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


# NEW G2 resource controls. These are not recovered G1/b985 tests or native proof.
def _g2_hash_facts(resources, *, limits):
    return {k:{'sha256':digest(v),'size_bytes':len(v)} for k,v in resources.items()}


def _g2_noop(resources, *, probe=_g2_hash_facts, limits=None, sources=None, calls=None):
    calls=[] if calls is None else calls
    def build(d,i,s,*,limits,seed,**kw):
        calls.append('build')
        return MutationDraft(d,ProfileReport(capabilities=('resource-transport-test-only',)))
    def validate(d,i,s,c,r,*,limits,**kw):
        calls.append('validate')
        return c==d and r['resource_digests']==_g2_hash_facts(kw.get('resources',{}),limits=limits)
    return prepare_mutation('g2-transport-test-only',library_bytes(),{},sources,
        resources=resources,validate_resources=probe,limits=limits,build=build,validate=validate)


def test_g2_resources_accept_and_reprobe():
    seen=[]
    def probe(r,*,limits):seen.append(dict(r));return _g2_hash_facts(r,limits=limits)
    inputs={'blob':b'non ITL bytes'};p=_g2_noop(inputs,probe=probe)
    inputs['blob']=b'changed caller';target=Library.from_bytes(library_bytes())
    before=(target.container,target.sections)
    with pytest.raises(ValueError):apply(target,p)
    assert len(seen)==1
    assert not apply(target,p,resources={'blob':b'non ITL bytes'}).changed
    assert len(seen)==2 and (target.container,target.sections)==before
    assert p.resource_facts['blob']['size_bytes']==13
    with pytest.raises(TypeError):p.resource_facts['blob']['size_bytes']=1
    report=p.to_dict();report['resource_facts']['blob']['size_bytes']=1
    assert p.resource_facts['blob']['size_bytes']==13


@pytest.mark.parametrize('empty',[None,{}])
def test_g2_empty_resources_do_not_change_legacy_signatures(empty):
    def fail(*a,**k):raise AssertionError('unused resource callback called')
    def build(d,i,s,*,limits,seed):return MutationDraft(d,ProfileReport())
    def validate(d,i,s,c,r,*,limits):return c==d
    p=prepare_mutation('legacy-signature',library_bytes(),{},resources=empty,
        validate_resources=fail,build=build,validate=validate)
    assert not apply(Library.from_bytes(library_bytes()),p,resources=empty).changed


@pytest.mark.parametrize('callback',[None,True,{},'probe_bytes',b'code'])
def test_g2_nonempty_resources_require_code(callback):
    calls=[]
    with pytest.raises((ValueError,TypeError)):_g2_noop({'blob':b'x'},probe=callback,calls=calls)
    assert calls==[]


@pytest.mark.parametrize('resources',[[],b'x',True,{'':b'x'},{1:b'x'},{'x'*129:b'x'},
    {'\ud800':b'x'},{'blob':bytearray(b'x')},{'blob':memoryview(b'x')},{'blob':'x'},
    {'blob':None},{'blob':False}])
def test_g2_bad_resource_inputs_precede_callbacks(resources):
    calls=[]
    def probe(*a,**k):calls.append('probe');raise AssertionError('callback reached')
    with pytest.raises((ValueError,TypeError)):_g2_noop(resources,probe=probe,calls=calls)
    assert not calls


def test_g2_resources_require_exact_dict_and_bounded_count():
    from types import MappingProxyType
    class Custom(dict):pass
    for value in (MappingProxyType({'x':b'x'}),Custom(x=b'x'),{str(i):b'' for i in range(129)}):
        calls=[]
        with pytest.raises((ValueError,TypeError)):_g2_noop(value,calls=calls)
        assert not calls


@pytest.mark.parametrize('facts',[None,True,[],{}, {'extra':1}, {'blob':b'x'},
    {'blob':object()}, {'blob':ReadLimits()}, {'blob':float('nan')},
    {'blob':float('inf')}, {'blob':{1:'not a JSON key'}}, {'blob':'\ud800'}])
def test_g2_bad_resource_facts_precede_build(facts):
    calls=[]
    with pytest.raises((ValueError,TypeError)):
        _g2_noop({'blob':b'x'},probe=lambda r,limits:facts,calls=calls)
    assert not calls


def test_g2_cyclic_facts_and_callback_map_mutation_refused():
    facts={};facts['blob']=facts
    with pytest.raises(ValueError,match='cyclic'):_g2_noop({'blob':b'x'},probe=lambda r,limits:facts)
    def bad(r,*,limits):r['blob']=b'y';return {'blob':1}
    raw={'blob':b'x'}
    with pytest.raises(ValueError,match='changed'):_g2_noop(raw,probe=bad)
    assert raw=={'blob':b'x'}


@pytest.mark.parametrize('limits',[ReadLimits(max_file_bytes=1),ReadLimits(max_plain_bytes=1),
    ReadLimits(max_nodes=1),ReadLimits(max_depth=1),ReadLimits(max_text_bytes=1),
    ReadLimits(max_json_bytes=8),ReadLimits(memory_budget_bytes=128)])
def test_g2_input_budget_refusal_happens_before_any_callback(limits):
    seen=[]
    def probe(r,*,limits):seen.append('probe');return _g2_hash_facts(r,limits=limits)
    with pytest.raises(ValueError):_g2_noop({'blob':b'x'},limits=limits,probe=probe,calls=seen)
    assert seen==[]


@pytest.mark.parametrize('dimension',['text','nodes','depth','json','memory'])
def test_g2_output_facts_budgets_precede_builder(dimension):
    limits=ReadLimits();facts={'blob':'x'*5000}
    if dimension=='text':limits=ReadLimits(max_text_bytes=4096)
    elif dimension=='nodes':limits=ReadLimits(max_nodes=1000);facts={'blob':[None]*2000}
    elif dimension=='json':limits=ReadLimits(max_json_bytes=2048)
    elif dimension=='memory':limits=ReadLimits(memory_budget_bytes=3*1024*1024);facts={'blob':'x'*120000}
    else:
        limits=ReadLimits(max_depth=8);facts={'blob':None}
        for _ in range(20):facts={'blob':facts}
    seen=[]
    def probe(r,*,limits):seen.append('probe');return facts
    with pytest.raises(ValueError):_g2_noop({'blob':b'x'},limits=limits,probe=probe,calls=seen)
    assert seen==['probe']


@pytest.mark.parametrize('current',[None,{}, {'blob':b'b'}, {'blob':b'longer'},
    {'extra':b'a'},{'blob':b'a','extra':b'a'}, {'blob':bytearray(b'a')}, []])
def test_g2_apply_requires_exact_explicit_resource_snapshots(current):
    calls=[];p=_g2_noop({'blob':b'a'},calls=calls);target=Library.from_bytes(library_bytes())
    before=copy.deepcopy(target.__dict__);calls.clear()
    with pytest.raises((ValueError,TypeError)):apply(target,p,resources=current)
    assert target.__dict__==before and calls==[]


def test_g2_namespace_collisions_and_old_itl_source_cas_preserved():
    data=library_bytes()
    with pytest.raises(ValueError,match='overlap'):_g2_noop({'donor':b'x'},sources={'donor':data})
    p=_g2_noop({'blob':b'x'},sources={'donor':data});target=Library.from_bytes(data)
    for source in (None,{}, {'donor':b'changed'},{'extra':data},{'donor':data,'extra':data}):
        before=copy.deepcopy(target.__dict__)
        with pytest.raises(ValueError):apply(target,p,sources=source,resources={'blob':b'x'})
        assert target.__dict__==before
    assert not apply(target,p,sources={'donor':data},resources={'blob':b'x'}).changed
    legacy=prepare(data,{'operations':[]})
    with pytest.raises(ValueError):apply(target,legacy,resources={'blob':b'x'})


def test_g2_changed_facts_and_python_bool_int_equality_do_not_bypass_reprobe():
    value=[1]
    def probe(r,*,limits):return {'blob':{'number':value[0]}}
    p=_g2_noop({'blob':b'x'},probe=probe);target=Library.from_bytes(library_bytes())
    for new in (True,1.0,2):
        value[0]=new;before=copy.deepcopy(target.__dict__)
        with pytest.raises(ValueError,match='facts changed'):apply(target,p,resources={'blob':b'x'})
        assert target.__dict__==before
    value[0]=1;assert not apply(target,p,resources={'blob':b'x'}).changed


@pytest.mark.parametrize('field,value',[('resource_digests',{}),('resource_facts',{}),
    ('_resources',{}),('_resource_facts_json',b'{}'),('_validate_resources',None),
    ('_input_cost',0),('_facts_cost',0),('_candidate',b'bad')])
def test_g2_resource_private_and_public_fields_are_sealed(field,value):
    p=_g2_noop({'blob':b'x'});target=Library.from_bytes(library_bytes());before=copy.deepcopy(target.__dict__)
    object.__setattr__(p,field,value)
    with pytest.raises((ValueError,TypeError)):apply(target,p,resources={'blob':b'x'})
    assert target.__dict__==before


def test_g2_stale_target_precedes_reprobe_without_serializing():
    seen=[]
    def probe(r,*,limits):seen.append('probe');return _g2_hash_facts(r,limits=limits)
    p=_g2_noop({'blob':b'x'},probe=probe);target=Library.from_bytes(library_bytes())
    put(target.tracks[0].node.header,8,999);before=copy.deepcopy(target.__dict__)
    def fail(*a,**k):raise AssertionError('input serialization')
    target.to_bytes=fail
    with pytest.raises(ValueError,match='stale target'):apply(target,p,resources={'blob':b'x'})
    assert target.container==before['container'] and target.sections==before['sections'] and seen==['probe']


def _g2_pcm():
    import io,wave
    buf=io.BytesIO()
    with wave.open(buf,'wb') as w:w.setnchannels(1);w.setsampwidth(2);w.setframerate(48000);w.writeframes(b'\0'*96)
    return buf.getvalue()


def _g2_test_only_pcm_probe(resources,*,limits):
    # Independent stdlib physical control, NOT a replacement for itlkit.media.
    import io,wave
    result={}
    for name,raw in resources.items():
        with wave.open(io.BytesIO(raw),'rb') as w:
            facts={'sample_rate':w.getframerate(),'channels':w.getnchannels(),
                   'sample_width':w.getsampwidth(),'frames':w.getnframes(),'sha256':digest(raw)}
            if w.getcomptype()!='NONE' or len(w.readframes(facts['frames']))!=facts['frames']*facts['channels']*facts['sample_width']:
                raise ValueError('test PCM is not complete uncompressed frames')
        result[name]=facts
    return result


def test_g2_default_wav_in_itl_sources_is_still_refused_before_build():
    called=[]
    def build(*a,**k):called.append('build');raise AssertionError('WAV in ITL lane reached builder')
    with pytest.raises(ValueError,match='hdfm'):
        prepare_mutation('wrong-lane',library_bytes(),{}, {'media':_g2_pcm()},build=build,validate=lambda *a,**k:True)
    assert called==[]


@pytest.mark.parametrize('control',['positive','wrong_declared_rate','fake_probe_facts'])
def test_g2_minimal_pcm_scalar_candidate_with_independent_intent(control,monkeypatch):
    from itlkit import Container
    data=Library.from_bytes(library_bytes()).to_bytes();raw=_g2_pcm();resources={'clip.wav':raw}
    intent={'year':2037,'sample_rate':48000,'channels':1,'sample_width':2,'frames':48}
    if control=='wrong_declared_rate':intent['sample_rate']=44100
    calls=[]
    def probe(r,*,limits):
        calls.append('probe');facts=_g2_test_only_pcm_probe(r,limits=limits)
        if control=='fake_probe_facts':facts['clip.wav']['sample_rate']=44100
        return facts
    def build(d,i,s,*,limits,seed,resources):
        calls.append('build');lib=Library.from_bytes(d);lib.track(track_id=1).set(year=i['year'])
        return MutationDraft(lib.to_bytes(),ProfileReport(capabilities=('PCM-transport-scalar-test-only',)))
    def validate(d,i,s,c,r,*,limits,resources):
        actual=_g2_test_only_pcm_probe(resources,limits=limits)
        if actual!=r['resource_facts'] or any(actual['clip.wav'][key]!=i[key] for key in ('sample_rate','channels','sample_width','frames')):return False
        before=Container.from_bytes(d);after=Container.from_bytes(c);expected=bytearray(before.payload)
        put(expected,Library.from_bytes(d).track(track_id=1).node.offset+0x34,i['year'])
        return after.payload==bytes(expected) and after.trailer==before.trailer and after.header[:8]+after.header[12:]==before.header[:8]+before.header[12:]
    def prepare_it():return prepare_mutation('PCM-transport-scalar-test-only',data,intent,resources=resources,validate_resources=probe,build=build,validate=validate)
    if control!='positive':
        with pytest.raises(ValueError,match='postcondition'):prepare_it()
        return
    p=prepare_it();assert calls==['probe','build']
    def no_random(*a,**k):raise AssertionError('RNG replay at apply')
    monkeypatch.setattr('itlkit.planning.secrets.token_bytes',no_random)
    for _ in range(2):
        target=Library.from_bytes(data);receipt=apply(target,p,resources=resources)
        assert receipt.changed and not receipt.native_qualified and target.to_bytes()==p.candidate_bytes
    assert calls==['probe','build','probe','probe']


def test_g2_real_media_probe_integration_requires_actual_owner_module():
    media=pytest.importorskip('itlkit.media',reason='actual reviewed media.probe_bytes dependency not integrated; stdlib control is separate')
    raw=_g2_pcm()
    def probe(r,*,limits):return {k:dataclasses.asdict(media.probe_bytes(v,limits=limits)) for k,v in r.items()}
    p=_g2_noop({'clip.wav':raw},probe=probe)
    assert p.resource_facts['clip.wav']['sample_rate']==48000
    assert not apply(Library.from_bytes(library_bytes()),p,resources={'clip.wav':raw}).changed


def test_g2_blocked_profile_and_wrong_ledger_do_not_become_capabilities():
    from itlkit.schema import Blocker,snapshot_key
    data=library_bytes()
    def blocked(d,i,s,*,limits,seed,resources):return ProfileReport(blockers=(Blocker('pool-unproved','No pool permission'),))
    p=prepare_mutation('blocked',data,{},resources={'blob':b'x'},validate_resources=_g2_hash_facts,build=blocked,validate=lambda *a,**k:True)
    assert p.blocked
    with pytest.raises(TypeError):apply(Library.from_bytes(data),p,resources={'blob':b'x'})
    def wrong(d,i,s,*,limits,seed,resources):return MutationDraft(d,ProfileReport(),AllocationLedger(snapshot=snapshot_key(d),sources={}))
    with pytest.raises(ValueError,match='SnapshotKey'):
        prepare_mutation('wrong-ledger',data,{}, {'donor':data},resources={'blob':b'x'},validate_resources=_g2_hash_facts,build=wrong,validate=lambda *a,**k:True)
    for fake in (p.to_dict(),{'passed':True}):
        with pytest.raises(TypeError):apply(Library.from_bytes(data),fake,resources={'blob':b'x'})


@pytest.mark.parametrize('case',['file','aggregate','names','pin-json'])
def test_g2_resource_specific_input_budgets_precede_probe(case):
    from itlkit.schema import ReadLimits
    seen=[];resources={'blob':b'x'};limits=ReadLimits()
    if case=='file':
        cap=len(library_bytes())+1;limits=ReadLimits(max_file_bytes=cap);resources={'blob':b'x'*(cap+1)}
    elif case=='aggregate':
        limits=ReadLimits(memory_budget_bytes=524288);resources={'a':b'x'*32768,'b':b'y'*32768}
    elif case=='names':
        limits=ReadLimits(max_text_bytes=4096);resources={str(i).zfill(128):b'' for i in range(33)}
    else:limits=ReadLimits(max_json_bytes=100)
    def probe(r,*,limits):seen.append('probe');return _g2_hash_facts(r,limits=limits)
    with pytest.raises(ValueError):_g2_noop(resources,probe=probe,limits=limits,calls=seen)
    assert not seen


@pytest.mark.parametrize('where',['build','validate'])
def test_g2_engine_resource_map_mutation_is_refused(where):
    resources={'blob':b'x'}
    def build(d,i,s,*,limits,seed,resources):
        if where=='build':resources.clear()
        return MutationDraft(d,ProfileReport())
    def validate(d,i,s,c,r,*,limits,resources):
        if where=='validate':resources['blob']=bytearray(b'x')
        return True
    with pytest.raises(ValueError,match='changed'):
        prepare_mutation('mutation-negative-only',library_bytes(),{},resources=resources,
            validate_resources=_g2_hash_facts,build=build,validate=validate)
    assert resources=={'blob':b'x'}


def test_g2_fact_aliases_detached_before_adoption():
    data={'blob':{'nested':[1]}}
    def probe(r,*,limits):return data
    p=_g2_noop({'blob':b'x'},probe=probe)
    data['blob']['nested'].append(2)
    assert tuple(p.resource_facts['blob']['nested'])==(1,)
    target=Library.from_bytes(library_bytes());before=copy.deepcopy(target.__dict__)
    with pytest.raises(ValueError,match='facts changed'):apply(target,p,resources={'blob':b'x'})
    assert target.__dict__==before


def test_g2_resources_cannot_stand_in_for_ledger_itl_sources():
    from itlkit.schema import snapshot_key
    data=library_bytes();key=snapshot_key(data)
    def build(d,i,s,*,limits,seed,resources):
        return MutationDraft(d,ProfileReport(),AllocationLedger(snapshot=key,sources={'donor':key}))
    with pytest.raises(ValueError,match='SnapshotKey'):
        prepare_mutation('negative-ledger-only',data,{},resources={'donor':data},
            validate_resources=_g2_hash_facts,build=build,validate=lambda *a,**k:True)
