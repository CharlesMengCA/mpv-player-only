#!/bin/bash
clear
echo $0 $@

# some library version may fail during build, find an old version to make it work

set -x #echo on

add_option () {
  if ! grep -- "$3" $1.cmake; then
   sed -i "/$2/a \    $3" $1.cmake
 fi
}


cd ~/mpv-winbuild-cmake/

#add_option toolchain/mingw-w64 "GIT_SHALLOW 1" "GIT_TAG v7.0.0"
#add_option packages/vulkan "GIT_REPOSITORY https:\/\/github.com\/KhronosGroup\/Vulkan-Loader.git" "GIT_TAG 3e390a15976143060eb232acc04380209f9ed08e"
#add_option packages/vulkan "GIT_REPOSITORY https:\/\/github.com\/KhronosGroup\/Vulkan-Loader.git" "GIT_TAG v1.2.161"
#add_option packages/vulkan "GIT_REPOSITORY https:\/\/github.com\/KhronosGroup\/Vulkan-Headers.git" "GIT_TAG v1.2.165"

#add_option packages/lcms2 "GIT_REPOSITORY https:\/\/github.com\/mm2\/Little-CMS.git" "GIT_TAG 5f7853e784d6c46d32171478248541de308137b8"

#add_option packages/shaderc "shaderc.git" "GIT_TAG v2020.1"
#add_option packages/fribidi "GIT_SHALLOW 1" "GIT_TAG v1.0.9"
#add_option packages/glslang "GIT_SHALLOW 1" "GIT_TAG 8.13.3743"
#sed -i "s/https:\/\/git.xiph.org\/opus.git/https:\/\/github.com\/xiph\/opus.git/" packages/opus.cmake
#add_option packages/libplacebo "GIT_SHALLOW 1" "GIT_TAG v2.43.1"
add_option packages/ffmpeg "GIT_SHALLOW 1" "GIT_TAG n4.3.2"
#add_option packages/mujs "GIT_REPOSITORY" "GIT_TAG 1.0.7"

#add_option packages/x265 "GIT_SHALLOW 1" "GIT_TAG 3ae3d711660da39af2a230f3d5856ee3a6195cd4"

#vk_dir=/usr/share/vulkan/registry
#mkdir -p "$vk_dir" && cp /root/mpv-winbuild-cmake/build64/packages/vulkan-header-prefix/src/vulkan-header/registry/vk.xml $vk_dir/vk.xml

#sed -i "s/https:\/\/gitlab.freedesktop.org\/fontconfig\/fontconfig.git/https:\/\/github.com\/freedsktop\/fontconfig.git/" packages/fontconfig.cmake

#cp -n /root/mpv-winbuild-cmake/build64/packages/aom-prefix/src/aom/aom/aom_decoder.h /root/mpv-winbuild-cmake/build64/install/x86_64-w64-mingw32/include/aom/
#cp -n /root/mpv-winbuild-cmake/build64/packages/aom-prefix/src/aom/aom/aomdx.h /root/mpv-winbuild-cmake/build64/install/x86_64-w64-mingw32/include/aom/

#sed -i "s/-DCONFIG_AV1_DECODER=0/-DCONFIG_AV1_DECODER=1/" packages/aom.cmake
#add_option packages/fontconfig "GIT_SHALLOW 1" "GIT_TAG 2.13.92"
#

#sed -i "s/git:\/\/anongit.freedesktop.org\/uchardet\/uchardet/https:\/\/gitlab.freedesktop.org\/uchardet\/uchardet.git/" packages/uchardet.cmake


#sed -i "s/optimizer.RegisterVulkanToWebGPUPasses();/\/\/optimizer.RegisterVulkanToWebGPUPasses();/" build64/packages/shaderc-prefix/src/shaderc/libshaderc_util/src/spirv_tools_wrapper.cc

