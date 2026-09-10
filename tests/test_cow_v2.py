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
