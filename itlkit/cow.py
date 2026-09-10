"""Experimental isolated COW preparation; no publication or native calls.

No fallback from a legacy refusal. This engine has its own explicit, narrower
closure gates. Missing codec integration is reported, never replaced by a stub.
"""
from __future__ import annotations
from dataclasses import dataclass,asdict
import copy
import hashlib
import json
from .binary import uint,put
from .container import Container
from .library import Library,set_text,read_text,text_nodes
from .errors import FormatError,UnsupportedError
from .graph import build_graph,_limit_values,_bounded_json,Rejected
from .identity import ReservationAllocator,AllocationLedger,source_binding,ScopedID,SourceBinding,_check_journal
from .trackops import _aux_profile

_FIELDS={'name':2,'album':3,'artist':4,'comment':8,'composer':12,'album_artist':27}
_POOL={2:'L+0x178',3:'L+0x1c0',4:'L+0x208',8:'L+0x400',12:'L+0x208',27:'L+0x208',300:'L+0x1c0',301:'L+0x208',302:'L+0x208',400:'L+0x208'}
_AUX={9:('album',b'miah',88,(300,301,302),0xdc),11:('artist',b'miih',100,(400,),0x1e0)}


def _sha(data):return hashlib.sha256(data).hexdigest()


@dataclass(frozen=True,slots=True)
class BlockedCOW:
    baseline_digest: str
    blockers: tuple[str,...]
    engine: str='cow.v2'
    blocked: bool=True

    def to_dict(self):return asdict(self)


@dataclass(frozen=True,slots=True)
class TextPatch:
    owner: str
    code: int
    value: str
    identity: ScopedID


@dataclass(frozen=True,slots=True)
class _Candidate:
    baseline: bytes
    intent_json: bytes
    candidate_bytes: bytes
    journal: AllocationLedger
    text_patches: tuple[TextPatch,...]
    # A validated private candidate, not a PreparedMutation/adoption capability.


def _intent(intent,limits):
    if type(intent) is not dict or set(intent)!={'track_pid','fields'}:
        raise ValueError('COW intent is exactly {track_pid: canonical hex, fields: object}')
    pid=intent['track_pid'];fields=intent['fields']
    if type(pid) is not str or len(pid)!=16 or any(c not in '0123456789ABCDEF' for c in pid) or int(pid,16)==0:
        raise ValueError('track_pid must be16 uppercase hexadecimal digits, nonzero')
    if type(fields) is not dict or not fields or set(fields)-set(_FIELDS):
        raise ValueError('COW supports name/album/artist/album_artist/comment/composer only')
    if any(type(v) is not str or '\0' in v for v in fields.values()):
        raise ValueError('COW fields must be NUL-free strings')
    if 4*sum(map(len,fields.values()))>limits['max_text_bytes']:
        raise UnsupportedError('intent aggregate text allocation budget')
    try:canonical=_bounded_json(intent,limits,live_bytes=4*sum(map(len,fields.values())))
    except Rejected as exc:raise UnsupportedError('intent JSON budget: '+str(exc)) from exc
    return pid,dict(fields),canonical


def _text(node,code):
    found=text_nodes(node,code)
    if len(found)>1:raise UnsupportedError('ambiguous text occurrence')
    return read_text(found[0]) if found else ''


def _keys(node,fields):
    future={k:fields.get(k,_text(node,_FIELDS[k])) for k in ('album','artist','album_artist')}
    if uint(node.header,0x50)&0x01000000 and not future['album_artist']:
        raise UnsupportedError('compilation without explicit AlbumArtist grouping is unproved')
    effective=future['album_artist'] or future['artist']
    return {9:(future['album'],effective,future['album_artist']),11:(effective,)}


def _analyse(data,intent,limits):
    values=_limit_values(limits);pid,fields,canonical=_intent(intent,values)
    graph=build_graph(data,limits=values);d=graph.to_dict()
    reasons=[x['code'] for x in d['issues']]
    lib=Library.from_bytes(data,max_plain_bytes=values['max_plain_bytes'])
    matches=[t for t in lib.tracks if f'{t.persistent_id:016X}'==pid]
    if len(matches)!=1:return BlockedCOW(_sha(data),tuple(reasons+['target_track_missing_or_ambiguous']))
    target=matches[0].node
    changed={_FIELDS[k]:v for k,v in fields.items() if _text(target,_FIELDS[k])!=v}
    old_aux={};changed_aux={}
    if changed:
        reasons.extend(d['coverage']['pool_blockers'])
        if any(not value for value in changed.values()):reasons.append('empty/unset text transition not yet implemented')
        if lib.container.trailer:reasons.append('unknown compression trailer')
        if any(c.tag!=b'mhoh' for c in target.children or ()):reasons.append('unknown selected track child family')
        if any(p.is_smart and uint(p.node.header,0x238)==0 for p in lib.playlists):reasons.append('custom-smart metadata dependencies unproved')
        if any(s['reason']=='unmapped_leaf_msph' for s in d['opaque_spans']):reasons.append('msph metadata dependency/refresh proof required')
        try:
            for code in changed:
                for node in text_nodes(target,code):
                    if len(node.header)!=24 or uint(node.header,20)!=0 or node.payload[8:16]!=bytes(8) or len(node.payload)!=16+uint(node.payload,4):
                        raise UnsupportedError('selected text has noncanonical header/prefix/suffix')
            lib._require_semantic_profile();keys=_keys(target,fields)
            for section,(kind,tag,size,codes,ref) in _AUX.items():
                matches=[a for a in lib._records(section,tag) if uint(a.header,16)==uint(target.header,ref)]
                if len(matches)!=1:raise UnsupportedError('target auxiliary reference missing/ambiguous')
                old=matches[0];old_aux[section]=old
                before=tuple(_text(old,code) for code in codes)
                if before!=keys[section]:
                    _aux_profile(old,section)
                    if uint(old.header,28)!=2 or not any(before):raise UnsupportedError('blank auxiliary identity transition unproved')
                    changed_aux[section]=keys[section]
        except UnsupportedError as exc:reasons.append(str(exc))
    if reasons:return BlockedCOW(_sha(data),tuple(sorted(set(reasons))))
    return values,graph,lib,target,changed,old_aux,changed_aux,canonical


def _write_text(graph,allocator,node,old_owner,new_owner,code,value,patches):
    binding=source_binding(graph,old_owner,code) if text_nodes(node,code) and _text(node,code) else None
    identity=allocator.atom(_POOL[code],binding,value)
    set_text(node,code,value);put(text_nodes(node,code)[0].header,16,identity.value)
    patches.append(TextPatch(new_owner,code,value,identity))


def _prepare_candidate(data,intent,*,limits=None,seed=None):
    context=_analyse(data,intent,limits)
    if type(context) is BlockedCOW:return context
    values,g,lib,target,changed,old_aux,changed_aux,canonical=context
    allocator=ReservationAllocator(g,seed=seed);patches=[];owner='track:'+intent['track_pid']
    for code,value in sorted(changed.items()):
        _write_text(g,allocator,target,owner,owner,code,value,patches)
    if 2 in changed:target.header[0x6d]&=0xfe  # Never touch ee or rank words.
    for section,new_key in sorted(changed_aux.items()):
        kind,tag,size,codes,ref=_AUX[section];old=old_aux[section];clone=copy.deepcopy(old)
        local=allocator.local(kind);pid=allocator.persistent(kind)
        put(clone.header,16,local.value);put(clone.header,20,pid.value,8)
        old_owner=kind+':'+f'{uint(old.header,20,8):016X}';new_owner=kind+':'+f'{pid.value:016X}'
        for code,value in zip(codes,new_key):
            if _text(old,code)!=value:
                if not value:raise UnsupportedError('auxiliary unset transition unproved')
                _write_text(g,allocator,clone,old_owner,new_owner,code,value,patches)
        lib._root(section).children.append(clone);put(target.header,ref,local.value)
        # Deliberately retain every old object, even if known inbound becomes0.
    journal=allocator.freeze()
    if changed:
        payload=lib._sync()  # Synchronize BEFORE reading the updated header.
        if len(payload)>values['max_plain_bytes']:raise UnsupportedError('candidate plaintext budget')
        candidate=Container(lib.container.header,payload,lib.container.trailer).to_bytes()
    else:candidate=data
    result=_Candidate(data,canonical,candidate,journal,tuple(patches))
    if not _validate_candidate(result,limits=values):raise UnsupportedError('independent COW closure verification failed')
    return result


def _expected_text(old,code,value,identity):
    # Independent deterministic wire expectation, no allocator or builder calls.
    h=bytearray(old.header) if old is not None else bytearray(24)
    if old is None:h[:4]=b'mhoh';put(h,4,24);put(h,12,code)
    prefix=bytearray(old.payload[:16]) if old is not None else bytearray(16)
    encoding=uint(prefix,0) if old is not None else 3
    if any(ord(c)>127 for c in value):encoding=1
    if encoding not in (1,3):raise UnsupportedError('unproved modified text encoding')
    raw=value.encode('utf-16-le' if encoding==1 else 'latin-1')
    put(prefix,0,encoding);put(prefix,4,len(raw));put(h,16,identity.value);put(h,8,24+16+len(raw))
    return bytes(h)+bytes(prefix)+raw


def _expected_record(old,owner,patches,*,local=None,pid=None,refs=(),name_refresh=False):
    relevant={p.code:p for p in patches if p.owner==owner}
    if len(relevant)!=sum(p.owner==owner for p in patches):raise UnsupportedError('duplicate typed text patch')
    children=[];seen=set()
    for child in old.children or ():
        patch=relevant.get(child.type_code) if child.tag==b'mhoh' else None
        if patch is not None:
            children.append(_expected_text(child,patch.code,patch.value,patch.identity));seen.add(patch.code)
        else:children.append(child.to_bytes())
    for code,patch in sorted(relevant.items()):
        if code not in seen:children.append(_expected_text(None,code,patch.value,patch.identity))
    h=bytearray(old.header);body=b''.join(children);put(h,8,len(h)+len(body));put(h,12,len(children))
    if local is not None:put(h,16,local)
    if pid is not None:put(h,20,pid,8)
    for offset,value in refs:put(h,offset,value)
    if name_refresh:h[0x6d]&=0xfe
    return bytes(h)+body


def _validate_journal_evidence(ledger,graph,patches,old_owner_for_new):
    """Independent target-local COW evidence checks, never allocator replay.

    The caller already checked immutable journal shape/budgets. This engine
    uses fresh reservations and no retirement. Historical/foreign journals
    require a separate adapter and are not coerced into this target scope.
    """
    d=graph.to_dict();by_id={e.reserved_identity:e for e in ledger.entries}
    values_by_id={};pool_next={p:max(x['used_ids']+[0])+1 for p,x in d['pools'].items()}
    for patch in patches:
        source_owner=old_owner_for_new.get(patch.owner)
        if source_owner is None:return False
        rows=[r for r in d['strings'] if r['owner']==source_owner and r['type']==patch.code]
        if len(rows)>1:return False
        old=None
        if rows and rows[0]['value']:
            row=rows[0]
            if not row['registered_pool_binding'] or row['pool']!=_POOL[patch.code]:return False
            old=SourceBinding(graph.snapshot,row['pool'],row['wire_id'],row['utf16_sha256'])
        if by_id[patch.identity].old_identity!=old:return False
        values_by_id.setdefault(patch.identity,set()).add(patch.value)
    seen_local=set();seen_pid=set();atom_keys=set()
    for entry in ledger.entries:
        identity=entry.reserved_identity;checks=dict(entry.capacity_check);ns=identity.namespace
        if ns.startswith('pool:'):
            pool=ns[5:]
            if pool not in pool_next or identity.width!=4 or identity.value!=pool_next[pool]:return False
            pool_next[pool]+=1
            if checks!={'upper_bound':65535,'dense_bytes':4*(identity.value+1)}:return False
            values=values_by_id.get(identity,set())
            if len(values)!=1:return False
            key=(pool,entry.old_identity,next(iter(values)))
            if key in atom_keys:return False
            atom_keys.add(key)
            if entry.old_identity is None:expected_consumers=()
            elif type(entry.old_identity) is SourceBinding:
                old=entry.old_identity
                if old.snapshot!=graph.snapshot or old.pool!=pool:return False
                rows=[r for r in d['strings'] if r['registered_pool_binding'] and r['pool']==pool and r['wire_id']==old.wire_id and r['utf16_sha256']==old.value_digest]
                if not rows:return False
                expected_consumers=tuple(sorted(r['owner']+':'+str(r['type']) for r in rows))
            else:return False
            if entry.consumers!=expected_consumers:return False
        elif ns in ('album.local','artist.local'):
            if identity.width!=4 or identity.value in seen_local:return False
            seen_local.add(identity.value)
            if set(checks)!={'upper_bound','probes'} or checks['upper_bound']!=1000000 or not 1<=checks['probes']<=4096:return False
            if entry.old_identity is not None or entry.consumers:return False
        elif ns in ('album.pid','artist.pid'):
            if identity.width!=8 or identity.value in seen_pid:return False
            seen_pid.add(identity.value)
            if set(checks)!={'width','probes'} or checks['width']!=8 or not 1<=checks['probes']<=4096:return False
            if entry.old_identity is not None or entry.consumers:return False
        else:return False
    return True


def _validate_candidate(result,*,limits=None):
    # Recompute admission and all expected modified/retained wire records.
    if type(result) is not _Candidate:return False
    bounds=_limit_values(limits)
    if type(result.intent_json) is not bytes or len(result.intent_json)>min(bounds['max_json_bytes'],bounds['memory_budget_bytes']//8):return False
    if type(result.text_patches) is not tuple or len(result.text_patches)>16:return False
    if any(type(p) is not TextPatch or type(p.identity) is not ScopedID or type(p.code) is not int or p.code not in _POOL or type(p.owner) is not str or len(p.owner)>128 or type(p.value) is not str or 2*len(p.value)>bounds['max_text_bytes'] for p in result.text_patches):return False
    try:
        _check_journal(result.journal,10000,min(bounds['max_json_bytes'],bounds['memory_budget_bytes']//8))
        intent=json.loads(result.intent_json)
    except (TypeError,ValueError,UnsupportedError):return False
    context=_analyse(result.baseline,intent,bounds)
    if type(context) is BlockedCOW:return False
    values,g,before,target,changed,old_aux,changed_aux,canonical=context
    if canonical!=result.intent_json or result.journal.snapshot!=g.snapshot:return False
    after_graph=build_graph(result.candidate_bytes,limits=values)
    if after_graph.to_dict()['issues'] or (changed and after_graph.coverage['pool_blockers']):return False
    after=Library.from_bytes(result.candidate_bytes,max_plain_bytes=values['max_plain_bytes'])
    if after.persistent_id!=before.persistent_id:return False
    entries=result.journal.entries;reserved={e.reserved_identity for e in entries}
    if result.journal.retired:return False  # This COW engine never retires/reclaims.
    if any(p.identity not in reserved or p.identity.namespace!='pool:'+_POOL[p.code] or p.identity.scope!=g.snapshot.digest for p in result.text_patches):return False
    old_local={x.value for x in g.owners if x.width==4};old_pids={x.value for x in g.owners if x.width==8}
    raw_guard=b''.join((g.data[:144],g._plain,g._trailer))
    for e in entries:
        identity=e.reserved_identity
        if identity.scope!=g.snapshot.digest or not identity.value:return False
        if identity.namespace.startswith('pool:'):
            pool=identity.namespace[5:]
            if not identity.value<=65535 or identity.value in g.to_dict()['pools'][pool]['used_ids']:return False
        elif identity.width==4:
            if identity.value in old_local or identity.value>1000000 or identity.value.to_bytes(4,'little') in raw_guard or identity.value.to_bytes(4,'big') in raw_guard:return False
        elif identity.width==8:
            if identity.value in old_pids or any(p in raw_guard for p in (identity.value.to_bytes(8,'little'),identity.value.to_bytes(8,'big'),f'{identity.value:016X}'.encode(),f'{identity.value:016x}'.encode())):return False
        else:return False
    owner='track:'+intent['track_pid'];refs=[];extra={};expected_patch_values={(owner,code):value for code,value in changed.items()}
    old_owner_for_new={owner:owner}
    for section,key in changed_aux.items():
        kind,tag,size,codes,ref=_AUX[section]
        local=[e.reserved_identity for e in entries if e.namespace==kind+'.local']
        pid=[e.reserved_identity for e in entries if e.namespace==kind+'.pid']
        if len(local)!=1 or len(pid)!=1:return False
        new_owner=kind+':'+f'{pid[0].value:016X}';old=old_aux[section]
        old_owner_for_new[new_owner]=kind+':'+f'{uint(old.header,20,8):016X}'
        for code,value in zip(codes,key):
            if _text(old,code)!=value:expected_patch_values[new_owner,code]=value
        extra[section]=_expected_record(old,new_owner,result.text_patches,local=local[0].value,pid=pid[0].value)
        refs.append((ref,local[0].value))
    if {(p.owner,p.code):p.value for p in result.text_patches}!=expected_patch_values:return False
    if len(expected_patch_values)!=len(result.text_patches):return False
    if not _validate_journal_evidence(result.journal,g,result.text_patches,old_owner_for_new):return False
    # Reject unused reservations, incorrect namespaces and duplicate allocations.
    used={p.identity for p in result.text_patches}|{e.reserved_identity for e in entries if e.namespace in {v+'.'+k for sec in changed_aux for v in [_AUX[sec][0]] for k in ('local','pid')}}
    if used!=reserved or len(reserved)!=len(entries):return False
    changed_track=_expected_record(target,owner,result.text_patches,refs=refs,name_refresh=2 in changed)
    expected_sections=[]
    for section in before.sections:
        kind=section.section_type
        if kind==16:expected_sections.append(None);continue
        if kind==1 or kind in extra:
            root=before._root(kind);records=[]
            for node in root.children:
                records.append(changed_track if node is target else node.to_bytes())
            if kind in extra:records.append(extra[kind])
            rh=bytearray(root.header);put(rh,8,len(records));body=bytes(rh)+b''.join(records)
            sh=bytearray(section.header);put(sh,8,len(sh)+len(body));expected_sections.append(bytes(sh)+body)
        else:expected_sections.append(section.to_bytes())
    main=before._root(16);mh=bytearray(main.header)
    plain_size=sum(len(v) for v in expected_sections if v is not None)+next(len(s.header)+len(main.header) for s in before.sections if s.section_type==16)
    put(mh,8,plain_size+len(before.container.header))
    for sec,off in ((9,0x4c),(11,0x54)):put(mh,off,uint(mh,off)+(1 if sec in extra else 0))
    for index,section in enumerate(before.sections):
        if section.section_type==16:expected_sections[index]=bytes(section.header)+bytes(mh)
    if b''.join(expected_sections)!=after.container.payload:return False
    outer=bytearray(before.container.header);put(outer,8,len(result.candidate_bytes),endian='big')
    for sec,off in ((9,0x4c),(11,0x54)):put(outer,off,uint(outer,off,endian='big')+(1 if sec in extra else 0),endian='big')
    return bytes(outer)==after.container.header and before.container.trailer==after.container.trailer


def prepare(target_bytes,intent,sources=None,*,limits=None,seed=None):
    """Return shared PreparedMutation or blocked profile; never publish bytes.

    Without the real codec dependency this returns BlockedCOW, not a fake plan.
    """
    if sources is not None and (type(sources) is not dict or sources):
        raise ValueError('COW has no external sources; use the import engine')
    context=_analyse(target_bytes,intent,limits)
    try:
        from . import schema,planning
    except ImportError:
        reasons=('codec_schema_planning_dependency_missing',)
        if type(context) is BlockedCOW:reasons+=context.blockers
        return BlockedCOW(_sha(target_bytes),tuple(sorted(set(reasons))))
    if type(context) is BlockedCOW:
        return schema.ProfileReport(blockers=tuple(schema.Blocker('cow_dependency',r) for r in context.blockers))
    private=[];expected=[]
    def build(data,intent,sources,*,limits,seed):
        from .identity import to_shared_ledger
        result=_prepare_candidate(data,intent,limits=limits,seed=seed)
        if type(result) is BlockedCOW:return schema.ProfileReport(blockers=tuple(schema.Blocker('cow_dependency',r) for r in result.blockers))
        private.append(result)
        draft=planning.MutationDraft(result.candidate_bytes,
            schema.ProfileReport(context[2].container.version,context[2].container.payload_byteorder,capabilities=('scoped_metadata_COW_experimental',),
                invariants=({'check':'independent exact closure','passed':True},),evidence_refs=('docs/identities-v2.md','static phase3 keyed dispatch')),
            to_shared_ledger(result.journal),
            typed_patches=tuple(asdict(p) for p in result.text_patches),
            opaque_preservation=({'check':'all unselected records/old aux/opaque sections exact; no GC','passed':True},),
            postconditions=({'check':'source-derived exact expected plaintext/headers','passed':True},
                            {'check':'Name6d independent of ee/ranks','passed':True}))
        expected.append({k:schema.plain(getattr(draft,k)) for k in ('profile_report','allocation_ledger','typed_patches','opaque_preservation','postconditions')})
        return draft
    def validate(data,intent,sources,candidate,report,*,limits):
        if len(private)!=1 or sources:return False
        result=private[0]
        if data!=result.baseline or candidate!=result.candidate_bytes or _intent(intent,_limit_values(limits))[2]!=result.intent_json:return False
        if any(report.get(k)!=v for k,v in expected[0].items()):return False
        return _validate_candidate(result,limits=limits)
    return planning.prepare_mutation('cow.v2',target_bytes,intent,sources,limits=limits,seed=seed,build=build,validate=validate)