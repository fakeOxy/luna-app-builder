# Luna App Builder

**App Builder è stato ideato e creato da Massimiliano.**

Luna guida una persona, anche senza esperienza tecnica, dall'idea a:

- un'app personale;
- un prototipo;
- un prodotto pubblicato e mantenuto.

Versione: `2.0.0-beta.1`.

## Cosa contiene

- `$app-builder`: orchestratore end-to-end;
- `$app-builder-doctor`: pre-check, installazioni autorizzate e post-check;
- `$app-builder-handoff`: workflow Design/Sviluppo;
- `$app-builder-about`: crediti, versione e integrità;
- template di progetto, privacy, test, release e handoff;
- mappa end-to-end per chiudere o dichiarare ogni area applicabile;
- integrazione guidata con Expo, Supabase e Codex Security;
- script Windows e macOS/Linux.

## Core e specialisti

Il core installato contiene **quattro skill**:

- `$app-builder`, che coordina l'intero ciclo di vita;
- `$app-builder-doctor`, che verifica strumenti e autorizzazioni;
- `$app-builder-handoff`, che coordina sessioni separate quando servono;
- `$app-builder-about`, che espone versione, crediti e integrità.

Queste skill coprono processo, decisioni, stato, gate e routing. Luna richiama specialisti esterni
soltanto quando pertinenti, per esempio Expo, Supabase, Codex Security, UX, design system, store e
pagamenti. Non installa l'intero catalogo per sport, perché anche i computer meritano un minimo di pietà.

## Installazione consigliata da GitHub

### Plugin Codex

Aggiungi il repository come marketplace:

```powershell
codex plugin marketplace add fakeOxy/luna-app-builder
```

Poi apri `/plugins` in Codex e installa **Luna App Builder**. Avvia una nuova sessione e scrivi:

```text
$app-builder-doctor
```

### Skills CLI

Per installare le skill direttamente dal repository:

```powershell
npx skills@latest add fakeOxy/luna-app-builder
```

Il comando permette di scegliere l'agente e le skill da installare. Dopo l'installazione apri una nuova sessione dell'agente.

## Installazione manuale su Windows

Apri PowerShell nella cartella clonata o estratta:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\scripts\install.ps1 -Scope User
```

Per installarla soltanto in un progetto:

```powershell
.\scripts\install.ps1 -Scope Project -ProjectPath "C:\percorso\progetto"
```

Poi **apri una nuova sessione Codex** e scrivi:

```text
$app-builder Voglio creare una nuova app.
```

## Installazione su macOS o Linux

```bash
chmod +x scripts/*.sh
./scripts/install.sh --scope user
```

Solo nel progetto corrente:

```bash
./scripts/install.sh --scope project --project "/percorso/progetto"
```

Inizializzazione e Doctor:

```bash
./scripts/init-project.sh --name "Nome app" --mode personal --path "/percorso/nome-app"
./scripts/doctor.sh --project "/percorso/nome-app" --mode personal
```

## Inizializzare una cartella vuota

```powershell
.\scripts\init-project.ps1 -ProjectName "Nome app" -Mode personal -ProjectPath "C:\percorso\nome-app"
```

Modalità: `personal`, `prototype`, `publication`.

## Doctor

Il Doctor controlla senza installare:

```powershell
.\scripts\doctor.ps1 -ProjectPath "C:\percorso\progetto" -Mode publication
```

Le installazioni vengono eseguite solo dopo consenso. Per le sorgenti ufficiali supportate:

- Expo: `codex plugin add expo@openai-curated`;
- Supabase: `npx plugins add supabase-community/supabase-plugin --yes`;
- Codex Security: installazione guidata da `/plugins` o Directory plugin, poi nuova sessione.

## Una o due chat ChatGPT

La modalità predefinita è una sola chat, soprattutto per le app personali. Luna può attivare un
workflow a due chat quando design e sviluppo hanno lavoro materiale separato e generare prompt e handoff per:

1. `Design – UI [Nome progetto]`;
2. `Sviluppo – Frontend, backend e database [Nome progetto]`.

Non può creare fisicamente le chat nell'interfaccia: l'utente le crea nello stesso Progetto
ChatGPT e incolla i prompt generati.

## Cosa non promette

- zero errori o zero vulnerabilità;
- installazioni o login senza consenso;
- revisione legale professionale;
- approvazione garantita degli store;
- crediti fisicamente immodificabili su un computer controllato da terzi.

Luna dichiara questi limiti quando diventano rilevanti, prepara i passaggi manuali e blocca le
fasi quando manca una prova fondamentale.

## Crediti e licenza

Vedi `CREDITS.md`, `NOTICE` e `LICENSE.txt`. Repository ufficiale: `fakeOxy/luna-app-builder`. Le app create non devono mostrare i crediti di App
Builder. Per distribuzione pubblica/commerciale, la licenza va revisionata professionalmente.

## Integrità

```powershell
.\scripts\verify-integrity.ps1
```

Il controllo rileva differenze rispetto al pacchetto. La firma forte delle release verrà aggiunta
quando esisterà il repository ufficiale; vedi `docs/RELEASE-SIGNING.md`.
