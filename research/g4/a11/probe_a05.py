"""a11 read-only adversarial probe of the a05 media-intake surface (snapshot of g4/a05)."""
import dataclasses, importlib.util, struct, sys, traceback

W = "<CI_ROOT>/wt/a11"
SNAP = "<CI_ROOT>/reports/a11/a05_media_snapshot.py"
sys.path[:0] = [W]

import itlkit  # noqa: F401  (package needed so the snapshot's relative imports resolve)

spec = importlib.util.spec_from_file_location("itlkit.media_a05", SNAP)
m = importlib.util.module_from_spec(spec)
sys.modules["itlkit.media_a05"] = m
spec.loader.exec_module(m)


def p(name, value):
    print("A05 %-26s %s" % (name, value), flush=True)


def classify(fn):
    try:
        return ("ok", fn())
    except Exception as exc:
        return (type(exc).__name__, str(exc)[:160])


p("fields", [f.name for f in dataclasses.fields(m.MediaFacts)])
p("FIELD_STATUSES", m.FIELD_STATUSES)


def wav(extra=b"", rate=48000, ch=1, bits=16, frames=100):
    pcm = b"\0" * (frames * ch * bits // 8)
    fmt = struct.pack("<HHIIHH", 1, ch, rate, rate * ch * bits // 8, ch * bits // 8, bits)
    body = (b"WAVE" + b"fmt " + struct.pack("<I", len(fmt)) + fmt + extra +
            b"data" + struct.pack("<I", len(pcm)) + pcm)
    return b"RIFF" + struct.pack("<I", len(body)) + body


def chunk(tag, payload):
    return tag + struct.pack("<I", len(payload)) + payload + (b"\0" if len(payload) & 1 else b"")


def tiling(data, facts):
    covered, bad = 0, []
    for tag, begin, length in facts.chunk_spans:
        covered += length + 8
        seen = data[begin - 8:begin - 4]
        if seen != tag.encode("ascii", "replace"):
            bad.append((tag, begin, seen))
    return {"spans": len(facts.chunk_spans), "covered_plus_hdr": covered + 12,
            "file": len(data), "exact": covered + 12 == len(data), "header_mismatch": bad}


cases = {
    "canonical": wav(),
    "plus_LIST_even": wav(chunk(b"LIST", b"INFO")),
    "plus_ID3_even": wav(chunk(b"ID3 ", b"ID3PAYLOAD__")),
    "plus_ANNO_odd": wav(chunk(b"ANNO", b"odd")),
    "plus_unknown_XYZ": wav(chunk(b"XYZ ", b"1234")),
    "dup_LIST": wav(chunk(b"LIST", b"INFO") + chunk(b"LIST", b"INF2")),
    "rate_44100_uneven": wav(rate=44100, frames=4411),
}
probed = {}
for name, data in cases.items():
    kind, val = classify(lambda: m.probe_bytes(data))
    if kind != "ok":
        p("probe:" + name, (kind, val))
        continue
    probed[name] = val
    p("probe:" + name, {"chunks": val.chunks, "spans": val.chunk_spans,
                        "meta_carriers": val.metadata_carriers,
                        "art_carriers": val.artwork_carriers,
                        "meta_present": val.embedded_metadata_present,
                        "art_possible": val.artwork_possible})
    p("tiling:" + name, tiling(data, val))

if "rate_44100_uneven" in probed:
    f = probed["rate_44100_uneven"]
    p("uneven_ms", (f.exact_pcm_milliseconds, f.pcm_millisecond_remainder, f.pcm_milliseconds_are_exact))
    rows = m.new_track_media_fields(f)
    p("uneven_duration_row", [(r.field, r.status, r.value, r.note[:60]) for r in rows if r.field == "duration_ms"])
    p("uneven_conditions", [c[:90] for c in m.unmet_new_media_conditions(f)])

if "canonical" in probed:
    f = probed["canonical"]
    rows = m.new_track_media_fields(f)
    p("canonical_rows", [(r.field, r.status, r.value if not isinstance(r.value, str) or len(str(r.value)) < 24 else "<str>") for r in rows])
    p("canonical_conditions_n", len(m.unmet_new_media_conditions(f)))

# Cross-family: AIFF facts built directly (public frozen dataclass, no parsing needed).
aiff = m.MediaFacts("AIFF", 1000, "ab" * 32, 48000, 1, 16, 480, 0.01, "exact_pcm_frames",
                    768000, "pcm", ("COMM", "SSND"), (), (("COMM", 12, 18), ("SSND", 38, 968)), (), ())
p("aiff_recipe_kind", classify(lambda: m.recipe_kind_text(aiff)))
p("aiff_recipe_format", classify(lambda: m.recipe_format_code(aiff)))
aiff_rows = {r.field: (r.status, r.value) for r in m.new_track_media_fields(aiff)}
p("aiff_format_code_row", aiff_rows["format_code"])
p("aiff_kind_text_row", aiff_rows["kind_text"])
p("aiff_contradiction", (aiff_rows["format_code"][0] == "recipe_constant_unverified"
                         and aiff_rows["format_code"][1] is None))
p("aiff_conditions", [c[:70] for c in m.unmet_new_media_conditions(aiff)])

# Unknown family with no recipe at all.
mp3 = m.MediaFacts("MP3", 1000, "cd" * 32, 44100, 2, None, None, 1.0,
                   "parser_only_not_native_wire_duration", 128000, "mp3", (), ("APIC:",), (), (), ("APIC:",))
mp3_rows = {r.field: (r.status, r.value) for r in m.new_track_media_fields(mp3)}
p("mp3_format_code_row", mp3_rows["format_code"])
p("mp3_artwork_row", mp3_rows["artwork"])
p("mp3_meta_present", (mp3.embedded_metadata_present, mp3.artwork_possible))

# Status/value invariant: a row claiming a recipe constant must actually carry one.
violations = []
for label, facts in (("canonical", probed.get("canonical")), ("aiff", aiff), ("mp3", mp3)):
    if facts is None:
        continue
    for r in m.new_track_media_fields(facts):
        if r.status == "recipe_constant_unverified" and r.value is None:
            violations.append((label, r.field))
p("recipe_status_violations", violations)
print("DONE probe_a05")
