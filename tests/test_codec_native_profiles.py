"""Synthetic ABI regression tests plus optional native/COM fixture concordance."""
from datetime import datetime
import json
import os
from pathlib import Path
import pytest
from itlkit import Library,UnsupportedError,FormatError,hfs_from_datetime
from itlkit.binary import uint,put
from test_core_support import library_bytes


def test_rating_is_one_byte_and_counters_are_not_forced_mirrors():
    lib=Library.from_bytes(library_bytes());t=lib.tracks[0]
    put(t.node.header,0x6c,0x100);put(t.node.header,0x60,47);put(t.node.header,0x118,29)
    assert t.get('rating')==0 and t.get('rating_aux_raw')==1
    t.set(rating=80,play_count=71,skip_count=13)
    assert t.get('rating')==80 and t.get('rating_aux_raw')==1
    assert t.get('play_count_aux_raw')==47 and t.get('skip_count_aux_raw')==29
    assert Library.from_bytes(lib.to_bytes()).tracks[0].get('rating')==80
    with pytest.raises(UnsupportedError):t.set(play_count_aux_raw=0)


@pytest.mark.parametrize('operations',[[None],[1],['op'],[{'op':'set_track','track_id':1,'fields':None}],
                                      [{'op':'set_track','track_id':1,'fields':{},'unknown_key':1}]])
def test_malformed_operations_fail_without_partial_changes(operations):
    lib=Library.from_bytes(library_bytes());before=lib.to_bytes()
    with pytest.raises((ValueError,FormatError,UnsupportedError)):lib.apply_operations(operations)
    assert lib.to_bytes()==before


@pytest.mark.parametrize('doc',[[],None,'invalid',123])
def test_malformed_library_documents(doc):
    with pytest.raises(FormatError):Library.from_dict(doc)


NATIVE_ROOT=os.environ.get('ITLKIT_NATIVE_ROOT')
NATIVE_REPORTS=os.environ.get('ITLKIT_NATIVE_REPORTS')
SAMPLES=sorted(Path(NATIVE_ROOT).glob('*.itl')) if NATIVE_ROOT else []


@pytest.mark.parametrize('path',SAMPLES,ids=lambda p:p.name)
def test_native_byte_exact_and_com_values(path):
    lib=Library.read(path)
    assert lib.to_bytes()==path.read_bytes()
    rebuilt=Library.from_bytes(lib.to_bytes(rebuild=True))
    assert rebuilt.container.payload==lib.container.payload
    report=Path(NATIVE_REPORTS)/path.stem/'com.json' if NATIVE_REPORTS else None
    if report is None or not report.exists():return
    com=json.loads(report.read_text(encoding='utf-8-sig')).get('after')
    if not com:return
    assert lib.summary()['library_persistent_id']==com['library_persistent_id']
    assert len(lib.tracks)==com['track_count']
    fields={'name':'Name','artist':'Artist','album':'Album','album_artist':'AlbumArtist','comment':'Comment',
            'genre':'Genre','composer':'Composer','rating':'Rating','play_count':'PlayedCount','skip_count':'SkippedCount',
            'year':'Year','track_number':'TrackNumber','track_count':'TrackCount','disc_number':'DiscNumber','disc_count':'DiscCount',
            'bit_rate':'BitRate','file_size':'Size','track_id':'TrackDatabaseID',
            'sort_name':'SortName','sort_artist':'SortArtist','sort_album':'SortAlbum','sort_album_artist':'SortAlbumArtist'}
    for native in com['tracks']:
        track=lib.track(persistent_id=native['persistent_id'])
        for field,key in fields.items():
            if key not in native:continue
            value=track.get(field)
            if value is None and native[key]=='':value=''
            assert value==native[key],(path.name,field,value,native[key])
        for field,key in [('date_added','DateAdded'),('date_modified','ModificationDate'),('play_date','PlayedDate'),('skip_date','SkippedDate')]:
            if key not in native:continue
            expected=0 if native[key].startswith('1899-12-30') else hfs_from_datetime(datetime.fromisoformat(native[key]))
            assert track.get(field)==expected,(path.name,field,track.get(field),expected)
    for native in com['playlists']:
        playlist=lib.playlist(native['persistent_id'])
        if not playlist.is_master:assert playlist.name==native['name']
        observed=[f'{lib.track(track_id=tid).persistent_id:016X}' for tid in playlist.track_ids]
        expected=[m['persistent_id'] for m in sorted(native['members'],key=lambda m:m['play_order_index'])]
        # Raw order is distinct from master/system UI auto-sort (e.g. title changes).
        # User playlists in these fixtures use an explicit stored/manual order.
        if playlist.is_plain:
            assert observed==expected,(path.name,playlist.name,observed,expected)
        else:
            assert sorted(observed)==sorted(expected),(path.name,playlist.name,observed,expected)