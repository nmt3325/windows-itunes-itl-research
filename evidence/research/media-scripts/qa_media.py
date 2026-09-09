#!/usr/bin/env python3
"""Read-only candidate QA plus one new QA result file; run Python -B."""
import contextlib
import ctypes
from ctypes import wintypes
import hashlib
import io
import json
from pathlib import Path
import sys
import tracemalloc
import generate_media as g

ROOT = Path(__file__).resolve().parent.parent
SET = ROOT / "pcm-v1"
checks = []
manifest = json.loads((SET / "media-manifest.json").read_text(encoding="utf-8"))
requests = json.loads((SET / "native-requests.json").read_text(encoding="utf-8"))
files = sorted(p for p in SET.rglob("*") if p.is_file())
before = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in files}
tracemalloc.start()
for item in manifest["media"]:
    p = Path(item["path"])
    p.resolve().relative_to(SET.resolve())
    assert p.stat().st_size == item["size_bytes"]
    assert hashlib.sha256(p.read_bytes()).hexdigest() == item["sha256"]
    spec = next(s for s in g.SPECS if s["id"] == item["id"])
    v = g.validate_pcm(p, spec)
    assert v["frames"] == 66150 and v["duration_seconds"] == 1.5
    assert v["sample_rate"] == 44100 and v["channels"] == 1
    assert v["peak_sample"] <= 1638 and v["peak_sample"] > 1600
    assert len(v["readers"]) == 3
    checks.append({"name":item["id"] + "-sha-container-metadata-stdlib-regeneration", "passed":True})
    bad = p.read_bytes()[:20]
    try:
        g.walk_chunks(bad, 12, len(bad), "<" if item["format"] == "wav" else ">")
    except AssertionError:
        checks.append({"name":item["id"] + "-truncated-chunk-rejected", "passed":True})
    else:
        raise AssertionError("truncated chunk accepted")

piece = g.chunk(b"fmt ", b"\0"*16, "<")
try:
    g.walk_chunks(piece + piece, 0, len(piece)*2, "<")
except AssertionError:
    checks.append({"name":"duplicate-chunk-rejected", "passed":True})
else:
    raise AssertionError("duplicate chunk accepted")

bad_id3 = bytearray(g.id3(g.SPECS[1]["metadata"]))
bad_id3[9] += 1
try:
    g.read_id3(bytes(bad_id3))
except AssertionError:
    checks.append({"name":"id3-size-mismatch-rejected", "passed":True})
else:
    raise AssertionError("bad ID3 accepted")

old_argv = sys.argv[:]
try:
    sys.argv = [str(ROOT / "scripts" / "generate_media.py"), "--set-name", "pcm-v1"]
    try:
        g.main()
    except FileExistsError:
        checks.append({"name":"existing-output-set-refused", "passed":True})
    else:
        raise AssertionError("existing output set accepted")
    sys.argv = [str(ROOT / "scripts" / "generate_media.py"), "--set-name", ".."]
    with contextlib.redirect_stderr(io.StringIO()):
        try:
            g.main()
        except SystemExit as exc:
            assert exc.code == 2
            checks.append({"name":"out-of-scope-set-name-refused", "passed":True})
        else:
            raise AssertionError("invalid output set accepted")
finally:
    sys.argv = old_argv

for key in ("id", "filename"):
    assert len({m[key] for m in manifest["media"]}) == len(manifest["media"])
for key in ("title", "artist", "album"):
    assert len({m["metadata"][key] for m in manifest["media"]}) == len(manifest["media"])
assert {m["format"] for m in manifest["media"]} == {"wav", "aiff"}
assert {m["format"] for m in manifest["blocked"]} == {"mp3", "aac", "alac"}
assert requests["media_manifest"]["sha256"] == hashlib.sha256((SET / "media-manifest.json").read_bytes()).hexdigest()
assert len(requests["requests"]) == 2
for r,m in zip(requests["requests"],manifest["media"]):
    assert r["media"]["sha256"] == m["sha256"]
    assert r["media"]["path"] == m["path"]
    assert r["candidate_itl"] is None and r["track_pid"] is None
    assert r["native_acceptance"] == "untested"
    assert m["ffprobe"]["status"] == "not_run"
checks.append({"name":"identifiers-and-native-handoff-consistent-with-known-limitations", "passed":True})
after = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in files}
assert before == after
assert not list((ROOT / "scripts").glob("__pycache__"))
checks.append({"name":"all-candidate-and-manifest-bytes-unchanged-no-pycache", "passed":True})
current, peak = tracemalloc.get_traced_memory()
tracemalloc.stop()
resources = {"python_traced_peak_bytes":peak, "budget_bytes":512*1024*1024, "concurrent_encoders":0}
assert peak < resources["budget_bytes"]
if sys.platform == "win32":
    class Counters(ctypes.Structure):
        _fields_ = [("cb",wintypes.DWORD),("PageFaultCount",wintypes.DWORD)] + [(n,ctypes.c_size_t) for n in ("PeakWorkingSetSize","WorkingSetSize","QuotaPeakPagedPoolUsage","QuotaPagedPoolUsage","QuotaPeakNonPagedPoolUsage","QuotaNonPagedPoolUsage","PagefileUsage","PeakPagefileUsage")]
    k = ctypes.WinDLL("kernel32",use_last_error=True)
    p = ctypes.WinDLL("psapi",use_last_error=True)
    k.GetCurrentProcess.restype = wintypes.HANDLE
    p.GetProcessMemoryInfo.argtypes = [wintypes.HANDLE,ctypes.POINTER(Counters),wintypes.DWORD]
    p.GetProcessMemoryInfo.restype = wintypes.BOOL
    c = Counters()
    c.cb = ctypes.sizeof(c)
    if not p.GetProcessMemoryInfo(k.GetCurrentProcess(),ctypes.byref(c),c.cb):
        raise ctypes.WinError(ctypes.get_last_error())
    resources["qa_python_peak_working_set_bytes"] = c.PeakWorkingSetSize
    resources["qa_python_working_set_bytes"] = c.WorkingSetSize
    assert c.PeakWorkingSetSize < resources["budget_bytes"]
checks.append({"name":"bounded-qa-process-memory", "passed":True})
result = {"status":"passed", "test_count":len(checks), "checks":checks, "resources":resources, "media_bytes_total":sum(m["size_bytes"] for m in manifest["media"]), "native_acceptance":"untested", "ffprobe":"not_available_on_runner"}
g.write_json(ROOT / "final-qa.json",result)
print(json.dumps(result,indent=2))
