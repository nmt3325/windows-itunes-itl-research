# U-17 filesystem process-crash ext4/tmpfs contrast (2026-09-26)

This research-only follow-up reruns the selected 2026-09-25 Linux `write_new` process-termination schedules on two local filesystems in the same runner:

- `ext4_tmp`: the filesystem backing `/tmp` (`ext4`, magic `ef53` in the retained report)
- `tmpfs_dev_shm`: the tmpfs mounted at `/dev/shm` (`tmpfs`, magic `1021994` in the retained report)

The generator is [`scripts/research/audit_filesystem_process_crash_tmpfs_ext4_20260926.py`](../../../../scripts/research/audit_filesystem_process_crash_tmpfs_ext4_20260926.py). It reuses the 2026-09-25 child schedule driver [`scripts/research/audit_filesystem_process_crash_20260925.py`](../../../../scripts/research/audit_filesystem_process_crash_20260925.py), so production [`itlkit/io.py`](../../../../itlkit/io.py) remains unchanged.

## Retained result

- Report: [`report.json`](report.json)
- Report SHA-256: `83735369d68e3b7c3f4faf0a78ad16ef7361f17c3a8db5b443aa274c7ebe25a1`
- Generator SHA-256: `462197f4c0fee499276c3c312bf9fa5fb2ff9cb1e07880511f7fe9c0e9478c33`
- Regression test: [`tests/test_filesystem_process_crash_tmpfs_ext4_20260926.py`](../../../../tests/test_filesystem_process_crash_tmpfs_ext4_20260926.py)

The retained aggregate has 10 case scenarios: four parent-issued/reaped `SIGKILL` schedules plus one normal control on each filesystem. It records 8 actual `SIGKILL` operations, 2 normal controls, 10 child processes, 10 `mkstemp` creations, 6 complete-payload file `fsync` completions, 4 hard-link commits, and 2 production cleanup unlinks. The ext4 and tmpfs normalized case sequences and outcome fingerprints match.

## Boundary

This is a filesystem/runtime contrast only. It is not power-loss evidence, not directory-entry durability evidence, not a hostile-directory or network-filesystem result, not a Windows/NTFS generalization, and not native iTunes acceptance. Cases, controls, replays, and retained artifacts are not counted as independent experiments. U-17 remains open.

Focused verification used:

```bash
python -B -m pytest tests/test_filesystem_process_crash_tmpfs_ext4_20260926.py -q -rs -p no:cacheprovider --basetemp /tmp/itl-u17-tmpfs-ext4-tests
```

Result: `4 passed`.
