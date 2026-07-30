# Gate e blocchi

## Gate universale

Ogni fase mostra:

- decisioni approvate;
- artefatti prodotti;
- prove eseguite con comandi e risultati;
- verifiche non eseguite;
- rischi residui;
- singolo prossimo passo.

## Blocchi obbligatori

Non avanzare quando:

- il problema o il confine MVP non sono definiti;
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
