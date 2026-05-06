#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

rsync -a --delete --exclude '.git' "$HOME/.config/nvim/" "$ROOT/config/nvim/"
mkdir -p "$ROOT/config/alacritty/themes/themes"
cp "$HOME/.config/alacritty/alacritty.toml" "$ROOT/config/alacritty/alacritty.toml"
cp "$HOME/.config/alacritty/themes/themes/coolnight.toml" "$ROOT/config/alacritty/themes/themes/coolnight.toml"

cp "$HOME/.gitconfig" "$ROOT/git/gitconfig"
cp "$HOME/.config/git/ignore" "$ROOT/git/ignore"

cp "$HOME/.p10k.zsh" "$ROOT/shell/p10k.zsh"
cp "$HOME/.zprofile" "$ROOT/shell/zprofile"
cp "$HOME/.zshenv" "$ROOT/shell/zshenv"

rsync -a --delete "$HOME/.claude/agents/" "$ROOT/claude/agents/"
rsync -a --delete "$HOME/.claude/commands/" "$ROOT/claude/commands/"
rsync -a --delete "$HOME/.claude/hooks/" "$ROOT/claude/hooks/"

echo "Synced portable config. Review git diff carefully before committing."

