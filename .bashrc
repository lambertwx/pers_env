# Change your command prompt to indicate whether your running in screen or tmux
if [ -n "$STY" ]; then export PS1="(screen) $PS1"; fi
if [ -n "$TMUX" ]; then export PS1="(tmux) $PS1"; fi

################################## Aliases

alias copy='cp'
alias cn='pushd ~/work/notebooks'
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
alias sls='screen -list'
alias type='less -X'


# If we're on the Mac
if [[ $(uname -s) == Darwin ]]; then
    alias act3='deactivate; source /Users/lambert/anaconda3/bin/activate'
    alias e='aquamacs'
    alias ex='open'

    # Alias "git" to run the "hub" add-on (https://hub.github.com)
    eval "$(hub alias -s)"
else
    alias e='emacs'
fi

if [[ $USER == lambert.wixson ]]; then
    alias psfire='ps gux | grep firefox'
    alias psvnc='ps gux --sort -etime | grep -i xvnc'
    alias scl='ssh clarifai@localhost'
fi

if [[ $HOSTNAME == chrome-c-gpu-node-1 ]]; then
    alias eval1='docker exec -it eval-1 bash -l'
fi

# Disable shell exit upon ctrl-D (unless the user hits ctrl-D 999 times)
export IGNOREEOF=999

# Function to remove a folder from your PYTHONPATH
# (from https://unix.stackexchange.com/questions/108873/removing-a-directory-from-path )
function pypath_remove {
    # Delete path by parts so we can never accidentally remove sub paths
    PYTHONPATH=${PYTHONPATH//":$1:"/":"} # delete any instances in the middle
    PYTHONPATH=${PYTHONPATH/#"$1:"/} # delete any instance at the beginning
    PYTHONPATH=${PYTHONPATH/%":$1"/} # delete any instance in the at the end
}

# Switch to sync folder
function sws {
    pypath_remove /home/lambert/work/clarifai
    export CLARIFAI_ROOT=/home/lambert/work/clar-sync
    PYTHONPATH=$CLARIFAI_ROOT:$PYTHONPATH
    cd $CLARIFAI_ROOT
}
