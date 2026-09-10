import dataclasses
import pytest
from itlkit.schema import (ReadLimits, LimitError, ProfileReport, FieldSpec, ByteSpan,
    ScopedID, AllocationReservation, AllocationLedger, ReferenceGraph, Blocker,
    encode_json, load_library, preflight_payload, read_bytes)
from itlkit.container import Container
from test_core_support import library_bytes, section, record, pack


def test_defaults_and_legacy_cap_separate():
    from itlkit.container import DEFAULT_MAX_PLAIN_BYTES
    limits=ReadLimits()
    assert limits.max_file_bytes==limits.max_plain_bytes==16*1024**2
    assert limits.memory_budget_bytes==DEFAULT_MAX_PLAIN_BYTES==512*1024**2
    assert limits.max_nodes==100000 and limits.max_depth==32
    assert limits.max_text_bytes==4*1024**2 and limits.max_json_bytes==64*1024**2


@pytest.mark.parametrize('name',[f.name for f in dataclasses.fields(ReadLimits)])
@pytest.mark.parametrize('value',[0,-1,True,1.5,'1'])
def test_invalid_limits(name,value):
    with pytest.raises(ValueError):ReadLimits(**{name:value})


def test_records_are_defensive_and_reports_detached():
    original={'matched':['one']}
    graph=ReferenceGraph(coverage=original)
    original['matched'].append('two')
    assert graph.coverage['matched']==('one',)
    with pytest.raises(TypeError):graph.coverage['x']=1
    report=graph.to_dict();report['matched']=False
    assert graph.coverage['matched']==('one',)
    assert ProfileReport(blockers=[Blocker('unknown','opaque')]).blocked


def test_scopes_and_ledger_capacity_are_explicit():
    a=ScopedID('track.pid','library-A',7,8);b=ScopedID('album.pid','library-A',7,8)
    assert a!=b
    r=AllocationReservation(a.namespace,a.scope,None,a,['track'],{'passed':True,'upper':2**64-1})
    ledger=AllocationLedger([r]);assert tuple(ledger)==(r,)
    with pytest.raises(ValueError):AllocationLedger([r,r])
    with pytest.raises(ValueError):AllocationReservation(b.namespace,b.scope,None,a,[],{'passed':True})
    with pytest.raises(ValueError):AllocationReservation(a.namespace,a.scope,None,a,[],{'passed':False})
    with pytest.raises(ValueError):ScopedID('track.pid','library-A',True,8)


def test_field_evidence_is_not_automatic_write_permission():
    f=FieldSpec('mith',1,'observed',756,0x6d,1,'little',1,None,
        'partial-bit','none',('library.py',),(ByteSpan(110,112),), 'name_refresh')
    assert f.signedness_or_mask==1 and f.write_level=='none'
    with pytest.raises(ValueError):dataclasses.replace(f,evidence_refs=())
    with pytest.raises(ValueError):dataclasses.replace(f,opaque_ranges=(ByteSpan(750,757),))


def test_bounded_reader_normal_and_limits(tmp_path):
    data=library_bytes();path=tmp_path/'input.itl';path.write_bytes(data)
    assert read_bytes(path)==data and load_library(data).tracks[0].track_id==1
    for kwargs in ({'max_file_bytes':len(data)-1},{'max_plain_bytes':32},
                   {'max_nodes':3},{'max_text_bytes':8},{'memory_budget_bytes':64},{'max_depth':1}):
        with pytest.raises(ValueError):load_library(data,limits=ReadLimits(**kwargs))
    with pytest.raises(LimitError):read_bytes(path,limits=ReadLimits(max_file_bytes=1))
    with pytest.raises(TypeError):load_library(bytearray(data))


def test_unknown_payload_not_tag_scanned():
    c=Container.from_bytes(pack(section(250,b'mith miph msdh'*20)))
    assert preflight_payload(c.payload)['nodes']==1


def test_json_budget_and_nan():
    assert encode_json({'x':'日本語'})==b'{"x":"\\u65e5\\u672c\\u8a9e"}'
    with pytest.raises(LimitError):encode_json({'x':'x'*20},limits=ReadLimits(max_json_bytes=10))
    with pytest.raises(ValueError):encode_json({'x':float('nan')})
    with pytest.raises(ValueError):ReadLimits(max_depth=33)
    cyclic=[];cyclic.append(cyclic)
    with pytest.raises(ValueError,match='cyclic'):encode_json(cyclic)
    deep=[];v=deep
    for _ in range(120):v.append([]);v=v[0]
    with pytest.raises(ValueError,match='nesting'):encode_json(deep)
