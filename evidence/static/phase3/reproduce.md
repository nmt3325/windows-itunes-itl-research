# Reproduction
Use pwsh; every command cwd is <CI_TEMP_WIN>\<CI_BROKER>\WINDOWS_RESEARCH_RUN\work\itl\wt\static.
No iTunes/COM/UI/live attach, no production writes, no other-owner scripts or candidates.
Do not run earlier phase1/phase2 finalizers/censuses.

$root='<CI_TEMP_WIN>\<CI_BROKER>\WINDOWS_RESEARCH_RUN\work\itl'
$env:PYTHONIOENCODING='utf-8';$env:PYTHONDONTWRITEBYTECODE='1';$env:GIT_OPTIONAL_LOCKS='0'
$py="$root\tools\py\Scripts\python.exe"
& $py -B -u "$root\reports\static\phase3\prepare_targets.py"
& "$root\tools\static\run-headless.ps1" -Targets 'phase3/targets.txt' -Output 'phase3/decompiled' -LogName 'phase3/ghidra-name-first-two'
& $py -B -u "$root\reports\static\phase3\prepare_final_two.py"
& "$root\tools\static\run-headless.ps1" -Targets 'phase3/targets-final-two.txt' -Output 'phase3/decompiled2' -LogName 'phase3/ghidra-name-final-two'
& $py -B -u "$root\reports\static\phase3\native_name_evidence.py"
& $py -B -u "$root\reports\static\phase3\offline_descriptor_proof.py"

Run Ghidra sequentially, CPU1 heap3G60s/function, noanalysis. Only4 functions total; eb8130 is ASM/emulation only. Require2 completed=true rows in each summary AND command exit0/eoftrue; resume bounded commands rather than duplicate them.
The snapshot script loads phase2 inspect() under a non-main name; it does not run or rewrite the old census. Only pinned003/010 saved synthetic inputs, not live library.
Original-code proof uses existing owned Unicorn with synthetic memory and original PE instructions. It is not native application acceptance.
The executed phase3/build_report.py can reproduce reports and verification without running decompilation. It requires150 preserved artifacts,9 original source hashes,4 new C,26 original-code checks and65536 separate model cases. Do not rerun it merely to stamp completion: it emits STATIC_PHASE3_VERIFIED before the separate post-EOF completion stamp.
Raw module hash/RVAs/ASM are authoritative; Ghidra inferred signatures/names can vary with project state. Some register-carried arguments are omitted in C.
