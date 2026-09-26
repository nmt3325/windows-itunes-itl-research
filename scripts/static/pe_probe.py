import argparse, bisect, hashlib, json, re, sqlite3, struct
from pathlib import Path
_parser=argparse.ArgumentParser()
_parser.add_argument('--root',type=Path,default=Path(__file__).resolve().parents[2])
_parser.add_argument('--binary',type=Path,required=True)
_parser.add_argument('--output-dir',type=Path)
_args=_parser.parse_args();ROOT=_args.root.resolve();OUT=(_args.output_dir or ROOT/'reports/static').resolve();OUT.mkdir(parents=True,exist_ok=True)
import pefile
from capstone import Cs, CS_ARCH_X86, CS_MODE_64
p=_args.binary.resolve()
b=p.read_bytes(); pe=pefile.PE(data=b); base=pe.OPTIONAL_HEADER.ImageBase
funcs=sorted((x.struct.BeginAddress,x.struct.EndAddress,x.struct.UnwindData) for x in pe.DIRECTORY_ENTRY_EXCEPTION)
starts=[x[0] for x in funcs]
def fun(a):
 i=bisect.bisect_right(starts,a)-1
 return funcs[i][0] if i>=0 and a<funcs[i][1] else None
imports=[]
for ent in getattr(pe,'DIRECTORY_ENTRY_IMPORT',[])+getattr(pe,'DIRECTORY_ENTRY_DELAY_IMPORT',[]):
 for imp in ent.imports:
  imports.append({'dll':ent.dll.decode(),'name':imp.name.decode() if imp.name else '#'+str(imp.ordinal),'rva':imp.address-base})
secs=[{'name':s.Name.rstrip(b'\0').decode(),'rva':s.VirtualAddress,'vsize':s.Misc_VirtualSize,'offset':s.PointerToRawData,'rsize':s.SizeOfRawData} for s in pe.sections]
needles=[b'BHUILuilfghuila3']+[x.encode() for x in ['hdfm','mfdh','msdh','mith','mhoh','miph','mtph','mlth','mlph','mlah','mlih','miah','miih','mhgh','miqh']]
needles+=list({n[::-1] for n in needles if len(n)==4})
hits=[]
for n in needles:
 for m in re.finditer(re.escape(n),b):
  off=m.start()
  try:rva=pe.get_rva_from_offset(off)
  except:continue
  hits.append({'needle':n.decode(),'offset':off,'rva':rva,'function':fun(rva)})
strings=[]
pattern=re.compile(rb'(?:Library\.itl|iTunes Library|[Ll]ibrary(?:Reader|Writer|File)|[Dd]atabase(?:Reader|Writer|\.cpp)|[Pp]ersist(?:ent|ence)|AES[_ -]|[Cc]rypt(?:er|Context)|[Cc]orrupt.*[Ll]ibr|[Ll]ibr.*[Cc]orrupt)')
for m in re.finditer(rb'[\x20-\x7e]{7,}\x00',b):
 if pattern.search(m.group()):
  try:rva=pe.get_rva_from_offset(m.start())
  except:continue
  strings.append({'rva':rva,'text':m.group()[:-1].decode()[:700]})
info={'module':str(p),'sha256':hashlib.sha256(b).hexdigest(),'image_base':base,'machine':pe.FILE_HEADER.Machine,'sections':secs,'functions_count':len(funcs),'imports':imports,'hits':hits,'strings':strings}
(OUT/'pe_inventory.json').write_text(json.dumps(info,indent=2),encoding='utf-8')
(OUT/'pdata.json').write_text(json.dumps(funcs),encoding='utf-8')
print('BASE',hex(base),'pdata functions',len(funcs),flush=True)
print('KEY',[x for x in hits if len(x['needle'])>4],flush=True)
print('TAG_FUNCTIONS',json.dumps({n:sorted(set(hex(x['function']) for x in hits if x['needle']==n and x['function'] is not None)) for n in ['hdfm','mfdh','msdh','mith','mhoh','miph','mtph','mlth','mlph','mlah','mlih','miah','miih']}),flush=True)
important={x['rva']:x['dll']+'!'+x['name'] for x in imports if re.search('zlib|Crypt|AES',x['dll']+' '+x['name'],re.I)}
important.update({x['rva']:x['needle'] for x in hits if len(x['needle'])>4})
print('IMPORTANT_IMPORTS',json.dumps(important),flush=True)
db=sqlite3.connect(OUT/'xrefs.sqlite'); db.executescript('CREATE TABLE refs(src INTEGER, fun INTEGER, kind TEXT, dst INTEGER, mnemonic TEXT, op TEXT); CREATE TABLE functions(start INTEGER PRIMARY KEY,end INTEGER,unwind INTEGER);')
db.executemany('INSERT INTO functions VALUES(?,?,?)',funcs)
md=Cs(CS_ARCH_X86,CS_MODE_64); md.skipdata=True
rows=[]; n=0; finds=[]
rip=re.compile(r'\[rip(?: ([-+]) (0x[0-9a-f]+))?\]')
for s in pe.sections:
 if not s.Characteristics & 0x20000000: continue
 for addr,size,mn,op in md.disasm_lite(s.get_data(),base+s.VirtualAddress):
  n+=1; src=addr-base; dst=None; kind=None
  if mn in ('call','jmp') and op.startswith('0x'):
   dst=int(op,16)-base;kind='direct'
  elif '[rip' in op:
   mm=rip.search(op)
   if mm:
    disp=int(mm.group(2),16) if mm.group(2) else 0
    if mm.group(1)=='-':disp=-disp
    dst=src+size+disp;kind='rip'
  if kind:
   ff=fun(src); rows.append((src,ff,kind,dst,mn,op))
   if dst in important:
    finds.append({'src':hex(src),'fun':hex(ff) if ff else None,'target':important[dst],'mn':mn,'op':op})
   if len(rows)>=10000:db.executemany('INSERT INTO refs VALUES(?,?,?,?,?,?)',rows);rows=[]
 if rows:db.executemany('INSERT INTO refs VALUES(?,?,?,?,?,?)',rows);rows=[]
 print('SCANNED',s.Name,n,'instructions',flush=True)
db.executescript('CREATE INDEX refs_dst ON refs(dst); CREATE INDEX refs_fun ON refs(fun);');db.commit();db.close()
(OUT/'important_xrefs.json').write_text(json.dumps(finds,indent=2),encoding='utf-8')
print('IMPORTANT_XREFS',json.dumps(finds),flush=True)
print('DONE',n,'instructions',flush=True)
