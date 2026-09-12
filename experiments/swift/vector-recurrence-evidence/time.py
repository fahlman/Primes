from pathlib import Path
import argparse, hashlib, json, math, os, shutil, statistics, subprocess, sys
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from primes_run_support import TimingLock, run, snapshot, check_conditions, utc

p=argparse.ArgumentParser()
p.add_argument('--candidate',required=True)
a=p.parse_args()
repo=Path('/Users/ryan/Developer/Primes-vector-recurrence');root=repo/'experiments/swift'
evidence=root/'vector-recurrence-evidence'
control='1d0522115846d8c6487d49a9bf0e60b18b9d8599'
output=evidence/f'timing-{a.candidate[:7]}.json'
provenance=evidence/f'timing-provenance-{a.candidate[:7]}.json'
events=evidence/f'compiler-events-{a.candidate[:7]}.jsonl'
assert not any(p.exists() for p in [output,provenance,events]),'Preserve every previous attempt'
verification=evidence/f'verification-{a.candidate[:7]}.json'
admission=evidence/f'review-admission-{a.candidate[:7]}.json'
v=json.loads(verification.read_text());r=json.loads(admission.read_text())
assert v['candidate']==a.candidate and v['status']=='passed'
assert r['candidate']==a.candidate and r['admitted_for_timing']
def sha(data):return hashlib.sha256(data).hexdigest()
def git(*args):return subprocess.check_output(['git','-C',str(repo),*args])
assert git('show',f'{a.candidate}:experiments/swift/compare_optimizations.py')==git('show',f'{control}:experiments/swift/compare_optimizations.py')
assert (root/'compare_optimizations.py').read_bytes()==git('show',f'{control}:experiments/swift/compare_optimizations.py')
assert git('show',f'{a.candidate}:experiments/swift/PrimeSieve.swift')==(root/'PrimeSieve.swift').read_bytes()
record={'candidate':a.candidate,'control':control,'status':'running','started_at_utc':utc(),
        'verification_sha256':sha(verification.read_bytes()),'admission_sha256':sha(admission.read_bytes()),
        'timing_script_sha256':sha(Path(__file__).read_bytes()),
        'compare_script_sha256':sha((root/'compare_optimizations.py').read_bytes())}
try:
    record['before']=snapshot();check_conditions(record['before'])
    with TimingLock('Codex vector recurrence65-111 vs adopted111: one session, three rotated5s trials each '+a.candidate):
        compiler=shutil.which('swiftc');assert compiler
        shimdir=root/'.build'/f'compiler-recorder-{a.candidate[:7]}'
        shimdir.mkdir(parents=True,exist_ok=False)
        # The recorder forwards all arguments unchanged to the real compiler.
        # It affects compile-time accounting only; benchmark binaries run directly.
        shim=shimdir/'swiftc'
        shimtext='#!'+sys.executable+'\n'+'''import json,subprocess,sys,time
from datetime import datetime,timezone
compiler=COMPILER
events=EVENTS
args=[compiler,*sys.argv[1:]]
start=time.monotonic();stamp=datetime.now(timezone.utc).isoformat()
result=subprocess.run(args)
entry={'command':args,'started_at_utc':stamp,'duration_seconds':time.monotonic()-start,'exit_code':result.returncode}
with open(events,'a') as output:output.write(json.dumps(entry)+'\\n')
sys.exit(result.returncode if result.returncode>=0 else 128-result.returncode)
'''.replace('COMPILER',repr(compiler)).replace('EVENTS',repr(str(events)))
        shim.write_text(shimtext);shim.chmod(0o755)
        record['compiler_recorder_source']=shimtext
        record['compiler_recorder_sha256']=sha(shim.read_bytes())
        record['real_compiler']=compiler
        args=['env','PATH='+str(shimdir)+os.pathsep+os.environ['PATH'],sys.executable,str(root/'compare_optimizations.py'),
              '--repo',str(repo),'--variant','control-111='+control,
              '--variant','vector-recurrence='+a.candidate,'--output',str(output)]
        record['command']=run(args,root);assert record['command']['exit_code']==0
        result=json.loads(output.read_text())
        record['raw_timing_sha256']=sha(output.read_bytes())
        assert result['flags']==['-O','-whole-module-optimization']
        assert result['harness_revision']==v['harness']
        assert result['runner_sha256']==v['runner_sha256'] and result['observer_sha256']==v['observer_sha256']
        admitted_version=v['commands'][0]['combined_stdout_stderr']
        admitted_version=admitted_version[admitted_version.index('Apple Swift version'):].strip()
        assert result['swift_version'].strip()==admitted_version
        assert result['cpu']=='Apple M4 Pro' and result['machine']=='arm64'
        assert set(result['variants'])=={'control-111','vector-recurrence'}
        assert result['variants']['control-111']['revision']==control
        assert result['variants']['vector-recurrence']['revision']==a.candidate
        assert result['run_order']==[['control-111','vector-recurrence'],['vector-recurrence','control-111'],['control-111','vector-recurrence']]
        assert set(result['samples'])==set(result['variants'])
        for name,samples in result['samples'].items():
            assert len(samples)==3
            for sample in samples:
                assert sample['passes']>0 and math.isfinite(sample['seconds']) and sample['seconds']>=5
                assert sample['threads']==1 and sample['tags']=='algorithm=base,faithful=yes,bits=1'
                assert sample['validation'].startswith('Validated: 78498 primes;')
                assert math.isfinite(sample['milliseconds_per_pass'])
                assert sample['milliseconds_per_pass']==1000*sample['seconds']/sample['passes']
            assert result['median_ms'][name]==statistics.median(s['milliseconds_per_pass'] for s in samples)
        assert result['variants']['vector-recurrence']['source_sha256']==v['candidate_source_sha256']
        assert result['variants']['control-111']['source_sha256']==v['control_source_sha256']
        record['binary_sha256']={name:sha((root/'.build/optimization-comparison'/name/'benchmark').read_bytes()) for name in result['variants']}
        compiles=[json.loads(line) for line in events.read_text().splitlines()]
        assert all(x['exit_code']==0 for x in compiles)
        for name in result['variants']:
            target=str(root/'.build/optimization-comparison'/name/'benchmark')
            builds=[x for x in compiles if len(x['command'])>2 and x['command'][-2:]==['-o',target]]
            assert len(builds)==1
            assert '-O' in builds[0]['command'] and '-whole-module-optimization' in builds[0]['command']
        record['compiler_events_sha256']=sha(events.read_bytes())
        record['after_trials_under_lock']=snapshot();check_conditions(record['after_trials_under_lock'])
        record['status']='passed'
except BaseException as error:
    record['status']='failed';record['error']=f'{type(error).__name__}: {error}';raise
finally:
    record['after']=snapshot();record['finished_at_utc']=utc();record['lock_absent_after']=not TimingLock.path.exists()
    provenance.write_text(json.dumps(record,indent=2)+'\n')
