#!/bin/bash
source $(pwd)/functions.sh
SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

clear && echo $0 $@

sudo pacman -S --needed --noconfirm docker git docker-buildx
#systemctl enable docker.service
sudo systemctl start docker.service

cd ..
git config --global user.email "CharlesMeng@outlook.com"
git config --global user.name "CharlesMengCA"
#git config --global init.defaultBranch master

git clone https://github.com/BtbN/FFmpeg-Builds.git
#git clone https://github.com/CharlesMengCA/FFmpeg-Builds.git

cd FFmpeg-Builds

#mkdir -p .cache/downloads
#cp -v $SCRIPT_DIR/Patch/50-xvid_71fdbd375fd4dc6730046ee5ef8892d278115f362302c99911232e5db4bc8105.tar.xz .cache/downloads
#cd .cache/downloads
#ln -s 50-xvid_71fdbd375fd4dc6730046ee5ef8892d278115f362302c99911232e5db4bc8105.tar.xz 50-xvid.tar.xz
#cd ../.. 

sed -i "\#/configure#i \    sed -i 's/FFMPEG_CONFIGURATION=\"/[ -z \"\\\\\${l}\" ] \\\&\\\& FFMPEG_CONFIGURATION=\"/g' configure" build.sh
sed -i "s/rm -rf ffbuild/#rm -rf ffbuild/g" build.sh

#git am $SCRIPT_DIR/ffmpeg/0001-Disable-linux-related.patch

# VA-API - Supported on Intel, AMD, and NVIDIA (only via the open-source Nouveau drivers). 
# Widely supported by software, including Kodi, VLC, MPV, Chromium, and Firefox. 
# Main limitation is lacking any support in the proprietary NVIDIA drivers.
rm scripts.d/50-vaapi/50-libva.sh

rm scripts.d/50-openmpt.sh
rm scripts.d/50-kvazaar.sh
rm scripts.d/50-aribb24/50-libaribb24.sh
rm scripts.d/50-libaribcaption.sh

#cp -v $SCRIPT_DIR/ffmpeg/60-libplacebo.sh scripts.d/50-vulkan/

git status

[[ $1 == "config" ]] && exit

set -x #echo on
#sed -i "s/--branch='\\\$GIT_BRANCH'/--branch='n5.1.2'/g" build.sh
echo 'Start: ' $(date '+%H:%M:%S') > ../build_time.txt

./makeimage.sh win64 gpl-shared 7.1
./build.sh win64 gpl-shared 7.1

echo 'Done: ' $(date '+%H:%M:%S') >> ../build_time.txt
#./makeimage.sh win64 gpl-shared
#./build.sh win64 gpl-shared

#source=$(find ffbuild/pkgroot -type d -name 'ffmpeg-*win64*')
#target=$(echo $source | sed 's/^.*pkgroot\/\(.*shared\).*$/\1/')
#cp -r -v $source/bin $SCRIPT_DIR/../$target/
