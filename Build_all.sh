#! /bin/bash
clear
# Package requirements (Arch Linux names):
# spirv-cross, mingw-w64-gcc, automake-1.15, gtk-doc


ROOTDIR="$(dirname "$(dirname "$(readlink -fm "$0")")")"
LIBRAIN_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
LIBACFUTILS_PATH="$ROOTDIR/libacfutils"

# Function: Pause
function pause(){
   echo "Press any key to continue"
   read -p "$*"
}
# Function: Compile shaders
function compile_shaders(){
    echo "=> Starting shader compilation step..."
    echo " "
    cd $LIBRAIN_PATH/shaders
    make
    echo " "
    echo "=> Shader compilation step processed."
    pause
    clear
}

function test(){
  # We'll try to build on N+1 CPUs we have available. The extra +1 is to allow
    # for one make instance to be blocking on disk.
    NCPUS=$(( $(grep 'processor[[:space:]]\+:' /proc/cpuinfo  | wc -l) + 1 ))
    RELEASE="debug"

    OUTPUT=$LIBRAIN_PATH/plugin/librain.plugin

    rm -rf "$OUTPUT"
    mkdir -p "$OUTPUT/docs" "$OUTPUT"/shaders

    cp $LIBRAIN_PATH/shaders/bin/*.glsl* $LIBRAIN_PATH/shaders/bin/*.spv* "$OUTPUT/shaders"
    cp $LIBRAIN_PATH/COPYING.txt $LIBRAIN_PATH/plugin/HOWTO.txt $LIBRAIN_PATH/README.md $LIBRAIN_PATH/src/librain.h \
    "$OUTPUT/docs"

    # make distclean > /dev/null

    if [[ $(uname) = "Darwin" ]]; then
        mkdir -p "$OUTPUT/mac_x64"

        qmake -spec macx-clang
        make clean && make -j $NCPUS
        if [ $? != 0 ] ; then
            exit
        fi
        mv librain.dylib "$OUTPUT/mac_x64/librain.plugin.xpl" || exit 1
    else
        mkdir -p "$OUTPUT/win_x64" "$OUTPUT/lin_x64"

        qmake -set CROSS_COMPILE x86_64-w64-mingw32-
        qmake -spec win32-g++
        make clean && make -j $NCPUS
        if [ $? != 0 ] ; then
            exit
        fi
        mv "$RELEASE/rain.dll" "$OUTPUT/win_x64/librain.plugin.xpl" || exit 1

        qmake -spec linux-g++-64
        make clean && make -j $NCPUS
        if [ $? != 0 ] ; then
        exit
        fi
        mv librain.so "$OUTPUT/lin_x64/librain.plugin.xpl" || exit 1
    fi

    make distclean > /dev/null
}

# Function compile librain
function compile_librain(){
    echo "=> Starting librain compilation step..."
    echo " "
    echo "=> Preparing makefile from qmake project..."
    cd $LIBRAIN_PATH/plugin/qmake
    qmake -set LIBACFUTILS $LIBACFUTILS_PATH
    qmake
    echo " "
    echo "=> Building cglm library..."
    cd $LIBACFUTILS_PATH/cglm
    ./build_cglm
    echo " "
    echo "=> Building glew library..."
    cd $LIBACFUTILS_PATH/glew
    ./build_glew_deps
    echo " "
    echo "=> Attempting compilation..."
    ###
    cd $LIBRAIN_PATH/plugin/qmake
    ./build
    pause
    echo "=> Librain compilation step processed."
    clear
}







# Function execution

# compile_shaders
compile_librain
