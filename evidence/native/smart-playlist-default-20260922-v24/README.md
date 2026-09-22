# Smart Playlist v24 canonical negative

- Status: **`failed_with_preserved_evidence`**.
- Candidate: raw reference fixture `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74`.
- Seeded Artist: `Independent Artist`.
- Created playlist: `Playlist`, PID `9081AD2B1ABE848F`, Kind 2, SpecialKind 0.
- COM members: none.
- Native-saved ITL: 4,402 bytes, SHA-256 `58ad4d6fedc65f43e627b35075218c6c19b16d767570c41d6f8c2f2fe7376696`.
- iTunes exited normally; no forbidden fallback artifact was found; the profile junction was removed and the profile was absent after cleanup.

The UI displayed the requested text, yet the exact empty/conflict warning appeared and the serialized Artist/contains leaf had zero-length data. The saved root contains native nested wrapper framing, including OR media-kind leaves and an AND wrapper around the string-family leaf. These are structural observations only. Membership and operand gates failed, so the attempt is not Smart Playlist editing support and no verification restart was attempted.

The complete controls, warning, COM state, parsed AST, inventory, hashes, and cleanup record are in [`result.json`](result.json). The full v1–v24 series is indexed by [`../smart-playlist-default-20260922/README.md`](../smart-playlist-default-20260922/README.md).
