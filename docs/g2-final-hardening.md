# Final G2 source checkpoint — full read/write remains incomplete

The tested library source is `612167a45148b230c90bdeeb76a55c12063ec16f`.
Parent regression: **2125 passed, 6 skipped, 36 separate subtests**; 4 pytest XML-format warnings. All prior case identities and 116 input SHA/size/mtime pins were retained. Source and tests were not weakened after the code freeze.

## Changes actually integrated
- Shared reader: admission before opening, opened-size-plus-one reads, descriptor/path identity checks and conservative pre-inflate caps.
- JSON: keys as well as values counted before encoding; controlled refusal for oversized data.
- Constructor facade: actual PCM is transported as a distinct resource and independently re-probed against the declaration. Combined budgets are partitioned before work.
- All full constructor candidates still return blocked. This does not implement actual reservations, complete pool/master/system closure, or independent writer acceptance.

## Separately preserved, not native-certified
The guard proposal is on `proposals/itl-20260910-g2-native-guard`, fixed at `aa6940d02c770ec73bd444df2f449bd02acb4b3e`. Owner offline checks: 45/45 expected outcomes, 86 original checks passed and 1 held. It is **not merged into the library**, not independently executed by the parent and not a native success certificate. Its source was fixed before the code freeze; the commit receipt is 08:15:52Z. Native execution deadlines and authorization guards are retained; do not run it in a personal library.

A genuinely new tagless 48000-Hz mono16 PCM, 72000 frames / 1500 ms, is preserved with its measured SHA and original mtime. It was **not imported into iTunes**. The 30-check discovery contract is preparation only: the Windows backend remains unbound and authorization stayed false. No G2 native action was performed. Earlier successful native cases remain historical, not tests of these new sources.

## Remaining work
Actual constructor reservations and SourceBinding/Name/Kind registration; auxiliary/items/history and unknown pool closure; automatic safe entry-point admission; complete system/smart/folder semantics; new independent writer save/exit/restart validation; playback. Three original codec test revisions remain missing. Admission estimates are not OS RSS guarantees or filesystem locks.

See `g2-hardening-status.md` and `continuation-g2-checkpoint.md` for explicitly historical checkpoints; their older status statements do not override this newer fixed result.
