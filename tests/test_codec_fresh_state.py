"""Evidence-gated Name flag, explicit Unplayed, and fail-closed pool aliases."""
import copy
import pytest
from itlkit import Library,UnsupportedError
from itlkit.binary import uint,put
from itlkit.library import set_text,text_nodes
from itlkit.atoms import guard_text_changes,assert_pool_bindings
from test_codec_tracks import profile


@pytest.mark.parametrize('raw',[0,1,0xfe,0xff])
@pytest.mark.parametrize('name',['New Name','Caf\u00e9 \u00ff','\u65e5\u672c\u8a9e \U0001f9ea'])
def test_changed_nonempty_name_clears_only_refresh_low_bit(raw,name):
    lib=profile();t=lib.tracks[0];t.node.header[0x6d]=raw;t.node.header[0xee]=0
    put(t.node.header,0x290,1000);original=bytes(t.node.header)
    t.set(name=name)
    assert t.get('name_refresh_flag_raw')==raw&0xfe
    assert t.get('rating_aux_raw')==raw&0xfe  # backward-compatible raw alias, not rating
    assert t.get('unplayed') is True and t.get('played_flag_raw')==0
    assert uint(t.node.header,0x290)==1000 and uint(t.node.header,0x6c,1)==original[0x6c]
    assert {i for i,(a,b) in enumerate(zip(original,t.node.header)) if a!=b}<={0x6d}
    assert Library.from_bytes(lib.to_bytes()).tracks[0].get('name')==name


def test_noop_name_does_not_disable_default_refresh_or_change_bytes():
    lib=profile();t=lib.tracks[0];t.node.header[0x6d]=1;before=lib.to_bytes()
    t.set(name=t.get('name'));assert lib.to_bytes()==before
    t.set(play_count=7);assert t.get('unplayed') is True and t.get('name_refresh_flag_raw')==1


@pytest.mark.parametrize('raw',[0,1,0xfe,0xff])
@pytest.mark.parametrize('unplayed',[False,True])
def test_unplayed_is_explicit_independent_state_and_preserves_other_bits(raw,unplayed):
    lib=profile();t=lib.tracks[0];t.node.header[0x6d]=1;t.node.header[0xee]=raw
    t.set(play_count=7,rating=80);before=bytes(t.node.header)
    assert t.get('unplayed') is (not bool(raw&1))
    t.set(unplayed=unplayed)
    assert t.get('unplayed') is unplayed
    assert t.node.header[0xee]==(raw&0xfe if unplayed else raw|1)
    assert {i for i,(a,b) in enumerate(zip(before,t.node.header)) if a!=b}<={0xee}
    t.set(play_count=0);assert t.get('unplayed') is unplayed
    assert Library.from_bytes(lib.to_bytes()).tracks[0].get('unplayed') is unplayed


@pytest.mark.parametrize('bad',[0,1,None,'false',[],2.0])
def test_unplayed_invalid_values_fail_atomically(bad):
    lib=profile();before=lib.to_bytes()
    with pytest.raises(ValueError):lib.tracks[0].set(name='Not committed',unplayed=bad)
    assert lib.to_bytes()==before


def test_legacy_profile_does_not_gain_unverified_played_semantics():
    lib=profile();h=bytearray(lib.container.header);h[16]=9;h[17:27]=b'12.13.9.1\0';lib.container.header=bytes(h)
    t=lib.tracks[0];t.node.header[0x6d]=1;before=lib.to_bytes()
    with pytest.raises(UnsupportedError):t.get('unplayed')
    with pytest.raises(UnsupportedError):t.set(unplayed=False)
    assert lib.to_bytes()==before
    t.set(name='Legacy title');assert t.node.header[0x6d]==1


def test_state_changes_in_operation_json_and_read_only_raw_aliases():
    lib=profile();pid=lib.tracks[0].persistent_id
    lib.apply_operations([{'op':'set_track','persistent_id':f'{pid:016X}','fields':{'unplayed':False,'play_count':0}}])
    assert lib.track(persistent_id=pid).get('unplayed') is False
    for field in ('played_flag_raw','name_refresh_flag_raw','rating_aux_raw'):
        before=lib.to_bytes()
        with pytest.raises(UnsupportedError):lib.tracks[0].set(**{field:0})
        assert lib.to_bytes()==before


def atom(node,code,number):
    target=text_nodes(node,code)[0];put(target.header,16,number);return target


def test_shared_title_refuses_cow_and_preserves_every_other_occurrence():
    lib=profile();atom(lib.tracks[0].node,2,1);atom(lib.tracks[1].node,2,1)
    before=lib.to_bytes()
    with pytest.raises(UnsupportedError,match='COW'):lib.tracks[0].set(name='Different')
    assert lib.to_bytes()==before


def test_different_pool_id_and_playlist_local_pool_are_not_aliases():
    lib=profile();t=lib.tracks[0];atom(t.node,2,1)
    set_text(lib.tracks[1].node,5,'Genre');atom(lib.tracks[1].node,5,1)
    atom(lib.playlists[0].node,100,1)
    t.set(name='Independent')
    assert t.get('name')=='Independent' and lib.tracks[1].get('genre')=='Genre'


@pytest.mark.parametrize('owner_kind',['track','artist'])
def test_sort_composer_and_artist_index_aliases_are_not_missed(owner_kind):
    lib=profile();t=lib.tracks[0];set_text(t.node,32,'Shared sort');atom(t.node,32,9)
    if owner_kind=='track':other=lib.tracks[1].node;code=34
    else:other=lib._root(11).children[1];code=401
    set_text(other,code,'Shared sort');atom(other,code,9);before=lib.to_bytes()
    with pytest.raises(UnsupportedError,match='COW'):t.set(sort_artist='Changed')
    assert lib.to_bytes()==before


def test_absent_or_unkeyed_addition_to_explicit_pool_is_not_blanket_zeroed():
    lib=profile();atom(lib.tracks[1].node,4,5);before=lib.to_bytes()
    with pytest.raises(UnsupportedError,match='scoped allocation'):lib.tracks[0].set(composer='New composer')
    assert lib.to_bytes()==before


def test_conflicting_existing_binding_is_not_silently_reinterpreted():
    lib=profile();atom(lib.tracks[0].node,2,1);set_text(lib.tracks[1].node,2,'Different old');atom(lib.tracks[1].node,2,1)
    before=lib.to_bytes()  # raw inspection does not claim resolved atom semantics
    with pytest.raises(UnsupportedError,match='conflicting'):lib.tracks[2].set(name='New')
    assert lib.to_bytes()==before


def test_shared_album_artist_object_edit_is_conservatively_refused():
    lib=profile();a,b=lib.tracks[:2]
    for off in (0xdc,0x1e0):put(b.node.header,off,uint(a.node.header,off))
    set_text(b.node,3,a.get('album'));set_text(b.node,4,a.get('artist'));before=lib.to_bytes()
    with pytest.raises(UnsupportedError,match='shared album/artist'):a.set(album='Unsafe COW')
    assert lib.to_bytes()==before


def test_same_owner_unchanged_album_artist_alias_is_protected():
    lib=profile();t=lib.tracks[0];set_text(t.node,27,t.get('artist'));atom(t.node,4,5);atom(t.node,27,5)
    before=lib.to_bytes()
    with pytest.raises(UnsupportedError,match='COW'):t.set(artist='Display artist only')
    assert lib.to_bytes()==before


def test_known_domain_joint_guard_requires_consistent_replacements():
    lib=profile();a,b=lib.tracks[:2];atom(a.node,2,1);atom(b.node,2,1)
    guard_text_changes(lib,[(a.node,2,'Together'),(b.node,2,'Together')])
    with pytest.raises(UnsupportedError):guard_text_changes(lib,[(a.node,2,'One'),(b.node,2,'Two')])
    with pytest.raises(UnsupportedError,match='unknown pool'):guard_text_changes(lib,[(a.node,999,'unknown')])


def test_restoration_rejects_known_atom_collision_before_adoption():
    target,donor=profile((1,)),profile((2,))
    atom(target.tracks[0].node,2,1)
    set_text(donor.tracks[0].node,2,'Donor distinct title');atom(donor.tracks[0].node,2,1)
    a,b=target.to_bytes(),donor.to_bytes()
    with pytest.raises(UnsupportedError,match='conflicting'):
        target.add_track_from(donor,donor.tracks[0].persistent_id)
    assert target.to_bytes()==a and donor.to_bytes()==b
