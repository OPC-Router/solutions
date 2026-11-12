Diese Solution speist OPC-UA-Datenpunkte in einen **Unified Namespace**: jede überwachte Variable wird auf ihrem eigenen MQTT-Topic in der ISA-95-Hierarchie veröffentlicht

```
<enterprise>/<site>/<area>/<line>/<cell>/<tag>
```

mit einem normalisierten JSON-Payload

```json
{"tag": "Ramp1", "value": 42.0, "quality": "good", "timestamp": "2026-09-03T04:42:50.06Z"}
```

Die wiederverwendbare Funktion **Publish UNS message** nimmt die fünf ISA-95-Ebenen sowie Tag, Wert, Qualität und Zeitstempel, bildet Topic und Payload und veröffentlicht sie – retained, damit spät hinzukommende Abonnenten sofort den letzten bekannten Zustand sehen. Der Beispiel-Flow **Sample - OPC UA subtree to UNS** überwacht einen ganzen OPC-UA-Teilbaum mit dem *Multi-Datachange-Trigger* und ruft die Funktion mit den Ebenen aus den Parametern und dem Tag-Namen aus dem Adressraum auf – keine Konfiguration je Tag.

##### Voraussetzungen

* Ein MQTT-Broker. Die Protokollversion (5 oder 3.1.1) ist ein Parameter.
* Ein OPC-UA-Server. Der Browse Path des zu überwachenden Teilbaums wird als Parameter angegeben (z. B. `bp=Objects/2:Machine;`, Ebenen mit `/` getrennt, abschließendes `;`). Nicht die Wurzel wählen (`bp=Objects;`): Array-Variablen darin (z. B. in der Server-Diagnose unter `Objects/Server`) lassen den gesamten Trigger-Stapel mit einem Fehler fehlschlagen.

##### Hinweis

Retained Topics überleben ein Umbenennen: Nach dem Ändern einer Ebene oder des Teilbaums die alten Topics im Broker löschen (je Topic eine leere retained Nachricht senden, z. B. `mosquitto_pub -r -n -t <altes Topic>`), oder *Nachrichten retained veröffentlichen* ausschalten.

##### Anpassungsmöglichkeiten

* **Mehrere Maschinen:** je Teilbaum einen Beispiel-Flow mit eigenem `cell`-Wert anlegen – die Funktion bleibt dieselbe.
* Boolesche Tags gehen unverändert durch den `DoubleArray`-Eingang der Funktion und kommen als `"value": false` an. Für Text-Tags eine zweite Funktion mit `StringArray`-Eingang (und `"value": ""` im JSON-Template) anlegen.
* **Größe:** Jeder Trigger-Stapel ist ein Funktionsaufruf, der je Tag eine Nachricht sendet. Bei Teilbäumen mit Hunderten Tags die Aufrufdauer im Protokoll beobachten und den Teilbaum bei Bedarf auf mehrere Beispiel-Flows verteilen.
* **Sparkplug B statt einfacher Topics:** das MQTT-Publish in der Funktion durch das Sparkplug-Plug-in ersetzen.
