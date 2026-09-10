# ITL4 synthetic media corpus (2026-09-10)

No iTunes, COM, UI, Frida, original media or production ITL writer is used.
Only this new source prefix may be committed. Run on the assigned Windows
worktree with read-only prepared Python + mutagen 1.47.0. No pip/global install.

## Approved initial corpus

Use `ROOT/fixtures/media4/initial-02`, never the preserved failed
`initial-01` or `reports/media/pilot-01`. The approved corpus is read-only and
sealed; all new cases and reproductions require a fresh destination directory.
Copy media to a disposable dynamic-owned location for native work; verify the
original SHA256 before/after copying. Do not retag the sealed files.

20 files = WAV/AIFF/MP3/AAC-LC/ALAC x ASCII, Latin1, Unicode, absent user tags.
Each source is mono PCM16 at 48 kHz, 60,000 frames (1.25 s). Integer triangle
wave with deterministic phase/amplitude and 240-frame fade; no random library
state. `matrix.json` declares seeds, signal parameters, fixed file mtime, tags
and filename cases. All file-only names differ from embedded titles.

Fields: title, artist, album, album_artist, genre, comment, composer, year,
track_number/total, disc_number/total. Within each nonempty profile, artist,
album, album_artist and genre are repeated across formats to expose native
shared-index behavior. Native IDs/index sharing are not inferred from strings.
Unicode includes Japanese, Greek and a non-BMP music symbol. Paths include
spaces, literal percent, `%25`, Japanese, `#`, `&`, brackets and Latin1 text.
The absent profile omits embedded user tags: explicit-empty versus absent is
not claimed equivalent or covered as a distinct initial condition.

ID3v2.3 is used for WAV/AIFF/MP3 (including WAVE/AIFF ID3 chunks); MP4 ilst
atoms for AAC/ALAC. Mutagen writes and reopens the tags; ffprobe independently
checks all normalized fields. Native support for those container/tag choices
is unmeasured. Mutagen converts the v2.3 numeric year to an ASCII TDRC object
on load; the Unicode text frames remain UTF-16. AAC decoded padding and
container/source/decoded duration are recorded separately.

## Optimization is unsupported

Do not use `-O`, `-OO`, or `PYTHONOPTIMIZE=1/2`. All three entry modules
refuse optimized execution/import before imports or operational I/O. Safety
assertions remain active in supported normal execution; key hash, scope and
seal checks additionally use explicit exceptions. This is preventive hardening,
not evidence that an unverified binary was executed.

The old sealed manifests retain the generator SHA from their creation. New
source hashes and unchanged media hashes are recorded separately in phase03;
never update old GeneratorSHA fields to match a later source revision.

`test_optimization.py --root ROOT` writes a new phase03/test-run directory and
checks the refusal matrix plus normal help/read-only verification. It never
reruns `qa.py`/full QA against the existing phase02 directory.

## Run and verify (PowerShell)

Set `$ROOT` to the current parent-issued root, not an archived run path.

```powershell
Set-Location "$ROOT\wt\media"
$PY = "$ROOT\tools\py\Scripts\python.exe"
$env:PYTHONDONTWRITEBYTECODE = '1'
$env:PYTHONUTF8 = '1'
$env:PYTHONIOENCODING = 'utf-8'
$env:OMP_NUM_THREADS = '1'
$env:TEMP = "$ROOT\reports\media\tmp"
$env:TMP = $env:TEMP
# Only if tools/media is unprovisioned, using the existing resolved curl:
& $PY -B -X utf8 scripts/research/media20260910/acquire.py --root $ROOT --curl (Get-Command curl.exe).Source
# Generation: destination MUST NOT EXIST. Use a fresh approved owned name:
& $PY -B -X utf8 scripts/research/media20260910/corpus.py --root $ROOT --destination "$ROOT\reports\media\reproduction-NEW"
# Read-only integrity + current tag check:
& $PY -B -X utf8 scripts/research/media20260910/corpus.py --root $ROOT --destination "$ROOT\fixtures\media4\initial-02" --verify
# Original run audit; phase02 MUST NOT EXIST. Compares initial-02/reproduction-01:
& $PY -B -X utf8 scripts/research/media20260910/qa.py --root $ROOT
```

`acquire.py` verifies the current official/vendor links, current provided
SHA256, historical same-version archive hash and each extracted binary hash
before execution. Only ffmpeg.exe and ffprobe.exe are extracted to
`tools/media`. The archive and executables must never be staged or distributed.
`tools/media/provenance.json` records current URLs, sizes, hashes and versions.

Every codec/decoder/filter/probe runs sequentially with one thread. Each child
has a 30-second timeout and an observed own+child 512 MiB working-set guard.
Per-command argv, exit status, stdout/stderr and measured peak are in `qa/`.
The GHA execution ledger includes the outer command completion/EOF receipts.
No success is inferred from an idle/deadline response.

The second independent generation must match all media bytes, PCM hashes,
tag values and media mtimes; full manifests differ in paths and observation
timestamps by design. `seal.json` hashes the complete artifact set except itself.
Record its own SHA256 externally, and never rebuild it in the sealed folder.

## Handoff boundaries

`reports/media/manifest.json` and `native-requests.json` are exact copies from
the approved initial corpus; `report.json` tracks the current experiment phase.
Failures and old sources are preserved in phase01 and partial directories.
Native donor creation is a discovery oracle, not independent-writer acceptance.
Raw metadata must be captured before setters/UpdateInfoFromFile. iTunes native
recognition, filename fallback, pool identities, restart survival and playback
are measured only by dynamic. Constructor/CRUD acceptance requires a separate
predeclared request with complete old/new identities, locations and memberships.
