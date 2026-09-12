from pathlib import Path
import hashlib,json,statistics
pkg=Path('/Users/ryan/Developer/Primes-discovery-bound-111/experiments/swift')
raw=pkg/'discovery-111-results-968c249.json'
x=json.loads(raw.read_text())
out=pkg/'discovery-111-evidence/analysis.json';assert not out.exists()
assert x['run_order']==[['control111','discovery111'],['discovery111','control111'],['control111','discovery111']]
rows={}
for name,samples in x['samples'].items():
 assert len(samples)==3
 for s in samples:
  assert s['passes']>0 and s['seconds']>=5 and s['threads']==1
  assert s['tags']=='algorithm=base,faithful=yes,bits=1'
  assert 'Validated: 78498 primes;' in s['validation']
 values=[1e6*s['seconds']/s['passes'] for s in samples]
 median=statistics.median(values)
 assert abs(median/1000-x['median_ms'][name])<1e-12
 rows[name]={'revision':x['variants'][name]['revision'],'microseconds_per_sieve':values,'median_microseconds':median,'median_sieves_per_second':1e6/median,'minimum_microseconds':min(values),'maximum_microseconds':max(values)}
c=rows['control111'];d=rows['discovery111']
qualifies=d['maximum_microseconds']<c['minimum_microseconds']
all_slower=d['minimum_microseconds']>c['maximum_microseconds']
result={'result_sha256':hashlib.sha256(raw.read_bytes()).hexdigest(),'variants':rows,'throughput_change_percent':100*(c['median_microseconds']/d['median_microseconds']-1),'microseconds_saved':c['median_microseconds']-d['median_microseconds'],'range_gap_microseconds':c['minimum_microseconds']-d['maximum_microseconds'],'qualifies':qualifies,'decision':'qualifies; pending integration decision' if qualifies else ('all trials slower; does not qualify' if all_slower else 'overlapping ranges; flat under agreed admission rule; does not qualify'),'admission_rule':'Maximum candidate microseconds/sieve must be less than minimum control microseconds/sieve; this screen is not a significance test.','run_order':x['run_order']}
out.write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
