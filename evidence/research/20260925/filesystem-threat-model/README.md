# Bounded U-17 filesystem publication threat-model audit

This directory retains a deterministic, offline Linux audit of `itlkit.io.write_new` at production baseline `bc31fd860576b25f47ff1c3f409a9d97b04114fb`. The production implementation was not changed.

## Scope and accounting

The campaign contains **21 case scenarios**, not 21 independent experiments:

| Class | Scenarios | What the class means |
| --- | ---: | --- |
| Direct native filesystem | 8 | Unmodified production calls on one fresh `/tmp` scratch filesystem |
| Scheduler-assisted native syscall | 5 | A Python hook fixes the interleaving; the reported rename, symlink, mkdir, write, and link outcomes use real Linux syscalls |
| Fault injection | 8 | One documented I/O boundary is substituted to characterize error handling; this is not hostile-filesystem evidence |

Repeated paths, controls, and two-publisher participants are not independent experiments. The campaign launched no iTunes process, crashed no process, simulated no power loss, and made no hostile-directory safety claim. Every exercised object was below a new `/tmp` root; the CLI removed that root after each run. The retained JSON contains no timestamps, runner paths, random temporary names, kernel version, or filesystem label.

## Cases covered

- new destination publication;
- existing regular file, hard-link alias, symlink, and dangling symlink refusal;
- stable parent symlink and lexical `..` parent alias;
- missing parent refusal;
- destination creation immediately before the native hard-link commit;
- two publishers synchronized at the native hard-link commit;
- partial write exception, short write, flush, file `fsync`, close, and hard-link refusal;
- cleanup failure before and after publication;
- parent-directory rename without replacement;
- parent-directory rename/replacement with a spoofed temporary basename;
- parent-symlink retargeting with a spoofed temporary basename.

## Observed guarantees in the bounded stable-directory model

1. Existing destinations and aliases were not replaced. A destination created after the initial `lexists` check but before `link` won; the production call returned `EEXIST` and removed its own temporary file.
2. Two synchronized publishers produced one complete winner and one `EEXIST` refusal. The destination was exactly one payload, never a merge.
3. Injected write, short-write, flush, file-`fsync`, close, and hard-link failures happened before publication and left no destination when normal cleanup succeeded. Hard-link refusal did not fall back to replacement rename.
4. A pre-publication cleanup failure retained the primary `ENOSPC` error and added a cleanup note. A post-publication cleanup failure raised an explicit “complete output was published” error while leaving the complete destination and its temporary hard link.
5. A stable parent symlink and a lexical parent alias resolved to one complete destination in their bounded direct cases.

Fault injection supports only the listed control-flow boundaries. It is not evidence that every real filesystem produces those failures in the same way.

## Explicit limits witnessed

The production module already states that it is not safe against a hostile destination-directory owner. The campaign produced deterministic witnesses for that boundary:

- If the parent was renamed away before `link`, publication failed with `ENOENT` and the already complete temporary file remained in the displaced directory.
- If the parent pathname was replaced and the random temporary basename was spoofed, `write_new` returned successfully while the replacement directory’s destination contained the spoof bytes; the requested complete temporary remained in the displaced directory.
- Retargeting a parent symlink and spoofing the temporary basename produced the same bounded result.

Those schedules were positioned with hooks around the production `os.link` call. The directory operations and final link were real Linux syscalls, but the result does **not** prove coverage of arbitrary adversarial schedules. It confirms the existing requirement that parent directories remain trusted and stable.

The implementation file-fsyncs the temporary but does not fsync the parent directory. This campaign did not cut power or kill a process and therefore provides no power-loss or directory-entry durability evidence. Network filesystems, mounts with unusual hard-link behavior, alternate kernels/runtimes, and Windows were not tested.

## Reproduction

Use the pinned Python/dependency environment documented at repository root. The scratch root must not already exist.

```bash
rm -rf /tmp/itl-u17-filesystem-replay /tmp/itl-u17-filesystem-replay.json
PYTHONDONTWRITEBYTECODE=1 PYTHONIOENCODING=utf-8 \
  python -B scripts/research/audit_filesystem_publication_20260925.py \
  --scratch-root /tmp/itl-u17-filesystem-replay \
  --output /tmp/itl-u17-filesystem-replay.json
cmp /tmp/itl-u17-filesystem-replay.json \
  evidence/research/20260925/filesystem-threat-model/report.json
sha256sum /tmp/itl-u17-filesystem-replay.json
```

Expected report SHA-256:

```text
20309694a41d6bce7b285d002b21cdd2b9c7bb51a258161e535e37ab95bd99bc
```

Focused regression:

```bash
PYTHONDONTWRITEBYTECODE=1 PYTHONIOENCODING=utf-8 \
  python -B -m pytest \
  tests/test_codec_output_atomic.py \
  tests/test_filesystem_threat_model_20260925.py \
  -q -rs -p no:cacheprovider \
  --basetemp /tmp/itl-u17-filesystem-pytest
```

## Integration recommendation

Integrate the generator, retained report, focused regression, and bounded documentation. Keep the trusted/stable-parent and power-loss disclaimers unchanged. No production change is justified by these observations because the in-model cases behave as documented and the parent-swap witnesses fall inside the already documented hostile-directory exclusion. U-17 remains open: process-crash/power-loss testing, broader filesystems/runtimes, and broader parser/fault campaigns are still missing.
