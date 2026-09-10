"""NEW G2 tests of the actual production controller/guard, with explicit I/O doubles.

Does NOT run old suites, remove xfails, patch guard predicates or reuse the
old test-only contract model. Every fixture and native boundary here is fake.
"""
import argparse
import ast
import collections
import contextlib
import copy
import datetime as dt
import hashlib
import importlib
import json
import os
from pathlib import Path
import sys
import types
import unittest
from unittest.mock import Mock, patch
import g2_acceptance_guard as g
import g2_native_acceptance as production
import g2_action_selftest as isolation

OUT = None
FIELDS = sorted(g.CORE | {'ratingKind'})
IDS = isolation.IDS
MASTER, MUSIC, MANUAL, HIDDEN = isolation.MASTER, isolation.MUSIC, isolation.MANUAL, isolation.HIDDEN
FILE_PID = isolation.FILE_PID
KIND = 'g2_production_guard_offline_selftest_only'


def state(fix):
    tracks = []
    for index, pid in enumerate(IDS):
        tr = {k: '' for k in g.CORE_TEXT + g.CORE_DATES}
        tr.update({k: 0 for k in g.CORE_NUMBER}); tr.update({k: False for k in g.CORE_BOOL})
        tr.update(persistent_id=pid, Name=['alpha', 'beta', 'gamma'][index],
                  Location=str(fix/(str(index)+'.wav')), file_exists=True, ratingKind=1,
                  Enabled=True, Unplayed=True, Size=15, Duration=1, SampleRate=44100)
        tracks.append(tr)
    playlists = []
    for pid, name, kind, special, smart, members in [(MASTER, 'Library', 1, None, False, IDS),
               (MUSIC, 'Music', 2, 6, True, IDS), (MANUAL, 'ITL4 Mock Manual', 2, 0, False, IDS[::-1])]:
        playlists.append(dict(persistent_id=pid, name=name, kind=kind, special_kind=special,
                              Smart=smart, parent_persistent_id=None,
                              members=[dict(persistent_id=p, name=tracks[IDS.index(p)]['Name'], play_order_index=i+1)
                                       for i, p in enumerate(members)]))
    return dict(version=g.VERSION, library_persistent_id=MASTER, track_count=3,
                reported_track_count=3, reported_playlist_count=3, sound_volume=100,
                typelib_track_scalar_properties=FIELDS, tracks=tracks, playlists=playlists)


def save_json(path, value):
    with Path(path).open('x', encoding='utf-8', newline='\n') as f:
        json.dump(value, f, ensure_ascii=True, allow_nan=False, indent=2); f.write('\n')


class FakeAuthorization:
    def __init__(self, root, runtime_sha, handoff_path, handoff_sha, case):
        self.case = case; self.runtime_sha = runtime_sha
        self.handoff_path = Path(handoff_path); self.handoff_sha = handoff_sha
    def check(self, budget_seconds=0):
        self.case.verify()
        return dt.datetime(2026, 9, 10, 8, 35, tzinfo=dt.timezone.utc)


class GuardTests(unittest.TestCase):
    def setUp(self):
        self.folder = OUT/'cases'/self.id().split('.')[-1]
        self.folder.mkdir(parents=True, exist_ok=False)
        self.root = self.folder/'fake-root'
        self.fix = self.root/'fixtures/dynamic4'; self.fix.mkdir(parents=True)
        self.rep = self.root/'reports/dynamic'; self.rep.mkdir(parents=True)
        self.parent = self.root/'reports/parent'; self.parent.mkdir()
        self.expected = state(self.fix)
        for tr in self.expected['tracks']:
            Path(tr['Location']).write_bytes(b'MOCK MEDIA ONLY')
        self.raw_bytes = isolation.mock_library()
        baseline = self.fix/'baseline-MOCK.itl'; baseline.write_bytes(self.raw_bytes)
        candidate = self.fix/'candidate-MOCK.itl'; candidate.write_bytes(self.raw_bytes)
        self.plan = dict(schema='itl4.g2.strict-passive-plan.v1', classification='passive_preservation',
                         frozen_utc=(dt.datetime.now(dt.timezone.utc)-dt.timedelta(seconds=10)).isoformat(),
                         expected_origin='independent_pre_native_intent', dwell_seconds=[45, 30],
                         old_track_pids=list(IDS), new_track_pids=[], track_fields=FIELDS,
                         before=copy.deepcopy(self.expected), expected=copy.deepcopy(self.expected),
                         candidate=g.stable_read(candidate)[1], baseline=g.stable_read(baseline)[1],
                         before_raw=g.raw_projection(self.raw_bytes), expected_raw=g.raw_projection(self.raw_bytes),
                         file_pid=FILE_PID, live=str(self.fix/'new-live'/'iTunes Library.itl'),
                         media=[g.stable_read(t['Location'])[1] for t in self.expected['tracks']])
        self.plan_path = self.rep/'plan-MOCK.json'; self.output = self.rep/'new-controller-run'
        self.mutate = lambda value, index: None
        self.port_calls = []; self.t0 = dt.datetime.now(dt.timezone.utc)+dt.timedelta(seconds=5)

    def frozen(self):
        save_json(self.plan_path, self.plan)
        pin = g.stable_read(self.plan_path)[1]
        return g.FrozenCase(self.plan_path, pin['sha256'], self.root)

    def cycle_value(self, case, index, output, previous):
        self.port_calls.append(index)
        times = list(range(0, (45 if index == 1 else 30), 2)) + [45 if index == 1 else 30]
        com = dict(ok=True, quit_returned=True, errors=[], explicit_actions=[],
                   update_info_from_file_called=False, plan_sha256=case.pin['sha256'],
                   samples=[dict(elapsed_seconds=t, state=copy.deepcopy(case.spec['expected']),
                                 media=copy.deepcopy(case.media), modal_events=[]) for t in times],
                   after=copy.deepcopy(case.spec['expected']))
        saved = output/'MOCK-saved.itl'; saved.write_bytes(self.raw_bytes)
        start = self.t0+dt.timedelta(seconds=(index-1)*100)
        value = dict(index=index, evidence_kind='offline_test_double', started_utc=start.isoformat(),
                     completed_utc=(start+dt.timedelta(seconds=60)).isoformat(),
                     worker_exit_code=0, native_exit_code=0, native_stopped=True,
                     com=com, input_sha256=previous, selected_path=str(case.live), selection_verified=True,
                     file_pid=FILE_PID, modal_events=[], fallback_detected=False,
                     identity=dict(pid=700000+index, creation='MOCK PROCESS '+str(index)),
                     saved=g.stable_read(saved)[1])
        self.mutate(value, index)
        return value

    def run_controller(self, *, real_authorization=False):
        case = self.frozen()
        owner = self
        class FakePort:
            evidence_kind = 'offline_test_double'
            def __init__(self, the_case, auth, options): self.case = the_case
            def run_cycle(self, index, output, previous): return owner.cycle_value(self.case, index, output, previous)
        with contextlib.ExitStack() as stack:
            stack.enter_context(patch.object(production, 'NativePort', FakePort))
            if not real_authorization:
                stack.enter_context(patch.object(g, 'Authorization', FakeAuthorization))
            return production.controller(self.plan_path, case.pin['sha256'], '0'*64,
                                         self.parent/'handoff.json', '1'*64, self.output, root=self.root)

    def refused(self, code):
        with self.assertRaisesRegex(g.Rejected, '^'+code): self.run_controller()
        if (self.output/'result.json').exists():
            result = g.load_json((self.output/'result.json').read_bytes())
            self.assertIs(result['ok'], False); self.assertIs(result['guard_passed'], False)
            self.assertIs(result['native_acceptance'], False); self.assertIs(result['engine_witness'], False)

    def test_real_controller_complete_mock_protocol_is_not_native_evidence(self):
        value = self.run_controller()
        self.assertTrue(value['guard_passed']); self.assertFalse(value['native_validation_performed'])
        self.assertFalse(value['native_acceptance']); self.assertFalse(value['engine_witness'])
        self.assertEqual(self.port_calls, [1, 2])

    def test_equal_missing_expected_and_observed_metadata_rejected_before_backend(self):
        self.plan['before']['tracks'][0].pop('Name'); self.plan['expected']['tracks'][0].pop('Name')
        self.refused('missing_metadata'); self.assertEqual(self.port_calls, [])

    def test_equal_missing_expected_non_name_metadata_rejected_before_backend(self):
        self.plan['before']['tracks'][0].pop('AlbumArtist'); self.plan['expected']['tracks'][0].pop('AlbumArtist')
        self.refused('missing_metadata'); self.assertEqual(self.port_calls, [])

    def test_missing_reported_counts_in_both_intents_is_not_inferred(self):
        for s in [self.plan['before'], self.plan['expected']]: s.pop('reported_track_count')
        self.refused('explicit_reported_count'); self.assertEqual(self.port_calls, [])

    def test_expected_ambiguous_manual_order_is_rejected_before_backend(self):
        for s in [self.plan['before'], self.plan['expected']]: s['playlists'][2]['members'][0]['play_order_index']=2
        self.refused('manual_order_token')

    def test_hidden_physical_reorder_rejected_by_production_path(self):
        def change(value, index):
            p=Path(value['saved']['path']); p.write_bytes(isolation.mock_library(hidden=[IDS[2], IDS[0]])); value['saved']=g.stable_read(p)[1]
        self.mutate=change; self.refused('raw_full_order_or_intent_mismatch')
        self.assertEqual(self.port_calls,[1])

    def test_hidden_membership_loss_rejected_by_production_path(self):
        def change(value, index):
            p=Path(value['saved']['path']); p.write_bytes(isolation.mock_library(hidden=[IDS[0]])); value['saved']=g.stable_read(p)[1]
        self.mutate=change; self.refused('raw_full_order_or_intent_mismatch')

    def test_legacy_header_delta_stays_limited_but_new_path_rejects_child_order(self):
        import raw_capture as rc
        first=rc.capture(Path(self.plan['candidate']['path']))
        p=self.fix/'other-MOCK.itl';p.write_bytes(isolation.mock_library(hidden=[IDS[2],IDS[0]])); second=rc.capture(p)
        self.assertEqual(rc.header_differences(first,second)['playlists']['headers'],{})
        def change(value,index):
            dest=Path(value['saved']['path']);dest.write_bytes(p.read_bytes());value['saved']=g.stable_read(dest)[1]
        self.mutate=change;self.refused('raw_full_order_or_intent_mismatch')

    def test_duplicate_metadata_occurrence_order_is_authoritative(self):
        # Replace equal-sized text payloads without changing any record lengths.
        a='occurrence-a'.encode('utf-16le');b='occurrence-b'.encode('utf-16le')
        self.assertEqual(len(a),len(b));data=self.raw_bytes
        self.assertEqual(data.count(a),1);self.assertEqual(data.count(b),1)
        changed=data.replace(a,b'Q'*len(a)).replace(b,a).replace(b'Q'*len(a),b)
        def change(value,index):
            p=Path(value['saved']['path']);p.write_bytes(changed);value['saved']=g.stable_read(p)[1]
        self.mutate=change;self.refused('raw_full_order_or_intent_mismatch')

    def test_controller_rejects_worker_zero_com_false(self):
        self.mutate=lambda v,i:v['com'].update(ok=False)
        self.refused('strict_com_success');self.assertEqual(self.port_calls,[1])

    def test_final_pass_rechecks_first_saved_file(self):
        def change(v,i):
            if i==2:
                p=self.output/'cycle-1'/'MOCK-saved.itl';p.write_bytes(b'CHANGED OLD SAVE')
        self.mutate=change;self.refused('file_pin_changed')

    def test_media_same_length_byte_tamper_rejected(self):
        def change(v,i): Path(self.plan['media'][0]['path']).write_bytes(b'TAMPERED MEDIA!')
        self.assertEqual(len(b'TAMPERED MEDIA!'),15)
        self.mutate=change;self.refused('file_pin_changed')

    def test_plan_changed_after_arming_is_rejected(self):
        def change(v,i):
            with self.plan_path.open('ab') as f:f.write(b' ')
        self.mutate=change;self.refused('frozen_plan_changed')

    def test_mutable_in_memory_spec_cannot_replace_expected(self):
        case=self.frozen();case.spec['expected']['tracks'][0]['Name']='changed'
        with self.assertRaisesRegex(g.Rejected,'^frozen_plan_in_memory_changed'):case.verify()

    def test_wrong_external_plan_sha_rejected(self):
        save_json(self.plan_path,self.plan)
        with self.assertRaisesRegex(g.Rejected,'^plan_pin'):g.FrozenCase(self.plan_path,'f'*64,self.root)

    def test_duplicate_json_key_rejected(self):
        with self.assertRaisesRegex(g.Rejected,'^duplicate_json_key'):g.load_json(b'{"a":1,"a":2}')

    def test_nonfinite_json_rejected(self):
        with self.assertRaisesRegex(g.Rejected,'^nonfinite_json'):g.load_json(b'{"a":NaN}')

    def test_existing_output_rejected_without_replaying_work(self):
        self.output.mkdir();(self.output/'sentinel').write_bytes(b'unchanged')
        with self.assertRaisesRegex(g.Rejected,'^existing_output'):self.run_controller()
        self.assertEqual((self.output/'sentinel').read_bytes(),b'unchanged');self.assertEqual(self.port_calls,[])

    def test_real_runtime_false_blocks_before_native_factory(self):
        case=self.frozen()
        runtime=dict(generation=2,native_owner='dynamic',native_ready=False,native_handoff_issued=False)
        save_json(self.root/'runtime.json',runtime); rsha=g.stable_read(self.root/'runtime.json')[1]['sha256']
        with patch.object(production,'NativePort',side_effect=AssertionError('native factory reached')) as factory:
            with self.assertRaisesRegex(g.Rejected,'^native_not_authorized'):
                production.controller(self.plan_path,case.pin['sha256'],rsha,self.parent/'handoff.json','1'*64,self.output,root=self.root)
        factory.assert_not_called();self.assertFalse(self.output.exists());self.assertFalse(case.live.exists())

    def test_readiness_without_explicit_handoff_is_rejected(self):
        case=self.frozen()
        runtime=dict(generation=2,env_id='mock-env',native_owner='dynamic',native_ready=True,native_handoff_issued=False)
        save_json(self.root/'runtime.json',runtime)
        auth=g.Authorization(self.root,g.stable_read(self.root/'runtime.json')[1]['sha256'],self.parent/'handoff.json','0'*64,case)
        with self.assertRaisesRegex(g.Rejected,'^native_not_authorized'):auth.check()

    def test_old_cutoff_is_not_modified_by_new_selector(self):
        original=isolation.P/'native_select.py';new=isolation.P/'g2_native_select.py'
        self.assertEqual(hashlib.sha256(original.read_bytes()).hexdigest(),isolation.ORIGINALS['native_select.py'])
        self.assertIn('2026-09-10T05:15:00+00:00',original.read_text(encoding='utf-8'))
        self.assertNotIn('2026-09-10T05:15:00+00:00',new.read_text(encoding='utf-8'))
        import g2_native_select as selector
        auth=Mock();auth.check.side_effect=g.Rejected('native_not_authorized')
        with self.assertRaisesRegex(g.Rejected,'^native_not_authorized'):
            selector.select(self.fix/'absent','open',self.rep/'picker',authorization=auth)
        self.assertFalse((self.rep/'picker').exists())

    def test_parent_handoff_has_a_hard_g2_deadline(self):
        case=self.frozen()
        runtime=dict(generation=2,env_id='MOCK-ENV-NOT-A-RUNNER',native_owner='dynamic',
                     native_ready=True,native_handoff_issued=True,
                     g2_schedule=dict(native_permission_granted=True,native_cutoff_utc=g.G2_CUTOFF))
        handoff=dict(schema='itl4.g2.dynamic-native-handoff.v1',authorized=True,
                     plan_sha256=case.pin['sha256'],root=str(self.root),env_id=runtime['env_id'],
                     acquisition_verified=True,not_after_utc=g.G2_CUTOFF)
        save_json(self.root/'runtime.json',runtime);save_json(self.parent/'handoff.json',handoff)
        auth=g.Authorization(self.root,g.stable_read(self.root/'runtime.json')[1]['sha256'],
                             self.parent/'handoff.json',g.stable_read(self.parent/'handoff.json')[1]['sha256'],case)
        with self.assertRaisesRegex(g.Rejected,'^native_cutoff'):auth.check(budget_seconds=10**9)

    def test_explicit_handoff_for_different_case_is_not_authority(self):
        case=self.frozen()
        runtime=dict(generation=2,env_id='MOCK-ENV',native_owner='dynamic',native_ready=True,
                     native_handoff_issued=True,g2_schedule=dict(native_permission_granted=True,native_cutoff_utc=g.G2_CUTOFF))
        handoff=dict(schema='itl4.g2.dynamic-native-handoff.v1',authorized=True,plan_sha256='0'*64,root=str(self.root))
        save_json(self.root/'runtime.json',runtime);save_json(self.parent/'handoff.json',handoff)
        auth=g.Authorization(self.root,g.stable_read(self.root/'runtime.json')[1]['sha256'],self.parent/'handoff.json',g.stable_read(self.parent/'handoff.json')[1]['sha256'],case)
        with self.assertRaisesRegex(g.Rejected,'^handoff_case_scope'):auth.check()

    def test_actual_native_port_checks_com_flag_before_wait_or_save(self):
        case=self.frozen();case.live.parent.mkdir();case.live.write_bytes(self.raw_bytes)
        out=self.rep/'native-port-MOCK';out.mkdir()
        ident=dict(pid=700002,creation='MOCK',path='MOCK')
        handle=Mock(); wait=Mock(return_value=0)
        n=types.SimpleNamespace(require_stopped=Mock(),identity=Mock(return_value=ident),
            win32api=types.SimpleNamespace(OpenProcess=Mock(return_value=handle)),
            win32event=types.SimpleNamespace(WaitForSingleObject=wait),
            win32process=types.SimpleNamespace(GetExitCodeProcess=Mock(return_value=0)))
        selector=types.SimpleNamespace(select=Mock(return_value=dict(selected=True,verified_picker_path=str(case.live),identity=ident)))
        def worker(*args,**kwargs):
            save_json(out/'com.json',dict(ok=False,quit_returned=False,after=self.expected))
            return types.SimpleNamespace(returncode=0)
        auth=FakeAuthorization(self.root,'0'*64,self.parent/'handoff','1'*64,case)
        with patch.object(production,'native_modules',return_value=(n,selector)),patch.object(production.subprocess,'run',side_effect=worker):
            port=production.NativePort(case,auth,{})
            with self.assertRaisesRegex(g.Rejected,'^strict_com_success'):port.run_cycle(1,out,case.candidate['sha256'])
        wait.assert_not_called();handle.Close.assert_called_once();self.assertFalse((out/'saved.itl').exists())


def sample_mutator(change):
    def alter(v,i):
        for sample in v['com']['samples']:change(sample['state'])
        change(v['com']['after'])
    return alter


def make_case(name, mutation, code, plan=False):
    def test(self):
        if plan:mutation(self.plan)
        else:self.mutate=mutation
        self.refused(code)
    test.__name__='test_'+name
    setattr(GuardTests,test.__name__,test)


STATE_BAD = [
 ('missing_name',lambda s:s['tracks'][0].pop('Name'),'missing_metadata'),
 ('missing_composer',lambda s:s['tracks'][0].pop('Composer'),'missing_metadata'),
 ('unavailable_name',lambda s:s['tracks'][0].update(Name={'unavailable':'MOCK'}),'unavailable_metadata'),
 ('null_name',lambda s:s['tracks'][0].update(Name=None),'unavailable_metadata'),
 ('numeric_name',lambda s:s['tracks'][0].update(Name=7),'metadata_type'),
 ('missing_reported_tracks',lambda s:s.pop('reported_track_count'),'explicit_reported_count'),
 ('missing_reported_playlists',lambda s:s.pop('reported_playlist_count'),'explicit_reported_count'),
 ('wrong_reported_tracks',lambda s:s.update(reported_track_count=4),'explicit_reported_count'),
 ('bool_reported_count',lambda s:s.update(reported_playlist_count=True),'explicit_reported_count'),
 ('missing_manual_order',lambda s:s['playlists'][2]['members'][0].pop('play_order_index'),'manual_order_token'),
 ('duplicate_manual_order',lambda s:s['playlists'][2]['members'][0].update(play_order_index=2),'manual_order_token'),
 ('string_manual_order',lambda s:s['playlists'][2]['members'][0].update(play_order_index='1'),'manual_order_token'),
 ('zero_manual_order',lambda s:s['playlists'][2]['members'][0].update(play_order_index=0),'manual_order_token'),
 ('ambiguous_playlist_kind',lambda s:s['playlists'][2].update(special_kind=None),'playlist_classification'),
 ('wrong_master',lambda s:s.update(library_persistent_id='0000000000000666'),'master_identity'),
 ('changed_artist',lambda s:s['tracks'][0].update(Artist='unexpected'),'state_intent_mismatch'),
 ('changed_location',lambda s:s['tracks'][0].update(Location=s['tracks'][1]['Location']),'state_intent_mismatch'),
 ('missing_type_inventory',lambda s:s.pop('typelib_track_scalar_properties'),'scalar_inventory_mismatch'),
 ('unknown_unavailable_field',lambda s:s['tracks'][0].update(Unclassified={'unavailable':'MOCK'}),'non_scalar_track_observation'),
 ('empty_fallback',lambda s:s.update(tracks=[],track_count=0,reported_track_count=0),'dangling_visible_member'),
 ('duplicate_old_id',lambda s:s['tracks'][1].update(persistent_id=IDS[0]),'duplicate_ids'),
 ('manual_reordered',lambda s:s['playlists'][2]['members'][0].update(play_order_index=4),'state_intent_mismatch'),
]
for name,mutation,code in STATE_BAD:make_case(name,sample_mutator(mutation),code)

for name,mutation,code in [
 ('com_ok_missing',lambda v,i:v['com'].pop('ok'),'strict_com_success'),
 ('com_ok_integer',lambda v,i:v['com'].update(ok=1),'strict_com_success'),
 ('quit_false',lambda v,i:v['com'].update(quit_returned=False),'strict_com_success'),
 ('quit_missing',lambda v,i:v['com'].pop('quit_returned'),'strict_com_success'),
 ('worker_failure',lambda v,i:v.update(worker_exit_code=1),'worker_exit'),
 ('worker_bool_zero',lambda v,i:v.update(worker_exit_code=False),'worker_exit'),
 ('native_failure',lambda v,i:v.update(native_exit_code=1),'normal_native_exit'),
 ('native_not_stopped',lambda v,i:v.update(native_stopped=False),'normal_native_exit'),
 ('worker_error_hidden',lambda v,i:v['com'].update(errors=['ignored failure']),'passive_worker_contract'),
 ('setter_repair',lambda v,i:v['com'].update(explicit_actions=[{'Name':'repair'}]),'passive_worker_contract'),
 ('refresh_from_file',lambda v,i:v['com'].update(update_info_from_file_called=True),'passive_worker_contract'),
 ('wrong_selected_path',lambda v,i:v.update(selected_path='wrong library'),'selected_library_path'),
 ('selected_flag_missing',lambda v,i:v.pop('selection_verified'),'selected_library_path'),
 ('wrong_file_pid',lambda v,i:v.update(file_pid='0000000000000888'),'selected_file_pid'),
 ('damaged_modal',lambda v,i:v.update(modal_events=['Damaged Library']),'modal_or_fallback'),
 ('fallback_true',lambda v,i:v.update(fallback_detected=True),'modal_or_fallback'),
 ('fallback_unobserved',lambda v,i:v.pop('fallback_detected'),'modal_or_fallback'),
 ('no_samples',lambda v,i:v['com'].update(samples=[]),'insufficient_observations'),
 ('one_sample',lambda v,i:v['com'].update(samples=v['com']['samples'][:1]),'insufficient_observations'),
 ('short_dwell',lambda v,i:v['com'].update(samples=v['com']['samples'][:-2]),'insufficient_dwell'),
 ('sparse_samples',lambda v,i:v['com'].update(samples=[v['com']['samples'][j] for j in [0,8,-1]]),'observation_coverage'),
 ('backward_sample_time',lambda v,i:v['com']['samples'][2].update(elapsed_seconds=0),'observation_coverage'),
 ('nan_sample_time',lambda v,i:v['com']['samples'][0].update(elapsed_seconds=float('nan')),'observation_time'),
 ('sample_missing_media',lambda v,i:v['com']['samples'][1].pop('media'),'sample_media_or_modal'),
 ('sample_modal',lambda v,i:v['com']['samples'][1].update(modal_events=['Damaged']),'sample_media_or_modal'),
 ('clock_envelope_short',lambda v,i:v.update(completed_utc=v['started_utc']),'observation_clock_inconsistent'),
 ('broken_input_chain',lambda v,i:v.update(input_sha256='0'*64),'cycle_chain_or_plan'),
 ('worker_wrong_plan',lambda v,i:v['com'].update(plan_sha256='0'*64),'cycle_chain_or_plan'),
 ('missing_saved_observation',lambda v,i:v.pop('saved'),'incomplete_file_pin'),
 ('origin_mixed',lambda v,i:v.update(evidence_kind='native_observation'),'mixed_evidence_origin'),
 ('same_process_reused',lambda v,i:v.update(identity={'pid':700001,'creation':'MOCK PROCESS 1'}),'same_process_not_reopened'),
]:make_case(name,mutation,code)

for name,mutation,code in [
 ('overlap_old_new',lambda s:s.update(new_track_pids=[IDS[0]]),'overlapping_old_new'),
 ('missing_old_id',lambda s:s.update(old_track_pids=IDS[:2]),'old_id_partition'),
 ('duplicate_old_partition',lambda s:s.update(old_track_pids=IDS+[IDS[0]]),'duplicate_ids'),
 ('missing_expected_origin',lambda s:s.pop('expected_origin'),'self_observed_expectation'),
 ('self_observed_intent',lambda s:s.update(expected_origin='observed_after_open'),'self_observed_expectation'),
 ('short_requested_windows',lambda s:s.update(dwell_seconds=[3,3]),'two_observation_windows'),
 ('incomplete_fields_contract',lambda s:s.update(track_fields=['Name']),'incomplete_field_contract'),
 ('missing_media_pin',lambda s:s['media'].pop(),'incomplete_media_inventory'),
 ('duplicate_media_pin',lambda s:s['media'].append(copy.deepcopy(s['media'][0])),'duplicate_media_path'),
 ('raw_intent_omits_hidden',lambda s:s['expected_raw']['sections'][-1]['records'].pop(),'raw_intent_not_candidate'),
]:make_case(name,mutation,code,True)


def main():
    global OUT
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--out',required=True,type=Path)
    args=parser.parse_args();OUT=g.within(args.out,isolation.R/'reports/dynamic')
    g.need(not OUT.exists(),'existing_output');before=isolation.pinned_sources()
    OUT.mkdir(parents=True,exist_ok=False);isolation.OUT=OUT
    sources={name:hashlib.sha256((isolation.P/name).read_bytes()).hexdigest() for name in
             ['g2_acceptance_guard.py','g2_native_acceptance.py','g2_native_select.py','g2_guard_selftest.py']}
    save_json(OUT/'scope.json',dict(evidence_kind=KIND,native_actions=0,engine_witness=False,
              real_production_predicates=True,old_test_model_used=False,old_suites_reexecuted=False,
              old_xfails_removed=False,source_pins=sources,fixed_original_pins=before))
    sys.addaudithook(isolation.audit_io);sys.path[:0]=[str(isolation.P),str(isolation.LEGACY)]
    with isolation.no_native_interfaces():
        with (OUT/'unittest.log').open('x',encoding='utf-8',newline='\n') as log:
            log.write('EXPLICIT OFFLINE DOUBLES ONLY. NO NATIVE OBSERVATIONS OR ENGINE WITNESSES.\n')
            with contextlib.redirect_stdout(log),contextlib.redirect_stderr(log):
                result=unittest.TextTestRunner(stream=log,verbosity=2,resultclass=isolation.Results).run(
                       unittest.defaultTestLoader.loadTestsFromTestCase(GuardTests))
        after=isolation.pinned_sources()
    good=result.wasSuccessful() and not isolation.BLOCKED_CALLS and before==after
    summary=dict(evidence_kind=KIND,status='passed' if good else 'failed',test_count=result.testsRun,
                 passed=sum(x['outcome']=='passed' for x in result.records),failures=len(result.failures),
                 errors=len(result.errors),expected_failures=len(result.expectedFailures),skipped=len(result.skipped),
                 native_actions=0,native_observations=0,native_acceptance=False,engine_witness=False,
                 real_production_predicates=True,old_test_model_used=False,old_suites_reexecuted=False,
                 original5_helpers7_optional7_preserved=before==after,blocked_boundary_calls=isolation.BLOCKED_CALLS,
                 sources=sources,tests=result.records)
    save_json(OUT/'result.json',summary)
    print(json.dumps({k:v for k,v in summary.items() if k not in ['tests','sources']},ensure_ascii=True))
    return 0 if good else 1


if __name__=='__main__':raise SystemExit(main())
