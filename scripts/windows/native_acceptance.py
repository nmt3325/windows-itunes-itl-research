"""Two native save/reload cycles for hash-pinned independent writer candidates."""
import argparse,hashlib,json,pathlib,re,traceback
import win32api,win32process
from native_driver import run_case

def digest(data):return hashlib.sha256(data).hexdigest()
def require_stopped():
    found=[]
    for pid in win32process.EnumProcesses():
        h=None
        try:
            h=win32api.OpenProcess(0x0400|0x0010,False,pid)
            if pathlib.Path(win32process.GetModuleFileNameEx(h,0)).name.lower()=='itunes.exe':found.append(pid)
        except Exception:pass
        finally:
            if h:h.Close()
    if found:raise RuntimeError(f'iTunes still running; never replace a live library: {found}')

def accept(root,report,case):
    name=case['name']
    if not re.fullmatch(r'[A-Za-z0-9_-]+',name):raise ValueError('Unsafe case name')
    out=report/'acceptance'/name;out.mkdir(parents=True,exist_ok=False);result={'name':name,'candidate':case['candidate'],'expected_sha256':case['sha256'],'status':'started','cycles':[]}
    try:
        require_stopped();candidate=pathlib.Path(case['candidate']);data=candidate.read_bytes()
        if digest(data)!=case['sha256']:raise ValueError('Candidate hash changed since handoff')
        if data[:4]!=b'hdfm':raise ValueError('Not hdfm')
        pinned=root/'candidates'/(name+'.itl');pinned.parent.mkdir(parents=True,exist_ok=True)
        with pinned.open('xb') as f:f.write(data)
        live=root/'live/iTunes Library.itl';old=live.read_bytes();result['previous_live_sha256']=digest(old)
        with (out/'pretest-library.itl').open('xb') as f:f.write(old)
        expected=out/'expected.json';expected.write_text(json.dumps(case['expected'],ensure_ascii=False,indent=2),encoding='utf-8')
        temp=live.with_name(live.name+'.'+name+'.tmp')
        with temp.open('xb') as f:f.write(data)
        require_stopped()
        if digest(live.read_bytes())!=digest(old):raise RuntimeError('Live library changed while preparing candidate')
        temp.replace(live);result['staged_sha256']=digest(live.read_bytes())
        for cycle in (1,2):
            c={'name':name+'-reload'+str(cycle),'expected_before':case['expected']['track_count'],'expected_after':case['expected']['track_count'],'expected_state':str(expected),'action':{'kind':'snapshot'}}
            r=run_case(root,report,c);result['cycles'].append({'name':r['name'],'fixture_path':r['fixture_path'],'fixture_sha256':r['fixture_sha256'],'prelaunch_sha256':r['prelaunch_sha256'],'itunes_exit_code':r['itunes_exit_code'],'worker_exit_code':r['worker_exit_code'],'library_persistent_id':r['observed']['library_persistent_id'],'track_persistent_ids':[t['persistent_id'] for t in r['observed']['tracks']]})
            if cycle==1 and r['prelaunch_sha256']!=case['sha256']:raise RuntimeError('Native opened the wrong input file')
            if cycle==2 and r['prelaunch_sha256']!=result['cycles'][0]['fixture_sha256']:raise RuntimeError('Second native cycle did not use first native save')
            expected=out/('expected-after-cycle'+str(cycle)+'.json');expected.write_text(json.dumps(r['observed'],ensure_ascii=False,indent=2),encoding='utf-8')
        result['status']='passed';result['native_acceptance']=True;result['note']='Both full-state gates passed inside bounded COM workers before native Quit; both actual native processes exited zero. No unexpected modal was dismissed.'
    except Exception as e:
        result.update(status='failed',native_acceptance=False,error=str(e),traceback=traceback.format_exc());(out/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');raise
    (out/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps(result,ensure_ascii=True),flush=True);return result

def main():
    p=argparse.ArgumentParser();p.add_argument('--root',type=pathlib.Path,required=True);p.add_argument('--report',type=pathlib.Path,required=True);p.add_argument('--manifest',type=pathlib.Path,required=True);a=p.parse_args()
    for case in json.loads(a.manifest.read_text(encoding='utf-8')):accept(a.root,a.report,case)
if __name__=='__main__':main()
