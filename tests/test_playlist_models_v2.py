"""Read-model controls. Synthetic groups/SLst are NOT native qualification."""
from dataclasses import FrozenInstanceError, replace
import json
from pathlib import Path
import struct

import pytest
from itlkit.playlist_models import (
    PlaylistLimitError, RawSpan, inspect_playlists, inspect_playlist_payload,
    parse_smart_rules, models_json,
)


def number(data, offset, value, size=4, endian="little"):
    data[offset:offset + size] = value.to_bytes(size, endian)


def record(tag, size, body=b"", slots=()):
    h = bytearray(size)
    h[:4] = tag
    number(h, 4, size)
    number(h, 8, size + len(body))
    for off, value, width in slots:
        number(h, off, value, width)
    return bytes(h) + body


def metadata(t, body=b"", slot=0):
    return record(b"mhoh", 24, body, [(12, t, 4), (16, slot, 4)])


def title(value="Title", encoding=1, body=None, t=100):
    raw = value.encode("utf-16-le" if encoding == 1 else "latin1") if body is None else body
    return metadata(t, struct.pack("<II", encoding, len(raw)) + b"\0" * 8 + raw)


def item(local=11, parent=0, track=1, group=0, token=99, pid=None, children=()):
    return record(b"mtph", 84, b"".join(children), [(12, len(children), 4), (16, local, 4),
                  (20, parent, 4), (24, track, 4), (28, group, 1), (32, token, 4),
                  (68, 100000 + local if pid is None else pid, 8)])


def playlist(metas=None, items=(), pid=7, raw_tail=b""):
    metas = [title(), metadata(105, b"view-a"), metadata(105, b"view-b"), metadata(108, b"view-c")] if metas is None else metas
    return record(b"miph", 3500, b"".join(metas) + b"".join(items) + raw_tail,
                  [(12, len(metas), 4), (16, len(items), 4), (0x1b8, pid, 8), (0xd40, 71, 4)])


def section(kind, records, tag=b"mlph"):
    root = record(tag, 16, b"".join(records), [(8, len(records), 4)])
    return record(b"msdh", 96, root, [(12, kind, 4)])


def payload(playlists=None, extra=b""):
    tracks = [record(b"mith", 756, slots=[(16, x, 4)]) for x in (1, 2)]
    return section(1, tracks, b"mlth") + section(2, [playlist(items=[item()])] if playlists is None else playlists) + extra


def smart_rule(body=b"abc", field=0xfffffff0, action=0xabcdef02, nested=0, disabled=0, padding=b"\xe7"):
    h = bytearray(56)
    struct.pack_into(">II", h, 0, field, action)
    h[8], h[9] = nested, disabled
    struct.pack_into(">I", h, 52, len(body))
    return bytes(h) + body + (padding if len(body) & 1 else b"")


def smart(rules=(), version=1, secondary=1):
    h = bytearray(136)
    h[:4] = b"SLst"
    struct.pack_into(">HHI", h, 4, version, secondary, len(rules))
    h[14:16] = b"\x02\x07"
    h[30:34] = b"KEEP"
    return bytes(h) + b"".join(rules)


def codes(values):
    return {d.code for d in values}


@pytest.mark.parametrize("version", [0, 1])
def test_smart_empty_header(version):
    data = smart(version=version, secondary=0x9876)
    tree = parse_smart_rules(data)
    assert tree.raw.read() == data and tree.header.read()[30:34] == b"KEEP"
    assert tree.version == version and tree.secondary_version == 0x9876
    assert tree.root_flag_bytes == (2, 7) and tree.wire_complete
    assert tree.semantic_level == "uninterpreted" and tree.native_level == "not-qualified"


def test_unknown_leaf_odd_padding_no_guessing():
    body = b"SLst\xff"
    data = smart([smart_rule(body, disabled=2)])
    tree = parse_smart_rules(data)
    rule = tree.rules[0]
    assert tree.wire_complete and rule.tree is None
    assert rule.payload.read() == body and rule.padding.read() == b"\xe7"
    assert rule.field_code == 0xfffffff0 and rule.action_bits == 0xabcdef02 and rule.disabled_flag == 2
    assert codes(rule.diagnostics) == {"opaque_rule_leaf"}
    assert tree.header.read() + rule.raw.read() == data


def test_nested_tree_is_not_string_or_evaluator():
    data = smart([smart_rule(smart([smart_rule(b"\0\xff")]), nested=3, action=1), smart_rule(b"z")])
    tree = parse_smart_rules(data)
    assert tree.wire_complete and tree.rules[0].tree.rules[0].payload.read() == b"\0\xff"
    assert tree.rules[0].nested_flag == 3
    assert tree.rules[1].payload.read() == b"z"
    assert tree.raw.read() == data


def test_nested_action_schema_failure_does_not_erase_wire_tree():
    tree = parse_smart_rules(smart([smart_rule(smart(), nested=1, action=0)]))
    assert tree.wire_complete and tree.rules[0].tree is not None
    assert "nested_action_bit" in codes(tree.rules[0].diagnostics)
    assert tree.native_level == "not-qualified"


@pytest.mark.parametrize("cut", [0, 1, 4, 135, 137, 191, 192, 193, 194, 195])
def test_smart_truncation_local_diagnostic(cut):
    data = smart([smart_rule(b"abc")])[:cut]
    tree = parse_smart_rules(data)
    assert not tree.wire_complete
    assert tree.raw.read() == data and tree.diagnostics


def test_bad_nested_subtree_does_not_hide_next_rule():
    tree = parse_smart_rules(smart([smart_rule(b"oops", nested=1, action=1), smart_rule(b"second")]))
    assert not tree.wire_complete and len(tree.rules) == 2
    assert tree.rules[0].tree.diagnostics and tree.rules[1].payload.read() == b"second"


def test_unsupported_smart_version_and_trailing_bytes():
    tree = parse_smart_rules(smart([smart_rule()], version=2))
    assert tree.version == 2 and not tree.rules and "smart_version" in codes(tree.diagnostics)
    tree = parse_smart_rules(smart() + b"extra")
    assert tree.unparsed.read() == b"extra" and not tree.wire_complete


@pytest.mark.parametrize("limits", [{"max_nodes": 1}, {"max_depth": 1}, {"max_plain_bytes": 8}, {"memory_budget_bytes": 1}])
def test_smart_budgets(limits):
    with pytest.raises(PlaylistLimitError):
        parse_smart_rules(smart([smart_rule(smart(), nested=1, action=1)]), limits=limits)


def test_ordered_entries_metadata_identity_and_exact_spans():
    data = payload([playlist(items=[item(11, token=700), item(12, track=2, token=3)])])
    model = inspect_playlist_payload(data)
    p = model.playlists[0]
    assert model.raw.read() == data and model.track_reference_coverage == "primary-header-ids"
    assert [m.type_code for m in p.metadata] == [100, 105, 105, 108]
    assert [m.occurrence_index for m in p.metadata] == [0, 0, 1, 0]
    assert [m.payload.read() for m in p.metadata[1:]] == [b"view-a", b"view-b", b"view-c"]
    assert [i.value("local_id") for i in p.entries] == [11, 12]
    assert [i.value("order_token") for i in p.entries] == [700, 3]
    assert [i.value("persistent_id") for i in p.entries] == [100011, 100012]
    assert [i.child_index for i in p.entries] == [4, 5]
    assert p.metadata[0].text == "Title" and p.value("persistent_id") == 7
    assert p.raw.read() == p.header.read() + b"".join(m.raw.read() for m in p.metadata) + b"".join(i.raw.read() for i in p.entries)
    assert p.folder_parent_status == "undecoded-not-a-root-assertion" and p.semantic_write_level == "none"


def test_flat_group_graph_optional_zero_track_and_labels():
    entries = [item(11, track=0, group=1, children=[title("Group", t=200), title("Description", t=201)]),
               item(12, parent=11), item(13, parent=11, group=1, track=0), item(14, parent=13, track=2)]
    p = inspect_playlist_payload(payload([playlist(items=entries)])).playlists[0]
    assert [e.parent_index for e in p.parent_edges] == [None, 0, 0, 2]
    assert not codes(p.diagnostics) & {"parent_cycle", "parent_missing", "track_reference", "parent_not_group"}
    assert p.entries[0].metadata[0].text == "Group"
    assert not any(e.physical_children for e in p.entries)


@pytest.mark.parametrize("entries,expected", [
    ([item(parent=999)], "parent_missing"),
    ([item(11, parent=12, group=1), item(12, parent=11, group=1)], "parent_cycle"),
    ([item(11), item(12, parent=11)], "parent_not_group"),
    ([item(11), item(11), item(12, parent=11)], "parent_ambiguous"),
    ([item(11, group=2)], "group_flag"),
    ([item(11, track=999)], "track_reference"),
    ([item(11, pid=7), item(12, pid=7)], "entry_persistent_identity"),
    ([item(0)], "entry_identity"),
])
def test_graph_negatives_are_local(entries, expected):
    data = payload([playlist(items=entries), playlist(pid=8)])
    result = inspect_playlist_payload(data)
    assert expected in codes(result.playlists[0].diagnostics)
    assert result.playlists[1].metadata[0].text == "Title" and result.raw.read() == data


def test_isolated_acyclic_forward_parent():
    p = inspect_playlist_payload(payload([playlist(items=[item(12, parent=11), item(11, track=0, group=1)])])).playlists[0]
    assert p.parent_edges[0].parent_index == 1
    assert "parent_not_before_child" in codes(p.diagnostics)
    assert "parent_cycle" not in codes(p.diagnostics)


def test_physical_nesting_not_flattened_or_folder_parent():
    data = payload([playlist(items=[item(11, children=[item(12)])])])
    p = inspect_playlist_payload(data).playlists[0]
    assert len(p.entries) == 1 and len(p.entries[0].physical_children) == 1
    assert "physical_nested_mtph" in codes(p.entries[0].diagnostics)
    assert len(p.parent_edges) == 1 and p.folder_parent_status.startswith("undecoded")


def test_duplicate_titles_unknown_encoding_and_strict_bad_utf16():
    metas = [title("first"), title(encoding=77, body=b"abc"), title(body=b"\x00\xd8"), title("last")]
    p = inspect_playlist_payload(payload([playlist(metas=metas)])).playlists[0]
    assert [m.text for m in p.metadata] == ["first", None, None, "last"]
    assert [m.occurrence_index for m in p.metadata] == [0, 1, 2, 3]
    assert "title_occurrences" in codes(p.diagnostics)
    assert "unknown_text_encoding" in codes(p.metadata[1].diagnostics)
    assert "invalid_text" in codes(p.metadata[2].diagnostics)
    assert p.metadata[1].encoding == 77


def test_smart_preferences_and_special_metadata_separation():
    prefs = bytearray(112)
    number(prefs, 4, 0x11223344, endian="big")
    special, auxiliary = b"\x00\x00\x00\x10pech\x00\x00\x00\x00strt", b"<?xml version='1.0'?>"
    metas = [title(), metadata(101, smart()), metadata(102, prefs), metadata(103, special), metadata(109, auxiliary)]
    p = inspect_playlist_payload(payload([playlist(metas=metas)])).playlists[0]
    assert p.metadata[1].smart_tree.wire_complete
    assert next(f.value for f in p.metadata[2].fields if f.name == "u32_04") == 0x11223344
    assert p.metadata[3].smart_tree is None and p.metadata[3].payload.read() == special
    assert p.metadata[4].text is None and p.metadata[4].payload.read() == auxiliary


def test_secondary_namespace_retained_not_primary_track_resolved():
    data = payload(extra=section(14, [playlist(pid=7, items=[item(track=999)])]))
    ps = inspect_playlist_payload(data).playlists
    assert len(ps) == 2 and [p.value("persistent_id") for p in ps] == [7, 7]
    assert [p.section_kind for p in ps] == [2, 14] and ps[0].section_index != ps[1].section_index
    assert "track_reference" not in codes(ps[1].diagnostics)


def test_opaque_child_no_tag_scan_and_unknown_header_local_values():
    fake = record(b"zzzz", 12, b"miph\x00mtph\x00SLst")
    short = record(b"miph", 32)
    doc = inspect_playlist_payload(payload([playlist(raw_tail=fake), short, playlist(pid=8)]))
    assert len(doc.playlists) == 3
    assert doc.playlists[0].opaque_children[0].read() == fake
    assert "playlist_header_profile" in codes(doc.playlists[1].diagnostics)
    assert all(f.level == "wire" for f in doc.playlists[1].fields)
    assert doc.playlists[2].value("persistent_id") == 8


def test_broken_child_and_section_extents_stop_locally():
    bad = bytearray(item()); number(bad, 8, 0xffffffff)
    data = payload([playlist(items=[bytes(bad)]), playlist(pid=8)])
    doc = inspect_playlist_payload(data)
    assert "child_framing" in codes(doc.playlists[0].diagnostics)
    assert doc.playlists[1].value("persistent_id") == 8
    truncated = inspect_playlist_payload(data + b"msdh")
    assert "section_framing" in codes(truncated.diagnostics) and len(truncated.playlists) == 2


def test_counts_are_diagnostics_not_silent_repairs():
    p = bytearray(playlist()); number(p, 16, 33)
    data = payload([bytes(p)])
    view = inspect_playlist_payload(data)
    assert "playlist_count" in codes(view.playlists[0].diagnostics)
    assert view.raw.read() == data


@pytest.mark.parametrize("overrides", [{"max_nodes": 1}, {"max_depth": 1}, {"max_plain_bytes": 100},
                                        {"max_text_bytes": 1}, {"memory_budget_bytes": 1}])
def test_document_limits(overrides):
    with pytest.raises(PlaylistLimitError):
        inspect_playlist_payload(payload(), limits=overrides)


def test_section_nodes_counted_and_text_budget_is_aggregate():
    data = record(b"msdh", 16, slots=[(12, 250, 4)]) * 2
    assert inspect_playlist_payload(data, limits={"max_nodes": 2}).node_count == 2
    with pytest.raises(PlaylistLimitError):
        inspect_playlist_payload(data, limits={"max_nodes": 1})
    with pytest.raises(PlaylistLimitError):
        inspect_playlist_payload(payload([playlist(metas=[title("ab")]), playlist(metas=[title("ab")])]), limits={"max_text_bytes": 7})


@pytest.mark.parametrize("bad", [{"max_nodes": True}, {"max_depth": 1000}, {"max_plain_bytes": 0}, {"surprise": 1}])
def test_limit_validation(bad):
    with pytest.raises(ValueError):
        inspect_playlist_payload(b"", limits=bad)


def test_limits_protocol_without_shared_dependency():
    class Limits:
        max_file_bytes = max_plain_bytes = 16 * 1024**2
        max_nodes, max_depth = 100000, 32
        max_text_bytes, max_json_bytes, memory_budget_bytes = 4 * 1024**2, 64 * 1024**2, 512 * 1024**2
    assert inspect_playlist_payload(payload(), limits=Limits()).playlists
    with pytest.raises(TypeError):
        inspect_playlist_payload(b"", limits=object())


def test_immutable_defensive_copy_and_raw_comparison():
    data = bytearray(payload())
    result = inspect_playlist_payload(data)
    original = result.raw.read()
    data[:] = b"x" * len(data)
    assert result.raw.read() == original
    with pytest.raises(FrozenInstanceError):
        result.byteorder = "big"
    assert RawSpan(0, 1, b"a") != RawSpan(0, 1, b"b")
    with pytest.raises(ValueError):
        RawSpan(0, 10, b"a")


def test_be_is_raw_preserved_without_fake_empty_success():
    data = payload()
    doc = inspect_playlist_payload(data, byteorder="big")
    assert doc.raw.read() == data and not doc.playlists
    assert "inner_endian" in codes(doc.diagnostics) and doc.track_reference_coverage == "incomplete"


def test_export_exact_boundary_no_duplicated_raw_nested_payload():
    data = payload([playlist(metas=[title(), metadata(101, smart([smart_rule(smart(), nested=1, action=1)]))])])
    doc = inspect_playlist_payload(data)
    encoded = models_json(doc, include_raw=True)
    value = json.loads(encoded)
    assert bytes.fromhex(value["payload_hex"]) == data
    assert encoded.count("payload_hex") == 1 and "_buffer" not in encoded
    assert models_json(doc, include_raw=True, limits={"max_json_bytes": len(encoded)}) == encoded
    with pytest.raises(PlaylistLimitError):
        models_json(doc, include_raw=True, limits={"max_json_bytes": len(encoded) - 1})
    with pytest.raises(PlaylistLimitError):
        models_json(doc, limits={"max_nodes": 1})
    with pytest.raises(PlaylistLimitError):
        models_json(parse_smart_rules(smart([smart_rule()])), limits={"max_nodes": 1})


def test_envelope_api_does_not_read_publish_or_rebuild(monkeypatch):
    from itlkit import Container, Library
    from test_core_support import library_bytes
    data = library_bytes()
    def forbidden(*args, **kwargs):
        raise AssertionError("read model called an I/O or semantic rebuild API")
    monkeypatch.setattr(Path, "read_bytes", forbidden)
    monkeypatch.setattr(Path, "write_bytes", forbidden)
    monkeypatch.setattr(Container, "to_bytes", forbidden)
    monkeypatch.setattr(Library, "to_bytes", forbidden)
    view = inspect_playlists(data)
    # test_core_support.library_bytes() supplies exactly one default playlist.
    assert view.envelope_sha256 and len(view.playlists) == 1
    assert view.playlists[0].value("persistent_id") == 0xBEEF000000000001
    with pytest.raises(PlaylistLimitError):
        inspect_playlists(data, limits={"max_file_bytes": len(data) - 1})


def test_dense_metadata_and_long_graph_are_bounded_without_recursion():
    metas = [metadata(777, b"x")] * 10000
    p = inspect_playlist_payload(payload([playlist(metas=metas)])).playlists[0]
    assert len(p.metadata) == 10000 and p.metadata[-1].occurrence_index == 9999
    entries = [item(i + 1, parent=i, group=1, track=0) for i in range(2000)]
    p = inspect_playlist_payload(payload([playlist(items=entries)])).playlists[0]
    assert "parent_cycle" not in codes(p.diagnostics) and p.parent_edges[-1].parent_index == 1998


def test_seeded_truncated_bytes_never_tag_resynchronize():
    import random
    rng = random.Random(437)
    for _ in range(100):
        data = rng.randbytes(rng.randrange(200))
        result = parse_smart_rules(data)
        assert result.raw.read() == data and not result.wire_complete
        result = inspect_playlist_payload(data)
        assert result.raw.read() == data and not result.playlists


def test_document_json_honors_stricter_observed_depth():
    raw = payload([playlist(metas=[title(), metadata(101, smart([smart_rule(smart(), nested=1, action=1)]))])])
    doc = inspect_playlist_payload(raw)
    assert doc.max_observed_depth == 6
    with pytest.raises(PlaylistLimitError):
        models_json(doc, limits={"max_depth": 5})
    assert json.loads(models_json(doc, limits={"max_depth": 6}))["model"]["max_observed_depth"] == 6


@pytest.mark.parametrize("reader", [inspect_playlists, inspect_playlist_payload, parse_smart_rules])
def test_input_memory_admission_precedes_defensive_copy(reader):
    class NoCopy(bytearray):
        def __bytes__(self):
            raise AssertionError("copied before memory admission")
    with pytest.raises(PlaylistLimitError, match="estimated input memory budget"):
        reader(NoCopy(b"x" * 100), limits={"memory_budget_bytes": 1})
