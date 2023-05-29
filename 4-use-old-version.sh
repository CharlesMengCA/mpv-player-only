#!/bin/bash
# some library version may fail during build, find an old version to make it work
source $(pwd)/functions.sh
bashFolder=$(pwd)

clear && echo $0 $@

cd ~/mpv-winbuild-cmake/

cp -v --preserve=timestamps $bashFolder/Patch/cm-patch.sh ./packages

#set -x #echo on

replace_option mbedtls "URL https:\/\/github.com\/Mbed-TLS\/mbedtls\/archive\/refs\/tags\/v3.4.0.tar.gz" \
							  "GIT_REPOSITORY https:\/\/github.com\/Mbed-TLS\/mbedtls.git"
replace_option mbedtls "URL_HASH SHA256=1B899F355022E8D02C4D313196A0A16AF86C5A692456FA99D302915B8CF0320A" \
							  "GIT_SHALLOW 1"

if ! curl --output /dev/null --silent --head --fail "https://fossies.org/linux/misc/lzo-2.10.tar.gz"; then
	# https://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz
	replace_option lzo "fossies.org\/linux\/misc" "www.oberhumer.com\/opensource\/lzo\/download"
fi

#https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.5.tar.xz
#https://github.com/xiph/ogg/releases/download/v1.3.5/libogg-1.3.5.tar.xz
if ! curl --output /dev/null --silent --head --fail "https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.5.tar.xz"; then
	replace_option ogg "ftp.osuosl.org\/pub\/xiph\/releases\/ogg" "github.com\/xiph\/ogg\/releases\/download\/v1.3.5"
fi

#https://downloads.xiph.org/releases/vorbis/libvorbis-1.3.7.tar.xz
#https://github.com/xiph/vorbis/releases/download/v1.3.7/libvorbis-1.3.7.tar.xz
#if ! curl --output /dev/null --silent --head --fail "https://downloads.xiph.org/releases/vorbis/libvorbis-1.3.7.tar.xz"; then
	replace_option vorbis "downloads.xiph.org\/releases\/vorbis" "github.com\/xiph\/vorbis\/releases\/download\/v1.3.7"
#fi

#replace_option libxml2 "gitlab.gnome.org" "github.com"

# just for version info purpose
uncomment_line libplacebo "GIT_CLONE_FLAGS "
add_option libplacebo "GIT_CLONE_FLAGS " "GIT_SHALLOW 1"
#add_option libplacebo "GIT_CLONE_FLAGS " "GIT_TAG 541c85ec5e0e0b93a40896549c464632caab845d"
comment_line libplacebo "GIT_CLONE_FLAGS "

#replace_option glslang "GIT_TAG main" "GIT_TAG a3310b7cff7b67d2daa443c03090b4978c91384a"

#cp -v --preserve=timestamps $bashFolder/Patch/glslang-*.patch ./packages
#add_option glslang "UPDATE_COMMAND " "PATCH_COMMAND \$\{EXEC\} \$\{CMAKE_CURRENT_SOURCE_DIR\}\/cm-patch.sh"

cp -v --preserve=timestamps $bashFolder/Patch/libplacebo-*.patch ./packages
add_option libplacebo "UPDATE_COMMAND " "PATCH_COMMAND \$\{EXEC\} \$\{CMAKE_CURRENT_SOURCE_DIR\}\/cm-patch.sh"

#cp -v --preserve=timestamps $bashFolder/Patch/ffmpeg-*.patch ./packages
#add_option ffmpeg "UPDATE_COMMAND " "PATCH_COMMAND \$\{EXEC\} \$\{CMAKE_CURRENT_SOURCE_DIR\}\/cm-patch.sh"

#cp -v --preserve=timestamps $bashFolder/Patch/mpv-*.patch ./packages


#add_option glslang "UPDATE_COMMAND " "PATCH_COMMAND \$\{EXEC\} git am --3way \$\{CMAKE_CURRENT_SOURCE_DIR\}\/glslang*.patch"



#uncomment_line libplacebo "GIT_CLONE_FLAGS "
#add_option libplacebo "GIT_CLONE_FLAGS " "GIT_TAG 1a99e806be26038985be0638bbc80c0db1a00796"
#comment_line libplacebo "GIT_CLONE_FLAGS "

#add_option mpv "SOURCE_DIR " "GIT_TAG dcc9bc5deab932be8b4a743326f48b25ba2cbe84"
#add_option mpv "SOURCE_DIR " "GIT_TAG v0.35.0"

#add_option glslang "UPDATE_COMMAND " "GIT_REMOTE_NAME origin"
#add_option glslang "UPDATE_COMMAND " "GIT_TAG main"

#replace_option vulkan-header "GIT_TAG main" "GIT_TAG e8b8e06d092ab406b097907ecaae1a8aae9c7d53"
#replace_option vulkan-header "GIT_TAG main" "GIT_TAG v1.3.240"
#replace_option vulkan "GIT_TAG main" "GIT_TAG v1.3.240"

#comment_line vulkan-header "GIT_SHALLOW 1"
#add_option vulkan-header "UPDATE_COMMAND " "PATCH_COMMAND \$\{EXEC\} git checkout 18963a6cc03fe15e3785d353dea6a1ff95115a5e"
#cp -v --preserve=timestamps $bashFolder/Patch/ffmpeg-0001-Vulkan-Headers-v1.3.238.patch ./packages
#add_option ffmpeg "UPDATE_COMMAND " "PATCH_COMMAND \$\{EXEC\} git am --3way \$\{CMAKE_CURRENT_SOURCE_DIR\}\/ffmpeg-*.patch"

#delete_line ffmpeg "PATCH_COMMAND "

#cp -v --preserve=timestamps $bashFolder/Patch/new/vulkan-*.patch ./packages


#comment_line ffmpeg "GIT_TAG c8e9cc8d2096abda1bce99915ec1fdeff18f2fe2"
#replace_option ffmpeg "GIT_TAG c8e9cc8d2096abda1bce99915ec1fdeff18f2fe2" "PATCH_COMMAND \$\{EXEC\} patch -p1 < \$\{CMAKE_CURRENT_SOURCE_DIR\}\/o0ot.diff"
#replace_option ffmpeg "GIT_SHALLOW 1" "GIT_TAG n4.4.1"



#https://github.com/GPUOpen-LibrariesAndSDKs/AMF/trunk/amf/public/include
#https://github.com/GPUOpen-LibrariesAndSDKs/AMF.git
#replace_option amf-headers "SVN_REPOSITORY " "GIT_REPOSITORY "
#replace_option amf-headers "\/trunk\/amf\/public\/include " ".git"

#replace_option vulkan "GIT_SHALLOW 1" "GIT_TAG 5035e37bf6bf6cf4b0c6cf7956c63b0522d69ab9"

#replace_option zlib "github.com\/madler\/zlib\/archive\/refs\/tags\/v1.2.12.tar.gz" \
#						  "zlib.net\/zlib-1.2.13.tar.gz"

#replace_option zlib "d8688496ea40fb61787500e863cc63c9afcbc524468cedeb478068924eb54932" \
#						  "b3a24de97a8fdbc835b9833169501030b8977031bcb54b3b3ac13740f846ab30"

#cp $bashFolder/Patch/zlib-1-win32-static.patch ./packages

#replace_option x265 "GIT_REPOSITORY https:\/\/bitbucket.org\/multicoreware\/x265_git.git" \
#                    "URL https:\/\/bitbucket.org\/multicoreware\/x265_git\/get\/931178347b3f.zip"

#replace_option expat "R_2_4_9" "R_2_5_0"
#replace_option expat "2\.4\.9" "2\.5\.0"
#replace_option expat "6e8c0728fe5c7cd3f93a6acce43046c5e4736c7b4b68e032e9350daa0efc0354" \
#							"ef2420f0232c087801abf705e89ae65f6257df6b7931d37846a193ef2e8cdcbe"

#comment_line libjxl "PATCH_COMMAND"

#cp $bashFolder/libssh-0001-install-modified-pc-file.patch ./packages



#append_option mpv "--prefer-static" "-Dbuild-date=true"

#replace_option vulkan-header "GIT_TAG main" "GIT_TAG v1.3.224"

#broken on debd0ea4d38c4ce93ad4cbbfabead9f47918ffae
#replace_option libssh "GIT_SHALLOW 1" "GIT_TAG d30cf11cb652f596709366ec7c299dbff11862f1"

#cp $bashFolder/libssh-0003-Fix-Update-HMAC-function-parameter-type.patch ./packages

#add_option mbedtls "cleanup(mbedtls install)" "force_rebuild_git(mbedtls)"

#comment_line libzimg "GIT_SHALLOW 1"

#replace_option libzimg "GIT_SHALLOW 1" "GIT_TAG 51c3c7f750c2af61955377faad56e3ba1b03589f"

#replace_option libiconv "1.16" "1.17"
#replace_option libiconv "e6a1b1b589654277ee790cce3734f07876ac4ccfaecbee8afa0b649cf529cc04" \
#							   "8f74213b56238c85a50a5329f77e06198771e70dd9a739779f4c02f65d971313"

#replace_option libmfx "COMMAND mv libmfx.pc mfx.pc" "COMMAND cp -u libmfx.pc mfx.pc"

#sed -i "/https:\/\/github.com\/KhronosGroup\/Vulkan-Loader.git/!b;n;c\    GIT_TAG edc995aef7a8bbb00bbff9b18ab267de53815292" packages/vulkan.cmake

#replace next line https://stackoverflow.com/questions/18620153/find-matching-text-and-replace-next-line

#replace_option lame "GIT_REPOSITORY https:\/\/salsa.debian.org\/multimedia-team\/lame.git" \
#							"URL \"https:\/\/downloads.sourceforge.net\/project\/lame\/lame\/3.100\/lame-3.100.tar.gz\""

#comment_line lame "force_rebuild_git(lame)"

#sed -i '/opengl_cb\.h/d' mpv.cmake

#add_option toolchain/mingw-w64 "GIT_SHALLOW 1" "GIT_TAG v7.0.0"

#sed -i "s/https:\/\/git.xiph.org\/opus.git/https:\/\/github.com\/xiph\/opus.git/" opus.cmake
#add_option mujs "GIT_REPOSITORY" "GIT_TAG 1.0.7"

#vk_dir=/usr/share/vulkan/registry
#mkdir -p "$vk_dir" && cp /root/mpv-winbuild-cmake/build64/vulkan-header-prefix/src/vulkan-header/registry/vk.xml $vk_dir/vk.xml

#sed -i "s/https:\/\/gitlab.freedesktop.org\/fontconfig\/fontconfig.git/https:\/\/github.com\/freedsktop\/fontconfig.git/" fontconfig.cmake

#cp -n /root/mpv-winbuild-cmake/build64/aom-prefix/src/aom/aom/aom_decoder.h /root/mpv-winbuild-cmake/build64/install/x86_64-w64-mingw32/include/aom/
#cp -n /root/mpv-winbuild-cmake/build64/aom-prefix/src/aom/aom/aomdx.h /root/mpv-winbuild-cmake/build64/install/x86_64-w64-mingw32/include/aom/

#sed -i "s/-DCONFIG_AV1_DECODER=0/-DCONFIG_AV1_DECODER=1/" aom.cmake

#sed -i "s/git:\/\/anongit.freedesktop.org\/uchardet\/uchardet/https:\/\/gitlab.freedesktop.org\/uchardet\/uchardet.git/" uchardet.cmake

#sed -i "s/optimizer.RegisterVulkanToWebGPUPasses();/\/\/optimizer.RegisterVulkanToWebGPUPasses();/" build64/shaderc-prefix/src/shaderc/libshaderc_util/src/spirv_tools_wrapper.cc
