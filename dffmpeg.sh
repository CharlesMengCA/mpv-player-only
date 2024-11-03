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

git clone https://github.com/BtbN/FFmpeg-Builds.git
#git clone https://github.com/CharlesMengCA/FFmpeg-Builds.git

cd FFmpeg-Builds

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

./makeimage.sh win64 gpl-shared 7.0
./build.sh win64 gpl-shared 7.0

#./makeimage.sh win64 gpl-shared
#./build.sh win64 gpl-shared

#source=$(find ffbuild/pkgroot -type d -name 'ffmpeg-*win64*')
#target=$(echo $source | sed 's/^.*pkgroot\/\(.*shared\).*$/\1/')
#cp -r -v $source/bin $SCRIPT_DIR/../$target/
