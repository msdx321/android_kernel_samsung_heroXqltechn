#!/bin/bash

export ARCH=arm64
export SEC_BUILD_OPTION_HW_REVISION=02

ROOT_DIR=$(pwd)
OUT_DIR=$ROOT_DIR/out
BUILDING_DIR=$OUT_DIR/kernel_obj

JOB_NUMBER=`grep processor /proc/cpuinfo|wc -l`

ANYKERNEL_DIR=$ROOT_DIR/prebuilt-anykernel
TEMP_DIR=$OUT_DIR/temp/

DTBTOOL=$ROOT_DIR/toolchains/dtbTool/dtbToolCM

TOOLCHAIN=$1

FUNC_PRINT()
{
		echo ""
		echo "=============================================="
		echo $1
		echo "=============================================="
		echo ""
}
if [ "${TOOLCHAIN}" = "SaberMod" ]; then

		CROSS_COMPILER=$ROOT_DIR/toolchains/SaberMod-aarch64-4.9/bin/aarch64-
		FUNC_PRINT "Using SaberMod-ToolChain"

else

		CROSS_COMPILER=$ROOT_DIR/toolchains/aarch64-linux-android-4.9/bin/aarch64-linux-android-
		FUNC_PRINT "Using Default-ToolChain"

fi;

FUNC_BUILD_KERNEL()
{
		FUNC_PRINT "Start Building Kernel"

		make -C $ROOT_DIR O=$BUILDING_DIR KCFLAGS=-mno-android msdx321_defconfig
		make -C $ROOT_DIR O=$BUILDING_DIR KCFLAGS=-mno-android -j$JOB_NUMBER ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILER

		FUNC_PRINT "Finish Building Kernel"
}

FUNC_CLEAN()
{
		FUNC_PRINT "Cleaning"

		rm -rf $OUT_DIR
		mkdir $OUT_DIR
		mkdir -p $TEMP_DIR

}

FUNC_PACK()
{
		FUNC_PRINT "Start Packing"

		cp -r $ANYKERNEL_DIR/* $TEMP_DIR
		cp $BUILDING_DIR/arch/arm64/boot/Image.gz $TEMP_DIR/zImage
		cd $TEMP_DIR
		zip -r BKernel.zip ./*
		mv BKernel.zip $OUT_DIR/BKernel.zip
		cd $ROOT_DIR

		FUNC_PRINT "Finish Packing"
}

FUNC_BUILD_DTB()
{
		FUNC_PRINT "Building DTB"
		$DTBTOOL -v -s 2048 -o $TEMP_DIR/dtb $BUILDING_DIR/arch/arm64/boot/dts/samsung/

}

START_TIME=`date +%s`
FUNC_CLEAN
FUNC_BUILD_KERNEL
FUNC_BUILD_DTB
FUNC_PACK
END_TIME=`date +%s`

let "ELAPSED_TIME=$END_TIME-$START_TIME"
echo "Total compile time is $ELAPSED_TIME seconds"
