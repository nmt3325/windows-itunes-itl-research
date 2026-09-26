param(
  [string]$Targets='targets-final.txt',
  [string]$Output='decompiled',
  [string]$LogName='ghidra-final',
  [string]$CookieRva='179b8e0',
  [string]$Root=(Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path,
  [Parameter(Mandatory=$true)][string]$JavaHome,
  [Parameter(Mandatory=$true)][string]$GhidraHome,
  [string]$ProjectDirectory=(Join-Path $Root 'tools\static\projects'),
  [string]$ReportDirectory=(Join-Path $Root 'reports\static'),
  [string]$ScriptDirectory=(Join-Path $Root 'tools\static\scripts')
)
$ErrorActionPreference='Stop'
$env:JAVA_HOME=(Resolve-Path $JavaHome).Path;$env:PATH="$env:JAVA_HOME\bin;"+$env:PATH
$env:USERPROFILE=Join-Path $Root 'tools\static\home';$env:APPDATA=Join-Path $env:USERPROFILE 'AppData\Roaming';$env:LOCALAPPDATA=Join-Path $env:USERPROFILE 'AppData\Local'
$env:TEMP=Join-Path $Root 'tools\static\tmp';$env:TMP=$env:TEMP
$env:GHIDRA_HEADLESS_MAXMEM='3G';$env:GHIDRA_HEADLESS_JAVA_OPTIONS="-Duser.home=$env:USERPROFILE -Djava.io.tmpdir=$env:TEMP"
$analyzeHeadless=Join-Path $GhidraHome 'support\analyzeHeadless.bat'
& $analyzeHeadless $ProjectDirectory ITLStatic -process iTunes.exe -noanalysis -max-cpu 1 -scriptPath $ScriptDirectory -postScript ITLSelective.java $ReportDirectory $Targets $Output $CookieRva -log (Join-Path $ReportDirectory "$LogName.log") -scriptlog (Join-Path $ReportDirectory "$LogName-script.log") 2>&1 | Tee-Object -FilePath (Join-Path $ReportDirectory "$LogName-console.log") | Where-Object {$_ -match 'ITLSelective|ERROR|REPORT:'}
$launcherExit=$LASTEXITCODE
if($launcherExit -ne 0){exit $launcherExit}
$summary=Join-Path (Join-Path $ReportDirectory $Output) 'summary.tsv'
if(!(Test-Path $summary)){throw 'Ghidra launcher returned zero without decompilation summary'}
$rows=Import-Csv $summary -Delimiter "`t"
if(@($rows|Where-Object {$_.completed -ne 'true'}).Count -ne 0){throw 'Some target decompilations failed'}
"VERIFIED_DECOMPILED_COUNT=$($rows.Count)"
