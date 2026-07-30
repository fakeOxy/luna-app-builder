# Copertura end-to-end

Questa è la mappa di controllo di Luna. Non tutte le righe si applicano a ogni progetto: usa
`not_applicable` con una motivazione, mai il silenzio. Collega ogni area a un artefatto, una prova
o un limite esplicito.

## Strategia e fattibilità

- problema, utenti e alternativa attuale;
- valore, differenziazione e validazione dell'idea;
- personale/prototipo/pubblicazione e piattaforme;
- fattibilità tecnica, API, hardware, account e dipendenze;
- costi iniziali, ricorrenti, variabili e limiti gratuiti;
- tempi, priorità, competenze e rischi;
- proprietà del codice, licenze, marchi, nome, dominio e asset;
- criteri di successo, MVP, esclusioni e roadmap.

## Prodotto e esperienza

- casi d'uso, ruoli e permessi;
- architettura informativa, navigazione e flussi;
- onboarding, login, recupero account e cancellazione;
- stati vuoti, caricamento, successo, errore e retry;
- copy, notifiche, email e comunicazioni;
- accessibilità, tastiera, safe area, testo dinamico e riduzione movimento;
- responsive, orientamento, dispositivi e piattaforme;
- internazionalizzazione, localizzazione, fusi, date, valute e RTL quando pertinenti;
- offline, rete lenta, conflitti e recupero;
- supporto, feedback, segnalazioni e gestione abusi quando pertinenti.

## Brand e design

- posizionamento, nome, voce e personalità;
- palette, tipografia, icone, logo, splash e app icon;
- token, componenti, varianti e motion;
- fotografie, illustrazioni, licenze e asset;
- specifiche verificabili e coerenza cross-platform;
- screenshot e materiali di store soltanto da prodotto reale.

## Architettura e dati

- stack, struttura, dipendenze e decisioni architetturali;
- modello dati, indici, vincoli e migrazioni;
- autenticazione, autorizzazione, ruoli, RLS e multi-tenancy;
- API, storage, upload, code, job e funzioni server;
- cache, sincronizzazione, idempotenza e concorrenza;
- ambienti development, test/beta e produzione;
- configurazione, segreti e rotazione credenziali;
- import, export, portabilità e cancellazione dati;
- backup, restore drill, rollback e disaster recovery;
- logging, metriche, tracing, alert e costi.

## Privacy, sicurezza e conformità

- inventario dati, finalità, minimizzazione e conservazione;
- consenso e permessi just-in-time quando applicabili;
- servizi terzi, trasferimenti e data processing;
- privacy policy, termini, store labels/Data Safety e contatti;
- account deletion ed esercizio dei diritti;
- `SECURITY.md`, threat model e invarianti;
- dependency, secret e supply-chain hygiene;
- diff scan sui cambi sensibili, scan repository e validazione findings;
- incident response, disclosure e registro dei rischi;
- moduli speciali per salute, minori, finanza, AI, UGC, posizione e pagamenti;
- revisione professionale quando il giudizio legale o di dominio supera gli strumenti disponibili.

## Engineering e qualità

- source control, branch/commit strategy e protezione delle modifiche utente;
- coding conventions, typing, lint, format e build;
- test unitari, integrazione, end-to-end e regressione proporzionati;
- mock/stub distinti da servizi reali;
- test su dispositivo/browser rappresentativo;
- crash, memoria, startup, frame rate, batteria, rete e dimensione build;
- compatibilità OS, aggiornamento da versioni precedenti e migrazioni;
- CI/CD, artefatti riproducibili e provenienza release;
- feature flags, rollout graduale, rollback e kill switch quando necessari;
- documentazione tecnica, runbook e handoff.

## Monetizzazione e distribuzione

- modello gratuito/Premium, prezzi, trial e paywall;
- acquisto, restore, rinnovo, cancellazione, refund e stato offline;
- analytics, eventi, attribution e consenso;
- account sviluppatore, firma, certificati, bundle/package identity e versioning;
- TestFlight/Play testing, beta web o distribuzione interna;
- metadata, categorie, rating, screenshot, preview, support URL e review notes;
- App Store, Play Store, web/PWA, enterprise o sideload secondo il progetto;
- ASO, lancio, canali, supporto e piano di comunicazione;
- tasse, fatturazione o adempimenti commerciali segnalati per revisione umana.

## Operazioni e fine vita

- monitoraggio crash, disponibilità, costi e sicurezza;
- supporto, recensioni, feedback e metriche prodotto;
- aggiornamenti SDK/dipendenze e scansioni periodiche;
- backup/restore periodici e manutenzione database;
- certificati, account e rinnovi;
- incidenti, post-mortem e comunicazioni;
- roadmap, deprecazioni, esportazione dati e sunset;
- chiusura servizi, eliminazione sicura e comunicazione agli utenti.

## Chiusura della copertura

Per ogni area registra uno stato:

- `covered_verified`;
- `covered_pending`;
- `not_applicable` con motivo;
- `manual_required` con istruzioni e prova attesa;
- `human_review_required` con professionista/owner;
- `unavailable` con limite della tecnologia o della superficie.

Luna non promette che ogni controllo trovi ogni errore. Promette che nessuna area applicabile viene
saltata senza essere nominata, assegnata e chiusa con una prova o un limite dichiarato.
