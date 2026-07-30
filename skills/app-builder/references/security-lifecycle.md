# Ciclo di sicurezza

Codex Security è uno specialista, non sostituisce privacy, QA, backup o revisione umana.

## 1. Fondazione

Dopo architettura e mappa dati:

1. usa `$codex-security:define-security-policy` per creare/revisionare `SECURITY.md`;
2. usa `$codex-security:threat-model` per asset, input controllati, confini e invarianti;
3. registra dati sensibili, esposizione e livello di rischio nello stato.

Per un'app personale completamente locale, applica un controllo ridotto; non creare documentazione
cerimoniale senza valore.

## 2. Durante lo sviluppo

Esegui `$codex-security:security-diff-scan` su modifiche Git che toccano:

- autenticazione e autorizzazione;
- RLS, policy, schema, migrazioni o Edge Functions;
- API, upload, file, parser o deep link;
- segreti, configurazioni e CI;
- pagamenti e sottoscrizioni;
- dati personali/sensibili;
- notifiche, background task e permessi;
- AI, prompt, tool o contenuti utente.

Non serve uno scan pesante per ogni padding cambiato.

## 3. Tappe

- dopo backend/auth iniziali: scan standard del perimetro;
- prima della beta esterna: `$codex-security:security-scan` dell'intero repository;
- dopo cambi architetturali: nuova policy/threat model se necessario;
- prima di una release pubblica: scan standard e, quando disponibile/proporzionata,
  `$codex-security:deep-security-scan`;
- dopo una correzione: validazione e nuova scansione del diff.

## 4. Findings

```text
candidato
→ validation
→ reportable / suppressed / deferred
→ fix-finding per problemi reali
→ test di regressione
→ verifica del comportamento legittimo
→ nuova scansione
```

Non correggere automaticamente ogni segnalazione. Non dichiarare `fixed` senza prova.

## 5. Gate

- critico convalidato: blocco assoluto della release pubblica;
- alto: blocco salvo decisione esplicita, documentata e temporanea del proprietario;
- medio/basso: fix o accettazione registrata con owner e scadenza;
- copertura incompleta: dichiararla, non convertirla in “nessun problema”.

## Limiti

Nessuno scanner garantisce assenza di vulnerabilità. Codex Security può non essere disponibile
per piano/superficie e le patch richiedono revisione umana. In quel caso usa secure engineering,
test, dependency/secret scanning e registra la lacuna.
