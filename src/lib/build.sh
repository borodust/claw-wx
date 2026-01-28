#!/bin/bash

WORK_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
LIBRARY_DIR=$WORK_DIR/wx/

RELEASE_MODE="MinSizeRel"

REST_ARGS=
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    --arch)
        TARGET_ARCH="$2"
        shift
        shift
        ;;
    --ndk)
        NDK="$2"
        shift
        shift
        ;;
    --debug)
        RELEASE_MODE="Debug"
        shift
        ;;
    *)
        REST_ARGS+="$1"
        shift
        ;;
esac
done

BUILD_DIR="$WORK_DIR/build/$REST_ARGS/"

function build_desktop {
    mkdir -p "$BUILD_DIR" && cd "$BUILD_DIR"
    cmake -DCMAKE_BUILD_TYPE=$RELEASE_MODE \
           -DCMAKE_C_COMPILER=clang \
           -DCMAKE_CXX_COMPILER=clang++ \
           -DCMAKE_SHARED_LINKER_FLAGS="-stdlib=libc++ -lc++abi" \
           -DCMAKE_CXX_FLAGS="-ferror-limit=0" \
           $WORK_DIR
    cmake --build  . --config $RELEASE_MODE
    yes | cp "$BUILD_DIR/wx/lib/"libwx_*.so* "$BUILD_DIR/"
    ln -fs ./wx/lib/wx/include/"$(find wx/lib/wx/include/ -name "setup.h" -printf "%P\n")" .
}


case "$REST_ARGS" in
    desktop)
        build_desktop
        ;;
    *)
        echo "Unrecognized platform $REST_ARGS"
        exit -1
        ;;
esac
