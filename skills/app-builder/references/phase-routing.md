# Routing degli specialisti

Luna sceglie autonomamente ruolo e prossimo specialista usando stato, artefatti, codice e rischio.
Non chiede all'utente di conoscere i nomi delle skill. Leggi il `SKILL.md` completo immediatamente
prima dell'uso e carica il minimo set necessario.

| Bisogno o segnale | Ruolo | Specialista primario | Motore esterno opzionale | Regola |
|---|---|---|---|---|
| Repo esistente senza stato affidabile | CTO | `$app-project-adoption` | Git/GitHub e test già presenti | Ricognizione read-only prima di modifiche |
| Problema, utenti, alternative e prove | Market Analyst | `$app-product-discovery` | ricerca pubblica corrente, catalogo marketing | Non chiamare “validato” ciò che è soltanto E0-E2 |
| Requisiti, MVP, esclusioni e acceptance | Operations Lead | `$app-requirements-mvp` | `prd-generator` | Luna possiede il confine MVP |
| Brand, voce e asset | Product Marketing | `$app-brand-assets` | `design`, `build-a-brand`, `design-system`, UI/UX Pro Max | Estrarre prima il brand esistente |
| Flussi, stati e accessibilità | Product Marketing | `$app-ux-accessibility` | `ui-ux-pro-max`, `impeccable`, audit platform | Checklist e runtime sono prove diverse |
| Microcopy, onboarding, errori e store copy | Product Marketing | `$app-copywriting` | `impeccable`, catalogo Marketing Skills | Product copy e marketing copy restano distinti |
| Outcome, eventi, funnel, baseline e soglie | Data Analyst | `$app-analytics-measurement` | analytics skill del catalogo, Data Analytics disponibile | Nessun dato o SDK senza consenso |
| Token e componenti | Product Marketing | `design-system` | UI/UX Pro Max | I token non sono codice finito |
| Concept mobile | Product Marketing | `imagegen-frontend-mobile` | brand + UX | Produce riferimenti, non React Native |
| Piano e implementazione non banale | CTO | Superpowers | skill stack | Brainstorming, piano, TDD e verifica; Luna possiede scope e gate |
| Expo/React Native | CTO | plugin ufficiale `expo` | UX/design system | Usa skill Expo versionate e codice reale |
| Web frontend | CTO | skill compatibile con stack | design system/UX | Non applicare prescrizioni web al native |
| Supabase/Auth/Postgres/Storage | CTO | `supabase:supabase` | postgres best practices + security | Migrazioni versionate, RLS, niente service key nel client |
| Sicurezza proporzionata | CTO | `$app-security-orchestrator` | Codex Security + catalogo community | Seleziona playbook, non carica 817 trigger |
| Sicurezza policy/minacce | CTO | `codex-security:define-security-policy`, `threat-model` | security orchestrator | Prima delle scansioni serie |
| Sicurezza di un diff | CTO | `codex-security:security-diff-scan` | `validation`, `fix-finding` | Modifiche sensibili Git-backed |
| Scan repository | CTO | `codex-security:security-scan` | deep scan per release pubblica | Non dichiarare copertura completa se incompleta |
| Android build security | CTO | `$app-security-orchestrator` | MobSF playbook | Docker/build upload richiedono consenso |
| iOS build security | CTO | `$app-security-orchestrator` | iOS assessment playbook | Serve ambiente Apple appropriato |
| GitHub/CI | CTO | plugin GitHub o skill installata | security supply-chain playbook | Push/PR solo con intento dell'utente |
| Test e QA | CTO | pratica engineering + test stack | Superpowers, device automation | Registra comandi e risultati reali |
| Beta e feedback | Support & Feedback | `$app-analytics-measurement` + copy | catalogo marketing | Classifica segnali, non rispondere o contattare senza consenso |
| Build/submit mobile | CTO | plugin Expo/EAS | strumenti store | Upload non equivale a pubblicazione completa |
| Pagamenti | Product Marketing + CTO | documentazione ufficiale + SDK scelto | security/store review | Definire prodotto prima del codice |
| Store compliance | Product Marketing | skill App Store/Play corrente | security per codice | Policy store non è security scan |
| Screenshot store | Product Marketing | `app-store-screenshots` | brand kit | Solo schermate vere e correnti |
| ASO e lancio | Product Marketing | skill ASO dal catalogo marketing | analytics/brand/copy | Vicino al lancio, non al wireframe |
| OpenAI API | CTO | `openai-docs` | server-side + cost controls | Fonti ufficiali e segreti fuori dal client |
| Capability non coperta | Operations Lead | `find-skills` | massimo tre candidati | Cerca solo dopo un capability gap documentato |

## Transizione automatica

Dopo un gate:

- `approved` → instrada il passo successivo;
- `approved_with_assumptions` → continua soltanto con investimento delimitato e test incorporato;
- `blocked` → mostra il blocker e non saltarlo;
- `not_applicable` → registra motivazione e continua.

Se l'utente chiede direttamente una funzione, esegui una verifica rapida dei prerequisiti e attiva
soltanto gli specialisti mancanti. Non costringerlo a recitare l'intero ciclo di vita per cambiare
una label, ma non implementare auth o pagamenti su requisiti immaginari.

## Delega

Prima di invocare uno specialista esterno registra il contratto definito in `external-roles.md`.
Luna resta l'unica interfaccia e il state owner. Dopo il risultato verifica compatibilità, prova e
limiti prima di aggiornare il gate.

## Regole di compatibilità

- Per native mobile, non importare hover, GSAP, DOM, Tailwind o layout da landing page senza motivo.
- Una sola skill di gusto/stile per deliverable, scelta dopo brand e stack.
- Le skill creative non coprono backend, sicurezza, test o deployment.
- Preferisci plugin ufficiali e fonti primarie; le skill community passano dal bootstrap autorizzato.
- I cataloghi sicurezza e marketing sono vendor content: leggi i playbook pertinenti, non attivare
  tutto e non eseguire script senza review.
- Superpowers controlla il processo engineering, non scope, stato o gate.
- `find-skills` propone candidati soltanto quando il capability gap resta aperto.
- Se manca uno specialista, registra capability gap, fallback nativo e prova usata.
