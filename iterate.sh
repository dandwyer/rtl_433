#!/usr/bin/env bash

set -euox pipefail

# Path to the script itself
script_path="$0"

# Run ShellCheck on this script
shellcheck "$script_path" || {
    echo "ShellCheck found issues in the script."
    exit 1
}

echo "ShellCheck did not find any issues."

cmake -GNinja -B build \
    -DBUILD_TESTING_ANALYZER=OFF \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_INSTALL_PREFIX=~/.local \
    -DFORCE_COLORED_BUILD:BOOL=ON \

cmake --build build -j "$(nproc)"

cmake --build build -j "$(nproc)" --target test

build/src/rtl_433 \
    -vv \
    -r ~/samples/g796_916.45M_1200k.cu8 \
    -Y minlevel=-15 \
    -X

build/src/rtl_433 \
    -vv \
    -r ~/samples/g796_916.45M_1200k.cu8 \
    -Y minlevel=-15 \
    -X n=name,m=FSK_PCM,s=10,l=10,r=10240 \
    -R 0

build/src/rtl_433 \
    -vv \
    -r ~/samples/g796_916.45M_1200k.cu8 \
    -Y minlevel=-15 \
    -X n=name,m=FSK_PCM,s=10,l=10,r=10240



    #-R 0

#-R 223:vvvv

build/src/rtl_433 \
    -vv \
    -r ~/samples/g796_916.45M_1200k.cu8 \
    -R 223:vvvvvv,1601937 \
    -R 223 \
    -X n=one,m=FSK_PCM,s=10,l=10,r=10240 \
    -Y minlevel=-15 \

echo "All tests passed."