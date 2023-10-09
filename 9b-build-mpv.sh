#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh
clear && echo $0 $@

BUILD64=~/mpv-winbuild-cmake/build64
cd $BUILD64

StartTime=$(date '+%H:%M:%S')
#set -x #echo on
#{ set +x; } 2>/dev/null # echo off

echo-build vulkan

#FILE=$BUILD64/install/x86_64-w64-mingw32/lib/pkgconfig/vulkan.pc
#if [ ! -f "$FILE" ]; then

#		sed -i "s/if(PKG_CONFIG_FOUND)/if(TRUE)/" $BUILD64/packages/vulkan-prefix/src/vulkan/loader/CMakeLists.txt

#		rm $BUILD64/packages/vulkan-prefix/src/vulkan-stamp/vulkan-build

#		ninja vulkan
#fi

echo "+ ninja libssh"
ninja libssh -j 1

echo-build shaderc

#FILE=$BUILD64/install/x86_64-w64-mingw32/lib/pkgconfig/shaderc.pc

#if [ ! -f "$FILE" ]; then
#	cp $BUILD64/packages/shaderc-prefix/src/shaderc-build/shaderc.pc $FILE
#fi

echo-build libplacebo

#rm $FILE

echo-build spirv-cross
echo-build libarchive
echo-build libass

lsb_release -a &> /dev/null
if [ $? -ne 127 ]; then
	rm -rf packages/vulkan-prefix/src/vulkan/
	rm -rf packages/vulkan-header-prefix/src/vulkan-header/

	rm -rf packages/shaderc-prefix/src/shaderc/
	rm -rf packages/spirv-tools-prefix/src/spirv-tools/
	rm -rf packages/spirv-headers-prefix/src/spirv-headers/
	rm -rf packages/glslang-prefix/src/glslang/

	rm -rf packages/libplacebo-prefix/src/libplacebo/
	rm -rf packages/zlib-prefix/src/zlib/
	rm -rf packages/libjpeg-prefix/src/libjpeg/

	rm -rf packages/spirv-cross-prefix/src/spirv-cross/

	rm -rf packages/libarchive-prefix/src/libarchive/
	rm -rf packages/bzip2-prefix/src/bzip2/
	rm -rf packages/expat-prefix/src/expat/
	rm -rf packages/lzo-prefix/src/lzo/
	rm -rf packages/xz-prefix/src/xz/
	rm -rf packages/zlib-prefix/src/zlib/
	rm -rf packages/nettle-prefix/src/nettle/

	rm -rf packages/libass-prefix/src/libass/
	rm -rf packages/harfbuzz-prefix/src/harfbuzz/
	rm -rf packages/freetype2-prefix/src/freetype2/
	rm -rf packages/fribidi-prefix/src/fribidi/
	rm -rf packages/libiconv-prefix/src/libiconv/
	rm -rf packages/fontconfig-prefix/src/fontconfig/
fi

echo-build mpv

cd mpv-x86_64* && ls -g -o --time-style=iso *.exe
cd ../mpv-dev-x86_64-* && ls -g -o --time-style=iso *.dll

echo 'MPV Build: ' $StartTime '->' $(date '+%H:%M:%S')  >> $HOME/build_time.txt
