"""Independent negative/ref tests plus constructor reproducibility; no native API."""
from __future__ import annotations
import copy, ctypes, json
from pathlib import Path
import builder
import verify as v

OWN=Path(__file__).resolve().parent
RESULTS=[]


def check(name,fn):
 try:
  detail=fn()
 except Exception as exc:
  RESULTS.append({'name':name,'status':'failed','error':f'{type(exc).__name__}: {exc}'})
  raise
 else:
  RESULTS.append({'name':name,'status':'passed','detail':detail})


def rejects(name,fn,reason):
 def run():
  try: fn()
  except (ValueError,FileExistsError) as exc:
   if reason and reason not in str(exc): raise AssertionError(f'wrong refusal: {exc}')
   return str(exc)
  raise AssertionError('negative mutation accepted')
 check(name,run)


def mutate(data,off,value,width=4):
 b=bytearray(data); b[off:off+width]=value.to_bytes(width,'little'); return bytes(b)


def peak_memory():
 from ctypes import wintypes
 class PMC(ctypes.Structure):
  _fields_=[('cb',wintypes.DWORD),('PageFaultCount',wintypes.DWORD)]+[(n,ctypes.c_size_t) for n in ['PeakWorkingSetSize','WorkingSetSize','QuotaPeakPagedPoolUsage','QuotaPagedPoolUsage','QuotaPeakNonPagedPoolUsage','QuotaNonPagedPoolUsage','PagefileUsage','PeakPagefileUsage']]
 get=ctypes.windll.kernel32.GetCurrentProcess; get.restype=wintypes.HANDLE
 mem=ctypes.windll.psapi.GetProcessMemoryInfo
 mem.argtypes=[wintypes.HANDLE,ctypes.POINTER(PMC),wintypes.DWORD]; mem.restype=wintypes.BOOL
 p=PMC(); p.cb=ctypes.sizeof(p)
 if not mem(get(),ctypes.byref(p),p.cb): raise ctypes.WinError()
 if p.PeakWorkingSetSize>512*1024*1024: raise AssertionError('memory quota exceeded')
 return {'peak_working_set_bytes':p.PeakWorkingSetSize,'limit_bytes':512*1024*1024}


def main():
 manifest=builder.load_json(OWN/'native-requests.json')
 template=builder.Library.read(builder.ROOT/'fixtures/dynamic/snapshots/003-three-tracks-reloaded.itl')
 for request in manifest['cases']:
  case=request['case_id'].split('-')[-2]
  check(case+' independent bytes refs media preservation',lambda r=request:v.verify_case(r))
  base=builder.Library.read(Path(request['baseline']['path']))
  media=Path(request['new_media']['path'])
  original=Path(request['candidate']['path']).read_bytes()
  def reproduce():
   a,ai=builder.construct(base,template,media,case)
   b,bi=builder.construct(base,template,media,case)
   assert a==b==original and ai==bi
   assert base.to_bytes()==Path(request['baseline']['path']).read_bytes()
   return {'sha256':v.sha(a),'in_memory_builds':2}
  check(case+' reproducible constructor nonmutation',reproduce)
  decoded=v.from_wire(original); payload=decoded['payload']; header=decoded['header']
  new=next(t for t in decoded['tracks'] if v.hx(t['header'],0x80)==request['construction']['new_track_pid'])
  old=decoded['tracks'][0]
  def bad(off,value,width=4):
   return lambda:v.from_wire(v.repack(header,mutate(payload,off,value,width)))
  rejects(case+' duplicate track PID',bad(new['offset']+0x80,v.u(old['header'],0x80,8),8),'track PID identity')
  rejects(case+' duplicate track local ID',bad(new['offset']+16,v.u(old['header'],16)),'track local identity')
  rejects(case+' duplicate secondary ID',bad(new['offset']+0x1f4,v.u(old['header'],0x1f4)),'secondary track identity')
  rejects(case+' dangling album reference',bad(new['offset']+0xdc,999999),'album dangling')
  rejects(case+' dangling artist reference',bad(new['offset']+0x1e0,999999),'artist dangling')
  root=decoded['sec'][1]['root']
  rejects(case+' wrong track-list count',bad(root['offset']+8,3),'list count')
  mfdh=decoded['sec'][16]['root']
  rejects(case+' wrong mirror track count',bad(mfdh['offset']+0x44,3),'header/list count')
  title=next(c for c in new['children'] if v.u(c['header'],12)==2)
  oldtitle=next(c for c in old['children'] if v.u(c['header'],12)==2)
  rejects(case+' occupied unequal Name atom',bad(title['offset']+16,v.u(oldtitle['header'],16)),'unequal-text alias')
  master=next(p for p in decoded['playlists'] if v.hx(p['header'],0x1b8)==builder.MASTER_PID)
  item=master['children'][-1]
  rejects(case+' dangling playlist track',bad(item['offset']+24,999999),'dangling playlist')
  rejects(case+' wrong playlist item count',bad(master['offset']+16,3),'miph item count')
  rejects(case+' wrong section length',bad(decoded['sec'][1]['offset']+8,0),'section bound')
  rejects(case+' protected candidate immutable',lambda:builder.save(Path(request['candidate']['path']),b'not-a-library'),'immutable output differs')
  # These negatives operate only on copied models. No foreign/source files are changed.
  t=copy.deepcopy(template.track(persistent_id=builder.TEMPLATE_PID))
  opaque=copy.deepcopy(t.node.children[0]); builder.put(opaque.header,12,1); opaque.payload=b'opaque-location-probe'
  t.node.children.append(opaque)
  rejects(case+' reject opaque type1 template',lambda:builder.guard_template(t),'opaque type-1')
  t=copy.deepcopy(template.track(persistent_id=builder.TEMPLATE_PID)); t.node.header[0x275]=1
  rejects(case+' reject unknown template state',lambda:builder.guard_template(t),'byte fingerprint')
  t=copy.deepcopy(template.track(persistent_id=builder.TEMPLATE_PID)); t.node.children[0].payload+=b'extension'
  rejects(case+' reject text extension',lambda:builder.guard_template(t),'prefix/suffix')
  t=copy.deepcopy(template.track(persistent_id=builder.TEMPLATE_PID)); builder.put(t.node.header,0xf4,48000)
  rejects(case+' reject unverified sample rate',lambda:builder.guard_template(t),'WAV dimensions')
  t=copy.deepcopy(template.track(persistent_id=builder.TEMPLATE_PID)); builder.put(t.node.header,0x144,10)
  rejects(case+' reject duplicate size drift',lambda:builder.guard_template(t),'duplicated-size')
  class BadMedia:
   def read_bytes(self): return b'RIFF'
   def resolve(self): return media
  rejects(case+' refuse mismatched media before output',lambda:builder.construct(base,template,BadMedia(),case),'synthetic media')
  class OccupiedMedia:
   def read_bytes(self): return builder.pcm_bytes(case)
   def resolve(self): return Path(base.tracks[0].get('path'))
  rejects(case+' refuse registered path',lambda:builder.construct(base,template,OccupiedMedia(),case),'already registered')
  check(case+' final immutable candidate hash',lambda:v.sha(Path(request['candidate']['path']).read_bytes())==request['candidate']['sha256'] or (_ for _ in ()).throw(AssertionError('candidate mutated')))
 rejects('refuse writes outside owned reports',lambda:builder.save(builder.ROOT/'forbidden-write-test.txt',b'not-written'),'write outside')
 mem=peak_memory()
 output={'status':'offline_tests_passed','native_acceptance':'not_run','implementation_independence':'verify.py imports no itlkit; distinct AES/zlib envelope and boundary parser, identity/atom/reference and old-byte oracle',
         'case_count':2,'test_count':len(RESULTS),'memory':mem,'checks':RESULTS}
 builder.save(OWN/'offline-tests.json',output)
 print(json.dumps(output,indent=2))

if __name__=='__main__': main()
