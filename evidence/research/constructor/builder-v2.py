"""Rebuild frozen fresh-WAV candidates onto existing dynamic-owned media, read-only."""
from __future__ import annotations
import copy,json,hashlib,sys
from datetime import datetime,timezone
from pathlib import Path
import builder as b
import verify as v

OWN=Path(__file__).resolve().parent
ROOT=OWN.parents[1]
REQUEST=ROOT/'reports/dynamic/phase3/requests-to-add-constructor.json'
MEDIA_ROOT=ROOT/'fixtures/dynamic/phase3/constructed-media'
ALLOWED={'003':'2c2d55b585f92d6ddce719234fbe5946279488cda3b68299325f32ccdcc78642','037':'eef503b3075e1ee675516a824360f82f5db1cb73da51bf9f6c1b402b0af0d4ae'}


def fact(p):
 p=Path(p); stat=p.stat(); data=p.read_bytes()
 return {'path':str(p),'bytes':len(data),'sha256':hashlib.sha256(data).hexdigest(),'mtime_ns':stat.st_mtime_ns,
         'mtime_utc':datetime.fromtimestamp(stat.st_mtime,timezone.utc).isoformat(),'file_attributes':stat.st_file_attributes}


def assert_fact(f):
 now=fact(f['path'])
 for key in ('bytes','sha256','mtime_ns','file_attributes'):
  if key in f: v.need(f[key]==now[key],'input changed '+f['path']+' '+key)
 return now


def rebind_only(original,output,pid):
 old=v.from_wire(original); new=v.from_wire(output)
 v.equal_except(old['header'],new['header'],[(8,4)],'v1-v2 outer')
 v.need(len(old['tracks'])==len(new['tracks'])==4,'v2 total track count')
 old_tracks=v.bypid(old['tracks'],0x80); new_tracks=v.bypid(new['tracks'],0x80)
 v.need(set(old_tracks)==set(new_tracks),'v2 track identity drift')
 for key,t in old_tracks.items():
  n=new_tracks[key]
  if key!=pid: v.need(t['raw']==n['raw'],'old track changed on rebinding'); continue
  v.equal_except(t['header'],n['header'],[(8,4)],'v1-v2 new track header')
  v.need(len(t['children'])==len(n['children'])==4,'unrecognized location child')
  for x,y in zip(t['children'],n['children']):
   code=v.u(x['header'],12)
   if code not in (11,13): v.need(x['raw']==y['raw'],'non-location metadata changed')
   else:
    v.equal_except(x['header'],y['header'],[(8,4)],'v1-v2 location header')
    v.equal_except(x['body'][:16],y['body'][:16],[(4,4)],'v1-v2 location prefix')
    v.need(v.text(x)!=v.text(y),'location not rebound')
 for sec in old['sections']:
  out=new['sec'][sec['kind']]
  if sec['kind'] not in (1,16): v.need(sec['raw']==out['raw'],'non-track section changed on rebinding')
  else:
   v.equal_except(sec['header'],out['header'],[(8,4)],'v1-v2 section header')
   v.equal_except(sec['root']['header'],out['root']['header'],[(8,4)] if sec['kind']==16 else [],'v1-v2 root')
 return {'status':'passed','only_semantic_delta':['new track mhoh13 path','new track mhoh11 FILE URL'],
         'other_changes':'corresponding string/record/section/logical/container lengths only','all_v1_track_and_aux_and_item_pids':'preserved',
         'all_system_and_ordinary_memberships':'byte-identical to v1'}


def main():
 # No v1 writer, generate_media(), os.utime(), native API or shared dependency changes.
 old_manifest=b.load_json(OWN/'native-requests.json'); marker=b.load_json(OWN/'ADD_CONSTRUCTOR_DONE'); report=b.load_json(OWN/'report.json')
 v.need(fact(OWN/'native-requests.json')['sha256']=='936bfcf322a02e2648871a836a71a215f6d2a9bbe9d8aa25ef57eed6348ff32a','v1 manifest pin')
 assert_fact(marker['report']); assert_fact(marker['native_requests'])
 for f in report['artifacts']: assert_fact(f)
 for f in old_manifest['source_files']: assert_fact(f)
 # Snapshot every existing owned artifact except this new v2 script/log; preserve hash/mtime/attributes.
 frozen=[fact(p) for p in sorted(OWN.rglob('*')) if p.is_file() and p.name not in {'builder-v2.py','build-v2.log'}]
 source_pins=[fact(OWN/'builder.py'),fact(OWN/'verify.py'),fact(Path(__file__))]
 request=b.load_json(REQUEST); requested={c['case_id']:c for c in request['cases']}
 template=b.Library.read(ROOT/'fixtures/dynamic/snapshots/003-three-tracks-reloaded.itl')
 template_state=b.load_json(ROOT/'reports/dynamic/native-runs/003-three-tracks-reloaded/com.json')['after']
 cases=[]; checks=[]; copies=[]
 for old in old_manifest['cases']:
  code=old['case_id'].split('-')[-2]; instruction=requested[old['case_id']]
  media=MEDIA_ROOT/f'fresh-constructor-{code}.wav'
  v.need(Path(instruction['required_new_media']['path'])==media,'unapproved dynamic media path')
  assert_fact(instruction['original_candidate']); assert_fact(instruction['original_media'])
  mf=assert_fact(instruction['required_new_media'])
  v.need(mf['sha256']==ALLOWED[code] and mf['bytes']==88244 and mf['mtime_ns']==1788962400000000000,'dynamic copy pin/profile')
  v.need(media.read_bytes()==Path(old['new_media']['path']).read_bytes(),'copy differs from frozen synthesis')
  copies.append(mf)
  base_path=Path(old['baseline']['path']); assert_fact(old['baseline'])
  data,info=b.construct(b.Library.read(base_path),template,media,code)
  again,info2=b.construct(b.Library.read(base_path),template,media,code)
  v.need(data==again and info==info2,'v2 deterministic build')
  candidate=OWN/'candidates'/f'fresh-{code}-v2.itl'
  b.save(candidate,data)
  raw=b.Library.from_bytes(data)
  pid_map={t.track_id:f'{t.persistent_id:016X}' for t in raw.tracks}
  r=copy.deepcopy(old)
  r.update({'case_id':old['case_id'].replace('-v1','-v2'),'status':'offline_verified_native_pending',
    'supersedes_case_id':old['case_id'],'previous_candidate':assert_fact(old['candidate']),
    'candidate':fact(candidate),'baseline':fact(base_path),'construction':info,
    'new_media':mf|{'pcm':old['new_media']['pcm'],'ownership':'dynamic','constructor_access':'read_only'},
    'old_media':[fact(f['path']) for f in old['old_media']],
    'native_baseline_oracle':fact(old['native_baseline_oracle']['path']),
    'native_baseline_provenance':fact(old['native_baseline_provenance']['path']),
    'expected_raw_tracks_before_native':[t.to_dict() for t in raw.tracks],
    'expected_raw_playlists_before_native':[p.to_dict()|{'member_persistent_ids':[pid_map[i] for i in p.track_ids],'special_kind_raw':b.uint(p.node.header,0x238)} for p in raw.playlists],
    'expected_com_all_passive_observations':b.com_expectation(b.load_json(old['native_baseline_oracle']['path'])['after'],template_state,info),
    'v2_rebinding_policy':'Regenerated from original SHA-pinned baseline through frozen builder.construct(), using existing dynamic copy; no in-place v1 or live-byte patch.',
    'mtime_policy':'Existing copy SHA, full nanosecond mtime and attributes checked before/after. Its14:00UTC mtime equals the unchanged new track modification/addition HFS fields. No media writes.'})
  r['template']['source']=fact(old['template']['source']['path'])
  r['guard_and_byte_diff_rationale'].append('V2 only: path13/URL11 rebound by normal constructor text operations to the approved dynamic-owned copy; identities and all other metadata/membership preserved from v1.')
  r=json.loads(json.dumps(r))
  independent=v.verify_case(r)
  delta=rebind_only(Path(old['candidate']['path']).read_bytes(),data,info['new_track_pid'])
  v.need(v.u(v.from_wire(data)['tracks'][-1]['header'],0x20)==3871807200,'new modified HFS/copy mtime mismatch')
  check={'case_id':r['case_id'],'reproducibility':'two exact in-memory rebuilds','independent_byte_ref_media_check':independent,'independent_v1_v2_delta':delta}
  r['independent_checks']=check; checks.append(check); cases.append(r)
 for f in frozen+copies+source_pins: assert_fact(f)
 preservation={'status':'passed','v1_files':frozen,'dynamic_media_copies_read_only':copies,'rule':'SHA256, bytes, mtime_ns and file_attributes equal before/after; new files only'}
 b.save(OWN/'v1-preservation-for-v2.json',preservation)
 b.save(OWN/'offline-checks-v2.json',{'status':'passed_offline_only','native_acceptance':'not_run','checks':checks,'preservation':preservation})
 manifest=copy.deepcopy(old_manifest)
 manifest.update({'schema':'descriptive-native-requests/v2','status':'offline_verified_native_pending','created_utc':datetime.now(timezone.utc).isoformat(),
  'previous_manifest':fact(OWN/'native-requests.json'),'requested_by_dynamic':fact(REQUEST),'source_files':[fact(f['path']) for f in old_manifest['source_files']],
  'constructor_sources':source_pins,'generation':{'command':str(ROOT/'tools/py/Scripts/python.exe')+' -B '+str(OWN/'builder-v2.py'),
    'cwd':str(ROOT/'wt/add-constructor'),'shell':'pwsh','env':{'PYTHONDONTWRITEBYTECODE':'1','PYTHONIOENCODING':'utf-8'},'receipt_file':str(OWN/'v2-run-receipts.json')},
  'independent_checks':fact(OWN/'offline-checks-v2.json'),'v1_preservation':fact(OWN/'v1-preservation-for-v2.json'),'cases':cases})
 b.save(OWN/'native-requests-v2.json',manifest)
 for f in frozen+copies+source_pins: assert_fact(f)
 print(json.dumps({'status':'v2_ready_native_pending','manifest':fact(OWN/'native-requests-v2.json'),'cases':[{'case_id':r['case_id'],'candidate':r['candidate'],'media':r['new_media'],'new_track_pid':r['construction']['new_track_pid']} for r in cases]},indent=2))

if __name__=='__main__': main()
