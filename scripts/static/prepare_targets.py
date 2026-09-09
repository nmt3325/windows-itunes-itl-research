import json,struct,sqlite3,bisect
from pathlib import Path
from collections import defaultdict
from capstone import Cs,CS_ARCH_X86,CS_MODE_64
import pefile
ROOT=Path(r'D:\a\_temp\gha-mcp\WINDOWS_RESEARCH_RUN\work\itl');OUT=ROOT/'reports'/'static'
pe=pefile.PE(r'C:\Program Files\iTunes\iTunes.exe');base=pe.OPTIONAL_HEADER.ImageBase
fs=json.loads((OUT/'pdata.json').read_text());by_start={s:(s,e,u) for s,e,u in fs};owners={};groups=defaultdict(list)
def owner(t,depth=0):
 s,e,u=t
 if s in owners:return owners[s]
 if depth>20:raise RuntimeError('unwind loop')
 b=pe.get_data(u,4)
 if (b[0]>>3)&4:
  ch=struct.unpack('<III',pe.get_data(u+((4+2*b[2]+3)&~3),12)); o=owner(ch,depth+1)
 else:o=s
 owners[s]=o;return o
for f in fs:groups[owner(f)].append(f)
(OUT/'function_groups.json').write_text(json.dumps({hex(k):v for k,v in groups.items()}))
(OUT/'function_groups.tsv').write_text('\n'.join(f'{o:x}\t{s:x}\t{e:x}' for o,rs in groups.items() for s,e,u in rs))
inventory=json.loads((OUT/'pe_inventory.json').read_text());imp={x['rva']:x['dll']+'!'+x['name'] for x in inventory['imports']}
db=sqlite3.connect(OUT/'xrefs.sqlite')
keyf=[int(x['fun'],16) for x in json.loads((OUT/'important_xrefs.json').read_text()) if x['target']=='BHUILuilfghuila3']
print('KEY RVA',hex(next(x['rva'] for x in inventory['hits'] if len(x['needle'])>4)))
print('KEY OWNERS',[(hex(f),hex(owners[f])) for f in keyf])
pre=[0x106a3a0,0x106a430,0x1075000,0x1075695,0x1076bb5,0x1084235,0x1084270,0x108513c,0x1085270,0x10c6970,0x10cbb98,0x106db3f,0x1070370,0x107b651,0x1071260,0x107ee90,0x107ea60,0x106ac80,0x106af90,0x106b140,0x106b290,0x1081a70]
selected=list(dict.fromkeys(owners.get(f,f) for f in pre))
asm=OUT/'asm';asm.mkdir(exist_ok=True);md=Cs(CS_ARCH_X86,CS_MODE_64)
summ=[]
for o in selected:
 calls=[]; lines=[]
 for s,e,u in groups[o]:
  for a,z,mn,op in md.disasm_lite(pe.get_data(s,e-s),base+s):lines.append(f'{a-base:08x} {mn:10} {op}')
  for src,kind,dst,mn,op in db.execute('SELECT src,kind,dst,mnemonic,op FROM refs WHERE fun=?',(s,)):
   if mn=='call':calls.append({'src':hex(src),'dst':hex(dst),'name':imp.get(dst),'owner':hex(owners.get(dst,dst))})
 (asm/f'{o:08x}.asm').write_text('\n'.join(lines),encoding='utf-8')
 summ.append({'entry':hex(o),'bytes':sum(e-s for s,e,u in groups[o]),'ranges':[[hex(s),hex(e)] for s,e,u in groups[o]],'calls':calls})
 print('TARGET',hex(o),'bytes',sum(e-s for s,e,u in groups[o]),'calls',[c['name'] or c['owner'] for c in calls])
(OUT/'targets1.txt').write_text('\n'.join(f'{x:x}' for x in selected))
(OUT/'callgraph1.json').write_text(json.dumps(summ,indent=2),encoding='utf-8')
print('TOTAL LOGICAL FUNCTIONS',len(groups),'TARGETS',len(selected))
