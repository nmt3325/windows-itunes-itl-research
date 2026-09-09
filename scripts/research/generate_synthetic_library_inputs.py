"""Generate disposable synthetic WAVs plus native iTunes metadata.
Native import is a separate step. Measure compressed ITL size after saving;
large input size does not prove the encryption boundary was exercised.
"""
import argparse
import hashlib
import json
from pathlib import Path
import random
import string
import struct
import wave


def generate(destination, count=768, seed=24601):
    if not 1 <= count <= 4096:
        raise ValueError('count must be in 1..4096')
    destination.mkdir(parents=True, exist_ok=False)
    rng = random.Random(seed)
    alphabet = string.ascii_letters + string.digits
    tracks = []
    for i in range(count):
        stem = f'Synth-{i+1:04d}-' + ''.join(rng.choice(alphabet) for _ in range(42))
        filename = stem + '.wav'
        pcm = bytearray(16000)
        struct.pack_into('<Q', pcm, 0, i+1)
        path = destination / filename
        with wave.open(str(path), 'wb') as out:
            out.setnchannels(1)
            out.setsampwidth(2)
            out.setframerate(8000)
            out.writeframes(pcm)
        tracks.append({'filename': filename,
                       'input_sha256': hashlib.sha256(path.read_bytes()).hexdigest(),
                       'name': stem,
                       'artist': f'Synthetic Artist {i % 8:02d}',
                       'album': f'Synthetic Album {i % 16:02d}',
                       'album_artist': f'Synthetic Ensemble {i % 4:02d}',
                       'comment': ''.join(rng.choice(alphabet) for _ in range(240))})
    result = {'generator_version': 1, 'seed': seed, 'track_count': count,
              'purpose': 'native encryption boundary and shared-index fixtures',
              'note': 'Native metadata edits may change generated WAV tags.',
              'tracks': tracks}
    manifest = destination / 'manifest.json'
    manifest.write_text(json.dumps(result, ensure_ascii=True, indent=2)+'\n', encoding='utf-8')
    return {'track_count': count,
            'media_bytes': sum((destination/r['filename']).stat().st_size for r in tracks),
            'manifest_sha256': hashlib.sha256(manifest.read_bytes()).hexdigest(),
            'artist_groups': len({r['artist'] for r in tracks}),
            'album_groups': len({r['album'] for r in tracks}),
            'album_artist_groups': len({r['album_artist'] for r in tracks}),
            'native_import_status': 'not performed'}


if __name__ == '__main__':
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('destination', type=Path)
    ap.add_argument('--count', type=int, default=768)
    ap.add_argument('--seed', type=int, default=24601)
    args = ap.parse_args()
    print(json.dumps(generate(args.destination, args.count, args.seed), indent=2))
