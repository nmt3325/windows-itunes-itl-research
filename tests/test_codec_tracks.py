import copy
import pytest
from itlkit import Library,Node,UnsupportedError
from itlkit.binary import uint,put
from itlkit.library import set_text
from test_codec_playlists import make_library,MASTER,PL


def profile(ids=(1,2,3)):
    lib=make_library()
    lib._root(1).children=[t.node for t in lib.tracks if t.track_id in ids]
    for p in lib.playlists:
        p.node.children=[n for n in p.node.children if n.tag!=b'mtph' or uint(n.header,24) in ids]
    for section,tag,size in [(9,b'miah',88),(11,b'miih',100)]:
        lib._root(section).children=[]
        for i in ids:
            h=bytearray(size);h[:4]=tag;put(h,4,size);put(h,8,size)
            put(h,16,(100 if section==9 else 200)+i)
            put(h,20,(0xA001000000000000 if section==9 else 0xA002000000000000)+i,8)
            put(h,28,2)
            if section==9:put(h,40,0x2000)
            node=Node(h,children=[])
            if section==9:
                set_text(node,300,f'Album {i}');set_text(node,301,f'Artist {i}')
            else:set_text(node,400,f'Artist {i}')
            lib._root(section).children.append(node)
    for t in lib.tracks:
        i=t.track_id
        put(t.node.header,0x14,1);put(t.node.header,0x8c,1463899680);put(t.node.header,0x1f4,300+i)
        put(t.node.header,0xdc,100+i);put(t.node.header,0x1e0,200+i)
        set_text(t.node,6,'WAV audio file');set_text(t.node,11,f'file:///synthetic/{i}.wav')
        set_text(t.node,3,f'Album {i}');set_text(t.node,4,f'Artist {i}')
    return Library.from_bytes(lib.to_bytes())


def pid(lib,i):return lib.track(track_id=i).persistent_id


def test_restore_complete_track_and_its_objects_without_changing_donor():
    target,donor=profile((1,)),profile();donor_bytes=donor.to_bytes()
    p=pid(donor,2);before=target.to_bytes()
    restored=target.add_track_from(donor,p)
    assert restored.persistent_id==p and restored.get('name')=='Synthetic Track'
    assert restored.track_id!=donor.track(persistent_id=p).track_id
    assert len(target.tracks)==len(target._root(9).children)==len(target._root(11).children)==2
    assert set(target.playlist(MASTER).track_ids)=={t.track_id for t in target.tracks}
    assert donor.to_bytes()==donor_bytes and len(Library.from_bytes(before).tracks)==1
    again=Library.from_bytes(target.to_bytes())
    assert again.track(persistent_id=p).get('url')=='file:///synthetic/2.wav'
    with pytest.raises(ValueError):target.add_track_from(donor,p)


def test_delete_removes_memberships_and_only_orphaned_auxiliary_objects():
    lib=profile();target_pid=pid(lib,2)
    lib.delete_track(target_pid)
    assert len(lib.tracks)==2 and len(lib._root(9).children)==2 and len(lib._root(11).children)==2
    assert all(2 not in p.track_ids for p in lib.playlists)
    assert len(Library.from_bytes(lib.to_bytes()).tracks)==2
    with pytest.raises(ValueError):lib.track(persistent_id=target_pid)
    single=profile((1,));single.delete_track(pid(single,1))
    empty=Library.from_bytes(single.to_bytes())
    assert not empty.tracks and not empty._root(9).children and not empty._root(11).children


def test_indexed_edits_rebuild_references_reuse_equal_objects_and_gc_orphans():
    lib=profile();p1,p2=pid(lib,1),pid(lib,2)
    fields={'album':'Collection 日本語','artist':'Artist Ω','album_artist':'Album Artist 🎼'}
    lib.track(persistent_id=p1).set(**fields,name='New title',rating=60)
    t1=lib.track(persistent_id=p1)
    assert all(t1.get(k)==v for k,v in fields.items())
    assert t1.get('album_id')!=101 and t1.get('artist_id')!=201
    assert len(lib._root(9).children)==len(lib._root(11).children)==3
    lib.track(persistent_id=p2).set(**fields)
    t1,t2=lib.track(persistent_id=p1),lib.track(persistent_id=p2)
    assert t1.get('album_id')==t2.get('album_id') and t1.get('artist_id')==t2.get('artist_id')
    assert len(lib._root(9).children)==len(lib._root(11).children)==2
    lib.delete_track(p1)
    assert len(lib._root(9).children)==2 and len(lib._root(11).children)==2
    assert Library.from_bytes(lib.to_bytes()).track(persistent_id=p2).get('album_artist')==fields['album_artist']


def test_index_changes_are_atomic_even_with_invalid_other_fields():
    lib=profile();before=lib.to_bytes()
    with pytest.raises(ValueError):lib.tracks[0].set(artist='not committed',rating=999)
    assert lib.to_bytes()==before
    with pytest.raises(ValueError):lib.tracks[0].set(album_artist=None)
    assert lib.to_bytes()==before


def test_foreign_lineage_unknown_media_and_unknown_aux_fields_refused():
    donor=profile();target=profile((1,));p=pid(donor,2)
    h=bytearray(donor.container.header);h[52]^=1;donor.container.header=bytes(h)
    with pytest.raises(UnsupportedError,match='lineage'):target.add_track_from(donor,p)
    lib=profile();set_text(lib.tracks[0].node,6,'Unknown audio type')
    with pytest.raises(UnsupportedError):lib.delete_track(lib.tracks[0].persistent_id)
    lib=profile();put(lib._root(9).children[0].header,0x30,7)
    before=lib.to_bytes()
    with pytest.raises(UnsupportedError):lib.tracks[0].set(artist='Unknown dependent write')
    assert lib.to_bytes()==before


def test_stale_mutation_handles_fail_instead_of_silently_losing_edits():
    lib=profile();old_track=lib.tracks[0];old_playlist=lib.playlist(PL)
    lib.create_playlist('New')
    with pytest.raises(ValueError,match='stale'):old_track.set(name='silently lost')
    with pytest.raises(ValueError,match='stale'):old_playlist.rename('silently lost')


def test_delete_track_json_operation():
    lib=profile();p=pid(lib,2)
    lib.apply_operations([{'op':'delete_track','persistent_id':f'{p:016X}'}])
    assert len(lib.tracks)==2
    assert len(Library.from_dict(lib.to_dict()).tracks)==2