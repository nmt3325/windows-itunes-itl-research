"""Single-process fixed-seed bounded corpus, not a general safety proof.
No native operations, imports of music, networking, source changes or new dependencies.
"""
from pathlib import Path
from datetime import datetime, timezone
from ctypes import wintypes as w
from unittest.mock import patch
import argparse, base64, collections, copy, ctypes, hashlib, json, random, sys, time, traceback, zlib
from Crypto.Cipher import AES
ROOT=Path(r'<CI_TEMP_WIN>\<CI_BROKER>\WINDOWS_RESEARCH_RUN\work\itl')
OUT=ROOT/'reports/identities/phase2-fuzz'; SOURCE=OUT/'source'
SHA='56069f1e2a17d9aea62c1d753b2bd93ed404a000'; SEED=0x20260909
CAP=4*1024*1024; MEMORY=512*1024*1024; MAX_BATCH_SECONDS=100
assert Path.cwd()==ROOT/'wt/identities' and sys.dont_write_bytecode
sys.path.insert(0,str(SOURCE))
import itlkit
from itlkit import Library, Container
from itlkit.model import Node
from itlkit.errors import ITLError
import itlkit.io as io
from itlkit.atoms import assert_pool_bindings
assert Path(itlkit.__file__).resolve().is_relative_to(SOURCE.resolve())
sys.path.insert(0,str(ROOT/'reports/identities/scripts'))
import audit_identities as independent
independent.MAX_FILE=CAP; independent.MAX_PAYLOAD=CAP  # in-memory audit cap; old files unchanged

def digest(b): return hashlib.sha256(b).hexdigest()
def read_json(p): return json.loads(p.read_text(encoding='utf-8-sig'))
def save(name,data):
 p=(OUT/name).resolve(); assert p.is_relative_to(OUT.resolve())
 p.parent.mkdir(parents=True,exist_ok=True)
 with p.open('x',encoding='utf-8',newline='\n') as f: json.dump(data,f,ensure_ascii=False,indent=2); f.write('\n')
def preserved():
 return all(Path(x['path']).is_file() and digest(Path(x['path']).read_bytes())==x['sha256'] for x in read_json(OUT/'prior-artifacts.json'))
class PMC(ctypes.Structure):
 _fields_=[('cb',w.DWORD),('PageFaultCount',w.DWORD)]+[(n,ctypes.c_size_t) for n in ('PeakWorkingSetSize','WorkingSetSize','QuotaPeakPagedPoolUsage','QuotaPagedPoolUsage','QuotaPeakNonPagedPoolUsage','QuotaNonPagedPoolUsage','PagefileUsage','PeakPagefileUsage','PrivateUsage')]
ctypes.windll.kernel32.GetCurrentProcess.restype=w.HANDLE
ctypes.windll.psapi.GetProcessMemoryInfo.argtypes=[w.HANDLE,ctypes.POINTER(PMC),w.DWORD]
def memory():
 m=PMC(); m.cb=ctypes.sizeof(m)
 if not ctypes.windll.psapi.GetProcessMemoryInfo(ctypes.windll.kernel32.GetCurrentProcess(),ctypes.byref(m),m.cb): raise OSError('self memory probe failed')
 return {'peak_working_set_bytes':m.PeakWorkingSetSize,'peak_pagefile_bytes':m.PeakPagefileUsage,'private_bytes':m.PrivateUsage}
raw={k:independent.pinned(*v) for k,v in independent.PINS.items()}
assert preserved()
controls={k:Library.from_bytes(v,max_plain_bytes=CAP) for k,v in raw.items()}
census={k:independent.census_bytes(v,k) for k,v in raw.items()}
header,payload,_=independent.decode(raw['synthetic003'])
json_baseline=controls['synthetic003'].to_dict()
assert len(json.dumps(json_baseline).encode())<CAP
source_pins=[{'path':str(p.relative_to(OUT)).replace('\\','/'),'sha256':digest(p.read_bytes()),'bytes':p.stat().st_size,'git_blob_sha1':hashlib.sha1(b'blob '+str(p.stat().st_size).encode()+b'\0'+p.read_bytes()).hexdigest()} for p in sorted(SOURCE.rglob('*')) if p.is_file()]
for x in source_pins: assert x['git_blob_sha1'] in (OUT/'source-git-tree.txt').read_text(encoding='utf-8-sig'),x['path']

def pack(h,p,compression=1,encryption=2,cap=102400):
 assert len(p)<=CAP
 h=bytearray(h); h[0x41]=encryption; h[0x43]=compression; h[0x5c:0x60]=cap.to_bytes(4,'big')
 b=zlib.compress(p,1) if compression else bytes(p)
 n=(0 if encryption==0 else len(b) if encryption==1 else min(len(b),cap))//16*16
 if n: b=AES.new(b'BHUILuilfghuila3',AES.MODE_ECB).encrypt(b[:n])+b[n:]
 h[8:12]=(len(h)+len(b)).to_bytes(4,'big')
 assert len(h)+len(b)<=CAP
 return bytes(h)+b

def evaluate_binary(data,layer='library',limit=CAP,must_refuse=False):
 assert len(data)<=CAP and 1<=limit<=CAP
 start=time.perf_counter()
 try:
  co=Container.from_bytes(data,max_plain_bytes=limit)
  if layer=='container':
   assert co.to_bytes()==data, 'container no-op not byte exact'
   if must_refuse: raise AssertionError('boundary expected refusal but accepted')
   return {'outcome':'accepted','noop_exact':True,'scope':'opaque container','plain_bytes':len(co.payload)}
  lib=Library(co)  # already explicitly bounded decode, avoids a second unbounded ingress
  out=lib.to_bytes()
  assert out==data, 'Library no-op not byte exact'
  if must_refuse: raise AssertionError('known invalid frame/identity was accepted')
  supported=[]; observational=[]; oracle_unavailable=None
  try:
   c=independent.census_bytes(data)
   for e in c['checks']['errors']:
    if e['code'] in ('identity_nonzero_unique','dangling_object_reference','item_identity_nonzero_unique','dangling_track_reference','declared_count'): supported.append(e)
    else: observational.append(e['code'])
  except (independent.Refusal, UnicodeError) as ex: oracle_unavailable=str(ex)
  assert not supported, 'supported invariant failure: '+repr(supported)
  return {'outcome':'accepted','noop_exact':True,'supported_invariants_checked':oracle_unavailable is None,'independent_oracle_unavailable':oracle_unavailable,'observational_outside_core_read_contract':observational,'plain_bytes':len(co.payload)}
 except (ITLError,ValueError) as ex:
  return {'outcome':'refused','exception':type(ex).__name__,'message':str(ex)[:600]}

# Each case is independently seeded. The case index suffices to replay its exact recipe.
plan=[]
for label in raw: plan.append({'family':'control','label':label,'ordinal':0})
for family,n in [('container',128),('frame',128),('identity_ref',96),('json',64),('atomic',48),('boundary',32)]:
 for j in range(n): plan.append({'family':family,'label':('synthetic003','synthetic037','donor032_reloaded')[j%3],'ordinal':j})
assert len(plan)<=2000

KNOWN_JSON_EXCEPTIONS=(ITLError,ValueError,TypeError,KeyError)
def run_case(spec,index):
 rng=random.Random(SEED+index); family=spec['family']; j=spec['ordinal']; label=spec['label']; data=raw[label]
 recipe={'family':family,'label':label,'ordinal':j,'case_seed':SEED+index,'source_sha256':digest(data)}
 if family=='control': return recipe,evaluate_binary(data)
 if family=='container':
  b=bytearray(data); typ=j%4
  if typ==0:
   off=rng.randrange(len(b)); mask=1<<rng.randrange(8); b[off]^=mask; recipe.update(operation='xor_byte',offset=off,mask=mask)
  elif typ==1:
   length=rng.choice([0,1,4,8,95,96,143,144,len(b)-1,rng.randrange(len(b))]); b=b[:length]; recipe.update(operation='truncate',length=length)
  elif typ==2:
   off=rng.choice([4,8,0x30,0x44,0x48,0x4c,0x54,0x5c]); value=rng.choice([0,1,15,16,95,96,143,144,0xffffffff]); b[off:off+4]=value.to_bytes(4,'big'); recipe.update(operation='outer_u32',offset=off,value=value)
  else:
   off=rng.choice([0x41,0x43,0x52]); value=rng.choice([0,1,2,3,127,255]); b[off]=value; recipe.update(operation='outer_byte',offset=off,value=value)
  return recipe,evaluate_binary(bytes(b),'container' if j%2==0 else 'library')
 if family=='frame':
  h,p,_=independent.decode(data); p=bytearray(p); lib=controls[label]
  nodes=[n for s in lib.sections for n in s.walk()]
  n=rng.choice(nodes); field=rng.choice([0,4,8,12]); at=n.offset+field
  if field==0: value=rng.choice([b'XXXX',b'msdh',b'mith',b'mhoh']); p[at:at+4]=value; recipe.update(operation='tag',offset=at,new_hex=value.hex())
  else:
   value=rng.choice([0,1,11,12,15,16,len(n.header)-1,len(n.header),len(p)+1,0x7fffffff,0xffffffff]); p[at:at+4]=value.to_bytes(4,'little'); recipe.update(operation='payload_u32',offset=at,value=value)
  b=pack(h,p); recipe['candidate_sha256']=digest(b)
  return recipe,evaluate_binary(b)
 if family=='identity_ref':
  h,p,_=independent.decode(data); p=bytearray(p); c=census[label]; tracks=c['tracks']; t=tracks[j%len(tracks)]; other=tracks[(j+1)%len(tracks)]; cat=j%8
  if cat==0: at=t['offset']+16; size=4; value=0
  elif cat==1: at=t['offset']+16; size=4; value=other['local_id']
  elif cat==2: at=t['offset']+0x80; size=8; value=int(other['persistent_id'],16)
  elif cat==3: at=t['offset']+0x1f4; size=4; value=other['secondary_id']
  elif cat==4: at=t['offset']+0xdc; size=4; value=376
  elif cat==5: at=t['offset']+0x1e0; size=4; value=376
  elif cat==6:
   item=next(p0 for p0 in c['playlists'] if p0['is_master'])['items'][0]; at=item['offset']+24; size=4; value=376
  else:
   obj=c['albums'][j%len(c['albums'])]; at=obj['offset']+20; size=8; value=0
  before=bytes(p[at:at+size]); p[at:at+size]=value.to_bytes(size,'little'); b=pack(h,p)
  recipe.update(operation='identity_u32_or_u64',offset=at,width=size,before_hex=before.hex(),after_hex=p[at:at+size].hex(),candidate_sha256=digest(b))
  return recipe,evaluate_binary(b,must_refuse=True)
 if family=='boundary':
  limit=[1,15,16,4096,65536,131072,262144,1048576][j%8]
  delta=[-1,0,1,131072][j//8]; length=max(0,min(CAP-144,limit+delta)); p=b'Z'*length
  b=pack(header,p,compression=1 if j%2 else 0,encryption=0,cap=0)
  recipe.update(operation='bounded_expansion',max_plain_bytes=limit,actual_plain_bytes=length,compression=bool(j%2),input_sha256=digest(b))
  return recipe,evaluate_binary(b,'container',limit,must_refuse=length>limit)
 if family=='json':
  v=copy.deepcopy(json_baseline); mode=j%12; recipe['mutation']=mode
  # original_file_b64 is fixed prevalidated synthetic003, never a hostile compressed stream.
  if mode==0: v['schema']=rng.choice([None,0,'unknown'])
  elif mode==1: v['operations']=rng.choice([None,{},'not a list',1])
  elif mode==2: v['operations']=[{'op':'unknown-'+str(j)}]
  elif mode==3: v['container']['original_sha256']='0'*64
  elif mode==4: v['container']['payload_hex']='zz'
  elif mode==5: v['container']['original_file_b64']='!invalid!'
  elif mode==6: v['sections'][0]['kind']='unknown'
  elif mode==7: v['sections'][0]['header_hex']='0'
  elif mode==8: v['sections'][0]['children']=[None]
  elif mode==9: v['operations']=[{'op':'set_track','track_id':True,'fields':{'rating':50}}]
  elif mode==10:
   node={'kind':'total','header_hex':'6d697468100000001000000000000000','children':[]}
   for _ in range(34): node={'kind':'total','header_hex':'6d697468100000001000000001000000','children':[node]}
   v['sections'][0]=node
  else: v['operations']=[]
  serialized=json.dumps(v,ensure_ascii=True).encode(); assert len(serialized)<=CAP
  recipe['json_sha256']=digest(serialized); recipe['max_bytes']=len(serialized)
  try:
   lib=Library.from_dict(v); out=lib.to_bytes(); check=Library.from_bytes(out,max_plain_bytes=CAP)
   assert check.to_bytes()==out
   assert out==raw['synthetic003'], 'unexpected JSON non-noop acceptance'
   return recipe,{'outcome':'accepted','noop_exact':True,'scope':'small JSON with prevalidated original baseline'}
  except KNOWN_JSON_EXCEPTIONS as ex: return recipe,{'outcome':'refused','exception':type(ex).__name__,'message':str(ex)[:600]}
 if family=='atomic':
  lib=Library.from_bytes(raw['synthetic003'],max_plain_bytes=CAP); before=lib.to_bytes(); target=OUT/'tmp'/f'target-{index}.bin'; sentinel=rng.randbytes(31+j)
  mode=j%6; recipe.update(mode=mode,target=str(target.relative_to(OUT)),sentinel_sha256=digest(sentinel))
  if mode in (0,1):
   with target.open('xb') as f: f.write(sentinel)
   refused=False
   try:
    if mode==0: lib.write(target)
    else: io.write_new(target,rng.randbytes(j+8))
   except FileExistsError: refused=True
   assert refused and target.read_bytes()==sentinel
   return recipe,{'outcome':'refused','exception':'FileExistsError','existing_target_unchanged':True}
  if mode in (2,3):
   refused=False
   def short_write(stream,bytes0): stream.write(bytes0[:7]); raise OSError('injected short-write failure')
   hook=patch.object(io,'_write_payload',side_effect=short_write) if mode==2 else patch.object(io.os,'link',side_effect=OSError('injected precommit link failure'))
   try:
    with hook: io.write_new(target,sentinel)
   except OSError: refused=True
   assert refused and not target.exists() and not list(target.parent.glob('.'+target.name+'.itlkit-*'))
   return recipe,{'outcome':'refused','exception':'OSError','fault_injection':True,'absent_target_remains_absent':True,'sibling_temp_cleaned':True}
  if mode==4:
   operations=[{'op':'set_track','track_id':lib.tracks[0].track_id,'fields':{'rating':j+1}},{'op':'unsupported-after-first-change'}]
   refused=False
   try: lib.apply_operations(operations)
   except (ITLError,ValueError): refused=True
   assert refused and lib.to_bytes()==before
   return recipe,{'outcome':'refused','memory_transaction_unchanged':True,'operations':operations}
  io.write_new(target,sentinel)
  assert target.read_bytes()==sentinel and not list(target.parent.glob('.'+target.name+'.itlkit-*'))
  return recipe,{'outcome':'accepted','new_target_complete':True,'sibling_temp_cleaned':True}
 raise AssertionError('unknown family')

def main():
 ap=argparse.ArgumentParser(); ap.add_argument('--replay',type=int); args=ap.parse_args()
 if args.replay is not None:
  assert 0<=args.replay<len(plan)
  print(json.dumps(run_case(plan[args.replay],args.replay),ensure_ascii=False)); return
 save('source-input-manifest.json',{'commit_sha':SHA,'archive_sha256':digest((OUT/'source-target.zip').read_bytes()),'source_files':source_pins,'input_files':[{'label':k,'path':str(ROOT/p),'sha256':h,'bytes':len(raw[k])} for k,(p,h) in independent.PINS.items()],'prior_report_sha256':digest((ROOT/'reports/identities/report.json').read_bytes()),'independent_checker_sha256':digest((ROOT/'reports/identities/scripts/audit_identities.py').read_bytes()),'harness_sha256':digest(Path(__file__).read_bytes())})
 save('case-plan.json',{'seed':SEED,'seed_hex':hex(SEED),'planned_cases':len(plan),'cases':plan})
 start=time.perf_counter(); outcomes=[]; anomalies=[]; stop_reason=None
 logpath=OUT/'logs/cases.jsonl'
 with logpath.open('x',encoding='utf-8') as log:
  for i,spec in enumerate(plan):
   if time.perf_counter()-start>MAX_BATCH_SECONDS: stop_reason='100-second harness batch budget'; break
   tick=time.perf_counter(); recipe={'family':spec['family'],'label':spec['label'],'ordinal':spec['ordinal'],'case_seed':SEED+i}
   try:
    recipe,result=run_case(spec,i)
   except Exception as ex:
    result={'outcome':'anomaly','exception':type(ex).__name__,'message':str(ex)[:1000],'traceback':traceback.format_exc(limit=6)}
    anomalies.append({'case_index':i,'spec':spec,'recipe':recipe,'result':result})
    # Each retained witness is already one case / one mutation field, not global minimization.
    if len(anomalies)<=12: save(f'repros/case-{i:04d}.json',anomalies[-1])
   record={'case_index':i,'spec':spec,'recipe':recipe,'result':result,'elapsed_ms':round((time.perf_counter()-tick)*1000,4)}
   outcomes.append(record); log.write(json.dumps(record,ensure_ascii=False)+'\n'); log.flush()
   m=memory()
   if max(m['peak_working_set_bytes'],m['peak_pagefile_bytes'])>=MEMORY: stop_reason='memory cap'; break
 family={f:dict(collections.Counter(o['result']['outcome'] for o in outcomes if o['spec']['family']==f)) for f in sorted({o['spec']['family'] for o in outcomes})}
 snapshot_ok=all(digest((ROOT/p).read_bytes())==h for p,h in independent.PINS.values())
 old_ok=preserved(); src_ok=all(digest((OUT/x['path']).read_bytes())==x['sha256'] for x in source_pins)
 elapsed=time.perf_counter()-start; disk=sum(p.stat().st_size for p in OUT.rglob('*') if p.is_file())
 status='completed_selected_corpus' if not stop_reason and len(outcomes)==len(plan) else 'bounded_partial'
 report={'task':'independent bounded fuzz of selected synthetic ITL corpus','status':status,'target_commit':SHA,'seed':SEED,'seed_hex':hex(SEED),'planned':len(plan),'actually_executed':len(outcomes),'unexecuted':len(plan)-len(outcomes),'by_family':family,'accepted':sum(o['result']['outcome']=='accepted' for o in outcomes),'refused':sum(o['result']['outcome']=='refused' for o in outcomes),'anomalies':anomalies,'anomaly_count':len(anomalies),'elapsed_seconds':elapsed,'max_case_ms':max((o['elapsed_ms'] for o in outcomes),default=0),'stop_reason':stop_reason,'resource_limits':{'max_input_or_plain_bytes':CAP,'batch_harness_seconds':MAX_BATCH_SECONDS,'executor_timeout_seconds':120,'processes':1,'working_data_cap_bytes':MEMORY},'resources':{**memory(),'own_phase_disk_bytes':disk,'measurement':'Windows GetProcessMemoryInfo of current Python only; OS peak working set and peak pagefile/private metrics after every executed case, disk sum at close; not whole-environment memory'},'preservation':{'old_identity_artifacts_unchanged':old_ok,'all7_input_hashes_unchanged':snapshot_ok,'exported_source_unchanged':src_ok},'native_operations':0,'import_music_operations':0,'source_import_path':str(Path(itlkit.__file__).resolve()),'json_budget_scope':'Library.from_dict has no max_plain_bytes parameter. JSON tests use only prevalidated tiny original baselines or invalid non-decompressible base64; no adversarial compressed original is passed through that unbounded signature. All hostile expansion tests enter Container.from_bytes with explicit max_plain_bytes. Internal self-redecode only sees already bounded generated bytes.','limits':['Not a proof of general parser safety or native acceptance.','One deterministic selected corpus/batch; no parallel, repeated native, music import, COM or UI tests.','No coverage-guided fuzzing, process crash/power loss, symlink race or hostile-directory claims.','Independent oracle scope unavailable on unsupported layouts is recorded, not counted as invariant verification.','Counterexamples are single-case/field repros, not globally minimized across all bytes.'],'reproduction':'Use --replay INDEX from the same cwd; binary/JSON cases are read-only; atomic cases must use a fresh own temp output prefix to avoid overwriting earlier evidence.','setup_errors':[{'command_id':'5c781ae199584fec','exit_code':1,'reason':'optional README.md absent; zero-byte failed archive retained; corrected archive includes only verified existing paths'}],'completed_at_utc':datetime.now(timezone.utc).isoformat()}
 assert snapshot_ok and old_ok and src_ok and disk<MEMORY
 save('report.json',report)
 print(json.dumps({k:report[k] for k in ('status','planned','actually_executed','unexecuted','by_family','anomaly_count','elapsed_seconds','max_case_ms','resources','preservation','completed_at_utc')},ensure_ascii=False,indent=2))
 if anomalies: print('ANOMALIES_RECORDED_NOT_MISCOUNTED_AS_PASSES')

if __name__=='__main__': main()
