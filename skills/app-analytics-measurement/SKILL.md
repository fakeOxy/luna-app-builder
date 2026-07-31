---
name: app-analytics-measurement
description: Definisce un piano di misurazione proporzionato per app personali, prototipi e prodotti pubblicabili, collegando obiettivi, eventi, funnel, baseline, soglie e privacy senza trasformare ogni interazione in sorveglianza inutile.
---

# App Analytics & Measurement

## Obiettivo

Trasformare gli obiettivi del prodotto in prove osservabili. Questa skill non installa SDK e non
invia dati: stabilisce cosa misurare, perché, con quale soglia e con quali limiti.

Leggi prima:

- `.app-builder/state.md`;
- `docs/PRODUCT_DISCOVERY.md`;
- `docs/REQUIREMENTS.md`;
- `docs/USER_FLOWS.md` quando esiste;
- `docs/PRIVACY_DATA_MAP.md` quando applicabile.

Scrivi o aggiorna `docs/MEASUREMENT_PLAN.md`.

## Quando usarla

Usala quando:

- discovery o requisiti contengono un criterio di successo;
- serve progettare una beta o un esperimento;
- onboarding, paywall, acquisti o funnel devono essere verificati;
- analytics esistenti sono incoerenti o raccolgono dati senza una decisione collegata;
- si prepara una release pubblica;
- l'utente chiede numeri, conversioni, retention o performance di prodotto.

Non usarla per metriche tecniche come crash, log e tempi di risposta: quelle appartengono a
observability e performance, salvo collegamenti espliciti con un outcome utente.

## Principi

1. Parti dalla decisione che la metrica deve sostenere.
2. Preferisci pochi eventi stabili a una discarica di tracking.
3. Distingui eventi realmente implementati da eventi soltanto progettati.
4. Non inventare baseline, conversioni, retention o benchmark.
5. Definisci soglie prima dell'esperimento, non dopo aver visto il risultato.
6. Non raccogliere testo libero, contatti, posizione o identificatori se non servono.
7. Ogni proprietà deve avere motivo, tipo, cardinalità attesa e retention.
8. Analytics non sostituisce interviste, osservazione o test qualitativi.
9. Nessun SDK, account o invio di dati senza consenso esplicito.
10. Per minori, salute, finanza o dati sensibili richiedi revisione privacy più rigorosa.

## Profondità per modalità

### Personale

- usa dati locali o nessun tracking quando basta;
- misura soltanto se aiuta davvero l'utente;
- niente account analytics per una funzione che può essere verificata manualmente.

### Prototipo

- definisci attivazione, completamento del percorso principale e ritorno;
- collega ogni metrica a un'assunzione della discovery;
- specifica campione, durata, baseline e limiti.

### Pubblicazione

- definisci tassonomia eventi versionata;
- separa analytics, crash reporting e log;
- documenta consenso, opt-out, retention, ambienti e accessi;
- verifica che store disclosure e privacy map coincidano con il tracking reale.

## Workflow

### 1. Ricostruisci outcome e decisioni

Per ogni outcome registra:

- utente;
- comportamento osservabile;
- alternativa attuale;
- decisione che il dato abilita;
- costo di un falso positivo o falso negativo.

### 2. Definisci il modello di misurazione

Usa questa gerarchia:

```text
Outcome
→ metrica primaria
→ metriche di guardia
→ eventi
→ proprietà minime
→ baseline
→ soglia
→ decisione
```

Una metrica primaria senza guardrail può ottimizzare il comportamento sbagliato. Esempio: più
notifiche aperte non è un successo se aumentano disinstallazioni o disattivazioni.

### 3. Disegna gli eventi

Ogni evento deve avere:

- nome in `snake_case`;
- trigger preciso;
- owner;
- piattaforma;
- proprietà consentite;
- proprietà vietate;
- ambiente;
- stato: `planned`, `implemented`, `verified`, `deprecated`.

Esempio:

```text
Event: onboarding_completed
Trigger: l'utente supera l'ultimo passaggio e raggiunge la schermata principale
Properties: onboarding_version, entry_point, duration_bucket
Forbidden: email, nome, testo libero, token
```

### 4. Definisci funnel e coorti

Per ogni funnel:

- ingresso;
- passaggi;
- finestra temporale;
- completamento;
- abbandono;
- segmenti ammessi;
- decisione associata.

Non creare coorti con dati troppo piccoli o sensibili che possano identificare persone.

### 5. Baseline e soglie

Classifica la baseline:

- `unknown`;
- `manual_observation`;
- `existing_product_data`;
- `external_reference`;
- `experiment_control`.

Dichiara sempre provenienza e periodo. Una soglia scelta per il test va marcata come
`provisional`, non travestita da standard di settore.

### 6. Privacy e governance

Per ogni evento verifica:

- necessità;
- base di consenso o altra base applicabile da revisionare;
- retention;
- accessi;
- esportazione/cancellazione;
- ambienti test e produzione;
- eventuali dati di terze parti.

Non fornire conclusioni legali definitive. Segnala quando serve revisione professionale.

### 7. Verification plan

Un evento diventa `verified` soltanto dopo prova reale:

1. attiva il flusso in ambiente previsto;
2. controlla che l'evento parta una volta sola;
3. verifica proprietà e tipi;
4. verifica assenza di dati vietati;
5. controlla deduplicazione, offline e retry;
6. confronta conteggio client/server quando applicabile;
7. salva comando, screenshot o log come evidenza.

## Gate

Il piano è pronto quando esistono:

- outcome e decisione;
- metrica primaria;
- almeno un guardrail quando necessario;
- eventi e proprietà minime;
- baseline dichiarata o `unknown` motivato;
- soglia provvisoria o definitiva;
- privacy e retention;
- verifica prevista;
- owner e stato degli eventi.

Il gate può essere:

- `approved`;
- `approved_with_assumptions`;
- `blocked`;
- `not_applicable`.

## Handoff

Restituisci a Luna:

- sintesi delle metriche;
- assunzioni aperte;
- eventi da implementare nella slice corrente;
- eventi esclusi;
- rischi privacy;
- prossimo test;
- percorso `docs/MEASUREMENT_PLAN.md`.

Luna resta state owner e decide se proseguire verso implementazione, beta o revisione del prodotto.
