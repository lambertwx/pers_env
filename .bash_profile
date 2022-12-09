# This gets executed by an interactive LOGIN shell
# Include this via "source ~/pers_env/.bash_profile"

if [ -f ~/pers_env/bin/enable_numkeys_as_cursor.sh ]; then
    source ~/pers_env/bin/enable_numkeys_as_cursor.sh > /dev/null
fi

# This has to be in the .bash_profile as per https://github.com/pyenv/pyenv
eval "$(pyenv init --path)"
