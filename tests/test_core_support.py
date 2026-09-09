"""Independent synthetic byte fixtures; no original library/media bytes included."""
import struct
import zlib
from Crypto.Cipher import AES

def u32(b, o, n): struct.pack_into('<I', b, o, n)
def u64(b, o, n): struct.pack_into('<Q', b, o, n)
def be32(b, o, n): struct.pack_into('>I', b, o, n)

def record(tag, hlen, payload=b'', *, count=None, fields=()):
    h=bytearray(hlen); h[:4]=tag; u32(h,4,hlen); u32(h,8,hlen+len(payload))
    if count is not None: u32(h,12,count)
    for offset, value in fields: u32(h,offset,value)
    return bytes(h)+payload

def text(code, value, encoding=3, suffix=b''):
    s=value.encode({1:'utf-16le',2:'ascii',3:'latin1'}[encoding])
    return record(b'mhoh',24,struct.pack('<IIII',encoding,len(s),0,0)+s+suffix,fields=[(12,code)])

def track(tid=1, pid=None, title='Synthetic Track'):
    children=text(2,title)+text(4,'Synthetic Artist')+text(3,'Synthetic Album')
    h=bytearray(record(b'mith',756,count=3)); u32(h,8,756+len(children));u32(h,0x10,tid)
    u64(h,0x80,0xABCD000000000000+tid if pid is None else pid)
    u32(h,0x6c,20);u32(h,0x2bc,0x10008001);u32(h,0x1f4,300+tid)
    return bytes(h)+children

def item(tid, iid):
    h=bytearray(record(b'mtph',84,count=0));u32(h,0x10,iid);u32(h,0x18,tid);u32(h,0x20,iid);u64(h,0x44,0x9911000000000000+iid)
    return bytes(h)

def playlist(tids=(), pid=0xBEEF000000000001, name='Synthetic Playlist', *, smart=False, master=False, local_id=4):
    strings=text(100,name)
    if smart: strings+=record(b'mhoh',24,b'Uninterpreted smart rules',fields=[(12,101)])
    payload=strings+b''.join(item(tid,10+i) for i,tid in enumerate(tids))
    h=bytearray(record(b'miph',3500,count=2 if smart else 1));u32(h,8,len(h)+len(payload));u32(h,16,len(tids))
    u64(h,0x1b8,pid);u32(h,0xd40,local_id);u32(h,0x14,0x10000 if master else 0)
    return bytes(h)+payload

def list_record(tag, hlen, records):
    h=bytearray(hlen);h[:4]=tag;u32(h,4,hlen);u32(h,8,len(records))
    return bytes(h)+b''.join(records)

def section(kind,payload):
    return record(b'msdh',96,payload,fields=[(12,kind)])

def pack(payload, *, limit=102400, level=9, trailer=b'', version='12.13.10.3', header=None, encryption=2, compression=1, little=1):
    h=bytearray(144) if header is None else bytearray(header)
    if header is None:
        h[:4]=b'hdfm';be32(h,4,144);h[16]=len(version);h[17:17+len(version)]=version.encode('ascii')
        be32(h,92,limit);h[136:144]=bytes.fromhex('123456789abcdef0')
        h[0x41]=encryption;h[0x43]=compression;h[0x52]=little
    c=(zlib.compress(payload,level)+trailer) if h[0x43] else payload+trailer
    limit=int.from_bytes(h[92:96],'big')
    interval={0:0,1:len(c),2:min(len(c),limit)}[h[0x41]];n=interval//16*16
    c=AES.new(b'BHUILuilfghuila3',AES.MODE_ECB).encrypt(c[:n])+c[n:]
    be32(h,8,len(h)+len(c))
    return bytes(h)+c

def library_bytes(tracks=None, playlists=None, *, opaque=None, trailer=b''):
    tracks=[track()] if tracks is None else tracks
    playlists=[playlist([1])] if playlists is None else playlists
    h=bytearray(144);h[:4]=b'hdfm';be32(h,4,144);h[16]=10;h[17:27]=b'12.13.10.3';be32(h,92,102400)
    h[136:144]=bytes.fromhex('123456789abcdef0');struct.pack_into('>Q',h,52,0xFAFBFCFD01020304)
    h[0x41]=2;h[0x43]=1;h[0x52]=1
    main=bytearray(144);main[:4]=b'mfdh';u32(main,4,144);main[0x52]=1
    mfdh=section(16,main)
    rest=[section(12,list_record(b'mhgh',280,[record(b'mhoh',24,b'opaque mith miph msdh payload',fields=[(12,514)])])),
          section(9,list_record(b'mlah',92,[])),section(11,list_record(b'mlih',100,[])),
          section(1,list_record(b'mlth',92,tracks)),section(2,list_record(b'mlph',92,playlists))]
    if opaque is not None: rest.append(section(250,opaque))
    u32(main,8,len(mfdh)+sum(map(len,rest))+144)
    u32(main,48,1+len(rest));be32(h,48,1+len(rest))
    for o,v in [(68,len(tracks)),(72,len(playlists)),(76,0),(84,0)]:u32(main,o,v);be32(h,o,v)
    payload=section(16,main)+b''.join(rest)
    return pack(payload,header=h,trailer=trailer)