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


# New G2 adapter controls. These are NOT recovered f5 original test text.
def _g2_foreign_bytes():
    from itlkit.library import Library
    from itlkit.container import Container
    from itlkit.binary import put
    lib = Library.from_bytes(sample(file_pid=0x1111222233334444))
    put(lib.tracks[0].node.header, 0x80, 0xDDEE333344445555, 8)
    payload = lib._sync()
    return Container(lib.container.header, payload).to_bytes()


def _g2_mixed_journal():
    target = build_graph(sample()); source = build_graph(_g2_foreign_bytes())
    a = ReservationAllocator(target, sources=(source,), seed=23)
    old = next(i for i in source.owners if i.namespace == 'track.pid' and i.value == 0xDDEE333344445555)
    a.persistent('track', old)
    a.persistent('album')
    a.local('album')
    new_playlist = a.persistent('playlist')
    a.token(new_playlist)
    a.atom('L+0x208', source_binding(source, 'track:DDEE333344445555', 27), 'New Ensemble')
    return a, a.freeze(), target, source


def test_g2_real_canonical_mixed_sources_scopes_and_seed():
    import hashlib
    from itlkit import schema
    from itlkit.identity import to_canonical_ledger, validate_allocation_ledger
    a,j,t,s = _g2_mixed_journal()
    c = to_canonical_ledger(j, t.data, {'donor':s.data}, seed_material=a.seed_material)
    assert type(c) is schema.AllocationLedger and len(c.reservations) == 6
    assert c.snapshot.to_dict() == j.to_dict()['snapshot']
    assert c.sources['donor'].to_dict() == {'digest':s.snapshot.digest,'file_pid':s.snapshot.file_pid,'plain_digest':s.snapshot.plain_digest}
    old = c.reservations[0].old_identity
    assert type(old) is schema.ScopedID and old.scope == s.snapshot.digest
    assert c.reservations[0].scope == t.snapshot.digest and old.scope != t.snapshot.digest
    binding = c.reservations[-1].old_identity
    assert type(binding) is schema.SourceBinding and binding.snapshot.to_dict() == {'digest':s.snapshot.digest,'file_pid':s.snapshot.file_pid,'plain_digest':s.snapshot.plain_digest}
    assert c.reservations[-1].consumers == j.entries[-1].consumers
    assert len(c.reservations[-1].consumers) == 5
    assert c.reservations[4].scope.endswith('/playlist:'+f'{c.reservations[3].reserved_identity.value:016X}')
    assert c.seed_commitment == hashlib.sha256(a.seed_material).hexdigest() == j.seed_commitment
    checks = validate_allocation_ledger(j,t.data,{'donor':s.data},seed_material=a.seed_material)
    for row, check, original in zip(c.reservations,checks,j.entries):
        assert row.capacity_check['allocator_reported'] == dict(original.capacity_check)
        assert row.capacity_check['passed'] and row.capacity_check['semantic_permission'] is False
        assert check['seed_commitment_verified'] is True
    report = c.to_dict(); report['sources'].clear(); report['reservations'][-1]['consumers'].clear()
    assert 'donor' in c.sources and c.reservations[-1].consumers


@pytest.mark.parametrize('fault', ['source_digest','source_file_pid','source_plain','binding_value',
    'binding_wire','binding_pool','consumer','capacity','entry_scope','width','target_snapshot',
    'seed_digest','retirement','local_probe','pid_probe','generated_pid','unknown_namespace'])
def test_g2_canonical_independent_metadata_refusals(fault):
    from itlkit.identity import to_canonical_ledger
    from itlkit.errors import FormatError
    a,j,t,s = _g2_mixed_journal(); entries = list(j.entries); e = entries[-1]
    if fault == 'source_digest': e=replace(e,old_identity=replace(e.old_identity,snapshot=replace(s.snapshot,digest='0'*64)))
    elif fault == 'source_file_pid': e=replace(e,old_identity=replace(e.old_identity,snapshot=replace(s.snapshot,file_pid=s.snapshot.file_pid+1)))
    elif fault == 'source_plain': e=replace(e,old_identity=replace(e.old_identity,snapshot=replace(s.snapshot,plain_digest='0'*64)))
    elif fault == 'binding_value': e=replace(e,old_identity=replace(e.old_identity,value_digest='0'*64))
    elif fault == 'binding_wire': e=replace(e,old_identity=replace(e.old_identity,wire_id=60000))
    elif fault == 'binding_pool': e=replace(e,old_identity=replace(e.old_identity,pool='L+0x178'))
    elif fault == 'consumer': e=replace(e,consumers=e.consumers[:-1])
    elif fault == 'capacity': e=replace(e,capacity_check=(('upper_bound',65535),('dense_bytes',4)))
    elif fault == 'entry_scope': e=replace(e,scope=s.snapshot.digest)
    elif fault == 'width': e=replace(e,reserved_identity=replace(e.reserved_identity,width=8))
    elif fault == 'target_snapshot': j=replace(j,snapshot=replace(j.snapshot,file_pid=j.snapshot.file_pid+1))
    elif fault == 'seed_digest': j=replace(j,seed_commitment='0'*64)
    elif fault == 'retirement': j=replace(j,retired=(ScopedID('album.local',t.snapshot.digest,999999,4),))
    elif fault == 'local_probe': entries[2]=replace(entries[2],capacity_check=(('upper_bound',1000000),('probes',2)))
    elif fault == 'pid_probe': entries[1]=replace(entries[1],capacity_check=(('width',8),('probes',2)))
    elif fault == 'generated_pid': entries[1]=replace(entries[1],reserved_identity=replace(entries[1].reserved_identity,value=0x123456789ABCDEF1))
    elif fault == 'unknown_namespace': e=replace(e,namespace='bogus.local',reserved_identity=replace(e.reserved_identity,namespace='bogus.local'))
    entries[-1]=e; forged=replace(j,entries=tuple(entries))
    with pytest.raises((ValueError,TypeError,UnsupportedError,FormatError)):
        to_canonical_ledger(forged,t.data,{'donor':s.data},seed_material=a.seed_material)


@pytest.mark.parametrize('fault',['missing','changed','recompressed'])
def test_g2_canonical_source_bytes_are_not_substituted(fault):
    from itlkit.identity import to_canonical_ledger
    from itlkit.errors import FormatError
    from itlkit.container import Container
    a,j,t,s = _g2_mixed_journal()
    sources = {} if fault=='missing' else {'donor': sample(file_pid=0x4444555566667777) if fault=='changed' else Container.from_bytes(s.data).to_bytes(rebuild=True,compression_level=1)}
    with pytest.raises((ValueError,TypeError,UnsupportedError,FormatError)):
        to_canonical_ledger(j,t.data,sources,seed_material=a.seed_material)


def test_g2_canonical_history_recompression_keeps_complete_exclusion_prefix():
    from itlkit.identity import to_canonical_ledger
    from itlkit.container import Container
    from itlkit import schema
    a,j,t,s = _g2_mixed_journal()
    c1=to_canonical_ledger(j,t.data,{'donor':s.data},seed_material=a.seed_material)
    # Start a separate real transaction which retires a new reservation.
    g=build_graph(sample());first=ReservationAllocator(g,seed=7)
    local=first.local('album');first.retire(local);first.atom('L+0x178',None,'Reserved, not published')
    j1=first.freeze();h1=to_canonical_ledger(j1,g.data,seed_material=first.seed_material)
    raw2=Container.from_bytes(g.data).to_bytes(rebuild=True,compression_level=1)
    g2=build_graph(raw2);second=ReservationAllocator(g2,journal=j1,seed=8)
    local2=second.local('artist');second.persistent('album');j2=second.freeze()
    h2=to_canonical_ledger(j2,raw2,seed_material=second.seed_material,history=(h1,))
    assert local2.value>local.value and local2.scope!=local.scope
    assert h2.reservations[:len(h1.reservations)]==h1.reservations
    assert h2.retired==h1.retired and h2.history==(h1,)
    assert h2.seed_commitment==j2.seed_commitment and h2.history[0].seed_commitment==j1.seed_commitment
    # Historical foreign source provenance remains present without pretending its
    # old wire bytes are a current source or gaining new source membership.
    other=ReservationAllocator(g2,journal=j,seed=9);other.local('artist');j3=other.freeze()
    h3=to_canonical_ledger(j3,raw2,seed_material=other.seed_material,history=(c1,))
    assert not h3.sources and h3.history[0].sources['donor'].digest==s.snapshot.digest
    assert h3.reservations[:len(c1.reservations)]==c1.reservations
    assert type(h3.reservations[-2].old_identity) is schema.SourceBinding


@pytest.mark.parametrize('fault',['drop','reorder','alter','scope','retirement_drop','history_missing','lineage'])
def test_g2_history_cannot_lose_relabel_or_grant_exclusions(fault):
    from itlkit.identity import to_canonical_ledger
    from itlkit.container import Container
    from itlkit.errors import FormatError
    g=build_graph(sample());a=ReservationAllocator(g,seed=7)
    first=a.local('album');a.retire(first);a.persistent('album');j1=a.freeze()
    h1=to_canonical_ledger(j1,g.data,seed_material=a.seed_material)
    raw=Container.from_bytes(g.data).to_bytes(rebuild=True,compression_level=1)
    g2=build_graph(raw);b=ReservationAllocator(g2,journal=j1,seed=8);b.local('artist');j=b.freeze();history=(h1,)
    if fault=='drop': j=replace(j,entries=j.entries[1:])
    elif fault=='reorder': j=replace(j,entries=(j.entries[1],j.entries[0],j.entries[2]))
    elif fault=='alter': j=replace(j,entries=(replace(j.entries[0],capacity_check=(('upper_bound',1000000),('probes',2))),*j.entries[1:]))
    elif fault=='scope':
        e=j.entries[0];j=replace(j,entries=(replace(e,scope=g2.snapshot.digest,reserved_identity=replace(e.reserved_identity,scope=g2.snapshot.digest)),*j.entries[1:]))
    elif fault=='retirement_drop': j=replace(j,retired=())
    elif fault=='history_missing': history=()
    elif fault=='lineage': history=(replace(h1,snapshot=replace(h1.snapshot,file_pid=h1.snapshot.file_pid+1)),)
    with pytest.raises((ValueError,TypeError,UnsupportedError,FormatError)):
        to_canonical_ledger(j,raw,seed_material=b.seed_material,history=history)


def test_g2_empty_unregistered_source_and_trailer_do_not_grant_pool_membership():
    import hashlib
    from itlkit.identity import to_canonical_ledger
    from itlkit.library import Library,set_text,text_nodes
    from itlkit.container import Container
    from itlkit.errors import FormatError
    lib=Library.from_bytes(sample());set_text(lib.tracks[0].node,12,'');p=lib._sync();raw=Container(lib.container.header,p).to_bytes()
    g=build_graph(raw);a=ReservationAllocator(g,seed=1);a.atom('L+0x208',None,'New');j=a.freeze()
    row=next(r for r in g.to_dict()['strings'] if r['owner']=='track:AACC000000000001' and r['type']==12)
    old=SourceBinding(g.snapshot,'L+0x208',row['wire_id'],hashlib.sha256(b'').hexdigest())
    forged=replace(j,entries=(replace(j.entries[0],old_identity=old),))
    with pytest.raises((ValueError,TypeError,UnsupportedError,FormatError)):
        to_canonical_ledger(forged,raw,seed_material=a.seed_material)
    c=Container.from_bytes(sample());c.trailer=b'opaque'+(0xDADA444433332222).to_bytes(8,'little')+b'tail!'
    raw=c.to_bytes(rebuild=True);g=build_graph(raw);a=ReservationAllocator(g,seed=1)
    value=a.persistent('track');j=a.freeze()
    # A raw-backed identity diagnostic can retain the trailer and exclude its
    # bytes, but cannot turn that into COW/pool/native permission.
    out=to_canonical_ledger(j,raw,seed_material=a.seed_material)
    assert out.reservations[0].reserved_identity.value==value.value
    forged=replace(j,entries=(replace(j.entries[0],reserved_identity=replace(value,value=0xDADA444433332222)),))
    with pytest.raises((ValueError,TypeError,UnsupportedError,FormatError)):
        to_canonical_ledger(forged,raw,seed_material=a.seed_material,requested_pids=(forged.entries[0].reserved_identity,))


def test_g2_explicit_untyped_request_requires_explicit_mode_and_no_collision():
    from itlkit.identity import to_canonical_ledger
    g=build_graph(sample());a=ReservationAllocator(g,seed=23);p=a.persistent('track',0xDADA444433332222);j=a.freeze()
    with pytest.raises(UnsupportedError,match='seeded PID'):
        to_canonical_ledger(j,g.data,seed_material=a.seed_material)
    c=to_canonical_ledger(j,g.data,seed_material=a.seed_material,requested_pids=(p,))
    assert c.reservations[0].capacity_check['pid_mode']=='explicit-request'
    with pytest.raises((TypeError,UnsupportedError)):
        to_canonical_ledger(j,g.data,seed_material=a.seed_material,requested_pids=[p])


@pytest.mark.parametrize('limits_kw',[{'max_nodes':1},{'max_json_bytes':32},{'memory_budget_bytes':1024},{'max_file_bytes':10},{'max_text_bytes':1}])
def test_g2_canonical_bounds_before_metadata_acceptance(limits_kw):
    from itlkit.identity import to_canonical_ledger
    from itlkit.schema import ReadLimits
    from itlkit.errors import FormatError
    a,j,t,s = _g2_mixed_journal()
    with pytest.raises((ValueError,TypeError,UnsupportedError,FormatError)):
        to_canonical_ledger(j,t.data,{'donor':s.data},seed_material=a.seed_material,limits=ReadLimits(**limits_kw))


def test_g2_canonical_transport_does_not_allocate_or_encode_seed(monkeypatch):
    from itlkit.identity import to_canonical_ledger
    a,j,t,s = _g2_mixed_journal();material=a.seed_material
    def forbidden(*args,**kwargs): raise AssertionError('allocator/RNG/seed encoding during evidence validation')
    monkeypatch.setattr('itlkit.identity.ReservationAllocator',forbidden)
    monkeypatch.setattr('itlkit.identity.seed_from_text',forbidden)
    monkeypatch.setattr('itlkit.identity.secrets.token_bytes',forbidden)
    c=to_canonical_ledger(j,t.data,{'donor':s.data},seed_material=material)
    assert len(c.reservations)==len(j.entries)
    with pytest.raises(TypeError):to_canonical_ledger(j.to_dict(),t.data,{'donor':s.data},seed_material=material)
    with pytest.raises(TypeError):to_canonical_ledger(j,t.data,{'donor':s.data},seed_material=material,validate=lambda *a,**k: True)
