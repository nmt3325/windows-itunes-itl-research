"""Independent-review regressions; offline only, no iTunes or COM calls."""
import copy
from datetime import datetime,timedelta,timezone
import errno
from pathlib import Path
import pytest
from itlkit import Library,Container,FormatError,UnsupportedError,hfs_from_datetime,hfs_to_datetime
from itlkit.binary import put,uint
from itlkit.library import text_nodes,read_text
from itlkit.model import serialize_sections
from itlkit.__main__ import main
from itlkit.operations import Allocator
from itlkit.trackops import _import_aux
from test_codec_tracks import profile,pid
from test_codec_playlists import PL,MASTER,pids
from test_codec_native_profiles import assert_com_concordance,COM_FIELDS,DATE_FIELDS
import itlkit.io as output


def bad_bytes(lib):
    container=copy.deepcopy(lib.container)
    container.payload=serialize_sections(lib.sections)
    return container.to_bytes(rebuild=True)


@pytest.mark.parametrize('section,code,field',[(9,300,'album'),(11,400,'artist')])
@pytest.mark.parametrize('extension',['suffix','header','prefix'])
@pytest.mark.parametrize('value',['','new longer value'])
def test_indexed_extensions_refused_without_byte_loss(section,code,field,extension,value):
    lib=profile();node=text_nodes(lib._root(section).children[0],code)[0]
    if extension=='suffix':node.payload+=b'REVIEW_UNKNOWN_SUFFIX'
    elif extension=='header':put(node.header,20,0x11223344)
    else:
        p=bytearray(node.payload);put(p,8,0x11223344);node.payload=bytes(p)
    before=lib.to_bytes();held=lib.tracks[0]
    with pytest.raises(UnsupportedError,match='unknown'):held.set(**{field:value})
    assert lib.to_bytes()==before and held.node is lib.tracks[0].node
    assert Container.from_bytes(before).payload==lib.container.payload


def test_unknown_aux_suffix_is_not_lost_by_equal_key_reuse_or_gc():
    lib=profile();old=lib._root(9).children[0];text_nodes(old,300)[0].payload+=b'OPAQUE'
    before=lib.to_bytes()
    with pytest.raises(UnsupportedError):lib.tracks[0].set(album='Album 2',artist='Artist 2')
    assert lib.to_bytes()==before
    with pytest.raises(UnsupportedError):lib.delete_track(pid(lib,1))
    assert lib.to_bytes()==before


@pytest.mark.parametrize('recreate',[False,True])
def test_stale_playlist_replace_cannot_target_current_or_reused_pid(recreate):
    lib=profile();held=lib.playlist(PL)
    if recreate:
        lib.delete_playlist(PL);lib.create_playlist('Replacement',persistent_id=PL,track_persistent_ids=pids(lib,[1,3]))
    else:lib.create_playlist('Separate transaction')
    before=lib.to_bytes()
    with pytest.raises(ValueError,match='stale'):held.replace_members(pids(lib,[2]))
    assert lib.to_bytes()==before
    current=lib.playlist(PL);current.replace_members(pids(lib,[2]))
    assert current.track_ids==[2]


@pytest.mark.parametrize('namespace',['album_pid','artist_pid','playlist_local','item_pid','item_local','secondary'])
@pytest.mark.parametrize('zero',[False,True])
def test_modeled_identity_namespaces_reject_zero_and_duplicates(namespace,zero):
    lib=profile()
    if namespace in ('album_pid','artist_pid'):
        nodes=lib._root(9 if namespace=='album_pid' else 11).children;off,size=20,8
    elif namespace=='playlist_local':nodes=[p.node for p in lib.playlists];off,size=0xd40,4
    elif namespace in ('item_pid','item_local'):
        nodes=lib.playlist(PL).items;off,size=(68,8) if namespace=='item_pid' else (16,4)
    else:nodes=[t.node for t in lib.tracks];off,size=0x1f4,4
    put(nodes[1].header,off,0 if zero else uint(nodes[0].header,off,size),size)
    raw=bad_bytes(lib)
    with pytest.raises(FormatError,match='zero or duplicate'):Library.from_bytes(raw)
    with pytest.raises(FormatError,match='zero or duplicate'):lib.to_bytes()


@pytest.mark.parametrize('reverse',[False,True])
def test_aux_import_rejects_ambiguous_first_or_later_conflicting_match(reverse):
    source,target=profile(),profile((2,3));album=source._root(9).children[0]
    equal=copy.deepcopy(album);put(equal.header,16,91001)
    conflict=target._root(9).children[0];put(conflict.header,20,uint(album.header,20,8),8)
    target._root(9).children.insert(0 if not reverse else len(target._root(9).children),equal)
    original=serialize_sections(target.sections)
    with pytest.raises(UnsupportedError,match='ambiguous'):
        _import_aux(target,source,9,uint(album.header,16),Allocator(target))
    assert serialize_sections(target.sections)==original
    with pytest.raises(FormatError):target.add_track_from(source,pid(source,1))
    assert serialize_sections(target.sections)==original


def test_identity_namespaces_are_not_global():
    lib=profile();value=lib._root(9).children[0].header[20:28]
    lib._root(11).children[0].header[20:28]=value
    assert Library.from_bytes(lib.to_bytes()).tracks
    # Item identities are scoped within a playlist; global aliases are still
    # conservatively inspected before a structural removal/replacement.
    lib.playlist(MASTER).items[0].header[68:76]=lib.playlist(PL).items[0].header[68:76]
    assert Library.from_bytes(lib.to_bytes()).playlists


@pytest.mark.parametrize('declared',[0,1,10,12,0xffffffff])
def test_outer_section_count_is_a_high_level_validation_boundary(declared,tmp_path):
    raw=bytearray(profile().to_bytes());put(raw,0x30,declared,endian='big')
    assert declared!=len(profile().sections)
    assert Container.from_bytes(raw).to_bytes()==raw
    with pytest.raises(FormatError,match='hdfm section'):Library.from_bytes(raw)
    source=tmp_path/'bad.itl';source.write_bytes(raw)
    assert main(['check',str(source)])==2


@pytest.mark.parametrize('region',['outer','section','list','metadata'])
@pytest.mark.parametrize('operation',['delete','replace'])
@pytest.mark.parametrize('encoding',['little','big','hex'])
def test_retained_header_and_metadata_pid_markers_refuse(region,operation,encoding):
    lib=profile();pl=lib.playlist(PL)
    value=PL if operation=='delete' else uint(pl.items[0].header,68,8)
    needle=f'{value:016X}'.encode() if encoding=='hex' else value.to_bytes(8,encoding)
    if region=='outer':
        h=bytearray(lib.container.header);h[0x70:0x70+len(needle)]=needle;lib.container.header=bytes(h)
    elif region=='section':
        h=next(s for s in lib.sections if s.section_type==2).header;h[0x50:0x50+len(needle)]=needle
    elif region=='list':lib._root(2).header[0x40:0x40+len(needle)]=needle
    else:
        # Put the marker in metadata retained by replacement, or the master
        # metadata retained by deleting the ordinary playlist.
        owner=pl if operation=='replace' else lib.playlist(MASTER)
        node=next(n for n in owner.node.children if n.type_code==105)
        b=bytearray(node.payload);b[80:80+len(needle)]=needle;node.payload=bytes(b)
    before=lib.to_bytes()
    with pytest.raises(UnsupportedError):
        if operation=='delete':lib.delete_playlist(PL)
        else:lib.replace_playlist_members(PL,pids(lib,[3]))
    assert lib.to_bytes()==before


def test_known_library_self_id_is_not_a_playlist_reference():
    lib=profile();h=bytearray(lib.container.header);put(h,0x34,PL,8,endian='big');lib.container.header=bytes(h)
    put(lib._root(16).header,0x34,PL,8)
    lib.delete_playlist(PL)
    assert not any(p.persistent_id==PL for p in lib.playlists)
    assert Library.from_bytes(lib.to_bytes()).persistent_id==PL


@pytest.mark.parametrize('value',[1,2,86400,2082844799,2082844800,0xffffffff])
@pytest.mark.parametrize('offset',[-43200,0,19800,32400,50400])
def test_hfs_full_uint32_domain_uses_wall_epoch_arithmetic(value,offset):
    expected=datetime(1904,1,1,tzinfo=timezone(timedelta(seconds=offset)))+timedelta(seconds=value)
    assert hfs_to_datetime(value,utc_offset_seconds=offset)==expected
    assert hfs_from_datetime(expected)==value


def test_hfs_zero_unset_and_boundaries():
    assert hfs_to_datetime(0,utc_offset_seconds=0) is None
    for bad in (-1,2**32,True,1.0):
        with pytest.raises(ValueError):hfs_to_datetime(bad,utc_offset_seconds=0)
    with pytest.raises(ValueError):hfs_from_datetime(datetime(1904,1,1))


def oracle_for(lib):
    tracks=[]
    for t in lib.tracks:
        row={'persistent_id':f'{t.persistent_id:016X}'}
        for field,key in COM_FIELDS.items():row[key]=t.get(field) if t.get(field) is not None else ''
        for key in DATE_FIELDS.values():row[key]='1899-12-30T00:00:00+00:00'
        tracks.append(row)
    playlists=[{'persistent_id':f'{p.persistent_id:016X}','name':p.name,
                'members':[{'persistent_id':f'{lib.track(track_id=tid).persistent_id:016X}','play_order_index':i+1} for i,tid in enumerate(p.track_ids)]} for p in lib.playlists]
    return {'library_persistent_id':lib.summary()['library_persistent_id'],'track_count':len(tracks),'tracks':tracks,'playlists':playlists}


@pytest.mark.parametrize('fault',['empty','missing_track','duplicate_track','missing_playlist','duplicate_playlist','missing_field','missing_members'])
def test_com_concordance_rejects_partial_or_duplicated_enumeration(fault):
    lib=profile();com=oracle_for(lib);assert_com_concordance(lib,com)
    if fault=='empty':com['tracks']=[];com['playlists']=[]
    elif fault=='missing_track':com['tracks'].pop()
    elif fault=='duplicate_track':com['tracks'][-1]=copy.deepcopy(com['tracks'][0])
    elif fault=='missing_playlist':com['playlists'].pop()
    elif fault=='duplicate_playlist':com['playlists'].append(copy.deepcopy(com['playlists'][0]))
    elif fault=='missing_field':com['tracks'][0].pop('Name')
    else:com['playlists'][0].pop('members')
    with pytest.raises(AssertionError):assert_com_concordance(lib,com)


def test_com_concordance_rejects_new_ordinary_playlist_but_exposes_nonplain_scope():
    lib=profile();com=oracle_for(lib);lib.create_playlist('Unexpected',persistent_id=0xCF01020304050607)
    with pytest.raises(AssertionError,match='ordinary/master'):assert_com_concordance(lib,com)
    lib=profile();com=oracle_for(lib)
    extra=copy.deepcopy(lib.playlist(PL).node);put(extra.header,0x1b8,0xCF01020304050607,8);put(extra.header,0xd40,9999);put(extra.header,0x238,7)
    lib._root(2).children.append(extra);lib=Library.from_bytes(lib.to_bytes())
    result=assert_com_concordance(lib,com)
    assert result['unrepresented_nonplain_count']==1


@pytest.mark.parametrize('stage',['write','short','flush','sync','publish'])
def test_exclusive_publish_failure_never_leaves_partial_destination(stage,tmp_path,monkeypatch):
    src=tmp_path/'source.itl';src.write_bytes(profile().to_bytes());raw=src.read_bytes();dst=tmp_path/'output.itl'
    if stage=='write':
        def failing(stream,data):stream.write(data[:73]);stream.flush();raise OSError(errno.ENOSPC,'injected')
        monkeypatch.setattr(output,'_write_payload',failing)
    elif stage in ('short','flush'):
        real=output.os.fdopen
        class Stream:
            def __init__(self,inner):self.inner=inner
            def __enter__(self):return self
            def __exit__(self,*exc):return self.inner.__exit__(*exc)
            def write(self,data):return self.inner.write(data[:73] if stage=='short' else data)
            def flush(self):raise OSError(errno.EIO,'injected flush')
            def fileno(self):return self.inner.fileno()
        monkeypatch.setattr(output.os,'fdopen',lambda *a,**k:Stream(real(*a,**k)))
    elif stage=='sync':monkeypatch.setattr(output.os,'fsync',lambda fd:(_ for _ in ()).throw(OSError(errno.EIO,'injected sync')))
    else:monkeypatch.setattr(output.os,'link',lambda *a,**k:(_ for _ in ()).throw(OSError(errno.EPERM,'no hard links')))
    assert main(['roundtrip',str(src),str(dst)])==2
    assert not dst.exists() and src.read_bytes()==raw
    assert sorted(p.name for p in tmp_path.iterdir())==['source.itl']


def test_exclusive_publication_commit_sees_complete_bytes_and_race_is_safe(tmp_path,monkeypatch):
    destination=tmp_path/'out';payload=b'x'*10007;real=output.os.link
    def publish(temporary,path):
        assert Path(temporary).read_bytes()==payload and not Path(path).exists()
        real(temporary,path)
    monkeypatch.setattr(output.os,'link',publish)
    output.write_new(destination,payload);assert destination.read_bytes()==payload
    with pytest.raises(FileExistsError):output.write_new(destination,b'replacement')
    destination.unlink()
    def race(temporary,path):Path(path).write_bytes(b'other writer');real(temporary,path)
    monkeypatch.setattr(output.os,'link',race)
    with pytest.raises(FileExistsError):output.write_new(destination,payload)
    assert destination.read_bytes()==b'other writer'
    assert [p.name for p in tmp_path.iterdir()]==['out']
