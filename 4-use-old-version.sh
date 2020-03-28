#!/bin/bash
# some library version may fail during build, find an old version to make it work
source $(pwd)/functions.sh

clear && echo $0 $@

bashFolder=$(pwd)

cd ~/mpv-winbuild-cmake/
#set -x #echo on

#append_option packages/mpv "mpv.git" "GIT_TAG 2858073fd03616f6fef0351256fc897352088987"

replace_option expat "R_2_4_1" "R_2_4_2"
replace_option expat "2\.4\.1" "2\.4\.2"
replace_option expat "cf032d0dba9b928636548e32b327a2d66b1aab63c4f4a13dd132c2d1d2f2fb6a" "bc2ff58f49c29aac7bff705a6c167a821f26c512079ff08ac432fd0fdc9bb199"

#replace_option packages/mpv "mpv-1.dll" "mpv-2.dll"
#sed -i '/opengl_cb\.h/d' packages/mpv.cmake

#replace_option packages/spirv-tools "GIT_SHALLOW 1" "GIT_TAG b9e255b3663c29686ef91e0d332c1ba82930bbb5"

#sed -i "s/GIT_REMOTE_NAME origin//g" packages/vulkan.cmake
#replace_option packages/vulkan "GIT_TAG main" "GIT_TAG v1.2.193"
#append_option  packages/vulkan "GIT_REPOSITORY https:\/\/github.com\/KhronosGroup\/Vulkan-Loader.git" "GIT_TAG v1.2.193"

#replace_option packages/libssh "GIT_SHALLOW 1" "GIT_TAG 1ab2340644109442f933b1fb47dee927bed29f8e"

#add_option toolchain/mingw-w64 "GIT_SHALLOW 1" "GIT_TAG v7.0.0"
#add_option packages/vulkan "GIT_REPOSITORY https:\/\/github.com\/KhronosGroup\/Vulkan-Loader.git" "GIT_TAG 3e390a15976143060eb232acc04380209f9ed08e"

#replace_option packages/glslang "GIT_SHALLOW 1" "GIT_TAG 3d935ea2243b4fffd9694191834d8573270dc869"
#replace_option packages/spirv-headers "GIT_SHALLOW 1" "GIT_TAG f836486eb164603f3c8cc7c272f4d3b953d6aa25"
#replace_option packages/spirv-tools "GIT_SHALLOW 1" "GIT_TAG d07505c761f5a0013cf3134f1d912ec775ad49c7"

#replace_option packages/spirv-headers "GIT_SHALLOW 1" "GIT_TAG 814e728b30ddd0f4509233099a3ad96fd4318c07"
#replace_option packages/spirv-tools "GIT_SHALLOW 1" "GIT_TAG 4b092d2ab81854e61632bdd1e658907f0071c37e"


#add_option packages/lcms2 "GIT_REPOSITORY https:\/\/github.com\/mm2\/Little-CMS.git" "GIT_TAG 5f7853e784d6c46d32171478248541de308137b8"

#add_option packages/shaderc "shaderc.git" "GIT_TAG v2021.1"
#add_option packages/fribidi "GIT_SHALLOW 1" "GIT_TAG v1.0.9"
#add_option packages/glslang "GIT_SHALLOW 1" "GIT_TAG 11.2.0"
#sed -i "s/https:\/\/git.xiph.org\/opus.git/https:\/\/github.com\/xiph\/opus.git/" packages/opus.cmake
#replace_option packages/libplacebo "GIT_SHALLOW 1" "GIT_TAG v4.157.0"
#replace_option packages/libplacebo "GIT_SHALLOW 1" "GIT_TAG b4c65bc361603e801d264f533d0d8f6fd702a19f"
#add_option packages/mujs "GIT_REPOSITORY" "GIT_TAG 1.0.7"

#replace_option packages/ffmpeg "GIT_SHALLOW 1" "GIT_TAG n4.4.1"
#replace_option packages/ffmpeg "GIT_SHALLOW 1" "GIT_TAG 0dcd95ef8a2e16ed930296567ab1044e33602a34"

#add_option packages/x265 "GIT_SHALLOW 1" "GIT_TAG 3ae3d711660da39af2a230f3d5856ee3a6195cd4"
#replace_option packages/freetype2 "GIT_SHALLOW 1" "GIT_TAG c5516e0f7cd0c7075381b15d3194a640f4d35ee3"

#vk_dir=/usr/share/vulkan/registry
#mkdir -p "$vk_dir" && cp /root/mpv-winbuild-cmake/build64/packages/vulkan-header-prefix/src/vulkan-header/registry/vk.xml $vk_dir/vk.xml

#sed -i "s/https:\/\/gitlab.freedesktop.org\/fontconfig\/fontconfig.git/https:\/\/github.com\/freedsktop\/fontconfig.git/" packages/fontconfig.cmake

#cp -n /root/mpv-winbuild-cmake/build64/packages/aom-prefix/src/aom/aom/aom_decoder.h /root/mpv-winbuild-cmake/build64/install/x86_64-w64-mingw32/include/aom/
#cp -n /root/mpv-winbuild-cmake/build64/packages/aom-prefix/src/aom/aom/aomdx.h /root/mpv-winbuild-cmake/build64/install/x86_64-w64-mingw32/include/aom/

#sed -i "s/-DCONFIG_AV1_DECODER=0/-DCONFIG_AV1_DECODER=1/" packages/aom.cmake
#add_option packages/fontconfig "GIT_SHALLOW 1" "GIT_TAG 2.13.92"

#sed -i "s/git:\/\/anongit.freedesktop.org\/uchardet\/uchardet/https:\/\/gitlab.freedesktop.org\/uchardet\/uchardet.git/" packages/uchardet.cmake


#sed -i "s/optimizer.RegisterVulkanToWebGPUPasses();/\/\/optimizer.RegisterVulkanToWebGPUPasses();/" build64/packages/shaderc-prefix/src/shaderc/libshaderc_util/src/spirv_tools_wrapper.cc

#sed -i "s/libressl-3.1.5.tar.gz/libressl-3.4.2.tar.gz/" packages/libressl.cmake
#sed -i "s/2c13ddcec5081c0e7ba7f93d8370a91911173090f1922007e1d90de274500494/cb82ca7d547336917352fbd23db2fc483c6c44d35157b32780214ec74197b3ce/" packages/libressl.cmake
#cp $bashFolder/libressl-0001-remove-postfix-in-libs-name.patch ./packages 
