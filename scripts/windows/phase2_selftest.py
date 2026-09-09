"""Pure/mocked regression tests: never launch or connect to native iTunes."""
import argparse, copy, pathlib, sys, tempfile, types, unittest
from unittest.mock import Mock, patch
import passive_native as p

class Phase2Tests(unittest.TestCase):
    def setUp(self):
        self.temp=tempfile.TemporaryDirectory(dir=self.scratch);self.root=pathlib.Path(self.temp.name)
        self.media=self.root/'sample.wav';self.media.write_bytes(b'synthetic')
        self.live=self.root/'iTunes Library.itl';self.live.write_bytes(b'hdfm-test-only')
        self.state={'version':'test','library_persistent_id':'MASTER','track_count':1,'playlists':[],
                    'tracks':[{'persistent_id':'TRACK','Name':'Requested','Unplayed':True,'Location':str(self.media)}]}
    def tearDown(self):self.temp.cleanup()
    def test_observe_only_never_hides_name(self):
        changed=copy.deepcopy(self.state);changed['tracks'][0].update(Name='Reverted',Unplayed=False)
        errors=p.compare_state(self.state,changed,['Unplayed']);self.assertEqual([e['property'] for e in errors],['Name'])
    def test_unplayed_not_inferred(self):
        changed=copy.deepcopy(self.state);changed['tracks'][0]['Unplayed']=False
        self.assertEqual(p.compare_state(self.state,changed,['Unplayed']),[])
        self.assertTrue(p.compare_state(self.state,changed,[]))
    def test_expected_is_not_mutated(self):
        before=copy.deepcopy(self.state);p.filtered(self.state,['Unplayed']);self.assertEqual(before,self.state)
    def test_identity_is_never_observe_only(self):
        changed=copy.deepcopy(self.state);changed['library_persistent_id']='WRONG'
        self.assertTrue(p.compare_state(self.state,changed,['Unplayed']))
    def trial(self,initial,later,wrong_master=False):
        import native_worker as nw
        tr=types.SimpleNamespace(Location=str(self.media),Unplayed=True,Rating=0,RatingKind=1,
                                 AlbumRating=0,AlbumRatingKind=1,PlayedCount=0,ModificationDate='test')
        class Track:
            def __init__(self):self.calls=0
            @property
            def Name(self):
                self.calls+=1;return initial if self.calls==1 else later
            def __getattr__(self,name):return getattr(tr,name)
        track=Track();playlist=object();app=types.SimpleNamespace(LibraryPlaylist=types.SimpleNamespace(Tracks=object()),Quit=Mock())
        spec={'root':str(self.root),'live':str(self.live),'expected':self.state,'target_track':'TRACK',
              'observe_only':['Unplayed'],'dwell_seconds':0}
        sp=self.root/'spec.json';op=self.root/'result.json';p.write_json(sp,spec)
        with patch.object(nw.pythoncom,'CoInitialize'),patch.object(nw.pythoncom,'CoUninitialize'),patch.object(nw.win32com.client.dynamic,'Dispatch',return_value=app),patch.object(nw,'pid',side_effect=lambda a,o:('WRONG' if wrong_master else 'MASTER') if o is app.LibraryPlaylist else 'TRACK'),patch.object(nw,'items',return_value=[track]),patch.object(nw,'file_interface',return_value=track),patch.object(nw,'snapshot',return_value=copy.deepcopy(self.state)),patch.object(p,'envelope',return_value={}):
            if wrong_master:
                with self.assertRaises(AssertionError):p.worker(sp,op)
                app.Quit.assert_not_called()
            else:p.worker(sp,op);app.Quit.assert_called_once()
        return p.load(op)
    def test_fresh_lookup_catches_stale_snapshot(self):
        result=self.trial('Requested','Reverted');self.assertFalse(result['accepted']);self.assertTrue(result['observation_completed'])
    def test_initial_failure_not_erased(self):
        self.assertFalse(self.trial('Wrong initial','Requested')['accepted'])
    def test_stable_passive_read_passes(self):
        self.assertTrue(self.trial('Requested','Requested')['accepted'])
    def test_fallback_stops_before_quit(self):
        self.assertFalse(self.trial('Requested','Requested',True)['observation_completed'])

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--scratch',type=pathlib.Path,required=True);a,rest=ap.parse_known_args();a.scratch.mkdir(parents=True,exist_ok=True);Phase2Tests.scratch=a.scratch;unittest.main(argv=[sys.argv[0]]+rest)
