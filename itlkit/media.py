"""Bounded, read-only media facts. Parser support is not ITL write admission."""
from __future__ import annotations

from dataclasses import dataclass
from hashlib import sha256
from io import BytesIO
from pathlib import Path
import math
import os
import stat
import struct


class MediaError(ValueError):
    """Malformed, stale or unsupported media/probe input."""


def limit_value(limits, name):
    """Use the real shared limits; dictionaries remain helper-only convenience."""
    from .schema import ReadLimits, get_limits
    try:
        checked = ReadLimits(**limits) if type(limits) is dict else get_limits(limits)
        value = getattr(checked, name)
    except (TypeError, ValueError, AttributeError) as exc:
        raise MediaError('invalid shared ReadLimits: ' + str(exc)) from exc
    return value


# Owned helper admission policy, not the separately owned engine resources API.
# This is a deterministic conservative estimate, never an OS/RSS guarantee.
_MEDIA_WORKSPACE = 64 * 1024


def _memory_preflight(limits, amount):
    """Apply the real shared memory dimension before helper allocations/IO."""
    from .schema import ReadLimits, get_limits, LimitError
    try:
        checked = ReadLimits(**limits) if type(limits) is dict else get_limits(limits)
    except (TypeError, ValueError) as exc:
        raise MediaError('invalid shared ReadLimits: ' + str(exc)) from exc
    try:
        checked.check('memory', amount)
    except LimitError as exc:
        raise MediaError(str(exc)) from exc
    return checked


def _probe_memory_estimate(size, limits):
    """Input/buffer/parser copies plus bounded possible eight-byte chunk slots.

    Optional parser internals are not an allocation sandbox. Large valid inputs
    may be refused by this heuristic even when max_file_bytes permits them.
    """
    _need(type(size) is int and size >= 0, 'media estimate size range/type')
    slots = min(limit_value(limits, 'max_nodes'), max(0, (size - 12) // 8))
    return _MEDIA_WORKSPACE + 16 * size + 1024 * slots


@dataclass(frozen=True, slots=True)
class MediaFacts:
    format: str
    size_bytes: int
    sha256: str
    sample_rate: int
    channels: int
    bits_per_sample: int | None
    frames: int | None
    duration_seconds: float
    duration_quality: str
    bitrate_bps: int | None
    codec: str | None
    chunks: tuple[str, ...] = ()
    tag_keys: tuple[str, ...] = ()
    # Observation-only intake surface. Spans and carrier names are recorded so
    # a new-media record cannot silently drop an embedded field; payloads are
    # never decoded, applied or rewritten.
    chunk_spans: tuple[tuple[str, int, int], ...] = ()
    metadata_carriers: tuple[str, ...] = ()
    artwork_carriers: tuple[str, ...] = ()

    @property
    def exact_pcm_milliseconds(self):
        if self.duration_quality != 'exact_pcm_frames' or self.frames is None:
            raise MediaError('not an exact PCM duration')
        return self.frames * 1000 // self.sample_rate

    @property
    def pcm_millisecond_remainder(self):
        """Nonzero means exact_pcm_milliseconds truncates; native rounding is unverified."""
        if self.duration_quality != 'exact_pcm_frames' or self.frames is None:
            raise MediaError('not an exact PCM duration')
        return self.frames * 1000 % self.sample_rate

    @property
    def pcm_milliseconds_are_exact(self):
        return self.pcm_millisecond_remainder == 0

    @property
    def embedded_metadata_present(self):
        """True when the media carries metadata this module deliberately never decodes."""
        return bool(self.metadata_carriers or self.tag_keys)

    @property
    def artwork_possible(self):
        """True when an artwork-capable carrier exists; artwork is never extracted."""
        return bool(self.artwork_carriers)


@dataclass(frozen=True, slots=True)
class FileObservation:
    path: str
    size_bytes: int
    sha256: str
    mtime_ns: int
    facts: MediaFacts


def _need(condition, message):
    if not condition:
        raise MediaError(message)


def _pcm(data, limits):
    wave = data[:4] == b'RIFF' and data[8:12] == b'WAVE'
    aiff = data[:4] == b'FORM' and data[8:12] == b'AIFF'
    _need(wave or aiff, 'unverified PCM container (including RF64/WAVE extensible/AIFC)')
    endian = '<' if wave else '>'
    _need(struct.unpack_from(endian + 'I', data, 4)[0] + 8 == len(data), 'PCM outer length/trailer')
    chunks = {}
    cursor = 12
    while cursor < len(data):
        _need(len(chunks) < limit_value(limits, 'max_nodes'), 'PCM chunk count budget')
        _need(cursor + 8 <= len(data), 'truncated chunk header')
        tag = data[cursor:cursor + 4]
        size = struct.unpack_from(endian + 'I', data, cursor + 4)[0]
        start, end = cursor + 8, cursor + 8 + size
        _need(end + (size & 1) <= len(data), 'truncated chunk or padding')
        _need(tag not in chunks, 'duplicate PCM chunk')
        chunks[tag] = (start, end)
        cursor = end + (size & 1)
    if wave:
        _need(b'fmt ' in chunks and b'data' in chunks, 'missing WAVE fmt/data')
        start, end = chunks[b'fmt ']
        _need(end - start == 16, 'only canonical16-byte PCM fmt is decoded')
        codec, channels, rate, byte_rate, align, bits = struct.unpack_from('<HHIIHH', data, start)
        _need(codec == 1, 'compressed/extensible WAVE is unverified')
        _need(channels in (1, 2) and bits in (8, 16, 24, 32) and rate > 0, 'PCM dimensions')
        _need(align == channels * bits // 8 and byte_rate == rate * align, 'PCM byte rate/alignment')
        start, end = chunks[b'data']
        _need((end - start) % align == 0, 'partial PCM frame')
        frames = (end - start) // align
    else:
        _need(b'COMM' in chunks and b'SSND' in chunks, 'missing AIFF COMM/SSND')
        start, end = chunks[b'COMM']
        _need(end - start == 18, 'AIFF COMM shape')
        channels, frames, bits = struct.unpack_from('>HIH', data, start)
        exponent, mantissa = struct.unpack_from('>HQ', data, start + 8)
        _need(0 < exponent < 0x7fff and mantissa & (1 << 63), 'AIFF extended80 rate shape')
        shift = exponent - 16383 - 63
        _need(-63 <= shift <= 16, 'AIFF rate exponent bound')
        if shift < 0:
            _need(mantissa % (1 << -shift) == 0, 'fractional AIFF rate is unverified')
            rate = mantissa >> -shift
        else:
            rate = mantissa << shift
        _need(channels in (1, 2) and bits in (8, 16, 24, 32) and rate > 0, 'AIFF dimensions')
        start, end = chunks[b'SSND']
        _need(end - start >= 8, 'AIFF SSND header')
        offset, block_size = struct.unpack_from('>II', data, start)
        _need(offset == block_size == 0, 'AIFF SSND offset/block profile unverified')
        _need(end - start - 8 == frames * channels * (bits // 8), 'AIFF sample length')
    _need(frames > 0, 'empty PCM media')
    # Record every chunk, including unknown ones, as (tag, payload offset,
    # payload length). Presence is reported; no payload is decoded or dropped.
    spans = tuple((key.decode('ascii', 'backslashreplace'), begin, finish - begin)
                  for key, (begin, finish) in chunks.items())
    names = tuple(name for name, _, _ in spans)
    return MediaFacts('WAV' if wave else 'AIFF', len(data), sha256(data).hexdigest(),
                      rate, channels, bits, frames, frames / rate, 'exact_pcm_frames',
                      rate * channels * bits, 'pcm', names, (),
                      spans,
                      tuple(name for name in names if name in _PCM_METADATA_CHUNKS),
                      tuple(name for name in names if name in _PCM_ARTWORK_CHUNKS))


def probe_bytes(data: bytes, *, limits=None) -> MediaFacts:
    """No IO or implicit tag application. Non-PCM probing requires optional mutagen."""
    limits = _memory_preflight(limits, _MEDIA_WORKSPACE)
    _need(isinstance(data, bytes), 'media must be immutable bytes')
    _need(12 <= len(data) <= limit_value(limits, 'max_file_bytes'), 'media file size budget')
    _memory_preflight(limits, _probe_memory_estimate(len(data), limits))
    if data[:4] in (b'RIFF', b'FORM', b'RF64'):
        return _pcm(data, limits)
    try:
        import mutagen
    except ImportError as exc:
        raise MediaError('optional mutagen is required for non-PCM probing; no installation attempted') from exc
    try:
        audio = mutagen.File(BytesIO(data), easy=False)
    except Exception as exc:
        raise MediaError('non-PCM parser refused media') from exc
    _need(audio is not None, 'unrecognized media; raw AAC requires a separate profile')
    info = audio.info
    module = type(audio).__module__
    codec = getattr(info, 'codec', None)
    if module == 'mutagen.mp3':
        _need(not getattr(info, 'sketchy', False), 'sketchy MPEG stream')
        family = 'MP3'
    elif module == 'mutagen.mp4' and codec == 'alac':
        family = 'ALAC'
    elif module == 'mutagen.mp4' and isinstance(codec, str) and codec.startswith('mp4a'):
        family = 'AAC_MP4'
    else:
        raise MediaError('unverified codec/container')
    rate, channels, seconds = info.sample_rate, info.channels, info.length
    _need(type(rate) is int and rate > 0 and type(channels) is int and channels > 0, 'invalid parsed dimensions')
    _need(isinstance(seconds, (int, float)) and math.isfinite(seconds) and seconds > 0, 'invalid parsed duration')
    tags = audio.tags or {}
    _need(len(tags) <= limit_value(limits, 'max_nodes'), 'tag key count budget')
    _need(all(type(k) is str for k in tags), 'parsed tag keys must be strings')
    characters = sum(len(k) for k in tags)
    _memory_preflight(limits, _probe_memory_estimate(len(data), limits) +
                      16 * characters + 256 * len(tags))
    _need(characters <= limit_value(limits, 'max_text_bytes'), 'tag key text budget')
    _need(sum(len(k.encode('utf-8')) for k in tags) <= limit_value(limits, 'max_text_bytes'), 'tag key text budget')
    keys = tuple(sorted(tags))
    return MediaFacts(family, len(data), sha256(data).hexdigest(), rate, channels,
                      getattr(info, 'bits_per_sample', None), None, float(seconds),
                      'parser_only_not_native_wire_duration', getattr(info, 'bitrate', None), codec,
                      tag_keys=keys,
                      artwork_carriers=tuple(k for k in keys if k.startswith(_TAG_ARTWORK_PREFIXES)))


def probe_file(path, *, expected_sha256=None, expected_size=None, expected_mtime_ns=None, limits=None):
    """Budget before IO; retain strict pins and path/open-file identity checks."""
    limits = _memory_preflight(limits, _MEDIA_WORKSPACE)
    if expected_sha256 is not None:
        _need(type(expected_sha256) is str and len(expected_sha256) == 64 and
              all(c in '0123456789abcdef' for c in expected_sha256), 'SHA256 pin must be canonical lowercase hex')
    for value in (expected_size, expected_mtime_ns):
        _need(value is None or (type(value) is int and value >= 0), 'numeric file pins must be nonnegative integers')
    cap = limit_value(limits, 'max_file_bytes')
    path_text = os.fspath(path)
    _need(type(path_text) is str, 'media path must resolve to text')
    path_workspace = 16 * len(path_text)
    _memory_preflight(limits, _MEDIA_WORKSPACE + path_workspace)
    path = Path(path_text)
    before = path.stat()
    _need(stat.S_ISREG(before.st_mode), 'media is not a regular file')
    _need(before.st_size <= cap, 'media file size budget before read')
    _memory_preflight(limits, _probe_memory_estimate(before.st_size + 1, limits) + path_workspace)
    identity = lambda s: (s.st_dev, s.st_ino, s.st_size, s.st_mtime_ns)
    with path.open('rb') as stream:
        opened = os.fstat(stream.fileno())
        _need(identity(before) == identity(opened), 'media replaced before open')
        # Reserve/read only the verified length plus a growth-detection byte.
        data = stream.read(opened.st_size + 1)
        completed = os.fstat(stream.fileno())
    _need(identity(opened) == identity(completed) and len(data) == opened.st_size, 'media changed during read')
    facts = probe_bytes(data, limits=limits)
    after = path.stat()
    _need(identity(before) == identity(after), 'media path changed during probe')
    for observed, expected in ((facts.sha256, expected_sha256), (facts.size_bytes, expected_size),
                               (after.st_mtime_ns, expected_mtime_ns)):
        _need(expected is None or observed == expected, 'sealed media provenance mismatch')
    return FileObservation(str(path), facts.size_bytes, facts.sha256, after.st_mtime_ns, facts)


# --- genuinely new-media intake classification ---------------------------
# Observation and classification only. Nothing below relaxes a writer,
# constructor or admission gate, decodes a payload, or constitutes native
# acceptance.

# Container chunks that can carry native-visible metadata or artwork. Only
# presence is reported; payloads are never decoded or applied.
_PCM_METADATA_CHUNKS = frozenset({'LIST', 'CSET', 'ID3 ', 'id3 ', 'NAME',
                                  'AUTH', 'ANNO', 'COMT', '(c) '})
_PCM_ARTWORK_CHUNKS = frozenset({'ID3 ', 'id3 '})
_TAG_ARTWORK_PREFIXES = ('APIC', 'PIC', 'covr', 'METADATA_BLOCK_PICTURE')

# Constants the existing admitted PCM recipe writes. Recorded as recipe
# constants whose native provenance was NOT re-verified in this phase. Other
# families refuse rather than borrow the WAV template.
_RECIPE_KIND_TEXT = {'WAV': 'WAV audio file'}
_RECIPE_FORMAT_CODE = {'WAV': 0x57415620}

FIELD_STATUSES = ('derived_exact', 'recipe_constant_unverified',
                  'caller_supplied', 'absent_from_itlkit')


@dataclass(frozen=True, slots=True)
class MediaFieldRequirement:
    """One media-derived field a genuinely new track record needs."""
    field: str
    record_site: str
    status: str
    value: object = None
    note: str = ''


def recipe_kind_text(facts):
    """Kind text the admitted recipe writes for this family; never a cross-family guess."""
    _need(type(facts) is MediaFacts, 'typed MediaFacts required')
    value = _RECIPE_KIND_TEXT.get(facts.format)
    _need(value is not None, 'no recipe Kind text for ' + str(facts.format))
    return value


def recipe_format_code(facts):
    """Format code the admitted recipe writes for this family; never a cross-family guess."""
    _need(type(facts) is MediaFacts, 'typed MediaFacts required')
    value = _RECIPE_FORMAT_CODE.get(facts.format)
    _need(value is not None, 'no recipe format code for ' + str(facts.format))
    return value


def new_track_media_fields(facts, observation=None, *, limits=None):
    """Classify every media-derived field a genuinely new track record needs.

    Pure classification of an already-probed observation: no IO, no fallback
    and no authority. 'derived_exact' means the value comes from the actual
    bytes; every other status marks an open gap that construction must not
    invent.
    """
    _memory_preflight(limits, _MEDIA_WORKSPACE)
    _need(type(facts) is MediaFacts, 'typed MediaFacts required')
    _need(observation is None or type(observation) is FileObservation,
          'typed FileObservation required')
    rows = [
        MediaFieldRequirement('size_bytes', 'mith 0x24 and 0x144', 'derived_exact',
                              facts.size_bytes),
        MediaFieldRequirement('media_sha256', 'declaration provenance', 'derived_exact',
                              facts.sha256),
        MediaFieldRequirement('sample_rate_hz', 'mith 0x98 float32', 'derived_exact',
                              facts.sample_rate),
        MediaFieldRequirement('channels', 'profile gate only', 'derived_exact', facts.channels),
        MediaFieldRequirement('bits_per_sample', 'profile gate only', 'derived_exact',
                              facts.bits_per_sample),
    ]
    if facts.duration_quality == 'exact_pcm_frames' and facts.frames is not None:
        rows.extend((
            MediaFieldRequirement('pcm_frames', 'mith 0xf4 uint64', 'derived_exact', facts.frames,
                                  'mono PCM evidence only; other shapes are unverified'),
            MediaFieldRequirement('duration_ms', 'mith 0x28', 'derived_exact',
                                  facts.exact_pcm_milliseconds,
                                  'frames divide evenly into milliseconds'
                                  if facts.pcm_milliseconds_are_exact else
                                  'floor truncates here; the native rounding convention is unverified'),
            MediaFieldRequirement('bitrate_kbps', 'mith 0x38', 'derived_exact',
                                  facts.bitrate_bps // 1000,
                                  'rate*channels*bits//1000; the native PCM convention is unverified'),
        ))
    else:
        rows.extend((
            MediaFieldRequirement('pcm_frames', 'mith 0xf4 uint64', 'absent_from_itlkit', None,
                                  'no exact frame count outside the PCM path'),
            MediaFieldRequirement('duration_ms', 'mith 0x28', 'absent_from_itlkit', None,
                                  'parser-only duration is not a native wire duration'),
            MediaFieldRequirement('bitrate_kbps', 'mith 0x38', 'absent_from_itlkit',
                                  facts.bitrate_bps,
                                  'parser-reported bitrate is not the native stored value'),
        ))
    rows.extend((
        MediaFieldRequirement('format_code', 'mith 0x8c', 'recipe_constant_unverified',
                              _RECIPE_FORMAT_CODE.get(facts.format),
                              'recipe constant, not re-verified natively in this phase'),
        MediaFieldRequirement('kind_text', 'mhoh code 6', 'recipe_constant_unverified',
                              _RECIPE_KIND_TEXT.get(facts.format),
                              'recipe constant, not re-verified natively in this phase'),
        MediaFieldRequirement('date_modified', 'mith 0x20', 'caller_supplied',
                              None if observation is None else observation.mtime_ns,
                              'filesystem mtime is observed but its HFS/wall-clock mapping is unverified'),
        MediaFieldRequirement('date_added', 'mith 0x78', 'absent_from_itlkit', None,
                              'no media or filesystem source; a native or user clock value'),
        MediaFieldRequirement('location_path', 'mhoh code 13', 'caller_supplied',
                              None if observation is None else observation.path,
                              'filesystem identity, not media content; the destination path must be declared'),
        MediaFieldRequirement('location_url', 'mhoh code 11', 'caller_supplied',
                              None if observation is None else observation.path,
                              'derived from the declared path, not from media bytes'),
        MediaFieldRequirement('name', 'mhoh code 2', 'absent_from_itlkit', None,
                              'tag values are never decoded; bare PCM carries no name at all'),
        MediaFieldRequirement('tag_metadata', 'album/artist/genre/year/track/disc records',
                              'absent_from_itlkit', facts.tag_keys,
                              'only tag key names are observed; values are never decoded or applied'),
        MediaFieldRequirement('artwork', 'artwork records', 'absent_from_itlkit',
                              facts.artwork_carriers,
                              'artwork is never extracted; carriers are only reported'),
    ))
    for row in rows:
        _need(row.status in FIELD_STATUSES, 'unknown field status')
    return tuple(rows)


def unmet_new_media_conditions(facts, observation=None, *, limits=None):
    """Explicit list of what still blocks genuinely new-media construction."""
    rows = new_track_media_fields(facts, observation, limits=limits)
    conditions = ['%s: %s%s' % (row.field, row.status,
                                ' (' + row.note + ')' if row.note else '')
                  for row in rows if row.status != 'derived_exact']
    if facts.format != 'WAV':
        conditions.append('family: only the WAV PCM recipe is admitted; ' + str(facts.format) +
                          ' must not borrow it')
    if facts.channels != 1:
        conditions.append('channels: only mono is qualified')
    if facts.bits_per_sample != 16:
        conditions.append('bit depth: only 16-bit is qualified')
    if facts.sample_rate not in (44100, 48000):
        conditions.append('sample rate: only 44100 and 48000 are qualified')
    if facts.embedded_metadata_present:
        conditions.append('embedded metadata carriers present and never decoded: ' +
                          ', '.join(facts.metadata_carriers + facts.tag_keys))
    if facts.artwork_possible:
        conditions.append('artwork carriers present and never extracted: ' +
                          ', '.join(facts.artwork_carriers))
    if (facts.duration_quality == 'exact_pcm_frames' and facts.frames is not None
            and not facts.pcm_milliseconds_are_exact):
        conditions.append('duration: frames*1000 leaves remainder %d; native rounding is unverified'
                          % facts.pcm_millisecond_remainder)
    if observation is None:
        conditions.append('file identity: no FileObservation, so path, size and mtime pins are unobserved')
    return tuple(conditions)
