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

## Project
- Name:
- One-line outcome:
- Repository root:
- Existing or new:
- Project mode: personal | prototype | publication
- Product type:
- Target platforms:
- Distribution target:
- Current phase:
- Delivery mode: guided | vertical_slices
- Current slice:
- State owner:
- Workflow: single_chat | two_chat
- Last updated:

## Feasibility and constraints
- Experience level:
- Budget:
- Deadline:
- Required accounts/hardware:
- Known costs:
- Capability limits:

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
- SECURITY.md:
- Threat model:
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
| 0 Preflight and feasibility | pending | doctor report, modalità e avvio discovery | |
| 1 Product and MVP | pending | product discovery, vision e requisiti MVP | |
| 2 Brand | pending | | |
| 3 UX and accessibility | pending | | |
| 4 Design system and UI | pending | | |
| 5 Architecture, data, privacy, security | pending | | |
| 6 Implementation | pending | | |
| 7 QA and compliance | pending | | |
| 8 Beta | pending | | |
| 9 Monetization, analytics, store readiness | pending | | |
| 10 Release | pending | | |
| 11 Operations and maintenance | pending | | |

Usa: pending, partial, in_progress, blocked, approved, approved_with_assumptions, deferred,
not_applicable.

## Current delivery slice
- ID and name:
- Outcome:
- Specification:
- Design:
- Implementation:
- Verification:
- Security check:
- Acceptance criterion:
- Status:

## Source of truth
- Detailed tracker:
- Product discovery: `docs/PRODUCT_DISCOVERY.md`
- Product/UX specs:
- Design system:
- Implementation truth:
- Conflict resolution:

## End-to-end coverage
| Area | Status | Evidence or limitation | Owner |
|---|---|---|---|
| Strategy and feasibility | covered_pending | `docs/PRODUCT_DISCOVERY.md` | |
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

## Regole del Product Discovery

- `Gate status: approved` richiede utente, problema, outcome, alternativa, successo, MVP,
  esclusioni, assunzioni, evidenze con limiti, fattibilità preliminare e prossimo test.
- `approved_with_assumptions` nomina le assunzioni aperte e incorpora il loro test nel prossimo
  investimento.
- `Confidence` usa solo low, medium o high; non inventare percentuali senza un modello reale.
- Ricerca documentale e competitor possono sostenere un'ipotesi, ma `behavior-validated` richiede
  comportamento diretto di utenti pertinenti e una soglia definita prima del test.
- Aggiorna `Evidence last reviewed` quando prezzi, policy, API o competitor vengono ricontrollati.
- Non copiare l'intero documento di discovery nello stato: conserva qui decisione, prova più forte,
  assunzione principale e prossimo esperimento.

## Regole di coerenza e persistenza

- Non dire “ho registrato” finché il file non è stato scritto e riletto oppure il diff non mostra i valori.
- Ogni esclusione confermata va copiata in `Scope > Explicitly excluded`, non soltanto in vincoli o decisioni.
- Quando una decisione chiude un prerequisito, aggiorna i campi dipendenti e rimuovi note ormai vecchie.
- `Target platforms` descrive il target attuale. Uno stack multipiattaforma non aggiunge piattaforme non richieste.
- Motiva lo stack con il requisito corrente; eventuali possibilità future restano in `Later` o nelle assunzioni.
- Per modalità personale, classifica store, monetizzazione, backend remoto e compliance pubblica come
  `not_applicable` quando esplicitamente esclusi; non lasciare tutto genericamente `pending`.
- `State owner` e `Workflow` devono riflettere la sessione reale: una sola chat per default, due soltanto
  dopo attivazione esplicita del workflow Design/Sviluppo.
- Dopo ogni aggiornamento materiale, rileggi almeno le sezioni modificate e correggi incoerenze prima di rispondere.

## Regole

- Una sola fase e una sola slice `in_progress`.
- Solo lo state owner modifica il file.
- Collega artefatti dettagliati, non copiarli interamente.
- Non salvare token, password, dati personali inutili o segreti.
- `approved` richiede evidenza del gate.
- Un rischio accettato mantiene owner, motivo e scadenza.