from pathlib import Path
import hashlib, json, sys
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from primes_run_support import TimingLock, run, snapshot, check_conditions, utc
repo=Path('/Users/ryan/Developer/Primes-marking-helpers');root=repo/'experiments/swift'
evidence=root/'marking-helpers-evidence'
control='1d0522115846d8c6487d49a9bf0e60b18b9d8599'
candidates=[
 ('marking-helpers','06b24cba796ce60fae80e6823d9858ef014f1fe8',evidence),
 ('unified-dense-128','9b2d9cb52aacc8ed69f47a1b1dab7181b85e578d',Path('/Users/ryan/Developer/Primes-unified-dense-128/experiments/swift/unified-dense-128-evidence'))
]
output=evidence/'remaining-refactors-timing.json';provenance=evidence/'remaining-refactors-timing-provenance.json'
assert not output.exists() and not provenance.exists()
record={'control':control,'started_at_utc':utc(),'status':'running','gates':{}}
sources={}
for name,rev,folder in candidates:
    v=folder/f'verification-{rev[:7]}.json';a=folder/f'review-admission-{rev[:7]}.json'
    verify=json.loads(v.read_text());review=json.loads(a.read_text())
    assert verify['status']=='passed' and verify['candidate']==rev
    assert review['candidate']==rev and review['admitted_for_timing']
    sources[name]=verify['candidate_source_sha256']
    record['gates'][name]={'candidate':rev,'verification_sha256':hashlib.sha256(v.read_bytes()).hexdigest(),
                         'review_sha256':hashlib.sha256(a.read_bytes()).hexdigest()}
try:
    record['before']=snapshot();check_conditions(record['before'])
    with TimingLock('Codex remaining refactors: control111, inline helpers, unified128; three rotated5s trials each'):
        args=['python3',str(root/'compare_optimizations.py'),'--repo',str(repo),'--variant','control-111='+control]
        for name,rev,_ in candidates: args+=['--variant',name+'='+rev]
        args+=['--output',str(output)]
        record['command']=run(args,root);assert record['command']['exit_code']==0
        result=json.loads(output.read_text())
        for name,expected in sources.items(): assert result['variants'][name]['source_sha256']==expected
        record['binary_sha256']={name:hashlib.sha256((root/'.build/optimization-comparison'/name/'benchmark').read_bytes()).hexdigest() for name in result['variants']}
        record['status']='passed'
except BaseException as error:
    record['status']='failed';record['error']=f'{type(error).__name__}: {error}';raise
finally:
    record['after']=snapshot();record['finished_at_utc']=utc();record['lock_absent_after']=not TimingLock.path.exists()
    provenance.write_text(json.dumps(record,indent=2)+'\n')
