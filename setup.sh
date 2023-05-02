#!/usr/bin/bash

set -euo pipefail

backup_if_exists () {
  if [[ -r "$1" ]]; then
    mv --backup=numbered "$1" "$1.bak"
    return 0
  fi
}

if [ $# -ne 1 ]; then
  echo "Error: This script requires exactly one command line argument." >&2
  exit 1
fi

setup_mode=$1
DOTFILES="$HOME/.dotfiles"

if [ ! -d "$DOTFILES" ]; then
  echo ".dotfiles directory does not exist in the user's HOME('$HOME')." >&2
  exit 1
fi

setup_zsh () {
  if ! command -v zsh &> /dev/null; then
    echo "zsh is not installed on this system." >&2
    return 1
  fi

  backup_if_exists "$HOME/.zshrc"

  ln -s "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
  zsh
  source "$HOME/.zshrc"
}

setup_fonts () {
  mkdir -p "$HOME/.local/share"
  backup_if_exists "$HOME/.local/share/fonts"
  ln -s "$DOTFILES/fonts" "$HOME/.local/share/fonts"
}

setup_kitty () {
  if ! command -v kitty &> /dev/null; then
    echo "kitty is not installed on this system." >&2
    return 1
  fi

  mkdir -p "$HOME/.config"
  backup_if_exists "$HOME/.config/kitty"
  ln -s "$DOTFILES/kitty" "$HOME/.config/kitty"
}

case "$setup_mode" in
  zsh)
    setup_zsh
    ;;
  kitty)
    setup_kitty
    ;;
  fonts)
    setup_fonts
    ;;
  *)
    echo "Unknown setup_mode: $setup_mode" >&2
    exit 1
    ;;
esac
