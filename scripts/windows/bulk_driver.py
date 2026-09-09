"""Supervise synthetic native donor workers; never recover failures by force."""
import argparse, pathlib, subprocess, sys, time, traceback
import win32api, win32con, win32event, win32process
from native_acceptance import require_stopped
from native_driver import EXE, wait_ready
from passive_native import load, write_json, facts, envelope


def run(live,root,report,name,spec,existing_pid=None):
    live=live.resolve();root=root.resolve();assert live.is_relative_to(root)
    out=report/'donor-runs'/name;out.mkdir(parents=True,exist_ok=False)
    spec_path=out/'spec.json';write_json(spec_path,spec)
    result={'name':name,'selected_library':str(live),'started_epoch':time.time(),'startup_ui_events':[],
            'existing_pid':existing_pid,'worker_source':facts(pathlib.Path(__file__).with_name('bulk_native.py'))}
    handle=None
    try:
        if existing_pid:
            native_pid=existing_pid
        else:
            require_stopped();result['prelaunch_file']=facts(live)
            native=subprocess.Popen([EXE],stdin=subprocess.DEVNULL,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL)
            native_pid=native.pid
        result['pid']=native_pid
        handle=win32api.OpenProcess(win32con.PROCESS_QUERY_INFORMATION|win32con.PROCESS_VM_READ|win32con.SYNCHRONIZE,False,native_pid)
        actual_exe=win32process.GetModuleFileNameEx(handle,0)
        assert pathlib.Path(actual_exe).resolve()==pathlib.Path(EXE).resolve()
        result['process_created']=win32process.GetProcessTimes(handle)['CreationTime'].isoformat()
        write_json(out/'result.json',result)
        class ProcessView:
            pid=native_pid
            @property
            def returncode(self):
                code=win32process.GetExitCodeProcess(handle)
                return None if code==259 else code
            def poll(self):return self.returncode
        wait_ready(ProcessView(),result['startup_ui_events'])
        cmd=[sys.executable,'-B','-u',str(pathlib.Path(__file__).with_name('bulk_native.py')),'--spec',str(spec_path),'--out',str(out/'com.json')]
        result['worker_command']=cmd
        with (out/'worker.log').open('w',encoding='utf-8') as log:
            worker=subprocess.run(cmd,stdout=log,stderr=subprocess.STDOUT,timeout=spec.get('worker_timeout_seconds',300))
        result['worker_exit_code']=worker.returncode;com=load(out/'com.json')
        if worker.returncode or not com.get('quit_returned'):raise RuntimeError('Worker did not complete normally; inspect owned native process before recovery')
        wait=win32event.WaitForSingleObject(handle,45000);result['native_wait_result']=wait
        result['itunes_exit_code']=win32process.GetExitCodeProcess(handle)
        assert wait==0 and result['itunes_exit_code']==0
        require_stopped();dest=root/'phase2/snapshots'/(name+'.itl');assert not dest.exists();dest.parent.mkdir(parents=True,exist_ok=True)
        data=live.read_bytes();assert data[:4]==b'hdfm';dest.write_bytes(data)
        result['saved']=facts(dest);result['profile']=envelope(dest);result['file_persistent_id']=data[0x34:0x3c].hex().upper()
        if 'file_pid' in spec:assert result['file_persistent_id']==spec['file_pid']
        result['observed']=com['after'];result['completed']=True;write_json(out/'result.json',result)
        print('DONOR_CYCLE',name,'COUNT',com['after']['track_count'],'FILE_PID',result['file_persistent_id'],'MASTER',com['after']['library_persistent_id'],'BODY',result['profile']['body_bytes'],flush=True)
        return result
    except Exception as e:
        result.update(error=str(e),traceback=traceback.format_exc(),completed=False)
        if handle:result['native_exit_at_error']=win32process.GetExitCodeProcess(handle)
        write_json(out/'result.json',result);raise
    finally:
        if handle:handle.Close()


def main():
    p=argparse.ArgumentParser();p.add_argument('--live',type=pathlib.Path,required=True);p.add_argument('--root',type=pathlib.Path,required=True);p.add_argument('--report',type=pathlib.Path,required=True);p.add_argument('--name',required=True);p.add_argument('--spec',type=pathlib.Path,required=True);p.add_argument('--existing-pid',type=int);a=p.parse_args();run(a.live,a.root,a.report,a.name,load(a.spec),a.existing_pid)
if __name__=='__main__':main()
