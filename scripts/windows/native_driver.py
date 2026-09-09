"""Native fixture supervisor. Serial UI owner, bounded worker/exit waits, immutable case evidence."""
import argparse,array,hashlib,json,math,pathlib,subprocess,sys,time,wave
import win32con,win32gui,win32process
from desktop_probe import snapshot

EXE=pathlib.Path(r'C:\Program Files\iTunes\iTunes.exe')

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()

def wait_ready(proc,log):
    limit=time.monotonic()+45
    while time.monotonic()<limit:
        if proc.poll() is not None:raise RuntimeError(f'iTunes exited during startup: {proc.returncode}')
        windows=[w for w in snapshot() if w['pid']==proc.pid]
        for w in windows:
            texts=' '.join(c['text'] for c in w['children'])
            if 'problem with your audio configuration' in texts:
                buttons=[c for c in w['children'] if c['id']==1 and c['class']=='Button' and c['text']=='OK']
                if len(buttons)==1:
                    log.append({'action':'dismiss_audio_warning','pid':proc.pid,'window':w});win32gui.PostMessage(buttons[0]['hwnd'],win32con.BM_CLICK,0,0);time.sleep(.25)
            elif w['class']=='iTunesCustomModalDialog' or w['class']=='#32770':
                log.append({'action':'unexpected_modal','window':w})
                raise RuntimeError('Unexpected modal; never auto-dismiss damaged-library or cloud prompts')
        if any(w['class']=='iTunes' for w in windows):time.sleep(.8);return
        time.sleep(.25)
    log.append({'timeout_windows':snapshot()});raise TimeoutError('iTunes main UI not ready in 45s')

def generate_media(root):
    media=root/'media';media.mkdir(exist_ok=True)
    for name,hz in [('alpha',440),('beta',660),('gamma',880)]:
        p=media/(name+'.wav')
        if p.exists():continue
        samples=array.array('h',(int(5000*math.sin(2*math.pi*hz*i/44100)) for i in range(44100)))
        if sys.byteorder!='little':samples.byteswap()
        with wave.open(str(p),'wb') as f:f.setparams((1,2,44100,44100,'NONE','not compressed'));f.writeframes(samples.tobytes())
    return {p.name:{'sha256':sha(p),'bytes':p.stat().st_size} for p in media.glob('*.wav')}

def run_case(root,report,case):
    name=case['name'];out=report/'native-runs'/name;out.mkdir(parents=True,exist_ok=False)
    ui=[];result={'name':name,'case':case,'started':time.time(),'ui':ui};proc=None
    try:
        windows=snapshot()
        if any(w['class'] in ('iTunes','iTunesCustomModalDialog') for w in windows):raise RuntimeError('iTunes already running; refusing duplicate launch')
        live=root/'live'/'iTunes Library.itl';result['prelaunch_sha256']=sha(live)
        proc=subprocess.Popen([str(EXE)],stdin=subprocess.DEVNULL,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL);result['itunes_pid']=proc.pid;wait_ready(proc,ui)
        action_file=out/'action.json';action_file.write_text(json.dumps(case.get('action',{'kind':'snapshot'}),ensure_ascii=False,indent=2),encoding='utf-8')
        cmd=[sys.executable,'-u',str(pathlib.Path(__file__).with_name('native_worker.py')),'--root',str(root),'--output',str(out/'com.json'),'--action',str(action_file),'--quit','--expect-count',str(case['expected_before'])]
        if case.get('expected_state'):cmd+=['--expect-state',str(case['expected_state'])]
        result['worker_command']=cmd
        with (out/'worker.log').open('w',encoding='utf-8') as log:
            worker=subprocess.run(cmd,stdout=log,stderr=subprocess.STDOUT,timeout=100)
        result['worker_exit_code']=worker.returncode
        if worker.returncode:raise RuntimeError(f'COM worker failed: {worker.returncode}; inspect {out}/worker.log')
        proc.wait(timeout=30);result['itunes_exit_code']=proc.returncode
        if proc.returncode:raise RuntimeError('iTunes native process exited nonzero')
        time.sleep(.4);data=live.read_bytes();assert data.startswith(b'hdfm')
        destination=root/'snapshots'/(name+'.itl');assert not destination.exists();destination.write_bytes(data)
        com=json.loads((out/'com.json').read_text(encoding='utf-8'));result['fixture_path']=str(destination);result['fixture_sha256']=sha(destination);result['fixture_bytes']=len(data);result['observed']=com['after'];result['status']='passed'
        if 'expected_after' in case and com['after']['track_count']!=case['expected_after']:raise RuntimeError('Final count mismatch')
    except Exception as e:
        result['status']='failed';result['error']=repr(e)
        if proc:result['itunes_poll']=proc.poll()
        (out/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');raise
    (out/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps({'name':name,'status':result['status'],'fixture':result['fixture_path'],'bytes':result['fixture_bytes'],'sha256':result['fixture_sha256'],'count':result['observed']['track_count']}),flush=True)
    return result

def main():
    p=argparse.ArgumentParser();p.add_argument('--root',required=True,type=pathlib.Path);p.add_argument('--report',required=True,type=pathlib.Path);p.add_argument('--plan',type=pathlib.Path);p.add_argument('--initial',action='store_true');a=p.parse_args()
    if a.initial:
        generate_media(a.root)
        cases=[{'name':'001-one-track','expected_before':0,'expected_after':1,'action':{'kind':'add_files','paths':[str(a.root/'media/alpha.wav')]}},{'name':'002-three-tracks','expected_before':1,'expected_after':3,'action':{'kind':'add_files','paths':[str(a.root/'media/beta.wav'),str(a.root/'media/gamma.wav')]}}]
    else:cases=json.loads(a.plan.read_text(encoding='utf-8'))
    for case in cases:run_case(a.root,a.report,case)
if __name__=='__main__':main()
