---
name: app-builder-handoff
description: Crea e mantiene il workflow coordinato tra chat o task Design e Sviluppo, con prompt iniziali, proprietà dei file, specifiche, accettazione e passaggi persistenti senza modifiche concorrenti.
---

# App Builder Handoff

Leggi `../app-builder/references/chat-workflow.md`.

## Responsabilità

1. Determina se il progetto beneficia di una o due chat.
2. Se usa due chat, genera:
   - `.app-builder/chat-prompts/design.md`;
   - `.app-builder/chat-prompts/development.md`;
   - `.app-builder/handoffs/README.md`;
   - un handoff per la slice corrente.
3. Assegna sempre uno state owner. Di norma è la chat Sviluppo.
4. Il Design può creare concept, specifiche e asset solo nei path assegnati.
5. Lo Sviluppo implementa, verifica e aggiorna lo stato centrale.
6. Ogni handoff deve contenere obiettivo, input, decisioni approvate, file consentiti,
   acceptance criteria, output e limiti.
7. Chi riceve verifica il risultato prima di segnare l'handoff come chiuso.

## Limite esplicito

Non puoi creare o nominare fisicamente chat nell'interfaccia di ChatGPT. Produci i due prompt
pronti da copiare e indica all'utente questo unico passaggio manuale.
