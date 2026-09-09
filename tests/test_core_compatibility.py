"""Independent vectors: input packing/expected decoding never use codec helpers.

AES is the standard primitive; interval, flag, envelope and text expectations
are separately constructed from the native-code audit, not writer roundtrips.
"""
import copy
import hashlib
import random
import struct
import zlib
import pytest
from Crypto.Cipher import AES
from itlkit import Container,Library,Node,FormatError,UnsupportedError,crypt_length
from itlkit.library import read_text,set_text,text_nodes
from test_core_support import library_bytes

KEY=b'BHUILuilfghuila3'


def interval(size,flag,cap):
    selected=0 if flag==0 else size if flag==1 else min(size,cap)
    return (selected//16)*16


def vector(payload,flag=2,cap=102400,compression=1,little=1,level=1):
    encoded=zlib.compress(payload,level) if compression else bytes(payload)
    n=interval(len(encoded),flag,cap)
    body=(AES.new(KEY,AES.MODE_ECB).encrypt(encoded[:n])+encoded[n:]) if n else encoded
    h=bytearray(144);h[:4]=b'hdfm';struct.pack_into('>II',h,4,144,144+len(body))
    struct.pack_into('>HH',h,12,0x43,1);h[16]=10;h[17:27]=b'12.13.10.3'
    h[0x41]=flag;h[0x43]=compression;h[0x52]=little;struct.pack_into('>I',h,92,cap)
    h[136:144]=b'P2opaque'
    return bytes(h)+body


def oracle(encoded_file):
    hlen=struct.unpack_from('>I',encoded_file,4)[0]
    cap=struct.unpack_from('>I',encoded_file,92)[0];body=encoded_file[hlen:]
    flag=encoded_file[0x41]
    if flag not in (0,1,2):raise ValueError('unknown mode')
    n=interval(len(body),flag,cap)
    plain=AES.new(KEY,AES.MODE_ECB).decrypt(body[:n])+body[n:] if n else body
    return zlib.decompress(plain) if encoded_file[0x43] else plain


@pytest.mark.parametrize('flag',[0,1,2])
@pytest.mark.parametrize('cap',[0,1,15,16,17,31,102400,102401,0xffffffff])
@pytest.mark.parametrize('compression',[0,1])
@pytest.mark.parametrize('size',[0,1,15,16,17,251,131117])
def test_independent_envelope_vectors(flag,cap,compression,size):
    payload=random.Random(9901).randbytes(size);source=vector(payload,flag,cap,compression)
    c=Container.from_bytes(source)
    assert c.payload==payload and c.trailer==b'' and c.to_bytes()==source
    assert c.encryption_flag==flag and c.compression_flag==compression and c.payload_byteorder=='little'
    rebuilt=c.to_bytes(rebuild=True)
    assert rebuilt==vector(payload,flag,cap,compression,level=6)
    assert oracle(rebuilt)==payload and rebuilt[136:144]==b'P2opaque'
    c.payload=b'modified\x00'+payload
    assert oracle(c.to_bytes())==c.payload


@pytest.mark.parametrize('flag',[0,1,2])
@pytest.mark.parametrize('compression',[2,255])
@pytest.mark.parametrize('little',[1,2,255])
def test_native_boolean_fields_not_invented_closed_enums(flag,compression,little):
    source=vector(b'nonzero Boolean fields',flag,17,compression,little)
    c=Container.from_bytes(source);assert c.payload_byteorder=='little'
    assert c.compression_flag==compression and oracle(c.to_bytes(rebuild=True))==c.payload


@pytest.mark.parametrize('flag',[3,4,17,255])
def test_unknown_encryption_flags_fail_before_any_success(flag):
    data=bytearray(vector(b'valid body',0));data[0x41]=flag
    with pytest.raises(UnsupportedError,match='encryption flag'):Container.from_bytes(data)
    c=Container.from_bytes(vector(b'valid body',0));c.header=bytes(data[:144])
    for rebuild in [False,True]:
        with pytest.raises(UnsupportedError):c.to_bytes(rebuild=rebuild)
    with pytest.raises(UnsupportedError):Container.from_dict(c.to_dict())


@pytest.mark.parametrize('args',[(True,16),(1.0,16),(1,'16'),(-1,16),(1,-1)])
def test_crypt_interval_rejects_bad_numeric_types(args):
    with pytest.raises(FormatError):crypt_length(*args)


def test_uncompressed_is_not_implicitly_inflated_and_is_budgeted():
    embedded=zlib.compress(b'inner stream must stay opaque')
    c=Container.from_bytes(vector(embedded,0,compression=0))
    assert c.payload==embedded and c.trailer==b''
    with pytest.raises(FormatError,match='exceeds'):
        Container.from_bytes(vector(b'x'*101,1,compression=0),max_plain_bytes=100)
    c.trailer=b'not a separately identifiable raw trailer'
    with pytest.raises(UnsupportedError):c.to_bytes()


def test_big_endian_is_preserved_raw_but_never_claimed_as_semantic_le():
    be_record=struct.pack('>4sIII',b'hdsm',96,96,250)+b'\0'*80
    data=vector(be_record,little=0)
    c=Container.from_bytes(data);assert c.payload==be_record and c.payload_byteorder=='big'
    assert c.to_bytes()==data and oracle(c.to_bytes(rebuild=True))==be_record
    assert Container.from_dict(c.to_dict()).to_bytes()==data
    with pytest.raises(UnsupportedError,match='little-endian'):Library.from_bytes(data)
    contradictory=bytearray(library_bytes());contradictory[0x52]=0
    assert Container.from_bytes(contradictory).payload==Container.from_bytes(library_bytes()).payload
    with pytest.raises(UnsupportedError):Library.from_bytes(contradictory)
    with pytest.raises(UnsupportedError):Library(Container.from_bytes(contradictory))


def test_mutated_endian_is_rejected_at_write_and_edit_boundaries():
    lib=Library.from_bytes(library_bytes());before=lib.sections[0].to_bytes()
    h=bytearray(lib.container.header);h[0x52]=0;lib.container.header=bytes(h)
    for operation in [lib.to_bytes,lib._require_semantic_profile,lambda:lib.tracks[0].set(name='unsafe'),lambda:lib.playlists[0].rename('unsafe')]:
        with pytest.raises(UnsupportedError,match='little-endian'):operation()
    assert lib.sections[0].to_bytes()==before


def string_node(encoding,data,code=2,suffix=b''):
    h=bytearray(struct.pack('<4sIIIII',b'mhoh',24,40+len(data)+len(suffix),code,0x77331199,0))
    return Node(h,payload=struct.pack('<IIII',encoding,len(data),0x12345678,0xaabbccdd)+data+suffix)


@pytest.mark.parametrize('data,expected',[(b'Caf\xe9','Café'),(b'\xff','ÿ'),(b'\xc3\xa9','Ã©'),(b'\xc3\xbf','Ã¿'),(bytes(range(256)),''.join(map(chr,range(256))))])
def test_encoding_three_zero_extends_every_byte_including_utf8_lookalikes(data,expected):
    n=string_node(3,data);before=n.to_bytes()
    assert read_text(n)==expected and n.to_bytes()==before


@pytest.mark.parametrize('value',['Café','ÿ','日本語','emoji 🎵🧪','e\u0301','é'*255,'é'*256])
def test_unicode_one_and_transitions_preserve_other_fields(value):
    n=string_node(1,value.encode('utf-16-le'));assert read_text(n)==value
    old=string_node(3,b'Caf\xe9');parent=Node(bytearray(756),children=[old])
    prefix=old.payload[8:16];identity=old.header[16:24]
    set_text(parent,2,value);assert read_text(old)==value
    assert old.payload[8:16]==prefix and old.header[16:24]==identity


@pytest.mark.parametrize('encoding',[0,4,99,0xffffffff])
def test_unknown_text_encodings_stay_opaque(encoding):
    node=string_node(encoding,b'untouched bytes');before=node.to_bytes()
    with pytest.raises(UnsupportedError):read_text(node)
    assert node.to_bytes()==before


def test_encoding_two_scope_keeps_real_ascii_urls_without_guessing_other_types():
    value=b'file:///C:/Music/alpha.wav';node=string_node(2,value,11)
    assert read_text(node)==value.decode('ascii')
    for other in [string_node(2,b'Caf\xe9',11),string_node(2,b'Name',2)]:
        before=other.to_bytes()
        with pytest.raises(UnsupportedError,match='encoding 2'):read_text(other)
        assert other.to_bytes()==before


@pytest.mark.parametrize('code',[1,0x13,0x42])
def test_direct_payload_types_are_not_accidental_text(code):
    node=string_node(3,b'text-looking binary',code);before=node.to_bytes()
    with pytest.raises(UnsupportedError):read_text(node)
    with pytest.raises(UnsupportedError):set_text(Node(bytearray(756),children=[]),code,'text')
    assert node.to_bytes()==before


def test_rating_aux_and_loved_byte_neighbor_sentinels():
    lib=Library.from_bytes(library_bytes());t=lib.tracks[0]
    t.node.header[0x6d:0x70]=b'\x01\x96\xa9';t.node.header[0x2bc:0x2c0]=b'\x83\x96\xa9\xa5'
    t.set(rating=80,loved=True)
    assert t.node.header[0x6c:0x70]==b'\x50\x01\x96\xa9'
    assert t.node.header[0x2bc:0x2c0]==b'\x83\x96\xa9\xa7'
    t.set(loved=False);assert t.node.header[0x2bc:0x2c0]==b'\x83\x96\xa9\xa5'