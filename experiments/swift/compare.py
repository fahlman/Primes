"""Reproduce three alternating five-second runs against the pinned repository.

Run with Python 3 from any directory. Requires Swift and network access.
Generated files are stored only under this package's .build directory.
"""
from pathlib import Path
import json
import statistics
import subprocess
from urllib.request import urlopen

root = Path(__file__).resolve().parent
build = root / '.build'
build.mkdir(exist_ok=True)
revision = '22bfea9c7122c46dcda799020fccf5ae83fe667f'
url = f'https://raw.githubusercontent.com/PlummersSoftwareLLC/Primes/{revision}/PrimeSwift/solution_1/PrimeSwift_1bitStriped_u8/Sources/PrimeSieveSwift/main.swift'
source = urlopen(url).read().decode()
source = source[:source.index('extension Sieve {\n    func printResults')]
source = source.replace('import ArgumentParser\n', '')
start = source.index('let bitMasks =')
end = source.index('// This is a very limited')
source = source[:start] + '''let bitMasks: UnsafeMutableBufferPointer<Word> = {
    let masks = UnsafeMutableBufferPointer<Word>.allocate(capacity: wordSize)
    _ = masks.initialize(from: ContiguousArray((0..<wordSize).lazy.map { Word(1) &<< $0 }))
    return masks
}()

''' + source[end:]
source += '''
extension BooleanBitArray {
    func withStorage<R>(_ body: (UnsafeRawPointer?) -> R) -> R {
        body(words.baseAddress)
    }
}
extension Sieve {
    func withStorage<R>(_ body: (UnsafeRawPointer?) -> R) -> R {
        primeArray.withStorage(body)
    }
    func primes() -> [Int] {
        var result = [2]
        for num in stride(from: 3, to: sieveLimit, by: 2) {
            if primeArray.getBit(at: index(for: num)) { result.append(num) }
        }
        return result
    }
}
typealias PrimeSieve = Sieve
'''
(build / 'RepositoryBaseline.swift').write_text(source)
runner = (root / 'Benchmark.swift').read_text().replace('fahlman_swift_dense_striped', 'repository_striped_u8')
(build / 'RepositoryBenchmark.swift').write_text(runner)

def run(*arguments):
    subprocess.run(list(map(str, arguments)), cwd=root, check=True)

run('swiftc', '-O', '-parse-as-library', '-module-name', 'BenchmarkObserver',
    '-emit-module', '-emit-module-path', build / 'BenchmarkObserver.swiftmodule',
    '-emit-object', root / 'BenchmarkObserver.swift', '-o', build / 'BenchmarkObserver.o')
for name, implementation, benchmark in [
    ('new', root / 'PrimeSieve.swift', root / 'Benchmark.swift'),
    ('repository', build / 'RepositoryBaseline.swift', build / 'RepositoryBenchmark.swift'),
]:
    run('swiftc', '-O', '-whole-module-optimization', '-I', build,
        implementation, benchmark, build / 'BenchmarkObserver.o', '-o', build / name)

samples = {'repository': [], 'new': []}
for round_index in range(3):
    names = ['repository', 'new'] if round_index % 2 == 0 else ['new', 'repository']
    for name in names:
        result = subprocess.run([str(build / name)], cwd=root, capture_output=True, text=True, check=True)
        line = result.stdout.strip()
        label, count, seconds, threads, tags = line.split(';')
        item = dict(output=line, passes=int(count), seconds=float(seconds), validation=result.stderr.strip())
        item['milliseconds_per_pass'] = item['seconds'] * 1000 / item['passes']
        samples[name].append(item)
        print(name, line, flush=True)

medians = {name: statistics.median(item['milliseconds_per_pass'] for item in runs)
           for name, runs in samples.items()}
results = dict(revision=revision, samples=samples, median_ms=medians,
               speedup=medians['repository'] / medians['new'])
(root / 'comparison-results.json').write_text(json.dumps(results, indent=2) + '\n')
print(json.dumps({'median_ms': medians, 'speedup': results['speedup']}, indent=2))
