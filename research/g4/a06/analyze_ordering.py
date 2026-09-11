#!/usr/bin/env python3
"""a06: membership/ordering series, smart-tree variation, reference disproof."""
from __future__ import annotations

import json
from collections import Counter, defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
OUT = ROOT / "research" / "g4" / "a06" / "out"
SURVEY = json.loads((OUT / "playlist-survey.json").read_text())
FILES = SURVEY["files"]
BYNAME = {rec["file"]: rec for rec in FILES}
result = {}

# --- sections -------------------------------------------------------------
secs = Counter()
for rec in FILES:
    for s in rec["sections"]:
        secs[(s["kind"], s["declared_count"] == s["playlists"])] += 1
result["section_kinds"] = [{"kind": k[0], "declared_matches_parsed": k[1], "count": v}
                           for k, v in sorted(secs.items())]
print("sections:", result["section_kinds"])
print("playlists per file:", sorted(Counter(len(r["playlists"]) for r in FILES).items()))

# --- ordering series ------------------------------------------------------
SERIES = [
    "evidence/native/snapshots/030-playlist-create.itl",
    "evidence/native/snapshots/031-playlist-add.itl",
    "evidence/native/snapshots/032-playlist-rename.itl",
    "evidence/native/snapshots/033-playlist-order.itl",
    "evidence/native/snapshots/034-playlist-remove.itl",
    "evidence/native/snapshots/035-playlist-create-delete.itl",
    "evidence/native/snapshots/036-playlist-delete.itl",
    "evidence/native/snapshots/037-final-three-reloaded.itl",
    "evidence/native/candidates/070-codec-playlist-rename.itl",
    "evidence/native/candidates/071-codec-playlist-members.itl",
    "evidence/native/candidates/072-codec-playlist-create.itl",
    "evidence/native/snapshots/072-codec-playlist-create-reload1.itl",
    "evidence/native/snapshots/072-codec-playlist-create-reload2.itl",
    "evidence/native/candidates/074-codec-playlist-create-from-master.itl",
    "evidence/native/snapshots/074-codec-playlist-create-from-master-reload1.itl",
    "evidence/native/snapshots/074-codec-playlist-create-from-master-reload2.itl",
]
rows = []
for path in SERIES:
    rec = BYNAME.get(path)
    if rec is None:
        rows.append({"file": path, "missing": True})
        print("MISSING", path)
        continue
    for pl in rec["playlists"]:
        if pl["special_kind"] or pl["master_flags_raw"]:
            continue
        row = {
            "file": path, "name": pl["name"],
            "pid": f"{pl['persistent_id']:016X}", "local_id": pl["local_id"],
            "flags18": f"0x{pl['flags_18_raw']:x}",
            "declared_items": pl["entry_count"],
            "tracks": [e["track_id"] for e in pl["entries"]],
            "item_ids": [e["local_id"] for e in pl["entries"]],
            "tokens": [e["order_token"] for e in pl["entries"]],
            "item_pids": [f"{e['pid']:012X}"[-6:] for e in pl["entries"]],
        }
        rows.append(row)
        print(f"{Path(path).stem:52s} {pl['name']!r} pid={row['pid']} lid={pl['local_id']} "
              f"f18={row['flags18']}")
        print(f"    tracks={row['tracks']}")
        print(f"    itemids={row['item_ids']}")
        print(f"    tokens={row['tokens']}")
result["ordinary_series"] = rows

# master membership order vs track order, one file
rec = BYNAME["evidence/native/snapshots/037-final-three-reloaded.itl"]
for pl in rec["playlists"]:
    if pl["master_flags_raw"]:
        print("master 037 tracks:", [e["track_id"] for e in pl["entries"]])
        print("master 037 tokens:", [e["order_token"] for e in pl["entries"]])
        print("master 037 itemids:", [e["local_id"] for e in pl["entries"]])
        result["master_037"] = {
            "tracks": [e["track_id"] for e in pl["entries"]],
            "tokens": [e["order_token"] for e in pl["entries"]],
            "item_ids": [e["local_id"] for e in pl["entries"]],
        }

# --- token/id relationships across every playlist -------------------------
tok_eq_id = tok_ne_id = 0
tok_sorted = tok_unsorted = 0
id_sorted = id_unsorted = 0
for rec in FILES:
    for pl in rec["playlists"]:
        toks = [e["order_token"] for e in pl["entries"]]
        ids = [e["local_id"] for e in pl["entries"]]
        for t, i in zip(toks, ids):
            if t == i:
                tok_eq_id += 1
            else:
                tok_ne_id += 1
        if len(toks) > 1:
            if toks == sorted(toks):
                tok_sorted += 1
            else:
                tok_unsorted += 1
            if ids == sorted(ids):
                id_sorted += 1
            else:
                id_unsorted += 1
result["token_stats"] = {"token_equals_item_id": tok_eq_id, "token_differs": tok_ne_id,
                         "playlists_token_ascending": tok_sorted,
                         "playlists_token_not_ascending": tok_unsorted,
                         "playlists_itemid_ascending": id_sorted,
                         "playlists_itemid_not_ascending": id_unsorted}
print("token stats:", result["token_stats"])

# --- smart tree variation --------------------------------------------------
var = defaultdict(lambda: defaultdict(set))
for rec in FILES:
    for pl in rec["playlists"]:
        for m in pl["metadata"]:
            if m["code"] != 101 or not m.get("smart_tree"):
                continue
            t = m["smart_tree"]
            key = (pl["special_kind"], pl["name"])
            var[key]["header_hex"].add(t["header_hex"])
            var[key]["declared_count"].add(t["declared_count"])
            var[key]["root_flags"].add(tuple(t["root_flag_bytes"]))
            for idx, r in enumerate(t["rules"]):
                var[key][f"r{idx}.header"].add(r["header_hex"])
                var[key][f"r{idx}.payload"].add(r["payload_hex"])
smart_var = {}
for key, fields in sorted(var.items()):
    varying = {f: sorted(v) for f, v in fields.items() if len(v) > 1}
    smart_var[f"{key[0]}:{key[1]}"] = {
        "varying_fields": {f: len(v) for f, v in fields.items() if len(v) > 1},
        "values": {f: (v if len(v) <= 6 else v[:6] + ["..."]) for f, v in varying.items()},
    }
    if varying:
        print(f"smart var {key}: {[(f, len(v)) for f, v in varying.items()]}")
        for f, v in varying.items():
            for val in v[:4]:
                print(f"     {f}: {val}")
result["smart_variation"] = smart_var

# --- disprove the 0x1bf 'reference' ---------------------------------------
checks = []
for rec in FILES:
    for pl in rec["playlists"]:
        for r in pl["header_refs"]:
            checks.append({
                "file": rec["file"], "name": pl["name"], "off": r["off"],
                "value": r["value"],
                "pid_top_byte": (pl["persistent_id"] >> 56) & 0xFF,
                "equals_pid_top_byte": r["value"] == ((pl["persistent_id"] >> 56) & 0xFF),
                "inside_pid_slot": 0x1B8 <= r["off"] <= 0x1BF,
            })
result["reference_disproof"] = checks
print("refs all inside pid slot:", all(c["inside_pid_slot"] for c in checks),
      "| all equal pid top byte:", all(c["equals_pid_top_byte"] for c in checks),
      "| n =", len(checks))

(OUT / "ordering-findings.json").write_text(json.dumps(result, indent=1, sort_keys=True))
