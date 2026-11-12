This Solution creates a **Jira issue** whenever a machine reports a fault - directly from OPC UA, through the Jira Cloud REST API v3. Maintenance gets a ticket with the fault code, the machine name, a priority and labels the moment the fault appears.

The reusable function **Create Jira issue** takes summary, description, priority and two labels, posts the issue to `/rest/api/3/issue` and returns the issue key (e.g. `OPS-123`). The sample flow **Sample - Jira issue on machine fault** watches a fault-code node and calls the function with a generated summary and description.

##### Requirements

* Jira Cloud with an account that may create issues in the target project, and an API token for that account (id.atlassian.com > Security > API tokens). Basic authentication with e-mail + token is what Jira Cloud expects.
* Credentials are **not** part of the solution: the function sends the HTTP header `Authorization` from the variable **Jira API authorization header**, whose value you set during the import (see below). The REST client instance itself is created without authentication - the header carries it.
* For the sample flow: an OPC UA server.

##### Before the import

Set the value of the HTTP header Authorization already during the import, in the **Authorization header (value)** parameter: `Basic <base64 of e-mail:API token>` (Linux/macOS: `echo -n 'you@example.com:TOKEN' | base64`; PowerShell: `[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes('you@example.com:TOKEN'))`). The value ends up encrypted in the secret-string variable **Jira API authorization header**.

##### Customization options

* **Closing the issue when the fault clears, or writing the issue status back to the PLC:** use a REST Server trigger as Jira webhook target (`Jira settings > System > Webhooks`) and an OPC UA write - a JSON Read step then maps `issue.key` and `issue.fields.status.name` from the webhook body (not part of this solution).

Further adaptation hints (trigger behavior, additional fields, Jira Data Center/Server) are available as notes directly in the sample flow and in the **Create Jira issue** function.
