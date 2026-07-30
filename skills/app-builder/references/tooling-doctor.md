# Tooling Doctor

## Principio

Controlla prima, installa solo dopo consenso, ricontrolla e prova. L'installazione non implica che
un plugin sia autenticato, autorizzato o caricato nella sessione corrente.

## Pre-check

- sistema operativo e shell;
- Codex e versione;
- Git;
- Node.js/npm/npx quando richiesti;
- package manager e stack rilevati;
- skill locali e globali;
- plugin visibili nella sessione;
- account/permessi necessari;
- stato Expo, Supabase, Codex Security, GitHub e store in base alla modalità.

## Catalogo approvato

### Expo ufficiale

Quando il progetto usa Expo/React Native:

```text
codex plugin add expo@openai-curated
```

In alternativa usa `/plugins` e installa **Expo** dalla directory curata. Dopo l'installazione,
apri una nuova sessione e verifica che le skill Expo risultino disponibili.

### Supabase

Quando backend, Auth, Storage o Postgres sono necessari:

```text
npx plugins add supabase-community/supabase-plugin --yes
```

Il comando installa plugin, MCP e skill. Poi serve autenticazione dell'utente e selezione del
progetto. Verifica separatamente: plugin presente, MCP connesso, progetto corretto e permessi.

### Codex Security ufficiale

Per progetti pubblici o con dati/azioni sensibili, usa `/plugins` o la Directory plugin per
installare **Codex Security**. Non automatizzare con un comando non documentato. Dopo il riavvio
verifica almeno la presenza di:

- `codex-security:define-security-policy`;
- `codex-security:threat-model`;
- `codex-security:security-diff-scan`;
- `codex-security:security-scan`;
- `codex-security:deep-security-scan`;
- `codex-security:validation`;
- `codex-security:fix-finding`.

La disponibilità può dipendere da piano, ruolo, workspace e superficie.

### Skill community

Usa `npx skills@latest add ...` solo quando:

- la sorgente è indicata nel piano;
- la licenza è nota;
- la skill è pertinente;
- l'utente approva;
- non duplica uno specialista ufficiale migliore.

## Post-check

1. ripeti inventario e script;
2. verifica che la skill appaia nella sessione;
3. esegui un prompt innocuo o una lettura di documentazione;
4. per servizi esterni prova accesso read-only minimo;
5. registra `ready` solo con evidenza.

## Sicurezza

- Non stampare `.env`, token o chiavi.
- Non persistere token nei report.
- Non collegare account sbagliati “per provare”.
- Usa progetto di sviluppo e privilegi minimi.
- Chiedi conferma prima di comandi che modificano configurazioni globali.
