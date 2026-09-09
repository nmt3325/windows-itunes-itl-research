import copy
import struct
import pytest
from itlkit import Library,Container,Node,FormatError,parse_sections,serialize_sections
from test_core_support import library_bytes,section,record,list_record,text,track,playlist,pack,u32


def test_all_bytes_modeled_and_tag_like_payload_not_scanned():
    phantom=record(b'mith',756,text(2,'not a real track'),count=1)
    source=library_bytes(opaque=b'raw-prefix'+phantom+b'msdh miph\x00')
    c=Container.from_bytes(source); sections=parse_sections(c.payload)
    assert serialize_sections(sections)==c.payload
    lib=Library.from_bytes(source)
    assert len(lib.tracks)==1
    assert lib.sections[-1].children is None
    assert lib.to_bytes()==source
    assert Library.from_bytes(lib.to_bytes(rebuild=True)).to_bytes()==lib.to_bytes(rebuild=True)


def test_unknown_framed_child_is_opaque():
    unknown=record(b'Xxxx',16,record(b'mith',756,count=0))
    data=section(12,list_record(b'mhgh',280,[unknown]))
    sections=parse_sections(data)
    root=sections[0].children[0]
    assert root.children[0].tag==b'Xxxx' and root.children[0].children is None
    assert serialize_sections(sections)==data


@pytest.mark.parametrize('bad',[b'',b'x',b'msdh'+b'\0'*8])
def test_invalid_outer_section_prefix(bad):
    if not bad:
        assert parse_sections(bad)==[]
    else:
        with pytest.raises(FormatError):parse_sections(bad)


@pytest.mark.parametrize('offset,value',[(4,0),(4,999999),(8,4),(8,999999)])
def test_bad_section_lengths(offset,value):
    data=bytearray(section(250,b'abc'));u32(data,offset,value)
    with pytest.raises(FormatError):parse_sections(data)


def test_mismatched_record_counts_and_bad_child_size():
    for payload in [list_record(b'mlth',92,[track()])[:-1],list_record(b'mlth',92,[track()])+b'x']:
        with pytest.raises(FormatError):parse_sections(section(1,payload))
    payload=bytearray(list_record(b'mlth',92,[track()]));u32(payload,8,3)
    with pytest.raises(FormatError,match='count'):parse_sections(section(1,payload))


def test_recursive_depth_guard():
    payload=record(b'mhoh',24,b'',fields=[(12,8)])
    for _ in range(40):payload=record(b'mith',16,payload,count=1)
    with pytest.raises(FormatError,match='depth'):parse_sections(section(1,list_record(b'mlth',92,[payload])))


def test_json_node_roundtrip_and_invalid_model():
    lib=Library.from_bytes(library_bytes(opaque=b'unchanged'))
    for sec in lib.sections:
        assert Node.from_dict(sec.to_dict()).to_bytes()==sec.to_bytes()
    node=copy.deepcopy(lib.sections[0]);node.payload=b'ambiguous'
    with pytest.raises(FormatError):node.to_bytes()
    with pytest.raises(FormatError):Node.from_dict({'header_hex':'xx','kind':'total'})


def test_duplicate_ids_and_dangling_refs_rejected():
    for source in [library_bytes(tracks=[track(),track()],playlists=[]),
                   library_bytes(tracks=[track(1,pid=123),track(2,pid=123)],playlists=[]),
                   library_bytes(tracks=[track(1,pid=0)],playlists=[]),
                   library_bytes(tracks=[],playlists=[playlist([99])]),
                   library_bytes(playlists=[playlist([1]),playlist([1])])]:
        with pytest.raises(FormatError):Library.from_bytes(source)


def test_global_count_and_logical_length_validation():
    c=Container.from_bytes(library_bytes())
    for offset in [96+8,96+48,96+68]:
        raw=bytearray(c.payload);u32(raw,offset,123456);c2=Container(c.header,bytes(raw))
        with pytest.raises(FormatError):Library.from_bytes(c2.to_bytes())