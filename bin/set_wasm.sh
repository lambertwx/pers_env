# This sets up some more paths for using emscripten and its versions of clang, llvm, etc.
# Note that you must have a working python3 set up, so before you run this, source setcon.sh.

# This will add $EMSDK and $EMSDK/upstream/emscripten and $EMSDK/node/12.9.1_64bit/bin to your PATH
source ~/party3/emsdk/emsdk_env.sh

# Add one more folder to your path.  This holds clang, llvm, etc.
export WASM_UTILS_BIN=$EMSDK/upstream/bin
export PATH=$WASM_UTILS_BIN:$PATH


