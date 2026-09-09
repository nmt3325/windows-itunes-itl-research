# Reproduce static phase2

All remote commands use absolute cwd <ITL_ROOT>\wt\static and PowerShell. No iTunes/COM/UI/attach, production edits, or other-owner scripts.

```powershell
$root='<ITL_ROOT>'
Set-Location "$root\wt\static"
$env:PYTHONIOENCODING='utf-8'
$env:PYTHONDONTWRITEBYTECODE='1'
$env:GIT_OPTIONAL_LOCKS='0'
$py="$root\tools\py\Scripts\python.exe"
& $py -B "$root\reports\static\phase2\census_snapshots.py"
& $py -B "$root\reports\static\phase2\namespace_evidence.py"
& $py -B "$root\reports\static\phase2\object_reference_evidence.py"
```

Census uses the52 pinned paths/hashes in snapshot-manifest.json. Newly arriving files are not silently added. Scripts read originals only, validate bounds and SHA, and write under phase2. No production imports or pycache writes.

Optional decompile replay, only when no headless job is running:

```powershell
& "$root\tools\static\run-headless.ps1" -Targets 'phase2/targets.txt' -Output 'phase2/decompiled' -LogName 'phase2/ghidra-replay'
```

Existing Ghidra12.1.3 project/script; max1 process,CPU1,heap3G,noanalysis,60sec/function. Targets1078140,1078bb0,bfe1f0,bfe500. Require4 real C outputs and completed summary.tsv, not merely launcher exit. ASM/target preparation is in prepare.py and function-atlas.json with exact unwind ranges and EXE SHA.

Do not blindly replay freeze_and_check.py (one-time cohort/bootstrap edit), original rebuild_targets.py or original build_final_report.py. Preserve original47 outputs and audit. Final checks are recorded in finalize.py and final-qa.json; completion status is stamped only after exit/EOF. Ghidra reuses the already-owned project/cache under tools/static; new analysis outputs are in phase2.
