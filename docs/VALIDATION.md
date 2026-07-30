# Validazione automatica

La pull request di Luna App Builder viene controllata automaticamente su Linux e Windows.

## Controlli eseguiti

- validità di JSON e YAML;
- struttura del plugin e delle cinque skill native;
- coerenza di nome, versione, repository e credito a Massimiliano;
- presenza dei file obbligatori;
- riferimenti interni e placeholder dei template;
- ricerca di chiavi, credenziali e file sensibili comuni;
- ricerca di pattern pericolosi negli installer;
- sintassi degli script Bash e PowerShell;
- copertura e checksum del manifesto SHA-256;
- installazione in una cartella temporanea;
- presenza e caricamento di `$app-product-discovery`;
- inizializzazione separata delle modalità personale, prototipo e pubblicazione;
- generazione di `docs/PRODUCT_DISCOVERY.md` e degli altri documenti;
- rimozione dei placeholder e workflow a una chat per default;
- preservazione UTF-8 su Windows, inclusi trattini lunghi e caratteri accentati;
- esecuzione del Doctor e verifica delle righe Product Discovery;
- verifica finale dell'integrità.

La pipeline è definita in `.github/workflows/validate.yml` e viene eseguita sulle pull request, su
`main` e sulle branch `setup/**` e `feat/**`.

Un controllo automatico riduce gli errori, ma non sostituisce la revisione umana, i test in una
vera sessione Codex, una discovery con utenti pertinenti o una firma crittografica della release.