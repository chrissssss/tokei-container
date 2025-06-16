#!/bin/sh

set -e

# Verwende Umgebungsvariable oder Fallback
REPO_URL="${GIT_REPO:-https://github.com/davidtakac/bura}"
REPO_NAME=$(basename "$REPO_URL" .git)

# Klonen
git clone --depth 1 "$REPO_URL"
cd "$REPO_NAME"

# Analyse
echo "Analysiere Code mit tokei..."
tokei . --output json > /output/loc.json

echo "Fertig. Ergebnis in output/loc.json"
