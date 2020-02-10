# This is what anaconda puts in your .bashrc or .bash_profile.  I moved it out here from there
# to avoid conflicts with the Zillow default env

# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/Users/lambertw/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    echo "Eval'ing conda_setup"
    \eval "$__conda_setup"
else
    if [ -f "/Users/lambertw/anaconda3/etc/profile.d/conda.sh" ]; then
        echo "Running conda.sh from profile.d"
        . "/Users/lambertw/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
	echo "Just prepending anaconda to path."
        \export PATH="/Users/lambertw/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
