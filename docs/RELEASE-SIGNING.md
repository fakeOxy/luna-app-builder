# Firma delle release

Il manifesto SHA-256 rileva modifiche accidentali ma, da solo, non prova l'origine: chi altera i
file può rigenerare anche il manifesto.

Per una distribuzione pubblica con firma forte:

1. crea una chiave di firma su un dispositivo controllato da Massimiliano;
2. non inserire mai la chiave privata nel repository o nel pacchetto;
3. firma `integrity-manifest.json` per ogni release;
4. pubblica chiave pubblica, firma, tag Git e checksum dal repository ufficiale;
5. aggiorna `$app-builder-about` per verificare la firma oltre ai checksum.

Strumenti possibili: minisign, cosign o firma Git/tag.

Il repository ufficiale esiste. Per `v2.0.0-beta.1` il livello garantito è tag Git più manifesto
SHA-256; la firma crittografica forte non è ancora attiva. Questo limite deve restare dichiarato e
nessuna chiave privata deve essere inclusa nel repository o nel pacchetto.
