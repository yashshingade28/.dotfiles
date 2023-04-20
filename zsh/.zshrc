source_if_exists () {
    if [[ -r "$1" ]]; then
        source "$1"
        return 0
    else
        echo "\`source \"$1\"\` failed : \"$1\" does not exist or is not readable"
        return 1
    fi
}

export DOTFILES=$HOME/.dotfiles/

source_if_exists $DOTFILES/zsh/conf/env-vars.zsh
source_if_exists $DOTFILES/zsh/conf/load-plugs.zsh
source_if_exists $DOTFILES/zsh/conf/zsh-config
source_if_exists $DOTFILES/zsh/conf/load-prompt.zsh
