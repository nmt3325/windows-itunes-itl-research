# Current Windows replay dependency profile (2026-09-26)

This profile pins current Windows x86-64 / CPython 3.12 wheels for Capstone, pefile, PyCryptodome, and Unicorn by exact version and SHA-256. The four wheels were downloaded only to `/tmp`, hashed, and not retained.

Use `scripts/static/current-replay-requirements-win-py312.txt` with pip hash checking. This is a new current profile, not a claim that Capstone 5.0.9 or pefile 2024.8.26 were used historically. It does not stage iTunes, Ghidra, or a Ghidra project, does not perform binary replay or native acceptance, and does not close U-18.

A clean Windows Server 2025 / CPython 3.12.10 runner completed a hash-checked install, four Python `--help` checks, and PowerShell parsing. Distribution metadata matched all four pins. Capstone's installed distribution reports `5.0.9` while `capstone.__version__` reports `5.0.7`; the receipt preserves this upstream metadata/module discrepancy rather than normalizing it away. No proprietary binary, Ghidra, Unicorn emulation, iTunes, or native acceptance operation occurred.

On the same runner, MinGW built a fresh x64 PE fixture in temporary storage and the parameterized `pe_probe.py` completed against it, scanning 2,008 instructions and writing all four expected report files. The fixture was not retained and was not iTunes; this validates current path/dependency plumbing only, not historical analysis or native acceptance.

The pinned Ghidra 12.1.3 archive and JDK 21 were then used with a temporary Ghidra project containing the same synthetic PE under the project name `iTunes.exe`. With `-CookieRva none`, the parameterized PowerShell/Java path decompiled one synthetic target successfully and produced `summary.tsv` plus one C file. Ghidra also read nine proprietary Windows/JDK host-system libraries while resolving imports; the receipt records those reads explicitly. It read or launched no Apple iTunes binary, recreated no historical Ghidra project, performed no Unicorn emulation or native acceptance, and does not close U-18.

Finally, `bootstrap-current-replay.ps1` repeated the synthetic import and one-target decompilation from a fresh project directory. This closes the current-profile project-bootstrap plumbing gap only; it does not recreate the historical project or supply lawful Apple iTunes input.
