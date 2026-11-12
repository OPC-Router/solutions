Diese Solution macht aus MQTT einen Request/Response-Kanal („RPC über MQTT") mit den MQTT-5-Mitteln **Response-Topic**, **Correlation Data** und **User Properties**.

MES, SCADA oder ein Dienst veröffentlicht eine Anfrage und gibt an, wohin die Antwort gehen soll (Response-Topic) und woran sie zu erkennen ist (Correlation Data). Die Anfrage wird in einem Flow verarbeitet und über die wiederverwendbare Funktion **Answer MQTT request** beantwortet, die

* die Antwort an das **Response-Topic** der Anfrage veröffentlicht,
* die **Correlation Data** zurückgibt (mit der unten beschriebenen Einschränkung) und
* die User Properties `traceId` (aus der Anfrage), `status`, `sourceSystem` und `schemaVersion` mitsendet – Metadaten für Routing und Nachverfolgung, die außerhalb des Payloads bleiben.

Der Beispiel-Flow **Sample - read OPC UA node on request** beantwortet `{"browsePath": "..."}` mit Live-Wert, Qualität und Zeitstempel des OPC-UA-Knotens. Testen mit der Mosquitto-CLI:

```
mosquitto_pub -V 5 -t opcrouter/rpc/read -m '{"browsePath":"bp=Objects/2:Machine/2:GoodParts;"}' \
  -D publish response-topic client/reply/1 -D publish correlation-data req-001 \
  -D publish user-property traceId T-42
mosquitto_sub -V 5 -t 'client/reply/#' -F '%j'
```

##### Bekannte Einschränkung (Stand 5.7)

Der MQTT-Trigger übergibt die **Correlation Data** als Byte-Array, liest davon aber nur das erste Byte als Zahl aus – mehrbytige Correlation Data kommt daher nicht unverändert zurück: Bei `req-001` wird nur das erste Zeichen `r` übernommen, dessen ASCII-Code `114` ist, daraus wird also `114`. Als Anfrage-Kennung eignet sich die User Property `traceId` oder Correlation Data mit nur einem Byte.

##### Voraussetzungen

* Ein MQTT-5-Broker (Mosquitto 2.x, EMQX, HiveMQ, …). Die Anbindung wird mit Protokollversion 5 angelegt.
* Für den Beispiel-Flow: ein OPC-UA-Server. Jeder gesendete Browse Path wird dynamisch gelesen – keine feste Item-Liste.

##### Eigene Request-Handler bauen

Den Beispiel-Flow kopieren und den Mittelteil (JSON Read, OPC UA Dynamisches Lesen, JSON Write) durch die eigene Verarbeitung ersetzen. Details zum Trigger und zur Fehlerbehandlung stehen als Notizen direkt im Beispiel-Flow.
