"""Independently audit closed native phase3 evidence; never launch or import native automation."""
from pathlib import Path
from collections import Counter
import argparse
import hashlib
import json
import re
import subprocess
import sys
import traceback
import zlib


def require(value, message):
    if not value:
        raise ValueError(message)


def unique(rows, label):
    require(isinstance(rows, list), label + ': list required')
    out = {}
    for row in rows:
        pid = row['persistent_id']
        require(isinstance(pid, str) and re.fullmatch('[0-9A-F]{16}', pid) and int(pid, 16) != 0, label + ': invalid PID')
        require(pid not in out, label + ': duplicate PID')
        out[pid] = row
    return out


def compare_state(actual, expected, ignore, ordinary):
    require(actual['version'] == expected['version'], 'native version')
    require(actual['library_persistent_id'] == expected['library_persistent_id'], 'master identity')
    aa, ee = unique(actual['tracks'], 'actual tracks'), unique(expected['tracks'], 'expected tracks')
    require(type(actual['track_count']) is int and actual['track_count'] == len(aa) == expected['track_count'] == len(ee), 'enumeration/count disagreement')
    require(set(aa) == set(ee), 'complete track PID set')
    fields = 0
    for pid, exp in ee.items():
        for key, value in exp.items():
            if key in ignore:
                continue
            require(key in aa[pid], 'missing field ' + key)
            got = aa[pid][key]
            if key == 'Location':
                require(isinstance(got, str) and str(Path(got)).casefold() == str(Path(value)).casefold(), 'Location changed')
            else:
                require(got == value and (type(got) is bool) == (type(value) is bool), 'field mismatch ' + pid + '/' + key)
            fields += 1
    ap, ep = unique(actual['playlists'], 'actual playlists'), unique(expected['playlists'], 'expected playlists')
    require(set(ap) == set(ep), 'complete visible playlist PID set')
    for pid, exp in ep.items():
        got = ap[pid]
        for key in ('name', 'kind', 'special_kind'):
            if key in exp:
                require(got.get(key) == exp[key], 'playlist classification/name changed')
        gm = [v['persistent_id'] for v in got['members']]
        em = [v['persistent_id'] for v in exp['members']]
        require(set(gm) <= set(aa), 'dangling visible playlist reference')
        require(gm == em if pid in ordinary else Counter(gm) == Counter(em), 'playlist membership/order changed')
    return fields


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('root', type=Path)
    parser.add_argument('output', type=Path)
    parser.add_argument('--cases', nargs='+', default=['p4-fresh-api', 'crud3-cross-one-003', 'crud3-cross-shared-two-037'])
    args = parser.parse_args()
    root, output = args.root.resolve(), args.output.resolve()
    require(output.is_relative_to(root / 'reports/parent') and not output.exists(), 'new parent-owned output required')
    output.mkdir(parents=True)
    source = subprocess.check_output(['git', '-C', str(root / 'repo'), 'rev-parse', 'HEAD'], text=True).strip()
    sys.path.insert(0, str(root / 'repo'))
    from itlkit import Library
    from Crypto.Cipher import AES
    pins = {}
    def read(path):
        path = Path(path).resolve()
        require(path.is_relative_to(root / 'reports') or path.is_relative_to(root / 'fixtures/dynamic'), 'out-of-scope evidence path')
        require(not path.is_relative_to(root / 'reports/crud-research/phase2/private'), 'private data excluded')
        data = path.read_bytes()
        digest = hashlib.sha256(data).hexdigest()
        if str(path) in pins:
            require(pins[str(path)]['sha256'] == digest, 'evidence changed during audit')
        pins[str(path)] = {'path': str(path), 'bytes': len(data), 'sha256': digest}
        return data
    def js(path):
        return json.loads(read(path).decode('utf-8-sig'))
    def pinned(record):
        data = read(record['path'])
        require(hashlib.sha256(data).hexdigest() == record['sha256'], 'declared artifact hash mismatch')
        if 'bytes' in record:
            require(len(data) == record['bytes'], 'declared artifact size mismatch')
        return data
    def decode(data):
        require(data[:4] == b'hdfm' and len(data) < 8 * 1024 * 1024, 'unsupported envelope')
        be = lambda off: int.from_bytes(data[off:off + 4], 'big')
        require(be(4) == 144 and be(8) == len(data) and data[0x41] == 2 and data[0x43] == 1 and data[0x52] == 1, 'unsupported native profile')
        body = data[144:]
        encrypted = min(len(body), be(0x5c)) & ~15
        comp = AES.new(b'BHUILuilfghuila3', AES.MODE_ECB).decrypt(body[:encrypted]) + body[encrypted:]
        dz = zlib.decompressobj()
        plain = dz.decompress(comp, 8 * 1024 * 1024 + 1)
        require(len(plain) <= 8 * 1024 * 1024 and dz.eof and not dz.unused_data and not dz.unconsumed_tail, 'bounded zlib closure')
        pos, kinds = 0, set()
        while pos < len(plain):
            require(plain[pos:pos + 4] == b'msdh' and pos + 16 <= len(plain), 'section tag/bounds')
            h, size, kind = [int.from_bytes(plain[pos + o:pos + o + 4], 'little') for o in (4, 8, 12)]
            require(16 <= h <= size <= len(plain) - pos and kind not in kinds, 'section size/identity')
            kinds.add(kind)
            pos += size
        require(pos == len(plain) and len(kinds) == be(0x30), 'section coverage/count')
        lib = Library.from_bytes(data, max_plain_bytes=8 * 1024 * 1024)
        require(lib.container.payload == plain and lib.to_bytes() == data, 'production decode/no-op disagrees')
        return lib, {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest(), 'plain_bytes': len(plain), 'plain_sha256': hashlib.sha256(plain).hexdigest(), 'section_count': len(kinds)}
    def raw_members(lib):
        ids = {t.track_id: f'{t.persistent_id:016X}' for t in lib.tracks}
        require(len(ids) == len(lib.tracks), 'duplicate raw track ID')
        out = {}
        for pl in lib.playlists:
            pid = f'{pl.persistent_id:016X}'
            require(pid not in out and set(pl.track_ids) <= set(ids), 'raw playlist identity/reference')
            out[pid] = {'plain': pl.is_plain, 'master': pl.is_master, 'members': [ids[i] for i in pl.track_ids], 'name': pl.name}
        return out
    reports = []
    for name in args.cases:
        require(re.fullmatch('[A-Za-z0-9._-]+', name) is not None and name not in ('.', '..'), 'unsafe case name')
        item = {'case': name, 'status': 'in_progress'}
        try:
            case = js(root / 'reports/dynamic/phase3/cases' / name / 'result.json')
            require(case['accepted'] is True and len(case['cycles']) == 2, 'not a completed two-cycle acceptance')
            spec = js(root / 'reports/dynamic/phase3/runs' / (name + '-reload1') / 'spec.json')
            data = read(spec['candidate'])
            require(hashlib.sha256(data).hexdigest() == case['sha256'] == spec['sha256'], 'candidate hash chain')
            candidate, candidate_info = decode(data)
            expected = spec['expected']
            expected_ids = set(unique(expected['tracks'], 'expected tracks'))
            old, new = set(spec['old_track_pids']), set(spec['new_track_pids'])
            require(not old & new and old | new == expected_ids, 'old/new partition')
            require({f'{t.persistent_id:016X}' for t in candidate.tracks} == expected_ids, 'candidate identities')
            require(f'{candidate.persistent_id:016X}' == spec['file_persistent_id'], 'file identity')
            original_raw = raw_members(candidate)
            ordinary = {pid for pid, v in original_raw.items() if v['plain']}
            require([pid for pid, v in original_raw.items() if v['master']] == [expected['library_persistent_id']], 'raw master identity')
            ignore = set(spec['observe_only']) | {'TrackID', 'TrackDatabaseID', 'PlayOrderIndex'}
            for inp in spec['inputs']:
                pinned(inp)
            media = {str(Path(m['path'])): m for m in spec['media']}
            for m in media.values():
                pinned(m)
                require(Path(m['path']).stat().st_mtime_ns == m['mtime_ns'], 'input media timestamp changed')
            cycle_rows = []
            previous = spec['sha256']
            for idx, cycle in enumerate(case['cycles'], 1):
                require(cycle['cycle'] == idx and cycle['prelaunch']['sha256'] == previous, 'save-to-next-load chain')
                require(cycle['accepted'] is True and cycle['observation_completed'] is True and cycle['errors'] == [], 'incomplete cycle')
                require(cycle['worker_exit_code'] == 0 and cycle['itunes_exit_code'] == 0 and cycle['media_unchanged'] is True, 'native/worker exit or media guard')
                evidence = js(cycle['com_evidence'])
                require(evidence['accepted'] is True and evidence['errors'] == [] and evidence['observation_completed'] is True and evidence['quit_returned'] is True, 'incomplete COM evidence')
                require(evidence['explicit_mutations'] == [] and evidence['update_info_from_file_called'] is False, 'acceptance used mutations')
                require(evidence['spec']['expected'] == expected, 'expected state drift')
                states = [evidence['before'], evidence['after']] + [s['state'] for s in evidence['samples']]
                comparisons = sum(compare_state(s, expected, ignore, ordinary) for s in states)
                require(len(evidence['samples']) >= 2, 'missing passive observations')
                times = [s['elapsed_seconds'] for s in evidence['samples']]
                require(times == sorted(times) and times[-1] >= spec['dwell'][idx - 1], 'insufficient passive dwell')
                require(all(s['expected_errors'] == [] and s['stability_errors'] == [] for s in evidence['samples']), 'passive observation mismatch')
                saved = pinned(cycle['saved'])
                lib, info = decode(saved)
                require(info['sha256'] == cycle['profile_after']['file_sha256'] and info['plain_sha256'] == cycle['profile_after']['expanded_sha256'], 'saved profile hash mismatch')
                require(f'{lib.persistent_id:016X}' == spec['file_persistent_id'], 'saved file identity')
                require({f'{t.persistent_id:016X}' for t in lib.tracks} == expected_ids, 'saved track PID set')
                current_raw = raw_members(lib)
                require(set(current_raw) == set(original_raw), 'serialized playlist set changed')
                for pid, want in original_raw.items():
                    got = current_raw[pid]
                    require(got['plain'] == want['plain'] and got['master'] == want['master'], 'raw playlist role changed')
                    require(got['members'] == want['members'] if want['plain'] else Counter(got['members']) == Counter(want['members']), 'raw playlist membership changed: ' + pid)
                previous = info['sha256']
                cycle_rows.append({'cycle': idx, 'saved': info, 'native_exit': 0, 'worker_exit': 0, 'states_checked': len(states), 'field_comparisons': comparisons, 'passive_seconds': times[-1], 'serialized_playlists_checked': len(current_raw)})
            item.update(status='passed', candidate=candidate_info, old_tracks=len(old), new_tracks=len(new), total_tracks=len(expected_ids), visible_playlists=len(expected['playlists']), cycles=cycle_rows, media_unchanged=True, raw_all_playlists_checked=True)
        except Exception as exc:
            item.update(status='failed', error=repr(exc), traceback=traceback.format_exc())
        reports.append(item)
    for path, pin in pins.items():
        require(hashlib.sha256(Path(path).read_bytes()).hexdigest() == pin['sha256'], 'input changed at final preservation gate')
    require(source == subprocess.check_output(['git', '-C', str(root / 'repo'), 'rev-parse', 'HEAD'], text=True).strip(), 'source moved during audit')
    require(not any(n == 'pythoncom' or n.startswith('win32com') for n in sys.modules), 'native automation module unexpectedly imported')
    result = {'status': 'passed' if all(r['status'] == 'passed' for r in reports) else 'failed', 'source_commit': source, 'cases': reports, 'native_actions_by_parent': False, 'evidence_files_unchanged': len(pins), 'limitations': ['Audit of archived native execution, not an additional native run.', 'No audible playback claim; native audio configuration warning observed.', 'Scope is the exact named synthetic candidates, not all libraries or formats.']}
    (output / 'input-pins.json').write_text(json.dumps(list(pins.values()), indent=2), encoding='utf-8')
    (output / 'report.json').write_text(json.dumps(result, indent=2), encoding='utf-8')
    print(json.dumps(result, ensure_ascii=True))
    return 0 if result['status'] == 'passed' else 1


if __name__ == '__main__':
    raise SystemExit(main())
