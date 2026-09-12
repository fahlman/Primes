#!/usr/bin/env python3
"""Collect one completed cutoff111 Linux job; never build or execute Swift.

The output is append-only: an existing architecture directory is an error.
Original API responses, job logs, artifact ZIP and extracted bytes are retained;
audit.json is derived evidence and never changes the original validation record.
"""

import argparse
from datetime import datetime, timezone
import hashlib
import io
import json
import math
from pathlib import Path, PurePosixPath
import re
import stat
import subprocess
import sys
import zipfile


REPOSITORY = "fahlman/Primes"
RUN = 34702902662
SOURCE = "099e35afa8a2f01d79ef11f805d760e81d1d983a"
WORKFLOW = "cfa0f2fa3e11e8d3d5ad2f17084aaf49ff98d126"
ROOT = Path("/Users/ryan/Developer/Primes-linux-docker-validation")
EVIDENCE = ROOT / f"experiments/swift/linux-docker-validation/run-{RUN}"
JOBS = {"amd64": 103577690048, "arm64": 103577689911}
CHECKS = ["verify-asan", "extra-verify-asan", "phase-verify-asan",
          "verify-wmo", "extra-verify-wmo", "phase-verify-wmo"]
PREFIX_COMMANDS = [
    "solution-head", "solution-clean", "workflow-head", "host-kernel", "host-cpu",
    "docker-version", "docker-platform", "pull-base-0", "inspect-base-0",
    "pull-base-1", "inspect-base-1", "build-compiler-stage", "build-runtime-image",
    "inspect-build-image", "inspect-runtime-image", "container-swift-version",
    "runtime-smoke",
]
VERIFY_OUTPUT = (
    "Passed: complete prime arrays for every limit -2...2048, larger square boundaries, 1M, and 10M.\n"
)
EXTRA_OUTPUT = (
    "Passed: every limit in 2,049...30,000, 11382 deduplicated 128-bit alignment/group/tail limits, "
    "500 random limits in 2,049...2,000,000, and 1561 limits within 3 of every prime square up to 2,000,000.\n"
    "Passed: 3654 sparse double-group and cleanup boundary limits.\n"
)
PHASE_OUTPUT = (
    "Passed 53015 partial/full flag checks over 2305 limits; allocation zeroing; "
    "full raw-buffer equality; 78,498 primes at 1,000,000.\n"
)


def utc():
    return datetime.now(timezone.utc).isoformat()


def sha(data):
    return hashlib.sha256(data).hexdigest()


def write_new(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("xb") as handle:
        handle.write(data)


def write_json(path, value):
    write_new(path, (json.dumps(value, indent=2) + "\n").encode())


def api(endpoint):
    # Structured argv only. Responses are captured as bytes into files, never
    # emitted to a terminal; retain ANSI bytes present in the original job log.
    # gh follows the API's artifact/job-log redirects.
    return subprocess.run(
        ["gh", "api", "--allow-escape-sequences", "--method", "GET", endpoint], check=True,
        stdout=subprocess.PIPE, stderr=subprocess.PIPE, timeout=180,
    ).stdout


def timestamp(value):
    return datetime.fromisoformat(value.replace("Z", "+00:00"))


def elapsed(start, end):
    seconds = (timestamp(end) - timestamp(start)).total_seconds()
    if seconds < 0:
        raise ValueError("Negative recorded duration")
    return seconds


def expected_hashes(filename, revision, prefix):
    raw = (EVIDENCE / filename).read_bytes()
    expected = json.loads(raw)
    for name, digest in expected.items():
        content = subprocess.run(
            ["git", "-C", str(ROOT), "show", f"{revision}:{prefix}{name}"],
            check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, timeout=60,
        ).stdout
        if sha(content) != digest:
            raise ValueError(f"Expected hash disagrees with exact Git object: {name}")
    return expected, sha(raw)


def extract_checked(zip_bytes, destination):
    """Validate every ZIP member before extracting; never extract links or paths outside it."""
    members = []
    names = set()
    with zipfile.ZipFile(io.BytesIO(zip_bytes)) as archive:
        infos = archive.infolist()
        if len(infos) > 10000 or sum(info.file_size for info in infos) > 128 * 1024 * 1024:
            raise ValueError("Artifact exceeds the bounded extraction size")
        for info in infos:
            path = PurePosixPath(info.filename)
            mode = (info.external_attr >> 16) & 0xFFFF
            kind = stat.S_IFMT(mode)
            if (not info.filename or "\\" in info.filename or path.is_absolute()
                    or any(part in {".", "..", ""} for part in info.filename.rstrip("/").split("/"))
                    or info.filename in names or info.flag_bits & 1
                    or kind not in {0, stat.S_IFREG, stat.S_IFDIR}
                    or (kind == stat.S_IFDIR) != info.is_dir() and kind != 0):
                raise ValueError(f"Unsafe ZIP member: {info.filename!r}")
            names.add(info.filename)
        destination.mkdir()
        for info in infos:
            target = destination.joinpath(*PurePosixPath(info.filename).parts)
            if info.is_dir():
                target.mkdir(parents=True, exist_ok=True)
                continue
            content = archive.read(info)  # Also checks the member CRC.
            write_new(target, content)
            if target.read_bytes() != content:
                raise ValueError(f"Extracted bytes differ: {info.filename}")
            members.append({"path": info.filename, "bytes": len(content), "sha256": sha(content)})
    return members


def audit(architecture, job, artifact, directory, expected_source, expected_workflow):
    errors = []

    def require(condition, description):
        if not condition:
            errors.append(description)

    data = json.loads((directory / "validation.json").read_bytes())
    machine = {"amd64": "x86_64", "arm64": "aarch64"}[architecture]
    platform = f"linux/{architecture}"
    require(job.get("conclusion") == "success", "GitHub job did not succeed")
    require(data.get("status") == "passed", "Validator status is not passed")
    require(data.get("check_scope") == "full_suite", "Not full-suite coverage")
    require(data.get("requested_checks") == CHECKS, "Requested checks are not exactly all six")
    require(data.get("completed_checks") == CHECKS, "Completed checks are not exactly all six")
    require(data.get("unrequested_checks") == [], "Some checks were unrequested")
    require(data.get("requested_solution_revision") == SOURCE == data.get("solution_revision"),
            "Solution revision differs from the pin")
    require(data.get("workflow_revision") == WORKFLOW, "Workflow revision differs from the pin")
    require(data.get("source_sha256") == expected_source == data.get("source_sha256_after"),
            "Source hashes before/after disagree with exact source Git objects")
    require(data.get("workflow_sha256") == expected_workflow, "Workflow hashes disagree with exact Git objects")
    require(data.get("host_system") == "Linux" and data.get("host_machine") == machine
            and data.get("requested_platform") == platform, "Host is not the requested native architecture")
    gh = data.get("github", {})
    for key, expected in {
        "GITHUB_REPOSITORY": REPOSITORY, "GITHUB_SHA": WORKFLOW,
        "GITHUB_RUN_ID": str(RUN), "GITHUB_RUN_ATTEMPT": "1", "RUNNER_OS": "Linux",
        "RUNNER_ARCH": {"amd64": "X64", "arm64": "ARM64"}[architecture],
        "GITHUB_REF": "refs/heads/swift/linux-docker-validation",
    }.items():
        require(gh.get(key) == expected, f"Unexpected {key}")
    require(data.get("run_url") == f"https://github.com/{REPOSITORY}/actions/runs/{RUN}", "Wrong run URL")
    lock = data.get("runner_local_lock", {})
    require(lock.get("acquired_exclusively") is True and lock.get("removed_in_finally") is True
            and lock.get("path") == "/tmp/primes-timing.lock", "Runner-local lock lifecycle incomplete")

    commands = data.get("commands", [])
    expected_commands = PREFIX_COMMANDS + [item for name in CHECKS for item in ("compile-" + name, "run-" + name)]
    require([entry.get("name") for entry in commands] == expected_commands, "Unexpected command count/order (expected 29)")
    require(all(type(entry.get("exit_code")) is int and entry["exit_code"] == 0 for entry in commands),
            "Not every recorded command exited zero")
    by_name = {entry["name"]: entry for entry in commands}
    durations = []
    previous_end = timestamp(data["started_at_utc"])
    for entry in commands:
        start, end = timestamp(entry["started_at_utc"]), timestamp(entry["finished_at_utc"])
        require(previous_end <= start <= end <= timestamp(data["finished_at_utc"]),
                f"Nonserial or out-of-record timestamps: {entry['name']}")
        previous_end = end
        durations.append({"name": entry["name"], "seconds": elapsed(entry["started_at_utc"], entry["finished_at_utc"]),
                          "exit_code": entry.get("exit_code")})

    def log(name, stream="stdout"):
        relative = PurePosixPath(by_name[name][stream + "_log"])
        if relative.is_absolute() or ".." in relative.parts or relative.parts[:1] != ("logs",):
            raise ValueError("Unsafe log reference")
        return directory.joinpath(*relative.parts).read_bytes()

    require(log("solution-head").decode().strip() == SOURCE, "Source-head stdout mismatch")
    require(log("workflow-head").decode().strip() == WORKFLOW, "Workflow-head stdout mismatch")
    require(log("solution-clean") == b"", "Solution checkout was not clean")
    require(log("docker-platform").decode().strip() in {platform, "linux/" + machine}, "Docker daemon platform mismatch")
    docker = json.loads(log("docker-version"))
    require(docker == data.get("docker_version"), "Docker version record disagrees with stdout")
    require(docker.get("Server", {}).get("Os") == "linux"
            and docker.get("Server", {}).get("Arch") == architecture, "Docker server architecture mismatch")
    version = log("container-swift-version").decode().strip()
    require(version == data.get("swift_version") and "Swift version 6.3.3" in version
            and f"Target: {machine}-unknown-linux-gnu" in version, "Swift compiler/version/target mismatch")

    images = data.get("base_images", {})
    require(set(images) == {"swift:6.3.3", "swift:6.3.3-slim"}, "Unexpected Docker base images")
    image_records = [("inspect-base-0", images["swift:6.3.3"]),
                     ("inspect-base-1", images["swift:6.3.3-slim"]),
                     ("inspect-build-image", data["build_image"]),
                     ("inspect-runtime-image", data["runtime_image"])]
    for name, image in image_records:
        actual = json.loads(log(name))[0]
        require(all(image.get(key) == actual.get(key) for key in image), f"Image record/inspect mismatch: {name}")
        require(image.get("Os") == "linux" and image.get("Architecture") == architecture
                and re.fullmatch(r"sha256:[0-9a-f]{64}", image.get("Id", "")), f"Image identity/platform mismatch: {name}")
        if name.startswith("inspect-base"):
            require(bool(image.get("RepoDigests")) and all(re.fullmatch(r"swift@sha256:[0-9a-f]{64}", digest)
                    for digest in image["RepoDigests"]), f"Missing base-image digest: {name}")
    require((directory / "build-image.id").read_text().strip() == data["build_image"]["Id"], "Build image ID file mismatch")
    require((directory / "runtime-image.id").read_text().strip() == data["runtime_image"]["Id"], "Runtime image ID file mismatch")

    stdout, stderr = log("runtime-smoke").decode().strip(), log("runtime-smoke", "stderr").decode().strip()
    fields = stdout.split(";")
    if len(stdout.splitlines()) != 1 or len(fields) != 5:
        raise ValueError("Invalid runtime result format")
    label, passes, seconds, threads, tags = fields
    smoke = {"passes": int(passes), "seconds": float(seconds), "threads": int(threads), "tags": tags,
             "prime_count": 78498, "performance_evidence": False}
    require(bool(label) and int(passes) > 0 and math.isfinite(float(seconds)) and float(seconds) >= 5
            and threads == "1" and tags == "algorithm=base,faithful=yes,bits=1"
            and re.fullmatch(r"Validated: 78498 primes; checksum: \d+", stderr), "Runtime smoke failed validation")
    require(smoke == data.get("runtime_smoke"), "Runtime smoke record disagrees with stdout/stderr")
    for check in CHECKS:
        expected = EXTRA_OUTPUT if check.startswith("extra-") else PHASE_OUTPUT if check.startswith("phase-") else VERIFY_OUTPUT
        require(log("run-" + check).decode() == expected, f"Unexpected passing output: {check}")
        require(log("run-" + check, "stderr") == b"", f"Nonempty test stderr: {check}")
        command = by_name["compile-" + check]["command"]
        flags = ["-O", "-sanitize=address"] if check.endswith("asan") else ["-O", "-whole-module-optimization"]
        name = check.rsplit("-", 1)[0]
        sources = ["/source/PrimeSieve.swift"] + {
            "verify": ["/source/Verify.swift"], "extra-verify": ["/source/ExtraVerify.swift"],
            "phase-verify": ["/source/tools/phase-split/PhaseSieve.swift", "/source/tools/phase-split/PhaseVerify.swift"],
        }[name]
        suffix = SOURCE[:12] + "-" + architecture
        builder = "swift-validation-build:" + suffix
        solution_root = by_name["solution-head"]["command"][2]
        mounts = [command[index + 1] for index, part in enumerate(command) if part == "--mount"]
        require(len(mounts) == 2 and mounts[0] == f"type=bind,source={solution_root}/experiments/swift,target=/source,readonly"
                and re.fullmatch(r"type=bind,source=/[^,]+,target=/validation", mounts[1]), f"Unexpected verification mounts: {check}")
        prefix = ["docker", "run", "--rm", "--platform", platform, "--network", "none",
                  "--mount", mounts[0], "--mount", mounts[1], "--workdir", "/validation"]
        require(command == prefix + ["--entrypoint", "swiftc", builder] + flags + sources + ["-o", "/validation/" + check],
                f"Compile command differs from the registered validator: {check}")
        require(by_name["run-" + check]["command"] == prefix + ["--entrypoint", "/validation/" + check, builder],
                f"Execution command differs from the registered validator: {check}")

    return {
        "status": "passed" if not errors else "failed", "errors": errors,
        "scope": "One architecture's full six-check correctness and Docker compatibility evidence; no speed claim.",
        "architecture": architecture, "source_revision": SOURCE, "workflow_revision": WORKFLOW,
        "run_id": RUN, "job_id": job["id"], "job_url": job["html_url"], "artifact_id": artifact["id"],
        "job_conclusion": job["conclusion"], "job_seconds": elapsed(job["started_at"], job["completed_at"]),
        "validator_seconds": elapsed(data["started_at_utc"], data["finished_at_utc"]),
        "commands": durations, "verifier_compile_seconds": sum(item["seconds"] for item in durations if item["name"].startswith("compile-")),
        "verifier_run_seconds": sum(item["seconds"] for item in durations if item["name"].startswith("run-")),
        "completed_checks": data.get("completed_checks"), "source_sha256": data.get("source_sha256"),
        "workflow_sha256": data.get("workflow_sha256"), "swift_version": data.get("swift_version"),
        "base_images": images, "build_image": data.get("build_image"), "runtime_image": data.get("runtime_image"),
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("architecture", choices=sorted(JOBS))
    parser.add_argument("--attempt", help="Optional lowercase label for a separate, never-overwritten evidence directory.")
    args = parser.parse_args()
    if args.attempt is not None and not re.fullmatch(r"[a-z0-9][a-z0-9_-]{0,63}", args.attempt):
        parser.error("Attempt labels must contain 1–64 lowercase letters, digits, underscores or hyphens, starting with a letter or digit.")
    directory_name = args.architecture + ("-" + args.attempt if args.attempt else "")
    destination = EVIDENCE / directory_name
    if destination.exists():
        parser.error(f"Refusing to overwrite existing evidence: {destination}")
    expected_source, source_manifest_hash = expected_hashes("expected-source-hashes.json", SOURCE, "experiments/swift/")
    expected_workflow, workflow_manifest_hash = expected_hashes("expected-workflow-hashes.json", WORKFLOW, "")
    job_raw = api(f"repos/{REPOSITORY}/actions/jobs/{JOBS[args.architecture]}")
    job = json.loads(job_raw)
    if (job.get("run_id") != RUN or job.get("head_sha") != WORKFLOW or job.get("run_attempt") != 1
            or job.get("name") != f"Validate cutoff 111 on native {args.architecture}"):
        raise ValueError("Unexpected job identity")
    if job.get("status") != "completed" or not job.get("completed_at"):
        raise SystemExit("Job is not completed; no architecture evidence files were created.")
    # Only a completed job permits creation of architecture-specific output.
    destination.mkdir()
    collection = {"started_at_utc": utc(), "architecture": args.architecture, "attempt": args.attempt,
                  "source_revision": SOURCE,
                  "workflow_revision": WORKFLOW, "run_id": RUN, "job_id": job["id"],
                  "expected_source_manifest_sha256": source_manifest_hash,
                  "expected_workflow_manifest_sha256": workflow_manifest_hash,
                  "run_snapshot_scope": "Captured for this completed architecture; the overall run may still be running.",
                  "collector_sha256": sha(Path(__file__).read_bytes()), "status": "collecting"}
    audit_result = None
    try:
        github = destination / "github"
        write_new(github / "job.json", job_raw)
        run_raw = api(f"repos/{REPOSITORY}/actions/runs/{RUN}")
        write_new(github / "run-snapshot.json", run_raw)
        run = json.loads(run_raw)
        if run.get("head_sha") != WORKFLOW or run.get("run_attempt") != 1:
            raise ValueError("Run snapshot does not match the pinned workflow/attempt")
        job_log_endpoint = f"repos/{REPOSITORY}/actions/jobs/{job['id']}/logs"
        try:
            job_log = api(job_log_endpoint)
        except subprocess.CalledProcessError as error:
            # Only this supplemental endpoint's observed HTTP 404 is nonfatal.
            # It does not establish why the log is unavailable. The artifact's
            # original command logs remain mandatory for the full-suite audit.
            stderr = error.stderr or b""
            if not re.search(rb"\bHTTP 404\b", stderr):
                raise
            write_new(github / "job-log-404.stdout", error.stdout or b"")
            write_new(github / "job-log-404.stderr", stderr)
            collection["supplemental_job_log"] = {
                "status": "unavailable_http_404", "endpoint": job_log_endpoint,
                "command": error.cmd, "exit_code": error.returncode,
                "response_stdout": "github/job-log-404.stdout",
                "response_stderr": "github/job-log-404.stderr",
                "job_status_at_collection": job.get("status"),
                "overall_run_status_at_snapshot": run.get("status"),
                "limitation": "The job-log request returned HTTP 404; its cause is not established. Original artifact command logs are audited separately.",
            }
        else:
            write_new(github / "job.log", job_log)
            collection["supplemental_job_log"] = {"status": "available", "path": "github/job.log"}
        write_new(github / "check-run.json", api(f"repos/{REPOSITORY}/check-runs/{job['id']}"))
        for page in range(1, 101):
            raw = api(f"repos/{REPOSITORY}/check-runs/{job['id']}/annotations?per_page=100&page={page}")
            write_new(github / f"annotations-page-{page}.json", raw)
            if len(json.loads(raw)) < 100:
                break
        else:
            raise ValueError("Annotation pagination exceeded its bound")
        artifacts = []
        for page in range(1, 101):
            raw = api(f"repos/{REPOSITORY}/actions/runs/{RUN}/artifacts?per_page=100&page={page}")
            write_new(github / f"artifacts-page-{page}.json", raw)
            batch = json.loads(raw)["artifacts"]
            artifacts.extend(batch)
            if len(batch) < 100:
                break
        else:
            raise ValueError("Artifact pagination exceeded its bound")
        name = f"swift-linux-{args.architecture}-full-{SOURCE}"
        matches = [item for item in artifacts if item["name"] == name and not item["expired"]]
        if len(matches) != 1:
            raise ValueError(f"Expected one nonexpired artifact named {name}; got {len(matches)}")
        raw = api(f"repos/{REPOSITORY}/actions/artifacts/{matches[0]['id']}")
        write_new(github / "artifact.json", raw)
        artifact = json.loads(raw)
        if (artifact.get("name") != name or artifact.get("expired") is not False
                or artifact.get("workflow_run", {}).get("id") != RUN
                or artifact["workflow_run"].get("head_sha") != WORKFLOW
                or not re.fullmatch(r"sha256:[0-9a-f]{64}", artifact.get("digest", ""))):
            raise ValueError("Artifact provenance/digest is invalid")
        archive = api(f"repos/{REPOSITORY}/actions/artifacts/{artifact['id']}/zip")
        write_new(destination / "artifact.zip", archive)
        collection["artifact_zip_sha256"] = sha(archive)
        collection["artifact_zip_matches_github_digest"] = "sha256:" + sha(archive) == artifact["digest"]
        if not collection["artifact_zip_matches_github_digest"]:
            raise ValueError("Artifact ZIP SHA256 differs from GitHub digest")
        members = extract_checked(archive, destination / "artifact")
        write_json(destination / "extracted-file-manifest.json", members)
        audit_result = audit(args.architecture, job, artifact, destination / "artifact", expected_source, expected_workflow)
        collection["status"] = "collected_and_audited" if audit_result["status"] == "passed" else "collected_audit_failed"
    except Exception as error:
        collection["status"] = "failed_preserved_partial_evidence"
        collection["error"] = f"{type(error).__name__}: {error}"
        audit_result = audit_result or {"status": "incomplete", "errors": [collection["error"]]}
    finally:
        collection["finished_at_utc"] = utc()
        audit_result["supplemental_job_log"] = collection.get("supplemental_job_log", {"status": "not_collected"})
        write_json(destination / "audit.json", audit_result)
        write_json(destination / "collection.json", collection)
        manifest = [{"path": str(path.relative_to(destination)), "bytes": path.stat().st_size,
                     "sha256": sha(path.read_bytes())} for path in sorted(destination.rglob("*")) if path.is_file()]
        write_json(destination / "evidence-manifest.json", manifest)
    print(json.dumps({"directory": str(destination), "collection_status": collection["status"],
                      "audit_status": audit_result["status"], "errors": audit_result.get("errors", [])}, indent=2))
    return 0 if collection["status"] == "collected_and_audited" else 1


if __name__ == "__main__":
    sys.exit(main())
