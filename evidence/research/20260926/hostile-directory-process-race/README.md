# Separate-process hostile-directory race witnesses (2026-09-26)

This bounded Linux U-17 follow-up separates the production writer from the pathname mutator:

- three fresh writer child processes execute `itlkit.io.write_new`;
- a scheduling hook pauses each writer immediately before its real `os.link` call;
- the parent process either performs no mutation (control), replaces the parent directory and spoofs the random temporary basename, or retargets the parent symlink and spoofs that basename; and
- the released child performs the native pathname-based hard-link call and exits normally.

Both adversarial cases reproduced the documented limitation: `write_new` returned successfully while the destination contained the parent process's spoof bytes, and the requested complete temporary remained in the original/displaced directory. The stable-parent control published the requested payload and removed its temporary.

The retained report is byte-identical across two fresh roots after normalizing random temporary basenames. These are three scenarios, not independent experiments. The hook fixes one boundary, so this is not an uncontrolled scheduler campaign and does not cover arbitrary hostile schedules.

Files:

- generator: `scripts/research/audit_hostile_directory_process_race_20260926.py`
- report: `report.json`
- tests: `tests/test_hostile_directory_process_race_20260926.py`

No process was killed, no power was cut, no network filesystem or Apple iTunes binary was used, and no directory-entry durability was measured. This strengthens the hostile-parent **limitation** rather than establishing hostile-directory safety. U-17 remains open; universal atomicity, power-loss durability, network/unusual-filesystem behavior, alternate runtimes, and native acceptance remain unproven.
