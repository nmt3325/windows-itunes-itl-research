"""Frozen-fixture fresh WAV constructor. EXPERIMENTAL; no native acceptance claim.

Only reports/add-constructor is writable. Requires the immutable 56309a worktree.
Not a same-lineage restore: the PCM bytes, media path and track/PIDs are new.
"""
from __future__ import annotations
import argparse, copy, hashlib, io, json, os, sys, wave
from datetime import datetime, timezone
from pathlib import Path

BASE_SHA = '56309a258d7b1aadea72738561d1d9fae2e30bc0'
BASES = {
 '003': ('003-three-tracks-reloaded', 'a93cbc94da00eb60d1f5a45ac70af55948d4ecbae2ea735744af04b7b46128e4'),
 '037': ('037-final-three-reloaded', '155e427ebaf820e177123c9787d878e1f6b655a5978db409ba742c8697675f81'),
}
TEMPLATE_PID = 'D018EAABC195E072'
MASTER_PID = '9751B29CECF5340B'
FILE_PID = 'D2F61BE0A69CA302'
AFFECTED = {MASTER_PID, '04E2F2CF5464E974', 'F799EAAF82E6D6D2'}
WHEN = datetime(2026, 9, 9, 14, 0, 0, tzinfo=timezone.utc)
OWN = Path(__file__).resolve().parent
ROOT = OWN.parents[1]
SOURCE = ROOT/'wt/add-constructor'
sys.path.insert(0, str(SOURCE))
from itlkit import Library
from itlkit.binary import uint, put
from itlkit.library import read_text, set_text, hfs_from_datetime
from itlkit.model import Node
from itlkit.operations import Allocator, require_simple_library, _item
from itlkit.trackops import _wave, _aux, _aux_profile, _check_item


def sha(data):
 return hashlib.sha256(data).hexdigest()


def describe(path):
 path = Path(path)
 data = path.read_bytes()
 return {'path': str(path), 'bytes': len(data), 'sha256': sha(data)}


def load_json(path):
 return json.loads(Path(path).read_text(encoding='utf-8-sig'))


def save(path, data):
 path = Path(path).resolve()
 if not path.is_relative_to(OWN):
  raise ValueError('write outside owned report directory')
 if not isinstance(data, bytes):
  data = (json.dumps(data, indent=2, ensure_ascii=True) + '\n').encode('utf-8')
 path.parent.mkdir(parents=True, exist_ok=True)
 if path.exists():
  if path.read_bytes() != data:
   raise FileExistsError(f'immutable output differs: {path}')
  return
 with path.open('xb') as f:
  f.write(data); f.flush(); os.fsync(f.fileno())


def pcm_bytes(case):
 # Integer-only deterministic triangular tone, peak <1% full scale, fade edges.
 period = 100 if case == '003' else 84
 frames = bytearray()
 for i in range(44100):
  j = i % period
  a = ((j if j < period//2 else period-j)*1024//period)-256
  fade = min(i, 44099-i, 441)
  value = a*fade//441
  frames.extend(value.to_bytes(2, 'little', signed=True))
 buf = io.BytesIO()
 with wave.open(buf, 'wb') as w:
  w.setnchannels(1); w.setsampwidth(2); w.setframerate(44100)
  w.writeframes(bytes(frames))
 result = buf.getvalue()
 assert len(result) == 88244
 return result


def generate_media(case):
 p = OWN/'media'/f'fresh-constructor-{case}.wav'
 existed = p.exists()
 save(p, pcm_bytes(case))
 if not existed:
  # Own media only; never change machine timezone/time or original media timestamps.
  os.utime(p, (WHEN.timestamp(), WHEN.timestamp()))
 if int(p.stat().st_mtime) != int(WHEN.timestamp()):
  raise ValueError('media modification time changed after construction')
 with wave.open(str(p), 'rb') as w:
  assert (w.getnchannels(), w.getsampwidth(), w.getframerate(), w.getnframes()) == (1, 2, 44100, 44100)
 return p


class StableAllocator(Allocator):
 def __init__(self, library, case):
  super().__init__(library)
  self.case, self.serial = case, 0
 def persistent(self, requested=None):
  if requested is None:
   self.serial += 1
   key = f'itl-add-constructor/v1/{self.case}/{self.serial}'.encode('ascii')
   requested = int.from_bytes(hashlib.sha256(key).digest()[:8], 'big')
  return super().persistent(requested)


def guard_template(track):
 _wave(track)
 if any(c.type_code == 1 for c in track.node.children):
  raise ValueError('opaque type-1 location object: constructor refuses, never rewrites/drops it')
 if [c.type_code for c in track.node.children] != [2, 6, 13, 11]:
  raise ValueError('constructor only supports the exact native blank-WAV text-only location template')
 if track.get('compilation') or track.get('album') or track.get('artist') or track.get('album_artist'):
  raise ValueError('nonblank grouping is outside this minimal construction case')
 if (track.get('file_size'), track.get('total_time'), track.get('sample_rate'), track.get('bit_rate')) != (88244, 1000, 44100, 705):
  raise ValueError('unverified WAV dimensions')
 if uint(track.node.header, 0x144) != 88244 or uint(track.node.header, 0x98) != 0x472c4400:
  raise ValueError('unverified duplicated-size/float-rate state')
 for c in track.node.children:
  if len(c.header) != 24 or uint(c.header, 20) or c.payload[8:16] != bytes(8) or len(c.payload) != 16+uint(c.payload, 4):
   raise ValueError('unverified string header/prefix/suffix')
  read_text(c)
 if sha(track.node.to_bytes()) != 'be529daf17c563d3d749c0657536431bd92c61aa864d5b241066ae44384c53ff':
  raise ValueError('template byte fingerprint differs from native003alpha')


def construct(base, template_lib, media, case):
 """Create an in-memory candidate; never alter either input model or file."""
 require_simple_library(base); require_simple_library(template_lib)
 if f'{base.persistent_id:016X}' != FILE_PID or len(base.tracks) != 3:
  raise ValueError('recipient is outside pinned three-track fixture profile')
 source = template_lib.track(persistent_id=TEMPLATE_PID)
 guard_template(source)
 if media.read_bytes() != pcm_bytes(case):
  raise ValueError('unverified synthetic media bytes/dimensions')
 path = str(media.resolve())
 if not path.isascii() or any(c in path for c in '%?#\x00\r\n'):
  raise ValueError('only ASCII unescaped local paths in this probe')
 if any(t.get('path') == path for t in base.tracks):
  raise ValueError('media already registered in recipient')
 candidate = copy.deepcopy(base)
 allocator = StableAllocator(candidate, case)
 new_aux = {}
 for section, field in [(9, 'album_id'), (11, 'artist_id')]:
  old = _aux(template_lib, section, source.get(field))
  _aux_profile(old, section)
  if old.children:
   raise ValueError('blank native album/artist object required')
  n = copy.deepcopy(old)
  local_id, pid = allocator.local(), allocator.persistent()
  put(n.header, 16, local_id); put(n.header, 20, pid, 8)
  candidate._root(section).children.append(n)
  new_aux[section] = {'local_id': local_id, 'persistent_id': f'{pid:016X}', 'raw_sha256': sha(n.to_bytes())}
 node = copy.deepcopy(source.node)
 tid, sid, pid = allocator.local(), allocator.local(), allocator.persistent()
 put(node.header, 0x10, tid); put(node.header, 0x1f4, sid); put(node.header, 0x80, pid, 8)
 put(node.header, 0xdc, new_aux[9]['local_id']); put(node.header, 0x1e0, new_aux[11]['local_id'])
 put(node.header, 0x20, hfs_from_datetime(WHEN)); put(node.header, 0x78, hfs_from_datetime(WHEN))
 # Explicit new Name: evidence-backed bit0 clear, not an unrated/unplayed edit.
 node.header[0x6d] &= 0xfe
 put(node.header, 0x290, 0)
 name = f'Fresh Constructed WAV {case}'
 set_text(node, 2, name)
 used_name_ids = {uint(c.header, 16) for t in candidate.tracks for c in t.node.children if c.type_code == 2}
 atom_id = next(i for i in range(1, 256) if i not in used_name_ids)
 put(next(c for c in node.children if c.type_code == 2).header, 16, atom_id)
 set_text(node, 13, path)
 set_text(node, 11, 'file://localhost/'+path.replace('\\', '/'))
 # path13 wire ID1 and FILE URL11 wire ID2 are per-file, not global string aliases.
 candidate._root(1).children.append(node)
 expected_rules = {f'{p.persistent_id:016X}': (p.is_master, uint(p.node.header, 0x238)) for p in candidate.playlists}
 for ppid, kind in [(MASTER_PID, 0), ('04E2F2CF5464E974', 16640), ('F799EAAF82E6D6D2', 1024)]:
  if ppid not in expected_rules or expected_rules[ppid][1] != kind:
   raise ValueError('unexpected master/system membership profile')
  p = candidate.playlist(ppid)
  if p.track_ids != [75,77,79]:
   raise ValueError('unexpected pinned membership; no generic smart-rule inference')
  for i in p.items:
   _check_item(i)
  p.node.children.append(_item(tid, allocator))
 data = candidate.to_bytes(rebuild=True)
 return data, {'new_track_pid': f'{pid:016X}', 'new_track_id': tid, 'new_secondary_id': sid,
               'new_name_atom_id': atom_id, 'new_aux': new_aux, 'name': name, 'path': path,
               'changed_playlist_pids': sorted(AFFECTED)}


def com_expectation(base_state, template_state, info):
 result = copy.deepcopy(base_state)
 result['track_count'] = 4
 result['library_persistent_id'] = MASTER_PID
 for t in result['tracks']:
  for f in ('TrackID','TrackDatabaseID','PlayOrderIndex'):
   t.pop(f, None)
 new = copy.deepcopy(next(t for t in template_state['tracks'] if t['persistent_id'] == TEMPLATE_PID))
 for f in ('TrackID','TrackDatabaseID','PlayOrderIndex'):
  new.pop(f, None)
 new.update({'persistent_id': info['new_track_pid'], 'Name': info['name'], 'Location': info['path'],
             'ModificationDate': WHEN.isoformat(), 'DateAdded': WHEN.isoformat(), 'Unplayed': True})
 result['tracks'].append(new)
 for p in result['playlists']:
  if p['persistent_id'] in AFFECTED:
   p['members'].append({'persistent_id': info['new_track_pid'], 'name': info['name']})
  for m in p.get('members', []):
   m.pop('play_order_index', None)
  p['membership_comparison'] = 'ordered' if p['persistent_id'] not in AFFECTED else 'exact_multiset'
 return result


def source_manifest():
 return [describe(p) for p in sorted((SOURCE/'itlkit').glob('*.py'))] + [describe(SOURCE/'docs/format.md')]


def build_case(case, template_lib, template_state):
 stem, expected_sha = BASES[case]
 bp = ROOT/'fixtures/dynamic/snapshots'/f'{stem}.itl'
 base_bytes = bp.read_bytes()
 if sha(base_bytes) != expected_sha:
  raise ValueError('pinned baseline SHA mismatch')
 b = Library.from_bytes(base_bytes)
 media = generate_media(case)
 data, info = construct(b, template_lib, media, case)
 assert data != base_bytes
 assert b.to_bytes() == base_bytes
 # A second independent build has deterministic bytes/IDs.
 again, info2 = construct(Library.from_bytes(base_bytes), template_lib, media, case)
 assert data == again and info == info2
 p = OWN/'candidates'/f'fresh-{case}-v1.itl'
 save(p, data)
 raw = Library.from_bytes(data)
 oracle_path = ROOT/'reports/dynamic/native-runs'/stem/'com.json'
 result_path = ROOT/'reports/dynamic/native-runs'/stem/'result.json'
 oracle = load_json(oracle_path)['after']
 native_provenance = load_json(result_path)
 assert native_provenance['fixture_sha256'] == expected_sha
 assert {t['persistent_id'] for t in oracle['tracks']} == {f'{t.persistent_id:016X}' for t in b.tracks}
 base_media = [describe(Path(t.get('path'))) for t in b.tracks]
 assert sha(media.read_bytes()) not in {m['sha256'] for m in base_media}
 expected = com_expectation(oracle, template_state, info)
 memberships = []
 id_to_pid = {t.track_id: f'{t.persistent_id:016X}' for t in raw.tracks}
 for pl in raw.playlists:
  memberships.append(pl.to_dict()|{'member_persistent_ids':[id_to_pid[i] for i in pl.track_ids],
                                   'special_kind_raw':uint(pl.node.header,0x238)})
 request = {
  'case_id': f'fresh-constructed-wav-{case}-v1', 'status':'offline_candidate_native_untested',
  'intended_operation':'Append genuinely new synthesized local PCM WAV, not restore an existing track record/PID/path.',
  'candidate':describe(p), 'baseline':describe(bp),
  'native_baseline_oracle':describe(oracle_path), 'native_baseline_provenance':describe(result_path),
  'template':{'source':describe(ROOT/'fixtures/dynamic/snapshots/003-three-tracks-reloaded.itl'), 'persistent_id':TEMPLATE_PID},
  'donor_track':None, 'new_media':describe(media)|{'mtime_utc':WHEN.isoformat(), 'pcm':{'channels':1,'sample_width':2,'sample_rate':44100,'frames':44100,'duration_ms':1000}},
  'old_media':base_media, 'construction':info,
  'expected_file_persistent_id':FILE_PID, 'expected_com_library_persistent_id':MASTER_PID,
  'expected_main_track_count':4, 'expected_serialized_track_count':4,
  'expected_raw_tracks_before_native':[t.to_dict() for t in raw.tracks],
  'expected_raw_playlists_before_native':memberships,
  'expected_com_all_passive_observations':expected,
  'native_observation_requirements':[
   'Hash candidate, baseline, template, every media before use. Test a copy; do not mutate producer files.',
   'Selected ITL, not AddFile/AddFolder/drag-import: enumerate all four unique persistent IDs, every listed expected field, old media and old metadata.',
   'Compare hdfm file identity independently of COM LibraryPlaylist/master identity; damaged or empty/new-library fallback is failure.',
   'Observe immediately and after passive wait; complete clean save/exit/restart twice and re-observe after each wait.',
   'Raw local IDs may renumber on native saves. Compare track/playlist persistent identities; capture local IDs, do not mistake renumbering for new identities.',
   'Master and Music membership exact multiset; ordinary playlist retains exact order. Raw Downloaded membership also required in saved ITL.',
   'Where audio subsystem permits, open/play new synthetic file at volume zero only AFTER passive acceptance; document unsupported playback separately.',
  ],
  'guard_and_byte_diff_rationale':[
   'Exact SHA-pinned synthetic003/037 recipients only. Template003alpha has no type1 location object: nothing opaque is removed or rewritten.',
   'Fresh compact local/PIDs for mith and blank miah/miih plus three mtph. No global find/replace and no cross-library identity spoof.',
   'Only new Name pool atom changed to unused small positive ID; kind atom unchanged; URL/path IDs remain per-file 2/1.',
   'Explicit Name clears only6d bit0 and resets290. Other six rank words retained as native blank metadata ranks, not reassigned as IDs.',
   'Audio dimensions equal template so file size including duplicate144, duration, integer/float sample rate and bit rate remain consistent.',
   'Both date fields explicit UTC HFS14:00 matching own media mtime. No global time settings altered.',
   'Old tracks, old aux objects, old playlist items/metadata, opaque sections are byte-identical. Only enclosing counts/lengths and new records differ.',
   'hdfm/mfdh3c constant6f and unresolved58 preserved. No guessed high-water update.',
  ],
  'known_unknowns':[
   'Native acceptance, delayed refresh and two-save survival are not established by any offline test.',
   'Unknown inherited fixed WAV flag bytes are bounded to the exact pinned template; no claim of arbitrary WAV/profile synthesis.',
   'No support for opaque type1 location data, non-ASCII/escaped URLs, moved files, other media sizes/rates/formats, store/cloud/history.',
   'Unresolved allocator high-water semantics and full rank-cache regeneration; native save may normalize IDs/ranks/blank aux objects.',
   'Raw system playlists not all exposed via COM; saved-byte membership observation is separate from COM coverage.',
  ]}
 return request


def main():
 ap=argparse.ArgumentParser(description=__doc__)
 ap.add_argument('--verify-existing',action='store_true',help='reconstruct in memory and compare frozen files (no candidate writes)')
 args=ap.parse_args()
 if not SOURCE.is_dir():
  raise RuntimeError('run from the assigned GHA report location')
 template_path=ROOT/'fixtures/dynamic/snapshots/003-three-tracks-reloaded.itl'
 template_bytes=template_path.read_bytes()
 assert sha(template_bytes)==BASES['003'][1]
 template=Library.from_bytes(template_bytes)
 oracle=load_json(ROOT/'reports/dynamic/native-runs/003-three-tracks-reloaded/com.json')['after']
 if args.verify_existing:
  for case in BASES:
   stem,h=BASES[case]
   b=ROOT/'fixtures/dynamic/snapshots'/f'{stem}.itl'
   assert sha(b.read_bytes())==h
   media=OWN/'media'/f'fresh-constructor-{case}.wav'
   data,_=construct(Library.read(b),template,media,case)
   assert data==(OWN/'candidates'/f'fresh-{case}-v1.itl').read_bytes()
   print('REPRODUCED',case,sha(data))
  return
 requests=[build_case(case,template,oracle) for case in BASES]
 donor_manifest=ROOT/'reports/dynamic/phase2/independent-donor32-manifest.json'
 donor=load_json(donor_manifest)
 donor_path=Path(donor['native_reload']['path'])
 assert sha(donor_path.read_bytes())==donor['native_reload']['sha256']
 # This independent donor is a negative provenance control, not a source of the new records.
 donor_lib=Library.read(donor_path)
 for case in requests:
  pid=case['construction']['new_track_pid']
  assert pid not in {f'{t.persistent_id:016X}' for t in donor_lib.tracks}
  assert case['new_media']['path'] not in {t.get('path') for t in donor_lib.tracks}
 manifest={'schema':'descriptive-native-requests/v1','task':'add-constructor','base_sha':BASE_SHA,
  'producer_scope':'reports/add-constructor only; no production edits/native processes',
  'independent_donor_negative_control':{'manifest':describe(donor_manifest),'library':describe(donor_path),'used_as_template':False},
  'source_files':source_manifest(),'cases':requests}
 save(OWN/'native-requests.json',manifest)
 save(OWN/'input-manifest.json',{'source_files':source_manifest(),'baselines':[r['baseline'] for r in requests],
  'template':requests[0]['template'],'native_oracles':[r['native_baseline_oracle'] for r in requests],
  'evidence':[describe(ROOT/'reports/static/phase2/findings.md'),describe(ROOT/'reports/static/phase3/findings.md')],
  'independent_donor_negative_control':manifest['independent_donor_negative_control']})
 print(json.dumps({'status':'candidates_built_native_untested','cases':[
  {'case_id':r['case_id'],'candidate':r['candidate'],'new_pid':r['construction']['new_track_pid']} for r in requests]},indent=2))

if __name__=='__main__':
 main()
