# EXP-03 - native acceptance of an itlkit-built playlist

Real iTunes 12.13.11.1 on Windows, 2026-09-11. Declared before any modification; see `exp03-declaration.json`.
The version gate was bypassed by `research/g4/exp03/gate_bypass.py`; every other itlkit precondition was enforced.
Results here are a probe, not an authoritative licence to widen itlkit accepted profiles.

| stage | bytes | sha256 |
| --- | ---: | --- |
| input, preserved live library (native-written) | 4524 | `19d088455f692cc86f3d4f70c5fc74fd039d1efca0ce22f80f25547b8b876dcb` |
| candidate built by itlkit with the version gate bypassed | 3520 | `109a09644c3a27d3a297f004c4c6cc9874c06974a16c153fa95ebfb7122406c6` |
| left behind after open + normal Quit | 4709 | `125b6fafc76327fe59cd8a13376930bdacb6c6bb7084aed4d3d05f5b37a81ade` |
| left behind after restart 1 | 4709 | `e4b1fdb50835a577ecb808e2b5dc4cb66ed21be4f8c74769fe1eb4f7790e4cd1` |
| left behind after restart 2 | 4709 | `9810e3318ca7ee03b32cf7f6819127674a1d65cdb6007c5ea1c2f5e60773fea2` |

COM enumerated 8 playlists in all three sessions: the 7 the application always creates, plus `exp03-itlkit-playlist` (kind=2, special=0, 1 track).
No damaged-file dialog appeared, the library directory stayed at 5 files, and every session ended in a normal COM Quit.
The three files the application left behind have three different digests despite identical semantics, which is why byte identity is not an acceptance criterion.
The preserved baseline library was restored afterwards.
