# Ciclo di vita completo

## Fase 0 — Preflight, modalità e fattibilità

Verifica progetto esistente, strumenti, skill, account richiesti, piattaforme, costi minimi,
vincoli hardware, API e servizi. Seleziona personale/prototipo/pubblicazione.

Artefatti: doctor report, modalità, capability matrix iniziale, mappa dei costi e prerequisiti.
Gate: il percorso è tecnicamente e finanziariamente plausibile; limiti noti.

## Fase 1 — Prodotto, utenti e MVP

Definisci problema, utente, alternativa attuale, valore, casi d'uso, funzioni, esclusioni, modello
di business, metriche, rischi e piano di validazione. Non progettare quaranta schermate prima di
sapere perché esistono.

Artefatti: vision, requirements, inventario funzionale, MVP e roadmap.
Gate: problema, utente, piattaforme e confine MVP approvati.

## Fase 2 — Brand e identità

Nome, posizionamento, personalità, voce, palette, tipografia, logo/icona necessari. Per strumenti
personali interni può essere ridotta o non applicabile.

Artefatti: brand brief e asset approvati.
Gate: una direzione coerente, non un buffet di sei brand incompatibili.

## Fase 3 — UX, contenuti e accessibilità

Flussi principali, navigazione, inventario schermate, stati vuoti/loading/error/success, permessi,
onboarding, copy, accessibilità e user journey. Considera tastiera, safe area, Dynamic Type,
riduzione movimento, offline e recupero errori.

Artefatti: user flows, screen map, content rules, acceptance criteria.
Gate: percorso principale e stati critici approvati.

## Fase 4 — Design system e UI

Token, componenti, varianti, spaziature, responsive, motion, icone, fotografie, tema e specifiche
per la slice. Il sistema del progetto è fonte di verità; una skill estetica non può sostituirlo.

Artefatti: design system e specifiche verificabili.
Gate: la slice può essere implementata senza decisioni visive materiali aperte.

## Fase 5 — Architettura, dati, privacy e sicurezza

Scegli stack e dipendenze; modella dati, auth, autorizzazioni, API, storage, caching, ambienti,
backup, migrazioni, osservabilità e costi. Crea mappa dati e, per progetti esposti, SECURITY.md e
threat model. Attiva moduli condizionali.

Artefatti: architecture decision record, data model, privacy data map, security policy, threat
model, environment plan, backup/restore plan.
Gate: confini, dati, responsabilità e rischi sono espliciti; nessun segreto nel client.

## Fase 6 — Implementazione in vertical slice

Per ogni slice: specifica, piano, codice, migrazioni, test, prova reale, controllo sicurezza e
handoff. Mantieni build eseguibile. Versiona schema e configurazioni. Non accumulare un backend
immaginario dietro schermate perfette.

Artefatti: codice, test, migrazioni, log di verifica, stato aggiornato.
Gate: acceptance criteria dimostrati nell'ambiente previsto.

## Fase 7 — QA, affidabilità, sicurezza e conformità

Test funzionali, integrazione, regressione, dispositivi, browser, accessibilità, performance,
rete lenta/offline, errori, aggiornamenti, privacy, permessi, sicurezza, pagamenti, account e
cancellazione. Verifica backup e ripristino.

Artefatti: test plan eseguito, report QA, scan security, issue register.
Gate: ogni blocker è fixed, accepted con autorità/ragione oppure deferred con owner e data; i
critici non sono accettabili per release pubbliche.

## Fase 8 — Beta e stabilizzazione

Build interna, tester reali, canali beta, feedback strutturato, crash, metriche di attivazione,
regressioni e iterazioni. Dati beta separati dalla produzione quando necessario.

Artefatti: beta plan, feedback register, release candidate.
Gate: percorso principale completato da tester e blocker chiusi.

## Fase 9 — Monetizzazione, analytics e store readiness

Definisci gratuitamente/Premium, prezzi, trial, paywall, restore, cancellazioni, analytics,
consensi, metadata, screenshot, privacy labels/data safety, support URL e contenuti store.

Artefatti: monetization spec, event plan, store listing, privacy checklist.
Gate: funzionalità e claim coincidono; acquisti e policy verificati.

## Fase 10 — Pubblicazione e rollout

Versioning, build firmata, upload, revisione, rollout graduale, monitoraggio, rollback e risposta
agli store. L'utente conserva le conferme finali e gli account.

Artefatti: release checklist, build e note, approvazioni, piano rollout.
Gate: release pubblicata o distribuita con monitoraggio attivo.

## Fase 11 — Operazioni, manutenzione, crescita e dismissione

Crash, incidenti, aggiornamenti, costi, dipendenze, backup, migrazioni, supporto, recensioni,
retention, nuove versioni e scansioni dopo cambi sensibili. Prevedi esportazione e cancellazione
dati e un piano di fine vita.

Artefatti: runbook, maintenance plan, incident log, roadmap e sunset plan quando serve.
Gate: proprietà e frequenze operative assegnate.
