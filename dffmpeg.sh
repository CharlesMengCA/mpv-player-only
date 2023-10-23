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

if [[ $1 == "config" ]]; then
   exit
fi

cd FFmpeg-Builds

git am $SCRIPT_DIR/ffmpeg/0001-Disable-linux-related.patch

rm scripts.d/50-openmpt.sh
rm scripts.d/50-kvazaar.sh
rm scripts.d/50-aribb24/50-libaribb24.sh

#cp -v $SCRIPT_DIR/ffmpeg/60-libplacebo.sh scripts.d/50-vulkan/

git status

set -x #echo on
#sed -i "s/--branch='\\\$GIT_BRANCH'/--branch='n5.1.2'/g" build.sh

./makeimage.sh win64 gpl-shared 6.0
./build.sh win64 gpl-shared 6.0

#./makeimage.sh win64 gpl-shared
#./build.sh win64 gpl-shared

#source=$(find ffbuild/pkgroot -type d -name 'ffmpeg-*win64*')
#target=$(echo $source | sed 's/^.*pkgroot\/\(.*shared\).*$/\1/')
#cp -r -v $source/bin $SCRIPT_DIR/../$target/
