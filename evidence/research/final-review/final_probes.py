"""Offline final-diff checks; writes only to a new phase4 result directory."""
from pathlib import Path
import argparse,sys,hashlib,json,copy,contextlib,traceback,ctypes
from datetime import datetime,timedelta,timezone
from unittest.mock import patch
p=argparse.ArgumentParser();p.add_argument('--root',type=Path,required=True);p.add_argument('--out',type=Path,required=True);a=p.parse_args()
R=a.root;P=R/'reports/review/phase4';S=P/'source';O=a.out
assert O.resolve().is_relative_to(P.resolve()) and not O.exists();O.mkdir()
manifest=json.loads((P/'source-manifest.json').read_text(encoding='utf-8'));assert manifest['source_commit']=='9268e159950186c4bc844cd673733eec3406296a'
def sha(b):return hashlib.sha256(b).hexdigest()
for rel,v in manifest['files'].items():assert sha((S/rel).read_bytes())==v['sha256']
sys.path[:0]=[str(S),str(S/'tests')]
import itlkit,pytest
from itlkit import Library,UnsupportedError,hfs_from_datetime
from itlkit.binary import put,uint
from itlkit.model import Node
from test_codec_tracks import profile
import itlkit.trackops as ops
assert Path(itlkit.__file__).is_relative_to(S)
results={};inputs={}
def load(rel,expected):
 b=(R/rel).read_bytes();assert sha(b)==expected,rel
 q=O/'inputs'/rel;q.parent.mkdir(parents=True,exist_ok=True);q.write_bytes(b)
 inputs[rel]={'sha256':sha(b),'bytes':len(b)};return Library.from_bytes(b)
def denied(target,fn,source=None):
 b=target.to_bytes();s=source.to_bytes() if source else None
 held=[x.node for x in target.tracks+target.playlists]
 with patch.object(ops,'Allocator',side_effect=AssertionError('allocation before guard')):
  try:fn()
  except UnsupportedError as e:message=str(e)
  else:raise AssertionError('unsafe operation accepted')
 assert target.to_bytes()==b and (source is None or source.to_bytes()==s)
 assert all(x is y.node for x,y in zip(held,target.tracks+target.playlists))
 return {'refusal':message,'bytes_unchanged':True,'handles_unchanged':True,'before_allocator':True}
def dates():
 cases=[]
 for micros in [1,500000,999999]:
  v=datetime(1903,12,31,23,59,59,micros,tzinfo=timezone.utc)
  try:hfs_from_datetime(v)
  except ValueError as e:cases.append({'input':v.isoformat(),'refusal':str(e)})
  else:raise AssertionError('negative fraction accepted')
 controls=0
 for offset in [-28800,0,32400]:
  epoch=datetime(1904,1,1,tzinfo=timezone(timedelta(seconds=offset)))
  for seconds in [0,1,2082844800,2**32-1]:
   for micros in [0,1,500000,999999]:
    assert hfs_from_datetime(epoch+timedelta(seconds=seconds,microseconds=micros))==seconds;controls+=1
  for delta in [timedelta(microseconds=-1),timedelta(seconds=2**32)]:
   try:hfs_from_datetime(epoch+delta)
   except ValueError:pass
   else:raise AssertionError('boundary accepted')
 return {'original_three':cases,'positive_wall_time_controls':controls,'edge_refusals':6}
def witnesses():
 base='reports/playlist-audit/run-02/repro/'
 x=load(base+'nested-before.itl','f5c5d1c125613a17e27a864bad22e795bfe809ede13ba24c4c00507091bf883c')
 out={'F1_nested':denied(x,lambda:x.delete_track(x.track(track_id=2).persistent_id))}
 pairs=[('unmatched_system',base+'unmatched_system-before.itl','bae21375803613ffc9da7b3ead43899a6f1157c30048a1d248a8e2854d935a6d',base+'unmatched_system-donor.itl','aa4ee37a7b1e841faa7e930b0028872f0e92e1f6c5f81f9e16d0b2bc9901dcd8'),('mismatched_kind',base+'mismatched_kind-before.itl','587c075c23d814f09997ddec0aaace62b24966cff823e1de4dc6692faf03d369',base+'mismatched_kind-donor.itl','aa4ee37a7b1e841faa7e930b0028872f0e92e1f6c5f81f9e16d0b2bc9901dcd8'),('native_derived_missing_podcasts','reports/playlist-audit/supplement-01/native-system-target.itl','4df35a0a82bf879edfefb15d0e2cc3c77e1b96740646a8f822784143c0149ca4','reports/playlist-audit/supplement-01/native-system-donor-missing-podcasts.itl','2580bbdf0015254980bd4c6720079d75cda40132c9d8ab9c248f326e6ca3b519')]
 for name,tr,th,sr,sh in pairs:
  t,s=load(tr,th),load(sr,sh);missing={q.persistent_id for q in s.tracks}-{q.persistent_id for q in t.tracks};assert len(missing)==1
  pid=missing.pop();out[name]=denied(t,lambda:t.add_track_from(s,pid),s)
 return out
def ordinary(lib):return next(q for q in lib.playlists if q.is_plain)
def rule(pl,code,data):
 h=bytearray(24);h[:4]=b'mhoh';put(h,4,24);put(h,8,24+len(data));put(h,12,code);pl.node.children.append(Node(h,payload=data))
def rules_and_scope():
 out={}
 for code in [101,102,103]:
  for match in [False,True]:
   t,s=profile((1,)),profile((1,2));tp,sp=ordinary(t),ordinary(s)
   for q in [tp,sp]:put(q.node.header,0x238,2561)
   rule(tp,code,b'review-opaque');rule(sp,code,b'review-opaque' if match else b'review-different')
   pid=s.track(track_id=2).persistent_id;before=s.to_bytes();t.to_bytes()
   if match:
    meta=[n.to_bytes() for n in tp.node.children if n.tag==b'mhoh'];items=[n.to_bytes() for n in tp.items];plid=tp.persistent_id
    t.add_track_from(s,pid);pl=t.playlist(plid)
    assert [n.to_bytes() for n in pl.node.children if n.tag==b'mhoh']==meta and [n.to_bytes() for n in pl.items][:len(items)]==items
    out[f'{code}_equal']='accepted; opaque bytes and old items preserved'
   else:out[f'{code}_different']=denied(t,lambda:t.add_track_from(s,pid),s)
   assert s.to_bytes()==before
 t,s=profile((1,)),profile((1,2));tp=ordinary(t);plid=tp.persistent_id;s._root(2).children.remove(ordinary(s).node);t.to_bytes();old=tp.node.to_bytes();t.add_track_from(s,s.track(track_id=2).persistent_id);assert t.playlist(plid).node.to_bytes()==old
 out['unmatched_ordinary']='unchanged and accepted'
 t,s=profile((1,)),profile((1,2));h=bytearray(s.container.header);put(h,0x34,s.persistent_id+1,8,endian='big');s.container.header=bytes(h)
 out['cross_lineage']=denied(t,lambda:t.add_track_from(s,s.track(track_id=2).persistent_id),s)
 return out
def members(lib):
 ids={t.track_id:t.persistent_id for t in lib.tracks}
 return {p.persistent_id:sorted(ids[i] for i in p.track_ids) for p in lib.playlists}
def restoration():
 native=load('reports/parent/phase1-frozen/snapshots/003-three-tracks-reloaded.itl','a93cbc94da00eb60d1f5a45ac70af55948d4ecbae2ea735744af04b7b46128e4')
 out={}
 for label,s in [('synthetic',profile()),('closed_native_003',native)]:
  b=s.to_bytes();t=Library.from_bytes(b);pid=s.tracks[-1].persistent_id;peer={x.persistent_id:x.node.to_bytes() for x in s.tracks if x.persistent_id!=pid};original=members(s)
  t.delete_track(pid);assert pid not in {x.persistent_id for x in t.tracks};t.add_track_from(s,pid);t=Library.from_bytes(t.to_bytes())
  assert members(t)==original and {x.persistent_id for x in t.tracks}=={x.persistent_id for x in s.tracks}
  assert all(t.track(persistent_id=k).node.to_bytes()==v for k,v in peer.items()) and s.to_bytes()==b
  out[label]={'restored':True,'all_playlist_membership_multisets_equal':True,'peer_records_unchanged':True}
 return out
for name,fn in [('dates',dates),('four_original_witnesses',witnesses),('opaque_rules_and_scope',rules_and_scope),('same_lineage_controls',restoration)]:
 try:results[name]={'status':'passed','evidence':fn()};print('PASSED',name,flush=True)
 except Exception as e:results[name]={'status':'failed','error':repr(e),'traceback':traceback.format_exc()};print('FAILED',name,repr(e),flush=True)
with (O/'pytest.log').open('x',encoding='utf-8') as f,contextlib.redirect_stdout(f),contextlib.redirect_stderr(f):code=pytest.main([str(S/'tests'),'--rootdir',str(S),'-q','-p','no:cacheprovider','--basetemp',str(O/'pytest-temp'),'--junitxml',str(O/'pytest.xml')])
from ctypes import wintypes as w
class M(ctypes.Structure):
 _fields_=[('cb',w.DWORD),('PageFaultCount',w.DWORD)]+[(k,ctypes.c_size_t) for k in ['PeakWorkingSetSize','WorkingSetSize','QuotaPeakPagedPoolUsage','QuotaPagedPoolUsage','QuotaPeakNonPagedPoolUsage','QuotaNonPagedPoolUsage','PagefileUsage','PeakPagefileUsage']]
k=ctypes.WinDLL('kernel32');ps=ctypes.WinDLL('psapi');k.GetCurrentProcess.restype=w.HANDLE;ps.GetProcessMemoryInfo.argtypes=[w.HANDLE,ctypes.POINTER(M),w.DWORD];ps.GetProcessMemoryInfo.restype=w.BOOL;m=M();m.cb=ctypes.sizeof(m);assert ps.GetProcessMemoryInfo(k.GetCurrentProcess(),ctypes.byref(m),m.cb)
import xml.etree.ElementTree as ET
summary={'source_commit':manifest['source_commit'],'groups':results,'inputs':inputs,'pytest_exit_code':int(code),'pytest':ET.parse(O/'pytest.xml').getroot().find('testsuite').attrib,'peak_working_set_bytes':m.PeakWorkingSetSize,'native_actions':False,'utc':datetime.now(timezone.utc).isoformat()}
(O/'results.json').write_text(json.dumps(summary,indent=2)+'\n',encoding='utf-8');print(json.dumps(summary,indent=2))
assert 0<m.PeakWorkingSetSize<512*1024*1024
raise SystemExit(bool(code or any(v['status']!='passed' for v in results.values())))
