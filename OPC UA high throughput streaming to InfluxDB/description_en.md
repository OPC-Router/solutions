This Solution includes an **OPC UA client plug-in** optimized for the **Multi Datachange Trigger** and an **InfluxDB plug-in**. Both plug-ins are optimized for **high data throughput**.

##### Optimizations made

* OPC UA Client
  * Asynchronous browsing for the Multi Datachange Trigger is used.
* Multi Datachange Trigger
  * Updating of items has been disabled.
* InfluxDB
  * Stacked/asynchronous inserts are used.

The included connection transfers data from the Multi Datachange Trigger to an InfluxDB.
