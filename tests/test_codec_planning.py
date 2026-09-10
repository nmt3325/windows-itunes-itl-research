import dataclasses
import pickle
import copy
import pytest
from itlkit import Library
from itlkit.planning import (prepare,prepare_mutation,apply,PreparedMutation,MutationDraft,
    library_state_digest,digest)
from itlkit.schema import ReadLimits,ProfileReport,AllocationLedger,AllocationReservation,ScopedID
from itlkit.binary import put,uint
from test_core_support import library_bytes
from test_codec_tracks import profile


def scalar(year=2037):
    return {'operations':[{'op':'set_track','track_id':1,'fields':{'year':year}}]}


def test_normal_noop_and_read_only_preparation():
    data=library_bytes();lib=Library.from_bytes(data);state=copy.deepcopy(lib.__dict__)
    p=prepare(data,scalar());assert isinstance(p,PreparedMutation)
    assert lib.__dict__==state and p.baseline_digest==digest(data)
    r=apply(lib,p);assert r.changed and not r.native_qualified
    assert lib.track(track_id=1).get('year')==2037
    q=prepare(data,{'operations':[]});lib2=Library.from_bytes(data);before=(lib2.container,lib2.sections)
    assert not apply(lib2,q).changed and (lib2.container,lib2.sections)==before
    assert lib2.container._original==data


def test_input_library_not_serialized_for_digest(monkeypatch):
    lib=Library.from_bytes(library_bytes());p=prepare(lib.container._original,scalar())
    put(lib.tracks[0].node.header,0x34,1999)
    state=copy.deepcopy(lib.__dict__)
    def bad(*a,**k):raise AssertionError('input serializer called')
    monkeypatch.setattr(lib,'to_bytes',bad)
    with pytest.raises(ValueError,match='stale target'):apply(lib,p)
    assert lib.container==state['container'] and lib.sections==state['sections']
    with pytest.raises(TypeError):digest(lib)


def test_stale_raw_derived_header_is_not_normalized_away():
    data=library_bytes();lib=Library.from_bytes(data);p=prepare(data,scalar())
    put(lib.tracks[0].node.header,8,999)
    state=copy.deepcopy(lib.__dict__)
    with pytest.raises(ValueError,match='stale'):apply(lib,p)
    assert lib.__dict__==state


@pytest.mark.parametrize('field,value',[('_candidate',b'bad'),('engine','forged'),
    ('baseline_digest','0'*64),('intent',{'operations':[]}),('postconditions',())])
def test_tamper_atomic(field,value):
    data=library_bytes();lib=Library.from_bytes(data);p=prepare(data,scalar())
    before=copy.deepcopy(lib.__dict__);object.__setattr__(p,field,value)
    with pytest.raises(ValueError):apply(lib,p)
    assert lib.__dict__==before


def test_reports_not_capabilities_and_no_pickle():
    data=library_bytes();p=prepare(data,scalar());report=p.to_dict()
    assert report['executable'] is False
    with pytest.raises(TypeError):apply(Library.from_bytes(data),report)
    with pytest.raises(TypeError):PreparedMutation(**report)
    with pytest.raises(TypeError):pickle.dumps(p)
    with pytest.raises(TypeError):dataclasses.replace(p,engine='other')
    report['intent']['operations'][0]['fields']['year']=1
    assert apply(Library.from_bytes(data),p).changed


def test_refusal_and_invalid_later_operation_are_not_partial():
    data=library_bytes();lib=Library.from_bytes(data);before=copy.deepcopy(lib.__dict__)
    p=prepare(data,{'operations':[{'op':'create_playlist','name':'Not this engine'}]})
    assert isinstance(p,ProfileReport) and p.blocked
    with pytest.raises(ValueError):prepare(data,{'operations':scalar()['operations']+[
        {'op':'set_track','track_id':1,'fields':{'rating':999}}]})
    assert lib.__dict__==before
    for intent in ({'operations':[],'extra':1},{'operations':'x'}):
        with pytest.raises(ValueError):prepare(data,intent)
    with pytest.raises(ValueError):prepare(data,scalar(),seed=7)


def test_budget_and_sources_are_checked():
    data=library_bytes()
    with pytest.raises(ValueError):prepare(data,scalar(),limits=ReadLimits(max_nodes=1))
    with pytest.raises(ValueError):prepare(data,scalar(),limits=ReadLimits(max_json_bytes=8))
    with pytest.raises(TypeError):prepare(Library.from_bytes(data),scalar())


def test_trusted_engine_prepares_random_candidate_once_and_freezes_apply(monkeypatch):
    # Real existing core allocator, not a substitute identity/graph implementation.
    # This tests the framework, not native/general importing qualifications.
    data=profile().to_bytes();calls=[]
    def build(d,intent,sources,*,limits,seed):
        calls.append('build');lib=Library.from_bytes(d)
        p=lib.create_playlist('Prepared once',track_persistent_ids=[])
        ids=[ScopedID('playlist.pid','target',p.persistent_id,8),
             ScopedID('playlist.local','target',p.playlist_id,4)]
        ledger=AllocationLedger(tuple(AllocationReservation(x.namespace,x.scope,None,x,
            ('created playlist',),{'passed':True,'upper':(1<<(8*x.width))-1}) for x in ids))
        return MutationDraft(lib.to_bytes(),ProfileReport(capabilities=('framework-test',)),ledger,
            postconditions=({'check':'new playlist name and real allocated identity','passed':True},))
    def validate(d,intent,sources,candidate,report,*,limits):
        base=Library.from_bytes(d);lib=Library.from_bytes(candidate)
        old={p.persistent_id for p in base.playlists};new=[p for p in lib.playlists if p.persistent_id not in old]
        r=report['allocation_ledger']['reservations']
        return len(new)==1 and new[0].name=='Prepared once' and len(r)==2 and r[0]['reserved_identity']['value']==new[0].persistent_id and r[1]['reserved_identity']['value']==new[0].playlist_id
    p=prepare_mutation('test-real-core-allocation',data,{},build=build,validate=validate)
    assert calls==['build'] and len(p.allocation_ledger)==2
    def no_random(*a,**k):raise AssertionError('randomness during apply')
    monkeypatch.setattr('itlkit.operations.secrets.randbits',no_random)
    left=Library.from_bytes(data);right=Library.from_bytes(data)
    apply(left,p);apply(right,p)
    assert left.to_bytes()==right.to_bytes()==p.candidate_bytes and calls==['build']


def test_source_pins_and_rechecked_postconditions():
    data=library_bytes();allow=[True]
    def build(d,i,s,*,limits,seed):return MutationDraft(d,ProfileReport(capabilities=('noop',)))
    def validate(d,i,s,c,r,*,limits):return allow[0] and c==d and s=={'donor':data}
    p=prepare_mutation('source-noop',data,{}, {'donor':data},build=build,validate=validate)
    target=Library.from_bytes(data);state=copy.deepcopy(target.__dict__)
    with pytest.raises(ValueError,match='source'):apply(target,p)
    with pytest.raises(ValueError,match='source'):apply(target,p,sources={'donor':b'changed'})
    assert not apply(target,p,sources={'donor':data}).changed
    allow[0]=False
    with pytest.raises(ValueError,match='postcondition'):apply(target,p,sources={'donor':data})
    assert target.__dict__==state
