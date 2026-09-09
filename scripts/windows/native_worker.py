"""One bounded COM operation on an isolated synthetic library. Run under a supervisor timeout."""
import argparse,datetime,json,pathlib,time,traceback
import pythoncom,pywintypes,win32com.client

FIELDS=['Name','Artist','Album','AlbumArtist','Composer','Genre','Comment','Grouping','Lyrics','SortName','SortArtist','SortAlbum','SortAlbumArtist','Rating','AlbumRating','PlayedCount','PlayedDate','SkippedCount','SkippedDate','DateAdded','ModificationDate','TrackNumber','TrackCount','DiscNumber','DiscCount','Year','BPM','Compilation','Enabled','VolumeAdjustment','Location','Duration','SampleRate','BitRate','Size','TrackDatabaseID','TrackID','PlayOrderIndex','Unplayed']
# These distinguish explicit user ratings from computed ratings; capture only.
FIELDS+=['RatingKind','AlbumRatingKind']
SETTABLE=set(FIELDS)-{'DateAdded','ModificationDate','Location','Duration','SampleRate','BitRate','Size','TrackDatabaseID','TrackID','PlayOrderIndex','RatingKind','AlbumRatingKind'}

def norm(v):
    if isinstance(v,(str,int,float,bool)) or v is None:return v
    if hasattr(v,'isoformat'):return v.isoformat()
    return str(v)

def pid(app,obj):
    hi,lo=app.GetITObjectPersistentIDs(obj);return f'{hi&0xffffffff:08X}{lo&0xffffffff:08X}'

def file_interface(app,obj):
    lib=app._oleobj_.GetTypeInfo().GetContainingTypeLib()[0]
    for i in range(lib.GetTypeInfoCount()):
        if lib.GetDocumentation(i)[0]=='IITFileOrCDTrack':
            return win32com.client.dynamic.Dispatch(obj._oleobj_.QueryInterface(lib.GetTypeInfo(i).GetTypeAttr().iid, pythoncom.IID_IDispatch))
    raise RuntimeError('IITFileOrCDTrack type missing')

def items(c):return [c.Item(i) for i in range(1,c.Count+1)]

def snapshot(app):
    result={'version':app.Version,'library_persistent_id':pid(app,app.LibraryPlaylist),'tracks':[],'playlists':[]}
    for tr in items(app.LibraryPlaylist.Tracks):
        tr=file_interface(app,tr);v={'persistent_id':pid(app,tr)}
        for n in FIELDS:
            try:v[n]=norm(getattr(tr,n))
            except Exception as e:v[n]={'unavailable':str(e)}
        result['tracks'].append(v)
    result['track_count']=len(result['tracks'])
    for pl in items(app.LibrarySource.Playlists):
        v={'name':pl.Name,'persistent_id':pid(app,pl),'kind':pl.Kind,'members':[]}
        try:v['special_kind']=pl.SpecialKind
        except Exception:v['special_kind']=None
        for tr in items(pl.Tracks):v['members'].append({'persistent_id':pid(app,tr),'name':tr.Name,'play_order_index':tr.PlayOrderIndex})
        result['playlists'].append(v)
    return result

def guard(before,root):
    for tr in before['tracks']:
        loc=tr.get('Location')
        if not isinstance(loc,str) or not pathlib.Path(loc).resolve().is_relative_to(root.resolve()):raise RuntimeError('Refusing non-synthetic track location')

def findtrack(app,key):
    ts=items(app.LibraryPlaylist.Tracks)
    if isinstance(key,int):return file_interface(app,ts[key-1])
    for t in ts:
        if pid(app,t)==key or t.Name==key:return file_interface(app,t)
    raise KeyError(key)

def findplaylist(app,name):
    if not name.startswith('Synthetic'):raise RuntimeError('Only Synthetic* playlists are mutable')
    pls=[p for p in items(app.LibrarySource.Playlists) if p.Name==name]
    if len(pls)!=1:raise RuntimeError(f'Expected unique playlist {name}, got {len(pls)}')
    return pls[0]

def action(app,spec,root):
    kind=spec.get('kind','snapshot')
    if kind=='snapshot':return
    if kind=='add_files':
        for name in spec['paths']:
            p=pathlib.Path(name).resolve()
            if not p.is_relative_to(root.resolve()):raise RuntimeError('Audio outside synthetic root')
            status=app.LibraryPlaylist.AddFile(str(p));limit=time.monotonic()+45
            while status.InProgress:
                if time.monotonic()>limit:raise TimeoutError('AddFile in progress for 45s')
                pythoncom.PumpWaitingMessages();time.sleep(.1)
            if status.Tracks.Count!=1:raise RuntimeError('AddFile returned unexpected track count')
        return
    if kind=='set_track':
        tr=findtrack(app,spec['track']);name=spec['field'];value=spec['value']
        if name not in SETTABLE:raise ValueError(f'Unsupported mutation {name}')
        if name.endswith('Date'):value=pywintypes.Time(datetime.datetime.fromisoformat(value))
        setattr(tr,name,value);actual=getattr(tr,name)
        if norm(actual)!=norm(value):raise RuntimeError(f'Property verification mismatch: {name}: {norm(actual)!r} != {norm(value)!r}')
        return
    if kind=='create_playlist':
        if not spec['name'].startswith('Synthetic'):raise RuntimeError('Synthetic prefix required')
        if any(p.Name==spec['name'] for p in items(app.LibrarySource.Playlists)):raise RuntimeError('Playlist exists')
        app.CreatePlaylist(spec['name']);return
    if kind=='delete_track':findtrack(app,spec['track']).Delete();return
    pl=findplaylist(app,spec['name'])
    if kind=='rename_playlist':
        if not spec['new_name'].startswith('Synthetic'):raise RuntimeError('Synthetic prefix required')
        pl.Name=spec['new_name'];return
    if kind=='delete_playlist':pl.Delete();return
    if kind in ('playlist_add','playlist_reorder'):
        tracks=[findtrack(app,k) for k in spec['tracks']]
        if kind=='playlist_reorder':
            for tr in reversed(items(pl.Tracks)):tr.Delete()
        for tr in tracks:pl.AddTrack(tr)
        return
    if kind=='playlist_remove':
        key=spec['track'];members=items(pl.Tracks)
        if isinstance(key,int):members[key-1].Delete();return
        for t in members:
            if pid(app,t)==key:t.Delete();return
        raise KeyError(key)
    raise ValueError(kind)

def main():
    p=argparse.ArgumentParser();p.add_argument('--root',type=pathlib.Path,required=True);p.add_argument('--action',type=pathlib.Path);p.add_argument('--output',type=pathlib.Path,required=True);p.add_argument('--quit',action='store_true');p.add_argument('--expect-count',type=int);p.add_argument('--expect-state',type=pathlib.Path);a=p.parse_args()
    if a.output.exists():raise RuntimeError('Evidence path already exists')
    result={'started_utc':datetime.datetime.now(datetime.timezone.utc).isoformat()};pythoncom.CoInitialize()
    try:
        app=win32com.client.dynamic.Dispatch('iTunes.Application');result['before']=snapshot(app);guard(result['before'],a.root)
        if a.expect_count is not None and result['before']['track_count']!=a.expect_count:raise RuntimeError('Unexpected initial count; possible damaged-library fallback')
        if a.expect_state:
            from verify_native_matrix import compare
            expected=json.loads(a.expect_state.read_text(encoding='utf-8'))
            result['expectation_errors']=compare(expected,result['before'])
            if result['expectation_errors']:raise RuntimeError('Native expected-state gate failed: '+json.dumps(result['expectation_errors'],ensure_ascii=True)[:8000])
        spec=json.loads(a.action.read_text(encoding='utf-8')) if a.action else {'kind':'snapshot'}
        result['action']=spec;action(app,spec,a.root);result['after']=snapshot(app)
        guard(result['after'],a.root)
        # A first successful read is insufficient: lazy native metadata loading
        # can change values during observation. Never adopt that as a new expected
        # state for a snapshot-only candidate, and never Quit before this gate.
        if spec.get('kind','snapshot')=='snapshot':
            from verify_native_matrix import compare
            result['snapshot_stability_errors']=compare(result['before'],result['after'])
            result['post_expectation_errors']=compare(expected if a.expect_state else result['before'],result['after'])
            errors=result['snapshot_stability_errors']+result['post_expectation_errors']
            if errors:raise RuntimeError('Native snapshot-only state changed before Quit: '+json.dumps(errors,ensure_ascii=True)[:8000])
        result['ok']=True
        a.output.write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8')
        print(json.dumps({'ok':True,'action':spec,'library_id':result['after']['library_persistent_id'],'track_count':result['after']['track_count'],'track_ids':[t['persistent_id'] for t in result['after']['tracks']]}),flush=True)
        if a.quit:print('Quitting iTunes for native flush',flush=True);app.Quit()
    except Exception as e:
        result['ok']=False;result['error']=str(e);result['traceback']=traceback.format_exc();a.output.write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');raise
if __name__=='__main__':main()
