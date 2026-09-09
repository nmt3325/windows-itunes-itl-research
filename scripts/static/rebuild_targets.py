"""Regenerate all 47 target definitions/ASM after prepare_targets.py. No production edits."""
from pathlib import Path
import json,hashlib,csv
import pefile
from capstone import Cs,CS_ARCH_X86,CS_MODE_64
ROOT=Path(r'D:\a\_temp\gha-mcp\WINDOWS_RESEARCH_RUN\work\itl');R=ROOT/'reports/static'
TARGETS=[0x106a3a0,0x106a430,0x1075000,0x1075580,0x1076b60,0x1084190,0x1085040,0x1085270,0x10c6970,0x10cbb30,0x106daf0,0x1070370,0x107b460,0x1071260,0x107ee90,0x107ea60,0x106ac80,0x106af90,0x106b140,0x106b290,0x1081a70,0xbfbe20,0xbfbf10,0xbfc0d0,0x10770a0,0x10773d0,0x106aba0,0x106ab70,0x1076780,0x1075f60,0x106b030,0x1070770,0x1075810,0x1081790,0x16390f0,0x526f40,0x1068f90,0x106a520,0xbf9710,0xbf9a90,0xbfc580,0xba0ac0,0x106cba0,0xbfc320,0xbfc1e0,0xbfa2a0,0xbfb050]
g={int(k,16):v for k,v in json.loads((R/'function_groups.json').read_text()).items()}
# Verified leaf ranges lack unwind entries. End addresses are exclusive.
g[0x1068f90]=[[0x1068f90,0x10690cf,0]];g[0x106a520]=[[0x106a520,0x106a559,0]]
(R/'supplementary-leaf-ranges.json').write_text(json.dumps({hex(o):g[o] for o in [0x1068f90,0x106a520]},indent=2))
(R/'function_groups.tsv').write_text('\n'.join(f'{o:x}\t{s:x}\t{e:x}' for o,rs in sorted(g.items()) for s,e,u in rs)+'\n')
(R/'targets-final.txt').write_text('\n'.join(f'{x:x}' for x in TARGETS)+'\n')
binpath=Path(r'C:\Program Files\iTunes\iTunes.exe');sha=hashlib.sha256(binpath.read_bytes()).hexdigest();assert sha=='30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d'
p=pefile.PE(str(binpath),fast_load=True);base=p.OPTIONAL_HEADER.ImageBase;md=Cs(CS_ARCH_X86,CS_MODE_64)
if (R/'decompiled/summary.tsv').exists():
 rows=list(csv.DictReader((R/'decompiled/summary.tsv').read_text().splitlines(),delimiter='\t'));assert len(rows)==47 and all(x['completed']=='true' for x in rows)
atlas=[]
for rva in TARGETS:
 lines=[f'; Original iTunes.exe machine code; base={base:#x}; RVA={rva:#x}; SHA256={sha}'];n=0
 for start,end,u in g[rva]:
  lines.append(f'; range {start:#x}..{end:#x} (exclusive)')
  for a,s,m,o in md.disasm_lite(p.get_data(start,end-start),base+start):lines.append(f'{a-base:08x} {m:10} {o}');n+=1
 fn=R/'asm'/f'{rva:08x}.asm';fn.write_text('\n'.join(lines)+'\n');c=R/'decompiled'/f'{rva:08x}.c'
 if c.exists():assert c.stat().st_size>100
 atlas.append({'module':'iTunes.exe','rva':hex(rva),'base':hex(base),'module_sha256':sha,'function_bytes':sum(e-s for s,e,u in g[rva]),'instruction_count':n,'decompiled_c':str(c.relative_to(R)).replace('\\','/'),'c_sha256':hashlib.sha256(c.read_bytes()).hexdigest() if c.exists() else None,'assembly':str(fn.relative_to(R)).replace('\\','/'),'body_basis':'manual_verified_leaf' if rva in [0x1068f90,0x106a520] else 'PE_x64_chained_unwind'})
(R/'function-atlas.json').write_text(json.dumps(atlas,indent=2))
print('REBUILT 47 function definitions, original ASM, and hashed C atlas')
print('ZLIB_VERSION_LITERAL',p.get_data(0x1ac7f4c,32).split(b'\0')[0])
