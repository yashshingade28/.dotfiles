() {
  emulate -L zsh

  source_if_exists $DOTFILES/zsh/conf/powerlevel10k/powerlevel10k.zsh-theme

  typeset USE_POWERLINE=true

  # Determine terminal capabilities.
  {
    if ! zmodload zsh/langinfo zsh/terminfo ||
      [[ $langinfo[CODESET] != (utf|UTF)(-|)8 || $TERM == (dumb|linux) ]] ||
      (( terminfo[colors] < 256 )); then
      # Don't use the powerline config. It won't work on this terminal.
      USE_POWERLINE=false
      # Define alias `x` if our parent process is `login`.
      typeset parent=$(</proc/$PPID/comm:t)
      if [[ $parent == login ]]; then
        alias x='startx ~/.xinitrc'
      fi
    fi
  } 2>/dev/null

  if [[ $USE_POWERLINE == false ]]; then
    # Use 8 colors and ASCII.
    source_if_exists $DOTFILES/zsh/conf/.p10k-portable.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=black,bold'
  else
    # Use 256 colors and UNICODE.
    if source_if_exists $DOTFILES/zsh/conf/.p10k.zsh; then
      # Enabling the correct and wrong status at the right end
      typeset -g POWERLEVEL9K_STATUS_OK=true
      typeset -g POWERLEVEL9K_STATUS_ERROR=true
    fi
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
  fi
}
