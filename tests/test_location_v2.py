from dataclasses import replace
import struct
import pytest
from itlkit.location import LocationError, plan_location, decode_file_url, location_records, inspect_location_records


@pytest.mark.parametrize('tail', ['simple.wav','space name.wav','100%file.wav','a#b+c.wav','音源 Ω 🎼.wav','caf\u00e9.wav','cafe\u0301.wav'])
def test_roundtrip(tail):
    value = 'D:\\media\\'+tail
    bundle = plan_location(value)
    assert decode_file_url(bundle.url) == value
    records = location_records(bundle)
    assert inspect_location_records(records) == bundle
    assert struct.unpack_from('<I',records[0],24)[0] == (3 if value.isascii() else 1)
    assert struct.unpack_from('<I',records[1],24)[0] == 2


@pytest.mark.parametrize('path', ['relative.wav','D:relative.wav','\\root.wav','\\\\server\\x.wav','\\\\?\\D:\\x.wav','D:\\..\\x','D:\\a\\.\\x','D:\\a\\x:stream','D:\\NUL.wav','D:\\COM1','D:\\LPT\u00b9.txt','D:\\CONOUT$','D:\\bad.','D:\\bad ','D:\\a\x00b','D:\\x\ud800','D:\\'+('x'*256)])
def test_bad_path(path):
    with pytest.raises(LocationError):
        plan_location(path)


@pytest.mark.parametrize('url', ['file://host/D:/x','https://localhost/D:/x','file://localhost/D:/x%','file://localhost/D:/x%GG','file://localhost/D:/x%2f..','file://localhost/D:/x%5c..','file://localhost/D:/x%ff','file://localhost/D:/x?','file://localhost/D:/x#','file://localhost/D:/a b'])
def test_bad_url(url):
    with pytest.raises(LocationError):
        decode_file_url(url)


def test_no_unicode_normalization_or_plus_decoding():
    assert plan_location('D:\\caf\u00e9.wav') != plan_location('D:\\cafe\u0301.wav')
    assert decode_file_url('file://localhost/D:/a+b.wav') == 'D:\\a+b.wav'
    assert '%252F' in plan_location('D:\\literal%2F.wav').url


def test_type1_suffix_alias_and_forgery():
    for payload in (b'', b'opaque'):
        with pytest.raises(LocationError):
            plan_location('D:\\x.wav',type1_payload=payload)
    bundle = plan_location('D:\\x.wav')
    with pytest.raises(LocationError):
        location_records(replace(bundle,url='file://localhost/D:/y.wav'))
    records = location_records(bundle)
    for damaged in ((records[0]+b'opaque',records[1]),(records[0],records[0])):
        with pytest.raises(LocationError):
            inspect_location_records(damaged)


@pytest.mark.parametrize('alias',['NUL .wav','AUX .wav','COM1 .wav','LPT1  .wav','con .txt','PRN  .a.b','COM\u00b9 .wav','LPT\u00b2  .wav'])
@pytest.mark.parametrize('nested',[False,True])
def test_review_loc01_spaces_before_extension_are_devices(alias,nested):
    from urllib.parse import quote
    from itlkit.location import windows_path,decode_file_url,LocationBundle
    path=('D:\\ordinary\\'+alias+'\\track.wav') if nested else 'D:\\'+alias
    url='file://localhost/'+quote(path.replace('\\','/'),safe='/:')
    def raw(typ,ident,text,enc):
        body=text.encode('ascii' if enc in (2,3) else 'utf-16le')
        payload=struct.pack('<IIQ',enc,len(body),0)+body
        return struct.pack('<4sIIIII',b'mhoh',24,24+len(payload),typ,ident,0)+payload
    enc=3 if path.isascii() else 1
    records=(raw(13,1,path,enc),raw(11,2,url,2));before=records
    # No path.open/stat/device operation here. Raw bytes are independent of the planner.
    for operation in (lambda:windows_path(path),lambda:plan_location(path),lambda:decode_file_url(url),
                      lambda:location_records(LocationBundle(path,url,enc)),lambda:inspect_location_records(records)):
        with pytest.raises(LocationError,match='reserved Win32 device'):operation()
    assert records==before


@pytest.mark.parametrize('path',[r'D:\ordinary .wav',r'D:\NULx .wav',r'D:\auxiliary\COM10 .wav',r'D:\part\CON  name.wav'])
def test_review_loc01_ordinary_spaces_are_not_normalized(path):
    from itlkit.location import windows_path,decode_file_url
    assert windows_path(path)==path
    bundle=plan_location(path)
    assert bundle.path==path and decode_file_url(bundle.url)==path
    assert inspect_location_records(location_records(bundle)).path==path
