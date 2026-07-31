# Routing degli specialisti

Luna sceglie autonomamente il prossimo specialista usando stato, artefatti, codice e rischio. Non
chiede all'utente di conoscere i nomi delle skill. Leggi il `SKILL.md` completo immediatamente prima
dell'uso e carica il minimo set necessario.

| Bisogno o segnale | Specialista primario | Motore esterno opzionale | Regola |
|---|---|---|---|
| Repo esistente senza stato affidabile | `$app-project-adoption` | Git/GitHub e test già presenti | Ricognizione read-only prima di modifiche |
| Problema, utenti, alternative e prove | `$app-product-discovery` | ricerca pubblica corrente | Non chiamare “validato” ciò che è soltanto E0-E2 |
| Requisiti, MVP, esclusioni e acceptance | `$app-requirements-mvp` | `prd-generator` | Luna possiede il confine MVP |
| Brand, voce e asset | `$app-brand-assets` | `design`, `brand`, `design-system`, UI/UX Pro Max | Estrarre prima il brand esistente |
| Flussi, stati e accessibilità | `$app-ux-accessibility` | `ui-ux-pro-max`, `impeccable`, audit platform | Checklist e runtime sono prove diverse |
| Microcopy, onboarding, errori e store copy | `$app-copywriting` | `impeccable`, Marketing Skills | Product copy e marketing copy restano distinti |
| Token e componenti | `design-system` | UI/UX Pro Max | I token non sono codice finito |
| Concept mobile | `imagegen-frontend-mobile` | brand + UX | Produce riferimenti, non React Native |
| Expo/React Native | plugin ufficiale `expo` | UX/design system | Usa skill Expo versionate e codice reale |
| Web frontend | skill compatibile con stack | design system/UX | Non applicare prescrizioni web al native |
| Supabase/Auth/Postgres/Storage | `supabase:supabase` | postgres best practices + security | Migrazioni versionate, RLS, niente service key nel client |
| Sicurezza proporzionata | `$app-security-orchestrator` | Codex Security + catalogo community | Seleziona playbook, non carica 817 trigger |
| Sicurezza policy/minacce | `codex-security:define-security-policy`, `threat-model` | security orchestrator | Prima delle scansioni serie |
| Sicurezza di un diff | `codex-security:security-diff-scan` | `validation`, `fix-finding` | Modifiche sensibili Git-backed |
| Scan repository | `codex-security:security-scan` | deep scan per release pubblica | Non dichiarare copertura completa se incompleta |
| Android build security | `$app-security-orchestrator` | MobSF playbook | Docker/build upload richiedono consenso |
| iOS build security | `$app-security-orchestrator` | iOS assessment playbook | Serve ambiente Apple appropriato |
| GitHub/CI | plugin GitHub o skill installata | security supply-chain playbook | Push/PR solo con intento dell'utente |
| Test e QA | pratica engineering + test stack | device automation | Registra comandi e risultati reali |
| Build/submit mobile | plugin Expo/EAS | strumenti store | Upload non equivale a pubblicazione completa |
| Pagamenti | documentazione ufficiale + SDK scelto | security/store review | Definire prodotto prima del codice |
| Store compliance | skill App Store/Play corrente | security per codice | Policy store non è security scan |
| Screenshot store | `app-store-screenshots` | brand kit | Solo schermate vere e correnti |
| ASO e lancio | skill ASO selezionate | analytics/brand/copy | Vicino al lancio, non al wireframe |
| OpenAI API | `openai-docs` | server-side + cost controls | Fonti ufficiali e segreti fuori dal client |

## Transizione automatica

Dopo un gate:

- `approved` → instrada il passo successivo;
- `approved_with_assumptions` → continua soltanto con investimento delimitato e test incorporato;
- `blocked` → mostra il blocker e non saltarlo;
- `not_applicable` → registra motivazione e continua.

Se l'utente chiede direttamente una funzione, esegui una verifica rapida dei prerequisiti e attiva
soltanto gli specialisti mancanti. Non costringerlo a recitare l'intero ciclo di vita per cambiare
una label, ma non implementare auth o pagamenti su requisiti immaginari.

## Regole di compatibilità

- Per native mobile, non importare hover, GSAP, DOM, Tailwind o layout da landing page senza motivo.
- Una sola skill di gusto/stile per deliverable, scelta dopo brand e stack.
- Le skill creative non coprono backend, sicurezza, test o deployment.
- Preferisci plugin ufficiali e fonti primarie; le skill community passano dal bootstrap autorizzato.
- Il catalogo sicurezza è vendor content: leggi i playbook pertinenti, non eseguire script senza review.
- Se manca uno specialista, registra capability gap, fallback nativo e prova usata.
