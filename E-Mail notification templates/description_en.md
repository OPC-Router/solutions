This Solution sends HTML-formatted e-mails from machine data. The layout lives in two reusable **functions (FX)** that any flow can call:

* **Send alarm mail (HTML)** – a colour-coded alarm/status card (Info, Warning, Alarm) with title, message, source, value and time.
* **Send shift report mail (HTML)** – a shift report table with the OEE figures availability, performance, quality and OEE, calculated from four counters (good parts, scrap, run time, planned time).

Two sample flows show how the functions are called: an OPC UA data-change trigger that mails an alarm card, and a cron trigger that reads counters over OPC UA and mails the shift report.

##### Requirements

* An SMTP server that accepts mail from the OPC Router
* For the sample flows: an OPC UA server. Replace the endpoint and node ids in the parameters, or exchange the triggers for your own data sources.
