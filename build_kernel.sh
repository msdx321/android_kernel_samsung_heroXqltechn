#!/bin/bash

export PATH=$(pwd)/toolchains/linux-x86/aarch64/aarch64-linux-android-4.9/bin:$PATH
export CROSS_COMPILE=$(pwd)/toolchains/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export ARCH=arm64
export SEC_BUILD_OPTION_HW_REVISION=02

make -C $(pwd) O=$(pwd)/out KCFLAGS=-mno-android msdx321_defconfig
make -C $(pwd) O=$(pwd)/out KCFLAGS=-mno-android -j8

$(pwd)/toolchains/dtbTool/dtbToolCM -v -s 2048 -o out/arch/arm64/boot/dt.img  out/arch/arm64/boot/dts/samsung/

cp out/arch/arm64/boot/dt.img out/dt_image
cp out/arch/arm64/boot/Image.gz out/kernel.gz
