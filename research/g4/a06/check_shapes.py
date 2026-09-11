import json
from collections import Counter, defaultdict
from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
S = json.loads((ROOT / "research/g4/a06/out/playlist-survey.json").read_text())

OFFKEYS = {"start", "end", "offset", "pos", "body_start", "body_end", "span"}

def strip(o):
    if isinstance(o, dict):
        return {k: strip(v) for k, v in sorted(o.items()) if k not in OFFKEYS}
    if isinstance(o, list):
        return [strip(v) for v in o]
    return o

raw = defaultdict(set)
stripped = defaultdict(set)
for rec in S["files"]:
    for pl in rec["playlists"]:
        for m in pl["metadata"]:
            if m["code"] == 101 and m.get("smart_tree"):
                k = (pl["special_kind"], pl["name"])
                raw[k].add(json.dumps(m["smart_tree"], sort_keys=True))
                stripped[k].add(json.dumps(strip(m["smart_tree"]), sort_keys=True))
print("smart tree shapes raw vs offset-stripped:")
for k in sorted(raw):
    print(f"   {k}: raw={len(raw[k])} stripped={len(stripped[k])}")
sample = json.loads(sorted(raw[(1024, 'Music')])[0])
print("sample smart_tree keys:", sorted(sample.keys()))
print("sample rule keys:", sorted(sample["rules"][0].keys()) if sample["rules"] else None)

sec = defaultdict(Counter)
for rec in S["files"]:
    for s in rec["sections"]:
        sec[s["kind"]][(s["declared_count"], s["playlists"])] += 1
print("section (declared,parsed) by kind:")
for k in sorted(sec):
    print(f"   kind={k}: {dict(sec[k])}")

meta = Counter()
for rec in S["files"]:
    for pl in rec["playlists"]:
        for m in pl["metadata"]:
            meta[(m["code"], m.get("encoding"), m["size"] if "size" in m else None)] += 1
print("metadata (code,encoding,size) census:")
for k, v in sorted(meta.items(), key=lambda kv: (kv[0][0], -kv[1])):
    print("   ", k, v)

opq = Counter()
diags = Counter()
for rec in S["files"]:
    for d in rec["diags"]:
        diags[d["code"] if isinstance(d, dict) else d] += 1
    for pl in rec["playlists"]:
        opq[len(pl["opaque_children"])] += 1
        for d in pl["diags"]:
            diags[d["code"] if isinstance(d, dict) else d] += 1
print("opaque children per playlist:", dict(opq))
print("diagnostics:", dict(diags))
