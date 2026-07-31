# External Specialists Routing Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rendere Luna l'unica interfaccia visibile, capace di trovare, installare dopo consenso, selezionare e coordinare specialisti esterni senza cedere loro stato, scope o decisioni finali.

**Architecture:** Luna mantiene stato e gate. Un bootstrap iniziale installa skill fondamentali e scarica cataloghi versionati. Un registro locale descrive provenienza, rischio e capacità. Il router assegna un ruolo interno, seleziona il minimo specialista utile e usa fallback nativi quando una dipendenza esterna manca.

**Tech Stack:** Markdown Agent Skills, Node.js bootstrap, Python repository validator, GitHub Actions, Codex plugins/skills.

## Global Constraints

- `main` e Tavia non vengono modificati.
- Un solo consenso iniziale copre esclusivamente download gratuiti dichiarati.
- Login, API, costi, Docker, scanner, upload, push e pubblicazioni richiedono consensi separati.
- Luna resta state owner e unica interfaccia utente.
- Skill community nuove devono essere valutate prima dell'installazione.
- Cataloghi marketing e sicurezza vengono indicizzati e caricati on demand, non registrati interamente come trigger attivi.

---

### Task 1: Contratti e test del router

**Files:**
- Modify: `scripts/validate_repository.py`
- Modify: `.github/workflows/validate.yml`

**Produces:** controlli che falliscono finché non esistono `find-skills`, Superpowers, catalogo marketing, registro ruoli e analytics.

- [x] Aggiungere aspettative per la dodicesima skill nativa `app-analytics-measurement`.
- [x] Richiedere i riferimenti `external-roles.md` e `dynamic-skill-discovery.md`.
- [x] Verificare nel bootstrap i repository di Vercel Skills, Superpowers e Marketing Skills.
- [x] Verificare che i cataloghi sicurezza e marketing siano `on_demand_only`.
- [x] Eseguire la CI e confermare il fallimento dovuto alle capacità mancanti.

### Task 2: Analytics e ruoli interni

**Files:**
- Create: `skills/app-analytics-measurement/SKILL.md`
- Create: `skills/app-analytics-measurement/agents/openai.yaml`
- Create: `skills/app-builder/references/external-roles.md`
- Create: `templates/docs/MEASUREMENT_PLAN.md`

**Produces:** contratto per metriche e sei ruoli interni non visibili.

- [x] Definire eventi, proprietà, funnel, baseline, soglie e minimizzazione dati.
- [x] Definire ruoli Market Analyst, Product Marketing, CTO, Support, Data Analyst e Operations.
- [x] Stabilire che un ruolo può usare più skill ma non possiede stato o decisioni finali.
- [x] Aggiungere il template persistente del piano di misurazione.

### Task 3: Skill discovery e catalogo marketing

**Files:**
- Create: `skills/app-builder/references/dynamic-skill-discovery.md`
- Modify: `skills/app-builder/scripts/bootstrap-specialists.mjs`

**Produces:** bootstrap di `find-skills`, Superpowers e catalogo marketing completo indicizzato localmente.

- [x] Installare `find-skills` da `vercel-labs/skills`.
- [x] Installare Superpowers da `obra/superpowers` per Codex quando non già presente.
- [x] Clonare Marketing Skills a un commit fissato in `.app-builder/vendor`.
- [x] Generare `.app-builder/marketing-catalog/index.json`.
- [x] Conservare l'attivazione `on_demand_only` e fallback nativo.
- [x] Registrare sorgente, commit, licenza dichiarata, stato e percorsi relativi.

### Task 4: Routing autonomo e stato

**Files:**
- Modify: `skills/app-builder/SKILL.md`
- Modify: `skills/app-builder/references/autonomous-routing.md`
- Modify: `skills/app-builder/references/phase-routing.md`
- Modify: `skills/app-builder/references/state-schema.md`
- Modify: `templates/state.md`
- Modify: `templates/app-builder.config.json`

**Produces:** Luna seleziona ruolo e specialista senza chiedere all'utente nomi di skill.

- [x] Inserire analytics nel percorso discovery, beta e store.
- [x] Cercare skill nuove soltanto davanti a un capability gap reale.
- [x] Registrare ruolo, specialista, input, output, rischio e gate.
- [x] Impedire a specialisti esterni di modificare stato centrale o ampliare lo scope.

### Task 5: Verifica e documentazione

**Files:**
- Modify: `README.md`
- Modify: `CHANGELOG.md`
- Modify: `docs/VALIDATION.md`
- Regenerate: `integrity-manifest.json`

**Produces:** pacchetto verificato su Linux e Windows e pronto al collaudo manuale.

- [x] Eseguire validatore, parsing, smoke test tre modalità e bootstrap dry-run.
- [x] Verificare un progetto nuovo e uno esistente fittizio.
- [x] Verificare che i cataloghi non diventino centinaia di trigger attivi.
- [x] Rigenerare il manifesto deterministico.
- [x] Lasciare la PR in bozza fino ai test reali Codex.

## Verifica automatica

- RED: la CI ha fallito dopo l'introduzione dei controlli per le capacità mancanti.
- GREEN: Linux e Windows hanno superato validatore, parsing, tre modalità, bootstrap dry-run, progetto esistente, Doctor e integrità sul commit `415a45214d55051bdca37e26129e6f934001a4fb`.
- Residuo manuale: bootstrap reale e routing conversazionale in una sessione Codex isolata.
