################################## Environment variables

# Change your command prompt to indicate whether your running in screen or tmux
if [ -n "$STY" ]; then export PS1="(screen) $PS1"; fi
if [ -n "$TMUX" ]; then export PS1="(tmux) $PS1"; fi

# Disable shell exit upon ctrl-D (unless the user hits ctrl-D 999 times)
export IGNOREEOF=999

# This is useful for finding some utility scripts.  But you don't have to put this into your path,
# since these scripts can only be run as "python foo.py".
export PATH_TENFLOW_PYTOOLS=$VIRTUAL_ENV/lib/python2.7/site-packages/tensorflow/python/tools

##### Paths #####
if [[ $(uname -s) == Darwin ]]; then
    export PATH_ARAXIS=/Applications/Araxis\ Merge.app/Contents/Utilities
    export PATH=$PATH:$PATH_ARAXIS
fi

export JB_DISABLE_BUFFERING=1

################################## Aliases

### Aliases that work in all environments.

alias copy='cp'
alias cls='clear'

# Show all Clarifai-related environment variables.  The "-o posix" is to prevent set from showing one's bash functions.
alias clv='set -o posix; set | grep CLARIFAI; set +o posix'

alias cn='pushd ~/work/notebooks'
alias cr='pushd $CLARIFAI_ROOT'
alias del='rm'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Get the current branch
alias gc="git branch | awk '/\*/ {print \$0; }'"
# Switch to the master branch
alias gcm='git checkout master'
alias gd='alias_gd'        # git difftool. See functions below.
alias gs='git status | more'

alias grep='grep --color=auto'
alias h='history'

# By default Jupyter opens port 8888 but this can conflict with web
# proxies like Charles that don't pick a new port automatically if the port
# they want is taken.  So have Jupyter starting trying at 8900 and work up
# up from there.
alias jnb='jupyter notebook --no-browser --notebook-dir=~/work --port=8900'

alias klogs='ls -l $CLARIFAI_ROOT/go/src/clarifai/*.log'

alias l='ls -CF'           # Use this instead of ls if you want to see symlinks
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls -FL'          # The -L means to follow symlinks instead of displaying them as @

alias mpclip='mpv --keep-open --script-opts=osc-timems=yes,osc-visibility=always --pause'

# Pass -X to less so it doesn't clear the screen on exit.  -F so it exits if file fits on the screen
alias more='less -XF'
alias rmb='rm *~'
alias type='less -XF'


### Environment-specific aliases
# If we're on the Mac
if [[ $(uname -s) == Darwin ]]; then
    # Copy laptop to colo
    alias 2co='rsync -r --exclude-from ~/work/PYSYNC_IGNORE.txt --exclude='*.pyc' --update --verbose ~/work/clarifai/* lambert@q9:/home/lambert/work/clar-sync'
    alias act3='deactivate; source /Users/lambert/anaconda3/bin/activate'
    alias adiff='"${PATH_ARAXIS}"/compare'  # We do the double-quote to handle the fact that PATH_ARAXIS has a space in it.
    alias e='aquamacs'
    alias ex='open'

    # Alias "git" to run the "hub" add-on (https://hub.github.com)
    eval "$(hub alias -s)"

    # Mount colo dirs
    function mountc {
	sshfs lambert@q18:/mnt/nfs/lambert ~/CoH
	sshfs lambert@q18:/mnt/scratch/1 ~/Co1
	sshfs lambert@q18:/mnt/scratch/2 ~/Co2
    }
else
    alias e='emacs'
    alias sls='screen -list'
fi

if [[ $USER == lambert.wixson ]]; then
    alias psfire='ps gux | grep firefox'
    alias psvnc='ps gux --sort -etime | grep -i xvnc'
    alias scl='ssh clarifai@localhost'
fi

if [[ $HOSTNAME == chrome-c-gpu-node-1 ]]; then
    alias eval1='docker exec -it eval-1 bash -l'
fi

##### Functions #####

# Had to put in function because we want to pass args AND run in background.  You can't do this with a regular alias.
function alias_gd {
    git difftool "$@" &
}

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

# Set up git tab completion.
# To enable this on Mac, you have to do: brew install bash-completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Set up virtualenv switching with tab completion
# To enable this on Mac, you have to do: pip install virtualenvwrapper
source ~/virtualenv/v1/bin/virtualenvwrapper.sh
