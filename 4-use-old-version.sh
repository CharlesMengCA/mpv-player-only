#!/bin/bash
# some library version may fail during build, find an old version to make it work
source $(pwd)/functions.sh

clear && echo $0 $@

bashFolder=$(pwd)

cd ~/mpv-winbuild-cmake/
#set -x #echo on

#append_option mpv "mpv.git" "GIT_TAG 2858073fd03616f6fef0351256fc897352088987"

replace_option expat "R_2_4_1" "R_2_4_6"
replace_option expat "2\.4\.1" "2\.4\.6"
replace_option expat "cf032d0dba9b928636548e32b327a2d66b1aab63c4f4a13dd132c2d1d2f2fb6a" \
							"de55794b7a9bc214852fdc075beaaecd854efe1361597e6268ee87946951289b"

#replace_option lame "GIT_REPOSITORY https:\/\/salsa.debian.org\/multimedia-team\/lame.git" \
#							"URL \"https:\/\/downloads.sourceforge.net\/project\/lame\/lame\/3.100\/lame-3.100.tar.gz\""

#comment_line lame "force_rebuild_git(lame)"

#replace_option libarchive "GIT_SHALLOW 1" "GIT_TAG 3665c7587d6561f0209da1716f86fbebb9a26778"

#replace_option ffmpeg "GIT_SHALLOW 1" "GIT_TAG n4.4.1"
#replace_option ffmpeg "GIT_SHALLOW 1" "GIT_TAG a88a141c1791b448f2c327e6bdd9491a4439efc2"
#replace_option ffmpeg "GIT_TAG a88a141c1791b448f2c327e6bdd9491a4439efc2" "GIT_SHALLOW 1"

#replace_option mpv "mpv-1.dll" "mpv-2.dll"
#sed -i '/opengl_cb\.h/d' mpv.cmake

#replace_option spirv-tools "GIT_SHALLOW 1" "GIT_TAG b9e255b3663c29686ef91e0d332c1ba82930bbb5"

#sed -i "s/GIT_REMOTE_NAME origin//g" vulkan.cmake
#replace_option vulkan "GIT_TAG main" "GIT_TAG v1.2.193"
#append_option  vulkan "GIT_REPOSITORY https:\/\/github.com\/KhronosGroup\/Vulkan-Loader.git" "GIT_TAG v1.2.193"

#replace_option libssh "GIT_SHALLOW 1" "GIT_TAG 1ab2340644109442f933b1fb47dee927bed29f8e"

#add_option toolchain/mingw-w64 "GIT_SHALLOW 1" "GIT_TAG v7.0.0"
#add_option vulkan "GIT_REPOSITORY https:\/\/github.com\/KhronosGroup\/Vulkan-Loader.git" "GIT_TAG 3e390a15976143060eb232acc04380209f9ed08e"

#replace_option glslang "GIT_SHALLOW 1" "GIT_TAG 3d935ea2243b4fffd9694191834d8573270dc869"
#replace_option spirv-headers "GIT_SHALLOW 1" "GIT_TAG f836486eb164603f3c8cc7c272f4d3b953d6aa25"
#replace_option spirv-tools "GIT_SHALLOW 1" "GIT_TAG d07505c761f5a0013cf3134f1d912ec775ad49c7"

#replace_option spirv-headers "GIT_SHALLOW 1" "GIT_TAG 814e728b30ddd0f4509233099a3ad96fd4318c07"
#replace_option spirv-tools "GIT_SHALLOW 1" "GIT_TAG 4b092d2ab81854e61632bdd1e658907f0071c37e"


#add_option lcms2 "GIT_REPOSITORY https:\/\/github.com\/mm2\/Little-CMS.git" "GIT_TAG 5f7853e784d6c46d32171478248541de308137b8"

#add_option shaderc "shaderc.git" "GIT_TAG v2021.1"
#add_option fribidi "GIT_SHALLOW 1" "GIT_TAG v1.0.9"
#add_option glslang "GIT_SHALLOW 1" "GIT_TAG 11.2.0"
#sed -i "s/https:\/\/git.xiph.org\/opus.git/https:\/\/github.com\/xiph\/opus.git/" opus.cmake
#replace_option libplacebo "GIT_SHALLOW 1" "GIT_TAG v4.157.0"
#replace_option libplacebo "GIT_SHALLOW 1" "GIT_TAG b4c65bc361603e801d264f533d0d8f6fd702a19f"
#add_option mujs "GIT_REPOSITORY" "GIT_TAG 1.0.7"


#add_option x265 "GIT_SHALLOW 1" "GIT_TAG 3ae3d711660da39af2a230f3d5856ee3a6195cd4"
#replace_option freetype2 "GIT_SHALLOW 1" "GIT_TAG c5516e0f7cd0c7075381b15d3194a640f4d35ee3"

#vk_dir=/usr/share/vulkan/registry
#mkdir -p "$vk_dir" && cp /root/mpv-winbuild-cmake/build64/vulkan-header-prefix/src/vulkan-header/registry/vk.xml $vk_dir/vk.xml

#sed -i "s/https:\/\/gitlab.freedesktop.org\/fontconfig\/fontconfig.git/https:\/\/github.com\/freedsktop\/fontconfig.git/" fontconfig.cmake

#cp -n /root/mpv-winbuild-cmake/build64/aom-prefix/src/aom/aom/aom_decoder.h /root/mpv-winbuild-cmake/build64/install/x86_64-w64-mingw32/include/aom/
#cp -n /root/mpv-winbuild-cmake/build64/aom-prefix/src/aom/aom/aomdx.h /root/mpv-winbuild-cmake/build64/install/x86_64-w64-mingw32/include/aom/

#sed -i "s/-DCONFIG_AV1_DECODER=0/-DCONFIG_AV1_DECODER=1/" aom.cmake
#add_option fontconfig "GIT_SHALLOW 1" "GIT_TAG 2.13.92"

#sed -i "s/git:\/\/anongit.freedesktop.org\/uchardet\/uchardet/https:\/\/gitlab.freedesktop.org\/uchardet\/uchardet.git/" uchardet.cmake


#sed -i "s/optimizer.RegisterVulkanToWebGPUPasses();/\/\/optimizer.RegisterVulkanToWebGPUPasses();/" build64/shaderc-prefix/src/shaderc/libshaderc_util/src/spirv_tools_wrapper.cc

#sed -i "s/libressl-3.1.5.tar.gz/libressl-3.4.2.tar.gz/" libressl.cmake
#sed -i "s/2c13ddcec5081c0e7ba7f93d8370a91911173090f1922007e1d90de274500494/cb82ca7d547336917352fbd23db2fc483c6c44d35157b32780214ec74197b3ce/" libressl.cmake
#cp $bashFolder/libressl-0001-remove-postfix-in-libs-name.patch ./packages 
