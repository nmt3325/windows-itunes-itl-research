"""Exact native library picker, bounded and new-only.
select(destination, mode, output_dir) leaves one owned native process for the
oracle controller. Modes: create (new directory) or open (existing ITL).
"""
import ctypes,datetime,pathlib,subprocess,time,traceback
from ctypes import wintypes
import win32con,win32gui
import native_oracle as n

def select(destination, mode, output_dir):
    if mode not in ('create', 'open'):
        raise ValueError('Unknown chooser mode')
    dest = n.scoped(destination, n.FIX)
    out = n.scoped(output_dir, n.REPORT)
    out.mkdir(parents=True, exist_ok=False)
    r = dict(mode=mode, destination=str(dest), started_utc=n.now(), events=[])
    proc = None
    try:
        n.require_stopped()
        cutoff = datetime.datetime.fromisoformat('2026-09-10T05:15:00+00:00')
        if datetime.datetime.now(datetime.timezone.utc) >= cutoff:
            raise ValueError('Native cutoff')
        if n.facts(n.EXE)['sha256'] != n.PIN:
            raise ValueError('EXE hash mismatch')
        if mode == 'create' and dest.exists():
            raise ValueError('Create target exists')
        if mode == 'open':
            r['input'] = n.facts(dest)
        ctypes.windll.user32.keybd_event(0x10, 0, 0, 0)
        try:
            proc = subprocess.Popen([str(n.EXE)], cwd=n.W, stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            r['identity'] = n.identity(proc.pid)
            n.write(out/'owned-native.json', r['identity'])
            deadline = time.monotonic() + 15
            chooser = []
            while time.monotonic() < deadline:
                ws = [w for w in n.desktop() if w['pid'] == proc.pid]
                chooser = [w for w in ws if any(c['text'] == 'Choose iTunes Library' for c in w['children'])]
                if chooser:
                    break
                if proc.poll() is not None:
                    raise RuntimeError('Native exited before chooser')
                time.sleep(.2)
            if len(chooser) != 1:
                raise RuntimeError('Exact chooser not observed')
        finally:
            ctypes.windll.user32.keybd_event(0x10, 0, 2, 0)
        w = chooser[0]
        r['events'].append({'chooser': w})
        wanted = 102 if mode == 'create' else 101
        label = 'Create &Library\u2026' if mode == 'create' else '&Choose Library\u2026'
        bs = [c for c in w['children'] if c['class'] == 'Button' and c['id'] == wanted and c['text'] == label and c['visible'] and c['enabled']]
        if len(bs) != 1:
            raise RuntimeError('Ambiguous chooser button')
        win32gui.PostMessage(bs[0]['hwnd'], win32con.BM_CLICK, 0, 0)
        deadline = time.monotonic() + 10
        ds = []
        title = 'New iTunes Library' if mode == 'create' else 'Open iTunes Library'
        while time.monotonic() < deadline:
            ds = [w for w in n.desktop() if w['pid'] == proc.pid and w['class'] == '#32770' and w['title'] == title]
            if ds:
                break
            time.sleep(.2)
        if len(ds) != 1:
            raise RuntimeError('Exact path dialog not observed')
        w = ds[0]
        r['events'].append({'path_dialog': w})
        edit_id = 1001 if mode == 'create' else 1148
        es = [c for c in w['children'] if c['class'] == 'Edit' and c['id'] == edit_id and c['visible']]
        allowed = ['&Save', 'Save'] if mode == 'create' else ['&Open', 'Open']
        bs = [c for c in w['children'] if c['class'] == 'Button' and c['id'] == 1 and c['text'] in allowed and c['visible']]
        if len(es) != 1 or len(bs) != 1:
            raise RuntimeError('Ambiguous filename/action controls')
        send = ctypes.windll.user32.SendMessageW
        send.argtypes = [wintypes.HWND, wintypes.UINT, wintypes.WPARAM, wintypes.LPARAM]
        send.restype = wintypes.LPARAM
        text = ctypes.create_unicode_buffer(str(dest))
        send(es[0]['hwnd'], win32con.WM_SETTEXT, 0, ctypes.addressof(text))
        buf = ctypes.create_unicode_buffer(4096)
        send(es[0]['hwnd'], win32con.WM_GETTEXT, 4096, ctypes.addressof(buf))
        if buf.value != str(dest):
            raise RuntimeError('Filename verification failed')
        r['verified_picker_path'] = buf.value
        win32gui.PostMessage(bs[0]['hwnd'], win32con.BM_CLICK, 0, 0)
        deadline = time.monotonic() + 8
        while win32gui.IsWindow(w['hwnd']) and win32gui.IsWindowVisible(w['hwnd']) and time.monotonic() < deadline:
            time.sleep(.1)
        if win32gui.IsWindow(w['hwnd']) and win32gui.IsWindowVisible(w['hwnd']):
            raise RuntimeError('Path dialog did not close')
        n.wait_ready(proc, r['events'])
        live = dest/'iTunes Library.itl' if mode == 'create' else dest
        r['live'] = n.facts(live)
        r['selected'] = True
        r['native_still_owned'] = True
    except Exception as e:
        r.update(selected=False, error=str(e), traceback=traceback.format_exc())
        raise
    finally:
        r['completed_utc'] = n.now()
        if proc:
            r['native_poll'] = proc.poll()
            r['last_windows'] = [w for w in n.desktop() if w['pid'] == proc.pid]
        n.write(out/'result.json', r)
    return r
