import copy
from datetime import datetime,timezone,timedelta
import json
import pytest
from itlkit import Library,Container,UnsupportedError,FormatError,hfs_from_datetime,hfs_to_datetime
from itlkit.binary import uint,put
from itlkit.library import read_text,text_nodes
from test_core_support import library_bytes,playlist,track,text,record,u32


def test_variable_length_unicode_and_number_edits_preserve_opaque_bytes():
    opaque=b'Unknown data: mith\x00msdh\x00'+bytes(range(256))
    source=library_bytes(opaque=opaque);lib=Library.from_bytes(source)
    t=lib.tracks[0];pid=t.persistent_id
    title='長い曲名 🎵 cafe\u0301 / mith / miph / msdh'*200
    t.set(name=title,genre='日本語',rating=100,play_count=123,skip_count=22,loved=True,year=2026,
          composer='作曲者',disc_number=2,disc_count=3,date_added=3850000000)
    result=lib.to_bytes();again=Library.from_bytes(result);t2=again.track(persistent_id=pid)
    assert t2.get('name')==title and t2.get('genre')=='日本語' and t2.get('rating')==100
    assert t2.get('play_count')==123 and uint(t2.node.header,0x60)==0
    assert t2.get('skip_count')==22 and uint(t2.node.header,0x118)==0
    assert uint(t2.node.header,0x2bc)==0x12008001
    assert again.sections[-1].payload==opaque
    assert Library.from_bytes(source).tracks[0].get('name')=='Synthetic Track'
    assert Container.from_bytes(result).header[136:144]==Container.from_bytes(source).header[136:144]
    assert len(text_nodes(t2.node,5))==1
    assert len(result)==int.from_bytes(result[8:12],'big')
    assert uint(again._root(16).header,8)==len(again.container.payload)+144
    t2.set(loved=False)
    assert uint(t2.node.header,0x2bc)==0x10008001


@pytest.mark.parametrize('field,value',[('rating',101),('rating',-1),('rating',True),('play_count',-1),
                                       ('skip_count',2**32),('disc_number',65536),('loved',1),('name','a\x00b')])
def test_invalid_values_are_transactionally_rejected(field,value):
    source=library_bytes();lib=Library.from_bytes(source)
    with pytest.raises((ValueError,UnsupportedError)):lib.tracks[0].set(**{'name':'first edit',field:value})
    assert lib.to_bytes()==source


@pytest.mark.parametrize('field,value',[('artist','new'),('album','new'),('album_artist','new'),
                                      ('track_id',5),('persistent_id',55),('unknown',1)])
def test_unknown_dependencies_and_identity_writes_refused(field,value):
    lib=Library.from_bytes(library_bytes());before=lib.to_bytes()
    with pytest.raises(UnsupportedError):lib.tracks[0].set(**{field:value})
    assert lib.to_bytes()==before


def test_url_encoding_and_unknown_string_suffix():
    lib=Library.from_bytes(library_bytes()); t=lib.tracks[0]
    with pytest.raises(ValueError):t.set(url='file:///日本語')
    t.set(url='file:///music/%E6%97%A5.wav');assert t.get('url').startswith('file:///music')
    node=text_nodes(t.node,2)[0];node.payload+=b'unknown'
    before=node.payload
    with pytest.raises(UnsupportedError):t.set(name='different length')
    assert node.payload==before


def test_invalid_encoding_and_string_length():
    lib=Library.from_bytes(library_bytes());node=text_nodes(lib.tracks[0].node,2)[0]
    for off,val in [(0,99),(4,999999)]:
        candidate=copy.deepcopy(node);p=bytearray(candidate.payload);put(p,off,val);candidate.payload=bytes(p)
        with pytest.raises((FormatError,UnsupportedError)):read_text(candidate)


def test_playlist_read_and_rename():
    lib=Library.from_bytes(library_bytes());pl=lib.playlists[0]
    assert pl.persistent_id==0xBEEF000000000001 and pl.track_ids==[1] and pl.is_plain
    pl.rename('日本語のプレイリスト 🎶')
    assert Library.from_bytes(lib.to_bytes()).playlists[0].name=='日本語のプレイリスト 🎶'
    for flag in ['smart','master']:
        other=Library.from_bytes(library_bytes(playlists=[playlist([1],**{flag:True})]))
        with pytest.raises(UnsupportedError):other.playlists[0].rename('Unsafe')


def test_json_operations_and_atomic_failure():
    source=library_bytes();doc=Library.from_bytes(source).to_dict()
    assert Library.from_dict(json.loads(json.dumps(doc))).to_bytes()==source
    doc['operations']=[{'op':'set_track','track_id':1,'fields':{'name':'JSON changed','rating':80}}]
    lib=Library.from_dict(doc);assert Library.from_bytes(lib.to_bytes()).tracks[0].get('name')=='JSON changed'
    before=lib.to_bytes()
    with pytest.raises(UnsupportedError):lib.apply_operations([{'op':'set_track','track_id':1,'fields':{'name':'not committed'}},{'op':'delete_unimplemented'}])
    assert lib.to_bytes()==before
    doc=Library.from_bytes(source).to_dict();doc['sections'][-1]['children'][0]['children'][0]['header_hex']='0'*7000
    with pytest.raises((UnsupportedError,FormatError)):Library.from_dict(doc)


def test_unsupported_profiles_and_unknown_trailers_refuse_mutation():
    for special in ['version','trailer']:
        c=Container.from_bytes(library_bytes(trailer=b'unknown' if special=='trailer' else b''))
        if special=='version':
            h=bytearray(c.header);h[17:27]=b'99.99.99.9';c.header=bytes(h)
        lib=Library.from_bytes(c.to_bytes())
        with pytest.raises(UnsupportedError):lib.tracks[0].set(rating=40)


def test_hfs_time_requires_explicit_zone():
    dt=datetime(2026,1,2,3,4,5,tzinfo=timezone(timedelta(hours=9)))
    encoded=hfs_from_datetime(dt)
    assert hfs_to_datetime(encoded,utc_offset_seconds=9*3600)==dt
    assert hfs_to_datetime(0,utc_offset_seconds=0) is None
    with pytest.raises(ValueError):hfs_from_datetime(datetime(2026,1,1))
    with pytest.raises(ValueError):hfs_to_datetime(-1,utc_offset_seconds=0)