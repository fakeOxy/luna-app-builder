# Bootstrap degli specialisti

## Obiettivo

Al primo accesso Luna prepara automaticamente le capacità fondamentali. L'utente non deve cercare
repository o copiare comandi. Luna presenta una sola richiesta di consenso con sorgenti, scopo e
limiti, esegue il bootstrap e ripete il Doctor.

Luna resta l'unica interfaccia e il state owner. Le skill esterne sono lavoratori specializzati,
non nuovi direttori del progetto.

## Consenso

Prima esecuzione:

1. rileva se `.app-builder/specialists.json` esiste ed è attuale;
2. mostra cosa verrà scaricato e dove;
3. chiarisce che sono progetti community gratuiti, non garanzie professionali;
4. distingue skill gratuita da eventuali tool, API o crediti a pagamento;
5. chiede un unico consenso esplicito;
6. esegue `scripts/bootstrap-specialists.mjs --project <root> --approved`;
7. salva report, inventario e indici;
8. ripete il Doctor;
9. apre una nuova sessione soltanto se necessaria per caricare le skill.

Il consenso al bootstrap non autorizza login, spese, crediti Pika, Docker, scanner invasivi,
upload di build, script di penetration testing, push o pubblicazioni. Questi richiedono consenso
nel momento d'uso.

## Pacchetto iniziale

| Capacità | Sorgente | Uso |
|---|---|---|
| Ricerca skill | `vercel-labs/skills` → `find-skills` | cerca candidati solo davanti a un capability gap |
| Processo engineering | `obra/superpowers` | brainstorming, piano, TDD, debugging, subagenti e verifica |
| PRD strutturato | `jamesrochabrun/skills` → `prd-generator` | supporto a requirements |
| UX/UI e design system | `nextlevelbuilder/ui-ux-pro-max-skill` | pattern, palette, tipografia, design e UX |
| Brand | `Pika-Labs/Pika-Plugins` → `build-a-brand` | strategia e identità; servizi a pagamento mai automatici |
| Critica e UX writing | `pbakaus/impeccable` | audit, interaction e copy in-app |
| Marketing base | `coreyhaines31/marketingskills` | product marketing, copywriting e copy editing |
| Marketing catalog | `coreyhaines31/marketingskills` | catalogo completo indicizzato on demand |
| Security catalog | `mukul975/Anthropic-Cybersecurity-Skills` | playbook completi indicizzati on demand |

Le skill native Luna restano proprietarie di routing, stato, gate, fallback e limiti.

## Find Skills

`find-skills` non installa automaticamente ciò che trova. Luna:

1. registra il capability gap;
2. controlla skill native, plugin ufficiali e cataloghi locali;
3. cerca soltanto se il gap resta aperto;
4. valuta massimo tre candidati;
5. controlla fonte, licenza, manutenzione, script, servizi e rischio;
6. installa senza nuovo consenso solo sorgenti già approvate dal bootstrap;
7. chiede consenso per una sorgente nuova;
8. esegue un post-check innocuo.

## Superpowers

Superpowers è il motore di processo del ruolo CTO quando la modifica è non banale:

- brainstorming e specifica;
- piano scritto;
- TDD quando applicabile;
- debugging sistematico;
- task paralleli solo se indipendenti;
- verifica prima del completamento.

Non possiede scope, stato, gate o comunicazione finale. Queste restano a Luna.

## Protezione del progetto

Il bootstrap non modifica il `.gitignore` condiviso. In un repository Git aggiunge le cache locali
a `.git/info/exclude`:

- `.app-builder/vendor/`;
- `.app-builder/security-catalog/`;
- `.app-builder/marketing-catalog/`.

Registro e report usano percorsi relativi e non salvano il percorso assoluto della macchina. In
assenza di Git non modificano configurazioni del progetto.

## Cataloghi on demand

I repository completi vengono scaricati in `.app-builder/vendor` e fissati a commit dichiarati.
Vengono creati due indici locali:

- `.app-builder/security-catalog/index.json`;
- `.app-builder/marketing-catalog/index.json`.

I cataloghi non vengono copiati integralmente nella cartella delle skill attive perché produrrebbero
collisioni di trigger, consumo di contesto e rischio supply-chain. Luna seleziona il minimo playbook
pertinente tramite `$app-security-orchestrator`, ruoli marketing e routing autonomo.

Leggere un playbook non autorizza a eseguire i suoi script o strumenti.

## Aggiornamenti

Non aggiornare sorgenti community durante una slice. Registra commit/versione, revisiona changelog,
licenza e comandi, poi aggiorna in un task dedicato con test. `--refresh` viene usato soltanto dopo
una decisione esplicita.

## Fallimenti

Se uno specialista o catalogo non si installa:

- registra l'errore nel report;
- continua con la skill nativa Luna;
- usa `external_specialist_unavailable` o `partial`;
- non chiede all'utente di eseguire manualmente una sequenza di comandi;
- propone una sola correzione quando necessaria;
- non blocca fasi che il fallback copre onestamente.
