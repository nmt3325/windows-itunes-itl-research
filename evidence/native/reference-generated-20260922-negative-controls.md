# Rejected sparse reference-generator controls

The original generator-v1 fixture hashes were retained as negative evidence rather than relabeled as successes:

- raw: `f340b1ee9b11864d8e8f9bb00a72bbcc313c0074c48f9bc8df1c31224109ef2c`
- zlib: `3e597e9778936d2fbf70d13620b5e4ebc9649d2d8b11086a5560daf7e620b6ce`

Strict runs are under [`reference-generated-20260922/`](reference-generated-20260922/) and [`reference-generated-20260922-clean/`](reference-generated-20260922-clean/). Depending on the isolated run, iTunes displayed an update/migration dialog, created `Previous iTunes Libraries`, rewrote the candidate, or exposed a different library/master identity with an empty master track collection. These outcomes are failures under the requested gate. The gates were not weakened.

Structural comparison showed that sparse section framing and a custom playlist alone were insufficient. The accepted v2 profile adds current global metadata, album/artist records, the master playlist with matching library identity and track membership, section 23, media-folder section, current-profile header fields, and correct `miph` metadata/item counts. Because several changes were introduced together, the evidence does not assign necessity to every individual unknown constant.
