"""Focused container-lifecycle tests; add --docker-probe for a small real probe.

The default tests use fake Docker responses and no Docker or Swift execution.
The explicit probe pulls one small image and runs normal, timeout and SIGTERM
cases under the runner-local timing lock. It never builds or runs the sieve.
"""
import argparse
import json
import os
from pathlib import Path
import signal
import subprocess
import sys
import tempfile
import threading
import unittest
from unittest.mock import Mock, patch

from validate import (CommandRunner, OwnedContainers, ValidationInterrupted,
                      finish_cleanup, hashes, install_signal_handlers, utc)


class FakeDocker:
    def __init__(self):
        self.items = {}
        self.calls = []
        self.start_error = None
        self.fail_remove = False
        self.uncertain_create = False
        self.foreign_collision = False
        self.container_exit_code = 0
        self.fail_lookup = False
        self.rename_on_start = False

    def __call__(self, name, command, timeout=1200):
        command = list(map(str, command))
        self.calls.append(command)
        action = command[2]
        if action == "create":
            if self.uncertain_create:
                raise subprocess.TimeoutExpired(command, timeout)
            container_name = command[command.index("--name") + 1]
            label = command[command.index("--label") + 1]
            key, value = label.split("=", 1)
            container_id = f"{len(self.items) + 1:064x}"
            self.items[container_id] = {
                "Id": container_id, "Name": "/" + container_name,
                "Config": {"Labels": {key: "someone-else" if self.foreign_collision else value}},
                "State": {"Running": False, "Status": "created", "ExitCode": 0},
            }
            if self.foreign_collision:
                raise RuntimeError("Name is already in use")
            return container_id + "\n", ""
        if action == "inspect":
            return json.dumps([self.items[command[3]]]), ""
        if action == "ls":
            if self.fail_lookup:
                raise RuntimeError("Docker daemon is unavailable")
            if command[-1].startswith("id="):
                target = command[-1].removeprefix("id=")
                return target if target in self.items else "", ""
            name_filter = command[-1].removeprefix("name=^").removesuffix("$")
            return "\n".join(k for k, v in self.items.items() if v["Name"] == name_filter), ""
        if action == "start":
            if self.rename_on_start:
                self.items[command[-1]]["Name"] = "/renamed-while-running"
            if self.start_error:
                self.items[command[-1]]["State"] = {"Running": True, "Status": "running", "ExitCode": 0}
                raise self.start_error
            self.items[command[-1]]["State"] = {
                "Running": False, "Status": "exited", "ExitCode": self.container_exit_code}
            return "finished\n", ""
        if action == "rm":
            if self.fail_remove:
                raise RuntimeError("Docker removal failed")
            del self.items[command[-1]]
            return "", ""
        raise AssertionError(command)


class LifecycleTests(unittest.TestCase):
    def setUp(self):
        self.record = {"commands": [], "status": "running"}
        self.docker = FakeDocker()
        self.containers = OwnedContainers(self.docker, self.record, lambda: None)
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.lock = Path(self.temp.name) / "lock"
        self.lock.write_text("owned\n")
        self.inode = self.lock.stat().st_ino

    def finish(self):
        return finish_cleanup(self.containers, self.record, self.lock, self.inode)

    def test_normal_run_removes_verified_id_and_preserves_unrelated_container(self):
        foreign_id = "f" * 64
        self.docker.items[foreign_id] = {"Id": foreign_id, "Name": "/unrelated", "Config": {"Labels": {}}}
        self.assertEqual(self.containers("normal", ["image"])[0], "finished\n")
        self.assertEqual(list(self.docker.items), [foreign_id])
        entry = self.record["containers"][0]
        self.assertTrue(entry["removed_confirmed"])
        starts = [c for c in self.docker.calls if c[2] == "start"]
        self.assertEqual(starts, [["docker", "container", "start", "--attach", entry["id"]]])
        self.assertTrue(self.finish())
        self.assertFalse(self.lock.exists())

    def test_timeout_and_interrupt_preserve_primary_error_and_remove_container(self):
        for error in [subprocess.TimeoutExpired("docker", 1), ValidationInterrupted(signal.SIGTERM)]:
            with self.subTest(error=type(error).__name__):
                self.docker.start_error = error
                with self.assertRaises(type(error)) as caught:
                    self.containers("interrupted", ["image"])
                self.assertIs(caught.exception, error)
                self.assertEqual(self.docker.items, {})
                self.assertTrue(self.record["containers"][-1]["removed_confirmed"])
        self.assertTrue(self.finish())
        self.assertFalse(self.lock.exists())

    def test_cleanup_failure_retains_lock_and_original_timeout(self):
        error = subprocess.TimeoutExpired("docker", 1)
        self.docker.start_error, self.docker.fail_remove = error, True
        with self.assertRaises(subprocess.TimeoutExpired) as caught:
            self.containers("timeout", ["image"])
        self.assertIs(caught.exception, error)
        self.assertFalse(self.finish())
        self.assertTrue(self.lock.exists())
        self.assertEqual(self.record["status"], "failed")
        self.assertTrue(self.record["containers"][0]["cleanup_errors"])

    def test_client_success_cannot_hide_nonzero_container_exit(self):
        self.docker.container_exit_code = 7
        with self.assertRaisesRegex(RuntimeError, "container did not exit successfully"):
            self.containers("nonzero", ["image"])
        self.assertEqual(self.record["containers"][0]["last_inspected_state"]["ExitCode"], 7)
        self.assertEqual(self.docker.items, {})
        self.assertTrue(self.finish())

    def test_uncertain_create_never_starts_and_retains_lock_even_if_lookup_empty(self):
        self.docker.uncertain_create = True
        with self.assertRaises(subprocess.TimeoutExpired):
            self.containers("create-timeout", ["image"])
        self.assertFalse(any(c[2] == "start" for c in self.docker.calls))
        self.assertFalse(self.finish())
        self.assertTrue(self.lock.exists())

    def test_failed_lookup_is_not_treated_as_container_absence(self):
        self.docker.fail_lookup = True
        with self.assertRaises(RuntimeError):
            self.containers("lookup-failure", ["image"])
        self.assertFalse(self.finish())
        self.assertTrue(self.docker.items)
        self.assertTrue(self.lock.exists())

    def test_foreign_name_collision_is_never_removed_or_started(self):
        self.docker.foreign_collision = True
        with self.assertRaises(RuntimeError):
            self.containers("collision", ["image"])
        self.assertFalse(any(c[2] in {"rm", "start"} for c in self.docker.calls))
        self.assertFalse(self.finish())
        self.assertTrue(self.docker.items)
        self.assertTrue(self.lock.exists())

    def test_renamed_known_container_is_not_mistaken_for_absence(self):
        self.docker.rename_on_start = True
        self.docker.start_error = subprocess.TimeoutExpired("docker", 1)
        with self.assertRaises(subprocess.TimeoutExpired):
            self.containers("renamed", ["image"])
        self.assertFalse(self.finish())
        entry = self.record["containers"][0]
        self.assertFalse(entry["removed_confirmed"])
        self.assertIn(entry["id"], self.docker.items)
        self.assertTrue(any(c[-1] == "id=" + entry["id"] for c in self.docker.calls if c[2] == "ls"))
        self.assertTrue(self.lock.exists())

    def test_unreaped_client_retains_lock_without_containers(self):
        self.record["commands"].append({"client_cleanup_error": "Unable to stop client"})
        self.assertFalse(self.finish())
        self.assertTrue(self.lock.exists())

    def test_lock_with_another_inode_is_not_removed(self):
        self.inode += 1
        self.assertTrue(self.finish())
        self.assertTrue(self.lock.exists())

    def test_sigterm_raises_normally_and_is_deferred_during_cleanup(self):
        previous = install_signal_handlers(self.record)
        try:
            handler = signal.getsignal(signal.SIGTERM)
            with self.assertRaises(ValidationInterrupted):
                handler(signal.SIGTERM, None)
            self.record["cleaning_up"] = True
            handler(signal.SIGTERM, None)
            self.assertEqual(self.record["interrupted_signals"], [signal.SIGTERM, signal.SIGTERM])
        finally:
            for sig, handler in previous.items():
                signal.signal(sig, handler)


class ClientTests(unittest.TestCase):
    def test_timeout_and_interrupt_stop_group_and_reap_client_with_partial_logs(self):
        for error in [subprocess.TimeoutExpired("docker", 1), ValidationInterrupted(signal.SIGTERM)]:
            with self.subTest(error=type(error).__name__), tempfile.TemporaryDirectory() as directory:
                output = Path(directory)
                (output / "logs").mkdir()
                record = {"commands": []}
                process = Mock(pid=12345)
                process.wait.side_effect = [error, -15, -15]
                def create(*_args, **kwargs):
                    kwargs["stdout"].write("partial output\n")
                    return process
                with patch("validate.subprocess.Popen", side_effect=create) as popen, patch("validate.os.killpg") as kill:
                    with self.assertRaises(type(error)):
                        CommandRunner(output, record, lambda: None)("client", ["docker"], timeout=1)
                self.assertTrue(popen.call_args.kwargs["start_new_session"])
                self.assertEqual([call.args for call in kill.call_args_list],
                                 [(12345, signal.SIGTERM), (12345, signal.SIGKILL)])
                entry = record["commands"][0]
                self.assertTrue(entry["client_reaped_after_error"])
                self.assertIn("partial output", (output / entry["stdout_log"]).read_text())
                self.assertIn("error", entry)

    def test_client_cleanup_failure_is_recorded(self):
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory)
            (output / "logs").mkdir()
            record = {"commands": []}
            process = Mock(pid=12345)
            process.wait.side_effect = subprocess.TimeoutExpired("docker", 1)
            with patch("validate.subprocess.Popen", return_value=process), patch("validate.os.killpg", side_effect=PermissionError):
                with self.assertRaises(subprocess.TimeoutExpired):
                    CommandRunner(output, record, lambda: None)("client", ["docker"], timeout=1)
            self.assertIn("client_cleanup_error", record["commands"][0])


def docker_probe(output, image):
    output.mkdir(parents=True, exist_ok=False)
    (output / "logs").mkdir()
    record = {"purpose": "Small Docker lifecycle probe; no Swift or performance validation.",
              "status": "running", "started_at_utc": utc(), "commands": [], "probe_image": image}
    def save():
        (output / "probe.json").write_text(json.dumps(record, indent=2) + "\n")
    class ProbeRunner(CommandRunner):
        def __call__(self, name, command, timeout=1200):
            timer = None
            if name == "probe-sigterm":
                # Creation and ownership inspection have completed at this point.
                timer = threading.Timer(1, lambda: os.kill(os.getpid(), signal.SIGTERM))
                timer.start()
            try:
                return super().__call__(name, command, timeout)
            finally:
                if timer:
                    timer.cancel()
                    timer.join()
    run = ProbeRunner(output, record, save)
    containers = OwnedContainers(run, record, save)
    previous = install_signal_handlers(record)
    lock = Path("/tmp/primes-timing.lock")
    inode = None
    failed = False
    try:
        descriptor = os.open(lock, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
        inode = os.fstat(descriptor).st_ino
        with os.fdopen(descriptor, "w") as handle:
            handle.write("Swift validation Docker lifecycle probe\n")
        run("probe-pull", ["docker", "pull", image], timeout=120)
        info, _ = run("probe-image", ["docker", "image", "inspect", image], timeout=5)
        record["image_inspect"] = json.loads(info)
        options = ["--network", "none", image, "sh", "-c"]
        def require_started(name, marker):
            command = next(item for item in record["commands"] if item["name"] == name)
            if marker not in (output / command["stdout_log"]).read_text().splitlines():
                raise AssertionError("Interrupted probe did not establish that container work started")
            record.setdefault("observed_start_markers", {})[name] = marker
        containers("probe-normal", options + ["exit 0"], timeout=5)
        try:
            containers("probe-nonzero", options + ["exit 7"], timeout=5)
            raise AssertionError("Expected a nonzero container exit to fail")
        except RuntimeError:
            if record["containers"][-1]["last_inspected_state"]["ExitCode"] != 7:
                raise AssertionError("The nonzero container outcome was not recorded")
            record["nonzero_exit_observed"] = 7
        try:
            containers("probe-timeout", options + ["echo probe-started-timeout; exec sleep 10"], timeout=1)
            raise AssertionError("Expected a client timeout")
        except subprocess.TimeoutExpired:
            require_started("probe-timeout", "probe-started-timeout")
            record["timeout_observed"] = True
        try:
            containers("probe-sigterm", options + ["echo probe-started-sigterm; exec sleep 10"], timeout=5)
            raise AssertionError("Expected SIGTERM cancellation")
        except ValidationInterrupted:
            require_started("probe-sigterm", "probe-started-sigterm")
            record["expected_interrupt_signals"] = record.pop("interrupted_signals", [])
            if record["expected_interrupt_signals"] != [signal.SIGTERM]:
                raise AssertionError("Unexpected interrupt signal record")
        if not all(item["removed_confirmed"] for item in record["containers"]):
            raise AssertionError("An owned probe container remains")
        record["status"] = "passed_lifecycle_probe"
    except BaseException as error:
        failed = True
        record.update(status="failed", error=f"{type(error).__name__}: {error}")
        raise
    finally:
        try:
            confirmed = finish_cleanup(containers, record, lock, inode)
            record["finished_at_utc"] = utc()
            save()
            if not failed and not confirmed:
                raise RuntimeError(record["cleanup_error"])
        finally:
            for sig, handler in previous.items():
                signal.signal(sig, handler)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--docker-probe", action="store_true")
    parser.add_argument("--output", type=Path)
    parser.add_argument("--probe-image", default="busybox:1.37.0")
    args = parser.parse_args()
    if args.docker_probe and args.output is None:
        parser.error("--docker-probe requires a new --output directory")
    if args.output is not None:
        args.output = args.output.resolve()
        args.output.mkdir(parents=True, exist_ok=False)
    suite = unittest.defaultTestLoader.loadTestsFromModule(__import__(__name__))
    started = utc()
    if args.output is None:
        result = unittest.TextTestRunner(verbosity=2).run(suite)
    else:
        with (args.output / "unit-tests.log").open("w") as stream:
            result = unittest.TextTestRunner(verbosity=2, stream=stream).run(suite)
        summary = {"status": "passed" if result.wasSuccessful() else "failed",
                   "tests_run": result.testsRun, "failures": len(result.failures), "errors": len(result.errors),
                   "started_at_utc": started, "finished_at_utc": utc(), "command": sys.argv,
                   "source_sha256": hashes(Path(__file__).parent, ["validate.py", "test_lifecycle.py"])}
        (args.output / "unit-results.json").write_text(json.dumps(summary, indent=2) + "\n")
    if not result.wasSuccessful():
        raise SystemExit(1)
    if args.docker_probe:
        docker_probe(args.output / "docker-probe", args.probe_image)
