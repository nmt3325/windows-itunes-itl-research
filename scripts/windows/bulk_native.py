"""Bounded synthetic-only native bulk import/metadata/snapshot worker.
Run only with a supervisor and a separately verified selected library.
"""
import argparse, datetime, json, pathlib, time, traceback
import pythoncom, win32com.client
from native_worker import pid, items, norm
from passive_native import load, write_json, facts

FIELDS={'name':'Name','artist':'Artist','album':'Album','album_artist':'AlbumArtist','comment':'Comment'}

def execute(spec_path, output):
    spec=load(spec_path);root=pathlib.Path(spec['root']).resolve();rows=spec.get('rows',[])
    assert not output.exists();assert spec['mode'] in ('empty','import','snapshot')
    result={'started_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'spec':spec,
            'added':[],'metadata_tracks_completed':0,'explicit_mutations':[]}
    pythoncom.CoInitialize()
    try:
        app=win32com.client.dynamic.Dispatch('iTunes.Application');master=pid(app,app.LibraryPlaylist)
        if spec['mode']=='empty':
            assert app.LibraryPlaylist.Tracks.Count==0
            assert master != spec['forbidden_master'], 'Not an independent native library'
            result['after']={'version':app.Version,'library_persistent_id':master,'track_count':0,'tracks':[],'playlists':[]}
        else:
            assert master==spec['master'], 'Wrong selected master PID'
            assert app.LibraryPlaylist.Tracks.Count==spec['expected_before'], 'Unexpected count; inspect before retry'
            lib=app._oleobj_.GetTypeInfo().GetContainingTypeLib()[0]
            iid=next(lib.GetTypeInfo(i).GetTypeAttr().iid for i in range(lib.GetTypeInfoCount()) if lib.GetDocumentation(i)[0]=='IITFileOrCDTrack')
            def wrap(t):return win32com.client.dynamic.Dispatch(t._oleobj_.QueryInterface(iid,pythoncom.IID_IDispatch))
            def collect():
                out={}
                for t in items(app.LibraryPlaylist.Tracks):
                    tr=wrap(t);loc=pathlib.Path(tr.Location).resolve()
                    assert loc.is_relative_to(root), 'Outside synthetic media scope'
                    assert loc.name not in out, 'Ambiguous duplicate media filename'
                    out[loc.name]=tr
                return out
            desired={x['metadata']['filename']:x for x in rows};assert len(desired)==len(rows)
            current=collect();assert set(current)<=set(desired)
            result['before_pids']=sorted(pid(app,t) for t in current.values())
            if 'expected_pids' in spec:assert result['before_pids']==sorted(spec['expected_pids'])
            if spec['mode']=='import':
                for filename,item in desired.items():
                    if filename in current:continue
                    p=pathlib.Path(item['copied']['path']).resolve();assert p.is_relative_to(root)
                    before=facts(p);assert before['sha256']==item['metadata']['input_sha256']
                    status=app.LibraryPlaylist.AddFile(str(p));deadline=time.monotonic()+35
                    while status.InProgress:
                        assert time.monotonic()<deadline, 'Import timeout; inspect actual native state before retry'
                        pythoncom.PumpWaitingMessages();time.sleep(.05)
                    assert status.Tracks.Count==1
                    tr=wrap(status.Tracks.Item(1));assert pathlib.Path(tr.Location).resolve().is_relative_to(root)
                    result['added'].append({'source':before,'persistent_id':pid(app,tr),'actual_location':tr.Location})
                    if len(result['added'])%32==0:write_json(output,result);print('IMPORTED',len(result['added']),flush=True)
                current=collect();assert set(current)==set(desired)
                result['explicit_mutations']=['LibraryPlaylist.AddFile']+list(FIELDS.values())
                for filename,item in desired.items():
                    tr=current[filename]
                    for key,field in FIELDS.items():
                        value=item['metadata'][key];assert len(value)<=255 if key=='comment' else True
                        setattr(tr,field,value);assert getattr(tr,field)==value, 'Native setter mismatch: '+field
                    result['metadata_tracks_completed']+=1
                    if result['metadata_tracks_completed']%32==0:write_json(output,result);print('METADATA',result['metadata_tracks_completed'],flush=True)
            def snapshot():
                current=collect();assert set(current)==set(desired);tracks=[];errors=[]
                for filename,tr in current.items():
                    t={'persistent_id':pid(app,tr),'filename':filename,'Location':tr.Location}
                    for key,field in FIELDS.items():
                        t[field]=getattr(tr,field)
                        if t[field]!=desired[filename]['metadata'][key]:errors.append({'track':t['persistent_id'],'field':field,'expected':desired[filename]['metadata'][key],'actual':t[field]})
                    t['ModificationDate']=norm(tr.ModificationDate);t['Unplayed']=tr.Unplayed;tracks.append(t)
                playlists=[]
                for pl in items(app.LibrarySource.Playlists):
                    kind=pl.Kind
                    if kind==2:
                        sk=pl.SpecialKind
                        if sk==0:playlists.append({'persistent_id':pid(app,pl),'name':pl.Name,'members':[pid(app,t) for t in items(pl.Tracks)]})
                return {'version':app.Version,'library_persistent_id':master,'track_count':len(tracks),'tracks':tracks,'ordinary_playlists':playlists},errors
            result['first_snapshot'],errors=snapshot();time.sleep(2);result['after'],later=snapshot();errors+=later
            assert result['after']['track_count']==spec['expected_after']
            after_pids=sorted(t['persistent_id'] for t in result['after']['tracks']);assert len(after_pids)==len(set(after_pids))
            assert set(result['before_pids'])<=set(after_pids)
            if spec['mode']=='snapshot':assert after_pids==sorted(spec['expected_pids'])
            result['errors']=errors;result['media_after']=[facts(pathlib.Path(t['Location'])) for t in result['after']['tracks']]
            assert not errors, 'Native metadata verification failed'
        result['ok']=True;write_json(output,result);app.Quit();result['quit_returned']=True;write_json(output,result)
        print(json.dumps({'ok':True,'master':master,'count':result['after']['track_count'],'added':len(result['added'])}),flush=True)
    except Exception as e:
        result.update(ok=False,error=str(e),traceback=traceback.format_exc());write_json(output,result);raise
    finally:pythoncom.CoUninitialize()

def main():
    p=argparse.ArgumentParser();p.add_argument('--spec',type=pathlib.Path,required=True);p.add_argument('--out',type=pathlib.Path,required=True);a=p.parse_args();execute(a.spec,a.out)
if __name__=='__main__':main()
