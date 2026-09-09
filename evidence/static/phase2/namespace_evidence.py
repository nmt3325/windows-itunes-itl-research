from pathlib import Path
from collections import defaultdict,Counter
import re,json,hashlib
root=Path(r'D:\a\_temp\gha-mcp\WINDOWS_RESEARCH_RUN\work\itl');r=root/'reports/static';out=r/'phase2';chunks=[]
for name,pat in [('0107b460.c',r'1e002(?:70|c0|d8)|\+ 0x(?:e0|e4|e8|ec|f0|f4|f8)\b'),('0106daf0.c',r'0xa003(?:b8|bc|c0|c4|c8|cc|d0)\b')]:
 ls=(r/'decompiled'/name).read_text().splitlines();keep=set()
 for i,l in enumerate(ls):
  if re.search(pat,l):keep.update(range(max(0,i-6),min(len(ls),i+9)))
 text='\n'.join(f'{i+1}: {ls[i]}' for i in sorted(keep));chunks+=['SOURCE ../decompiled/'+name,text];print(chunks[-2]);print(text)
for path in [r/'asm/0106daf0.asm',r/'asm/0107b460.asm',out/'asm/01078140.asm',out/'asm/01078bb0.asm',out/'asm/00bfe1f0.asm',out/'asm/00bfe500.asm']:
 ls=path.read_text().splitlines();keep=set()
 for i,l in enumerate(ls):
  if re.search(r'\+ 0x(?:290|294|298|29c|2a0|2a4|2a8)\b|\+ 0x1e002(?:70|c0|d8)\b|mov\s+edx, 5$|0x141078(?:8ff|a84)|0x140693570',l):keep.update(range(max(0,i-10),min(len(ls),i+12)))
  if path.name=='0107b460.asm' and re.match(r'0107d1[6-9a-d][0-9a-f] ',l):keep.add(i)
  if path.name in ['00bfe1f0.asm','00bfe500.asm'] and i<90:keep.add(i)
 text='\n'.join(ls[i] for i in sorted(keep));chunks+=['SOURCE '+str(path.relative_to(r)),text]
 if path.name=='0107b460.asm':print('TRACK_ASM_ID_SETUP');print(text[:8000])
(out/'pool-and-object-evidence.txt').write_text('\n'.join(chunks),encoding='utf-8')
c=json.loads((out/'native-url-census.json').read_text());mp={('mith',2):'L+0x178',('mith',3):'L+0x1c0',('miah',300):'L+0x1c0',('mith',4):'L+0x208',('mith',12):'L+0x208',('mith',27):'L+0x208',('miah',301):'L+0x208',('miah',302):'L+0x208',('miih',400):'L+0x208'}
files=[];conflicts=[];shared=[];counts=Counter();url_alias_examples=[];crossmatches=[]
for f in c['files']:
 groups=defaultdict(list)
 for m in f['mhoh']:
  domain=mp.get((m['parent_tag'],m['type']))
  if domain and m['atom_id'] and m.get('length') and m.get('utf16le_semantic_sha256'):
   groups[(domain,m['atom_id'])].append(m);counts[domain]+=1
 local=[]
 for (domain,aid),items in groups.items():
  hashes={x['utf16le_semantic_sha256'] for x in items};entry={'domain':domain,'atom_id':aid,'distinct_semantic_hashes':len(hashes),'uses':[{'tag':x['parent_tag'],'type':x['type'],'record_offset':x['record_offset'],'mhoh_offset':x['offset'],'semantic_sha256':x['utf16le_semantic_sha256']} for x in items]};local.append(entry)
  if len(hashes)>1:conflicts.append({'path':f['path'],**entry})
  if len({x['record_offset'] for x in items})>1:shared.append({'path':f['path'],**entry})
 files.append({'path':f['path'],'sha256':f['sha256'],'groups':local})
 urls=[x for x in f['mhoh'] if x['parent_tag']=='mith' and x['type']==11]
 if Path(f['path']).name=='003-three-tracks-reloaded.itl':url_alias_examples=[{'atom_id':m['atom_id'],'record_offset':m['record_offset'],'payload_sha256':m['data_sha256']} for m in urls]
 if Path(f['path']).name=='015-album-artist.itl':
  for m in f['mhoh']:
   if m['parent_tag'] in ['miah','miih'] and m.get('utf16le_semantic_sha256'):
    matches=[t['type'] for t in f['mhoh'] if t['parent_tag']=='mith' and t.get('utf16le_semantic_sha256')==m['utf16le_semantic_sha256']]
    crossmatches.append({'tag':m['parent_tag'],'type':m['type'],'atom_id':m['atom_id'],'matching_track_types':matches})
result={'scope':'Only confirmed L+178/1c0/208 decoded nonempty positive-ID string domains; per-snapshot comparisons, never global cross-library ID equality. L=*(reader+0x1e00270).','domain_map':[{'tag':tag,'type':typ,'domain':domain} for (tag,typ),domain in mp.items()],'aggregate':{'mapped_occurrences':dict(counts),'shared_cross_record_groups':len(shared),'conflicting_same_domain_ids':len(conflicts)},'conflicts':conflicts,'shared_groups':shared,'files':files,'url_ids_are_not_global_example':url_alias_examples,'controlled_snapshot_015_semantic_hash_matches':crossmatches}
(out/'namespace-census.json').write_text(json.dumps(result,indent=2),encoding='utf-8');print('NAMESPACE_CENSUS',json.dumps(result['aggregate']));print('CONTROLLED_HASH_MATCHES',json.dumps(crossmatches));print('URL_SAME_ID_DIFFERENT_VALUES',json.dumps(url_alias_examples))
print('PHASE2_NAMESPACE_EVIDENCE_SAVED')
