#!/bin/bash
source $(pwd)/functions.sh
SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

clear && echo $0 $@

sudo pacman -S --needed --noconfirm docker git
#systemctl enable docker.service
systemctl start docker.service

cd ..
git clone https://github.com/BtbN/FFmpeg-Builds.git
#git clone https://github.com/CharlesMengCA/FFmpeg-Builds.git
cd FFmpeg-Builds

rm scripts.d/50-openmpt.sh
rm scripts.d/50-kvazaar.sh
rm scripts.d/50-aribb24/50-libaribb24.sh

set -x #echo on
#sed -i "s/--branch='\\\$GIT_BRANCH'/--branch='n5.1.2'/g" build.sh

./makeimage.sh win64 gpl-shared 5.1
./build.sh win64 gpl-shared 5.1

#./makeimage.sh win64 gpl-shared
#./build.sh win64 gpl-shared

source=$(find ffbuild/pkgroot -type d -name 'ffmpeg-*win64*')
target=$(echo $source | sed 's/^.*pkgroot\/\(.*shared\).*$/\1/')
cp -r -v $source/bin $SCRIPT_DIR/../$target/
