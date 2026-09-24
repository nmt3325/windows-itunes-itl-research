# Retained PlayedDate / timezone audit (2026-09-25)

## Result

A second checked-in parser reproduced the selected date fields in all eight retained case snapshots. Cases 031–034 share raw `play_date=3851325296`; the Eastern aware-input case converted `2026-01-15T17:34:56+00:00` to displayed `12:34:56` before that same wall-tuple scalar was stored. The retained DST-gap input `02:30` read back and serialized as `03:30` (`3855785400`).

The second-parser 032→033 snapshot comparison also finds all 23 `date_modified` values shifted by exactly -14,400 seconds, no `date_added` or `skip_date` changes, and one target `play_date` set. This is a bounded observation; it does not establish the cause.

| case | zone | input | outcome | COM readback | stored play_date | selected date-field transition |
|---|---|---|---|---|---:|---|
| `031-set-date-naive-utc` | UTC | `2026-01-15T12:34:56` | accepted | `2026-01-15T12:34:56+00:00` | 3851325296 | {'play_date': 1} |
| `032-set-date-aware-utc` | UTC | `2026-01-15T12:34:56+00:00` | accepted | `2026-01-15T12:34:56+00:00` | 3851325296 | {'play_date': 1} |
| `033-set-date-naive-eastern` | Eastern Standard Time | `2026-01-15T12:34:56` | accepted | `2026-01-15T12:34:56+00:00` | 3851325296 | {'date_modified': 23, 'play_date': 1} |
| `034-set-date-aware-instant` | Eastern Standard Time | `2026-01-15T17:34:56+00:00` | accepted | `2026-01-15T12:34:56+00:00` | 3851325296 | {'play_date': 1} |
| `035-set-date-fold` | Eastern Standard Time | `2026-11-01T01:30:00` | accepted | `2026-11-01T01:30:00+00:00` | 3876341400 | {'play_date': 1} |
| `036-set-date-gap` | Eastern Standard Time | `2026-03-08T02:30:00` | accepted | `2026-03-08T03:30:00+00:00` | 3855785400 | {'play_date': 1} |
| `037-set-date-epoch` | Eastern Standard Time | `1904-01-01T00:00:00` | rejected_or_failed | `OSError: [Errno 22] Invalid argument` | 0 | {} |
| `038-set-date-epoch-plus-one` | Eastern Standard Time | `1904-01-01T00:00:01` | rejected_or_failed | `OSError: [Errno 22] Invalid argument` | 0 | {} |

## Evidence boundary

- source aggregate SHA-256: `dce9b5382f454620a848f1f3b9c31be6c9eeaf78fcaa320140c1a349ccd8c996`
- retained snapshots parsed: **9** (case 030 baseline plus cases 031–038)
- case snapshots cross-checked against the aggregate: **8**
- selected track-field values cross-checked: **1104**
- snapshot file-set SHA-256: `e38949f720a7c4f2a11ebd910b58bc1edbaee5803bbd38a3b2c094e05e698899`
- the comparison count is a parser-consistency count, not a count of native experiments
- no native action was performed and no frozen evidence was modified

`REFERENCE_PARSER` deliberately does not import `itlkit`, but it is still a repository-local implementation rather than an external oracle. The native observations remain limited to the exact retained installer, environment, files, actions, and save sequence.

## Epoch boundary and public prior art

Both retained assignments failed at the Python/COM boundary and made no separately parsed date-field transition. This does not prove raw ITL scalar 0 or 1 rejection.

Historical XML prior art at https://www.joabj.com/Writing/Tech/Tuts/Apps-APIs/iTunes-PlayDate.html also associates Play Date integers with seconds since 1904-01-01. It is not binary-ITL or current-native evidence and does not prove the wall-time/DST behavior above.

## What remains open

No other date field, second fold choice, raw scalar 0/1 writer candidate, additional zone/locale, filesystem-timestamp cause, or iTunes version is qualified here. **U-11 remains open.**

## Reproduce

```bash
python scripts/research/audit_path_time_retained_20260925.py
python -m pytest -q -p no:cacheprovider tests/test_path_time_retained_20260925.py
```
