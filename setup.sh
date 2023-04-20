#!/usr/bin/bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Error: This script requires exactly one command line argument." >&2
  exit 1
fi

setup_mode=$1
DTF="$HOME/.dotfiles"

if [ ! -d "$DTF" ]; then
  echo ".dotfiles directory does not exist in the user's HOME('$HOME')." >&2
  exit 1
fi

setup_zsh () {
  if ! command -v zsh &> /dev/null; then
    echo "zsh is not installed on this system." >&2
    exit 1
  fi

  if [ -e "$HOME/.zshrc" ]; then
    mv --backup=numbered "$HOME/.zshrc" "$HOME/.zshrc.bak"
  fi

  ln -s "$DTF/zsh/.zshrc" "$HOME/.zshrc"
  zsh
  source "$HOME/.zshrc"
}

setup_fonts () {
  if [ -d "$HOME/.local/share/fonts" ] || [ -L "$HOME/.local/share/fonts" ]; then
    rm -r "$HOME/.local/share/fonts"
  fi
  ln -s "$DTF/fonts" "$HOME/.local/share/fonts"
}

case "$setup_mode" in
  zsh)
    setup_zsh
    ;;
  fonts)
    setup_fonts
    ;;
  *)
    echo "Unknown setup_mode: $setup_mode" >&2
    exit 1
    ;;
esac
