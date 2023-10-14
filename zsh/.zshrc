#!/usr/bin/zsh

source_if_exists() {
    local suppress_message=false

    while getopts ":s" opt; do
        case $opt in
            s) suppress_message=true ;;
            \?) echo "Invalid option: -$OPTARG" >&2; return 1 ;;
        esac
    done
    shift $((OPTIND - 1))

    if [[ -r "$1" ]]; then
        source "$1"
        return 0
    else
        if [ "$suppress_message" = false ]; then
            echo " \`source \"$1\" \` failed: \"$1\" does not exist or is not readable"
        fi
        return 1
    fi
}

export DOTFILES=$HOME/.dotfiles

source_if_exists "$DOTFILES"/zsh/conf/settings.zsh
source_if_exists "$DOTFILES"/zsh/conf/prompt.zsh
source_if_exists "$DOTFILES"/zsh/conf/plugs.zsh
source_if_exists "$DOTFILES"/zsh/conf/env.zsh
