alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB

if command -v trash &> /dev/null
then
  alias rm=trash
fi
