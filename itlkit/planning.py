"""Experimental prepare/validate/seal/apply primitives.

Only reviewed in-process engines build plans. Reports cannot be deserialized
into executable authority. Hashes are provenance/CAS, never profile allowlists.
The seal detects accidental/data tampering; it is not a sandbox against Python
code that can modify this module or a trusted engine's closure.
"""
from __future__ import annotations
from dataclasses import dataclass, field, replace
from collections.abc import Mapping
from typing import Protocol
import hashlib
import hmac
import secrets
import json
import math
from .library import Library, NUMBER_FIELDS, READ_ONLY_FIELDS
from .container import Container
from .model import Node, KINDS
from .binary import uint
from .schema import (Record, ReadLimits, ProfileReport, Blocker, AllocationLedger,
                     freeze, plain, encode_json, get_limits, load_library, LimitError,
                     SnapshotKey, SourceBinding, ScopedID, AllocationReservation,
                     ReferenceGraph, ReferenceEdge, snapshot_key, identity_snapshot_digest,
                     IDENTITY_V2_POOLS)
from .errors import FormatError, UnsupportedError

_KEY = secrets.token_bytes(32)


def digest(data: bytes) -> str:
    if type(data) is not bytes:
        raise TypeError('digest requires immutable bytes, not Library serialization')
    return hashlib.sha256(data).hexdigest()


def library_state_digest(library: Library, *, limits=None) -> str:
    """Hash exact current model state without to_bytes(), _sync(), or repair.

    Unlike normalized serialization, this also detects stale derived/raw headers.
    Offsets are diagnostic and are intentionally excluded. Shared/cyclic Nodes
    are rejected. The caller must serialize edits explicitly before prepare.
    """
    if type(library) is not Library or type(library.container) is not Container:
        raise TypeError('exact Library/Container types required for atomic adoption')
    limits = get_limits(limits); c = library.container
    h = hashlib.sha256(); total = 0; n = 0; seen = set(); model_bytes = 0; text_bytes = 0

    def add(b):
        nonlocal total
        if type(b) not in (bytes, bytearray):
            raise TypeError('invalid model byte storage')
        total += len(b); limits.check('memory', total * 4 + n * 1024)
        h.update(len(b).to_bytes(8, 'big')); h.update(b)

    for b in (c.header, c.payload, c.trailer):
        limits.check('plain', len(b)); add(b)
    add(c._original or b'')
    if c._original is not None:
        limits.check('file', len(c._original))
    add(b'baseline-none' if c._baseline is None else b'baseline-present')
    for b in c._baseline or ():
        add(b)
    limits.check('nodes', len(library.sections))
    stack = [(node, 0) for node in reversed(library.sections)]
    while stack:
        node, depth = stack.pop()
        if type(node) is not Node or id(node) in seen:
            raise FormatError('cyclic, shared, or unsupported node model')
        seen.add(id(node)); n += 1; limits.check('nodes', n); limits.check('depth', depth)
        model_bytes += len(node.header) + len(node.payload)
        limits.check('plain', model_bytes)
        if node.tag == b'mhoh':
            text_bytes += len(node.payload); limits.check('text', text_bytes)
        # Match parser-produced kind storage and the existing model vocabulary.
        if type(node.kind) is not str or node.kind not in KINDS:
            raise FormatError('invalid node kind in model')
        add(node.kind.encode('ascii')); add(node.header); add(node.payload)
        if node.children is None:
            add(b'leaf')
        else:
            if type(node.children) is not list:
                raise FormatError('invalid child list')
            if n + len(stack) + len(node.children) > limits.max_nodes:
                raise LimitError('nodes budget exceeded before traversal')
            add(b'children'); add(len(node.children).to_bytes(8, 'big'))
            stack.extend((v, depth + 1) for v in reversed(node.children))
    return h.hexdigest()


@dataclass(frozen=True)
class MutationDraft:
    """Engine output, not executable authority; prepare_mutation validates it."""
    candidate_bytes: bytes
    profile_report: ProfileReport
    allocation_ledger: AllocationLedger = field(default_factory=AllocationLedger)
    typed_patches: tuple = ()
    opaque_preservation: tuple = ()
    postconditions: tuple = ()


@dataclass(frozen=True)
class MutationReceipt(Record):
    engine: str
    baseline_digest: str
    prepared_candidate_digest: str
    changed: bool
    postconditions: tuple
    native_qualified: bool = False


@dataclass(frozen=True, init=False)
class PreparedMutation:
    engine: str
    intent: object
    profile_report: ProfileReport
    baseline_digest: str
    input_digests: object
    resource_digests: object
    resource_facts: object
    allocation_ledger: AllocationLedger
    typed_patches: tuple
    opaque_preservation: tuple
    postconditions: tuple
    prepared_candidate_digest: str
    _candidate: bytes = field(repr=False)
    _target: bytes = field(repr=False)
    _sources: object = field(repr=False)
    _resources: object = field(repr=False)
    _validate_resources: object = field(repr=False)
    _resource_facts_json: bytes = field(repr=False)
    _input_cost: int = field(repr=False)
    _facts_cost: int = field(repr=False)
    _limits: ReadLimits = field(repr=False)
    _state_digest: str = field(repr=False)
    _validate: object = field(repr=False)
    _seal: bytes = field(repr=False)

    def __init__(self, *args, **kwargs):
        raise TypeError('PreparedMutation is produced only by prepare_mutation')

    def to_dict(self):
        result = {k: plain(getattr(self, k)) for k in self.__dataclass_fields__ if not k.startswith('_')}
        result['schema'] = 'itlkit.prepared-report.v1'
        result['executable'] = False
        return result

    @property
    def candidate_bytes(self):
        _verify_seal(self)
        return self._candidate

    def __reduce_ex__(self, protocol):
        raise TypeError('prepared capabilities are not serializable; export a report')


class Engine(Protocol):
    def prepare(self, target_bytes: bytes, intent, sources=None, *, limits=None, seed=None) -> PreparedMutation | ProfileReport: ...


def _snapshot_sources(sources, limits):
    if sources is None:
        return {}
    if type(sources) is not dict or any(type(k) is not str or not k or type(v) is not bytes for k, v in sources.items()):
        raise TypeError('sources must map nonempty names to immutable ITL bytes')
    limits.check('nodes', len(sources))
    for v in sources.values():
        limits.check('file', len(v))
    limits.check('memory', 12 * sum(len(v) for v in sources.values()))
    return dict(sources)


def _snapshot_resources(resources, sources, limits):
    """Separate bounded immutable snapshots; never reinterpret them as ITL."""
    if resources is None:
        return {}
    if type(resources) is not dict:
        raise TypeError('resources must be an exact dict of names to immutable bytes')
    limits.check('nodes', len(resources))
    if len(resources) > 128:
        raise LimitError('resource count exceeds 128')
    text_size = 0; wire_size = 0
    for name, data in resources.items():
        if type(name) is not str or not 0 < len(name) <= 128:
            raise ValueError('resource names must contain 1..128 characters')
        text_size += len(name.encode('utf-8', 'strict'))
        limits.check('text', text_size)
        if name in sources:
            raise FormatError('resource and ITL source namespaces overlap')
        if type(data) is not bytes:
            raise TypeError('resource snapshots require exact immutable bytes')
        limits.check('file', len(data)); wire_size += len(data)
    limits.check('memory', 12 * wire_size + 1024 * len(resources))
    return dict(resources)


def _resource_pins(resources):
    return {k: {'sha256': digest(v), 'size_bytes': len(v)} for k, v in resources.items()}


def _resource_kwargs(resources):
    return {'resources': dict(resources)} if resources else {}


def _check_resource_argument(kwargs, expected):
    if not expected:
        return
    actual = kwargs['resources']
    if type(actual) is not dict or set(actual) != set(expected) or any(
            type(actual[k]) is not bytes or actual[k] != expected[k] for k in expected):
        raise FormatError('trusted callback changed its resource snapshot map')


def _bounded_resource_json(value, limits, retained_cost):
    """Strict finite JSON, charged before copying/encoding. No DTO conversion.

    Reservations are conservative process-admission estimates, not a sandbox for
    arbitrary Python callbacks. Keys count toward text/node budgets too.
    """
    stack = [(value, 0, frozenset())]; count = 0; text_size = 0
    while stack:
        v, depth, ancestors = stack.pop(); count += 1
        limits.check('nodes', count); limits.check('depth', depth)
        limits.check('memory', retained_cost + 512 * (count + len(stack)))
        if type(v) is str:
            limits.check('text', text_size + len(v))
            limits.check('memory', retained_cost + 512 * (count + len(stack)) +
                         4 * (text_size + len(v)))
            text_size += len(v.encode('utf-8', 'strict')); limits.check('text', text_size)
        elif v is None or type(v) in (int, bool):
            pass
        elif type(v) is float:
            if not math.isfinite(v):
                raise FormatError('resource facts require finite JSON numbers')
        elif isinstance(v, Mapping) or type(v) in (tuple, list):
            if id(v) in ancestors:
                raise FormatError('cyclic resource JSON')
            lineage = ancestors | {id(v)}
            n = len(v) * (2 if isinstance(v, Mapping) else 1)
            limits.check('nodes', count + len(stack) + n)
            limits.check('memory', retained_cost + 512 * (count + len(stack) + n))
            if isinstance(v, Mapping):
                for k, item in v.items():
                    if type(k) is not str:
                        raise TypeError('resource JSON keys must be exact strings')
                    stack.append((k, depth + 1, lineage))
                    stack.append((item, depth + 1, lineage))
            else:
                stack.extend((item, depth + 1, lineage) for item in v)
        else:
            raise TypeError('resource facts must be JSON values, not records or callbacks')
    available = limits.memory_budget_bytes - retained_cost - 512 * count
    if available < 64:
        raise LimitError('resource JSON aggregate memory budget exceeded')
    # Restrict serialization before allocation using the remaining aggregate
    # budget. Reserve room for detached/frozen facts and later report copies.
    scoped = replace(limits, max_json_bytes=min(limits.max_json_bytes, available // 32),
                     memory_budget_bytes=available)
    encoded = encode_json(value, limits=scoped)
    cost = 512 * count + 32 * len(encoded)
    limits.check('memory', retained_cost + cost)
    return encoded, cost


def _probe_resources(callback, resources, limits, retained_cost):
    if not resources:
        return b'{}', 0
    if not callable(callback):
        raise TypeError('nonempty resources require trusted validate_resources code')
    args = {'resources': dict(resources)}
    facts = callback(args['resources'], limits=limits)
    _check_resource_argument(args, resources)
    if not isinstance(facts, Mapping) or len(facts) != len(resources) or set(facts) != set(resources):
        raise FormatError('resource facts must have exactly the resource names')
    return _bounded_resource_json(facts, limits, retained_cost)


def _history_ledgers(history, limits):
    encode_json(history, limits=limits)  # cycle/depth/aggregate check before traversal
    stack = list(history); out = []
    while stack:
        past = stack.pop()
        if type(past) is not AllocationLedger or past.snapshot is None:
            raise TypeError('history requires complete canonical provenance ledgers')
        out.append(past); limits.check('nodes', len(out))
        stack.extend(past.history)
    return tuple(out)


def _check_ledger_inputs(ledger, data, sources, limits):
    """Provenance/CAS only. Engine code still proves membership/closure/intent."""
    if ledger.snapshot is None:
        if any(type(r.old_identity) is SourceBinding or r.source_snapshot is not None or
               r.target_snapshot is not None or (type(r.old_identity) is ScopedID and
               r.old_identity.scope != r.scope) for r in ledger):
            raise FormatError('cross-snapshot ledger requires complete input provenance')
        return
    target = snapshot_key(data, limits=limits)
    actual = {k:snapshot_key(v, limits=limits) for k,v in sources.items()}
    if ledger.snapshot != target or dict(ledger.sources) != actual:
        raise FormatError('ledger input SnapshotKey mismatch')
    current = {v.digest:v for v in (target,*actual.values())}
    past = _history_ledgers(ledger.history, limits)
    if any(h.snapshot.file_pid != target.file_pid for h in past):
        raise FormatError('ledger history lineage mismatch')
    old_entries = tuple(r for h in past for r in h)
    old_retired = tuple(r for h in past for r in h.retired)
    for r in ledger:
        if r.target_snapshot != target:
            if r not in old_entries:
                raise FormatError('historical reservation was dropped, changed or relabeled')
            continue
        identity_snapshot_digest(r.reserved_identity, identity_v2=True)
        if r.old_identity is not None:
            key = r.source_snapshot
            if key is None or current.get(key.digest) != key:
                raise FormatError('reservation source is not an exact current input snapshot')
    for r in ledger.retired:
        scope = identity_snapshot_digest(r, identity_v2=True)
        if scope != target.digest and r not in old_retired:
            raise FormatError('retirement history is not preserved')
    # An inherited journal is an exclusion union: it may not silently lose entries.
    if any(r not in ledger.reservations for r in old_entries) or any(
            r not in ledger.retired for r in old_retired):
        raise FormatError('inherited reservation/retirement exclusion was dropped')


def adapt_identity_ledger(ledger, target_bytes, sources=None, *, history=(),
                          limits=None, validate):
    """Explicit identity-v2 -> canonical evidence adapter, NOT write authority.

    validate(target_bytes, detached_sources, detached_identity_report,
             detached_history_reports, *, limits) -> one capacity-check mapping
    per original ordered entry, each with passed is True. Reviewed engine CODE
    must recompute source membership/bindings/aliases, bounds and exclusions,
    retirement history and seed commitment from pinned inputs. There is no default
    validator, no JSON callback, no allocation and no serialized-report adoption.
    The engine's candidate/postcondition validator runs separately at prepare/apply.
    """
    from . import identity as ids
    limits = get_limits(limits)
    if not callable(validate): raise TypeError('explicit evidence validator code required')
    if type(ledger) is not ids.AllocationLedger or type(ledger.entries) is not tuple or type(ledger.retired) is not tuple:
        raise TypeError('real immutable identity AllocationLedger required, not a report')
    if type(history) not in (tuple,list): raise TypeError('history must be a ledger sequence')
    encode_json(ledger, limits=limits)
    past = _history_ledgers(history, limits)
    limits.check('nodes', len(ledger.entries)+len(ledger.retired)+len(past))
    inputs = _snapshot_sources(sources, limits)
    wire_estimate=12*(len(target_bytes)+sum(map(len,inputs.values())))
    limits.check('memory',wire_estimate)
    plain_total=0
    for raw in (target_bytes,*inputs.values()):
        # A wire/plain digest alone does not enforce node/depth/text limits.
        parsed=load_library(raw,limits=limits)
        plain_total+=len(parsed.container.payload)
        limits.check('memory',wire_estimate+8*plain_total)
        del parsed
    target = snapshot_key(target_bytes, limits=limits)
    source_keys = {k:snapshot_key(v,limits=limits) for k,v in inputs.items()}
    catalog = {}
    def add_key(key):
        if key.digest in catalog and catalog[key.digest] != key:
            raise FormatError('conflicting SnapshotKey provenance')
        catalog[key.digest] = key
    for key in (target,*source_keys.values()): add_key(key)
    for h in past:
        add_key(h.snapshot)
        for key in h.sources.values(): add_key(key)
    def key_copy(v):
        if type(v) is not ids.SnapshotKey: raise TypeError('real identity SnapshotKey required')
        return SnapshotKey(v.digest,v.file_pid,v.plain_digest)
    if key_copy(ledger.snapshot) != target:
        raise FormatError('identity ledger target snapshot is stale')
    def scoped(v):
        if type(v) is not ids.ScopedID: raise TypeError('real identity ScopedID required')
        result = ScopedID(v.namespace,v.scope,v.value,v.width)
        identity_snapshot_digest(result, identity_v2=True)
        if not result.value: raise ValueError('zero is not an allocated/owned identity')
        return result
    def binding(v):
        if type(v) is not ids.SourceBinding: raise TypeError('real SourceBinding required')
        result = SourceBinding(key_copy(v.snapshot),v.pool,v.wire_id,v.value_digest)
        if result.pool not in IDENTITY_V2_POOLS: raise ValueError('unknown source pool domain')
        return result
    rows=[]
    for entry in ledger.entries:
        if type(entry) is not ids.Reservation or type(entry.consumers) is not tuple or type(entry.capacity_check) is not tuple:
            raise TypeError('immutable typed identity reservation required')
        if any(type(c) is not str or not c or len(c)>512 for c in entry.consumers):
            raise TypeError('immutable bounded consumers required')
        checks = entry.capacity_check
        if len(checks)>16 or any(type(c) is not tuple or len(c)!=2 or
                type(c[0]) is not str or c[0] not in ('upper_bound','dense_bytes','probes','width') or
                type(c[1]) is not int or not 0<=c[1]<2**64 for c in checks) or len(dict(checks))!=len(checks):
            raise TypeError('immutable, unique reported capacity fields required')
        new = scoped(entry.reserved_identity)
        if (entry.namespace,entry.scope)!=(new.namespace,new.scope):
            raise ValueError('identity entry namespace/scope mismatch')
        old = entry.old_identity
        if type(old) is ids.ScopedID: old=scoped(old)
        elif type(old) is ids.SourceBinding: old=binding(old)
        elif old is not None: raise TypeError('untyped mutable old identity refused')
        newkey=catalog.get(identity_snapshot_digest(new))
        if newkey is None: raise FormatError('reservation target snapshot missing from history')
        oldkey = old.snapshot if type(old) is SourceBinding else catalog.get(
            identity_snapshot_digest(old)) if old is not None else None
        if old is not None and (oldkey is None or catalog.get(oldkey.digest)!=oldkey):
            raise FormatError('source SnapshotKey missing or changed')
        # Shape validation happens before the engine callback, but no passed flag is invented.
        if type(old) is ScopedID and (old.namespace,old.width)!=(new.namespace,new.width):
            raise ValueError('old identity namespace/width mismatch')
        if type(old) is SourceBinding and (new.namespace,new.width)!=('pool:'+old.pool,4):
            raise ValueError('source binding namespace/width mismatch')
        rows.append((entry,new,old,newkey,oldkey))
    retired = tuple(scoped(v) for v in ledger.retired)
    report=json.loads(encode_json(ledger,limits=limits))
    checked=validate(target_bytes,dict(inputs),report,plain(tuple(history)),limits=limits)
    if type(checked) not in (tuple,list) or len(checked)!=len(rows):
        raise TypeError('validator must return one recomputed check per ordered reservation')
    encode_json(checked,limits=limits)
    reservations=[]
    for (entry,new,old,newkey,oldkey),check in zip(rows,checked):
        if not isinstance(check,Mapping) or check.get('passed') is not True or 'allocator_reported' in check:
            raise UnsupportedError('evidence validator did not return a successful independent check')
        check=dict(check);check['allocator_reported']=dict(entry.capacity_check)
        reservations.append(AllocationReservation(entry.namespace,entry.scope,old,new,
            entry.consumers,check,source_snapshot=oldkey,target_snapshot=newkey))
    result=AllocationLedger(tuple(reservations),target,source_keys,retired,
                            ledger.seed_commitment,tuple(history))
    _check_ledger_inputs(result,target_bytes,inputs,limits)
    encode_json(result,limits=limits)
    return result


def adapt_identity_graph(graph, *, limits=None):
    """Copy redecoded known-wire graph evidence, retaining owner locator/level.

    The result is a canonical diagnostic, never a replacement for raw graph
    revalidation by an allocator or an engine-specific semantic validator.
    """
    from . import graph as graphs
    from . import identity as ids
    limits=get_limits(limits)
    if type(graph) is not graphs.ReferenceGraph:
        raise TypeError('real identity ReferenceGraph required, not a report')
    load_library(graph.data,limits=limits)  # canonical framing/resource preflight first
    fresh=graphs.revalidate_graph(graph)
    key=snapshot_key(fresh.data,limits=limits)
    if (fresh.snapshot.digest,fresh.snapshot.file_pid,fresh.snapshot.plain_digest)!=(key.digest,key.file_pid,key.plain_digest):
        raise FormatError('graph SnapshotKey mismatch')
    encode_json(fresh.to_dict(),limits=limits)
    def convert(v):
        if type(v) is not ids.ScopedID: raise TypeError('real identity graph endpoint required')
        x=ScopedID(v.namespace,v.scope,v.value,v.width)
        if identity_snapshot_digest(x,identity_v2=True)!=key.digest:
            raise FormatError('graph owner snapshot mismatch')
        return x
    owners=tuple(convert(x) for x in fresh.owners); edges=[]
    for edge in fresh.typed_edges:
        parts=edge.owner.split(':')
        if len(parts)==2 and parts[0] in ('track','album','artist','playlist'):
            ns=parts[0]+'.pid'; scope=key.digest; value=parts[1]
        elif len(parts)==3 and parts[0]=='item':
            ns='item.pid';scope=key.digest+'/playlist:'+parts[1];value=parts[2]
        else: raise UnsupportedError('unmapped graph edge owner locator')
        if len(value)!=16 or any(c not in '0123456789ABCDEF' for c in value):
            raise FormatError('invalid graph owner PID locator')
        owner=ScopedID(ns,scope,int(value,16),8)
        if owner not in owners: raise FormatError('graph owner locator is not a typed owner')
        edges.append(ReferenceEdge(owner,convert(edge.target),edge.field,
            ('identity-v2 known-wire graph; not semantic permission',),edge.owner,key,edge.evidence_level))
    coverage=dict(fresh.coverage)
    coverage['transport_only']=True;coverage['identity_graph_issues']=fresh.to_dict()['issues']
    result=ReferenceGraph(tuple(edges),owners,fresh.opaque_possible_edges,coverage,key)
    encode_json(result,limits=limits)
    return result


def _mac(p):
    body = encode_json(p.to_dict(), limits=p._limits)
    private = (digest(p._candidate) + digest(p._target) + p._state_digest +
               str(id(p._validate))).encode('ascii')
    private += encode_json(plain(p._limits), limits=p._limits)
    private += encode_json({k: digest(v) for k, v in p._sources.items()}, limits=p._limits)
    private += encode_json(_resource_pins(p._resources), limits=p._limits)
    private += (str(id(p._validate_resources)) + ':' + str(p._input_cost) + ':' +
                str(p._facts_cost) + ':' + digest(p._resource_facts_json)).encode('ascii')
    return hmac.digest(_KEY, body + private, 'sha256')


def _verify_seal(p):
    if type(p) is not PreparedMutation:
        raise TypeError('an in-process PreparedMutation is required, not a report')
    try:
        if not hmac.compare_digest(p._seal, _mac(p)):
            raise FormatError('prepared mutation tampered')
        if digest(p._candidate) != p.prepared_candidate_digest:
            raise FormatError('prepared candidate digest mismatch')
    except AttributeError as exc:
        raise FormatError('incomplete prepared capability') from exc


def prepare_mutation(engine: str, target_bytes: bytes, intent, sources=None, *,
                     limits=None, seed=None, build, validate, resources=None,
                     validate_resources=None) -> PreparedMutation | ProfileReport:
    """Reviewed in-process engine adapter, not caller-issued write authority.

    Nonempty resources require a pure validate_resources(resources, *, limits)
    returning exact named JSON facts. Only then do build/validate receive the
    additional resources= keyword. Empty resources preserve legacy signatures.
    Every input admission precedes callbacks; facts are checked before build.
    """
    limits = get_limits(limits)
    if not isinstance(engine, str) or not engine or not callable(build) or not callable(validate):
        raise TypeError('engine name and trusted build/validate callables required')
    if validate_resources is not None and not callable(validate_resources):
        raise TypeError('validate_resources must be trusted callable code')
    if type(target_bytes) is not bytes:
        raise TypeError('immutable target bytes required')
    limits.check('file', len(target_bytes))
    inputs = _snapshot_sources(sources, limits)
    resource_inputs = _snapshot_resources(resources, inputs, limits)
    if resource_inputs and validate_resources is None:
        raise TypeError('nonempty resources require validate_resources')
    pins = _resource_pins(resource_inputs)
    input_cost = 12 * (len(target_bytes) + sum(map(len, inputs.values())) +
                       sum(map(len, resource_inputs.values()))) + 1024 * len(resource_inputs)
    limits.check('memory', input_cost)
    if resource_inputs:
        encoded, json_cost = _bounded_resource_json(
            {'intent': intent, 'sources': _resource_pins(inputs), 'resources': pins},
            limits, input_cost)
        intent_copy = json.loads(encoded)['intent']; input_cost += json_cost
    else:
        intent_copy = json.loads(encode_json(intent, limits=limits))
    if type(intent_copy) is not dict:
        raise FormatError('intent must be a JSON object')
    target = load_library(target_bytes, limits=limits)
    state = library_state_digest(target, limits=limits)
    total_plain = len(target.container.payload)
    limits.check('memory', input_cost + total_plain * 8)
    for v in inputs.values():
        lib = load_library(v, limits=limits)
        total_plain += len(lib.container.payload)
        limits.check('memory', input_cost + total_plain * 8)
        del lib
    input_cost += total_plain * 8
    facts_json, facts_cost = _probe_resources(validate_resources, resource_inputs, limits, input_cost)
    # Both retained facts and one re-probe must fit, including candidate storage.
    limits.check('memory', input_cost + 2 * facts_cost)
    build_kwargs = _resource_kwargs(resource_inputs)
    draft = build(target_bytes, json.loads(encode_json(intent_copy, limits=limits)),
                  dict(inputs), limits=limits, seed=seed, **build_kwargs)
    _check_resource_argument(build_kwargs, resource_inputs)
    if type(draft) is ProfileReport:
        if not draft.blocked:
            raise FormatError('engine returned an unblocked profile without a candidate')
        return draft
    if type(draft) is not MutationDraft or type(draft.profile_report) is not ProfileReport or type(draft.allocation_ledger) is not AllocationLedger:
        raise TypeError('engine must return MutationDraft with typed profile and ledger')
    if draft.profile_report.blocked:
        return draft.profile_report
    _check_ledger_inputs(draft.allocation_ledger, target_bytes, inputs, limits)
    if type(draft.candidate_bytes) is not bytes:
        raise TypeError('candidate must be immutable bytes')
    limits.check('file', len(draft.candidate_bytes))
    limits.check('memory', input_cost + 2 * facts_cost + 12 * len(draft.candidate_bytes))
    load_library(draft.candidate_bytes, limits=limits)
    p = object.__new__(PreparedMutation)
    data = dict(engine=engine, intent=freeze(intent_copy), profile_report=draft.profile_report,
                baseline_digest=digest(target_bytes), input_digests=freeze({k: digest(v) for k,v in inputs.items()}),
                resource_digests=freeze(pins), resource_facts=freeze(json.loads(facts_json)),
                allocation_ledger=draft.allocation_ledger, typed_patches=freeze(draft.typed_patches),
                opaque_preservation=freeze(draft.opaque_preservation), postconditions=freeze(draft.postconditions),
                prepared_candidate_digest=digest(draft.candidate_bytes), _candidate=draft.candidate_bytes,
                _target=target_bytes, _limits=limits, _state_digest=state, _validate=validate,
                _validate_resources=validate_resources, _resource_facts_json=facts_json,
                _input_cost=input_cost, _facts_cost=facts_cost)
    from types import MappingProxyType
    data['_sources'] = MappingProxyType(dict(inputs))
    data['_resources'] = MappingProxyType(dict(resource_inputs))
    for k,v in data.items():
        object.__setattr__(p,k,v)
    # Bound the complete evidence report before calling the engine validator.
    encode_json(p.to_dict(), limits=limits)
    validate_kwargs = _resource_kwargs(resource_inputs)
    valid = validate(target_bytes, plain(p.intent), dict(inputs), p._candidate,
                     p.to_dict(), limits=limits, **validate_kwargs)
    _check_resource_argument(validate_kwargs, resource_inputs)
    if valid is not True:
        raise UnsupportedError('engine postcondition validation failed during prepare')
    object.__setattr__(p, '_seal', _mac(p))
    return p


def apply(target_library: Library, prepared: PreparedMutation, *, sources=None,
          resources=None) -> MutationReceipt:
    """Exact current sources/resources, re-probe, CAS, then one atomic adoption.

    No builder/allocator/RNG replay. Mutable callers synchronize externally.
    """
    _verify_seal(prepared); p = prepared; limits = p._limits
    current = _snapshot_sources(sources, limits)
    if {k: digest(v) for k,v in current.items()} != dict(p.input_digests):
        raise FormatError('stale or missing source inputs')
    current_resources = _snapshot_resources(resources, current, limits)
    if _resource_pins(current_resources) != plain(p.resource_digests):
        raise FormatError('stale, extra or missing resource inputs')
    if library_state_digest(target_library, limits=limits) != p._state_digest:
        raise FormatError('stale target model; input Library was not modified')
    _check_ledger_inputs(p.allocation_ledger, p._target, current, limits)
    fresh_json, fresh_cost = _probe_resources(p._validate_resources, current_resources,
        limits, p._input_cost + p._facts_cost + 12 * len(p._candidate))
    if fresh_json != p._resource_facts_json:
        raise FormatError('resource facts changed during re-probe')
    limits.check('memory', p._input_cost + p._facts_cost + fresh_cost + 12 * len(p._candidate))
    candidate = load_library(p._candidate, limits=limits)
    kwargs = _resource_kwargs(current_resources)
    valid = p._validate(p._target, plain(p.intent), dict(current), p._candidate,
                        p.to_dict(), limits=limits, **kwargs)
    _check_resource_argument(kwargs, current_resources)
    if valid is not True:
        raise UnsupportedError('engine postcondition validation failed during apply')
    _verify_seal(p)
    if library_state_digest(target_library, limits=limits) != p._state_digest:
        raise FormatError('target changed during validation')
    receipt = MutationReceipt(p.engine, p.baseline_digest, p.prepared_candidate_digest,
                              p.baseline_digest != p.prepared_candidate_digest, p.postconditions)
    if receipt.changed:
        adopted = dict(target_library.__dict__)
        adopted.update(container=candidate.container, sections=candidate.sections)
        target_library.__dict__ = adopted
    return receipt


_SCALARS = frozenset(NUMBER_FIELDS) - frozenset(READ_ONLY_FIELDS) | {'loved','unplayed'}


def _legacy_build(data, intent, sources, *, limits, seed):
    if seed is not None or sources or set(intent) != {'operations'} or type(intent['operations']) is not list:
        raise ValueError('legacy scalar intent is exactly {operations: list}; no seed or sources')
    lib = load_library(data, limits=limits)
    for op in intent['operations']:
        if type(op) is not dict or op.get('op') != 'set_track' or type(op.get('fields')) is not dict or set(op['fields']) - _SCALARS:
            return ProfileReport(lib.container.version, lib.container.payload_byteorder,
                                 blockers=(Blocker('engine_not_available', 'Only non-allocating legacy scalar set_track is wrapped; use a dedicated engine'),))
    lib.apply_operations(intent['operations'])
    result = lib.to_bytes()
    return MutationDraft(result, ProfileReport(lib.container.version, lib.container.payload_byteorder,
        invariants=({'check':'current core guard admission','passed':True},),
        capabilities=('legacy_scalar_operations',), evidence_refs=('itlkit/library.py:Track.set and Library.apply_operations',)),
        typed_patches=tuple(intent['operations']),
        postconditions=({'check':'deterministic guarded scalar replay','passed':True},))


def _legacy_validate(data, intent, sources, candidate, report, *, limits):
    draft = _legacy_build(data, intent, sources, limits=limits, seed=None)
    return type(draft) is MutationDraft and draft.candidate_bytes == candidate and not report['allocation_ledger']['reservations']


def prepare(target_bytes: bytes, intent, sources=None, *, limits=None, seed=None):
    """Concrete non-allocating legacy-scalar engine; no unsafe fallback."""
    return prepare_mutation('legacy-scalars.v1', target_bytes, intent, sources,
                            limits=limits, seed=seed, build=_legacy_build, validate=_legacy_validate)


def identity_binding_index(ledger, *, limits=None):
    """Index a canonical ledger's freshly reserved identities by namespace.

    This is the read-only seam between identity evidence and the wire slots an
    engine must fill: which typed identity did THIS snapshot reserve for a
    namespace, and what provenance does it carry. Reservations whose target
    snapshot differs are retained history/exclusion evidence and are
    deliberately not indexed as fresh identities. The index is structural
    evidence only: it proves nothing about record layout, pool coverage,
    reference closure, semantic permission or native acceptance, and it never
    becomes a write permit.
    """
    from types import MappingProxyType
    limits = get_limits(limits)
    if type(ledger) is not AllocationLedger or type(ledger.reservations) is not tuple:
        raise TypeError('a canonical AllocationLedger is required, not a report or mapping')
    if type(ledger.snapshot) is not SnapshotKey:
        raise FormatError('an identity binding index requires the ledger target SnapshotKey')
    if len(ledger.reservations) > limits.max_nodes:
        raise LimitError('ledger reservation count exceeds the node bound')
    index = {}
    for reservation in ledger.reservations:
        if type(reservation) is not AllocationReservation:
            raise TypeError('typed AllocationReservation records are required')
        if reservation.target_snapshot != ledger.snapshot:
            continue  # inherited from an earlier snapshot; not a fresh identity
        identity = reservation.reserved_identity
        if identity_snapshot_digest(identity, identity_v2=True) != ledger.snapshot.digest:
            raise FormatError('reserved identity is not scoped to the ledger target snapshot')
        index.setdefault(reservation.namespace, []).append(reservation)
    return MappingProxyType({k: tuple(v) for k, v in sorted(index.items())})
