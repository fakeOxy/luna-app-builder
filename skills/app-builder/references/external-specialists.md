# Registro specialisti esterni

Questo registro descrive le sorgenti community usate dal bootstrap. Non sostituisce la verifica al
momento dell'installazione.

| Sorgente | Capability | Licenza dichiarata | Strategia |
|---|---|---|---|
| `jamesrochabrun/skills` | `prd-generator` | verificare nel repository al bootstrap | installare solo la skill richiesta |
| `nextlevelbuilder/ui-ux-pro-max-skill` | UI/UX, design, brand, design system | MIT nel repository; verificare componenti CLI | installazione Codex e report |
| `pbakaus/impeccable` | UX critique, audit, interaction, UX writing | verificare nel repository al bootstrap | skill condivisa, uso selettivo |
| `coreyhaines31/marketingskills` | product marketing, copywriting, copy editing | MIT | installare solo tre skill |
| `mukul975/Anthropic-Cybersecurity-Skills` | 817 playbook in 29 domini | Apache-2.0 | clone pin, indice locale, attivazione on demand |

## Regole di fiducia

- Community non significa ufficiale.
- Licenza del repository e licenza di un installer o asset possono differire: registra entrambe.
- Non eseguire automaticamente script inclusi nelle skill.
- Controlla commit, file modificati, prerequisiti e comandi prima dell'uso.
- Preferisci fonti ufficiali per policy, API, store e standard correnti.
- Se una sorgente cambia licenza o introduce comportamento incompatibile, il fallback nativo Luna
  resta disponibile.

## Ownership

Gli specialisti esterni forniscono metodi e reference. Luna possiede:

- selezione;
- consenso;
- stato;
- gate;
- prova;
- limitazioni;
- compatibilità con il progetto;
- decisione di avanzamento.
