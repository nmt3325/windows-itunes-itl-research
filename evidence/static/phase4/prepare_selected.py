"""Prepare only four selected functions and an isolated copy of the existing project."""
from pathlib import Path
import json,hashlib,shutil
import pefile
from capstone import Cs,CS_ARCH_X86,CS_MODE_64
ROOT=Path(r'D:\a\_temp\gha-mcp\WINDOWS_RESEARCH_RUN\work\itl');R=ROOT/'reports/static';O=R/'phase4';EXE=Path(r'C:\Program Files\iTunes\iTunes.exe')
sha=hashlib.sha256(EXE.read_bytes()).hexdigest();assert sha=='30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d'
g={int(k,16):v for k,v in json.loads((R/'function_groups.json').read_text()).items()}
pe=pefile.PE(str(EXE),fast_load=True);base=pe.OPTIONAL_HEADER.ImageBase;md=Cs(CS_ARCH_X86,CS_MODE_64)
(O/'asm').mkdir(exist_ok=True);targets=[0xf92b80,0x1087800,0xf6e820,0x106b450];atlas=[]
for rv in targets:
 ranges=g[rv];assert sum(b-a for a,b,*_ in ranges)<12000
 lines=[f'; Original iTunes.exe SHA256 {sha}; ImageBase {base:#x}; function RVA {rv:#x}'];calls=[]
 for a,b,*_ in ranges:
  lines.append(f'; Unwind range {a:#x}..{b:#x}, end exclusive')
  for ins in md.disasm(pe.get_data(a,b-a),base+a):
   lines.append(f'{ins.address-base:08x} {ins.bytes.hex():24} {ins.mnemonic} {ins.op_str}')
   if ins.mnemonic=='call':calls.append({'rva':hex(ins.address-base),'target':ins.op_str})
 (O/'asm'/f'{rv:08x}.asm').write_text('\n'.join(lines),encoding='utf-8')
 atlas.append({'module':'iTunes.exe','rva':hex(rv),'bytes':sum(b-a for a,b,*_ in ranges),'unwind_ranges':ranges,'calls':calls})
(O/'targets-first.txt').write_text('\n'.join(f'{x:x}' for x in targets)+'\n',encoding='utf-8')
(O/'atlas-first.json').write_text(json.dumps(atlas,indent=2),encoding='utf-8')
src=ROOT/'tools/static/projects';dst=O/'projects'
if not dst.exists():shutil.copytree(src,dst)
for d in ['home/AppData/Roaming','home/AppData/Local','tmp','scripts']:(O/d).mkdir(parents=True,exist_ok=True)
shutil.copy2(ROOT/'tools/static/scripts/ITLSelective.java',O/'scripts/ITLSelective.java')
s=(ROOT/'tools/static/run-headless.ps1').read_text()
s=s.replace('tools\\static\\home','reports\\static\\phase4\\home').replace('tools\\static\\tmp','reports\\static\\phase4\\tmp').replace('tools\\static\\projects','reports\\static\\phase4\\projects').replace('tools\\static\\scripts','reports\\static\\phase4\\scripts')
s=s.replace('-Duser.home=','-XX:ActiveProcessorCount=1 -Duser.home=')
(O/'run-headless.ps1').write_text(s,encoding='utf-8')
print('PREPARED_FOUR',json.dumps(atlas,indent=2));print('ISOLATED_PROJECT',str(dst));print('NO_ORIGINAL_PROJECT_OR_REPORT_WRITES')
