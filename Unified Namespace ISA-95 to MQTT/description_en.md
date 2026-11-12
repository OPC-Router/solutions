This Solution feeds OPC UA data points into a **Unified Namespace**: every monitored variable is published on its own MQTT topic in the ISA-95 hierarchy

```
<enterprise>/<site>/<area>/<line>/<cell>/<tag>
```

with a normalised JSON payload

```json
{"tag": "Ramp1", "value": 42.0, "quality": "good", "timestamp": "2026-09-03T04:42:50.06Z"}
```

The reusable function **Publish UNS message** takes the five ISA-95 levels plus tag, value, quality and timestamp, builds topic and payload and publishes them - retained, so late subscribers see the last known state immediately. The sample flow **Sample - OPC UA subtree to UNS** monitors a whole OPC UA subtree with the *Multi Data Change* trigger and calls the function with the levels from the parameters and the tag name from the address space - no per-tag configuration.

##### Requirements

* An MQTT broker. The protocol version (5 or 3.1.1) is a parameter.
* An OPC UA server. The browse path of the subtree to monitor is given as a parameter (e.g. `bp=Objects/2:Machine;`, levels separated by `/`, trailing `;`). Do not choose the root (`bp=Objects;`): array-valued variables in it (e.g. in the server diagnostics under `Objects/Server`) make the whole trigger batch fail with an error.

##### Note

Retained topics outlive a rename: after changing a level or the subtree, clear the old topics in the broker (publish an empty retained message to each, e.g. `mosquitto_pub -r -n -t <old topic>`), or set *Publish messages retained* to off.

##### Customization options

* **Several machines:** create one sample flow per subtree with its own `cell` value - the function stays the same.
* Boolean tags pass through the function's `DoubleArray` input unchanged and arrive as `"value": false`. For string tags, add a second function with a `StringArray` input (and `"value": ""` in the JSON template).
* **Scale:** every trigger batch is one function call that publishes one message per tag. For subtrees with hundreds of tags, watch the call time in the log and split the subtree over several sample flows if needed.
* **Sparkplug B instead of plain topics:** replace the MQTT publish in the function with the Sparkplug plug-in.
