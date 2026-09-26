# Atlas C-hash history audit (2026-09-26)

This deterministic U-18 negative-result audit compares all 47 retained `function-atlas.json` C hashes with current public C bytes, the C bytes at the atlas introduction commit, and every reachable Git blob whose path is under `evidence/static/decompiled/*.c`.

Result: `0/47` match in all three scopes. No expected atlas C hash is present in a reachable decompiled-C blob, so the historically hashed C bytes remain unavailable. This does not reconstruct those bytes, replay Ghidra/Unicorn, read a proprietary binary, establish native acceptance, or close U-18.
