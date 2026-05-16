#!/bin/bash
[ "$EUID" -ne 0 ] && exec su -c "$0 $*"

#disable_lib() { echo $1; rm $1; }
#disable_lib() { sed -i 's/return 0/return -1/g' "$1"; }
#disable_lib() { echo $1; sed -i '/^ffbuild_enabled[[:space:]]*()[[:space:]]*{/,/^[[:space:]]*}/ s/return 0/return -1/g' $1; }
disable_lib() { echo $1; sed -i '/^ffbuild_configure[[:space:]]*()[[:space:]]*{/,/^[[:space:]]*}/ s/echo --enable-/echo --disable-/g' $1; }

SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
RELEASE_BRANCH=8.1

clear && echo $0 $@

sudo pacman -S --needed --noconfirm docker git docker-buildx
#systemctl enable docker.service
sudo systemctl start docker.service

cd ..
git config --global user.email "CharlesMeng@outlook.com"
git config --global user.name "CharlesMengCA"
#git config --global init.defaultBranch master
rm -rf FFmpeg

git clone -b release/$RELEASE_BRANCH --single-branch https://github.com/FFmpeg/FFmpeg.git --depth=1
cd FFmpeg

git apply --check $SCRIPT_DIR/ffmpeg/Patchs/ffmpeg-*.$RELEASE_BRANCH.patch || exit

cd ..
rm -rf FFmpeg
rm -rf FFmpeg-Builds

git clone https://github.com/BtbN/FFmpeg-Builds.git
#git clone https://github.com/CharlesMengCA/FFmpeg-Builds.git

cd FFmpeg-Builds
#git checkout 55c2e7a2278cc1bb2f4040abe7f873e77f09e7e5
git apply $SCRIPT_DIR/ffmpeg/Patchs/BtbN-0001-Allow-extra-patches.patch

cd patches
mkdir ffmpeg
cp -v $SCRIPT_DIR/ffmpeg/Patchs/ffmpeg-0001-Revert-extension_picky.$RELEASE_BRANCH.patch ffmpeg
cd ..

mkdir -p .cache/downloads
cp -v $SCRIPT_DIR/Patch/50-xvid_71fdbd375fd4dc6730046ee5ef8892d278115f362302c99911232e5db4bc8105.tar.xz .cache/downloads
cd .cache/downloads
ln -s 50-xvid_71fdbd375fd4dc6730046ee5ef8892d278115f362302c99911232e5db4bc8105.tar.xz 50-xvid.tar.xz
cd ../.. 

sed -i "\#/configure#i \    sed -i 's/FFMPEG_CONFIGURATION=\"/[ -z \"\\\\\${l}\" ] \\\&\\\& FFMPEG_CONFIGURATION=\"/g' configure" build.sh
sed -i "s/rm -rf ffbuild/#rm -rf ffbuild/g" build.sh

sed -i "s#git.savannah.gnu.org/git/libiconv.git#skia.googlesource.com/third_party/libiconv#g" scripts.d/20-libiconv.sh
sed -i "s#git.savannah.gnu.org/git/gnulib.git#github.com/coreutils/gnulib.git#g" scripts.d/20-libiconv.sh

#git am $SCRIPT_DIR/ffmpeg/0001-Disable-linux-related.patch

# VA-API - Supported on Intel, AMD, and NVIDIA (only via the open-source Nouveau drivers). 
# Widely supported by software, including Kodi, VLC, MPV, Chromium, and Firefox. 
# Main limitation is lacking any support in the proprietary NVIDIA drivers.
disable_lib scripts.d/50-vaapi/50-libva.sh

disable_lib scripts.d/50-openmpt.sh
disable_lib scripts.d/50-kvazaar.sh
disable_lib scripts.d/50-aribb24/50-libaribb24.sh
disable_lib scripts.d/50-libaribcaption.sh

#cp -v $SCRIPT_DIR/ffmpeg/60-libplacebo.sh scripts.d/50-vulkan/

git status > ff_build_change_log.txt

[[ $1 == "config" ]] && exit

set -x #echo on
#sed -i "s/--branch='\\\$GIT_BRANCH'/--branch='n5.1.2'/g" build.sh
echo 'Start: ' $(date '+%H:%M:%S') > ../build_time.txt

./makeimage.sh win64 gpl-shared $RELEASE_BRANCH
./build.sh win64 gpl-shared $RELEASE_BRANCH

echo 'Done: ' $(date '+%H:%M:%S') >> ../build_time.txt
#./makeimage.sh win64 gpl-shared
#./build.sh win64 gpl-shared

#source=$(find ffbuild/pkgroot -type d -name 'ffmpeg-*win64*')
#target=$(echo $source | sed 's/^.*pkgroot\/\(.*shared\).*$/\1/')
#cp -r -v $source/bin $SCRIPT_DIR/../$target/
