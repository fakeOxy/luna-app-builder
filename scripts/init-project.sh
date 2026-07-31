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
PROJECT_ORIGIN="new"
while IFS= read -r entry; do
  base="$(basename "$entry")"
  case "$base" in .app-builder|.agents|.codex|docs) continue ;; esac
  PROJECT_ORIGIN="existing"
  break
done < <(find "$PROJECT" -mindepth 1 -maxdepth 1 -print)
for signal in .git package.json src app ios android supabase pubspec.yaml Cargo.toml pyproject.toml; do
  [[ -e "$PROJECT/$signal" ]] && PROJECT_ORIGIN="existing"
done
ADOPTION_STATUS="not_applicable"
[[ "$PROJECT_ORIGIN" == existing ]] && ADOPTION_STATUS="pending"

mkdir -p "$PROJECT/.app-builder/chat-prompts" "$PROJECT/.app-builder/handoffs" "$PROJECT/docs"

render() {
  local source="$1" destination="$2" content
  content="$(cat "$source")"
  content="${content//\{\{PROJECT_NAME\}\}/$NAME}"
  content="${content//\{\{PROJECT_MODE\}\}/$MODE}"
  content="${content//\{\{PROJECT_ROOT\}\}/$PROJECT}"
  content="${content//\{\{PROJECT_ORIGIN\}\}/$PROJECT_ORIGIN}"
  content="${content//\{\{ADOPTION_STATUS\}\}/$ADOPTION_STATUS}"
  content="${content//\{\{DATE\}\}/$DATE}"
  content="${content//\{PROJECT_NAME\}/$NAME}"
  content="${content//\{PROJECT_MODE\}/$MODE}"
  content="${content//\{PROJECT_ROOT\}/$PROJECT}"
  content="${content//\{PROJECT_ORIGIN\}/$PROJECT_ORIGIN}"
  content="${content//\{ADOPTION_STATUS\}/$ADOPTION_STATUS}"
  content="${content//\{DATE\}/$DATE}"
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
echo "Origine rilevata: $PROJECT_ORIGIN"
echo "Avvia Codex nella cartella e usa \$app-builder. Nessun segreto è stato creato o copiato."
