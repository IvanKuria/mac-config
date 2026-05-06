#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$HOME/.mac-config-backup/$(date +%Y%m%d-%H%M%S)"

backup_path() {
  local target="$1"
  if [[ -e "$target" || -L "$target" ]]; then
    mkdir -p "$BACKUP_DIR$(dirname "$target")"
    mv "$target" "$BACKUP_DIR$target"
  fi
}

link_file() {
  local source="$1"
  local target="$2"
  mkdir -p "$(dirname "$target")"
  backup_path "$target"
  ln -s "$source" "$target"
}

link_dir() {
  local source="$1"
  local target="$2"
  mkdir -p "$(dirname "$target")"
  backup_path "$target"
  ln -s "$source" "$target"
}

if command -v brew >/dev/null 2>&1; then
  brew bundle --file "$ROOT/Brewfile"
else
  echo "Homebrew not found. Install it from https://brew.sh, then rerun this script."
fi

link_file "$ROOT/shell/zshrc" "$HOME/.zshrc"
link_file "$ROOT/shell/zprofile" "$HOME/.zprofile"
link_file "$ROOT/shell/zshenv" "$HOME/.zshenv"
link_file "$ROOT/shell/p10k.zsh" "$HOME/.p10k.zsh"

link_file "$ROOT/git/gitconfig" "$HOME/.gitconfig"
link_file "$ROOT/git/ignore" "$HOME/.config/git/ignore"

link_dir "$ROOT/config/alacritty" "$HOME/.config/alacritty"
link_dir "$ROOT/config/nvim" "$HOME/.config/nvim"

mkdir -p "$HOME/.claude"
link_dir "$ROOT/claude/agents" "$HOME/.claude/agents"
link_dir "$ROOT/claude/commands" "$HOME/.claude/commands"
link_dir "$ROOT/claude/hooks" "$HOME/.claude/hooks"
link_file "$ROOT/claude/settings.json" "$HOME/.claude/settings.json"

mkdir -p "$HOME/.codex"
link_file "$ROOT/codex/config.toml" "$HOME/.codex/config.toml"

echo "Done. Backups, if any, are in $BACKUP_DIR"
echo "Next: run gh auth login, claude, and codex to sign into local auth."

