"""Bounded discovery oracles for a fresh 2026-09-10 runner; not writer acceptance.
CLI: worker --spec PATH --out PATH; controller --spec PATH.
Every result is new-only. Caller owns native exclusivity and selection evidence.
"""
import argparse,collections,datetime,hashlib,json,pathlib,re,subprocess,sys,time,traceback
import pythoncom,pywintypes,win32api,win32com.client,win32event,win32process
W=pathlib.Path(__file__).resolve().parents[3]
ROOT=W.parents[1]; FIX=ROOT/'fixtures/dynamic4'; REPORT=ROOT/'reports/dynamic'
sys.path.insert(0,str(W/'scripts/windows'))
import native_worker as legacy
from native_driver import wait_ready,EXE
from native_acceptance import require_stopped
from desktop_probe import snapshot as desktop
PIN='30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d'
SESSION={'TrackID','trackID','TrackDatabaseID','PlayOrderIndex','Index','SourceID','PlaylistID','sourceID','playlistID'}
def now():return datetime.datetime.now(datetime.timezone.utc).isoformat()
def read(p):return json.loads(pathlib.Path(p).read_text(encoding='utf-8'))
def write(p,obj):
    with pathlib.Path(p).open('x',encoding='utf-8',newline='\n') as f:json.dump(obj,f,ensure_ascii=False,indent=2)
def facts(p):
    p=pathlib.Path(p);b=p.read_bytes();s=p.stat()
    return dict(path=str(p),bytes=len(b),sha256=hashlib.sha256(b).hexdigest(),mtime_ns=s.st_mtime_ns)
def identity(pid):
    h=win32api.OpenProcess(0x410,False,pid)
    try:return dict(pid=pid,path=win32process.GetModuleFileNameEx(h,0),creation=str(win32process.GetProcessTimes(h)['CreationTime']))
    finally:h.Close()
def scoped(p,root):
    p=pathlib.Path(p).resolve()
    if not p.is_relative_to(root.resolve()):raise ValueError('Path outside owned scope: '+str(p))
    return p
def fields():
    lib=pythoncom.LoadTypeLib(str(EXE))
    for i in range(lib.GetTypeInfoCount()):
        ti=lib.GetTypeInfo(i)
        if lib.GetDocumentation(i)[0]!='IITFileOrCDTrack':continue
        fs=[]
        for j in range(ti.GetTypeAttr().cFuncs):
            d=ti.GetFuncDesc(j);t=d.rettype[0]
            if d.invkind==2 and not d.args and (isinstance(t,int) or isinstance(t,tuple) and t[0]==29):fs.append(ti.GetNames(d.memid)[0])
        return fs
    raise RuntimeError('File track typelib interface absent')
def full(app):
    s=legacy.snapshot(app);by={t['persistent_id']:t for t in s['tracks']};props=fields()
    for t in legacy.items(app.LibraryPlaylist.Tracks):
        t=legacy.file_interface(app,t);row=by[legacy.pid(app,t)]
        for n in props:
            try:row[n]=legacy.norm(getattr(t,n))
            except pywintypes.com_error as e:row[n]={'unavailable':str(e),'hresult':e.hresult}
        row['file_exists']=pathlib.Path(row['Location']).is_file()
    for p in legacy.items(app.LibrarySource.Playlists):
        row=next(x for x in s['playlists'] if x['persistent_id']==legacy.pid(app,p))
        for n in ['Smart','SpecialKind','Shared','Visible','Shuffle','SongRepeat']:
            try:row[n]=legacy.norm(getattr(p,n))
            except (pywintypes.com_error,AttributeError) as e:row[n]={'unavailable':str(e)}
        try:
            parent=p.Parent;row['parent_persistent_id']=legacy.pid(app,parent) if parent is not None else None
        except (pywintypes.com_error,AttributeError) as e:row['parent_persistent_id']={'unavailable':str(e)}
    s['reported_track_count']=app.LibraryPlaylist.Tracks.Count
    s['reported_playlist_count']=app.LibrarySource.Playlists.Count
    s['sound_volume']=app.SoundVolume;s['typelib_track_scalar_properties']=props
    return s

def shape(s):
    if s['version']!='12.13.10.3':raise ValueError('Wrong native version')
    ts=s['tracks'];ids=[t['persistent_id'] for t in ts]
    if s['track_count']!=len(ts) or len(ids)!=len(set(ids)):raise ValueError('Incomplete/duplicate tracks')
    for t in ts:
        scoped(t['Location'],FIX)
        if not t['file_exists']:raise ValueError('Missing media')
    ps=s['playlists'];pids=[p['persistent_id'] for p in ps]
    if len(pids)!=len(set(pids)):raise ValueError('Duplicate playlists')
    if any(not isinstance(p,str) or not re.fullmatch(r'[0-9A-F]{16}',p) or int(p,16)==0 for p in ids+pids):raise ValueError('Malformed/zero persistent identity')
    if s.get('reported_track_count',len(ts))!=len(ts) or s.get('reported_playlist_count',len(ps))!=len(ps):raise ValueError('Native Count/enumeration mismatch')
    master=[p for p in ps if p['kind']==1]
    if len(master)!=1 or master[0]['persistent_id']!=s['library_persistent_id']:raise ValueError('Master identity missing')
    if collections.Counter(m['persistent_id'] for m in master[0]['members'])!=collections.Counter(ids):raise ValueError('Master closure')
    if any(m['persistent_id'] not in ids for p in ps for m in p['members']):raise ValueError('Dangling visible membership')

def differences(a,b):
    errors=[]
    for k in ['version','library_persistent_id','track_count']:
        if a[k]!=b[k]:errors.append(dict(property=k,expected=a[k],actual=b[k]))
    aa={x['persistent_id']:x for x in a['tracks']};bb={x['persistent_id']:x for x in b['tracks']}
    if aa.keys()!=bb.keys():errors.append(dict(property='track_ids'))
    for p in aa.keys()&bb.keys():
        for k,v in aa[p].items():
            if k not in SESSION and v!=bb[p].get(k):errors.append(dict(track=p,property=k,expected=v,actual=bb[p].get(k)))
    aa={p['persistent_id']:p for p in a['playlists']};bb={p['persistent_id']:p for p in b['playlists']}
    if aa.keys()!=bb.keys():errors.append(dict(property='playlist_ids'))
    for pid in aa.keys()&bb.keys():
        x,y=aa[pid],bb[pid]
        for k in ['name','kind','special_kind','Smart','parent_persistent_id']:
            if x.get(k)!=y.get(k):errors.append(dict(playlist=pid,property=k,expected=x.get(k),actual=y.get(k)))
        ordered=x['kind']==2 and x.get('special_kind')==0 and x.get('Smart') is False
        conv=lambda p: [m['persistent_id'] for m in sorted(p['members'],key=lambda m:m['play_order_index'])] if ordered else sorted(m['persistent_id'] for m in p['members'])
        if conv(x)!=conv(y):errors.append(dict(playlist=pid,property='members'))
    return errors

def worker(spec,out):
    s=read(spec);r=dict(started_utc=now(),classification='native_discovery_oracle',independent_writer_acceptance=False,spec=s);app=None
    try:
        pythoncom.CoInitialize();app=win32com.client.dynamic.Dispatch('iTunes.Application')
        if app.Version!='12.13.10.3' or app.LibraryPlaylist.Tracks.Count!=s['expected_before']:raise ValueError('Preliminary identity/count gate')
        r['before']=full(app);shape(r['before'])
        if s.get('expected_master') and r['before']['library_persistent_id']!=s['expected_master']:raise ValueError('Wrong selected master')
        if s.get('expected_state'):
            r['pre_errors']=differences(read(s['expected_state']),r['before'])
            if r['pre_errors']:raise ValueError('Predeclared state mismatch')
        r['media_before']=[facts(t['Location']) for t in r['before']['tracks']]
        action=s.get('action',{'kind':'snapshot'});r['explicit_action']=action
        if action['kind']=='add_files':
            for p in action['paths']:
                scoped(p,FIX)
                if facts(p)['sha256']!=s['media_sha256'][str(p)]:raise ValueError('Media pin mismatch')
        if action['kind'] not in ('snapshot','add_files') and not s.get('expected_state'):raise ValueError('Mutation requires a frozen pre-state')
        from oracle_actions import apply
        r['action_observation']=apply(app,action,FIX)
        r['immediate_after']=full(app);shape(r['immediate_after'])
        dwell=float(s.get('dwell_seconds',3))
        if not 0<=dwell<=120:raise ValueError('Unbounded dwell')
        time.sleep(dwell);r['after']=full(app);shape(r['after'])
        if r['after']['track_count']!=s['expected_after']:raise ValueError('After-count mismatch')
        r['stability_errors']=differences(r['immediate_after'],r['after'])
        if r['stability_errors']:raise ValueError('Lazy drift observed')
        if action['kind']=='snapshot':
            r['passive_errors']=differences(read(s['expected_state']) if s.get('expected_state') else r['before'],r['after'])
            if r['passive_errors']:raise ValueError('Passive state changed')
        r['media_after']=[facts(t['Location']) for t in r['after']['tracks']]
        r['media_original_paths_after']=[facts(p['path']) for p in r['media_before']]
        r['media_original_paths_unchanged']=r['media_before']==r['media_original_paths_after']
        r['action_differences']=differences(r['before'],r['after'])
        if action['kind']=='snapshot' and not r['media_original_paths_unchanged']:raise ValueError('Media changed during passive observation')
        if r['after']['sound_volume']!=r['before']['sound_volume']:raise ValueError('Unexpected sound volume change')
        r['ok']=True;app.Quit();r['quit_returned']=True
    except Exception as e:r.update(ok=False,error=str(e),traceback=traceback.format_exc());raise
    finally:
        r['completed_utc']=now();write(out,r)
        print(json.dumps(dict(ok=r.get('ok'),count=r.get('after',{}).get('track_count'),master=r.get('after',{}).get('library_persistent_id'),error=r.get('error')),ensure_ascii=True),flush=True)

def controller(spec):
    s=read(spec);live=scoped(s['live'],FIX);out=scoped(s['out'],REPORT);out.mkdir(parents=True,exist_ok=False)
    r=dict(started_utc=now(),spec=s,classification='native_discovery_oracle',ui=[],native_acceptance=False);h=None;proc=None
    try:
        if datetime.datetime.now(datetime.timezone.utc)>=datetime.datetime.fromisoformat('2026-09-10T05:15:00+00:00'):raise ValueError('Native cutoff')
        if facts(EXE)['sha256']!=PIN:raise ValueError('EXE changed')
        r['prelaunch']=facts(live)
        if s.get('existing_identity'):
            ident=s['existing_identity'];pid=ident['pid']
            if identity(pid)!=ident:raise ValueError('Existing process identity changed')
        else:
            require_stopped();proc=subprocess.Popen([str(EXE)],cwd=str(W),stdin=subprocess.DEVNULL,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL);pid=proc.pid
        r['identity']=identity(pid);write(out/'owned-native.json',r['identity'])
        h=win32api.OpenProcess(0x100000|0x410,False,pid)
        class View:
            def __init__(self):self.pid=pid
            def poll(self):
                c=win32process.GetExitCodeProcess(h);return None if c==259 else c
            @property
            def returncode(self):return self.poll()
        wait_ready(View(),r['ui'])
        write(out/'spec.json',s)
        cmd=[sys.executable,'-B','-u',str(pathlib.Path(__file__)),'worker','--spec',str(out/'spec.json'),'--out',str(out/'com.json')];r['worker_command']=cmd
        with (out/'worker.log').open('x',encoding='utf-8') as f:p=subprocess.run(cmd,cwd=W,stdout=f,stderr=subprocess.STDOUT,timeout=float(s.get('dwell_seconds',3))+100)
        r['worker_exit_code']=p.returncode
        if p.returncode:raise RuntimeError('Worker failed: '+str(out/'worker.log'))
        if win32event.WaitForSingleObject(h,45000)!=0:raise TimeoutError('Normal Quit not complete')
        r['native_exit_code']=win32process.GetExitCodeProcess(h)
        if r['native_exit_code']!=0:raise RuntimeError('Native nonzero exit')
        require_stopped();dest=scoped(s['snapshot'],FIX);data=live.read_bytes()
        if data[:4]!=b'hdfm' or int.from_bytes(data[8:12],'big')!=len(data):raise ValueError('Bad saved envelope')
        with dest.open('xb') as f:f.write(data)
        r['saved']=facts(dest);r['file_persistent_id']=data[0x34:0x3c].hex().upper();com=read(out/'com.json');r['observed']=com['after'];r['ok']=True
        write(out/'expected-after.json',com['after'])
    except Exception as e:r.update(ok=False,error=str(e),traceback=traceback.format_exc());raise
    finally:
        if h:
            r['native_poll']=win32process.GetExitCodeProcess(h);h.Close()
        r['completed_utc']=now();write(out/'result.json',r)
        print(json.dumps({k:r.get(k) for k in ['ok','error','saved','file_persistent_id','worker_exit_code','native_exit_code']},ensure_ascii=True),flush=True)
    return r
if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('mode',choices=['worker','controller']);p.add_argument('--spec',required=True);p.add_argument('--out');a=p.parse_args()
    if a.mode=='worker':worker(a.spec,a.out)
    else:controller(a.spec)
