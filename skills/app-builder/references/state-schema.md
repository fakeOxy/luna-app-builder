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
| 0 Preflight and feasibility | pending | | |
| 1 Product and MVP | pending | | |
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

Usa: pending, partial, in_progress, blocked, approved, deferred, not_applicable.

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
- Product/UX specs:
- Design system:
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
| Monetization and distribution | covered_pending | | |
| Operations and end of life | covered_pending | | |

## Artifact index
| Artifact | Path/URL | Status |
|---|---|---|

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

## Regole

- Una sola fase e una sola slice `in_progress`.
- Solo lo state owner modifica il file.
- Collega artefatti dettagliati, non copiarli interamente.
- Non salvare token, password, dati personali inutili o segreti.
- `approved` richiede evidenza del gate.
- Un rischio accettato mantiene owner, motivo e scadenza.
