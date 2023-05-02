backup_if_exists () {
  if [[ -r "$1" ]]; then
    mv --backup=numbered "$1" "$1.bak"
    return 0
  fi
}

alias cp="cp -i"                                                # Confirm before overwriting something

export TERM="xterm-256color"

# better df
if command -v duf &> /dev/null
then
  alias df=duf
fi

# colored ls
if command -v exa &> /dev/null
then
  alias ls=exa
else
  # File and Dir colors for ls and other outputs
  export LS_OPTIONS='--color=auto'
  eval "$(dircolors -b)"
  alias ls='ls $LS_OPTIONS'
fi

if command -v bat &> /dev/null
then
  alias cat=bat
fi
