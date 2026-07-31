# Rubrica delle evidenze

Usa questa rubrica per evitare che opinioni, ricerche pubbliche e comportamento reale vengano
mescolati sotto la parola comoda “validazione”.

## Livelli

| Livello | Significato | Esempi | Cosa consente di dire |
|---|---|---|---|
| E0 | Opinione o intuizione | preferenza del fondatore, idea, supposizione | “ipotesi” |
| E1 | Osservazione concreta ma limitata | problema personale ricorrente, aneddoto documentato | “osservato in questo caso” |
| E2 | Evidenza esterna corrente | documentazione ufficiale, dataset, report, competitor verificato | “supportato da fonti esterne” |
| E3 | Comportamento diretto di utenti pertinenti | test, interviste strutturate, uso del prototipo, impegno reale | “validato nel test descritto” |
| E4 | Risultato ripetuto e misurato | più cicli, soglia raggiunta, retention o conversione osservata | “ripetuto nelle condizioni descritte” |

## Regole

- Il livello appartiene a una singola affermazione, non all'intero progetto.
- Una fonte secondaria non diventa primaria perché viene citata da molti blog.
- L'esistenza di concorrenti dimostra che esiste un'offerta, non che il progetto avrà domanda.
- Un sondaggio sulle intenzioni è più debole di un comportamento osservato.
- Un test con amici o colleghi può essere utile, ma il campione e i bias devono essere dichiarati.
- Nessun risultato va generalizzato oltre pubblico, contesto, durata e piattaforma osservati.
- Numeri, prezzi, policy, limiti API e funzioni dei concorrenti devono avere data di verifica.

## Qualità della fonte

Preferisci, in ordine:

1. documentazione ufficiale, store, dataset primario o repository originale;
2. ricerca accademica o istituzionale pertinente;
3. fonte professionale riconosciuta con metodologia dichiarata;
4. testimonianza diretta verificabile;
5. aggregatori, blog o contenuti social, usati soltanto come indizio.

Quando fonti attendibili discordano, registra entrambe e spiega l'effetto sulla decisione.

## Freschezza

Classifica ogni fonte come:

- `current`: verificata nel periodo rilevante;
- `possibly_stale`: potrebbe essere cambiata e va ricontrollata;
- `historical`: utile soltanto per contesto;
- `unknown`: data o versione non disponibile.

Prezzi, policy store, API, disponibilità di prodotti e funzionalità software devono essere trattati
come instabili.

## Confidence della raccomandazione

- **Bassa:** dominano E0-E1 o manca una dipendenza decisiva.
- **Media:** esistono E2 pertinenti e almeno un test o osservazione diretta delimitata.
- **Alta:** le assunzioni più rischiose hanno E3-E4 coerenti e i principali vincoli sono verificati.

La confidence non è una percentuale inventata. Se non esiste un modello quantitativo reale, usa
soltanto basso, medio o alto e spiega perché.