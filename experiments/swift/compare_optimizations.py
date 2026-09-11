"""Compare committed Swift candidates using the unchanged baseline runner.

Supply --variant NAME=REVISION for each candidate. Three rotated five-second
runs per variant are measured serially after every executable is compiled.
"""
import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import platform
import statistics
import subprocess


HARNESS_REVISION = '25402d46ba991b39451724d3873d326626981e3f'
PACKAGE = 'experiments/swift'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--repo', type=Path, default=Path(__file__).resolve().parent)
    parser.add_argument('--variant', action='append', required=True, metavar='NAME=REVISION')
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()

    def git(*arguments):
        return subprocess.check_output(['git', '-C', str(args.repo), *arguments], text=True).strip()

    repo = Path(git('rev-parse', '--show-toplevel'))
    root = repo / PACKAGE
    build = root / '.build' / 'optimization-comparison'
    build.mkdir(parents=True, exist_ok=True)
    output = args.output or root / 'optimization-results.json'

    def source(revision, name):
        return subprocess.check_output(['git', '-C', str(repo), 'show', f'{revision}:{PACKAGE}/{name}'])

    def compile_swift(*arguments):
        subprocess.run(['swiftc', *map(str, arguments)], cwd=build, check=True)

    observer = source(HARNESS_REVISION, 'BenchmarkObserver.swift')
    runner = source(HARNESS_REVISION, 'Benchmark.swift')
    (build / 'BenchmarkObserver.swift').write_bytes(observer)
    compile_swift('-O', '-parse-as-library', '-module-name', 'BenchmarkObserver',
                  '-emit-module', '-emit-module-path', build / 'BenchmarkObserver.swiftmodule',
                  '-emit-object', build / 'BenchmarkObserver.swift', '-o', build / 'BenchmarkObserver.o')

    variants = {}
    for specification in args.variant:
        name, revision = specification.split('=', 1)
        if not name or any(c not in 'abcdefghijklmnopqrstuvwxyz0123456789-_' for c in name):
            parser.error('Variant names must use lowercase letters, digits, hyphens, or underscores.')
        if name in variants:
            parser.error(f'Duplicate variant: {name}')
        revision = git('rev-parse', '--verify', f'{revision}^{{commit}}')
        implementation = source(revision, 'PrimeSieve.swift')
        path = build / name
        path.mkdir(exist_ok=True)
        (path / 'PrimeSieve.swift').write_bytes(implementation)
        (path / 'Benchmark.swift').write_text(runner.decode().replace('fahlman_swift_striped_unrolled', name))
        compile_swift('-O', '-whole-module-optimization', '-I', build,
                      path / 'PrimeSieve.swift', path / 'Benchmark.swift',
                      build / 'BenchmarkObserver.o', '-o', path / 'benchmark')
        variants[name] = {'revision': revision, 'source_sha256': hashlib.sha256(implementation).hexdigest()}

    names = list(variants)
    samples = {name: [] for name in names}
    orders = []
    for round_index in range(3):
        shift = round_index % len(names)
        order = names[shift:] + names[:shift]
        orders.append(order)
        for name in order:
            result = subprocess.run([str(build / name / 'benchmark')], cwd=build,
                                    capture_output=True, text=True, check=True)
            label, passes, seconds, threads, tags = result.stdout.strip().split(';')
            passes, seconds, threads = int(passes), float(seconds), int(threads)
            if (label != name or passes <= 0 or seconds < 5 or threads != 1
                    or tags != 'algorithm=base,faithful=yes,bits=1'
                    or 'Validated: 78498 primes;' not in result.stderr):
                raise RuntimeError(f'Invalid benchmark output for {name}: {result.stdout} {result.stderr}')
            item = {'output': result.stdout.strip(), 'passes': passes, 'seconds': seconds,
                    'threads': threads, 'tags': tags, 'validation': result.stderr.strip(),
                    'milliseconds_per_pass': 1000 * seconds / passes}
            samples[name].append(item)
            print(f'{name}: {item["milliseconds_per_pass"]:.6f} ms/pass ({passes} passes)', flush=True)

    medians = {name: statistics.median(s['milliseconds_per_pass'] for s in runs)
               for name, runs in samples.items()}
    cpu = (subprocess.check_output(['sysctl', '-n', 'machdep.cpu.brand_string'], text=True).strip()
           if platform.system() == 'Darwin' else platform.processor())
    results = {'recorded_at_utc': datetime.now(timezone.utc).isoformat(),
               'platform': platform.platform(), 'machine': platform.machine(), 'cpu': cpu,
               'swift_version': subprocess.check_output(['swiftc', '--version'], text=True).strip(),
               'flags': ['-O', '-whole-module-optimization'],
               'harness_revision': HARNESS_REVISION,
               'runner_sha256': hashlib.sha256(runner).hexdigest(),
               'observer_sha256': hashlib.sha256(observer).hexdigest(),
               'variants': variants, 'run_order': orders, 'samples': samples, 'median_ms': medians,
               'speedup_over_first': {name: medians[names[0]] / value for name, value in medians.items()}}
    output.write_text(json.dumps(results, indent=2) + '\n')
    print(json.dumps({'median_ms': medians, 'speedup_over_first': results['speedup_over_first']}, indent=2))


if __name__ == '__main__':
    main()
