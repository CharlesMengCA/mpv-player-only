#!/bin/bash
# some library version may fail during build, find an old version to make it work
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
source $SCRIPT_DIR/functions.sh

[[ $1 == "" ]] && clear
echo_info $0 $@

cd ~/mpv-winbuild-cmake/

#git am --3way $SCRIPT_DIR/Patch/libmpv.patch

append_option libva "--buildtype=release" "-Db_ndebug=true"
append_option dav1d "--buildtype=release" "-Db_ndebug=true"
append_option fribidi "--buildtype=release" "-Db_ndebug=true"
append_option harfbuzz "--buildtype=release" "-Db_ndebug=true"
append_option freetype2 "--buildtype=release" "-Db_ndebug=true"
append_option fontconfig "--buildtype=release" "-Db_ndebug=true"
append_option rubberband "--buildtype=release" "-Db_ndebug=true"

#replace_option rustup "cargo-c --profile" "cargo-c --path \/home\/cm\/cargo-c --profile"

#set -x #echo on

comment_line libarchive " openssl"
replace_option libarchive "-DENABLE_OPENSSL=ON" "-DENABLE_OPENSSL=OFF"

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
#add_option libvpl "UPDATE_COMMAND " "GIT_TAG main"
#add_option libvpl "UPDATE_COMMAND " "GIT_REMOTE_NAME origin"

#replace_option libiconv "ftp.gnu.org\/pub\/gnu\/libiconv" "fossies.org\/linux\/misc"

#replace_option fontconfig "gitlab.freedesktop.org\/fontconfig" "gitlab.com\/freedesktop-sdk\/mirrors\/freedesktop\/tagoh"
#replace_option libxml2 "gitlab.gnome.org" "github.com"

# just for version info purpose
replace_option libplacebo "GIT_CLONE_FLAGS \"--filter=tree:0\"" "GIT_SHALLOW 1"
#replace_option libplacebo "haasn" "CharlesMengCA"
cp -v --preserve=timestamps $SCRIPT_DIR/Patch/libplacebo-version.sh ./packages
add_option libplacebo "UPDATE_COMMAND " "PATCH_COMMAND \$\{EXEC\} \$\{CMAKE_CURRENT_SOURCE_DIR\}\/libplacebo-version.sh"

#comment_line openssl "PATCH_COMMAND "

replace_option luajit "CFLAGS='-DUNICODE'" "CFLAGS='-D_WIN32_WINNT=0x0602 -DUNICODE'"
#append_option mingw-w64 "GIT_CLONE_FLAGS " "GIT_RESET 5ccc975a43c4f839063b4cd5be7fe9f081378b93"

#append_option llvm "GIT_TAG release\/18.x" "GIT_RESET c13b7485b87909fcf739f62cfa382b55407433c0"

#cp -v --preserve=timestamps $SCRIPT_DIR/Patch/new/fontconfig-*.patch ./packages

#comment_line ffmpeg "PATCH_COMMAND "
#replace_option ffmpeg "GIT_SHALLOW 1" "GIT_RESET 97d2990ea6241a569bc4c259d427f7739c97d766"

#lavc/ac3dsp: R-V V min_exponents
#replace_option ffmpeg "GIT_SHALLOW 1" "GIT_RESET 38f67a32b3831c8dd0b34db888c16d4a7af9091c"

#append_option mpv "GIT_CLONE_FLAGS " "GIT_RESET 1586ccc0c86ab23aad9e3f4b2b5986574ce266a7"

#cp -v --preserve=timestamps $SCRIPT_DIR/Patch/ffmpeg-*.patch ./packages
#append_option ffmpeg "GIT_SHALLOW 1" "PATCH_COMMAND \$\{EXEC\} git apply \$\{CMAKE_CURRENT_SOURCE_DIR\}\/ffmpeg-*.patch"

#append_option spirv-headers "GIT_TAG main" "GIT_RESET fbf2402"

#cp -v --preserve=timestamps $SCRIPT_DIR/Patch/openssl-*.patch ./packages
#add_option openssl "UPDATE_COMMAND " "PATCH_COMMAND \$\{EXEC\} \$\{CMAKE_CURRENT_SOURCE_DIR\}\/cm-patch.sh"

#cp -v --preserve=timestamps $SCRIPT_DIR/Patch/glslang-*.patch ./packages
#add_option glslang "UPDATE_COMMAND " "PATCH_COMMAND \$\{EXEC\} \$\{CMAKE_CURRENT_SOURCE_DIR\}\/cm-patch.sh"

#replace_option mingw-w64-crt "--with-default-msvcrt=msvcrt-os" "--with-default-msvcrt=ucrt"
#replace_option mingw-w64-headers "--with-default-msvcrt=msvcrt" "--with-default-msvcrt=ucrt"

#add_option shaderc "UPDATE_COMMAND " "PATCH_COMMAND \$\{EXEC\} \$\{CMAKE_CURRENT_SOURCE_DIR\}\/cm-patch.sh"
#cp -v --preserve=timestamps $SCRIPT_DIR/Patch/shaderc-*.patch ./packages

#append_option shaderc "GIT_TAG main" "GIT_RESET e6187c722e96ca87240b515071ea9cb8d180f45d"
#append_option shaderc "-DENABLE_GLSLANG_BINARIES=OFF" "-DSKIP_GLSLANG_INSTALL=ON"

#cp -v --preserve=timestamps $SCRIPT_DIR/Patch/vulkan-*.patch ./packages
#cp -v --preserve=timestamps $SCRIPT_DIR/Patch/new/vulkan-*.patch ./packages

#cp -v --preserve=timestamps $SCRIPT_DIR/Patch/ffmpeg-*.patch ./packages
#add_option ffmpeg "UPDATE_COMMAND " "PATCH_COMMAND \$\{EXEC\} \$\{CMAKE_CURRENT_SOURCE_DIR\}\/cm-patch.sh"

cp -v --preserve=timestamps $SCRIPT_DIR/Patch/mpv-*.patch ./packages

#delete_line mpv "mpv.def"

#add_option glslang "UPDATE_COMMAND " "PATCH_COMMAND \$\{EXEC\} git am --3way \$\{CMAKE_CURRENT_SOURCE_DIR\}\/glslang*.patch"

#comment_line vulkan-header "GIT_SHALLOW 1"
#add_option vulkan-header "UPDATE_COMMAND " "PATCH_COMMAND \$\{EXEC\} git checkout 18963a6cc03fe15e3785d353dea6a1ff95115a5e"
append_option vulkan-header "-DBUILD_SHARED_LIBS=OFF" "-DVULKAN_HEADERS_ENABLE_MODULE=OFF"

#https://github.com/GPUOpen-LibrariesAndSDKs/AMF/trunk/amf/public/include
#https://github.com/GPUOpen-LibrariesAndSDKs/AMF.git
#replace_option amf-headers "SVN_REPOSITORY " "GIT_REPOSITORY "
#replace_option amf-headers "\/trunk\/amf\/public\/include " ".git"


#replace_option zlib "github.com\/madler\/zlib\/archive\/refs\/tags\/v1.2.12.tar.gz" \
#						  "zlib.net\/zlib-1.2.13.tar.gz"

#replace_option zlib "d8688496ea40fb61787500e863cc63c9afcbc524468cedeb478068924eb54932" \
#						  "b3a24de97a8fdbc835b9833169501030b8977031bcb54b3b3ac13740f846ab30"

#cp $SCRIPT_DIR/Patch/zlib-1-win32-static.patch ./packages

#replace_option x265 "GIT_REPOSITORY https:\/\/bitbucket.org\/multicoreware\/x265_git.git" \
#                    "URL https:\/\/bitbucket.org\/multicoreware\/x265_git\/get\/931178347b3f.zip"

#replace_option expat "R_2_4_9" "R_2_5_0"
#replace_option expat "2\.4\.9" "2\.5\.0"
#replace_option expat "6e8c0728fe5c7cd3f93a6acce43046c5e4736c7b4b68e032e9350daa0efc0354" \
#							"ef2420f0232c087801abf705e89ae65f6257df6b7931d37846a193ef2e8cdcbe"

#comment_line libjxl "PATCH_COMMAND"

#cp $SCRIPT_DIR/libssh-0001-install-modified-pc-file.patch ./packages

#append_option mpv "--prefer-static" "-Dbuild-date=true"


#cp $SCRIPT_DIR/libssh-0003-Fix-Update-HMAC-function-parameter-type.patch ./packages

#comment_line libzimg "GIT_SHALLOW 1"


#replace_option libmfx "COMMAND mv libmfx.pc mfx.pc" "COMMAND cp -u libmfx.pc mfx.pc"


#replace next line https://stackoverflow.com/questions/18620153/find-matching-text-and-replace-next-line

#replace_option lame "GIT_REPOSITORY https:\/\/salsa.debian.org\/multimedia-team\/lame.git" \
#							"URL \"https:\/\/downloads.sourceforge.net\/project\/lame\/lame\/3.100\/lame-3.100.tar.gz\""

#comment_line lame "force_rebuild_git(lame)"

#sed -i '/opengl_cb\.h/d' mpv.cmake
#sed -i "s/https:\/\/git.xiph.org\/opus.git/https:\/\/github.com\/xiph\/opus.git/" opus.cmake

#vk_dir=/usr/share/vulkan/registry
#mkdir -p "$vk_dir" && cp /root/mpv-winbuild-cmake/build64/vulkan-header-prefix/src/vulkan-header/registry/vk.xml $vk_dir/vk.xml

#sed -i "s/https:\/\/gitlab.freedesktop.org\/fontconfig\/fontconfig.git/https:\/\/github.com\/freedsktop\/fontconfig.git/" fontconfig.cmake

#cp -n /root/mpv-winbuild-cmake/build64/aom-prefix/src/aom/aom/aom_decoder.h /root/mpv-winbuild-cmake/build64/install/x86_64-w64-mingw32/include/aom/
#cp -n /root/mpv-winbuild-cmake/build64/aom-prefix/src/aom/aom/aomdx.h /root/mpv-winbuild-cmake/build64/install/x86_64-w64-mingw32/include/aom/

#sed -i "s/-DCONFIG_AV1_DECODER=0/-DCONFIG_AV1_DECODER=1/" aom.cmake

#sed -i "s/git:\/\/anongit.freedesktop.org\/uchardet\/uchardet/https:\/\/gitlab.freedesktop.org\/uchardet\/uchardet.git/" uchardet.cmake

#sed -i "s/optimizer.RegisterVulkanToWebGPUPasses();/\/\/optimizer.RegisterVulkanToWebGPUPasses();/" build64/shaderc-prefix/src/shaderc/libshaderc_util/src/spirv_tools_wrapper.cc
