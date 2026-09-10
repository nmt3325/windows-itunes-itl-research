# Read-only playlist title diagnostics

Playlist.to_dict and inspect now report an unsupported, duplicated or malformed playlist title under field_errors.name, without suppressing readable tracks or other playlists. The undecodable name key is omitted. A supported empty string and an absent title remain distinct from an undecodable title.

This changes read-only presentation, not format validation or write admission. Direct name access and unsafe rename still raise. Original bytes and library.v1 raw/JSON no-op roundtrips are preserved. No replacement decoding or automatic repair was added.

The new12 synthetic regression cases cover unknown encoding, invalid UTF-16, overdeclared string length, duplicate title, valid/empty/missing name, CLI behavior, unsafe-rename refusal and unchanged bytes. Before the fix:5 failures/7 passes. After the fix, all12 plus the historical suite pass:988 passed,5 skipped for absent historical COM oracles. This was not a new native write experiment.

Run: python -B -m pytest tests/test_inspection_diagnostics.py -q -p no:cacheprovider

The historical sample_rate getter at offset0xf4 was separately found to be mislabeled for1.25-second48000-Hz media. It was not changed in the original presentation-only commit. The subsequent independently checked correction and its distinct qualification limits are documented in sample-rate.md.
