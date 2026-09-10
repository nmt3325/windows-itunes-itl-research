"""Independent generated controls, no runner paths or fixture admission hashes."""
from dataclasses import replace
from types import SimpleNamespace
import hashlib
import pytest
from test_core_support import record,text,track,item,playlist,list_record,section,pack,u32,u64,be32
from itlkit.graph import build_graph,stable_graph,revalidate_graph,_DEFAULT_LIMITS
from itlkit.container import Container
from itlkit.errors import FormatError,UnsupportedError


def keyed(code,value,identity):
    b=bytearray(text(code,value,1));u32(b,16,identity);return bytes(b)


def sample(*,file_pid=0xFAFBFCFD01020304,opaque=False,alias=False,secondary=False):
    tracks=[]
    for i in range(2):
        children=keyed(2,'Track '+str(i),1 if alias else i+1)+keyed(3,'Album',1)+keyed(4,'Singer',1)+keyed(27,'Ensemble',2)+keyed(12,'Composer',3)
        h=bytearray(record(b'mith',756,children,count=5));u32(h,16,101+2*i);u32(h,0x1f4,102+2*i);u64(h,0x80,0xAACC000000000001+i);u32(h,0xdc,51);u32(h,0x1e0,61)
        tracks.append(bytes(h))
    a=bytearray(record(b'miah',88,keyed(300,'Album',1)+keyed(301,'Ensemble',2)+keyed(302,'Ensemble',2),count=3));u32(a,16,51);u64(a,20,0xBBBB000000000001);u32(a,28,2);u32(a,40,8272)
    ar=bytearray(record(b'miih',100,keyed(400,'Ensemble',2),count=1));u32(ar,16,61);u64(ar,20,0xCCCC000000000001);u32(ar,28,2)
    pl=playlist([101,103],master=True,local_id=71)
    rest=[section(12,list_record(b'mhgh',280,[])),section(9,list_record(b'mlah',92,[bytes(a)])),section(11,list_record(b'mlih',100,[bytes(ar)])),section(1,list_record(b'mlth',92,tracks)),section(2,list_record(b'mlph',92,[pl]))]
    if opaque:rest.append(section(250,b'bounded opaque local and PID data'))
    if secondary:rest.append(section(13,list_record(b'mlth',92,[tracks[0]])))
    h=bytearray(144);h[:4]=b'hdfm';be32(h,4,144);h[16]=10;h[17:27]=b'12.13.10.3';h[0x41]=2;h[0x43]=1;h[0x52]=1;be32(h,92,102400);h[52:60]=file_pid.to_bytes(8,'big')
    m=bytearray(144);m[:4]=b'mfdh';u32(m,4,144);u64(m,52,file_pid);m[0x52]=1
    u32(m,8,240+sum(map(len,rest))+144)
    for off,value in [(48,len(rest)+1),(68,2),(72,1),(76,1),(84,1)]:u32(m,off,value);be32(h,off,value)
    return pack(section(16,m)+b''.join(rest),header=h)


def limits(**updates):
    d=dict(_DEFAULT_LIMITS);d.update(updates);return SimpleNamespace(**d)


def test_bounded_known_graph_and_typed_edges():
    g=build_graph(sample());d=g.to_dict()
    assert not d['issues'] and not g.coverage['pool_blockers']
    assert len(d['tracks'])==2 and len(g.typed_edges)==len(d['strings'])-1+6
    assert any(e.target.namespace=='album.local' for e in g.typed_edges)
    assert d['pools']['L+0x208']['occurrences']==9  # two Artist/AA/Composer + two album + artist


def test_defensive_copies_and_immutable_graph():
    g=build_graph(sample());d=g.to_dict();d['tracks'].clear()
    assert len(g.to_dict()['tracks'])==2
    with pytest.raises((AttributeError,TypeError)):g.coverage['complete_semantic']=True
    with pytest.raises((AttributeError,TypeError)):g.snapshot=None


def test_forged_graph_report_is_not_coverage_authority():
    g=build_graph(sample(opaque=True));d=g.to_dict();d['coverage']['pool_blockers']=[]
    import json
    forged=replace(g,_document=json.dumps(d).encode())
    with pytest.raises(UnsupportedError):revalidate_graph(forged)
    with pytest.raises(TypeError):revalidate_graph(d)


@pytest.mark.parametrize('field,value',[('max_file_bytes',100),('max_plain_bytes',100),('max_nodes',2),('max_text_bytes',2),('max_json_bytes',10),('memory_budget_bytes',10)])
def test_each_budget_enforced(field,value):
    with pytest.raises((FormatError,ValueError)):build_graph(sample(),limits=limits(**{field:value}))


def test_bool_and_partial_limits_refused():
    with pytest.raises(ValueError):build_graph(sample(),limits=limits(max_nodes=True))
    with pytest.raises(ValueError):build_graph(sample(),limits={'max_nodes':5})
    with pytest.raises(FormatError):build_graph(bytearray(sample()))


def test_compact_pool_alias_reported_not_granted():
    d=build_graph(sample(alias=True)).to_dict()
    assert any(x['code']=='pool_id_text_collision' for x in d['issues'])


def test_opaque_sections_and_secondary_consumers_block_atoms():
    assert build_graph(sample(opaque=True)).coverage['pool_blockers']
    d=build_graph(sample(secondary=True)).to_dict()
    assert len(d['strings'])>len(build_graph(sample()).to_dict()['strings'])
    assert d['extra_identities'] and d['coverage']['pool_blockers']


def test_recompression_changes_snapshot_not_stable_graph():
    raw=sample();c=Container.from_bytes(raw);other=c.to_bytes(rebuild=True,compression_level=1)
    g,h=build_graph(raw),build_graph(other)
    assert g.snapshot!=h.snapshot and stable_graph(g)==stable_graph(h)


def test_scoped_ids_do_not_use_sort_cache_values():
    g=build_graph(sample())
    assert all('rank' not in identity.namespace for identity in g.owners)
    assert not g.coverage['opaque_gc_authorized']


# G2 reconstruction: f5 appended graph-test source was not recovered.
@pytest.mark.parametrize('value',[None,True,False,0,2**64-1,-(2**64-1),'simple','\x00\b\t\n\f\r"\\/','\u00e9','\U0001f3b5',{'two':['x',True,None],'one':2},{2:'wire text key'}])
def test_reconstructed_bounded_json_exact_canonical_bytes(value):
    import json
    from itlkit.graph import _bounded_json
    expected=json.dumps(value,sort_keys=True,separators=(',',':'),ensure_ascii=True,allow_nan=False).encode('ascii')
    assert _bounded_json(value,limits(max_json_bytes=len(expected)))==expected
    if len(expected)>1:
        with pytest.raises(FormatError,match='graph_json_budget'):_bounded_json(value,limits(max_json_bytes=len(expected)-1))


def test_reconstructed_graph_cap_before_any_full_json_encoder(monkeypatch):
    import itlkit.graph as module
    raw=sample()
    def forbidden(*args,**kwargs):raise AssertionError('full serialization before max_json admission')
    monkeypatch.setattr(module.json,'dumps',forbidden)
    monkeypatch.setattr(module.json.JSONEncoder,'iterencode',forbidden)
    with pytest.raises(FormatError,match='graph_json_budget'):build_graph(raw,limits=limits(max_json_bytes=1))


def test_reconstructed_large_escaped_text_cap_precedes_encoder(monkeypatch):
    import itlkit.graph as module
    value='\u0000'*100000
    def forbidden(*args,**kwargs):raise AssertionError('escaped text encoded before budget admission')
    monkeypatch.setattr(module.json.JSONEncoder,'iterencode',forbidden)
    with pytest.raises(FormatError,match='graph_json_budget'):module._bounded_json(value,limits(max_json_bytes=200000))


def test_reconstructed_json_cycle_and_type_bounds():
    from itlkit.graph import _bounded_json
    cyclic=[];cyclic.append(cyclic)
    with pytest.raises(FormatError,match='graph_json_cycle'):_bounded_json(cyclic,limits())
    for invalid in (object(),1.5,2**64,{True:'bad key'}):
        with pytest.raises(FormatError):_bounded_json(invalid,limits())


def test_reconstructed_json_aggregate_element_depth_memory_bounds():
    from itlkit.graph import _bounded_json
    with pytest.raises(FormatError,match='element_budget'):_bounded_json([None]*32,limits(max_nodes=1))
    deep=None
    for _ in range(21):deep=[deep]
    with pytest.raises(FormatError,match='depth_budget'):_bounded_json(deep,limits(max_depth=1))
    with pytest.raises(FormatError,match='memory_budget'):_bounded_json('x'*100,limits(memory_budget_bytes=100))


def test_reconstructed_19byte_trailer_inventory_and_immutable_revalidation():
    from itlkit.graph import sha
    trailer=b'opaque'+(0xDADA444433332222).to_bytes(8,'little')+b'tail!'
    assert len(trailer)==19
    c=Container.from_bytes(sample());c.trailer=trailer;raw=c.to_bytes(rebuild=True)
    g=build_graph(raw);d=g.to_dict()
    spans=[s for s in d['opaque_spans'] if s['address_space']=='compression_trailer']
    assert spans==[{'address_space':'compression_trailer','offset':0,'end':19,'section':None,'reason':'unknown_compression_trailer','sha256':sha(trailer)}]
    assert d['trailer_bytes']==19 and g._trailer==trailer
    assert 'pool-disjointness-unproved:compression-trailer' in g.coverage['pool_blockers']
    assert sha(trailer)!=sha(raw)
    with pytest.raises(UnsupportedError,match='tampered'):revalidate_graph(replace(g,_trailer=b''))
    assert revalidate_graph(g)==g


def test_reconstructed_actual_codec_limits_protocol():
    from itlkit.schema import ReadLimits
    g=build_graph(sample(),limits=ReadLimits())
    assert g.coverage['read_limits_protocol_enforced'] and not g.coverage['complete_semantic']
    with pytest.raises(FormatError):build_graph(sample(),limits=ReadLimits(max_nodes=1))
