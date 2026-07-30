#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'TXT'
Uso:
  init-project.sh --name "Nome app" [--mode personal|prototype|publication] [--path /percorso] [--force]
  init-project.sh "Nome app" [personal|prototype|publication] [/percorso]
TXT
}

NAME=""
MODE="personal"
PROJECT="$(pwd)"
FORCE=false

if [[ $# -gt 0 && "$1" != --* ]]; then
  NAME="$1"
  MODE="${2:-personal}"
  PROJECT="${3:-$(pwd)}"
else
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --name) NAME="${2:?Manca il valore di --name}"; shift 2 ;;
      --mode) MODE="${2:?Manca il valore di --mode}"; shift 2 ;;
      --path) PROJECT="${2:?Manca il valore di --path}"; shift 2 ;;
      --force) FORCE=true; shift ;;
      -h|--help) usage; exit 0 ;;
      *) echo "Argomento sconosciuto: $1" >&2; usage; exit 2 ;;
    esac
  done
fi

[[ -n "$NAME" ]] || { usage; exit 2; }
case "$MODE" in personal|prototype|publication) ;; *) echo "Modalità non valida: $MODE" >&2; exit 2;; esac

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT="$(mkdir -p "$PROJECT" && cd "$PROJECT" && pwd)"
DATE="$(date +%F)"
mkdir -p "$PROJECT/.app-builder/chat-prompts" "$PROJECT/.app-builder/handoffs" "$PROJECT/docs"

render() {
  local source="$1" destination="$2" content
  content="$(cat "$source")"
  content="${content//\{\{PROJECT_NAME\}\}/"$NAME"}"
  content="${content//\{\{PROJECT_MODE\}\}/"$MODE"}"
  content="${content//\{\{PROJECT_ROOT\}\}/"$PROJECT"}"
  content="${content//\{\{DATE\}\}/"$DATE"}"
  content="${content//\{PROJECT_NAME\}/"$NAME"}"
  content="${content//\{PROJECT_MODE\}/"$MODE"}"
  content="${content//\{PROJECT_ROOT\}/"$PROJECT"}"
  content="${content//\{DATE\}/"$DATE"}"
  printf '%s\n' "$content" > "$destination"
}

copy_rendered() {
  local source="$1" destination="$2"
  if [[ -e "$destination" && "$FORCE" != true ]]; then
    echo "Preservato: $destination"
    return
  fi
  mkdir -p "$(dirname "$destination")"
  render "$source" "$destination"
  echo "Creato: $destination"
}

copy_rendered "$ROOT/templates/state.md" "$PROJECT/.app-builder/state.md"
copy_rendered "$ROOT/templates/app-builder.config.json" "$PROJECT/.app-builder/config.json"
copy_rendered "$ROOT/templates/chat-prompts/design.md" "$PROJECT/.app-builder/chat-prompts/design.md"
copy_rendered "$ROOT/templates/chat-prompts/development.md" "$PROJECT/.app-builder/chat-prompts/development.md"
copy_rendered "$ROOT/templates/handoff.md" "$PROJECT/.app-builder/handoffs/HANDOFF-TEMPLATE.md"
copy_rendered "$ROOT/templates/handoffs/README.md" "$PROJECT/.app-builder/handoffs/README.md"
for f in "$ROOT"/templates/docs/*; do
  copy_rendered "$f" "$PROJECT/docs/$(basename "$f")"
done

echo "Progetto inizializzato: $PROJECT"
echo "Avvia Codex nella cartella e usa \$app-builder. Nessun segreto è stato creato o copiato."
