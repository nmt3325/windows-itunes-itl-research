"""G4-B a07 characterization tests for msdh sections 4, 21 (msph800) and 23.

Every assertion is re-derived from the native snapshots committed under
evidence/native/snapshots/. The tests are read-only with respect to the
fixtures: nothing is written to disk and iTunes is never invoked. Mutations
exist only in memory, to measure which framed fields a change would move.
"""
from __future__ import annotations

import hashlib
import plistlib
from functools import lru_cache
from pathlib import Path

import pytest

from itlkit import operations
from itlkit.binary import put, uint
from itlkit.container import Container
from itlkit.importer import decode_msph800
from itlkit.library import Library
from itlkit.model import parse_sections, serialize_sections

ROOT = Path(__file__).resolve().parents[1]
SNAPSHOTS = ROOT / 'evidence' / 'native' / 'snapshots'
EXPECTED_ORDER = [16, 12, 9, 11, 1, 13, 23, 2, 14, 21, 4]
REFERENCE = '001-one-track.itl'
DEFAULT_LOCATION_SNAPSHOT = '000-empty.itl'
MSPH800_KEYS = ['containerOrder', 'defaultSettings', 'includesAllPodcasts', 'podcasts',
                'settings', 'sortOrder', 'syncedToCloud', 'title', 'ungroupedList',
                'updatedDate', 'uuid']

pytestmark = pytest.mark.skipif(not SNAPSHOTS.is_dir(),
                                reason='native ITL snapshots are unavailable')


def snapshot_names():
    return [path.name for path in sorted(SNAPSHOTS.glob('*.itl'))]


@lru_cache(maxsize=None)
def payload_of(name):
    return Container.read(SNAPSHOTS / name).payload


@lru_cache(maxsize=None)
def sections_of(name):
    return tuple(parse_sections(payload_of(name)))


def sole_section(name, section_type):
    matches = [s for s in sections_of(name) if s.section_type == section_type]
    assert len(matches) == 1, '%s has %d sections of type %d' % (name, len(matches), section_type)
    return matches[0]


def msph_record(name):
    section = sole_section(name, 21)
    root = section.children[0]
    assert root.tag == b'mlsh'
    records = list(root.children or ())
    assert len(records) == 1
    return records[0]


def mhoh_text(node):
    payload = bytes(node.payload)
    encoding, length = uint(payload, 0, 4), uint(payload, 4, 4)
    data = payload[16:16 + length]
    return encoding, (data.decode('utf-16-le', 'replace') if encoding == 1
                      else data.decode('latin-1'))


def track_location_texts(name):
    out = []
    for section in sections_of(name):
        if section.section_type != 1 or not section.children:
            continue
        for track in section.children[0].children or ():
            if track.tag != b'mith':
                continue
            for child in track.children or ():
                if child.tag == b'mhoh' and child.type_code in (11, 13):
                    out.append((child.type_code, mhoh_text(child)[1]))
    return out


def node_map(sections):
    out = {}

    def walk(node, path):
        out[path] = node
        for index, child in enumerate(node.children or ()):
            tag = child.tag.decode('latin-1', 'replace')
            walk(child, '%s/%s[%d]' % (path, tag, index))

    for index, section in enumerate(sections):
        walk(section, 'msdh[%d](type=%s)' % (index, section.section_type))
    return out


def changed_nodes(before_sections, after_sections):
    before, after = node_map(before_sections), node_map(after_sections)
    assert set(before) == set(after), 'perturbation changed the node inventory'
    changed = set()
    for path, node in before.items():
        if bytes(node.header) != bytes(after[path].header):
            changed.add(path + ':header')
        if bytes(node.payload) != bytes(after[path].payload):
            changed.add(path + ':payload')
    return changed


def rebuild(library):
    return parse_sections(Container.from_bytes(library.to_bytes()).payload)


def test_corpus_is_the_observed_single_version_profile():
    names = snapshot_names()
    assert len(names) >= 50
    versions = {Container.read(SNAPSHOTS / name).version for name in names}
    assert versions == {'12.13.10.3'}


def test_every_snapshot_round_trips_byte_exactly():
    for name in snapshot_names():
        assert serialize_sections(list(sections_of(name))) == payload_of(name), name


def test_section_order_matches_the_importer_profile():
    for name in snapshot_names():
        assert [s.section_type for s in sections_of(name)] == EXPECTED_ORDER, name


def test_section4_is_an_unframed_ascii_media_folder_url():
    for name in snapshot_names():
        section = sole_section(name, 4)
        payload = bytes(section.payload)
        text = payload.decode('ascii')
        assert section.children is None
        assert text.startswith('file://localhost/') and text.endswith('/'), name
        assert not payload.endswith(b'\x00'), name
        assert '%20' in text, name
        assert uint(section.header, 8) == len(section.header) + len(payload), name
        assert len(section.header) == 96, name
        # No record framing: a 12-byte prefix would have to declare a sane header length.
        assert not (12 <= uint(payload, 4) <= len(payload)), name


def test_section4_varies_only_with_the_configured_media_folder():
    by_url = {}
    for name in snapshot_names():
        by_url.setdefault(bytes(sole_section(name, 4).payload).decode('ascii'), []).append(name)
    assert len(by_url) == 2, by_url.keys()
    default = [url for url, names in by_url.items() if names == [DEFAULT_LOCATION_SNAPSHOT]]
    assert len(default) == 1
    assert default[0].endswith('/Music/iTunes/iTunes%20Media/')
    # The single relocated value covers every other snapshot, across track and
    # playlist mutations, so section 4 does not track library content.
    relocated = [names for url, names in by_url.items() if url != default[0]]
    assert len(relocated) == 1 and len(relocated[0]) == len(snapshot_names()) - 1


def test_section4_url_is_not_referenced_anywhere_else():
    for name in snapshot_names():
        url = bytes(sole_section(name, 4).payload)
        assert payload_of(name).count(url) == 1, name
        for _code, text in track_location_texts(name):
            assert not text.startswith(url.decode('ascii')), name


def test_section23_is_an_empty_96_byte_stsh_root():
    digests = set()
    for name in snapshot_names():
        section = sole_section(name, 23)
        payload = bytes(section.payload)
        digests.add(hashlib.sha256(payload).hexdigest())
        assert section.children is None, name
        assert len(payload) == 96 and payload[:4] == b'stsh', name
        assert uint(payload, 4) == 96, name          # header length spans the whole body
        assert uint(payload, 8) == 0, name           # list-root count: no entries
        assert not any(payload[8:]), name            # everything after the count is zero
        assert uint(section.header, 8) == len(section.header) + len(payload), name
    assert len(digests) == 1


def test_section21_holds_exactly_one_msph800_settings_record():
    for name in snapshot_names():
        section = sole_section(name, 21)
        root = section.children[0]
        assert len(root.header) == 44 and uint(root.header, 8) == 1, name
        record = msph_record(name)
        assert record.tag == b'msph' and len(record.header) == 48, name
        assert uint(record.header, 12) == 1, name
        assert not any(record.header[16:]), name
        payload = bytes(record.payload)
        assert payload[:4] == b'mhoh', name
        assert uint(payload, 4) == 24, name
        assert uint(payload, 8) == len(payload), name
        assert uint(payload, 12) == 800, name
        assert not any(payload[16:24]), name
        assert uint(record.header, 8) == len(record.header) + len(payload), name
        assert (uint(section.header, 8)
                == len(section.header) + len(root.header) + uint(record.header, 8)), name


def test_msph800_payload_is_an_ascii_plist_dictionary():
    for name in snapshot_names():
        xml = bytes(msph_record(name).payload)[24:]
        assert all(byte < 128 for byte in xml), name
        assert not xml.endswith(b'\x00'), name
        value = plistlib.loads(xml)
        assert sorted(value) == MSPH800_KEYS, name
        assert value['uuid'] == 'PlaylistMostRecent', name
        assert value['podcasts'] == [] and value['settings'] == [], name
        assert sorted(value['defaultSettings']) == ['episodesToShow', 'episodesToShowTruth',
                                                    'mediaType', 'showPlayedEpisodes'], name


def test_msph800_record_is_byte_identical_across_the_whole_corpus():
    digests = {hashlib.sha256(msph_record(name).to_bytes()).hexdigest()
               for name in snapshot_names()}
    assert len(digests) == 1
    payloads = {hashlib.sha256(payload_of(name)).hexdigest() for name in snapshot_names()}
    assert len(payloads) == len(snapshot_names())


def test_native_msph800_records_satisfy_the_production_decoder():
    profiles, digests = set(), set()
    for name in snapshot_names():
        decoded = decode_msph800(msph_record(name))
        profiles.add(decoded['profile'])
        digests.add(decoded['record_sha256'])
        assert decoded['semantic_independence_proven'] is False, name
    assert profiles == {'empty-podcast-settings-dictionary.v1'}
    assert len(digests) == 1


def test_section4_length_change_moves_only_two_length_fields():
    before = parse_sections(payload_of(REFERENCE))
    library = Library.read(SNAPSHOTS / REFERENCE)
    section = [s for s in library.sections if s.section_type == 4][0]
    original_total = uint(section.header, 8)
    section.payload = bytes(section.payload)[:-1] + b'X/'
    after = rebuild(library)
    assert changed_nodes(before, after) == {
        'msdh[0](type=16)/mfdh[0]:header',
        'msdh[10](type=4):header',
        'msdh[10](type=4):payload',
    }
    grown = [s for s in after if s.section_type == 4][0]
    assert uint(grown.header, 8) == original_total + 1


def test_msph800_length_change_moves_exactly_four_length_fields():
    before = parse_sections(payload_of(REFERENCE))
    library = Library.read(SNAPSHOTS / REFERENCE)
    section = [s for s in library.sections if s.section_type == 21][0]
    root = section.children[0]
    record = root.children[0]
    payload = bytearray(record.payload)
    xml = bytes(payload[24:]).replace(b'<string>Most Recent</string>',
                                      b'<string>Most Recent XYZ</string>', 1)
    head = bytearray(payload[:24])
    put(head, 8, 24 + len(xml))
    record.payload = bytes(head) + xml
    after = rebuild(library)
    assert changed_nodes(before, after) == {
        'msdh[0](type=16)/mfdh[0]:header',
        'msdh[9](type=21):header',
        'msdh[9](type=21)/mlsh[0]/msph[0]:header',
        'msdh[9](type=21)/mlsh[0]/msph[0]:payload',
    }
    grown = [s for s in after if s.section_type == 21][0]
    assert uint(grown.header, 8) == 1107 + 4
    assert uint(grown.children[0].header, 8) == 1            # mlsh count is untouched
    assert uint(grown.children[0].children[0].header, 8) == 967 + 4


def test_in_place_edits_move_no_length_field():
    for section_type, mutate, expected in (
        (23, lambda node: node.__setattr__('payload', bytes(bytearray(node.payload[:16])
                                                            + b'\x01' + node.payload[17:])),
         'msdh[6](type=23):payload'),
        (21, None, 'msdh[9](type=21)/mlsh[0]/msph[0]:payload'),
    ):
        before = parse_sections(payload_of(REFERENCE))
        library = Library.read(SNAPSHOTS / REFERENCE)
        section = [s for s in library.sections if s.section_type == section_type][0]
        if section_type == 23:
            mutate(section)
        else:
            record = section.children[0].children[0]
            record.payload = bytes(record.payload).replace(b'<date>2026-09-09T11:13:03Z</date>',
                                                           b'<date>2027-01-02T03:04:05Z</date>', 1)
        after = rebuild(library)
        assert changed_nodes(before, after) == {expected}


def test_structural_guard_ignores_the_declared_stsh_entry_count():
    baseline = Library.read(SNAPSHOTS / REFERENCE)
    try:
        operations.require_simple_library(baseline)
    except Exception as exc:  # noqa: BLE001
        pytest.skip('reference snapshot is outside the guarded profile: %r' % exc)
    mutated = Library.read(SNAPSHOTS / REFERENCE)
    section = [s for s in mutated.sections if s.section_type == 23][0]
    payload = bytearray(section.payload)
    put(payload, 8, 1)
    section.payload = bytes(payload)
    # Characterization, not an endorsement: the guard checks only length and
    # magic, so a store index that declares one entry still passes as "empty".
    operations.require_simple_library(mutated)
