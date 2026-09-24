# Public clean-replay delivery audit — 2026-09-25

## Defect

At base commit `9dc9be906c30172fc8d0ac9550d28cb137e63e42`, all six files below the top-level `windows_itl_research.egg-info/` directory were listed in `DELIVERY-MANIFEST.json`. The directory is ignored by the tracked `*.egg-info/` rule and none of its files is tracked. Consequently:

1. a clean Git clone could not contain the manifest-declared files; and
2. an editable install regenerated tool/version-dependent metadata, after which verification failed (observed first error: `Size mismatch: windows_itl_research.egg-info/PKG-INFO`).

The published delivery inventory was therefore not reproducible from a clean clone. This is a repository bootstrap defect, not a GHA MCP defect.

## Bounded repair

The manifest builder, production verifier, and independent verifier now share one narrow policy:

- exclude the exact case-insensitive **top-level directory** `windows_itl_research.egg-info`;
- reject any manifest entry under that excluded directory;
- continue to include and verify other `*.egg-info` directories;
- continue to include and verify a nested directory with the same name; and
- continue to exclude `.git` and `DELIVERY-MANIFEST.json` as before.

The exclusion is intentionally not a generic `*.egg-info` glob. Editable-install metadata is derived packaging state, while every unrelated or nested file remains part of the exact delivered set.

## Regression gates

```bash
python -m pytest -q tests/test_public_replay_audit_20260925.py
python proposals/test_verify_delivery_strict.py
python -B scripts/research/qa_delivery_verifier.py   scripts/research/verify_delivery.py /tmp/new-delivery-qa
python -B scripts/research/verify_delivery.py
```

A clean public replay should then verify both before and after an editable install performed in a disposable environment:

```bash
git clone https://github.com/nmt3325/windows-itunes-itl-research.git /tmp/itl-clean
cd /tmp/itl-clean
python -B scripts/research/verify_delivery.py
python -m venv /tmp/itl-clean-venv
/tmp/itl-clean-venv/bin/python -m pip install --no-deps -e .
python -B scripts/research/verify_delivery.py
```

The second verification deliberately runs against the source tree after packaging metadata may have been generated there.

## Claim boundary

This repair removes one concrete clean-clone delivery blocker and adds positive/negative regression coverage. It does **not** close U-18: historical static-analysis scripts still have unstaged private/tool-layout dependencies, and complete pinned end-to-end Ghidra/Unicorn replay receipts remain absent.
