"""Re-audit immutable passive native runs without connecting to iTunes."""
import argparse, pathlib
from passive_native import load, write_json, facts, envelope, compare_state


def media_map(rows):
    return {str(pathlib.Path(x['path']).resolve()).casefold():{k:v for k,v in x.items() if k!='path'} for x in rows}

def audit(manifest_path, result_path):
    cases=load(manifest_path);results=load(result_path);assert len(cases)==len(results)
    findings=[]
    for case,entry in zip(cases,results):
        assert entry['name']==case['name'] and entry['sha256']==case['sha256'];assert len(entry['cycles'])==2
        pin=pathlib.Path(case['root'])/'phase2/candidates'/(case['name']+'.itl')
        assert facts(pin)['sha256']==case['sha256'];previous=case['sha256'];cycles=[]
        target=next(t for t in case['expected']['tracks'] if t['persistent_id']==case['target_track'])
        assert set(case['observe_only']) <= {'Unplayed','RatingKind','AlbumRatingKind','AlbumRating'}
        for index,res in enumerate(entry['cycles'],1):
            assert res['cycle']==index and res['prelaunch']['sha256']==previous
            assert res['itunes_exit_code']==0 and res['worker_exit_code']==0 and res['observation_completed']
            assert facts(pathlib.Path(res['saved']['path']))['sha256']==res['saved']['sha256'];previous=res['saved']['sha256']
            assert envelope(pathlib.Path(res['saved']['path']),case['target_track'])==res['profile_after']
            com=load(pathlib.Path(res['com_evidence']));assert com['observation_completed'] and com['quit_returned']
            assert com['spec']['expected']==case['expected'];assert com['explicit_mutations']==[] and com['update_info_from_file_called'] is False
            errors=[]
            if com['initial_target']['Name']!=target['Name']:errors.append({'property':'initial_target_Name','expected':target['Name'],'actual':com['initial_target']['Name']})
            first=com['samples'][0]['state']
            for j,s in enumerate(com['samples']):
                expected=compare_state(case['expected'],s['state'],case['observe_only'])
                if s['fresh_target']['Name']!=target['Name']:expected.append({'property':'fresh_target_Name','expected':target['Name'],'actual':s['fresh_target']['Name']})
                stable=[] if j==0 else compare_state(first,s['state'],case['observe_only'])
                assert expected==s['expected_errors'] and stable==s['stability_errors'];errors+=expected+stable
            assert com['samples'][-1]['elapsed_seconds']>=case['dwell'][index-1]
            if com['final_fresh_target']['Name']!=target['Name']:errors.append({'property':'pre_quit_Name','expected':target['Name'],'actual':com['final_fresh_target']['Name']})
            assert errors==com['errors'];assert com['accepted']==res['accepted']==(not errors)
            cycles.append({'cycle':index,'accepted':res['accepted'],'initial_name':com['initial_target']['Name'],
                           'observations':[{'elapsed':s['elapsed_seconds'],'snapshot_name':next(t['Name'] for t in s['state']['tracks'] if t['persistent_id']==case['target_track']),'fresh_name':s['fresh_target']['Name']} for s in com['samples']],
                           'final':com['final_fresh_target'],'input_sha256':res['prelaunch']['sha256'],
                           'saved':res['saved'],'profile_before':res['profile_before'],'profile_after':res['profile_after'],
                           'media_prelaunch_to_final_unchanged':media_map(res['media_prelaunch'])==media_map(com['samples'][-1]['media']),
                           'ui_actions':[x.get('action') for x in res['ui']]})
        assert entry['accepted']==all(c['accepted'] for c in cycles)
        findings.append({'name':case['name'],'sha256':case['sha256'],'accepted':entry['accepted'],
                         'raw_factors':case.get('raw_factors'),'requested_fields':case.get('expected_fields'),
                         'cycles':cycles})
    return {'audit_ok':True,'manifest':str(manifest_path),'result_path':str(result_path),
            'cases':len(findings),'native_cycles':2*len(findings),'positive_cases':sum(x['accepted'] for x in findings),
            'negative_cases':sum(not x['accepted'] for x in findings),'findings':findings,
            'limitations':['Bounded observations, not indefinite persistence.','No in-memory native dirty flag captured; persisted raw bytes, COM ModificationDate and media file attributes are distinct observations.']}


def main():
    p=argparse.ArgumentParser();p.add_argument('--manifest',type=pathlib.Path,required=True);p.add_argument('--results',type=pathlib.Path,required=True);p.add_argument('--out',type=pathlib.Path,required=True);a=p.parse_args();assert not a.out.exists();result=audit(a.manifest,a.results);write_json(a.out,result);print({k:v for k,v in result.items() if k not in ['findings','limitations']},flush=True)
if __name__=='__main__':main()
