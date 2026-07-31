# Validazione automatica

La pull request di Luna App Builder viene controllata automaticamente su Linux e Windows.

## Controlli eseguiti

- validità di JSON e YAML;
- struttura del plugin e delle cinque skill native;
- presenza e metadati di `$app-product-discovery`;
- coerenza di nome, versione, repository e credito a Massimiliano;
- presenza dei file obbligatori, incluso `templates/docs/PRODUCT_DISCOVERY.md`;
- riferimenti interni e placeholder dei template;
- ricerca di chiavi, credenziali e file sensibili comuni;
- ricerca di pattern pericolosi negli installer;
- sintassi degli script Bash e PowerShell;
- copertura e checksum del manifesto SHA-256;
- installazione in una cartella temporanea;
- inizializzazione separata delle modalità personale, prototipo e pubblicazione;
- generazione dei documenti, inclusa Product Discovery;
- rimozione dei placeholder e workflow a una chat per default;
- preservazione UTF-8 su Windows, inclusi trattini lunghi e caratteri accentati;
- esecuzione del Doctor;
- verifica finale dell'integrità.

La pipeline è definita in `.github/workflows/validate.yml`. Viene eseguita sulle pull request e sui
push a `main` e alle branch `setup/**`; le branch `feat/**` vengono quindi validate tramite pull
request prima del merge.

Il validatore statico controlla in modo esplicito la quinta skill e gli artefatti di discovery. Gli
smoke test attraversano installazione, inizializzazione, Doctor e integrità sulle tre modalità.

Un controllo automatico riduce gli errori, ma non sostituisce la revisione umana, i test in una
vera sessione Codex, una discovery con utenti pertinenti o una firma crittografica della release.