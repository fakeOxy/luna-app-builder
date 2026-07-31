# Schema dello stato

Crea `.app-builder/state.md`. Mantienilo breve, attuale e privo di segreti.

```markdown
# App Builder State

## App Builder
- Agent: Luna
- Creator: Massimiliano
- Version: 2.0.0-beta.1
- welcome_shown: false
- Integrity status: not_checked
- Bootstrap status: pending | ready | partial | declined | blocked
- Bootstrap consent date:
- Specialists registry: `.app-builder/specialists.json`
- Security catalog: missing | indexed | stale | blocked
- Marketing catalog: missing | indexed | stale | blocked
- Dynamic skill discovery: unavailable | ready | restricted
- Engineering process: native | superpowers | fallback

## Project
- Name:
- One-line outcome:
- Repository root:
- Project origin: new | existing | migrated
- Adoption status: not_applicable | pending | in_progress | approved | blocked
- Adoption report: `.app-builder/adoption-report.md`
- Project mode: personal | prototype | publication
- Product type:
- Target platforms:
- Distribution target:
- Current phase:
- Current role:
- Current specialist:
- Specialist reason:
- Delivery mode: guided | vertical_slices
- Current slice:
- State owner: Luna/current session
- Workflow: single_chat | two_chat
- Last updated:

## Feasibility and constraints
- Experience level:
- Budget:
- Deadline:
- Required accounts/hardware:
- Known costs:
- Capability limits:
- Open capability gap:

## Users and problem
- Primary user:
- Problem:
- Current alternative:
- Success metric:

## Product discovery
- Gate status: in_progress | approved | approved_with_assumptions | blocked | not_applicable
- Recommendation: pending | go | go_with_assumptions | pivot | hold | stop
- Confidence: low | medium | high
- Strongest evidence:
- Main open assumption:
- Next validation experiment:
- Evidence last reviewed:
- Detailed artifact: `docs/PRODUCT_DISCOVERY.md`

## Requirements and MVP
- Gate status: pending | in_progress | approved | approved_with_assumptions | blocked | not_applicable
- Main outcome:
- MVP boundary:
- First vertical slice:
- Main dependency:
- Detailed artifact: `docs/REQUIREMENTS.md`

## Brand and assets
- Gate status: pending | in_progress | approved | blocked | not_applicable
- Direction:
- Voice:
- Missing critical asset:
- Detailed artifacts: `docs/BRAND.md`, `docs/ASSET_INVENTORY.md`

## UX and accessibility
- Gate status: pending | in_progress | approved | blocked | not_applicable
- Primary flow:
- Main accessibility risk:
- Runtime verification:
- Detailed artifacts: `docs/USER_FLOWS.md`, `docs/ACCESSIBILITY.md`

## Copywriting
- Gate status: pending | in_progress | approved | blocked | not_applicable
- Voice principle:
- Main terminology decision:
- Sensitive copy review:
- Detailed artifact: `docs/COPY_SYSTEM.md`

## Analytics and measurement
- Gate status: pending | in_progress | approved | approved_with_assumptions | blocked | not_applicable
- Primary outcome:
- Primary metric:
- Guardrail:
- Baseline type:
- Threshold status: unknown | provisional | approved
- Event implementation status: not_started | planned | partial | verified
- Privacy review:
- Detailed artifact: `docs/MEASUREMENT_PLAN.md`

## Scope
### MVP
- ...
### Later
- ...
### Explicitly excluded
- ...

## Risk and conditional modules
- Data sensitivity:
- Internet exposure:
- Auth:
- Payments:
- AI:
- Health/safety:
- Children:
- UGC:
- Location/media/files:
- Required modules:

## Tooling status
| Capability | Status | Evidence | Next action |
|---|---|---|---|

## Security and privacy
- Security gate: pending | in_progress | approved | blocked | not_applicable
- SECURITY.md:
- Threat model:
- Security plan: `docs/SECURITY_PLAN.md`
- Community playbooks selected:
- Last diff scan:
- Last standard scan:
- Last deep scan:
- Open findings:
- Data map:
- Privacy/legal review:
- Backup/restore status:

## Confirmed decisions
| Area | Decision | Reason | Date |
|---|---|---|---|

## Assumptions to validate
- ...

## Phase status
| Phase | Status | Deliverable | Gate evidence |
|---|---|---|---|
| 0 Preflight, bootstrap and adoption | pending | doctor, bootstrap, adoption | |
| 1 Discovery, requirements and MVP | pending | discovery, requirements, MVP | |
| 2 Brand and assets | pending | brand, asset inventory | |
| 3 UX, accessibility and copy | pending | flows, accessibility, copy | |
| 4 Design system and UI | pending | | |
| 5 Architecture, data, privacy, security | pending | | |
| 6 Implementation | pending | | |
| 7 QA and compliance | pending | | |
| 8 Beta and measurement | pending | measurement plan, feedback, verification | |
| 9 Monetization, analytics, store readiness | pending | | |
| 10 Release | pending | | |
| 11 Operations and maintenance | pending | | |

Usa: pending, partial, in_progress, blocked, approved, approved_with_assumptions, deferred,
not_applicable.

## Current delivery slice
- ID and name:
- Outcome:
- Specification:
- UX/accessibility:
- Copy:
- Measurement:
- Design:
- Architecture/security:
- Implementation:
- Verification:
- Acceptance criterion:
- Status:

## Source of truth
- Detailed tracker:
- Product discovery: `docs/PRODUCT_DISCOVERY.md`
- Requirements: `docs/REQUIREMENTS.md`
- UX/accessibility: `docs/USER_FLOWS.md`, `docs/ACCESSIBILITY.md`
- Brand/assets: `docs/BRAND.md`, `docs/ASSET_INVENTORY.md`
- Copy: `docs/COPY_SYSTEM.md`
- Measurement: `docs/MEASUREMENT_PLAN.md`
- Design system:
- Security: `docs/SECURITY_PLAN.md`
- Implementation truth:
- Conflict resolution:

## End-to-end coverage
| Area | Status | Evidence or limitation | Owner |
|---|---|---|---|
| Strategy and feasibility | covered_pending | | |
| Product and experience | covered_pending | | |
| Brand and design | covered_pending | | |
| Architecture and data | covered_pending | | |
| Privacy, security, compliance | covered_pending | | |
| Engineering and quality | covered_pending | | |
| Analytics and evidence | covered_pending | | |
| Monetization and distribution | covered_pending | | |
| Operations and end of life | covered_pending | | |

## Artifact index
| Artifact | Path/URL | Status |
|---|---|---|

## Delegation history
| Role | Specialist | Reason | Allowed paths | Output | Risk | Gate | Date |
|---|---|---|---|---|---|---|---|

## Dynamic skill searches
| Capability gap | Query | Candidates | Selected source | Consent | Post-check | Date |
|---|---|---|---|---|---|---|

## Active handoffs
| Owner | Output | Allowed paths | Status |
|---|---|---|---|

## Risks and blockers
- ...

## Next interaction
- Next decision:
- Questions to ask:
- Recommended action:

## Decision history
- YYYY-MM-DD — ...
```

## Regole del routing autonomo

- `Current role` e `Current specialist` devono riflettere il lavoro realmente attivo; l'utente non
  deve sceglierli.
- Luna resta l'unica interfaccia e il state owner.
- Registra in `Delegation history` motivo, percorsi, output, rischio e gate.
- Se lo specialista esterno manca ma il fallback nativo copre il gate, registra `partial` e continua.
- Una transizione automatica è consentita soltanto se il prossimo passo è reversibile e già autorizzato.
- `Open capability gap` viene valorizzato prima di usare `find-skills` e svuotato solo dopo post-check
  o fallback documentato.

## Regole del bootstrap

- `ready` richiede report, registro specialisti e post-check.
- `partial` nomina installazioni fallite e fallback disponibili.
- Il consenso bootstrap non autorizza strumenti invasivi o account esterni.
- Catalogo sicurezza o marketing `indexed` significa disponibile localmente, non centinaia di skill
  attive.
- Superpowers può essere `ready` anche se una singola skill di processo non è pertinente al task.

## Regole del progetto esistente

- `Adoption status: approved` richiede baseline, fonti di verità, convenzioni, aree protette e primo
  intervento minimo.
- Non segnare fasi `pending` se il progetto possiede prove affidabili che le rendono già approvate.
- Errori preesistenti e working tree non pulito devono essere registrati prima delle modifiche.

## Regole del Product Discovery

- `approved` richiede utente, problema, outcome, alternativa, successo, MVP, esclusioni, assunzioni,
  evidenze con limiti, fattibilità preliminare e prossimo test.
- `approved_with_assumptions` incorpora il test delle assunzioni nel prossimo investimento.
- `behavior-validated` richiede comportamento diretto e soglia definita prima del test.

## Regole del Measurement Plan

- Non segnare analytics `approved` senza outcome, decisione, metrica primaria, guardrail applicabili,
  baseline o `unknown` motivato, soglia e privacy.
- `verified` richiede prova reale dell'evento e assenza di dati vietati.
- Metriche tecniche e metriche di prodotto restano distinte.
- Nessun dato inventato può comparire come baseline.

## Regole di coerenza e persistenza

- Non dire “ho registrato” finché il file non è stato scritto e riletto o il diff mostra i valori.
- Ogni esclusione confermata va copiata in `Scope > Explicitly excluded`.
- Quando una decisione chiude un prerequisito, aggiorna i campi dipendenti.
- `Target platforms` descrive il target attuale, non tutte le possibilità dello stack.
- Per modalità personale, marca store, monetizzazione, backend remoto e compliance pubblica
  `not_applicable` quando esclusi.
- Una sola fase, un ruolo proprietario e una slice `in_progress`.
- Solo lo state owner modifica il file.
- Collega artefatti dettagliati, non copiarli interamente.
- Non salvare token, password, dati personali inutili o segreti.
- `approved` richiede evidenza del gate.
- Un rischio accettato mantiene owner, motivo e scadenza.
