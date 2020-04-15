#/bin/bash -f

# Detect live and commented-out debugger statements in JavaScript files.
# SOMEDAY: Remove them automatically

function git_root() {
    echo $(git rev-parse --show-toplevel)
}

grep -r --include=\*.js --exclude-dir=\*.next --exclude-dir=node_modules debugger $(git_root)

