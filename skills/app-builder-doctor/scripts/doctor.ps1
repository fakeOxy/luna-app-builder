param(
  [string]$ProjectPath = (Get-Location).Path,
  [ValidateSet("personal","prototype","publication","auto")]
  [string]$Mode = "auto",
  [switch]$AutoInstallApproved,
  [string]$OutputPath = ".app-builder/doctor-report.md"
)

$ErrorActionPreference = "Stop"
$checks = [System.Collections.Generic.List[object]]::new()

function Add-Check([string]$Name, [string]$Status, [string]$Evidence, [string]$Next) {
  $checks.Add([pscustomobject]@{ Name=$Name; Status=$Status; Evidence=$Evidence; Next=$Next })
}

function Get-CommandInfo([string]$Name, [string[]]$Args) {
  $cmd = Get-Command $Name -ErrorAction SilentlyContinue
  if (-not $cmd) { return $null }
  try {
    $value = & $Name @Args 2>&1 | Select-Object -First 3 | Out-String
    return ($value.Trim())
  } catch { return "presente, versione non leggibile: $($_.Exception.Message)" }
}

if (-not (Test-Path $ProjectPath -PathType Container)) { throw "Cartella progetto non trovata: $ProjectPath" }
$ProjectPath = (Resolve-Path $ProjectPath).Path
Set-Location $ProjectPath

$git = Get-CommandInfo "git" @("--version")
Add-Check "Git" ($(if($git){"ready"}else{"missing_required"})), ($(if($git){$git}else{"comando non trovato"})), "Installa Git solo se il progetto deve essere versionato."

$node = Get-CommandInfo "node" @("--version")
Add-Check "Node.js" ($(if($node){"ready"}else{"missing_optional"})), ($(if($node){$node}else{"comando non trovato"})), "Richiesto per Expo, molte app web e installer npm."

$npm = Get-CommandInfo "npm" @("--version")
Add-Check "npm" ($(if($npm){"ready"}else{"missing_optional"})), ($(if($npm){"v$npm"}else{"comando non trovato"})), "Installa insieme a Node.js quando necessario."

$codex = Get-CommandInfo "codex" @("--version")
Add-Check "Codex" ($(if($codex){"ready"}else{"missing_required"})), ($(if($codex){$codex}else{"comando non trovato"})), "Accedi a Codex e riapri la sessione dopo installazioni plugin."

$appBuilderPaths = @(
  (Join-Path $ProjectPath ".agents/skills/app-builder/SKILL.md"),
  (Join-Path $HOME ".agents/skills/app-builder/SKILL.md"),
  (Join-Path $HOME ".codex/skills/app-builder/SKILL.md")
)
$appBuilderFound = $appBuilderPaths | Where-Object { Test-Path $_ } | Select-Object -First 1
Add-Check "Luna App Builder" ($(if($appBuilderFound){"ready"}else{"missing_required"})), ($(if($appBuilderFound){$appBuilderFound}else{"skill non trovata nei path standard"})), "Esegui scripts/install.ps1 dal pacchetto App Builder."

$discoveryPaths = @(
  (Join-Path $ProjectPath ".agents/skills/app-product-discovery/SKILL.md"),
  (Join-Path $HOME ".agents/skills/app-product-discovery/SKILL.md"),
  (Join-Path $HOME ".codex/skills/app-product-discovery/SKILL.md")
)
$discoveryFound = $discoveryPaths | Where-Object { Test-Path $_ } | Select-Object -First 1
Add-Check "Product Discovery skill" ($(if($discoveryFound){"ready"}else{"missing_required"})), ($(if($discoveryFound){$discoveryFound}else{"app-product-discovery non trovata nei path standard"})), "Reinstalla o aggiorna Luna App Builder dal repository ufficiale."

$discoveryDoc = Join-Path $ProjectPath "docs/PRODUCT_DISCOVERY.md"
Add-Check "Product Discovery document" ($(if(Test-Path $discoveryDoc){"ready"}else{"missing_optional"})), ($(if(Test-Path $discoveryDoc){$discoveryDoc}else{"documento non ancora presente"})), "Inizializzalo con scripts/init-project.ps1 o crealo quando parte la discovery."

$packageFiles = Get-ChildItem -Path $ProjectPath -Filter package.json -File -Recurse -ErrorAction SilentlyContinue |
  Where-Object { $_.FullName -notmatch "[\\/]node_modules[\\/]" } | Select-Object -First 20
$expoDetected = $false
foreach ($pkg in $packageFiles) {
  try {
    $j = Get-Content $pkg.FullName -Raw | ConvertFrom-Json
    $deps = @{}
    if ($j.dependencies) { $j.dependencies.psobject.Properties | ForEach-Object { $deps[$_.Name]=$_.Value } }
    if ($j.devDependencies) { $j.devDependencies.psobject.Properties | ForEach-Object { $deps[$_.Name]=$_.Value } }
    if ($deps.ContainsKey("expo")) { $expoDetected = $true; break }
  } catch {}
}

function Get-PluginInventory {
  if (-not (Get-Command codex -ErrorAction SilentlyContinue)) { return "" }
  foreach ($candidate in @(@("plugin","list"), @("plugins","list"))) {
    try {
      $value = (& codex @candidate 2>&1 | Out-String)
      if ($LASTEXITCODE -eq 0 -and $value.Trim()) { return $value }
    } catch {}
  }
  return ""
}

$pluginText = Get-PluginInventory
function Plugin-Detected([string]$Pattern) {
  return ($pluginText -match $Pattern)
}

if ($expoDetected) {
  $expoPlugin = Plugin-Detected "(?i)\bexpo\b"
  if (-not $expoPlugin -and $AutoInstallApproved -and $codex) {
    try { & codex plugin add "expo@openai-curated"; $pluginText = Get-PluginInventory; $expoPlugin = Plugin-Detected "(?i)\bexpo\b" } catch {}
  }
  Add-Check "Plugin Expo" ($(if($expoPlugin){"ready"}else{"missing_required"})), ($(if($expoPlugin){"rilevato nell'output plugin"}else{"stack Expo rilevato; plugin non confermato"})), "Autorizza codex plugin add expo@openai-curated o installa Expo da /plugins."
} else {
  Add-Check "Plugin Expo" "not_applicable_or_unknown" "nessuna dipendenza Expo rilevata" "Attivalo solo per un progetto Expo/React Native."
}

$supabaseFolder = Test-Path (Join-Path $ProjectPath "supabase/config.toml")
$supabaseDep = $false
foreach ($pkg in $packageFiles) {
  try {
    $raw = Get-Content $pkg.FullName -Raw
    if ($raw -match "@supabase/") { $supabaseDep=$true; break }
  } catch {}
}
$needsSupabase = $supabaseFolder -or $supabaseDep
$supabasePlugin = Plugin-Detected "(?i)supabase"
if ($needsSupabase -and -not $supabasePlugin -and $AutoInstallApproved -and $npm) {
  try {
    & npx plugins add supabase-community/supabase-plugin --yes
    $pluginText = Get-PluginInventory
    $supabasePlugin = Plugin-Detected "(?i)supabase"
  } catch {}
}
Add-Check "Plugin Supabase" ($(if($supabasePlugin){"ready"}elseif($needsSupabase){"missing_required"}else{"missing_optional"})), ($(if($supabasePlugin){"rilevato/installato"}elseif($needsSupabase){"Supabase è usato dal progetto ma il plugin non è confermato"}else{"non richiesto dai file correnti"})), "Con consenso: npx plugins add supabase-community/supabase-plugin --yes; poi autentica il progetto corretto."

$securityPlugin = Plugin-Detected "(?i)codex.?security|codex-security"
$securityNeeded = ($Mode -eq "publication")
Add-Check "Codex Security" ($(if($securityPlugin){"ready"}elseif($securityNeeded){"missing_required"}else{"missing_optional"})), ($(if($securityPlugin){"plugin rilevato"}else{"non confermato dal CLI; verifica anche nella sessione"})), "Apri /plugins, installa Codex Security, avvia una nuova sessione e verifica le skill codex-security:* ."

$statePath = Join-Path $ProjectPath ".app-builder/state.md"
Add-Check "Stato App Builder" ($(if(Test-Path $statePath){"ready"}else{"missing_required"})), ($(if(Test-Path $statePath){$statePath}else{"file assente"})), "Inizializza il progetto con scripts/init-project.ps1."

$out = [System.Collections.Generic.List[string]]::new()
$out.Add("# App Builder Doctor")
$out.Add("")
$out.Add("- Data: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')")
$out.Add("- Progetto: $ProjectPath")
$out.Add("- Modalità richiesta: $Mode")
$out.Add("- Installazioni autorizzate in questa esecuzione: $($AutoInstallApproved.IsPresent)")
$out.Add("")
$out.Add("| Capability | Stato | Evidenza | Prossima azione |")
$out.Add("|---|---|---|---|")
foreach ($c in $checks) {
  $e = ($c.Evidence -replace "\r?\n", " ") -replace "\|", "\\|"
  $n = ($c.Next -replace "\|", "\\|")
  $out.Add("| $($c.Name) | $($c.Status) | $e | $n |")
}
$out.Add("")
$out.Add("> Questo report non prova che un plugin sia autenticato o caricato nella chat corrente. Luna deve completare il post-check nella sessione e non deve salvare token nel report.")

$fullOutput = if ([System.IO.Path]::IsPathRooted($OutputPath)) { $OutputPath } else { Join-Path $ProjectPath $OutputPath }
$dir = Split-Path $fullOutput -Parent
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$out -join "`n" | Set-Content -Path $fullOutput -Encoding UTF8

$checks | Format-Table -AutoSize
Write-Host "`nReport: $fullOutput"