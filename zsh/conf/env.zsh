# create .bak files
bak () {
  if [[ -r "$1" ]]; then
    mv --backup=numbered "$1" "$1.bak"
    return 0
  fi
}

# python calculator -- Usage : calc "2/(3+5)"
alias pycalc="python -c \"from math import *; import sys; print(eval(''.join(sys.argv[1:])))\""

# confirm before overwriting a file
alias cp="cp -i" 
alias mv="mv -i"

# colorize grep output
alias grep="grep --color=always"
alias egrep="egrep --color=always"
alias fgrep="fgrep --color=always"

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

# better cat
if command -v bat &> /dev/null
then
  alias cat=bat
fi
