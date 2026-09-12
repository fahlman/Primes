"""Build the committed Dockerfile and run existing Swift checks on native Linux.

This orchestrates a compatibility check, not a performance comparison. It never
implements sieve logic or changes the checked-out solution/Dockerfile.
"""

import argparse
from datetime import datetime, timezone
import hashlib
import json
import math
import os
from pathlib import Path
import platform
import re
import subprocess


SOURCE_FILES = [
    "Dockerfile", "PrimeSieve.swift", "Benchmark.swift", "BenchmarkObserver.swift",
    "Verify.swift", "ExtraVerify.swift", "tools/phase-split/PhaseSieve.swift",
    "tools/phase-split/PhaseVerify.swift",
]
WORKFLOW_FILES = [
    ".github/workflows/swift-linux-docker-validation.yml",
    "experiments/swift/tools/linux-docker/validate.py",
]


def utc():
    return datetime.now(timezone.utc).isoformat()


def hashes(root, names):
    return {name: hashlib.sha256((root / name).read_bytes()).hexdigest()
            for name in names}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--solution-root", type=Path, required=True)
    parser.add_argument("--solution-revision", required=True)
    parser.add_argument("--workflow-root", type=Path, required=True)
    parser.add_argument("--platform", choices=["linux/amd64", "linux/arm64"], required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--build-output", type=Path, required=True)
    args = parser.parse_args()
    if not re.fullmatch(r"[0-9a-f]{40}", args.solution_revision):
        parser.error("The solution revision must be a complete lowercase commit SHA.")

    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    logs = output / "logs"
    logs.mkdir()
    solution = args.solution_root.resolve()
    package = solution / "experiments/swift"
    workflow = args.workflow_root.resolve()
    builds = args.build_output.resolve()
    lock = Path("/tmp/primes-timing.lock")
    lock_inode = None
    record = {
        "status": "running", "started_at_utc": utc(),
        "purpose": "Linux/Docker correctness and runtime compatibility only; no speed claim.",
        "requested_solution_revision": args.solution_revision,
        "requested_platform": args.platform,
        "host_system": platform.system(), "host_machine": platform.machine(),
        "github": {key: os.environ.get(key) for key in [
            "GITHUB_REPOSITORY", "GITHUB_SHA", "GITHUB_REF", "GITHUB_RUN_ID",
            "GITHUB_RUN_ATTEMPT", "GITHUB_SERVER_URL", "RUNNER_OS", "RUNNER_ARCH",
            "ImageOS", "ImageVersion",
        ]},
        "commands": [],
    }
    if all(os.environ.get(key) for key in ["GITHUB_SERVER_URL", "GITHUB_REPOSITORY", "GITHUB_RUN_ID"]):
        record["run_url"] = (os.environ["GITHUB_SERVER_URL"] + "/" + os.environ["GITHUB_REPOSITORY"]
                             + "/actions/runs/" + os.environ["GITHUB_RUN_ID"])

    def save():
        (output / "validation.json").write_text(json.dumps(record, indent=2) + "\n")

    def run(name, command, timeout=1200):
        number = len(record["commands"]) + 1
        stdout = logs / f"{number:02d}-{name}.stdout.log"
        stderr = logs / f"{number:02d}-{name}.stderr.log"
        entry = {
            "name": name, "command": [str(part) for part in command],
            "started_at_utc": utc(), "timeout_seconds": timeout,
            "exit_code": None,
            "stdout_log": str(stdout.relative_to(output)),
            "stderr_log": str(stderr.relative_to(output)),
        }
        record["commands"].append(entry)
        save()
        print(f"RUN {name}: {json.dumps(entry['command'])}", flush=True)
        try:
            with stdout.open("w") as out, stderr.open("w") as err:
                result = subprocess.run(entry["command"], stdout=out, stderr=err,
                                        text=True, timeout=timeout, check=False)
            entry["exit_code"] = result.returncode
        except Exception as error:
            entry["error"] = f"{type(error).__name__}: {error}"
            raise
        finally:
            entry["finished_at_utc"] = utc()
            save()
        if result.returncode != 0:
            raise RuntimeError(f"{name} exited {result.returncode}; see {stderr.name}")
        return stdout.read_text(), stderr.read_text()

    def inspect_image(name, image):
        text, _ = run(name, ["docker", "image", "inspect", image], timeout=60)
        info = json.loads(text)[0]
        expected_arch = args.platform.split("/")[1]
        if info["Os"] != "linux" or info["Architecture"] != expected_arch:
            raise RuntimeError(f"Unexpected image platform for {image}")
        return {key: info.get(key) for key in [
            "Id", "RepoTags", "RepoDigests", "Os", "Architecture", "Created",
        ]}

    try:
        save()
        expected_machine = {"linux/amd64": "x86_64", "linux/arm64": "aarch64"}[args.platform]
        if platform.system() != "Linux" or platform.machine() != expected_machine:
            raise RuntimeError("This workflow requires the matching native Linux runner.")
        # This lock protects this Linux runner only. The branch must still be
        # pushed after local M4 timing finishes; no shared cross-host lock exists.
        descriptor = os.open(lock, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
        lock_inode = os.fstat(descriptor).st_ino
        with os.fdopen(descriptor, "w") as handle:
            handle.write(f"Swift Linux/Docker compatibility: {args.solution_revision} {args.platform}\n")
        record["runner_local_lock"] = {"path": str(lock), "acquired_exclusively": True}
        builds.mkdir(parents=True, exist_ok=False)
        head, _ = run("solution-head", ["git", "-C", solution, "rev-parse", "HEAD"], timeout=60)
        if head.strip() != args.solution_revision:
            raise RuntimeError("Solution checkout does not match the pinned revision.")
        record["solution_revision"] = head.strip()
        status, _ = run("solution-clean", ["git", "-C", solution, "status", "--porcelain"], timeout=60)
        if status.strip():
            raise RuntimeError("Solution checkout contains uncommitted files.")
        head, _ = run("workflow-head", ["git", "-C", workflow, "rev-parse", "HEAD"], timeout=60)
        record["workflow_revision"] = head.strip()
        if os.environ.get("GITHUB_SHA") and head.strip() != os.environ["GITHUB_SHA"]:
            raise RuntimeError("Workflow checkout does not match the event revision.")
        record["source_sha256"] = hashes(package, SOURCE_FILES)
        record["workflow_sha256"] = hashes(workflow, WORKFLOW_FILES)
        run("host-kernel", ["uname", "-a"], timeout=60)
        run("host-cpu", ["lscpu"], timeout=60)
        version, _ = run("docker-version", ["docker", "version", "--format", "{{json .}}"], timeout=60)
        record["docker_version"] = json.loads(version)
        backend, _ = run("docker-platform", ["docker", "info", "--format", "{{.OSType}}/{{.Architecture}}"], timeout=60)
        if backend.strip() not in {args.platform, "linux/" + expected_machine}:
            raise RuntimeError("Docker daemon is not the requested native Linux architecture.")

        # Keep the Dockerfile untouched. Pull its versioned bases once, retain their
        # immutable digests, then use local images without requesting a fresh pull.
        from_lines = re.findall(r"^FROM\s+(\S+)(?:\s+AS\s+(\S+))?\s*$",
                                (package / "Dockerfile").read_text(), re.MULTILINE | re.IGNORECASE)
        if from_lines != [("swift:6.3.3", "build"), ("swift:6.3.3-slim", "")]:
            raise RuntimeError("Review this validator for the changed Dockerfile stages.")
        record["base_images"] = {}
        for index, (image, _) in enumerate(from_lines):
            run(f"pull-base-{index}", ["docker", "pull", "--platform", args.platform, image])
            info = inspect_image(f"inspect-base-{index}", image)
            if not info["RepoDigests"]:
                raise RuntimeError(f"No immutable digest recorded for {image}")
            record["base_images"][image] = info

        suffix = args.solution_revision[:12] + "-" + args.platform.split("/")[1]
        builder = "swift-validation-build:" + suffix
        runtime = "swift-validation-runtime:" + suffix
        common_build = ["docker", "build", "--progress=plain", "--pull=false",
                        "--platform", args.platform, "--file", package / "Dockerfile"]
        run("build-compiler-stage", common_build + ["--target", "build", "--tag", builder,
            "--iidfile", output / "build-image.id", package])
        run("build-runtime-image", common_build + ["--tag", runtime,
            "--iidfile", output / "runtime-image.id", package])
        record["build_image"] = inspect_image("inspect-build-image", builder)
        record["runtime_image"] = inspect_image("inspect-runtime-image", runtime)
        container = ["docker", "run", "--rm", "--platform", args.platform, "--network", "none"]
        version, _ = run("container-swift-version", container + ["--entrypoint", "swiftc", builder, "--version"], timeout=60)
        record["swift_version"] = version.strip()
        if "Swift version 6.3.3" not in version:
            raise RuntimeError("Unexpected Swift compiler version in build stage.")
        stdout, stderr = run("runtime-smoke", container + [runtime], timeout=120)
        fields = stdout.strip().split(";")
        if len(stdout.strip().splitlines()) != 1 or len(fields) != 5:
            raise RuntimeError("Runtime image did not emit exactly one benchmark result.")
        label, passes, seconds, threads, tags = fields
        elapsed = float(seconds)
        if (not label or int(passes) <= 0 or not math.isfinite(elapsed) or elapsed < 5
                or threads != "1" or tags != "algorithm=base,faithful=yes,bits=1"
                or not re.fullmatch(r"Validated: 78498 primes; checksum: \d+", stderr.strip())):
            raise RuntimeError("Runtime image failed benchmark-output validation.")
        record["runtime_smoke"] = {
            "passes": int(passes), "seconds": elapsed, "threads": 1, "tags": tags,
            "prime_count": 78498, "performance_evidence": False,
        }

        # Both code and checks come from the same immutable checkout. The only
        # writable host mount holds newly compiled verification executables.
        checking = container + [
            "--mount", f"type=bind,source={package},target=/source,readonly",
            "--mount", f"type=bind,source={builds},target=/validation",
            "--workdir", "/validation",
        ]
        for mode, flags in [("asan", ["-O", "-sanitize=address"]),
                            ("wmo", ["-O", "-whole-module-optimization"])]:
            for name, sources in [
                ("verify", ["Verify.swift"]),
                ("extra-verify", ["ExtraVerify.swift"]),
                ("phase-verify", ["tools/phase-split/PhaseSieve.swift",
                                  "tools/phase-split/PhaseVerify.swift"]),
            ]:
                executable = f"/validation/{name}-{mode}"
                run(f"compile-{name}-{mode}", checking + ["--entrypoint", "swiftc", builder,
                    *flags, "/source/PrimeSieve.swift", *["/source/" + s for s in sources],
                    "-o", executable])
                run(f"run-{name}-{mode}", checking + ["--entrypoint", executable, builder])

        record["source_sha256_after"] = hashes(package, SOURCE_FILES)
        if record["source_sha256_after"] != record["source_sha256"]:
            raise RuntimeError("The checked-out source changed during validation.")
        record["status"] = "passed"
    except Exception as error:
        record["status"] = "failed"
        record["error"] = f"{type(error).__name__}: {error}"
        raise
    finally:
        if lock_inode is not None and lock.exists() and lock.stat().st_ino == lock_inode:
            lock.unlink()
            record.setdefault("runner_local_lock", {})["removed_in_finally"] = True
        record["finished_at_utc"] = utc()
        save()
        print(f"Evidence: {output / 'validation.json'}", flush=True)


if __name__ == "__main__":
    main()
