# Validazione automatica

La pull request di Luna App Builder viene controllata automaticamente su Linux e Windows.

## Controlli eseguiti

- validità di JSON e YAML;
- struttura del plugin e delle quattro skill;
- coerenza di nome, versione, repository e credito a Massimiliano;
- presenza dei file obbligatori;
- riferimenti interni e placeholder dei template;
- ricerca di chiavi, credenziali e file sensibili comuni;
- ricerca di pattern pericolosi negli installer;
- sintassi degli script Bash e PowerShell;
- copertura e checksum del manifesto SHA-256;
- installazione in una cartella temporanea;
- inizializzazione di un progetto personale;
- generazione dei documenti e rimozione dei placeholder;
- esecuzione del Doctor;
- verifica finale dell'integrità.

La pipeline è definita in `.github/workflows/validate.yml` e viene eseguita sulle pull request, su `main` e sulle branch `setup/**`.

Un controllo automatico riduce gli errori, ma non sostituisce la revisione umana, i test in una vera sessione Codex o una firma crittografica della release.
