# Luna App Builder

**App Builder è stato ideato e creato da Massimiliano.**

Luna guida anche chi non ha esperienza tecnica dall'idea o da un progetto esistente a:

- un'app personale;
- un prototipo;
- un prodotto pubblicato e mantenuto.

Versione pubblicata: `2.0.0-beta.1`.

La pull request della futura `v2.0.0-beta.2` aggiunge routing autonomo, adozione non invasiva,
ruoli interni, specialisti di prodotto/design/copy/analytics, Superpowers, ricerca dinamica delle
skill e cataloghi marketing e sicurezza locali. Finché non viene validata e unita, la release
pubblica resta la beta precedente.

## Una sola Luna

L'utente non deve conoscere ruoli, agenti o nomi delle skill. Un comando generico come:

```text
$app-builder Voglio creare una nuova app.
```

fa partire un percorso proporzionato:

```text
Doctor e bootstrap
→ discovery
→ requisiti e MVP
→ brand e asset
→ UX e accessibilità
→ copywriting
→ measurement plan
→ design e architettura
→ sicurezza
→ piano engineering
→ implementazione in vertical slice
→ QA, beta, store e operazioni
```

Luna resta l'unica interfaccia visibile e il `state owner`. Assegna internamente il ruolo utile,
chiama il minimo specialista necessario, verifica il risultato e restituisce una sola sintesi con un
solo prossimo passo. Installazioni, account, spese, pubblicazioni, dati reali e strumenti invasivi
richiedono consenso.

## Dodici skill native

- `$app-builder`: orchestrazione end-to-end, ruoli e routing autonomo;
- `$app-builder-doctor`: ambiente, bootstrap, plugin, cataloghi e post-check;
- `$app-builder-handoff`: coordinamento Design/Sviluppo;
- `$app-builder-about`: versione, crediti e integrità;
- `$app-product-discovery`: problema, utenti, evidenze e decisione prima del codice;
- `$app-requirements-mvp`: requisiti, confine MVP, acceptance criteria e prima slice;
- `$app-ux-accessibility`: flussi, stati, recovery e accessibilità;
- `$app-brand-assets`: posizionamento, voce, sistema visivo e inventario asset;
- `$app-copywriting`: microcopy, onboarding, errori, notifiche e store copy;
- `$app-project-adoption`: innesto read-only nei progetti esistenti;
- `$app-security-orchestrator`: regia sicurezza con Codex Security e playbook selettivi;
- `$app-analytics-measurement`: outcome, eventi, funnel, baseline, soglie e privacy.

Le skill native possiedono stato, gate, consenso e fallback. Gli specialisti community aumentano la
profondità, ma non decidono scope o avanzamento.

## Sei ruoli interni

Luna può operare internamente come:

- Market Analyst;
- Product Marketing;
- CTO;
- Support & Feedback;
- Data Analyst;
- Operations Lead.

`Operations Lead` è sempre Luna. I ruoli non sono sei chat da amministrare e non modificano lo
stato centrale. Prima di ogni delega Luna registra motivo, input, percorsi consentiti, output atteso,
rischio e consenso.

## Primo accesso e bootstrap automatico

Al primo accesso Luna:

1. esegue il Doctor senza installare nulla;
2. capisce se la cartella è nuova o contiene già un progetto;
3. presenta una sola richiesta di consenso per il bootstrap gratuito dichiarato;
4. dopo approvazione prepara automaticamente specialisti e cataloghi;
5. ripete il Doctor e registra capacità riuscite, fallback e limiti.

Il bootstrap prepara:

- `find-skills` da `vercel-labs/skills`;
- Superpowers da `obra/superpowers` come processo engineering;
- `prd-generator`;
- UI/UX Pro Max, `design` e `design-system`;
- `build-a-brand`;
- Impeccable;
- `product-marketing`, `copywriting` e `copy-editing`;
- il catalogo completo Marketing Skills;
- il catalogo completo Anthropic Cybersecurity Skills.

Le cache vendor vengono escluse tramite `.git/info/exclude`, senza modificare il `.gitignore`
condiviso. Registro e report usano percorsi relativi.

Il consenso iniziale non autorizza login, crediti, API, Docker, scanner, upload, penetration test,
push o pubblicazioni.

## Find Skills

`find-skills` viene usata soltanto quando Luna registra un `capability_gap` non coperto da:

1. skill native;
2. plugin ufficiali;
3. cataloghi locali;
4. fallback già disponibili.

Luna valuta massimo tre candidati e controlla repository, licenza, manutenzione, compatibilità,
script, servizi richiesti e rischio. Una nuova sorgente non viene installata senza consenso. Il
numero di download è un segnale, non una benedizione papale sulla supply chain.

## Superpowers

Superpowers organizza il lavoro del ruolo CTO per modifiche non banali:

```text
brainstorming e specifica
→ piano scritto
→ TDD quando applicabile
→ implementazione
→ debugging sistematico
→ verifica prima del completamento
```

Può coordinare subagenti su task indipendenti, ma Luna conserva scope, stato, gate e comunicazione
finale.

## Catalogo marketing

Il repository completo viene scaricato in:

```text
.app-builder/vendor/marketing-skills
```

L'indice locale vive in:

```text
.app-builder/marketing-catalog/index.json
```

Luna usa on demand skill pertinenti a competitor, posizionamento, copy, onboarding, pricing,
paywall, analytics, ASO e lancio. Il catalogo non viene registrato interamente come trigger attivi.

## Le 817 skill di sicurezza

Il catalogo completo viene scaricato in:

```text
.app-builder/vendor/anthropic-cybersecurity-skills
```

L'indice locale vive in:

```text
.app-builder/security-catalog/index.json
```

Le 817 skill non vengono registrate tutte come skill attive. `$app-security-orchestrator` classifica
i playbook come difensivi, dual-use, restricted o blocked e legge soltanto quelli pertinenti.
Codex Security resta il motore primario per policy, threat model, scansioni, validazione e fix.
L'esecuzione di strumenti esterni richiede scope e consenso separati.

## Analytics e misurazione

`$app-analytics-measurement` collega ogni metrica a una decisione reale:

```text
outcome
→ metrica primaria
→ guardrail
→ eventi e proprietà minime
→ baseline
→ soglia
→ verifica
```

Produce `docs/MEASUREMENT_PLAN.md`, non installa SDK e non invia dati. Baseline e risultati non
vengono inventati. Privacy, retention e dati vietati fanno parte del gate.

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

L'inizializzatore preserva i file esistenti, rileva `new` o `existing` e crea documenti Luna senza
sovrascriverli salvo `--force` o `-Force`.

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
