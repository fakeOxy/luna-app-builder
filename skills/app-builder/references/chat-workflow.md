# Workflow Design e Sviluppo

## Quando usarlo

Usa due chat per progetti con UI rilevante e implementazione continuativa. Per una piccola app
personale una sola chat può essere più efficiente.

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
