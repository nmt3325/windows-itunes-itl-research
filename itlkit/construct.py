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

from .media import MediaError, probe_bytes, limit_value
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


def validate_metadata(metadata, *, limits=None):
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


def prepare(target_bytes, intent, sources=None, *, limits=None, seed=None):
    """Validate independent intent and return the actual shared blocked ProfileReport.

    The integrated codec pin parses every source as ITL before build, so WAV
    must NOT be hidden in JSON/a closure or passed as an invented ITL donor.
    Actual opaque/media-source support plus authorized graph/allocator integration
    are required before a full candidate can be sealed. No fallback is provided.
    """
    from .schema import get_limits, encode_json, load_library, ProfileReport, Blocker
    from .atoms import assert_pool_bindings
    from .trackops import _profile
    from .errors import UnsupportedError
    checked = get_limits(limits)
    if type(target_bytes) is not bytes:
        raise TypeError('target must be immutable bytes')
    checked.check('file', len(target_bytes))
    if type(intent) is not dict or set(intent) != {'op','location','metadata','date_added','date_modified','media'}:
        raise ConstructionError('intent must have exactly op/location/metadata/date_added/date_modified/media')
    if type(sources) is not dict or set(sources) != {'media'} or type(sources['media']) is not bytes:
        raise TypeError('constructor sources must contain exactly immutable media bytes')
    _need(intent['op'] == 'append_pcm_wave', 'unsupported construction operation')
    _need(type(intent['date_added']) is str and type(intent['date_modified']) is str, 'JSON intent dates must be explicit ISO strings')
    detached = json.loads(encode_json(intent, limits=checked))
    expected = declare_intent(sources['media'], detached['metadata'], detached['location'],
                              date_added=detached['date_added'], date_modified=detached['date_modified'], limits=checked)
    claimed = detached['media']
    _need(type(claimed) is dict and set(claimed) == set(expected['media']), 'media declaration exact keys')
    _need(all(type(claimed[k]) is type(v) and claimed[k] == v for k,v in expected['media'].items()), 'media declaration differs from actual immutable bytes')
    library = load_library(target_bytes, limits=checked)
    blockers = []
    try:
        _profile(library)
        assert_pool_bindings(library)
    except UnsupportedError as exc:
        blockers.append(Blocker('retained_profile_or_pools', str(exc)))
    blockers.extend((
        Blocker('media_source_adapter_unavailable', 'Authorized planning adapter loads every source as ITL before build; constructor requires bounded media source snapshot/hash/revalidation without ITL parsing', evidence_refs=('itlkit/planning.py:prepare_mutation source loop',)),
        Blocker('identity_adapter_pending_authorized_pin', 'Actual graph/allocator and auxiliary/item/pool closure adapter await a new parent pin; no unchecked supplied ledger, pool guard deletion, or donor relabeling is used'),
    ))
    return ProfileReport(library.container.version, library.container.payload_byteorder,
                         invariants=({'check':'input-derived media/metadata declaration','passed':True},
                                     {'check':'bounded target decoding','passed':True},
                                     {'check':'baseline digest is provenance only','sha256':sha256(target_bytes).hexdigest()}),
                         capabilities=('media_probe','independent_intent_validation','standalone_pcm_record_recipe'),
                         blockers=tuple(blockers),
                         evidence_refs=('docs/construct-v2.md','docs/experimental-api.md'))
