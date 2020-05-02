#!/bin/bash

set -x #echo on

cd ~/mpv-winbuild-cmake/build64

cmake -DTARGET_ARCH=x86_64-w64-mingw32 -G Ninja ..

ninja gcc

ninja x264 vulkan shaderc gmp libmodplug speex vorbis xvidcore lzo expat

ninja mpv



