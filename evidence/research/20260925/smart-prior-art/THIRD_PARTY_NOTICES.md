# Third-party notices for retained Smart Playlist prior-art snapshots

This directory retains four small binary snapshots solely for reproducible,
evidence-bounded format comparison. They are cross-format prior art, not
Windows-native proof. The source repositories and exact commits are pinned in
`source-manifest.json`.

## `kynoptic/smart-playlist-io`

Source: https://github.com/kynoptic/smart-playlist-io
Pinned commit: `31acf7f058278f120b9d054459134416e76d1d8e`

`smart-playlist-io-golden-criteria.bin` and
`smart-playlist-io-golden-info.bin` are exact copies of the pinned upstream
regression fixtures `tests/fixtures/golden_criteria.bin` and
`tests/fixtures/golden_info.bin`.

### MIT license (verbatim; line endings normalized)

```text
MIT License

Copyright (c) 2026 kynoptic

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

### Upstream NOTICE (verbatim; line endings normalized)

```text
This project includes knowledge and techniques derived from the following
open-source projects. No source code is copied directly, but the binary format
specifications (field IDs, byte offsets, rule block layouts, subexpression
structure) used in our encoder and decoder were learned from these works.

================================================================================

itunessmart
https://github.com/cvzi/itunes_smartplaylist

Copyright (c) 2018 cuzi

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

================================================================================

banshee-itunes-import-plugin
by Scott Peterson

The original reverse-engineering of the iTunes Smart Playlist binary format,
which itunessmart built upon.
```

## `cvzi/itunes_smartplaylist`

Source: https://github.com/cvzi/itunes_smartplaylist
Pinned commit: `9a36e82d5bfaad9154b50166fee0489f5d9306e2`

`itunes-smartplaylist-minimal-criteria.bin` and
`itunes-smartplaylist-minimal-info.bin` are byte-exact extractions of the
`Smart Criteria` and `Smart Info` plist data in the pinned
`tests/library_minimal.xml` fixture.

### MIT license (verbatim; line endings normalized)

```text
MIT License

Copyright (c) cuzi 2018

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
