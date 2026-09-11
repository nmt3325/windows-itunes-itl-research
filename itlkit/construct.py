"""Experimental PCM wire recipe; whole-library prepare remains dependency-gated.

A standalone mith record is NOT a complete ITL or a PreparedMutation. No caller
bindings/ranks or serialized report confer graph/allocation/write authority.
"""
from __future__ import annotations
from dataclasses import dataclass
from datetime import datetime
from hashlib import sha256
import json
import struct

from .media import (MediaError, probe_bytes, limit_value, _memory_preflight,
                    _probe_memory_estimate)
from .location import LocationError, plan_location, location_records, _text_record


class ConstructionError(ValueError):
    pass


def _need(ok, why):
    if not ok:
        raise ConstructionError(why)


def _uint(value, width, name, *, positive=False):
    _need(type(value) is int and (1 if positive else 0) <= value < 1 << (8 * width), name + ' range/type')
    return value


@dataclass(frozen=True, slots=True)
class WaveRecordBindings:
    track_local: int
    secondary_local: int
    track_pid: int
    album_local: int
    artist_local: int
    name_atom: int
    kind_atom: int

    def validate(self):
        local = (self.track_local, self.secondary_local, self.album_local, self.artist_local)
        for value in local:
            _uint(value, 4, 'local identity', positive=True)
            _need(value <= 1000000, 'local capacity')
        _need(len(set(local)) == 4, 'overlapping new local identities')
        _uint(self.track_pid, 8, 'persistent identity', positive=True)
        for value in (self.name_atom, self.kind_atom):
            _uint(value, 4, 'pool identity', positive=True)
            _need(value <= 65535, 'dense pool capacity')


@dataclass(frozen=True, slots=True)
class WaveRecord:
    record_bytes: bytes
    media_sha256: str
    record_sha256: str
    sample_rate_hz: int
    pcm_frames: int
    duration_ms: int
    bitrate_kbps: int
    profile: str = 'windows_12_13_10_3_pcm16_mono_44100_48000_text_location'
    native_accepted: bool = False


def hfs_displayed_wall_time(value):
    """Existing wall-clock convention: require an aware datetime, do not UTC-shift it."""
    _need(isinstance(value, datetime) and value.utcoffset() is not None, 'explicit aware wall datetime required')
    delta = value.replace(tzinfo=None) - datetime(1904, 1, 1)
    micros = (delta.days * 86400 + delta.seconds) * 1000000 + delta.microseconds
    _need(0 < micros < (1 << 32) * 1000000, 'nonzero HFS time range')
    seconds = micros // 1000000
    _need(seconds != 0, 'nonzero HFS time range after flooring')
    return seconds


def _metadata_memory_estimate(metadata):
    # Bound the flat shape before set/dict copies. No encoding or stringification.
    _need(type(metadata) is dict, 'explicit metadata mapping required')
    _need(len(metadata) <= 14, 'unknown/identity/derived metadata key')
    characters = 0
    for key, value in metadata.items():
        _need(type(key) is str, 'metadata keys must be strings')
        characters += len(key)
        if isinstance(value, str):
            characters += len(value)
        else:
            _need(type(value) in (int, bool), 'metadata values must be text or scalar')
    return 65536 + 256 * len(metadata) + 32 * characters


def _construction_preflight(media_bytes, metadata, location, date_added, date_modified, limits, *, extra=0):
    """Combined helper-stage estimate before parsing, URI/JSON or record copies.

    Raw path lengths reserve UTF16 and percent-escaped UTF8 expansion without
    performing either conversion. This is not an engine resource reservation.
    """
    checked = _memory_preflight(limits, 65536)
    if not isinstance(media_bytes, bytes):
        raise MediaError('media must be immutable bytes')
    _need(isinstance(location, str), 'explicit Location text required')
    description = _metadata_memory_estimate(metadata)
    name = metadata.get('name')
    name_chars = len(name) if isinstance(name, str) else 0
    path_chars = len(location)
    date_chars = sum(len(v) if isinstance(v, str) else 96 for v in (date_added, date_modified))
    # 756-byte header, four40-byte text wrappers, Kind and URI prefix slack.
    # Four bytes/Name character and16/path character bound possible encodings.
    record_bytes = 756 + 4 * 40 + 16 + 4 * name_chars + 16 * path_chars + 16
    estimate = (_probe_memory_estimate(len(media_bytes), checked) + description +
                32 * (16 * path_chars + 16 + date_chars) + 8 * record_bytes + extra)
    _memory_preflight(checked, estimate)
    return checked


def validate_metadata(metadata, *, limits=None):
    limits = _memory_preflight(limits, 65536)
    _memory_preflight(limits, _metadata_memory_estimate(metadata))
    _need(type(metadata) is dict, 'explicit metadata mapping required')
    allowed = {'name', 'unplayed', 'rating', 'year', 'track_number', 'track_count', 'disc_number', 'disc_count',
               'album', 'artist', 'album_artist', 'genre', 'composer', 'comment'}
    _need(not set(metadata) - allowed, 'unknown/identity/derived metadata key')
    name = metadata.get('name')
    _need(isinstance(name, str) and bool(name) and name.isascii() and not any(ord(c) < 32 or ord(c) == 127 for c in name),
          'initial recipe requires an explicit nonempty ASCII Name')
    _need(len(name) <= limit_value(limits, 'max_text_bytes'), 'Name budget')
    # Shared grouping/COW and nonempty additional text await the shared allocator.
    for key in ('album', 'artist', 'album_artist', 'genre', 'composer', 'comment'):
        _need(key not in metadata or metadata[key] == '', 'nonempty grouping/additional text not yet materialized')
    result = {'name': name, 'unplayed': metadata.get('unplayed', True)}
    _need(type(result['unplayed']) is bool, 'unplayed must be bool')
    for key, width in (('rating', 1), ('year', 4), ('track_number', 4), ('track_count', 4), ('disc_number', 2), ('disc_count', 2)):
        result[key] = _uint(metadata.get(key, 0), width, key)
    _need(result['rating'] <= 100, 'rating exceeds100')
    _need(result['year'] <= 32767, 'Year native signed16 conversion boundary')
    _need(result['track_number'] <= 65535 and result['track_count'] <= 65535, 'track number/count native unsigned16 conversion boundary')
    return result


def materialize_pcm_wave_record(media_bytes, metadata, location, bindings, *, date_added, date_modified, sort_ranks, limits=None):
    """Pure complete-record emitter, NOT library adoption or a trusted allocation plan.

    Re-probes bytes rather than trusting a caller-built MediaFacts. Profile refusal
    never falls back to a template from a different codec/channel/configuration.
    """
    limits = _construction_preflight(media_bytes, metadata, location, date_added, date_modified, limits)
    facts = probe_bytes(media_bytes, limits=limits)
    _need(facts.format == 'WAV' and facts.channels == 1 and facts.bits_per_sample == 16 and
          facts.sample_rate in (44100, 48000), 'unqualified PCM channel/bit-depth/rate profile')
    values = validate_metadata(metadata, limits=limits)
    bundle = plan_location(location, limits=limits)
    _need(bundle.path.isascii() and '%' not in bundle.url, 'non-ASCII/escaped native Location qualification pending')
    _need(type(bindings) is WaveRecordBindings, 'typed record bindings required')
    bindings.validate()
    _need(isinstance(sort_ranks, tuple) and len(sort_ranks) == 7, 'seven explicit rank values required; no guessed reset')
    for rank in sort_ranks:
        _uint(rank, 4, 'rank')
    added, modified = hfs_displayed_wall_time(date_added), hfs_displayed_wall_time(date_modified)
    # These are ASCII in the admitted recipe; check before encoding any child.
    text_bytes = len(values['name']) + len('WAV audio file') + len(bundle.path) + len(bundle.url)
    _need(text_bytes <= limit_value(limits, 'max_text_bytes'), 'aggregate record text budget')
    path_record, url_record = location_records(bundle, limits=limits)
    records = (_text_record(2, bindings.name_atom, values['name'], 3),
               _text_record(6, bindings.kind_atom, 'WAV audio file', 3), path_record, url_record)
    _need(sum(len(raw) - 40 for raw in records) <= limit_value(limits, 'max_text_bytes'), 'aggregate record text budget')
    header = bytearray(756)
    header[:4] = b'mith'
    # Observed default bytes for this narrowly named native PCM recipe. These
    # slots are not independently advertised as semantic setters.
    defaults = {0x14: 1, 0x50: 70, 0x5c: 0xffffffff, 0xc8: 256, 0x104: 1,
                0x128: 258, 0x14c: 0x80808080, 0x150: 0x8080, 0x1dc: 256,
                0x208: 65536, 0x274: 1}
    fields = {4: 756, 8: 756 + sum(map(len, records)), 12: len(records),
              0x10: bindings.track_local, 0x20: modified, 0x24: facts.size_bytes,
              0x28: facts.exact_pcm_milliseconds, 0x2c: values['track_number'],
              0x30: values['track_count'], 0x34: values['year'],
              0x38: facts.bitrate_bps // 1000, 0x78: added, 0x8c: 0x57415620,
              0xdc: bindings.album_local, 0x144: facts.size_bytes,
              0x1e0: bindings.artist_local, 0x1f4: bindings.secondary_local}
    for offset, value in {**defaults, **fields}.items():
        struct.pack_into('<I', header, offset, _uint(value, 4, f'field{offset:x}'))
    struct.pack_into('<Q', header, 0x80, bindings.track_pid)
    struct.pack_into('<f', header, 0x98, float(facts.sample_rate))
    # PCM mono evidence: sample count differs from sample RATE for non1sec audio.
    # Do not reuse this rule for MPEG/AAC/ALAC or unknown channel profiles.
    struct.pack_into('<Q', header, 0xf4, facts.frames)
    struct.pack_into('<HH', header, 0x68, values['disc_number'], values['disc_count'])
    header[0x6c] = values['rating']
    header[0x6d] = 0  # explicit Name, no filename-refresh bit
    header[0xee] = 0 if values['unplayed'] else 1
    for offset, rank in zip(range(0x290, 0x2ac, 4), sort_ranks):
        struct.pack_into('<I', header, offset, rank)
    raw = bytes(header) + b''.join(records)
    return WaveRecord(raw, facts.sha256, sha256(raw).hexdigest(), facts.sample_rate,
                      facts.frames, facts.exact_pcm_milliseconds, facts.bitrate_bps // 1000)


def _wall_datetime(value):
    if isinstance(value, str):
        try:
            value = datetime.fromisoformat(value)
        except ValueError as exc:
            raise ConstructionError('invalid ISO wall datetime') from exc
    hfs_displayed_wall_time(value)
    return value


def _media_declaration(facts):
    return {'format': facts.format, 'sha256': facts.sha256, 'size_bytes': facts.size_bytes,
            'sample_rate_hz': facts.sample_rate, 'channels': facts.channels,
            'bits_per_sample': facts.bits_per_sample, 'pcm_source_frames': facts.frames,
            'duration_ms': facts.exact_pcm_milliseconds, 'bitrate_kbps': facts.bitrate_bps // 1000}


def declare_intent(media_bytes, metadata, location, *, date_added, date_modified, limits=None):
    """Detached JSON expectation from MEDIA + user intent, before record construction.

    No target/candidate is read, no identity is allocated, and embedded tags do
    not supply metadata. The result is data, not a coverage/permission certificate.
    """
    from .schema import get_limits, encode_json
    checked = get_limits(limits)
    _construction_preflight(media_bytes, metadata, location, date_added, date_modified, checked)
    facts = probe_bytes(media_bytes, limits=checked)
    _need(facts.format == 'WAV' and facts.channels == 1 and facts.bits_per_sample == 16 and
          facts.sample_rate in (44100, 48000), 'unqualified PCM recipe')
    values = validate_metadata(metadata, limits=checked)
    bundle = plan_location(location, limits=checked)
    _need(bundle.path.isascii() and '%' not in bundle.url, 'native qualification pending for escaped/UTF16 constructor Location')
    result = {'op': 'append_pcm_wave', 'location': bundle.path, 'metadata': values,
              'date_added': _wall_datetime(date_added).isoformat(),
              'date_modified': _wall_datetime(date_modified).isoformat(),
              'media': _media_declaration(facts)}
    return json.loads(encode_json(result, limits=checked))


@dataclass(frozen=True, slots=True)
class _FacadeAdmission:
    # Only immutable limits/costs, never media bytes, target bytes or caller facts.
    shared: object
    model: object
    probe: object
    work: object
    fixed_cost: int
    probe_cost: int
    model_cost: int
    floor: int


def _facade_shape(target_bytes, intent, media_bytes, checked):
    _memory_preflight(checked, 65536)
    if type(target_bytes) is not bytes or type(media_bytes) is not bytes:
        raise TypeError('target and media must be exact immutable bytes')
    checked.check('file', len(target_bytes)); checked.check('file', len(media_bytes))
    keys = {'op', 'location', 'metadata', 'date_added', 'date_modified', 'media'}
    _need(type(intent) is dict and len(intent) == 6 and all(type(k) is str for k in intent) and set(intent) == keys,
          'intent must have exactly op/location/metadata/date_added/date_modified/media')
    _need(type(intent['op']) is str and intent['op'] == 'append_pcm_wave', 'unsupported construction operation')
    for k in ('location', 'date_added', 'date_modified'):
        _need(type(intent[k]) is str, 'JSON Location/dates must be exact strings')
    meta = intent['metadata']
    meta_cost = _metadata_memory_estimate(meta)
    _need(all(type(v) in (str, int, bool) for v in meta.values()), 'metadata scalar exact types')
    for value in meta.values():
        if type(value) is int:
            _uint(value, 8, 'metadata scalar')
    claim = intent['media']
    media_keys = {'format', 'sha256', 'size_bytes', 'sample_rate_hz', 'channels',
                  'bits_per_sample', 'pcm_source_frames', 'duration_ms', 'bitrate_kbps'}
    _need(type(claim) is dict and len(claim) == 9 and all(type(k) is str for k in claim) and set(claim) == media_keys,
          'media declaration exact keys')
    for k, v in claim.items():
        if k in ('format', 'sha256'):
            _need(type(v) is str, 'media declaration text type')
        else:
            _uint(v, 8, 'media declaration numeric')
    # Flat closed input shape: bound escaped JSON BEFORE encoding/copying it.
    chars = sum(len(k) + (len(v) if type(v) is str else 20) for k, v in meta.items())
    chars += sum(len(k) + (len(v) if type(v) is str else 20) for k, v in claim.items())
    chars += sum(len(intent[k]) for k in ('op', 'location', 'date_added', 'date_modified'))
    json_bound = 1024 + 6 * chars + 32 * (len(meta) + 15)
    fixed = 262144 + 24 * (len(target_bytes) + len(media_bytes)) + 128 * json_bound + meta_cost
    return fixed


def _facade_admission(target_bytes, intent, media_bytes, checked):
    """Partition this BLOCKED prepare path before JSON, decode or physical probe.

    Reserve wire/intent/facts/text work plus the real media helper workspace.
    Two bounded model slots cover planning's retained target and our builder's
    diagnostic model. Each obeys 64*plain +8192*nodes <= model_cost. Tight caps
    can conservatively refuse otherwise valid inputs; this is not an RSS limit.
    Candidate/history/allocator accounting is intentionally not implemented.
    """
    from dataclasses import replace
    fixed = _facade_shape(target_bytes, intent, media_bytes, checked)
    probe_cost = _probe_memory_estimate(len(media_bytes), checked) + 65536
    floor = fixed + probe_cost + 2 * 2097152
    _memory_preflight(checked, floor)
    model_cost = (checked.memory_budget_bytes - fixed - probe_cost) // 2
    plain_cap = min(checked.max_plain_bytes, model_cost // 128)
    node_cap = min(checked.max_nodes, model_cost // 16384)
    shared = replace(checked, memory_budget_bytes=checked.memory_budget_bytes - probe_cost,
                     max_plain_bytes=plain_cap, max_nodes=node_cap)
    return _FacadeAdmission(shared, replace(shared, memory_budget_bytes=model_cost),
        replace(checked, memory_budget_bytes=probe_cost), replace(checked, memory_budget_bytes=fixed),
        fixed, probe_cost, model_cost, floor)


def _resource_media(resources):
    if type(resources) is not dict or len(resources) != 1 or any(type(k) is not str for k in resources) or set(resources) != {'media'} or type(resources['media']) is not bytes:
        raise TypeError('constructor resources must contain exactly immutable media bytes')
    return resources['media']


def _constructor_resource_facts(resources, *, limits, admission):
    """Bounded pure JSON projection, physically probed; not a caller DTO adapter."""
    from .media import MediaFacts
    from .schema import get_limits
    _need(type(admission) is _FacadeAdmission and get_limits(limits) is admission.shared, 'constructor admission context mismatch')
    data = _resource_media(resources)
    # Changed/larger callback inputs cannot borrow planning's reserved memory.
    _memory_preflight(admission.probe, _probe_memory_estimate(len(data), admission.probe) + 65536)
    facts = probe_bytes(data, limits=admission.probe)
    _need(type(facts) is MediaFacts, 'actual typed MediaFacts required')
    for k in ('size_bytes', 'sample_rate', 'channels', 'bits_per_sample', 'frames', 'bitrate_bps'):
        _uint(getattr(facts, k), 8, 'physical media facts ' + k)
    _need(type(facts.format) is str and facts.format == 'WAV' and facts.channels == 1 and
          facts.bits_per_sample == 16 and facts.sample_rate in (44100, 48000), 'unqualified PCM recipe')
    _need(type(facts.sha256) is str and facts.sha256 == sha256(data).hexdigest() and facts.size_bytes == len(data),
          'physical media size/hash mismatch')
    _need(facts.duration_quality == 'exact_pcm_frames' and type(facts.duration_seconds) is float and
          facts.duration_seconds == facts.frames / facts.sample_rate, 'physical PCM duration mismatch')
    # Exactly nine scalar fields bound facts JSON independently of arbitrary tags
    # or chunk observations. No dataclass, byte payload or callable crosses lanes.
    return {'media': _media_declaration(facts)}


def _constructor_check_intent(intent, facts, admission):
    claim = intent['media']; actual = facts['media']
    _need(type(claim) is dict and set(claim) == set(actual) and
          all(type(claim[k]) is type(v) and claim[k] == v for k, v in actual.items()),
          'media declaration differs from actual immutable bytes')
    values = validate_metadata(intent['metadata'], limits=admission.work)
    bundle = plan_location(intent['location'], limits=admission.work)
    _need(bundle.path.isascii() and '%' not in bundle.url, 'native qualification pending for escaped/UTF16 constructor Location')
    _wall_datetime(intent['date_added']); _wall_datetime(intent['date_modified'])
    return values, bundle


def _constructor_blocked_build(data, intent, sources, *, limits, seed, resources, admission):
    from .schema import load_library, ProfileReport, Blocker
    from .atoms import assert_pool_bindings
    from .trackops import _profile
    from .errors import UnsupportedError
    _need(type(sources) is dict and not sources, 'constructor ITL source lane must be empty')
    facts = _constructor_resource_facts(resources, limits=limits, admission=admission)
    _constructor_check_intent(intent, facts, admission)
    library = load_library(data, limits=admission.model)
    blockers = []
    try:
        _profile(library)
        assert_pool_bindings(library)
    except UnsupportedError as exc:
        blockers.append(Blocker('retained_profile_or_pools', str(exc)))
    blockers.extend((
        Blocker('identity_pool_master_closure_pending', 'Real graph/identity dependency is present; actual reservations, SourceBinding, Name/Kind registration, auxiliary/items/history, complete master and system-role/unknown-pool closure remain unimplemented'),
        Blocker('constructor_candidate_unavailable', 'No full new-track builder or independent candidate acceptance; no repair, donor relabeling, fabricated ledger or no-op candidate'),
        Blocker('candidate_accounting_pending', 'Partitioned admission covers only this blocked preparation path, not future candidate/allocator/history work or OS RSS'),
        Blocker('identity_binding_closure_unproved', 'Recipe wire slots can be derived from an externally frozen canonical ledger by bindings_from_ledger, but these remain unproved: ' + ', '.join(row['code'] for row in UNMET_CONSTRUCTION_CONDITIONS)),
    ))
    return ProfileReport(library.container.version, library.container.payload_byteorder,
        invariants=({'check': 'independent media declaration', 'passed': True, 'media_facts': facts['media']},
                    {'check': 'partitioned blocked-prepare budget', 'fixed_bytes': admission.fixed_cost,
                     'probe_bytes': admission.probe_cost, 'model_bytes_each': admission.model_cost,
                     'floor_bytes': admission.floor, 'plain_cap': admission.model.max_plain_bytes,
                     'node_cap': admission.model.max_nodes},
                    {'check': 'baseline digest is provenance only', 'sha256': sha256(data).hexdigest()}),
        capabilities=('media_probe', 'independent_intent_validation',
                      'media_resource_lane', 'pure_json_media_facts', 'partitioned_blocked_prepare_admission'),
        blockers=tuple(blockers), evidence_refs=('docs/construct-v2.md', 'docs/experimental-api.md'))


def _constructor_reject_candidate(data, intent, sources, candidate, report, *, limits, resources, admission):
    # Contract-ready resources keyword, but no candidate can be accepted yet.
    # Never replay the builder, allocator or RNG here (including at apply).
    _need(type(sources) is dict and not sources, 'constructor ITL source lane must be empty')
    facts = _constructor_resource_facts(resources, limits=limits, admission=admission)
    _constructor_check_intent(intent, facts, admission)
    return False


def prepare(target_bytes, intent, sources=None, *, limits=None, seed=None):
    """Real media-resource facade; always explicitly blocked before any candidate."""
    from functools import partial
    from .schema import get_limits, encode_json
    from .planning import prepare_mutation
    checked = get_limits(limits)
    _memory_preflight(checked, 65536)
    if type(sources) is not dict or len(sources) != 1 or any(type(k) is not str for k in sources) or set(sources) != {'media'} or type(sources['media']) is not bytes:
        raise TypeError('constructor sources must contain exactly immutable media bytes')
    media_bytes = sources['media']
    admission = _facade_admission(target_bytes, intent, media_bytes, checked)
    detached = json.loads(encode_json(intent, limits=admission.work))
    _need(_facade_shape(target_bytes, detached, media_bytes, checked) <= admission.fixed_cost,
          'intent changed beyond admitted shape')
    # Partial closures contain only immutable cost/limit records, never media,
    # target, intent or fake identity/ledger data. Actual bytes travel explicitly.
    return prepare_mutation('constructor-pcm-resource.v1', target_bytes, detached, None,
        limits=admission.shared, seed=seed, resources={'media': media_bytes},
        validate_resources=partial(_constructor_resource_facts, admission=admission),
        build=partial(_constructor_blocked_build, admission=admission),
        validate=partial(_constructor_reject_candidate, admission=admission))


# --- Identity-v2 requirement surface for the admitted PCM recipe ------------
# Every wire slot materialize_pcm_wave_record actually writes, paired with the
# identity-v2 namespace that must own it. The header offsets and mhoh type
# codes are the slots emitted above: mith type 2 is Name, type 6 is Kind.
IDENTITY_REQUIREMENTS = (
    ('track_local', 'track.common_local', 4, 'header:0x10'),
    ('secondary_local', 'track.file_local', 4, 'header:0x1f4'),
    ('album_local', 'album.local', 4, 'header:0xdc'),
    ('artist_local', 'artist.local', 4, 'header:0x1e0'),
    ('track_pid', 'track.pid', 8, 'header:0x80'),
    ('name_atom', 'pool:L+0x178', 4, 'mhoh:mith:2'),
    ('kind_atom', 'pool:L+0x370', 4, 'mhoh:mith:6'),
)

# What a complete, self-consistent identity set still does NOT prove. This is
# evidence about absence: never a plan of record, a capability or a permission.
UNMET_CONSTRUCTION_CONDITIONS = (
    {'code': 'kind_atom_outside_constructor_pool_guard',
     'owner': 'itlkit/atoms.py',
     'detail': 'graph.POOLS maps mith type 6 to L+0x370 and it is an identity-v2 pool, but '
               'atoms._POOLS has no type 6 entry, so assert_pool_bindings cannot see the '
               'Kind atom this recipe writes'},
    {'code': 'no_container_membership_patch',
     'owner': 'itlkit/library.py and a reviewed candidate builder',
     'detail': 'a materialized record is standalone: list/section counts, header track '
               'counters, auxiliary album/artist rows and playlist item entries are not produced'},
    {'code': 'no_reverse_reference_closure',
     'owner': 'itlkit/graph.py',
     'detail': 'adapt_identity_graph can only re-validate an existing graph; no post-candidate '
               'ReferenceGraph proves album/artist/item edges close onto the new identities'},
    {'code': 'no_allocator_inside_prepare',
     'owner': 'itlkit/construct.py',
     'detail': 'prepare forwards seed but never runs ReservationAllocator, so bindings must come '
               'from a ledger frozen and canonicalized outside this engine'},
    {'code': 'no_candidate_accounting',
     'owner': 'itlkit/construct.py',
     'detail': 'the partitioned admission budgets only this blocked path, not candidate, '
               'allocator or history work'},
    {'code': 'no_native_acceptance_evidence',
     'owner': 'native verification task',
     'detail': 'WaveRecord.native_accepted stays False; nothing here observes or implies that '
               'iTunes accepts a constructed record'},
)


def unmet_construction_conditions():
    """Explicit JSON-safe list of what a bound identity set still cannot prove."""
    return tuple(dict(row) for row in UNMET_CONSTRUCTION_CONDITIONS)


def _recipe_namespaces():
    """Fail closed if the recipe drifts from the shared identity-v2 vocabulary."""
    from .schema import IDENTITY_V2_POOLS, IDENTITY_V2_WIDTHS, importer_pool_domain
    for _field, namespace, width, _slot in IDENTITY_REQUIREMENTS:
        if IDENTITY_V2_WIDTHS.get(namespace) != width:
            raise ConstructionError('recipe identity namespace is outside the identity-v2 vocabulary')
        if namespace.startswith('pool:') and namespace[5:] not in IDENTITY_V2_POOLS:
            raise ConstructionError('recipe pool is outside the identity-v2 pool vocabulary')
    if (IDENTITY_REQUIREMENTS[5][1] != 'pool:' + importer_pool_domain('name')
            or IDENTITY_REQUIREMENTS[6][1] != 'pool:' + importer_pool_domain('kind')):
        raise ConstructionError('recipe pool domains drifted from the pinned importer alias table')
    return tuple(row[1] for row in IDENTITY_REQUIREMENTS)


def _binding_provenance(namespace, reservation):
    """Report retained provenance for one reservation; never relabel a source."""
    from .schema import ScopedID, SourceBinding
    old = reservation.old_identity
    record = {'namespace': namespace, 'consumers': tuple(reservation.consumers)}
    if namespace.startswith('pool:'):
        if old is None:
            record['source_binding'] = None
            return record
        if type(old) is not SourceBinding or 'pool:' + old.pool != namespace:
            raise ConstructionError('pool reservation carries a foreign or untyped source binding')
        record['source_binding'] = {'pool': old.pool, 'wire_id': old.wire_id,
                                    'value_digest': old.value_digest,
                                    'snapshot': old.snapshot.digest}
        return record
    if old is not None and type(old) is not ScopedID:
        raise ConstructionError('non-pool reservation requires typed retained provenance')
    record['retained_source'] = None if old is None else {
        'namespace': old.namespace, 'scope': old.scope, 'value': old.value}
    return record


def bindings_from_ledger(ledger, *, limits=None):
    """Bind this recipe's wire slots to a canonical AllocationLedger.

    This closes the one integration that was genuinely missing between the
    constructor and planning: which reserved typed identity fills each slot the
    recipe writes, and what SourceBinding provenance a pool atom carries.

    It is evidence conversion only. Nothing is allocated, no candidate is built
    or accepted, no gate is relaxed, and prepare() stays blocked whether or not
    this succeeds. See unmet_construction_conditions() for what a complete
    binding still does not prove.
    """
    from .planning import identity_binding_index
    required = _recipe_namespaces()
    index = identity_binding_index(ledger, limits=limits)
    if set(index) - set(required):
        raise ConstructionError('ledger reserves identities outside the admitted recipe set')
    values, provenance = {}, {}
    for field_name, namespace, width, slot in IDENTITY_REQUIREMENTS:
        rows = index.get(namespace, ())
        if len(rows) != 1:
            raise ConstructionError('exactly one reservation is required per recipe namespace')
        identity = rows[0].reserved_identity
        if identity.width != width or not 0 < identity.value < 1 << (8 * width):
            raise ConstructionError('reserved identity width or value is unusable in this slot')
        values[field_name] = identity.value
        provenance[slot] = _binding_provenance(namespace, rows[0])
    bindings = WaveRecordBindings(**values)
    bindings.validate()
    return bindings, provenance
