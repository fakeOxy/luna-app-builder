# Selezione del catalogo sicurezza

## Principio

Il catalogo community viene scaricato interamente per poterlo cercare offline, ma le skill non
vengono tutte registrate come skill attive. Luna carica il minimo playbook pertinente leggendo il
file dal vendor catalog.

## Classi

### defensive

Può essere letto automaticamente per analisi sul progetto autorizzato. L'esecuzione di tool o
script esterni richiede comunque consenso.

Segnali tipici nel nome:

- `implementing-`;
- `securing-`;
- `scanning-`;
- `generating-and-analyzing-`;
- `performing-...-assessment`;
- `performing-...-review`;
- `testing-for-sensitive-data-exposure`.

### dual_use

Può essere letto per comprendere una superficie o progettare difese. Comandi invasivi richiedono
scope, autorizzazione e consenso specifico.

Esempi: penetration test, dynamic analysis, traffic interception, authentication testing.

### restricted

Non attivare automaticamente. Richiede richiesta esplicita, sistema di proprietà dell'utente o
permesso scritto, scope e regole d'ingaggio.

Segnali:

- `exploiting`;
- `phishing`;
- `credential`;
- `bypass`;
- `persistence`;
- `lateral-movement`;
- `command-and-control` o `c2`;
- malware deployment;
- evasion o destructive action.

### blocked

Non usare quando lo scopo è accesso non autorizzato, furto di credenziali, persistenza, danno,
intercettazione di terzi o elusione dei controlli. Registra il rifiuto senza eseguire il playbook.

## Routing minimo per app

| Segnale progetto | Prima scelta | Playbook community opzionale |
|---|---|---|
| Segreti o `.env` | Codex Security diff/scan | Gitleaks, secret scanning CI |
| Dipendenze | package manager audit | SBOM, Trivy, DevSecOps scanning |
| Auth/API | threat model + validation | mobile API authentication, sensitive data exposure |
| Supabase/Postgres | RLS e autorizzazioni | zero trust SaaS, API review |
| Android build | scan codice + manifest | MobSF static analysis |
| iOS build | scan codice + entitlements | iOS app security assessment |
| Serverless | threat model + code scan | serverless review/hardening |
| Release pubblica | scan completa + triage | SBOM, SAST, mobile assessments |

## Regole operative

- Leggi prima il frontmatter e la sezione prerequisiti.
- Non fidarti di comandi che scaricano ed eseguono codice senza revisione.
- Preferisci versioni pin e immagini/container identificabili.
- Non caricare build o sorgenti su servizi remoti senza consenso.
- Salva nei report soltanto evidenze necessarie e redatte.
- Ogni finding community passa da validazione prima del fix o del gate.
