from pathlib import Path
from collections import defaultdict,Counter
import json,re,hashlib,subprocess,sys
root=Path(r'D:\a\_temp\gha-mcp\WINDOWS_RESEARCH_RUN\work\itl');r=root/'reports/static';out=r/'phase2'
p=out/'census_snapshots.py';s=p.read_text(encoding='utf-8-sig');old='[0x10,0x14,0x120,0x134,0x174,0x290';new='[0x10,0x14,0xdc,0x1e0,0x120,0x134,0x174,0x290'
assert s.count(old)==1 or new in s
if old in s:s=s.replace(old,new);p.write_text(s,encoding='utf-8')
subprocess.run([sys.executable,'-B','-u',str(p)],check=True)
c=json.loads((out/'native-url-census.json').read_text());files=[];missing=[];dupes=[];shared=[];counts=Counter()
for f in c['files']:
 maps={tag:defaultdict(list) for tag in ['miah','miih']};uses=defaultdict(list)
 for rec in f['records']:
  if rec['tag'] in maps:maps[rec['tag']][rec['header_fields_u32']['0x10']].append(rec['offset'])
 for tag,mapping in maps.items():
  for key,offsets in mapping.items():
   if key and len(offsets)>1:dupes.append({'path':f['path'],'tag':tag,'id':key,'offsets':offsets})
 links=[]
 for rec in f['records']:
  if rec['tag']!='mith':continue
  for field,tag in [('0xdc','miah'),('0x1e0','miih')]:
   value=rec['header_fields_u32'][field];hits=maps[tag].get(value,[])
   link={'track_offset':rec['offset'],'track_pid':rec['track_pid'],'mith_field':field,'target_tag':tag,'local_id':value,'target_record_offsets':hits};links.append(link)
   if value:
    counts[tag]+=1;uses[(tag,value)].append(rec['track_pid'])
    if not hits:missing.append({'path':f['path'],**link})
 for (tag,key),pids in uses.items():
  if len(pids)>1:shared.append({'path':f['path'],'tag':tag,'id':key,'track_pids':pids})
 files.append({'path':f['path'],'sha256':f['sha256'],'links':links})
result={'claim':'miah/miih+0x10 local object IDs map separately to mith+0xdc album and mith+0x1e0 artist references; these are not mhoh atom IDs or mith+0x290..2a8 ranks.','evidence':['decompiled/01078140.c:343-345','decompiled/01078bb0.c:387-389','../decompiled/0107b460.c:427-443','../decompiled/0106daf0.c:337-342'],'aggregate':{'nonzero_references':dict(counts),'missing_targets':len(missing),'duplicate_positive_local_ids':len(dupes),'shared_target_groups':len(shared)},'missing_targets':missing,'duplicates':dupes,'shared_targets':shared,'files':files}
(out/'object-reference-census.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
parts=[]
for name,ranges in [('0106daf0.c',[(330,343)]),('0107b460.c',[(370,410),(427,466)])]:
 ls=(r/'decompiled'/name).read_text().splitlines();parts+=['SOURCE ../decompiled/'+name,'\n'.join(f'{i+1}: {ls[i]}' for lo,hi in ranges for i in range(lo-1,hi))]
ls=(r/'asm/0107b460.asm').read_text().splitlines();keep=set()
for i,l in enumerate(ls):
 if re.search(r'lea\s+rdx, \[rbp \+ 0x40\]$',l) or re.match(r'0107d1(?:8[8-f]|9[0-9a-f]|a[0-9a-f]|b[0-9a-f]|c[0-9a-f]|d[0-7])\s',l):keep.update(range(max(0,i-2),min(len(ls),i+6)))
parts+=['SOURCE ../asm/0107b460.asm','\n'.join(ls[i] for i in sorted(keep))]
(out/'object-reference-evidence.txt').write_text('\n'.join(parts),encoding='utf-8')
print('OBJECT_REFERENCE_CENSUS',json.dumps(result['aggregate']));print('HEADER_AND_ATOM_REGISTER_PROOF');print(parts[-1]);print('OBJECT_REFERENCES_SAVED')
