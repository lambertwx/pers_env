# This is what anaconda puts in your .bashrc or .bash_profile.  I moved it out here from there
# to avoid conflicts with the Zillow default env

# Figure out whether to use miniconda or conda.  This is my code, not from conda init.
# Test whether the miniconda dir exists
if (test -d "$HOME/miniconda3")
then
    CONDIR=$HOME/miniconda3
else
    CONDIR=$HOME/anaconda3
fi
echo "Conda path is $CONDIR"


# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$( $CONDIR/bin/conda shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    echo "Eval'ing conda_setup"
    eval "$__conda_setup"
else
    if [ -f "$CONDIR/etc/profile.d/conda.sh" ]; then
        echo "Running conda.sh from profile.d"
        . "$CONDIR/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
	echo "Just prepending anaconda to path."
        export PATH="$CONDIR/bin:$PATH"
    fi
fi
unset __conda_setup
