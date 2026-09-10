import copy
import json
import base64
import hashlib
import dataclasses
import pytest
from itlkit import Container,Library,UnsupportedError
from itlkit.raw import export_raw_tree,import_raw_tree,inspect_coverage,RAW_SCHEMA
from itlkit.schema import ReadLimits
from itlkit.binary import put
from test_core_support import library_bytes,pack,section,record


def sha(b):return hashlib.sha256(b).hexdigest()
def raw_input():return library_bytes(opaque=b'opaque mith miph msdh marker',trailer=b'trailer')
def doc():return export_raw_tree(raw_input())


def test_raw_json_noop_exact_and_legacy_schemas_unchanged():
    data=raw_input();c=Container.from_bytes(data);before=copy.deepcopy(c.__dict__)
    d=export_raw_tree(c);assert d['schema']==RAW_SCHEMA
    assert import_raw_tree(json.dumps(d),research_only=True,expected_baseline_digest=sha(data)).to_bytes()==data
    assert c.__dict__==before and c.to_dict()['schema']=='itlkit.container.v1'
    assert Library.from_bytes(data).to_dict()['schema']=='itlkit.library.v1'


def test_raw_same_size_opaque_edit_only_and_other_bytes_preserved():
    data=raw_input();d=export_raw_tree(data);s=d['sections'][-1]
    old=bytes.fromhex(s['payload_hex']);s['payload_hex']=(b'X'+old[1:]).hex()
    out=import_raw_tree(d,research_only=True,expected_baseline_digest=sha(data))
    before=Container.from_bytes(data)
    assert out.payload[:-len(old)]==before.payload[:-len(old)]
    assert out.payload[-len(old):]==b'X'+old[1:]
    assert out.trailer==before.trailer and out.header[:8]+out.header[12:]==before.header[:8]+before.header[12:]
    assert inspect_coverage(out).profile_report.blocked


@pytest.mark.parametrize('value',[False,None,1,'true'])
def test_raw_explicit_mode_required(value):
    with pytest.raises(ValueError,match='research_only'):import_raw_tree(doc(),research_only=value)


@pytest.mark.parametrize('part',['schema','policy','header','trailer','digest','baseline','section_add',
    'section_remove','child_remove','tag','kind','offset','record_header','resize','extra','missing','leaf_shape','hex'])
def test_tamper_and_unsupported_changes_refuse(part):
    d=doc();s=d['sections'][-1];root=d['sections'][0]
    if part=='schema':d['schema']='itlkit.library.v1'
    elif part=='policy':d['policy']='unsafe'
    elif part=='header':d['header_hex']='00'+d['header_hex'][2:]
    elif part=='trailer':d['trailer_hex']='00'
    elif part=='digest':d['original_sha256']='0'*64
    elif part=='baseline':d['original_file_b64']='bad!'
    elif part=='section_add':d['sections'].append(copy.deepcopy(s))
    elif part=='section_remove':d['sections'].pop()
    elif part=='child_remove':root['children'].clear()
    elif part=='tag':s['tag']='mith'
    elif part=='kind':s['kind']='total'
    elif part=='offset':s['offset']=False
    elif part=='record_header':s['header_hex']='00'+s['header_hex'][2:]
    elif part=='resize':s['payload_hex']+='00'
    elif part=='extra':s['adopt']=True
    elif part=='missing':del s['kind']
    elif part=='leaf_shape':s['children']=[]
    elif part=='hex':s['payload_hex']='zz'+s['payload_hex'][2:]
    snapshot=copy.deepcopy(d)
    with pytest.raises(ValueError):import_raw_tree(d,research_only=True)
    assert d==snapshot


def test_external_baseline_pin_detects_paired_baseline_tamper():
    a=raw_input();b=library_bytes(opaque=b'other wire baseline same!!!')
    other=export_raw_tree(b)
    with pytest.raises(ValueError,match='stale raw baseline'):
        import_raw_tree(other,research_only=True,expected_baseline_digest=sha(a))
    # Without an external pin unsigned JSON has self-consistency, not authenticity.
    assert import_raw_tree(other,research_only=True).to_bytes()==b


def test_duplicate_json_keys_and_cycle_refuse():
    d=doc();wire=json.dumps(d);wire=wire[:-1]+',"schema":"'+RAW_SCHEMA+'"}'
    with pytest.raises(ValueError,match='duplicate'):import_raw_tree(wire,research_only=True)
    d['sections'].append(d)
    with pytest.raises(ValueError,match='cyclic'):import_raw_tree(d,research_only=True)


@pytest.mark.parametrize('limit,value',[('max_file_bytes',1),('max_plain_bytes',16),
    ('max_nodes',1),('max_depth',1),('max_text_bytes',8),('max_json_bytes',32),('memory_budget_bytes',64)])
def test_aggregate_budgets(limit,value):
    limits=ReadLimits(**{limit:value})
    with pytest.raises(ValueError):export_raw_tree(raw_input(),limits=limits)
    with pytest.raises(ValueError):import_raw_tree(doc(),research_only=True,limits=limits)


def test_unknown_embedded_tags_not_interpreted_and_big_endian_container_only():
    data=pack(section(250,b'mith miph msdh mlth'))
    d=export_raw_tree(data);assert len(d['sections'])==1 and 'children' not in d['sections'][0]
    assert import_raw_tree(d,research_only=True).to_bytes()==data
    be=pack(b'opaque arbitrary big endian',little=0)
    with pytest.raises(UnsupportedError):export_raw_tree(be)
    coverage=inspect_coverage(be)
    assert coverage.records[0].payload_level=='opaque_big_endian' and len(coverage.records)==1
    assert Container.from_bytes(be).to_bytes()==be


def test_coverage_unknown_partial_bits_aliases_and_unverified_prefix():
    data=library_bytes();lib=Library.from_bytes(data)
    # Synthetic prefix-shaped unknown metadata: never promote just because it decodes.
    globalnode=lib._root(12).children[0];put(globalnode.header,12,508)
    globalnode.payload=(3).to_bytes(4,'little')+(1).to_bytes(4,'little')+b'\0'*8+b'x'
    before=copy.deepcopy(lib.__dict__)
    r=inspect_coverage(lib)
    assert lib.__dict__==before and r.profile_report.blocked
    track=next(x for x in r.records if x.record_tag=='mith')
    names={f.name for f in track.fields}
    assert set(NUM_NAMES)<=names
    assert any(f.name=='rating_aux_raw' and f.write_level=='none' for f in track.fields)
    site=next(x for x in track.partial_bits if x['offset']==0x6d)
    assert site['known_mask']==1 and site['unknown_mask']==254
    assert sum(s.end-s.start for s in track.unknown_header_ranges)>500
    assert any(x.payload_level=='prefix_decodable_semantics_unverified' and x.payload_details['metadata_type']==508 for x in r.records)
    view=r.to_dict();view['totals']['header_bytes']=-1;assert r.totals['header_bytes']>0


NUM_NAMES=('name','year','rating','played_flag_raw','compilation','loved','unplayed')


def test_coverage_does_not_serialize_dirty_library(monkeypatch):
    lib=Library.from_bytes(library_bytes());put(lib.tracks[0].node.header,8,999)
    before=copy.deepcopy(lib.__dict__)
    def fail(*a,**k):raise AssertionError('input normalized')
    monkeypatch.setattr(lib,'to_bytes',fail)
    r=inspect_coverage(lib)
    assert r.records and lib.container==before['container'] and lib.sections==before['sections']


def test_raw_requires_explicit_current_container_snapshot():
    c=Container.from_bytes(raw_input());c.payload=c.payload[:-1]+b'z'
    with pytest.raises(ValueError,match='serialize and re-read'):export_raw_tree(c)
    with pytest.raises(TypeError):export_raw_tree(Library.from_bytes(library_bytes()))


def test_library_json_cannot_use_raw_edit_path():
    d=Library.from_bytes(library_bytes(opaque=b'abcdef')).to_dict()
    d['sections'][-1]['payload_hex']=b'zbcdef'.hex()
    with pytest.raises(UnsupportedError,match='raw tree edits'):Library.from_dict(d)


def test_json_lexical_budget_precedes_allocating_parser(monkeypatch):
    def fail(*a,**k):raise AssertionError('JSON parser reached before budget check')
    monkeypatch.setattr('itlkit.raw.json.loads',fail)
    with pytest.raises(ValueError,match='lexical'):
        import_raw_tree('{"x":'+('['*120)+(']'*120)+'}',research_only=True)
    with pytest.raises(ValueError,match='budget'):
        import_raw_tree('{"x":['+','.join('[]' for _ in range(100))+']}',research_only=True,
                        limits=ReadLimits(memory_budget_bytes=10000))


def test_current_model_text_budget_and_pascal_padding():
    lib=Library.from_bytes(library_bytes())
    with pytest.raises(ValueError,match='text'):
        inspect_coverage(lib,ReadLimits(max_text_bytes=1))
    r=inspect_coverage(lib);outer=r.records[0]
    assert any(s.start<=27 and s.end>=32 for s in outer.unknown_header_ranges)



def test_escaped_tag_json_is_bounded_and_roundtrips():
    from test_core_support import list_record
    tag=bytes([122,34,92,122])
    data=pack(section(1,list_record(b'mlth',12,[record(tag,12,b'opaque')])))
    d=export_raw_tree(data)
    assert import_raw_tree(json.dumps(d),research_only=True).to_bytes()==data


def test_every_current_named_track_accessor_has_a_coverage_entry():
    from itlkit.library import TEXT_FIELDS,NUMBER_FIELDS
    r=inspect_coverage(Library.from_bytes(library_bytes()))
    track=next(x for x in r.records if x.record_tag=='mith')
    names={f.name for f in track.fields}
    # The legacy +f4 alias maps to one offset-named raw span, not another field.
    assert (set(TEXT_FIELDS)|set(NUMBER_FIELDS)|{'compilation','loved','unplayed'})-{'mith_0xf4_u64_raw'} <= names


def test_g2_f4_single_raw_span_and_float_rate_are_distinct():
    r=inspect_coverage(Library.from_bytes(library_bytes()))
    track=next(x for x in r.records if x.record_tag=='mith')
    fields=[f for f in track.fields if f.offset_or_payload_layout==0xf4]
    assert len(fields)==1 and fields[0].name=='header_0xf4_8_raw'
    assert fields[0].width==8 and fields[0].write_level=='none' and fields[0].namespace is None
    rate=next(f for f in track.fields if f.name=='sample_rate')
    assert rate.offset_or_payload_layout==0x98 and rate.width==4 and rate.read_level=='evidence_mapped_float32'
