#!/bin/bash

export PATH=/home/bit/Android/CyanogenMod/cm-13.0/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin:$PATH
export CROSS_COMPILE=/home/bit/Android/CyanogenMod/cm-13.0/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export ARCH=arm64
export SEC_BUILD_OPTION_HW_REVISION=02

rm -rf ~/out
mkdir ~/out

<<<<<<< HEAD
make -C $(pwd) O=$(pwd)/out ARCH=arm64 CROSS_COMPILE=aarch64-linux-android- KCFLAGS=-mno-android hero2qlte_chnzc_defconfig
make -C $(pwd) O=$(pwd)/out ARCH=arm64 CROSS_COMPILE=aarch64-linux-android- KCFLAGS=-mno-android

cp out/arch/arm64/boot/Image $(pwd)/arch/arm64/boot/Image
=======
make -C $(pwd) O=/home/bit/out KCFLAGS=-mno-android msdx321_defconfig
make -C $(pwd) O=/home/bit/out KCFLAGS=-mno-android -j8
>>>>>>> 8da1926... Update build_kernel.sh
