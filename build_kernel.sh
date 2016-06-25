#!/bin/bash

export PATH=$(pwd)/toolchains/linux-x86/aarch64/aarch64-linux-android-4.9/bin:$PATH
export CROSS_COMPILE=$(pwd)/toolchains/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export ARCH=arm64
export SEC_BUILD_OPTION_HW_REVISION=02

make -C $(pwd) O=$(pwd)/out KCFLAGS=-mno-android msdx321_defconfig
make -C $(pwd) O=$(pwd)/out KCFLAGS=-mno-android -j8

$(pwd)/toolchains/dtbTool/dtbToolCM -v -s 2048 -o out/arch/arm64/boot/dt.img  out/arch/arm64/boot/dts/samsung/

cp -f out/arch/arm64/boot/dt.img prebuilt-boot/boot.img-dt
cp -f out/arch/arm64/boot/Image.gz prebuilt-boot/boot.img-zImage

cd prebuilt-boot
rm -rf boot.img
$(pwd)/mkboot/mkbootimg --kernel boot.img-zImage --ramdisk boot.img-ramdisk.gz --cmdline "console=null androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 cma=24M@0-0xffffffff rcupdate.rcu_expedited=1" --tags_offset 02000000 --dt boot.img-dt --base 80000000 --pagesize 4096 -o boot.img
