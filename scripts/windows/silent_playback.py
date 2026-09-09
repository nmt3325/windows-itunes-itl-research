"""Bounded silent playback observation on a separately staged synthetic-only copy.
A clean worker/native exit is not evidence that playback succeeded.
"""
import argparse
import pathlib
import time
import traceback
from passive_native import load, write_json, facts


def progressed(samples, target, before_count, after_count):
    valid = [s for s in samples if s.get('state') == 1 and s.get('track_pid') == target]
    positions = [s['position'] for s in valid if isinstance(s.get('position'), (int, float))]
    return bool(valid) and ((positions and max(positions) > min(positions)) or after_count > before_count)


def worker(spec_path, output):
    import pythoncom
    import win32com.client
    from native_worker import snapshot, guard, pid, items, file_interface
    from import_native import compare, shape
    spec = load(spec_path); root = pathlib.Path(spec['root']); target = spec['target_track']
    assert not output.exists(); result = {'samples': [], 'mutations_attempted': [], 'playback_succeeded': False}
    pythoncom.CoInitialize()
    try:
        app = win32com.client.dynamic.Dispatch('iTunes.Application')
        result['before'] = snapshot(app); guard(result['before'], root); shape(result['before'])
        assert not compare(spec['expected'], result['before'], spec['observe_only'])
        tr = file_interface(app, next(t for t in items(app.LibraryPlaylist.Tracks) if pid(app, t) == target))
        selected = next(t for t in result['before']['tracks'] if t['persistent_id'] == target)
        assert 0 < selected['Duration'] <= 2
        before_media = [facts(pathlib.Path(t['Location'])) for t in result['before']['tracks']]
        original = app.SoundVolume; result['original_volume'] = original; before_count = tr.PlayedCount
        write_json(output, result)
        try:
            result['mutations_attempted'].append('SoundVolume=0'); app.SoundVolume = 0; assert app.SoundVolume == 0
            result['mutations_attempted'].append('TargetTrack.Play'); tr.Play(); start = time.monotonic()
            while time.monotonic() - start < 1.6:
                pythoncom.PumpWaitingMessages(); row = {'elapsed': time.monotonic() - start, 'state': app.PlayerState, 'position': app.PlayerPosition}
                try:
                    current = app.CurrentTrack; row['track_pid'] = pid(app, current) if current else None
                except Exception as error:
                    row['current_track_error'] = str(error)
                result['samples'].append(row); write_json(output, result)
                if row.get('track_pid') not in (None, target):
                    break
                time.sleep(.1)
            result['played_count_after'] = tr.PlayedCount
            result['playback_succeeded'] = bool(progressed(result['samples'], target, before_count, result['played_count_after']))
        except Exception as error:
            result['playback_error'] = repr(error)
        finally:
            try:
                result['mutations_attempted'].append('Stop'); app.Stop()
            except Exception as error:
                result['stop_error'] = repr(error)
            result['mutations_attempted'].append('RestoreSoundVolume'); app.SoundVolume = original
            result['restored_volume'] = app.SoundVolume; result['volume_restored'] = result['restored_volume'] == original
            write_json(output, result); assert result['volume_restored']
        result['after'] = snapshot(app); guard(result['after'], root); shape(result['after'])
        assert {t['persistent_id'] for t in result['after']['tracks']} == {t['persistent_id'] for t in result['before']['tracks']}
        result['media_unchanged'] = before_media == [facts(pathlib.Path(t['Location'])) for t in result['after']['tracks']]
        result['success_definition'] = 'Target COM Playing state plus position advance or target play-count increase; not an audible-output claim.'
        result['observation_completed'] = True; write_json(output, result); app.Quit(); result['quit_returned'] = True; write_json(output, result)
    except Exception as error:
        result.update(observation_completed=False, error=repr(error), traceback=traceback.format_exc()); write_json(output, result); raise
    finally:
        pythoncom.CoUninitialize()


def selftest():
    assert not progressed([], 'T', 0, 0)
    assert not progressed([{'state': 1, 'track_pid': 'OTHER', 'position': 1}], 'T', 0, 1)
    assert not progressed([{'state': 1, 'track_pid': 'T', 'position': 0}], 'T', 0, 0)
    assert progressed([{'state': 1, 'track_pid': 'T', 'position': 0}, {'state': 1, 'track_pid': 'T', 'position': 1}], 'T', 0, 0)
    print('Four playback outcome predicate checks passed')


if __name__ == '__main__':
    p = argparse.ArgumentParser(); p.add_argument('--selftest', action='store_true'); p.add_argument('--spec', type=pathlib.Path); p.add_argument('--out', type=pathlib.Path); args = p.parse_args()
    if args.selftest:
        selftest()
    else:
        if args.spec is None or args.out is None:
            p.error('--spec and --out are required')
        worker(args.spec, args.out)
