"""Offline stdlib negative tests for the proposed strict delivery verifier."""
import hashlib,json,os,pathlib,tempfile,unittest
import verify_delivery_strict as verifier
class StrictDeliveryTests(unittest.TestCase):
 def setUp(self):
  base=os.environ.get('ITL_AUDIT_SCRATCH');pathlib.Path(base).mkdir(parents=True,exist_ok=True) if base else None
  self.tmp=tempfile.TemporaryDirectory(dir=base);self.root=pathlib.Path(self.tmp.name);self.data=b'example';(self.root/'sample.txt').write_bytes(self.data);self.row={'path':'sample.txt','bytes':len(self.data),'sha256':hashlib.sha256(self.data).hexdigest()}
 def tearDown(self):self.tmp.cleanup()
 def run_rows(self,rows):
  (self.root/'DELIVERY-MANIFEST.json').write_text(json.dumps(rows),encoding='utf-8');return verifier.verify(self.root)
 def test_valid_exact_set(self):self.assertTrue(self.run_rows([self.row])['ok'])
 def test_extra_file_rejected(self):
  (self.root/'extra.txt').write_bytes(b'synthetic extra');self.assertFalse(self.run_rows([self.row])['ok'])
 def test_changed_digest_rejected(self):self.assertFalse(self.run_rows([dict(self.row,sha256='0'*64)])['ok'])
 def test_changed_size_rejected(self):self.assertFalse(self.run_rows([dict(self.row,bytes=999)])['ok'])
 def test_missing_file_rejected(self):
  (self.root/'sample.txt').unlink();self.assertFalse(self.run_rows([self.row])['ok'])
 def test_exact_duplicate_rejected(self):self.assertFalse(self.run_rows([self.row,self.row])['ok'])
 def test_casefold_alias_rejected(self):self.assertFalse(self.run_rows([self.row,dict(self.row,path='SAMPLE.TXT')])['ok'])
 def test_traversal_rejected(self):self.assertFalse(self.run_rows([dict(self.row,path='../outside.txt')])['ok'])
 def test_drive_relative_rejected(self):self.assertFalse(self.run_rows([dict(self.row,path='C:outside.txt')])['ok'])
if __name__=='__main__':unittest.main(verbosity=2)