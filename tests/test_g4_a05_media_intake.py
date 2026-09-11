"""G4-B a05: media intake and genuinely new-media record construction gaps.

New tests authored on the GHA runner in this phase. Structural, preservation
and classification evidence only; nothing here is native acceptance.
"""
import struct
from datetime import datetime, timedelta, timezone

import pytest

from itlkit.media import (FIELD_STATUSES, MediaError, MediaFieldRequirement,
                          new_track_media_fields, probe_bytes, probe_file,
                          recipe_format_code, recipe_kind_text,
                          unmet_new_media_conditions)

# Declared dimensions of the never-imported reference fixture
# ITL-G2-PCM-48000-001.wav. Reproduced structurally; the file itself is only
# probed read-only by research/g4/a05/probe_reference_fixture.py.
REFERENCE = {'size_bytes': 144044, 'sample_rate': 48000, 'channels': 1,
             'bits': 16, 'frames': 72000, 'duration_ms': 1500}


def wav_bytes(frames=72000, rate=48000, channels=1, bits=16, extra=(), sample=0):
    body = bytes([sample]) * (frames * channels * bits // 8)
    chunks = (b'fmt ' + struct.pack('<I', 16) +
              struct.pack('<HHIIHH', 1, channels, rate, rate * channels * bits // 8,
                          channels * bits // 8, bits))
    chunks += b'data' + struct.pack('<I', len(body)) + body + (b'\0' if len(body) % 2 else b'')
    for tag, payload in extra:
        chunks += tag + struct.pack('<I', len(payload)) + payload + (b'\0' if len(payload) % 2 else b'')
    return b'RIFF' + struct.pack('<I', 4 + len(chunks)) + b'WAVE' + chunks


def aiff_bytes(rate=22050, frames=4410, channels=1, bits=16):
    exponent = rate.bit_length() - 1
    comm = struct.pack('>HIHHQ', channels, frames, bits, exponent + 16383, rate << (63 - exponent))
    sound = b'\0' * (8 + frames * channels * bits // 8)
    body = (b'AIFF' + b'COMM' + struct.pack('>I', len(comm)) + comm +
            b'SSND' + struct.pack('>I', len(sound)) + sound)
    return b'FORM' + struct.pack('>I', len(body)) + body


def field(rows, name):
    matches = [row for row in rows if row.field == name]
    assert len(matches) == 1, name
    assert type(matches[0]) is MediaFieldRequirement
    return matches[0]


def test_a05_reference_shaped_pcm_reproduces_fixture_dimensions():
    data = wav_bytes()
    assert len(data) == REFERENCE['size_bytes']
    facts = probe_bytes(data)
    assert (facts.format, facts.size_bytes, facts.sample_rate, facts.channels,
            facts.bits_per_sample, facts.frames) == ('WAV', 144044, 48000, 1, 16, 72000)
    assert facts.exact_pcm_milliseconds == REFERENCE['duration_ms']
    assert facts.pcm_milliseconds_are_exact and facts.pcm_millisecond_remainder == 0
    assert facts.chunks == ('fmt ', 'data')
    assert facts.chunk_spans == (('fmt ', 20, 16), ('data', 44, 144000))
    assert not facts.embedded_metadata_present and not facts.artwork_possible


@pytest.mark.parametrize('tag,metadata,artwork,unknown', [
    (b'LIST', True, False, False), (b'ID3 ', True, True, False),
    (b'CSET', True, False, False),
    # Coordinator amendment, 2026-09-11 (decision D4/D5). An unlisted chunk is an
    # undecoded carrier, not proof of bare media: it is absent from the allowlisted
    # carrier tuples but is reported through unknown_chunks, and it must still
    # block a bare-media candidate.
    (b'Zzz1', False, False, True)])
def test_a05_carriers_are_reported_never_decoded_and_never_dropped(tag, metadata, artwork, unknown):
    payload = b'INFOINAM' + struct.pack('<I', 4) + b'abc\0'
    data = wav_bytes(frames=257, extra=((tag, payload),))
    facts = probe_bytes(data)
    name = tag.decode('ascii')
    assert facts.chunks == ('fmt ', 'data', name)
    span = facts.chunk_spans[-1]
    assert span[0] == name and span[2] == len(payload)
    assert data[span[1]:span[1] + span[2]] == payload  # bytes preserved, not decoded
    assert (name in facts.metadata_carriers) is metadata
    assert (name in facts.artwork_carriers) is artwork
    assert (name in facts.unknown_chunks) is unknown
    assert facts.embedded_metadata_present is (metadata or unknown)
    assert facts.artwork_possible is artwork
    conditions = unmet_new_media_conditions(facts)
    assert any('embedded metadata carriers' in c for c in conditions) is (metadata or unknown)
    assert any('artwork carriers' in c for c in conditions) is artwork


def test_a05_chunk_spans_account_for_every_byte():
    data = wav_bytes(frames=257, extra=((b'LIST', b'INFO'), (b'Zzz1', b'\x01\x02\x03')))
    facts = probe_bytes(data)
    total = 12
    for name, offset, length in facts.chunk_spans:
        assert data[offset - 8:offset - 4] == name.encode('ascii')
        assert struct.unpack_from('<I', data, offset - 4)[0] == length
        total += 8 + length + (length % 2)
    assert total == len(data) == facts.size_bytes
    assert 'Zzz1' in facts.chunks and 'Zzz1' not in facts.metadata_carriers


def test_a05_inventory_matches_what_the_constructor_actually_writes():
    from itlkit.construct import WaveRecordBindings, materialize_pcm_wave_record
    data = wav_bytes()
    facts = probe_bytes(data)
    rows = new_track_media_fields(facts)
    bindings = WaveRecordBindings(track_local=101, secondary_local=102, track_pid=0x51A05,
                                  album_local=103, artist_local=104, name_atom=11, kind_atom=12)
    when = datetime(2026, 9, 11, 12, 0, tzinfo=timezone(timedelta(hours=9)))
    record = materialize_pcm_wave_record(
        data, {'name': 'A05 New Media'}, 'C:\\Music\\ITL-G2-PCM-48000-001.wav', bindings,
        date_added=when, date_modified=when, sort_ranks=(0,) * 7)
    raw = record.record_bytes
    assert struct.unpack_from('<I', raw, 0x24)[0] == field(rows, 'size_bytes').value == 144044
    assert struct.unpack_from('<I', raw, 0x144)[0] == field(rows, 'size_bytes').value
    assert struct.unpack_from('<I', raw, 0x28)[0] == field(rows, 'duration_ms').value == 1500
    assert struct.unpack_from('<I', raw, 0x38)[0] == field(rows, 'bitrate_kbps').value == 768
    assert struct.unpack_from('<f', raw, 0x98)[0] == float(field(rows, 'sample_rate_hz').value)
    assert struct.unpack_from('<Q', raw, 0xf4)[0] == field(rows, 'pcm_frames').value == 72000
    assert struct.unpack_from('<I', raw, 0x8c)[0] == recipe_format_code(facts)
    assert field(rows, 'format_code').value == recipe_format_code(facts)
    assert recipe_kind_text(facts).encode('ascii') in raw
    assert field(rows, 'kind_text').value == recipe_kind_text(facts) == 'WAV audio file'
    assert record.media_sha256 == field(rows, 'media_sha256').value
    # The two recipe constants are the only record values the media cannot prove.
    assert {row.field for row in rows if row.status == 'recipe_constant_unverified'} == {
        'format_code', 'kind_text'}


def test_a05_no_cross_family_recipe_fallback():
    facts = probe_bytes(aiff_bytes())
    with pytest.raises(MediaError, match='no recipe Kind text'):
        recipe_kind_text(facts)
    with pytest.raises(MediaError, match='no recipe format code'):
        recipe_format_code(facts)
    rows = new_track_media_fields(facts)
    assert field(rows, 'kind_text').value is None and field(rows, 'format_code').value is None
    assert any(c.startswith('family:') for c in unmet_new_media_conditions(facts))


@pytest.mark.parametrize('kwargs,needle', [
    ({'channels': 2}, 'channels:'), ({'bits': 24}, 'bit depth:'), ({'rate': 22050}, 'sample rate:')])
def test_a05_unqualified_pcm_dimensions_are_listed(kwargs, needle):
    conditions = unmet_new_media_conditions(probe_bytes(wav_bytes(frames=1000, **kwargs)))
    assert any(c.startswith(needle) for c in conditions)


def test_a05_unmet_conditions_name_every_open_gap(tmp_path):
    data = wav_bytes()
    path = tmp_path / 'ITL-G2-PCM-48000-001.wav'
    path.write_bytes(data)
    observation = probe_file(path, expected_size=len(data))
    rows = new_track_media_fields(observation.facts, observation)
    assert all(row.status in FIELD_STATUSES for row in rows)
    assert field(rows, 'date_modified').value == observation.mtime_ns
    assert field(rows, 'date_modified').status == 'caller_supplied'
    assert field(rows, 'location_path').value == str(path)
    assert field(rows, 'date_added').status == 'absent_from_itlkit'
    open_gaps = {row.field for row in rows if row.status != 'derived_exact'}
    assert open_gaps == {'format_code', 'kind_text', 'date_modified', 'date_added',
                         'location_path', 'location_url', 'name', 'tag_metadata', 'artwork'}
    conditions = unmet_new_media_conditions(observation.facts, observation)
    assert len(conditions) == len(open_gaps)
    assert not any(c.startswith('file identity:') for c in conditions)
    assert any(c.startswith('file identity:') for c in
               unmet_new_media_conditions(observation.facts))


def test_a05_additions_do_not_change_existing_facts_or_gates(tmp_path):
    from dataclasses import FrozenInstanceError
    from itlkit.schema import ReadLimits
    data = wav_bytes(frames=257)
    path = tmp_path / 'small.wav'
    path.write_bytes(data)
    facts = probe_bytes(data)
    assert probe_file(path).facts == facts
    assert facts.exact_pcm_milliseconds == 257 * 1000 // 48000 == 5
    assert not facts.pcm_milliseconds_are_exact
    assert facts.pcm_millisecond_remainder == 257 * 1000 % 48000
    assert any(c.startswith('duration:') for c in unmet_new_media_conditions(facts))
    with pytest.raises(FrozenInstanceError):
        facts.chunk_spans = ()
    with pytest.raises(MediaError, match='memory budget'):
        new_track_media_fields(facts, limits=ReadLimits(memory_budget_bytes=1))
    with pytest.raises(MediaError, match='memory budget'):
        unmet_new_media_conditions(facts, limits={'memory_budget_bytes': 1})
    with pytest.raises(MediaError, match='typed MediaFacts required'):
        new_track_media_fields({'format': 'WAV'})
    with pytest.raises(MediaError, match='typed FileObservation required'):
        new_track_media_fields(facts, object())
