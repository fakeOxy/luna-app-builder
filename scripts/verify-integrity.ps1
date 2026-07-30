param([string]$RootPath = (Split-Path $PSScriptRoot -Parent))
$ErrorActionPreference = "Stop"
$manifestPath = Join-Path $RootPath "integrity-manifest.json"
if (-not (Test-Path $manifestPath)) { throw "Manifesto non trovato: $manifestPath" }
$m = Get-Content $manifestPath -Raw | ConvertFrom-Json
$failed = 0
foreach ($entry in $m.files) {
  $path = Join-Path $RootPath $entry.path
  if (-not (Test-Path $path -PathType Leaf)) { Write-Host "MISSING  $($entry.path)"; $failed++; continue }
  $hash = (Get-FileHash $path -Algorithm SHA256).Hash.ToLowerInvariant()
  if ($hash -ne $entry.sha256) { Write-Host "MODIFIED $($entry.path)"; $failed++ } else { Write-Host "OK       $($entry.path)" }
}
if ($failed -gt 0) { Write-Error "$failed file mancanti o modificati."; exit 1 }
Write-Host "Integrità checksum verificata. Nota: senza firma crittografica, chi modifica i file può anche rigenerare il manifesto."
