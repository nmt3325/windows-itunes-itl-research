from pathlib import Path
import sys,json,hashlib,datetime,zlib,struct
import pefile,capstone
from Crypto.Cipher import AES
root=Path(r'D:\a\_temp\gha-mcp\WINDOWS_RESEARCH_RUN\work\itl');r=root/'reports/static';out=r/'phase2'
exe=Path(r'C:\Program Files\iTunes\iTunes.exe');blob=exe.read_bytes();sha=hashlib.sha256(blob).hexdigest();assert sha=='30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d'
pe=pefile.PE(data=blob,fast_load=True);cs=capstone.Cs(capstone.CS_ARCH_X86,capstone.CS_MODE_64);base=pe.OPTIONAL_HEADER.ImageBase
G={int(k,16):v for k,v in json.loads((r/'function_groups.json').read_text()).items()}
targets=[0x1078140,0x1078bb0,0xbfe1f0,0xbfe500];assert len(targets)<=6
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
print('FOUR_TARGETS',[(x['rva'],x['bytes']) for x in atlas])
ls=(r/'decompiled/0106b030.c').read_text().splitlines();print('POOL_WRITER_HELPER');print('\n'.join(f'{i+1}: {l}' for i,l in enumerate(ls)))
f=root/'fixtures/dynamic/snapshots/003-three-tracks-reloaded.itl';d=f.read_bytes();h=int.from_bytes(d[4:8],'big');b=d[h:];n=(min(len(b),int.from_bytes(d[0x5c:0x60],'big')) if d[0x41]==2 else len(b) if d[0x41]==1 else 0)&~15;b=AES.new(b'BHUILuilfghuila3',AES.MODE_ECB).decrypt(b[:n])+b[n:];p=zlib.decompress(b) if d[0x43] else b;e='little' if d[0x52] else 'big';off=0;sections=[]
while off<len(p):
 tag=p[off:off+4];hl=int.from_bytes(p[off+4:off+8],e);tl=int.from_bytes(p[off+8:off+12],e);typ=int.from_bytes(p[off+12:off+16],e);assert hl>=16 and tl>=hl and off+tl<=len(p)
 sections.append({'offset':off,'tag':tag.decode('ascii'),'header':hl,'total':tl,'type':typ,'first_child_prefix':p[off+hl:off+hl+12].hex()});off+=tl
print('NATIVE_SECTION_SHAPES',json.dumps(sections));print('PREPARED_PHASE2')
