"""a11 adversarial probes against the reachable base commit. Read-only on production code."""
import copy, json, os, random, struct, sys, traceback

WT = "<CI_ROOT>/wt/a11"
sys.path[:0] = [WT, os.path.join(WT, "tests")]

from itlkit import Container, FormatError, Library, Node, UnsupportedError
from itlkit.admission import require_complete_master
from itlkit.binary import put, uint
from itlkit.schema import LimitError, ReadLimits
from itlkit import playlist_models as pm
from test_core_support import (library_bytes, list_record, playlist, record, section, track,
                              item, text, u32, u64)

MASTER = 0xBEEF000000000001


def classify(fn):
    try:
        return ("ok", fn())
    except Exception as exc:
        return (type(exc).__name__, str(exc)[:140])


def p(name, value):
    print("PROBE %-30s %s" % (name, value), flush=True)


def wire_bytes():
    return library_bytes(tracks=[track(i) for i in (1, 2, 3)],
                         playlists=[playlist([1, 2, 3], pid=MASTER, master=True, local_id=4),
                                    playlist([1, 2], pid=MASTER + 10, local_id=6)])


def base_lib():
    return Library.from_bytes(wire_bytes())


def observed_depth(lib):
    stack, mx = [(s, 0) for s in lib.sections], 0
    while stack:
        n, d = stack.pop()
        mx = max(mx, d)
        stack.extend((c, d + 1) for c in (n.children or ()))
    return mx


print("== target 1: depth mapping / off-by-one ==")


def nest_under_ordinary(levels):
    lib = base_lib()
    proto = copy.deepcopy(lib.playlists[-1].items[1])
    cur = copy.deepcopy(proto)
    for _ in range(levels - 1):
        parent = copy.deepcopy(proto)
        parent.children = [cur]
        cur = parent
    lib.playlists[-1].items[0].children = [cur]
    return lib


try:
    p("direct_items_exclude_nested", len(nest_under_ordinary(3).playlists[-1].items))
    for levels in (1, 27, 28, 29, 30, 40):
        lib = nest_under_ordinary(levels)
        p("admission_depth", (levels, observed_depth(lib),
                              classify(lambda: require_complete_master(lib) and "accepted")))
except Exception:
    traceback.print_exc()

try:
    for d in (1, 32, 33, 64, 65):
        p("pm_limits_max_depth", (d, classify(lambda: pm._limits({"max_depth": d}) and "ok")[0]))
    p("pm_limits_shared_readlimits", classify(lambda: pm._limits(ReadLimits())["max_depth"]))
except Exception:
    traceback.print_exc()


def slst(body, count, version=1):
    h = bytearray(136)
    h[:4] = b"SLst"
    struct.pack_into(">H", h, 4, version)
    struct.pack_into(">H", h, 6, 0)
    struct.pack_into(">I", h, 8, count)
    return bytes(h) + body


def slst_rule(payload, nested=0, action=1, code=4):
    h = bytearray(56)
    struct.pack_into(">I", h, 0, code)
    struct.pack_into(">I", h, 4, action)
    h[8] = nested
    struct.pack_into(">I", h, 52, len(payload))
    return bytes(h) + payload + (b"\0" if len(payload) & 1 else b"")


def nested_slst(levels):
    body = slst(slst_rule(b"ab"), 1)
    for _ in range(levels):
        body = slst(slst_rule(body, nested=1), 1)
    return body


try:
    for levels in (0, 1, 14, 15, 16, 31):
        data = nested_slst(levels)
        kind, val = classify(lambda: pm.parse_smart_rules(data))
        p("slst_depth_default32", (levels, len(data), kind if kind != "ok" else ("complete", val.wire_complete)))
    tree = pm.parse_smart_rules(nested_slst(15))
    p("slst_export_depth_16", classify(lambda: len(pm.models_json(tree, limits={"max_depth": 16})))[0])
    p("slst_export_depth_31", classify(lambda: len(pm.models_json(tree, limits={"max_depth": 31})))[0])
except Exception:
    traceback.print_exc()

print("== target 3/4: order, duplicates, span facts, private field leakage ==")


def custom_miph(names, tids, pid, local_id, master=False):
    strings = b"".join(text(100, n) for n in names)
    payload = strings + b"".join(item(t, 20 + i) for i, t in enumerate(tids))
    h = bytearray(record(b"miph", 3500, count=len(names)))
    u32(h, 8, len(h) + len(payload))
    u32(h, 16, len(tids))
    u64(h, 0x1b8, pid)
    u32(h, 0xd40, local_id)
    u32(h, 0x14, 0x10000 if master else 0)
    return bytes(h) + payload


def payload_bytes():
    tracks = list_record(b"mlth", 92, [track(1), track(2)])
    pls = list_record(b"mlph", 92, [custom_miph(["Master"], [1, 2], MASTER, 4, master=True),
                                    custom_miph(["Dup", "Dup"], [2, 2], MASTER + 10, 6)])
    return section(1, tracks) + section(2, pls)


try:
    payload = payload_bytes()
    doc = pm.inspect_playlist_payload(payload)
    pl = doc.playlists[1]
    p("order_metadata", [(m.child_index, m.occurrence_index, m.type_code, m.text) for m in pl.metadata])
    p("order_entries", [(e.child_index, e.value("local_id"), e.value("track_id")) for e in pl.entries])
    p("doc_observed", (doc.node_count, doc.max_observed_depth, doc.decoded_text_bytes,
                       doc.estimated_model_bytes, doc.track_reference_coverage))
    js = pm.models_json(doc)
    d = json.loads(js)
    p("json_private_and_raw", ("_buffer" in js, "payload_hex" in js, len(js)))
    p("json_key_order_doc", list(d["model"].keys())[:7])
    p("json_key_order_span", list(d["model"]["raw"].keys()))
    p("json_dup_metadata", [m["text"] for m in d["model"]["sections"][1]["playlists"][1]["metadata"]])
    p("export_depth_at_observed", classify(lambda: len(pm.models_json(doc, limits={"max_depth": doc.max_observed_depth})))[0])
    p("export_depth_below_observed", classify(lambda: len(pm.models_json(doc, limits={"max_depth": max(1, doc.max_observed_depth - 1)})))[0])
    js_raw = pm.models_json(doc, include_raw=True)
    p("json_include_raw_private", ("_buffer" in js_raw, "payload_hex" in js_raw))
    sub = pm.parse_smart_rules(nested_slst(2)).rules[0].tree
    jsub = json.loads(pm.models_json(sub, include_raw=True))
    base, hexs = jsub["payload_base_offset"], jsub["payload_hex"]
    span = sub.rules[0].header
    ok = hexs[(span.offset - base) * 2:(span.offset - base + span.size) * 2] == span.read().hex()
    p("span_reconstruction", (base, span.offset, span.size, ok, "_buffer" in json.dumps(jsub)))
except Exception:
    traceback.print_exc()

print("== target 2: envelope/model budget accounting ==")
try:
    wire = wire_bytes()
    W = len(wire)
    P = len(Library.from_bytes(wire).container.payload)
    p("envelope_sizes", (W, P))
    for delta in (0, 8, 4 * (P + 1), 4 * (P + 1) + 2048 * 400, 4 * (P + 1) + 2048 * 4000):
        M = 6 * W + delta
        kind, val = classify(lambda: pm.inspect_playlists(wire, limits={"memory_budget_bytes": M}))
        p("envelope_budget", (delta, kind, val if kind != "ok" else val.estimated_model_bytes))
    try:
        pm.inspect_playlists(wire, limits={"memory_budget_bytes": 6 * W + 8})
    except Exception as exc:
        p("envelope_cause", (type(exc).__name__, type(exc.__cause__).__name__))
    p("explicit_plain_cap", classify(lambda: pm.inspect_playlists(wire, limits={"max_plain_bytes": 1})))
    p("unchanged_caller_limits", classify(lambda: pm.inspect_playlists(wire) and "ok")[0])
except Exception:
    traceback.print_exc()

print("== target 5: auxiliary admission predicate ==")


def aux_variant(mode):
    lib = base_lib()
    if mode == "opaque_record":
        n = Node(bytearray(record(b"miah", 88, count=0, fields=((16, 7),))))
        n.payload = b"opaque!!"
        put(n.header, 20, 0xAABB000000000007, 8)
        lib._root(9).children = [n]
    elif mode == "wide_record_dup_pid":
        ns = []
        for i in (7, 8):
            n = Node(bytearray(record(b"miah", 92, count=0, fields=((16, i),))), children=[])
            put(n.header, 20, 0xAABB000000000001, 8)
            ns.append(n)
        lib._root(9).children = ns
    elif mode == "exact_record_dup_pid":
        ns = []
        for i in (7, 8):
            n = Node(bytearray(record(b"miah", 88, count=0, fields=((16, i),))), children=[])
            put(n.header, 20, 0xAABB000000000001, 8)
            ns.append(n)
        lib._root(9).children = ns
    elif mode == "artist_wide_dup_pid":
        ns = []
        for i in (7, 8):
            n = Node(bytearray(record(b"miih", 104, count=0, fields=((16, i),))), children=[])
            put(n.header, 20, 0xAABB000000000001, 8)
            ns.append(n)
        lib._root(11).children = ns
    elif mode == "foreign_tag_in_aux":
        n = Node(bytearray(record(b"mith", 756, count=0, fields=((16, 1),))), children=[])
        lib._root(9).children = [n]
    elif mode == "aux_section_width":
        s = next(x for x in lib.sections if x.section_type == 9)
        s.header = s.header + b"\0" * 4
        put(s.header, 4, len(s.header))
    elif mode == "aux_root_width":
        r = lib._root(9)
        r.header = r.header + b"\0" * 4
        put(r.header, 4, len(r.header))
    return lib


try:
    for mode in ("opaque_record", "wide_record_dup_pid", "exact_record_dup_pid",
                 "artist_wide_dup_pid", "foreign_tag_in_aux", "aux_section_width", "aux_root_width"):
        lib = aux_variant(mode)
        core = classify(lambda: Library._validate_ids_and_refs(lib) or "accepted")
        adm = classify(lambda: require_complete_master(lib) and "accepted")
        p("aux_concordance", (mode, core[0], adm[0]))
except Exception:
    traceback.print_exc()

print("== fuzz: exception-class discipline ==")
try:
    payload = payload_bytes()
    random.seed(20260911)
    bad, stats = {}, {}
    for i in range(2000):
        data = bytearray(payload)
        for _ in range(random.randint(1, 5)):
            data[random.randrange(len(data))] = random.randrange(256)
        if random.random() < 0.25:
            data = data[:random.randrange(1, len(data))]
        kind, val = classify(lambda: pm.inspect_playlist_payload(bytes(data)))
        stats[kind] = stats.get(kind, 0) + 1
        if kind == "ok":
            if i % 3 == 0:
                k2, v2 = classify(lambda: pm.models_json(val, include_raw=(i % 2 == 0)))
                stats["json:" + k2] = stats.get("json:" + k2, 0) + 1
                if k2 == "ok":
                    if "_buffer" in v2:
                        bad.setdefault("json_private_leak", i)
                elif k2 != "PlaylistLimitError":
                    bad.setdefault("json:" + k2, (i, v2))
        elif kind != "PlaylistLimitError":
            bad.setdefault("parse:" + kind, (i, val))
    p("fuzz_payload_stats", stats)
    p("fuzz_payload_unexpected", bad)

    base_tree = nested_slst(3)
    bad2, stats2 = {}, {}
    for i in range(2000):
        data = bytearray(base_tree)
        for _ in range(random.randint(1, 5)):
            data[random.randrange(len(data))] = random.randrange(256)
        if random.random() < 0.25:
            data = data[:random.randrange(1, len(data))]
        kind, val = classify(lambda: pm.parse_smart_rules(bytes(data)))
        stats2[kind] = stats2.get(kind, 0) + 1
        if kind == "ok":
            k2, v2 = classify(lambda: pm.models_json(val, include_raw=True))
            stats2["json:" + k2] = stats2.get("json:" + k2, 0) + 1
            if k2 == "ok":
                if "_buffer" in v2:
                    bad2.setdefault("json_private_leak", i)
            elif k2 != "PlaylistLimitError":
                bad2.setdefault("json:" + k2, (i, v2))
        elif kind != "PlaylistLimitError":
            bad2.setdefault("parse:" + kind, (i, val))
    p("fuzz_slst_stats", stats2)
    p("fuzz_slst_unexpected", bad2)
except Exception:
    traceback.print_exc()

print("DONE probe_base")
