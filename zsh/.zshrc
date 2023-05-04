#!/usr/bin/zsh

source_if_exists () {
    if [[ -r "$1" ]]; then
        source "$1"
        return 0
    else
        echo "\`source \"$1\"\` failed : \"$1\" does not exist or is not readable"
        return 1
    fi
}

export DOTFILES=$HOME/.dotfiles

source_if_exists "$DOTFILES"/zsh/conf/settings.zsh
source_if_exists "$DOTFILES"/zsh/conf/prompt.zsh
source_if_exists "$DOTFILES"/zsh/conf/plugs.zsh
source_if_exists "$DOTFILES"/zsh/conf/env.zsh
