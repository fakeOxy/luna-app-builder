# Workflow Design e Sviluppo

## Quando usarlo

La modalità iniziale è `single_chat`. Passa a `two_chat` soltanto quando esistono attività materiali
separate di design e sviluppo, proprietari chiari e un vantaggio concreto nel parallelismo.

- **Personale:** una chat per impostazione predefinita.
- **Prototipo:** una chat per default; due se UI e implementazione procedono davvero in parallelo.
- **Pubblicazione:** due chat consigliate per progetti non banali, ma non obbligatorie.

Non impostare nomi di chat o `state owner` fittizi prima che il workflow a due chat sia stato
esplicitamente attivato. In una sola chat, lo state owner è la sessione corrente.

## Chat 1 — Design – UI [Nome progetto]

Possiede:

- brand e direzione visiva;
- UX e flussi;
- design system;
- concept, specifiche e asset;
- review visiva e accessibilità del design.

Non modifica codice di produzione né `.app-builder/state.md`, salvo autorizzazione specifica.

## Chat 2 — Sviluppo – Frontend, backend e database [Nome progetto]

Possiede:

- stato centrale;
- architettura e codice;
- backend, database e migrazioni;
- test, sicurezza, build e release;
- verifica e accettazione degli handoff.

## Handoff

Ogni file in `.app-builder/handoffs/` contiene:

- ID e stato;
- mittente e destinatario;
- obiettivo e contesto;
- decisioni approvate;
- input e path consentiti;
- acceptance criteria;
- output richiesti;
- test/verifiche;
- rischi e domande aperte.

## Limite della piattaforma

Luna non può creare materialmente le chat ChatGPT. Genera i prompt pronti in
`.app-builder/chat-prompts/`; l'utente crea le chat nello stesso Progetto ChatGPT e incolla i
prompt. Questa azione manuale deve essere indicata una sola volta.
