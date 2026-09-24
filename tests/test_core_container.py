import base64
import json
import random
import struct
import zlib
import pytest
from Crypto.Cipher import AES
from itlkit import Container,FormatError,crypt_length
from test_core_support import pack,library_bytes,be32

@pytest.mark.parametrize('limit',[0,16,102400,102416])
@pytest.mark.parametrize('size',[0,1,15,16,17,65536,180013])
def test_container_exact_and_forced(size,limit):
    payload=random.Random(55).randbytes(size)
    source=pack(payload,limit=limit,level=1)
    c=Container.from_bytes(source)
    assert c.payload==payload and c.to_bytes()==source
    rebuilt=c.to_bytes(rebuild=True,compression_level=9)
    assert Container.from_bytes(rebuilt).payload==payload
    assert int.from_bytes(rebuilt[8:12],'big')==len(rebuilt)
    compressed=zlib.compress(payload,9); n=crypt_length(len(compressed),limit)
    assert rebuilt[144+n:]==compressed[n:]
    assert AES.new(b'BHUILuilfghuila3',AES.MODE_ECB).decrypt(rebuilt[144:144+n])==compressed[:n]


def test_larger_than_100kb_tail_really_plain():
    payload=random.Random(1).randbytes(250000)
    source=pack(payload)
    assert len(source)-144>102400
    c=Container.from_bytes(source)
    assert c.payload==payload
    assert source[144+102400:]==zlib.compress(payload,9)[102400:]


@pytest.mark.parametrize('length',list(range(0,96))+[97,143,144,160])
def test_truncation_is_rejected(length):
    source=library_bytes()
    if length<len(source):
        with pytest.raises(FormatError):Container.from_bytes(source[:length])


def test_invalid_sizes_magic_limit_and_version():
    source=library_bytes()
    for offset,value in [(4,0),(4,len(source)+1),(8,len(source)+1),(92,15)]:
        bad=bytearray(source);be32(bad,offset,value)
        with pytest.raises(FormatError):Container.from_bytes(bad)
    with pytest.raises(FormatError):Container.from_bytes(b'xxxx'+source[4:])
    assert Container.from_bytes(source).version=='12.13.10.3'
    assert crypt_length(102415,102400)==102400
    assert crypt_length(102416,0)==0
    assert crypt_length(102416,0,1)==102416
    assert crypt_length(100,3)==0
    assert crypt_length(100,17)==16


def test_decompression_limit_and_corruption():
    with pytest.raises(FormatError,match='exceeds'):Container.from_bytes(pack(b'x'*100000),max_plain_bytes=100)
    good=pack(b'large payload'*300)
    bad=bytearray(good);bad[146]^=3
    with pytest.raises(FormatError):Container.from_bytes(bad)
    for cut in (1,2,4,10):
        b=bytearray(good[:-cut]);be32(b,8,len(b))
        with pytest.raises(FormatError):Container.from_bytes(b)
    with pytest.raises(ValueError):Container.from_bytes(good,max_plain_bytes=0)


def test_unknown_tail_roundtrips_without_loss():
    source=pack(b'payload',trailer=b'\xff\x00unknown\x00tail')
    c=Container.from_bytes(source)
    assert c.trailer==b'\xff\x00unknown\x00tail'
    assert c.to_bytes()==source
    assert Container.from_bytes(c.to_bytes(rebuild=True)).trailer==c.trailer


def test_container_json_roundtrip_and_digest_guard():
    source=library_bytes(); c=Container.from_bytes(source)
    doc=json.loads(json.dumps(c.to_dict()))
    assert Container.from_dict(doc).to_bytes()==source
    doc['original_sha256']='0'*64
    with pytest.raises(FormatError,match='digest'):Container.from_dict(doc)
    doc=c.to_dict();doc['original_file_b64']='!not base64'
    with pytest.raises(FormatError):Container.from_dict(doc)


def test_container_json_honors_plaintext_budget_before_reconstruction():
    source = pack(b'x' * 4096)
    doc = Container.from_bytes(source).to_dict()
    with pytest.raises(FormatError, match='exceeds'):
        Container.from_dict(doc, max_plain_bytes=128)

    # Isolate the original-file path: the projected payload itself is tiny, but
    # the retained baseline still expands beyond the same caller budget.
    doc['payload_hex'] = ''
    with pytest.raises(FormatError, match='exceeds'):
        Container.from_dict(doc, max_plain_bytes=128)

    direct = Container.from_bytes(pack(b'ab')).to_dict()
    direct['original_file_b64'] = None
    direct['original_sha256'] = None
    direct['payload_hex'] = '61 \n 62\t'
    assert Container.from_dict(direct, max_plain_bytes=2).payload == b'ab'

    direct['payload_hex'] = '00 ' * 129 + 'not-hex'
    with pytest.raises(FormatError, match='exceeds'):
        Container.from_dict(direct, max_plain_bytes=128)
    direct['payload_hex'] = '0'
    with pytest.raises(FormatError, match='invalid container JSON'):
        Container.from_dict(direct, max_plain_bytes=1)
    direct['payload_hex'] = '00\u2003'
    with pytest.raises(FormatError, match='invalid container JSON'):
        Container.from_dict(direct, max_plain_bytes=1)

    exact = Container.from_bytes(pack(b'xyz')).to_dict()
    assert Container.from_dict(exact, max_plain_bytes=3).to_bytes() == pack(b'xyz')
    for invalid in (False, 0, -1, 1.0, '1'):
        with pytest.raises(ValueError, match='positive'):
            Container.from_dict(exact, max_plain_bytes=invalid)


def test_changed_payload_never_reuses_original_ciphertext():
    c=Container.from_bytes(pack(b'first'))
    c.payload=b'second'
    assert Container.from_bytes(c.to_bytes()).payload==b'second'
    assert not c.unchanged
    with pytest.raises(ValueError):c.to_bytes(compression_level=10)