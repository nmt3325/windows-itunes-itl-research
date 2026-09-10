"""Independent fixed-fixture RED/GREEN probes of production guards. No native calls.
No old 434/48 inputs or test runners are imported or replayed. A plan's raw
projection is an interface serialization, not an independent native golden:
the oracle here is the separately specified one-byte old-record delta.
"""
from pathlib import Path
import argparse,ast,copy,datetime as dt,hashlib,importlib,json,os,sys,traceback,zlib
from unittest.mock import patch

IDS=['EDAD000000000101','EDAD000000000202'];MASTER='EEAA000000000101';FILE='FFAA000000000909'
def sha(b):return hashlib.sha256(b).hexdigest()
def dump(p,v):
 with p.open('x',encoding='utf8',newline='\n') as f:json.dump(v,f,sort_keys=True,indent=2);f.write('\n')
def put(b,o,v,n=4,endian='little'):b[o:o+n]=v.to_bytes(n,endian)
def rec(tag,h,payload=b''):
 b=bytearray(h);b[:4]=tag;put(b,4,h);put(b,8,h+len(payload));return b+payload
def meta(code,value):
 b=bytearray(16)+value.encode('ascii');put(b,0,3);put(b,4,len(value));x=rec(b'mhoh',24,b);put(x,12,code);return x
def library(count=1):
 tracks=[]
 for i in range(count):
  b=rec(b'mith',756,meta(2,'independent-'+str(i)));put(b,12,1);put(b,16,i+1);put(b,0x80,int(IDS[i],16),8);put(b,0xdc,17);put(b,0x1e0,19);b[755]=0x5a;tracks.append(b)
 children=[meta(100,'Independent Library')]
 for i in range(count):
  b=rec(b'mtph',84);put(b,16,100+i);put(b,0x18,i+1);put(b,0x44,10000+i,8);children.append(b)
 pl=rec(b'miph',3500,b''.join(children));put(pl,12,1);put(pl,16,count);put(pl,0x14,0x10000);put(pl,0x1b8,int(MASTER,16),8);put(pl,0xd40,77);pl[3499]=0x6b
 al=rec(b'miah',28);put(al,16,17);put(al,20,1717,8)
 ar=rec(b'miih',28);put(ar,16,19);put(ar,20,1919,8)
 sections=[];offsets={};position=144
 for kind,tag,rows in [(1,b'mlth',tracks),(2,b'mlph',[pl]),(9,b'mlah',[al]),(11,b'mlih',[ar])]:
  ls=rec(tag,20,b''.join(rows));put(ls,8,len(rows));ls[19]=0x7c
  sec=rec(b'msdh',96,ls);put(sec,12,kind);sec[95]=0x8d
  if kind==1:offsets.update(track_tail=position+96+20+755,section_tail=position+95,list_tail=position+96+19,track_count=position+96+20+12,list_count=position+96+8,section_size=position+8)
  if kind==2:offsets.update(playlist_tail=position+96+20+3499,flag_unselected=position+96+20+20,playlist_count=position+96+20+16,playlist_size=position+96+20+8)
  position+=len(sec);sections.append(sec)
 opaque=rec(b'msdh',32,b'NEW-FIX-OPAQUE-14');put(opaque,12,14);sections.append(opaque)
 b=rec(b'hdfm',144,b''.join(sections));put(b,4,144,endian='big');put(b,8,len(b),endian='big');put(b,0x34,int(FILE,16),8,'big');b[0x52]=1;b[0x20]=0x9e
 for o,n in [(0x44,count),(0x48,1),(0x4c,1),(0x54,1)]:put(b,o,n,endian='big')
 offsets.update(envelope_unknown=0x20,outer_count=0x44)
 return bytes(b),offsets
def encode(b,level):
 h=bytearray(b[:144]);body=zlib.compress(b[144:],level);h[0x43]=1;put(h,8,len(h)+len(body),endian='big');return bytes(h)+body
def changed(b,offset):return b[:offset]+bytes([b[offset]^1])+b[offset+1:]

def run(source,out,exe,red,only=None):
 sys.path.insert(0,str(source));g=importlib.import_module('g2_acceptance_guard');prod=importlib.import_module('g2_native_acceptance')
 out.mkdir(parents=True,exist_ok=False);(out/'cases').mkdir()
 rows=[];blocked=[];start=dt.datetime.now(dt.timezone.utc).isoformat()
 def audit(event,args):
  if event in ('subprocess.Popen','os.system','os.startfile','socket.connect'):
   blocked.append(event);raise RuntimeError('Forbidden native/process boundary '+event)
  if event=='open' and args and isinstance(args[0],(str,bytes,os.PathLike)):
   mode=args[1] or '';flags=args[2] if len(args)>2 and type(args[2]) is int else 0
   if any(x in str(mode) for x in 'wax+') or flags&(os.O_WRONLY|os.O_RDWR|os.O_CREAT|os.O_TRUNC):
    if not Path(os.fsdecode(args[0])).resolve().is_relative_to(out.resolve()):raise RuntimeError('Write outside new run')
 sys.addaudithook(audit)
 fields=sorted(g.CORE|{'IndependentScalar'})
 def state(fix,count):
  tracks=[]
  for i,pid in enumerate(IDS[:count]):
   t={x:'' for x in g.CORE_TEXT+g.CORE_DATES};t.update({x:0 for x in g.CORE_NUMBER});t.update({x:False for x in g.CORE_BOOL});t.update(persistent_id=pid,Name='independent-'+str(i),Location=str(fix/(str(i)+'.dat')),file_exists=True,IndependentScalar=29);tracks.append(t)
  return dict(version=g.VERSION,library_persistent_id=MASTER,track_count=count,reported_track_count=count,reported_playlist_count=1,sound_volume=100,typelib_track_scalar_properties=fields,tracks=tracks,playlists=[dict(persistent_id=MASTER,name='Independent Library',kind=1,special_kind=None,Smart=False,parent_persistent_id=None,members=[dict(persistent_id=t['persistent_id'],name=t['Name']) for t in tracks])])
 def fixture(folder,count=1,mutation=None):
  root=folder/'root';fix=root/'fixtures/dynamic4';rep=root/'reports/dynamic';fix.mkdir(parents=True);rep.mkdir(parents=True)
  b,_=library(1);c,offsets=library(count)
  if mutation:c=changed(c,offsets[mutation])
  (fix/'baseline.itl').write_bytes(b);(fix/'candidate.itl').write_bytes(c)
  for i in range(count):(fix/(str(i)+'.dat')).write_bytes(b'NEW INDEPENDENT NON-AUDIO FIXTURE')
  s=dict(schema='itl4.g2.strict-passive-plan.v1',classification='independent_writer_append' if count==2 else 'passive_preservation',frozen_utc=(dt.datetime.now(dt.timezone.utc)-dt.timedelta(seconds=10)).isoformat(),expected_origin='independent_pre_native_intent',dwell_seconds=[45,30],old_track_pids=IDS[:1],new_track_pids=IDS[1:] if count==2 else [],track_fields=fields,before=state(fix,1),expected=state(fix,count),before_raw=g.raw_projection(b),expected_raw=g.raw_projection(c),candidate=g.stable_read(fix/'candidate.itl')[1],baseline=g.stable_read(fix/'baseline.itl')[1],file_pid=FILE,live=str(fix/'live-new/library.itl'),media=[g.stable_read(fix/(str(i)+'.dat'))[1] for i in range(count)])
  path=rep/'plan.json';dump(path,s)
  return lambda:g.FrozenCase(path,sha(path.read_bytes()),root),c,offsets
 def cycle(case,folder,b,index=1,previous=None,reported_previous=None):
  rep=case.root/'reports/dynamic';saved=rep/('saved-'+str(index)+'.itl');saved.write_bytes(b)
  times=list(range(0,46 if index==1 else 31,5));state_value=copy.deepcopy(case.spec['expected'])
  com=dict(ok=True,quit_returned=True,errors=[],explicit_actions=[],update_info_from_file_called=False,plan_sha256=case.pin['sha256'],samples=[dict(elapsed_seconds=t,state=state_value,media=case.media,modal_events=[]) for t in times],after=state_value)
  t0=dt.datetime.now(dt.timezone.utc)+dt.timedelta(seconds=5+100*(index-1))
  v=dict(index=index,worker_exit_code=0,com=com,native_exit_code=0,native_stopped=True,input_sha256=reported_previous or previous or case.candidate['sha256'],selection_verified=True,selected_path=str(case.live),file_pid=FILE,modal_events=[],fallback_detected=False,started_utc=t0.isoformat(),completed_utc=(t0+dt.timedelta(seconds=60)).isoformat(),saved=g.stable_read(saved)[1])
  wanted=previous or case.candidate['sha256']
  dump(folder/('cycle-input-'+str(index)+'.json'),dict(record=v,argument_previous_sha256=wanted))
  return case.cycle(v,index,wanted)
 def case(name,expected,fn,allowed_codes=None):
  if only is not None and name!=only:return
  folder=out/'cases'/('%03d-'%len(rows)+name);folder.mkdir()
  result=dict(name=name,expected=expected,per_case_os_exit=None)
  try:
   value=fn(folder);result.update(actual='accepted',value=value if type(value) in (dict,list,str,int,bool,type(None)) else type(value).__name__)
  except g.Rejected as e:result.update(actual='refused',code=e.code,error=str(e))
  except Exception as e:result.update(actual='exception',error=str(e),traceback=traceback.format_exc())
  result['matched']=result['actual']==expected and (not allowed_codes or result.get('code') in allowed_codes)
  dump(folder/'result.json',result);rows.append(result);print(name,result['actual'],result['matched'],result.get('code',''),flush=True)
 def ctor(folder,count=1,mutation=None):return fixture(folder,count,mutation)[0]().pin
 case('passive-nonzero-unknown-control','accepted',lambda f:ctor(f))
 case('append-closed-length-count-fields-control','accepted',lambda f:ctor(f,2))
 mutants=['track_tail','playlist_tail','flag_unselected','section_tail','list_tail','envelope_unknown']
 for m in mutants:
  for count in [1,2]:case('constructor-'+str(count)+'-'+m,'refused',lambda f,m=m,count=count:ctor(f,count,m))
  def raw_mut(f,m=m):
   make,b,o=fixture(f);c=make();v=changed(b,o[m]);(f/'mutated.itl').write_bytes(v);return c.raw(v)
  case('raw-'+m,'refused',raw_mut,['raw_full_order_or_intent_mismatch'])
  def cycle_mut(f,m=m):
   make,b,o=fixture(f);return cycle(make(),f,changed(b,o[m]))
  case('cycle-'+m,'refused',cycle_mut,['raw_full_order_or_intent_mismatch'])
 def two_cycles(f,mutation=None,stale=False):
  make,b,o=fixture(f);c=make();v1=encode(b,1);v2=encode(changed(b,o[mutation]) if mutation else b,9)
  hashes=[sha(b),sha(v1),sha(v2)];assert len(set(hashes))==3
  p1=cycle(c,f,v1);p2=cycle(c,f,v2,2,p1['sha256'],c.candidate['sha256'] if stale else None)
  return dict(wire_sha256=hashes,last=p2,synthetic_windows=[45,30])
 case('normal-two-cycle-distinct-hashes','accepted',two_cycles)
 case('second-save-header-tamper','refused',lambda f:two_cycles(f,'track_tail'),['raw_full_order_or_intent_mismatch'])
 case('second-save-stale-chain','refused',lambda f:two_cycles(f,stale=True),['cycle_chain_or_plan'])
 for m in ['track_count','playlist_count','playlist_size','section_size','list_count','outer_count']:
  def invalid_count(f,m=m):
   make,b,o=fixture(f);c=make();v=changed(b,o[m]);(f/'invalid-count.itl').write_bytes(v);return c.raw(v)
  case('closed-masked-counter-still-validated-'+m,'refused',invalid_count)
 # Evaluate the old production controller's exact read-only hash predicate,
 # not its COM entry. The new pure seam is called directly after the fix.
 def exe_component(f,component):
  if component=='controller':
   if hasattr(prod,'executable_preflight'):return prod.executable_preflight(exe)
   tree=ast.parse((source/'g2_native_acceptance.py').read_bytes())
   nodes=[n for n in ast.walk(tree) if isinstance(n,ast.Call) and isinstance(n.func,ast.Attribute) and n.func.attr=='need' and len(n.args)>1 and isinstance(n.args[1],ast.Constant) and n.args[1].value=='exe_pin_changed']
   assert len(nodes)==1
   import types
   value=eval(compile(ast.Expression(nodes[0].args[0]),'<actual-old-controller-exe-predicate>','eval'),{'g':g,'n':types.SimpleNamespace(EXE=exe),'EXE_SHA':prod.EXE_SHA})
   assert value;return dict(old_production_expression=True)
  if (source/'g2_native_select.py').read_text(encoding='utf8').find('def executable_preflight(')<0:
   return dict(old_selector_has_no_bounded_streaming_preflight=True)
  selector=importlib.import_module('g2_native_select');return selector.executable_preflight(exe)
 case('actual-exe-controller-read-only-preflight','accepted',lambda f:exe_component(f,'controller'))
 def selector_case(f):
  v=exe_component(f,'selector');assert not v.get('old_selector_has_no_bounded_streaming_preflight');return v
 case('actual-exe-selector-read-only-preflight','accepted',selector_case)
 if hasattr(g,'executable_pin'):
  # Additional GREEN-only API contracts, counted separately from paired probes.
  def small(f,mode):
   p=f/'synthetic-exe.bin';b=b'PURE SYNTHETIC EXECUTABLE PIN TEST'*50000;p.write_bytes(b)
   if mode=='wrong-sha':return g.executable_pin(p,'0'*64,expected_bytes=len(b))
   if mode=='wrong-size':return g.executable_pin(p,sha(b),expected_bytes=len(b)+1)
   if mode=='bad-pin-type':return g.executable_pin(p,sha(b),expected_bytes=True)
   if mode=='identity-race':
    real=g.os.fstat;calls=[]
    def altered(fd):
     s=real(fd);calls.append(1)
     if len(calls)==2:
      import types
      return types.SimpleNamespace(**{k:getattr(s,k)+(1 if k=='st_ino' else 0) for k in ['st_dev','st_ino','st_mode','st_size','st_mtime_ns','st_ctime_ns']})
     return s
    with patch.object(g.os,'fstat',side_effect=altered):return g.executable_pin(p,sha(b),expected_bytes=len(b))
   return g.executable_pin(p,sha(b),expected_bytes=len(b))
  for mode,expect,code in [('normal','accepted',None),('wrong-sha','refused',['exe_pin_changed']),('wrong-size','refused',['executable_size_mismatch']),('bad-pin-type','refused',['invalid_executable_pin']),('identity-race','refused',['executable_identity_changed'])]:case('green-stream-contract-'+mode,expect,lambda f,mode=mode:small(f,mode),code)
  def oversize(f):
   p=f/'sparse-too-large.bin'
   with p.open('xb') as h:h.truncate(g.MAX_EXE_BYTES+1)
   return g.executable_pin(p,'0'*64,expected_bytes=g.MAX_EXE_BYTES)
  case('green-exe-cap-not-widened','refused',oversize,['executable_size_limit'])
  def ordinary_limit(f):return g.stable_read(exe)
  case('green-itl-media-default-cap-still-32mib','refused',ordinary_limit,['file_size_limit'])
  def bounded_reads(f):
   original=Path.open;seen=[]
   class Reader:
    def __init__(self,h):self.h=h
    def __enter__(self):return self
    def __exit__(self,*a):return self.h.__exit__(*a)
    def fileno(self):return self.h.fileno()
    def read(self,n):
     assert 0<n<=1024*1024,n;seen.append(n);return self.h.read(n)
   def opened(p,*a,**kw):
    h=original(p,*a,**kw);return Reader(h) if p==exe else h
   with patch.object(Path,'open',opened):v=g.executable_pin(exe,g.EXE_SHA)
   assert len(seen)>32;return dict(pin=v,read_requests=len(seen),max_chunk=max(seen))
  case('green-exe-single-open-bounded-chunks','accepted',bounded_reads)
 summary=dict(schema='itl4.g2.guard-fix-regression.v1',label='RED-original-production' if red else 'GREEN-fixed-production',started_utc=start,completed_utc=dt.datetime.now(dt.timezone.utc).isoformat(),cases=len(rows),matched=sum(r['matched'] for r in rows),mismatched=sum(not r['matched'] for r in rows),accepted=sum(r['actual']=='accepted' for r in rows),refused=sum(r['actual']=='refused' for r in rows),exceptions=sum(r['actual']=='exception' for r in rows),native_actions=0,real_controller_calls=0,NativePort_calls=0,native_witness=False,engine_witness=False,blocked_boundaries=blocked,source_pins={n:sha((source/n).read_bytes()) for n in ['g2_acceptance_guard.py','g2_native_acceptance.py','g2_native_select.py']},tests=rows)
 dump(out/'result.json',summary)
 manifest=[]
 for p in sorted(out.rglob('*')):
  if p.is_file():
   h=hashlib.sha256()
   with p.open('rb') as f:
    while b:=f.read(1024*1024):h.update(b)
   manifest.append(dict(path=p.relative_to(out).as_posix(),bytes=p.stat().st_size,sha256=h.hexdigest()))
 dump(out/'MANIFEST.json',manifest)
 print(json.dumps({k:v for k,v in summary.items() if k!='tests'},indent=2))
 return 1 if summary['mismatched'] or blocked else 0

if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--source',required=True,type=Path);p.add_argument('--out',required=True,type=Path);p.add_argument('--exe',required=True,type=Path);p.add_argument('--red',action='store_true');p.add_argument('--only');a=p.parse_args();raise SystemExit(run(a.source.resolve(),a.out.resolve(),a.exe.resolve(),a.red,a.only))
