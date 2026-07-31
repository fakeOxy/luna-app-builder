#!/usr/bin/env python3
"""Static validation for Luna App Builder.

Validates package metadata, native skills, autonomous routing, bootstrap safety,
templates, attribution, obvious secret leaks and the committed integrity manifest.
It never contacts third parties or runs installers.
"""
from __future__ import annotations

import hashlib
import json
import re
import sys
from pathlib import Path
from typing import Any

try:
    import yaml
except ImportError as exc:  # pragma: no cover
    raise SystemExit("PyYAML non installato. Esegui: python -m pip install pyyaml") from exc

ROOT = Path(__file__).resolve().parents[1]
EXPECTED_REPOSITORY = "https://github.com/fakeOxy/luna-app-builder"
EXPECTED_CREATOR = "Massimiliano"
EXPECTED_PLUGIN_NAME = "luna-app-builder"
EXPECTED_SKILLS = {
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
    "app-security-orchestrator",
}
ALLOWED_TEMPLATE_KEYS = {"PROJECT_NAME", "PROJECT_MODE", "PROJECT_ROOT", "DATE", "HANDOFF_ID"}
IGNORED_PARTS = {".git", "__pycache__", ".pytest_cache", ".mypy_cache", "node_modules"}
SECURITY_REPOSITORY = "https://github.com/mukul975/Anthropic-Cybersecurity-Skills.git"
SECURITY_PIN = "673da1f3b0b7be34ffc9624ef3858fe45f1c3bed"

errors: list[str] = []
warnings: list[str] = []


def fail(message: str) -> None:
    errors.append(message)


def warn(message: str) -> None:
    warnings.append(message)


def ignored(path: Path) -> bool:
    return any(part in IGNORED_PARTS for part in path.parts)


def read_text(path: Path) -> str:
    try:
        return path.read_text(encoding="utf-8")
    except FileNotFoundError:
        fail(f"File mancante: {path.relative_to(ROOT)}")
        return ""
    except UnicodeDecodeError:
        fail(f"File non UTF-8: {path.relative_to(ROOT)}")
        return ""


def load_json(path: Path) -> dict[str, Any]:
    try:
        data = json.loads(read_text(path))
    except json.JSONDecodeError as exc:
        fail(f"JSON non valido in {path.relative_to(ROOT)}: {exc}")
        return {}
    if not isinstance(data, dict):
        fail(f"JSON radice non oggetto in {path.relative_to(ROOT)}")
        return {}
    return data


def load_yaml_text(text: str, label: str) -> dict[str, Any]:
    try:
        data = yaml.safe_load(text)
    except yaml.YAMLError as exc:
        fail(f"YAML non valido in {label}: {exc}")
        return {}
    if not isinstance(data, dict):
        fail(f"YAML radice non oggetto in {label}")
        return {}
    return data


def parse_frontmatter(path: Path) -> tuple[dict[str, Any], str]:
    text = read_text(path)
    match = re.match(r"\A---\r?\n(.*?)\r?\n---\r?\n", text, re.DOTALL)
    if not match:
        fail(f"Frontmatter YAML mancante o malformato: {path.relative_to(ROOT)}")
        return {}, text
    return load_yaml_text(match.group(1), str(path.relative_to(ROOT))), text[match.end() :]


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


required_paths = [
    ".agents/plugins/marketplace.json",
    ".codex-plugin/plugin.json",
    ".github/workflows/validate.yml",
    "README.md",
    "NOTICE",
    "CREDITS.md",
    "LICENSE.txt",
    "SECURITY.md",
    "creator.json",
    "integrity-manifest.json",
    "docs/VALIDATION.md",
    "scripts/install.sh",
    "scripts/install.ps1",
    "scripts/init-project.sh",
    "scripts/init-project.ps1",
    "scripts/doctor.sh",
    "scripts/doctor.ps1",
    "scripts/generate_integrity_manifest.py",
    "scripts/verify-integrity.sh",
    "scripts/verify-integrity.ps1",
    "scripts/validate_repository.py",
    "templates/state.md",
    "templates/app-builder.config.json",
    "templates/docs/PRODUCT_DISCOVERY.md",
    "templates/docs/REQUIREMENTS.md",
    "templates/docs/BRAND.md",
    "templates/docs/ASSET_INVENTORY.md",
    "templates/docs/USER_FLOWS.md",
    "templates/docs/ACCESSIBILITY.md",
    "templates/docs/COPY_SYSTEM.md",
    "templates/docs/SECURITY_PLAN.md",
    "skills/app-builder/scripts/bootstrap-specialists.mjs",
    "skills/app-builder/references/autonomous-routing.md",
    "skills/app-builder/references/specialist-bootstrap.md",
    "skills/app-builder/references/external-specialists.md",
    "skills/app-security-orchestrator/references/security-selection.md",
]
for relative in required_paths:
    if not (ROOT / relative).is_file():
        fail(f"File obbligatorio mancante: {relative}")

for path in sorted(ROOT.rglob("*.json")):
    if not ignored(path):
        load_json(path)
for suffix in ("*.yaml", "*.yml"):
    for path in sorted(ROOT.rglob(suffix)):
        if not ignored(path):
            load_yaml_text(read_text(path), str(path.relative_to(ROOT)))

creator = load_json(ROOT / "creator.json")
plugin = load_json(ROOT / ".codex-plugin/plugin.json")
marketplace = load_json(ROOT / ".agents/plugins/marketplace.json")
manifest = load_json(ROOT / "integrity-manifest.json")
config = load_json(ROOT / "templates/app-builder.config.json")
version = creator.get("version")

if not isinstance(version, str) or not re.fullmatch(r"\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?", version):
    fail("creator.json.version non segue SemVer")
for label, value in {
    "plugin version": plugin.get("version"),
    "manifest version": manifest.get("version"),
}.items():
    if value != version:
        fail(f"Versione incoerente: {label}={value!r}, creator={version!r}")
if creator.get("creator") != EXPECTED_CREATOR or manifest.get("creator") != EXPECTED_CREATOR:
    fail("Credito del creatore incoerente")
if creator.get("officialRepository") != EXPECTED_REPOSITORY or manifest.get("officialRepository") != EXPECTED_REPOSITORY:
    fail("Repository ufficiale incoerente")
if plugin.get("name") != EXPECTED_PLUGIN_NAME or plugin.get("skills") != "./skills/":
    fail("Metadati plugin non validi")
if plugin.get("author", {}).get("name") != EXPECTED_CREATOR:
    fail("Autore plugin non coerente")
if plugin.get("interface", {}).get("developerName") != EXPECTED_CREATOR:
    fail("developerName plugin non coerente")

plugins = marketplace.get("plugins")
if not isinstance(plugins, list) or len(plugins) != 1:
    fail("Il marketplace deve esporre esattamente un plugin")
else:
    item = plugins[0]
    source = item.get("source", {})
    if item.get("name") != EXPECTED_PLUGIN_NAME:
        fail("Nome plugin marketplace non coerente")
    if source.get("source") != "local" or source.get("path") != "./":
        fail("Il marketplace deve usare source local con path ./")
    if item.get("policy", {}).get("installation") != "AVAILABLE":
        fail("Policy marketplace installation deve essere AVAILABLE")

skills_root = ROOT / "skills"
actual_skills = {path.name for path in skills_root.iterdir() if path.is_dir()} if skills_root.is_dir() else set()
if actual_skills != EXPECTED_SKILLS:
    fail(f"Set skill inatteso. Attese={sorted(EXPECTED_SKILLS)}, trovate={sorted(actual_skills)}")
for skill_name in sorted(actual_skills):
    skill_dir = skills_root / skill_name
    skill_file = skill_dir / "SKILL.md"
    agent_file = skill_dir / "agents/openai.yaml"
    if not skill_file.is_file():
        fail(f"SKILL.md mancante per {skill_name}")
        continue
    metadata, body = parse_frontmatter(skill_file)
    if metadata.get("name") != skill_name:
        fail(f"Nome frontmatter non coincide con cartella: {skill_name}")
    description = metadata.get("description")
    if not isinstance(description, str) or len(description.strip()) < 40:
        fail(f"Descrizione skill troppo breve: {skill_name}")
    if not body.strip().startswith("#"):
        fail(f"Corpo skill senza titolo: {skill_name}")
    if not agent_file.is_file():
        fail(f"agents/openai.yaml mancante per {skill_name}")
    else:
        interface = load_yaml_text(read_text(agent_file), str(agent_file.relative_to(ROOT))).get("interface", {})
        for key in ("display_name", "short_description", "default_prompt"):
            if not isinstance(interface.get(key), str) or not interface[key].strip():
                fail(f"{agent_file.relative_to(ROOT)}: interface.{key} mancante")

main_skill = read_text(ROOT / "skills/app-builder/SKILL.md")
for reference in sorted(set(re.findall(r"references/[A-Za-z0-9_.-]+\.md", main_skill))):
    if not (ROOT / "skills/app-builder" / reference).is_file():
        fail(f"Riferimento inesistente nella skill principale: {reference}")
for routed in (
    "$app-project-adoption",
    "$app-product-discovery",
    "$app-requirements-mvp",
    "$app-brand-assets",
    "$app-ux-accessibility",
    "$app-copywriting",
    "$app-security-orchestrator",
):
    if routed not in main_skill:
        fail(f"Routing autonomo mancante: {routed}")
if "non deve conoscere i nomi delle skill" not in main_skill:
    fail("Luna non dichiara il routing autonomo")
if "Le app create non devono mostrare i crediti" not in main_skill:
    fail("Crediti del pacchetto non separati dalle app generate")

for relative in ("README.md", "NOTICE", "CREDITS.md", "skills/app-builder/SKILL.md"):
    if EXPECTED_CREATOR not in read_text(ROOT / relative):
        fail(f"Credito del creatore mancante in {relative}")

for path in sorted((ROOT / "templates").rglob("*")):
    if not path.is_file():
        continue
    text = read_text(path)
    for match in re.finditer(r"\{\{([A-Z0-9_]+)\}\}", text):
        if match.group(1) not in ALLOWED_TEMPLATE_KEYS:
            fail(f"Placeholder non supportato {match.group(0)} in {path.relative_to(ROOT)}")
if config.get("appBuilder", {}).get("creator") != EXPECTED_CREATOR:
    fail("Il config template non conserva il credito")
if config.get("appBuilder", {}).get("routing") != "autonomous":
    fail("Routing config non autonomo")
if config.get("routing", {}).get("askUserToChooseSkill") is not False:
    fail("Il config permette di scaricare la scelta skill sull'utente")
if config.get("bootstrap", {}).get("automaticAfterConsent") is not True:
    fail("Bootstrap automatico dopo consenso non configurato")
if config.get("bootstrap", {}).get("securityCatalog", {}).get("activateOnDemandOnly") is not True:
    fail("Catalogo sicurezza non limitato all'attivazione on demand")

bootstrap = read_text(ROOT / "skills/app-builder/scripts/bootstrap-specialists.mjs")
for required in (SECURITY_REPOSITORY, SECURITY_PIN, "--approved", "--dry-run", "on_demand_only"):
    if required not in bootstrap:
        fail(f"Bootstrap privo del vincolo richiesto: {required}")
for forbidden in ("shell: true", "curl ", "wget ", "Invoke-Expression", "--skill \"*\" -a codex"):
    if forbidden in bootstrap:
        fail(f"Bootstrap contiene pattern non consentito: {forbidden}")
if "Anthropic-Cybersecurity-Skills", "--skill" in ():  # pragma: no cover - keeps formatter quiet
    pass
if re.search(r"Anthropic-Cybersecurity-Skills[^\n]+--skill", bootstrap):
    fail("Il catalogo sicurezza non deve essere registrato in blocco come skill attive")

forbidden_names = re.compile(r"(^|/)(\.env($|\.)|.*\.(p8|p12|jks|keystore|pem|key))$", re.IGNORECASE)
secret_patterns = [
    ("private key", re.compile(r"-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----")),
    ("GitHub token", re.compile(r"\bgh[pousr]_[A-Za-z0-9]{30,}\b")),
    ("OpenAI key", re.compile(r"\bsk-[A-Za-z0-9_-]{20,}\b")),
    ("Stripe live key", re.compile(r"\b(?:sk|rk)_live_[A-Za-z0-9]{16,}\b")),
]
for path in sorted(ROOT.rglob("*")):
    if not path.is_file() or ignored(path):
        continue
    relative = path.relative_to(ROOT).as_posix()
    if forbidden_names.search(relative):
        fail(f"Possibile file segreto incluso: {relative}")
    if path.stat().st_size > 1_000_000:
        warn(f"File grande non analizzato per segreti: {relative}")
        continue
    try:
        text = path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        continue
    for label, pattern in secret_patterns:
        if pattern.search(text):
            fail(f"Possibile {label} incluso in {relative}")

installer_text = "\n".join(read_text(ROOT / p) for p in ("scripts/install.sh", "scripts/install.ps1"))
for label, pattern in {
    "download ed esecuzione remota": r"(?:curl|wget|Invoke-WebRequest).*(?:\||iex|Invoke-Expression|bash|sh)",
    "modifica permanente ExecutionPolicy": r"Set-ExecutionPolicy",
    "cancellazione root": r"rm\s+-rf\s+/(?:\s|$)",
}.items():
    if re.search(pattern, installer_text, re.IGNORECASE):
        fail(f"Pattern pericoloso negli installer: {label}")

entries = manifest.get("files")
if not isinstance(entries, list):
    fail("integrity-manifest.json.files deve essere una lista")
    entries = []
manifest_paths: set[str] = set()
for entry in entries:
    if not isinstance(entry, dict):
        fail("Voce non oggetto nel manifesto")
        continue
    relative = entry.get("path")
    if not isinstance(relative, str) or not relative or relative.startswith("/") or ".." in Path(relative).parts:
        fail(f"Path manifesto non sicuro: {relative!r}")
        continue
    if relative in manifest_paths:
        fail(f"Voce duplicata nel manifesto: {relative}")
        continue
    manifest_paths.add(relative)
    path = ROOT / relative
    if not path.is_file():
        fail(f"File del manifesto mancante: {relative}")
        continue
    if entry.get("size") != path.stat().st_size:
        fail(f"Dimensione manifesto errata per {relative}")
    if entry.get("sha256") != sha256(path):
        fail(f"Checksum manifesto errato per {relative}")

repository_files = {
    path.relative_to(ROOT).as_posix()
    for path in ROOT.rglob("*")
    if path.is_file() and path.name != "integrity-manifest.json" and not ignored(path)
}
missing_from_manifest = sorted(repository_files - manifest_paths)
extra_in_manifest = sorted(manifest_paths - repository_files)
if missing_from_manifest:
    fail("File non coperti dal manifesto: " + ", ".join(missing_from_manifest))
if extra_in_manifest:
    fail("Voci manifesto senza file: " + ", ".join(extra_in_manifest))

if warnings:
    print("Avvisi:")
    for message in warnings:
        print(f"  - {message}")
if errors:
    print("Errori di validazione:", file=sys.stderr)
    for message in errors:
        print(f"  - {message}", file=sys.stderr)
    raise SystemExit(1)

print(f"Validazione completata: {len(repository_files)} file coperti, {len(actual_skills)} skill native valide, versione {version}.")
