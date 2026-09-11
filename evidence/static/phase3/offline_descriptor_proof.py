"""Execute original x64 leaf/slices in isolated Unicorn memory; no iTunes process or host I/O calls."""
from pathlib import Path
import sys,hashlib,json,struct
ROOT=Path(r'<CI_TEMP_WIN>\<CI_BROKER>\WINDOWS_RESEARCH_RUN\work\itl');OUT=ROOT/'reports/static/phase3'
sys.path.insert(0,str(ROOT/'tools/static/pylibs'))
import pefile
from unicorn import Uc,UC_ARCH_X86,UC_MODE_64
from unicorn.x86_const import *
raw=Path(r'C:\Program Files\iTunes\iTunes.exe').read_bytes();sha=hashlib.sha256(raw).hexdigest()
assert sha=='30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d'
pe=pefile.PE(data=raw,fast_load=True);BASE=pe.OPTIONAL_HEADER.ImageBase
u=Uc(UC_ARCH_X86,UC_MODE_64)
for rva in [0xeb8000,0x106d000,0x107b000]:u.mem_map(BASE+rva,0x1000);u.mem_write(BASE+rva,pe.get_data(rva,0x1000))
C=0x10000000;L=0x20000000;D=0x30000000;H=0x40000100;SP=0x50000800;STOP=0x60000000
for addr in [C,L,D,H&~4095,SP&~4095,STOP]:u.mem_map(addr,0x1000)
def put(addr,v,n=8):u.mem_write(addr,v.to_bytes(n,'little'))
def get(addr,n=8):return int.from_bytes(u.mem_read(addr,n),'little')
u.mem_write(C,bytes(0x1000));put(C+0x10,L)
for i in range(6):put(C+0x160+4*i,0x12340000+i,4)
tests=[]
expected=[(30,0x1768,0x178,0xb0),(31,0x17b0,0x1c0,0xbc),(32,0x17f8,0x208,0xb4),(33,0x17f8,0x208,0xb8),(34,0x17f8,0x208,0xc4),(35,0x1840,0x640,None)]
put(C+0x70,C+0x600)
for idx,album_artist in [(i,1) for i in range(6)]+[(7,0),(7,1),(6,0),(8,0)]:
    u.mem_write(D,b'\xa5'*0x100);put(C+0xb8,album_artist,4);put(SP,STOP)
    for reg,value in [(UC_X86_REG_RCX,C),(UC_X86_REG_RDX,idx),(UC_X86_REG_R8,D),(UC_X86_REG_RSP,SP)]:u.reg_write(reg,value)
    u.emu_start(BASE+0xeb8130,STOP,timeout=1_000_000,count=5000)
    rc=u.reg_read(UC_X86_REG_RAX)&0xffffffff
    row={'kind':'original_sort_descriptor_leaf','index':idx,'album_artist_nonzero':bool(album_artist),'return_u32':hex(rc),'wire_type':get(D+0xc,4),'pool_offset':hex(get(D+0x40)-L) if get(D+0x40) else None,'base_pool_offset':hex(get(D+0x30)-L) if get(D+0x30) else None,'base_member_offset':hex(get(D+0x38)-C) if get(D+0x38) else None,'stored_sort_id':hex(get(D+0x48,4))}
    assert bytes(u.mem_read(D+0x88,0x78))==b'\xa5'*0x78
    if idx<6:
        typ,pool,bpool,member=expected[idx]
        assert rc==0 and get(D+0xc,4)==typ and get(D+0x40)==L+pool and get(D+0x30)==L+bpool
        assert get(D+0x38)==C+(member if member is not None else 0x628)
        assert get(D+0x48,4)==0x12340000+idx
    elif idx==7:
        selected=3 if album_artist else 2
        assert rc==0 and get(D+0xc,4)==0 and get(D+0x40)==L+0x17f8 and get(D+0x48,4)==0x12340000+selected
        assert get(D+0x38)==C+(0xb8 if album_artist else 0xb4)
    else:assert rc==0xffffffce and get(D+0xc,4)==0 and get(D+0x40)==0
    row['passed']=True;tests.append(row)
# Original 106dbed..106dbfd store slice: flags member -> wire byte 6d.
for flags in [0,0x10,0xef,0xff,0x55,0xaa,0x80,4]:
    u.mem_write(H,b'\xa5'*0x100);put(C+0x9a,flags,1)
    u.reg_write(UC_X86_REG_R14,C);u.reg_write(UC_X86_REG_RDI,H)
    u.emu_start(BASE+0x106dbed,BASE+0x106dbfd,timeout=1_000_000,count=100)
    expect=bytearray(b'\xa5'*0x100);expect[0x6d]=(flags>>4)&1
    assert bytes(u.mem_read(H,0x100))==bytes(expect)
    tests.append({'kind':'original_writer_instruction_slice','flags9a':flags,'wire6d':get(H+0x6d,1),'passed':True})
# Original 107b9e5..107ba03 read slice: ONLY wire bit0 is consumed.
for wire in [0,1,2,3,128,129,254,255]:
    flags=0xaa;put(C+0x9a,flags,1);put(H+0x6d,wire,1)
    u.reg_write(UC_X86_REG_RBX,C);u.reg_write(UC_X86_REG_RBP,H-0x40)
    u.emu_start(BASE+0x107b9e5,BASE+0x107ba03,timeout=1_000_000,count=100)
    assert get(C+0x9a,1)==((flags&0xef)|((wire&1)<<4))
    tests.append({'kind':'original_reader_instruction_slice','wire6d':wire,'initial_flags9a':flags,'result_flags9a':get(C+0x9a,1),'passed':True})
report={'status':'passed','module_sha256':sha,'tests':tests,'test_count':len(tests),'original_leaf_cases':10,'original_writer_slice_cases':8,'original_reader_slice_cases':8,'host_calls':0,'native_itunes_execution':False,'limits':['Descriptor uses synthetic C/L pointers and seeded sort IDs.','Reader/writer checks execute bounded original instruction slices, not complete reader/writer functions.','These checks establish pointer and bit mappings, not Fresh rollback causality or native CRUD acceptance.']}
(OUT/'offline-descriptor-proof.json').write_text(json.dumps(report,indent=2),encoding='utf-8')
print('ORIGINAL_CODE_PROOF_PASS',len(tests));print(json.dumps(tests[:10],indent=2))
