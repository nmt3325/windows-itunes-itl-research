import sys
from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT))
from itlkit import playlist_models as pm, Library, UnsupportedError
from itlkit.operations import require_plain

FIXTURES = [
    "evidence/native/snapshots/037-final-three-reloaded.itl",
    "evidence/native/snapshots/033-playlist-order.itl",
    "evidence/native/snapshots/072-codec-playlist-create-reload2.itl",
    "evidence/native/snapshots/074-codec-playlist-create-from-master-reload1.itl",
    "evidence/native/donor32/donor032-imported.itl",
]


def sb(sp):
    return bytes(sp.read())


def records(data):
    doc = pm.inspect_playlists(data)
    out = {}
    for s in doc.sections:
        for p in s.playlists:
            pid = {f.name: f.value for f in p.fields}["persistent_id"]
            out[pid] = sb(p.raw)
    return doc, out


for path in FIXTURES:
    fp = ROOT / path
    if not fp.exists():
        print("MISSING", path)
        continue
    raw = fp.read_bytes()
    lib = Library.from_bytes(raw)
    print(f"{Path(path).stem}: to_bytes==input {lib.to_bytes() == raw}")
    for p in lib.playlists:
        if p.is_master or p.is_smart:
            continue
        try:
            require_plain(p)
            verdict = "OK"
        except UnsupportedError as exc:
            verdict = f"REFUSED({exc})"
        print(f"   {p.name!r} is_plain={p.is_plain} is_smart={p.is_smart} require_plain={verdict}")
    for p in lib.playlists:
        if p.is_smart:
            try:
                p.rename("x")
                print(f"   !! rename allowed on smart {p.name!r}")
            except UnsupportedError as exc:
                print(f"   rename refused on smart {p.name!r}: {str(exc)[:60]}")
            break

print()
src = ROOT / FIXTURES[0]
raw = src.read_bytes()
_, before = records(raw)
lib = Library.from_bytes(raw)
target = [p for p in lib.playlists if p.is_plain and not p.is_master][0]
tpid = target.persistent_id
print("rename target", target.name, hex(tpid) if isinstance(tpid, int) else tpid)
target.rename("A06 Renamed 名前")
after_bytes = lib.to_bytes()
_, after = records(after_bytes)
print("same pid set:", set(before) == set(after))
changed = [pid for pid in before if before[pid] != after.get(pid)]
print("changed records:", [f"{p:016X}" for p in changed])
print("unchanged count:", sum(1 for pid in before if before[pid] == after.get(pid)))

# metadata bodies of non-target playlists identical?

doc_b = pm.inspect_playlists(raw)
doc_a = pm.inspect_playlists(after_bytes)


def metamap(doc):
    m = {}
    for s in doc.sections:
        for p in s.playlists:
            pid = {f.name: f.value for f in p.fields}["persistent_id"]
            m[pid] = [(x.type_code, sb(x.payload)) for x in p.metadata]
    return m


mb, ma = metamap(doc_b), metamap(doc_a)
diff_codes = set()
for pid in mb:
    if mb[pid] != ma.get(pid):
        for (c1, b1), (c2, b2) in zip(mb[pid], ma[pid]):
            if (c1, b1) != (c2, b2):
                diff_codes.add((f"{pid:016X}", c1))
print("metadata payload diffs after rename:", sorted(diff_codes))

# replace members
lib2 = Library.from_bytes(raw)
target2 = [p for p in lib2.playlists if p.is_plain and not p.is_master][0]
track_pids = [t.persistent_id for t in lib2.tracks][:2]
print("track pids sample:", [f"{t:016X}" if isinstance(t, int) else t for t in track_pids])
lib2.replace_playlist_members(target2.persistent_id, track_pids)
rep = lib2.to_bytes()
_, after2 = records(rep)
changed2 = [pid for pid in before if before[pid] != after2.get(pid)]
print("changed records after replace_members:", [f"{p:016X}" for p in changed2])
