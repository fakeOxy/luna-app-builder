param(
  [Parameter(Mandatory=$true)][string]$ProjectName,
  [ValidateSet("personal","prototype","publication")][string]$Mode = "personal",
  [string]$ProjectPath = (Get-Location).Path,
  [switch]$Force
)
$ErrorActionPreference = "Stop"
$ProjectPath = [System.IO.Path]::GetFullPath($ProjectPath)
New-Item -ItemType Directory -Force -Path $ProjectPath | Out-Null
$Root = Split-Path $PSScriptRoot -Parent
$Today = Get-Date -Format "yyyy-MM-dd"

function Render([string]$Text) {
  return $Text.Replace("{{PROJECT_NAME}}", $ProjectName).Replace("{{PROJECT_MODE}}", $Mode).Replace("{{PROJECT_ROOT}}", $ProjectPath).Replace("{{DATE}}", $Today).Replace("{PROJECT_NAME}", $ProjectName).Replace("{PROJECT_MODE}", $Mode).Replace("{PROJECT_ROOT}", $ProjectPath).Replace("{DATE}", $Today)
}
function Copy-Rendered([string]$Source, [string]$Destination) {
  if ((Test-Path $Destination) -and -not $Force) { Write-Host "Preservato: $Destination"; return }
  New-Item -ItemType Directory -Force -Path (Split-Path $Destination -Parent) | Out-Null
  Render (Get-Content $Source -Raw) | Set-Content $Destination -Encoding UTF8
  Write-Host "Creato: $Destination"
}

Copy-Rendered "$Root/templates/state.md" "$ProjectPath/.app-builder/state.md"
Copy-Rendered "$Root/templates/app-builder.config.json" "$ProjectPath/.app-builder/config.json"
Copy-Rendered "$Root/templates/chat-prompts/design.md" "$ProjectPath/.app-builder/chat-prompts/design.md"
Copy-Rendered "$Root/templates/chat-prompts/development.md" "$ProjectPath/.app-builder/chat-prompts/development.md"
Copy-Rendered "$Root/templates/handoff.md" "$ProjectPath/.app-builder/handoffs/HANDOFF-TEMPLATE.md"
Copy-Rendered "$Root/templates/handoffs/README.md" "$ProjectPath/.app-builder/handoffs/README.md"
foreach ($file in Get-ChildItem "$Root/templates/docs" -File) {
  Copy-Rendered $file.FullName "$ProjectPath/docs/$($file.Name)"
}
Write-Host "`nProgetto inizializzato. Avvia Codex nella cartella e usa `$app-builder."
