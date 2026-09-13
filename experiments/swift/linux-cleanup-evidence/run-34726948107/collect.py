#!/usr/bin/env python3
"""Collect/audit the fixed PR15 workflow, preserving raw evidence in a new directory.

No builds, tests, CI mutations or publication. --architecture permits collecting
one completed native job while the other job is still running. Never overwrite
an existing output directory; use a fresh directory for a later snapshot.
"""
import argparse
from datetime import datetime, timezone
import hashlib
import json
import math
from pathlib import Path, PurePosixPath
import re
import stat
import subprocess
import sys
import zipfile

REPO = "fahlman/Primes"
GIT = Path("/Users/ryan/Developer/Primes")
SOURCE = "099e35afa8a2f01d79ef11f805d760e81d1d983a"
WORKFLOW = "028125534a516a9adca0cd8f7419bd74d2b51975"
LABEL = "org.fahlman.primes.validation-owner"
CHECKS = ["verify-asan", "extra-verify-asan", "phase-verify-asan",
          "verify-wmo", "extra-verify-wmo", "phase-verify-wmo"]
SOURCE_FILES = ["Dockerfile", "PrimeSieve.swift", "Benchmark.swift", "BenchmarkObserver.swift",
                "Verify.swift", "ExtraVerify.swift", "tools/phase-split/PhaseSieve.swift",
                "tools/phase-split/PhaseVerify.swift"]
WORKFLOW_FILES = [".github/workflows/swift-linux-docker-validation.yml",
                  "experiments/swift/tools/linux-docker/validate.py",
                  "experiments/swift/tools/linux-docker/test_lifecycle.py"]
PREFIX = ["solution-head", "solution-clean", "workflow-head", "host-kernel", "host-cpu",
          "docker-version", "docker-platform", "pull-base-0", "inspect-base-0", "pull-base-1",
          "inspect-base-1", "build-compiler-stage", "build-runtime-image", "inspect-build-image",
          "inspect-runtime-image"]
OPERATIONS = ["container-swift-version", "runtime-smoke"] + [
    item for check in CHECKS for item in ("compile-" + check, "run-" + check)]
PASS_OUTPUTS = {
    "verify": "Passed: complete prime arrays for every limit -2...2048, larger square boundaries, 1M, and 10M.\n",
    "extra-verify": "Passed: every limit in 2,049...30,000, 11382 deduplicated 128-bit alignment/group/tail limits, 500 random limits in 2,049...2,000,000, and 1561 limits within 3 of every prime square up to 2,000,000.\nPassed: 3654 sparse double-group and cleanup boundary limits.\n",
    "phase-verify": "Passed 53015 partial/full flag checks over 2305 limits; allocation zeroing; full raw-buffer equality; 78,498 primes at 1,000,000.\n",
}


def utc():
    return datetime.now(timezone.utc).isoformat()


def sha(data):
    return hashlib.sha256(data).hexdigest()


def write(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("xb") as stream:
        stream.write(data)


def write_json(path, data):
    write(path, (json.dumps(data, indent=2) + "\n").encode())


def stamp(value):
    return datetime.fromisoformat(value.replace("Z", "+00:00"))


def seconds(start, end):
    result = (stamp(end) - stamp(start)).total_seconds()
    if result < 0:
        raise ValueError("Negative recorded duration")
    return result


def expected(revision, names, prefix=""):
    result = {}
    for name in names:
        data = subprocess.run(["git", "-C", str(GIT), "show", revision + ":" + prefix + name],
                              check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, timeout=60).stdout
        result[name] = sha(data)
    return result


def extract(archive_path, target):
    """Validate all names/types/sizes first; preserve ZIP and member bytes exactly."""
    with zipfile.ZipFile(archive_path) as archive:
        infos = archive.infolist()
        if len(infos) > 10000 or sum(item.file_size for item in infos) > 256 * 1024 * 1024:
            raise ValueError("ZIP exceeds bounded extraction limits")
        seen = set()
        for item in infos:
            path = PurePosixPath(item.filename)
            kind = stat.S_IFMT(item.external_attr >> 16)
            if (not item.filename or "\\" in item.filename or path.is_absolute() or
                    any(part in {"", ".", ".."} for part in item.filename.rstrip("/").split("/")) or
                    item.filename in seen or item.flag_bits & 1 or
                    kind not in {0, stat.S_IFDIR, stat.S_IFREG} or
                    (kind != 0 and (kind == stat.S_IFDIR) != item.is_dir()) or
                    path.parts[0] not in {"swift-linux-docker-evidence", "swift-linux-docker-lifecycle"}):
                raise ValueError(f"Unsafe or unexpected ZIP member: {item.filename!r}")
            seen.add(item.filename)
        target.mkdir()
        manifest = []
        for item in infos:
            destination = target.joinpath(*PurePosixPath(item.filename).parts)
            if item.is_dir():
                destination.mkdir(parents=True, exist_ok=True)
            else:
                data = archive.read(item)  # Checks CRC as well as decompression.
                write(destination, data)
                manifest.append({"path": item.filename, "bytes": len(data), "sha256": sha(data)})
        return manifest


class Audit:
    def __init__(self):
        self.errors = []

    def require(self, condition, message):
        if not condition:
            self.errors.append(message)

    def logs(self, root, command, stream="stdout"):
        path = PurePosixPath(command[stream + "_log"])
        if path.is_absolute() or ".." in path.parts or path.parts[:1] != ("logs",):
            raise ValueError("Unsafe command log reference")
        return root.joinpath(*path.parts).read_text()

    def commands(self, root, record, allow_expected_errors=False):
        previous = stamp(record["started_at_utc"])
        durations = []
        for command in record["commands"]:
            start, end = stamp(command["started_at_utc"]), stamp(command["finished_at_utc"])
            self.require(previous <= start <= end <= stamp(record["finished_at_utc"]),
                         "Nonserial/out-of-record command timestamps: " + command["name"])
            previous = end
            if not allow_expected_errors or command["name"] not in {"probe-nonzero", "probe-timeout", "probe-sigterm"}:
                self.require(type(command.get("exit_code")) is int and command["exit_code"] == 0 and
                             "error" not in command, "Command did not pass: " + command["name"])
            self.require("client_cleanup_error" not in command, "Unconfirmed client cleanup: " + command["name"])
            self.logs(root, command)
            self.logs(root, command, "stderr")
            durations.append({"name": command["name"], "exit_code": command.get("exit_code"),
                              "seconds": seconds(command["started_at_utc"], command["finished_at_utc"])})
        return durations

    def containers(self, root, record, operations, prefix_count, probe=False):
        self.require(record.get("owned_container_cleanup_confirmed") is True, "Container cleanup is unconfirmed")
        self.require(record.get("runner_local_lock", {}).get("removed_in_finally") is True,
                     "Owned timing lock removal is unconfirmed")
        self.require(not record.get("runner_local_lock", {}).get("retained_due_to_unconfirmed_cleanup") and
                     not record.get("cleanup_error") and not record.get("interrupted_signals") and
                     record.get("cleaning_up") is False, "Cleanup/cancellation state is unresolved")
        owner = record["container_owner"]
        self.require(bool(re.fullmatch(r"[0-9a-f]{32}", owner)), "Malformed ownership token")
        entries = record["containers"]
        self.require([entry.get("operation") for entry in entries] == operations, "Unexpected owned-container operations/count")
        self.require(len({entry.get("id") for entry in entries}) == len(entries), "Duplicate container IDs")
        cursor = prefix_count
        found = {}
        for index, entry in enumerate(entries):
            operation, name, cid = entry["operation"], entry["name"], entry["id"]
            self.require(name == f"swift-validation-{owner}-{index}" and bool(re.fullmatch(r"[0-9a-f]{64}", cid)),
                         "Container identity/name is unexpected")
            self.require(entry.get("creation_confirmed") is True and entry.get("removed_confirmed") is True and
                         not entry.get("cleanup_errors"), "Container removal/ownership is unconfirmed: " + operation)
            commands = record["commands"]
            start = cursor
            self.require(commands[cursor]["name"] == "create-" + operation, "Missing container creation")
            create = commands[cursor]
            create_prefix = ["docker", "container", "create", "--name", name, "--label", LABEL + "=" + owner]
            self.require(create["command"][:len(create_prefix)] == create_prefix and
                         self.logs(root, create).strip() == cid, "Creation ownership/ID mismatch")
            cursor += 1
            inspected = []
            def inspect_at(position):
                command = commands[position]
                self.require(command["name"] == "inspect-owned-" + name and
                             command["command"] == ["docker", "container", "inspect", cid], "Wrong inspected container")
                info = json.loads(self.logs(root, command))[0]
                self.require(info["Id"] == cid and info["Name"] == "/" + name and
                             info["Config"]["Labels"].get(LABEL) == owner, "Inspected ownership mismatch")
                inspected.append(info)
            inspect_at(cursor)
            cursor += 1
            attached = commands[cursor]
            self.require(attached["name"] == operation and
                         attached["command"] == ["docker", "container", "start", "--attach", cid], "Wrong attached container")
            cursor += 1
            if commands[cursor]["name"] == "inspect-owned-" + name:
                inspect_at(cursor)
                cursor += 1
            elif not probe or operation == "probe-normal":
                self.require(False, "Successful command lacks post-exit inspection")
            lookup = ["docker", "container", "ls", "--all", "--quiet", "--no-trunc", "--filter", "id=" + cid]
            self.require(commands[cursor]["name"] == "find-owned-" + name and commands[cursor]["command"] == lookup and
                         self.logs(root, commands[cursor]).split() == [cid], "Pre-removal ID lookup mismatch")
            cursor += 1
            inspect_at(cursor)
            cursor += 1
            self.require(commands[cursor]["name"] == "remove-owned-" + name and
                         commands[cursor]["command"] == ["docker", "container", "rm", "--force", cid], "Wrong forced removal")
            cursor += 1
            self.require(commands[cursor]["name"] == "find-owned-" + name and commands[cursor]["command"] == lookup and
                         self.logs(root, commands[cursor]).strip() == "", "Post-removal absence is unconfirmed")
            self.require(stamp(commands[cursor]["finished_at_utc"]) <= stamp(entry["removed_at_utc"]) <= stamp(record["finished_at_utc"]),
                         "Removal timestamp mismatch")
            cursor += 1
            state = inspected[-1]["State"]
            self.require(entry.get("last_inspected_state") == state, "Saved container state differs from raw inspect")
            if not probe or operation == "probe-normal":
                self.require(not state["Running"] and state["Status"] == "exited" and state["ExitCode"] == 0 and
                             "error" not in entry, "Container did not exit successfully: " + operation)
            found[operation] = {"entry": entry, "create": create, "attached": attached,
                                "options": create["command"][len(create_prefix):], "state": state,
                                "commands": commands[start:cursor]}
        self.require(cursor == len(record["commands"]), "Unexpected commands outside registered container lifecycle")
        return found


def audit(arch, run_id, job, directory, source_hashes, workflow_hashes):
    a = Audit()
    root = directory / "swift-linux-docker-evidence"
    lifecycle = directory / "swift-linux-docker-lifecycle"
    data = json.loads((root / "validation.json").read_text())
    a.require(job.get("status") == "completed" and job.get("conclusion") == "success", "Native job did not succeed")
    a.require(data.get("status") == "passed" and data.get("check_scope") == "full_suite" and
              data.get("requested_checks") == CHECKS == data.get("completed_checks") and
              data.get("unrequested_checks") == [], "Full six-check validation did not pass")
    a.require(data.get("requested_solution_revision") == SOURCE == data.get("solution_revision") and
              data.get("workflow_revision") == WORKFLOW, "Source/workflow revision mismatch")
    a.require(data.get("source_sha256") == source_hashes == data.get("source_sha256_after") and
              data.get("workflow_sha256") == workflow_hashes, "Exact Git source/workflow hashes mismatch")
    machine, platform = {"amd64": "x86_64", "arm64": "aarch64"}[arch], "linux/" + arch
    a.require(data.get("host_system") == "Linux" and data.get("host_machine") == machine and
              data.get("requested_platform") == platform, "Native host/platform mismatch")
    for key, value in {"GITHUB_REPOSITORY": REPO, "GITHUB_SHA": WORKFLOW, "GITHUB_RUN_ID": str(run_id),
                       "GITHUB_RUN_ATTEMPT": "1", "RUNNER_OS": "Linux", "RUNNER_ARCH": "X64" if arch == "amd64" else "ARM64",
                       "GITHUB_REF": "refs/heads/swift/linux-docker-validation"}.items():
        a.require(data.get("github", {}).get(key) == value, "Unexpected GitHub field: " + key)
    a.require(data.get("run_url") == f"https://github.com/{REPO}/actions/runs/{run_id}", "Wrong run URL")
    a.require(data.get("runner_local_lock", {}).get("acquired_exclusively") is True and
              data["runner_local_lock"].get("path") == "/tmp/primes-timing.lock", "Exclusive lock acquisition missing")
    durations = a.commands(root, data)
    a.require([item["name"] for item in data["commands"][:len(PREFIX)]] == PREFIX, "Unexpected initial command sequence")
    before = {item["name"]: item for item in data["commands"][:len(PREFIX)]}
    a.require(a.logs(root, before["solution-head"]).strip() == SOURCE and
              a.logs(root, before["workflow-head"]).strip() == WORKFLOW and
              a.logs(root, before["solution-clean"]) == "", "Raw checkout identity mismatch")
    a.require(a.logs(root, before["docker-platform"]).strip() in {platform, "linux/" + machine}, "Docker daemon platform mismatch")
    docker = json.loads(a.logs(root, before["docker-version"]))
    a.require(docker == data.get("docker_version") and docker["Server"]["Os"] == "linux" and
              docker["Server"]["Arch"] == arch, "Docker version/native architecture mismatch")
    images = data["base_images"]
    a.require(set(images) == {"swift:6.3.3", "swift:6.3.3-slim"}, "Unexpected Swift base images")
    for name, image in [("inspect-base-0", images["swift:6.3.3"]), ("inspect-base-1", images["swift:6.3.3-slim"]),
                        ("inspect-build-image", data["build_image"]), ("inspect-runtime-image", data["runtime_image"])]:
        raw = json.loads(a.logs(root, before[name]))[0]
        a.require(all(raw.get(k) == v for k, v in image.items()) and image["Os"] == "linux" and
                  image["Architecture"] == arch and bool(re.fullmatch(r"sha256:[0-9a-f]{64}", image["Id"])), "Image identity mismatch: " + name)
        if name.startswith("inspect-base"):
            a.require(bool(image["RepoDigests"]) and all(re.fullmatch(r"swift@sha256:[0-9a-f]{64}", digest)
                      for digest in image["RepoDigests"]), "Missing immutable base-image digest")
    for filename, key in [("build-image.id", "build_image"), ("runtime-image.id", "runtime_image")]:
        a.require((root / filename).read_text().strip() == data[key]["Id"], "Image-ID file mismatch")
    containers = a.containers(root, data, OPERATIONS, len(PREFIX))
    suffix = SOURCE[:12] + "-" + arch
    builder, runtime = "swift-validation-build:" + suffix, "swift-validation-runtime:" + suffix
    solution_root = before["solution-head"]["command"][2]
    package = solution_root + "/experiments/swift"
    build_base = ["docker", "build", "--progress=plain", "--pull=false", "--platform", platform,
                  "--file", package + "/Dockerfile"]
    for operation, middle, filename in [("build-compiler-stage", ["--target", "build", "--tag", builder], "build-image.id"),
                                        ("build-runtime-image", ["--tag", runtime], "runtime-image.id")]:
        argv = before[operation]["command"]
        iid = argv[argv.index("--iidfile") + 1]
        a.require(PurePosixPath(iid).name == filename and
                  argv == build_base + middle + ["--iidfile", iid, package], "Dockerfile build invocation mismatch")
    for index, image in enumerate(["swift:6.3.3", "swift:6.3.3-slim"]):
        a.require(before[f"pull-base-{index}"]["command"] == ["docker", "pull", "--platform", platform, image],
                  "Swift base-image pull mismatch")
    common = ["--platform", platform, "--network", "none"]
    a.require(containers["container-swift-version"]["options"] == common + ["--entrypoint", "swiftc", builder, "--version"], "Compiler-version command mismatch")
    version = a.logs(root, containers["container-swift-version"]["attached"]).strip()
    a.require(version == data.get("swift_version") and "Swift version 6.3.3" in version and
              f"Target: {machine}-unknown-linux-gnu" in version, "Swift compiler identity mismatch")
    smoke = containers["runtime-smoke"]
    a.require(smoke["options"] == common + [runtime], "Runtime image command mismatch")
    out, err = a.logs(root, smoke["attached"]).strip(), a.logs(root, smoke["attached"], "stderr").strip()
    label, passes, elapsed, threads, tags = out.split(";")
    a.require(len(out.splitlines()) == 1 and bool(label) and int(passes) > 0 and math.isfinite(float(elapsed)) and
              float(elapsed) >= 5 and threads == "1" and tags == "algorithm=base,faithful=yes,bits=1" and
              bool(re.fullmatch(r"Validated: 78498 primes; checksum: \d+", err)), "Raw runtime smoke did not validate")
    a.require(data.get("runtime_smoke") == {"passes": int(passes), "seconds": float(elapsed), "threads": 1,
              "tags": tags, "prime_count": 78498, "performance_evidence": False}, "Smoke summary mismatch")
    for check in CHECKS:
        name, mode = check.rsplit("-", 1)
        compiled, executed = containers["compile-" + check], containers["run-" + check]
        options = compiled["options"]
        mounts = [options[i + 1] for i, part in enumerate(options) if part == "--mount"]
        a.require(len(mounts) == 2 and mounts[0] == f"type=bind,source={solution_root}/experiments/swift,target=/source,readonly" and
                  bool(re.fullmatch(r"type=bind,source=/[^,]+,target=/validation", mounts[1])), "Verification mounts mismatch")
        base = common + ["--mount", mounts[0], "--mount", mounts[1], "--workdir", "/validation"]
        flags = ["-O", "-sanitize=address"] if mode == "asan" else ["-O", "-whole-module-optimization"]
        files = ["/source/PrimeSieve.swift"] + {"verify": ["/source/Verify.swift"], "extra-verify": ["/source/ExtraVerify.swift"],
                 "phase-verify": ["/source/tools/phase-split/PhaseSieve.swift", "/source/tools/phase-split/PhaseVerify.swift"]}[name]
        a.require(options == base + ["--entrypoint", "swiftc", builder] + flags + files + ["-o", "/validation/" + check] and
                  executed["options"] == base + ["--entrypoint", "/validation/" + check, builder], "Verification command/flags mismatch: " + check)
        a.require(a.logs(root, executed["attached"]) == PASS_OUTPUTS[name] and a.logs(root, executed["attached"], "stderr") == "",
                  "Verification passing stdout/stderr mismatch: " + check)
    units = json.loads((lifecycle / "unit-results.json").read_text())
    tool_hashes = {Path(name).name: digest for name, digest in workflow_hashes.items() if name.endswith(".py")}
    a.require(units.get("status") == "passed" and units.get("tests_run") == 13 and units.get("failures") == 0 and
              units.get("errors") == 0 and units.get("source_sha256") == tool_hashes, "Native unit-test evidence mismatch")
    unit_log = (lifecycle / "unit-tests.log").read_text()
    a.require("Ran 13 tests in " in unit_log and unit_log.rstrip().endswith("OK"), "Native unit-test log does not confirm all 13")
    probe_root = lifecycle / "docker-probe"
    probe = json.loads((probe_root / "probe.json").read_text())
    a.require(probe.get("status") == "passed_lifecycle_probe" and probe.get("probe_image") == "busybox:1.37.0" and
              probe.get("timeout_observed") is True and probe.get("nonzero_exit_observed") == 7 and
              probe.get("expected_interrupt_signals") == [15], "Real lifecycle probe did not pass all intended cases")
    probe_durations = a.commands(probe_root, probe, allow_expected_errors=True)
    a.require([item["name"] for item in probe["commands"][:2]] == ["probe-pull", "probe-image"], "Probe setup mismatch")
    image = json.loads(a.logs(probe_root, probe["commands"][1]))
    a.require(image == probe.get("image_inspect") and image[0]["Os"] == "linux" and image[0]["Architecture"] == arch and
              bool(image[0]["RepoDigests"]), "Probe image/native identity mismatch")
    probes = a.containers(probe_root, probe, ["probe-normal", "probe-nonzero", "probe-timeout", "probe-sigterm"], 2, probe=True)
    for name, shell in {"probe-normal": "exit 0", "probe-nonzero": "exit 7",
                        "probe-timeout": "echo probe-started-timeout; exec sleep 10",
                        "probe-sigterm": "echo probe-started-sigterm; exec sleep 10"}.items():
        a.require(probes[name]["options"] == ["--network", "none", "busybox:1.37.0", "sh", "-c", shell], "Unexpected probe workload")
    a.require(probes["probe-nonzero"]["state"]["ExitCode"] == 7 and not probes["probe-nonzero"]["state"]["Running"], "Nonzero container exit was not observed")
    for name, kind, marker in [("probe-timeout", "TimeoutExpired:", "probe-started-timeout"),
                               ("probe-sigterm", "ValidationInterrupted:", "probe-started-sigterm")]:
        attached = probes[name]["attached"]
        a.require(attached.get("error", "").startswith(kind) and attached.get("client_reaped_after_error") is True and
                  type(attached.get("exit_code")) is int and marker in a.logs(probe_root, attached).splitlines() and
                  probe.get("observed_start_markers", {}).get(name) == marker, "Interrupted running-workload proof is missing: " + name)
    return {"status": "passed" if not a.errors else "failed", "errors": a.errors,
            "architecture": arch, "scope": "Full six Swift checks, Docker smoke and lifecycle fix; no performance claim.",
            "source_revision": SOURCE, "workflow_revision": WORKFLOW, "run_id": run_id, "job_id": job["id"],
            "validator_seconds": seconds(data["started_at_utc"], data["finished_at_utc"]),
            "job_seconds": seconds(job["started_at"], job["completed_at"]), "commands": durations,
            "completed_checks": CHECKS, "validated_containers": len(containers), "native_unit_tests": units["tests_run"],
            "probe_containers": len(probes), "probe_commands": probe_durations,
            "swift_version": version, "base_images": images, "source_sha256": source_hashes,
            "workflow_sha256": workflow_hashes}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--run-id", type=int, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--architecture", choices=["amd64", "arm64"])
    args = parser.parse_args()
    if args.run_id <= 0:
        parser.error("Use a positive run ID")
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    collection = {"status": "collecting", "started_at_utc": utc(), "run_id": args.run_id,
                  "source_revision": SOURCE, "workflow_revision": WORKFLOW,
                  "collector_sha256": sha(Path(__file__).read_bytes()), "api_requests": [], "architectures": {}}

    def api(endpoint, path, optional_404=False):
        path.parent.mkdir(parents=True, exist_ok=True)
        error_path = path.with_name(path.name + ".stderr")
        command = ["gh", "api", "--allow-escape-sequences", "--method", "GET", endpoint]
        entry = {"command": command, "started_at_utc": utc(), "stdout": str(path.relative_to(output)),
                 "stderr": str(error_path.relative_to(output)), "exit_code": None}
        collection["api_requests"].append(entry)
        try:
            with path.open("xb") as out, error_path.open("xb") as err:
                completed = subprocess.run(command, stdout=out, stderr=err, timeout=180)
            entry["exit_code"] = completed.returncode
            if completed.returncode:
                if optional_404 and re.search(rb"\bHTTP 404\b", error_path.read_bytes()):
                    entry["status"] = "unavailable_http_404"
                    return None
                raise RuntimeError("GitHub API request failed; raw responses retained")
            entry["status"] = "downloaded"
            return path.read_bytes()
        except BaseException as error:
            entry["error"] = f"{type(error).__name__}: {error}"
            raise
        finally:
            entry["finished_at_utc"] = utc()

    def pages(endpoint, stem, field):
        items = []
        for page in range(1, 101):
            data = json.loads(api(endpoint + f"?per_page=100&page={page}", output / "github" / f"{stem}-{page}.json"))
            batch = data[field]
            items.extend(batch)
            if len(batch) < 100:
                return items
        raise RuntimeError("Pagination bound exceeded")

    try:
        source_hashes = expected(SOURCE, SOURCE_FILES, "experiments/swift/")
        workflow_hashes = expected(WORKFLOW, WORKFLOW_FILES)
        write_json(output / "expected-source-hashes.json", source_hashes)
        write_json(output / "expected-workflow-hashes.json", workflow_hashes)
        base = f"repos/{REPO}/actions/runs/{args.run_id}"
        run = json.loads(api(base, output / "github/run.json"))
        if run.get("head_sha") != WORKFLOW or run.get("run_attempt") != 1 or run.get("event") != "push":
            raise ValueError("Run does not match the fixed workflow revision/attempt/event")
        jobs = pages(base + "/jobs", "jobs", "jobs")
        artifacts = pages(base + "/artifacts", "artifacts", "artifacts")
        for arch in [args.architecture] if args.architecture else ["amd64", "arm64"]:
            target = output / arch
            target.mkdir()
            result = {"status": "incomplete", "errors": []}
            try:
                matches = [job for job in jobs if job["name"] == f"Validate cutoff 111 on native {arch}"]
                if len(matches) != 1:
                    raise ValueError("Expected exactly one native job")
                job = json.loads(api(f"repos/{REPO}/actions/jobs/{matches[0]['id']}", target / "job.json"))
                if job.get("run_id") != args.run_id or job.get("head_sha") != WORKFLOW or job.get("run_attempt") != 1:
                    raise ValueError("Job identity mismatch")
                if job.get("status") != "completed":
                    result = {"status": "not_ready", "job_status": job.get("status"), "errors": ["Native job is not completed"]}
                    continue
                log = api(f"repos/{REPO}/actions/jobs/{job['id']}/logs", target / "job.log", optional_404=True)
                result["supplemental_job_log"] = "available" if log is not None else "unavailable_http_404_cause_unknown"
                artifact_name = f"swift-linux-{arch}-full-{SOURCE}"
                found = [item for item in artifacts if item["name"] == artifact_name and item.get("expired") is False]
                if len(found) != 1:
                    raise ValueError("Expected one nonexpired architecture artifact")
                artifact = json.loads(api(f"repos/{REPO}/actions/artifacts/{found[0]['id']}", target / "artifact.json"))
                if (artifact.get("name") != artifact_name or artifact.get("expired") is not False or
                        artifact.get("workflow_run", {}).get("id") != args.run_id or
                        artifact["workflow_run"].get("head_sha") != WORKFLOW or
                        not re.fullmatch(r"sha256:[0-9a-f]{64}", artifact.get("digest", ""))):
                    raise ValueError("Artifact identity/digest metadata mismatch")
                archive = api(f"repos/{REPO}/actions/artifacts/{artifact['id']}/zip", target / "artifact.zip")
                digest = sha(archive)
                write_json(target / "zip-digest.json", {"sha256": digest, "api_digest": artifact["digest"],
                           "matches_api_digest": "sha256:" + digest == artifact["digest"]})
                if "sha256:" + digest != artifact["digest"]:
                    raise ValueError("Original ZIP does not match the API digest")
                write_json(target / "extracted-files.json", extract(target / "artifact.zip", target / "artifact"))
                result = {**result, **audit(arch, args.run_id, job, target / "artifact", source_hashes, workflow_hashes)}
                result["artifact_id"] = artifact["id"]
                result["artifact_zip_sha256"] = digest
            except Exception as error:
                result.update(status="incomplete_or_failed", error=f"{type(error).__name__}: {error}")
            finally:
                collection["architectures"][arch] = result
                write_json(target / "audit.json", result)
        collection["status"] = ("passed_selected_architectures" if collection["architectures"] and
                                all(item["status"] == "passed" for item in collection["architectures"].values())
                                else "incomplete_or_failed")
    except BaseException as error:
        collection.update(status="incomplete_or_failed", error=f"{type(error).__name__}: {error}")
    finally:
        collection["finished_at_utc"] = utc()
        write_json(output / "collection.json", collection)
        files = [{"path": str(path.relative_to(output)), "bytes": path.stat().st_size, "sha256": sha(path.read_bytes())}
                 for path in sorted(output.rglob("*")) if path.is_file()]
        write_json(output / "evidence-manifest.json", files)
    print(json.dumps({"output": str(output), "status": collection["status"],
                      "architectures": {key: item["status"] for key, item in collection["architectures"].items()}}, indent=2))
    return 0 if collection["status"] == "passed_selected_architectures" else 1


if __name__ == "__main__":
    sys.exit(main())
