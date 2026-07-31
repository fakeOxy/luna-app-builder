# Validazione automatica

Le pull request di Luna App Builder vengono controllate su Linux e Windows.

## Controlli statici

- validità JSON e YAML;
- struttura del plugin e delle dodici skill native;
- frontmatter, metadati agente e descrizioni;
- routing autonomo verso discovery, requirements, brand, UX, copy, analytics, adoption e security;
- Luna come unica interfaccia e state owner;
- presenza dei contratti per ruoli interni e delega esterna;
- `find-skills` limitata ai capability gap;
- Superpowers limitato al processo engineering;
- coerenza di nome, versione, repository e credito a Massimiliano;
- presenza di template e riferimenti interni, incluso `MEASUREMENT_PLAN.md`;
- placeholder supportati, inclusi origine progetto e stato adozione;
- configurazione di bootstrap automatico dopo consenso;
- pin dei cataloghi marketing e sicurezza;
- attivazione `on_demand_only` di entrambi i cataloghi;
- assenza di registrazione in blocco delle 817 skill sicurezza o dell'intero catalogo marketing;
- assenza di `shell: true`, download pipe-to-shell e pattern equivalenti nel bootstrap;
- ricerca di chiavi, credenziali e file sensibili comuni;
- pattern pericolosi negli installer;
- copertura e checksum del manifesto SHA-256.

## Smoke test Linux e Windows

Per `personal`, `prototype` e `publication` la pipeline verifica:

- installazione delle dodici skill native;
- inizializzazione dello stato autonomo con ruolo `Operations Lead`;
- generazione di discovery, requirements, brand, asset, accessibility, copy, measurement e security plan;
- configurazione `askUserToChooseSkill: false`;
- interfaccia `luna_only` e ruoli esterni interni;
- Find Skills in modalità capability-gap-only;
- Superpowers come processo engineering;
- cataloghi marketing e sicurezza on demand;
- bootstrap `--dry-run` senza rete o installazioni;
- creazione di registro e report bootstrap;
- presenza nel report di Find Skills, Superpowers e dei due cataloghi;
- rilevazione Doctor delle dodici skill e del measurement plan;
- preservazione UTF-8 e rimozione placeholder;
- integrità finale.

Viene inoltre creato un progetto fittizio già esistente con `package.json`; Doctor deve rilevarlo e
richiedere `$app-project-adoption` prima di modifiche strutturali.

## TDD del routing esterno

I controlli per la dodicesima skill, i ruoli, Find Skills, Superpowers e il catalogo marketing sono
stati introdotti prima dell'implementazione. La prima esecuzione è fallita sui file e contratti
mancanti. Dopo l'implementazione, la run `30664671279` ha superato validatore, parsing, tre modalità,
bootstrap dry-run, Doctor, progetto esistente e integrità sia su Linux sia su Windows.

## Cosa non viene eseguito in CI

La pipeline non:

- scarica realmente gli specialisti community;
- clona realmente i cataloghi marketing e sicurezza;
- esegue Docker, MobSF, scanner o penetration test;
- effettua login o OAuth;
- prova l'efficacia reale del routing conversazionale;
- verifica servizi esterni a pagamento o account dell'utente.

Queste verifiche richiedono test manuali controllati. Gli strumenti esterni vengono testati prima in
dry-run e poi, dopo consenso, in una cartella separata.

La pipeline è definita in `.github/workflows/validate.yml`. Le pull request usano permessi in sola
lettura. Il workflow separato di refresh del manifesto può scrivere soltanto su branch `feat/**`
del repository ufficiale e non sulle pull request esterne.

Un controllo automatico riduce gli errori, ma non sostituisce revisione umana, prove in una vera
sessione Codex, tester reali o una firma crittografica della release.
