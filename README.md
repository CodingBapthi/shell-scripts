# Shell-Scripte für den eigen gebrauch

In diesem Reposetorie sind alle meine Shell-Scripte die ich für den eigen gebrauch geschrieben habe.
Jedes der Scripte bekommt einen eigenen Bereich in der README.md in der die Funktionsweise erklört wird.

## downloadRemmoteDB.sh
Dieses Shell-Skript ermöglicht es Ihnen, einen Datenbank-Dump von einem Remote-Host herunterzuladen und (optional) zu entpacken. Es verwendet mysqldump und scp unter Verwendung von ssh-Konfigurationsdatei.

### Anforderungen
* Der Remote-Host muss in der ssh-Konfigurationsdatei auf dem lokalen Computer eingetragen sein.
* mysqldump und scp müssen auf dem Remote-Host installiert sein.
### Verwendung
1. Laden Sie das Skript herunter und machen Sie es ausführbar mit dem Befehl chmod +x /path/to/script.sh
2. Führen Sie das Skript im Terminal aus, indem Sie den Pfad zum Skript und die erforderlichen Argumente angeben:
```
./path/to/script.sh remote_host remote_db [local_file]
```
* remote_host: Der Hostname oder die IP-Adresse des Remote-Hosts
* remote_db: Der Name der zu sichernden Datenbank
* local_file: (optional) der Name der lokalen Dump Datei
### Optionen
* Das Skript fragt ob die heruntergeladene Datei entpackt werden soll, falls sie gzip komprimiert ist.
* Der Fortschritt des Dump-Vorgangs wird angezeigt
* Der Dump wird nach erfolgreichem Download und Entpacken von