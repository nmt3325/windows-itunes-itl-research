from dataclasses import replace
from datetime import datetime, timezone, timedelta
from hashlib import sha256
import io
import struct
import wave
import pytest
from itlkit.construct import ConstructionError, WaveRecordBindings, materialize_pcm_wave_record, hfs_displayed_wall_time, declare_intent, prepare


def pcm(frames=60000, rate=48000, channels=1, bits=16, sample=0):
    out = io.BytesIO()
    with wave.open(out,'wb') as stream:
        stream.setnchannels(channels); stream.setsampwidth(bits//8); stream.setframerate(rate)
        stream.writeframes(bytes([sample])*(frames*channels*bits//8))
    return out.getvalue()


DATE = datetime(2026,9,10,1,40,tzinfo=timezone.utc)
IDS = WaveRecordBindings(103,105,0x1111222233334444,101,102,4,1)
RANKS = (4000,1000,1000,1000,1000,1000,1000)


def build(data=None, metadata=None, bindings=IDS, location='D:\\new-media\\independent.wav'):
    return materialize_pcm_wave_record(pcm() if data is None else data, {'name':'New explicit Name'} if metadata is None else metadata,
                                      location,bindings,date_added=DATE,date_modified=DATE,sort_ranks=RANKS)


@pytest.mark.parametrize('rate,frames',[(48000,60000),(48000,72000),(44100,11025),(44100,88200)])
def test_positive_record_and_non_one_second_count(rate,frames):
    result = build(pcm(frames,rate))
    h = result.record_bytes
    assert h[:4] == b'mith'
    assert struct.unpack_from('<II',h,4) == (756,len(h))
    assert struct.unpack_from('<I',h,12)[0] == 4
    assert struct.unpack_from('<f',h,0x98)[0] == rate
    assert struct.unpack_from('<Q',h,0xf4)[0] == frames
    assert frames != rate
    assert struct.unpack_from('<I',h,0x28)[0] == frames*1000//rate
    assert struct.unpack_from('<I',h,0x38)[0] == rate*16//1000
    assert struct.unpack_from('<Q',h,0x80)[0] == IDS.track_pid
    assert h[0x6d] == h[0xee] == 0
    assert sha256(h).hexdigest() == result.record_sha256
    assert not result.native_accepted
    cursor = 756
    types=[]
    while cursor<len(h):
        assert h[cursor:cursor+4] == b'mhoh'
        types.append(struct.unpack_from('<I',h,cursor+12)[0])
        cursor += struct.unpack_from('<I',h,cursor+8)[0]
    assert cursor==len(h) and types==[2,6,13,11]


def test_media_hash_and_identity_metamorphisms():
    a,b=build(pcm(sample=0)),build(pcm(sample=1))
    assert a.media_sha256!=b.media_sha256 and a.record_bytes==b.record_bytes
    # Content hashes are provenance; otherwise identical physical facts need not change the record.
    c=build(bindings=replace(IDS,track_pid=0x1122334455667788))
    diff=[i for i,(x,y) in enumerate(zip(a.record_bytes,c.record_bytes)) if x!=y]
    assert diff and set(diff)<=set(range(0x80,0x88))
    assert build()==build()


def test_flags_are_independent():
    data=build(metadata={'name':'Explicit','rating':80,'unplayed':False}).record_bytes
    assert data[0x6c]==80 and data[0x6d]==0 and data[0xee]==1
    assert struct.unpack_from('<7I',data,0x290)==RANKS


@pytest.mark.parametrize('changes',[{'track_local':0},{'track_local':105},{'track_local':1000001},{'track_pid':0},{'track_pid':1<<64},{'name_atom':65536},{'kind_atom':True}])
def test_binding_refusals(changes):
    with pytest.raises(ConstructionError):
        build(bindings=replace(IDS,**changes))


@pytest.mark.parametrize('metadata',[{}, {'name':''},{'name':'音'},{'name':'x','artist':'new grouping'},{'name':'x','rating':101},{'name':'x','year':True},{'name':'x','unplayed':1},{'name':'x','identity':1}])
def test_metadata_refusals(metadata):
    with pytest.raises(ConstructionError):
        build(metadata=metadata)


@pytest.mark.parametrize('channels,bits,rate',[(2,16,48000),(1,8,48000),(1,24,48000),(1,16,22050)])
def test_unqualified_media_no_template_fallback(channels,bits,rate):
    with pytest.raises(ConstructionError):
        build(pcm(1000,rate,channels,bits))


@pytest.mark.parametrize('location',['D:\\音.wav','D:\\space name.wav','D:\\x%y.wav'])
def test_unqualified_native_location(location):
    with pytest.raises(ConstructionError):
        build(location=location)


def test_dates_and_mutation_free_dependency_block():
    assert hfs_displayed_wall_time(DATE)==hfs_displayed_wall_time(DATE.replace(tzinfo=timezone(timedelta(hours=9))))
    for date in (DATE.replace(tzinfo=None),datetime(1904,1,1,tzinfo=timezone.utc),datetime(2041,1,1,tzinfo=timezone.utc)):
        with pytest.raises(ConstructionError):hfs_displayed_wall_time(date)
    from test_core_support import library_bytes
    from itlkit.schema import ProfileReport
    source=pcm();target=library_bytes()
    intent=declare_intent(source,{'name':'New'},'D:\\new.wav',date_added=DATE,date_modified=DATE)
    result=prepare(target,intent,{'media':source},seed=123)
    assert type(result) is ProfileReport and result.blocked
    codes={b.code for b in result.blockers}
    assert {'media_source_adapter_unavailable','identity_adapter_pending_authorized_pin'} <= codes
    assert source==pcm() and target==library_bytes()
    with pytest.raises(TypeError):prepare(target,intent,{'media':source},limits={'max_file_bytes':False})


@pytest.mark.parametrize('key,bad', [('year',32768),('track_number',65536),('track_count',65536)])
def test_native_low16_conversion_boundaries(key,bad):
    with pytest.raises(ConstructionError):build(metadata={'name':'Width control',key:bad})
    build(metadata={'name':'Width control',key:bad-1})


def test_subsecond_reserved_hfs_zero_is_refused():
    with pytest.raises(ConstructionError):
        hfs_displayed_wall_time(datetime(1904,1,1,0,0,0,999999,tzinfo=timezone.utc))
    assert hfs_displayed_wall_time(datetime(1904,1,1,0,0,1,tzinfo=timezone.utc))==1


def test_intent_is_independent_json_and_detached():
    import json
    from test_core_support import library_bytes
    from itlkit.schema import ReadLimits
    source=pcm(72000,48000,sample=2);metadata={'name':'Independent expectation'}
    intent=declare_intent(source,metadata,'D:\\newmedia.wav',date_added=DATE,date_modified=DATE)
    saved=json.loads(json.dumps(intent));metadata['name']='caller changed'
    assert intent['metadata']['name']=='Independent expectation'
    assert intent['media']['pcm_source_frames']==72000 and intent['media']['duration_ms']==1500
    assert intent['media']['sample_rate_hz']==48000 and intent['media']['size_bytes']==144044
    assert prepare(library_bytes(),intent,{'media':source},limits=ReadLimits()).blocked
    assert intent==saved
    assert declare_intent(pcm(72000,48000,sample=3),saved['metadata'],'D:\\newmedia.wav',date_added=DATE,date_modified=DATE)['media']['sha256'] != intent['media']['sha256']


@pytest.mark.parametrize('key,bad',[('sha256','0'*64),('pcm_source_frames',60001),('sample_rate_hz',48000.0),('channels',True),('size_bytes',0)])
def test_forged_media_declaration_refused(key,bad):
    from test_core_support import library_bytes
    source=pcm();intent=declare_intent(source,{'name':'New'},'D:\\x.wav',date_added=DATE,date_modified=DATE)
    intent['media'][key]=bad
    with pytest.raises(ConstructionError):prepare(library_bytes(),intent,{'media':source})


def test_actual_shared_adapter_rejects_wave_source_before_builder():
    from test_core_support import library_bytes
    from itlkit.planning import prepare_mutation
    from itlkit.schema import ProfileReport,Blocker
    calls=[]
    def build(d,i,s,*,limits,seed):
        calls.append('build')
        return ProfileReport(blockers=(Blocker('not_a_candidate','test must not reach builder'),))
    def validate(*args,**kwargs):
        calls.append('validate')
        return False
    with pytest.raises(ValueError):
        prepare_mutation('constructor-media-contract-check',library_bytes(),{}, {'media':pcm()},build=build,validate=validate)
    assert calls==[]  # observed real dependency boundary, not a mocked positive engine


def test_constructor_uses_shared_target_budgets_and_rejects_authority_extras():
    from test_core_support import library_bytes
    from itlkit.schema import ReadLimits
    source=pcm();intent=declare_intent(source,{'name':'New'},'D:\\x.wav',date_added=DATE,date_modified=DATE)
    with pytest.raises(ValueError):prepare(library_bytes(),intent,{'media':source},limits=ReadLimits(max_nodes=1))
    with pytest.raises(ValueError):prepare(b'not an ITL',intent,{'media':source})
    for key in ('allocation_ledger','candidate_bytes','graph'):
        with pytest.raises(ConstructionError):prepare(library_bytes(),dict(intent,**{key:{}}),{'media':source})
    with pytest.raises(TypeError):prepare(library_bytes(),intent,{'media':source,'donor':library_bytes()})


@pytest.mark.parametrize('micros',[1,500000,999999])
@pytest.mark.parametrize('slot',['date_added','date_modified'])
def test_review_construct01_no_subsecond_zero_in_either_wire_slot(micros,slot):
    bad=datetime(1904,1,1,tzinfo=timezone.utc)+timedelta(microseconds=micros)
    with pytest.raises(ConstructionError):hfs_displayed_wall_time(bad)
    dates={'date_added':DATE,'date_modified':DATE};dates[slot]=bad
    with pytest.raises(ConstructionError):
        materialize_pcm_wave_record(pcm(frames=257),{'name':'Date boundary'},r'D:\ordinary.wav',
            WaveRecordBindings(103,105,0x1111222233334444,101,102,4,1),sort_ranks=(4000,1000,1000,1000,1000,1000,1000),**dates)


def test_review_construct01_prequantization_bounds_and_normal_writes():
    epoch=datetime(1904,1,1,tzinfo=timezone.utc);upper=epoch+timedelta(seconds=1<<32)
    for dt in (epoch-timedelta(microseconds=1),epoch,upper,upper+timedelta(microseconds=1),(epoch+timedelta(seconds=1)).replace(tzinfo=None)):
        with pytest.raises(ConstructionError):hfs_displayed_wall_time(dt)
    assert hfs_displayed_wall_time(upper-timedelta(microseconds=1))==(1<<32)-1
    one=epoch+timedelta(seconds=1,microseconds=999999)
    assert hfs_displayed_wall_time(one)==1
    record=materialize_pcm_wave_record(pcm(frames=257),{'name':'Normal date control'},r'D:\ordinary.wav',
        WaveRecordBindings(103,105,0x1111222233334444,101,102,4,1),date_added=one,date_modified=one,sort_ranks=(4000,1000,1000,1000,1000,1000,1000))
    assert struct.unpack_from('<I',record.record_bytes,0x78)[0]==struct.unpack_from('<I',record.record_bytes,0x20)[0]==1
    assert not record.native_accepted


# G2 budget regressions retain all prior helper safety tests verbatim above.
def _g2_budget_record(data, metadata=None, *, limits=None, location=r'D:\budget-control.wav'):
    return materialize_pcm_wave_record(data, {'name': 'Budget control'} if metadata is None else metadata,
        location, IDS, date_added=DATE, date_modified=DATE, sort_ranks=RANKS, limits=limits)


@pytest.mark.parametrize('entry', ['record', 'intent'])
def test_g2_budget_one_constructor_before_probe_and_location(monkeypatch, entry):
    from itlkit import construct
    from itlkit.schema import ReadLimits
    data = pcm(frames=257)
    calls = []
    probe, plan = construct.probe_bytes, construct.plan_location
    def observed_probe(*args, **kwargs):
        calls.append('probe')
        return probe(*args, **kwargs)
    def observed_plan(*args, **kwargs):
        calls.append('location')
        return plan(*args, **kwargs)
    monkeypatch.setattr(construct, 'probe_bytes', observed_probe)
    monkeypatch.setattr(construct, 'plan_location', observed_plan)
    with pytest.raises(ValueError, match='memory budget'):
        if entry == 'record':
            _g2_budget_record(data, limits=ReadLimits(memory_budget_bytes=1))
        else:
            declare_intent(data, {'name': 'Budget control'}, r'D:\budget-control.wav',
                date_added=DATE, date_modified=DATE, limits=ReadLimits(memory_budget_bytes=1))
    assert calls == []


@pytest.mark.parametrize('entry', ['record', 'intent', 'metadata'])
def test_g2_budget_text_refused_before_record_or_location_materialization(monkeypatch, entry):
    from itlkit import construct
    from itlkit.schema import ReadLimits
    data = pcm(frames=257)
    metadata = {'name': 'X' * 200000}
    calls = []
    originals = {name: getattr(construct, name) for name in ('probe_bytes', 'plan_location', 'location_records', '_text_record')}
    def wrapper(name):
        def observed(*args, **kwargs):
            calls.append(name)
            return originals[name](*args, **kwargs)
        return observed
    for name in originals:
        monkeypatch.setattr(construct, name, wrapper(name))
    with pytest.raises(ValueError, match='memory budget'):
        if entry == 'record':
            _g2_budget_record(data, metadata, limits=ReadLimits(memory_budget_bytes=1024 * 1024))
        elif entry == 'intent':
            declare_intent(data, metadata, r'D:\budget-control.wav', date_added=DATE,
                date_modified=DATE, limits=ReadLimits(memory_budget_bytes=1024 * 1024))
        else:
            construct.validate_metadata(metadata, limits=ReadLimits(memory_budget_bytes=1024 * 1024))
    assert calls == []


def test_g2_budget_metadata_one_refused():
    from itlkit.construct import validate_metadata
    from itlkit.schema import ReadLimits
    with pytest.raises(ValueError, match='memory budget'):
        validate_metadata({'name': 'Budget control'}, limits=ReadLimits(memory_budget_bytes=1))


def test_g2_budget_prepare_before_json_or_media(monkeypatch):
    from itlkit import schema, construct
    from test_core_support import library_bytes
    source = pcm(frames=257)
    target = library_bytes()
    intent = declare_intent(source, {'name': 'Budget control'}, r'D:\budget-control.wav',
                            date_added=DATE, date_modified=DATE)
    calls = []
    original_json, original_probe = schema.encode_json, construct.probe_bytes
    def observed_json(*args, **kwargs):
        calls.append('json')
        return original_json(*args, **kwargs)
    def observed_probe(*args, **kwargs):
        calls.append('probe')
        return original_probe(*args, **kwargs)
    monkeypatch.setattr(schema, 'encode_json', observed_json)
    monkeypatch.setattr(construct, 'probe_bytes', observed_probe)
    with pytest.raises(ValueError, match='memory budget'):
        prepare(target, intent, {'media': source}, limits=schema.ReadLimits(memory_budget_bytes=1))
    assert calls == []


@pytest.mark.parametrize('bad', [True, False, 1.0, 0.0, -1.0, -1, 0, '1', None])
def test_g2_budget_record_limit_type_contract(bad):
    from itlkit.media import MediaError
    with pytest.raises(MediaError, match='invalid shared ReadLimits'):
        _g2_budget_record(pcm(frames=257), limits={'memory_budget_bytes': bad})


def test_g2_budget_engine_and_declaration_require_actual_limits():
    from itlkit.schema import ReadLimits
    from test_core_support import library_bytes
    source = pcm(frames=257)
    intent = declare_intent(source, {'name': 'Budget control'}, r'D:\budget-control.wav',
                            date_added=DATE, date_modified=DATE)
    class Subclass(ReadLimits):
        pass
    for value in ({'memory_budget_bytes': 64 * 1024 * 1024}, True, 1.0, Subclass()):
        with pytest.raises(TypeError, match='limits must be ReadLimits'):
            declare_intent(source, {'name': 'Budget control'}, r'D:\budget-control.wav',
                           date_added=DATE, date_modified=DATE, limits=value)
        with pytest.raises(TypeError, match='limits must be ReadLimits'):
            prepare(library_bytes(), intent, {'media': source}, limits=value)


@pytest.mark.parametrize('budget', [32 * 1024 * 1024, 64 * 1024 * 1024])
def test_g2_budget_sufficient_preserves_record_intent_and_blockers(budget):
    from itlkit.schema import ReadLimits, ProfileReport
    from test_core_support import library_bytes
    import copy
    source = pcm(frames=60000, sample=5)
    metadata = {'name': 'Independent budget control', 'year': 2026, 'rating': 80, 'unplayed': False}
    before = dict(metadata)
    limited = _g2_budget_record(source, metadata, limits=ReadLimits(memory_budget_bytes=budget))
    assert limited == _g2_budget_record(source, metadata)
    assert not limited.native_accepted and limited.record_bytes[:4] == b'mith'
    intent = declare_intent(source, metadata, r'D:\budget-control.wav', date_added=DATE,
                            date_modified=DATE, limits=ReadLimits(memory_budget_bytes=budget))
    saved = copy.deepcopy(intent)
    result = prepare(library_bytes(), intent, {'media': source}, limits=ReadLimits(memory_budget_bytes=budget))
    assert type(result) is ProfileReport and result.blocked
    assert {'media_source_adapter_unavailable', 'identity_adapter_pending_authorized_pin'} <= {b.code for b in result.blockers}
    assert intent == saved and metadata == before and source == pcm(frames=60000, sample=5)
