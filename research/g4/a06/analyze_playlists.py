#!/usr/bin/env python3
"""a06: derive playlist-kind, membership/order and smart-criteria findings.

Input is the read-only survey JSON. No fixture is modified.
"""
from __future__ import annotations

import json
from collections import Counter, defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
OUT = ROOT / "research" / "g4" / "a06" / "out"
SURVEY = json.loads((OUT / "playlist-survey.json").read_text())
FILES = SURVEY["files"]
findings = {}


def sig(pl):
    return (pl["master_flags_raw"], pl["flags_18_raw"], pl["special_kind"],
            tuple(sorted(pl["meta_codes"])))


# --- A. kinds ------------------------------------------------------------
kinds = defaultdict(lambda: {"n": 0, "files": set(), "names": set(), "pids": set(),
                             "entry_totals": 0, "nonempty": 0})
for rec in FILES:
    for pl in rec["playlists"]:
        k = kinds[sig(pl)]
        k["n"] += 1
        k["files"].add(rec["file"])
        k["names"].add(pl["name"])
        k["pids"].add(pl["persistent_id"])
        k["entry_totals"] += pl["entry_count"]
        k["nonempty"] += 1 if pl["entry_count"] else 0
findings["kinds"] = [
    {"master_flags_raw": k[0], "flags_18_raw": k[1], "special_kind": k[2],
     "meta_codes": list(k[3]), "occurrences": v["n"], "files": len(v["files"]),
     "names": sorted(x for x in v["names"] if x is not None),
     "distinct_pids": len(v["pids"]), "nonempty_occurrences": v["nonempty"],
     "example_file": sorted(v["files"])[0]}
    for k, v in sorted(kinds.items(), key=lambda kv: -kv[1]["n"])]

# --- B. flags_18 variants for ordinary (special_kind 0, not master) -------
ord_flags = defaultdict(lambda: {"files": set(), "names": set()})
for rec in FILES:
    for pl in rec["playlists"]:
        if pl["special_kind"] == 0 and not pl["master_flags_raw"]:
            slot = ord_flags[pl["flags_18_raw"]]
            slot["files"].add(rec["file"])
            slot["names"].add(pl["name"])
findings["ordinary_flags_18"] = [
    {"flags_18_raw": f"0x{f:x}", "files": sorted(v["files"]),
     "names": sorted(x for x in v["names"] if x is not None)}
    for f, v in sorted(ord_flags.items())]

# --- C. smart trees -------------------------------------------------------
smart = defaultdict(lambda: {"files": set(), "trees": set(), "detail": None})
prefs = defaultdict(lambda: {"files": set(), "bodies": set()})
for rec in FILES:
    for pl in rec["playlists"]:
        key = (pl["special_kind"], pl["name"])
        for m in pl["metadata"]:
            if m["code"] == 101 and m.get("smart_tree"):
                t = m["smart_tree"]
                shape = json.dumps(t, sort_keys=True)
                smart[key]["files"].add(rec["file"])
                smart[key]["trees"].add(shape)
                smart[key]["detail"] = t
            if m["code"] == 102:
                prefs[key]["files"].add(rec["file"])
                prefs[key]["bodies"].add(m["body_hex"])
findings["smart"] = []
for (special, name), v in sorted(smart.items()):
    t = v["detail"]
    findings["smart"].append({
        "special_kind": special, "name": name, "files": len(v["files"]),
        "distinct_tree_shapes": len(v["trees"]),
        "version": t["version"], "secondary_version": t["secondary_version"],
        "declared_count": t["declared_count"], "wire_complete": t["wire_complete"],
        "root_flag_bytes": t["root_flag_bytes"], "unparsed": t["unparsed"],
        "header_hex": t["header_hex"], "diags": t["diags"],
        "rules": [{"field_code": f"0x{r['field_code']:08x}",
                   "action_bits": f"0x{r['action_bits']:08x}",
                   "nested": r["nested"], "disabled": r["disabled"],
                   "payload_size": r["payload_size"],
                   "payload_hex": r["payload_hex"],
                   "padding_hex": r["padding_hex"],
                   "header_hex": r["header_hex"],
                   "diags": r["diags"],
                   "nested_tree": r["tree"]} for r in t["rules"]],
    })
findings["smart_preferences"] = [
    {"special_kind": s, "name": n, "files": len(v["files"]),
     "distinct_bodies": len(v["bodies"]), "body_hex": sorted(v["bodies"])[0]}
    for (s, n), v in sorted(prefs.items())]

# --- D. membership / ordering series -------------------------------------
series = {}
for rec in FILES:
    if "/native/snapshots/" not in rec["file"]:
        continue
    stem = Path(rec["file"]).stem
    rows = []
    for pl in rec["playlists"]:
        if pl["entry_count"] == 0:
            continue
        rows.append({
            "name": pl["name"], "special_kind": pl["special_kind"],
            "master": bool(pl["master_flags_raw"]),
            "pid": f"{pl['persistent_id']:016X}", "local_id": pl["local_id"],
            "declared_items": pl["entry_count"],
            "track_ids": [e["track_id"] for e in pl["entries"]],
            "item_local_ids": [e["local_id"] for e in pl["entries"]],
            "order_tokens": [e["order_token"] for e in pl["entries"]],
            "item_pids": [f"{e['pid']:016X}" for e in pl["entries"]],
            "parent_ids": [e["parent_entry_id"] for e in pl["entries"]],
            "group_flags": [e["group_flag"] for e in pl["entries"]],
        })
    series[stem] = rows
findings["snapshot_series"] = series

# --- E. duplicates, grouping, nesting ------------------------------------
dups, grouped, nested, nonzero_parent, entry_meta = [], [], [], [], Counter()
for rec in FILES:
    for pl in rec["playlists"]:
        tids = [e["track_id"] for e in pl["entries"]]
        if len(tids) != len(set(tids)):
            c = Counter(tids)
            dups.append({"file": rec["file"], "name": pl["name"],
                         "sequence": tids,
                         "repeated": {k: v for k, v in c.items() if v > 1}})
        for e in pl["entries"]:
            if e["group_flag"]:
                grouped.append({"file": rec["file"], "name": pl["name"], "entry": e})
            if e["nested_mtph"]:
                nested.append({"file": rec["file"], "name": pl["name"], "entry": e})
            if e["parent_entry_id"]:
                nonzero_parent.append({"file": rec["file"], "name": pl["name"], "entry": e})
            for code in e["meta"]:
                entry_meta[code] += 1
findings["duplicate_membership"] = dups
findings["grouped_entries"] = grouped
findings["physically_nested_entries"] = nested
findings["nonzero_parent_entries"] = nonzero_parent
findings["entry_metadata_codes"] = dict(entry_meta)

# --- F. header offset census per kind ------------------------------------
KNOWN_PLAIN = {0, 4, 8, 12, 16, 0x18, 0x1c, 0x1b4, 0x1b8, 0x1bc,
               0x274, 0x730, 0x734, 0xc74, 0xd40}
MODELLED = {0x14, 0x18, 0x1b4, 0x1b8, 0x238, 0xd40}
census = defaultdict(lambda: {"union": set(), "inter": None, "n": 0})
for rec in FILES:
    for pl in rec["playlists"]:
        key = (pl["master_flags_raw"], pl["special_kind"], pl["flags_18_raw"])
        offs = set(pl["header_nonzero32"])
        slot = census[key]
        slot["n"] += 1
        slot["union"] |= offs
        slot["inter"] = offs if slot["inter"] is None else (slot["inter"] & offs)
findings["header_offset_census"] = [
    {"master_flags_raw": k[0], "special_kind": k[1], "flags_18_raw": f"0x{k[2]:x}",
     "occurrences": v["n"],
     "always_nonzero": [f"0x{o:x}" for o in sorted(v["inter"])],
     "sometimes_nonzero": [f"0x{o:x}" for o in sorted(v["union"] - v["inter"])],
     "outside_require_plain_known": [f"0x{o:x}" for o in sorted(v["union"] - KNOWN_PLAIN)],
     "outside_modelled_slots": [f"0x{o:x}" for o in sorted(v["union"] - MODELLED)]}
    for k, v in sorted(census.items())]

# --- G. are the "header_refs" real references? ----------------------------
refs = []
for rec in FILES:
    for pl in rec["playlists"]:
        for r in pl["header_refs"]:
            refs.append({"file": rec["file"], "name": pl["name"], **r})
findings["header_reference_candidates"] = {
    "total": len(refs),
    "offsets": sorted(Counter(r["off"] for r in refs).items()),
    "aligned_offsets": sorted({r["off"] for r in refs if r["off"] % 4 == 0}),
    "samples": refs[:8],
}

# --- H. entry metadata / item record sizes -------------------------------
sizes = Counter()
for rec in FILES:
    for pl in rec["playlists"]:
        for e in pl["entries"]:
            sizes[(e["hdr"], e["size"])] += 1
findings["entry_record_sizes"] = [{"header": k[0], "total": k[1], "count": v}
                                  for k, v in sorted(sizes.items())]

(OUT / "playlist-findings.json").write_text(json.dumps(findings, indent=1, sort_keys=True))

print("== ordinary flags_18 variants ==")
for row in findings["ordinary_flags_18"]:
    print(" ", row["flags_18_raw"], row["names"], len(row["files"]), "files")
    for f in row["files"][:4]:
        print("     ", f)
print("== smart trees ==")
for s in findings["smart"]:
    print(f"  special={s['special_kind']} name={s['name']!r} files={s['files']} "
          f"shapes={s['distinct_tree_shapes']} ver={s['version']}/{s['secondary_version']} "
          f"count={s['declared_count']} complete={s['wire_complete']} "
          f"flags={s['root_flag_bytes']} tail={s['unparsed']} diags={s['diags']}")
    for r in s["rules"]:
        print(f"      rule field={r['field_code']} action={r['action_bits']} "
              f"nested={r['nested']} disabled={r['disabled']} "
              f"len={r['payload_size']} payload={r['payload_hex'][:96]} pad={r['padding_hex']}")
print("== smart preferences 102 ==")
for p in findings["smart_preferences"]:
    print(f"  special={p['special_kind']} name={p['name']!r} files={p['files']} "
          f"distinct={p['distinct_bodies']}")
print("== duplicates ==", len(findings["duplicate_membership"]))
for d in findings["duplicate_membership"][:6]:
    print("   ", d["file"], d["name"], d["repeated"], d["sequence"])
print("== grouped entries ==", len(findings["grouped_entries"]),
      "| nested mtph ==", len(findings["physically_nested_entries"]),
      "| nonzero parent ==", len(findings["nonzero_parent_entries"]),
      "| entry metadata codes ==", findings["entry_metadata_codes"])
print("== entry record sizes ==", findings["entry_record_sizes"])
print("== header ref candidates ==", findings["header_reference_candidates"]["total"],
      findings["header_reference_candidates"]["offsets"],
      "aligned:", findings["header_reference_candidates"]["aligned_offsets"])
print("== header census ==")
for c in findings["header_offset_census"]:
    print(f"  master={c['master_flags_raw']} special={c['special_kind']} "
          f"f18={c['flags_18_raw']} n={c['occurrences']}")
    print(f"     always={c['always_nonzero']}")
    print(f"     sometimes={c['sometimes_nonzero']}")
    print(f"     outside_modelled={c['outside_modelled_slots']}")
