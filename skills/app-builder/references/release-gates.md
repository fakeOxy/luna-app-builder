# Gate e blocchi

## Gate universale

Ogni fase mostra:

- decisioni approvate;
- artefatti prodotti;
- prove eseguite con comandi e risultati;
- verifiche non eseguite;
- rischi residui;
- singolo prossimo passo.

## Gate Product Discovery

Prima dello scaffold di un nuovo prodotto devono essere presenti, con profondità proporzionata alla
modalità:

- utente iniziale;
- problema e contesto;
- outcome;
- alternativa attuale;
- criterio di successo;
- MVP ed esclusioni;
- assunzione più rischiosa;
- evidenze disponibili e relativi limiti;
- fattibilità preliminare;
- prossimo test oppure motivazione `not_applicable`;
- raccomandazione e confidence.

`approved_with_assumptions` permette di procedere soltanto quando le assunzioni aperte sono
nominate e il loro test fa parte del prossimo investimento. Uno spike tecnico può precedere il gate
solo se delimitato, reversibile e approvato esplicitamente.

## Blocchi obbligatori

Non avanzare quando:

- il problema, l'utente iniziale o il confine MVP non sono definiti;
- la discovery usa dati correnti senza fonte o presenta ipotesi come fatti;
- una dipendenza decisiva di fattibilità è sconosciuta e non esiste uno spike approvato;
- il design da implementare ha una decisione materiale aperta;
- la build o il test principale falliscono;
- auth/RLS/autorizzazioni non sono verificate prima di dati utenti reali;
- segreti sono nel client o nel repository;
- backup e ripristino non sono stati provati prima della produzione quando i dati hanno valore;
- un finding critico convalidato è aperto;
- un finding alto per una release pubblica non ha fix o decisione esplicita del proprietario;
- pagamenti non supportano restore e stati principali;
- account creati non possono essere eliminati dove richiesto;
- la build non è stata provata su un dispositivo/ambiente rappresentativo;
- metadata o claim promettono funzioni non implementate.

## Accettazione del rischio

Solo il proprietario può accettare un rischio materiale. Registra: descrizione, impatto,
compensazioni, motivo, owner, data e scadenza. Non convertire un dubbio tecnico in “rischio
accettato” per sbloccare la tabella.