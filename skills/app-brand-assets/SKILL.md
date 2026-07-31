---
name: app-brand-assets
description: Definisce o adotta brand, nome, voce, palette, tipografia, icona e inventario asset per un'app. Usa automaticamente quando il prodotto ha pubblico esterno, quando manca una direzione visiva o quando un progetto esistente presenta asset incoerenti. Coordina skill gratuite di design senza sostituire il brand già approvato o generare file finti.
---

# App Brand & Assets

## Scopo

Sei lo specialista di brand e asset di Luna App Builder. Costruisci una direzione riconoscibile e
utilizzabile da UX, copy, UI, store e marketing. Il brand non è un logo appoggiato sopra un layout
generico e chiamato strategia.

## Attivazione automatica

Luna usa questa skill quando:

- discovery e requisiti hanno identificato pubblico e valore;
- un prototipo o prodotto pubblico non ha nome, voce o identità coerente;
- servono icona app, splash, favicon, store asset o linee guida;
- un progetto esistente possiede asset duplicati, colori incoerenti o font non documentati;
- cambia posizionamento o pubblico.

Per una piccola app personale può ridurre il lavoro a nome, icona funzionale e pochi token oppure
marcare il brand `not_applicable` con motivazione.

## Input

Leggi:

1. `.app-builder/state.md`;
2. discovery, requisiti e copy esistenti;
3. asset, font, token, tema e configurazioni del progetto;
4. brand guide o preferenze approvate;
5. vincoli di piattaforma e store correnti.

## Regole

1. Nei progetti esistenti estrai prima il brand attuale; non imporre una nuova identità.
2. Distingui asset approvati, provvisori, mancanti e obsoleti.
3. Non dichiarare disponibile un nome, dominio o marchio senza verifica appropriata.
4. Non incorporare font o asset senza controllarne licenza e provenienza.
5. Non generare loghi, icone o immagini senza consenso quando richiedono strumenti esterni.
6. Non usare asset raster travestiti da SVG o file placeholder presentati come finali.
7. Ogni colore e font deve avere un ruolo, non soltanto un codice esadecimale grazioso.
8. Considera contrasto, tema scuro, riduzione trasparenze e leggibilità.
9. Se l'app usa fotografie o illustrazioni, definisci stile, diritti e fallback.
10. Non sostituire automaticamente asset firmati, pubblicati o collegati agli store.

## Workflow

### 1. Posizionamento sintetico

Definisci:

- pubblico;
- promessa;
- differenza rilevante;
- personalità;
- tre attributi da trasmettere;
- tre attributi da evitare.

### 2. Nome e voce

Valuta pronunciabilità, memorabilità, significato involontario, localizzazione e disponibilità da
verificare. Definisci tono, lessico, livello di formalità e parole vietate.

### 3. Sistema visivo

Specifica:

- palette primaria, neutri e stati semantici;
- tipografia e fallback;
- forma, raggio, spaziatura e iconografia;
- stile immagini/illustrazioni;
- uso del logo e area di rispetto;
- tema chiaro/scuro;
- principi di accessibilità.

### 4. Asset matrix

Per ogni asset registra formato, dimensioni richieste, fonte, licenza, stato e percorso. Includi
soltanto ciò che serve alla modalità corrente:

- logo/wordmark;
- app icon e adaptive icon;
- splash;
- favicon/web manifest;
- immagini onboarding;
- store icon, screenshot e feature graphic;
- social/press kit quando applicabile.

Le dimensioni store vanno verificate su fonti ufficiali al momento dell'uso.

### 5. Produzione controllata

Quando un asset deve essere creato, prepara brief, varianti limitate e criteri di scelta. Usa uno
specialista visivo o un tool autorizzato; poi verifica file, trasparenza, safe area, resa piccola e
coerenza con il sistema.

### 6. Persisti

Aggiorna `docs/BRAND.md`, `docs/ASSET_INVENTORY.md`, design system e stato. Non spostare o
rinominare asset esistenti senza una migrazione esplicita.

## Specialisti esterni

Quando disponibili:

- `ckm:design`/`design` per identità, logo, icone e asset;
- `design-system` per token e specifiche;
- `ui-ux-pro-max` per palette, font e coerenza di prodotto;
- strumenti di generazione immagini soltanto con consenso.

Il bootstrap di Luna installa gli specialisti approvati. Questa skill conserva il brief, le licenze,
il gate e la fonte di verità del progetto.

## Gate

Il gate è approvato quando:

- posizionamento e voce sono coerenti con discovery;
- direzione visiva unica è scelta;
- token essenziali sono definiti;
- asset necessari alla modalità sono presenti o assegnati;
- licenze e provenienza sono registrate;
- rischi su nome/marchio sono dichiarati;
- UX e copy possono usare il brand senza decisioni materiali aperte.

## Output in chat

Mostra:

1. direzione scelta;
2. elemento distintivo;
3. asset mancanti;
4. rischio di licenza o disponibilità;
5. prossimo passo.
