#!/bin/sh

set -e

REPO_URL="${GIT_REPO:-https://github.com/chrissssss/tokei-container}"
REPO_NAME=$(basename "$REPO_URL" .git)

# Klonen
git clone --depth 1 "$REPO_URL"

# wenn .tokeignore existiert, die datei nach $REPO_NAME kopieren
if [ -f ".tokeignore" ]; then
  cp .tokeignore "$REPO_NAME"
fi

cd "$REPO_NAME"

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
