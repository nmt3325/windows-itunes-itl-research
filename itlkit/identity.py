"""Typed bounded reservations; no native execution, mutations or publication.

Exact experimental surface is documented in docs/identities-v2.md. A ledger is
an immutable reservation journal, never caller-issued semantic write authority.
"""
from __future__ import annotations
from dataclasses import dataclass, asdict
from functools import wraps
import hashlib
import secrets
from .errors import UnsupportedError


def _positive(value, upper, name):
    if type(value) is not int or not 0 < value <= upper:
        raise ValueError(name+' must be a bounded positive integer')
    return value


def _digest(value):
    if type(value) is not str or len(value)!=64 or any(c not in '0123456789abcdef' for c in value):
        raise ValueError('canonical SHA256 hex required')


@dataclass(frozen=True, slots=True)
class SnapshotKey:
    digest: str
    file_pid: int
    plain_digest: str

    def __post_init__(self):
        _digest(self.digest);_digest(self.plain_digest)
        _positive(self.file_pid,2**64-1,'file_pid')


@dataclass(frozen=True, slots=True)
class ScopedID:
    namespace: str
    scope: str
    value: int
    width: int

    def __post_init__(self):
        if type(self.namespace) is not str or not self.namespace or type(self.scope) is not str or not self.scope:
            raise ValueError('namespace and scope are required')
        if type(self.width) is not int or self.width not in (4,8) or type(self.value) is not int or not 0<=self.value<2**(8*self.width):
            raise ValueError('invalid typed wire identity')


@dataclass(frozen=True, slots=True)
class SourceBinding:
    snapshot: SnapshotKey
    pool: str
    wire_id: int
    value_digest: str

    def __post_init__(self):
        if type(self.snapshot) is not SnapshotKey or type(self.pool) is not str or not self.pool:
            raise TypeError('typed snapshot and exact pool required')
        if type(self.wire_id) is not int or not 0<=self.wire_id<2**31:
            raise ValueError('source external ID must be nonnegative signed32')
        _digest(self.value_digest)


@dataclass(frozen=True, slots=True)
class Reservation:
    namespace: str
    scope: str
    old_identity: ScopedID | SourceBinding | None
    reserved_identity: ScopedID
    consumers: tuple[str,...]
    capacity_check: tuple[tuple[str,int],...]


@dataclass(frozen=True, slots=True)
class AllocationLedger:
    snapshot: SnapshotKey
    entries: tuple[Reservation,...]
    retired: tuple[ScopedID,...]
    seed_commitment: str

    def to_dict(self):
        """Defensive report, not a deserialization/apply capability."""
        return asdict(self)


def _scope(identity):
    if type(identity) is not ScopedID:raise TypeError('typed scoped identity required')
    if len(identity.namespace)>64 or len(identity.scope) not in (64,90):raise ValueError('bounded canonical identity scope required')
    base,separator,playlist=identity.scope.partition('/playlist:');_digest(base)
    if separator:
        if identity.namespace not in ('item.local','item.pid','item.order_token') or len(playlist)!=16 or any(c not in '0123456789ABCDEF' for c in playlist) or int(playlist,16)==0:
            raise ValueError('invalid playlist-local identity scope')
    elif identity.namespace=='item.order_token':raise ValueError('order token requires playlist-local scope')


def seed_from_text(text):
    """Domain-separated SHA256 of length-prefixed strict UTF8; no normalization.

    Empty text is deterministic, not a request for randomness. At most4096
    UTF8 bytes; the character precheck also bounds the temporary UTF8 buffer.
    Existing integer and binary-seed encodings are deliberately unchanged.
    """
    if type(text) is not str:raise TypeError('text seed must be a string')
    if len(text)>4096:raise ValueError('text seed exceeds4096 UTF8 bytes')
    try:encoded=text.encode('utf-8','strict')
    except UnicodeEncodeError as exc:raise ValueError('text seed must be valid Unicode for strict UTF8') from exc
    if len(encoded)>4096:raise ValueError('text seed exceeds4096 UTF8 bytes')
    return hashlib.sha256(b'itl.identity.text-seed.v1\0'+len(encoded).to_bytes(4,'big')+encoded).digest()


def _entry_size(entry):
    if type(entry) is not Reservation or type(entry.consumers) is not tuple or type(entry.capacity_check) is not tuple:
        raise TypeError('immutable typed reservation required')
    _scope(entry.reserved_identity)
    if (entry.namespace,entry.scope)!=(entry.reserved_identity.namespace,entry.reserved_identity.scope):
        raise ValueError('reservation namespace/scope mismatch')
    if any(type(c) is not str or len(c)>512 for c in entry.consumers):raise TypeError('bounded immutable consumer strings required')
    if len(entry.capacity_check)>16 or any(type(c) is not tuple or len(c)!=2 or type(c[0]) is not str or c[0] not in ('upper_bound','dense_bytes','probes','width') or type(c[1]) is not int or not 0<=c[1]<2**64 for c in entry.capacity_check):
        raise TypeError('invalid immutable capacity evidence')
    if len(dict(entry.capacity_check))!=len(entry.capacity_check):raise ValueError('duplicate capacity fields')
    old=entry.old_identity
    if type(old) is ScopedID:
        _scope(old)
        if old.namespace!=entry.namespace:raise ValueError('old identity namespace mismatch')
    elif type(old) is SourceBinding:
        if len(old.pool)>64:raise ValueError('bounded source pool name required')
        if entry.namespace!='pool:'+old.pool:raise ValueError('source binding namespace mismatch')
    elif old is not None:raise TypeError('old identity must be typed')
    return 1024+sum(4*(64+len(c)) for c in entry.consumers)


def _check_journal(journal,max_reservations=100000,byte_limit=64*1024*1024):
    if type(journal) is not AllocationLedger or type(journal.snapshot) is not SnapshotKey or type(journal.entries) is not tuple or type(journal.retired) is not tuple:
        raise TypeError('complete immutable AllocationLedger required')
    _digest(journal.seed_commitment)
    if len(journal.entries)+len(journal.retired)>max_reservations:raise UnsupportedError('journal reservation budget')
    size=0;ids=set();retired=set()
    for entry in journal.entries:
        size+=_entry_size(entry)
        if entry.reserved_identity in ids:raise ValueError('duplicate journal reservation')
        ids.add(entry.reserved_identity)
        if size>byte_limit:raise UnsupportedError('aggregate journal evidence budget')
    for identity in journal.retired:
        _scope(identity);size+=512
        if identity in retired:raise ValueError('duplicate retirement entry')
        retired.add(identity)
    if size>byte_limit:raise UnsupportedError('aggregate journal evidence budget')
    return size


def source_binding(graph, owner, type_code):
    from .graph import revalidate_graph
    g=revalidate_graph(graph);d=g.to_dict()
    rows=[r for r in d['strings'] if r['owner']==owner and r['type']==type_code and r['registered_pool_binding']]
    if len(rows)!=1:raise UnsupportedError('one unambiguous source consumer is required')
    row=rows[0]
    return SourceBinding(g.snapshot,row['pool'],row['wire_id'],row['utf16_sha256'])


def _operation(method):
    @wraps(method)
    def wrapped(self,*args,**kwargs):
        self._open()
        try:return method(self,*args,**kwargs)
        except Exception:
            self._failed=True
            raise
    return wrapped


class ReservationAllocator:
    """Validate raw graphs, reserve once, freeze once. No new randomness on apply.

    Local namespaces remain distinct; a fresh-write exclusion union is only a
    conservative policy. Retired IDs are never reclaimed by this transaction.
    A previous ledger can carry exclusions across snapshots of the same file
    lineage; it cannot grant source membership, pool coverage or patch rights.
    """
    LOCAL={'track.common':'track.common_local','track.file':'track.file_local',
           'album':'album.local','artist':'artist.local','playlist':'playlist.local','item':'item.local'}
    PID_KINDS=frozenset(('track','album','artist','playlist','item'))

    def __init__(self,graph,*,sources=(),seed=None,journal=None,max_dense_id=65535,
                 max_local_id=1000000,max_probes=4096,max_reservations=10000,
                 max_scan_bytes=64*1024*1024):
        from .graph import revalidate_graph
        self.max_dense_id=_positive(max_dense_id,65535,'max_dense_id')
        self.max_local_id=_positive(max_local_id,2**32-1,'max_local_id')
        self.max_probes=_positive(max_probes,4096,'max_probes')
        self.max_reservations=_positive(max_reservations,100000,'max_reservations')
        self.max_scan_bytes=_positive(max_scan_bytes,512*1024*1024,'max_scan_bytes')
        if type(sources) not in (tuple,list) or len(sources)>32:
            raise ValueError('at most32 bounded source graphs')
        g=revalidate_graph(graph)
        graph_budget=min(64*1024*1024,dict(g._limits)['memory_budget_bytes']//4)
        retained=lambda x:len(x.data)+len(x._plain)+len(x._trailer)+4*len(x._document)
        total=retained(g)
        if total>graph_budget:raise UnsupportedError('aggregate retained graph budget')
        d=g.to_dict()
        if d['issues']:raise UnsupportedError('cannot reserve from an invalid known graph')
        self.snapshot=g.snapshot;self._graphs={g.snapshot:g};self._docs={g.snapshot:d}
        for source in sources:
            s=revalidate_graph(source);total+=retained(s)
            if total>graph_budget:raise UnsupportedError('aggregate retained source graph budget')
            sd=s.to_dict()
            if sd['issues']:raise UnsupportedError('invalid imported source graph')
            self._graphs[s.snapshot]=s;self._docs[s.snapshot]=sd
        self._raw=b''.join((g.data[:144],g._plain,g._trailer))
        self._scope=self.snapshot.digest;self._doc=d
        self._used=set();self._pids=set();self._pool={p:set(x['used_ids']) for p,x in d['pools'].items()}
        self._tokens={i['order_token'] for p in d['playlists'] for i in p['items']}
        self._existing=set(g.owners);self._playlists={int(p['pid'],16) for p in d['playlists']}
        for doc in self._docs.values():
            for ns,vals in doc['namespace_values'].items():
                if '.pid' not in ns and any(v>self.max_local_id for v in vals):
                    raise UnsupportedError('input local IDs exceed allocation policy')
            for namespace,value in doc.get('extra_identities',()):
                if type(value) is not int or not 0<=value<2**(64 if '.pid' in namespace else 32) or ('.pid' not in namespace and value>self.max_local_id):
                    raise UnsupportedError('secondary/imported identity exceeds input allocation policy')
            if any(i['order_token']>self.max_local_id for p in doc['playlists'] for i in p['items']):
                raise UnsupportedError('input order token exceeds allocation policy')
            if any(v>self.max_dense_id for x in doc['pools'].values() for v in x['used_ids']):
                raise UnsupportedError('input pool ID exceeds small dense allocation policy')
        for identity in self._existing:
            (self._pids if identity.width==8 else self._used).add(identity.value)
        for ns,value in d.get('extra_identities',()):
            (self._pids if '.pid' in ns else self._used).add(value)
        self._used.update(self._tokens)
        self._entries=[];self._retired=[];self._new=set();self._atoms={}
        self._scan_bytes=0;self._pid_counter=0;self._failed=False;self._ledger=None;self._planned_text_bytes=0
        self._evidence_limit=min(dict(g._limits)['max_json_bytes'],dict(g._limits)['memory_budget_bytes']//8)
        self._evidence_bytes=0
        if journal is not None:
            self._evidence_bytes=_check_journal(journal,self.max_reservations,self._evidence_limit)
            if type(journal) is not AllocationLedger or type(journal.entries) is not tuple or type(journal.retired) is not tuple:
                raise TypeError('only a frozen AllocationLedger may be an exclusion journal')
            if journal.snapshot.file_pid!=self.snapshot.file_pid:
                raise UnsupportedError('journal belongs to a different file lineage')
            if len(journal.entries)+len(journal.retired)>self.max_reservations:
                raise UnsupportedError('journal budget')
            for entry in journal.entries:
                if type(entry) is not Reservation or type(entry.reserved_identity) is not ScopedID or type(entry.consumers) is not tuple or type(entry.capacity_check) is not tuple:
                    raise TypeError('invalid journal reservation')
                if entry.namespace!=entry.reserved_identity.namespace or entry.scope!=entry.reserved_identity.scope or any(type(v) is not str for v in entry.consumers) or any(type(v) is not tuple or len(v)!=2 or type(v[0]) is not str or type(v[1]) is not int for v in entry.capacity_check):
                    raise TypeError('journal nested contents are not immutable typed evidence')
                if entry.old_identity is not None and type(entry.old_identity) not in (ScopedID,SourceBinding):
                    raise TypeError('journal old identity type')
                self._exclude(entry.reserved_identity)
            for identity in journal.retired:
                if type(identity) is not ScopedID:raise TypeError('invalid retired identity')
                self._exclude(identity)
            self._entries.extend(journal.entries);self._retired.extend(journal.retired)
        self._next_local=max(self._used|{0})+1
        if seed is None:self._seed=secrets.token_bytes(32)
        elif type(seed) is int and 0<=seed<2**256:self._seed=seed.to_bytes(32,'big')
        elif type(seed) is bytes and 0<len(seed)<=64:self._seed=seed
        elif type(seed) is str:self._seed=seed_from_text(seed)
        else:raise ValueError('seed must be None, bounded int,1..64 bytes or bounded UTF8 text')

    def _exclude(self,identity):
        if identity.namespace.startswith('pool:'):
            pool=identity.namespace[5:]
            if identity.width!=4 or pool not in self._pool or not 0<identity.value<=self.max_dense_id:
                raise UnsupportedError('journal pool bound/scope')
            self._pool[pool].add(identity.value)
        elif identity.namespace in set(self.LOCAL.values())|{'item.order_token'}:
            if identity.width!=4 or not 0<identity.value<=self.max_local_id:
                raise UnsupportedError('journal local bound')
            self._used.add(identity.value)
        elif identity.namespace in {k+'.pid' for k in self.PID_KINDS}|{'file.pid','master.pid'}:
            if identity.width!=8 or not identity.value:raise UnsupportedError('journal PID bound')
            self._pids.add(identity.value)
        else:raise UnsupportedError('journal unknown identity namespace')

    def _open(self):
        if self._failed:raise UnsupportedError('allocator poisoned by prior refusal; discard transaction')
        if self._ledger is not None:raise UnsupportedError('allocation ledger is already frozen')

    def _capacity(self,bytes_needed):
        if len(self._entries)+len(self._retired)>=self.max_reservations:raise UnsupportedError('reservation budget')
        if self._evidence_bytes+bytes_needed>self._evidence_limit:raise UnsupportedError('aggregate journal evidence budget')
        self._evidence_bytes+=bytes_needed

    def _occurs(self,value,width):
        patterns=[value.to_bytes(width,'little'),value.to_bytes(width,'big')]
        if width==8:patterns += [f'{value:016X}'.encode(),f'{value:016x}'.encode()]
        for p in patterns:
            self._scan_bytes+=len(self._raw)
            if self._scan_bytes>self.max_scan_bytes:raise UnsupportedError('aggregate opaque probe-byte budget')
            if p in self._raw:return True
        return False

    def _record(self,identity,old=None,consumers=(),checks=()):
        entry=Reservation(identity.namespace,identity.scope,old,identity,tuple(consumers),tuple(checks))
        self._capacity(_entry_size(entry));self._entries.append(entry)
        self._new.add(identity)
        return identity

    def _local(self,namespace,scope):
        for probe in range(1,self.max_probes+1):
            value=self._next_local;self._next_local+=1
            if value>self.max_local_id:raise UnsupportedError('local allocation policy exhausted')
            if value in self._used or self._occurs(value,4):continue
            self._used.add(value)
            return self._record(ScopedID(namespace,scope,value,4),checks=(('upper_bound',self.max_local_id),('probes',probe)))
        raise UnsupportedError('local probe count exhausted')

    @_operation
    def local(self,kind):
        if type(kind) is not str or kind not in self.LOCAL:raise UnsupportedError('unknown local identity kind')
        return self._local(self.LOCAL[kind],self._scope)

    @_operation
    def token(self,playlist_scope):
        if type(playlist_scope) is not ScopedID or playlist_scope.namespace!='playlist.pid' or playlist_scope.width!=8 or playlist_scope.scope!=self._scope:
            raise UnsupportedError('typed target playlist scope required for order token')
        if playlist_scope.value not in self._playlists and playlist_scope not in self._new:
            raise UnsupportedError('unknown target playlist for token')
        return self._local('item.order_token',self._scope+'/playlist:'+f'{playlist_scope.value:016X}')

    @_operation
    def persistent(self,kind,requested=None):
        if type(kind) is not str or kind not in self.PID_KINDS:raise UnsupportedError('unknown persistent identity kind')
        old=None
        if type(requested) is ScopedID:
            old=requested
            if requested.namespace!=kind+'.pid' or requested.width!=8 or not any(requested in graph.owners for graph in self._graphs.values()):
                raise UnsupportedError('requested typed PID is not in a pinned source graph')
            requested=requested.value
        if requested is not None:_positive(requested,2**64-1,'requested PID')
        for probe in range(1,(1 if requested is not None else self.max_probes)+1):
            if requested is None:
                self._pid_counter+=1
                material=b'itl.identity.v2\0'+self._seed+bytes.fromhex(self.snapshot.digest)+kind.encode()+self._pid_counter.to_bytes(8,'big')
                value=int.from_bytes(hashlib.sha256(material).digest()[:8],'little')
            else:value=requested
            if not value or value in self._pids or self._occurs(value,8):
                if requested is not None:raise UnsupportedError('requested PID collides or has opaque occurrence')
                continue
            self._pids.add(value)
            return self._record(ScopedID(kind+'.pid',self._scope,value,8),old,checks=(('width',8),('probes',probe)))
        raise UnsupportedError('persistent allocation probes exhausted')

    @_operation
    def atom(self,pool,source_binding,value):
        if type(pool) is not str or pool not in self._pool:raise UnsupportedError('unknown keyed pool')
        if self._doc['coverage']['pool_blockers']:raise UnsupportedError('pool consumer coverage blocked: '+','.join(self._doc['coverage']['pool_blockers']))
        if type(value) is not str or not value or '\0' in value:
            raise UnsupportedError('nonempty NUL-free text required; empty is not reference-only')
        if 2*len(value)>dict(self._graphs[self.snapshot]._limits)['max_text_bytes']:
            raise UnsupportedError('new atom text budget before encoding')
        encoded=value.encode('utf-16-le');digest=hashlib.sha256(encoded).hexdigest()
        if len(encoded)>dict(self._graphs[self.snapshot]._limits)['max_text_bytes']:
            raise UnsupportedError('new atom text budget')
        consumers=()
        if source_binding is not None:
            if type(source_binding) is not SourceBinding or source_binding.pool!=pool or source_binding.snapshot not in self._docs:
                raise UnsupportedError('typed source binding not in pinned graph')
            source=self._docs[source_binding.snapshot]
            rows=[r for r in source['strings'] if r['registered_pool_binding'] and r['pool']==pool and r['wire_id']==source_binding.wire_id and r['utf16_sha256']==source_binding.value_digest]
            if not rows:raise UnsupportedError('source binding value/ID mismatch')
            if source['coverage']['pool_blockers']:raise UnsupportedError('source pool coverage blocked')
            consumers=tuple(sorted(r['owner']+':'+str(r['type']) for r in rows))
        key=(pool,source_binding,digest)
        if key in self._atoms:return self._atoms[key]
        if self._planned_text_bytes+len(encoded)>dict(self._graphs[self.snapshot]._limits)['max_text_bytes']:
            raise UnsupportedError('aggregate planned atom text budget')
        self._planned_text_bytes+=len(encoded)
        atom_id=max(self._pool[pool]|{0})+1
        if atom_id>self.max_dense_id or atom_id>=2**31:raise UnsupportedError('small signed32 dense pool exhausted')
        self._pool[pool].add(atom_id)
        result=self._record(ScopedID('pool:'+pool,self._scope,atom_id,4),source_binding,consumers,(('upper_bound',self.max_dense_id),('dense_bytes',4*(atom_id+1))))
        self._atoms[key]=result
        return result

    @_operation
    def retire(self,identity):
        if type(identity) is not ScopedID or identity not in self._existing|self._new:
            raise UnsupportedError('retirement requires a known target/reserved typed identity')
        if identity not in self._retired:
            self._capacity(512);self._retired.append(identity)
        self._exclude(identity)
        # Exclusion only: no record is deleted, and no integer is reclaimed.

    def freeze(self):
        if self._ledger is not None:return self._ledger
        if self._failed:raise UnsupportedError('cannot freeze poisoned allocator')
        self._ledger=AllocationLedger(self.snapshot,tuple(self._entries),tuple(self._retired),hashlib.sha256(self._seed).hexdigest())
        return self._ledger

def to_shared_ledger(ledger):
    """Bridge frozen identity reservations to the real codec schema records.

    This is evidence conversion, NOT admission. SourceBinding provenance is
    preserved separately; a foreign source ID is never relabeled target-owned.
    Import fails when the real dependency is absent; there is no fallback type.
    """
    from . import schema
    _check_journal(ledger)
    reservations=[]
    for entry in ledger.entries:
        identity=entry.reserved_identity
        new=schema.ScopedID(identity.namespace,identity.scope,identity.value,identity.width)
        old=None;source=entry.old_identity
        if type(source) is ScopedID and (source.namespace,source.scope)==(identity.namespace,identity.scope):
            old=schema.ScopedID(source.namespace,source.scope,source.value,source.width)
        elif type(source) is SourceBinding and source.snapshot.digest==identity.scope and identity.namespace=='pool:'+source.pool:
            old=schema.ScopedID(identity.namespace,identity.scope,source.wire_id,4)
        check={'passed':True,**dict(entry.capacity_check),'identity_journal_snapshot':asdict(ledger.snapshot)}
        if source is not None:check['typed_source_provenance']=asdict(source)
        reservations.append(schema.AllocationReservation(identity.namespace,identity.scope,old,new,entry.consumers,check))
    return schema.AllocationLedger(tuple(reservations))
