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

plugin_inventory() {
  if ! command -v codex >/dev/null 2>&1; then return 0; fi
  codex plugin list 2>&1 || codex plugins list 2>&1 || true
}

GIT_V="$(command_info git --version)"
[[ -n "$GIT_V" ]] && add_check Git ready "$GIT_V" "" || add_check Git missing_required "comando non trovato" "Installa Git se il progetto va versionato."
NODE_V="$(command_info node --version)"
[[ -n "$NODE_V" ]] && add_check Node.js ready "$NODE_V" "" || add_check Node.js missing_optional "comando non trovato" "Richiesto da Expo e molti stack web."
NPM_V="$(command_info npm --version)"
[[ -n "$NPM_V" ]] && add_check npm ready "v$NPM_V" "" || add_check npm missing_optional "comando non trovato" "Installa insieme a Node.js."
CODEX_V="$(command_info codex --version)"
[[ -n "$CODEX_V" ]] && add_check Codex ready "$CODEX_V" "" || add_check Codex missing_required "comando non trovato" "Installa o accedi a Codex."

AB=""
for p in "$PROJECT_PATH/.agents/skills/app-builder/SKILL.md" "$HOME/.agents/skills/app-builder/SKILL.md" "$HOME/.codex/skills/app-builder/SKILL.md"; do
  [[ -f "$p" ]] && AB="$p" && break
done
[[ -n "$AB" ]] && add_check "Luna App Builder" ready "$AB" "" || add_check "Luna App Builder" missing_required "skill non trovata" "Esegui scripts/install.sh."

PLUGIN_TEXT="$(plugin_inventory)"
EXPO_DETECTED=false
while IFS= read -r pkg; do
  grep -q '"expo"' "$pkg" && EXPO_DETECTED=true && break
done < <(find "$PROJECT_PATH" -path '*/node_modules' -prune -o -name package.json -type f -print | head -n 20)

if $EXPO_DETECTED; then
  if ! grep -Eqi '(^|[^a-z])expo([^a-z]|$)' <<<"$PLUGIN_TEXT" && $AUTO_INSTALL && command -v codex >/dev/null 2>&1; then
    echo "Installazione Expo autorizzata dall'utente..."
    codex plugin add expo@openai-curated || true
    PLUGIN_TEXT="$(plugin_inventory)"
  fi
  grep -Eqi '(^|[^a-z])expo([^a-z]|$)' <<<"$PLUGIN_TEXT" \
    && add_check "Plugin Expo" ready "rilevato nel catalogo Codex" "Esegui un post-check nella nuova sessione." \
    || add_check "Plugin Expo" missing_required "stack Expo rilevato; plugin non confermato" "Con consenso: codex plugin add expo@openai-curated, poi nuova sessione."
else
  add_check "Plugin Expo" not_applicable_or_unknown "stack Expo non rilevato" "Attivalo solo se serve."
fi

NEEDS_SUPABASE=false
[[ -f "$PROJECT_PATH/supabase/config.toml" ]] && NEEDS_SUPABASE=true
grep -Rqs '"@supabase/' --include package.json --exclude-dir node_modules "$PROJECT_PATH" && NEEDS_SUPABASE=true || true
if $NEEDS_SUPABASE && ! grep -Eqi 'supabase' <<<"$PLUGIN_TEXT" && $AUTO_INSTALL && command -v npx >/dev/null 2>&1; then
  echo "Installazione Supabase autorizzata dall'utente..."
  npx plugins add supabase-community/supabase-plugin --yes || true
  PLUGIN_TEXT="$(plugin_inventory)"
fi
if grep -Eqi 'supabase' <<<"$PLUGIN_TEXT"; then
  add_check "Plugin Supabase" ready "plugin rilevato" "Verifica separatamente autenticazione, progetto e permessi."
elif $NEEDS_SUPABASE; then
  add_check "Plugin Supabase" missing_required "Supabase usato dal progetto" "Con consenso: npx plugins add supabase-community/supabase-plugin --yes; poi autentica."
else
  add_check "Plugin Supabase" missing_optional "non richiesto dai file correnti" ""
fi

if grep -Eqi 'codex.?security|codex-security' <<<"$PLUGIN_TEXT"; then
  add_check "Codex Security" ready "plugin rilevato" "Verifica le skill namespaced nella nuova sessione."
elif [[ "$MODE" == publication ]]; then
  add_check "Codex Security" missing_required "non confermato" "Installa il plugin ufficiale da /plugins e riapri la sessione."
else
  add_check "Codex Security" missing_optional "non confermato" "Consigliato per progetti pubblici o sensibili."
fi

[[ -f "$PROJECT_PATH/.app-builder/state.md" ]] \
  && add_check "Stato App Builder" ready ".app-builder/state.md" "" \
  || add_check "Stato App Builder" missing_required "assente" "Esegui scripts/init-project.sh."

if [[ "$OUTPUT_PATH" = /* ]]; then FULL_OUTPUT="$OUTPUT_PATH"; else FULL_OUTPUT="$PROJECT_PATH/$OUTPUT_PATH"; fi
mkdir -p "$(dirname "$FULL_OUTPUT")"
{
  echo "# App Builder Doctor"
  echo
  echo "- Data: $(date '+%Y-%m-%d %H:%M:%S')"
  echo "- Progetto: $PROJECT_PATH"
  echo "- Modalità richiesta: $MODE"
  echo "- Installazioni autorizzate in questa esecuzione: $AUTO_INSTALL"
  echo
  echo "| Capability | Stato | Evidenza | Prossima azione |"
  echo "|---|---|---|---|"
  printf '%s\n' "${rows[@]}"
  echo
  echo "> Il report non prova autenticazione o caricamento nella chat. Luna completa il post-check senza salvare token."
} > "$FULL_OUTPUT"
printf '%s\n' "${rows[@]}"
echo "Report: $FULL_OUTPUT"
