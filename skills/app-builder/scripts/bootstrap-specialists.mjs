#!/usr/bin/env node
import { spawnSync } from "node:child_process";
import {
  appendFileSync,
  existsSync,
  mkdirSync,
  readFileSync,
  readdirSync,
  statSync,
  writeFileSync,
} from "node:fs";
import { dirname, join, relative, resolve } from "node:path";

const SECURITY_REPOSITORY = "https://github.com/mukul975/Anthropic-Cybersecurity-Skills.git";
const SECURITY_COMMIT = "673da1f3b0b7be34ffc9624ef3858fe45f1c3bed";
const MARKETING_REPOSITORY = "https://github.com/coreyhaines31/marketingskills.git";
const MARKETING_COMMIT = "7868cb9251fad80a73d26e488a5ad5f6c4a9f335";
const FIND_SKILLS_REPOSITORY = "vercel-labs/skills";
const SUPERPOWERS_REPOSITORY = "obra/superpowers";

const args = process.argv.slice(2);
const valueOf = (flag, fallback) => {
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
const marketingRoot = join(vendorRoot, "marketing-skills");
const reportPath = join(appBuilder, "bootstrap-report.md");
const registryPath = join(appBuilder, "specialists.json");
const securityIndexPath = join(appBuilder, "security-catalog", "index.json");
const marketingIndexPath = join(appBuilder, "marketing-catalog", "index.json");
mkdirSync(appBuilder, { recursive: true });

const results = [];
const portable = (value) => String(value ?? "").split(project).join(".");

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
  const output = `${result.stdout || ""}\n${result.stderr || ""}`
    .trim()
    .replace(/\r?\n/g, " ")
    .slice(0, 1600);
  const ok = result.status === 0;
  results.push({
    label,
    status: ok ? "ready" : "failed_optional",
    command: rendered,
    detail: output || `exit ${result.status}`,
  });
  return ok;
}

function protectLocalCacheFromGit() {
  const gitExclude = join(project, ".git", "info", "exclude");
  const entries = [
    ".app-builder/vendor/",
    ".app-builder/security-catalog/",
    ".app-builder/marketing-catalog/",
  ];
  if (dryRun) {
    results.push({
      label: "Git local exclude",
      status: "dry_run",
      command: "append Luna local caches to .git/info/exclude",
      detail: "nessuna modifica eseguita",
    });
    return;
  }
  if (!existsSync(gitExclude)) {
    results.push({
      label: "Git local exclude",
      status: "not_applicable",
      command: "none",
      detail: "repository Git non rilevato; nessun .gitignore del progetto modificato",
    });
    return;
  }
  const current = readFileSync(gitExclude, "utf8");
  const lines = current.split(/\r?\n/);
  const missing = entries.filter((entry) => !lines.includes(entry));
  if (missing.length === 0) {
    results.push({
      label: "Git local exclude",
      status: "ready",
      command: "none",
      detail: "cache Luna già escluse localmente",
    });
    return;
  }
  const prefix = current.endsWith("\n") || current.length === 0 ? "" : "\n";
  appendFileSync(gitExclude, `${prefix}# Luna local specialist cache\n${missing.join("\n")}\n`, "utf8");
  results.push({
    label: "Git local exclude",
    status: "ready",
    command: "append .git/info/exclude",
    detail: "cache vendor e indici esclusi senza modificare .gitignore",
  });
}
protectLocalCacheFromGit();

const installs = [
  ["Find Skills", FIND_SKILLS_REPOSITORY, "find-skills"],
  ["PRD Generator", "jamesrochabrun/skills", "prd-generator"],
  ["Product Marketing", "coreyhaines31/marketingskills", "product-marketing"],
  ["Marketing Copywriting", "coreyhaines31/marketingskills", "copywriting"],
  ["Copy Editing", "coreyhaines31/marketingskills", "copy-editing"],
  ["Build a Brand", "Pika-Labs/Pika-Plugins", "build-a-brand"],
  ["Design", "nextlevelbuilder/ui-ux-pro-max-skill", "design"],
  ["Design System", "nextlevelbuilder/ui-ux-pro-max-skill", "design-system"],
];
for (const [label, repository, skill] of installs) {
  run(label, npx, ["skills", "add", repository, "--skill", skill, "-a", "codex", "--copy", "-y"]);
}
run("Superpowers engineering process", npx, ["skills", "add", SUPERPOWERS_REPOSITORY, "-a", "codex", "--copy", "-y"]);
run("Impeccable UX writing and audit", npx, ["skills", "add", "pbakaus/impeccable", "-a", "codex", "--copy", "-y"]);
run("UI UX Pro Max", npx, ["-y", "uipro-cli", "init", "--ai", "codex"]);

function gitHead(folder) {
  if (!existsSync(folder)) return null;
  const result = spawnSync(git, ["-C", folder, "rev-parse", "HEAD"], {
    encoding: "utf8",
    shell: false,
  });
  return result.status === 0 ? result.stdout.trim() : null;
}

function ensurePinnedCatalog({ label, repository, commit, root }) {
  if (dryRun) {
    results.push({
      label,
      status: "dry_run",
      command: `git clone/fetch ${repository} @ ${commit}`,
      detail: "download completo in .app-builder/vendor; attivazione on_demand_only",
    });
    return;
  }
  mkdirSync(vendorRoot, { recursive: true });
  const current = gitHead(root);
  if (!current && !existsSync(root)) {
    const cloned = run(`${label} clone`, git, ["clone", "--filter=blob:none", "--no-checkout", repository, root]);
    if (cloned) {
      run(`${label} pin`, git, ["-C", root, "fetch", "--depth", "1", "origin", commit]);
      run(`${label} checkout`, git, ["-C", root, "checkout", "--detach", commit]);
    }
    return;
  }
  if (!current) {
    results.push({
      label,
      status: "failed_optional",
      command: `git -C ${root} rev-parse HEAD`,
      detail: "cartella esistente ma non è un clone Git valido; Luna usa i fallback nativi",
    });
    return;
  }
  if (current !== commit && refresh) {
    run(`${label} refresh`, git, ["-C", root, "fetch", "--depth", "1", "origin", commit]);
    run(`${label} checkout`, git, ["-C", root, "checkout", "--detach", commit]);
    return;
  }
  results.push({
    label,
    status: current === commit ? "ready" : "installed_different_pin",
    command: `git -C ${root} rev-parse HEAD`,
    detail: current,
  });
}

ensurePinnedCatalog({
  label: "Cybersecurity catalog",
  repository: SECURITY_REPOSITORY,
  commit: SECURITY_COMMIT,
  root: securityRoot,
});
ensurePinnedCatalog({
  label: "Marketing catalog",
  repository: MARKETING_REPOSITORY,
  commit: MARKETING_COMMIT,
  root: marketingRoot,
});

function frontmatter(text) {
  const match = text.match(/^---\s*\n([\s\S]*?)\n---/);
  return match ? match[1] : "";
}
function field(block, name) {
  const match = block.match(new RegExp(`^${name}:\\s*["']?([^\\n"']+)`, "m"));
  return match ? match[1].trim() : null;
}
function classifySecurity(name) {
  const blocked = /(credential-theft|deploying-malware|ransomware-attack|destructive|data-exfiltration)/i;
  const restricted = /(exploiting|phishing|bypass|persistence|lateral-movement|command-and-control|\bc2\b|credential|evasion|red-team)/i;
  const defensive = /^(implementing|securing|scanning|generating|testing|performing|detecting|hardening|building-security|conducting-security)/i;
  if (blocked.test(name)) return "blocked";
  if (restricted.test(name)) return "restricted";
  if (defensive.test(name)) return "defensive";
  return "dual_use";
}

function findSkillFiles(root) {
  const candidates = [join(root, "skills"), root];
  const base = candidates.find((candidate) => existsSync(candidate) && statSync(candidate).isDirectory());
  if (!base) return [];
  const files = [];
  for (const folder of readdirSync(base, { withFileTypes: true })) {
    if (!folder.isDirectory()) continue;
    const direct = join(base, folder.name, "SKILL.md");
    if (existsSync(direct)) files.push({ folder: folder.name, path: direct });
  }
  return files;
}

function buildCatalogIndex({ root, repository, commit, indexPath, kind }) {
  if (dryRun || !existsSync(root)) return 0;
  const entries = [];
  for (const item of findSkillFiles(root)) {
    const block = frontmatter(readFileSync(item.path, "utf8"));
    const name = field(block, "name") || item.folder;
    entries.push({
      name,
      folder: item.folder,
      description: field(block, "description"),
      domain: field(block, "domain"),
      subdomain: field(block, "subdomain"),
      classification: kind === "security" ? classifySecurity(name) : "approved_marketing_reference",
      path: relative(root, item.path).replaceAll("\\", "/"),
    });
  }
  entries.sort((a, b) => a.name.localeCompare(b.name));
  mkdirSync(dirname(indexPath), { recursive: true });
  writeFileSync(
    indexPath,
    JSON.stringify(
      {
        repository,
        commit: gitHead(root) || commit,
        generatedAt: new Date().toISOString(),
        activation: "on_demand_only",
        count: entries.length,
        entries,
      },
      null,
      2,
    ) + "\n",
    "utf8",
  );
  return entries.length;
}

const securityCount = buildCatalogIndex({
  root: securityRoot,
  repository: SECURITY_REPOSITORY,
  commit: SECURITY_COMMIT,
  indexPath: securityIndexPath,
  kind: "security",
});
const marketingCount = buildCatalogIndex({
  root: marketingRoot,
  repository: MARKETING_REPOSITORY,
  commit: MARKETING_COMMIT,
  indexPath: marketingIndexPath,
  kind: "marketing",
});

const safeResults = results.map((item) => ({
  ...item,
  command: portable(item.command),
  detail: portable(item.detail),
}));
const registry = {
  generatedAt: new Date().toISOString(),
  project: ".",
  consent: approved,
  dryRun,
  visibleInterface: "luna_only",
  stateOwner: "luna",
  roles: [
    "market_analyst",
    "product_marketing",
    "cto",
    "support_feedback",
    "data_analyst",
    "operations_lead",
  ],
  dynamicDiscovery: {
    repository: FIND_SKILLS_REPOSITORY,
    skill: "find-skills",
    installation: "search_then_review_then_consent",
  },
  engineeringProcess: {
    repository: SUPERPOWERS_REPOSITORY,
    owner: "cto_role",
    authority: "process_only",
  },
  securityCatalog: {
    repository: SECURITY_REPOSITORY,
    pinnedCommit: SECURITY_COMMIT,
    path: relative(project, securityRoot).replaceAll("\\", "/"),
    index: relative(project, securityIndexPath).replaceAll("\\", "/"),
    indexedSkills: securityCount,
    activation: "on_demand_only",
  },
  marketingCatalog: {
    repository: MARKETING_REPOSITORY,
    pinnedCommit: MARKETING_COMMIT,
    path: relative(project, marketingRoot).replaceAll("\\", "/"),
    index: relative(project, marketingIndexPath).replaceAll("\\", "/"),
    indexedSkills: marketingCount,
    activation: "on_demand_only",
  },
  results: safeResults,
};
writeFileSync(registryPath, JSON.stringify(registry, null, 2) + "\n", "utf8");

const lines = [
  "# Luna Specialist Bootstrap",
  "",
  `- Data: ${new Date().toISOString()}`,
  "- Progetto: `.`",
  `- Consenso esplicito: ${approved}`,
  `- Dry run: ${dryRun}`,
  `- Skill sicurezza indicizzate: ${securityCount || "non calcolate"}`,
  `- Skill marketing indicizzate: ${marketingCount || "non calcolate"}`,
  "- Interfaccia visibile: Luna",
  "",
  "| Capability | Stato | Comando | Evidenza |",
  "|---|---|---|---|",
];
for (const item of safeResults) {
  const safe = String(item.detail || "").replace(/\|/g, "\\|");
  lines.push(`| ${item.label} | ${item.status} | \`${item.command}\` | ${safe} |`);
}
lines.push(
  "",
  "> I cataloghi sicurezza e marketing sono locali ma non vengono caricati interamente come trigger attivi. Luna seleziona il minimo playbook pertinente. Find Skills cerca candidati ma non li installa senza il contratto di consenso. Superpowers governa il processo engineering, non stato e scope.",
  "",
);
writeFileSync(reportPath, lines.join("\n"), "utf8");
console.log(`Bootstrap completato. Report: ${reportPath}`);
