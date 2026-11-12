Diese Solution versendet HTML-formatierte E-Mails aus Maschinendaten. Das Layout steckt in zwei wiederverwendbaren **Funktionen (FX)**, die jeder Flow aufrufen kann:

* **Send alarm mail (HTML)** – eine farbcodierte Alarm-/Statuskarte (Info, Warning, Alarm) mit Titel, Nachricht, Quelle, Wert und Zeit.
* **Send shift report mail (HTML)** – eine Schichtberichts-Tabelle mit den OEE-Kennzahlen Verfügbarkeit, Leistung, Qualität und OEE, berechnet aus vier Zählern (Gutteile, Ausschuss, Laufzeit, geplante Zeit).

Zwei Beispiel-Flows zeigen den Aufruf: ein OPC-UA-Datenänderungs-Trigger, der eine Alarmkarte sendet, und ein Cron-Trigger, der Zähler über OPC UA liest und den Schichtbericht sendet.

##### Voraussetzungen

* Ein SMTP-Server, der Mails vom OPC Router annimmt
* Für die Beispiel-Flows: ein OPC-UA-Server. Endpunkt und Node-IDs in den Parametern anpassen oder die Trigger gegen eigene Datenquellen tauschen.
