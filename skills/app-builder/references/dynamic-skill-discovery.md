# Ricerca dinamica delle skill

## Scopo

`find-skills` aiuta Luna a cercare una capability mancante. Non è un'autorizzazione a installare
il primo repository con un README entusiasta.

## Quando cercare

Usa la ricerca dinamica soltanto quando esiste un `capability_gap` reale:

- nessuna skill nativa o già installata copre il gate;
- il progetto usa uno stack o un servizio specialistico;
- una policy, piattaforma o tool richiede conoscenza aggiornata;
- il fallback generico produrrebbe un risultato non verificabile.

Non cercare nuove skill per attività ordinarie già coperte. Più strumenti non equivalgono a più
competenza, spesso equivalgono soltanto a più cartelle.

## Procedura

1. Descrivi il gap in una frase verificabile.
2. Controlla registro locale, plugin ufficiali e cataloghi già scaricati.
3. Se manca ancora, usa `find-skills` o `npx skills find` senza installare.
4. Valuta massimo tre candidati.
5. Registra per ciascuno:
   - repository e owner;
   - skill esatta;
   - descrizione;
   - licenza dichiarata;
   - ultimo commit o release osservata;
   - compatibilità Codex;
   - script/comandi inclusi;
   - rete, account, crediti o servizi richiesti;
   - rischio `low`, `medium`, `high`;
   - alternativa nativa.
6. Se la sorgente è già approvata nel registro e l'installazione rientra nel consenso bootstrap,
   installa e fai post-check.
7. Per una nuova sorgente presenta una raccomandazione singola e chiedi consenso.
8. Dopo l'installazione verifica che la skill sia caricata e prova un task innocuo.
9. Aggiorna `.app-builder/specialists.json` senza token o percorsi personali assoluti.

## Criteri di selezione

Preferisci nell'ordine:

1. plugin ufficiale compatibile;
2. fonte primaria del tool o framework;
3. repository community mantenuto, con licenza chiara e scope stretto;
4. fallback nativo Luna.

Popolarità e numero di installazioni sono segnali, non audit di sicurezza.

## Divieti

- niente installazione silenziosa da una ricerca;
- niente `curl | sh`, `wget | bash` o equivalenti;
- niente esecuzione automatica degli script inclusi;
- niente skill offensive o dual-use fuori dallo scope autorizzato;
- niente repository senza licenza per distribuzioni pubbliche senza revisione;
- niente aggiornamenti automatici che cambiano il pin durante una slice.

## Contratto di stato

Registra:

```text
capability_gap
search_query
candidates_reviewed
selected_specialist
source
version_or_commit
license
risk
consent
post_check
fallback
```

Luna resta l'unica interfaccia e il state owner. `find-skills` propone candidati, non decide il
percorso del progetto.
