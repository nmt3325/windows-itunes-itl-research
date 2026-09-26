param(
  [Parameter(Mandatory=$true)][string]$Binary,
  [Parameter(Mandatory=$true)][string]$JavaHome,
  [Parameter(Mandatory=$true)][string]$GhidraHome,
  [Parameter(Mandatory=$true)][string]$ProjectDirectory,
  [Parameter(Mandatory=$true)][string]$ReportDirectory,
  [string]$Root=(Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path,
  [string]$ProjectName='ITLStatic',
  [string]$ProgramName='iTunes.exe',
  [string]$ScriptDirectory=(Join-Path $Root 'scripts\ghidra'),
  [string]$Targets='targets-final.txt',
  [string]$Output='decompiled',
  [string]$LogName='ghidra-final',
  [string]$CookieRva='179b8e0'
)
$ErrorActionPreference='Stop'
$binaryPath=(Resolve-Path $Binary).Path
if((Split-Path $binaryPath -Leaf) -ne $ProgramName){throw 'Binary filename must match ProgramName'}
$javaPath=(Resolve-Path $JavaHome).Path
$ghidraPath=(Resolve-Path $GhidraHome).Path
New-Item -ItemType Directory -Force $ProjectDirectory,$ReportDirectory | Out-Null
$env:JAVA_HOME=$javaPath;$env:PATH="$javaPath\bin;"+$env:PATH
$analyzeHeadless=Join-Path $ghidraPath 'support\analyzeHeadless.bat'
& $analyzeHeadless $ProjectDirectory $ProjectName -import $binaryPath -overwrite -max-cpu 1 -log (Join-Path $ReportDirectory "$LogName-import.log")
if($LASTEXITCODE -ne 0){exit $LASTEXITCODE}
& (Join-Path $PSScriptRoot 'run-headless.ps1') -Root $Root -JavaHome $javaPath -GhidraHome $ghidraPath -ProjectDirectory $ProjectDirectory -ProjectName $ProjectName -ProgramName $ProgramName -ReportDirectory $ReportDirectory -ScriptDirectory $ScriptDirectory -Targets $Targets -Output $Output -LogName $LogName -CookieRva $CookieRva
exit $LASTEXITCODE
