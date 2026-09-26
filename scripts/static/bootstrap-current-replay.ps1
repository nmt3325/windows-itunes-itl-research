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
$projectPath=[IO.Path]::GetFullPath($ProjectDirectory)
if((Test-Path $projectPath) -and @(Get-ChildItem -Force $projectPath).Count -ne 0){throw 'ProjectDirectory must be absent or empty for a clean bootstrap'}
$javaPath=(Resolve-Path $JavaHome).Path
$ghidraPath=(Resolve-Path $GhidraHome).Path
$analyzeHeadless=Join-Path $ghidraPath 'support\analyzeHeadless.bat'
if(!(Test-Path -LiteralPath $analyzeHeadless -PathType Leaf)){throw 'Ghidra analyzeHeadless.bat was not found'}
$targetsPath=Join-Path $ReportDirectory $Targets
$groupsPath=Join-Path $ReportDirectory 'function_groups.tsv'
if(!(Test-Path -LiteralPath $targetsPath -PathType Leaf)){throw 'Targets file was not found in ReportDirectory'}
if(!(Test-Path -LiteralPath $groupsPath -PathType Leaf)){throw 'function_groups.tsv was not found in ReportDirectory'}
New-Item -ItemType Directory -Force $projectPath,$ReportDirectory | Out-Null
$env:JAVA_HOME=$javaPath;$env:PATH="$javaPath\bin;"+$env:PATH
& $analyzeHeadless $ProjectDirectory $ProjectName -import $binaryPath -overwrite -max-cpu 1 -log (Join-Path $ReportDirectory "$LogName-import.log")
if($LASTEXITCODE -ne 0){exit $LASTEXITCODE}
& (Join-Path $PSScriptRoot 'run-headless.ps1') -Root $Root -JavaHome $javaPath -GhidraHome $ghidraPath -ProjectDirectory $ProjectDirectory -ProjectName $ProjectName -ProgramName $ProgramName -ReportDirectory $ReportDirectory -ScriptDirectory $ScriptDirectory -Targets $Targets -Output $Output -LogName $LogName -CookieRva $CookieRva
exit $LASTEXITCODE
