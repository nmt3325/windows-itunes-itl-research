"""Fail-closed comparison of native save/restart evidence and requested mutations."""
import argparse,hashlib,json,pathlib

# Native iTunes renumbers COM TrackDatabaseID after import/restart (139->71,
# 146->77, 153->79 were observed). Keep these in raw evidence, but use the
# actual 64-bit Persistent IDs as the cross-restart identity gate.
# Library enumeration PlayOrderIndex is not a user-playlist order; user
# playlist order is compared separately by persistent ID below.
SESSION_FIELDS={'TrackID','TrackDatabaseID','PlayOrderIndex'}
def ordered(pl):return [m['persistent_id'] for m in sorted(pl['members'],key=lambda x:x['play_order_index'])]
def trackmap(s):return {t['persistent_id']:t for t in s['tracks']}
def playlists(s):
    # COM Kind=2, SpecialKind=0 selects ordinary user playlists, including
    # independently created/renamed playlists whose names are not Synthetic*.
    # Do not compare the auto-sorted Library/Music system views as stored order.
    user=[p for p in s['playlists'] if p['kind']==2]
    if any(p.get('special_kind') is None for p in user):raise ValueError('Missing COM SpecialKind; refusing an ambiguous playlist gate')
    return {p['persistent_id']:{'name':p['name'],'kind':p['kind'],'members':ordered(p)} for p in user if p['special_kind']==0}
def compare(expected,actual):
    diffs=[]
    for name in ('version','library_persistent_id','track_count'):
        if expected[name]!=actual[name]:diffs.append({'property':name,'expected':expected[name],'actual':actual[name]})
    a,b=trackmap(expected),trackmap(actual)
    if set(a)!=set(b):diffs.append({'property':'track_persistent_ids','expected':sorted(a),'actual':sorted(b)})
    for pid in a.keys()&b.keys():
        for k,v in a[pid].items():
            if k in SESSION_FIELDS:continue
            if v!=b[pid].get(k):diffs.append({'track':pid,'property':k,'expected':v,'actual':b[pid].get(k)})
    if playlists(expected)!=playlists(actual):diffs.append({'property':'synthetic_playlists','expected':playlists(expected),'actual':playlists(actual)})
    return diffs

def verify_action(before,after,spec):
    kind=spec.get('kind','snapshot');tracks=trackmap(after)
    if kind=='set_track':
        target=tracks[spec['track']];assert target[spec['field']]==spec['value'],('mutation_readback',spec,target[spec['field']])
    old={p['name']:p for p in before['playlists']};new={p['name']:p for p in after['playlists']}
    if kind=='create_playlist':assert spec['name'] not in old and spec['name'] in new
    if kind=='rename_playlist':
        assert spec['name'] not in new and new[spec['new_name']]['persistent_id']==old[spec['name']]['persistent_id']
    if kind=='delete_playlist':assert spec['name'] in old and spec['name'] not in new
    if kind=='playlist_add':assert ordered(new[spec['name']])==ordered(old[spec['name']])+spec['tracks']
    if kind=='playlist_reorder':assert ordered(new[spec['name']])==spec['tracks']
    if kind=='playlist_remove':assert ordered(new[spec['name']])==[x for x in ordered(old[spec['name']]) if x!=spec['track']]
    if kind=='add_files':
        locations={str(pathlib.Path(t['Location']).resolve()).lower() for t in after['tracks']}
        assert all(str(pathlib.Path(x).resolve()).lower() in locations for x in spec['paths'])
    if kind=='delete_track':assert spec['track'] not in tracks

def verify(report,plans,baseline=None):
    cases=[c for p in plans for c in json.loads(p.read_text(encoding='utf-8'))];entries=[];previous=json.loads(baseline.read_text(encoding='utf-8'))['after'] if baseline else None;previous_sha=None
    for case in cases:
        out=report/'native-runs'/case['name'];r=json.loads((out/'result.json').read_text(encoding='utf-8'));c=json.loads((out/'com.json').read_text(encoding='utf-8'));checks=[]
        if r['status']!='passed' or not c['ok'] or r['worker_exit_code']!=0 or r['itunes_exit_code']!=0:checks.append({'error':'native_run_not_successful'})
        actual_sha=hashlib.sha256(pathlib.Path(r['fixture_path']).read_bytes()).hexdigest()
        if actual_sha!=r['fixture_sha256']:checks.append({'error':'saved_fixture_hash_mismatch'})
        if previous_sha and r['prelaunch_sha256']!=previous_sha:checks.append({'error':'input_file_not_previous_native_save'})
        if previous is not None:checks.extend(compare(previous,c['before']))
        if c['before']['track_count']!=case['expected_before'] or c['after']['track_count']!=case['expected_after']:checks.append({'error':'count_gate_failed'})
        if any(e.get('action')=='unexpected_modal' for e in r['ui']):checks.append({'error':'unexpected_modal'})
        try:verify_action(c['before'],c['after'],case.get('action',{}))
        except Exception as e:checks.append({'error':'action_verification','detail':str(e)})
        entries.append({'name':case['name'],'ok':not checks,'errors':checks,'fixture_path':r['fixture_path'],'sha256':actual_sha,'library_persistent_id':c['after']['library_persistent_id'],'track_persistent_ids':sorted(trackmap(c['after'])),'playlists':playlists(c['after'])})
        previous=c['after'];previous_sha=r['fixture_sha256']
    return {'ok':all(x['ok'] for x in entries),'cases':entries,'case_count':len(entries),'compared_restarts':len(entries)-(0 if baseline else 1),'ignored_session_properties':sorted(SESSION_FIELDS),'note':'Mutation values are checked immediately and in the following native restart; final snapshot case is the closing reload gate.'}

def main():
    p=argparse.ArgumentParser();p.add_argument('--report',type=pathlib.Path,required=True);p.add_argument('--plan',type=pathlib.Path,action='append',required=True);p.add_argument('--baseline',type=pathlib.Path);p.add_argument('--out',type=pathlib.Path,required=True);a=p.parse_args()
    if a.out.exists():raise RuntimeError('Evidence output exists')
    result=verify(a.report,a.plan,a.baseline);a.out.write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps({'ok':result['ok'],'case_count':result['case_count'],'compared_restarts':result['compared_restarts'],'failed':[x for x in result['cases'] if not x['ok']][:10]}),flush=True)
    if not result['ok']:raise SystemExit(1)
if __name__=='__main__':main()
