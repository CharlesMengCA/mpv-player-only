#!/bin/bash
source $(pwd)/functions.sh

clear && echo $0 $@

pacman -S --needed --noconfirm docker git
#systemctl enable docker.service
systemctl start docker.service

cd ~
git clone https://github.com/BtbN/FFmpeg-Builds.git
cd FFmpeg-Builds

rm scripts.d/50-openmpt.sh
rm scripts.d/50-kvazaar.sh
rm scripts.d/50-aribb24/50-libaribb24.sh

./makeimage.sh win64 gpl-shared 5.1

./build.sh win64 gpl-shared 5.1

ls ffbuild/pkgroot