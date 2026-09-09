"""Attach after ordinary iTunes startup; trace one synthetic native save."""
import argparse,json,pathlib,subprocess,sys,time,traceback
from native_driver import EXE,wait_ready,sha
from native_acceptance import require_stopped

def main():
    p=argparse.ArgumentParser();p.add_argument('--root',type=pathlib.Path,required=True);p.add_argument('--report',type=pathlib.Path,required=True);p.add_argument('--name',required=True);p.add_argument('--action',type=pathlib.Path,required=True);p.add_argument('--expected',type=pathlib.Path,required=True);a=p.parse_args();out=a.report/'traced-runs'/a.name;out.mkdir(parents=True,exist_ok=False)
    scripts=pathlib.Path(__file__).parent;ui=[];result={'name':a.name,'ui':ui,'status':'started'};native=None;collector=None;log=None
    try:
        require_stopped();live=a.root/'live/iTunes Library.itl';result['prelaunch_sha256']=sha(live);native=subprocess.Popen([str(EXE)],stdin=subprocess.DEVNULL,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL);result['itunes_pid']=native.pid;wait_ready(native,ui)
        expected=json.loads(a.expected.read_text(encoding='utf-8'));expected=expected.get('after',expected);ep=out/'expected.json';ep.write_text(json.dumps(expected,ensure_ascii=False,indent=2),encoding='utf-8')
        base=[sys.executable,'-u',str(scripts/'native_worker.py'),'--root',str(a.root),'--expect-count',str(expected['track_count']),'--expect-state',str(ep)]
        with (out/'worker-before.log').open('w',encoding='utf-8') as f:subprocess.run(base+['--output',str(out/'before.json')],stdout=f,stderr=subprocess.STDOUT,timeout=100,check=True)
        trace=out/'trace';log=(out/'collector.log').open('w',encoding='utf-8');collector=subprocess.Popen([sys.executable,'-u',str(scripts/'trace_itunes.py'),'--pid',str(native.pid),'--out',str(trace),'--seconds','150'],stdin=subprocess.DEVNULL,stdout=log,stderr=subprocess.STDOUT)
        limit=time.monotonic()+25
        while not (trace/'process.json').exists():
            if collector.poll() is not None:raise RuntimeError('Collector exited before attach')
            if time.monotonic()>limit:raise TimeoutError('Collector attach timeout')
            time.sleep(.1)
        info=json.loads((trace/'process.json').read_text(encoding='utf-8'));assert info['pid']==native.pid and not info['spawned']
        with (out/'worker-after.log').open('w',encoding='utf-8') as f:subprocess.run(base+['--output',str(out/'after.json'),'--action',str(a.action),'--quit'],stdout=f,stderr=subprocess.STDOUT,timeout=100,check=True)
        native.wait(timeout=30);result['itunes_exit_code']=native.returncode
        if native.returncode:raise RuntimeError('Native nonzero exit')
        collector.wait(timeout=20);result['collector_exit_code']=collector.returncode
        if collector.returncode:raise RuntimeError('Collector nonzero exit')
        destination=a.root/'snapshots'/(a.name+'.itl')
        with destination.open('xb') as f:f.write(live.read_bytes())
        result.update(status='passed',fixture_path=str(destination),fixture_sha256=sha(destination),fixture_bytes=destination.stat().st_size,trace_dir=str(trace))
    except Exception as e:
        result.update(status='failed',error=str(e),traceback=traceback.format_exc())
    finally:
        if collector and collector.poll() is None:
            stop=out/'trace/STOP';stop.write_text('End owned bounded collection',encoding='utf-8')
            try:collector.wait(timeout=15)
            except subprocess.TimeoutExpired:collector.terminate();collector.wait(timeout=10);result['collector_terminated']=True
        if log:log.close()
        if native:result['native_poll_final']=native.poll()
        (out/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps(result,ensure_ascii=True),flush=True)
    if result['status']!='passed':raise SystemExit(1)
if __name__=='__main__':main()
