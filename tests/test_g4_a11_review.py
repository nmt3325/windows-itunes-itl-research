"""G4-B task a11: adversarial review probes. Read-only review; no production code is owned here.

Do not misread a green run as "a02 was reviewed":

* Branch g4/a02 was never reachable from the Linux research environment, so a02's
  actual diff is UNREVIEWED. Every probe below that targets itlkit/admission.py or
  itlkit/playlist_models.py was written against the phase base commit 1bb05ed and
  pins behaviour that a02's change must not silently alter. A pass means "the base
  invariant still holds here", never "a02's code is correct".
* The a05 tests are armed counterexamples. They skip until itlkit/media.py carries
  the a05 intake surface and then fail; both were already reproduced against a
  read-only snapshot of g4/a05 (command_id CMD-01).

See docs/g4/a11/review-findings.md for the ranked findings.
"""
import copy
import json
import struct

import pytest

from itlkit import FormatError, Library, Node
from itlkit import media
from itlkit import playlist_models as pm
from itlkit.admission import require_complete_master
from itlkit.binary import put
from itlkit.schema import LimitError, ReadLimits
from test_core_support import (item, library_bytes, list_record, playlist, record,
                               section, text, track, u32, u64)

MASTER = 0xBEEF000000000001


def _library():
    return Library.from_bytes(_wire())


def _wire():
    return library_bytes(tracks=[track(i) for i in (1, 2, 3)],
                         playlists=[playlist([1, 2, 3], pid=MASTER, master=True, local_id=4),
                                    playlist([1, 2], pid=MASTER + 10, local_id=6)])


def _observed_depth(library):
    stack, deepest = [(s, 0) for s in library.sections], 0
    while stack:
        node, depth = stack.pop()
        deepest = max(deepest, depth)
        stack.extend((child, depth + 1) for child in (node.children or ()))
    return deepest


def _nested_ordinary(levels):
    """Nest `levels` copies of an item under an ordinary playlist's first item."""
    library = _library()
    ordinary = library.playlists[-1]
    prototype = copy.deepcopy(ordinary.items[1])
    chain = copy.deepcopy(prototype)
    for _ in range(levels - 1):
        parent = copy.deepcopy(prototype)
        parent.children = [chain]
        chain = parent
    ordinary.items[0].children = [chain]
    return library


# --- target 1: depth mapping -------------------------------------------------

@pytest.mark.parametrize("levels, deepest, accepted", [(29, 32, True), (30, 33, False)])
def test_g4_a11_admission_depth_is_zero_based_so_thirty_three_levels_are_admitted(levels, deepest, accepted):
    library = _nested_ordinary(levels)
    assert _observed_depth(library) == deepest
    if accepted:
        assert require_complete_master(library) is not None
    else:
        with pytest.raises(LimitError) as excinfo:
            require_complete_master(library)
        assert "depth budget exceeded: 33 > 32" in str(excinfo.value)


def test_g4_a11_playlist_depth_ceiling_exceeds_the_shared_readlimits_ceiling():
    """Pins a contract conflict: the two accepted depth domains are not nested."""
    assert pm._limits({"max_depth": 33})["max_depth"] == 33
    assert pm._limits({"max_depth": 64})["max_depth"] == 64
    with pytest.raises(ValueError):
        pm._limits({"max_depth": 65})
    with pytest.raises(ValueError):
        ReadLimits(max_depth=33)
    assert pm._limits(ReadLimits())["max_depth"] == 32


def _slst(body, count, version=1):
    head = bytearray(136)
    head[:4] = b"SLst"
    struct.pack_into(">H", head, 4, version)
    struct.pack_into(">I", head, 8, count)
    return bytes(head) + body


def _slst_rule(payload, nested=0):
    head = bytearray(56)
    struct.pack_into(">I", head, 0, 4)
    struct.pack_into(">I", head, 4, 1)
    head[8] = nested
    struct.pack_into(">I", head, 52, len(payload))
    return bytes(head) + payload + (b"\0" if len(payload) & 1 else b"")


def _nested_slst(levels):
    body = _slst(_slst_rule(b"ab"), 1)
    for _ in range(levels):
        body = _slst(_slst_rule(body, nested=1), 1)
    return body


def test_g4_a11_smart_tree_nesting_costs_two_depth_levels_and_export_agrees():
    assert pm.parse_smart_rules(_nested_slst(15)).wire_complete is True
    with pytest.raises(pm.PlaylistLimitError):
        pm.parse_smart_rules(_nested_slst(16))
    tree = pm.parse_smart_rules(_nested_slst(15))
    assert pm.models_json(tree, limits={"max_depth": 31})
    with pytest.raises(pm.PlaylistLimitError):
        pm.models_json(tree, limits={"max_depth": 16})


# --- targets 3 and 4: order, duplicates, private state -----------------------

def _custom_miph(names, track_ids, persistent_id, local_id, master=False):
    strings = b"".join(text(100, name) for name in names)
    body = strings + b"".join(item(tid, 20 + index) for index, tid in enumerate(track_ids))
    head = bytearray(record(b"miph", 3500, count=len(names)))
    u32(head, 8, len(head) + len(body))
    u32(head, 16, len(track_ids))
    u64(head, 0x1b8, persistent_id)
    u32(head, 0xd40, local_id)
    u32(head, 0x14, 0x10000 if master else 0)
    return bytes(head) + body


def _payload():
    tracks = list_record(b"mlth", 92, [track(1), track(2)])
    playlists = list_record(b"mlph", 92, [
        _custom_miph(["Master"], [1, 2], MASTER, 4, master=True),
        _custom_miph(["Dup", "Dup"], [2, 2], MASTER + 10, 6)])
    return section(1, tracks) + section(2, playlists)


def test_g4_a11_export_preserves_array_order_and_duplicates():
    document = pm.inspect_playlist_payload(_payload())
    ordinary = document.playlists[1]
    assert [(m.child_index, m.occurrence_index, m.text) for m in ordinary.metadata] == \
           [(0, 0, "Dup"), (1, 1, "Dup")]
    assert [(e.child_index, e.value("local_id")) for e in ordinary.entries] == [(2, 20), (3, 21)]
    exported = json.loads(pm.models_json(document))
    assert list(exported["model"].keys())[:3] == ["schema", "raw", "byteorder"]
    assert list(exported["model"]["raw"].keys()) == ["offset", "size"]
    assert [m["text"] for m in exported["model"]["sections"][1]["playlists"][1]["metadata"]] == ["Dup", "Dup"]


def test_g4_a11_export_never_exposes_the_private_span_buffer():
    document = pm.inspect_playlist_payload(_payload())
    plain, with_raw = pm.models_json(document), pm.models_json(document, include_raw=True)
    assert "_buffer" not in plain and "payload_hex" not in plain
    assert "_buffer" not in with_raw and "payload_hex" in with_raw
    subtree = pm.parse_smart_rules(_nested_slst(2)).rules[0].tree
    exported = json.loads(pm.models_json(subtree, include_raw=True))
    span = subtree.rules[0].header
    start = (span.offset - exported["payload_base_offset"]) * 2
    assert exported["payload_hex"][start:start + span.size * 2] == span.read().hex()


# --- target 2: budget accounting ---------------------------------------------

def test_g4_a11_envelope_reservation_boundaries_keep_their_error_classes():
    wire = _wire()
    reserved = 6 * len(wire)
    with pytest.raises(pm.PlaylistLimitError):
        pm.inspect_playlists(wire, limits={"memory_budget_bytes": reserved})
    with pytest.raises(pm.PlaylistLimitError) as excinfo:
        pm.inspect_playlists(wire, limits={"memory_budget_bytes": reserved + 8})
    assert isinstance(excinfo.value.__cause__, FormatError)
    with pytest.raises(FormatError):
        pm.inspect_playlists(wire, limits={"max_plain_bytes": 1})
    caller = {"memory_budget_bytes": 512 * 1024 * 1024}
    document = pm.inspect_playlists(wire, limits=caller)
    assert caller == {"memory_budget_bytes": 512 * 1024 * 1024}
    assert document.estimated_model_bytes > 0


# --- target 5: auxiliary admission predicate ---------------------------------

def _aux_records(width, local_ids, persistent_id):
    nodes = []
    for local in local_ids:
        node = Node(bytearray(record(b"miah", width, count=0, fields=((16, local),))), children=[])
        put(node.header, 20, persistent_id, 8)
        nodes.append(node)
    return nodes


def test_g4_a11_aux_persistent_id_width_condition_still_matches_the_core():
    at_observed_width = _library()
    at_observed_width._root(9).children = _aux_records(88, (7, 8), 0xAABB000000000001)
    with pytest.raises(FormatError):
        Library._validate_ids_and_refs(at_observed_width)
    with pytest.raises(FormatError):
        require_complete_master(at_observed_width)

    widened = _library()
    widened._root(9).children = _aux_records(92, (7, 8), 0xAABB000000000001)
    Library._validate_ids_and_refs(widened)
    assert require_complete_master(widened) is not None


def test_g4_a11_aux_section_header_width_is_not_qualified():
    library = _library()
    aux_section = next(s for s in library.sections if s.section_type == 9)
    aux_section.header = aux_section.header + b"\0" * 4
    put(aux_section.header, 4, len(aux_section.header))
    assert require_complete_master(library) is not None


# --- a05 armed counterexamples ------------------------------------------------

a05_only = pytest.mark.skipif(
    not hasattr(media, "new_track_media_fields"),
    reason="a05 media intake surface is not on this branch; reproduced against a snapshot of g4/a05")


def _wav(extra=b"", rate=48000, channels=1, bits=16, frames=100):
    pcm = b"\0" * (frames * channels * bits // 8)
    fmt = struct.pack("<HHIIHH", 1, channels, rate, rate * channels * bits // 8,
                      channels * bits // 8, bits)
    body = (b"WAVE" + b"fmt " + struct.pack("<I", len(fmt)) + fmt + extra +
            b"data" + struct.pack("<I", len(pcm)) + pcm)
    return b"RIFF" + struct.pack("<I", len(body)) + body


def _riff_chunk(tag, payload):
    return tag + struct.pack("<I", len(payload)) + payload + (b"\0" if len(payload) & 1 else b"")


@a05_only
def test_g4_a11_counterexample_a05_recipe_status_implies_a_recipe_constant():
    """A row may only claim a recipe constant when one exists for that family."""
    facts = media.MediaFacts("AIFF", 1000, "ab" * 32, 48000, 1, 16, 480, 0.01,
                             "exact_pcm_frames", 768000, "pcm", ("COMM", "SSND"), (),
                             (("COMM", 12, 18), ("SSND", 38, 968)), (), ())
    with pytest.raises(media.MediaError):
        media.recipe_format_code(facts)
    rows = {row.field: row for row in media.new_track_media_fields(facts)}
    assert rows["format_code"].status == "absent_from_itlkit", (
        "no recipe constant exists for AIFF, yet the inventory reports %r with value %r; "
        "a candidate declaration would carry format_code=None as an unverified constant"
        % (rows["format_code"].status, rows["format_code"].value))


@a05_only
def test_g4_a11_counterexample_a05_unknown_chunk_is_an_undecoded_carrier():
    """An unknown chunk is never decoded, so it cannot be a bare-media candidate."""
    facts = media.probe_bytes(_wav(_riff_chunk(b"XYZ ", b"1234")))
    assert facts.chunk_spans[1][0] == "XYZ "
    assert facts.embedded_metadata_present, (
        "an unknown, never-decoded chunk is reported as bare media; carriers=%r"
        % (facts.metadata_carriers,))
