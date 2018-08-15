alias cr='pushd $CLARIFAI_ROOT'
alias del='rm'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias jnb='jupyter notebook --no-browser --notebook-dir=~/work'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls -F'
# Pass -X to less so it doesn't clear the screen on exit.
alias more='less -X'
alias type='less -X'

if [[ $(uname -s) == Darwin ]]; then
    alias e='aquamacs'
    alias ex='open'

    # Alias "git" to run the "hub" add-on (https://hub.github.com)
    eval "$(hub alias -s)"
else
    alias e='emacs'
fi

if [[ $USER == lambert.wixson]]; then
    alias scl='ssh clarifai@localhost'
fi

# Disable shell exit upon ctrl-D (unless the user hits ctrl-D 999 times)
export IGNOREEOF=999
