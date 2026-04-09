Diese Solution enthält einen einfachen Aufbau für das Anfragen und Verwenden eines Bearer Tokens für die Authentifizierung mit dem REST Transferobjekt.

Der Aufbau besteht aus zwei Verbindungen. Mit einer Verbindung wird der Bearer Token angefordert und in eine Variable gespeichert. Die andere Verbindung verwendet den gespeicherten Bearer Token für die Bearer Token Authentifizierung.

##### Hinweis

* In dem Aufbau wird für das Anfragen des Tokens die GET Methode genutzt. Wenn für die Anfrage ein **Request Body** benötigt wird, muss eine andere Methode genutzt werden, die Request Bodys unterstützt wie z.B. **POST**.
