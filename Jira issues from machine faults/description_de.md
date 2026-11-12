Diese Solution legt bei jeder Maschinenstörung einen **Jira-Vorgang** an – direkt aus OPC UA über die Jira-Cloud-REST-API v3. Die Instandhaltung bekommt in dem Moment ein Ticket mit Störungscode, Maschinenname, Priorität und Labels, in dem die Störung auftritt.

Die wiederverwendbare Funktion **Create Jira issue** nimmt Zusammenfassung, Beschreibung, Priorität und zwei Labels, sendet den Vorgang an `/rest/api/3/issue` und gibt den Issue-Key zurück (z. B. `OPS-123`). Der Beispiel-Flow **Sample - Jira issue on machine fault** überwacht einen Störungscode-Knoten und ruft die Funktion mit generierter Zusammenfassung und Beschreibung auf.

##### Voraussetzungen

* Jira Cloud mit einem Konto, das im Zielprojekt Vorgänge anlegen darf, und einem API-Token dieses Kontos (id.atlassian.com > Security > API tokens). Jira Cloud erwartet Basic-Authentifizierung mit E-Mail + Token.
* Zugangsdaten sind **nicht** Teil der Solution: die Funktion sendet den HTTP-Header `Authorization` aus der Variable **Jira API authorization header**, deren Wert Sie beim Import setzen (siehe unten). Die REST-Client-Anbindung selbst wird ohne Authentifizierung angelegt – der Header übernimmt das.
* Für den Beispiel-Flow: ein OPC-UA-Server.

##### Vor dem Import

Den Wert des HTTP-Headers Authorization bereits beim Import im Parameter **Authorization-Header (Wert)** setzen: `Basic <Base64 von E-Mail:API-Token>` (Linux/macOS: `echo -n 'you@example.com:TOKEN' | base64`; PowerShell: `[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes('you@example.com:TOKEN'))`). Der Wert landet verschlüsselt in der Secret-String-Variablen **Jira API authorization header**.

##### Anpassungsmöglichkeiten

* **Vorgang schließen, wenn die Störung geht, oder den Status zurück in die SPS schreiben:** einen REST-Server-Trigger als Jira-Webhook-Ziel (`Jira-Einstellungen > System > Webhooks`) mit einem OPC-UA-Schreiben verwenden – ein JSON-Read-Schritt liest dann `issue.key` und `issue.fields.status.name` aus dem Webhook-Body (nicht Teil dieser Solution).

Weitere Anpassungshinweise (Trigger-Verhalten, zusätzliche Felder, Jira Data Center/Server) stehen als Notizen direkt im Beispiel-Flow und in der Funktion **Create Jira issue**.
