# Pre-native UTF-8 harness failure

This directory is retained negative **harness evidence**, not an iTunes rejection of either three-track candidate.

The first attempt failed in candidate preflight before profile-junction creation or iTunes launch. The independent parser emitted Unicode JSON, while the harness subprocess text path relied on the Windows code page; the raw case reached `json.loads(None)` after the failed decode path, and the compressed case then reported a misleading manifest mismatch. `summary.json` therefore records zero passed cases and no native cycles.

The harness now launches the parser with Python UTF-8 mode and decodes stdout as strict UTF-8. An offline regression covers Japanese text, emoji, and decomposed Unicode. The retry used fresh root/evidence paths under [`../reference-multi-track-20260922-v2/`](../reference-multi-track-20260922-v2/) and both exact candidates passed two native cycles.

Do not count this directory as a native failure, pass, or cycle. Preserve it as evidence that Unicode harness failures are fail-closed and are not silently reclassified as product behavior.
