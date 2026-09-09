import copy
import pytest
from itlkit import Library,Node,UnsupportedError
from itlkit.binary import put,uint
from test_core_support import library_bytes,playlist,track

MASTER=0xF001000000000001
PL=0xF001000000000002


def make_library(*,master_only=False,opaque=None):
    playlists=[playlist([1,2,3],pid=MASTER,master=True)]
    if not master_only:playlists.append(playlist([1,2],pid=PL))
    lib=Library.from_bytes(library_bytes(tracks=[track(1),track(2),track(3)],playlists=playlists,opaque=opaque))
    lib._root(12).children=[]  # no global unknown references in this synthetic profile
    for i,p in enumerate(lib.playlists):
        put(p.node.header,0xd40,4+i)
        put(p.node.header,0x18,0x10001);put(p.node.header,0x1b4,0x008c0000)
        put(p.node.header,0x734,0x01000000)
        views=[]
        for code,size in [(105,1244),(105,1244),(108,220)]:
            h=bytearray(24);h[:4]=b'mhoh';put(h,4,24);put(h,8,size);put(h,12,code)
            views.append(Node(h,payload=bytes(size-24)))
        for j,item in enumerate(p.items):
            # Native item identities are distinct across these playlists.
            local=100+10*i+j
            put(item.header,16,local);put(item.header,32,local)
            put(item.header,68,0x9911000000000000+local,8)
        p.node.children=[p.node.children[0]]+views+p.items
    return Library.from_bytes(lib.to_bytes())


def pids(lib,tids):return [f'{lib.track(track_id=t).persistent_id:016X}' for t in tids]


def test_create_replace_delete_with_known_dependencies_and_counts():
    lib=make_library();original=lib.to_bytes();track_pids=pids(lib,[1,2,3])
    created=lib.create_playlist('新規 🎼',persistent_id=0xC0DE000000000001,track_persistent_ids=pids(lib,[3,1]))
    assert created.track_ids==[3,1] and created.is_plain
    new_pid=created.persistent_id
    again=Library.from_bytes(lib.to_bytes())
    assert len(again.playlists)==3 and len(again.tracks)==3
    assert again.playlist(new_pid).name=='新規 🎼'
    assert uint(again._root(16).header,0x48)==3
    assert int.from_bytes(again.container.header[0x48:0x4c],'big')==3
    old_items=[uint(n.header,68,8) for n in lib.playlist(PL).items]
    lib.replace_playlist_members(PL,pids(lib,[2,3,1,2]))
    assert lib.playlist(PL).track_ids==[2,3,1,2]
    assert not set(old_items)&{uint(n.header,68,8) for n in lib.playlist(PL).items}
    assert pids(lib,[1,2,3])==track_pids
    lib.delete_playlist(new_pid)
    assert len(Library.from_bytes(lib.to_bytes()).playlists)==2
    with pytest.raises(ValueError):lib.playlist(new_pid)
    assert Library.from_bytes(original).playlist(PL).track_ids==[1,2]


def test_create_from_master_only_native_view_template():
    lib=make_library(master_only=True)
    created=lib.create_playlist('First ordinary playlist')
    assert created.is_plain and not created.items
    created.replace_members(pids(lib,[1,3]))
    assert created.track_ids==[1,3]
    assert Library.from_bytes(lib.to_bytes()).playlist(created.persistent_id).track_ids==[1,3]


def test_unknown_structural_dependencies_fail_atomically():
    cases=[make_library(opaque=b'opaque unknown index'),make_library(),make_library()]
    put(cases[1].playlist(PL).node.header,0x100,3)
    put(cases[2].playlist(PL).items[0].header,0x28,99)
    for lib in cases:
        before=lib.to_bytes()
        with pytest.raises(UnsupportedError):lib.replace_playlist_members(PL,pids(lib,[3]))
        assert lib.to_bytes()==before
    lib=make_library()
    with pytest.raises(UnsupportedError):lib.delete_playlist(MASTER)
    with pytest.raises(UnsupportedError):lib.replace_playlist_members(MASTER,pids(lib,[3]))


def test_missing_track_and_duplicate_persistent_id_fail_atomically():
    lib=make_library();before=lib.to_bytes()
    with pytest.raises(ValueError):lib.replace_playlist_members(PL,['00000000000000FF'])
    with pytest.raises(ValueError):lib.create_playlist('duplicate',persistent_id=PL)
    assert lib.to_bytes()==before


def test_external_pid_reference_prevents_deletion():
    lib=make_library();h=bytearray(24);h[:4]=b'mhoh';put(h,4,24);put(h,12,517)
    lib._root(12).children.append(Node(h,payload=b'opaque'+PL.to_bytes(8,'little')))
    before=lib.to_bytes()
    with pytest.raises(UnsupportedError,match='referenced'):lib.delete_playlist(PL)
    assert lib.to_bytes()==before


def test_structural_json_operations_are_transactional():
    lib=make_library();pid='C0DE000000000002';members=pids(lib,[2,1])
    lib.apply_operations([{'op':'create_playlist','name':'JSON new','persistent_id':pid},
                          {'op':'replace_playlist_members','persistent_id':pid,'track_persistent_ids':members},
                          {'op':'rename_playlist','persistent_id':pid,'name':'JSON renamed'}])
    assert lib.playlist(pid).name=='JSON renamed' and lib.playlist(pid).track_ids==[2,1]
    before=lib.to_bytes()
    with pytest.raises(UnsupportedError):lib.apply_operations([{'op':'delete_playlist','persistent_id':pid},{'op':'not-supported'}])
    assert lib.to_bytes()==before
    lib.apply_operations([{'op':'delete_playlist','persistent_id':pid}])
    with pytest.raises(ValueError):lib.playlist(pid)