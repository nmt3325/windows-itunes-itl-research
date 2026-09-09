"""Bounded synthetic cross-lineage research probes; not a production import API."""
import sys,json,hashlib,copy,zlib,collections,datetime,os,io,wave
from pathlib import Path
sys.dont_write_bytecode=True
if not __debug__:raise RuntimeError('Validation requires non-optimized Python')
ROOT=Path(r'D:\a\_temp\gha-mcp\WINDOWS_RESEARCH_RUN\work\itl')
OUT=ROOT/'reports/crud-research/phase3'
sys.path.insert(0,str(OUT/'core-snapshot'))
from itlkit import Library
from itlkit.binary import uint as u,put
from itlkit.library import read_text,Track
from itlkit.operations import Allocator,require_simple_library
from itlkit.trackops import _profile,_wave,_aux,_check_item,_rule_signature
from itlkit.io import write_new
from Crypto.Cipher import AES
NS={2:'178',3:'1c0',300:'1c0',4:'208',12:'208',27:'208',301:'208',302:'208',400:'208',5:'328',6:'370',8:'400',30:'1768',31:'17b0',32:'17f8',33:'17f8',34:'17f8',401:'17f8'}
PROFILES=json.loads((OUT/'input-profiles.json').read_text(encoding='utf-8-sig'))
DONOR_MANIFEST=ROOT/'reports/dynamic/phase2/independent-donor32-manifest.json'
DONOR=json.loads(DONOR_MANIFEST.read_text(encoding='utf-8-sig'))
SELECTED=['E95DD2B085330A12','0EA4623DE17EC6F6']
def sha(b):return hashlib.sha256(b).hexdigest()
def js(p):return json.loads(Path(p).read_text(encoding='utf-8-sig'))
def exclusive(p,data):
 p=Path(p);assert p.is_relative_to(OUT);p.parent.mkdir(parents=True,exist_ok=True)
 if p.exists():assert p.read_bytes()==data,('immutable output differs',str(p))
 else:write_new(p,data)
def save(p,obj):exclusive(p,json.dumps(obj,indent=2,ensure_ascii=True).encode())
def pincheck():
 for n,h in js(OUT/'source-manifest.json')['files'].items():
  assert sha((OUT/'core-snapshot/itlkit'/n).read_bytes())==h
  assert sha((ROOT/'wt/crud-research/itlkit'/n).read_bytes())==h
 for rel,h in js(OUT/'phase12-preservation.json').items():assert sha((OUT.parent/rel).read_bytes())==h
 for d in PROFILES:assert sha(Path(d['path']).read_bytes())==d['sha256']
 assert sha((ROOT/'repo/docs/orchestration/phase2-plan.md').read_bytes())=='feeb6707f905cb2d241c815251ccf56dd9c0bfe3c59ddcd5021a87082d60542c'
 assert sha((ROOT/'repo/docs/orchestration/plan.md').read_bytes())=='ba81d8de38d81d5f051b9ef3c0514ecfdea948d994e8cf6519b78377bc75e612'
def read_profile(label):
 d=next(x for x in PROFILES if x['label']==label);return Library.read(d['path'],max_plain_bytes=4*1024*1024),d

def occurrences(l):
 for sec,tag in ((9,b'miah'),(11,b'miih'),(1,b'mith')):
  for n in l._records(sec,tag):
   for c in n.children or []:
    if c.tag==b'mhoh' and c.type_code in NS:yield sec,n,c

def registry(l):
 r={};occ=[]
 for sec,n,c in occurrences(l):
  assert len(c.header)==24 and u(c.header,20)==0
  assert c.payload[8:16]==bytes(8) and len(c.payload)==16+u(c.payload,4)
  text=read_text(c);i=u(c.header,16)
  assert i>0 and text,('unsupported empty/unkeyed global atom',sec,c.type_code,c.offset)
  key=(NS[c.type_code],i);v=text.encode('utf-16-le')
  assert key not in r or r[key]==v,('conflicting scoped definition',key)
  r[key]=v;occ.append((sec,n,c))
 return r,occ

def independent(data):
 assert len(data)<4*1024*1024 and data[:4]==b'hdfm'
 be=lambda off:int.from_bytes(data[off:off+4],'big')
 hs=be(4);assert hs==144 and be(8)==len(data)
 assert data[0x41]==2 and data[0x43]==1 and data[0x52]==1 and be(0x5c)==102400
 n=min(len(data)-hs,be(0x5c))//16*16
 comp=AES.new(b'BHUILuilfghuila3',AES.MODE_ECB).decrypt(data[hs:hs+n])+data[hs+n:]
 dec=zlib.decompressobj();plain=dec.decompress(comp,4*1024*1024+1)
 assert len(plain)<=4*1024*1024 and dec.eof and not dec.unused_data and not dec.unconsumed_tail
 def le(off,size=4):assert 0<=off and off+size<=len(plain);return int.from_bytes(plain[off:off+size],'little')
 sections={};pos=0;record_count=0
 while pos<len(plain):
  assert plain[pos:pos+4]==b'msdh';h,t,k=le(pos+4),le(pos+8),le(pos+12)
  assert h>=16 and h<=t<=len(plain)-pos and k not in sections
  sections[k]=(pos,h,t);pos+=t
 assert pos==len(plain) and len(sections)==be(0x30)
 def walk(start,end,depth=0):
  nonlocal record_count
  assert depth<=8;nodes=[]
  while start<end:
   assert start+12<=end;tag=plain[start:start+4];h,t=le(start+4),le(start+8)
   assert h>=12 and h<=t<=end-start
   child=walk(start+h,start+t,depth+1) if tag in (b'mith',b'miah',b'miih',b'miph',b'mtph') else []
   if tag==b'miph':assert le(start+12)==sum(x[0]==b'mhoh' for x in child) and le(start+16)==sum(x[0]==b'mtph' for x in child)
   elif tag in (b'mith',b'miah',b'miih',b'mtph'):assert le(start+12)==len(child)
   nodes.append((tag,start,t,child));record_count+=1;assert record_count<10000;start+=t
  assert start==end;return nodes
 roots={}
 for k,tag in ((1,b'mlth'),(2,b'mlph'),(9,b'mlah'),(11,b'mlih'),(13,b'mlth'),(14,b'mlph'),(12,b'mhgh'),(21,b'mlsh')):
  s,h,t=sections[k];pos=s+h;assert plain[pos:pos+4]==tag
  hh=le(pos+4);assert 12<=hh<=s+t-pos
  nodes=walk(pos+hh,s+t);assert le(pos+8)==len(nodes);roots[k]=nodes
 assert not roots[13] and not roots[14]
 assert len(roots[21])==1
 tg,pp,ss,_=roots[21][0]
 assert tg==b'msph' and le(pp+4)==48 and ss==967
 assert sha(plain[pp:pp+ss]) in {'a3e963debb07cb70454f280e255239db7827a7552c03fcc817212218ba04d940','41323ba0156b1e6228fa96eb6101f93e8fc681612704088c2de538ea0b58e0fd'}
 m=sections[16][0]+sections[16][1]
 assert plain[m:m+4]==b'mfdh' and le(m+8)==len(plain)+hs and le(m+0x30)==len(sections)
 for off,k in ((0x44,1),(0x48,2),(0x4c,9),(0x54,11)):assert le(m+off)==len(roots[k])==be(off)
 tracks={};secondary=[];pids=[]
 for tag,p,_,_ in roots[1]:
  assert tag==b'mith';tid=le(p+16);pid=le(p+0x80,8);assert tid and tid not in tracks and pid and pid not in pids
  tracks[tid]=p;pids.append(pid);secondary.append(le(p+0x1f4))
 assert len(set(secondary))==len(secondary) and 0 not in secondary
 for k,tag,off in ((9,b'miah',0xdc),(11,b'miih',0x1e0)):
  ids=[le(p+16) for _,p,_,_ in roots[k]];pp=[le(p+20,8) for _,p,_,_ in roots[k]]
  assert 0 not in ids and len(ids)==len(set(ids)) and 0 not in pp and len(pp)==len(set(pp))
  assert all(le(p+off) in ids for p in tracks.values())
 master=[];plids=[];plpids=[]
 for tag,p,_,children in roots[2]:
  assert tag==b'miph';plids.append(le(p+0xd40));plpids.append(le(p+0x1b8,8))
  items=[q for tg,q,_,_ in children if tg==b'mtph'];refs=[le(q+24) for q in items]
  assert set(refs)<=set(tracks)
  for vals in ([le(q+16) for q in items],[le(q+68,8) for q in items]):assert 0 not in vals and len(vals)==len(set(vals))
  if le(p+0x14)&0x10000:master.append(refs)
 assert all(0 not in a and len(a)==len(set(a)) for a in (plids,plpids))
 assert len(master)==1 and collections.Counter(master[0])==collections.Counter(tracks.keys())
 core=Library.from_bytes(data,max_plain_bytes=4*1024*1024);assert core.container.payload==plain and core.to_bytes()==data
 return {'framing_and_counts':True,'independent_known_refs_and_identities':True,'master_exactly_once':True,'sections':len(sections),'records_walked':record_count,'tracks':len(tracks),'playlists':len(roots[2]),'albums':len(roots[9]),'artists':len(roots[11]),'plain_bytes':len(plain)}

def mask(a,b,allowed):
 assert len(a)==len(b);diff=[i for i,(x,y) in enumerate(zip(a,b)) if x!=y]
 assert all(any(lo<=i<hi for lo,hi in allowed) for i in diff),('unexpected byte changes',diff)
 return diff

def selected_playlists(l):
 rr={}
 for p in l.playlists:
  k=0 if p.is_master else u(p.node.header,0x238)
  if not p.is_master and k not in (0x4100,0x400):continue
  assert k not in rr and len(p.node.header)==3500 and u(p.node.header,0x18)==65543
  codes=[n.type_code for n in p.node.children if n.tag==b'mhoh']
  assert codes=={0:[100,105,105,108],0x4100:[100,102,101,105,105,108],0x400:[100,102,101,105,105,108,109]}[k]
  assert collections.Counter(p.track_ids)==collections.Counter(t.track_id for t in l.tracks)
  for n in p.items:_check_item(n)
  rr[k]=p
 assert set(rr)=={0,0x4100,0x400};return rr

def derived_pid(allocator,case,label):
 for i in range(100):
  pid=int.from_bytes(hashlib.sha256((case+'/'+label+'/'+str(i)).encode()).digest()[:8],'big')
  try:return allocator.persistent(pid)
  except ValueError:pass
 raise AssertionError('no deterministic PID available')

def media_info(t):
 p=Path(t.get('path'));assert p.is_relative_to(ROOT/'fixtures/dynamic') and p.suffix.lower()=='.wav'
 raw=p.read_bytes();assert len(raw)<1024*1024
 with wave.open(io.BytesIO(raw),'rb') as w:shape={'channels':w.getnchannels(),'sample_rate':w.getframerate(),'sample_width':w.getsampwidth(),'frames':w.getnframes(),'compression':w.getcomptype()}
 assert shape['compression']=='NONE' and shape['sample_rate']==t.get('sample_rate') and len(raw)==t.get('file_size')
 st=p.stat();return {'path':str(p),'sha256':sha(raw),'bytes':len(raw),'mtime_ns':st.st_mtime_ns,'wave':shape}

FIELDS={'Name':'name','Artist':'artist','Album':'album','AlbumArtist':'album_artist','Composer':'composer','Genre':'genre','Comment':'comment','SortName':'sort_name','SortArtist':'sort_artist','SortAlbum':'sort_album','SortAlbumArtist':'sort_album_artist','Rating':'rating','PlayedCount':'play_count','SkippedCount':'skip_count','TrackNumber':'track_number','TrackCount':'track_count','DiscNumber':'disc_number','DiscCount':'disc_count','Year':'year','Compilation':'compilation','SampleRate':'sample_rate','BitRate':'bit_rate','Size':'file_size'}
def expected_track(t):
 d={k:(t.get(v) if t.get(v) is not None else '') for k,v in FIELDS.items()};d['persistent_id']=f'{t.persistent_id:016X}';d['Location']=str(Path(t.get('path')));d['Duration']=t.get('total_time')/1000
 return d

def build(case,recipient,selected):
 pincheck();d,dp=read_profile('donor032');b,bp=read_profile(recipient)
 assert d.persistent_id!=b.persistent_id
 _profile(d);_profile(b);dr,docc=registry(d);br,bocc=registry(b)
 src=[d.track(persistent_id=p) for p in selected]
 for t in src:_wave(t)
 assert not ({t.persistent_id for t in src}&{t.persistent_id for t in b.tracks})
 try:copy.deepcopy(b).add_track_from(d,selected[0])
 except Exception as exc:assert 'same library lineage' in str(exc);production_refusal=str(exc)
 else:raise AssertionError('production cross-lineage guard unexpectedly absent')
 target=copy.deepcopy(b);alloc=Allocator(target);initial_next=alloc.next_id
 pidmap={};localmap={};new=[];objects={};patches=[]
 for sec,tag,ref in ((9,b'miah','album_id'),(11,b'miih','artist_id')):
  for oldid in dict.fromkeys(t.get(ref) for t in src):
   old=_aux(d,sec,oldid);clone=copy.deepcopy(old);pid=u(old.header,20,8);alloc.persistent(pid)
   newid=alloc.local();put(clone.header,16,newid);objects[(sec,oldid)]=clone
   localmap[f'{tag.decode()}:{oldid}']=newid;new.append((sec,old,clone))
 for t in src:
  alloc.persistent(t.persistent_id);clone=copy.deepcopy(t.node);newid=alloc.local();second=alloc.local()
  put(clone.header,16,newid);put(clone.header,0x1f4,second);put(clone.header,0xdc,u(objects[(9,t.get('album_id'))].header,16));put(clone.header,0x1e0,u(objects[(11,t.get('artist_id'))].header,16))
  localmap[f'mith:{t.track_id}']=newid;localmap[f'secondary:{u(t.node.header,0x1f4)}']=second;new.append((1,t.node,clone));pidmap[t.persistent_id]=newid
 reserved=collections.defaultdict(set)
 for pool,i in br:reserved[pool].add(i)
 atommap={}
 for sec,old,clone in new:
  for a,c in zip(old.children or [],clone.children or []):
   if c.type_code not in NS:assert a.to_bytes()==c.to_bytes();continue
   key=(NS[c.type_code],u(c.header,16));assert key in dr
   if key not in atommap:
    i=max(reserved[key[0]]|{0})+1;assert 0<i<100000;reserved[key[0]].add(i);atommap[key]=i
   put(c.header,16,atommap[key]);assert a.payload==c.payload
   mask(a.header,c.header,[(16,20)])
   patches.append({'owner_tag':clone.tag.decode(),'source_owner_offset':old.offset,'type':c.type_code,'pool':key[0],'old_id':key[1],'new_id':atommap[key],'text_utf16_sha256':sha(dr[key])})
  mask(old.header,clone.header,[(16,20),(0xdc,0xe0),(0x1e0,0x1e4),(0x1f4,0x1f8)] if sec==1 else [(16,20)])
  target._root(sec).children.append(clone)
 destpl=selected_playlists(b);sourcepl=selected_playlists(d);membership=[]
 for kind,old in destpl.items():
  assert _rule_signature(old)==_rule_signature(sourcepl[kind]),('system rules differ',kind)
  dest=target.playlist(old.persistent_id)
  for t in src:
   assert sourcepl[kind].track_ids.count(t.track_id)==1
   item=copy.deepcopy(old.items[0]);lid=alloc.local();pid=derived_pid(alloc,case,f'member/{old.persistent_id:x}/{t.persistent_id:x}')
   put(item.header,16,lid);put(item.header,24,pidmap[t.persistent_id]);put(item.header,32,lid);put(item.header,68,pid,8);dest.node.children.append(item)
   membership.append({'playlist_pid':f'{old.persistent_id:016X}','kind_word':kind,'track_pid':f'{t.persistent_id:016X}','item_local_id':lid,'item_pid':f'{pid:016X}','token':lid})
 data=target.to_bytes(compression_level=1);check=independent(data);result=Library.from_bytes(data,max_plain_bytes=4*1024*1024);registry(result)
 assert len(result.tracks)==len(b.tracks)+len(src)
 assert result.persistent_id==b.persistent_id
 preserved=[]
 for t in b.tracks:
  q=result.track(persistent_id=t.persistent_id);assert q.node.to_bytes()==t.node.to_bytes();preserved.append({'persistent_id':f'{t.persistent_id:016X}','record_sha256':sha(t.node.to_bytes())})
 for sec,tag in ((9,b'miah'),(11,b'miih')):
  by={u(n.header,16):n for n in result._records(sec,tag)}
  for n in b._records(sec,tag):assert by[u(n.header,16)].to_bytes()==n.to_bytes()
 for p in b.playlists:
  q=result.playlist(p.persistent_id)
  if p.persistent_id in {x.persistent_id for x in destpl.values()}:
   assert [n.to_bytes() for n in q.node.children[:len(p.node.children)]]==[n.to_bytes() for n in p.node.children]
   mask(p.node.header,q.node.header,[(8,12),(16,20)])
  else:assert p.node.to_bytes()==q.node.to_bytes()
 by={s.section_type:s for s in result.sections};changes=[];unchanged=[]
 for s in b.sections:
  q=by[s.section_type]
  if s.to_bytes()!=q.to_bytes():changes.append(s.section_type)
  else:unchanged.append({'section':s.section_type,'sha256':sha(s.to_bytes())})
 assert set(changes)=={1,2,9,11,16}
 mask(b.container.header,result.container.header,[(8,12),(0x44,0x48),(0x4c,0x50),(0x54,0x58)])
 mask(b._root(16).header,result._root(16).header,[(8,12),(0x44,0x48),(0x4c,0x50),(0x54,0x58)])
 for k in (1,2,9,11):mask(b._root(k).header,result._root(k).header,[(8,12)])
 media=[media_info(t) for t in result.tracks]
 supplied=js(Path(DONOR['media_source_manifest']))['tracks'];supplied={str(Path(v['copied']['path'])):v['copied'] for v in supplied}
 for t in src:
  m=next(v for v in media if v['path']==str(Path(t.get('path'))));assert m['sha256']==supplied[m['path']]['sha256']
 oracle_path=ROOT/'reports/dynamic/native-runs'/Path(bp['path']).stem/'com.json';oracle=js(oracle_path)['after']
 oldnative={v['persistent_id']:v for v in oracle['tracks']}
 expected=[]
 for t in result.tracks:
  e=expected_track(t);pid=e['persistent_id']
  if pid in oldnative:
   for k,v in e.items():
    actual=oldnative[pid].get(k)
    if k=='Location':actual=str(Path(actual))
    assert actual==v,(pid,k,actual,v)
   e.update({k:v for k,v in oldnative[pid].items() if k not in ('TrackID','TrackDatabaseID','PlayOrderIndex','AlbumRating','Unplayed')})
   e['Location']=str(Path(e['Location']))
  else:
   native=next(v for v in DONOR['tracks'] if v['persistent_id']==pid)
   for k in ('Name','Artist','Album','AlbumArtist','Comment'):assert e[k]==native[k]
  expected.append(e)
 pl_expected=[];id_to_pid={t.track_id:f'{t.persistent_id:016X}' for t in result.tracks}
 for p in result.playlists:pl_expected.append({'persistent_id':f'{p.persistent_id:016X}','raw_name':p.name,'is_master':p.is_master,'is_plain':p.is_plain,'kind_word':u(p.node.header,0x238),'member_pids_physical_order':[id_to_pid[i] for i in p.track_ids],'native_compare_order':p.is_plain})
 candidate=OUT/'candidates'/(case+'.itl');exclusive(candidate,data)
 record={'case_id':case,'intended_operation':'genuinely new cross-library local-WAV import; not same-lineage restoration','candidate':{'path':str(candidate),'sha256':sha(data),'bytes':len(data)},'baseline':{k:bp[k] for k in ('path','sha256','bytes','file_pid')},'donor':{k:dp[k] for k in ('path','sha256','bytes','file_pid')},'donor_native_manifest':{'path':str(DONOR_MANIFEST),'sha256':sha(DONOR_MANIFEST.read_bytes())},'baseline_native_oracle':{'path':str(oracle_path),'sha256':sha(oracle_path.read_bytes())},'new_track_pids':selected,'source_lineages_different':True,'production_API_refusal_preserved':production_refusal,'expected':{'file_persistent_id':f'{result.persistent_id:016X}','library_persistent_id':f'{next(p for p in result.playlists if p.is_master).persistent_id:016X}','track_count':len(result.tracks),'serialized_playlist_count':len(result.playlists),'tracks':expected,'raw_tracks':[t.to_dict() for t in result.tracks],'all_serialized_playlists':pl_expected,'baseline_COM_playlist_PIDs':[p['persistent_id'] for p in oracle['playlists']],'observe_only':['Unplayed','AlbumRating','RatingKind','AlbumRatingKind','TrackID','TrackDatabaseID','PlayOrderIndex'],'ordinary_playlist_order_required':True,'system_playlist_membership_exact_set_required':True},'media':media,'validation':check,'preserved_existing_tracks':preserved,'existing_index_records_preserved':True,'existing_playlist_children_preserved':True,'unchanged_sections':unchanged,'changed_sections':changes,'atom_header_patches':patches,'local_id_map':localmap,'new_memberships':membership,'allocator':{'initial_next_local':initial_next,'next_local_after_allocation':alloc.next_id,'new_local_absent_from_all_original_bytes':True,'new_pids_checked_with_current_core_allocator':True,'compact_external_id_max_by_pool':{k:max(v) for k,v in reserved.items()}},'root_and_highwater':{'all_root_noncount_bytes_preserved':True,'hdfm_mfdh_3c_preserved':111,'note':'0x3c=111 in native3-track and32-track sources; not treated as a local-ID high-water field. No unproved persisted high-water field is changed. New known IDs are above the allocator baseline; native future-allocation behavior remains a separate check.'},'rank_and_name_state':{'all_seven_rank_words_copied_unchanged':True,'wire_6d_preserved':True,'names_and_locations_copied_exactly':True},'native_accepted':False,'native_steps':['Dynamic verifies all input/media hashes and tests copies only.','Load as selected ITL; check file/master identities and complete unique track enumeration.','Check every required field and media location; reject damaged or silent empty fallback.','Complete two native save/restart cycles with fixed expectations and passive dwell; no setters or UpdateInfoFromFile.','Verify synthetic media unchanged; optionally attempt silent playback only under dynamic ownership.'],'unknowns':['This is a bounded raw-model research transformation, not a new production API capability.','Native acceptance and rank/collation regeneration have not yet been tested.','Unknown bytes and destination global metadata/root URI remain unchanged; arbitrary relocation and cloud/store formats are unsupported.','Local IDs may be renumbered on native reopen; persistent identities and reference closure, not session IDs, define acceptance.']}
 save(OUT/'cases'/(case+'.json'),record)
 pincheck()
 return record

def publish(cases):
 path=OUT/'native-requests.json'
 current=js(path) if path.exists() else {'schema':'descriptive-native-requests-phase3-v1','owner':'crud-research','native_owner':'dynamic','private_originals_included':False,'cases':[]}
 by={c['case_id']:c for c in current['cases']}
 for c in cases:
  if c['case_id'] in by:assert by[c['case_id']]==c
  by[c['case_id']]=c
 current['cases']=list(by.values());data=json.dumps(current,indent=2,ensure_ascii=True).encode()
 temp=OUT/'native-requests.next.json'
 with temp.open('wb') as f:f.write(data);f.flush();os.fsync(f.fileno())
 os.replace(temp,path)
 summary={'task':'crud-research phase3','status':'early_candidate_ready' if len(by)==1 else 'shared_group_candidates_ready','base_sha':'56309a258d7b1aadea72738561d1d9fae2e30bc0','native_acceptance_tested':False,'candidate_cases':[{'case_id':c['case_id'],'sha256':c['candidate']['sha256'],'bytes':c['candidate']['bytes'],'new_tracks':len(c['new_track_pids']),'expected_total_tracks':c['expected']['track_count']} for c in by.values()],'native_requests':str(path),'source_manifest':'source-manifest.json','previous_phase_files_preserved':138}
 (OUT/'report.json').write_text(json.dumps(summary,indent=2),encoding='utf-8')
 print(json.dumps(summary))
if __name__=='__main__':
 mode=sys.argv[1] if len(sys.argv)>1 else 'minimal'
 if mode=='minimal':publish([build('crud3-cross-one-003','recipient003',SELECTED[:1])])
 elif mode=='group':publish([build('crud3-cross-shared-two-037','recipient037',SELECTED)])
 else:raise ValueError('unknown mode')