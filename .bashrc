# Include this via "source ~/pers_env/.bashrc"

################################## Environment variables

# Change your command prompt to indicate whether your running in screen or tmux
if [ -n "$STY" ]; then export PS1="(screen) $PS1"; fi
if [ -n "$TMUX" ]; then export PS1="(tmux) $PS1"; fi

# Disable shell exit upon ctrl-D (unless the user hits ctrl-D 999 times)
export IGNOREEOF=999

# This is useful for finding some utility scripts.  But you don't have to put this into your path,
# since these scripts can only be run as "python foo.py".
export PATH_TENFLOW_PYTOOLS=$VIRTUAL_ENV/lib/python2.7/site-packages/tensorflow/python/tools

# This is where "brew install qt" installed it. 
export CMAKE_PREFIX_PATH=/usr/local/opt/qt5

##### Paths #####
if [[ $(uname -s) == Darwin ]]; then
    export PATH_AQUAMACS=/Applications/Aquamacs.app/Contents/MacOS/bin
    export PATH=$PATH_AQUAMACS:$PATH

    export PATH_ARAXIS=/Applications/Araxis\ Merge.app/Contents/Utilities
    export PATH=$PATH:$PATH_ARAXIS
fi

export PATH=$PATH:~/pers_env/bin:~/bin

export JB_DISABLE_BUFFERING=1

################################## Aliases

###### Aliases that work in all environments.

alias copy='cp'
alias cls='clear'

### Special versions of cd and pushd 
alias cd-fma='pushd ~/zillow/rmx/experiences/web/floor-map-annotator/content'
alias cd-fmascratch='pushd ~/zillow/rmx/experiences/web/floor-map-annotator-scratch/content'
alias cd-rot='pushd ~/zillow/rmx/scripts/rotation_support'
# cd to the root of your current git repo
alias cdg='cd ./$(git rev-parse --show-cdup)'
alias cn='pushd ~/work/notebooks'
alias cr='pushd $GIT_ROOT'

alias cp='cp -i'
alias del='rm'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Get the current branch
alias gc="git branch | awk '/\*/ {print \$0; }'"
# Switch to the master branch
alias gcm='git checkout master'
alias gd='alias_gd'        # git difftool. See functions below.
alias gitcomm='git commit --no-verify'
alias gs='git status | more'

alias grep='grep --color=auto'
alias h='history'
alias j='jobs'

# By default Jupyter opens port 8888 but this can conflict with web
# proxies like Charles that don't pick a new port automatically if the port
# they want is taken.  So have Jupyter starting trying at 8900 and work up
# up from there.
alias jnb='jupyter notebook --no-browser --notebook-dir=~/work --port=8900'

#alias klogs='ls -l $CLARIFAI_ROOT/go/src/clarifai/*.log'

alias l='ls -CF'           # Use this instead of ls if you want to see symlinks
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls -FL'          # The -L means to follow symlinks instead of displaying them as @

### Aliases for mpv.  Note that many other settings for my mpv are in my ~/.config/mpv files.
# See my "video players" google doc https://docs.google.com/document/d/1C371RczJEvqdlsTsRCCoop3zrBiD3RQynz40Jb0uo2s/edit#

# Play a clip or a set of image files as a clip.  Use "--mf-fps" to set the frame rate.
alias mpclip='mpv --merge-files'

# Play a set of images with each images being one element of a playlist.  
# We set image-display-duration to 1 because as of 3/1/20
# mpv has a bug that if you set the image-display-duration to be less than 1, when you step to the
# prev playlist it may jump over multiple playlists.
alias mpim='mpv --image-display-duration=1'

###

alias mv='mv -i'

# Pass -X to less so it doesn't clear the screen on exit.  -F so it exits if file fits on the screen
alias more='less -XF'
alias nmake='make'
alias rmb='rm *~ *.bak'

# Sets up conda env.
alias setcon='source ~/pers_env/bin/setcon.sh'
# Set up WebAssembly env.
alias set_wasm='source ~/pers_env/bin/set_wasm.sh'

#alias type='less -XF'  # Can't do this because type is a builtin in bash.

alias xl='open -a "Microsoft Excel"'

# Show all Zillow-related environment variables.  The "-o posix" is to prevent set from showing one's bash functions.
alias zlv='set -o posix; set | grep -E "(^Z)|(GIT_ROOT); set +o posix'



### Environment-specific aliases
# If we're on the Mac
if [[ $(uname -s) == Darwin ]]; then
    # Copy laptop to colo
    alias 2co='rsync -r --exclude-from ~/work/PYSYNC_IGNORE.txt --exclude='*.pyc' --update --verbose ~/work/clarifai/* lambert@q9:/home/lambert/work/clar-sync'
    alias act3='deactivate; source /Users/lambert/anaconda3/bin/activate'
    alias adiff='"${PATH_ARAXIS}"/compare'  # We do the double-quote to handle the fact that PATH_ARAXIS has a space in it.
    #    alias e='aquamacs'
    # The following is a workaround to avoid the problem where aquamacs won't start from double-click on MacOS 10.14 Mojave
    alias e='/Applications/Aquamacs.app/Contents/MacOS/Aquamacs'
    alias ex='open'

    # Alias "git" to run the "hub" add-on (https://hub.github.com).  Comment out if you don't use hub.
    # eval "$(hub alias -s)"

    # Mount colo dirs
    # Copy these mountc() and umountc() to your Mac's .bash_profile and fill in appropriately,
    # so that your userid and machines aren't visible when you check in to gitlab.
    #function mountc {
	# sshfs lambert@q18:/mnt/nfs/lambert ~/CoH
	# sshfs lambert@q18:/mnt/scratch/1 ~/Co1
	# sshfs lambert@q18:/mnt/scratch/2 ~/Co2
    #}

    #function umountc {
	#diskutil unmount ~/CoH
	#diskutil unmount ~/Co1
	#diskutil unmount ~/Co2
    #}
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

# Put this into a function because you need to invoke this via its full path because it loads JAR files from there.
# So a symlink doesn't work.
function awsokta {
    ~/zillow/TOOL/okta-aws-cli-assume-role/awsokta
}

# Function to remove compiled python code below the current folder
# Works on macOS and Linux
# From https://stackoverflow.com/questions/28991015/python3-project-remove-pycache-folders-and-pyc-files
pyclean () {
    find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
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


# Disabled until I understand Zillow's dev setup better
if [ 0 == 1 ]; then
  # Set up git tab completion.
  # To enable this on Mac, you have to do: brew install bash-completion
  [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
fi

# Disabled until I understand Zillow's dev setup better
if [ 0 == 1 ]; then
  # Set up virtualenv switching with tab completion
  # To enable this on Mac, you have to do: pip install virtualenvwrapper
  source ~/virtualenv/v1/bin/virtualenvwrapper.sh
fi

# Set up pyenv shims
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
