"""NEW G2 authoritative passive controller; never calls the old controller.

The only success return follows FrozenCase.cycle for BOTH 45/30 saves.
Imports alone are offline. Native imports/launches require a pinned runtime,
a separately pinned case-specific parent handoff, and an explicit CLI action.
A test backend cannot produce native acceptance or an engine witness.
"""
from __future__ import annotations
import argparse
import datetime as dt
import json
import math
from pathlib import Path
import subprocess
import sys
import time
import traceback
import g2_acceptance_guard as g

W = Path(__file__).resolve().parents[3]
ROOT = W.parents[1]
PREFIX = W/'scripts/windows/continuation20260910'
EXE_SHA = '30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d'


def executable_preflight(path):
    """Pure read-only seam also exercised without controller/COM activation."""
    return g.executable_pin(path, EXE_SHA, expected_bytes=g.EXE_BYTES)


def now():
    return dt.datetime.now(dt.timezone.utc).isoformat()


def evidence_safe(value):
    if type(value) is float and not math.isfinite(value):
        return {'invalid_float': repr(value)}
    if type(value) is dict:
        return {k: evidence_safe(v) for k, v in value.items()}
    if type(value) in (list, tuple):
        return [evidence_safe(v) for v in value]
    return value


def write_json(path, value):
    with Path(path).open('x', encoding='utf-8', newline='\n') as f:
        json.dump(evidence_safe(value), f, ensure_ascii=True, indent=2, allow_nan=False); f.write('\n')


def strict_worker(com, exit_code):
    g.need(type(exit_code) is int and exit_code == 0, 'worker_exit')
    g.need(type(com) is dict and com.get('ok') is True and com.get('quit_returned') is True,
           'strict_com_success')
    g.need(com.get('errors') == [] and com.get('explicit_actions') == [] and
           com.get('update_info_from_file_called') is False, 'passive_worker_contract')


def native_modules():
    sys.path[:0] = [str(PREFIX), str(W/'scripts/windows')]
    import native_oracle as n
    import g2_native_select as selector
    return n, selector


def checked_ui(n, pid):
    windows = [x for x in n.desktop() if x['pid'] == pid]
    modals = [x for x in windows if x['class'] in ('#32770', 'iTunesCustomModalDialog')]
    g.need(not modals, 'modal_or_fallback', modals)
    g.need(any(x['class'] == 'iTunes' for x in windows), 'main_window_missing')
    return []


def observe(case, authorization, identity, index, output):
    """Actual COM worker. Passive getters only; Quit is the sole COM action."""
    authorization.check(budget_seconds=case.spec['dwell_seconds'][index-1] + 50)
    case.verify()
    n, _ = native_modules()
    result = dict(schema='itl4.g2.passive-com.v1', evidence_kind=('offline_test_double' if getattr(n, 'G2_OFFLINE_TEST_DOUBLE', False) is True else 'native_observation'),
                  started_utc=now(), plan_sha256=case.pin['sha256'], errors=[],
                  explicit_actions=[], update_info_from_file_called=False,
                  samples=[], ok=False, quit_returned=False)
    initialized = False; app = None
    try:
        g.need(n.identity(identity['pid']) == identity, 'owned_process_changed')
        result['exe_pin'] = executable_preflight(n.EXE)
        checked_ui(n, identity['pid'])
        n.pythoncom.CoInitialize(); initialized = True
        # Bind a running object; never activate a new server via Dispatch(progid).
        active = n.pythoncom.GetActiveObject(n.pythoncom.CLSIDFromProgID('iTunes.Application'))
        app = n.win32com.client.dynamic.Dispatch(active)
        first = n.full(app); case.state(first)
        g.need(n.identity(identity['pid']) == identity, 'owned_process_changed')
        started = time.monotonic()
        dwell = case.spec['dwell_seconds'][index-1]
        while True:
            authorization.check(budget_seconds=45)
            case.verify(); modal_events = checked_ui(n, identity['pid'])
            state = first if not result['samples'] else n.full(app)
            case.state(state)
            elapsed = time.monotonic() - started
            sample = dict(elapsed_seconds=elapsed, state=state, modal_events=modal_events,
                          media=g.media_inventory(case.spec['media'], case.fix))
            result['samples'].append(sample)
            # Measure the full dwell from the first completed observation.
            if elapsed - result['samples'][0]['elapsed_seconds'] >= dwell:
                break
            time.sleep(min(2, max(.01, dwell - (elapsed-result['samples'][0]['elapsed_seconds']))))
        result['after'] = result['samples'][-1]['state']
        g.need(n.identity(identity['pid']) == identity, 'owned_process_changed')
        checked_ui(n, identity['pid']); case.verify(); authorization.check(budget_seconds=45)
        app.Quit()
        result['quit_returned'] = True; result['ok'] = True
    except Exception as exc:
        result.update(ok=False, error=str(exc), traceback=traceback.format_exc())
        result['errors'].append(str(exc))
        raise
    finally:
        result['completed_utc'] = now()
        write_json(output, result)
        if initialized:
            n.pythoncom.CoUninitialize()
    return result


class NativePort:
    evidence_kind = 'native_observation'

    def __init__(self, case, authorization, options):
        self.case = case; self.authorization = authorization; self.options = options
        self.n, self.selector = native_modules()

    def run_cycle(self, index, output, previous_sha):
        case, n = self.case, self.n
        self.authorization.check(budget_seconds=case.spec['dwell_seconds'][index-1] + 130)
        n.require_stopped(); case.verify()
        live_data, live_pin = g.stable_read(case.live)
        g.need(live_pin['sha256'] == previous_sha, 'live_chain_changed')
        case.raw(live_data)
        started = now()
        selection = self.selector.select(case.live, 'open', output/'selection', authorization=self.authorization)
        g.need(selection.get('selected') is True and selection.get('verified_picker_path') == str(case.live), 'selected_library_path')
        identity = selection['identity']; g.need(n.identity(identity['pid']) == identity, 'owned_process_changed')
        write_json(output/'worker-identity.json', identity)
        command = [sys.executable, '-B', '-X', 'utf8', str(Path(__file__)), 'worker',
                   '--plan', str(case.path), '--plan-sha', case.pin['sha256'],
                   '--runtime-sha', self.authorization.runtime_sha,
                   '--handoff', str(self.authorization.handoff_path), '--handoff-sha', self.authorization.handoff_sha,
                   '--identity', str(output/'worker-identity.json'), '--cycle', str(index), '--out', str(output/'com.json')]
        h = n.win32api.OpenProcess(0x100000 | 0x410, False, identity['pid'])
        try:
            with (output/'worker.log').open('x', encoding='utf-8', newline='\n') as log:
                worker = subprocess.run(command, cwd=W, stdin=subprocess.DEVNULL, stdout=log,
                                        stderr=subprocess.STDOUT, timeout=case.spec['dwell_seconds'][index-1]+100)
            com = g.load_json(g.stable_read(output/'com.json')[0])
            # Mandatory even when a malfunctioning worker exited zero.
            strict_worker(com, worker.returncode)
            g.need(n.win32event.WaitForSingleObject(h, 45000) == 0, 'normal_quit_timeout')
            exit_code = n.win32process.GetExitCodeProcess(h)
            g.need(type(exit_code) is int and exit_code == 0, 'normal_native_exit')
        finally:
            h.Close()
        n.require_stopped()
        data, live_saved = g.stable_read(case.live)
        case.raw(data); case.verify()
        dest = output/'saved.itl'
        with dest.open('xb') as f:
            f.write(data)
        saved = g.stable_read(dest)[1]
        result = dict(index=index, evidence_kind=self.evidence_kind, started_utc=started,
                      completed_utc=now(), selected_path=str(case.live), selection_verified=True,
                      selection=selection, identity=identity, input_sha256=previous_sha,
                      worker_command=command, worker_exit_code=worker.returncode, com=com,
                      native_exit_code=exit_code, native_stopped=True, file_pid=case.spec['file_pid'],
                      modal_events=[], fallback_detected=False, saved=saved, live_saved=live_saved)
        write_json(output/'cycle.json', result)
        return result


def controller(plan_path, plan_sha, runtime_sha, handoff_path, handoff_sha, output, *, root=ROOT):
    """Authoritative entry. Factory replacement is a TEST seam, not a CLI option."""
    root = Path(root).resolve(); output = g.within(output, root/'reports/dynamic')
    g.need(not output.exists(), 'existing_output')
    case = g.FrozenCase(plan_path, plan_sha, root)
    authorization = g.Authorization(root, runtime_sha, handoff_path, handoff_sha, case)
    authorization.check(budget_seconds=350)
    g.need(not case.live.exists() and not case.live.parent.exists(), 'live_directory_not_new')
    case.verify()
    output.mkdir(parents=True, exist_ok=False)
    result = dict(schema='itl4.g2.strict-passive-result.v1', started_utc=now(), ok=False,
                  guard_passed=False, native_acceptance=False, engine_witness=False,
                  independent_writer_acceptance=False, plan_sha256=plan_sha, cycles=[],
                  scope='G2 declared COM/full raw ordered profile; not a universal ITL writer certificate')
    try:
        # Written before any native action. Never synthesize expected-after from observations.
        with (output/'plan.frozen.json').open('xb') as f:
            f.write(case.data)
        write_json(output/'armed.json', dict(armed_utc=now(), plan=case.pin, candidate=case.candidate,
                                           baseline=case.baseline, media=case.media,
                                           runtime_sha256=runtime_sha, handoff_sha256=handoff_sha))
        case.live.parent.mkdir(parents=True, exist_ok=False)
        with case.live.open('xb') as f:
            f.write(case.candidate_bytes)
        previous = case.candidate['sha256']; saved_paths = []; identities = []
        port = NativePort(case, authorization, {})
        result['evidence_kind'] = port.evidence_kind
        for index in [1, 2]:
            authorization.check(budget_seconds=case.spec['dwell_seconds'][index-1] + 130)
            case.verify()
            cycle_output = output/('cycle-' + str(index)); cycle_output.mkdir()
            value = port.run_cycle(index, cycle_output, previous)
            result['cycles'].append(value)
            strict_worker(value.get('com'), value.get('worker_exit_code'))
            saved = case.cycle(value, index, previous)
            g.need(value.get('evidence_kind') == port.evidence_kind, 'mixed_evidence_origin')
            g.need(saved['path'] not in saved_paths, 'reused_save_path'); saved_paths.append(saved['path'])
            identity = value.get('identity')
            g.need(type(identity) is dict and type(identity.get('pid')) is int and identity['pid'] > 0 and type(identity.get('creation')) is str, 'missing_process_identity')
            token = (identity['pid'], identity['creation'])
            g.need(token not in identities, 'same_process_not_reopened'); identities.append(token)
            if index == 2:
                g.need(g.utc(value['started_utc']) > g.utc(result['cycles'][0]['completed_utc']), 'overlapping_cycles')
            previous = saved['sha256']
        case.verify()
        # Re-read BOTH saved files at final admission, not just the second.
        for value in result['cycles']:
            data, _ = g.check_pin(value['saved'], root/'reports/dynamic'); case.raw(data)
        g.need(g.stable_read(case.live)[1]['sha256'] == previous, 'final_live_chain_changed')
        g.need(g.stable_read(output/'plan.frozen.json')[0] == case.data, 'frozen_copy_changed')
        result['guard_passed'] = True; result['ok'] = True
        result['native_validation_performed'] = port.evidence_kind == 'native_observation'
        # Even native validation is not a shared PreparedMutation/engine witness.
        result['native_acceptance'] = False
    except Exception as exc:
        result.update(ok=False, guard_passed=False, error=str(exc), traceback=traceback.format_exc())
        # No automatic repair, retry, Quit of an ambiguous process, or kill.
        raise
    finally:
        result['completed_utc'] = now()
        write_json(output/'result.json', result)
    return result


def main(argv=None):
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('mode', choices=['run', 'worker'])
    for name in ['plan', 'plan-sha', 'runtime-sha', 'handoff', 'handoff-sha', 'out']:
        p.add_argument('--' + name, required=True)
    p.add_argument('--identity'); p.add_argument('--cycle', type=int, choices=[1, 2])
    a = p.parse_args(argv)
    if a.mode == 'worker':
        g.need(a.identity is not None and a.cycle in (1, 2), 'worker_arguments')
        out = g.within(a.out, ROOT/'reports/dynamic'); g.need(not out.exists(), 'existing_output')
        case = g.FrozenCase(a.plan, a.plan_sha, ROOT)
        auth = g.Authorization(ROOT, a.runtime_sha, a.handoff, a.handoff_sha, case)
        auth.check(budget_seconds=case.spec['dwell_seconds'][a.cycle-1]+50)
        ident = g.load_json(g.stable_read(g.within(a.identity, ROOT/'reports/dynamic'))[0])
        observe(case, auth, ident, a.cycle, out)
    else:
        result = controller(a.plan, a.plan_sha, a.runtime_sha, a.handoff, a.handoff_sha, a.out)
        print(json.dumps({k: result[k] for k in ['ok', 'guard_passed', 'native_acceptance', 'engine_witness']}, ensure_ascii=True))
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
