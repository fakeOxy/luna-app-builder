# App Builder State

## App Builder
- Agent: Luna
- Creator: Massimiliano
- Version: 2.0.0-beta.1
- welcome_shown: false
- Integrity status: not_checked
- Bootstrap status: pending
- Bootstrap consent date: never
- Specialists registry: `.app-builder/specialists.json`
- Security catalog: missing

## Project
- Name: {PROJECT_NAME}
- One-line outcome: da definire
- Repository root: `{PROJECT_ROOT}`
- Project origin: new
- Adoption status: not_applicable
- Adoption report: `.app-builder/adoption-report.md`
- Project mode: {PROJECT_MODE}
- Product type: da definire
- Target platforms: da definire
- Distribution target: da definire
- Current phase: Phase 0 — Preflight, bootstrap and adoption
- Current specialist: app-builder-doctor
- Specialist reason: verificare ambiente e stato iniziale
- Delivery mode: guided
- Current slice: INIT-00
- State owner: current session until a two-chat workflow is explicitly activated
- Workflow: single_chat by default; may become two_chat when justified
- Last updated: {DATE}

## Feasibility and constraints
- Experience level: da definire
- Budget: da definire
- Deadline: da definire
- Required accounts/hardware: da verificare
- Known costs: da verificare
- Capability limits: da verificare

## Users and problem
- Primary user: da definire
- Problem: da definire
- Current alternative: da definire
- Success metric: da definire

## Product discovery
- Gate status: in_progress
- Recommendation: pending
- Confidence: low
- Strongest evidence: none
- Main open assumption: da definire
- Next validation experiment: da definire
- Evidence last reviewed: never
- Detailed artifact: `docs/PRODUCT_DISCOVERY.md`

## Requirements and MVP
- Gate status: pending
- Main outcome: da definire
- MVP boundary: da definire
- First vertical slice: da definire
- Main dependency: da definire
- Detailed artifact: `docs/REQUIREMENTS.md`

## Brand and assets
- Gate status: pending
- Direction: da definire
- Voice: da definire
- Missing critical asset: da verificare
- Detailed artifacts: `docs/BRAND.md`, `docs/ASSET_INVENTORY.md`

## UX and accessibility
- Gate status: pending
- Primary flow: da definire
- Main accessibility risk: da verificare
- Runtime verification: not_started
- Detailed artifacts: `docs/USER_FLOWS.md`, `docs/ACCESSIBILITY.md`

## Copywriting
- Gate status: pending
- Voice principle: da definire
- Main terminology decision: da definire
- Sensitive copy review: not_applicable_or_pending
- Detailed artifact: `docs/COPY_SYSTEM.md`

## Scope
### MVP
- da definire
### Later
- da definire
### Explicitly excluded
- Nessuna esclusione confermata ancora. Quando l’utente esclude una funzione, elencarla qui.

## Risk and conditional modules
- Data sensitivity: unknown
- Internet exposure: unknown
- Auth: unknown
- Payments: no
- AI: no
- Health/safety: no
- Children: no
- UGC: no
- Location/media/files: no
- Required modules: da classificare

## Tooling status
| Capability | Status | Evidence | Next action |
|---|---|---|---|

## Security and privacy
- Security gate: pending
- SECURITY.md: not_started
- Threat model: not_started
- Security plan: `docs/SECURITY_PLAN.md`
- Community playbooks selected: none
- Last diff scan: never
- Last standard scan: never
- Last deep scan: never
- Open findings: unknown
- Data map: not_started
- Privacy/legal review: unknown — classify after scope is known
- Backup/restore status: not_applicable_or_pending

## Confirmed decisions
| Area | Decision | Reason | Date |
|---|---|---|---|

## Assumptions to validate
- Nessuna ancora.

## Phase status
| Phase | Status | Deliverable | Gate evidence |
|---|---|---|---|
| 0 Preflight, bootstrap and adoption | in_progress | doctor, bootstrap, adoption | |
| 1 Discovery, requirements and MVP | pending | discovery, requirements, MVP | |
| 2 Brand and assets | pending | brand, asset inventory | |
| 3 UX, accessibility and copy | pending | flows, accessibility, copy | |
| 4 Design system and UI | pending | | |
| 5 Architecture, data, privacy, security | pending | | |
| 6 Implementation | pending | | |
| 7 QA and compliance | pending | | |
| 8 Beta | pending | | |
| 9 Monetization, analytics, store readiness | pending | | |
| 10 Release | pending | | |
| 11 Operations and maintenance | pending | | |

## Current delivery slice
- ID and name: INIT-00 — avvio guidato
- Outcome: classificare progetto, strumenti, bootstrap e prossimo specialista
- Specification: pending
- UX/accessibility: pending
- Copy: pending
- Design: pending
- Architecture/security: pending
- Implementation: pending
- Verification: pending
- Acceptance criterion: Doctor completato, progetto classificato e routing iniziale registrato
- Status: in_progress

## Source of truth
- Detailed tracker: `.app-builder/state.md`
- Product discovery: `docs/PRODUCT_DISCOVERY.md`
- Requirements: `docs/REQUIREMENTS.md`
- UX/accessibility: `docs/USER_FLOWS.md`, `docs/ACCESSIBILITY.md`
- Brand/assets: `docs/BRAND.md`, `docs/ASSET_INVENTORY.md`
- Copy: `docs/COPY_SYSTEM.md`
- Design system: `design/`
- Security: `docs/SECURITY_PLAN.md`
- Implementation truth: codice e test riproducibili
- Conflict resolution: ultima decisione utente, implementazione verificata, specifiche approvate, stato, bozze

## End-to-end coverage
| Area | Status | Evidence or limitation | Owner |
|---|---|---|---|
| Strategy and feasibility | covered_pending | | current session |
| Product and experience | covered_pending | | |
| Brand and design | covered_pending | | |
| Architecture and data | covered_pending | | |
| Privacy, security, compliance | covered_pending | | |
| Engineering and quality | covered_pending | | |
| Monetization and distribution | covered_pending | | |
| Operations and end of life | covered_pending | | |

## Artifact index
| Artifact | Path/URL | Status |
|---|---|---|
| Product discovery | `docs/PRODUCT_DISCOVERY.md` | in_progress |

## Specialist history
| Specialist | Reason | Artifact | Gate | Date |
|---|---|---|---|---|
| app-builder-doctor | avvio progetto | `.app-builder/doctor-report.md` | in_progress | {DATE} |

## Active handoffs
| Owner | Output | Allowed paths | Status |
|---|---|---|---|

## Risks and blockers
- Doctor non ancora completato.
- Bootstrap specialisti non ancora deciso.
- Problema, utente e prove non ancora verificati.

## Next interaction
- Next decision: classificare progetto e autorizzare o rifiutare il bootstrap
- Questions to ask: modalità e consenso soltanto se non deducibili
- Recommended action: eseguire `$app-builder-doctor`; Luna sceglierà il prossimo specialista

## Decision history
- {DATE} — Progetto inizializzato con Luna App Builder e routing autonomo pronto.
