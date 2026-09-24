# U-02 big-endian payload prior-art audit

This package is a reproducible, evidence-bounded audit of the 14 historical `.itl` fixtures in public repository [`josephw/titl`](https://github.com/josephw/titl), pinned exactly to commit `e7060370973d624d5c7b18f82303407b76421501`.

The pinned repository identifies its license as GNU LGPL v3 or later in `README.md`, `BOILERPLATE`, `pom.xml`, and `LGPL-3`. No third-party fixture bytes are copied into this repository. `audit.json` retains only relative upstream paths, input hashes, sizes, parser outcomes, bounded structural observations, and hashes of selected primitive payloads.

## Result

- **14/14** outer containers decoded.
- **14/14** unchanged serializations reproduced the exact input bytes.
- **14/14** forced reconstructions reparsed and preserved decoded payload, trailer, version, byte-order classification, and all outer header bytes except the recomputed file-size field.
- The outer byte-order flag classified **13 big-endian** payloads and **1 little-endian** payload (`Empty OS X iTunes 11.1.5 Library.itl`).
- Production `itlkit.Library` accepted **0/14**: all 13 big-endian inputs stopped at its explicit byte-order gate; the little-endian OS X input passed that gate and first stopped at the modern `mfdh` logical-size invariant.
- Independent `ReferenceLibrary` accepted **1/14**: the little-endian OS X input; all 13 big-endian inputs stopped at its explicit byte-order gate.
- The pinned `josephw/titl` high-level parser returned a `Library` for **14/14** when its pinned Java sources were compiled and invoked directly.
- The audit's third, read-only structural walker bounded **1,737 framed records across 14/14 payloads**, including all 13 big-endian payloads. It checked 93 section-root counts, 34 owner/child counts, 244 playlist-item counts, 446 conservative generic-string primitives, and censused 61 playlist track references.

A parser returning successfully is not native iTunes acceptance and does not prove every semantic field. Likewise, container round-trip success proves reversible envelope handling, not payload understanding.

## Byte-order and framing basis

The outer `hdfm` header stores its own framing integers in big-endian order. Byte `0x52` is the payload-order discriminator used by the repository container implementation: zero means big-endian, nonzero means little-endian. The decoded payload corroborates that field:

- big-endian fixtures physically begin with logical tag `hdsm`;
- the little-endian fixture physically begins with `msdh`, which becomes logical `hdsm` when each four-byte tag is reversed.

The third walker does not call either repository semantic parser. It reads integers with explicit `int.from_bytes(..., byteorder=...)` calls and checks these bounded historical primitives:

- `hdsm`: header length at `+0x04`, section type at `+0x0c`, and a type-4 terminal section;
- section roots: `hdfm`, `hghm`, `halm`, `hilm`, `htlm`, `hplm`, and `hslm`, with observed root counts at `+0x08` checked against the corresponding child record type;
- general records: header length at `+0x04`, bounded by the decoded payload;
- `hohm`: total record length at `+0x08` and type code at `+0x0c`;
- conservative `readGenericHohm` cases from the pinned parser: encoding flag at `+0x1b`, data length at `+0x1c`, eight reserved zero bytes, and bounded string data at `+0x28`; observed flags are mapped only as ASCII, UTF-16BE, UTF-8, or Windows-1252;
- `htim`: pinned-parser record-length field at `+0x08`, `hohm` child count at `+0x0c`, and track identifier at `+0x10`;
- `hpim`: observed `hohm` count field at `+0x0c` and playlist-item count at `+0x10`; only the playlist-item count is enforced because pinned code and fixtures do not establish the first field as a complete contiguous bound;
- `hptm`: track reference at `+0x18`, censused against observed `htim` track identifiers.

The walker treats bytes following the terminal type-4 `hdsm` as an opaque footer and records only its length, hash, and whether it starts with `file:`.

## First-boundary taxonomy

| Parser | Accepted | First rejection boundary |
|---|---:|---|
| `itlkit.Container` | 14/14 | none in this corpus; envelope framing only |
| `itlkit.Library` | 0/14 | 13 payload-byte-order gates; 1 modern root-size invariant |
| `ReferenceLibrary` | 1/14 | 13 payload-byte-order gates |
| pinned `josephw/titl` | 14/14 returned | none observed; return is not a completeness/native claim |
| independent structural walker | 14/14 | none observed for its deliberately narrow framing/bounds scope |

Pinned `FlippedInputImpl` reverses `readInt()` for the little-endian path but does not override `readShort()`. Therefore, even its 14/14 return result cannot support a claim that every 16-bit primitive in the little-endian fixture was interpreted with the correct byte order.

## Fixture manifest and outcomes

`L` is production `itlkit.Library`; `R` is `ReferenceLibrary`; `T` is pinned `josephw/titl`. “A” means returned/accepted and “R” means rejected at the boundary recorded in `audit.json`.

| Upstream fixture | SHA-256 | Order | Outer version | Framed records | L | R | T |
|---|---|---:|---:|---:|:---:|:---:|:---:|
| `Empty OS X iTunes 11.1.5 Library.itl` | `a900ef2e0d7e2e8492e2539ab5441571c6808aa6b65d82cb44357ce6982db916` | little | 11.1.5 | 132 | R | A | A |
| `Empty iTunes 10.0 Library.itl` | `1eb0c490c94cc3f9879f1acdaee6d64a90b7b03495de79ae3ac366734e9aa9f8` | big | 10.0 | 120 | R | R | A |
| `Empty iTunes 10.0.1 Library.itl` | `e847e2337cdaecbff062559f2d9b5d3a5a037a59b75e534c4d2891692cff4fc9` | big | 10.0.1 | 120 | R | R | A |
| `Empty iTunes 10.1 Library.itl` | `3515cc98c010cafc64e5e90819258273fbe43a0b93981b94e5855ede55cf67fa` | big | 10.1 | 120 | R | R | A |
| `Empty iTunes 10.2 Library.itl` | `bc0a0dce272a66e93dfb835ea84e9fc99d19de6dc016770f03f0c02725c34cec` | big | 10.2.2 | 120 | R | R | A |
| `Empty iTunes 8.0 Library.itl` | `f613cc306d2466809f8bbebdc5b3c90eeb6ed1f2154dee4b80b46bb74fef8f01` | big | 8.0 | 73 | R | R | A |
| `Empty iTunes 8.0.1 Library.itl` | `27b1a68d666be1a6fffddfb88f39a8bb2ffb3dc74608ea8e254402899340c8d9` | big | 8.0.1 | 74 | R | R | A |
| `Empty iTunes 9.0.3 Library.itl` | `d03835c9c62095009459bf8ad83e84af307d30d995f225b7028f33e287b79df6` | big | 9.0.3 | 100 | R | R | A |
| `Empty iTunes 9.2.0 Library.itl` | `32ff0d9e51e519916d628b0df3886e447e3c646dffc41cfcc905608685e6bda0` | big | 9.2 | 100 | R | R | A |
| `Minimal iTunes 8.0.1 Library.itl` | `5491a860124cde2a345bff6af26c9f5dcaa9c643d90411204f9b2ded297eaed2` | big | 8.0.1 | 238 | R | R | A |
| `iTunes 10.2.2 Library with single track with artwork.itl` | `3c084df1c71236f4ae57797bf59b2c60d081666055007c4ef7bc18088f084e44` | big | 10.2.2 | 153 | R | R | A |
| `iTunes 10.2.2 Library with single track.itl` | `9ca3e58d42da5dfccdeb20b77959519a59f2fbe4bd5f46078a292d791e728896` | big | 10.2.2 | 153 | R | R | A |
| `iTunes 8.0.1 Library TMBG.itl` | `d0517dc144fd446da01e4fdce4901c05e54ad9c23c347e922331b5e6a1043c82` | big | 8.0.1 | 132 | R | R | A |
| `iTunes 8.0.1 Library with TV show.itl` | `987100ec9a2b9142a8ac1b497a96b10b3266e486021078035f10c143d7393691` | big | 8.0.2 | 102 | R | R | A |

## Machine-readable evidence

`audit.json` contains:

- exact fixture and relevant source-file SHA-256 values;
- the strict upstream commit pin and relative paths only;
- outer envelope fields and byte-order rationale per fixture;
- exact first exception class/message/stage for repository high-level parsers;
- direct pinned-Java-parser return status and track/playlist counts;
- section boundaries, record/header-length censuses, count checks, bounded string primitive records, and reference census;
- explicit positive and negative claim boundaries, including `u02_status: "open"`.

## Reproduction

From the repository root, with the public checkout already pinned:

```bash
TITL_REPO=/path/to/titl

git -C "$TITL_REPO" checkout --detach e7060370973d624d5c7b18f82303407b76421501
PYTHONDONTWRITEBYTECODE=1 PYTHONPATH=. python \
  scripts/research/audit_big_endian_prior_art_20260925.py \
  --titl-repo "$TITL_REPO" \
  --output evidence/research/20260925/big-endian-prior-art/audit.json

TITL_REPO="$TITL_REPO" PYTHONDONTWRITEBYTECODE=1 python -m pytest \
  -p no:cacheprovider --basetemp=/tmp/pytest-u02 \
  tests/test_big_endian_prior_art_audit.py -q
```

The generator emits deterministic JSON: it records no timestamp or absolute checkout path and sorts fixtures and JSON keys.

## U-02 remains open

This audit advances the public prior-art and framing evidence but does not close U-02. It does not change production `Library`, run a BE-producing native iTunes version, prove native acceptance, validate every semantic field, or establish every format version. Closure still requires an endian-aware production semantic implementation with broader independent fixtures, negative/adversarial coverage, complete field/reference validation, and exact-version native save/reload evidence.
