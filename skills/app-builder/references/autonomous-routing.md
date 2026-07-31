# Routing autonomo di Luna

## Regola principale

L'utente non deve conoscere i nomi delle skill. Un messaggio come “voglio creare un'app” attiva
`$app-builder`, che legge stato e progetto, identifica il gate corrente e usa lo specialista
necessario. L'invocazione manuale resta disponibile, ma non è il percorso normale.

Luna non domanda “quale skill vuoi usare?”. Decide sulla base di evidenze, modalità e rischio.

## Nuovo progetto

```text
Doctor e bootstrap
→ Product discovery
→ Requirements e MVP
→ Brand leggero o completo
→ UX e accessibilità
→ Copywriting
→ Design system/UI
→ Architettura, dati e sicurezza
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

## Segnali e route

| Segnale osservato | Route primaria | Output |
|---|---|---|
| Idea vaga, pubblico o problema incerto | `$app-product-discovery` | `PRODUCT_DISCOVERY.md` |
| Discovery chiusa ma scope ambiguo | `$app-requirements-mvp` | `REQUIREMENTS.md` |
| Flussi, stati o barriere non definiti | `$app-ux-accessibility` | `USER_FLOWS.md`, `ACCESSIBILITY.md` |
| Nome, voce o asset incoerenti | `$app-brand-assets` | `BRAND.md`, `ASSET_INVENTORY.md` |
| Testi visibili, onboarding, errori o store | `$app-copywriting` | `COPY_SYSTEM.md` |
| Repo esistente senza stato Luna | `$app-project-adoption` | `adoption-report.md` |
| Auth, dati, API, pagamenti o release | `$app-security-orchestrator` | `SECURITY_PLAN.md` |
| Implementazione Expo | plugin ufficiale Expo | codice e test |
| Supabase/Auth/Postgres | plugin Supabase + security | migrazioni, RLS, test |

## Transizioni automatiche

Dopo ogni specialista:

1. rileggi artefatto e stato;
2. verifica il gate;
3. mostra decisione e limite;
4. se il prossimo passo è ordinario, reversibile e già autorizzato, continua;
5. se richiede spesa, account, installazione, pubblicazione, dati reali o scelta materiale, chiedi
   conferma;
6. non aprire più di una vertical slice.

## Richiesta diretta di implementazione

Se l'utente chiede subito “costruisci questa funzione”:

- ispeziona se requisiti, UX, copy, dati e sicurezza necessari esistono;
- usa in automatico gli specialisti mancanti con profondità minima;
- non costringere l'utente a una cerimonia completa per una modifica banale;
- blocca soltanto quando l'ambiguità può causare rework o rischio.

## Prevenzione dei loop

Registra per ogni skill:

- ultimo utilizzo;
- motivo;
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
- non affermare che uno strumento esterno è stato eseguito.
