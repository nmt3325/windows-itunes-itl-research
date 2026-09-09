"""Offline tests for native evidence gates; no iTunes is launched by this suite."""
import argparse,copy,hashlib,json,pathlib,random,sys,tempfile,unittest,zlib
from Crypto.Cipher import AES
from analyze_trace import KEY,decode,groups,analyze
from verify_native_matrix import compare,verify_action

A='1111111111111111';B='2222222222222222';P='3333333333333333'
def state():return {'version':'12.13.10.3','library_persistent_id':'4444444444444444','track_count':2,'tracks':[{'persistent_id':A,'Name':'Alpha','Rating':80,'TrackID':1,'TrackDatabaseID':71,'PlayOrderIndex':1},{'persistent_id':B,'Name':'Beta','Rating':0,'TrackID':2,'TrackDatabaseID':72,'PlayOrderIndex':2}],'playlists':[{'persistent_id':P,'name':'Synthetic Order','kind':2,'special_kind':0,'members':[{'persistent_id':A,'play_order_index':1},{'persistent_id':B,'play_order_index':2}]}]}

class EvidenceTests(unittest.TestCase):
    scratch=None
    def setUp(self):self.tmp=tempfile.TemporaryDirectory(dir=self.scratch);self.root=pathlib.Path(self.tmp.name)
    def tearDown(self):self.tmp.cleanup()
    def test_same_native_state(self):self.assertEqual(compare(state(),state()),[])
    def test_reject_empty_fallback(self):
        x=state();x['track_count']=0;x['tracks']=[];self.assertTrue(compare(state(),x))
    def test_reject_wrong_master_pid(self):
        x=state();x['library_persistent_id']='0000000000000000';self.assertTrue(compare(state(),x))
    def test_reject_wrong_track_pid(self):
        x=state();x['tracks'][0]['persistent_id']='AAAAAAAAAAAAAAAA';self.assertTrue(compare(state(),x))
    def test_reject_changed_value(self):
        x=state();x['tracks'][0]['Rating']=20;self.assertTrue(compare(state(),x))
    def test_session_ids_not_persistent_ids(self):
        x=state();x['tracks'][0].update(TrackID=131,TrackDatabaseID=139,PlayOrderIndex=2);self.assertEqual(compare(state(),x),[])
    def test_order_gate(self):
        x=state();x['playlists'][0]['members'][0]['play_order_index']=2;x['playlists'][0]['members'][1]['play_order_index']=1;self.assertTrue(compare(state(),x));verify_action(state(),x,{'kind':'playlist_reorder','name':'Synthetic Order','tracks':[B,A]})
    def test_non_synthetic_ordinary_name_is_checked(self):
        expected=state();expected['playlists'][0]['name']='Codec Playlist';actual=copy.deepcopy(expected);actual['playlists'][0]['name']='Wrong name';self.assertTrue(compare(expected,actual))
    def test_missing_independent_created_playlist_is_rejected(self):
        expected=state();expected['playlists'][0]['name']='Codec Created';actual=copy.deepcopy(expected);actual['playlists']=[];self.assertTrue(compare(expected,actual))
    def test_missing_playlist_classification_is_refused(self):
        actual=state();actual['playlists'][0]['special_kind']=None
        with self.assertRaises(ValueError):compare(state(),actual)
    def test_unicode_field_gate(self):
        x=state();x['tracks'][0]['Name']='\u5408\u6210\U0001f3b5';verify_action(state(),x,{'kind':'set_track','track':A,'field':'Name','value':'\u5408\u6210\U0001f3b5'})
    def worker_trial(self,unstable):
        import native_worker
        from unittest.mock import Mock,patch
        expected=state()
        for t in expected['tracks']:t['Location']=str(self.root/(t['persistent_id']+'.wav'))
        after=copy.deepcopy(expected)
        if unstable:after['tracks'][0]['Name']='Reverted name'
        ep=self.root/'expected.json';ep.write_text(json.dumps(expected),encoding='utf-8');op=self.root/'worker.json';app=Mock()
        argv=['native_worker.py','--root',str(self.root),'--output',str(op),'--expect-state',str(ep),'--expect-count','2','--quit']
        with patch.object(sys,'argv',argv),patch.object(native_worker.pythoncom,'CoInitialize'),patch.object(native_worker.win32com.client.dynamic,'Dispatch',return_value=app),patch.object(native_worker,'snapshot',side_effect=[expected,after]):
            if unstable:
                with self.assertRaisesRegex(RuntimeError,'snapshot-only state changed'):native_worker.main()
            else:native_worker.main()
        return app,json.loads(op.read_text(encoding='utf-8'))
    def test_snapshot_regression_blocks_native_quit(self):
        app,result=self.worker_trial(True);app.Quit.assert_not_called();self.assertFalse(result['ok']);self.assertTrue(result['snapshot_stability_errors']);self.assertTrue(result['post_expectation_errors'])
    def test_stable_snapshot_allows_native_quit(self):
        app,result=self.worker_trial(False);app.Quit.assert_called_once();self.assertTrue(result['ok']);self.assertEqual(result['snapshot_stability_errors'],[]);self.assertEqual(result['post_expectation_errors'],[])
    def test_rating_kind_fields_are_observation_only(self):
        import native_worker
        fields={'RatingKind','AlbumRatingKind'};self.assertTrue(fields.issubset(native_worker.FIELDS));self.assertTrue(fields.isdisjoint(native_worker.SETTABLE))
    def container(self,plain,cap=102400):
        c=zlib.compress(plain,1);n=min(cap,len(c))&~15;body=AES.new(KEY,AES.MODE_ECB).encrypt(c[:n])+c[n:];h=bytearray(144);h[:4]=b'hdfm';h[4:8]=(144).to_bytes(4,'big');h[8:12]=(144+len(body)).to_bytes(4,'big');h[0x5c:0x60]=cap.to_bytes(4,'big');p=self.root/'sample.itl';p.write_bytes(h+body);return p,c
    def test_offline_encryption_boundary(self):
        plain=random.Random(19).randbytes(130001);p,c=self.container(plain);m,c2,p2=decode(p);self.assertEqual(c2,c);self.assertEqual(p2,plain);self.assertEqual(m['encrypted_bytes'],102400);self.assertGreater(m['clear_tail_bytes'],16)
    def test_reject_wrong_outer_size(self):
        p,_=self.container(b'msdh'+b'X'*100);b=bytearray(p.read_bytes());b[8:12]=(1).to_bytes(4,'big');p.write_bytes(b)
        with self.assertRaises(ValueError):decode(p)
    def trace(self,p,c,plain):
        trace=self.root/'trace';trace.mkdir();records=[]
        for seq,(side,data) in enumerate([('input',c),('output',plain)],1):
            name=f'{seq:06d}.bin';(trace/name).write_bytes(data);records.append({'seq':seq,'blob':name,'sha256':hashlib.sha256(data).hexdigest(),'message':{'payload':{'kind':'zlib','fn':'inflate','stream':'test-stream','side':side,'ret':1,'consumed':len(c),'produced':len(plain),'stack':['test+0x0']}}})
        (trace/'events.jsonl').write_text('\n'.join(json.dumps(r) for r in records),encoding='utf-8');return trace
    def test_exact_trace_match(self):
        plain=b'msdh'+bytes(range(256))*7;p,c=self.container(plain);t=self.trace(p,c,plain);result=analyze(t,[p]);self.assertEqual(result['matched_functions'],['inflate'])
    def test_blob_tamper_detected(self):
        plain=b'msdh'+b'X'*128;p,c=self.container(plain);t=self.trace(p,c,plain);(t/'000001.bin').write_bytes(b'wrong')
        with self.assertRaises(ValueError):groups(t)

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--scratch',type=pathlib.Path,required=True);a,rest=p.parse_known_args();a.scratch.mkdir(parents=True,exist_ok=True);EvidenceTests.scratch=a.scratch;unittest.main(argv=[sys.argv[0]]+rest)
