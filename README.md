# mac-config

Portable Mac setup for Ivan's coding environment.

This repo intentionally stores config, not secrets. It avoids SSH keys, GitHub CLI tokens,
Claude/Codex auth files, shell history, caches, logs, and session databases.

## What's included

- Alacritty config and the `coolnight` theme
- Neovim/LazyVim config
- zsh aliases, shell setup, and Powerlevel10k prompt config
- Git config and global gitignore
- Claude Code agents, commands, hooks, and settings
- Codex plugin/config preferences without auth or machine-specific project trust entries
- Homebrew `Brewfile` for core CLI tools, fonts, and apps

## New Mac setup

1. Install Xcode command line tools:

   ```sh
   xcode-select --install
   ```

2. Install Homebrew from <https://brew.sh>.

3. Clone this repo:

   ```sh
   git clone https://github.com/IvanKuria/mac-config.git ~/mac-config
   cd ~/mac-config
   ```

4. Install packages and link configs:

   ```sh
   ./scripts/bootstrap.sh
   ```

5. Restart the terminal.

## Manual sign-ins after bootstrap

These are intentionally not stored in the repo:

```sh
gh auth login
claude
codex
```

Also sign into apps like Alacritty/Codex/Claude through their normal flows if needed.

## Updating this repo from the current Mac

After changing local configs:

```sh
./scripts/sync-from-local.sh
git status
git add .
git commit -m "Update mac config"
git push
```

