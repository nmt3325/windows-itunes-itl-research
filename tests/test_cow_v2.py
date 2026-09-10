from dataclasses import replace
import copy
import importlib.util
import pytest
from test_graph_v2 import sample
from itlkit import Library
from itlkit.binary import uint,put
from itlkit.container import Container
from itlkit.graph import build_graph
from itlkit.cow import prepare,BlockedCOW,_prepare_candidate,_validate_candidate,_Candidate
from itlkit.errors import UnsupportedError

PID='AACC000000000001'
def intent(**fields):return {'track_pid':PID,'fields':fields}
def encode(lib):
    payload=lib._sync();return Container(lib.container.header,payload,lib.container.trailer).to_bytes()


@pytest.mark.parametrize('field,albums,artists',[('name',1,1),('artist',1,1),('composer',1,1),('comment',1,1),('album',2,1),('album_artist',2,2)])
def test_real_pure_cow_and_exact_peer_preservation(field,albums,artists):
    original=sample();before=build_graph(original).to_dict()
    result=_prepare_candidate(original,intent(**{field:'Independent Omega \u03a9'}),seed=9)
    assert type(result) is _Candidate and _validate_candidate(result)
    after=build_graph(result.candidate_bytes).to_dict()
    assert len(after['albums'])==albums and len(after['artists'])==artists
    assert before['tracks'][1]['record_sha256']==after['tracks'][1]['record_sha256']
    assert before['albums'][0]['record_sha256']==after['albums'][0]['record_sha256']
    assert before['artists'][0]['record_sha256']==after['artists'][0]['record_sha256']
    assert result.baseline==original


def test_empty_same_value_is_noop_but_clear_transition_blocks():
    assert _prepare_candidate(sample(),intent(comment=''),seed=1).candidate_bytes==sample()
    assert type(_prepare_candidate(sample(),intent(name=''),seed=1)) is BlockedCOW


def test_seeded_prepare_deterministic_and_validation_has_no_randomness(monkeypatch):
    first=_prepare_candidate(sample(),intent(album_artist='New Ensemble'),seed=3)
    second=_prepare_candidate(sample(),intent(album_artist='New Ensemble'),seed=3)
    assert first==second
    monkeypatch.setattr('itlkit.identity.secrets.token_bytes',lambda n:(_ for _ in ()).throw(AssertionError('random after prepare')))
    assert _validate_candidate(first)


def test_name_refresh_does_not_change_unplayed_or_sort_rank():
    lib=Library.from_bytes(sample());node=lib.tracks[0].node;node.header[0x6d]=0x83;node.header[0xee]=0x5a
    for off in range(0x290,0x2ac,4):put(node.header,off,5000+off)
    baseline=encode(lib);result=_prepare_candidate(baseline,intent(name='Renamed'),seed=5)
    after=Library.from_bytes(result.candidate_bytes).tracks[0].node
    assert after.header[0x6d]==0x82 and after.header[0xee]==0x5a
    assert after.header[0x290:0x2ac]==node.header[0x290:0x2ac]


def test_unrelated_unknown_orphan_is_retained_not_gc():
    lib=Library.from_bytes(sample());orphan=copy.deepcopy(lib._root(9).children[0]);put(orphan.header,16,500);put(orphan.header,20,0xBBBB000000000002,8);put(orphan.header,84,0xDEADBEEF)
    lib._root(9).children.append(orphan);raw=encode(lib);old_bytes=Library.from_bytes(raw)._root(9).children[1].to_bytes()
    result=_prepare_candidate(raw,intent(album='New Album'),seed=6)
    assert Library.from_bytes(result.candidate_bytes)._root(9).children[1].to_bytes()==old_bytes
    assert len(Library.from_bytes(result.candidate_bytes)._root(9).children)==3


@pytest.mark.parametrize('bad',[{}, {'track_pid':PID,'fields':{'rating':10}}, {'track_pid':PID,'fields':{'name':'ok'},'extra':True}, {'track_pid':PID.lower(),'fields':{'name':'bad'}}, {'track_pid':PID,'fields':{'name':True}}])
def test_intent_refusals_before_mutation(bad):
    with pytest.raises((ValueError,TypeError)):_prepare_candidate(sample(),bad)


def test_native_opaque_dependencies_do_not_become_authority():
    result=_prepare_candidate(sample(opaque=True),intent(name='New'),seed=1)
    assert type(result) is BlockedCOW and any('section:250' in x for x in result.blockers)


def test_target_and_peer_tampering_caught():
    result=_prepare_candidate(sample(),intent(album='New'),seed=1)
    lib=Library.from_bytes(result.candidate_bytes);lib.tracks[1].node.header[0xee]^=1
    assert not _validate_candidate(replace(result,candidate_bytes=encode(lib)))
    lib=Library.from_bytes(result.candidate_bytes);lib.tracks[0].node.header[0xee]^=1
    assert not _validate_candidate(replace(result,candidate_bytes=encode(lib)))


def test_erasing_old_shared_auxiliary_caught():
    result=_prepare_candidate(sample(),intent(album='New'),seed=1)
    lib=Library.from_bytes(result.candidate_bytes);lib._root(9).children.pop(0)
    assert not _validate_candidate(replace(result,candidate_bytes=encode(lib)))


def test_fake_patch_and_unused_reservation_caught():
    result=_prepare_candidate(sample(),intent(name='New'),seed=1)
    patch=replace(result.text_patches[0],value='Not the intent')
    assert not _validate_candidate(replace(result,text_patches=(patch,)))


def test_missing_dependency_is_a_block_not_an_unverified_stub():
    if importlib.util.find_spec('itlkit.schema') is not None:pytest.skip('real codec dependency now present; covered by integrated test')
    result=prepare(sample(),intent(name='New'),seed=1)
    assert type(result) is BlockedCOW and 'codec_schema_planning_dependency_missing' in result.blockers


@pytest.mark.skipif(importlib.util.find_spec('itlkit.schema') is None,reason='real codec dependency not yet integrated; NOT a passing stub')
def test_real_shared_prepare_apply_and_stale_refusal(monkeypatch):
    from itlkit.planning import apply,PreparedMutation
    from itlkit.schema import ReadLimits
    result=prepare(sample(),intent(album_artist='New Ensemble'),seed=3,limits=ReadLimits())
    assert type(result) is PreparedMutation
    target=Library.from_bytes(sample());monkeypatch.setattr('itlkit.identity.secrets.token_bytes',lambda n:(_ for _ in ()).throw(AssertionError('random after prepare')))
    apply(target,result);assert target.to_bytes()==result.candidate_bytes
    from itlkit.errors import FormatError
    with pytest.raises(FormatError):apply(target,result)


def test_empty_unregistered_text_can_be_replaced_with_fresh_binding():
    from itlkit.library import set_text
    lib=Library.from_bytes(sample());set_text(lib.tracks[0].node,12,'');raw=encode(lib)
    result=_prepare_candidate(raw,intent(composer='New Composer'),seed=1)
    assert type(result) is _Candidate and _validate_candidate(result)
    assert result.journal.entries[0].old_identity is None


def test_noncanonical_empty_text_is_not_promoted_to_consumer():
    from itlkit.library import set_text,text_nodes
    lib=Library.from_bytes(sample());set_text(lib.tracks[0].node,12,'');put(text_nodes(lib.tracks[0].node,12)[0].header,20,1)
    result=_prepare_candidate(encode(lib),intent(composer='New Composer'),seed=1)
    assert type(result) is BlockedCOW



def test_cow_trailer_changed_intent_blocks_without_repair_or_fallback():
    from itlkit.schema import ProfileReport
    from itlkit.planning import apply
    c=Container.from_bytes(sample());c.trailer=b'opaque trailer';raw=c.to_bytes(rebuild=True)
    target=Library.from_bytes(raw);before=copy.deepcopy(target.__dict__)
    result=prepare(raw,intent(name='Changed'),seed=1)
    assert type(result) is ProfileReport and result.blocked
    assert any('trailer' in b.message for b in result.blockers)
    with pytest.raises(TypeError):apply(target,result)
    assert target.__dict__==before
    assert _prepare_candidate(raw,intent(comment=''),seed=1).candidate_bytes==raw


def test_cow_intent_json_budget_precedes_full_encoding(monkeypatch):
    from itlkit.schema import ReadLimits
    def forbidden(*args,**kwargs):raise AssertionError('intent encoded before budget check')
    monkeypatch.setattr('itlkit.graph.json.JSONEncoder.iterencode',forbidden)
    with pytest.raises(UnsupportedError,match='intent JSON budget'):prepare(sample(),intent(name='x'*500),limits=ReadLimits(max_json_bytes=32),seed=1)


@pytest.mark.parametrize('fault',['source_digest','source_snapshot','consumer','capacity','entry_scope','seed_format','retired'])
def test_independent_cow_validator_checks_complete_metadata(fault):
    q=_prepare_candidate(sample(),intent(name='ScopeCheck'),seed=23);j=q.journal;e=j.entries[0]
    if fault=='source_digest':e=replace(e,old_identity=replace(e.old_identity,value_digest='0'*64))
    elif fault=='source_snapshot':e=replace(e,old_identity=replace(e.old_identity,snapshot=replace(e.old_identity.snapshot,file_pid=e.old_identity.snapshot.file_pid+1)))
    elif fault=='consumer':e=replace(e,consumers=('invented-consumer',))
    elif fault=='capacity':e=replace(e,capacity_check=(('upper_bound',1),('dense_bytes',1)))
    elif fault=='entry_scope':e=replace(e,scope='1'*64)
    elif fault=='seed_format':j=replace(j,seed_commitment='not-a-digest')
    elif fault=='retired':j=replace(j,retired=(e.reserved_identity,))
    forged=replace(q,journal=replace(j,entries=(e,)))
    assert not _validate_candidate(forged)
    assert _validate_candidate(q)


@pytest.mark.parametrize('namespace',['album.local','album.pid'])
def test_cow_auxiliary_reservation_capacity_and_probe_evidence(namespace):
    q=_prepare_candidate(sample(),intent(album_artist='New Ensemble'),seed=23);j=q.journal
    entries=tuple(replace(e,capacity_check=tuple((k,0 if k=='probes' else v) for k,v in e.capacity_check)) if e.namespace==namespace else e for e in j.entries)
    assert not _validate_candidate(replace(q,journal=replace(j,entries=entries)))
    assert _validate_candidate(q)


def test_real_text_seed_cow_apply_uses_no_allocator_or_randomness(monkeypatch):
    from itlkit.planning import PreparedMutation,apply
    raw=sample();prepared=prepare(raw,intent(album_artist='Seeded Ensemble'),seed='ITL4/\u7a2e/\U0001f3b5')
    assert type(prepared) is PreparedMutation
    def forbidden(*args,**kwargs):raise AssertionError('allocation or randomness during apply')
    monkeypatch.setattr('itlkit.cow.ReservationAllocator',forbidden)
    monkeypatch.setattr('itlkit.cow._prepare_candidate',forbidden)
    monkeypatch.setattr('itlkit.identity.secrets.token_bytes',forbidden)
    target=Library.from_bytes(raw);apply(target,prepared)
    assert target.track(persistent_id=0xAACC000000000001).get('album_artist')=='Seeded Ensemble'


def test_typed_cow_patches_are_required_without_decoding_forged_reports():
    q=_prepare_candidate(sample(),intent(name='ScopeCheck'),seed=23)
    assert not _validate_candidate(replace(q,text_patches=list(q.text_patches)))
    assert not _validate_candidate(replace(q,intent_json=b'x'*4096),limits={'max_file_bytes':16777216,'max_plain_bytes':16777216,'max_nodes':100000,'max_depth':32,'max_text_bytes':4194304,'max_json_bytes':32,'memory_budget_bytes':536870912})


# New G2 canonical integration controls, not recovered f5 original tests.
@pytest.mark.parametrize('field',['name','comment','composer','artist','album','album_artist'])
def test_g2_cow_uses_full_canonical_ledger_not_lossy_bridge(field,monkeypatch):
    from itlkit import identity,schema,planning
    def forbidden(*args,**kwargs):raise AssertionError('legacy lossy ledger bridge called')
    monkeypatch.setattr(identity,'to_shared_ledger',forbidden)
    raw=sample();result=prepare(raw,intent(**{field:'G2 canonical value'}),seed='G2/seed')
    assert type(result) is planning.PreparedMutation
    ledger=result.allocation_ledger
    assert ledger.snapshot.digest==result.baseline_digest and ledger.seed_commitment
    assert ledger.sources=={} and ledger.history==() and ledger.retired==()
    for row in ledger:
        assert row.target_snapshot==ledger.snapshot
        assert row.capacity_check['validation']=='identity.raw-backed.default-policy.v1'
        assert row.capacity_check['seed_commitment_verified'] is True
        if row.old_identity is not None:
            assert type(row.old_identity) is schema.SourceBinding
            assert row.old_identity.snapshot==ledger.snapshot
    monkeypatch.setattr('itlkit.cow.ReservationAllocator',forbidden)
    monkeypatch.setattr('itlkit.identity.ReservationAllocator',forbidden)
    monkeypatch.setattr('itlkit.identity.seed_from_text',forbidden)
    monkeypatch.setattr('itlkit.cow._prepare_candidate',forbidden)
    monkeypatch.setattr('itlkit.identity.secrets.token_bytes',forbidden)
    target=Library.from_bytes(raw);planning.apply(target,result)
    assert target.to_bytes()==result.candidate_bytes


def test_g2_cow_seed_preimage_and_derived_pid_tampering_refuse():
    import hashlib
    q=_prepare_candidate(sample(),intent(album_artist='G2 ensemble'),seed=23)
    assert q.journal.seed_commitment==hashlib.sha256(q._seed_material).hexdigest()
    assert not _validate_candidate(replace(q,_seed_material=b'wrong but immutable'))
    assert not _validate_candidate(replace(q,journal=replace(q.journal,seed_commitment='0'*64)))
    assert not _validate_candidate(replace(q,_seed_material=bytearray(q._seed_material)))
    assert _validate_candidate(q)


def test_g2_none_seed_drawn_once_and_never_during_apply(monkeypatch):
    from itlkit import planning
    calls=[]
    def once(n):calls.append(n);return b'Z'*n
    monkeypatch.setattr('itlkit.identity.secrets.token_bytes',once)
    raw=sample();result=prepare(raw,intent(album='New seeded album'))
    assert type(result) is planning.PreparedMutation and calls==[32]
    def forbidden(*args,**kwargs):raise AssertionError('randomness after prepare')
    monkeypatch.setattr('itlkit.identity.secrets.token_bytes',forbidden)
    planning.apply(Library.from_bytes(raw),result)
    assert calls==[32]


def test_g2_cow_extra_sources_and_seal_tamper_are_atomic():
    from itlkit import planning
    from itlkit.errors import FormatError
    raw=sample();result=prepare(raw,intent(name='Atomic'),seed=23)
    target=Library.from_bytes(raw);before=planning.library_state_digest(target)
    with pytest.raises(FormatError):planning.apply(target,result,sources={'extra':raw})
    assert planning.library_state_digest(target)==before
    old=result.allocation_ledger
    object.__setattr__(result,'allocation_ledger',replace(old,seed_commitment='0'*64))
    with pytest.raises(FormatError):planning.apply(target,result)
    assert planning.library_state_digest(target)==before


def test_g2_explicit_synthetic_foreign_pid_plan_uses_real_checkers(monkeypatch):
    """Generated two-PID wire control, NOT a general/native import writer.

    Real allocator -> production canonical checker -> real planning seal. The
    test-only candidate checker independently checks ALL plaintext/header/trailer
    bytes and source-derived old PID intent; it is not an always-true callback.
    """
    from dataclasses import asdict
    from test_identity_v2 import _g2_foreign_bytes
    from itlkit import identity,planning,schema
    from itlkit.errors import FormatError
    raw=sample();donor=_g2_foreign_bytes();held=[];canonical=[]
    exact_intent={'source':'donor','source_track_pid':'DDEE333344445555','target_track_pids':['AACC000000000001','AACC000000000002']}
    def build(data,declared,sources,*,limits,seed):
        assert declared==exact_intent and set(sources)=={'donor'}
        g=build_graph(data,limits=limits);sg=build_graph(sources['donor'],limits=limits)
        old=next(i for i in sg.owners if i.namespace=='track.pid' and i.value==int(declared['source_track_pid'],16))
        a=identity.ReservationAllocator(g,sources=(sg,),seed=seed)
        new=(a.persistent('track',old),a.persistent('track'));journal=a.freeze()
        ledger=identity.to_canonical_ledger(journal,data,sources,seed_material=a.seed_material,limits=limits)
        lib=Library.from_bytes(data)
        for track,pid in zip(lib.tracks,new):put(track.node.header,0x80,pid.value,8)
        candidate=encode(lib);held.append((journal,a.seed_material));canonical.append(ledger.to_dict())
        return planning.MutationDraft(candidate,schema.ProfileReport(capabilities=('generated_two_pid_test_only',)),ledger,
               typed_patches=tuple(asdict(v) for v in new))
    def validate(data,declared,sources,candidate,report,*,limits):
        if declared!=exact_intent or set(sources)!={'donor'} or len(held)!=1:return False
        journal,seed_bytes=held[0]
        identity.validate_allocation_ledger(journal,data,sources,seed_material=seed_bytes,limits=limits)
        if report['allocation_ledger']!=canonical[0]:return False
        g=build_graph(data,limits=limits);sg=build_graph(sources['donor'],limits=limits)
        source_pid=next((i for i in sg.owners if i.namespace=='track.pid' and i.value==int(declared['source_track_pid'],16)),None)
        if source_pid is None or journal.entries[0].old_identity!=source_pid:return False
        rows=g.to_dict()['tracks']
        if [r['pid'] for r in rows]!=declared['target_track_pids']:return False
        ids=tuple(e.reserved_identity for e in journal.entries)
        if report['typed_patches']!=[asdict(i) for i in ids]:return False
        before=Container.from_bytes(data);after=Container.from_bytes(candidate)
        expected=bytearray(before.payload)
        for row,pid in zip(rows,ids):put(expected,row['offset']+0x80,pid.value,8)
        header=bytearray(before.header);put(header,8,len(candidate),endian='big')
        return bytes(expected)==after.payload and bytes(header)==after.header and before.trailer==after.trailer and not build_graph(candidate,limits=limits).to_dict()['issues']
    result=planning.prepare_mutation('generated-two-pid-control',raw,exact_intent,{'donor':donor},seed=23,build=build,validate=validate)
    assert type(result) is planning.PreparedMutation
    target=Library.from_bytes(raw);before=planning.library_state_digest(target)
    altered=Container.from_bytes(donor).to_bytes(rebuild=True,compression_level=1)
    for bad in (None,{}, {'renamed':donor},{'donor':donor,'extra':raw},{'donor':altered}):
        with pytest.raises(FormatError):planning.apply(target,result,sources=bad)
        assert planning.library_state_digest(target)==before
    forged=Library.from_bytes(result.candidate_bytes);forged.tracks[1].node.header[0xee]^=1
    assert not validate(raw,exact_intent,{'donor':donor},encode(forged),result.to_dict(),limits=schema.ReadLimits())
    def forbidden(*args,**kwargs):raise AssertionError('allocator/RNG/seed encoder at apply')
    monkeypatch.setattr(identity,'ReservationAllocator',forbidden)
    monkeypatch.setattr(identity,'seed_from_text',forbidden)
    monkeypatch.setattr(identity.secrets,'token_bytes',forbidden)
    planning.apply(target,result,sources={'donor':donor})
    assert target.to_bytes()==result.candidate_bytes
    with pytest.raises(FormatError):planning.apply(target,result,sources={'donor':donor})
