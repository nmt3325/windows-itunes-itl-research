"""Offline regression tests for stricter phase3 native-evidence gates."""
import copy
import unittest
from import_native import compare, shape


def state():
    ids = ['0000000000000001', '0000000000000002']
    return {'version': '12.13.10.3', 'library_persistent_id': '00000000000000AA', 'track_count': 2,
            'tracks': [dict(persistent_id=p, Name='Track'+p, Artist='', Album='', AlbumArtist='', Comment='', Location='D:\\synthetic\\'+p+'.wav', Unplayed=True, TrackDatabaseID=i) for i,p in enumerate(ids)],
            'playlists': [dict(persistent_id='00000000000000AA', name='Library', kind=1, special_kind=None, members=[dict(persistent_id=p, play_order_index=i) for i,p in enumerate(ids)]),
                          dict(persistent_id='00000000000000BB', name='Manual', kind=2, special_kind=0, members=[dict(persistent_id=p, play_order_index=i) for i,p in enumerate(ids)])]}


def music_state():
    base=state(); music=copy.deepcopy(base['playlists'][0]); music.update(persistent_id='00000000000000DD', name='Music', kind=2, special_kind=6); base['playlists'].append(music); return base


class Gates(unittest.TestCase):
    def test_music_member_loss(self):
        a=music_state(); b=music_state(); b['playlists'][-1]['members'].pop(); self.assertTrue(compare(a,b,[]))
    def test_music_identity_loss(self):
        a=music_state(); b=music_state(); b['playlists'].pop(); self.assertTrue(compare(a,b,[]))
    def test_system_name(self):
        a=music_state(); b=music_state(); b['playlists'][-1]['name']='Wrong'; self.assertTrue(compare(a,b,[]))
    def test_system_order_not_manual_order(self):
        a=music_state(); b=music_state(); b['playlists'][-1]['members'].reverse(); self.assertEqual(compare(a,b,[]),[])
    def test_extra_system(self):
        self.assertTrue(compare(state(),music_state(),[]))
    def test_complete_pass(self):
        self.assertEqual(compare(state(), state(), []), [])
    def test_duplicate_track(self):
        b=state(); b['tracks'][1]=copy.deepcopy(b['tracks'][0]); self.assertTrue(compare(state(), b, []))
    def test_empty_truncated_tracks(self):
        b=state(); b['tracks']=[]; self.assertTrue(compare(state(), b, []))
    def test_missing_master(self):
        b=state(); b['playlists'].pop(0); self.assertTrue(compare(state(), b, []))
    def test_master_missing_member(self):
        b=state(); b['playlists'][0]['members'].pop(); self.assertTrue(compare(state(), b, []))
    def test_master_duplicate_member(self):
        b=state(); b['playlists'][0]['members'][1]=copy.deepcopy(b['playlists'][0]['members'][0]); self.assertTrue(compare(state(), b, []))
    def test_master_sort_is_not_manual_order(self):
        b=state(); b['playlists'][0]['members'].reverse(); self.assertEqual(compare(state(), b, []), [])
    def test_ordinary_order_is_checked(self):
        b=state(); b['playlists'][1]['members'][0]['play_order_index']=9; self.assertTrue(compare(state(), b, []))
    def test_extra_ordinary(self):
        b=state(); extra=copy.deepcopy(b['playlists'][1]); extra['persistent_id']='00000000000000CC'; b['playlists'].append(extra); self.assertTrue(compare(state(), b, []))
    def test_missing_location(self):
        b=state(); del b['tracks'][0]['Location']; self.assertTrue(compare(state(), b, []))
    def test_location_change(self):
        b=state(); b['tracks'][0]['Location']='D:\\synthetic\\wrong.wav'; self.assertTrue(compare(state(), b, []))
    def test_session_ids_not_persistent_identity(self):
        b=state(); b['tracks'][0]['TrackDatabaseID']=999; self.assertEqual(compare(state(), b, []), [])
    def test_name_never_observe_only(self):
        with self.assertRaises(ValueError): compare(state(), state(), ['Name'])
    def test_explicit_unplayed_enforced(self):
        b=state(); b['tracks'][0]['Unplayed']=False; self.assertTrue(compare(state(), b, [])); self.assertEqual(compare(state(), b, ['Unplayed']), [])
    def test_expected_not_mutated(self):
        a=state(); old=copy.deepcopy(a); b=state(); b['tracks'][0]['Name']='Wrong'; self.assertTrue(compare(a,b,[])); self.assertEqual(a,old)
    def test_unknown_ordinary_classification(self):
        b=state(); b['playlists'][1]['special_kind']=None; self.assertTrue(compare(state(), b, []))
    def test_invalid_expected_refused(self):
        a=state(); a['track_count']=True
        with self.assertRaises(ValueError): shape(a)


if __name__=='__main__':
    unittest.main(verbosity=2)
