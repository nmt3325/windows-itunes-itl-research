import inspect as _inspect
import sys
from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT))
from itlkit import playlist_models as pm, Library, UnsupportedError
from itlkit.operations import require_plain

print("RawSpan.read", _inspect.signature(pm.RawSpan.read))


def sb(sp):
    return bytes(sp.read())


FIX = ROOT / "evidence/native/snapshots/037-final-three-reloaded.itl"
data = FIX.read_bytes()
doc = pm.inspect_playlists(data)
payload = sb(doc.raw)
print("payload len", len(payload), "| doc diags", [(d.code, d.level) for d in doc.diagnostics])
print("coverage", doc.track_reference_coverage, "| schema", doc.schema,
      "| semantic", doc.semantic_write_level, "| native", doc.native_level)

sec2 = [s for s in doc.sections if s.kind == 2][0]
pl = sec2.playlists[0]
print("pl raw", pl.raw.offset, pl.raw.size, "hdr", pl.header.offset, pl.header.size)
print("pl fields", {f.name: f.value for f in pl.fields})
print("pl folder_parent_status", pl.folder_parent_status,
      "| semantic", pl.semantic_write_level, "| native", pl.native_level)
print("pl diags", [(d.code, d.level, d.detail) for d in pl.diagnostics])
print("meta", [(m.type_code, m.raw.size, m.header.size, m.payload.size) for m in pl.metadata])
print("entry0 fields", {f.name: f.value for f in pl.entries[0].fields} if pl.entries else None)

bad = []
for s in doc.sections:
    for p in s.playlists:
        if p.header.offset != p.raw.offset:
            bad.append(("header-not-at-start", p.raw.offset))
        cur = p.header.offset + p.header.size
        pieces = sorted([m.raw for m in p.metadata] + [e.raw for e in p.entries]
                        + list(p.opaque_children), key=lambda sp: sp.offset)
        for sp in pieces:
            if sp.offset != cur:
                bad.append(("gap", p.raw.offset, cur, sp.offset))
            cur = sp.offset + sp.size
        if cur != p.raw.offset + p.raw.size:
            bad.append(("tail", cur, p.raw.offset + p.raw.size))
        if sb(p.raw) != payload[p.raw.offset:p.raw.offset + p.raw.size]:
            bad.append(("span-bytes", p.raw.offset))
print("tiling violations:", bad[:5], "count", len(bad))

for p in sec2.playlists:
    for m in p.metadata:
        if m.type_code == 101 and m.smart_tree is not None:
            t = m.smart_tree
            body = sb(t.raw)
            rebuilt = sb(t.header) + b"".join(
                sb(r.header) + sb(r.payload) + sb(r.padding) for r in t.rules) + sb(t.unparsed)
            name = next((x.text for x in p.metadata if x.type_code == 100), None)
            print(f"smart {name!r} body={len(body)} rebuilt_ok={rebuilt == body} "
                  f"rules={len(t.rules)} v={t.version}/{t.secondary_version} "
                  f"flags={list(t.root_flag_bytes)} complete={t.wire_complete} "
                  f"tail={t.unparsed.size}")
            for r in t.rules:
                print(f"    f=0x{r.field_code:08x} a=0x{r.action_bits:08x} "
                      f"hdr={sb(r.header).hex()}")
                print(f"      payload={sb(r.payload).hex()}")
            break
    else:
        continue
    break

# 102 preferences body for one playlist
for p in sec2.playlists:
    for m in p.metadata:
        if m.type_code == 102:
            name = next((x.text for x in p.metadata if x.type_code == 100), None)
            print(f"prefs {name!r} body={m.payload.size} hex={sb(m.payload).hex()}")
            print("   fields:", {f.name: f.value for f in m.fields})
            break
    else:
        continue
    break

print()
for path in ["evidence/native/snapshots/037-final-three-reloaded.itl",
             "evidence/native/snapshots/074-codec-playlist-create-from-master-reload1.itl"]:
    fp = ROOT / path
    if not fp.exists():
        print("missing", path)
        continue
    raw = fp.read_bytes()
    lib = Library.from_bytes(raw)
    print(Path(path).stem, "to_bytes==input:", lib.to_bytes() == raw)
    for p in lib.playlists():
        if p.is_master or p.is_smart:
            continue
        try:
            require_plain(p)
            verdict = "OK"
        except UnsupportedError as exc:
            verdict = f"REFUSED: {exc}"
        print(f"   {p.name!r} is_plain={p.is_plain} require_plain={verdict}")
