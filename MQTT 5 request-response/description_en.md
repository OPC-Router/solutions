This Solution turns MQTT into a request/response channel ("RPC over MQTT") using the MQTT 5 features **response topic**, **correlation data** and **user properties**.

A requester (MES, SCADA, a service) publishes a request and specifies where to answer (response topic) and how to match the answer (correlation data). The request is processed in a flow and answered through the reusable function **Answer MQTT request**, which

* publishes the answer payload to the request's **response topic**,
* passes the **correlation data** back (with the limitation described below), and
* adds the user properties `traceId` (taken from the request), `status`, `sourceSystem` and `schemaVersion` - metadata for routing and tracing that stays outside the payload.

The sample flow **Sample - read OPC UA node on request** answers `{"browsePath": "..."}` with the live value, quality and timestamp of that OPC UA node. Test it with the Mosquitto CLI:

```
mosquitto_pub -V 5 -t opcrouter/rpc/read -m '{"browsePath":"bp=Objects/2:Machine/2:GoodParts;"}' \
  -D publish response-topic client/reply/1 -D publish correlation-data req-001 \
  -D publish user-property traceId T-42
mosquitto_sub -V 5 -t 'client/reply/#' -F '%j'
```

##### Known limitation (as of 5.7)

The MQTT trigger hands **correlation data** to the flow as a byte array but only reads its first byte as a number, so correlation data longer than one byte is not echoed unchanged: for `req-001`, only the first character `r` is taken, and its ASCII code is `114` - hence `114`. Use the user property `traceId` as the request id, or send single-byte correlation data.

##### Requirements

* An MQTT 5 broker (Mosquitto 2.x, EMQX, HiveMQ, ...). The plug-in instance is created with protocol version 5.
* For the sample flow: an OPC UA server. Any browse path the requester sends is read dynamically - no fixed item list.

##### Building your own request handlers

Copy the sample flow and replace the middle part (JSON Read, OPC UA Dynamic Read, JSON Write) with your own processing. Details on the trigger and on error handling are available as notes directly in the sample flow.
