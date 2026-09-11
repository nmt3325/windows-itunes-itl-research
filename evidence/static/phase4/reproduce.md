# Bounded reproduction
Use explicit cwd <CI_TEMP_WIN>\<CI_BROKER>\WINDOWS_RESEARCH_RUN\work\itl\wt\static and pwsh.
Set PYTHONDONTWRITEBYTECODE=1, PYTHONIOENCODING=utf-8, GIT_OPTIONAL_LOCKS=0.
Run the shared interpreter read-only with -B:
  ROOT\tools\py\Scripts\python.exe -B -u ROOT\reports\static\phase4\resume_verify.py
This verifies all pinned prior files, inputs, saved ASM bytes,8 C summaries and3 donor snapshots. It writes only resume-verification.json; do not rerun it after freezing delivery without refreshing the manifest.
Ghidra reproduction (sequential, independent future replay only, not required again now):
  & ROOT\reports\static\phase4\run-headless.ps1 -Targets phase4/targets-first.txt -Output phase4/decompiled-first -LogName phase4/ghidra-first
  & ROOT\reports\static\phase4\run-headless.ps1 -Targets phase4/targets-second.txt -Output phase4/decompiled-second -LogName phase4/ghidra-second
The wrapper uses the isolated existing project, scripts, home and tmp under phase4; CPU1, ActiveProcessorCount1, heap3G, noanalysis,60s/function. Total8 targets, no full analysis. Do not overwrite older phase outputs or the original project. Do not run prior finalizers, native applications, COM, live attach, other-owner scripts or candidate builders. Actual executable SHA256 is recorded in each C header and input-manifest.json.
All source interpretations are bounded to this binary/profile. Full import acceptance belongs to dynamic and requires the parent's complete two-save/restart oracle.
