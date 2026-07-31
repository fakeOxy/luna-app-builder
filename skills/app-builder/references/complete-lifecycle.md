# Ciclo di vita completo

## Fase 0 — Preflight, bootstrap, adozione e fattibilità

Esegui Doctor, determina modalità, verifica strumenti, account, piattaforme, costi, hardware, API e
servizi. Se il progetto esiste, usa `$app-project-adoption` per ricognizione read-only, baseline,
fonti di verità e convenzioni. Se il bootstrap non è stato eseguito, chiedi un solo consenso e
prepara gli specialisti automaticamente.

Artefatti: doctor report, bootstrap report, adoption report quando applicabile, modalità,
capability matrix, mappa costi e prerequisiti.
Gate: progetto compreso, baseline nota, percorso plausibile, limiti e specialisti/fallback noti.

## Fase 1 — Discovery, requisiti e MVP

Invoca `$app-product-discovery` quando problema, pubblico o direzione non sono affidabili. Poi usa
`$app-requirements-mvp` per percorso principale, inventario prioritizzato, requisiti non funzionali,
criteri di accettazione, esclusioni e prima vertical slice.

La profondità dipende dalla modalità:

- personale: problema dell'utente, alternativa, successo, MVP, esclusioni e rischio principale;
- prototipo: pubblico iniziale, alternative, assunzioni e test con utenti o tester;
- pubblicazione: ricerca corrente e citata, differenziazione, costi, vincoli e validazione diretta.

Artefatti: product discovery, vision, requirements, inventario funzionale, MVP e roadmap.
Gate: problema, utente, outcome, alternativa, successo, prove, assunzioni, piattaforme, MVP,
acceptance criteria ed esclusioni approvati o approvati con assunzioni. Ricerca documentale non è
validazione del comportamento.

## Fase 2 — Brand, voce e asset

Usa `$app-brand-assets`. Nei progetti esistenti estrai nome, tono, token e asset correnti prima di
proporre cambi. Definisci posizionamento, voce, palette, tipografia, iconografia, logo/app icon e
inventario asset proporzionato alla modalità.

Artefatti: `BRAND.md`, `ASSET_INVENTORY.md`, asset approvati e licenze/provenienza.
Gate: direzione unica, token essenziali, asset richiesti assegnati e rischi nome/licenza dichiarati.

## Fase 3 — UX, accessibilità e copy

Usa `$app-ux-accessibility` per flussi, navigazione, screen map, stati, permessi, error recovery,
offline e criteri accessibilità. Usa `$app-copywriting` per microcopy, onboarding, errori, notifiche,
azioni distruttive e contenuti sensibili.

Considera tastiera, safe area, Dynamic Type/testo grande, screen reader, target tattili, contrasto,
riduzione movimento, localizzazione e recupero dagli errori.

Artefatti: user flows, accessibility plan/audit, copy system, inventario contenuti e acceptance
criteria UX.
Gate: percorso e stati critici approvati, copy implementabile, barriere principali trattate e test
manuali/runtime assegnati.

## Fase 4 — Design system e UI

Token, componenti, varianti, spaziature, responsive, motion, icone, fotografie, tema e specifiche
per la slice. Usa UI/UX Pro Max, Impeccable e design system quando disponibili, ma il sistema del
progetto rimane fonte di verità.

Artefatti: design system e specifiche verificabili.
Gate: la slice può essere implementata senza decisioni visive o testuali materiali aperte.

## Fase 5 — Architettura, dati, privacy e sicurezza

Scegli stack e dipendenze; modella dati, auth, autorizzazioni, API, storage, caching, ambienti,
backup, migrazioni, osservabilità e costi. Usa `$app-security-orchestrator` e Codex Security per
policy, threat model, scan e validation. Seleziona soltanto playbook community pertinenti.

Artefatti: ADR, data model, privacy data map, SECURITY.md, threat model, security plan, environment
plan, backup/restore plan.
Gate: confini, dati, responsabilità e rischi espliciti; segreti fuori dal client; auth/autorizzazioni
con strategia di prova.

## Fase 6 — Implementazione in vertical slice

Per ogni slice: evidenza, requisiti, UX/copy/design necessari, piano tecnico, sicurezza, codice,
migrazioni, test, prova reale e handoff. Mantieni build eseguibile e rispetta convenzioni adottate.
Non mescolare refactor ampio e nuovo comportamento senza motivo.

Artefatti: codice, test, migrazioni, log di verifica, stato aggiornato.
Gate: acceptance criteria dimostrati nell'ambiente previsto e regressioni note.

## Fase 7 — QA, affidabilità, sicurezza e conformità

Test funzionali, integrazione, regressione, dispositivi, browser, accessibilità, performance,
rete lenta/offline, errori, aggiornamenti, privacy, permessi, sicurezza, pagamenti, account e
cancellazione. Verifica backup e ripristino. Per release pubbliche valuta SAST, dependency scan,
SBOM e assessment build mobile.

Artefatti: test plan eseguito, report QA/accessibilità, scan security, issue register.
Gate: blocker chiusi o assegnati; finding critici chiusi; finding alti gestiti dal proprietario;
controlli non eseguiti dichiarati.

## Fase 8 — Beta e stabilizzazione

Build interna, tester reali, canali beta, feedback strutturato, crash, metriche di attivazione,
regressioni e iterazioni. Dati beta separati dalla produzione quando necessario.

Confronta i risultati con assunzioni e soglie della discovery. Aggiorna requisiti, UX, copy e
raccomandazione quando il comportamento reale contraddice le ipotesi.

Artefatti: beta plan, feedback register, release candidate, discovery e requirements aggiornati.
Gate: percorso principale completato da tester, assunzioni riesaminate e blocker chiusi.

## Fase 9 — Monetizzazione, analytics e store readiness

Definisci gratuito/Premium, prezzi, trial, paywall, restore, cancellazioni, analytics, consensi,
metadata, screenshot, privacy labels/data safety, support URL e contenuti store. Usa copy e brand
approvati; non promettere funzioni non presenti.

Artefatti: monetization spec, event plan, store listing, asset store, privacy checklist.
Gate: funzionalità e claim coincidono; acquisti, privacy e policy verificati.

## Fase 10 — Pubblicazione e rollout

Versioning, build firmata, upload, revisione, rollout graduale, monitoraggio, rollback e risposta
agli store. L'utente conserva conferme finali e account.

Artefatti: release checklist, build e note, approvazioni, piano rollout.
Gate: release pubblicata o distribuita con monitoraggio e rollback pronti.

## Fase 11 — Operazioni, manutenzione, crescita e dismissione

Crash, incidenti, aggiornamenti, costi, dipendenze, backup, migrazioni, supporto, recensioni,
retention, nuove versioni e scansioni dopo cambi sensibili. Prevedi esportazione/cancellazione dati
e fine vita.

Artefatti: runbook, maintenance plan, incident log, roadmap e sunset plan.
Gate: proprietà, frequenze operative e condizioni di escalation assegnate.
