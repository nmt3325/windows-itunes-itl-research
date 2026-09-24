# Bounded U-17 Linux process-termination campaign

This directory retains a deterministic, scratch-only follow-on for `itlkit.io.write_new` at repository baseline `c9f271d36a7095262c6195c04eb7f09d6cf88dee`. The production implementation was used unchanged. The campaign launched no iTunes process, used no user data, changed no production file, performed zero power-loss operations, and performed zero native iTunes operations.

## Scope and accounting

The retained campaign has **five case scenarios**:

| Class | Scenarios | Process outcome |
| --- | ---: | --- |
| Actual process crash | 4 | The parent received the named boundary event, confirmed that the child was alive, sent `SIGKILL`, and reaped return code `-9` |
| Normal completion control | 1 | A separate child called unmodified `write_new` without scheduling hooks, returned normally, and was reaped with return code `0` |

Cases, the control, test replays, and retained files are not independent experiments. The report records five child processes, four actual `SIGKILL` operations, five parent reaps, five Linux `mkstemp` creations, one partial-prefix flush, three complete-payload file `fsync` operations, two hard-link commits, one completed production cleanup unlink, zero power-loss operations, zero network-filesystem operations, and zero native iTunes operations.

## Crash mechanics versus scheduling hooks

Each child inherited one event-pipe descriptor. The parent waited at most 15 seconds for one atomic JSON event and allowed at most 10 seconds to reap the child. The event contains no PID or random temporary name.

The four hooks only position the child at explicit boundaries:

1. an `os.fdopen` wrapper pauses after native `mkstemp` creation and before any payload write;
2. a stream wrapper performs a real 4,097-byte prefix write and real flush, then pauses inside the production `stream.write` call;
3. an `os.link` wrapper pauses before the native link after production write, flush, file `fsync`, and close have completed;
4. an `os.link` wrapper performs the native hard-link commit, then pauses before returning to production cleanup.

The normal control uses no hook. The parent, not the child, performs and proves every crash termination. A Python exception or ordinary nonzero exit is not counted as a crash.

## Exact retained environment

The retained report records the observation environment rather than generalizing beyond it:

- Linux `6.17.0-1022-azure`, x86-64, glibc 2.39;
- CPython 3.12.3 with optimization disabled;
- the local `/tmp` root on ext4 (magic `ef53`), 4,096-byte blocks/fragments;
- mount options `rw,relatime,discard,journal_async_commit,nobarrier,errors=remount-ro,commit=30,data=writeback`.

A byte-exact report replay requires those recorded environment fields. The focused test also compares two fresh roots directly and compares the retained behavioral body independently of the environment envelope.

## Synthetic inputs and observed outcomes

The complete synthetic payload is 79,876 bytes with SHA-256 `3c39b3a05a4be268cda3c6b92a926ac96329b6bcda31b05b66e43e2d9bb14e8e`. Its 4,097-byte partial prefix has SHA-256 `e9209535f1ee8f9970f4e005fd0be640ec1fa6371ff5fdf4ca65955c93f772c4`. The empty-file SHA-256 is `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

| Stage | Termination proof | Destination after reap | Temporary after reap | Link/inode result |
| --- | --- | --- | --- | --- |
| After temporary creation, before write | `SIGKILL`, `-9`, reaped | absent | 0 bytes, empty SHA-256 | one link; one child FD at boundary |
| After partial write and flush | `SIGKILL`, `-9`, reaped | absent | 4,097-byte prefix, prefix SHA-256 | one link; one child FD at boundary |
| After complete flush/fsync/close, before link | `SIGKILL`, `-9`, reaped | absent | 79,876-byte complete payload | one link; zero child FDs to the temporary at boundary |
| After native hard-link commit, before cleanup | `SIGKILL`, `-9`, reaped | complete payload | complete payload | destination and temporary are the same inode; each reports link count two |
| Normal control | exit `0`, reaped | complete payload | none | destination link count one |

All regular files observed in the retained outcome had mode `-rw-------`. The crash cases retain the sibling temporary because `SIGKILL` prevents the child from executing `write_new`'s `finally` cleanup. After measurement, the generator removes the complete disposable scratch root and verifies that it is gone. The normalized report retains no scratch path, PID, inode number, device number, or random temporary basename.

## Reproduction

Use a fresh path below `/tmp`; the generator refuses relative, existing, or outside-`/tmp` roots. Keep the output outside the disposable root.

```bash
rm -rf /tmp/itl-u17-process-crash-replay /tmp/itl-u17-process-crash-replay.json
PYTHONDONTWRITEBYTECODE=1 PYTHONIOENCODING=utf-8 \
  python -B scripts/research/audit_filesystem_process_crash_20260925.py \
  --scratch-root /tmp/itl-u17-process-crash-replay \
  --output /tmp/itl-u17-process-crash-replay.json
cmp /tmp/itl-u17-process-crash-replay.json \
  evidence/research/20260925/filesystem-process-crash/report.json
sha256sum /tmp/itl-u17-process-crash-replay.json
```

Expected report SHA-256 on the recorded environment:

```text
9ab1d5c69379e27319bc7b817639f8c7179ae402770de3f860b40c103da7e525
```

Pinned source hashes:

- generator: `a902293a363ec02237290947113e3d0b212bbc553910f752a97538b3902c7a41`;
- production `itlkit/io.py`: `f042b3d98a71cfedf9cfd39fdd0d4acf5bacedd623dbc07d9d1d8bb54292a6f4`.

Focused regression (two fresh-root replays occur inside the new test):

```bash
rm -rf /tmp/itl-u17-process-crash-pytest
PYTHONDONTWRITEBYTECODE=1 PYTHONIOENCODING=utf-8 \
  python -B -m pytest \
  tests/test_filesystem_process_crash_20260925.py \
  tests/test_codec_output_atomic.py \
  tests/test_filesystem_threat_model_20260925.py \
  -q -rs -p no:cacheprovider \
  --basetemp /tmp/itl-u17-process-crash-pytest
```

## Claim boundary and integration recommendation

These results narrow only the five selected schedules on the recorded Linux runtime and local ext4 filesystem. They do **not** establish power-loss behavior, directory-entry durability, hostile-directory safety, network-filesystem behavior, Windows parity, universal atomicity, or native iTunes acceptance. Hooks position the listed boundaries; they do not prove arbitrary-schedule coverage. File `fsync` observations are not power-loss evidence.

Integrate the generator, normalized report, tests, and bounded documentation as research-only evidence. Do not change production `itlkit/` on these observations. Keep U-17 open for actual power-loss work and broader filesystem/runtime matrices.
