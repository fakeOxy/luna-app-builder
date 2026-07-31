#!/usr/bin/env node
import { spawnSync } from "node:child_process";
import { existsSync, mkdirSync, readFileSync, readdirSync, statSync, writeFileSync } from "node:fs";
import { dirname, join, resolve } from "node:path";

const SECURITY_REPOSITORY = "https://github.com/mukul975/Anthropic-Cybersecurity-Skills.git";
const SECURITY_COMMIT = "673da1f3b0b7be34ffc9624ef3858fe45f1c3bed";
const args = process.argv.slice(2);
const valueOf = (flag, fallback = undefined) => {
  const index = args.indexOf(flag);
  return index >= 0 ? args[index + 1] : fallback;
};
const has = (flag) => args.includes(flag);
const project = resolve(valueOf("--project", process.cwd()));
const approved = has("--approved");
const dryRun = has("--dry-run");
const refresh = has("--refresh");

if (!existsSync(project) || !statSync(project).isDirectory()) {
  console.error(`Cartella progetto non trovata: ${project}`);
  process.exit(2);
}
if (!approved && !dryRun) {
  console.error("Bootstrap non autorizzato. Luna deve ottenere un consenso esplicito e ripetere con --approved.");
  process.exit(3);
}

const isWindows = process.platform === "win32";
const npx = isWindows ? "npx.cmd" : "npx";
const git = isWindows ? "git.exe" : "git";
const appBuilder = join(project, ".app-builder");
const vendorRoot = join(appBuilder, "vendor");
const securityRoot = join(vendorRoot, "anthropic-cybersecurity-skills");
const reportPath = join(appBuilder, "bootstrap-report.md");
const registryPath = join(appBuilder, "specialists.json");
const securityIndexPath = join(appBuilder, "security-catalog", "index.json");
mkdirSync(appBuilder, { recursive: true });

const results = [];
function run(label, command, commandArgs, cwd = project) {
  const rendered = [command, ...commandArgs].join(" ");
  if (dryRun) {
    results.push({ label, status: "dry_run", command: rendered, detail: "non eseguito" });
    return true;
  }
  const result = spawnSync(command, commandArgs, {
    cwd,
    encoding: "utf8",
    shell: false,
    maxBuffer: 10 * 1024 * 1024,
  });
  const output = `${result.stdout || ""}\n${result.stderr || ""}`.trim().replace(/\r?\n/g, " ").slice(0, 1200);
  const ok = result.status === 0;
  results.push({ label, status: ok ? "ready" : "failed_optional", command: rendered, detail: output || `exit ${result.status}` });
  return ok;
}

const externalInstalls = [
  ["PRD Generator", npx, ["skills", "add", "jamesrochabrun/skills", "--skill", "prd-generator", "-a", "codex", "--copy", "-y"]],
  ["Marketing copy skills", npx, ["skills", "add", "coreyhaines31/marketingskills", "--skill", "product-marketing", "copywriting", "copy-editing", "-a", "codex", "--copy", "-y"]],
  ["Impeccable UX writing and audit", npx, ["skills", "add", "pbakaus/impeccable", "-a", "codex", "--copy", "-y"]],
  ["UI UX Pro Max", npx, ["-y", "uipro-cli", "init", "--ai", "codex"]],
  ["Brand and design helpers", npx, ["skills", "add", "nextlevelbuilder/ui-ux-pro-max-skill", "--skill", "design", "brand", "design-system", "-a", "codex", "--copy", "-y"]],
];

for (const [label, command, commandArgs] of externalInstalls) {
  run(label, command, commandArgs);
}

function gitHead(folder) {
  if (!existsSync(folder)) return null;
  const result = spawnSync(git, ["-C", folder, "rev-parse", "HEAD"], { encoding: "utf8", shell: false });
  return result.status === 0 ? result.stdout.trim() : null;
}

if (dryRun) {
  results.push({
    label: "Cybersecurity catalog",
    status: "dry_run",
    command: `git clone/fetch ${SECURITY_REPOSITORY} @ ${SECURITY_COMMIT}`,
    detail: "il catalogo completo verrebbe scaricato in .app-builder/vendor senza registrare 817 trigger attivi",
  });
} else {
  mkdirSync(vendorRoot, { recursive: true });
  const current = gitHead(securityRoot);
  if (!current) {
    const cloned = run("Cybersecurity catalog clone", git, ["clone", "--filter=blob:none", "--no-checkout", SECURITY_REPOSITORY, securityRoot]);
    if (cloned) {
      run("Cybersecurity catalog pin", git, ["-C", securityRoot, "fetch", "--depth", "1", "origin", SECURITY_COMMIT]);
      run("Cybersecurity catalog checkout", git, ["-C", securityRoot, "checkout", "--detach", SECURITY_COMMIT]);
    }
  } else if (current !== SECURITY_COMMIT && refresh) {
    run("Cybersecurity catalog refresh", git, ["-C", securityRoot, "fetch", "--depth", "1", "origin", SECURITY_COMMIT]);
    run("Cybersecurity catalog checkout", git, ["-C", securityRoot, "checkout", "--detach", SECURITY_COMMIT]);
  } else {
    results.push({
      label: "Cybersecurity catalog",
      status: current === SECURITY_COMMIT ? "ready" : "installed_different_pin",
      command: `git -C ${securityRoot} rev-parse HEAD`,
      detail: current,
    });
  }
}

function firstFrontmatter(text) {
  const match = text.match(/^---\s*\n([\s\S]*?)\n---/);
  return match ? match[1] : "";
}
function field(frontmatter, name) {
  const match = frontmatter.match(new RegExp(`^${name}:\\s*["']?([^\\n"']+)`, "m"));
  return match ? match[1].trim() : null;
}
function classify(name) {
  const blocked = /(credential-theft|deploying-malware|ransomware-attack|destructive|data-exfiltration)/i;
  const restricted = /(exploiting|phishing|bypass|persistence|lateral-movement|command-and-control|\bc2\b|credential|evasion|red-team)/i;
  const defensive = /^(implementing|securing|scanning|generating|testing|performing|detecting|hardening|building-security|conducting-security)/i;
  if (blocked.test(name)) return "blocked";
  if (restricted.test(name)) return "restricted";
  if (defensive.test(name)) return "defensive";
  return "dual_use";
}

let securityCount = 0;
if (!dryRun && existsSync(join(securityRoot, "skills"))) {
  const entries = [];
  for (const folder of readdirSync(join(securityRoot, "skills"), { withFileTypes: true })) {
    if (!folder.isDirectory()) continue;
    const skillPath = join(securityRoot, "skills", folder.name, "SKILL.md");
    if (!existsSync(skillPath)) continue;
    const text = readFileSync(skillPath, "utf8");
    const frontmatter = firstFrontmatter(text);
    entries.push({
      name: field(frontmatter, "name") || folder.name,
      folder: folder.name,
      description: field(frontmatter, "description"),
      domain: field(frontmatter, "domain"),
      subdomain: field(frontmatter, "subdomain"),
      classification: classify(folder.name),
      path: skillPath,
    });
  }
  entries.sort((a, b) => a.name.localeCompare(b.name));
  securityCount = entries.length;
  mkdirSync(dirname(securityIndexPath), { recursive: true });
  writeFileSync(
    securityIndexPath,
    JSON.stringify({
      repository: SECURITY_REPOSITORY,
      commit: gitHead(securityRoot),
      generatedAt: new Date().toISOString(),
      activation: "on_demand_only",
      count: entries.length,
      entries,
    }, null, 2) + "\n",
    "utf8",
  );
}

const registry = {
  generatedAt: new Date().toISOString(),
  project,
  consent: approved,
  dryRun,
  securityCatalog: {
    repository: SECURITY_REPOSITORY,
    pinnedCommit: SECURITY_COMMIT,
    path: securityRoot,
    indexedSkills: securityCount,
    activation: "on_demand_only",
  },
  results,
};
writeFileSync(registryPath, JSON.stringify(registry, null, 2) + "\n", "utf8");

const lines = [
  "# Luna Specialist Bootstrap",
  "",
  `- Data: ${new Date().toISOString()}`,
  `- Progetto: ${project}`,
  `- Consenso esplicito: ${approved}`,
  `- Dry run: ${dryRun}`,
  `- Skill sicurezza indicizzate: ${securityCount || "non calcolate"}`,
  "",
  "| Capability | Stato | Comando | Evidenza |",
  "|---|---|---|---|",
];
for (const item of results) {
  const safe = String(item.detail || "").replace(/\|/g, "\\|");
  lines.push(`| ${item.label} | ${item.status} | \`${item.command}\` | ${safe} |`);
}
lines.push(
  "",
  "> Il catalogo sicurezza è disponibile localmente ma non viene caricato interamente come skill attive. Luna seleziona i playbook pertinenti e richiede consenso separato prima di strumenti invasivi.",
  "",
);
writeFileSync(reportPath, lines.join("\n"), "utf8");
console.log(`Bootstrap completato. Report: ${reportPath}`);
