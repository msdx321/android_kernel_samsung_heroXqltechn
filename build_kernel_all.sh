#!/bin/zsh

export ARCH=arm64
export SEC_BUILD_OPTION_HW_REVISION=02

ROOT_DIR=$(pwd)
OUT_DIR=$ROOT_DIR/out
BUILDING_DIR=$OUT_DIR/kernel_obj
DIST_DIR=$ROOT_DIR/out-dist

JOB_NUMBER=`grep processor /proc/cpuinfo|wc -l`

#CROSS_COMPILER=$ROOT_DIR/lazy-prebuilt/aarch64-linux-android-4.9/bin/aarch64-linux-android-
CROSS_COMPILER=$ROOT_DIR/lazy-prebuilt/aarch64-linaro-4.9/bin/aarch64-linux-gnu-

DTBTOOL=$ROOT_DIR/lazy-prebuilt/bin/dtbTool
DTS_DIR=$BUILDING_DIR/arch/arm64/boot/dts/samsung

ANYKERNEL_DIR=$ROOT_DIR/anykernel-prebuilt
TEMP_DIR=$OUT_DIR/temp

FUNC_PRINT()
{
		echo ""
		echo "=============================================="
		echo $1
		echo "=============================================="
		echo ""
}

FUNC_CLEAN_DIST()
{
		FUNC_PRINT "Cleaning ZIPs"
		rm -rf $DIST_DIR
		mkdir -p $DIST_DIR
}

FUNC_CLEAN()
{
		FUNC_PRINT "Cleaning All"
		rm -rf $OUT_DIR
		mkdir $OUT_DIR
		mkdir -p $BUILDING_DIR
		mkdir -p $TEMP_DIR
}

FUNC_COMPILE_KERNEL()
{
		FUNC_PRINT "Start Compiling Kernel"
		make -C $ROOT_DIR O=$BUILDING_DIR $1
		make -C $ROOT_DIR O=$BUILDING_DIR -j$JOB_NUMBER ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILER
		FUNC_PRINT "Finish Compiling Kernel"
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
		mkdir $TEMP_DIR/modules
		find . -type f -name "*.ko" | xargs cp -t $TEMP_DIR/modules
		cd $TEMP_DIR
		zip -r BKernel.zip ./*
		mv BKernel.zip $DIST_DIR/BKernel-$1.zip
		cd $ROOT_DIR
		FUNC_PRINT "Finish Packing"
}

START_TIME=`date +%s`
FUNC_CLEAN_DIST
FUNC_CLEAN
FUNC_COMPILE_KERNEL msdx321_hero2qlte_chnzc_defconfig
FUNC_BUILD_DTB
FUNC_PACK G9350
FUNC_CLEAN
FUNC_COMPILE_KERNEL msdx321_heroqlte_chnzc_defconfig
FUNC_BUILD_DTB
FUNC_PACK G9300
END_TIME=`date +%s`

let "ELAPSED_TIME=$END_TIME-$START_TIME"
echo "Total compile time is $ELAPSED_TIME seconds"
