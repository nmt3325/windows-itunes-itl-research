"""Independent bounded identities/graph checker and allocation-plan prototype.
Uses the existing bounded container; no writes, native actions or hash allowlists.
A successful known-graph check is NOT complete semantic/native admission.
"""
from __future__ import annotations
from collections import Counter, defaultdict
import hashlib, json
from dataclasses import dataclass, field
from types import MappingProxyType
from .container import Container
from .errors import FormatError, UnsupportedError
from .identity import SnapshotKey, ScopedID

ROOTS = {1:b'mlth',2:b'mlph',9:b'mlah',11:b'mlih',12:b'mhgh',13:b'mlth',14:b'mlph',21:b'mlsh'}
CONTAINERS = {b'mith',b'miah',b'miih',b'miph',b'mtph',b'miqh'}
POOLS = {}
for owner, codes, pool in [('mith',(2,),'L+0x178'),('mith',(3,),'L+0x1c0'),('miah',(300,),'L+0x1c0'),('mith',(4,12,27),'L+0x208'),('miah',(301,302),'L+0x208'),('miih',(400,),'L+0x208'),('mith',(5,),'L+0x328'),('mith',(6,),'L+0x370'),('mith',(8,),'L+0x400'),('mith',(30,),'L+0x1768'),('mith',(31,),'L+0x17b0'),('mith',(32,33,34),'L+0x17f8'),('miih',(401,),'L+0x17f8'),('mith',(24,),'L+0x640'),('miah',(304,),'L+0x640'),('mith',(35,),'L+0x1840'),('mith',(60,62),'L+0x910')]:
    for code in codes: POOLS[owner,code] = pool

class Rejected(FormatError): pass
class Unsupported(UnsupportedError, Rejected): pass

def sha(data): return hashlib.sha256(data).hexdigest()
def u(data, off, width=4, endian='little'):
    if width not in (1,2,4,8) or not 0 <= off <= len(data)-width: raise Rejected('integer_bounds')
    return int.from_bytes(data[off:off+width],endian)
def put(data, off, value, width=4, endian='little'):
    if type(value) is not int or not 0 <= value < 1 << (width*8): raise Rejected('integer_range')
    if not 0 <= off <= len(data)-width: raise Rejected('integer_bounds')
    data[off:off+width] = value.to_bytes(width,endian)
def need(ok, message):
    if not ok: raise Rejected(message)

def _decode(data, limits):
    need(type(data) is bytes, 'immutable_bytes_required')
    need(144 <= len(data) <= limits['max_file_bytes'], 'file_budget')
    need(4 * len(data) <= limits['memory_budget_bytes'], 'declared_memory_budget')
    effective_plain = min(limits['max_plain_bytes'], limits['memory_budget_bytes'] // 8)
    need(effective_plain > 0, 'declared_memory_budget')
    c = Container.from_bytes(data, max_plain_bytes=effective_plain)
    if len(c.header) != 144 or c.payload_byteorder != 'little':
        raise Unsupported('identity_profile_requires_hdfm144_little')
    if c.version not in ('12.13.10.3', '12.13.9.1'):
        raise Unsupported('identity_version_profile')
    return c.header, c.payload, c.trailer


class Parsed:
    def __init__(self,data,limits):
        self.limits=limits;self.frame_count=0;self.text_bytes=0
        self.header,self.plain,self.trailer=_decode(data,limits)
        self.sections=[];self.roots={};self.nodes=[];self.opaque=[];self.seen_sections=set()
        p=0;d=self.plain
        while p<len(d):
            tag,h,total=self.prefix(p,len(d));need(tag==b'msdh' and h>=16 and h<=total<=len(d)-p,'section_boundary')
            k=u(d,p+12);need(k not in self.seen_sections,'duplicate_section');self.seen_sections.add(k)
            end=p+total; pos=p+h
            sec={'type':k,'offset':p,'header_length':h,'total':total,'sha256':sha(d[p:end])}
            if k in ROOTS or k==16:
                rt,rh,word=self.prefix(pos,end); need(rt==(b'mfdh' if k==16 else ROOTS[k]),'root_tag')
                if k==16:
                    need(pos+rh==end and rh==144,'inner_header_shape');children=[]
                else:
                    children=self.sequence(pos+rh,end,k,0);need(word==len(children),'root_count')
                self.roots[k]={'offset':pos,'header_length':rh,'children':children}
            else:
                self.opaque.append({'offset':pos,'end':end,'reason':'unmapped_section','section':k})
            self.sections.append(sec);p=end
        need(p==len(d) and 16 in self.roots,'section_closure')
        need(len(self.sections)==u(self.header,0x30,endian='big'),'outer_section_count')
        m=self.roots[16]['offset'];need(u(d,m+8)==len(d)+len(self.header),'inner_length')
        need(u(d,m+0x30)==len(self.sections),'inner_section_count')
        for off,k in [(0x44,1),(0x48,2),(0x4c,9),(0x54,11)]:
            count=len(self.roots.get(k,{}).get('children',[]))
            need(u(self.header,off,endian='big')==count==u(d,m+off),'library_count_'+hex(off))
    def prefix(self,p,end):
        self.frame_count+=1
        need(self.frame_count<=self.limits['max_nodes'],'node_budget')
        need(8*len(self.plain)+1024*self.frame_count<=self.limits['memory_budget_bytes'],'declared_memory_budget')
        need(0<=p<=end<=len(self.plain) and p+12<=end,'prefix_bounds')
        h=u(self.plain,p+4);need(12<=h<=end-p,'header_bounds')
        return self.plain[p:p+4],h,u(self.plain,p+8)
    def sequence(self,p,end,section,depth):
        need(depth<=self.limits['max_depth'],'nesting_budget');out=[]
        while p<end:
            tag,h,total=self.prefix(p,end);need(h<=total<=end-p,'record_bounds')
            need(len(self.nodes)<self.limits['max_nodes'],'node_budget')
            node={'tag':tag.decode('ascii','strict'),'offset':p,'header_length':h,'total':total,'section':section,'children':[]}
            self.nodes.append(node)
            if tag in CONTAINERS:
                node['children']=self.sequence(p+h,p+total,section,depth+1)
                if tag==b'miph':
                    need(u(self.plain,p+12)==sum(x['tag']=='mhoh' for x in node['children']),'playlist_metadata_count')
                    need(u(self.plain,p+16)==sum(x['tag']=='mtph' for x in node['children']),'playlist_item_count')
                else: need(u(self.plain,p+12)==len(node['children']),'child_count')
            elif tag!=b'mhoh': self.opaque.append({'offset':p+h,'end':p+total,'section':section,'reason':'unmapped_leaf_'+node['tag']})
            out.append(node);p+=total
        need(p==end,'sequence_closure');return out
    def records(self,section,tag):
        rows=self.roots.get(section,{}).get('children',[])
        need(all(n['tag']==tag for n in rows),'unexpected_record_'+str(section))
        return rows
    def text(self,node):
        p=node['offset'];h=node['header_length'];end=p+node['total'];b=p+h
        need(h>=24 and b+16<=end,'text_prefix')
        code=u(self.plain,p+12);enc=u(self.plain,b);length=u(self.plain,b+4)
        need(b+16+length<=end,'text_bounds')
        self.text_bytes+=length
        need(self.text_bytes<=self.limits['max_text_bytes'],'aggregate_text_budget')
        raw=self.plain[b+16:b+16+length]
        if enc==1: value=raw.decode('utf-16-le','strict')
        elif enc==3: value=raw.decode('latin-1')
        elif enc==2 and code==11 and raw.isascii(): value=raw.decode('ascii')
        else: raise Unsupported('text_encoding_'+str(enc))
        return {'type':code,'wire_id':u(self.plain,p+16),'value':value,'utf16_sha256':sha(value.encode('utf-16-le')),'encoding':enc,'byte_length':length,'offset':p,'header_length':h,'total':node['total'],'suffix_bytes':end-(b+16+length),'reserved_nonzero':u(self.plain,p+20)!=0 or any(self.plain[b+8:b+16])}

def _census(data, limits):
    tree=Parsed(data, limits);d=tree.plain;rows=[];tracks=[];albums=[];artists=[];playlists=[];issues=[];unknown=[]
    if tree.trailer:
        tree.opaque.append({'address_space':'compression_trailer','offset':0,'end':len(tree.trailer),'section':None,'reason':'unknown_compression_trailer','sha256':sha(tree.trailer)})
    def issue(code,**detail): issues.append({'code':code,**detail})
    def texts(node,owner):
        result={}
        for child in node['children']:
            if child['tag']!='mhoh':continue
            code=u(d,child['offset']+12);pool=POOLS.get((node['tag'],code))
            local=(node['tag']=='mith' and code in (11,13)) or (node['tag']=='miph' and code==100)
            if pool or local:
                try: row=tree.text(child)
                except (Rejected,UnicodeError) as exc:
                    if 'budget' in str(exc): raise
                    unknown.append({'owner':owner,'type':code,'pool':pool,'reason':str(exc)});continue
                if code in result:issue('duplicate_text_occurrence',owner=owner,type=code)
                row.update(owner=owner,owner_tag=node['tag'],pool=pool if pool else 'unkeyed_file_shard' if node['tag']=='mith' else 'playlist_local',external_id_consumed=bool(pool))
                rows.append(row);result[code]=row['value']
            else: tree.opaque.append({'offset':child['offset'],'end':child['offset']+child['total'],'section':node['section'],'reason':'unmapped_mhoh_'+str(code)})
        return result
    for section,tag,hlen,dest,kind in [(9,'miah',88,albums,'album'),(11,'miih',100,artists,'artist')]:
        for n in tree.records(section,tag):
            need(n['header_length']==hlen,'aux_shape')
            p=n['offset'];pid=f'{u(d,p+20,8):016X}';local=u(d,p+16)
            obj={'local_id':local,'pid':pid,'offset':p,'total':n['total'],'header_length':hlen,'flags':u(d,p+28),'retained_40':u(d,p+40) if section==9 else None,'record_sha256':sha(d[p:p+n['total']])}
            obj['text']=texts(n,kind+':'+pid);dest.append(obj)
    for n in tree.records(1,'mith'):
        need(n['header_length']==756,'track_shape');p=n['offset'];pid=f'{u(d,p+0x80,8):016X}'
        t={'pid':pid,'common_local':u(d,p+16),'file_local':u(d,p+0x1f4),'album_ref':u(d,p+0xdc),'artist_ref':u(d,p+0x1e0),'compilation':bool(u(d,p+0x50)&0x1000000),'offset':p,'total':n['total'],'record_sha256':sha(d[p:p+n['total']]),'sort_ranks':[u(d,p+q) for q in (0x290,0x294,0x298,0x29c,0x2a0,0x2a4,0x2a8)]}
        t['text']=texts(n,'track:'+pid);tracks.append(t)
    for n in tree.records(2,'miph'):
        need(n['header_length']==3500,'playlist_shape');p=n['offset'];pid=f'{u(d,p+0x1b8,8):016X}'
        codes=[u(d,x['offset']+12) for x in n['children'] if x['tag']=='mhoh']
        pl={'pid':pid,'local_id':u(d,p+0xd40),'is_master':bool(u(d,p+0x14)&0x10000),'kind_word':u(d,p+0x238),'offset':p,'items':[],'metadata_codes':codes}
        pl['is_plain']=not pl['is_master'] and pl['kind_word']==0 and not any(k in codes for k in (101,102,103))
        pl['text']=texts(n,'playlist:'+pid)
        for child in n['children']:
            if child['tag']!='mtph':continue
            need(child['header_length']==84 and not child['children'],'item_shape');q=child['offset']
            pl['items'].append({'local_id':u(d,q+16),'track_ref':u(d,q+24),'order_token':u(d,q+32),'pid':f'{u(d,q+68,8):016X}','offset':q})
        playlists.append(pl)
    extra_ids=[]
    for node in tree.nodes:
        tag=node['tag'];sec=node['section'];canonical={'mith':1,'miah':9,'miih':11}.get(tag)
        if canonical is not None and sec!=canonical:
            unknown.append({'reason':'secondary_identity_consumer_scope','section':sec,'tag':tag})
            texts(node,'secondary:'+str(sec)+':'+str(node['offset']))
            p=node['offset'];h=node['header_length']
            if tag=='mith' and h==756:
                extra_ids.extend([('track.common_local',u(d,p+16)),('track.file_local',u(d,p+0x1f4)),('track.pid',u(d,p+0x80,8))])
            elif tag in ('miah','miih') and h in (88,100):
                extra_ids.extend([(tag+'.local',u(d,p+16)),(tag+'.pid',u(d,p+20,8))])
    ns={'track.common_local':[t['common_local'] for t in tracks],'track.file_local':[t['file_local'] for t in tracks],'track.pid':[t['pid'] for t in tracks],'album.local':[a['local_id'] for a in albums],'album.pid':[a['pid'] for a in albums],'artist.local':[a['local_id'] for a in artists],'artist.pid':[a['pid'] for a in artists],'playlist.local':[p['local_id'] for p in playlists],'playlist.pid':[p['pid'] for p in playlists]}
    for pl in playlists:
        ns['item.local@'+pl['pid']]=[i['local_id'] for i in pl['items']]
        ns['item.pid@'+pl['pid']]=[i['pid'] for i in pl['items']]
    for name,vals in ns.items():
        repeated=[v for v,n in Counter(vals).items() if n>1]
        if repeated or 0 in vals or '0000000000000000' in vals:issue('zero_or_duplicate_identity',namespace=name,repeated=repeated)
    a_by={a['local_id']:a for a in albums};r_by={a['local_id']:a for a in artists};t_by={t['common_local']:t for t in tracks}
    for t in tracks:
        for role,ref,by in [('album',t['album_ref'],a_by),('artist',t['artist_ref'],r_by)]:
            if ref not in by:issue('missing_object_reference',track=t['pid'],role=role,ref=ref)
        aa=t['text'].get(27,''); ar=t['text'].get(4,'');album=t['text'].get(3,'');effective=aa or ar
        if t['compilation'] and not aa:
            unknown.append({'track':t['pid'],'reason':'compilation_without_album_artist_grouping'})
        else:
            if t['album_ref'] in a_by:
                actual=tuple(a_by[t['album_ref']]['text'].get(c,'') for c in (300,301,302))
                if actual!=(album,effective,aa):issue('resolving_but_wrong_album',track=t['pid'],actual=actual,expected=(album,effective,aa))
            if t['artist_ref'] in r_by and r_by[t['artist_ref']]['text'].get(400,'')!=effective:issue('resolving_but_wrong_artist',track=t['pid'],expected=effective)
    for p in playlists:
        for i in p['items']:
            if i['track_ref'] not in t_by:issue('missing_track_reference',playlist=p['pid'],ref=i['track_ref'])
    masters=[p for p in playlists if p['is_master']]
    if len(masters)!=1:issue('master_count',actual=len(masters))
    elif Counter(i['track_ref'] for i in masters[0]['items'])!=Counter(t_by.keys()):issue('master_membership_not_exactly_once')
    pool_stats={}
    for pool in sorted(set(POOLS.values())):
        uses=[r for r in rows if r['pool']==pool];bindings=defaultdict(set);texts_by_id=defaultdict(set)
        for row in uses:
            if row['wire_id'] and row['value']:
                bindings[row['wire_id']].add(row['utf16_sha256']);texts_by_id[row['utf16_sha256']].add(row['wire_id'])
                if row['wire_id']>=2**31:issue('external_id_not_positive_signed_int',pool=pool,wire_id=row['wire_id'])
        conflicts={str(i):sorted(v) for i,v in bindings.items() if len(v)>1}
        for i,v in conflicts.items():issue('pool_id_text_collision',pool=pool,wire_id=int(i),values=v)
        if bindings and any(r['wire_id']==0 and r['value'] for r in uses):unknown.append({'pool':pool,'reason':'mixed_keyed_unkeyed_nonempty_requires_order_proof'})
        pool_stats[pool]={'used_ids':sorted({r['wire_id'] for r in uses if r['wire_id']>0}),'registered_ids':sorted(bindings),'occurrences':len(uses),'empty_occurrences':sum(r['value']=='' for r in uses),'same_id_different_text_groups':len(conflicts),'same_text_multiple_ids_groups':sum(len(v)>1 for v in texts_by_id.values())}
    m=tree.roots[16]['offset'];filepid=f'{u(tree.header,0x34,8,"big"):016X}';innerpid=f'{u(d,m+0x34,8):016X}'
    if filepid!=innerpid:issue('file_pid_header_mismatch')
    gc=[]
    for role,objects,field in [('album',albums,'album_ref'),('artist',artists,'artist_ref')]:
        for obj in objects:
            incoming=[t['pid'] for t in tracks if t[field]==obj['local_id']]
            gc.append({'role':role,'local_id':obj['local_id'],'pid':obj['pid'],'known_track_inbound':incoming,'known_unreachable':not incoming,'semantic_gc':'retain_live' if incoming else 'retain_pending_opaque_dependency_proof'})
    graph={'schema':'itl.identities.graph.v1','snapshot_sha256':sha(data),'plain_sha256':sha(d),'file_bytes':len(data),'plain_bytes':len(d),'file_pid':filepid,'inner_file_pid':innerpid,'extra_identities':extra_ids,'frame_count':tree.frame_count,'text_bytes':tree.text_bytes,'trailer_bytes':len(tree.trailer),'master_pids':[p['pid'] for p in masters],'namespace_values':ns,'tracks':tracks,'albums':albums,'artists':artists,'playlists':playlists,'strings':rows,'pools':pool_stats,'gc':gc,'sections':tree.sections,'opaque_spans':tree.opaque,'unknown':unknown,'issues':issues,'known_invariants_passed':not issues,'complete_semantic_admission':False,'header_words':{hex(o):{'outer':u(tree.header,o,endian='big'),'inner':u(d,m+o)} for o in (0x3c,0x44,0x48,0x4c,0x54,0x58)}}
    return graph

def _stable_projection(graph):
    a={x['local_id']:x['pid'] for x in graph['albums']};r={x['local_id']:x['pid'] for x in graph['artists']};t={x['common_local']:x['pid'] for x in graph['tracks']}
    return {'file_pid':graph['file_pid'],'master_pids':graph['master_pids'],'albums':{a['pid']:{'text':a['text'],'flags':a['flags'],'retained_40':a['retained_40']} for a in graph['albums']},'artists':{a['pid']:{'text':a['text'],'flags':a['flags']} for a in graph['artists']},'tracks':{x['pid']:{'album_pid':a.get(x['album_ref']),'artist_pid':r.get(x['artist_ref']),'text':x['text'],'compilation':x['compilation']} for x in graph['tracks']},'playlists':{p['pid']:{'members':[t.get(i['track_ref']) for i in p['items']] if p['is_plain'] else sorted(t.get(i['track_ref'],'MISSING') for i in p['items']),'item_pids':sorted(i['pid'] for i in p['items'])} for p in graph['playlists']}}


_DEFAULT_LIMITS = {'max_file_bytes':16*1024*1024, 'max_plain_bytes':16*1024*1024,
                   'max_nodes':100000, 'max_depth':32, 'max_text_bytes':4*1024*1024,
                   'max_json_bytes':64*1024*1024, 'memory_budget_bytes':512*1024*1024}


def _limit_values(limits):
    # This is an enforced protocol adapter, NOT a substitute shared ReadLimits.
    # The codec-owned type is tested only after parent integration supplies it.
    if limits is None:
        values = dict(_DEFAULT_LIMITS)
    elif isinstance(limits, dict):
        if set(limits) != set(_DEFAULT_LIMITS):
            raise ValueError('limits require exactly the seven contracted fields')
        values = dict(limits)
    else:
        values = {k:getattr(limits,k) for k in _DEFAULT_LIMITS}
    if any(type(v) is not int or v<=0 for v in values.values()):
        raise ValueError('limits must contain positive integers, not bool')
    if values['max_depth']>32:
        raise ValueError('this graph implementation supports depth at most32')
    return values


def _bounded_json(value, limits, *, live_bytes=0):
    """Pre-count canonical ASCII JSON, then encode within that exact bound.

    Generated graph/intent data uses only dict/list/tuple, wire integers,
    strings, bool and None. Account for escaped Unicode, punctuation, graph
    storage and transient output buffers before invoking the encoder. This
    is a conservative memory admission estimate, never an OS RSS promise.
    """
    values=_limit_values(limits)
    if type(live_bytes) is not int or live_bytes<0:raise ValueError('invalid live-byte estimate')
    cap=values['max_json_bytes'];memory=values['memory_budget_bytes']
    size=0;elements=0;active=set()
    def admit(amount):
        nonlocal size
        size+=amount
        need(size<=cap,'graph_json_budget')
        need(live_bytes+256*elements+6*size<=memory,'graph_json_memory_budget')
    def text(s):
        # Even an entirely unescaped string cannot fit below this lower bound.
        need(len(s)+2<=cap-size,'graph_json_budget')
        need(live_bytes+256*elements+6*(size+len(s)+2)<=memory,'graph_json_memory_budget')
        admit(2)
        for char in s:
            c=ord(char)
            admit(2 if c in (8,9,10,12,13,34,92) else 1 if 32<=c<=126 else 6 if c<=65535 else 12)
    def visit(v,depth):
        nonlocal elements
        elements+=1
        need(elements<=values['max_nodes']*32,'graph_json_element_budget')
        need(depth<=values['max_depth']*3+16,'graph_json_depth_budget')
        admit(0);kind=type(v)
        if kind in (dict,list,tuple):
            need(id(v) not in active,'graph_json_cycle')
            need(len(v)<=values['max_nodes']*32-elements,'graph_json_element_budget')
            active.add(id(v));admit(2)
            try:
                if kind is dict:
                    for n,(key,item) in enumerate(v.items()):
                        if n:admit(1)
                        if type(key) is int:
                            need(key.bit_length()<=64,'graph_json_integer_range');key=str(key)
                        need(type(key) is str,'graph_json_key_type')
                        text(key);admit(1);visit(item,depth+1)
                else:
                    for n,item in enumerate(v):
                        if n:admit(1)
                        visit(item,depth+1)
            finally:active.remove(id(v))
        elif kind is str:text(v)
        elif kind is bool:admit(4 if v else 5)
        elif v is None:admit(4)
        elif kind is int:
            need(v.bit_length()<=64,'graph_json_integer_range');admit(len(str(v)))
        else:raise Rejected('graph_json_value_type')
    visit(value,0)
    out=bytearray()
    try:
        encoder=json.JSONEncoder(sort_keys=True,separators=(',',':'),ensure_ascii=True,allow_nan=False)
        for part in encoder.iterencode(value):
            # ensure_ascii makes character length equal the encoded byte length.
            need(part.isascii() and len(out)+len(part)<=size,'graph_json_stream_budget')
            out.extend(part.encode('ascii'))
    except (ValueError,TypeError,RecursionError) as exc:
        raise Rejected('graph_json_encoding') from exc
    need(len(out)==size,'graph_json_size_changed')
    return bytes(out)


def _immutable(value):
    if isinstance(value,dict):return MappingProxyType({k:_immutable(v) for k,v in value.items()})
    if isinstance(value,list):return tuple(_immutable(v) for v in value)
    return value


@dataclass(frozen=True, slots=True)
class ReferenceEdge:
    owner: str
    field: str
    target: ScopedID
    evidence_level: str = 'known-wire-reference'


@dataclass(frozen=True, slots=True)
class ReferenceGraph:
    snapshot: SnapshotKey
    _raw: bytes = field(repr=False)
    _plain: bytes = field(repr=False)
    _document: bytes = field(repr=False)
    _limits: tuple = field(repr=False)
    _trailer: bytes = field(repr=False,default=b'')

    def to_dict(self):
        """A defensive diagnostic copy; this is never executable authority."""
        return json.loads(self._document)

    @property
    def data(self):return self._raw

    @property
    def coverage(self):return _immutable(self.to_dict()['coverage'])

    @property
    def owners(self):
        d=self.to_dict();out=[]
        for ns,values in d['namespace_values'].items():
            namespace,_,scope=ns.partition('@')
            for value in values:
                width=8 if '.pid' in namespace else 4
                out.append(ScopedID(namespace,self.snapshot.digest+('/playlist:'+scope if scope else ''),int(value,16) if isinstance(value,str) else value,width))
        out.append(ScopedID('file.pid',self.snapshot.digest,self.snapshot.file_pid,8))
        for value in d['master_pids']:out.append(ScopedID('master.pid',self.snapshot.digest,int(value,16),8))
        return tuple(out)

    @property
    def typed_edges(self):
        d=self.to_dict();out=[];scope=self.snapshot.digest
        for t in d['tracks']:
            for field,ns in [('album_ref','album.local'),('artist_ref','artist.local')]:
                out.append(ReferenceEdge('track:'+t['pid'],field,ScopedID(ns,scope,t[field],4)))
        for pl in d['playlists']:
            for item in pl['items']:
                out.append(ReferenceEdge('item:'+pl['pid']+':'+item['pid'],'track_ref',ScopedID('track.common_local',scope,item['track_ref'],4)))
        for row in d['strings']:
            if row['registered_pool_binding']:
                out.append(ReferenceEdge(row['owner'],str(row['type']),ScopedID('pool:'+row['pool'],scope,row['wire_id'],4)))
        return tuple(out)

    @property
    def opaque_possible_edges(self):
        return tuple(_immutable(v) for v in self.to_dict()['opaque_spans'])


def build_graph(data, *, limits=None):
    """Bounded immutable known graph, no hash allowlist or semantic write grant.

    Accepts bytes, never a file path. Callers must bound file reads themselves.
    Structural errors raise; known identity/semantic issues are reported and
    prevent reservation admission. Unknown dependencies remain explicit.
    """
    values=_limit_values(limits)
    need(type(data) is bytes,'immutable_bytes_required')
    d=_census(data,values)
    # Dispatch supplying an external-ID argument is NOT successful registration:
    # native empty-value handling returns before keyed lookup/interning.
    for row in d['strings']:
        row['registered_pool_binding']=bool(row['external_id_consumed'] and row['value'] and 0<row['wire_id']<2**31)
    # Static keyed dispatch identifies consumer families, but these unparsed
    # library sections are not yet proved disjoint from every target pool.
    pool_blockers=[]
    for span in d['opaque_spans']:
        span.setdefault('address_space','payload')
        if span['reason']=='unknown_compression_trailer':
            pool_blockers.append('pool-disjointness-unproved:compression-trailer')
        if span['section'] in (1,9,11) and span['reason'].startswith('unmapped_mhoh_'):
            pool_blockers.append('unmapped-keyed-owner:'+span['reason'])
        if span['reason']=='unmapped_section':
            pool_blockers.append('pool-disjointness-unproved:section:'+str(span['section']))
    for unknown in d['unknown']:
        pool_blockers.append('unresolved:'+unknown['reason'])
    for row in d['strings']:
        if row['external_id_consumed'] and (row['header_length']!=24 or row['reserved_nonzero'] or row['suffix_bytes']):
            pool_blockers.append('noncanonical-string-consumer:'+row['pool'])
    # Unknown text types under the keyed owner families cannot be silently
    # treated as nonconsumers. Other playlist metadata stays graph-opaque.
    keyed_owners={t['offset'] for t in d['tracks']}|{a['offset'] for a in d['albums']}|{a['offset'] for a in d['artists']}
    d['coverage']={'complete_semantic':False,'pool_blockers':sorted(set(pool_blockers)),
                   'candidate_pools':sorted(POOLS.values()),
                   'pool_dispatch_evidence':'evidence/static/phase3/pool-map.json (known keyed consumers)',
                   'reference_evidence':'evidence/static/phase4/findings.md (typed constructor/persistence observations)',
                   'opaque_gc_authorized':False,'read_limits_protocol_enforced':True}
    header,plain,trailer=_decode(data,values)
    key=SnapshotKey(sha(data),int(d['file_pid'],16),sha(plain))
    d['schema']='itlkit.identity-graph.v2'
    live=4*len(data)+8*len(plain)+4*len(trailer)+1024*d['frame_count']+4*d['text_bytes']
    blob=_bounded_json(d,values,live_bytes=live)
    return ReferenceGraph(key,data,plain,blob,tuple(sorted(values.items())),trailer)


def revalidate_graph(graph):
    """Recompute from bounded raw bytes, not caller-authored coverage fields."""
    if type(graph) is not ReferenceGraph:
        raise TypeError('a built ReferenceGraph is required, not a report dictionary')
    actual=build_graph(graph.data,limits=dict(graph._limits))
    if actual.snapshot!=graph.snapshot or actual._document!=graph._document or actual._plain!=graph._plain or actual._trailer!=graph._trailer:
        raise Unsupported('graph_payload_or_coverage_tampered')
    return actual


def stable_graph(graph):
    graph=revalidate_graph(graph)
    return _immutable(_stable_projection(graph.to_dict()))


def to_canonical_graph(graph, *, limits=None):
    """Transport a REAL raw-backed graph; coverage stays diagnostic only.

    The shared adapter re-decodes and retains complete owner/scope/edge/opaque
    evidence. Its canonical result cannot be supplied as allocator authority.
    """
    from .planning import adapt_identity_graph
    from .identity import _canonical_limits
    return adapt_identity_graph(graph, limits=_canonical_limits(limits))
