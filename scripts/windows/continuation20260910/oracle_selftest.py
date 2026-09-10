"""Offline guard/comparison tests for the fresh native discovery harness.
Never constructs iTunes.Application or starts iTunes. Requires a saved baseline.
"""
import argparse
import copy
import pathlib
import sys
import unittest
import native_oracle as n

BASE = None

class OracleTests(unittest.TestCase):
    def setUp(self):
        self.a = copy.deepcopy(BASE)
        self.b = copy.deepcopy(BASE)

    def rejects(self, change):
        change(self.b)
        with self.assertRaises((ValueError, KeyError, TypeError)):
            n.shape(self.b)

    def master(self, state):
        return next(p for p in state['playlists'] if p['kind'] == 1)

    def ordinary(self, state):
        members = copy.deepcopy(self.master(state)['members'])
        for i, m in enumerate(members):
            m['play_order_index'] = i + 1
        p = dict(name='ITL4 Test Manual', persistent_id='FEDCBA0987654321',
                 kind=2, special_kind=0, Smart=False,
                 parent_persistent_id=None, members=members)
        state['playlists'].append(p)
        if 'reported_playlist_count' in state:
            state['reported_playlist_count'] += 1
        return p

    def test_baseline_shape(self):
        n.shape(self.a)

    def test_identity_comparison(self):
        self.assertEqual(n.differences(self.a, self.b), [])

    def test_wrong_version(self):
        self.rejects(lambda s: s.update(version='12.13.11'))

    def test_duplicate_track(self):
        self.rejects(lambda s: s['tracks'].append(copy.deepcopy(s['tracks'][0])))

    def test_count_mismatch(self):
        self.rejects(lambda s: s.update(track_count=0))

    def test_native_count_mismatch(self):
        self.rejects(lambda s: s.update(reported_track_count=999))

    def test_native_playlist_count_mismatch(self):
        self.rejects(lambda s: s.update(reported_playlist_count=999))

    def test_zero_track_pid(self):
        self.rejects(lambda s: s['tracks'][0].update(persistent_id='0000000000000000'))

    def test_malformed_track_pid(self):
        self.rejects(lambda s: s['tracks'][0].update(persistent_id='not-a-native-pid'))

    def test_duplicate_playlist(self):
        self.rejects(lambda s: s['playlists'].append(copy.deepcopy(s['playlists'][0])))

    def test_zero_playlist_pid(self):
        self.rejects(lambda s: s['playlists'][0].update(persistent_id='0000000000000000'))

    def test_missing_master(self):
        self.rejects(lambda s: s.update(playlists=[p for p in s['playlists'] if p['kind'] != 1]))

    def test_wrong_master_identity(self):
        self.rejects(lambda s: s.update(library_persistent_id='0123456789ABCDEF'))

    def test_missing_master_member(self):
        self.rejects(lambda s: self.master(s)['members'].pop())

    def test_duplicate_master_member(self):
        self.rejects(lambda s: self.master(s)['members'].append(copy.deepcopy(self.master(s)['members'][0])))

    def test_dangling_member(self):
        self.rejects(lambda s: self.master(s)['members'][0].update(persistent_id='0123456789ABCDEF'))

    def test_outside_location(self):
        self.rejects(lambda s: s['tracks'][0].update(Location=str(n.ROOT/'baseline/private.itl')))

    def test_missing_file_flag(self):
        self.rejects(lambda s: s['tracks'][0].update(file_exists=False))

    def test_location_is_not_observe_only(self):
        self.b['tracks'][0]['Location'] += '.different'
        self.assertTrue(n.differences(self.a, self.b))

    def test_missing_location_property(self):
        self.b['tracks'][0].pop('Location')
        self.assertTrue(n.differences(self.a, self.b))

    def test_missing_nonempty_track(self):
        self.b['tracks'].pop()
        self.assertTrue(n.differences(self.a, self.b))

    def test_extra_playlist(self):
        self.ordinary(self.b)
        self.assertTrue(n.differences(self.a, self.b))

    def test_system_name_change(self):
        self.b['playlists'][1]['name'] = 'Changed system name'
        self.assertTrue(n.differences(self.a, self.b))

    def test_system_member_loss(self):
        self.master(self.b)['members'].pop()
        self.assertTrue(n.differences(self.a, self.b))

    def test_system_physical_order_is_not_manual(self):
        self.master(self.b)['members'].reverse()
        self.assertEqual(n.differences(self.a, self.b), [])

    def test_manual_order_is_checked(self):
        p = self.ordinary(self.a)
        q = self.ordinary(self.b)
        q['members'][0]['play_order_index'], q['members'][1]['play_order_index'] = 2, 1
        self.assertTrue(n.differences(self.a, self.b))

    def test_manual_physical_enumeration_with_same_order(self):
        self.ordinary(self.a)
        self.ordinary(self.b)['members'].reverse()
        self.assertEqual(n.differences(self.a, self.b), [])

    def test_parent_change_is_checked(self):
        self.ordinary(self.a)
        self.ordinary(self.b)['parent_persistent_id'] = '0123456789ABCDEF'
        self.assertTrue(n.differences(self.a, self.b))

    def test_smart_classification_is_checked(self):
        self.ordinary(self.a)
        self.ordinary(self.b)['Smart'] = True
        self.assertTrue(n.differences(self.a, self.b))

    def test_expectation_is_not_mutated(self):
        frozen = copy.deepcopy(self.a)
        self.b['tracks'][0]['Name'] = 'Different'
        n.differences(self.a, self.b)
        self.assertEqual(self.a, frozen)

    def test_scope_allows_owned_fixture(self):
        self.assertEqual(n.scoped(n.FIX/'tmp/test.itl', n.FIX), (n.FIX/'tmp/test.itl').resolve())

    def test_scope_rejects_parent(self):
        with self.assertRaises(ValueError):
            n.scoped(n.FIX/'../media4/not-owned.wav', n.FIX)

    def test_unicode_comparison_is_exact(self):
        self.a['tracks'][0]['Name'] = 'Caf\u00e9 日本語 🎵'
        self.b['tracks'][0]['Name'] = 'Cafe\u0301 日本語 🎵'
        self.assertTrue(n.differences(self.a, self.b))

    def test_empty_name_is_not_filename_fallback(self):
        self.a['tracks'][0]['Name'] = ''
        self.b['tracks'][0]['Name'] = 'alpha'
        self.assertTrue(n.differences(self.a, self.b))


def strict_field_test(field):
    def test(self):
        value = self.b['tracks'][0][field]
        self.b['tracks'][0][field] = not value if isinstance(value, bool) else str(value) + '-changed'
        self.assertTrue(n.differences(self.a, self.b), field)
    return test

for field in ['Name', 'Artist', 'Album', 'AlbumArtist', 'Comment', 'Genre', 'Composer',
              'Unplayed', 'Rating', 'AlbumRating', 'PlayedCount', 'PlayedDate',
              'ModificationDate', 'DateAdded', 'Year', 'Compilation', 'SortName', 'Size']:
    setattr(OracleTests, 'test_strict_' + field, strict_field_test(field))


def session_field_test(field):
    def test(self):
        self.b['tracks'][0][field] = 123456789
        self.assertEqual(n.differences(self.a, self.b), [])
    return test

for field in sorted(n.SESSION):
    setattr(OracleTests, 'test_session_only_' + field, session_field_test(field))

if __name__ == '__main__':
    p = argparse.ArgumentParser()
    p.add_argument('--baseline', type=pathlib.Path, required=True)
    args = p.parse_args()
    BASE = n.read(args.baseline)
    if len(BASE['tracks']) != 3:
        raise ValueError('Self-test expects the isolated three-track baseline')
    suite = unittest.defaultTestLoader.loadTestsFromTestCase(OracleTests)
    result = unittest.TextTestRunner(verbosity=2).run(suite)
    sys.exit(0 if result.wasSuccessful() else 1)
