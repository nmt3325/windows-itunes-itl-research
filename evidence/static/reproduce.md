# Reproduce the bounded static analysis

Scope: write only `ROOT\tools\static` / `ROOT\reports\static`. Do not execute iTunes, change production source, or manipulate shared environment/worktrees. Use the existing static worktree as absolute cwd. Ghidra is one process at a time. Commands below are manual reproduction steps, not automatically scheduled actions.

```powershell
$root='<ITL_ROOT>'
Set-Location "$root\wt\static"
$py="$root\tools\py\Scripts\python.exe"
$env:PYTHONDONTWRITEBYTECODE='1'
$env:GIT_OPTIONAL_LOCKS='0'
Get-FileHash 'C:\Program Files\iTunes\iTunes.exe' -Algorithm SHA256
# Required SHA256: 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
```

## Installed toolchain

- Official Ghidra asset: https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_12.1.3_build/ghidra_12.1.3_PUBLIC_20260817.zip
- Archive SHA256: `93a5d11a9ad510622acaaf908c556a7b9b764d338e78a7567f3689bf5081fd54`
- Archive bytes: 569445154
- Ghidra root: `ROOT\tools\static\ghidra\ghidra_12.1.3_PUBLIC`
- JDK: `C:\hostedtoolcache\windows\Java_Temurin-Hotspot_jdk\21.0.12-101.0\x64`
- Python libraries pefile/capstone/PyCryptodome: supplied shared Python, read/execute only.
- Unicorn2.1.4: installed with `pip --target ROOT\tools\static\pylibs --no-cache-dir --no-compile`; shared Python was not modified.

## Evidence generation

```powershell
& $py "$root\tools\static\pe_probe.py"       # full PE/pdata/xref scan, not full decompilation
& $py "$root\tools\static\prepare_targets.py" # chained unwind groups / initial targets
& $py "$root\tools\static\rebuild_targets.py" # exact final 47 targets + 2 verified leaf ranges + ASM
```

`rebuild_targets.py` contains the literal final target list and supplements the unwind-only JSON with ranges `[0x1068f90,0x10690cf)` and `[0x106a520,0x106a559)`. The JSON remains unwind-only; TSV includes the supplements. When final C is available it checks and hashes it; before a first decompilation it still generates the target/range/ASM files. Run it again after decompilation to populate the C hashes.

## Process the existing project (executed successfully)

```powershell
& "$root\tools\static\run-headless.ps1"
# -process iTunes.exe -noanalysis -max-cpu 1
# -postScript ITLSelective.java ROOT\reports\static targets-final.txt decompiled
# Required output: ITL_SELECTIVE_DONE success=47 failed=0
# Also verify 47 rows completed=true and nonempty C, not just launcher exit code.
```

The launcher redirects USERPROFILE, APPDATA, LOCALAPPDATA, user.home and java.io.tmpdir under the owned static directories, uses Java21/heap3G, and uses the **isolated** `tools\static\scripts` scriptPath. Never use the parent `tools\static` scriptPath, which also contains the whole Ghidra distribution.

For a new project, use the same isolated environment settings from run-headless.ps1, choose a new project name under tools/static/projects, and replace `-process iTunes.exe` with `-import 'C:\Program Files\iTunes\iTunes.exe'`. Do not import into an existing/busy project or start a second headless process. Original import is already preserved as `ITLStatic.gpr`; no new import is required for reproducing the delivered result.

## Original-machine-code offline tests (executed successfully)

```powershell
$env:PYTHONPATH="$root\tools\static\pylibs"
& $py "$root\tools\static\offline_aes_proof.py"
# offline-emulation.json: success=true, tests=41
```

This does not load/launch a Windows iTunes module or process. Unicorn maps file bytes into its own address space; AES routines run as emulated instructions. The only modeled standard import is PE-verified VCRUNTIME140.dll!memmove. Reader interval tests also model two file-buffer helpers as an in-memory stream. This is not a native application acceptance test.

## Evidence interpretation

- C/ASM file names are module-relative hexadecimal RVAs, not file offsets.
- function-atlas.json contains binary identity, exact function ranges/size basis, ASM paths and C SHA256s.
- Decompiler prototypes are not all recovered; security-cookie fixup corrects an important missing return-value effect. Verify uncertain argument counts with ASM, not inferred C alone.
- Failure records are retained: initial Ghidra script lookup error; first emulator run stopped at an unresolved import after the two AES known-answer tests passed.
- No automatic job/environment/worktree lifecycle actions are included.
