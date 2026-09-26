from pathlib import Path

from itlkit.binary import put
from itlkit.model import Node
from scripts.research.audit_allocation_graph_20260925 import analyze_model, audit_file


def _record(tag: bytes, size: int, *, children=None) -> Node:
    header = bytearray(size)
    header[:4] = tag
    put(header, 4, size)
    put(header, 8, size)
    return Node(header, children=children)


def _section(section_type: int, root_tag: bytes, records: list[Node]) -> Node:
    root_header = bytearray(12)
    root_header[:4] = root_tag
    put(root_header, 4, 12)
    put(root_header, 8, len(records))
    root = Node(root_header, kind="count", children=records)
    section_header = bytearray(16)
    section_header[:4] = b"msdh"
    put(section_header, 4, 16)
    put(section_header, 8, 16)
    put(section_header, 12, section_type)
    return Node(section_header, kind="section", children=[root])


def _opaque_section(section_type: int, payload: bytes) -> Node:
    header = bytearray(16)
    header[:4] = b"msdh"
    put(header, 4, 16)
    put(header, 8, 16 + len(payload))
    put(header, 12, section_type)
    return Node(header, kind="section", payload=payload)


def _text(type_code: int, atom_id: int, value: str) -> Node:
    header = bytearray(24)
    header[:4] = b"mhoh"
    put(header, 4, 24)
    put(header, 8, 40)
    put(header, 12, type_code)
    put(header, 16, atom_id)
    prefix = bytearray(16)
    encoded = value.encode("latin-1")
    put(prefix, 0, 3)
    put(prefix, 4, len(encoded))
    return Node(header, payload=bytes(prefix) + encoded)


def _track(
    local_id: int,
    persistent_id: int,
    secondary_id: int,
    *,
    album_id: int = 0,
    artist_id: int = 0,
    children=None,
    ranks=None,
) -> Node:
    node = _record(b"mith", 756, children=[] if children is None else children)
    put(node.header, 0x10, local_id)
    put(node.header, 0x80, persistent_id, 8)
    put(node.header, 0xDC, album_id)
    put(node.header, 0x1E0, artist_id)
    put(node.header, 0x1F4, secondary_id)
    for offset, value in zip(range(0x290, 0x2AC, 4), ranks or [0] * 7):
        put(node.header, offset, value)
    return node


def _aux(tag: bytes, size: int, local_id: int, persistent_id: int, *, children=None) -> Node:
    node = _record(tag, size, children=[] if children is None else children)
    put(node.header, 0x10, local_id)
    put(node.header, 0x14, persistent_id, 8)
    return node


def _item(local_id: int, track_id: int, order_token: int, persistent_id: int) -> Node:
    node = _record(b"mtph", 84, children=[])
    put(node.header, 0x10, local_id)
    put(node.header, 0x18, track_id)
    put(node.header, 0x20, order_token)
    put(node.header, 0x44, persistent_id, 8)
    return node


def _playlist(local_id: int, persistent_id: int, items: list[Node]) -> Node:
    node = _record(b"miph", 3500, children=items)
    put(node.header, 0x1B8, persistent_id, 8)
    put(node.header, 0xD40, local_id)
    return node


def _header() -> bytes:
    return bytes(144)


def test_identity_namespaces_do_not_become_global() -> None:
    tracks = [
        _track(1, 0x101, 11, album_id=30, artist_id=31),
        _track(2, 0x102, 12, album_id=30, artist_id=31),
    ]
    albums = [_aux(b"miah", 88, 30, 0xABC)]
    artists = [_aux(b"miih", 100, 31, 0xABC)]
    playlists = [
        _playlist(40, 0x201, [_item(7, 1, 7, 0x55)]),
        _playlist(41, 0x202, [_item(7, 2, 7, 0x55)]),
    ]
    result = analyze_model(
        _header(),
        [
            _section(1, b"mlth", tracks),
            _section(9, b"mlah", albums),
            _section(11, b"mlih", artists),
            _section(2, b"mlph", playlists),
        ],
    )
    identities = result["identities"]
    assert identities["item_local_within_playlist"]["within_owner_duplicate_groups"] == []
    assert identities["item_local_within_playlist"]["cross_owner_overlap_groups"] == [
        {"value": 7, "playlist_count": 2}
    ]
    assert identities["item_persistent_within_playlist"]["cross_owner_overlap_groups"] == [
        {"value": 0x55, "playlist_count": 2}
    ]
    assert identities["persistent_domains"]["album_persistent"]["duplicate_positive_groups"] == []
    assert identities["persistent_domains"]["artist_persistent"]["duplicate_positive_groups"] == []
    assert any(
        row["left"] == "album_persistent" and row["right"] == "artist_persistent"
        for row in identities["persistent_cross_domain_overlaps"]
    )


def test_global_high_water_is_an_over_approximation_and_raw_guard_is_visible() -> None:
    sections = [
        _section(1, b"mlth", [_track(10, 0x101, 900)]),
        _section(9, b"mlah", [_aux(b"miah", 88, 20, 0x301)]),
        _opaque_section(99, (901).to_bytes(4, "little")),
    ]
    allocator = analyze_model(_header(), sections)["allocator"]
    assert allocator["global_base_maximum"] == 900
    assert allocator["naive_next_id"] == 901
    assert allocator["raw_guard_skipped_values"] >= 1
    assert allocator["first_free_after_raw_guard"] >= 902
    assert "track_local" in allocator["fields_over_approximated_by_global_high_water"]
    assert "album_local" in allocator["fields_over_approximated_by_global_high_water"]


def test_known_pool_sharing_conflict_and_unkeyed_text_are_separate() -> None:
    tracks = [
        _track(1, 0x101, 11, children=[_text(2, 1, "same")]),
        _track(2, 0x102, 12, children=[_text(2, 1, "same")]),
        _track(3, 0x103, 13, children=[_text(2, 1, "different")]),
        _track(4, 0x104, 14, children=[_text(2, 0, "unkeyed")]),
    ]
    pools = analyze_model(_header(), [_section(1, b"mlth", tracks)])["string_pools"]
    assert len(pools["shared_cross_owner_binding_groups"]) == 1
    assert len(pools["conflicting_binding_groups"]) == 1
    assert pools["known_pool_stats"]["name"]["zero_id_nonempty_text"] == 1


def test_shared_auxiliary_fanout_is_reported_without_claiming_cow() -> None:
    tracks = [
        _track(1, 0x101, 11, album_id=70),
        _track(2, 0x102, 12, album_id=70),
    ]
    album = _aux(b"miah", 88, 70, 0x500)
    result = analyze_model(
        _header(),
        [_section(1, b"mlth", tracks), _section(9, b"mlah", [album])],
    )
    observation = result["auxiliary_references"]["album"]
    assert observation["maximum_fanout"] == 2
    assert observation["shared_reference_groups"][0]["local_id"] == 70
    assert observation["shared_reference_groups"][0]["target_count"] == 1


def test_sort_atom_ids_and_rank_words_are_reported_independently() -> None:
    track = _track(
        1,
        0x101,
        11,
        children=[_text(30, 1, "Sort Value")],
        ranks=[1000] * 7,
    )
    result = analyze_model(_header(), [_section(1, b"mlth", [track])])
    pools = result["string_pools"]
    ranks = result["sort_rank_cache"]
    assert pools["sort_atom_id_distributions"]["sort_name"] == {"1": 1}
    assert ranks["rank_vectors"] == {"1000,1000,1000,1000,1000,1000,1000": 1}
    assert ranks["scope"].startswith("raw per-track observations")


def test_audit_file_records_parse_failure_instead_of_raising(tmp_path: Path) -> None:
    path = tmp_path / "broken.itl"
    path.write_bytes(b"not an itl")
    result = audit_file(path, tmp_path)
    assert result["container"]["status"] == "error"
    assert result["structure"]["status"] == "not_run"
    assert result["high_level_library"]["status"] == "not_run"


def test_reference_fixture_agrees_between_structure_and_current_high_level_reader() -> None:
    root = Path(__file__).resolve().parents[1]
    path = root / "TEST_CORPUS/generated/reference-one-track-raw.itl"
    result = audit_file(path, root)
    assert result["container"]["status"] == "ok"
    assert result["structure"]["status"] == "ok"
    assert result["model"]["record_counts"]["tracks"] == 1
    assert result["high_level_library"]["status"] == "ok"
