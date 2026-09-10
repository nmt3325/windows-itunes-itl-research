"""Explicit research raw trees and evidence-qualified read-only diagnostics.

Raw leaf means children is None in the generic Node tree, NOT that its bytes
have no semantic meaning. A raw edit is never a qualified semantic mutation.
"""
from __future__ import annotations
from dataclasses import dataclass
import base64
import binascii
import hashlib
import json
from .container import Container
from .library import Library, NUMBER_FIELDS, TEXT_FIELDS, READ_ONLY_FIELDS, read_text
from .model import Node, parse_sections, serialize_sections, CHILD_COUNT
from .binary import uint
from .errors import FormatError, UnsupportedError
from .schema import (Record, FieldSpec, ByteSpan, ProfileReport, Blocker, ReadLimits,
                     get_limits, encode_json, load_container, preflight_payload)

RAW_SCHEMA = 'itlkit.raw-tree.v1'
RAW_POLICY = 'same-sized-generic-opaque-leaf-research-only'


def _digest(b):
    return hashlib.sha256(b).hexdigest()


def _baseline(value, limits):
    """Require an explicit wire snapshot, never normalize a live Library."""
    if type(value) is bytes:
        return load_container(value, limits=limits)
    if type(value) is not Container:
        raise TypeError('raw tree requires immutable bytes or an unchanged Container')
    if not value.unchanged or type(value._original) is not bytes:
        raise UnsupportedError('serialize and re-read a Container explicitly before exporting its baseline')
    result = load_container(value._original, limits=limits)
    if (value.header, value.payload, value.trailer) != (result.header, result.payload, result.trailer):
        raise FormatError('Container baseline differs from its original bytes')
    return result


def _raw_tree(c, limits):
    if c.payload_byteorder != 'little':
        raise UnsupportedError('raw record tree supports little-endian only; preserve big-endian with Container')
    stats = preflight_payload(c.payload, limits=limits)
    limits.check('memory', 12 * len(c._original or b'') + 12 * len(c.payload) + stats['nodes'] * 6144)
    sections = parse_sections(c.payload)
    if serialize_sections(sections) != c.payload:
        raise FormatError('raw baseline does not reproduce exact framing')
    return sections


def export_raw_tree(container, *, limits=None) -> dict:
    """Export an intact baseline plus its generic tree; does not mutate input."""
    limits = get_limits(limits); c = _baseline(container, limits)
    sections = _raw_tree(c, limits)
    document = {'schema': RAW_SCHEMA, 'policy': RAW_POLICY,
                'original_file_b64': base64.b64encode(c._original).decode('ascii'),
                'original_sha256': _digest(c._original), 'header_hex': c.header.hex(),
                'trailer_hex': c.trailer.hex(), 'sections': [s.to_dict() for s in sections]}
    encode_json(document, limits=limits)
    return document


def _strict_json(text, limits):
    if type(text) is bytes:
        limits.check('json', len(text)); text = text.decode('utf8')
    elif type(text) is str:
        if len(text) > limits.max_json_bytes:
            raise FormatError('raw JSON exceeds byte budget')
        limits.check('json', len(text.encode('utf8')))
    else:
        return text
    # Guard allocations BEFORE json.loads: many tiny arrays can otherwise turn
    # a small JSON wire into an unbounded Python object graph.
    depth = 0; tokens = 0; in_string = False; escaped = False
    for ch in text:
        if in_string:
            if escaped: escaped = False
            elif ch == '\\': escaped = True
            elif ch == '"': in_string = False
            continue
        if ch == '"': in_string = True; tokens += 1
        elif ch in '{[': depth += 1; tokens += 1
        elif ch in '}]': depth -= 1
        elif ch in ',:': tokens += 1
        if depth > limits.max_depth * 3 + 16:
            raise FormatError('raw JSON lexical nesting budget exceeded')
        if tokens > limits.max_nodes * 32:
            raise FormatError('raw JSON lexical aggregate budget exceeded')
        limits.check('memory', len(text) * 4 + tokens * 256)
    def unique(pairs):
        d = {}
        for k,v in pairs:
            if k in d:
                raise FormatError('duplicate raw JSON key')
            d[k] = v
        return d
    def constant(v):
        raise FormatError('non-finite raw JSON number')
    try:
        return json.loads(text, object_pairs_hook=unique, parse_constant=constant)
    except (ValueError, RecursionError) as exc:
        if isinstance(exc, FormatError):
            raise
        raise FormatError(f'invalid raw JSON: {exc}') from exc


def import_raw_tree(document, *, research_only=False, limits=None,
                    expected_baseline_digest=None) -> Container:
    """Only equal-sized generic opaque payload replacement, explicit opt-in.

    expected_baseline_digest is an optional OUT-OF-BAND caller pin. The digest
    inside unsigned JSON checks self-consistency, not authenticity. Changed
    header/kind/tag/offset/child structure, extra/missing keys and resizing refuse.
    The serializer alone may update the outer physical length after compression.
    No semantic planning/adoption or native acceptance is implied.
    """
    if research_only is not True:
        raise UnsupportedError('raw editing requires research_only=True; no semantic/native authority')
    limits = get_limits(limits); document = _strict_json(document, limits)
    encode_json(document, limits=limits)
    keys = {'schema','policy','original_file_b64','original_sha256','header_hex','trailer_hex','sections'}
    if type(document) is not dict or set(document) != keys or document['schema'] != RAW_SCHEMA or document['policy'] != RAW_POLICY:
        raise FormatError('unsupported raw schema/policy or missing/extra document keys')
    value = document['original_file_b64']
    if type(value) is not str or len(value) > 4 * ((limits.max_file_bytes + 2) // 3):
        raise FormatError('raw baseline base64 exceeds file budget or has invalid type')
    try:
        original = base64.b64decode(value, validate=True)
    except (ValueError, binascii.Error) as exc:
        raise FormatError('invalid raw baseline base64') from exc
    if base64.b64encode(original).decode('ascii') != value:
        raise FormatError('noncanonical raw baseline base64')
    actual_digest = _digest(original)
    if document['original_sha256'] != actual_digest:
        raise FormatError('raw baseline digest mismatch')
    if expected_baseline_digest is not None and expected_baseline_digest != actual_digest:
        raise FormatError('stale raw baseline: external digest pin differs')
    c = load_container(original, limits=limits); sections = _raw_tree(c, limits)
    if document['header_hex'] != c.header.hex() or document['trailer_hex'] != c.trailer.hex():
        raise UnsupportedError('raw header/trailer editing is not permitted')
    proposed = document['sections']
    if type(proposed) is not list or len(proposed) != len(sections):
        raise UnsupportedError('raw section structure changes are not permitted')
    output = bytearray(c.payload); changed = False
    stack = list(zip(reversed(sections), reversed(proposed)))
    while stack:
        node, value = stack.pop()
        leaf = node.children is None
        required = {'tag','kind','header_hex','offset', 'payload_hex' if leaf else 'children'}
        if type(value) is not dict or set(value) != required:
            raise FormatError('missing/extra raw record keys or changed leaf/container shape')
        expected = {'tag':node.tag.decode('ascii',errors='replace'), 'kind':node.kind,
                    'header_hex':node.header.hex(), 'offset':node.offset}
        for key,before in expected.items():
            if type(value[key]) is not type(before) or value[key] != before:
                raise UnsupportedError(f'raw {key} editing is not permitted')
        if leaf:
            data = value['payload_hex']
            if type(data) is not str or len(data) != len(node.payload) * 2:
                raise UnsupportedError('raw payload resizing is not permitted')
            try:
                replacement = bytes.fromhex(data)
            except ValueError as exc:
                raise FormatError('invalid raw payload hex') from exc
            if len(replacement) != len(node.payload) or replacement.hex() != data:
                raise FormatError('raw payload hex must be canonical and same-sized')
            if replacement != node.payload:
                start = node.offset + len(node.header)
                output[start:start + len(node.payload)] = replacement; changed = True
        else:
            children = value['children']
            if type(children) is not list or len(children) != len(node.children):
                raise UnsupportedError('raw child structure changes are not permitted')
            stack.extend(zip(reversed(node.children),reversed(children)))
    if not changed:
        return c
    payload = bytes(output)
    preflight_payload(payload, limits=limits)
    if serialize_sections(parse_sections(payload)) != payload:
        raise FormatError('edited raw payload failed structural roundtrip')
    edited = Container(c.header, payload, c.trailer)
    wire = edited.to_bytes()
    result = load_container(wire, limits=limits)
    if result.payload != payload or result.trailer != c.trailer:
        raise FormatError('raw container reconstruction mismatch')
    if result.header[:8] + result.header[12:] != c.header[:8] + c.header[12:]:
        raise FormatError('raw reconstruction changed non-derived outer header')
    return result


@dataclass(frozen=True)
class RecordCoverage(Record):
    path: tuple
    record_tag: str
    section_kind: int | None
    owner_tag: str | None
    kind: str
    header_size: int
    fields: tuple
    unknown_header_ranges: tuple
    partial_bits: tuple
    payload_bytes: int
    payload_level: str
    payload_details: object


@dataclass(frozen=True)
class CoverageReport(Record):
    schema: str
    profile_report: ProfileReport
    records: tuple
    totals: object
    qualifications: tuple


_SIZE = {b'hdfm':144,b'mfdh':144,b'mith':756,b'miph':3500,b'miah':88,b'miih':100,b'mtph':84}
_SOURCES = ('itlkit/model.py:Node and parse_sections',)


def _specs(tag, kind, hlen, section, version, owner=None, code=None):
    """Addressed bytes are not the same as fully understood semantics."""
    specs=[]; partial=[]
    def add(name, offset, width, level='structural', write='none', namespace=None, mask=None, refs=_SOURCES):
        if offset + width <= hlen:
            specs.append(FieldSpec(tag.decode('ascii',errors='replace'),section,version,hlen,offset,
                width,'big' if tag==b'hdfm' else 'little',mask,namespace,level,write,refs,name=name))
            if type(mask) is int:
                partial.append({'offset':offset,'width':width,'known_mask':mask,
                    'unknown_mask':((1<<(width*8))-1)^mask,'level':'partial_bits','evidence_refs':refs})
    add('tag',0,4);add('header_length',4,4)
    word_name = ('child_count' if kind=='count' else 'logical_size' if tag==b'mfdh' else
                 'physical_size' if tag==b'hdfm' else 'fixed_or_mixed_word_raw' if kind in ('fixed','mixed') else 'total_size')
    add(word_name,8,4,'raw_slot' if word_name=='fixed_or_mixed_word_raw' else 'structural')
    if tag==b'msdh':add('section_kind',12,4)
    if tag in CHILD_COUNT:add('child_count',12,4)
    if tag==b'miph':add('metadata_count',12,4);add('item_count',16,4)
    if kind=='mixed':add('metadata_count',12,4);add('queue_count',16,4)
    if tag==b'mhoh':
        add('metadata_type',12,4)
        add('external_id_raw',16,4,'raw_slot',namespace='context-dependent string pool',refs=('itlkit/atoms.py:POOLS/bindings',))
    known_shape = _SIZE.get(tag)==hlen and version in ('12.13.9.1','12.13.10.3')
    if tag==b'hdfm':
        for name,o,w in [('format',12,2),('subversion',14,2),('version_pascal_length',16,1),('version_ascii',17,len(version)),
            ('section_count',48,4),('file_pid',52,8),('cipher',65,1),('compression',67,1),
            ('track_count',68,4),('playlist_count',72,4),('album_count',76,4),
            ('payload_byteorder',82,1),('artist_count',84,4),('encryption_cap',92,4)]:
            add(name,o,w,'named_accessor',refs=('itlkit/container.py:from_bytes/properties', 'itlkit/library.py:Library._validate'))
    elif known_shape and tag==b'mith':
        for name,(o,w) in NUMBER_FIELDS.items():
            if name=='sample_rate': continue  # parent core correction is separate
            raw = name.endswith('_raw') or name=='record_kind_raw'
            level = 'raw_slot' if raw else 'named_accessor'
            mask = 1 if name in ('name_refresh_flag_raw','played_flag_raw','rating_aux_raw') else None
            ns = {'track_id':'track.local','persistent_id':'track.pid','album_id':'album.local','artist_id':'artist.local'}.get(name)
            add(name,o,w,level,'none' if name in READ_ONLY_FIELDS else 'guarded_legacy',ns,mask,('itlkit/library.py:NUMBER_FIELDS/Track.get/Track.set',))
        add('sample_rate',0x98,4,'evidence_mapped_float32','none',mask='IEEE-754 float32',
            refs=('parent independently confirmed mith+0x98 LEfloat32; core fix separate',))
        add('header_0xf4_8_raw',0xf4,8,'raw_slot','none',mask='uninterpreted_bytes',
            refs=('preserved full mith header[0xf4:0xfc]; no sample-rate semantics',))
        add('secondary_track_id',0x1f4,4,'raw_slot',namespace='track.secondary',refs=('itlkit/library.py:_validate_ids_and_refs',))
        add('compilation',0x50,4,'partial_bits',mask=0x1000000,refs=('itlkit/library.py:Track.get',))
        add('loved',0x2bf,1,'partial_bits','guarded_legacy',mask=2,refs=('itlkit/library.py:Track.get/Track.set',))
        add('unplayed',0xee,1,'partial_bits','guarded_legacy' if version=='12.13.10.3' else 'none',mask=1,refs=('itlkit/library.py:Track.get/Track.set',))
        for name,code in TEXT_FIELDS.items():
            specs.append(FieldSpec('mith',section,version,hlen,{'child_tag':'mhoh','type_code':code},0,
                'bytes','encoding-dependent','context-dependent string pool','named_accessor',
                'none' if name in READ_ONLY_FIELDS else 'guarded_legacy',('itlkit/library.py:TEXT_FIELDS/Track.get/Track.set',),name=name))
    elif known_shape and tag in (b'miah',b'miih'):
        ns='album' if tag==b'miah' else 'artist'
        add('local_id',16,4,'named_accessor',namespace=ns+'.local',refs=('itlkit/library.py:_validate_ids_and_refs',))
        add('persistent_id',20,8,'named_accessor',namespace=ns+'.pid',refs=('itlkit/library.py:_validate_ids_and_refs',))
        add('guard_word_raw',28,4,'raw_slot',refs=('itlkit/trackops.py:_aux_profile',))
        if tag==b'miah':add('retained_state_raw',40,4,'raw_slot',refs=('itlkit/trackops.py:_aux_profile',))
    elif known_shape and tag==b'miph':
        add('master_flag',20,4,'partial_bits',mask=0x10000,refs=('itlkit/library.py:Playlist.is_master',))
        for name,o,w,ns,level in [('record_kind_raw',0x18,4,None,'raw_slot'),
            ('created_hfs_raw',0x1c,4,None,'raw_slot'),('view_kind_raw',0x1b4,4,None,'raw_slot'),
            ('persistent_id',0x1b8,8,'playlist.pid','named_accessor'),
            ('special_kind_raw',0x238,4,None,'raw_slot'),('modified_hfs_raw',0x274,4,None,'raw_slot'),
            ('local_id',0xd40,4,'playlist.local','named_accessor')]:
            add(name,o,w,level,namespace=ns,refs=('itlkit/library.py:Playlist','itlkit/operations.py:_plain'))
    elif known_shape and tag==b'mtph':
        for name,o,w,ns in [('local_id',16,4,'playlist.item.local'),('parent_entry',20,4,'playlist.entry.parent'),
            ('track_id',24,4,'track.local'),('group_raw',28,4,None),
            ('order_token',32,4,'playlist.order_token'),('persistent_id',68,8,'playlist.item.pid')]:
            add(name,o,w,'raw_slot' if name in ('parent_entry','group_raw') else 'named_accessor',namespace=ns,
                refs=('itlkit/library.py:Playlist.items/track_ids','itlkit/operations.py:_item/require_plain_playlist'))
    elif known_shape and tag==b'mfdh':
        for name,o,w in [('section_count',48,4),('self_pid_raw',52,8),('track_count',68,4),
                          ('playlist_count',72,4),('album_count',76,4),('artist_count',84,4)]:
            add(name,o,w,'raw_slot' if name=='self_pid_raw' else 'structural',refs=('itlkit/library.py:_validate/_sync','itlkit/references.py:_SELF'))
    covered=set()
    for f in specs:
        if type(f.offset_or_payload_layout) is int:
            covered.update(range(f.offset_or_payload_layout,f.offset_or_payload_layout+f.width))
    intervals=[];start=None
    for i in range(hlen+1):
        if i<hlen and i not in covered:
            if start is None:start=i
        elif start is not None:
            intervals.append(ByteSpan(start,i,'unknown',('outside named source accessor/framing slots',)));start=None
    # Partial aliases describe the same physical bits; do not count them twice.
    unique={(x['offset'],x['width'],x['known_mask']):x for x in partial}
    return tuple(specs),tuple(intervals),tuple(unique.values())


def _payload_level(node, section, owner):
    if node.children is not None:
        return 'structural_children', {}
    if not node.payload:
        return 'empty', {}
    if node.tag!=b'mhoh':
        return 'opaque_semantics_unverified', {'raw_leaf_research_only':True}
    code=node.type_code
    contexts={'mith':set(TEXT_FIELDS.values()),'miah':{300,301,302},'miih':{400},'miph':{100}}
    named=code in contexts.get(owner,set())
    try:
        text=read_text(node)
    except (ValueError,UnicodeError):
        return 'opaque_semantics_unverified', {'metadata_type':code,'text_helper':'refused','raw_leaf_research_only':True}
    return ('named_text_accessor_not_blanket_writer' if named else 'prefix_decodable_semantics_unverified'), {
        'metadata_type':code,'text_helper':'decoded','decoded_characters':len(text),
        'semantic_write_authority':False,'raw_leaf_research_only':True}


def inspect_coverage(library_or_container, limits=None) -> CoverageReport:
    """Read current model without serialization; never provide an admission ticket.

    Library offsets can refer to its earlier wire snapshot after an in-memory edit;
    paths and header-relative intervals, not offsets, identify diagnostics.
    """
    limits=get_limits(limits)
    if type(library_or_container) is Library:
        from .planning import library_state_digest
        library_state_digest(library_or_container,limits=limits)
        c=library_or_container.container;sections=library_or_container.sections
        if c.payload_byteorder!='little':raise UnsupportedError('Library payload endian unsupported')
    else:
        c=_baseline(library_or_container,limits)
        if c.payload_byteorder=='little':sections=_raw_tree(c,limits)
        else:sections=[]
    cache={};records=[];header_bytes=0;unknown_bytes=0;payload_bytes=0;partial_count=0;depth_max=0
    def record(path,tag,kind,header,section,owner,payload_size,level,details):
        nonlocal header_bytes,unknown_bytes,payload_bytes,partial_count
        key=(tag,kind,len(header),section,c.version,owner)
        if key not in cache:cache[key]=_specs(tag,kind,len(header),section,c.version,owner)
        f,unknown,bits=cache[key]
        r=RecordCoverage(path,tag.decode('ascii',errors='replace'),section,owner,kind,len(header),f,unknown,bits,payload_size,level,details)
        records.append(r);header_bytes+=len(header);unknown_bytes+=sum(s.end-s.start for s in unknown)
        payload_bytes+=payload_size;partial_count+=len(bits)
        limits.check('nodes',len(records));limits.check('memory',len(c.payload)*12+len(records)*6144)
    record((),b'hdfm','outer',c.header,None,None,len(c.payload) if not sections else 0,
           'opaque_big_endian' if c.payload_byteorder=='big' else 'structural_sections',{})
    stack=[(s,(i,),s.section_type,None,0) for i,s in reversed(list(enumerate(sections)))];seen=set()
    while stack:
        n,path,section,owner,depth=stack.pop()
        if type(n) is not Node or id(n) in seen:raise FormatError('cyclic/shared node in coverage')
        seen.add(id(n));limits.check('depth',depth);depth_max=max(depth_max,depth)
        level,details=_payload_level(n,section,owner)
        record(path,n.tag,n.kind,n.header,section,owner,len(n.payload),level,details)
        if n.children is not None:
            if len(records)+len(stack)+len(n.children)>limits.max_nodes:
                raise UnsupportedError('coverage node budget exceeded')
            stack.extend((child,path+(i,),section,n.tag.decode('ascii',errors='replace'),depth+1)
                         for i,child in reversed(list(enumerate(n.children))))
    shapes=sorted({(r.section_kind if r.section_kind is not None else -1,r.record_tag,r.header_size,r.kind) for r in records})
    blockers=(Blocker('semantic_coverage_incomplete','Unknown ranges, raw slots, partial bits and opaque semantics remain.'),)
    profile=ProfileReport(c.version,c.payload_byteorder,tuple({'section_kind':s,'tag':t,'header_size':h,'kind':k} for s,t,h,k in shapes),
        ({'check':'bounded structural inspection only','passed':True},),('read_only_coverage',),blockers,_SOURCES)
    result=CoverageReport('itlkit.coverage.v1',profile,tuple(records),
        {'record_count_including_outer':len(records),'header_bytes':header_bytes,
         'unmapped_header_bytes':unknown_bytes,'generic_leaf_payload_bytes':payload_bytes,
         'partial_bit_sites':partial_count,'maximum_record_depth':depth_max},
        ('Addressed slots are NOT a semantic coverage percentage.',
         'unknown_header_ranges means unaddressed bytes; raw_slot fields remain semantically unverified.',
         'Partial-bit sites retain unknown masks; aliases do not establish additional knowledge.',
         'mhoh prefix decoding alone is not semantic support (notably type 508).',
         'Read/write levels describe existing guarded accessors, not automatic mutation authority.',
         'No native qualification; Library model inspection never normalizes or repairs its input.'))
    encode_json(result,limits=limits)
    return result
