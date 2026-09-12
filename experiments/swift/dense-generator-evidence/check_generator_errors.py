from pathlib import Path
import hashlib, json, subprocess, sys
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from primes_run_support import TimingLock, run, utc
repo = Path('/Users/ryan/Developer/Primes-dense-generator')
root = repo / 'experiments/swift'; build = root / '.build/generator-proof'
evidence = root / 'dense-generator-evidence'
output = evidence / 'verification-9c5d7e5.json'; assert not output.exists()
candidate = '9c5d7e541499294c49b0a256441347555b9410eb'
record = {'candidate':candidate,'started_at_utc':utc(),'commands':[],'status':'running',
          'reused_assembly_proof':'verification-ce33c7d.json: PrimeSieve.swift is unchanged'}
def checked(args, expected=0):
    r=run(['swift', *map(str,args)], root); record['commands'].append(r)
    assert r['exit_code']==expected
    if expected: assert 'Stack dump' not in r['combined_stdout_stderr'] and 'Fatal error' not in r['combined_stdout_stderr']
try:
    assert subprocess.check_output(['git','-C',str(repo),'rev-parse','HEAD'],text=True).strip()==candidate
    source=(root/'PrimeSieve.swift').read_bytes()
    assert source == subprocess.check_output(['git','-C',str(repo),'show','ce33c7d:experiments/swift/PrimeSieve.swift'])
    prior=json.loads((evidence/'verification-ce33c7d.json').read_text()); assert prior['whole_assembly_byte_identical']
    with TimingLock('Codex unified generator concise error-handling verification '+candidate):
        for tool in ['tools/generate-dense.swift','tools/generate-dense-128.swift']:
            checked([tool,'--check','PrimeSieve.swift'])
            for width,old,new in [(64,'first: 1, step: 5','first: 2, step: 5'),(128,'first: 2, step: 65','first: 3, step: 65')]:
                p=build/f'error-{width}.swift';p.write_bytes(source.replace(old.encode(),new.encode(),1))
                checked([tool,'--check',p],1)
                checked([tool,'--write',p]);assert p.read_bytes()==source
        p=build/'missing-final.swift';broken=source.replace(b'        // END GENERATED DENSE 128\n',b'');p.write_bytes(broken)
        checked(['tools/generate-dense.swift','--write',p],1);assert p.read_bytes()==broken
        record['source_sha256']=hashlib.sha256(source).hexdigest();record['status']='passed'
except BaseException as error:
    record['status']='failed';record['error']=f'{type(error).__name__}: {error}';raise
finally:
    record['finished_at_utc']=utc();record['lock_absent_after']=not TimingLock.path.exists()
    output.write_text(json.dumps(record,indent=2)+'\n')
