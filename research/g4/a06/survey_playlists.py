#!/usr/bin/env python3
"""a06: read-only playlist inventory over available .itl fixtures.

Never writes, rebuilds or publishes a library. Uses only the read-only
itlkit.playlist_models observation API plus raw header byte inspection.
"""
from __future__ import annotations

import hashlib
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT))

from itlkit.playlist_models import inspect_playlists  # noqa: E402

OUT = ROOT / "research" / "g4" / "a06" / "out"
OUT.mkdir(parents=True, exist_ok=True)


def u(buf, off, width):
    return int.from_bytes(buf[off:off + width], "little")


def smart_tree(tree, depth=0):
    if tree is None:
        return None
    return {
        "span": [tree.raw.offset, tree.raw.size],
        "version": tree.version,
        "secondary_version": tree.secondary_version,
        "declared_count": tree.declared_count,
        "root_flag_bytes": list(tree.root_flag_bytes),
        "wire_complete": tree.wire_complete,
        "header_hex": tree.header.read().hex(),
        "unparsed": tree.unparsed.size,
        "diags": sorted({d.code for d in tree.diagnostics}),
        "rules": [
            {
                "index": r.index,
                "field_code": r.field_code,
                "action_bits": r.action_bits,
                "nested": r.nested_flag,
                "disabled": r.disabled_flag,
                "header_hex": r.header.read().hex(),
                "payload_size": r.payload.size,
                "payload_hex": r.payload.read().hex(),
                "padding_hex": r.padding.read().hex(),
                "diags": sorted({d.code for d in r.diagnostics}),
                "tree": smart_tree(r.tree, depth + 1),
            }
            for r in tree.rules
        ],
    }


def describe(path: Path):
    data = path.read_bytes()
    doc = inspect_playlists(data)
    rec = {
        "file": str(path.relative_to(ROOT)),
        "bytes": len(data),
        "sha256": hashlib.sha256(data).hexdigest(),
        "payload_sha256": doc.input_sha256,
        "track_count": len(doc.primary_track_ids),
        "coverage": doc.track_reference_coverage,
        "doc_diags": sorted({d.code for d in doc.diagnostics}),
        "sections": [
            {
                "index": s.index,
                "kind": s.kind,
                "declared_count": s.declared_count,
                "playlists": len(s.playlists),
                "diags": sorted({d.code for d in s.diagnostics}),
            }
            for s in doc.sections
        ],
        "playlists": [],
    }
    pid_map = {}
    lid_map = {}
    for pl in doc.playlists:
        pid_map.setdefault(pl.value("persistent_id"), []).append(pl.playlist_index)
        lid_map.setdefault(pl.value("local_id"), []).append(pl.playlist_index)
    for pl in doc.playlists:
        header = pl.header.read()
        nonzero32 = [off for off in range(0, len(header) - 3, 4) if u(header, off, 4)]
        # Cross-reference scan: does this header mention another playlist?
        refs = []
        for off in range(0, len(header) - 7):
            v8 = u(header, off, 8)
            if v8 and v8 in pid_map and off != 0x1b8:
                refs.append({"off": off, "width": 8, "kind": "playlist_pid",
                             "targets": pid_map[v8], "value": f"{v8:016X}"})
        for off in range(0, len(header) - 3, 1):
            v4 = u(header, off, 4)
            if v4 and v4 in lid_map and off not in (0xd40,):
                refs.append({"off": off, "width": 4, "kind": "playlist_local_id",
                             "targets": lid_map[v4], "value": v4})
        entries = [
            {
                "i": e.child_index,
                "hdr": e.header.size,
                "size": e.raw.size,
                "local_id": e.value("local_id"),
                "parent_entry_id": e.value("parent_entry_id"),
                "track_id": e.value("track_id"),
                "group_flag": e.value("group_flag"),
                "order_token": e.value("order_token"),
                "pid": e.value("persistent_id"),
                "meta": [m.type_code for m in e.metadata],
                "nested_mtph": len(e.physical_children),
                "opaque": len(e.opaque_children),
                "nonzero32": [off for off in range(0, e.header.size - 3, 4)
                              if u(e.header.read(), off, 4)],
            }
            for e in pl.entries
        ]
        metas = []
        for m in pl.metadata:
            item = {
                "code": m.type_code,
                "occurrence": m.occurrence_index,
                "record_size": m.raw.size,
                "header_size": m.header.size,
                "body_size": m.payload.size,
                "slot": m.pool_slot_raw,
                "encoding": m.encoding,
                "text": m.text,
                "diags": sorted({d.code for d in m.diagnostics}),
                "fields": {f.name: f.value for f in m.fields},
            }
            if m.type_code == 101:
                item["smart_tree"] = smart_tree(m.smart_tree)
            if m.type_code == 102:
                item["body_hex"] = m.payload.read().hex()
            if m.type_code not in (100, 101, 102) and m.payload.size <= 4096:
                item["body_sha256"] = hashlib.sha256(m.payload.read()).hexdigest()
            metas.append(item)
        rec["playlists"].append({
            "section_index": pl.section_index,
            "section_kind": pl.section_kind,
            "playlist_index": pl.playlist_index,
            "header_size": pl.header.size,
            "record_size": pl.raw.size,
            "name": next((m.text for m in pl.metadata if m.type_code == 100), None),
            "meta_codes": [m.type_code for m in pl.metadata],
            "master_flags_raw": pl.value("master_flags_raw"),
            "flags_18_raw": pl.value("flags_18_raw"),
            "flags_1b4_raw": pl.value("flags_1b4_raw"),
            "special_kind": pl.value("special_kind"),
            "persistent_id": pl.value("persistent_id"),
            "local_id": pl.value("local_id"),
            "entry_count": len(pl.entries),
            "entries": entries,
            "metadata": metas,
            "opaque_children": [{"off": o.offset, "size": o.size} for o in pl.opaque_children],
            "header_nonzero32": nonzero32,
            "header_refs": refs,
            "parent_edges": [
                {"i": pe.child_index, "child": pe.child_local_id, "parent": pe.parent_local_id,
                 "target": pe.parent_index, "status": pe.status, "level": pe.level}
                for pe in pl.parent_edges
            ],
            "folder_parent_status": pl.folder_parent_status,
            "diags": sorted({d.code for d in pl.diagnostics}),
        })
    return rec


def main():
    files = sorted(ROOT.glob("evidence/**/*.itl"))
    results, errors = [], []
    for path in files:
        try:
            results.append(describe(path))
        except Exception as exc:  # noqa: BLE001 - record, never repair
            errors.append({"file": str(path.relative_to(ROOT)),
                           "error": f"{type(exc).__name__}: {exc}"})
    (OUT / "playlist-survey.json").write_text(
        json.dumps({"files": results, "errors": errors}, indent=1, sort_keys=True))
    print(f"files={len(files)} parsed={len(results)} errors={len(errors)}")
    for e in errors:
        print("  ERROR", e["file"], e["error"])
    kinds = {}
    for rec in results:
        for pl in rec["playlists"]:
            key = (pl["section_kind"], pl["header_size"], pl["master_flags_raw"],
                   pl["flags_18_raw"], pl["flags_1b4_raw"], pl["special_kind"],
                   tuple(sorted(pl["meta_codes"])))
            slot = kinds.setdefault(key, {"count": 0, "names": set(), "files": set(),
                                          "entries": 0, "grouped": 0})
            slot["count"] += 1
            slot["names"].add(pl["name"])
            slot["files"].add(rec["file"])
            slot["entries"] += pl["entry_count"]
            slot["grouped"] += sum(1 for e in pl["entries"] if e["group_flag"])
    print(f"distinct playlist signatures: {len(kinds)}")
    for key, slot in sorted(kinds.items(), key=lambda kv: -kv[1]["count"]):
        sk, hdr, mf, f18, f1b4, special, metas = key
        names = sorted(x for x in slot["names"] if x is not None)
        print(f"  sec={sk} hdr={hdr} master=0x{mf:x} f18=0x{f18:x} f1b4=0x{f1b4:x} "
              f"special={special} meta={list(metas)} n={slot['count']} "
              f"entries={slot['entries']} grouped={slot['grouped']} "
              f"files={len(slot['files'])} names={names[:6]}")
    refs = [(rec["file"], pl["name"], pl["header_refs"]) for rec in results
            for pl in rec["playlists"] if pl["header_refs"]]
    print(f"playlists whose header references another playlist identity: {len(refs)}")
    for f, n, r in refs[:12]:
        print("   ", f, n, r[:4])


if __name__ == "__main__":
    main()
