"""Synthetic structural regressions; these are not native acceptance trials."""
import argparse
import pathlib
import struct
import tempfile
import unittest
from native_saved_audit import profile, frames, text


def put(buf, offset, value, size=4, endian='little'):
    buf[offset:offset+size] = value.to_bytes(size, endian)


def record(tag, header, body=b''):
    b=bytearray(header); b[:4]=tag; put(b,4,header); put(b,8,header+len(body)); return b+body


def library(*, ref=7, album=9, track_pid=1, item_count=1, duplicate_item=False, list_count=1, mode=0, endian=1, outer_playlists=1):
    tr=record(b'mith',756); put(tr,16,7); put(tr,0x80,track_pid,8); put(tr,0xdc,album); put(tr,0x1e0,11)
    al=record(b'miah',28); put(al,16,9); put(al,20,100,8)
    ar=record(b'miih',28); put(ar,16,11); put(ar,20,101,8)
    items=[]
    for i in range(item_count):
        item=record(b'mtph',84); put(item,16,15 if duplicate_item else 15+i); put(item,0x18,ref); put(item,0x44,20 if duplicate_item else 20+i,8); items.append(item)
    pl=record(b'miph',3500,b''.join(items)); put(pl,16,item_count); put(pl,0x14,0x10000); put(pl,0x1b8,0xaa,8); put(pl,0xd40,13)
    sections=[]
    for kind,tag,children in [(1,b'mlth',[tr]),(9,b'mlah',[al]),(11,b'mlih',[ar]),(2,b'mlph',[pl])]:
        root=record(tag,16,b''.join(children)); put(root,8,list_count if kind==1 else len(children)); sec=record(b'msdh',96,root); put(sec,12,kind); sections.append(sec)
    raw=record(b'hdfm',144,b''.join(sections)); put(raw,4,144,endian='big'); put(raw,8,len(raw),endian='big'); put(raw,0x34,0x999,8,'big'); raw[0x41]=mode; raw[0x52]=endian
    for offset,value in [(0x44,1),(0x48,outer_playlists),(0x4c,1),(0x54,1)]:put(raw,offset,value,endian='big')
    return bytes(raw)


class SavedAuditTests(unittest.TestCase):
    def run_profile(self, data):
        with tempfile.TemporaryDirectory(dir=SCRATCH) as d:
            p=pathlib.Path(d)/'synthetic.itl'; p.write_bytes(data); return profile(p)
    def test_valid_graph(self):
        p=self.run_profile(library()); self.assertEqual(len(p['tracks']),1); self.assertEqual(p['playlists']['00000000000000AA']['member_pids'],['0000000000000001'])
    def test_truncation(self):
        with self.assertRaises(ValueError):self.run_profile(library()[:-1])
    def test_dangling_item(self):
        with self.assertRaises(ValueError):self.run_profile(library(ref=99))
    def test_dangling_album(self):
        with self.assertRaises(ValueError):self.run_profile(library(album=10))
    def test_zero_track_pid(self):
        with self.assertRaises(ValueError):self.run_profile(library(track_pid=0))
    def test_incomplete_master(self):
        with self.assertRaises(ValueError):self.run_profile(library(item_count=0))
    def test_duplicate_master_member(self):
        with self.assertRaises(ValueError):self.run_profile(library(item_count=2))
    def test_duplicate_item_identity(self):
        with self.assertRaises(ValueError):self.run_profile(library(item_count=2,duplicate_item=True))
    def test_wrong_list_count(self):
        with self.assertRaises(ValueError):self.run_profile(library(list_count=2))
    def test_wrong_outer_count(self):
        with self.assertRaises(ValueError):self.run_profile(library(outer_playlists=2))
    def test_unknown_encryption(self):
        with self.assertRaises(ValueError):self.run_profile(library(mode=3))
    def test_wrong_endian(self):
        with self.assertRaises(ValueError):self.run_profile(library(endian=0))
    def test_zero_record_length(self):
        with self.assertRaises(ValueError):frames(b'mith'+(12).to_bytes(4,'little')+bytes(4))
    def test_latin1_string(self):
        body=bytearray(16)+b'Caf\xe9'; put(body,0,3); put(body,4,4); rec=record(b'mhoh',24,body); put(rec,12,100); self.assertEqual(text(rec,24),'Caf\u00e9')
    def test_invalid_string_length(self):
        body=bytearray(16)+b'x'; put(body,0,3); put(body,4,2); rec=record(b'mhoh',24,body); put(rec,12,100)
        with self.assertRaises(ValueError):text(rec,24)


if __name__=='__main__':
    parser=argparse.ArgumentParser(); parser.add_argument('--scratch',type=pathlib.Path,required=True); args=parser.parse_args(); args.scratch.mkdir(parents=True,exist_ok=False); SCRATCH=str(args.scratch); unittest.main(argv=['saved_audit_selftest'],verbosity=2)
