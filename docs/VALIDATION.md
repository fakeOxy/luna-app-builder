# Validazione automatica

Le pull request di Luna App Builder vengono controllate su Linux e Windows.

## Controlli statici

- validità JSON e YAML;
- struttura del plugin e delle undici skill native;
- frontmatter, metadati agente e descrizioni;
- routing autonomo verso discovery, requirements, brand, UX, copy, adoption e security;
- coerenza di nome, versione, repository e credito a Massimiliano;
- presenza di template e riferimenti interni;
- placeholder supportati, inclusi origine progetto e stato adozione;
- configurazione di bootstrap automatico dopo consenso;
- pin del catalogo sicurezza e attivazione on demand;
- assenza di registrazione in blocco delle 817 skill sicurezza;
- ricerca di chiavi, credenziali e file sensibili comuni;
- pattern pericolosi negli installer;
- copertura e checksum del manifesto SHA-256.

## Smoke test Linux e Windows

Per `personal`, `prototype` e `publication` la pipeline verifica:

- installazione delle undici skill native;
- inizializzazione dello stato autonomo;
- generazione di discovery, requirements, brand, asset, accessibility, copy e security plan;
- configurazione `askUserToChooseSkill: false`;
- bootstrap `--dry-run` senza rete o installazioni;
- creazione di registro e report bootstrap;
- rilevazione Doctor delle undici skill;
- preservazione UTF-8 e rimozione placeholder;
- integrità finale.

Viene inoltre creato un progetto fittizio già esistente con `package.json`; Doctor deve rilevarlo e
richiedere `$app-project-adoption` prima di modifiche strutturali.

## Cosa non viene eseguito in CI

La pipeline non:

- scarica specialisti community;
- clona le 817 skill sicurezza;
- esegue Docker, MobSF, scanner o penetration test;
- effettua login o OAuth;
- prova l'efficacia reale del routing conversazionale.

Queste verifiche richiedono test manuali controllati. Gli strumenti esterni vengono testati prima in
dry-run e poi, dopo consenso, in una cartella separata.

La pipeline è definita in `.github/workflows/validate.yml` e usa permessi `contents: read`.
Un controllo automatico riduce gli errori, ma non sostituisce revisione umana, prove in una vera
sessione Codex, tester reali o una firma crittografica della release.
