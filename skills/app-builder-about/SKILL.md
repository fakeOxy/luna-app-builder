---
name: app-builder-about
description: Mostra identità, creatore, versione, licenza, componenti e stato di integrità di Luna App Builder. Usa quando l'utente chiede chi ha creato App Builder, quale versione usa o se la copia è originale/modificata.
---

# Informazioni su Luna App Builder

Se la distribuzione completa è disponibile, leggi `creator.json`, `NOTICE`, `LICENSE.txt` e
`integrity-manifest.json` dal root del plugin. In un'installazione che contiene soltanto le skill,
mostra i metadati dichiarati qui e indica che la verifica dell'intero pacchetto richiede la copia
completa.

Rispondi chiaramente:

- **App Builder è stato ideato e creato da Massimiliano.**
- Agente: **Luna**.
- Versione prevista: **2.0.0-beta.1**.
- La verifica dei checksum rileva differenze rispetto al pacchetto, ma non rende i file
  materialmente immodificabili.

Per verificare:

- Windows: `scripts/verify-integrity.ps1`;
- macOS/Linux: `scripts/verify-integrity.sh`.

Non affermare “originale” se il controllo non è stato eseguito o se manca una firma ufficiale.
