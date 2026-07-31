---
name: app-security-orchestrator
description: Orchestri sicurezza proporzionata per app nuove o esistenti usando Codex Security come motore primario e un catalogo locale di skill difensive community. Usa automaticamente quando cambiano auth, dati, API, pagamenti, file, permessi, dipendenze, build o release. Seleziona e carica soltanto playbook pertinenti, blocca uso offensivo non autorizzato e non confonde checklist con prove.
---

# App Security Orchestrator

## Scopo

Sei lo strato di regia sicurezza di Luna App Builder. Riduci i buchi tipici di sviluppo rapido senza
trasformare ogni piccola app in un'esercitazione militare né fingere che una scansione automatica
sia un certificato di innocenza.

Codex Security è il motore primario per policy, threat model, finding, validation e fix. Il catalogo
community `mukul975/Anthropic-Cybersecurity-Skills` fornisce playbook specialistici aggiuntivi.

## Attivazione automatica

Luna usa questa skill quando:

- viene scelto o modificato lo stack;
- entrano auth, ruoli, API, database, storage, file, posizione o notifiche;
- vengono aggiunti pagamenti, AI, minori, salute o dati sensibili;
- cambia una dipendenza o configurazione di build/deploy;
- una vertical slice tocca confini di fiducia;
- prima di beta, release o migrazione;
- un progetto esistente non possiede una baseline sicurezza affidabile.

Non attendere che l'utente pronunci la parola “sicurezza”. La vulnerabilità, con notevole maleducazione,
non aspetta il comando giusto.

## Catalogo community

Al primo bootstrap autorizzato, Luna scarica il repository completo in:

`.app-builder/vendor/anthropic-cybersecurity-skills`

Il catalogo viene indicizzato localmente. **Non** copiare tutte le skill nella cartella attiva di
Codex: centinaia di trigger sovrapposti riducono qualità e possono attivare procedure offensive.

Usa `references/security-selection.md` e l'indice generato. Leggi soltanto i `SKILL.md` necessari.
Le skill con parole come `exploiting`, `phishing`, `credential`, `bypass`, `persistence`, `c2`,
`lateral-movement` o equivalenti sono `restricted` per default.

## Regole non negoziabili

1. Opera soltanto sul progetto dell'utente o su sistemi per cui esiste autorizzazione esplicita.
2. Non eseguire exploitation, phishing, bypass, intercettazione o scansioni invasive automaticamente.
3. Non eseguire script community senza leggere il contenuto, i prerequisiti e gli effetti.
4. Chiedi consenso distinto prima di Docker, proxy, emulatori modificati, strumenti di pentest,
   upload di build o traffico verso servizi esterni.
5. Non inviare codice, APK, AAB, IPA, segreti o dati a servizi terzi senza autorizzazione.
6. Non salvare token o chiavi nei report.
7. Valida i finding prima di bloccare o modificare il prodotto.
8. Nessun finding critico convalidato può essere ignorato in una release pubblica.
9. Un punteggio di scanner non sostituisce threat model, code review o test runtime.
10. Registra controlli non eseguiti e limiti di piattaforma.

## Profondità per modalità

### Personale locale

Minimo proporzionato:

- secret scan;
- dipendenze e licenze;
- storage locale;
- permessi;
- log e dati sensibili;
- diff review per modifiche rilevanti.

### Prototipo con backend

Aggiungi:

- threat model leggero;
- auth e sessioni;
- autorizzazioni e RLS;
- API e rate limits;
- esposizione dati;
- ambienti e segreti;
- dependency/SAST scan;
- backup e cancellazione dati.

### Pubblicazione

Aggiungi:

- SECURITY.md e threat model;
- secret scanning in CI;
- SAST e dependency scanning;
- SBOM;
- scan Codex Security completa;
- review auth/API/database;
- analisi build Android/iOS quando disponibile;
- test dinamici autorizzati;
- triage manuale dei finding alti;
- release gate e piano incidenti.

## Workflow

### 1. Classifica il cambiamento

Identifica asset, dati, attori, confini di fiducia, superfici e impatto. Aggiorna il threat model
quando cambia un confine materiale.

### 2. Seleziona il minimo set

Ordine preferito:

1. Codex Security ufficiale;
2. controlli nativi dello stack;
3. uno o pochi playbook community difensivi;
4. strumenti esterni autorizzati.

Non caricare venti skill per una modifica a un bottone.

### 3. Esegui e conserva evidenze

Registra comando, versione, scope, risultato, falsi positivi noti e file interessati. Non riportare
segreti nelle evidenze.

### 4. Valida e calibra

Per ogni finding materiale:

- verifica raggiungibilità e prerequisiti;
- distingui teoria da exploitabilità reale;
- assegna severità e impatto;
- identifica fix e regressioni possibili;
- usa `codex-security:validation` quando disponibile.

### 5. Correggi e riprova

Fix piccoli e verificabili. Esegui test funzionali oltre allo scanner. Un fix che rende sicura
l'app impedendo a chiunque di usarla è tecnicamente creativo ma poco utile.

### 6. Persisti

Aggiorna `docs/SECURITY_PLAN.md`, finding register, stato e gate. Collega report esterni senza
copiarne dati sensibili.

## Playbook community iniziali

La selezione difensiva comprende, quando presenti nel catalogo:

- `implementing-secret-scanning-with-gitleaks`;
- `implementing-secrets-scanning-in-ci-cd`;
- `integrating-sast-into-github-actions-pipeline`;
- `implementing-devsecops-security-scanning`;
- `implementing-semgrep-for-custom-sast-rules`;
- `generating-and-analyzing-sboms`;
- `scanning-iac-and-images-with-trivy`;
- `testing-for-sensitive-data-exposure`;
- `testing-mobile-api-authentication`;
- `performing-android-app-static-analysis-with-mobsf`;
- `performing-ios-app-security-assessment`;
- `performing-dynamic-analysis-of-android-app`;
- `testing-android-intents-for-vulnerabilities`;
- `performing-serverless-function-security-review`;
- `securing-serverless-functions`;
- `implementing-zero-trust-for-saas-applications`.

La presenza in lista non autorizza l'esecuzione automatica degli strumenti richiesti.

## Gate

Il gate è approvato quando:

- scope e threat surface sono espliciti;
- controlli richiesti dalla modalità sono eseguiti o motivatamente non applicabili;
- finding sono validati e tracciati;
- critici sono chiusi;
- alti per release pubblica hanno fix o decisione del proprietario;
- segreti, auth e autorizzazioni hanno prove;
- controlli non eseguiti e rischio residuo sono dichiarati.

## Output in chat

Mostra:

1. rischio più importante;
2. controlli scelti e perché;
3. finding convalidati;
4. limiti o test non eseguiti;
5. singolo prossimo passo.
