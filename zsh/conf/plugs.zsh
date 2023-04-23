# Use syntax highlighting
source_if_exists "$DOTFILES"/zsh/conf/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Use history substring search
if source_if_exists "$DOTFILES"/zsh/conf/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh; then
    # bind UP and DOWN arrow keys to history substring search
    zmodload zsh/terminfo
    bindkey "${terminfo[kcuu1]}" history-substring-search-up
    bindkey "${terminfo[kcud1]}" history-substring-search-down
    bindkey '^[[A' history-substring-search-up			
    bindkey '^[[B' history-substring-search-down
fi

# Use autosuggestions based on history
source_if_exists "$DOTFILES"/zsh/conf/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
