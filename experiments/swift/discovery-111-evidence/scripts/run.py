from pathlib import Path
import hashlib,json,os,shutil,subprocess,sys
sys.path.insert(0,str(Path(__file__).resolve().parent.parent))
from primes_run_support import TimingLock,check_conditions,run,sha,snapshot,utc
repo=Path('/Users/ryan/Developer/Primes-discovery-bound-111')
pkg=repo/'experiments/swift'
out=pkg/'discovery-111-evidence'
source='968c249b7bc61bad48dd39bcfdc4a325b71c1905'
control='6f989eeb17b4826d43925efe6fa7a0e178efcc76'
harness='25402d46ba991b39451724d3873d326626981e3f'
mode=sys.argv[1];assert mode in ['verify','timing'] and len(sys.argv)==2
assert subprocess.check_output(['git','rev-parse','HEAD'],cwd=repo,text=True).strip()==source
files=['PrimeSieve.swift','Benchmark.swift','BenchmarkObserver.swift','Verify.swift','ExtraVerify.swift','tools/phase-split/PhaseSieve.swift','tools/phase-split/PhaseVerify.swift','tools/generate-dense-128.swift','Dockerfile','run.sh','compare_optimizations.py']
for f in files:assert (pkg/f).read_bytes()==subprocess.check_output(['git','show',source+':experiments/swift/'+f],cwd=repo),f
out.mkdir(exist_ok=True)
record=out/(mode+'.json');assert not record.exists()
entry={'mode':mode,'candidate':source,'control':control,'harness_revision':harness,'started_at_utc':utc(),'wrapper_sha256':sha(__file__),'support_sha256':sha(Path(__file__).resolve().parent.parent/'primes_run_support.py'),'source_sha256':{f:sha(pkg/f) for f in files},'commands':[],'conditions_scope':'Before/after snapshots, not continuous monitoring','admission':'Every candidate trial must beat every control trial; one three-round rotated session; no automatic extra trials or merge.'}
if mode=='timing':
 verified=json.loads((out/'verify.json').read_text());review=json.loads((out/'review.json').read_text())
 assert verified['status']=='passed' and verified['candidate']==source
 assert review['candidate']==source and review['status']=='admitted' and not review['blocking_findings'] and review['pr_comment'].startswith('https://github.com/fahlman/Primes/pull/18#')
 assert verified['source_sha256']==entry['source_sha256']
 entry.update(verification_sha256=sha(out/'verify.json'),review_sha256=sha(out/'review.json'))

def save():record.write_text(json.dumps(entry,indent=2)+'\n')
def command(args):
 r=run([str(x) for x in args],pkg);entry['commands'].append(r);save()
 assert r['exit_code']==0 and 'error' not in r,args
 return r
try:
 with TimingLock('Codex PR18 cutoff111 '+mode+': exclusive serial validation or one rotated timing session; unique outputs.'):
  entry['before']=snapshot();save();check_conditions(entry['before'])
  try:
   v=command(['swiftc','--version'])['combined_stdout_stderr']
   assert 'Swift version 6.3.3' in v and 'arm64-apple-macosx' in v
   assert subprocess.check_output(['sysctl','-n','machdep.cpu.brand_string'],text=True).strip()=='Apple M4 Pro'
   if mode=='verify':
    b=pkg/'.build/discovery-111-verification';b.mkdir(exist_ok=False,parents=True)
    command(['swift','tools/generate-dense-128.swift','--check','PrimeSieve.swift'])
    for suffix,flags in [('asan',['-O','-sanitize=address']),('wmo',['-O','-whole-module-optimization'])]:
     for name,sources in [('verify',['Verify.swift']),('extra-verify',['ExtraVerify.swift']),('phase-verify',['tools/phase-split/PhaseSieve.swift','tools/phase-split/PhaseVerify.swift'])]:
      binary=b/(name+'-'+suffix)
      command(['swiftc',*flags,'PrimeSieve.swift',*sources,'-o',binary])
      command([binary])
    for f in ['Benchmark.swift','BenchmarkObserver.swift']:
     assert (pkg/f).read_bytes()==subprocess.check_output(['git','show',harness+':experiments/swift/'+f],cwd=repo)
    command(['swiftc','-O','-parse-as-library','-module-name','BenchmarkObserver','-emit-module','-emit-module-path',b/'BenchmarkObserver.swiftmodule','-emit-object','BenchmarkObserver.swift','-o',b/'BenchmarkObserver.o'])
    command(['swiftc','-O','-whole-module-optimization','-I',b,'PrimeSieve.swift','Benchmark.swift','-S','-o',b/'PrimeSwift.s'])
    shutil.copyfile(b/'PrimeSwift.s',out/'PrimeSwift.s')
    entry['assembly_sha256']=sha(out/'PrimeSwift.s')
   else:
    result=pkg/'discovery-111-results-968c249.json';assert not result.exists()
    command([sys.executable,'-u','compare_optimizations.py','--variant','control111='+control,'--variant','discovery111='+source,'--output',result])
    entry['result_file']=result.name;entry['result_sha256']=sha(result)
    entry['binary_sha256']={name:sha(pkg/'.build/optimization-comparison'/name/'benchmark') for name in ['control111','discovery111']}
   assert entry['source_sha256']=={f:sha(pkg/f) for f in files}
   entry['status']='passed'
  finally:
   entry['after']=snapshot();save();check_conditions(entry['after'])
except BaseException as error:
 entry.update(status='failed_or_requires_condition_review',error=type(error).__name__+': '+str(error));raise
finally:
 entry.update(finished_at_utc=utc(),lock_absent_after=not TimingLock.path.exists());save()
