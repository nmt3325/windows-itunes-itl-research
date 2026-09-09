"""Bounded Frida tracing; no patches and no original media involved."""
import argparse,hashlib,json,pathlib,threading,time,frida

def main():
    ap=argparse.ArgumentParser();g=ap.add_mutually_exclusive_group(required=True);g.add_argument('--pid',type=int);g.add_argument('--spawn',action='store_true');ap.add_argument('--out',type=pathlib.Path,required=True);ap.add_argument('--seconds',type=int,default=240);a=ap.parse_args();a.out.mkdir(parents=True,exist_ok=True)
    log=(a.out/'events.jsonl').open('x',encoding='utf-8');lock=threading.Lock();serial=0;size=0;detached=threading.Event()
    def message(msg,data):
        nonlocal serial,size
        with lock:
            serial+=1;rec={'seq':serial,'time':time.time(),'message':msg}
            if data:
                size+=len(data);rec.update(bytes=len(data),sha256=hashlib.sha256(data).hexdigest())
                if size<=134217728:
                    name=f'{serial:06d}.bin';(a.out/name).write_bytes(data);rec['blob']=name
                else:rec['capture_omitted']='128MiB budget'
            log.write(json.dumps(rec,ensure_ascii=False)+'\n');log.flush()
            if msg.get('type')=='error' or msg.get('payload',{}).get('kind') in ['ready','module']:print(json.dumps(rec),flush=True)
    device=frida.get_local_device()
    if a.spawn:
        from desktop_probe import snapshot
        if any(w['class'] in ('iTunes','iTunesCustomModalDialog') for w in snapshot()):raise RuntimeError('iTunes already running; refusing spawn')
        a.pid=device.spawn([r'C:\Program Files\iTunes\iTunes.exe'])
    try:
        session=device.attach(a.pid);session.on('detached',lambda *args:detached.set());script=session.create_script(pathlib.Path(__file__).with_suffix('.js').read_text(encoding='utf-8'));script.on('message',message);script.load();print('TRACE_ATTACHED',a.pid,flush=True)
        (a.out/'process.json').write_text(json.dumps({'pid':a.pid,'spawned':a.spawn}),encoding='utf-8')
    finally:
        if a.spawn:device.resume(a.pid)
    deadline=time.monotonic()+a.seconds
    while time.monotonic()<deadline and not detached.is_set() and not (a.out/'STOP').exists():time.sleep(.25)
    try:session.detach()
    except frida.InvalidOperationError:pass
    log.close();print(json.dumps({'events':serial,'captured_bytes':size,'detached':detached.is_set(),'completed':True}),flush=True)
if __name__=='__main__':main()
