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
import signal
import subprocess
import uuid


SOURCE_FILES = [
    "Dockerfile", "PrimeSieve.swift", "Benchmark.swift", "BenchmarkObserver.swift",
    "Verify.swift", "ExtraVerify.swift", "tools/phase-split/PhaseSieve.swift",
    "tools/phase-split/PhaseVerify.swift",
]
WORKFLOW_FILES = [
    ".github/workflows/swift-linux-docker-validation.yml",
    "experiments/swift/tools/linux-docker/validate.py",
    "experiments/swift/tools/linux-docker/test_lifecycle.py",
]
CHECK_NAMES = [
    "verify-asan", "extra-verify-asan", "phase-verify-asan",
    "verify-wmo", "extra-verify-wmo", "phase-verify-wmo",
]


def utc():
    return datetime.now(timezone.utc).isoformat()


def hashes(root, names):
    return {name: hashlib.sha256((root / name).read_bytes()).hexdigest()
            for name in names}


class ValidationInterrupted(BaseException):
    def __init__(self, signum):
        super().__init__(f"Received signal {signum}")


class CommandRunner:
    """Keep command logs and stop the client process group before Docker cleanup."""
    def __init__(self, output, record, save):
        self.output, self.record, self.save = output, record, save

    def __call__(self, name, command, timeout=1200):
        number = len(self.record["commands"]) + 1
        stdout = self.output / "logs" / f"{number:02d}-{name}.stdout.log"
        stderr = self.output / "logs" / f"{number:02d}-{name}.stderr.log"
        entry = {
            "name": name, "command": [str(part) for part in command],
            "started_at_utc": utc(), "timeout_seconds": timeout, "exit_code": None,
            "stdout_log": str(stdout.relative_to(self.output)),
            "stderr_log": str(stderr.relative_to(self.output)),
        }
        self.record["commands"].append(entry)
        self.save()
        print(f"RUN {name}: {json.dumps(entry['command'])}", flush=True)
        process = None
        try:
            with stdout.open("w") as out, stderr.open("w") as err:
                process = subprocess.Popen(entry["command"], stdout=out, stderr=err,
                                           text=True, start_new_session=True)
                entry["owned_process_group"] = process.pid
                entry["exit_code"] = process.wait(timeout=timeout)
        except BaseException as error:
            entry["error"] = f"{type(error).__name__}: {error}"
            if process is not None:
                already_cleaning = self.record.get("cleaning_up", False)
                self.record["cleaning_up"] = True
                try:
                    # Always signal the group, including children left after its
                    # leader exits. Reap the client before inspecting containers.
                    try:
                        os.killpg(process.pid, signal.SIGTERM)
                    except ProcessLookupError:
                        pass
                    try:
                        process.wait(timeout=2)
                    except subprocess.TimeoutExpired:
                        pass
                    try:
                        os.killpg(process.pid, signal.SIGKILL)
                    except ProcessLookupError:
                        pass
                    entry["exit_code"] = process.wait(timeout=2)
                    entry["client_reaped_after_error"] = True
                except BaseException as cleanup_error:
                    entry["client_cleanup_error"] = f"{type(cleanup_error).__name__}: {cleanup_error}"
                finally:
                    self.record["cleaning_up"] = already_cleaning
            raise
        finally:
            entry["finished_at_utc"] = utc()
            self.save()
        if entry["exit_code"] != 0:
            raise RuntimeError(f"{name} exited {entry['exit_code']}; see {stderr.name}")
        return stdout.read_text(), stderr.read_text()


class OwnedContainers:
    """Create first; start only a verified container owned by this invocation."""
    LABEL = "org.fahlman.primes.validation-owner"

    def __init__(self, run, record, save):
        self.run, self.record, self.save = run, record, save
        self.owner = uuid.uuid4().hex
        record["container_owner"] = self.owner
        record["containers"] = []

    def _inspect(self, entry, container_id):
        text, _ = self.run("inspect-owned-" + entry["name"],
                           ["docker", "container", "inspect", container_id], timeout=5)
        info = json.loads(text)[0]
        if (info["Id"] != container_id or info["Name"] != "/" + entry["name"] or
                info.get("Config", {}).get("Labels", {}).get(self.LABEL) != self.owner or
                (entry.get("id") and entry["id"] != container_id)):
            raise RuntimeError("Container identity/ownership mismatch; refusing removal or start")
        entry["id"] = container_id
        entry["creation_confirmed"] = True
        entry["last_inspected_state"] = info.get("State")
        self.save()
        return info

    def _matching_ids(self, entry):
        # Once creation returned a verified ID, absence must be checked by that
        # ID: a renamed container can still be running under another name.
        selector = "id=" + entry["id"] if entry.get("id") else "name=^/" + entry["name"] + "$"
        text, _ = self.run("find-owned-" + entry["name"],
                           ["docker", "container", "ls", "--all", "--quiet", "--no-trunc",
                            "--filter", selector], timeout=5)
        ids = text.split()
        if (len(ids) > 1 or any(not re.fullmatch(r"[0-9a-f]{64}", item) for item in ids) or
                (entry.get("id") and any(item != entry["id"] for item in ids))):
            raise RuntimeError("Unexpected container lookup result")
        return ids

    def cleanup(self, entry):
        if entry.get("removed_confirmed"):
            return
        self.record["cleaning_up"] = True
        try:
            ids = self._matching_ids(entry)
            if ids:
                self._inspect(entry, ids[0])
                self.run("remove-owned-" + entry["name"],
                         ["docker", "container", "rm", "--force", ids[0]], timeout=5)
                if self._matching_ids(entry):
                    raise RuntimeError("Owned container still exists after removal")
            elif not entry.get("creation_confirmed"):
                # A timed-out create request may still complete at the daemon.
                # It cannot start work, but absence is not a confirmed outcome.
                raise RuntimeError("Container creation outcome is unconfirmed; retain timing lock")
            entry["removed_confirmed"] = True
            entry["removed_at_utc"] = utc()
        except BaseException as error:
            entry.setdefault("cleanup_errors", []).append(f"{type(error).__name__}: {error}")
            raise
        finally:
            self.record["cleaning_up"] = False
            self.save()

    def __call__(self, name, options, timeout=1200):
        entry = {"operation": name, "name": f"swift-validation-{self.owner}-{len(self.record['containers'])}",
                 "creation_confirmed": False, "removed_confirmed": False}
        self.record["containers"].append(entry)
        self.save()
        primary_error = None
        try:
            text, _ = self.run("create-" + name,
                               ["docker", "container", "create", "--name", entry["name"],
                                "--label", self.LABEL + "=" + self.owner, *options], timeout=60)
            container_id = text.strip()
            if not re.fullmatch(r"[0-9a-f]{64}", container_id):
                raise RuntimeError("Docker create did not return a full container ID")
            self._inspect(entry, container_id)
            result = self.run(name, ["docker", "container", "start", "--attach", container_id], timeout)
            state = self._inspect(entry, container_id)["State"]
            # The attached client's exit code alone does not establish that the
            # container command completed successfully. Inspect its own state.
            if state["Running"] or state["Status"] != "exited" or state["ExitCode"] != 0:
                raise RuntimeError(f"{name} container did not exit successfully: {state}")
        except BaseException as error:
            primary_error = error
            entry["error"] = f"{type(error).__name__}: {error}"
            raise
        finally:
            try:
                self.cleanup(entry)
            except BaseException:
                if primary_error is None:
                    raise
        if self.record.get("interrupted_signals"):
            raise ValidationInterrupted(self.record["interrupted_signals"][-1])
        return result

    def cleanup_all(self):
        for entry in self.record["containers"]:
            try:
                self.cleanup(entry)
            except BaseException:
                pass  # Each failure is recorded; no uncertain lock release below.
        return (all(entry.get("removed_confirmed") for entry in self.record["containers"]) and
                not any("client_cleanup_error" in entry for entry in self.record["commands"]))


def install_signal_handlers(record):
    def interrupt(signum, _frame):
        record.setdefault("interrupted_signals", []).append(signum)
        if not record.get("cleaning_up"):
            raise ValidationInterrupted(signum)
        # Do not abandon cleanup on a second SIGINT/SIGTERM. SIGKILL cannot be
        # handled; in that case the already-created timing lock stays on disk.
    old = {sig: signal.signal(sig, interrupt) for sig in (signal.SIGINT, signal.SIGTERM)}
    return old


def finish_cleanup(containers, record, lock, lock_inode):
    confirmed = containers.cleanup_all()
    record["owned_container_cleanup_confirmed"] = confirmed
    if not confirmed:
        record["status"] = "failed"
        record["cleanup_error"] = "Owned Docker cleanup is unconfirmed; timing lock retained"
    elif record.get("interrupted_signals"):
        record["status"] = "failed"
        record.setdefault("error", "Validation interrupted by signal")
    if lock_inode is not None and lock.exists() and lock.stat().st_ino == lock_inode:
        if confirmed:
            lock.unlink()
            record.setdefault("runner_local_lock", {})["removed_in_finally"] = True
        else:
            record.setdefault("runner_local_lock", {})["retained_due_to_unconfirmed_cleanup"] = True
    return confirmed


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--solution-root", type=Path, required=True)
    parser.add_argument("--solution-revision", required=True)
    parser.add_argument("--workflow-root", type=Path, required=True)
    parser.add_argument("--platform", choices=["linux/amd64", "linux/arm64"], required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--build-output", type=Path, required=True)
    parser.add_argument("--checks", nargs="+", choices=CHECK_NAMES,
                        help="Run only these checks; omitted means the complete six-check suite.")
    args = parser.parse_args()
    if not re.fullmatch(r"[0-9a-f]{40}", args.solution_revision):
        parser.error("The solution revision must be a complete lowercase commit SHA.")
    selection = args.checks if args.checks is not None else CHECK_NAMES
    if len(selection) != len(set(selection)):
        parser.error("Each requested check must appear only once.")
    requested_checks = [name for name in CHECK_NAMES if name in selection]
    check_scope = "full_suite" if requested_checks == CHECK_NAMES else "targeted"

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
        "check_scope": check_scope,
        "requested_checks": requested_checks,
        "completed_checks": [],
        "unrequested_checks": [name for name in CHECK_NAMES if name not in requested_checks],
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

    run = CommandRunner(output, record, save)
    containers = OwnedContainers(run, record, save)
    previous_signals = install_signal_handlers(record)
    failed = False

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
        container = ["--platform", args.platform, "--network", "none"]
        version, _ = containers("container-swift-version", container + ["--entrypoint", "swiftc", builder, "--version"], timeout=60)
        record["swift_version"] = version.strip()
        if "Swift version 6.3.3" not in version:
            raise RuntimeError("Unexpected Swift compiler version in build stage.")
        stdout, stderr = containers("runtime-smoke", container + [runtime], timeout=120)
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
                check_name = f"{name}-{mode}"
                if check_name not in requested_checks:
                    continue
                executable = f"/validation/{name}-{mode}"
                containers(f"compile-{name}-{mode}", checking + ["--entrypoint", "swiftc", builder,
                    *flags, "/source/PrimeSieve.swift", *["/source/" + s for s in sources],
                    "-o", executable])
                containers(f"run-{name}-{mode}", checking + ["--entrypoint", executable, builder])
                record["completed_checks"].append(check_name)
                save()

        if record["completed_checks"] != requested_checks:
            raise RuntimeError("The completed checks do not match the requested checks.")
        record["source_sha256_after"] = hashes(package, SOURCE_FILES)
        if record["source_sha256_after"] != record["source_sha256"]:
            raise RuntimeError("The checked-out source changed during validation.")
        record["status"] = "passed" if check_scope == "full_suite" else "passed_targeted"
    except BaseException as error:
        failed = True
        record["status"] = "failed"
        record["error"] = f"{type(error).__name__}: {error}"
        raise
    finally:
        try:
            confirmed = finish_cleanup(containers, record, lock, lock_inode)
            record["finished_at_utc"] = utc()
            save()
            print(f"Evidence: {output / 'validation.json'}", flush=True)
            if not failed and (not confirmed or record.get("interrupted_signals")):
                raise RuntimeError(record.get("cleanup_error", "Validation interrupted by signal"))
        finally:
            for sig, handler in previous_signals.items():
                signal.signal(sig, handler)


if __name__ == "__main__":
    main()
