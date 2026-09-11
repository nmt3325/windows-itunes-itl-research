from pathlib import Path
import json, re, hashlib, sqlite3
ROOT=Path(r'<CI_TEMP_WIN>\<CI_BROKER>\WINDOWS_RESEARCH_RUN\work\itl')
R=ROOT/'reports/static'; OUT=R/'phase3'
out=[]
def span(file,a,b):
    lines=file.read_text(encoding='utf-8-sig').splitlines()
    out.append('\nFILE '+file.relative_to(ROOT).as_posix()+' SHA256 '+hashlib.sha256(file.read_bytes()).hexdigest())
    out.extend(f'{i+1}: {lines[i]}' for i in range(a-1,min(b,len(lines))))
span(R/'decompiled/0107b460.c',440,590)
span(R/'decompiled/0107b460.c',1380,1710)
# Emit every writer pool-to-mhoh helper call, with its complete local argument setup.
p=R/'decompiled/0106daf0.c';lines=p.read_text().splitlines();seen=set()
for i,line in enumerate(lines):
    if 'FUN_14106b030' in line:
        a=max(0,i-7);b=min(len(lines),i+3)
        out.append('\nWRITER CALL')
        for j in range(a,b):
            if j not in seen:out.append(f'{j+1}: {lines[j]}');seen.add(j)
# Source list is read-only: document declared public field names, not production execution.
for rel in ['wt/codec/itlkit/library.py','wt/codec/itlkit/operations.py','wt/codec/itlkit/model.py']:
    f=ROOT/rel
    if not f.exists():continue
    lines=f.read_text(encoding='utf-8-sig').splitlines()
    out.append('\nPUBLIC SOURCE '+rel+' SHA256 '+hashlib.sha256(f.read_bytes()).hexdigest())
    if rel.endswith('library.py'):out.extend(f'{i+1}: {s}' for i,s in enumerate(lines[:155]))
    else:
        for i,s in enumerate(lines):
            if any(k in s.lower() for k in ['text_fields','sort_composer','sort_show','editable','lyrics']):out.append(f'{i+1}: {s}')
# Exact byte field translation in already-generated original ASM.
for name,needle in [('0106daf0.asm','a00195'),('0107b460.asm','rbp + 0xad')]:
    f=R/'asm'/name;ls=f.read_text().splitlines()
    for i,line in enumerate(ls):
        if needle in line:
            out.append('\nASM '+name)
            out.extend(f'{j+1}: {ls[j]}' for j in range(max(0,i-10),min(len(ls),i+13)))
# Metadata only: no full dynamic report / private media text.
f=ROOT/'reports/dynamic/report.json';d=json.loads(f.read_text(encoding='utf-8-sig'))
if 'fresh_later_observation' in d:
    ob=d['fresh_later_observation'];out.append('\nFRESH_LATER_OBSERVATION '+json.dumps(ob,ensure_ascii=True))
else:out.append('\nDYNAMIC REPORT TOP KEYS '+repr(list(d)))
(OUT/'existing-text-flag-evidence.txt').write_text('\n'.join(out),encoding='utf-8')
print('\n'.join(out))
