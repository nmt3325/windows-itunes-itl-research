from pathlib import Path
import sys,json,hashlib,datetime,zlib,struct
import pefile,capstone
from Crypto.Cipher import AES
root=Path(r'<CI_TEMP_WIN>\<CI_BROKER>\WINDOWS_RESEARCH_RUN\work\itl');r=root/'reports/static';out=r/'phase3'
exe=Path(r'C:\Program Files\iTunes\iTunes.exe');blob=exe.read_bytes();sha=hashlib.sha256(blob).hexdigest();assert sha=='30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d'
pe=pefile.PE(data=blob,fast_load=True);cs=capstone.Cs(capstone.CS_ARCH_X86,capstone.CS_MODE_64);base=pe.OPTIONAL_HEADER.ImageBase
G={int(k,16):v for k,v in json.loads((r/'function_groups.json').read_text()).items()}
targets=[0xec75b0,0xec8180];assert len(targets)<=4
(out/'asm').mkdir(exist_ok=True);atlas=[]
for a in targets:
 ranges=G[a];lines=[f'; iTunes.exe SHA256 {sha}; ImageBase {base:#x}; function RVA {a:#x}'];calls=[]
 for s,e,u in ranges:
  lines.append(f'; unwind group range {s:#x}..{e:#x} (exclusive)')
  for i in cs.disasm(pe.get_data(s,e-s),base+s):
   lines.append(f'{i.address-base:08x} {i.bytes.hex():32s} {i.mnemonic:10s} {i.op_str}')
   if i.mnemonic in ('call','jmp') and i.op_str.startswith('0x'):calls.append({'site_rva':hex(i.address-base),'target_rva':hex(int(i.op_str,16)-base),'mnemonic':i.mnemonic})
 p=out/'asm'/f'{a:08x}.asm';p.write_text('\n'.join(lines)+'\n',encoding='utf-8')
 atlas.append({'rva':hex(a),'bytes':sum(e-s for s,e,u in ranges),'ranges':ranges,'asm_sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'calls':calls})
(out/'targets.txt').write_text(''.join(f'{a:x}\n' for a in targets),encoding='ascii')
(out/'function-atlas.json').write_text(json.dumps({'exe_sha256':sha,'functions':atlas},indent=2),encoding='utf-8')
print('TWO_PHASE3_TARGETS',[(x['rva'],x['bytes']) for x in atlas])
