from dataclasses import replace,FrozenInstanceError
import pytest
from test_graph_v2 import sample
from itlkit.graph import build_graph
from itlkit.identity import SnapshotKey,ScopedID,SourceBinding,ReservationAllocator,source_binding
from itlkit.errors import UnsupportedError


def allocator(**kwargs):return ReservationAllocator(build_graph(sample()),seed=20260910,**kwargs)


def test_exact_typed_operations_and_immutable_ledger():
    a=allocator();local=a.local('track.common');pid=a.persistent('track')
    pl=next(x for x in a._graphs[a.snapshot].owners if x.namespace=='playlist.pid')
    token=a.token(pl);atom=a.atom('L+0x178',None,'New title');ledger=a.freeze()
    assert (local.namespace,pid.namespace,token.namespace,atom.namespace)==('track.common_local','track.pid','item.order_token','pool:L+0x178')
    assert local.value!=token.value and atom.value==3
    assert a.freeze() is ledger
    with pytest.raises(FrozenInstanceError):ledger.entries=()
    with pytest.raises(FrozenInstanceError):ledger.entries[0].reserved_identity=None
    with pytest.raises(UnsupportedError):a.local('album')
    d=ledger.to_dict();d['entries']=();assert len(ledger.entries)==4


def test_deterministic_seed_and_distinct_namespace_reservations():
    a,b=allocator(),allocator()
    assert [a.persistent(k) for k in ('track','album','artist')]==[b.persistent(k) for k in ('track','album','artist')]
    assert a.freeze()==b.freeze()


@pytest.mark.parametrize('kind',['rank','item.order_token','master','file',True])
def test_invalid_local_kind_poisons_transaction(kind):
    a=allocator()
    with pytest.raises(UnsupportedError):a.local(kind)
    with pytest.raises(UnsupportedError):a.freeze()


def test_token_requires_typed_target_playlist():
    a=allocator()
    with pytest.raises(UnsupportedError):a.token(71)
    b=allocator();p=b.persistent('playlist');t=b.token(p)
    assert t.namespace=='item.order_token' and f'{p.value:016X}' in t.scope


def test_existing_file_master_pids_and_bool_refused():
    g=build_graph(sample())
    for value in [g.snapshot.file_pid,next(x.value for x in g.owners if x.namespace=='master.pid'),True,0,2**64]:
        a=ReservationAllocator(g,seed=1)
        with pytest.raises((ValueError,UnsupportedError)):a.persistent('track',value)


def test_source_binding_validated_and_same_binding_reuses_reservation():
    g=build_graph(sample());b=source_binding(g,'track:AACC000000000001',2)
    a=ReservationAllocator(g,seed=1);x=a.atom('L+0x178',b,'Different title');y=a.atom('L+0x178',b,'Different title')
    assert x==y and len(a.freeze().entries)==1
    z=ReservationAllocator(g,seed=1)
    with pytest.raises(UnsupportedError):z.atom('L+0x178',replace(b,wire_id=1234),'Different title')


def test_import_source_scope_and_retained_pid():
    g=build_graph(sample());s=build_graph(sample(file_pid=0x1111222233334444));a=ReservationAllocator(g,sources=(s,),seed=1)
    b=source_binding(s,'track:AACC000000000001',2)
    assert a.atom('L+0x178',b,'Foreign title').scope==g.snapshot.digest
    assert a.freeze().entries[0].old_identity.snapshot==s.snapshot


def test_forged_dict_or_opaque_graph_does_not_authorize_pool():
    g=build_graph(sample(opaque=True));a=ReservationAllocator(g,seed=1)
    with pytest.raises(UnsupportedError):a.atom('L+0x178',None,'No coverage')
    with pytest.raises(TypeError):ReservationAllocator(g.to_dict())


@pytest.mark.parametrize('value',['', 'nul\0text'])
def test_empty_or_nul_not_reference_only(value):
    a=allocator()
    with pytest.raises(UnsupportedError):a.atom('L+0x178',None,value)


def test_journal_retains_reserved_and_retired_ids():
    a=allocator();first=a.local('album');a.retire(first);journal=a.freeze()
    b=allocator(journal=journal);second=b.local('album')
    assert second.value>first.value and first in b.freeze().retired


def test_journal_different_lineage_or_mutable_refused():
    j=allocator().freeze();g=build_graph(sample(file_pid=0x1111222233334444))
    with pytest.raises(UnsupportedError):ReservationAllocator(g,journal=j)
    with pytest.raises(TypeError):allocator(journal=j.to_dict())


def test_small_dense_input_and_output_caps():
    a=allocator(max_dense_id=3);a.atom('L+0x178',None,'N')
    with pytest.raises(UnsupportedError):a.atom('L+0x178',None,'N2')
    with pytest.raises(UnsupportedError):allocator(max_dense_id=2)
    with pytest.raises(UnsupportedError):allocator(max_local_id=10)


def test_scan_and_reservation_budgets():
    a=allocator(max_scan_bytes=1)
    with pytest.raises(UnsupportedError):a.local('album')
    b=allocator(max_reservations=1);b.local('album')
    with pytest.raises(UnsupportedError):b.local('artist')


def test_freeze_never_uses_new_randomness(monkeypatch):
    a=allocator();a.persistent('track')
    monkeypatch.setattr('itlkit.identity.secrets.token_bytes',lambda n: (_ for _ in ()).throw(AssertionError('randomness after prepare')))
    first=a.freeze();assert a.freeze()==first


def test_reuse_at_exact_reservation_capacity_is_idempotent():
    a=allocator(max_reservations=1);first=a.atom('L+0x178',None,'Same')
    assert a.atom('L+0x178',None,'Same') is first
    assert len(a.freeze().entries)==1


def test_empty_unregistered_binding_cannot_be_a_typed_source():
    from itlkit.library import Library,set_text,text_nodes
    from itlkit.container import Container
    import hashlib
    lib=Library.from_bytes(sample());set_text(lib.tracks[0].node,12,'')
    wire=int.from_bytes(text_nodes(lib.tracks[0].node,12)[0].header[16:20],'little')
    payload=lib._sync();g=build_graph(Container(lib.container.header,payload).to_bytes())
    binding=SourceBinding(g.snapshot,'L+0x208',wire,hashlib.sha256(b'').hexdigest())
    a=ReservationAllocator(g,seed=1)
    with pytest.raises(UnsupportedError):a.atom('L+0x208',binding,'New Composer')
    with pytest.raises(UnsupportedError):a.freeze()
    assert all(not (e.owner=='track:AACC000000000001' and e.field=='12') for e in g.typed_edges)


@pytest.mark.parametrize('mutation',['consumer','capacity','namespace','old_identity','scope','snapshot','seed','duplicate'])
def test_nested_journal_validation(mutation):
    a=allocator();a.local('album');j=a.freeze();e=j.entries[0]
    if mutation=='consumer':e=replace(e,consumers=('valid',[]))
    if mutation=='capacity':e=replace(e,capacity_check=(('upper_bound',[]),))
    if mutation=='namespace':e=replace(e,namespace='playlist.pid')
    if mutation=='old_identity':e=replace(e,old_identity=[])
    if mutation=='scope':e=replace(e,scope='wrong',reserved_identity=replace(e.reserved_identity,scope='wrong'))
    j=replace(j,entries=(e,))
    if mutation=='snapshot':j=replace(j,snapshot='not a SnapshotKey')
    if mutation=='seed':j=replace(j,seed_commitment='not a digest')
    if mutation=='duplicate':j=replace(j,entries=j.entries*2)
    with pytest.raises((TypeError,ValueError,UnsupportedError)):allocator(journal=j)


def test_aggregate_planned_text_budget_and_cached_reuse():
    from test_graph_v2 import limits
    g=build_graph(sample(),limits=limits(max_text_bytes=1024));a=ReservationAllocator(g,seed=1)
    first=a.atom('L+0x178',None,'A'*400);assert a.atom('L+0x178',None,'A'*400)==first
    with pytest.raises(UnsupportedError):a.atom('L+0x1c0',None,'B'*400)
    with pytest.raises(UnsupportedError):a.freeze()


def test_requested_foreign_pid_preserved_with_distinct_snapshot_scope():
    from itlkit.library import Library
    from itlkit.binary import put
    from itlkit.container import Container
    lib=Library.from_bytes(sample(file_pid=0x1111222233334444));put(lib.tracks[0].node.header,0x80,0xDDEE333344445555,8)
    payload=lib._sync();source=build_graph(Container(lib.container.header,payload).to_bytes());target=build_graph(sample())
    old=next(i for i in source.owners if i.namespace=='track.pid' and i.value==0xDDEE333344445555)
    a=ReservationAllocator(target,sources=(source,),seed=1);new=a.persistent('track',old)
    assert new.value==old.value and new.scope==target.snapshot.digest and new.scope!=old.scope
    assert a.freeze().entries[0].old_identity==old


def test_journal_across_recompressed_snapshot_retains_exclusions():
    from itlkit.container import Container
    g=build_graph(sample());a=ReservationAllocator(g,seed=1);first=a.local('album');a.retire(first);j=a.freeze()
    h=build_graph(Container.from_bytes(sample()).to_bytes(rebuild=True,compression_level=1))
    b=ReservationAllocator(h,journal=j,seed=1);second=b.local('album')
    assert second.value>first.value and second.scope!=first.scope and first in b.freeze().retired


def test_secondary_imported_local_bound_is_checked_at_constructor():
    from itlkit.library import Library
    from itlkit.binary import put
    from itlkit.container import Container
    lib=Library.from_bytes(sample(secondary=True));put(lib._root(13).children[0].header,16,2000000)
    payload=lib._sync();source=build_graph(Container(lib.container.header,payload).to_bytes())
    with pytest.raises(UnsupportedError):ReservationAllocator(build_graph(sample()),sources=(source,),seed=1)


# G2 reconstruction: original f5 appended test bytes were not recovered.
# The original 8bd controls above remain unchanged. New counts require execution.
@pytest.mark.parametrize('seed,expected_pid,commitment',[
    (0,14018572941765490300,'66687aadf862bd776c8fc18b8e9f8e20089714856ee233b3902a591d0d5f2925'),
    (23,2639496911569222466,'4303ef0796bae63d9f52f7bf61ae2d37b57889452f2ad07bba769d90d354fe37'),
    (b'\x01',1450094673872726758,'4bf5122f344554c53bde2ebb8cd2b7e3d1600ad631c385a5d7cce23c7785459a'),
    (b'abc',15508038306727045170,'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad'),
])
def test_recovered_legacy_seed_ledger_vectors(seed,expected_pid,commitment):
    # Constants are the four records printed before f5's seed extension.
    g=build_graph(sample());a=ReservationAllocator(g,seed=seed)
    assert g.snapshot==SnapshotKey('9fe2150ff3513fb24ce0ffdad901d69ed00cdd6eb1c2b24fa3e220110f66a35e',18085326892210193156,'8672f37a772c82543c2ec676707cd30da29266db327711cca119df8988e39768')
    actual=a.persistent('track');j=a.freeze()
    assert actual==ScopedID('track.pid',g.snapshot.digest,expected_pid,8)
    assert j.snapshot==g.snapshot and j.seed_commitment==commitment and j.retired==()
    assert len(j.entries)==1
    e=j.entries[0]
    assert (e.namespace,e.scope,e.old_identity,e.reserved_identity,e.consumers,e.capacity_check)==('track.pid',g.snapshot.digest,None,actual,(),(('width',8),('probes',1)))


@pytest.mark.parametrize('text',['','abc','\u00e9','e\u0301','ITL4/\u7a2e/\U0001f3b5','a\0b'])
def test_reconstructed_text_seed_exact_encoding(text,monkeypatch):
    import hashlib
    from itlkit.identity import seed_from_text
    encoded=text.encode('utf-8','strict')
    expected=hashlib.sha256(b'itl.identity.text-seed.v1\0'+len(encoded).to_bytes(4,'big')+encoded).digest()
    assert seed_from_text(text)==expected
    def no_random(*args,**kwargs):raise AssertionError('explicit seed invoked RNG')
    monkeypatch.setattr('itlkit.identity.secrets.token_bytes',no_random)
    g=build_graph(sample());a=ReservationAllocator(g,seed=text);b=ReservationAllocator(g,seed=expected)
    assert [a.persistent(k) for k in ('track','album','artist')]==[b.persistent(k) for k in ('track','album','artist')]
    assert a.freeze()==b.freeze()
    assert a.freeze().seed_commitment==hashlib.sha256(expected).hexdigest()


@pytest.mark.parametrize('seed',[True,-1,2**256,b'',b'x'*65,1.5,[],{},'x'*4097,'\u00e9'*2049,'\ud800','\udfff'])
def test_reconstructed_invalid_seed_refuses(seed):
    with pytest.raises((TypeError,ValueError)):ReservationAllocator(build_graph(sample()),seed=seed)


@pytest.mark.parametrize('text',['x'*4096,'\u00e9'*2048,'\U0001f3b5'*1024])
def test_reconstructed_text_seed_exact_utf8_boundary(text):
    from itlkit.identity import seed_from_text
    assert len(text.encode('utf8'))==4096 and len(seed_from_text(text))==32
    with pytest.raises(ValueError):seed_from_text(text+'x')


def test_reconstructed_no_unicode_normalization_or_locale():
    from itlkit.identity import seed_from_text
    assert seed_from_text('\u00e9')!=seed_from_text('e\u0301')
    assert seed_from_text('')!=seed_from_text(' ')


def test_reconstructed_none_seed_drawn_once_before_freeze(monkeypatch):
    calls=[]
    def once(n):calls.append(n);return b'Q'*n
    monkeypatch.setattr('itlkit.identity.secrets.token_bytes',once)
    a=ReservationAllocator(build_graph(sample()));a.persistent('track');first=a.freeze()
    assert a.freeze() is first and calls==[32]


def test_reconstructed_mutable_old_identity_is_rejected_before_freeze():
    a=allocator();a.local('album');j=a.freeze();mutable={'mutable':[]}
    forged=replace(j,entries=(replace(j.entries[0],old_identity=mutable),))
    with pytest.raises(TypeError,match='old identity must be typed'):allocator(journal=forged)
    mutable['mutable'].append('changed')
    assert j.entries[0].old_identity is None


@pytest.mark.parametrize('width,value,kind',[(8,0xDADA444433332222,'track'),(4,0x00ABCDEF,'album')])
def test_reconstructed_trailer_occurrences_are_excluded_and_poison(width,value,kind):
    from itlkit.container import Container
    c=Container.from_bytes(sample());c.trailer=b'opaque'+value.to_bytes(width,'little')+b'end!!'
    g=build_graph(c.to_bytes(rebuild=True));a=ReservationAllocator(g,seed=1)
    if width==8:
        with pytest.raises(UnsupportedError,match='collides'):a.persistent(kind,value)
        with pytest.raises(UnsupportedError,match='poisoned'):a.freeze()
    else:
        # Direct occurrence query is a raw exclusion test, not a reservation grant.
        assert a._occurs(value,width)


def test_reconstructed_trailer_blocks_atom_coverage():
    from itlkit.container import Container
    c=Container.from_bytes(sample());c.trailer=b'opaque'
    a=ReservationAllocator(build_graph(c.to_bytes(rebuild=True)),seed=1)
    with pytest.raises(UnsupportedError,match='compression-trailer'):a.atom('L+0x178',None,'new')
    with pytest.raises(UnsupportedError,match='poisoned'):a.freeze()
