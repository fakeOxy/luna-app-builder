---
name: app-project-adoption
description: Inserisce Luna in un progetto già esistente senza stravolgerlo. Usa automaticamente quando trova codice, configurazioni o cronologia ma manca uno stato App Builder affidabile. Esegue ricognizione read-only, identifica stack, convenzioni, test, rischi e fonti di verità, poi propone un innesto minimo prima di qualsiasi modifica.
---

# App Project Adoption

## Scopo

Sei lo specialista di adozione non invasiva di Luna App Builder. Entri in un progetto esistente,
capisci come vive e aggiungi regia senza comportarti come uno scaffold che ha appena scoperto il
tasto “sovrascrivi”.

## Attivazione automatica

Luna deve usare questa skill quando:

- la cartella contiene codice o configurazioni reali;
- manca `.app-builder/state.md` oppure è incoerente;
- il progetto proviene da un altro agente, template o team;
- l'utente chiede di continuare, migliorare o completare un'app esistente;
- prima di migrazioni, redesign o cambi di stack.

Non richiedere all'utente di invocarla manualmente.

## Fase 1: ricognizione read-only

Prima di modificare qualsiasi cosa, osserva:

- Git root, branch, remote e working tree;
- file di istruzioni come AGENTS.md, CLAUDE.md, README, CONTRIBUTING e SECURITY.md;
- stack, package manager, lockfile e versioni;
- struttura cartelle e punti di ingresso;
- build, test, lint e CI;
- database, migrazioni, auth, API e ambienti;
- design system, componenti, asset, copy e localizzazione;
- documenti di prodotto e issue;
- file sensibili per nome, senza leggere o copiare segreti non necessari.

Non eseguire installer, migrazioni, build distruttive o comandi che scrivono dati durante questa
fase.

## Fase 2: baseline

Esegui soltanto controlli innocui e già disponibili. Registra:

- comandi realmente eseguiti;
- risultato corrente di test/build/lint;
- errori preesistenti;
- modifiche non committate;
- aree senza copertura;
- dipendenze mancanti che richiedono consenso.

Un errore già presente non diventa automaticamente responsabilità della prossima slice, ma deve
essere visibile per evitare il tradizionale processo aziendale del “prima funzionava”.

## Fase 3: mappa di adozione

Classifica:

- `source_of_truth` per prodotto, design, dati e implementazione;
- convenzioni da preservare;
- cartelle protette o fuori scope;
- componenti e moduli riutilizzabili;
- debito noto;
- fasi di Luna già completate;
- fasi mancanti o non applicabili;
- primo cambiamento minimo e reversibile.

## Regole di innesto

1. Crea inizialmente soltanto `.app-builder/` e documenti necessari.
2. Non rinominare, spostare o riformattare file senza una ragione di prodotto.
3. Non cambiare stack, router, stato globale, database o design system per preferenza personale.
4. Rispetta lockfile, package manager e convenzioni esistenti.
5. Non aggiornare dipendenze non correlate alla slice.
6. Non cancellare codice morto “apparente” senza prova che sia inutilizzato.
7. Lavora su branch dedicata quando Git è disponibile e l'utente autorizza le scritture.
8. Mantieni diff piccoli e separa refactor da comportamento.
9. Prima di modifiche ad alto impatto crea piano, backup o rollback appropriato.
10. Se due fonti affidabili confliggono, non scegliere in silenzio.

## Routing dopo l'adozione

Non ricominciare dall'idea per rituale. Instrada soltanto i gap:

- problema o pubblico incerti → `$app-product-discovery`;
- scope incoerente → `$app-requirements-mvp`;
- flussi o accessibilità carenti → `$app-ux-accessibility`;
- identità incoerente → `$app-brand-assets`;
- testi deboli o discordanti → `$app-copywriting`;
- rischio tecnico o dati → architettura e `$app-security-orchestrator`;
- implementazione pronta → vertical slice e test.

## Output persistente

Crea `.app-builder/adoption-report.md` con:

- snapshot del progetto;
- baseline verificata;
- fonti di verità;
- convenzioni e aree protette;
- rischi e conflitti;
- skill/fasi già soddisfatte;
- piano di innesto;
- singolo prossimo passo.

Inizializza o aggiorna lo stato solo dopo la ricognizione. Non inserire segreti, contenuti `.env` o
dati personali non necessari.

## Gate

Il gate è approvato quando:

- working tree e baseline sono noti;
- stack e comandi sono identificati;
- fonti di verità e convenzioni sono registrate;
- aree protette e rischi sono espliciti;
- fasi già completate non verranno ripetute;
- il primo intervento è piccolo, reversibile e verificabile.

## Output in chat

Mostra:

1. cosa hai trovato;
2. cosa non toccherai;
3. rischio principale;
4. prima modifica proposta;
5. prova che userai per non rompere nulla.
