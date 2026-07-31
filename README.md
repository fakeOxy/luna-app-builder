# Luna App Builder

**App Builder è stato ideato e creato da Massimiliano.**

Luna guida anche chi non ha esperienza tecnica dall'idea o da un progetto esistente a:

- un'app personale;
- un prototipo;
- un prodotto pubblicato e mantenuto.

Versione pubblicata: `2.0.0-beta.1`.

Il branch di sviluppo della futura `v2.0.0-beta.2` aggiunge routing autonomo, adozione non invasiva,
specialisti di prodotto/design/copy e un catalogo sicurezza locale. Finché la relativa pull request
non viene validata e unita, la release pubblica resta la beta precedente.

## Come lavora Luna

L'utente non deve conoscere o scegliere i nomi delle skill. Un comando generico come:

```text
$app-builder Voglio creare una nuova app.
```

fa partire questo percorso proporzionato:

```text
Doctor e bootstrap
→ discovery
→ requisiti e MVP
→ brand e asset
→ UX e accessibilità
→ copywriting
→ design e architettura
→ sicurezza
→ implementazione in vertical slice
→ QA, beta, store e operazioni
```

Luna legge stato, codice e rischi, usa lo specialista necessario e continua automaticamente
soltanto nelle azioni ordinarie, reversibili e già autorizzate. Installazioni, account, spese,
pubblicazioni, dati reali e strumenti invasivi richiedono consenso.

## Undici skill native

- `$app-builder`: orchestrazione end-to-end e routing autonomo;
- `$app-builder-doctor`: ambiente, bootstrap, plugin e post-check;
- `$app-builder-handoff`: coordinamento Design/Sviluppo;
- `$app-builder-about`: versione, crediti e integrità;
- `$app-product-discovery`: problema, utenti, evidenze e decisione prima del codice;
- `$app-requirements-mvp`: requisiti, confine MVP, acceptance criteria e prima slice;
- `$app-ux-accessibility`: flussi, stati, recovery e accessibilità;
- `$app-brand-assets`: posizionamento, voce, sistema visivo e inventario asset;
- `$app-copywriting`: microcopy, onboarding, errori, notifiche e store copy;
- `$app-project-adoption`: innesto read-only nei progetti esistenti;
- `$app-security-orchestrator`: regia sicurezza con Codex Security e playbook selettivi.

Le skill native possiedono stato, gate, consenso e fallback. Gli specialisti community ampliano la
profondità, ma non decidono da soli scope o avanzamento.

## Primo accesso e bootstrap automatico

Al primo accesso Luna:

1. esegue il Doctor senza installare nulla;
2. capisce se la cartella è nuova o contiene già un progetto;
3. presenta una sola richiesta di consenso per il bootstrap;
4. dopo approvazione scarica automaticamente gli specialisti gratuiti selezionati;
5. ripete il Doctor e registra ciò che funziona e i fallback.

Il bootstrap prepara:

- `prd-generator` da `jamesrochabrun/skills`;
- UI/UX Pro Max e le skill `design` e `design-system`;
- `build-a-brand` da `Pika-Labs/Pika-Plugins`;
- Impeccable per critica UX, accessibilità e UX writing;
- `product-marketing`, `copywriting` e `copy-editing` da Marketing Skills;
- il catalogo `mukul975/Anthropic-Cybersecurity-Skills` fissato a un commit verificato.

Le skill vengono installate gratuitamente, ma eventuali MCP, API, crediti o strumenti a pagamento
richiesti in seguito non vengono mai avviati dal consenso iniziale. Il bootstrap protegge inoltre le
cache locali tramite `.git/info/exclude`, senza modificare il `.gitignore` condiviso del progetto.

Il consenso al bootstrap non autorizza login, crediti Pika, Docker, scanner, upload, penetration
testing o pubblicazione. Questi restano passaggi separati.

## Le 817 skill di sicurezza

Il catalogo completo viene scaricato in:

```text
.app-builder/vendor/anthropic-cybersecurity-skills
```

Luna genera un indice locale in:

```text
.app-builder/security-catalog/index.json
```

Le 817 skill **non** vengono registrate tutte come skill attive. Sarebbe una pessima combinazione di
trigger sovrapposti, contesto sprecato e procedure offensive pronte a intervenire dove nessuno le ha
invitate. `$app-security-orchestrator` classifica i playbook come difensivi, dual-use, restricted o
blocked e legge soltanto quelli pertinenti.

Codex Security resta il motore primario per policy, threat model, scansioni, validazione e fix. Il
catalogo community aggiunge playbook per secret scanning, SAST, SBOM, API/auth, MobSF, iOS,
serverless e altri controlli specialistici. L'esecuzione di tool esterni richiede consenso e scope.

## Progetti esistenti

Quando Luna trova codice reale, usa `$app-project-adoption` prima di modificare:

- working tree e baseline;
- stack, package manager e versioni;
- build, test, lint e CI;
- convenzioni, design system, asset e copy;
- database, auth, API e sicurezza;
- fonti di verità e aree protette.

Crea `.app-builder/adoption-report.md`, ricostruisce le fasi già soddisfatte e attiva soltanto i
gap. Non cambia stack, rinomina cartelle, aggiorna dipendenze o ridisegna tutto per preferenza.

## Installazione da GitHub

### Skills CLI

Dentro la cartella del progetto:

```powershell
npx skills add fakeOxy/luna-app-builder --skill "*" -a codex --copy -y
```

Apri una nuova sessione Codex e scrivi:

```text
$app-builder Voglio creare una nuova app.
```

### Installazione manuale Windows

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\scripts\install.ps1 -Scope Project -ProjectPath "C:\percorso\progetto"
.\scripts\init-project.ps1 -ProjectName "Nome app" -Mode prototype -ProjectPath "C:\percorso\progetto"
```

### macOS/Linux

```bash
chmod +x scripts/*.sh
./scripts/install.sh --scope project --project "/percorso/progetto"
./scripts/init-project.sh --name "Nome app" --mode prototype --path "/percorso/progetto"
```

L'inizializzatore preserva i file già esistenti, rileva `new` o `existing` e crea documenti Luna
senza sovrascrivere quelli presenti salvo `--force`/`-Force`.

## Doctor

Controllo senza installazioni:

```powershell
.\scripts\doctor.ps1 -ProjectPath "C:\percorso\progetto" -Mode publication
```

Dopo il consenso unico al bootstrap:

```powershell
.\scripts\doctor.ps1 -ProjectPath "C:\percorso\progetto" -Mode publication -AutoInstallApproved
```

Il report non prova automaticamente autenticazione, permessi o caricamento nella chat. Luna esegue
il post-check e non salva token.

## Una o due chat

Una sola chat è il default. Luna può attivare due sessioni quando brand/UX/copy e sviluppo hanno
lavoro materiale separato:

1. `Design – UI [Nome progetto]`;
2. `Sviluppo – Frontend, backend e database [Nome progetto]`.

Genera prompt e handoff, ma non può creare fisicamente le chat nell'interfaccia.

## Cosa non promette

- zero errori o vulnerabilità;
- approvazione garantita degli store;
- revisione legale o security professionale;
- login, account o pubblicazioni senza l'utente;
- che una scansione automatica equivalga a prova completa;
- che una ricerca documentale equivalga a validazione del comportamento.

## Crediti, licenza e integrità

Vedi `CREDITS.md`, `NOTICE` e `LICENSE.txt`. Le app create non devono mostrare i crediti di App
Builder. Le sorgenti community mantengono licenze e attribuzioni proprie.

```powershell
.\scripts\verify-integrity.ps1
```

La release `v2.0.0-beta.1` usa tag Git e manifesto SHA-256, ma non include ancora una firma
crittografica forte; vedi `docs/RELEASE-SIGNING.md`.
