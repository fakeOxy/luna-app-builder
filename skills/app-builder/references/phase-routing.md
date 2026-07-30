# Routing degli specialisti

Leggi il `SKILL.md` completo dello specialista immediatamente prima di usarlo. Usa il minimo set.
Le disponibilità cambiano tra sessioni: non assumere che una cartella locale rappresenti tutto.

| Bisogno | Specialista primario | Aggiunte | Regola |
|---|---|---|---|
| Idea, MVP e percorso | `$app-builder` | Ricerca pubblica aggiornata quando serve | Luna possiede la sintesi e il gate |
| Brand da zero | `build-a-brand` | `brand`; `design` per asset | Non attivarli tutti per sport |
| UX, flussi e audit | `ui-ux-pro-max` | `$app-builder` per requisiti | Uno style database non è validazione utente |
| Token e componenti | `design-system` | UX review | I token non sono codice finito |
| Concept mobile | `imagegen-frontend-mobile` | UX + design system | Produce riferimenti, non React Native |
| Expo/React Native | plugin ufficiale `expo` | UX/design system; Callstack se installata | Usa skill Expo versionate e codice reale |
| Web frontend | skill compatibile con stack | design system/UX | Non applicare prescrizioni web al native |
| Supabase/Auth/Postgres/Storage | `supabase:supabase` | `supabase-postgres-best-practices` | Migrazioni versionate, RLS, niente service key nel client |
| Sicurezza policy/minacce | `codex-security:define-security-policy`, `threat-model` | Security lifecycle | Prima delle scansioni serie |
| Sicurezza di un diff | `codex-security:security-diff-scan` | `validation`, `fix-finding` | Modifiche sensibili Git-backed |
| Scan repository | `codex-security:security-scan` | deep scan per release pubblica | Non dichiarare copertura completa se incompleta |
| GitHub/CI | plugin GitHub o skill installata | fix CI quando richiesto | Push/PR solo con intento dell'utente |
| Test e QA | pratica di engineering + test stack | device automation se disponibile | Registra comandi e risultati reali |
| Build/submit mobile | plugin Expo/EAS | strumenti store | Upload non equivale a pubblicazione completa |
| Pagamenti | documentazione ufficiale + SDK scelto | security/store review | Definire prodotto prima del codice |
| Store compliance | skill App Store/Play aggiornata quando disponibile | Codex Security per codice | Policy store non è security scan |
| Screenshot store | `app-store-screens` | brand kit | Solo schermate vere e correnti |
| ASO e lancio | skill ASO selezionate | analytics/brand | Vicino al lancio, non al wireframe |
| OpenAI API | `openai-docs` | server-side + cost controls | Fonti ufficiali e segreti fuori dal client |

## Regole di compatibilità

- Per native mobile, non importare hover, GSAP, DOM, Tailwind o layout da landing page senza motivo.
- Una sola skill di gusto/stile per deliverable, scelta dopo brand e stack.
- Le skill creative non coprono backend, sicurezza, test o deployment.
- Preferisci plugin ufficiali e fonti primarie; le skill community richiedono approvazione.
- Se manca uno specialista, registra capability gap, fallback e prova usata.
