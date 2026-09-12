from pathlib import Path
import hashlib
import json
import statistics
import sys

path = Path(sys.argv[1])
d = json.loads(path.read_text())
assert d['cpu'] == 'Apple M4 Pro' and d['machine'] == 'arm64'
assert 'Swift version 6.3.3' in d['swift_version']
assert d['harness_revision'] == '25402d46ba991b39451724d3873d326626981e3f'
assert d['flags'] == ['-O', '-whole-module-optimization']
names = list(d['variants'])
assert d['run_order'] == [names[i:] + names[:i] for i in range(3)]
rows = {}
for name in names:
    samples = d['samples'][name]
    assert len(samples) == 3
    us = []
    for sample in samples:
        assert sample['passes'] > 0 and sample['seconds'] >= 5
        assert sample['threads'] == 1 and sample['tags'] == 'algorithm=base,faithful=yes,bits=1'
        assert 'Validated: 78498 primes;' in sample['validation']
        assert abs(sample['milliseconds_per_pass'] - 1000 * sample['seconds'] / sample['passes']) < 1e-12
        us.append(1000 * sample['milliseconds_per_pass'])
    median = statistics.median(us)
    assert abs(median - 1000 * d['median_ms'][name]) < 1e-12
    rows[name] = {'revision': d['variants'][name]['revision'], 'samples_us': us,
                  'median_us': median, 'passes_per_second_from_median': 1_000_000 / median}

controls = ['cutoff127', 'development63'] if 'cutoff79' in names else ['baseline127']
comparisons = {}
for control in controls:
    c = rows[control]
    comparisons[control] = {}
    for name, row in rows.items():
        if name == control:
            continue
        qualifies = max(row['samples_us']) < min(c['samples_us'])
        separated_slower = min(row['samples_us']) > max(c['samples_us'])
        comparisons[control][name] = {
            'throughput_change_percent': 100 * (c['median_us'] / row['median_us'] - 1),
            'saved_us_per_sieve': c['median_us'] - row['median_us'],
            'every_candidate_trial_faster_than_every_control_trial': qualifies,
            'every_candidate_trial_slower_than_every_control_trial': separated_slower,
            'classification': 'qualifies' if qualifies else ('separated_slower' if separated_slower else 'not_clearly_separated')}
result = {'raw_file': path.name, 'raw_sha256': hashlib.sha256(path.read_bytes()).hexdigest(),
          'variants': rows, 'comparisons': comparisons,
          'interpretation': 'Same-session medians and registered non-overlap admission; no statistical significance or cross-platform claim.'}
out = path.with_name(path.stem.replace('-results-', '-analysis-') + '.json')
assert not out.exists()
out.write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(result, indent=2))
