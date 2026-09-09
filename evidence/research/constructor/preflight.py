"""Independent final provenance, fresh identity and UTC/media preflight."""
import json
from pathlib import Path
from datetime import datetime,timezone
import verify as v

OWN=Path(__file__).resolve().parent
ROOT=OWN.parents[1]
req=json.loads((OWN/'native-requests.json').read_text())
inputs=json.loads((OWN/'input-manifest.json').read_text())
for f in inputs['source_files']+inputs['evidence']:
 v.need(v.sha(Path(f['path']).read_bytes())==f['sha256'],'source/evidence changed: '+f['path'])
rows=[]
for r in req['cases']:
 for f in [r['baseline'],r['candidate'],r['template']['source'],r['native_baseline_oracle'],r['native_baseline_provenance'],r['new_media']]+r['old_media']:
  v.need(v.sha(Path(f['path']).read_bytes())==f['sha256'],'pinned input/output hash drift: '+f['path'])
 b=v.from_wire(Path(r['baseline']['path']).read_bytes())
 c=v.from_wire(Path(r['candidate']['path']).read_bytes())
 old_pids={v.u(b['header'],0x34,8,'big')}; old_locals=set()
 for key,pid_offset,id_offset in [('tracks',0x80,16),('albums',20,16),('artists',20,16),('playlists',0x1b8,0xd40)]:
  for n in b[key]:
   old_pids.add(v.u(n['header'],pid_offset,8)); old_locals.add(v.u(n['header'],id_offset))
   if key=='tracks': old_locals.add(v.u(n['header'],0x1f4))
   if key=='playlists':
    for i in n['children']:
     if i['tag']==b'mtph':
      old_pids.add(v.u(i['header'],68,8)); old_locals.update((v.u(i['header'],16),v.u(i['header'],32)))
 info=r['construction']; pid=info['new_track_pid']
 new=next(t for t in c['tracks'] if v.hx(t['header'],0x80)==pid)
 added_pids=[int(pid,16)]+[int(n['persistent_id'],16) for n in info['new_aux'].values()]
 added_locals=[info['new_track_id'],info['new_secondary_id']]+[n['local_id'] for n in info['new_aux'].values()]
 for p in c['playlists']:
  if v.hx(p['header'],0x1b8) in v.AFFECTED:
   i=p['children'][-1]; added_pids.append(v.u(i['header'],68,8)); added_locals.append(v.u(i['header'],16))
   v.need(v.u(i['header'],16)==v.u(i['header'],32),'new item token not fresh local order')
 v.need(len(added_pids)==len(set(added_pids))==6 and not set(added_pids)&old_pids,'fresh persistent identity collision')
 v.need(len(added_locals)==len(set(added_locals))==7 and not set(added_locals)&old_locals,'fresh local identity collision')
 expected_utc=datetime(2026,9,9,14,0,tzinfo=timezone.utc)
 hfs=int((expected_utc-datetime(1904,1,1,tzinfo=timezone.utc)).total_seconds())
 v.need(v.u(new['header'],0x20)==v.u(new['header'],0x78)==hfs,'UTC HFS timestamp mismatch')
 v.need(int(Path(r['new_media']['path']).stat().st_mtime)==int(expected_utc.timestamp()),'new media timestamp mismatch')
 oracle=json.loads(Path(r['native_baseline_oracle']['path']).read_text(encoding='utf-8-sig'))['after']
 expected=r['expected_com_all_passive_observations']; et={t['persistent_id']:t for t in expected['tracks']}
 for t in oracle['tracks']:
  passive={k:value for k,value in t.items() if k not in ('TrackID','TrackDatabaseID','PlayOrderIndex')}
  v.need(passive==et[t['persistent_id']],'old COM expectation changed')
 v.need(et[pid]['Name']==info['name'] and et[pid]['Location']==info['path'],'new Name/Location manifest mismatch')
 v.need(et[pid]['DateAdded']==et[pid]['ModificationDate']==expected_utc.isoformat(),'new date manifest mismatch')
 rows.append({'case_id':r['case_id'],'input_output_media_hashes':'unchanged','old_com_expectations':'exact',
              'fresh_pids':[f'{p:016X}' for p in added_pids],'fresh_local_ids':added_locals,'new_hfs_time':hfs,
              'hdfm_file_pid':r['expected_file_persistent_id'],'com_master_pid':r['expected_com_library_persistent_id'],
              'independent_result':v.verify_case(r)})
control=req['independent_donor_negative_control']
for f in [control['manifest'],control['library']]:
 v.need(v.sha(Path(f['path']).read_bytes())==f['sha256'],'negative-control provenance changed')
v.need(not list(OWN.rglob('*.pyc')),'bytecode wrote into own artifacts')
result={'status':'passed_offline_only','native_acceptance':'not_run','checked_utc':datetime.now(timezone.utc).isoformat(),'cases':rows}
p=OWN/'preflight.json'
with p.open('x',encoding='utf-8',newline='\n') as f: json.dump(result,f,indent=2); f.write('\n')
print(json.dumps(result,indent=2))
