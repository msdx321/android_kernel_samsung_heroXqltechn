#!/bin/bash

export ARCH=arm64
export SEC_BUILD_OPTION_HW_REVISION=02

ROOT_DIR=$(pwd)
OUT_DIR=$ROOT_DIR/out
BUILDING_DIR=$OUT_DIR/kernel_obj
DTS_DIR=$BUILDING_DIR/arch/arm64/boot/dts/samsung

JOB_NUMBER=`grep processor /proc/cpuinfo|wc -l`

ANYKERNEL_DIR=$ROOT_DIR/prebuilt-anykernel
TEMP_DIR=$OUT_DIR/temp

DTBTOOL=$ROOT_DIR/toolchains/dtbTool/dtbToolCM

BUILD_CHOICE=$1
TOOLCHAIN=$2

source $ROOT_DIR/venv/bin/activate

FUNC_PRINT()
{
		echo ""
		echo "=============================================="
		echo $1
		echo "=============================================="
		echo ""
}

FUNC_CLEAN()
{
		if [ $1 = "all" ]; then
				FUNC_PRINT "Cleaning All"
				rm -rf $OUT_DIR
				mkdir $OUT_DIR
				mkdir -p $BUILDING_DIR
				mkdir -p $TEMP_DIR
		elif [ $1 = "dirty" ]; then
				FUNC_PRINT "Dirty Cleaning"
				rm -rf $TEMP_DIR
				mkdir -p $TEMP_DIR
		elif [ $1 = "make-clean" ]; then
				FUNC_PRINT "Make Cleaning"
				cd $BUILDING_DIR
				make ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILER clean
				cd $ROOT_DIR
				rm -rf $TEMP_DIR
		fi;
}

FUNC_BUILD_KERNEL()
{
		FUNC_PRINT "Start Building Kernel"
		make -C $ROOT_DIR O=$BUILDING_DIR KCFLAGS=-mno-android msdx321_defconfig
		make -C $ROOT_DIR O=$BUILDING_DIR KCFLAGS=-mno-android -j$JOB_NUMBER ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILER
		FUNC_PRINT "Finish Building Kernel"
}

FUNC_BUILD_DTB()
{
		FUNC_PRINT "Building DTB"
		$DTBTOOL -v -s 2048 -o $TEMP_DIR/dtb $DTS_DIR/
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

if [ "${TOOLCHAIN}" = "SaberMod" ]; then
		CROSS_COMPILER=$ROOT_DIR/toolchains/SaberMod-aarch64-4.9/bin/aarch64-
		FUNC_PRINT "Using SaberMod-ToolChain"
else
		CROSS_COMPILER=$ROOT_DIR/toolchains/aarch64-linux-android-4.9/bin/aarch64-linux-android-
		FUNC_PRINT "Using Default-ToolChain"
fi;

START_TIME=`date +%s`
if [ "${BUILD_CHOICE}" = "dirty" ]; then
		FUNC_CLEAN dirty
		FUNC_BUILD_KERNEL
		FUNC_BUILD_DTB
		FUNC_PACK
elif [ "${BUILD_CHOICE}" = "pack-only" ]; then
		FUNC_CLEAN dirty
		FUNC_PACK
elif [ "${BUILD_CHOICE}" = "clean-make" ]; then
		FUNC_CLEAN make-clean
		FUNC_BUILD_KERNEL
		FUNC_BUILD_DTB
		FUNC_PACK
else
		FUNC_CLEAN all
		FUNC_BUILD_KERNEL
		FUNC_BUILD_DTB
		FUNC_PACK
fi;
END_TIME=`date +%s`

let "ELAPSED_TIME=$END_TIME-$START_TIME"
echo "Total compile time is $ELAPSED_TIME seconds"
