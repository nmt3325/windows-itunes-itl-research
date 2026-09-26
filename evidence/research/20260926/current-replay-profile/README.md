# Current Windows replay dependency profile (2026-09-26)

This profile pins current Windows x86-64 / CPython 3.12 wheels for Capstone, pefile, PyCryptodome, and Unicorn by exact version and SHA-256. The four wheels were downloaded only to `/tmp`, hashed, and not retained.

Use `scripts/static/current-replay-requirements-win-py312.txt` with pip hash checking. This is a new current profile, not a claim that Capstone 5.0.9 or pefile 2024.8.26 were used historically. It does not stage iTunes, Ghidra, or a Ghidra project, does not perform binary replay or native acceptance, and does not close U-18.
