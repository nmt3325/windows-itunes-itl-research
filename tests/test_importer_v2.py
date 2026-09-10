"""Portable pure-helper tests plus opt-in fresh-native snapshot inspection.
No allocator/planning stubs, iTunes, media IO or candidate publication.
"""
import ast
from copy import deepcopy
from dataclasses import replace
from datetime import datetime
import hashlib
import json
import os
from pathlib import Path
import plistlib
import unittest
from unittest.mock import patch
from itlkit.container import Container
from itlkit.errors import ITLError
from itlkit.schema import ReadLimits, preflight_payload, load_container

from itlkit import Library
from itlkit.binary import put, uint
from itlkit.model import Node
from itlkit.importer import (
    ImportRefusal, _pid_list, _json_bytes, _pool_census, decode_msph800,
    _limits, _parse, encode_seed, _text_atom,
    _freeze_wire_layout, _assemble_wire, _validate_wire_assembly,
    inspect_pair, prepare, role_catalog, selected_closure,
    selected_wav_profile, transform_record,
)


def settings_values():
    return {'containerOrder': 1, 'defaultSettings': {'episodesToShow': 1,
        'episodesToShowTruth': 1, 'mediaType': 0, 'showPlayedEpisodes': 1},
        'includesAllPodcasts': 1, 'podcasts': [], 'settings': [], 'sortOrder': 1,
        'syncedToCloud': False, 'title': 'Most Recent', 'ungroupedList': 1,
        'updatedDate': datetime(2026, 1, 2, 3, 4, 5), 'uuid': 'PlaylistMostRecent'}


def settings_node(values=None, xml=None):
    raw = plistlib.dumps(settings_values() if values is None else values,
                        sort_keys=False) if xml is None else xml
    child = bytearray(24); child[:4] = b'mhoh'
    put(child, 4, 24); put(child, 8, 24 + len(raw)); put(child, 12, 800)
    header = bytearray(48); header[:4] = b'msph'
    put(header, 4, 48); put(header, 8, 72 + len(raw)); put(header, 12, 1)
    return Node(header, payload=bytes(child) + raw)


def track_node():
    h = bytearray(756); h[:4] = b'mith'; put(h, 4, 756); put(h, 8, 756)
    for off, val in ((0x10, 11), (0x14, 1), (0x8c, 1463899680),
                     (0xdc, 12), (0x1e0, 13), (0x1f4, 14)):
        put(h, off, val)
    put(h, 0x80, 0x123456789ABCD, 8)
    h[0x6d] = 1; h[0xee] = 7; put(h, 0x290, 34000)
    return Node(h, children=[])


def allocation_observation(call):
    """Instrumentation delegates to real implementations; no substitute parser."""
    counts = {'container_calls': 0, 'containers': 0, 'nodes': 0, 'decode_caps': []}
    original_call = Container.from_bytes
    original_container = Container.__init__
    original_node = Node.__init__
    def call_container(*a, **kw):
        counts['container_calls'] += 1
        counts['decode_caps'].append(kw['max_plain_bytes'])
        return original_call(*a, **kw)
    def init_container(self, *a, **kw):
        counts['containers'] += 1
        original_container(self, *a, **kw)
    def init_node(self, *a, **kw):
        counts['nodes'] += 1
        original_node(self, *a, **kw)
    with patch.object(Container, 'from_bytes', side_effect=call_container), \
         patch.object(Container, '__init__', init_container), \
         patch.object(Node, '__init__', init_node):
        try:
            return call(), None, counts
        except ITLError as exc:
            return None, exc, counts


class PureImporterTests(unittest.TestCase):
    def test_canonical_limits_for_default_and_explicit(self):
        self.assertIs(type(_limits()), ReadLimits)
        v = ReadLimits(max_nodes=11)
        self.assertIs(_limits(v), v)
        with self.assertRaises(ImportRefusal):
            _limits({'max_nodes': 11})

    def test_seed_known_utf8_protocol(self):
        prefix = b'itlkit.cross-import.seed.v1\x00'
        self.assertEqual(encode_seed(None), hashlib.sha256(prefix + b'\x00').digest())
        self.assertEqual(encode_seed('é'), hashlib.sha256(
            prefix + b'\x01\x00\x00\x00\x02\xc3\xa9').digest())
        self.assertNotEqual(encode_seed(None), encode_seed('None'))
        self.assertNotEqual(encode_seed('é'), encode_seed('e\u0301'))
        self.assertEqual(encode_seed('再現 seed'), encode_seed('再現 seed'))

    def test_seed_invalid_types_and_surrogate(self):
        for v in (True, 1, b'seed', '', 'x' * 129, '\ud800'):
            with self.subTest(value=repr(v)), self.assertRaises(ImportRefusal):
                encode_seed(v)


    def test_selection_canonical(self):
        self.assertEqual(_pid_list(['123456789abcdef0']), (0x123456789ABCDEF0,))

    def test_selection_duplicates(self):
        with self.assertRaises(ImportRefusal):
            _pid_list(['123456789ABCDEF0', '123456789abcdef0'])

    def test_selection_rejects_missing_malformed_bool(self):
        for value in ([], ['1'], ['0' * 16], [True], ['g' * 16], '123456789abcdef0'):
            with self.subTest(value=value), self.assertRaises(ImportRefusal):
                _pid_list(value)

    def test_json_budget_and_determinism(self):
        self.assertEqual(_json_bytes({'b': 2, 'a': 1}, 100), b'{"a":1,"b":2}')
        with self.assertRaises(ImportRefusal):
            _json_bytes({'large': 'x' * 1000}, 20)

    def test_settings_dictionary_not_hash_admission(self):
        a = settings_values(); b = settings_values()
        b['title'] = '新しい最近の曲'; b['updatedDate'] = datetime(2027, 2, 3)
        x = decode_msph800(settings_node(a)); y = decode_msph800(settings_node(b))
        self.assertEqual(x['profile'], y['profile'])
        self.assertNotEqual(x['record_sha256'], y['record_sha256'])
        self.assertFalse(x['semantic_independence_proven'])

    def test_settings_unknown_key(self):
        v = settings_values(); v['trackPID'] = '123456789ABCDEF0'
        with self.assertRaises(ImportRefusal):
            decode_msph800(settings_node(v))

    def test_settings_nonempty_references(self):
        for key in ('podcasts', 'settings'):
            v = settings_values(); v[key] = ['123456789ABCDEF0']
            with self.subTest(key=key), self.assertRaises(ImportRefusal):
                decode_msph800(settings_node(v))

    def test_settings_boolean_is_not_integer(self):
        v = settings_values(); v['containerOrder'] = True
        with self.assertRaises(ImportRefusal):
            decode_msph800(settings_node(v))

    def test_settings_duplicate_key(self):
        xml = plistlib.dumps(settings_values())
        xml = xml.replace(b'<key>title</key>', b'<key>containerOrder</key>')
        with self.assertRaises(ImportRefusal):
            decode_msph800(settings_node(xml=xml))

    def test_settings_entity_and_opaque_leaf(self):
        for xml in (b'<!DOCTYPE plist [<!ENTITY x "abc">]><plist>&x;</plist>',
                    b'<plist version="1.0"><data>AA==</data></plist>'):
            with self.subTest(xml=xml), self.assertRaises(ImportRefusal):
                decode_msph800(settings_node(xml=xml))

    def test_settings_count_and_frame(self):
        for off, value in ((12, 2), (16, 1)):
            n = settings_node(); put(n.header, off, value)
            with self.subTest(off=off), self.assertRaises(ImportRefusal):
                decode_msph800(n)
        n = settings_node(); n.payload += b'X'
        with self.assertRaises(ImportRefusal):
            decode_msph800(n)

    def test_transform_exact_byte_whitelist(self):
        n = track_node(); old = n.to_bytes()
        x, patches = transform_record(n, {'local': 21, 'album': 22,
                                         'artist': 23, 'secondary': 24})
        self.assertEqual(n.to_bytes(), old)
        expected = bytearray(old)
        for patch in patches:
            expected[patch.offset:patch.offset + len(patch.after)] = patch.after
        self.assertEqual(x.to_bytes(), bytes(expected))
        for off, size in ((0x80, 8), (0x6d, 1), (0xee, 1), (0x290, 28)):
            self.assertEqual(x.header[off:off + size], n.header[off:off + size])

    def test_transform_rejects_extra_missing_and_bool(self):
        values = {'local': 21, 'album': 22, 'artist': 23, 'secondary': 24}
        for v in ({}, values | {'rank': 0}, values | {'local': True},
                  values | {'local': 0}, values | {'local': 1000001}):
            with self.subTest(v=v), self.assertRaises(ImportRefusal):
                transform_record(track_node(), v)

    def test_transform_unknown_atom_occurrence(self):
        values = {'local': 21, 'album': 22, 'artist': 23, 'secondary': 24}
        for atoms in ({True: 5}, {999: 5}, {-1: 5}):
            with self.subTest(atoms=atoms), self.assertRaises(ImportRefusal):
                transform_record(track_node(), values, atoms)

    def test_prepare_unknown_keys_no_fallback(self):
        for intent in ({}, {'operation': 'raw'}, {'operation': 'cross_import',
             'source': 'donor', 'track_pids': [], 'ignore_opaque': True}):
            result = prepare(b'', intent, {'donor': b''})
            self.assertEqual(result['status'], 'blocked')
            self.assertIsNone(result['prepared_candidate_digest'])

    def test_prepare_file_type(self):
        i = {'operation': 'cross_import', 'source': 'donor',
             'track_pids': ['123456789ABCDEF0']}
        for data in (b'', bytearray(b'abc'), 'abc'):
            result = prepare(data, i, {'donor': b'bad'})
            self.assertEqual(result['status'], 'blocked')

    def test_no_production_assert_guards(self):
        source = Path(__file__).parents[1] / 'itlkit/importer.py'
        self.assertFalse(any(isinstance(n, ast.Assert) for n in ast.walk(ast.parse(source.read_text()))))


@unittest.skipUnless(os.environ.get('ITLKIT_FRESH_SNAPSHOT_DIR'),
                     'Set ITLKIT_FRESH_SNAPSHOT_DIR to the pinned closed snapshots')
class FreshSnapshotImporterTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        root = Path(os.environ['ITLKIT_FRESH_SNAPSHOT_DIR'])
        cls.paths = [root / 'fresh-004-three-reopened.itl', root / 'donor-v1-twenty-reopen2.itl']
        cls.target, cls.donor = [p.read_bytes() for p in cls.paths]
        cls.pins = [hashlib.sha256(x).hexdigest() for x in (cls.target, cls.donor)]
        cls.b = Library.from_bytes(cls.target, max_plain_bytes=4 * 1024**2)
        cls.d = Library.from_bytes(cls.donor, max_plain_bytes=4 * 1024**2)
        cls.selected = [f'{t.persistent_id:016X}' for t in cls.d.tracks
                        if uint(t.node.header, 0x8c) == 1463899680]

    def test_selected_only_not_twenty_copied(self):
        facts = inspect_pair(self.target, self.donor, self.selected)
        chosen = [r for r in facts['closure'] if r.tag == 'mith']
        self.assertEqual(len(chosen), len(self.selected))
        self.assertLess(len(chosen), len(self.d.tracks))
        self.assertEqual({r.persistent_id for r in chosen}, set(self.selected))

    def test_blank_aux_identities_not_label_merged(self):
        facts = inspect_pair(self.target, self.donor, self.selected)
        self.assertEqual(len([x for x in facts['closure'] if x.tag == 'miah']), len(self.selected))
        self.assertEqual(len([x for x in facts['closure'] if x.tag == 'miih']), len(self.selected))

    def test_repeat_inspection_deterministic(self):
        self.assertEqual(inspect_pair(self.target, self.donor, self.selected),
                         inspect_pair(self.target, self.donor, self.selected))

    def test_complete_old_new_wire_expected(self):
        v = json.loads(inspect_pair(self.target, self.donor, self.selected)['expected_wire_state_json'])
        self.assertEqual(len(v['old_tracks']), len(self.b.tracks))
        self.assertEqual(len(v['new_tracks']), len(self.selected))
        self.assertEqual(len(v['playlists']), len(self.b.playlists))
        self.assertNotEqual(v['file_pid'], v['master_pid'])

    def test_role_names_not_admission(self):
        from itlkit.library import set_text
        b = Library.from_bytes(self.target)
        for i, p in enumerate(b.playlists):
            c = next(n for n in p.node.children if n.type_code == 100)
            set_text(p.node, 100, '別名 ' + str(i))
        out = b.to_bytes()
        self.assertNotEqual(out, self.target)
        self.assertEqual(inspect_pair(out, self.donor, self.selected)['selected'], tuple(self.selected))

    def test_localized_kind_does_not_change_wire_profile(self):
        from itlkit.library import set_text
        donor = Library.from_bytes(self.donor)
        t = donor.track(persistent_id=int(self.selected[0], 16))
        c = next(n for n in t.node.children if n.type_code == 6)
        set_text(t.node, 6, 'WAVE の音声')
        selected_wav_profile(t)

    def test_shared_closure_once_on_explicit_offline_model(self):
        d = Library.from_bytes(self.donor)
        first = d.track(persistent_id=int(self.selected[0], 16))
        second = d.track(persistent_id=int(self.selected[1], 16))
        put(second.node.header, 0xdc, first.get('album_id'))
        put(second.node.header, 0x1e0, first.get('artist_id'))
        closure = selected_closure(d, self.selected[:2])
        self.assertEqual(len([x for x in closure if x.tag == 'miah']), 1)
        self.assertEqual(len([x for x in closure if x.tag == 'miih']), 1)
        self.assertEqual(closure[0].selected_consumers, tuple(self.selected[:2]))

    def test_selected_nonwav_refused(self):
        pid = next(t.persistent_id for t in self.d.tracks if uint(t.node.header, 0x8c) != 1463899680)
        with self.assertRaises(ImportRefusal):
            inspect_pair(self.target, self.donor, [f'{pid:016X}'])

    def test_selected_opaque_child_refused(self):
        donor = Library.from_bytes(self.donor)
        t = donor.track(persistent_id=int(self.selected[0], 16))
        h = bytearray(24); h[:4] = b'mhoh'; put(h, 4, 24); put(h, 8, 24); put(h, 12, 1)
        t.node.children.append(Node(h))
        with self.assertRaises(ImportRefusal):
            selected_closure(donor, self.selected[:1])

    def test_duplicate_pool_text_refused(self):
        from itlkit.library import set_text
        donor = Library.from_bytes(self.donor)
        t = donor.track(persistent_id=int(self.selected[1], 16))
        child = next(n for n in t.node.children if n.type_code == 6)
        set_text(t.node, 6, 'Conflicting same-pool string')
        with self.assertRaises(ImportRefusal):
            _pool_census(donor)

    def test_record_transform_all_old_bytes_unchanged(self):
        t = self.d.track(persistent_id=int(self.selected[0], 16))
        old = t.node.to_bytes()
        x, patches = transform_record(t.node, {'local': 500, 'secondary': 501,
                                              'album': 502, 'artist': 503}, {0: 300, 1: 301})
        self.assertEqual(old, t.node.to_bytes())
        self.assertEqual(len(patches), 6)
        for child, original in zip(x.children, t.node.children):
            self.assertEqual(child.payload, original.payload)
        self.assertEqual(x.header[0x80:0x88], t.node.header[0x80:0x88])

    def test_membership_local_token_distinct(self):
        role = role_catalog(self.b, target=True)[0]['master']
        x, patches = transform_record(role.items[0], {'local': 500, 'track': 501,
                  'token': 600, 'pid': 0x123456789ABCDEF0})
        self.assertEqual(uint(x.header, 16), 500)
        self.assertEqual(uint(x.header, 32), 600)
        self.assertEqual({p.namespace for p in patches},
                         {'local.item', 'ref.track.local', 'token.playlist', 'pid.item'})

    def test_current_entry_truthfully_blocked(self):
        result = prepare(self.target, {'operation': 'cross_import', 'source': 'donor',
            'track_pids': self.selected}, {'donor': self.donor}, seed='test')
        self.assertEqual(result['status'], 'blocked')
        self.assertIsNone(result['prepared_candidate_digest'])
        self.assertFalse(result['native_acceptance'])

    def test_input_files_unchanged(self):
        self.assertEqual([hashlib.sha256(p.read_bytes()).hexdigest() for p in self.paths], self.pins)
    def test_memory_one_refused_before_decode_and_node(self):
        _, error, calls = allocation_observation(lambda: inspect_pair(
            self.target, self.donor, self.selected, limits=ReadLimits(memory_budget_bytes=1)))
        self.assertIsNotNone(error)
        self.assertEqual(calls['container_calls'], 0)
        self.assertEqual(calls['containers'], 0)
        self.assertEqual(calls['nodes'], 0)

    def test_nodes_one_refused_before_node_single_input(self):
        _, error, calls = allocation_observation(lambda: _parse(
            self.target, ReadLimits(max_nodes=1)))
        self.assertIsNotNone(error)
        self.assertEqual(calls['container_calls'], 1)
        self.assertEqual(calls['nodes'], 0)

    def test_nodes_one_refused_before_any_pair_model(self):
        _, error, calls = allocation_observation(lambda: inspect_pair(
            self.target, self.donor, self.selected, limits=ReadLimits(max_nodes=1)))
        self.assertIsNotNone(error)
        self.assertEqual(calls['nodes'], 0)

    def test_nodes_budget_is_aggregate(self):
        stats = [preflight_payload(c.container.payload) for c in (self.b, self.d)]
        maximum = max(v['nodes'] for v in stats)
        _, error, calls = allocation_observation(lambda: inspect_pair(
            self.target, self.donor, self.selected, limits=ReadLimits(max_nodes=maximum)))
        self.assertIsNotNone(error)
        self.assertEqual(calls['container_calls'], 2)
        self.assertEqual(calls['nodes'], 0)

    def test_text_budget_is_aggregate(self):
        maximum = max(preflight_payload(c.container.payload)['text_bytes'] for c in (self.b, self.d))
        _, error, calls = allocation_observation(lambda: inspect_pair(
            self.target, self.donor, self.selected, limits=ReadLimits(max_text_bytes=maximum)))
        self.assertIsNotNone(error)
        self.assertEqual(calls['nodes'], 0)

    def test_plain_budget_is_aggregate(self):
        maximum = max(len(c.container.payload) for c in (self.b, self.d))
        _, error, calls = allocation_observation(lambda: inspect_pair(
            self.target, self.donor, self.selected, limits=ReadLimits(max_plain_bytes=maximum)))
        self.assertIsNotNone(error)
        self.assertEqual(calls['nodes'], 0)

    def test_memory_shrinks_actual_decompress_ceiling(self):
        _, error, calls = allocation_observation(lambda: inspect_pair(
            self.target, self.donor, self.selected,
            limits=ReadLimits(memory_budget_bytes=1024 * 1024)))
        self.assertIsNotNone(error)
        self.assertTrue(calls['decode_caps'])
        self.assertLess(calls['decode_caps'][0], len(self.b.container.payload))
        self.assertEqual(calls['containers'], 0)
        self.assertEqual(calls['nodes'], 0)

    def test_invalid_donor_before_target_model(self):
        _, error, calls = allocation_observation(lambda: inspect_pair(
            self.target, self.donor + b'bad length', self.selected))
        self.assertIsNotNone(error)
        self.assertEqual(calls['nodes'], 0)

    def test_no_library_normalization_during_inspection(self):
        with patch.object(Library, 'to_bytes', side_effect=AssertionError('normalization called')):
            facts = inspect_pair(self.target, self.donor, self.selected)
        self.assertEqual(facts['selected'], tuple(self.selected))

    def test_tiny_json_remains_blocked(self):
        with self.assertRaises(ImportRefusal):
            inspect_pair(self.target, self.donor, self.selected, limits=ReadLimits(max_json_bytes=1))

    def test_trailer_gate_before_model(self):
        c = Container.from_bytes(self.target)
        c.trailer = b'opaque' + (0x123456789ABCDEF0).to_bytes(8, 'little')
        data = c.to_bytes(rebuild=True)
        _, error, calls = allocation_observation(lambda: inspect_pair(data, self.donor, self.selected))
        self.assertIsInstance(error, ImportRefusal)
        self.assertEqual(error.code, 'UNKNOWN_COMPRESSION_TRAILER')
        self.assertEqual(calls['nodes'], 0)

    def test_master_exact_membership_gate_retained(self):
        lib = Library.from_bytes(self.target)
        master = role_catalog(lib, target=True)[0]['master']
        master.node.children.remove(master.items[-1])
        with self.assertRaisesRegex(ImportRefusal, 'MASTER_CLOSURE'):
            role_catalog(lib, target=True)

    def test_prepare_resource_refusal_has_no_candidate(self):
        intent = {'operation': 'cross_import', 'source': 'donor', 'track_pids': self.selected}
        result, error, calls = allocation_observation(lambda: prepare(
            self.target, intent, {'donor': self.donor}, limits=ReadLimits(memory_budget_bytes=1)))
        self.assertIsNone(error)
        self.assertEqual(result['status'], 'blocked')
        self.assertIsNone(result['prepared_candidate_digest'])
        self.assertEqual(calls['container_calls'], 0)
        self.assertEqual(calls['nodes'], 0)

    def _structural_values(self, selected):
        # Fixed OFFLINE TEST VECTORS, deliberately not an allocator or a ledger.
        # These never enter public prepare, a shared draft, publication or native.
        closure = selected_closure(self.d, selected)
        nums = iter(range(900001, 900501)); objects = {}; groups = {}
        nodes = {(sec, uint(n.header, 16)): n for sec, tag in
                 ((1, b'mith'), (9, b'miah'), (11, b'miih')) for n in self.d._records(sec, tag)}
        for row in closure:
            n = nodes[row.section, row.source_local]; values = {'local': next(nums)}
            if row.section == 1:
                values.update(album=objects[9, uint(n.header, 0xdc)]['slots']['local'],
                              artist=objects[11, uint(n.header, 0x1e0)]['slots']['local'],
                              secondary=next(nums))
            atoms = {}
            for i, child in enumerate(n.children or ()):
                atom = _text_atom(n, child, i)
                if atom is not None and atom[1]:
                    key = (atom[0], atom[1])
                    if key not in groups: groups[key] = 50001 + len(groups)
                    atoms[i] = groups[key]
            objects[row.section, row.source_local] = {'slots': values, 'atoms': atoms}
        roles = {}; counter = 0
        for role in ('master', 'downloaded_music', 'music'):
            roles[role] = {}
            for pid in selected:
                counter += 1; track = self.d.track(persistent_id=int(pid, 16))
                roles[role][int(pid, 16)] = {'local': next(nums), 'token': next(nums),
                    'pid': 0xFBCAD00000000000 + counter,
                    'track': objects[1, track.track_id]['slots']['local']}
        return objects, roles

    def _structural_layout(self, selected=None, target=None):
        selected = self.selected[:1] if selected is None else selected
        objects, roles = self._structural_values(selected)
        return _freeze_wire_layout(self.target if target is None else target,
                                   self.donor, selected, objects, roles)

    def test_private_full_assembly_and_independent_validation(self):
        for selected in (self.selected[:1], self.selected, list(reversed(self.selected))):
            with self.subTest(selection_size=len(selected)):
                layout = self._structural_layout(selected)
                # Full source/old expectations exist before the candidate bytes.
                original_expectation = layout.known_wire_expected_json
                self.assertTrue(layout.blockers)
                candidate = _assemble_wire(layout)
                with patch('itlkit.importer._assemble_wire', side_effect=AssertionError('builder rerun')):
                    self.assertTrue(_validate_wire_assembly(self.target, self.donor, selected, layout, candidate))
                self.assertEqual(layout.known_wire_expected_json, original_expectation)
                self.assertEqual(len(Library.from_bytes(candidate).tracks), len(self.b.tracks) + len(selected))
                result = prepare(self.target, {'operation': 'cross_import', 'source': 'donor',
                    'track_pids': selected}, {'donor': self.donor})
                self.assertEqual(result['status'], 'blocked')
                self.assertIsNone(result['prepared_candidate_digest'])

    def test_private_assembly_preserves_every_old_system_child(self):
        layout = self._structural_layout(); output = Library.from_bytes(_assemble_wire(layout))
        for old, new in zip(self.b.playlists, output.playlists):
            for a, b in zip(old.node.children, new.node.children):
                self.assertEqual(a.to_bytes(), b.to_bytes())
        for sec in (4, 21, 23):
            a = next(s for s in self.b.sections if s.section_type == sec)
            b = next(s for s in output.sections if s.section_type == sec)
            self.assertEqual(a.to_bytes(), b.to_bytes())

    def test_structural_validator_rejects_old_track_rank_flag_and_text_changes(self):
        layout = self._structural_layout(); wire = _assemble_wire(layout)
        for offset in (0x6d, 0xee, 0x290):
            bad = Library.from_bytes(wire); bad.tracks[0].node.header[offset] ^= 1
            with self.subTest(offset=offset), self.assertRaises(ImportRefusal):
                _validate_wire_assembly(self.target, self.donor, self.selected[:1], layout, bad.to_bytes())

    def test_structural_validator_rejects_opaque_settings_change(self):
        layout = self._structural_layout(); bad = Library.from_bytes(_assemble_wire(layout))
        node = bad._records(21, b'msph')[0]
        self.assertIn(b'Most Recent', node.payload)
        node.payload = node.payload.replace(b'Most Recent', b'Most Racent')
        with self.assertRaises(ImportRefusal):
            _validate_wire_assembly(self.target, self.donor, self.selected[:1], layout, bad.to_bytes())

    def test_structural_validator_rejects_system_child_reorder(self):
        layout = self._structural_layout(); bad = Library.from_bytes(_assemble_wire(layout))
        master = role_catalog(bad, target=True)[0]['master']
        positions = [i for i, n in enumerate(master.node.children) if n.tag == b'mtph']
        i, j = positions[:2]
        master.node.children[i], master.node.children[j] = master.node.children[j], master.node.children[i]
        with self.assertRaises(ImportRefusal):
            _validate_wire_assembly(self.target, self.donor, self.selected[:1], layout, bad.to_bytes())

    def test_structural_validator_rejects_aux_byte_change(self):
        layout = self._structural_layout(); bad = Library.from_bytes(_assemble_wire(layout))
        bad._records(9, b'miah')[0].header[40] ^= 1
        with self.assertRaises(ImportRefusal):
            _validate_wire_assembly(self.target, self.donor, self.selected[:1], layout, bad.to_bytes())

    def test_structural_values_detach_from_caller(self):
        selected = self.selected[:1]; objects, roles = self._structural_values(selected)
        layout = _freeze_wire_layout(self.target, self.donor, selected, objects, roles)
        before = _assemble_wire(layout)
        next(iter(objects.values()))['slots']['local'] = 1
        roles['master'][int(selected[0], 16)]['pid'] = 1
        self.assertEqual(_assemble_wire(layout), before)

    def test_proposed_collision_refuses_without_partial_public_plan(self):
        selected = self.selected[:1]; objects, roles = self._structural_values(selected)
        roles['master'][int(selected[0], 16)]['pid'] = self.b.persistent_id
        with self.assertRaisesRegex(ImportRefusal, 'COLLISION'):
            _freeze_wire_layout(self.target, self.donor, selected, objects, roles)

    def test_proposed_alias_split_refused(self):
        selected = self.selected[:2]; objects, roles = self._structural_values(selected)
        track = self.d.track(persistent_id=int(selected[1], 16))
        kind = next(i for i, n in enumerate(track.node.children) if n.type_code == 6)
        objects[1, track.track_id]['atoms'][kind] += 20
        with self.assertRaisesRegex(ImportRefusal, 'SOURCE_POOL_ALIAS_SPLIT'):
            _freeze_wire_layout(self.target, self.donor, selected, objects, roles)

    def test_proposed_reference_to_wrong_aux_refused(self):
        selected = self.selected[:1]; objects, roles = self._structural_values(selected)
        track = self.d.track(persistent_id=int(selected[0], 16))
        objects[1, track.track_id]['slots']['album'] = self.b.tracks[0].get('album_id')
        with self.assertRaisesRegex(ImportRefusal, 'SELECTED_REFERENCE_MAP_MISMATCH'):
            _freeze_wire_layout(self.target, self.donor, selected, objects, roles)

    def test_private_assembler_limits_before_encoding(self):
        layout = self._structural_layout()
        for caps in (ReadLimits(memory_budget_bytes=1), ReadLimits(max_nodes=1),
                     ReadLimits(max_plain_bytes=1), ReadLimits(max_file_bytes=1)):
            with self.subTest(caps=caps), patch.object(Container, 'to_bytes', side_effect=AssertionError('encoded early')):
                with self.assertRaises(ITLError): _assemble_wire(layout, limits=caps)

    def test_private_layout_cannot_be_applied_or_loaded_from_report(self):
        from itlkit.planning import apply
        layout = self._structural_layout()
        with self.assertRaises(TypeError): apply(self.b, layout)
        with self.assertRaises(ImportRefusal): _assemble_wire({'target_digest': layout.target_digest})

    def test_structural_validator_input_cas_and_selection(self):
        layout = self._structural_layout(); candidate = _assemble_wire(layout)
        with self.assertRaises(ImportRefusal):
            _validate_wire_assembly(self.target, self.donor, self.selected[:2], layout, candidate)
        with self.assertRaises(ImportRefusal):
            _validate_wire_assembly(self.target + b'X', self.donor, self.selected[:1], layout, candidate)

    def test_final_known_wire_projection_precedes_assembly(self):
        layout = self._structural_layout(self.selected)
        expected = json.loads(layout.known_wire_expected_json)
        self.assertFalse(expected['native_qualified'])
        candidate = Library.from_bytes(_assemble_wire(layout))
        by_pid = {f'{t.persistent_id:016X}': t for t in candidate.tracks}
        for row in expected['old_tracks'] + expected['new_tracks']:
            self.assertEqual(by_pid[row['pid']].to_dict(), row['metadata'])
            self.assertEqual(hashlib.sha256(by_pid[row['pid']].node.to_bytes()).hexdigest(), row['wire_sha256'])
        self.assertEqual(expected['counts']['tracks'], len(candidate.tracks))
        for row in expected['playlists']:
            playlist = candidate.playlist(int(row['pid'], 16))
            self.assertEqual(row['expected_members'], [f'{candidate.track(track_id=x).persistent_id:016X}' for x in playlist.track_ids])

    def test_structural_ordinary_bytes_order_and_counterexample(self):
        base = Library.from_bytes(self.target)
        ordinary = base.create_playlist('Offline preservation order',
            track_persistent_ids=[self.b.tracks[2].persistent_id, self.b.tracks[0].persistent_id],
            persistent_id=0xCBCC000000001337)
        target = base.to_bytes(); pid = ordinary.persistent_id
        before = base.playlist(pid).node.to_bytes()
        layout = self._structural_layout(target=target)
        wire = _assemble_wire(layout); after = Library.from_bytes(wire)
        self.assertEqual(after.playlist(pid).node.to_bytes(), before)
        self.assertTrue(_validate_wire_assembly(target, self.donor, self.selected[:1], layout, wire))
        pl = after.playlist(pid)
        positions = [i for i, n in enumerate(pl.node.children) if n.tag == b'mtph']
        a, b = positions
        pl.node.children[a], pl.node.children[b] = pl.node.children[b], pl.node.children[a]
        with self.assertRaisesRegex(ImportRefusal, 'UNTOUCHED_PLAYLIST_CHANGED'):
            _validate_wire_assembly(target, self.donor, self.selected[:1], layout, after.to_bytes())

    def test_structural_old_title_bytes_changed(self):
        layout = self._structural_layout(); bad = Library.from_bytes(_assemble_wire(layout))
        title = next(n for n in bad.tracks[0].node.children if n.type_code == 2)
        raw = bytearray(title.payload); raw[16] ^= 1; title.payload = bytes(raw)
        with self.assertRaisesRegex(ImportRefusal, 'OLD_OBJECT_BYTES_CHANGED'):
            _validate_wire_assembly(self.target, self.donor, self.selected[:1], layout, bad.to_bytes())

    def test_malformed_private_layout_cannot_loop_or_encode(self):
        layout = self._structural_layout(); sections = []
        for kind, raw in layout.sections:
            if kind == 2:
                changed = bytearray(raw); h = uint(raw, 4); offset = h + uint(raw, h + 4)
                put(changed, offset + 8, 0); raw = bytes(changed)
            sections.append((kind, raw))
        corrupt = replace(layout, sections=tuple(sections))
        with patch.object(Container, 'to_bytes', side_effect=AssertionError('encoded early')):
            with self.assertRaises(ITLError): _assemble_wire(corrupt)

    def test_structural_validator_aggregate_budget_before_candidate_nodes(self):
        layout = self._structural_layout(); candidate = _assemble_wire(layout)
        value, error, counts = allocation_observation(lambda: _validate_wire_assembly(
            self.target, self.donor, self.selected[:1], layout, candidate,
            limits=ReadLimits(memory_budget_bytes=1)))
        self.assertIsNone(value)
        self.assertIsNotNone(error)
        self.assertEqual(counts['nodes'], 0)
        self.assertEqual(counts['container_calls'], 0)

    def test_inspection_membership_intent_not_transient_wrapper_identity(self):
        facts = inspect_pair(self.target, self.donor, self.selected)
        expected = json.loads(facts['expected_wire_state_json'])
        roles = role_catalog(self.b, target=True)[0]
        enrolled = {f'{roles[r].persistent_id:016X}' for r in ('master', 'downloaded_music', 'music')}
        self.assertEqual(sum(bool(p['append_pids']) for p in expected['playlists']), 3)
        for p in expected['playlists']:
            self.assertEqual(p['append_pids'], self.selected if p['pid'] in enrolled else [])



if __name__ == '__main__':
    unittest.main()
