"""Independent bounded byte/reference oracle; deliberately never imports itlkit."""
from __future__ import annotations
import hashlib, io, json, struct, sys, wave, zlib
from pathlib import Path
from Crypto.Cipher import AES

KEY=b'BHUILuilfghuila3'
ROOT_TAGS={1:b'mlth',2:b'mlph',9:b'mlah',11:b'mlih',12:b'mhgh',13:b'mlth',14:b'mlph',21:b'mlsh'}
CONTAINERS={b'mith',b'miph',b'miah',b'miih',b'mtph'}
POOLS={2:'name',3:'album',300:'album',4:'artist',12:'artist',27:'artist',301:'artist',302:'artist',400:'artist',5:'genre',6:'kind',8:'comment',30:'sortname',31:'sortalbum',32:'sortartist',33:'sortartist',34:'sortartist',401:'sortartist'}
AFFECTED={'9751B29CECF5340B','04E2F2CF5464E974','F799EAAF82E6D6D2'}


def need(ok, message):
 if not ok:
  raise ValueError(message)


def u(data, off, n=4, byteorder='little'):
 need(0 <= off <= len(data)-n, 'integer out of bounds')
 return int.from_bytes(data[off:off+n],byteorder)


def sha(data):
 return hashlib.sha256(data).hexdigest()


def hx(data,off):
 return f'{u(data,off,8):016X}'


def records(data, start, stop, depth=0):
 need(depth <= 6,'nesting limit')
 out=[]
 while start<stop:
  need(start+12<=stop,'record prefix truncated')
  tag=data[start:start+4]; h=u(data,start+4); n=u(data,start+8)
  need(12<=h<=n<=stop-start,'record bound')
  raw=data[start:start+n]; header=raw[:h]; body=raw[h:]
  children=records(data,start+h,start+n,depth+1) if tag in CONTAINERS else None
  if children is not None:
   if tag==b'miph':
    need(u(header,12)==sum(c['tag']==b'mhoh' for c in children),'miph metadata count')
    need(u(header,16)==sum(c['tag']==b'mtph' for c in children),'miph item count')
   else:
    need(u(header,12)==len(children),'record child count')
  out.append({'tag':tag,'header':header,'body':body,'raw':raw,'children':children,'offset':start})
  start+=n
 need(start==stop,'record end mismatch')
 return out


def text(node):
 need(node['tag']==b'mhoh' and len(node['header'])==24,'string header')
 b=node['body']; need(len(b)>=16,'text prefix')
 enc=u(b,0); n=u(b,4); need(n==len(b)-16,'text byte count')
 need(b[8:16]==bytes(8),'unknown text extension')
 if enc==2:
  need(u(node['header'],12)==11 and b[16:].isascii(),'unsupported encoding2')
 need(enc in (1,2,3),'unsupported encoding')
 return b[16:].decode({1:'utf-16-le',2:'ascii',3:'latin-1'}[enc])


def parse_payload(header,payload):
 need(len(payload)<4*1024*1024,'bounded library budget')
 sections=[]; pos=0
 while pos<len(payload):
  need(pos+16<=len(payload),'section prefix')
  h=u(payload,pos+4); n=u(payload,pos+8); kind=u(payload,pos+12)
  need(payload[pos:pos+4]==b'msdh' and h==96 and h<=n<=len(payload)-pos,'section bound/profile')
  raw=payload[pos:pos+n]; root=None
  if kind in ROOT_TAGS or kind==16:
   at=pos+h; rh=u(payload,at+4)
   need(rh>=12 and at+rh<=pos+n,'root bounds')
   expected=ROOT_TAGS.get(kind,b'mfdh')
   need(payload[at:at+4]==expected,'root tag')
   children=[] if kind==16 else records(payload,at+rh,pos+n)
   if kind==16:
    need(at+rh==pos+n,'mfdh trailing bytes')
   else:
    need(u(payload,at+8)==len(children),'list count mismatch')
   root={'tag':expected,'header':payload[at:at+rh],'raw':payload[at:pos+n], 'children':children,'offset':at}
  sections.append({'kind':kind,'header':raw[:h],'raw':raw,'root':root,'offset':pos})
  pos+=n
 need(pos==len(payload),'section EOF')
 sec={s['kind']:s for s in sections}
 need(len(sec)==len(sections),'duplicate section type')
 need(set(sec)=={16,12,9,11,1,13,23,2,14,21,4},'unexpected section profile')
 mfdh=sec[16]['root']['header']
 need(u(mfdh,8)==len(payload)+len(header),'logical length')
 need(u(mfdh,0x30)==len(sections)==u(header,0x30,byteorder='big'),'section count')
 for kind,off in [(1,0x44),(2,0x48),(9,0x4c),(11,0x54)]:
  actual=len(sec[kind]['root']['children'])
  need(actual==u(header,off,byteorder='big')==u(mfdh,off),'header/list count mismatch')
 tracks=sec[1]['root']['children']; albums=sec[9]['root']['children']; artists=sec[11]['root']['children']; playlists=sec[2]['root']['children']
 for ns,off,n,label in [(tracks,16,4,'track local'),(tracks,0x80,8,'track PID'),(tracks,0x1f4,4,'secondary track'),(albums,16,4,'album local'),(albums,20,8,'album PID'),(artists,16,4,'artist local'),(artists,20,8,'artist PID'),(playlists,0x1b8,8,'playlist PID'),(playlists,0xd40,4,'playlist local')]:
  values=[u(t['header'],off,n) for t in ns]
  need(0 not in values and len(values)==len(set(values)),label+' identity ambiguity')
 tids={u(t['header'],16) for t in tracks}
 for t in tracks:
  need(len(t['header'])==756,'track header profile')
  need(u(t['header'],0xdc) in {u(n['header'],16) for n in albums},'album dangling reference')
  need(u(t['header'],0x1e0) in {u(n['header'],16) for n in artists},'artist dangling reference')
 for p in playlists:
  need(len(p['header'])==3500,'playlist header profile')
  items=[c for c in p['children'] if c['tag']==b'mtph']
  for i in items:
   need(len(i['header'])==84 and len(i['raw'])==84,'item header profile')
   need(u(i['header'],24) in tids,'dangling playlist reference')
  for off,n in [(16,4),(68,8)]:
   ids=[u(i['header'],off,n) for i in items]
   need(0 not in ids and len(ids)==len(set(ids)),'item identity ambiguity')
 pools={}
 for parent in tracks+albums+artists:
  for c in parent['children']:
   need(c['tag']==b'mhoh','unknown metadata node')
   code=u(c['header'],12)
   if code in POOLS:
    atom=u(c['header'],16); value=text(c); pool=POOLS[code]
    if value:
     need(0<atom<1024,'invalid/noncompact explicit atom')
     key=(pool,atom)
     need(key not in pools or pools[key]==value,'same-pool unequal-text alias')
     pools[key]=value
 return {'header':header,'payload':payload,'sections':sections,'sec':sec,'tracks':tracks,'albums':albums,'artists':artists,'playlists':playlists,'pools':pools}


def from_wire(data):
 need(len(data)>=144 and data[:4]==b'hdfm','outer magic/length')
 h=u(data,4,byteorder='big')
 need(h==144 and u(data,8,byteorder='big')==len(data),'outer size')
 header=data[:h]; body=data[h:]
 need(header[0x41]==2 and header[0x43]==1 and header[0x52]==1,'probe envelope profile')
 cap=u(header,0x5c,byteorder='big'); encrypted=min(len(body),cap)//16*16
 clear=AES.new(KEY,AES.MODE_ECB).decrypt(body[:encrypted])+body[encrypted:]
 d=zlib.decompressobj(); payload=d.decompress(clear,4*1024*1024+1)
 need(d.eof and not d.unused_data and not d.unconsumed_tail,'zlib EOF/trailer/budget')
 return parse_payload(header,payload)


def repack(header,payload):
 body=zlib.compress(payload,6); h=bytearray(header)
 h[8:12]=(len(body)+len(h)).to_bytes(4,'big')
 encrypted=min(len(body),u(h,0x5c,byteorder='big'))//16*16
 return bytes(h)+AES.new(KEY,AES.MODE_ECB).encrypt(body[:encrypted])+body[encrypted:]


def equal_except(a,b,spans,label):
 need(len(a)==len(b),label+' resized header')
 allowed={i for off,n in spans for i in range(off,off+n)}
 changed=[i for i,(x,y) in enumerate(zip(a,b)) if x!=y]
 need(all(i in allowed for i in changed),label+' modified unexpected bytes')
 return changed


def bypid(nodes,off):
 return {hx(n['header'],off):n for n in nodes}


def verify_case(req):
 bp=Path(req['baseline']['path']); cp=Path(req['candidate']['path'])
 need(sha(bp.read_bytes())==req['baseline']['sha256'],'baseline hash')
 need(sha(cp.read_bytes())==req['candidate']['sha256'],'candidate hash')
 b=from_wire(bp.read_bytes()); c=from_wire(cp.read_bytes())
 template=from_wire(Path(req['template']['source']['path']).read_bytes())
 info=req['construction']; newpid=info['new_track_pid']; tid=info['new_track_id']
 old=bypid(b['tracks'],0x80); out=bypid(c['tracks'],0x80)
 need(set(out)==set(old)|{newpid} and newpid not in old,'complete expected track PID set')
 for pid,node in old.items():
  need(node['raw']==out[pid]['raw'],'retained track modified')
 new=out[newpid]; src=bypid(template['tracks'],0x80)[req['template']['persistent_id']]
 changed=equal_except(src['header'],new['header'],[(8,4),(16,4),(0x20,4),(0x6d,1),(0x78,4),(0x80,8),(0xdc,4),(0x1e0,4),(0x1f4,4),(0x290,4)],'new template header')
 need(u(new['header'],16)==tid,'new track ID')
 need(new['header'][0x6d]==0 and u(new['header'],0x290)==0,'explicit Name state')
 need(u(new['header'],0x1f4)==info['new_secondary_id'],'secondary ID')
 children={u(n['header'],12):n for n in new['children']}
 need(set(children)=={2,6,13,11} and len(new['children'])==4,'type1/unknown location template')
 need(children[6]['raw']==next(n for n in src['children'] if u(n['header'],12)==6)['raw'],'kind bytes changed')
 need(text(children[2])==info['name'] and u(children[2]['header'],16)==info['new_name_atom_id'],'Name/atom')
 need(text(children[13])==info['path'] and text(children[11])=='file://localhost/'+info['path'].replace('\\','/'),'path URL agreement')
 need(u(children[13]['header'],16)==1 and u(children[11]['header'],16)==2,'file-local wire IDs')
 media=Path(req['new_media']['path']); raw=media.read_bytes()
 need(sha(raw)==req['new_media']['sha256'],'new media hash')
 with wave.open(io.BytesIO(raw),'rb') as w:
  need((w.getnchannels(),w.getsampwidth(),w.getframerate(),w.getnframes())==(1,2,44100,44100),'PCM dimensions')
 need(len(raw)==u(new['header'],0x24)==u(new['header'],0x144)==88244,'all size fields')
 need(u(new['header'],0x28)==1000 and u(new['header'],0xf4)==44100 and struct.unpack_from('<f',new['header'],0x98)[0]==44100.0 and u(new['header'],0x38)==705,'audio scalar fields')
 for tag,kind,off in [('albums',9,0xdc),('artists',11,0x1e0)]:
  before=bypid(b[tag],20); after=bypid(c[tag],20); npid=info['new_aux'][str(kind)]['persistent_id']
  need(set(after)==set(before)|{npid} and npid not in before,'aux object delta')
  for p,n in before.items(): need(n['raw']==after[p]['raw'],'old aux changed')
  added=after[npid]; expected_local=info['new_aux'][str(kind)]['local_id']
  need(u(added['header'],16)==u(new['header'],off)==expected_local,'aux reference target')
  need(not added['children'],'new aux must be native blank')
  original=next(n for n in template[tag] if u(n['header'],16)==u(src['header'],off))
  equal_except(original['header'],added['header'],[(16,4),(20,8)],'blank aux clone')
 before=bypid(b['playlists'],0x1b8); after=bypid(c['playlists'],0x1b8)
 need(set(before)==set(after),'playlist identity set changed')
 for pid,p in before.items():
  q=after[pid]
  if pid not in AFFECTED:
   need(p['raw']==q['raw'],'unaffected playlist changed'); continue
  equal_except(p['header'],q['header'],[(8,4),(16,4)],'membership header')
  need([x['raw'] for x in p['children']]==[x['raw'] for x in q['children'][:-1]],'old items or metadata changed')
  item=q['children'][-1]
  need(item['tag']==b'mtph' and u(item['header'],24)==tid,'missing added membership')
 for s in b['sections']:
  q=c['sec'][s['kind']]
  if s['kind'] not in (16,9,11,1,2):
   need(s['raw']==q['raw'],'opaque/unaffected section modified')
  else:
   equal_except(s['header'],q['header'],[(8,4)],'section header')
   spans=[(8,4),(0x44,4),(0x4c,4),(0x54,4)] if s['kind']==16 else [(8,4)]
   equal_except(s['root']['header'],q['root']['header'],spans,'root header')
 equal_except(b['header'],c['header'],[(8,4),(0x44,4),(0x4c,4),(0x54,4)],'outer header')
 need(c['header'][0x34:0x3c].hex().upper()==req['expected_file_persistent_id'],'file identity')
 for fact in req['old_media']:
  need(sha(Path(fact['path']).read_bytes())==fact['sha256'],'old media changed')
 need(req['expected_main_track_count']==len(c['tracks'])==4,'manifest track count')
 need({t['persistent_id'] for t in req['expected_com_all_passive_observations']['tracks']}==set(out),'COM manifest incomplete')
 # Positional fields are intentionally not native-identity requirements.
 for t in req['expected_com_all_passive_observations']['tracks']:
  need('TrackID' not in t and 'PlayOrderIndex' not in t,'volatile ID in gate')
 return {'case_id':req['case_id'],'status':'passed_offline_only','sha256':sha(cp.read_bytes()),
         'input_tracks_unchanged':len(old),'tracks':len(c['tracks']),'albums':len(c['albums']),'artists':len(c['artists']),
         'playlist_identities_unchanged':len(before),'added_memberships':3,'template_header_changed_byte_offsets':changed,
         'unchanged_sections':[s['kind'] for s in b['sections'] if s['raw']==c['sec'][s['kind']]['raw']],
         'native_acceptance':'not_run'}


def main():
 manifest=Path(__file__).resolve().parent/'native-requests.json'
 reqs=json.loads(manifest.read_text(encoding='utf-8'))
 print(json.dumps({'implementation':'independent bounded parser; no itlkit import','cases':[verify_case(r) for r in reqs['cases']]},indent=2))

if __name__=='__main__': main()
