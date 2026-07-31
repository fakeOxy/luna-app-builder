# Routing autonomo di Luna

## Regola principale

L'utente non deve conoscere i nomi delle skill. Un messaggio come “voglio creare un'app” attiva
`$app-builder`, che legge stato e progetto, identifica gate e rischio, assegna un ruolo interno e usa
lo specialista minimo necessario. L'invocazione manuale resta disponibile, ma non è il percorso
normale.

Luna resta l'unica interfaccia e il state owner. Non domanda “quale skill vuoi usare?” e non inoltra
all'utente transcript grezzi di agenti diversi.

## Nuovo progetto

```text
Doctor e bootstrap
→ Product discovery
→ Requirements e MVP
→ Brand leggero o completo
→ UX e accessibilità
→ Copywriting
→ Measurement plan quando serve
→ Design system/UI
→ Architettura, dati e sicurezza
→ Piano engineering con Superpowers
→ Vertical slice
→ QA, beta, store e operazioni
```

Ogni freccia richiede il gate precedente. `approved_with_assumptions` consente soltanto il prossimo
investimento delimitato e deve portarsi dietro il test dell'assunzione.

## Progetto esistente

```text
Ricognizione read-only
→ App Project Adoption
→ ricostruzione fasi già soddisfatte
→ routing dei soli gap
→ prima modifica minima
→ test di regressione
```

Non ripetere discovery, brand o UX se sono affidabili e ancora coerenti. Non migrare stack per
allineare il progetto ai gusti dell'agente.

## Ruoli interni

Usa `external-roles.md`:

- Market Analyst per problema, pubblico e alternative;
- Product Marketing per brand, copy, onboarding, pricing e store;
- CTO per architettura, piano e implementazione;
- Support & Feedback per beta, recensioni e problemi utente;
- Data Analyst per metriche, funnel ed esperimenti;
- Operations Lead per routing e gate. Questo ruolo è sempre Luna.

I ruoli non possiedono lo stato e non ampliano lo scope.

## Segnali e route

| Segnale osservato | Ruolo | Route primaria | Output |
|---|---|---|---|
| Idea vaga, pubblico o problema incerto | Market Analyst | `$app-product-discovery` | `PRODUCT_DISCOVERY.md` |
| Discovery chiusa ma scope ambiguo | Operations Lead | `$app-requirements-mvp` | `REQUIREMENTS.md` |
| Flussi, stati o barriere non definiti | Product Marketing | `$app-ux-accessibility` | `USER_FLOWS.md`, `ACCESSIBILITY.md` |
| Nome, voce o asset incoerenti | Product Marketing | `$app-brand-assets` | `BRAND.md`, `ASSET_INVENTORY.md` |
| Testi visibili, onboarding, errori o store | Product Marketing | `$app-copywriting` | `COPY_SYSTEM.md` |
| Outcome, beta, funnel o soglia da verificare | Data Analyst | `$app-analytics-measurement` | `MEASUREMENT_PLAN.md` |
| Repo esistente senza stato Luna | CTO | `$app-project-adoption` | `adoption-report.md` |
| Auth, dati, API, pagamenti o release | CTO | `$app-security-orchestrator` | `SECURITY_PLAN.md` |
| Implementazione non banale | CTO | Superpowers + skill stack | specifica, piano, codice e test |
| Implementazione Expo | CTO | plugin ufficiale Expo | codice e test |
| Supabase/Auth/Postgres | CTO | plugin Supabase + security | migrazioni, RLS, test |
| Capability non coperta | Operations Lead | `find-skills` dopo verifica gap | massimo tre candidati |

## Scelta degli specialisti esterni

1. Controlla skill native e plugin ufficiali.
2. Controlla cataloghi marketing e sicurezza locali.
3. Se il capability gap resta aperto, usa `dynamic-skill-discovery.md`.
4. Valuta massimo tre candidati.
5. Installa senza nuovo consenso soltanto sorgenti già approvate e coperte dal bootstrap.
6. Registra ruolo, specialista, input, percorsi consentiti, output, rischio e prova.
7. Usa il fallback nativo quando la sorgente manca o fallisce.

`find-skills` cerca; non decide. Superpowers governa il processo engineering; non decide scope e
gate.

## Transizioni automatiche

Dopo ogni specialista:

1. rileggi artefatto e stato;
2. verifica il gate;
3. mostra decisione e limite;
4. se il prossimo passo è ordinario, reversibile e già autorizzato, continua;
5. se richiede spesa, account, installazione non coperta, pubblicazione, dati reali o scelta
   materiale, chiedi conferma;
6. non aprire più di una vertical slice.

## Richiesta diretta di implementazione

Se l'utente chiede subito “costruisci questa funzione”:

- ispeziona se requisiti, UX, copy, measurement, dati e sicurezza necessari esistono;
- usa in automatico gli specialisti mancanti con profondità minima;
- usa Superpowers per specifica, piano, TDD e verifica quando la modifica non è banale;
- non costringere l'utente a una cerimonia completa per una modifica banale;
- blocca soltanto quando l'ambiguità può causare rework o rischio.

## Prevenzione dei loop

Registra per ogni delega:

- ruolo;
- specialista;
- ultimo utilizzo;
- motivo;
- input e percorsi consentiti;
- artefatto prodotto;
- gate;
- condizioni che richiedono una nuova esecuzione.

Non reinvocare uno specialista perché una fase ha un numero. Reinvocalo quando cambia un input
materiale o manca una prova.

## Fallback

Se uno specialista esterno non è disponibile:

- usa la skill nativa Luna;
- registra `external_specialist_unavailable`;
- non bloccare se il fallback copre il gate;
- non affermare che uno strumento esterno è stato eseguito;
- non chiedere all'utente di installare manualmente una lista di skill.
