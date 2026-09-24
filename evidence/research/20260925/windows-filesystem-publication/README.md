# Bounded Windows/NTFS filesystem-publication audit

This directory retains a deterministic Windows follow-up for `itlkit.io.write_new` at repository baseline `c9f271d36a7095262c6195c04eb7f09d6cf88dee`. The production implementation was not changed.

## Exact qualification

The retained campaign ran on one GitHub-hosted Windows environment with:

- Microsoft Windows Server 2025, kernel version `10.0.26100`, AMD64;
- CPython `3.12.10` (`os.name == "nt"`, `sys.platform == "win32"`);
- the runner-temporary volume reported as **NTFS** by `GetVolumePathNameW` plus `GetVolumeInformationW`;
- NTFS capability flags for hard links, reparse points, and POSIX-style unlink/rename set on that volume;
- direct probes confirming hard-link, file-symlink, dangling-symlink, directory-symlink, and directory-junction creation.

This is evidence for that exact runner/runtime/temporary volume, not universal Windows or NTFS behavior.

## Scope and accounting

The campaign contains **25 case scenarios**, not 25 independent experiments:

| Class | Executed | Unavailable | Meaning |
| --- | ---: | ---: | --- |
| Direct native filesystem | 9 | 0 | Unmodified production calls on one fresh Windows runner-temporary NTFS root |
| Scheduler-assisted native syscall | 6 | 0 | Python hooks fix the interleaving; the reported rename, reparse-point, directory, write, and final `os.link` operations are real Windows operations |
| Fault injection | 8 | 0 | One documented I/O boundary is substituted to characterize control flow; this is not native failure-frequency or hostile-filesystem evidence |
| Actual process termination | 2 | 0 | The parent observes an explicit boundary, calls Win32 `TerminateProcess`, and reaps the child |

Repeated cases, controls, and the two competing publishers are not independent experiments. The run performed **zero power-loss operations**, **zero native-iTunes operations**, and **zero network-filesystem operations**. It launched no iTunes process and used no COM, UI, media import, native library, or user data.

## Executed matrix

- successful publication to a new destination;
- refusal and preservation of an existing regular file and hard-link alias;
- refusal and preservation of an existing file symlink and dangling symlink (creation was directly available on this runner);
- stable directory-symlink, NTFS-junction, and lexical `..` parent aliases;
- missing-parent refusal;
- destination creation immediately before the real native `os.link` commit;
- two publishers synchronized at their real final `os.link` calls;
- injected partial-write exception, short write, flush, file `fsync`, close, and hard-link refusal;
- injected cleanup failures before and after publication;
- real parent rename without replacement;
- real parent rename/replacement, directory-symlink retarget, and junction retarget schedules with a spoofed temporary basename;
- parent-triggered Win32 `TerminateProcess` after payload fsync/stream close but before the link call;
- parent-triggered Win32 `TerminateProcess` after the real link but before temporary unlink.

## Bounded observations

1. Under the stable-parent model, existing destinations and the available alias types were not replaced. A destination created immediately before the native link won: `os.link` returned `FileExistsError`, `errno=EEXIST`, `winerror=ERROR_ALREADY_EXISTS`, and the production temporary was removed.
2. Two synchronized publishers produced exactly one complete winner and one `EEXIST` refusal. The destination was one payload and never a merge.
3. Injected write, short-write, flush, file-fsync, close, and hard-link failures preceded publication and left no destination when ordinary cleanup succeeded. The injected hard-link refusal did not trigger a replacement-rename fallback.
4. An injected pre-publication cleanup failure retained the primary error and its cleanup note. An injected post-publication cleanup failure reported that a complete output had already been published and left the complete destination plus its temporary hard-link alias.
5. The stable directory symlink, NTFS junction, and lexical parent alias each resolved to one complete destination and left no sibling temporary in their direct cases.
6. Before-link `TerminateProcess` retained one complete temporary and no destination. After-link/before-cleanup `TerminateProcess` retained a complete destination and its complete temporary hard-link alias (`st_nlink == 2`). Both children were reaped with the parent-selected exit code `0x66`.

The termination observations are separate from Linux `SIGKILL` and from power loss. They do not establish directory-entry durability.

## Out-of-model schedules witnessed

After the payload stream had closed, this exact NTFS runner permitted the scheduled parent operations:

- renaming the parent away before link caused `FileNotFoundError`, `errno=ENOENT`, `winerror=ERROR_PATH_NOT_FOUND`, and left the complete temporary in the displaced directory;
- replacing the parent directory and spoofing the random temporary basename let the pathname-based link publish spoof bytes while the requested complete temporary remained in the displaced directory;
- retargeting either the directory symlink or NTFS junction and spoofing the temporary basename produced the same bounded outcome.

These are platform observations and deterministic witnesses for the existing trusted/stable-parent precondition, not a new production defect and not coverage of arbitrary adversarial schedules.

## Explicit claim boundaries

The campaign does **not** claim:

- universal Windows or NTFS behavior;
- hostile-directory safety;
- network-filesystem behavior;
- universal atomicity;
- power-loss safety or directory-entry durability;
- native iTunes acceptance;
- independence of scenarios, repetitions, controls, or competing participants.

U-17 remains open. Real power-loss testing is still absent, broader Windows versions/runtimes/filesystems remain untested, and no native-iTunes operation was performed.

## Reproduction

Run from PowerShell in a pinned Windows environment. The scratch path must not already exist and must be below Python's `tempfile.gettempdir()`:

```powershell
$root = Join-Path ([IO.Path]::GetTempPath()) 'itl-u17-windows-replay'
$out = Join-Path ([IO.Path]::GetTempPath()) 'itl-u17-windows-replay.json'
python -B scripts/research/audit_windows_filesystem_publication_20260925.py `
  --scratch-root $root `
  --output $out
Compare-Object `
  ([IO.File]::ReadAllBytes($out)) `
  ([IO.File]::ReadAllBytes('evidence/research/20260925/windows-filesystem-publication/report.json'))
```

The retained run and a second fresh scratch-root replay were byte-identical.

Expected SHA-256 values:

```text
report.json  82921e322da3ea9edd16afeb439a3f13e60d71cc933e44bfa6ae74b7d6227c6d
generator    e36d23729e7c8844b5d7cf4fad3ed05dec9a70db6a1d7a6d57e59c7bb8948082
```

Focused Windows regression:

```powershell
python -B -m pytest `
  tests/test_codec_output_atomic.py `
  tests/test_windows_filesystem_publication_20260925.py `
  -q -rs -p no:cacheprovider
```

## Integration recommendation

Retain the generator, report, focused regression, and bounded documentation as Windows-specific corroborating evidence. Keep production publication code unchanged, preserve the trusted/stable-parent disclaimer, and keep U-17 open. A platform difference would be evidence to qualify, not automatically a production defect.
