param([string]$Targets='targets-final.txt',[string]$Output='decompiled',[string]$LogName='ghidra-final')
$ErrorActionPreference='Stop'
$root='D:\a\_temp\gha-mcp\WINDOWS_RESEARCH_RUN\work\itl'
$env:JAVA_HOME='C:\hostedtoolcache\windows\Java_Temurin-Hotspot_jdk\21.0.12-101.0\x64';$env:PATH="$env:JAVA_HOME\bin;"+$env:PATH
$env:USERPROFILE="$root\tools\static\home";$env:APPDATA="$env:USERPROFILE\AppData\Roaming";$env:LOCALAPPDATA="$env:USERPROFILE\AppData\Local"
$env:TEMP="$root\tools\static\tmp";$env:TMP=$env:TEMP
$env:GHIDRA_HEADLESS_MAXMEM='3G';$env:GHIDRA_HEADLESS_JAVA_OPTIONS="-Duser.home=$env:USERPROFILE -Djava.io.tmpdir=$env:TEMP"
& "$root\tools\static\ghidra\ghidra_12.1.3_PUBLIC\support\analyzeHeadless.bat" "$root\tools\static\projects" ITLStatic -process iTunes.exe -noanalysis -max-cpu 1 -scriptPath "$root\tools\static\scripts" -postScript ITLSelective.java "$root\reports\static" $Targets $Output -log "$root\reports\static\$LogName.log" -scriptlog "$root\reports\static\$LogName-script.log" 2>&1 | Tee-Object -FilePath "$root\reports\static\$LogName-console.log" | Where-Object {$_ -match 'ITLSelective|ERROR|REPORT:'}
$launcherExit=$LASTEXITCODE
if($launcherExit -ne 0){exit $launcherExit}
$summary="$root\reports\static\$Output\summary.tsv"
if(!(Test-Path $summary)){throw 'Ghidra launcher returned zero without decompilation summary'}
$rows=Import-Csv $summary -Delimiter "`t"
if(@($rows|Where-Object {$_.completed -ne 'true'}).Count -ne 0){throw 'Some target decompilations failed'}
"VERIFIED_DECOMPILED_COUNT=$($rows.Count)"
