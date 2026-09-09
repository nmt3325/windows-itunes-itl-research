"""Pinned, report-only fresh Name isolation. Never runs iTunes or changes production.
Creates NEW files only below reports/codec/phase3. No old candidate is a generation
source: the public Track.set API is run against native 003, then factors copy that
new baseline. Input/code SHA guards and exact expanded-byte patches are enforced.
"""
from __future__ import annotations
import argparse
import hashlib
import itertools
import json
from pathlib import Path
import struct
import sys
import zlib

sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
SOURCE_SHA = 'a93cbc94da00eb60d1f5a45ac70af55948d4ecbae2ea735744af04b7b46128e4'
NATIVE_NAME_SHA = '8016112599308dce5f3b4c1e3e5f8391cd303b5b4b916fcac01bd378ee8db1c7'
OLD_FRESH_SHA = '34e4b4348ee4db611d59c1da23791700558c3c91bc44504e4d89a8e5c228ec0f'
TARGET = 'D018EAABC195E072'
FRESH = dict(name='Codec Fresh 🧪', rating=80, play_count=7, skip_count=2, year=2032, track_number=9)
FIELDS = tuple(FRESH)
PROTOCOL = {
    'purpose': 'Factorial observations, not a production fix or full native support claim',
    'apply_no_setters_or_repairs': True,
    'name_observation_stages': ['first PID lookup', 'after full read-only metadata snapshot and fresh PID lookup', 'after bounded idle and fresh PID lookup', 'before native save', 'after reload1', 'after reload2'],
    'name_persistence_target': 'expected_fields.name throughout; record actual changes rather than repairing',
    'unplayed': {'policy': 'observe_only', 'derive_from_play_count': False, 'source_observed': True, 'do_not_abort_name_probe_for_unplayed_alone': True},
    'also_observe': ['Rating', 'RatingKind', 'AlbumRating', 'AlbumRatingKind', 'PlayedCount', 'SkippedCount', 'Unplayed'],
    'identity_policy': 'File PID, master PID, track PID set and membership unchanged; master display sort order is not raw item order',
    'failed_stage_policy': 'Record full observations; do not dismiss unknown dialogs or mutate fields to force a pass',
}


def sha(data):
    return hashlib.sha256(data).hexdigest()


def u32(data, offset):
    return struct.unpack_from('<I', data, offset)[0]


def blob(data):
    result = {'length': len(data), 'sha256': sha(data)}
    if len(data) <= 256:
        result['hex'] = bytes(data).hex()
    return result


def runs(a, b):
    if len(a) != len(b):
        return {'length_changed': True, 'before': blob(a), 'after': blob(b)}
    result, i = [], 0
    while i < len(a):
        if a[i] == b[i]:
            i += 1
            continue
        start = i
        while i < len(a) and a[i] != b[i]:
            i += 1
        result.append({'offset': start, 'offset_hex': hex(start), 'before_hex': bytes(a[start:i]).hex(), 'after_hex': bytes(b[start:i]).hex()})
    return result


def write_new(path, data):
    with path.open('xb') as file:
        file.write(data)


def json_new(path, data):
    write_new(path, (json.dumps(data, ensure_ascii=False, indent=2) + '\n').encode('utf8'))


def oracle(data):
    # Independent envelope decoder. Does not call itlkit container helpers.
    from Crypto.Cipher import AES
    assert data[:4] == b'hdfm'
    header_size, file_size = struct.unpack_from('>II', data, 4)
    assert file_size == len(data) and 96 <= header_size <= len(data)
    body, flag = data[header_size:], data[0x41]
    cap = struct.unpack_from('>I', data, 0x5c)[0]
    assert flag in (0, 1, 2)
    interval = 0 if flag == 0 else len(body) if flag == 1 else min(len(body), cap)
    n = interval // 16 * 16
    plain = AES.new(b'BHUILuilfghuila3', AES.MODE_ECB).decrypt(body[:n]) + body[n:] if n else body
    if data[0x43]:
        dec = zlib.decompressobj()
        payload = dec.decompress(plain) + dec.flush()
        assert dec.eof
        return payload, dec.unused_data
    return plain, b''


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=Path(r'D:\a\_temp\gha-mcp\WINDOWS_RESEARCH_RUN\work\itl'))
    parser.add_argument('--codec-dir', type=Path)
    parser.add_argument('--out', type=Path, default=HERE / 'generated')
    args = parser.parse_args()
    root = args.root.resolve()
    codec = (args.codec_dir or root / 'wt/codec').resolve()
    out = args.out.resolve()
    scope = (root / 'reports/codec/phase3').resolve()
    if not out.is_relative_to(scope) or out == scope:
        raise ValueError('output must be a new subdirectory of reports/codec/phase3')
    if out.exists():
        raise FileExistsError('output directory already exists; choose a new replay directory')
    lock_bytes = (HERE / 'producer-lock.json').read_bytes()
    lock = json.loads(lock_bytes)
    for path, expected in lock['package_sha256'].items():
        if sha((codec / path).read_bytes()) != expected:
            raise ValueError('producer source hash mismatch: ' + path)
    sys.path.insert(0, str(codec))
    import itlkit
    from itlkit import Library
    from itlkit.library import text_nodes, read_text
    assert Path(itlkit.__file__).resolve().parent == codec / 'itlkit'
    source_path = root / 'fixtures/dynamic/snapshots/003-three-tracks-reloaded.itl'
    native_name_path = root / 'fixtures/dynamic/snapshots/010-name-unicode.itl'
    old_path = root / 'reports/codec/native-fresh-modified.itl'
    inputs = {source_path: SOURCE_SHA, native_name_path: NATIVE_NAME_SHA, old_path: OLD_FRESH_SHA}
    for path, expected in inputs.items():
        assert sha(path.read_bytes()) == expected, str(path)
    source = source_path.read_bytes()
    original = Library.from_bytes(source)
    native_name = Library.from_bytes(native_name_path.read_bytes())
    assert [s.section_type for s in original.sections] == [16, 12, 9, 11, 1, 13, 23, 2, 14, 21, 4]
    assert original.container.version == '12.13.10.3' and len(original.tracks) == 3

    def title(lib):
        target = lib.track(persistent_id=TARGET)
        nodes = text_nodes(target.node, 2)
        assert len(nodes) == 1 and len(nodes[0].header) == 24
        return target, nodes[0]

    def pool(lib):
        entries = []
        for section in lib.sections:
            for record in section.walk():
                if record.tag != b'mith':
                    continue
                for text in text_nodes(record, 2):
                    assert len(text.header) == 24
                    value = read_text(text)
                    entries.append({'section': section.section_type, 'track_persistent_id': f'{struct.unpack_from("<Q", record.header, 0x80)[0]:016X}',
                                    'record_offset': record.offset, 'text_offset': text.offset,
                                    'external_id': u32(text.header, 16), 'encoding': u32(text.payload, 0),
                                    'decoded_utf16le_sha256': sha(value.encode('utf-16-le')), 'record_sha256': sha(text.to_bytes())})
        return entries

    inventory = pool(original)
    used = {entry['external_id'] for entry in inventory}
    assert used == {1, 2, 3} and len(inventory) == 3
    fresh_id = max(used) + 1
    assert fresh_id == 4 and fresh_id < 2**31
    # Not a general allocator: completeness is scoped to the exact pinned fixture.
    # Other known pools may reuse 4; no global-uniqueness requirement is imposed.

    def replay_api(fields):
        lib = Library.from_bytes(source)
        lib.track(persistent_id=TARGET).set(**fields)
        return lib.to_bytes(rebuild=True, compression_level=6)

    baseline = replay_api(FRESH)
    base = Library.from_bytes(baseline)
    bt, bn = title(base)
    assert bt.node.header[0x6d] == 1 and u32(bt.node.header, 0x290) == 1000 and u32(bn.header, 16) == 1
    assert baseline == old_path.read_bytes(), 'Public API replay differs from old fresh candidate; investigate rather than hide the difference'
    assert bt.node.header[0xee] == 0
    base_payload = base.container.payload
    original_t, original_n = title(original)
    native_t, native_n = title(native_name)

    def record_diff(left, right):
        differences = []
        def walk(a, b, path):
            assert a.tag == b.tag and len(a.header) == len(b.header)
            if bytes(a.header) != bytes(b.header):
                differences.append({'path': path, 'region': 'header', 'old_offset': a.offset, 'new_offset': b.offset, 'changes': runs(a.header, b.header)})
            assert (a.children is None) == (b.children is None)
            if a.children is None:
                if a.payload != b.payload:
                    differences.append({'path': path, 'region': 'payload', 'old_offset': a.offset, 'new_offset': b.offset, 'changes': runs(a.payload, b.payload)})
            else:
                assert len(a.children) == len(b.children)
                for index, (ac, bc) in enumerate(zip(a.children, b.children)):
                    label = ac.tag.decode('ascii') + (f':type{ac.type_code}' if ac.type_code is not None else '')
                    walk(ac, bc, path + f'/{index}:{label}')
        assert len(left.sections) == len(right.sections)
        for a, b in zip(left.sections, right.sections):
            assert a.section_type == b.section_type
            walk(a, b, f'section:{a.section_type}')
        return differences

    out.mkdir(parents=False, exist_ok=False)
    cases = []
    primary_for_sha = {}
    def add(name, data, category, api_fields, factors=None):
        lib = Library.from_bytes(data)
        payload, trailer = oracle(data)
        assert payload == lib.container.payload and trailer == lib.container.trailer
        assert lib.to_bytes() == data
        assert oracle(lib.to_bytes(rebuild=True)) == (payload, trailer)
        target, tn = title(lib)
        assert len(lib.tracks) == 3 and {t.persistent_id for t in lib.tracks} == {t.persistent_id for t in original.tracks}
        assert lib.summary()['file_persistent_id'] == original.summary()['file_persistent_id']
        assert lib.summary()['library_persistent_id'] == original.summary()['library_persistent_id']
        for t in original.tracks:
            if f'{t.persistent_id:016X}' != TARGET:
                assert lib.track(persistent_id=t.persistent_id).node.to_bytes() == t.node.to_bytes()
        assert [p.node.to_bytes() for p in lib.playlists] == [p.node.to_bytes() for p in original.playlists]
        for section in lib.sections:
            if section.section_type not in (1, 16):
                before = next(s for s in original.sections if s.section_type == section.section_type)
                assert section.to_bytes() == before.to_bytes()
        for code in (6, 13, 11):
            assert text_nodes(target.node, code)[0].to_bytes() == text_nodes(original_t.node, code)[0].to_bytes()
        assert target.node.header[0xee] == original_t.node.header[0xee] == 0
        expected = {field: original_t.get(field) for field in FIELDS}
        expected.update(api_fields)
        assert {field: target.get(field) for field in FIELDS} == expected
        filename = name + '.itl'
        write_new(out / filename, data)
        digest = sha(data)
        row = {'name': name, 'category': category, 'input': str(source_path), 'input_sha256': SOURCE_SHA,
               'output': str(out / filename), 'file': filename, 'sha256': digest, 'bytes': len(data),
               'expanded_bytes': len(payload), 'expanded_sha256': sha(payload),
               'file_persistent_id': lib.summary()['file_persistent_id'], 'library_persistent_id': lib.summary()['library_persistent_id'],
               'track_count': 3, 'track_persistent_ids': [f'{t.persistent_id:016X}' for t in lib.tracks],
               'target_track': TARGET, 'expected_fields': expected,
               'semantic_api_fields': api_fields, 'raw_factors': factors,
               'stored_state': {'mith_byte_6d': target.node.header[0x6d], 'title_external_id': u32(tn.header, 16), 'mith_word_290': u32(target.node.header, 0x290), 'mith_byte_ee': target.node.header[0xee]},
               'native_acceptance': 'pending', 'native_probe_protocol': PROTOCOL,
               'unchanged_assertions': ['other tracks byte-exact', 'playlists byte-exact', 'non-track sections except logical mfdh byte-exact', 'target mhoh6/13/11 byte-exact', 'byte0xee preserved'],
               'producer_lock_sha256': sha(lock_bytes), 'producer_head': lock['codec_head']}
        if digest in primary_for_sha:
            row['same_sha_as'] = primary_for_sha[digest]
        else:
            primary_for_sha[digest] = name
        row['expanded_record_differences_from_source'] = record_diff(original, lib)
        row['outer_header_differences_from_source'] = runs(original.container.header, lib.container.header)
        row['expanded_byte_differences_from_fresh_baseline'] = runs(base_payload, payload)
        if factors is not None:
            expected_payload = bytearray(base_payload)
            patches = []
            specifications = [('A', bt.node.offset + 0x6d, 1, 0, 'mith', '0x6d'),
                              ('B', bn.offset + 0x10, 4, fresh_id, 'title-mhoh', '0x10'),
                              ('C', bt.node.offset + 0x290, 4, 0, 'mith', '0x290')]
            for axis, offset, width, value, region, relative in specifications:
                if factors[axis]:
                    before = bytes(expected_payload[offset:offset + width])
                    after = value.to_bytes(width, 'little')
                    expected_payload[offset:offset + width] = after
                    patches.append({'factor': axis, 'region': region, 'relative_offset': relative, 'expanded_absolute_offset': offset, 'width': width, 'before_hex': before.hex(), 'after_hex': after.hex()})
            assert bytes(expected_payload) == payload, name + ' unexpected expanded byte changes'
            row['controlled_patches_from_baseline'] = patches
            row['generation_method'] = 'Copy freshly API-generated baseline, apply ONLY listed raw factors, serialize with unchanged production codec'
        elif category == 'api':
            row['generation_method'] = 'Re-run public Track.set(**semantic_api_fields) on native 003; not old-candidate reconstruction'
        else:
            row['generation_method'] = 'Exact byte copy of pinned native 003 reference, no operation'
        cases.append(row)
        print(name, digest, row['stored_state'])

    add('fresh-api-baseline', baseline, 'api', FRESH)
    for a, b, c in itertools.product((0, 1), repeat=3):
        lib = Library.from_bytes(baseline)
        target, name_node = title(lib)
        if a:
            target.node.header[0x6d] = 0
        if b:
            struct.pack_into('<I', name_node.header, 0x10, fresh_id)
        if c:
            struct.pack_into('<I', target.node.header, 0x290, 0)
        add(f'factor-A{a}-B{b}-C{c}', lib.to_bytes(rebuild=True), 'factorial', FRESH, {'A': a, 'B': b, 'C': c})
    add('control-name-only', replay_api({'name': FRESH['name']}), 'api', {'name': FRESH['name']})
    add('control-play-count-only', replay_api({'play_count': 7}), 'api', {'play_count': 7})
    add('control-native-noop', source, 'reference', {})
    assert len(cases) == 12 and len(primary_for_sha) == 11
    relation = {
        'public_api_replay_sha256': sha(baseline), 'old_fresh_sha256': OLD_FRESH_SHA, 'bit_identical': True,
        'old_candidate_used_to_generate': False,
        'v4_method_distinction': 'v4 force-reserialized existing candidates. This script actually invokes current public Track.set on original native 003 before building variants.',
    }
    native_delta = {'source_sha256': SOURCE_SHA, 'native_name_control_sha256': NATIVE_NAME_SHA,
                    'target_pid': TARGET, 'header_byte_differences': runs(original_t.node.header, native_t.node.header),
                    'title_external_id': [u32(original_n.header, 16), u32(native_n.header, 16)],
                    'other_mhoh_equal': {str(code): text_nodes(original_t.node, code)[0].to_bytes() == text_nodes(native_t.node, code)[0].to_bytes() for code in (6, 13, 11)},
                    'interpretation': 'Co-occurrence of three factors plus required text/size changes, not isolated causation'}
    manifest = {'schema': 'itlkit.experiment.fresh-name.v1', 'scope': 'experimental copies only; production unchanged',
                'producer_lock': lock, 'generator_sha256': sha(Path(__file__).read_bytes()),
                'input_hashes': {str(p): h for p, h in inputs.items()},
                'factors': {'A': 'mith+0x6d byte 1 -> 0; meaning not named', 'B': 'title pool L+0x178 mhoh+0x10 u32 1 -> fresh compact ID4', 'C': 'mith+0x290 u32 1000 -> 0; not a string atom ID'},
                'factorial_case_count': 8, 'total_files': 12, 'unique_file_hashes': 11,
                'title_pool_inventory': inventory, 'compact_id_selection': {'used': sorted(used), 'selected': fresh_id, 'policy': 'max observed in this pinned known title pool + 1; not a general unknown-pool allocator'},
                'semantic_reexecution_vs_v3': relation, 'native_003_to_010_observation': native_delta,
                'native_probe_protocol': PROTOCOL, 'candidates': cases}
    json_new(out / 'manifest.json', manifest)
    json_new(out / 'native-validation-requests.json', cases)
    for path, expected in inputs.items():
        assert sha(path.read_bytes()) == expected, str(path)
    for path, expected in lock['package_sha256'].items():
        assert sha((codec / path).read_bytes()) == expected, path
    print('FRESH_API_REPLAY_IDENTICAL', sha(baseline))
    print('MANIFEST_SHA', sha((out / 'manifest.json').read_bytes()))
    print('CANDIDATE_FILES 12 UNIQUE_HASHES 11 FACTORIAL 8')
    print('PRODUCTION_AND_ALL_INPUTS_UNCHANGED')


if __name__ == '__main__':
    main()