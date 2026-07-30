# Matrice delle capacità

Usa queste etichette in piani e gate.

| Stato | Significato | Esempio |
|---|---|---|
| `automatico` | Luna può eseguire il lavoro con gli strumenti disponibili | Creare file, test o documenti |
| `guidato` | Luna prepara e verifica, l'utente autorizza un passaggio | Collegare Supabase o creare una build firmata |
| `manuale` | L'utente deve agire in un'interfaccia esterna | Accettare accordi Apple, creare due chat ChatGPT |
| `specialista` | Serve una skill/plugin specifico | Scan Codex Security, build Expo/EAS |
| `revisione_umana` | Serve giudizio professionale o proprietario | Testo legale definitivo, rischio accettato |
| `non_disponibile` | Non può essere fatto nella superficie attuale | Creare chat nell'UI, garantire zero vulnerabilità |

## Regola

Dichiara il limite quando diventa rilevante, non nell'ultima riga del progetto. Per ogni attività
non automatica prepara istruzioni, input e criterio di verifica, così il passaggio manuale non
si trasforma in una caccia al tesoro amministrativa.
