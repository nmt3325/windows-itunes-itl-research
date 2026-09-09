"""New assertions for DATES-001 and playlist-audit F1/F2; old red probes stay frozen."""
import copy
from datetime import datetime, timedelta, timezone
import pytest
from itlkit import Library, UnsupportedError, hfs_from_datetime, hfs_to_datetime
from itlkit.binary import put, uint
from itlkit.model import Node
from test_codec_tracks import profile


@pytest.mark.parametrize('offset',[-28800,0,32400])
@pytest.mark.parametrize('seconds,micros',[(-1,1),(-1,500000),(-1,999999),(-1,0),(-86400,0),(2**32,0),(2**32,1),(2**32,999999),(2**32+1,0)])
def test_signed_bounds_before_fraction_quantization(offset,seconds,micros):
    epoch=datetime(1904,1,1,tzinfo=timezone(timedelta(seconds=offset)))
    with pytest.raises(ValueError,match='outside the HFS'):
        hfs_from_datetime(epoch+timedelta(seconds=seconds,microseconds=micros))


@pytest.mark.parametrize('offset',[-28800,0,32400])
@pytest.mark.parametrize('seconds,micros',[(0,0),(0,999999),(1,0),(1,999999),(2082844800,123456),(2**32-1,0),(2**32-1,999999)])
def test_exact_nonnegative_quantization_preserves_wall_policy(offset,seconds,micros):
    epoch=datetime(1904,1,1,tzinfo=timezone(timedelta(seconds=offset)))
    value=epoch+timedelta(seconds=seconds,microseconds=micros)
    assert hfs_from_datetime(value)==seconds
    decoded=hfs_to_datetime(seconds,utc_offset_seconds=offset)
    assert decoded==(value.replace(microsecond=0) if seconds else None)


def ordinary(lib):
    return next(p for p in lib.playlists if p.is_plain)


def nested(lib):
    p=ordinary(lib);outer=p.items[0];inner=copy.deepcopy(outer)
    put(inner.header,16,9123);put(inner.header,24,2);put(inner.header,32,9124)
    put(inner.header,68,0xFF01234567891234,8);outer.children=[inner]
    return p


@pytest.mark.parametrize('operation',['delete','indexed','restore_target','restore_source'])
def test_retained_nested_items_refused_atomically(operation):
    lib=profile();source=profile((1,2,3))
    if operation=='restore_target':lib=profile((1,3))
    if operation=='restore_source':
        lib=profile((1,3));nested(source)
    else:nested(lib)
    before=lib.to_bytes();donor=source.to_bytes();held=lib.tracks[0].node;held_p=lib.playlists[0].node
    assert Library.from_bytes(before).to_bytes()==before
    with pytest.raises(UnsupportedError,match='playlist item'):
        if operation=='delete':lib.delete_track(lib.track(track_id=2).persistent_id)
        elif operation=='indexed':lib.tracks[0].set(album='No mutation')
        else:lib.add_track_from(source,source.track(track_id=2).persistent_id)
    assert lib.to_bytes()==before and source.to_bytes()==donor
    assert lib.tracks[0].node is held and lib.playlists[0].node is held_p


@pytest.mark.parametrize('shape',['extended','payload','unknown_field'])
def test_unrelated_unsupported_item_shape_blocks_track_delete(shape):
    lib=profile();item=ordinary(lib).items[0]
    if shape=='extended':item.header.extend(bytes(4));put(item.header,4,88)
    elif shape=='payload':item.children=None;item.payload=b'opaque'
    else:put(item.header,20,123)
    # An opaque item payload is not parseable; test in-memory preflight without
    # incorrectly requiring that malformed fixture to pass Library.to_bytes.
    from itlkit.model import serialize_sections
    before=serialize_sections(lib.sections)
    envelope=(lib.container.header,lib.container.payload)
    with pytest.raises(UnsupportedError,match='playlist item'):
        lib.delete_track(lib.track(track_id=2).persistent_id)
    assert serialize_sections(lib.sections)==before
    assert (lib.container.header,lib.container.payload)==envelope


def rule(p,code,payload):
    h=bytearray(24);h[:4]=b'mhoh';put(h,4,24);put(h,8,24+len(payload));put(h,12,code)
    p.node.children.append(Node(h,payload=payload))


@pytest.mark.parametrize('variant',['missing_donor','missing_target','kind','classification','rule102','rule103'])
def test_system_definition_guards_precede_candidate_mutation(variant,monkeypatch):
    target,source=profile((1,)),profile((1,2));tp,sp=ordinary(target),ordinary(source)
    put(tp.node.header,0x238,2561);put(sp.node.header,0x238,2561)
    if variant=='missing_donor':source._root(2).children.remove(sp.node)
    elif variant=='missing_target':target._root(2).children.remove(tp.node)
    elif variant=='kind':put(sp.node.header,0x238,2562)
    elif variant=='classification':put(sp.node.header,0x238,0)
    else:
        code=int(variant[4:]);rule(tp,code,b'original-rule');rule(sp,code,b'different-rule')
    a,b=target.to_bytes(),source.to_bytes();held=target.tracks[0].node
    import itlkit.trackops as ops
    def forbidden_allocator(*args,**kwargs):raise AssertionError('allocation occurred before definition guard')
    monkeypatch.setattr(ops,'Allocator',forbidden_allocator)
    with pytest.raises(UnsupportedError,match='playlist'):
        target.add_track_from(source,source.track(track_id=2).persistent_id)
    assert target.to_bytes()==a and source.to_bytes()==b and target.tracks[0].node is held


@pytest.mark.parametrize('code',[102,103])
def test_matching_opaque_system_rules_preserved_without_reinterpretation(code):
    target,source=profile((1,)),profile((1,2));tp,sp=ordinary(target),ordinary(source);pid=tp.persistent_id
    for p in (tp,sp):
        put(p.node.header,0x238,2561);rule(p,code,b'opaque-rule-DO-NOT-ZERO')
    metadata=[c.to_bytes() for c in tp.node.children if c.tag==b'mhoh'];old_items=[c.to_bytes() for c in tp.items]
    added=target.add_track_from(source,source.track(track_id=2).persistent_id)
    p=target.playlist(pid)
    assert uint(p.node.header,0x238)==2561
    assert [c.to_bytes() for c in p.node.children if c.tag==b'mhoh']==metadata
    assert [c.to_bytes() for c in p.items][:len(old_items)]==old_items
    assert added.track_id in next(p for p in target.playlists if p.is_master).track_ids


def test_unmatched_ordinary_policy_and_same_lineage_guard_remain():
    target,source=profile((1,)),profile((1,2));tp,sp=ordinary(target),ordinary(source);pid=tp.persistent_id;old=tp.node.to_bytes()
    source._root(2).children.remove(sp.node)
    target.add_track_from(source,source.track(track_id=2).persistent_id)
    assert target.playlist(pid).node.to_bytes()==old
    a,b=profile((1,)),profile((1,2));h=bytearray(b.container.header);put(h,0x34,b.persistent_id+1,8,endian='big');b.container.header=bytes(h);before=a.to_bytes()
    with pytest.raises(UnsupportedError,match='same library lineage'):a.add_track_from(b,b.track(track_id=2).persistent_id)
    assert a.to_bytes()==before
