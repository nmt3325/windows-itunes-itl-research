"""Phase3 selected-copy native gate; descriptive producer requests need explicit adaptation.
Strict complete PID enumeration, master membership and ordinary playlists augment
passive_native's bounded read-only worker. No producer code is executed here.
"""
import argparse
import collections
import datetime
import json
import pathlib
import re
import struct
import subprocess
import sys
import time
import traceback
from passive_native import load, write_json, facts, envelope, digest

OBSERVE_ONLY = {'Unplayed', 'RatingKind', 'AlbumRatingKind', 'AlbumRating'}
SESSION_FIELDS = {'TrackID', 'TrackDatabaseID', 'PlayOrderIndex'}
REQUIRED_FIELDS = {'persistent_id', 'Name', 'Artist', 'Album', 'AlbumArtist', 'Comment', 'Location'}
PID = re.compile(r'[0-9A-F]{16}')


def require(value, message):
    if not value:
        raise ValueError(message)


def valid_pid(value):
    return isinstance(value, str) and bool(PID.fullmatch(value)) and int(value, 16) != 0


def shape(state):
    require(state['version'] == '12.13.10.3', 'Unexpected native version')
    require(valid_pid(state['library_persistent_id']), 'Invalid master PID')
    tracks = state['tracks']
    require(type(state['track_count']) is int and state['track_count'] == len(tracks), 'Incomplete track enumeration')
    ids = [t['persistent_id'] for t in tracks]
    require(all(valid_pid(x) for x in ids) and len(set(ids)) == len(ids), 'Duplicate or invalid track PID')
    for track in tracks:
        require(REQUIRED_FIELDS <= set(track), 'Incomplete expected/observed track metadata')
        require(all(isinstance(track[x], str) for x in REQUIRED_FIELDS), 'Non-text core metadata/location')
        require(bool(track['Location']), 'Empty track location')
    playlists = state['playlists']
    pids = [p['persistent_id'] for p in playlists]
    require(all(valid_pid(x) for x in pids) and len(pids) == len(set(pids)), 'Duplicate or invalid playlist PID')
    masters = [p for p in playlists if p['persistent_id'] == state['library_persistent_id']]
    require(len(masters) == 1 and masters[0]['kind'] == 1, 'Missing or wrong master playlist')
    members = [m['persistent_id'] for m in masters[0]['members']]
    require(collections.Counter(members) == collections.Counter(ids), 'Master membership is incomplete or duplicated')
    for playlist in playlists:
        require(all(m['persistent_id'] in ids for m in playlist['members']), 'Dangling playlist track PID')
        if playlist['kind'] == 2:
            require(playlist.get('special_kind') is not None, 'Missing ordinary/system classification')
        if playlist['kind'] == 2 and playlist['special_kind'] == 0:
            order = [m['play_order_index'] for m in playlist['members']]
            require(len(order) == len(set(order)), 'Ambiguous ordinary playlist order')
    return {t['persistent_id']: t for t in tracks}


def ordinary(state):
    return {p['persistent_id']: {'name': p['name'], 'members': [m['persistent_id'] for m in sorted(p['members'], key=lambda m: m['play_order_index'])]}
            for p in state['playlists'] if p['kind'] == 2 and p['special_kind'] == 0}


def compare(expected, actual, observe_only):
    require(set(observe_only) <= OBSERVE_ONLY, 'Unsafe observe-only field')
    a = shape(expected)
    try:
        b = shape(actual)
    except (KeyError, TypeError, ValueError) as error:
        return [{'property': 'complete_native_shape', 'error': str(error)}]
    errors = []
    for field in ['version', 'library_persistent_id', 'track_count']:
        if expected[field] != actual[field]:
            errors.append({'property': field, 'expected': expected[field], 'actual': actual[field]})
    if set(a) != set(b):
        errors.append({'property': 'track_persistent_ids', 'expected': sorted(a), 'actual': sorted(b)})
    for key in a.keys() & b.keys():
        for field, value in a[key].items():
            if field in SESSION_FIELDS or field in observe_only:
                continue
            observed = b[key].get(field)
            if value != observed:
                errors.append({'track': key, 'property': field, 'expected': value, 'actual': observed})
    if ordinary(expected) != ordinary(actual):
        errors.append({'property': 'ordinary_playlists', 'expected': ordinary(expected), 'actual': ordinary(actual)})
    def system_playlists(state):
        return {p['persistent_id']: {'name': p['name'], 'kind': p['kind'], 'special_kind': p.get('special_kind'),
                'members': dict(collections.Counter(m['persistent_id'] for m in p['members']))}
                for p in state['playlists'] if not (p['kind'] == 2 and p['special_kind'] == 0)}
    if system_playlists(expected) != system_playlists(actual):
        errors.append({'property': 'system_playlists', 'expected': system_playlists(expected), 'actual': system_playlists(actual)})
    return errors


def validate_case(case):
    require(bool(re.fullmatch(r'[A-Za-z0-9_-]+', case['name'])), 'Unsafe case name')
    root = pathlib.Path(case['root']).resolve()
    live = pathlib.Path(case['live']).resolve()
    report = pathlib.Path(case['report']).resolve()
    require(live.is_relative_to(root / 'phase3'), 'Phase3 must not overwrite previous live libraries')
    require(report == root.parents[1] / 'reports/dynamic/phase3', 'Outside phase3 report scope')
    expected = case['expected']
    current = shape(expected)
    require(set(case['observe_only']) <= OBSERVE_ONLY, 'Unsafe observe-only policy')
    require(not (set(case.get('requested_fields', [])) & set(case['observe_only'])), 'Requested field cannot be observe-only')
    old = case['old_track_pids']; new = case['new_track_pids']
    require(len(old) == len(set(old)) and len(new) == len(set(new)), 'Duplicate expected identity')
    require(not set(old) & set(new) and set(old) | set(new) == set(current), 'Incomplete old/new identity partition')
    if case['classification'] in ['cross_library_add', 'fresh_constructed_wav', 'same_lineage_restore']:
        require(len(new) > 0 and len(old) > 0, 'Track-add case requires old and genuinely additional destination PIDs')
    require(case['target_track'] in current, 'Missing target track')
    require(len(case['dwell']) == 2 and all(5 <= x <= 120 for x in case['dwell']), 'Invalid bounded dwell')
    require(valid_pid(case['file_persistent_id']), 'Missing serialized file identity')
    media = {str(pathlib.Path(m['path']).resolve()).casefold(): m for m in case['media']}
    locations = {str(pathlib.Path(t['Location']).resolve()).casefold() for t in current.values()}
    require(set(media) == locations, 'Incomplete or extra media hash inventory')
    for record in case['media']:
        p = pathlib.Path(record['path']).resolve()
        require(p.is_relative_to(root), 'Native media must be a dynamic-owned synthetic copy or preserved fixture')
        require(facts(p)['sha256'] == record['sha256'], 'Media hash mismatch: ' + str(p))
    for record in case['inputs']:
        require(facts(pathlib.Path(record['path']))['sha256'] == record['sha256'], 'Input provenance hash mismatch')
    raw = pathlib.Path(case['candidate']).read_bytes()
    require(digest(raw) == case['sha256'], 'Candidate SHA mismatch')
    require(raw[:4] == b'hdfm' and len(raw) >= 144, 'Unsupported candidate envelope')
    require(struct.unpack_from('>I', raw, 8)[0] == len(raw), 'Candidate outer size mismatch')
    require(f'{struct.unpack_from(">Q", raw, 0x34)[0]:016X}' == case['file_persistent_id'], 'Wrong candidate file PID')
    require(struct.unpack_from('>I', raw, 0x44)[0] == expected['track_count'], 'Candidate count header mismatch')
    envelope(pathlib.Path(case['candidate']), case['target_track'])
    return raw


def worker(spec, output):
    import passive_native
    passive_native.worker(spec, output, compare_fn=compare)


def run_cycle(case, number, previous_sha):
    from native_driver import EXE, wait_ready
    from native_acceptance import require_stopped
    root = pathlib.Path(case['root']); report = pathlib.Path(case['report']); live = pathlib.Path(case['live'])
    out = report / 'runs' / (case['name'] + '-reload' + str(number)); out.mkdir(parents=True, exist_ok=False)
    result = {'name': case['name'], 'cycle': number, 'ui': [], 'active_library': str(live)}
    proc = None
    try:
        require_stopped(); require(facts(live)['sha256'] == previous_sha, 'Native save chain changed')
        result['prelaunch'] = facts(live); result['profile_before'] = envelope(live, case['target_track'])
        result['media_prelaunch'] = [facts(pathlib.Path(m['path'])) for m in case['media']]
        proc = subprocess.Popen([str(EXE)], stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        result['itunes_pid'] = proc.pid; write_json(out / 'result.json', result)
        wait_ready(proc, result['ui'])
        spec = dict(case); spec['dwell_seconds'] = case['dwell'][number - 1]; spec['comparator'] = 'phase3-complete-identities-master-ordinary'
        write_json(out / 'spec.json', spec)
        command = [sys.executable, '-B', '-u', str(pathlib.Path(__file__).resolve()), 'worker', '--spec', str(out / 'spec.json'), '--out', str(out / 'com.json')]
        result['worker_command'] = command
        with (out / 'worker.log').open('w', encoding='utf-8') as log:
            run = subprocess.run(command, stdout=log, stderr=subprocess.STDOUT, timeout=spec['dwell_seconds'] + 90)
        result['worker_exit_code'] = run.returncode
        require(run.returncode == 0, 'Worker failed; inspect before any recovery')
        proc.wait(timeout=45); result['itunes_exit_code'] = proc.returncode
        require(proc.returncode == 0, 'Nonzero native exit'); require_stopped(); time.sleep(.3)
        saved = root / 'phase3/snapshots' / (case['name'] + '-reload' + str(number) + '.itl'); saved.parent.mkdir(parents=True, exist_ok=True)
        with saved.open('xb') as f:
            f.write(live.read_bytes())
        result['saved'] = facts(saved); result['profile_after'] = envelope(saved, case['target_track'])
        require(f'{struct.unpack_from(">Q", saved.read_bytes(), 0x34)[0]:016X}' == case['file_persistent_id'], 'Saved file identity changed')
        com = load(out / 'com.json')
        result.update(accepted=com['accepted'], observation_completed=com['observation_completed'], errors=com['errors'], final_target=com['final_fresh_target'], com_evidence=str(out / 'com.json'))
        after = {str(pathlib.Path(m['path']).resolve()).casefold(): facts(pathlib.Path(m['path'])) for m in case['media']}
        before = {str(pathlib.Path(m['path']).resolve()).casefold(): m for m in result['media_prelaunch']}
        result['media_unchanged'] = after == before
        if not result['media_unchanged']:
            result['accepted'] = False; result['errors'].append({'property': 'media_changed'})
        write_json(out / 'result.json', result)
        print(json.dumps({k: result[k] for k in ['name', 'cycle', 'accepted', 'itunes_exit_code', 'worker_exit_code', 'media_unchanged', 'final_target']}, ensure_ascii=True), flush=True)
        return result
    except Exception as error:
        result.update(observation_completed=False, error=repr(error), traceback=traceback.format_exc())
        if proc:
            result['itunes_poll'] = proc.poll()
        write_json(out / 'result.json', result)
        raise


def run_case(case_path):
    from native_acceptance import require_stopped
    case = load(case_path); raw = validate_case(case)
    deadline = datetime.datetime.fromisoformat(case['not_after_utc'])
    require((deadline - datetime.datetime.now(datetime.timezone.utc)).total_seconds() > sum(case['dwell']) + 300, 'Insufficient bounded native time')
    root = pathlib.Path(case['root']); live = pathlib.Path(case['live']); report = pathlib.Path(case['report'])
    selection = load(pathlib.Path(case['selection_evidence']))
    require(selection['completed'] and pathlib.Path(selection['selected_library']).resolve() == live.resolve(), 'No verified selected-library evidence')
    require_stopped(); out = report / 'cases' / case['name']; out.mkdir(parents=True, exist_ok=False)
    pins = root / 'phase3/candidates'; pins.mkdir(parents=True, exist_ok=True)
    with (pins / (case['name'] + '.itl')).open('xb') as f:
        f.write(raw)
    with (out / 'pretest-library.itl').open('xb') as f:
        f.write(live.read_bytes())
    write_json(out / 'case.json', case)
    temp = live.with_name(live.name + '.phase3.tmp')
    with temp.open('xb') as f:
        f.write(raw)
    require_stopped(); temp.replace(live); previous = case['sha256']; cycles = []
    for number in [1, 2]:
        result = run_cycle(case, number, previous); cycles.append(result); previous = result['saved']['sha256']
        write_json(out / 'progress.json', {'cycles': cycles, 'all_two_cycles_completed': len(cycles) == 2})
        require(result['media_unchanged'], 'Media changed; stop before another native cycle')
    entry = {'name': case['name'], 'classification': case['classification'], 'sha256': case['sha256'], 'accepted': all(x['accepted'] for x in cycles), 'cycles': cycles}
    write_json(out / 'result.json', entry)
    return entry


def main():
    p = argparse.ArgumentParser(); sub = p.add_subparsers(dest='mode', required=True)
    w = sub.add_parser('worker'); w.add_argument('--spec', type=pathlib.Path, required=True); w.add_argument('--out', type=pathlib.Path, required=True)
    c = sub.add_parser('case'); c.add_argument('--case', type=pathlib.Path, required=True)
    a = p.parse_args()
    if a.mode == 'worker':
        worker(a.spec, a.out)
    else:
        run_case(a.case)


if __name__ == '__main__':
    main()
