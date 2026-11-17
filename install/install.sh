#!/usr/bin/env bash
# Installe le skill pm-tickets pour Codex, OpenCode, DeepSeek Harness et Claude Code
# (Claude Code peut aussi l'installer depuis le catalogue LiteLLM).
#
# Usage : bash install/install.sh
#
# - Copie skills/pm-tickets dans ~/.agents/skills/ et ~/.claude/skills/,
#   et dans $DSH_HOME/skills/ (défaut ~/.dsh/skills/) si DeepSeek Harness est présent.
#   Une version déjà installée du skill est remplacée.
# - Crée la mémoire ~/.pm-tickets/ si elle manque, sans jamais modifier son contenu.
# - Reprend, s'ils existent, les réglages et exemples de l'ancien agent DeepSeek Harness
#   (~/.dsh/pm-tickets/), sans écraser ce qui existe déjà dans ~/.pm-tickets/.
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
src="$here/skills/pm-tickets"
if [ ! -f "$src/SKILL.md" ]; then
  echo "Erreur : SKILL.md introuvable dans $src" >&2
  exit 1
fi

dsh_home="${DSH_HOME:-$HOME/.dsh}"
targets=("$HOME/.agents/skills" "$HOME/.claude/skills")
if [ -d "$dsh_home" ]; then
  targets+=("$dsh_home/skills")
fi

for target in "${targets[@]}"; do
  mkdir -p "$target"
  rm -rf "$target/pm-tickets"
  cp -R "$src" "$target/pm-tickets"
  echo "Skill installé : $target/pm-tickets"
done

memory="$HOME/.pm-tickets"
mkdir -p "$memory/examples" "$memory/cache"
chmod 700 "$memory"

old="$dsh_home/pm-tickets"
if [ ! -f "$memory/config.json" ] && [ -f "$old/config.json" ]; then
  cp "$old/config.json" "$memory/config.json"
  echo "Réglages repris de l'ancien agent : $old/config.json"
fi
if [ -d "$old/examples" ]; then
  for file in "$old/examples"/*; do
    if [ -f "$file" ] && [ ! -e "$memory/examples/$(basename "$file")" ]; then
      cp "$file" "$memory/examples/"
      echo "Exemple repris : $(basename "$file")"
    fi
  done
fi

echo "Mémoire : $memory"
echo "Prochaine étape : redémarrer le harness, puis décrire un besoin (« j'ai besoin d'un ticket pour… »)."
