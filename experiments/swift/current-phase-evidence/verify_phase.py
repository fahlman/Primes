from pathlib import Path
import hashlib,json,re,subprocess,sys
sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
from primes_run_support import TimingLock,run,snapshot,utc
repo=Path('/Users/ryan/Developer/Primes-current-phase-tools');root=repo/'experiments/swift'
candidate='0c605a4d6d74a4f7515612035c1fdb51749fd0ca'
control='1d0522115846d8c6487d49a9bf0e60b18b9d8599'
build=root/'.build/phase-0c605a4'
evidence=root/'current-phase-evidence';evidence.mkdir(exist_ok=True)
output=evidence/'verification-0c605a4.json';assert not output.exists() and not build.exists()
build.parent.mkdir(exist_ok=True)
record={'candidate':candidate,'control':control,'status':'running','started_at_utc':utc(),'commands':[],'timing_campaign_run':False}
CAPTURE="import subprocess,sys; out=open(sys.argv[1],'wb'); err=open(sys.argv[2],'wb'); p=subprocess.run(sys.argv[3:],stdout=out,stderr=err); sys.exit(p.returncode if p.returncode>=0 else 128-p.returncode)"
def sha(data):return hashlib.sha256(data).hexdigest()
def git(*args):return subprocess.check_output(['git','-C',str(repo),*args])
def save():output.write_text(json.dumps(record,indent=2)+'\n')
def checked(command,expected=0):
    result=run(list(map(str,command)),root);record['commands'].append(result);save()
    assert result['exit_code']==expected,f'Unexpected exit: {command}'
    return result
try:
    assert git('rev-parse','HEAD').decode().strip()==candidate
    assert git('diff','HEAD','--','experiments/swift')==b''
    retained=['PrimeSieve.swift','Benchmark.swift','BenchmarkObserver.swift','tools/phase-split/PhaseSieve.swift','tools/phase-split/PhaseVerify.swift']
    record['retained_source_sha256']={}
    for path in retained:
        data=(root/path).read_bytes();assert data==git('show',f'{control}:experiments/swift/{path}')
        record['retained_source_sha256'][path]=sha(data)
    record['before']=snapshot()
    with TimingLock('Codex current-source phase tools build/correctness/stale-input checks '+candidate):
        checked(['swiftc','--version'])
        checked(['sh','tools/phase-split/build-current.sh',build])
        inputs=build/'inputs';derived=inputs/'CurrentPhaseSieve.swift';identity=inputs/'CurrentPhaseIdentity.swift'
        source=(root/'PrimeSieve.swift').read_bytes();data=derived.read_bytes()
        normalized='\n'.join(data.decode().split('\n')[3:])
        for before,after in [
            ('final class CurrentPhaseSieve {','final class PrimeSieve {'),
            ('    func runSieve(throughFactor cap: Int = .max) {','    func runSieve() {'),
            ('        while p <= limit / p && p <= cap {','        while p <= limit / p {')
        ]:
            assert normalized.count(before)==1;normalized=normalized.replace(before,after)
        assert normalized.encode()==source
        record['reversed_derived_source_byte_identical']=True
        record['source_identity']=json.loads((inputs/'source-identity.json').read_text())
        record['derived_sha256']=sha(data)
        checked([build/'phase-current','--check'])
        asm=evidence/'phase-current-0c605a4.otool.txt';err=evidence/'phase-current-0c605a4.otool.stderr'
        checked([sys.executable,'-c',CAPTURE,asm,err,'otool','-tV',build/'phase-current'])
        record['binary_sha256']=sha((build/'phase-current').read_bytes());record['disassembly_sha256']=sha(asm.read_bytes())
        text=asm.read_text();assert 'BenchmarkObserver7observe' in text
        for name in ['fullPass','derivedFullPass','through499Pass','through251Pass','through111Pass','through63Pass','through3Pass','allocationPass']:
            assert re.search(r'^_\$s\S*'+name+r'\S*:',text,re.M),f'Missing wrapper {name}'
        unexpected=build/'must-not-exist.json'
        try:
            derived.write_bytes(data+b'// stale-input negative check\n')
            result=checked([build/'phase-current','--output',unexpected],expected=1)
            assert 'Source changed since' in result['combined_stdout_stderr']
            assert not unexpected.exists() and 'round 1' not in result['combined_stdout_stderr']
        finally:derived.write_bytes(data)
        assert derived.read_bytes()==data
        # Exercise the production-path guard with a disposable source copy and a
        # tiny guard-only executable; the actual production file never changes.
        copy=build/'production-copy.swift';copy.write_bytes(source)
        copied=build/'copied-inputs'
        checked([build/'generate-current-phase','--source',copy,'--output',copied])
        probe=build/'GuardCheck.swift'
        probe.write_text('@main struct GuardCheck { static func main() { do { try CurrentPhaseBuild.identity.check(); print("Guard passed") } catch { phaseExitWithError(error) } } }\n')
        checked(['swiftc','-O','tools/phase-split/PhaseSourceGuard.swift',copied/'CurrentPhaseIdentity.swift',probe,'-o',build/'guard-check'])
        checked([build/'guard-check'])
        copy.write_bytes(source+b'// production-path negative check\n')
        result=checked([build/'guard-check'],expected=1);assert 'Source changed since' in result['combined_stdout_stderr']
        copy.write_bytes(source)
        # An unsupported production shape must not silently generate a diagnostic.
        unsupported=build/'unsupported.swift';unsupported.write_bytes(source.replace(b'final class PrimeSieve {',b'class PrimeSieve {',1))
        rejected=build/'unsupported-inputs'
        checked([build/'generate-current-phase','--source',unsupported,'--output',rejected],expected=1)
        assert not rejected.exists()
        files=['PrimeSieve.swift',derived,identity,'tools/phase-split/PhaseSourceGuard.swift',
               'tools/phase-split/PhaseSieve.swift','tools/phase-split/CurrentPhaseVerify.swift']
        for config,flags in [('asan',['-sanitize=address']),('wmo',['-whole-module-optimization'])]:
            binary=build/('verify-current-'+config)
            checked(['swiftc','-O',*flags,*files,'-o',binary]);checked([binary])
        checked([build/'phase-current','--check'])
        assert derived.read_bytes()==data
        assert git('rev-parse','HEAD').decode().strip()==candidate
        assert git('diff','HEAD','--','experiments/swift')==b''
        for path in retained: assert sha((root/path).read_bytes())==record['retained_source_sha256'][path]
        record['status']='passed'
except BaseException as error:
    record['status']='failed';record['error']=f'{type(error).__name__}: {error}';raise
finally:
    record['after']=snapshot();record['finished_at_utc']=utc();record['lock_absent_after']=not TimingLock.path.exists();save()
