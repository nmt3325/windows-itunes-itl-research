# Native Smart Playlist probe series — 2026-09-22

All 24 attempts are retained. **None passed the positive semantic gate.** A transport/control call returning success, a visible Edit value, or creation of a playlist is not counted as rule-editing support.

The isolated UI census established the `Smart Playlist` / `iTunesCustomModalDialog` surface, default Artist/contains/empty controls, 49 field choices, six string operators, five limit units, 13 selection modes, Match checked, Limit unchecked, Live updating checked, and OK/Cancel IDs 101/102. The exact empty/conflict warning and its Yes/Cancel controls are retained in the result JSONs.

## Attempt inventory

| Attempt | Terminal gate | Final live SHA-256 |
| ---: | --- | --- |
| v1 | bootstrap dependency failure | `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74` |
| v2 | foreground acquisition failure | `76f3852bd79c3ab4bf64f858f2ae976218a3c4122b77f94e941a01a24d42f1ae` |
| v3 | modal did not close | `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74` |
| v4 | control value not retained | `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74` |
| v5 | control value not retained | `8f499310241d3792c11735bca82b8ef4b7ea6e5adf527728fb8907a35499b85e` |
| v6 | control value not retained | `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74` |
| v7 | modal did not close | `95b59ff7113da69b515d19d0bf361b948af277f4923a18450797c5c652c73da1` |
| v8 | control value not retained | `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74` |
| v9 | empty/conflict warning intercepted | `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74` |
| v10 | empty/conflict warning intercepted | `cdfb6d6b2964cfaa5960a693ce779577453faa87f8746b793bd086a7801cc4a5` |
| v11 | control value not retained | `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74` |
| v12 | native input/focus exact gate failed | `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74` |
| v13 | native input/focus exact gate failed | `8ea73531db757575a15193b283403737d81d9ed5feac945e14579b5e7950a490` |
| v14 | created playlist membership empty | `d6bfd174f339456711dba38057b75aeece12a4857a2bffc74e5a809bd06503d8` |
| v15 | physical input exact gate failed | `e66e67c239f0ca1fad63d692f56b514f482972fd93ad5ab2f31566f41a8aee1f` |
| v16 | physical input exact gate failed | `571bd222033c87542b2e666c496caaf5f97322d20f32c1af57e6b9e79d87d6dd` |
| v17 | UI Automation ValuePattern failure | `ed55a255bc2e5ceb132ac92a3e15053843751fa2bb54b47e2d177e15720726c0` |
| v18 | SendKeys exact gate failed | `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74` |
| v19 | created playlist membership empty | `9ce8ee4198e87f8266202ff147bfb84ac186af57a3c83ca77353e7be27995240` |
| v20 | focus/input exact gate failed | `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74` |
| v21 | focus/input exact gate failed | `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74` |
| v22 | focus/input exact gate failed | `8fde6fc76e16f06b1ae7ce65b3c652fd7a0791c33bbd29388db87336dccc9fc5` |
| v23 | focus/input exact gate failed | `eb110bb7f2b443ec978e2dd03ad9f51de821454b61d88757b511082c12ca33aa` |
| v24 | created playlist membership empty | `58ad4d6fedc65f43e627b35075218c6c19b16d767570c41d6f8c2f2fe7376696` |

## Canonical v24 negative

Attempt v24 seeded the track Artist as `Independent Artist`; the visible Edit control also displayed that exact text after focused `SetWindowText` plus `EN_UPDATE`, `EN_CHANGE`, and `EN_KILLFOCUS`. Nevertheless iTunes showed the empty/conflict warning. After explicitly choosing Yes, it created playlist `9081AD2B1ABE848F` named `Playlist`, but COM membership was empty.

The native-saved ITL (`58ad4d6fedc65f43e627b35075218c6c19b16d767570c41d6f8c2f2fe7376696`, 4,402 bytes) contains two native-created nested wrappers: an OR group with media-kind values 1 and 32, and an AND group containing one Artist/contains leaf. The leaf has field `0x04`, action `0x01000002`, and `data_length == 0`; its decoded string candidate is empty. Thus v24 supplies native Windows evidence for the wrapper framing and occurrence of a string-family leaf, while decisively failing operand commit and semantic evaluation.

See [`probe-series-summary.json`](probe-series-summary.json), [`../smart-playlist-default-20260922-v24/README.md`](../smart-playlist-default-20260922-v24/README.md), and every retained `result.json`. No restart-positive rule-editing or independent-generation claim follows.
