"""Independent opt-in GATE01 controls; existing masterless fixtures stay intact.

Fixture concordance is offline, not new native acceptance or full RW coverage.
"""
from __future__ import annotations

import copy
import hashlib
import os
from pathlib import Path

import pytest

from itlkit import Container, FormatError, Library, Node, UnsupportedError
from itlkit.admission import require_complete_master
from itlkit.binary import put, uint
from itlkit.library import Playlist
from itlkit.model import parse_sections
from itlkit.planning import MutationDraft, apply, library_state_digest, prepare, prepare_mutation
from itlkit.raw import export_raw_tree, import_raw_tree
from itlkit.schema import LimitError, ProfileReport, ReadLimits
from test_core_support import library_bytes, list_record, playlist, record, section, track

MASTER = 0xBEEF000000000001
GOOD = ('complete', 'reordered', 'empty_complete', 'ordinary_duplicate',
        'ordinary_group', 'ordinary_nested', 'secondary_shadow', 'secondary_tracks')
BAD = ('no_master', 'two_masters', 'missing_member', 'duplicate_member',
       'same_count_duplicate', 'empty_no_master', 'secondary_only_master',
       'group', 'parent', 'nested', 'unknown_item_state', 'extended_item',
       'short_item', 'master_payload', 'unknown_master_child', 'unknown_primary_track',
       'unknown_primary_playlist', 'missing_tracks_root', 'missing_playlists_root',
       'missing_main', 'duplicate_section', 'wrong_root', 'extra_direct_root')


def make_library(case='complete'):
    tids = [] if case in ('empty_complete', 'empty_no_master') else [1, 2, 3]
    members = {'reordered': [3, 1, 2], 'missing_member': [1, 2],
               'duplicate_member': [1, 2, 3, 1], 'same_count_duplicate': [1, 1, 2]}.get(case, tids)
    ps = [] if case in ('no_master', 'empty_no_master', 'secondary_only_master') else [
        playlist(members, pid=MASTER, master=True, local_id=4)]
    if case == 'two_masters':
        ps.append(playlist(tids, pid=MASTER + 1, master=True, local_id=5))
    ordinary = [1, 1, 2] if case == 'ordinary_duplicate' else tids[:2]
    ps.append(playlist(ordinary, pid=MASTER + 10, local_id=6))
    lib = Library.from_bytes(library_bytes(tracks=[track(i) for i in tids], playlists=ps))
    masters = [p for p in lib.playlists if p.is_master]
    m = masters[0] if masters else None
    if case in ('secondary_shadow', 'secondary_only_master'):
        # Secondary PID/member values deliberately overlap/differ: not primary.
        lib.sections += parse_sections(section(14, list_record(b'mlph', 92, [
            playlist([999], pid=MASTER, master=True, local_id=4)])))
    if case == 'secondary_tracks':
        lib.sections += parse_sections(section(13, list_record(b'mlth', 92, [track(999)])))
    if case in ('group', 'parent', 'unknown_item_state'):
        put(m.items[0].header, {'group': 28, 'parent': 20, 'unknown_item_state': 36}[case], 1)
    if case == 'nested':
        m.items[0].children = [copy.deepcopy(m.items[1])]
    if case in ('extended_item', 'short_item'):
        n = m.items[0]
        n.header = n.header + b'\0' * 4 if case == 'extended_item' else n.header[:-4]
        put(n.header, 4, len(n.header))
    if case == 'master_payload':
        m.items[0].payload = b'not-flat'
    if case == 'unknown_master_child':
        m.node.children.append(Node(bytearray(record(b'zzzz', 12))))
    if case in ('ordinary_group', 'ordinary_nested'):
        n = lib.playlists[-1].items[0]
        if case == 'ordinary_group':
            put(n.header, 28, 1)
        else:
            n.children = [copy.deepcopy(lib.playlists[-1].items[1])]
    if case == 'unknown_primary_track':
        lib.tracks[0].node.header[:4] = b'zzzz'
    if case == 'unknown_primary_playlist':
        lib.playlists[-1].node.header[:4] = b'zzzz'
    missing = {'missing_tracks_root': 1, 'missing_playlists_root': 2, 'missing_main': 16}.get(case)
    if missing is not None:
        lib.sections = [n for n in lib.sections if n.section_type != missing]
    if case == 'duplicate_section':
        lib.sections.append(copy.deepcopy(next(n for n in lib.sections if n.section_type == 1)))
    if case == 'wrong_root':
        lib._root(1).header[:4] = b'zzzz'
    if case == 'extra_direct_root':
        next(n for n in lib.sections if n.section_type == 1).children.append(copy.deepcopy(lib._root(1)))
    return lib


def fingerprint(value):
    """Identity + value snapshot, including malformed/cyclic test models.

    Unknown objects are opaque identities, so malicious iter/len/repr hooks are
    not invoked by the oracle. Test deep graphs stay below Python stack limits.
    """
    seen = set()
    def visit(v):
        t = type(v)
        if t in (str, int, float, bytes, bool, type(None)):
            return (t.__name__, v)
        oid = id(v)
        if oid in seen:
            return ('ref', oid)
        seen.add(oid)
        if t is bytearray:
            return ('bytearray', oid, bytes(v))
        if t in (list, tuple):
            return (t.__name__, oid, tuple(visit(x) for x in v))
        if t is dict:
            return ('dict', oid, tuple((visit(k), visit(x)) for k, x in v.items()))
        if t in (Library, Container, Node):
            return (t.__name__, oid, visit(vars(v)))
        return ('opaque', t.__name__, oid)
    return visit(value)


def assert_pure(lib, *, accepted=True, limits=None, exception=(FormatError, UnsupportedError, TypeError)):
    before = fingerprint(lib)
    if accepted:
        result = require_complete_master(lib, limits=limits)
        assert type(result) is Playlist and result.library is lib
        assert any(result.node is n for n in lib._root(2).children)
        assert result.is_master
    else:
        with pytest.raises(exception):
            require_complete_master(lib, limits=limits)
        result = None
    assert fingerprint(lib) == before
    return result


@pytest.mark.parametrize('case', GOOD)
def test_positive_closed_membership_and_original_node(case):
    master = assert_pure(make_library(case))
    assert sorted(master.track_ids) == sorted(t.track_id for t in master.library.tracks)


@pytest.mark.parametrize('case', BAD)
def test_negative_membership_and_model_refusals_are_pure(case):
    assert_pure(make_library(case), accepted=False)


@pytest.mark.parametrize('case', ('complete', 'no_master', 'group', 'same_count_duplicate'))
def test_no_serialization_validation_repair_allocator_or_callback(monkeypatch, case):
    lib = make_library(case)
    import itlkit.library as core
    import itlkit.model as model
    def forbidden(*a, **k):
        raise AssertionError('forbidden side effect/accessor invoked')
    for cls, names in ((Library, ('_sync', 'to_bytes', 'to_dict', '_validate', '_require_semantic_profile',
                                  '_validate_ids_and_refs')),
                       (Container, ('to_bytes', 'from_bytes')),
                       (Node, ('walk', 'to_bytes', 'to_dict'))):
        for name in names:
            monkeypatch.setattr(cls, name, forbidden)
    monkeypatch.setattr(core, 'serialize_sections', forbidden)
    monkeypatch.setattr(model, 'serialize_sections', forbidden)
    # Per-instance accessor overrides must not be executed either.
    lib._root = forbidden
    lib._records = forbidden
    before = fingerprint(lib)
    if case == 'complete':
        result = require_complete_master(lib)
        assert result.library is lib
    else:
        with pytest.raises((FormatError, UnsupportedError)):
            require_complete_master(lib)
    assert fingerprint(lib) == before


@pytest.mark.parametrize('version', ('12.13.9.1', '12.13.10.3', '12.13.10.4', '99.0', ''))
def test_explicit_version_profile(version):
    lib = make_library()
    h = bytearray(lib.container.header)
    h[16] = len(version)
    h[17:32] = b'\0' * 15
    h[17:17 + len(version)] = version.encode('ascii')
    lib.container.header = bytes(h)
    assert_pure(lib, accepted=version in ('12.13.9.1', '12.13.10.3'))


@pytest.mark.parametrize('case', ('big_endian', 'unknown_trailer', 'unknown_encryption', 'short_outer',
                                  'long_track', 'short_playlist', 'root_size', 'section_size'))
def test_unsupported_shapes(case):
    lib = make_library()
    h = bytearray(lib.container.header)
    if case == 'big_endian':
        h[0x52] = 0
    elif case == 'unknown_trailer':
        lib.container.trailer = b'opaque'
    elif case == 'unknown_encryption':
        h[0x41] = 3
    elif case == 'short_outer':
        h = h[:-4]
        put(h, 4, len(h), endian='big')
    else:
        node = {'long_track': lib.tracks[0].node, 'short_playlist': lib.playlists[0].node,
                'root_size': lib._root(1),
                'section_size': next(n for n in lib.sections if n.section_type == 1)}[case]
        node.header = node.header[:-4] if case == 'short_playlist' else node.header + b'\0' * 4
        put(node.header, 4, len(node.header))
    lib.container.header = bytes(h)
    assert_pure(lib, accepted=False)


@pytest.mark.parametrize('offset', [20, 28, 36, 40, 44, 48, 52, 56, 60, 64, 76, 80])
def test_each_non_admitted_master_word_fails_closed(offset):
    lib = make_library()
    put(lib.playlists[0].items[0].header, offset, 0x80000001)
    assert_pure(lib, accepted=False)


def test_current_model_not_old_payload_and_result_not_a_certificate():
    lib = make_library()
    result = assert_pure(lib)
    old_payload = lib.container.payload
    node = result.items[-1]
    result.node.children = [n for n in result.node.children if n is not node]
    assert lib.container.payload == old_payload
    assert_pure(lib, accepted=False)
    assert len(result.track_ids) == 2  # a live view, not a sealed prior result


def test_stale_derived_counts_are_neither_normalized_nor_membership_authority():
    lib = make_library()
    put(lib._root(1).header, 8, 98765)
    put(lib.playlists[0].node.header, 16, 123456)
    put(lib._root(16).header, 0x44, 99)
    assert_pure(lib)
    assert uint(lib._root(1).header, 8) == 98765


def test_opaque_text_is_budgeted_not_decoded():
    lib = make_library()
    title = lib.playlists[0].node.children[0]
    payload = bytearray(title.payload)
    put(payload, 0, 99)
    title.payload = bytes(payload)
    assert_pure(lib)


ID_BAD = ('track_local_zero', 'track_local_duplicate', 'track_pid_zero', 'track_pid_duplicate',
          'secondary_zero', 'secondary_duplicate', 'playlist_local_zero', 'playlist_local_duplicate',
          'playlist_pid_zero', 'playlist_pid_duplicate', 'item_local_zero', 'item_local_duplicate',
          'item_pid_zero', 'item_pid_duplicate', 'missing_track_ref', 'missing_album_ref',
          'missing_artist_ref', 'album_local_zero', 'album_local_duplicate', 'album_pid_zero',
          'album_pid_duplicate', 'artist_local_zero', 'artist_pid_zero')


def identity_case(case):
    lib = make_library()
    ts = [t.node for t in lib.tracks]
    ps = [p.node for p in lib.playlists]
    items = lib.playlists[0].items
    targets = {
        'track_local': (ts, 16, 4), 'track_pid': (ts, 0x80, 8), 'secondary': (ts, 0x1f4, 4),
        'playlist_local': (ps, 0xd40, 4), 'playlist_pid': (ps, 0x1b8, 8),
        'item_local': (items, 16, 4), 'item_pid': (items, 68, 8),
    }
    if case.startswith(('album_', 'artist_')):
        artist = case.startswith('artist_')
        kind, tag, size = (11, b'miih', 100) if artist else (9, b'miah', 88)
        nodes = []
        for i in (7, 8):
            n = Node(bytearray(record(tag, size, count=0, fields=((16, i),))), children=[])
            put(n.header, 20, 0xAABB000000000000 + i, 8)
            nodes.append(n)
        lib._root(kind).children = nodes
        put(ts[0].header, 0x1e0 if artist else 0xdc, 7)
        targets['artist_local' if artist else 'album_local'] = (nodes, 16, 4)
        targets['artist_pid' if artist else 'album_pid'] = (nodes, 20, 8)
    if case.startswith('missing_'):
        n, off = (items[0], 24) if case == 'missing_track_ref' else (ts[0], 0xdc if case == 'missing_album_ref' else 0x1e0)
        put(n.header, off, 999)
    else:
        key, how = case.rsplit('_', 1)
        nodes, off, width = targets[key]
        put(nodes[0 if how == 'zero' else 1].header, off,
            0 if how == 'zero' else uint(nodes[0].header, off, width), width)
    return lib


@pytest.mark.parametrize('case', ID_BAD)
def test_linear_id_reference_predicates_match_core_refusals_and_remain_pure(case):
    lib = identity_case(case)
    before = fingerprint(lib)
    with pytest.raises(FormatError):
        Library._validate_ids_and_refs(lib)
    assert fingerprint(lib) == before
    assert_pure(lib, accepted=False)


class Bomb:
    def __iter__(self):
        raise AssertionError('unexpected iteration')
    def __len__(self):
        raise AssertionError('unexpected len')
    def __repr__(self):
        raise AssertionError('unexpected repr')


MALFORMED = ('sections_none', 'sections_generator', 'sections_bomb', 'section_not_node',
             'children_tuple', 'children_bomb', 'header_none', 'header_bomb', 'header_missing',
             'payload_none', 'payload_bomb', 'kind_none', 'kind_bomb', 'kind_unknown',
             'offset_bool', 'offset_negative', 'bad_header_length', 'short_header',
             'container_header_bomb', 'container_payload_none', 'original_bomb',
             'baseline_list', 'baseline_short', 'baseline_bomb', 'baseline_member_bomb',
             'cycle_node', 'shared_node', 'shared_section', 'metadata_children')


def malformed(case):
    lib = make_library()
    n = lib.playlists[0].items[0]
    if case == 'sections_none': lib.sections = None
    elif case == 'sections_generator': lib.sections = (s for s in lib.sections)
    elif case == 'sections_bomb': lib.sections = Bomb()
    elif case == 'section_not_node': lib.sections.append(Bomb())
    elif case == 'children_tuple': n.children = ()
    elif case == 'children_bomb': n.children = Bomb()
    elif case == 'header_none': n.header = None
    elif case == 'header_bomb': n.header = Bomb()
    elif case == 'header_missing': del n.header
    elif case == 'payload_none': n.payload = None
    elif case == 'payload_bomb': n.payload = Bomb()
    elif case == 'kind_none': n.kind = None
    elif case == 'kind_bomb': n.kind = Bomb()
    elif case == 'kind_unknown': n.kind = 'unknown'
    elif case == 'offset_bool': n.offset = True
    elif case == 'offset_negative': n.offset = -1
    elif case == 'bad_header_length': put(n.header, 4, 85)
    elif case == 'short_header': n.header = bytearray(b'mtph')
    elif case == 'container_header_bomb': lib.container.header = Bomb()
    elif case == 'container_payload_none': lib.container.payload = None
    elif case == 'original_bomb': lib.container._original = Bomb()
    elif case == 'baseline_list': lib.container._baseline = list(lib.container._baseline)
    elif case == 'baseline_short': lib.container._baseline = ()
    elif case == 'baseline_bomb': lib.container._baseline = Bomb()
    elif case == 'baseline_member_bomb': lib.container._baseline = (b'', Bomb(), b'')
    elif case == 'cycle_node': n.children = [n]
    elif case == 'shared_node': lib.playlists[-1].node.children.append(n)
    elif case == 'shared_section': lib.sections.append(lib.sections[0])
    elif case == 'metadata_children': lib.playlists[0].node.children[0].children = []
    else: raise AssertionError(case)
    return lib


@pytest.mark.parametrize('case', MALFORMED)
def test_malformed_models_reject_without_callbacks_recursion_or_mutation(case):
    assert_pure(malformed(case), accepted=False)


@pytest.mark.parametrize('value', (None, False, 1, {}, [], b'bytes', Bomb()))
def test_non_library_types_rejected_without_callbacks(value):
    with pytest.raises(TypeError):
        require_complete_master(value)


def test_missing_container_and_subclasses_rejected():
    lib = object.__new__(Library)
    with pytest.raises(TypeError): require_complete_master(lib)
    class Derived(Library): pass
    lib = Derived.from_bytes(library_bytes())
    with pytest.raises(TypeError): require_complete_master(lib)
    lib = make_library()
    lib.container = Bomb()
    assert_pure(lib, accepted=False, exception=TypeError)


@pytest.mark.parametrize('value', (False, 1, {}, [], Bomb()))
def test_limits_types_not_coerced(value):
    with pytest.raises(TypeError): require_complete_master(make_library(), limits=value)


def resource_amounts(lib):
    nodes = []
    stack = [(s, 0) for s in lib.sections]
    while stack:
        n, depth = stack.pop()
        nodes.append((n, depth))
        stack.extend((q, depth + 1) for q in n.children or ())
    model = sum(len(n.header) + len(n.payload) for n, _ in nodes)
    c = lib.container
    retained = sum(map(len, (c.header, c.payload, c.trailer, c._original, *c._baseline)))
    return {'max_file_bytes': len(c._original), 'max_plain_bytes': max(model, len(c.payload)),
            'max_nodes': len(nodes), 'max_depth': max(d for _, d in nodes),
            'max_text_bytes': sum(len(n.payload) for n, _ in nodes if n.tag == b'mhoh'),
            'memory_budget_bytes': (retained + model) * 4 + len(nodes) * 2048}


@pytest.mark.parametrize('dimension', ('max_file_bytes', 'max_plain_bytes', 'max_nodes',
                                      'max_depth', 'max_text_bytes', 'memory_budget_bytes'))
@pytest.mark.parametrize('delta', (0, -1))
def test_shared_limit_exact_boundaries_are_enforced_without_mutation(dimension, delta):
    lib = make_library()
    amount = resource_amounts(lib)[dimension]
    assert_pure(lib, accepted=delta == 0, limits=ReadLimits(**{dimension: amount + delta}), exception=LimitError)


def test_deep_graph_fails_bounded_not_recursionerror():
    lib = make_library()
    prototype = copy.deepcopy(lib.playlists[-1].items[0])
    current = copy.deepcopy(prototype)
    for _ in range(40):
        parent = copy.deepcopy(prototype)
        parent.children = [current]
        current = parent
    lib.playlists[-1].node.children.append(current)
    assert_pure(lib, accepted=False, exception=LimitError)


def test_wide_frontier_checked_before_expansion():
    lib = make_library()
    lib.playlists[-1].node.children += [None] * 1000
    assert_pure(lib, accepted=False, limits=ReadLimits(max_nodes=100), exception=LimitError)


def test_unknown_metadata_counts_toward_text_budget_and_json_budget_is_irrelevant():
    lib = make_library()
    title = lib.playlists[0].node.children[0]
    put(title.header, 12, 0xffffffff)
    assert_pure(lib, limits=ReadLimits(max_json_bytes=1))
    assert_pure(lib, accepted=False, limits=ReadLimits(max_text_bytes=1), exception=LimitError)


def test_mutated_frozen_limit_values_are_revalidated_and_callbacks_not_used():
    lib = make_library()
    limits = ReadLimits(max_nodes=1)
    object.__setattr__(limits, 'check', lambda *a: None)
    assert_pure(lib, accepted=False, limits=limits, exception=LimitError)
    object.__setattr__(limits, 'max_nodes', False)
    with pytest.raises(ValueError): require_complete_master(lib, limits=limits)


NO_EFFECT_ROWS = []
NO_EFFECT_OPS = ('empty_setter', 'same_year', 'same_name', 'same_name_refresh_bit',
                 'empty_operations', 'empty_fields_operation', 'same_playlist_name',
                 'legacy_empty_operations_plan', 'empty_generic_intent',
                 'raw_byte_noop', 'library_json_noop', 'raw_json_noop')


def no_effect_observation(case, operation):
    lib = make_library(case)
    if operation == 'same_name_refresh_bit':
        lib.tracks[0].node.header[0x6d] |= 1
    before_wire = lib.to_bytes()
    before_model = library_state_digest(lib)
    before_identity = fingerprint(lib)
    t = lib.tracks[0]
    calls = {'build': 0, 'validate': 0}
    if operation == 'empty_setter': t.set()
    elif operation == 'same_year': t.set(year=t.get('year'))
    elif operation in ('same_name', 'same_name_refresh_bit'): t.set(name=t.get('name'))
    elif operation == 'empty_operations': lib.apply_operations([])
    elif operation == 'empty_fields_operation': lib.apply_operations([{'op': 'set_track', 'track_id': 1, 'fields': {}}])
    elif operation == 'same_playlist_name':
        p = lib.playlists[-1]
        p.rename(p.name)
    elif operation == 'legacy_empty_operations_plan':
        prepared = prepare(before_wire, {'operations': []})
        receipt = apply(lib, prepared)
        assert not receipt.changed
    elif operation == 'empty_generic_intent':
        def build(data, intent, sources, **kwargs):
            calls['build'] += 1
            assert intent == {} and sources == {}
            return MutationDraft(data, ProfileReport('test-only', 'little'))
        def validate(data, intent, sources, candidate, report, **kwargs):
            calls['validate'] += 1
            return candidate == data and intent == {} and sources == {}
        prepared = prepare_mutation('test-only-identity', before_wire, {}, build=build, validate=validate)
        receipt = apply(lib, prepared)
        assert not receipt.changed and calls == {'build': 1, 'validate': 2}
    elif operation == 'raw_byte_noop':
        assert lib.to_bytes() == before_wire
    elif operation == 'library_json_noop':
        assert Library.from_dict(lib.to_dict()).to_bytes() == before_wire
    elif operation == 'raw_json_noop':
        assert import_raw_tree(export_raw_tree(before_wire), research_only=True).to_bytes() == before_wire
    else: raise AssertionError(operation)
    same_model = library_state_digest(lib) == before_model
    same_identity = fingerprint(lib) == before_identity
    same_wire = lib.to_bytes() == before_wire
    return {'case': case, 'operation': operation, 'accepted': True, 'byte_equal': same_wire,
            'model_value_equal_before_serialization': same_model, 'object_identity_equal': same_identity,
            'builder_calls': calls, 'native_actions': 0, 'admission_automatically_activated': False}


@pytest.mark.parametrize('case', ('complete', 'no_master'))
@pytest.mark.parametrize('operation', NO_EFFECT_OPS)
def test_no_effect_entrypoints_classified_without_auto_activation(case, operation):
    row = no_effect_observation(case, operation)
    NO_EFFECT_ROWS.append(row)
    assert row['accepted'] and row['byte_equal']
    if operation in ('empty_generic_intent', 'legacy_empty_operations_plan'):
        assert row['model_value_equal_before_serialization'] and row['object_identity_equal']


def test_explicit_residual_legacy_masterless_mutation_is_still_open():
    lib = make_library('no_master')
    assert_pure(lib, accepted=False)
    lib.tracks[0].set(year=2031)
    assert lib.tracks[0].get('year') == 2031
    assert_pure(lib, accepted=False)
    wire = lib.to_bytes()
    prepared = prepare(wire, {'operations': [{'op': 'set_track', 'track_id': 1, 'fields': {'year': 2032}}]})
    # to_bytes does not replace the old original/baseline cache. Its current
    # model therefore differs from the fresh byte snapshot prepared above.
    before = fingerprint(lib)
    with pytest.raises(FormatError, match='stale target model'):
        apply(lib, prepared)
    assert fingerprint(lib) == before
    fresh = Library.from_bytes(wire)
    assert_pure(fresh, accepted=False)
    receipt = apply(fresh, prepared)
    assert receipt.changed and fresh.tracks[0].get('year') == 2032
    assert_pure(fresh, accepted=False)
    assert 'require_complete_master' not in Library.__dict__


NATIVE_ROOT = os.environ.get('ITLKIT_NATIVE_ROOT')
NATIVE_FILES = sorted(Path(NATIVE_ROOT).glob('*.itl')) if NATIVE_ROOT else []


@pytest.mark.parametrize('path', NATIVE_FILES, ids=lambda p: p.name)
def test_existing_native_fixture_shape_only_offline(path):
    before_stat = path.stat()
    data = path.read_bytes()
    digest = hashlib.sha256(data).hexdigest()
    lib = Library.from_bytes(data)
    assert_pure(lib)
    after_stat = path.stat()
    assert (after_stat.st_size, after_stat.st_mtime_ns) == (before_stat.st_size, before_stat.st_mtime_ns)
    assert hashlib.sha256(path.read_bytes()).hexdigest() == digest
    assert lib.to_bytes() == data
