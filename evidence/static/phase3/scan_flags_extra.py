from pathlib import Path
import json,hashlib,bisect,struct
import pefile
from capstone import Cs,CS_ARCH_X86,CS_MODE_64,CS_AC_WRITE
from capstone.x86 import X86_OP_MEM,X86_OP_IMM
ROOT=Path(r'D:\a\_temp\gha-mcp\WINDOWS_RESEARCH_RUN\work\itl');R=ROOT/'reports/static';OUT=R/'phase3/scan-extra';OUT.mkdir(exist_ok=True)
EXE=Path(r'C:\Program Files\iTunes\iTunes.exe');raw=EXE.read_bytes()
assert hashlib.sha256(raw).hexdigest()=='30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d'
pe=pefile.PE(data=raw,fast_load=True);base=pe.OPTIONAL_HEADER.ImageBase
cv=lambda x:int(x,16) if isinstance(x,str) else x
g={int(k,16):[(cv(a),cv(b),cv(c)) for a,b,c in v] for k,v in json.loads((R/'function_groups.json').read_text()).items()}
ranges=sorted((a,b,k) for k,rs in g.items() for a,b,c in rs);starts=[x[0] for x in ranges]
owners=set();unowned=[];needle_hits=0
for sec in pe.sections:
    if not sec.Characteristics&0x20000000:continue
    data=sec.get_data()
    for disp in [0x98,0x99,0x9a]:
        start=0
        while True:
            at=data.find(struct.pack('<I',disp),start)
            if at<0:break
            start=at+1;rva=sec.VirtualAddress+at
            if not 0xe00000<=rva<0xf00000:continue
            needle_hits+=1;i=bisect.bisect_right(starts,rva)-1
            if i>=0 and ranges[i][0]<=rva<ranges[i][1]:owners.add(ranges[i][2])
            else:unowned.append(hex(rva))
md=Cs(CS_ARCH_X86,CS_MODE_64);md.detail=True
results=[];skipped=[];examined=0;d=OUT/'bounded-asm';d.mkdir(exist_ok=True)
for owner in sorted(owners):
    n=sum(b-a for a,b,c in g[owner])
    if n>200000:skipped.append({'rva':hex(owner),'bytes':n});continue
    ins=[]
    for a,b,c in g[owner]:ins.extend(md.disasm(pe.get_data(a,b-a),base+a))
    examined+=len(ins);matched=[];name=False;zero_rank=[]
    for i,x in enumerate(ins):
        mem=[o for o in x.operands if o.type==X86_OP_MEM]
        if any(o.mem.disp==0xb0 for o in mem):name=True
        if x.mnemonic=='mov' and len(x.operands)==2 and x.operands[0].type==X86_OP_MEM and x.operands[0].mem.disp==0xe0:
            src=x.operands[1]
            if src.type==X86_OP_IMM and src.imm==0:zero_rank.append(hex(x.address-base))
        for o in mem:
            if not o.mem.disp<=0x9a<o.mem.disp+o.size or o.mem.disp not in [0x98,0x99,0x9a]:continue
            bit=4+(0x9a-o.mem.disp)*8;mask=1<<bit
            imm=[v.imm for v in x.operands if v.type==X86_OP_IMM]
            direct=(x.mnemonic in ['test','or','xor'] and any(v&mask for v in imm)) or (x.mnemonic=='and' and any(not(v&mask) for v in imm)) or (x.mnemonic in ['bt','bts','btr','btc'] and bit in imm)
            if direct or o.mem.disp==0x9a:
                ctx=[f'{y.address-base:08x} {y.bytes.hex()} {y.mnemonic} {y.op_str}' for y in ins[max(0,i-5):i+7]]
                matched.append({'rva':hex(x.address-base),'asm':x.mnemonic+' '+x.op_str,'direct_bit20_operation':direct,'context':ctx})
    if not matched:continue
    calls=[{'rva':hex(x.address-base),'target':hex(x.operands[0].imm-base)} for x in ins if x.mnemonic=='call' and x.operands and x.operands[0].type==X86_OP_IMM]
    row={'rva':hex(owner),'bytes':n,'touches_name_member_b0':name,'zero_stores_to_e0':zero_rank,'matches':matched,'calls':calls};results.append(row)
    (d/f'{owner:08x}.asm').write_text('\n'.join(f'{x.address-base:08x} {x.bytes.hex()} {x.mnemonic} {x.op_str}' for x in ins),encoding='utf-8')
res={'module':'iTunes.exe','sha256':hashlib.sha256(raw).hexdigest(),'scanned_rva_interval':['0xe00000','0xf00000'],'raw_disp_candidate_hits':needle_hits,'candidate_unwind_groups':len(owners),'examined_instructions':examined,'unowned_candidates':unowned,'skipped_overlarge_groups':skipped,'functions':results,'limitations':['Raw displacement prefilter, not exhaustive typed dataflow.','Unwind-less leaves are recorded as unowned, not assigned invented boundaries.','Addresses/structural matches do not by themselves establish human semantics.']}
(OUT/'flag98-9a-scan.json').write_text(json.dumps(res,indent=2),encoding='utf-8')
print('SCAN_COUNTS',json.dumps({k:v for k,v in res.items() if k not in ['functions','unowned_candidates','limitations']}))
ranked=sorted(results,key=lambda f:(bool(f['zero_stores_to_e0']),f['touches_name_member_b0'],sum(m['direct_bit20_operation'] for m in f['matches'])) ,reverse=True)
lines=[]
for f in ranked:
    lines.append('\nFUNCTION '+f['rva']+' bytes='+str(f['bytes'])+' name_b0='+str(f['touches_name_member_b0'])+' rank_zero='+repr(f['zero_stores_to_e0']))
    for m in f['matches']:
        if m['direct_bit20_operation']:lines.extend(m['context'])
(OUT/'flag98-9a-scan.txt').write_text('\n'.join(lines),encoding='utf-8')
print('\n'.join(lines)[:15000])
