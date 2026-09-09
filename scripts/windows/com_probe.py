"""COM introspection against an already-running, disposable iTunes instance."""
import argparse, json, pathlib, sys, time
import pythoncom, win32com.client

def plain(value):
    if value is None or isinstance(value,(str,int,float,bool)): return value
    if hasattr(value,'isoformat'): return value.isoformat()
    return str(value)

def read(obj, names):
    result={}
    for n in names:
        try: result[n]=plain(getattr(obj,n))
        except Exception as e: result[n]={'error':str(e)}
    return result

def main():
    p=argparse.ArgumentParser();p.add_argument('--output',required=True,type=pathlib.Path);p.add_argument('--quit',action='store_true');p.add_argument('--typelib',type=pathlib.Path);a=p.parse_args()
    pythoncom.CoInitialize();print('Connecting to active iTunes COM',flush=True)
    app=win32com.client.dynamic.Dispatch('iTunes.Application')
    print('Connected',flush=True)
    if a.typelib:
        lib=app._oleobj_.GetTypeInfo().GetContainingTypeLib()[0];types=[]
        for i in range(lib.GetTypeInfoCount()):
            info=lib.GetTypeInfo(i);attr=info.GetTypeAttr();funcs=[]
            for j in range(attr.cFuncs):
                f=info.GetFuncDesc(j);funcs.append({'names':info.GetNames(f.memid),'invkind':f.invkind,'docs':info.GetDocumentation(f.memid)})
            types.append({'name':lib.GetDocumentation(i)[0],'funcs':funcs})
        a.typelib.write_text(json.dumps(types,indent=2,default=str),encoding='utf-8')
    result={'app':read(app,['Version','LibraryXMLPath','LibraryPersistentIDHigh','LibraryPersistentIDLow','PlayerState']), 'sources':[], 'tracks':[]}
    library=app.LibraryPlaylist;result['library']=read(library,['Name','Kind','TrackCount','SourceID','PlaylistID'])
    tracks=library.Tracks;result['track_count']=tracks.Count
    for i in range(1,tracks.Count+1): result['tracks'].append(read(tracks.Item(i),['Name','Artist','Album','TrackDatabaseID','TrackID','Rating','PlayedCount','SkippedCount','Location']))
    sources=app.Sources
    for i in range(1,sources.Count+1):
        s=sources.Item(i);source=read(s,['Name','Kind','SourceID']);source['playlists']=[]
        for j in range(1,s.Playlists.Count+1):
            pl=s.Playlists.Item(j);entry=read(pl,['Name','Kind','PlaylistID']);entry['track_count']=pl.Tracks.Count;source['playlists'].append(entry)
        result['sources'].append(source)
    a.output.write_text(json.dumps(result,indent=2,ensure_ascii=False),encoding='utf-8');print(json.dumps(result,indent=2,ensure_ascii=True),flush=True)
    if a.quit: print('Quit requested',flush=True); app.Quit()
if __name__=='__main__':main()
