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
    return $value.Trim()
  } catch { return "presente, versione non leggibile: $($_.Exception.Message)" }
}

function Find-Skill([string]$Name) {
  $paths = @(
    (Join-Path $ProjectPath ".agents/skills/$Name/SKILL.md"),
    (Join-Path $ProjectPath ".codex/skills/$Name/SKILL.md"),
    (Join-Path $HOME ".agents/skills/$Name/SKILL.md"),
    (Join-Path $HOME ".codex/skills/$Name/SKILL.md")
  )
  return $paths | Where-Object { Test-Path $_ } | Select-Object -First 1
}

if (-not (Test-Path $ProjectPath -PathType Container)) { throw "Cartella progetto non trovata: $ProjectPath" }
$ProjectPath = (Resolve-Path $ProjectPath).Path
Set-Location $ProjectPath

$git = Get-CommandInfo "git" @("--version")
$node = Get-CommandInfo "node" @("--version")
$npm = Get-CommandInfo "npm" @("--version")
$codex = Get-CommandInfo "codex" @("--version")
Add-Check "Git" ($(if($git){"ready"}else{"missing_required"})), ($(if($git){$git}else{"comando non trovato"})), "Git serve per versioning, adozione e catalogo sicurezza."
Add-Check "Node.js" ($(if($node){"ready"}else{"missing_optional"})), ($(if($node){$node}else{"comando non trovato"})), "Richiesto per bootstrap, Expo e molte app."
Add-Check "npm/npx" ($(if($npm){"ready"}else{"missing_optional"})), ($(if($npm){"v$npm"}else{"comando non trovato"})), "Richiesto per gli specialisti community e stack JavaScript."
Add-Check "Codex" ($(if($codex){"ready"}else{"missing_required"})), ($(if($codex){$codex}else{"comando non trovato"})), "Accedi a Codex e riapri la sessione dopo nuove skill."

$nativeSkills = @(
  "app-builder",
  "app-builder-doctor",
  "app-builder-handoff",
  "app-builder-about",
  "app-product-discovery",
  "app-requirements-mvp",
  "app-ux-accessibility",
  "app-brand-assets",
  "app-copywriting",
  "app-project-adoption",
  "app-security-orchestrator"
)
$missingNative = [System.Collections.Generic.List[string]]::new()
foreach ($skill in $nativeSkills) {
  if (-not (Find-Skill $skill)) { $missingNative.Add($skill) }
}
Add-Check "Luna native skills" ($(if($missingNative.Count -eq 0){"ready"}else{"missing_required"})), ($(if($missingNative.Count -eq 0){"11 skill native rilevate"}else{"mancano: $($missingNative -join ', ')"})), "Reinstalla Luna App Builder dal repository ufficiale e apri una nuova sessione."

$meaningfulEntries = Get-ChildItem -LiteralPath $ProjectPath -Force -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -notin @(".app-builder", ".agents", ".codex", "docs") }
$existingSignals = @(".git", "package.json", "src", "app", "ios", "android", "supabase", "pubspec.yaml", "Cargo.toml", "pyproject.toml") |
  Where-Object { Test-Path (Join-Path $ProjectPath $_) }
$isExisting = ($meaningfulEntries.Count -gt 0 -or $existingSignals.Count -gt 0)
$adoptionReport = Join-Path $ProjectPath ".app-builder/adoption-report.md"
if ($isExisting) {
  Add-Check "Existing project adoption" ($(if(Test-Path $adoptionReport){"ready"}else{"missing_required"})), ($(if(Test-Path $adoptionReport){$adoptionReport}else{"codice/configurazioni rilevati; adoption report assente"})), "Luna deve usare app-project-adoption in sola lettura prima di modifiche strutturali."
} else {
  Add-Check "Existing project adoption" "not_applicable" "nessun segnale di progetto preesistente" ""
}

$registryPath = Join-Path $ProjectPath ".app-builder/specialists.json"
$securityIndex = Join-Path $ProjectPath ".app-builder/security-catalog/index.json"
if (-not (Test-Path $registryPath) -and $AutoInstallApproved -and $node -and $npm -and $git) {
  $bootstrapCandidates = @(
    (Join-Path $ProjectPath ".agents/skills/app-builder/scripts/bootstrap-specialists.mjs"),
    (Join-Path $ProjectPath ".codex/skills/app-builder/scripts/bootstrap-specialists.mjs"),
    (Join-Path $HOME ".agents/skills/app-builder/scripts/bootstrap-specialists.mjs"),
    (Join-Path $HOME ".codex/skills/app-builder/scripts/bootstrap-specialists.mjs"),
    (Join-Path (Split-Path $PSScriptRoot -Parent) "skills/app-builder/scripts/bootstrap-specialists.mjs")
  )
  $bootstrap = $bootstrapCandidates | Where-Object { Test-Path $_ } | Select-Object -First 1
  if ($bootstrap) {
    try { & node $bootstrap --project $ProjectPath --approved } catch { Write-Warning "Bootstrap fallito: $($_.Exception.Message)" }
  }
}
Add-Check "Specialist bootstrap" ($(if(Test-Path $registryPath){"ready"}else{"missing_optional"})), ($(if(Test-Path $registryPath){$registryPath}else{"non eseguito"})), "Luna presenta una sola richiesta di consenso e avvia automaticamente il bootstrap."
Add-Check "Security catalog index" ($(if(Test-Path $securityIndex){"ready"}else{"missing_optional"})), ($(if(Test-Path $securityIndex){$securityIndex}else{"catalogo non indicizzato"})), "Il catalogo completo viene scaricato in vendor, ma i playbook si caricano on demand."

$externalGroups = [ordered]@{
  "PRD specialist" = @("prd-generator")
  "UX/design specialists" = @("ui-ux-pro-max", "impeccable")
  "Brand specialists" = @("design", "brand", "design-system")
  "Copy specialists" = @("product-marketing", "copywriting", "copy-editing")
}
foreach ($group in $externalGroups.GetEnumerator()) {
  $found = @($group.Value | Where-Object { Find-Skill $_ })
  Add-Check $group.Key ($(if($found.Count -gt 0){"ready"}else{"missing_optional"})), ($(if($found.Count -gt 0){$found -join ', '}else{"nessuna skill del gruppo rilevata"})), "Il fallback nativo Luna resta disponibile; non chiedere comandi manuali multipli."
}

$packageFiles = Get-ChildItem -Path $ProjectPath -Filter package.json -File -Recurse -ErrorAction SilentlyContinue |
  Where-Object { $_.FullName -notmatch "[\\/]node_modules[\\/]" } | Select-Object -First 20
$expoDetected = $false
$needsSupabase = Test-Path (Join-Path $ProjectPath "supabase/config.toml")
foreach ($pkg in $packageFiles) {
  try {
    $raw = Get-Content $pkg.FullName -Raw
    if ($raw -match '"expo"') { $expoDetected = $true }
    if ($raw -match '"@supabase/') { $needsSupabase = $true }
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

if ($expoDetected) {
  $expoPlugin = $pluginText -match "(?i)\bexpo\b"
  if (-not $expoPlugin -and $AutoInstallApproved -and $codex) {
    try { & codex plugin add "expo@openai-curated"; $pluginText = Get-PluginInventory; $expoPlugin = $pluginText -match "(?i)\bexpo\b" } catch {}
  }
  Add-Check "Plugin Expo" ($(if($expoPlugin){"ready"}else{"missing_required"})), ($(if($expoPlugin){"rilevato"}else{"stack Expo rilevato; plugin non confermato"})), "Con consenso installa il plugin ufficiale e riapri la sessione."
} else {
  Add-Check "Plugin Expo" "not_applicable_or_unknown" "stack Expo non rilevato" "Attivalo soltanto quando serve."
}

$supabasePlugin = $pluginText -match "(?i)supabase"
Add-Check "Plugin Supabase" ($(if($supabasePlugin){"ready"}elseif($needsSupabase){"missing_required"}else{"missing_optional"})), ($(if($supabasePlugin){"rilevato"}elseif($needsSupabase){"Supabase usato ma plugin non confermato"}else{"non richiesto dai file correnti"})), "Autenticazione e progetto restano controlli separati dalla presenza del plugin."

$securityPlugin = $pluginText -match "(?i)codex.?security|codex-security"
$securityNeeded = ($Mode -eq "publication" -or $needsSupabase)
Add-Check "Codex Security" ($(if($securityPlugin){"ready"}elseif($securityNeeded){"missing_required"}else{"missing_optional"})), ($(if($securityPlugin){"plugin rilevato"}else{"non confermato dal CLI"})), "Installa da /plugins, riapri la sessione e verifica le skill namespaced."

$statePath = Join-Path $ProjectPath ".app-builder/state.md"
$discoveryDoc = Join-Path $ProjectPath "docs/PRODUCT_DISCOVERY.md"
Add-Check "Stato App Builder" ($(if(Test-Path $statePath){"ready"}else{"missing_required"})), ($(if(Test-Path $statePath){$statePath}else{"file assente"})), "Inizializza il progetto senza sovrascrivere documenti esistenti."
Add-Check "Product Discovery document" ($(if(Test-Path $discoveryDoc){"ready"}else{"missing_optional"})), ($(if(Test-Path $discoveryDoc){$discoveryDoc}else{"documento non presente"})), "Luna lo crea quando discovery è il prossimo gate."

$out = [System.Collections.Generic.List[string]]::new()
$out.Add("# App Builder Doctor")
$out.Add("")
$out.Add("- Data: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')")
$out.Add("- Progetto: $ProjectPath")
$out.Add("- Modalità richiesta: $Mode")
$out.Add("- Progetto preesistente rilevato: $isExisting")
$out.Add("- Bootstrap autorizzato in questa esecuzione: $($AutoInstallApproved.IsPresent)")
$out.Add("")
$out.Add("| Capability | Stato | Evidenza | Prossima azione |")
$out.Add("|---|---|---|---|")
foreach ($c in $checks) {
  $e = ($c.Evidence -replace "\r?\n", " ") -replace "\|", "\\|"
  $n = $c.Next -replace "\|", "\\|"
  $out.Add("| $($c.Name) | $($c.Status) | $e | $n |")
}
$out.Add("")
$out.Add("> Il report non prova autenticazione o caricamento nella chat. Luna completa il post-check e non salva token. Il consenso bootstrap non autorizza strumenti invasivi successivi.")

$fullOutput = if ([System.IO.Path]::IsPathRooted($OutputPath)) { $OutputPath } else { Join-Path $ProjectPath $OutputPath }
New-Item -ItemType Directory -Force -Path (Split-Path $fullOutput -Parent) | Out-Null
$out -join "`n" | Set-Content -Path $fullOutput -Encoding UTF8
$checks | Format-Table -AutoSize
Write-Host "`nReport: $fullOutput"
