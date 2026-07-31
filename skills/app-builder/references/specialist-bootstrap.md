# Bootstrap degli specialisti

## Obiettivo

Al primo accesso Luna prepara automaticamente gli specialisti utili. L'utente non deve cercare
repository o copiare comandi. Luna presenta una sola richiesta di consenso con sorgenti, scopo e
limiti, quindi esegue il bootstrap e ripete il Doctor.

## Consenso

Prima esecuzione:

1. rileva se `.app-builder/specialists.json` esiste ed è attuale;
2. mostra cosa verrà scaricato e dove;
3. chiarisce che sono progetti community gratuiti e non garanzie professionali;
4. distingue skill gratuita da eventuali tool, API o crediti a pagamento richiesti dalla skill;
5. chiede un unico consenso esplicito;
6. esegue `scripts/bootstrap-specialists.mjs --project <root> --approved`;
7. salva report e inventario;
8. apre una nuova sessione soltanto se necessaria per far scoprire le skill installate.

Il consenso al bootstrap non autorizza login, spese, crediti Pika, Docker, scanner invasivi,
upload di build o script di penetration testing. Questi richiedono consenso nel momento d'uso.

## Pacchetto iniziale

| Ruolo | Sorgente | Uso |
|---|---|---|
| PRD strutturato | `jamesrochabrun/skills` → `prd-generator` | supporto a requirements |
| UX/UI e design system | `nextlevelbuilder/ui-ux-pro-max-skill` | pattern, palette, typography, design e UX |
| Brand | `Pika-Labs/Pika-Plugins` → `build-a-brand` | strategia e identità; servizi a pagamento mai automatici |
| Critica e UX writing | `pbakaus/impeccable` | audit, interaction, copy in-app |
| Marketing copy | `coreyhaines31/marketingskills` | copywriting, editing, positioning |
| Security catalog | `mukul975/Anthropic-Cybersecurity-Skills` | playbook ricercabili on demand |

Le skill native Luna restano proprietarie di stato, gate, routing e limiti.

## Protezione del progetto

Il bootstrap non modifica il `.gitignore` condiviso. In un repository Git aggiunge le cache locali
di Luna a `.git/info/exclude`:

- `.app-builder/vendor/`;
- `.app-builder/security-catalog/`.

Il registro usa percorsi relativi e non salva il percorso assoluto della macchina. In assenza di Git
non modifica file di configurazione del progetto.

## Catalogo sicurezza

Il repository completo viene scaricato in `.app-builder/vendor`, fissato al commit verificato nel
registro. Viene creato un indice locale. Le centinaia di skill non sono copiate tutte nella cartella
attiva perché:

- creerebbero collisioni di trigger;
- diluirebbero il contesto;
- includono procedure offensive e dual-use;
- aumenterebbero il rischio supply-chain.

`$app-security-orchestrator` seleziona e legge soltanto i playbook pertinenti. L'esecuzione di
strumenti rimane separata dalla lettura delle istruzioni.

## Aggiornamenti

Non aggiornare automaticamente sorgenti community durante una slice. Registra commit/versione,
revisiona changelog e licenza, poi aggiorna in un task dedicato con test. Il comando `--refresh`
serve soltanto dopo una decisione esplicita.

## Fallimenti

Se uno specialista non si installa:

- registra l'errore nel report;
- continua con la skill nativa Luna;
- non chiede all'utente di eseguire manualmente cinque comandi;
- propone una sola correzione quando davvero necessaria;
- non blocca fasi che il fallback copre.
