# Dockerisierter Tokei Code-Analysator

Dieses Projekt stellt eine Docker-Umgebung bereit, um Code-Statistiken eines Git-Repositorys mithilfe von [Tokei](https://github.com/XAMPPRocky/tokei) zu analysieren. Das Ergebnis der Analyse (Lines of Code, Kommentare, etc.) wird als JSON-Datei ausgegeben.

## Inhaltsverzeichnis

* [Über das Projekt](#über-das-projekt)
* [Funktionen](#funktionen)
* [Voraussetzungen](#voraussetzungen)
* [Erste Schritte](#erste-schritte)
  * [Konfiguration](#konfiguration)
  * [Ausführung](#ausführung)
* [Output](#output)
* [Dateistruktur](#dateistruktur)
* [Mitwirken](#mitwirken)
* [Lizenz](#lizenz)

## Über das Projekt

Das Ziel dieses Projekts ist es, eine einfache und reproduzierbare Methode zur Analyse von Code-Metriken für beliebige öffentliche Git-Repositorys bereitzustellen. Es verwendet Docker, um `tokei` und seine Abhängigkeiten zu kapseln, und ein Shell-Skript, um den Klon- und Analyseprozess zu automatisieren.

Verwendete Technologien:
*   Docker
*   Docker Compose
*   Shell-Skript
*   Tokei (Rust-basiertes Tool)

## Funktionen

*   Klont ein spezifiziertes Git-Repository.
*   Analysiert den Code mit `tokei`.
*   Gibt die Ergebnisse im JSON-Format in einem `output`-Verzeichnis aus.
*   Das zu analysierende Repository kann einfach über eine Umgebungsvariable konfiguriert werden.

## Voraussetzungen

Stelle sicher, dass die folgenden Tools auf deinem System installiert sind:

*   Docker
*   Docker Compose (normalerweise mit Docker Desktop enthalten)

## Erste Schritte

1.  **Klone dieses Repository (falls noch nicht geschehen):**
    ```sh
    git clone <URL-zu-deinem-Projekt-Repository>
    cd <dein-projekt-verzeichnis>
    ```

### Konfiguration

Das zu analysierende Git-Repository wird über die Umgebungsvariable `GIT_REPO` in der Datei `docker-compose.yml` festgelegt.
Ändere den Wert von `GIT_REPO`, um ein anderes Repository zu analysieren.

### Ausführung

1.  **Starte die Analyse mit Docker Compose:**
    ```sh
    docker-compose up
    ```
    Dieser Befehl baut das Docker-Image (falls es noch nicht existiert) und startet den Container. Das Skript `analyze.sh` wird dann ausgeführt.

## Output

Nach erfolgreicher Ausführung findest du die Analyseergebnisse in der Datei `output/loc.json`.

## Dateistruktur

*   `Dockerfile`: Definiert das Docker-Image, installiert Rust, Git und Tokei.
*   `docker-compose.yml`: Definiert und konfiguriert den `code-analysis`-Service.
*   `analyze.sh`: Das Skript, das im Container ausgeführt wird, um das Repository zu klonen und Tokei auszuführen.
*   `output/`: Verzeichnis, in das die `loc.json`-Ergebnisdatei geschrieben wird (wird beim ersten Lauf erstellt).

## Mitwirken

Beiträge sind willkommen! Bitte forke das Repository und erstelle einen Pull Request für deine Änderungen.

1.  Forke das Projekt
2.  Erstelle deinen Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Committe deine Änderungen (`git commit -m 'Add some AmazingFeature'`)
4.  Pushe zum Branch (`git push origin feature/AmazingFeature`)
5.  Öffne einen Pull Request

## Lizenz

Verteilt unter der MIT-Lizenz. Siehe `LICENSE` für weitere Informationen. (Du müsstest ggf. noch eine `LICENSE`-Datei hinzufügen)