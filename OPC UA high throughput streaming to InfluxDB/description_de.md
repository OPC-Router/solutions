Diese Solution enthält ein für den **Multi Datachange Trigger** optimiertes **OPC UA Client Plug-in** und ein **InfluxDB Plug-in**. Beide Plug-ins sind für einen **hohen Datendurchsatz** optimiert.

##### Vorgenommene Optimierungen

* OPC UA Client
  * Asynchrones Browsing für den Multi Datachange Trigger wird genutzt.
* Multi Datachange Trigger
  * Aktualisierung der Items wurde deaktiviert.
* InfluxDB
  * Es werden gestapelte/asynchrone Inserts verwendet.

Die enthaltene Verbindung realisiert die Übertragung der Daten aus dem Multi Datachange Trigger an eine InfluxDB.
