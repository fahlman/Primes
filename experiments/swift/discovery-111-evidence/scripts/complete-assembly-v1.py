"""Complete the interrupted assembly stage, then run the single admitted session.

run.py and its failed verify.json remain immutable. All six correctness checks
completed before its label-only harness assertion failed; none is repeated here.
"""
from pathlib import Path
import hashlib,json,shutil,subprocess,sys
sys.path.insert(0,str(Path(__file__).resolve().parent.parent))
from primes_run_support import TimingLock,check_conditions,run,sha,snapshot,utc
repo=Path('/Users/ryan/Developer/Primes-discovery-bound-111')
pkg=repo/'experiments/swift';out=pkg/'discovery-111-evidence'
source='968c249b7bc61bad48dd39bcfdc4a325b71c1905'
control='6f989eeb17b4826d43925efe6fa7a0e178efcc76'
harness='25402d46ba991b39451724d3873d326626981e3f'
mode=sys.argv[1];assert mode in ['assembly','timing'] and len(sys.argv)==2
def gitfile(rev,f):return subprocess.check_output(['git','show',rev+':experiments/swift/'+f],cwd=repo)
assert subprocess.check_output(['git','rev-parse','HEAD'],cwd=repo,text=True).strip()==source
verified=json.loads((out/'verify.json').read_text())
assert verified['candidate']==source and verified['status']=='failed_or_requires_condition_review'
assert verified['error']=='AssertionError: ' and verified['lock_absent_after']
assert verified['wrapper_sha256']==sha(Path(__file__).with_name('run.py'))
assert verified['support_sha256']==sha(Path(__file__).resolve().parent.parent/'primes_run_support.py')
assert len(verified['commands'])==14
assert all(c['exit_code']==0 and 'error' not in c for c in verified['commands'])
check_conditions(verified['before']);check_conditions(verified['after'])
expected=[['swiftc','--version'],['swift','tools/generate-dense-128.swift','--check','PrimeSieve.swift']]
b=pkg/'.build/discovery-111-verification'
for suffix,flags in [('asan',['-O','-sanitize=address']),('wmo',['-O','-whole-module-optimization'])]:
 for name,sources in [('verify',['Verify.swift']),('extra-verify',['ExtraVerify.swift']),('phase-verify',['tools/phase-split/PhaseSieve.swift','tools/phase-split/PhaseVerify.swift'])]:
  binary=str(b/(name+'-'+suffix))
  expected.extend([['swiftc',*flags,'PrimeSieve.swift',*sources,'-o',binary],[binary]])
assert [c['command'] for c in verified['commands']]==expected
files=list(verified['source_sha256'])
for f in files:
 assert (pkg/f).read_bytes()==gitfile(source,f),f
 assert sha(pkg/f)==verified['source_sha256'][f],f
 if f!='PrimeSieve.swift':assert (pkg/f).read_bytes()==gitfile(control,f),f
assert gitfile(source,'BenchmarkObserver.swift')==gitfile(harness,'BenchmarkObserver.swift')
frozen=gitfile(harness,'Benchmark.swift')
assert frozen.count(b'fahlman_swift_striped_unrolled')==1
assert gitfile(source,'Benchmark.swift')==frozen.replace(b'fahlman_swift_striped_unrolled',b'fahlman_swift_dense_striped')
record=out/(mode+'.json');assert not record.exists()
entry={'mode':mode,'candidate':source,'control':control,'harness_revision':harness,'started_at_utc':utc(),'wrapper_sha256':sha(__file__),'support_sha256':verified['support_sha256'],'source_sha256':verified['source_sha256'],'original_verification_sha256':sha(out/'verify.json'),'completed_correctness_commands':14,'commands':[],'conditions_scope':'Before/after snapshots, not continuous monitoring','recovery':'All six checks and generator passed; original wrapper stopped before assembly because current runner output label differs from frozen. Original failed record preserved. No completed checks repeated. Assembly uses the frozen runner; timing uses the unchanged comparison script.','admission':'Every candidate trial must beat every control trial; one three-round rotated session; no automatic extra trials or merge.'}
if mode=='timing':
 assembly=json.loads((out/'assembly.json').read_text());review=json.loads((out/'review.json').read_text())
 assert assembly['status']=='passed' and assembly['candidate']==source and assembly['source_sha256']==entry['source_sha256']
 assert assembly['original_verification_sha256']==sha(out/'verify.json')
 assert assembly['assembly_sha256']==sha(out/'PrimeSwift.s')
 assert review['candidate']==source and review['status']=='admitted' and not review['blocking_findings']
 assert review['pr_comment'].startswith('https://github.com/fahlman/Primes/pull/18#')
 entry.update(assembly_record_sha256=sha(out/'assembly.json'),review_sha256=sha(out/'review.json'))
def save():record.write_text(json.dumps(entry,indent=2)+'\n')
def command(args):
 r=run([str(x) for x in args],pkg);entry['commands'].append(r);save()
 assert r['exit_code']==0 and 'error' not in r,args
 return r
try:
 with TimingLock('Codex PR18 cutoff111 '+mode+': exclusive serial work; unique outputs.'):
  entry['before']=snapshot();save();check_conditions(entry['before'])
  try:
   v=command(['swiftc','--version'])['combined_stdout_stderr']
   assert 'Swift version 6.3.3' in v and 'arm64-apple-macosx' in v
   assert subprocess.check_output(['sysctl','-n','machdep.cpu.brand_string'],text=True).strip()=='Apple M4 Pro'
   if mode=='assembly':
    frozen_path=b/'FrozenBenchmark.swift';assert not frozen_path.exists();frozen_path.write_bytes(frozen)
    entry['assembly_runner_sha256']=sha(frozen_path)
    command(['swiftc','-O','-parse-as-library','-module-name','BenchmarkObserver','-emit-module','-emit-module-path',b/'BenchmarkObserver.swiftmodule','-emit-object','BenchmarkObserver.swift','-o',b/'BenchmarkObserver.o'])
    command(['swiftc','-O','-whole-module-optimization','-I',b,'PrimeSieve.swift',frozen_path,'-S','-o',b/'PrimeSwift.s'])
    shutil.copyfile(b/'PrimeSwift.s',out/'PrimeSwift.s');entry['assembly_sha256']=sha(out/'PrimeSwift.s')
   else:
    result=pkg/'discovery-111-results-968c249.json';assert not result.exists()
    command([sys.executable,'-u','compare_optimizations.py','--variant','control111='+control,'--variant','discovery111='+source,'--output',result])
    entry['result_file']=result.name;entry['result_sha256']=sha(result)
    entry['binary_sha256']={name:sha(pkg/'.build/optimization-comparison'/name/'benchmark') for name in ['control111','discovery111']}
   assert entry['source_sha256']=={f:sha(pkg/f) for f in files}
   assert entry['wrapper_sha256']==sha(__file__)
   entry['status']='passed'
  finally:
   entry['after']=snapshot();save();check_conditions(entry['after'])
except BaseException as error:
 entry.update(status='failed_or_requires_condition_review',error=type(error).__name__+': '+str(error));raise
finally:
 entry.update(finished_at_utc=utc(),lock_absent_after=not TimingLock.path.exists());save()
