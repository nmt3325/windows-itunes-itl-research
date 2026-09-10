"""Experimental prepare/validate/seal/apply primitives.

Only reviewed in-process engines build plans. Reports cannot be deserialized
into executable authority. Hashes are provenance/CAS, never profile allowlists.
The seal detects accidental/data tampering; it is not a sandbox against Python
code that can modify this module or a trusted engine's closure.
"""
from __future__ import annotations
from dataclasses import dataclass, field
from collections.abc import Mapping
from typing import Protocol
import hashlib
import hmac
import secrets
import json
from .library import Library, NUMBER_FIELDS, READ_ONLY_FIELDS
from .container import Container
from .model import Node
from .binary import uint
from .schema import (Record, ReadLimits, ProfileReport, Blocker, AllocationLedger,
                     freeze, plain, encode_json, get_limits, load_library, LimitError)
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
    h = hashlib.sha256(); total = 0; n = 0; seen = set()

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
    allocation_ledger: AllocationLedger
    typed_patches: tuple
    opaque_preservation: tuple
    postconditions: tuple
    prepared_candidate_digest: str
    _candidate: bytes = field(repr=False)
    _target: bytes = field(repr=False)
    _sources: object = field(repr=False)
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


def _mac(p):
    body = encode_json(p.to_dict(), limits=p._limits)
    private = (digest(p._candidate) + digest(p._target) + p._state_digest +
               str(id(p._validate))).encode('ascii')
    private += encode_json(plain(p._limits), limits=p._limits)
    private += encode_json({k: digest(v) for k, v in p._sources.items()}, limits=p._limits)
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
                     limits=None, seed=None, build, validate) -> PreparedMutation | ProfileReport:
    """Trusted-engine adapter. build and validate are CODE, never JSON callbacks.

    build(target_bytes, detached_intent, detached_sources, *, limits, seed)
      -> MutationDraft | blocked ProfileReport
    validate(target_bytes, detached_intent, detached_sources, candidate_bytes,
             detached_evidence_report, *, limits) -> exactly True
    validate runs here AND before apply; it must be pure and check every engine
    postcondition/ledger/opaque claim. No builder/allocator runs during apply.
    """
    limits = get_limits(limits)
    if not isinstance(engine, str) or not engine or not callable(build) or not callable(validate):
        raise TypeError('engine name and trusted build/validate callables required')
    intent_copy = json.loads(encode_json(intent, limits=limits))
    if type(intent_copy) is not dict:
        raise FormatError('intent must be a JSON object')
    inputs = _snapshot_sources(sources, limits)
    target = load_library(target_bytes, limits=limits)
    state = library_state_digest(target, limits=limits)
    total_file = len(target_bytes); total_plain = len(target.container.payload)
    for v in inputs.values():
        lib = load_library(v, limits=limits)
        total_file += len(v); total_plain += len(lib.container.payload)
    limits.check('memory', total_file * 12 + total_plain * 8)
    draft = build(target_bytes, json.loads(encode_json(intent_copy, limits=limits)),
                  dict(inputs), limits=limits, seed=seed)
    if type(draft) is ProfileReport:
        if not draft.blocked:
            raise FormatError('engine returned an unblocked profile without a candidate')
        return draft
    if type(draft) is not MutationDraft or type(draft.profile_report) is not ProfileReport or type(draft.allocation_ledger) is not AllocationLedger:
        raise TypeError('engine must return MutationDraft with typed profile and ledger')
    if draft.profile_report.blocked:
        return draft.profile_report
    load_library(draft.candidate_bytes, limits=limits)
    limits.check('memory', total_file * 12 + total_plain * 8 + len(draft.candidate_bytes) * 12)
    p = object.__new__(PreparedMutation)
    data = dict(engine=engine, intent=freeze(intent_copy), profile_report=draft.profile_report,
                baseline_digest=digest(target_bytes), input_digests=freeze({k: digest(v) for k,v in inputs.items()}),
                allocation_ledger=draft.allocation_ledger, typed_patches=freeze(draft.typed_patches),
                opaque_preservation=freeze(draft.opaque_preservation), postconditions=freeze(draft.postconditions),
                prepared_candidate_digest=digest(draft.candidate_bytes), _candidate=draft.candidate_bytes,
                _target=target_bytes, _sources=None,
                _limits=limits, _state_digest=state, _validate=validate)
    # Bytes are immutable; mapping is separately defensive (freeze intentionally rejects binary reports).
    from types import MappingProxyType
    data['_sources'] = MappingProxyType(dict(inputs))
    for k,v in data.items():
        object.__setattr__(p,k,v)
    if validate(target_bytes, plain(p.intent), dict(inputs), p._candidate, p.to_dict(), limits=limits) is not True:
        raise UnsupportedError('engine postcondition validation failed during prepare')
    object.__setattr__(p, '_seal', _mac(p))
    return p


def apply(target_library: Library, prepared: PreparedMutation, *, sources=None) -> MutationReceipt:
    """Validate everything before a single __dict__ adoption; no disk writes.

    Mutable concurrent callers must synchronize access to a Library externally.
    A plan with sources requires their current byte snapshots by exact name.
    """
    _verify_seal(prepared); p = prepared; limits = p._limits
    current = _snapshot_sources(sources, limits)
    if {k: digest(v) for k,v in current.items()} != dict(p.input_digests):
        raise FormatError('stale or missing source inputs')
    if library_state_digest(target_library, limits=limits) != p._state_digest:
        raise FormatError('stale target model; input Library was not modified')
    candidate = load_library(p._candidate, limits=limits)
    if p._validate(p._target, plain(p.intent), dict(current), p._candidate, p.to_dict(), limits=limits) is not True:
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
