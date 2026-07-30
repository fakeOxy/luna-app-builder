param(
  [ValidateSet("User","Project")][string]$Scope = "User",
  [string]$ProjectPath = (Get-Location).Path,
  [switch]$RunDoctor
)
$ErrorActionPreference = "Stop"
$Root = Split-Path $PSScriptRoot -Parent
$Target = if ($Scope -eq "User") { Join-Path $HOME ".agents/skills" } else { Join-Path ([System.IO.Path]::GetFullPath($ProjectPath)) ".agents/skills" }
New-Item -ItemType Directory -Force -Path $Target | Out-Null
foreach ($skill in Get-ChildItem "$Root/skills" -Directory) {
  $dest = Join-Path $Target $skill.Name
  if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
  Copy-Item $skill.FullName $dest -Recurse -Force
  Write-Host "Installata: $($skill.Name) -> $dest"
}
Write-Host "`nApri una nuova sessione Codex per caricare le skill."
if ($RunDoctor) { & "$PSScriptRoot/doctor.ps1" -ProjectPath $ProjectPath }
