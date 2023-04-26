alias cp="cp -i"                                                # Confirm before overwriting something
alias free='free -m'                                            # Show sizes in MB

export TERM="xterm-256color"

# been there
if command -v trash &> /dev/null
then
  alias rm=trash
fi

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
