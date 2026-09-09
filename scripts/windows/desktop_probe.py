"""Inspect the disposable Windows desktop; optionally launch or click explicit handles."""
import argparse, ctypes, json, pathlib, subprocess, time
import win32gui, win32process, win32con

def snapshot():
    windows=[]
    def top(h, _):
        if not win32gui.IsWindowVisible(h): return
        title=win32gui.GetWindowText(h)
        if not title: return
        children=[]
        def child(c, _):
            children.append({'hwnd':c,'class':win32gui.GetClassName(c),'text':win32gui.GetWindowText(c),'id':win32gui.GetDlgCtrlID(c),'enabled':bool(win32gui.IsWindowEnabled(c)),'visible':bool(win32gui.IsWindowVisible(c))})
        win32gui.EnumChildWindows(h,child,None)
        windows.append({'hwnd':h,'pid':win32process.GetWindowThreadProcessId(h)[1],'class':win32gui.GetClassName(h),'title':title,'children':children})
    win32gui.EnumWindows(top,None)
    return windows

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--launch',action='store_true');ap.add_argument('--shift',action='store_true');ap.add_argument('--click',type=int);ap.add_argument('--output',type=pathlib.Path,required=True);ap.add_argument('--wait',type=float,default=2);a=ap.parse_args();result={}
    if a.launch:
        if a.shift: ctypes.windll.user32.keybd_event(0x10,0,0,0)
        try:
            p=subprocess.Popen([r'C:\Program Files\iTunes\iTunes.exe'],stdin=subprocess.DEVNULL,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL)
            result['launched_pid']=p.pid
            time.sleep(a.wait)
        finally:
            if a.shift: ctypes.windll.user32.keybd_event(0x10,0,2,0)
    if a.click:
        if not win32gui.IsWindow(a.click): raise RuntimeError('Invalid window handle')
        result['clicked']={'hwnd':a.click,'text':win32gui.GetWindowText(a.click)}
        win32gui.PostMessage(a.click,win32con.BM_CLICK,0,0)
    time.sleep(a.wait);result['windows']=snapshot();a.output.parent.mkdir(parents=True,exist_ok=True);a.output.write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps(result,ensure_ascii=True,indent=2),flush=True)
if __name__=='__main__':main()
