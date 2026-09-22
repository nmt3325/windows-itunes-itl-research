# External `itl-rs` interoperability probe — 2026-09-22

This bundle evaluates the genuinely external MIT-licensed implementation [`quinnjr/itl-rs`](https://github.com/quinnjr/itl-rs) at commit `49f3ad3beaf2cdd4af2b16ee2297ec22e939dbab`. The source checkout remained clean. The retained harness depends on the pinned external crate; it does not import this repository's `itlkit` implementation.

## Provenance

- License SHA-256: `d5ff8acbab36c2f0b9fd5f27f599ee72c9f1788fc146e539908e646d74f4ceaa`.
- External `Cargo.lock` SHA-256: `7751d90aba89453bddc3804381e35f22875ee04b462c40edc7abf56e9ce0e7a9`.
- `rustc 1.98.1`; `cargo 1.98.1`.
- Reproducible harness sources and lockfile are retained under [`harness/`](harness/); build products are intentionally excluded.

## Outcomes

| Case | External result | Local conformance result | Native action |
| --- | --- | --- | --- |
| Raw reference `c6c681…d74` | Exit 101, `Decompression("corrupt deflate stream")`; no output | Retained negative | Not submitted |
| Zlib/AES reference `25f8ab…13ad` | Wrote 755-byte `287310…642` | Expanded payload is byte-identical (`666c74…a797`); the outer header differs only at total-size offsets 10–11; reference validator accepts it | Exact output passed two strict isolated iTunes cycles |
| Longer title + new artist | Wrote 812-byte `c24959…348b` | Rejected: `size.logical_mismatch`, logical size 10586 vs 10665 | Not submitted |
| Equal-length title | Wrote 765-byte `4c29ff…b25c` | Reference validator accepts framing, but production preflight rejects a zero/duplicate secondary track ID | Not submitted |

The unchanged-payload roundtrip also fails the stricter production semantic preflight for the same zero/duplicate secondary track-ID condition, even though iTunes accepts the serialized bytes and the external accessor reports PID zero while those bytes preserve `A17E000000000001`. This discrepancy is retained rather than normalized away.

## Strict conclusion

This proves **exact-hash compressed structural byte preservation and native acceptance**, not a correct independent semantic reimplementation. Raw input is unsupported, semantic identity access is wrong, and the mutation candidates did not clear mandatory preflight. Therefore `independent_reimplementation_passed` remains `false`.

See [`conformance-summary.json`](conformance-summary.json), [`source-and-run-attestation.json`](source-and-run-attestation.json), the four run logs, and [`native-accepted/summary.json`](native-accepted/summary.json).
