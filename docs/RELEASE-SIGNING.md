# Firma delle release

Il manifesto SHA-256 rileva modifiche accidentali ma, da solo, non prova l'origine: chi altera i
file può rigenerare anche il manifesto.

Per una distribuzione pubblica:

1. crea una chiave di firma su un dispositivo controllato da Massimiliano;
2. non inserire mai la chiave privata nel repository o nel pacchetto;
3. firma `integrity-manifest.json` per ogni release;
4. pubblica chiave pubblica, firma, tag Git e checksum dal repository ufficiale;
5. aggiorna `$app-builder-about` per verificare la firma oltre ai checksum.

Strumenti possibili: minisign, cosign o firma Git/tag. La scelta va fatta quando esiste il
repository ufficiale. Questo pacchetto beta non include una chiave privata, deliberatamente.
