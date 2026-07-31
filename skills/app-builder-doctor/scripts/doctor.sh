#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'TXT'
Uso:
  doctor.sh [--project /percorso] [--mode auto|personal|prototype|publication]
            [--output .app-builder/doctor-report.md] [--auto-install-approved]
  doctor.sh [/percorso] [auto|personal|prototype|publication] [output]

Senza --auto-install-approved il Doctor non installa nulla.
TXT
}

PROJECT_PATH="$(pwd)"
MODE="auto"
OUTPUT_PATH=".app-builder/doctor-report.md"
AUTO_INSTALL=false

if [[ $# -gt 0 && "$1" != --* ]]; then
  PROJECT_PATH="$1"
  MODE="${2:-auto}"
  OUTPUT_PATH="${3:-.app-builder/doctor-report.md}"
else
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --project) PROJECT_PATH="${2:?Manca il valore di --project}"; shift 2 ;;
      --mode) MODE="${2:?Manca il valore di --mode}"; shift 2 ;;
      --output) OUTPUT_PATH="${2:?Manca il valore di --output}"; shift 2 ;;
      --auto-install-approved) AUTO_INSTALL=true; shift ;;
      -h|--help) usage; exit 0 ;;
      *) echo "Argomento sconosciuto: $1" >&2; usage; exit 2 ;;
    esac
  done
fi
case "$MODE" in auto|personal|prototype|publication) ;; *) echo "Modalità non valida: $MODE" >&2; exit 2;; esac
[[ -d "$PROJECT_PATH" ]] || { echo "Cartella progetto non trovata: $PROJECT_PATH" >&2; exit 2; }
PROJECT_PATH="$(cd "$PROJECT_PATH" && pwd)"
cd "$PROJECT_PATH"

rows=()
add_check() { rows+=("| $1 | \`$2\` | ${3//$'\n'/ } | $4 |"); }
command_info() { command -v "$1" >/dev/null 2>&1 && "$@" 2>&1 | head -n 3 || true; }
find_skill() {
  local name="$1" path
  for path in \
    "$PROJECT_PATH/.agents/skills/$name/SKILL.md" \
    "$PROJECT_PATH/.codex/skills/$name/SKILL.md" \
    "$HOME/.agents/skills/$name/SKILL.md" \
    "$HOME/.codex/skills/$name/SKILL.md"; do
    [[ -f "$path" ]] && printf '%s' "$path" && return 0
  done
  return 1
}
plugin_inventory() {
  if ! command -v codex >/dev/null 2>&1; then return 0; fi
  codex plugin list 2>&1 || codex plugins list 2>&1 || true
}

GIT_V="$(command_info git --version)"
[[ -n "$GIT_V" ]] && add_check Git ready "$GIT_V" "" || add_check Git missing_required "comando non trovato" "Git serve per versioning, adozione e cataloghi."
NODE_V="$(command_info node --version)"
[[ -n "$NODE_V" ]] && add_check Node.js ready "$NODE_V" "" || add_check Node.js missing_optional "comando non trovato" "Richiesto per bootstrap, Expo e molte app."
NPM_V="$(command_info npm --version)"
[[ -n "$NPM_V" ]] && add_check npm/npx ready "v$NPM_V" "" || add_check npm/npx missing_optional "comando non trovato" "Installa insieme a Node.js."
CODEX_V="$(command_info codex --version)"
[[ -n "$CODEX_V" ]] && add_check Codex ready "$CODEX_V" "" || add_check Codex missing_required "comando non trovato" "Installa o accedi a Codex."

native_skills=(
  app-builder app-builder-doctor app-builder-handoff app-builder-about
  app-product-discovery app-requirements-mvp app-ux-accessibility
  app-brand-assets app-copywriting app-project-adoption
  app-security-orchestrator app-analytics-measurement
)
missing=()
for skill in "${native_skills[@]}"; do
  find_skill "$skill" >/dev/null || missing+=("$skill")
done
if [[ ${#missing[@]} -eq 0 ]]; then
  add_check "Luna native skills" ready "12 skill native rilevate" ""
else
  add_check "Luna native skills" missing_required "mancano: ${missing[*]}" "Reinstalla Luna App Builder e apri una nuova sessione."
fi

existing=false
for signal in .git package.json src app ios android supabase pubspec.yaml Cargo.toml pyproject.toml; do
  [[ -e "$PROJECT_PATH/$signal" ]] && existing=true && break
done
ADOPTION="$PROJECT_PATH/.app-builder/adoption-report.md"
if $existing; then
  [[ -f "$ADOPTION" ]] \
    && add_check "Existing project adoption" ready ".app-builder/adoption-report.md" "" \
    || add_check "Existing project adoption" missing_required "progetto esistente; adoption report assente" "Usa app-project-adoption in sola lettura."
else
  add_check "Existing project adoption" not_applicable "nessun segnale di progetto preesistente" ""
fi

REGISTRY="$PROJECT_PATH/.app-builder/specialists.json"
SECURITY_INDEX="$PROJECT_PATH/.app-builder/security-catalog/index.json"
MARKETING_INDEX="$PROJECT_PATH/.app-builder/marketing-catalog/index.json"
if [[ ! -f "$REGISTRY" ]] && $AUTO_INSTALL && command -v node >/dev/null 2>&1 && command -v npm >/dev/null 2>&1 && command -v git >/dev/null 2>&1; then
  bootstrap=""
  for candidate in \
    "$PROJECT_PATH/.agents/skills/app-builder/scripts/bootstrap-specialists.mjs" \
    "$PROJECT_PATH/.codex/skills/app-builder/scripts/bootstrap-specialists.mjs" \
    "$HOME/.agents/skills/app-builder/scripts/bootstrap-specialists.mjs" \
    "$HOME/.codex/skills/app-builder/scripts/bootstrap-specialists.mjs"; do
    [[ -f "$candidate" ]] && bootstrap="$candidate" && break
  done
  [[ -n "$bootstrap" ]] && node "$bootstrap" --project "$PROJECT_PATH" --approved || true
fi
[[ -f "$REGISTRY" ]] \
  && add_check "Specialist bootstrap" ready ".app-builder/specialists.json" "" \
  || add_check "Specialist bootstrap" missing_optional "non eseguito" "Luna chiede un solo consenso e avvia il bootstrap."
[[ -f "$SECURITY_INDEX" ]] \
  && add_check "Security catalog index" ready ".app-builder/security-catalog/index.json" "" \
  || add_check "Security catalog index" missing_optional "catalogo non indicizzato" "Catalogo completo, attivazione on demand."
[[ -f "$MARKETING_INDEX" ]] \
  && add_check "Marketing catalog index" ready ".app-builder/marketing-catalog/index.json" "" \
  || add_check "Marketing catalog index" missing_optional "catalogo non indicizzato" "Catalogo completo, attivazione on demand."

check_group() {
  local label="$1"; shift
  local found=() skill path
  for skill in "$@"; do
    if path="$(find_skill "$skill" 2>/dev/null)"; then found+=("$skill"); fi
  done
  if [[ ${#found[@]} -gt 0 ]]; then
    add_check "$label" ready "${found[*]}" ""
  else
    add_check "$label" missing_optional "nessuna skill del gruppo rilevata" "Il fallback nativo Luna resta disponibile."
  fi
}
check_group "Skill discovery" find-skills
check_group "Engineering process" using-superpowers brainstorming writing-plans test-driven-development
check_group "PRD specialist" prd-generator
check_group "UX/design specialists" ui-ux-pro-max impeccable
check_group "Brand specialists" build-a-brand design brand design-system
check_group "Copy specialists" product-marketing copywriting copy-editing

PLUGIN_TEXT="$(plugin_inventory)"
EXPO_DETECTED=false
while IFS= read -r pkg; do
  grep -q '"expo"' "$pkg" && EXPO_DETECTED=true && break
done < <(find "$PROJECT_PATH" -path '*/node_modules' -prune -o -name package.json -type f -print | head -n 20)
if $EXPO_DETECTED; then
  if ! grep -Eqi '(^|[^a-z])expo([^a-z]|$)' <<<"$PLUGIN_TEXT" && $AUTO_INSTALL && command -v codex >/dev/null 2>&1; then
    codex plugin add expo@openai-curated || true
    PLUGIN_TEXT="$(plugin_inventory)"
  fi
  grep -Eqi '(^|[^a-z])expo([^a-z]|$)' <<<"$PLUGIN_TEXT" \
    && add_check "Plugin Expo" ready "rilevato" "" \
    || add_check "Plugin Expo" missing_required "stack Expo rilevato; plugin non confermato" "Con consenso installa il plugin ufficiale."
else
  add_check "Plugin Expo" not_applicable_or_unknown "stack Expo non rilevato" "Attivalo soltanto quando serve."
fi

NEEDS_SUPABASE=false
[[ -f "$PROJECT_PATH/supabase/config.toml" ]] && NEEDS_SUPABASE=true
grep -Rqs '"@supabase/' --include package.json --exclude-dir node_modules "$PROJECT_PATH" && NEEDS_SUPABASE=true || true
if grep -Eqi 'supabase' <<<"$PLUGIN_TEXT"; then
  add_check "Plugin Supabase" ready "rilevato" "Verifica autenticazione e progetto separatamente."
elif $NEEDS_SUPABASE; then
  add_check "Plugin Supabase" missing_required "Supabase usato ma plugin non confermato" "Installa e autentica con consenso."
else
  add_check "Plugin Supabase" missing_optional "non richiesto dai file correnti" ""
fi

if grep -Eqi 'codex.?security|codex-security' <<<"$PLUGIN_TEXT"; then
  add_check "Codex Security" ready "plugin rilevato" ""
elif [[ "$MODE" == publication ]] || $NEEDS_SUPABASE; then
  add_check "Codex Security" missing_required "non confermato" "Installa da /plugins e riapri la sessione."
else
  add_check "Codex Security" missing_optional "non confermato" "Consigliato per progetti pubblici o sensibili."
fi

[[ -f "$PROJECT_PATH/.app-builder/state.md" ]] \
  && add_check "Stato App Builder" ready ".app-builder/state.md" "" \
  || add_check "Stato App Builder" missing_required "assente" "Inizializza il progetto."
[[ -f "$PROJECT_PATH/docs/PRODUCT_DISCOVERY.md" ]] \
  && add_check "Product Discovery document" ready "docs/PRODUCT_DISCOVERY.md" "" \
  || add_check "Product Discovery document" missing_optional "documento non presente" "Luna lo crea quando serve."
[[ -f "$PROJECT_PATH/docs/MEASUREMENT_PLAN.md" ]] \
  && add_check "Measurement plan" ready "docs/MEASUREMENT_PLAN.md" "" \
  || add_check "Measurement plan" missing_optional "documento non presente" "Luna lo crea per outcome, beta o analytics."

if [[ "$OUTPUT_PATH" = /* ]]; then FULL_OUTPUT="$OUTPUT_PATH"; else FULL_OUTPUT="$PROJECT_PATH/$OUTPUT_PATH"; fi
mkdir -p "$(dirname "$FULL_OUTPUT")"
{
  echo "# App Builder Doctor"
  echo
  echo "- Data: $(date '+%Y-%m-%d %H:%M:%S')"
  echo "- Progetto: $PROJECT_PATH"
  echo "- Modalità richiesta: $MODE"
  echo "- Progetto preesistente rilevato: $existing"
  echo "- Bootstrap autorizzato in questa esecuzione: $AUTO_INSTALL"
  echo
  echo "| Capability | Stato | Evidenza | Prossima azione |"
  echo "|---|---|---|---|"
  printf '%s\n' "${rows[@]}"
  echo
  echo "> Il report non prova autenticazione o caricamento nella chat. Luna completa il post-check senza salvare token."
} > "$FULL_OUTPUT"
printf '%s\n' "${rows[@]}"
echo "Report: $FULL_OUTPUT"
