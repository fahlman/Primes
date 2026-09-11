"""Compare the base, faithful implementation with all three repository entries.

Runs three rotated five-second trials per implementation (60 seconds total).
Requires Python 3, Swift, and network access. All generated build files stay
under .build; raw measurements are saved in all-swift-results.json.
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
variants = {
    'repository-bool': ('PrimeSwift_8bitBool', 8),
    'repository-packed': ('PrimeSwift_1bit_u8', 1),
    'repository-striped': ('PrimeSwift_1bitStriped_u8', 1),
}

def compile_swift(*arguments):
    subprocess.run(['swiftc', *map(str, arguments)], cwd=root, check=True)

compile_swift('-O', '-parse-as-library', '-module-name', 'BenchmarkObserver',
              '-emit-module', '-emit-module-path', build / 'BenchmarkObserver.swiftmodule',
              '-emit-object', root / 'BenchmarkObserver.swift', '-o', build / 'BenchmarkObserver.o')

runner = (root / 'Benchmark.swift').read_text()
for name, (directory, bits) in variants.items():
    url = f'https://raw.githubusercontent.com/PlummersSoftwareLLC/Primes/{revision}/PrimeSwift/solution_1/{directory}/Sources/PrimeSieveSwift/main.swift'
    source = urlopen(url).read().decode()
    source = source[:source.index('extension Sieve {\n    func printResults')]
    source = source.replace('import ArgumentParser\n', '')
    if bits == 1:
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
'''
    else:
        source += '''
extension Sieve {
    func withStorage<R>(_ body: (UnsafeRawPointer?) -> R) -> R {
        body(bits.baseAddress)
    }
    func primes() -> [Int] {
        var result = [2]
        for num in stride(from: 3, to: sieveSize, by: 2) {
            if bits[index(for: num)] { result.append(num) }
        }
        return result
    }
}
'''
    source += '\ntypealias PrimeSieve = Sieve\n'
    source_path = build / (name + '.swift')
    source_path.write_text(source)
    adapted_runner = runner.replace('fahlman_swift_dense_striped', name).replace('bits=1', f'bits={bits}')
    if bits == 8:
        adapted_runner = adapted_runner.replace('let byteCount = ((limit - 1) / 2 + 7) / 8', 'let byteCount = (limit + 1) / 2')
    runner_path = build / (name + '-runner.swift')
    runner_path.write_text(adapted_runner)
    compile_swift('-O', '-whole-module-optimization', '-I', build,
                  source_path, runner_path, build / 'BenchmarkObserver.o', '-o', build / name)

compile_swift('-O', '-whole-module-optimization', '-I', build,
              root / 'PrimeSieve.swift', root / 'Benchmark.swift',
              build / 'BenchmarkObserver.o', '-o', build / 'new')

names = [*variants, 'new']
samples = {name: [] for name in names}
for round_index in range(3):
    order = names[round_index:] + names[:round_index]
    for name in order:
        result = subprocess.run([str(build / name)], cwd=root, capture_output=True, text=True, check=True)
        line = result.stdout.strip()
        label, count, seconds, threads, tags = line.split(';')
        item = dict(output=line, passes=int(count), seconds=float(seconds),
                    threads=int(threads), tags=tags, validation=result.stderr.strip())
        item['milliseconds_per_pass'] = item['seconds'] * 1000 / item['passes']
        samples[name].append(item)
        print(line, flush=True)

medians = {name: statistics.median(item['milliseconds_per_pass'] for item in values)
           for name, values in samples.items()}
speedups = {name: medians[name] / medians['new'] for name in variants}
results = dict(revision=revision, samples=samples, median_ms=medians, speedups=speedups)
(root / 'all-swift-results.json').write_text(json.dumps(results, indent=2) + '\n')
print(json.dumps({'median_ms': medians, 'speedups': speedups}, indent=2))
