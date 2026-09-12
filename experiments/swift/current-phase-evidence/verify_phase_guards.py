from pathlib import Path
import hashlib, json, subprocess, sys
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from primes_run_support import TimingLock, run, utc

root = Path('/Users/ryan/Developer/Primes-current-phase-tools/experiments/swift')
build = root/'.build/phase-0c605a4'
evidence = root/'current-phase-evidence'
record_path = evidence/'guard-checks-0c605a4.json'
assert not record_path.exists()
assert json.loads((evidence/'verification-0c605a4.json').read_text())['status'] == 'passed'
assert subprocess.check_output(['git','rev-parse','HEAD'],cwd=root,text=True).strip() == '0c605a4d6d74a4f7515612035c1fdb51749fd0ca'
record = {'candidate':'0c605a4d6d74a4f7515612035c1fdb51749fd0ca', 'status':'running', 'started_at_utc':utc(), 'commands':[], 'timed_trials':0}
def checked(args):
    result=run(list(map(str,args)),root)
    record['commands'].append(result)
    assert result['exit_code']==1
    return result['combined_stdout_stderr']
def hashes(folder):
    return {str(p.relative_to(folder)):hashlib.sha256(p.read_bytes()).hexdigest() for p in folder.rglob('*') if p.is_file()}
try:
    with TimingLock('Codex phase tools remaining ambiguous-anchor and overwrite guards 0c605a4'):
        source=(root/'PrimeSieve.swift').read_bytes()
        ambiguous=build/'ambiguous-source.swift'
        ambiguous.write_bytes(source+b'\n// final class PrimeSieve {\n')
        rejected=build/'ambiguous-inputs'
        out=checked([build/'generate-current-phase','--source',ambiguous,'--output',rejected])
        assert 'Expected exactly one supported source anchor' in out and not rejected.exists()
        inputs=build/'inputs';before=hashes(inputs)
        out=checked([build/'generate-current-phase','--source',root/'PrimeSieve.swift','--output',inputs])
        assert 'Refusing' in out and hashes(inputs)==before
        existing=build/'existing-results.json';existing.write_bytes(b'{"sentinel":"preserve"}\n')
        saved=existing.read_bytes()
        out=checked([build/'phase-current','--output',existing])
        assert 'Refusing to overwrite results' in out and 'round 1' not in out and existing.read_bytes()==saved
        out=checked([build/'phase-current','--invalid'])
        assert 'Usage:' in out and 'round 1' not in out
        assert source==(root/'PrimeSieve.swift').read_bytes()
        record['source_and_generated_inputs_unchanged']=True
        record['existing_result_preserved']=True
        record['status']='passed'
except BaseException as error:
    record['status']='failed';record['error']=f'{type(error).__name__}: {error}';raise
finally:
    record['finished_at_utc']=utc();record['lock_absent_after']=not TimingLock.path.exists()
    record_path.write_text(json.dumps(record,indent=2)+'\n')
