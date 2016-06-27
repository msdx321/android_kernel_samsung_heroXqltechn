#!/bin/bash

ROOT_DIR=$(pwd)
OUT_DIR=$ROOT_DIR/out
BUILDING_DIR=$OUT_DIR/kernel_obj

CROSS_COMPILER=$ROOT_DIR/toolchains/aarch64-gnu-4.9/bin/aarch64-
JOB_NUMBER=`grep processor /proc/cpuinfo|wc -l`

ANYKERNEL_DIR=$ROOT_DIR/prebuilt-anykernel
TEMP_DIR=$OUT_DIR/temp/

DTBTOOL=$ROOT_DIR/toolchains/dtbTool/dtbToolCM

FUNC_BUILD_KERNEL()
{
		echo ""
		echo "=============================================="
		echo "START BUILDING KERNEL"
		echo "=============================================="
		echo ""

		make -C $ROOT_DIR O=$BUILDING_DIR msdx321_defconfig
		make -C $ROOT_DIR O=$BUILDING_DIR -j$JOB_NUMBER ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILER

		echo ""
		echo "=============================================="
		echo "FINISH BUILDING KERNEL"
		echo "=============================================="
		echo ""
}

FUNC_CLEAN()
{
		echo ""
		echo "=============================================="
		echo "CLEANING"
		echo "=============================================="
		echo ""

		rm -rf $OUT_DIR
		mkdir $OUT_DIR
		mkdir -p $TEMP_DIR

}

FUNC_PACK()
{
		echo ""
		echo "=============================================="
		echo "START PACKING"
		echo "=============================================="
		echo ""

		cp -r $ANYKERNEL_DIR/* $TEMP_DIR
		cp $BUILDING_DIR/arch/arm64/boot/Image.gz $TEMP_DIR/zImage
		cd $TEMP_DIR
		zip -r BKernel.zip ./*
		mv BKernel.zip $OUT_DIR/BKernel.zip
		cd $ROOT_DIR

		echo ""
		echo "=============================================="
		echo "FINISH PACKING"
		echo "=============================================="
		echo ""
}

FUNC_BUILD_DTB()
{
		echo ""
		echo "=============================================="
		echo "BUILDING DTB"
		echo "=============================================="
		echo ""

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
