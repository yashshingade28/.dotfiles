#!/usr/bin/bash

set -euo pipefail

backup_if_exists () {
  if [[ -r "$1" ]]; then
    echo -n "$1 exists. Do you want to backup this file/directory? ([Y]es/[N]o/[A]bort) "
    read -r response

    if [[ "$response" =~ ^[Yy]$ ]]; then
      mv --backup=numbered "$1" "$1.bak"
      echo "Backup created at $(dirname "$1")"
    elif [[ "$response" =~ ^[Nn]$ ]]; then
      rm -rf "$1"
    else
      echo "setup aborted safely"
      exit 1
    fi
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
  if [ ! -d "$DOTFILES/zsh" ]; then
    echo "The \$DOTFILES/zsh folder does not exist."
    return 1
  fi

  backup_if_exists "$HOME/.zshrc"

  ln -s "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
  zsh
}

setup_kitty () {
  if ! command -v kitty &> /dev/null; then
    echo "kitty is not installed on this system." >&2
    return 1
  fi
  if [ ! -d "$DOTFILES/kitty" ]; then
    echo "The \$DOTFILES/kitty folder does not exist."
    return 1
  fi

  mkdir -p "$HOME/.config"
  backup_if_exists "$HOME/.config/kitty"
  ln -s "$DOTFILES/kitty" "$HOME/.config/kitty"
}

setup_alacritty () {
  if ! command -v alacritty &> /dev/null; then
    echo "alacritty is not installed on this system." >&2
    return 1
  fi
  if [ ! -d "$DOTFILES/alacritty" ]; then
    echo "The \$DOTFILES/alacritty folder does not exist."
    return 1
  fi

  mkdir -p "$HOME/.config"
  backup_if_exists "$HOME/.config/alacritty"
  ln -s "$DOTFILES/alacritty" "$HOME/.config/alacritty"
}

setup_fonts () {
  if [ ! -d "$DOTFILES/fonts" ]; then
    echo "The \$DOTFILES/fonts folder does not exist."
    return 1
  fi

  mkdir -p "$HOME/.local/share"
  backup_if_exists "$HOME/.local/share/fonts"
  ln -s "$DOTFILES/fonts" "$HOME/.local/share/fonts"
}

setup_nvim () {
  if ! command -v nvim &> /dev/null; then
    echo "neovim is not installed on this system." >&2
    return 1
  fi
  if [ ! -d "$DOTFILES/nvim" ]; then
    echo "The \$DOTFILES/nvim folder does not exist."
    return 1
  fi

  backup_if_exists "$HOME/.config/nvim"
  rm -rf "$HOME/.local/share/nvim"
  git clone https://github.com/NvChad/NvChad "$HOME/.config/nvim" --depth 1
  ln -s "$DOTFILES/nvim/nvchad/custom" "$HOME/.config/nvim/lua/custom"
  nvim
}

setup_tmux () {
  if ! command -v tmux &> /dev/null; then
    echo "tmux is not installed on this system." >&2
    return 1
  fi
  if [ ! -d "$DOTFILES/tmux" ]; then
    echo "The \$DOTFILES/tmux folder does not exist."
    return 1
  fi

  mkdir -p "$HOME/.config"
  backup_if_exists "$HOME/.config/tmux"
  ln -s "$DOTFILES/tmux" "$HOME/.config/tmux"

  backup_if_exists "$HOME/.tmux.conf"
  ln -s "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"

  backup_if_exists "$HOME/.tmux.conf.local"
  ln -s "$DOTFILES/tmux/tmux.conf.local" "$HOME/.tmux.conf.local"
}

setup_sublime () {
  if ! command -v subl &> /dev/null; then
    echo "sublime-text is not installed on this system." >&2
    return 1
  fi
  if [ ! -d "$DOTFILES/sublime-setup" ]; then
    echo "The \$DOTFILES/sublime-setup folder does not exist."
    return 1
  fi

  mkdir -p "$HOME/.config/sublime-text/Packages/User"
  backup_if_exists "$HOME/.config/sublime-text/Packages/User/custom"
  ln -s "$DOTFILES/sublime-setup/custom" "$HOME/.config/sublime-text/Packages/User/custom"
  backup_if_exists "$HOME/.config/sublime-text/Packages/User/Preferences.sublime-settings"
  cp -f "$DOTFILES/sublime-setup/Preferences.sublime-settings" "$HOME/.config/sublime-text/Packages/User/Preferences.sublime-settings"
}

setup_git () {
  if ! command -v git &> /dev/null; then
    echo "git is not installed on this system." >&2
    return 1
  fi
  if [ ! -d "$DOTFILES/git" ]; then
    echo "The \$DOTFILES/git folder does not exist."
    return 1
  fi

  backup_if_exists "$HOME/.gitconfig"
  ln -s "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
}

case "$setup_mode" in
  zsh)
    setup_zsh
    ;;
  kitty)
    setup_kitty
    ;;
  alacritty)
    setup_alacritty
    ;;
  fonts)
    setup_fonts
    ;;
  nvim)
    setup_nvim
    ;;
  tmux)
    setup_tmux
    ;;
  sublime)
    setup_sublime
    ;;
  git)
    setup_git
    ;;
  *)
    echo "Unknown setup_mode: $setup_mode" >&2
    exit 1
    ;;
esac
