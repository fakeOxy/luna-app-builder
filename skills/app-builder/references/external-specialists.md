# Registro specialisti esterni

Questo registro descrive le sorgenti community usate dal bootstrap. Non sostituisce la verifica al
momento dell'installazione.

| Sorgente | Capability | Licenza dichiarata | Strategia |
|---|---|---|---|
| `vercel-labs/skills` | `find-skills` | verificare nel repository al bootstrap | installare la sola meta-skill; ricerca senza installazione automatica |
| `obra/superpowers` | brainstorming, piani, TDD, debugging, subagenti e verifica | verificare nel repository al bootstrap | motore di processo engineering sotto il controllo di Luna |
| `jamesrochabrun/skills` | `prd-generator` | verificare nel repository al bootstrap | installare solo la skill richiesta |
| `nextlevelbuilder/ui-ux-pro-max-skill` | UI/UX, design e design system | MIT nel repository; verificare componenti CLI | installazione Codex e report |
| `Pika-Labs/Pika-Plugins` | `build-a-brand` | Apache-2.0 | installare la skill; eventuali tool o crediti Pika richiedono consenso separato |
| `pbakaus/impeccable` | UX critique, audit, interaction, UX writing | verificare nel repository al bootstrap | skill condivisa, uso selettivo |
| `coreyhaines31/marketingskills` | marketing, competitor, copy, onboarding, pricing, analytics, ASO e lancio | MIT | clone versionato e indice locale; attivazione on demand |
| `mukul975/Anthropic-Cybersecurity-Skills` | 817 playbook in 29 domini | Apache-2.0 | clone pin, indice locale, attivazione on demand |

## Regole di fiducia

- Community non significa ufficiale.
- Installare una skill gratuita non autorizza eventuali servizi, crediti o chiamate a pagamento.
- Licenza del repository e licenza di un installer o asset possono differire: registra entrambe.
- Non eseguire automaticamente script inclusi nelle skill.
- Controlla commit, file modificati, prerequisiti e comandi prima dell'uso.
- Preferisci fonti ufficiali per policy, API, store e standard correnti.
- `find-skills` cerca candidati ma non autorizza l'installazione.
- Superpowers organizza il lavoro tecnico ma non sostituisce routing, stato o gate di Luna.
- I cataloghi marketing e sicurezza non vengono registrati interamente come trigger attivi.
- Se una sorgente cambia licenza o introduce comportamento incompatibile, il fallback nativo Luna
  resta disponibile.

## Ownership

Gli specialisti esterni forniscono metodi e reference. Luna resta l'unica interfaccia e possiede:

- selezione;
- consenso;
- stato;
- gate;
- prova;
- limitazioni;
- compatibilità con il progetto;
- decisione di avanzamento.

Usa `external-roles.md` per il contratto di delega e `dynamic-skill-discovery.md` per nuove sorgenti.
