#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# Starter Neovim Config
# One-command setup for a beginner-friendly Neovim configuration.
#
# Usage: curl -fsSL <url>/install.sh | bash
#    or: ./install.sh
# =============================================================================

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
INIT_FILE="$CONFIG_DIR/init.lua"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BOLD="\033[1m"
RESET="\033[0m"

# ── Check Neovim is installed ────────────────────────────────────────────────
if ! command -v nvim &>/dev/null; then
  echo -e "${RED}Neovim not found.${RESET} Install it first:"
  echo ""
  echo "  macOS:   brew install neovim"
  echo "  Ubuntu:  sudo add-apt-repository ppa:neovim-ppa/unstable && sudo apt install neovim"
  echo "  Fedora:  sudo dnf install neovim"
  echo "  Arch:    sudo pacman -S neovim"
  echo ""
  echo "Or download the AppImage: https://github.com/neovim/neovim/releases"
  exit 1
fi

# ── Check Neovim version (>= 0.12 required for vim.pack.add and native treesitter) ─────────────────
nvim_version=$(nvim --version | head -1 | grep -oP '[0-9]+\.[0-9]+' || echo "0.0")
major=$(echo "$nvim_version" | cut -d. -f1)
minor=$(echo "$nvim_version" | cut -d. -f2)

if [ "$major" -lt 0 ] 2>/dev/null || { [ "$major" -eq 0 ] && [ "$minor" -lt 12 ]; }; then
  echo -e "${RED}Neovim >= 0.12 required.${RESET} You have $nvim_version."
  echo "Update: https://github.com/neovim/neovim/releases"
  exit 1
fi

# ── Backup existing config ───────────────────────────────────────────────────
mkdir -p "$CONFIG_DIR"

if [ -f "$INIT_FILE" ]; then
  if [ -s "$INIT_FILE" ]; then
    BACKUP="$INIT_FILE.bak.$(date +%s)"
    echo -e "${YELLOW}Backing up existing config to:${RESET} $BACKUP"
    cp "$INIT_FILE" "$BACKUP"
  fi
fi

# ── Copy starter init.lua ────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$SCRIPT_DIR/init.lua" ]; then
  cp "$SCRIPT_DIR/init.lua" "$INIT_FILE"
else
  echo -e "${RED}Error:${RESET} Could not find starter init.lua."
  echo "Make sure init.lua is in the same directory as this script."
  exit 1
fi

# ── Done ─────────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}${BOLD}Starter Neovim config installed!${RESET}"
echo ""
echo "  Config: $INIT_FILE"
echo ""
echo -e "${BOLD}Next steps:${RESET}"
echo "  1. Launch Neovim — plugins auto-install on first run"
echo "  2. Open a code file — run ${BOLD}:Mason${RESET} to install language servers"
echo "  3. Try these keymaps:"
echo ""
echo "     jk          exit Insert mode (no more reaching for Esc)"
echo "     <Space>     hold for a keymap menu (which-key)"
echo "     <Space>sf   search files by name"
echo "     <Space>sg   search files by content (grep)"
echo "     <Space>bb   browse open buffers"
echo "     <Space>tt   toggle terminal"
    echo "     <Space>cm   open Mason (install LSP servers)"
    echo "     <Space>w    save current file"
    echo "     <Space>q    close current buffer"
    echo "     gd          go to definition (with an LSP installed)"
echo "     K           hover documentation (with an LSP installed)"
echo ""
echo -e "Run ${BOLD}vimtutor${RESET} (or ${BOLD}:Tutor${RESET} inside Neovim) for a guided 30-minute course."
echo "To revert: copy the backup file from $CONFIG_DIR/ back to init.lua."
