"""Offline CPU emulation of selected original iTunes instructions. Never loads or starts iTunes.
AES core and security-cookie instructions are original. Imported VCRUNTIME memmove is modeled.
Reader tests model only two buffered file I/O helpers with an in-memory byte stream.
This is NOT native iTunes acceptance and does not exercise UI/COM/DRM/cloud/device operations.
"""
import argparse
from pathlib import Path
import sys,struct,json,hashlib
_parser=argparse.ArgumentParser(description=__doc__)
_parser.add_argument('--root',type=Path,default=Path(__file__).resolve().parents[2])
_parser.add_argument('--binary',type=Path,required=True)
_parser.add_argument('--output-dir',type=Path)
_parser.add_argument('--pylibs',type=Path)
_args=_parser.parse_args();ROOT=_args.root.resolve();OUTPUT=(_args.output_dir or ROOT/'reports/static').resolve();OUTPUT.mkdir(parents=True,exist_ok=True)
sys.path.insert(0,str((_args.pylibs or ROOT/'tools/static/pylibs').resolve()))
import pefile,unicorn
from unicorn import Uc,UC_ARCH_X86,UC_MODE_64,UC_HOOK_CODE
from unicorn.x86_const import *
from Crypto.Cipher import AES
BINARY=_args.binary.resolve();SHA='30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d'
assert hashlib.sha256(BINARY.read_bytes()).hexdigest()==SHA
pe=pefile.PE(str(BINARY),fast_load=True);BASE=pe.OPTIONAL_HEADER.ImageBase;uc=Uc(UC_ARCH_X86,UC_MODE_64)
uc.mem_map(BASE,(pe.OPTIONAL_HEADER.SizeOfImage+4095)&~4095);uc.mem_write(BASE,pe.get_memory_mapped_image())
ARENA=0x50000000;uc.mem_map(ARENA,0x2400000);STACK=0x70000000;uc.mem_map(STACK,0x200000);STOP=ARENA
CTX=ARENA+0x1000;KEY=ARENA+0x2000;SCHED=ARENA+0x3000;IN=ARENA+0x4000;OUT=ARENA+0x6000;N=ARENA+0x8000;READER=ARENA+0x100000
regs=[UC_X86_REG_RAX,UC_X86_REG_RBX,UC_X86_REG_RCX,UC_X86_REG_RDX,UC_X86_REG_RSI,UC_X86_REG_RDI,UC_X86_REG_RBP,UC_X86_REG_R8,UC_X86_REG_R9,UC_X86_REG_R10,UC_X86_REG_R11,UC_X86_REG_R12,UC_X86_REG_R13,UC_X86_REG_R14,UC_X86_REG_R15]
def p64(a,v):uc.mem_write(a,struct.pack('<Q',v&0xffffffffffffffff))
def p32(a,v):uc.mem_write(a,struct.pack('<I',v&0xffffffff))
def u64(a):return struct.unpack('<Q',uc.mem_read(a,8))[0]
def u32(a):return struct.unpack('<I',uc.mem_read(a,4))[0]
def call(rva,*args):
 for reg in regs:uc.reg_write(reg,0)
 sp=STACK+0x100000-8;uc.reg_write(UC_X86_REG_RSP,sp);p64(sp,STOP)
 for reg,value in zip([UC_X86_REG_RCX,UC_X86_REG_RDX,UC_X86_REG_R8,UC_X86_REG_R9],args):uc.reg_write(reg,value)
 for i,value in enumerate(args[4:]):p64(sp+0x28+i*8,value)
 try:uc.emu_start(BASE+rva,STOP,timeout=5_000_000,count=2_000_000)
 except Exception as ex:raise RuntimeError(f'RVA {rva:x} emulator RIP={uc.reg_read(UC_X86_REG_RIP):x}: {ex}') from ex
 assert uc.reg_read(UC_X86_REG_RIP)==STOP,f'bounded execution did not return at {rva:x}'
 return uc.reg_read(UC_X86_REG_RAX)&0xffffffff

def setup(key,direction):
 uc.mem_write(CTX,bytes(0x100));uc.mem_write(SCHED,bytes(0x204));uc.mem_write(KEY,key)
 assert call(0xbfbe20,CTX,direction)==0
 call(0xbf9a90,direction,KEY,128,SCHED)
 uc.mem_write(CTX,b'\x01');p64(CTX+0x10,KEY);uc.mem_write(CTX+0x18,b'\x10');p64(CTX+0x20,SCHED)

def crypt(data,key,direction):
 setup(key,direction);uc.mem_write(IN,data or b'\0');uc.mem_write(OUT,b'\xcc'*max(1,len(data)));p32(N,len(data))
 ret=call(0xbfc580,CTX,IN,len(data),OUT,N)
 return ret,bytes(uc.mem_read(OUT,len(data))),u32(N)

# PE-verified thunk +0x1867875 -> VCRUNTIME140.dll!memmove IAT +0x18ec078.
# A raw PE has import-name RVAs rather than resolved host function addresses.
# Model this standard pure-memory operation; do not load any host iTunes dependency.
def memmove_model(uc,address,size,user):
 dest=uc.reg_read(UC_X86_REG_RCX);src=uc.reg_read(UC_X86_REG_RDX);n=uc.reg_read(UC_X86_REG_R8)
 assert n<=0x2000000
 if n:uc.mem_write(dest,bytes(uc.mem_read(src,n)))
 sp=uc.reg_read(UC_X86_REG_RSP);target=u64(sp);uc.reg_write(UC_X86_REG_RAX,dest);uc.reg_write(UC_X86_REG_RSP,sp+8);uc.reg_write(UC_X86_REG_RIP,target)
uc.hook_add(UC_HOOK_CODE,memmove_model,begin=BASE+0x1867875,end=BASE+0x1867875)

results=[];result={'kind':'offline_unicorn_original_machine_code','module':'iTunes.exe','sha256':SHA,'unicorn':unicorn.__version__,'native_iTunes_acceptance':False,'host_executable_loaded':False,'binary_patches':[],'tests':results}
try:
 k=bytes(range(16));plain=bytes.fromhex('00112233445566778899aabbccddeeff');expected=bytes.fromhex('69c4e0d86a7b0430d8cdb78070b4c55a')
 ret,out,n=crypt(plain,k,1);assert (ret,out,n)==(0,expected,16),(ret,out.hex(),n)
 results.append({'name':'FIPS197_AES128_encrypt','pass':True,'ciphertext':out.hex()});print('PASS FIPS197_AES128_encrypt',out.hex(),flush=True)
 ret,out,n=crypt(expected,k,2);assert (ret,out,n)==(0,plain,16)
 results.append({'name':'FIPS197_AES128_decrypt','pass':True})
 itk=bytes(pe.get_data(0x1b63af0,16));assert itk==b'BHUILuilfghuila3'
 for length in [1,15,16,17,31,32,33,63,64,65,127,128,129]:
  source=bytes((i*37+11)&255 for i in range(length));boundary=length&~15
  expected=AES.new(itk,AES.MODE_ECB).encrypt(source[:boundary])+source[boundary:]
  ret,out,n=crypt(source,itk,1);assert (ret,out,n)==(0,expected,length),(length,ret,out.hex(),expected.hex(),n)
  ret,back,n=crypt(out,itk,2);assert (ret,back,n)==(0,source,length)
  results.append({'name':'ITL_key_ECB_tail_roundtrip','length':length,'transformed':boundary,'pass':True})
 print('PASS 13 ECB tail lengths, original encryption/decryption code',flush=True)
 ret,out,n=crypt(bytes(32),itk,1);assert out[:16]==out[16:];results.append({'name':'equal_blocks_equal_ciphertext','pass':True})
 ret,out,n=crypt(b'',itk,1);assert ret==0x2070;results.append({'name':'zero_length_wrapper_rejected','return_hex':hex(ret),'pass':True})
 # The next two hooks model buffered I/O only. All cryptographic instructions remain original.
 stream={'data':b'','pos':0};io_calls=[]
 def ret_to_caller(value):
  sp=uc.reg_read(UC_X86_REG_RSP);dest=u64(sp);uc.reg_write(UC_X86_REG_RAX,value&0xffffffff);uc.reg_write(UC_X86_REG_RSP,sp+8);uc.reg_write(UC_X86_REG_RIP,dest)
 def io_hook(uc,address,size,user):
  rva=address-BASE
  if rva==0xba09a0:
   stream['pos']=uc.reg_read(UC_X86_REG_RDX);io_calls.append(['seek',stream['pos']]);ret_to_caller(0)
  elif rva==0xba0350:
   countptr=uc.reg_read(UC_X86_REG_RDX);dest=uc.reg_read(UC_X86_REG_R8);want=u64(countptr);chunk=stream['data'][stream['pos']:stream['pos']+want]
   if chunk:uc.mem_write(dest,chunk)
   stream['pos']+=len(chunk);p64(countptr,len(chunk));io_calls.append(['read',want,len(chunk)]);ret_to_caller(0 if len(chunk)==want else -39)
 h1=uc.hook_add(UC_HOOK_CODE,io_hook,begin=BASE+0xba09a0,end=BASE+0xba09a0);h2=uc.hook_add(UC_HOOK_CODE,io_hook,begin=BASE+0xba0350,end=BASE+0xba0350)
 for flag,cap in [(0,0),(1,0)]+[(2,x) for x in [0,1,15,16,17,31,32,33,128,129,0x19000]]:
  source=bytes((i*53+7)&255 for i in range(129));boundary=(min(len(source),cap) if flag==2 else len(source) if flag==1 else 0)&~15
  body=AES.new(itk,AES.MODE_ECB).encrypt(source[:boundary])+source[boundary:];stream['data']=bytes(0x90)+body;stream['pos']=0;io_calls.clear()
  setup(itk,2);uc.mem_write(READER+0x1e00128,bytes(uc.mem_read(CTX,0x38)));p64(READER+0x120,ARENA+0x9000);p64(READER+0x1e00160,0x90 if flag else 0xffffffffffffffff);p64(READER+0x1e00168,0x90+cap if flag==2 else 0xffffffffffffffff);p64(READER+0x1e00170,0x90);p64(READER+0x1e00178,0);p64(READER+0x1e00180,0)
  uc.mem_write(OUT,bytes(129));ret=call(0x10770a0,READER,OUT,129);out=bytes(uc.mem_read(OUT,129));assert (ret,out)==(0,source),(flag,cap,ret,out.hex())
  results.append({'name':'reader_crypto_interval','flag_from_observed_main_reader':flag,'cap':cap,'transformed':boundary,'pass':True,'modeled_io':list(io_calls)})
 uc.hook_del(h1);uc.hook_del(h2);result['modeled_functions_for_reader_tests']=['iTunes.exe+0xba09a0 seek','iTunes.exe+0xba0350 read with EOF -39'];result['success']=True
 print('PASS 13 buffered-reader interval cases including flag2 cap0',flush=True)
 result['modeled_standard_imports']=['VCRUNTIME140.dll!memmove via iTunes.exe+0x1867875 (IAT RVA 0x18ec078)']
 # Original text-record writer; imports are limited to the same memmove model.
 for little in [True,False]:
  endian='<' if little else '>';uc.mem_write(READER+0x52,bytes([int(little)]))
  for text in ['Caf\u00e9','\u65e5\u672c\u8a9e\U0001f642','\u00e9'*255,'\u00e9'*256]:
   source=text.encode('utf-16le');uc.mem_write(IN,source);uc.mem_write(OUT,bytes(2048));p64(N,OUT)
   ret=call(0x106ac80,READER,IN,len(source),7,2,1,N);record=bytes(uc.mem_read(OUT,u64(N)-OUT))
   expected_enc=3 if len(source)<0x1ff and all(ord(c)<=255 for c in text) else 1
   expected_data=text.encode('latin-1' if expected_enc==3 else 'utf-16le' if little else 'utf-16be')
   h=struct.unpack(endian+'6I',record[:24]);enc,n=struct.unpack(endian+'2I',record[24:32])
   assert ret==0 and h==(0x686f686d,24,40+len(expected_data),2,7,0),(ret,h)
   assert enc==expected_enc and n==len(expected_data) and record[40:]==expected_data,(enc,n,record.hex())
   results.append({'name':'mhoh_native_text_writer','little_endian':little,'characters':len(text),'encoding':enc,'data_length':n,'pass':True})
 for kind in [1,0x13,0x42]:
  source=b'binary_\x00\xff';uc.mem_write(IN,source);uc.mem_write(OUT,bytes(2048));p64(N,OUT);uc.mem_write(READER+0x52,b'\x01')
  ret=call(0x106ac80,READER,IN,len(source),0,kind,0,N);record=bytes(uc.mem_read(OUT,u64(N)-OUT))
  assert ret==0 and len(record)==24+len(source) and record[24:]==source
  results.append({'name':'mhoh_direct_payload_types','type':kind,'total_length':len(record),'pass':True})
 print('PASS 8 text/endian/threshold cases and 3 direct payload types',flush=True)

except Exception as ex:
 result['success']=False;result['error']=repr(ex);raise
finally:
 (OUTPUT/'offline-emulation.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
 print('SAVED offline-emulation.json tests=',len(results),'success=',result.get('success'),flush=True)
