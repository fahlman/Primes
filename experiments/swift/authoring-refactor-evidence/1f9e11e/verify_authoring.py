import hashlib, json, os, pathlib, subprocess, time
repo = pathlib.Path('/Users/ryan/Developer/Primes-authoring-template')
root = repo / 'experiments/swift'
revision = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=repo, text=True).strip()
out = root / 'authoring-refactor-evidence' / revision[:7]
out.mkdir(parents=True, exist_ok=False)
record = {'candidate': revision, 'purpose': 'Authoring identity and generator checks; no throughput measurement', 'commands': []}
lock = pathlib.Path('/tmp/primes-timing.lock')
identity = f'Codex authoring refactor checks {revision} pid={os.getpid()}\n'
owned = False

def save():
    (out / 'verification.json').write_text(json.dumps(record, indent=2)+'\n')

def run(argv, name):
    started=time.monotonic()
    p=subprocess.run(argv, cwd=root, capture_output=True)
    (out / (name+'.stdout')).write_bytes(p.stdout)
    (out / (name+'.stderr')).write_bytes(p.stderr)
    record['commands'].append({'argv': argv, 'exit_code': p.returncode, 'elapsed_seconds':time.monotonic()-started,
                               'stdout':name+'.stdout','stderr':name+'.stderr'})
    save()
    if p.returncode:
        raise RuntimeError(f'{name} failed with exit {p.returncode}')
    return p.stdout

try:
    with lock.open('x') as f: f.write(identity)
    owned=True
    record['lock_owner']=identity.strip()
    run(['swiftc','--version'], 'swift-version')
    run(['sw_vers'], 'os-version')
    source=(root/'PrimeSieve.swift').read_bytes()
    base=subprocess.check_output(['git','show','84d8a4f:experiments/swift/PrimeSieve.swift'],cwd=repo)
    record['initial_source_identical_to_84d8a4f'] = source == base
    if source != base: raise RuntimeError('Initial template source differs from adopted source')
    files=['PrimeSieve.swift','tools/PrimeSieve.swift.in','tools/generate-dense.swift',
           'tools/generate-dense-128.swift','tools/check-dense-generator.swift']
    record['sha256']={p:hashlib.sha256((root/p).read_bytes()).hexdigest() for p in files}
    checker=run(['swift','tools/check-dense-generator.swift'],'generator-checks')
    parsed=json.loads(checker)
    if parsed['status'] != 'passed': raise RuntimeError('Generator suite reported failure')
    record['generator_summary']={k:parsed[k] for k in ['status','command_count','schedule','temporary_fixtures_removed']}
    if (root/'PrimeSieve.swift').read_bytes()!=source: raise RuntimeError('Source changed during checks')
    record['status']='passed'
except BaseException as e:
    record['status']='failed'; record['error']=repr(e)
    raise
finally:
    if owned and lock.read_text()==identity:
        lock.unlink(); record['owned_lock_released']=True
    save()
