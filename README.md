# Conservami

Conservami è una semplice applicazione Flutter per tenere traccia degli alimenti conservati in frigorifero.
Ogni prodotto viene memorizzato in Hive e può essere aggiunto manualmente o tramite scansione del codice a barre.

## Funzionalità

- Elenco dei prodotti salvati con data di scadenza.
- Aggiunta rapida di un prodotto con notifica un giorno prima della scadenza.
- Recupero delle informazioni di base da OpenFoodFacts quando possibile.

## Utilizzo

1. Esegui `flutter pub get` per scaricare le dipendenze.
2. Avvia l'app con `flutter run` su un dispositivo o emulatore.
3. Tocca **+** nella schermata principale per inserire un nuovo prodotto.

La scansione del codice a barre richiede un dispositivo con fotocamera disponibile.
