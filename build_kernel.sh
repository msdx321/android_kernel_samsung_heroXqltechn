#!/bin/bash

export PATH=$(pwd)/toolchains/linux-x86/aarch64/aarch64-linux-android-4.9/bin:$PATH
export CROSS_COMPILE=$(pwd)/toolchains/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export ARCH=arm64
export SEC_BUILD_OPTION_HW_REVISION=02

mkdir out

make -C $(pwd) O=$(pwd)/out ARCH=arm64 CROSS_COMPILE=aarch64-linux-android- KCFLAGS=-mno-android hero2qlte_chnzc_defconfig
make -C $(pwd) O=$(pwd)/out ARCH=arm64 CROSS_COMPILE=aarch64-linux-android- KCFLAGS=-mno-android

make -C $(pwd) O=$(pwd)/out KCFLAGS=-mno-android msdx321_defconfig
make -C $(pwd) O=$(pwd)/out KCFLAGS=-mno-android -j8
