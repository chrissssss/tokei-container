#!/bin/sh

set -e

# GIT_REPO wird durch docker-compose.yml oder Shell-Umgebungsvariable gesetzt.
# Wenn GIT_REPO nicht gesetzt ist, wird das Skript fehlschlagen, was in diesem Setup
# nicht passieren sollte, da docker-compose.yml einen Standardwert bereitstellt.
if [ -z "$GIT_REPO" ]; then
  echo "Fehler: Die Umgebungsvariable GIT_REPO ist nicht gesetzt." >&2
  exit 1
fi
REPO_URL="$GIT_REPO"
REPO_NAME=$(basename "$REPO_URL" .git)

# Klonen
git clone --depth 1 "$REPO_URL"
cd "$REPO_NAME"

# Kopiere .tokeignore Datei aus /app (wo Dockerfile sie platziert hat)
# in das Wurzelverzeichnis des geklonten Repos, falls vorhanden.
test -f /app/.tokeignore && cp /app/.tokeignore .

# LOC-Analyse (JSON)
echo "Analysiere Code mit tokei..."
tokei . --output json > /output/loc.json

# COCOMO-Berechnung (bash + jq)
echo "Berechne Aufwand nach COCOMO..."

TOTAL_LOC=$(jq '[.[] | .code] | add' /output/loc.json)
KLOC=$(echo "$TOTAL_LOC / 1000" | bc -l)

# COCOMO Basic Model (organic type): PM = 2.4 * (KLOC)^1.05
COCOMO_PM=$(python3 -c "print(round(2.4 * (${KLOC})**1.05, 2))")

echo "Gesamter Code (LOC): $TOTAL_LOC"             > /output/cocomo.txt
echo "Geschätzte Personenmonate: $COCOMO_PM"      >> /output/cocomo.txt
echo "KLOC: $(printf %.2f "$KLOC")"               >> /output/cocomo.txt
echo "Ergebnis gespeichert in /output/cocomo.txt"
