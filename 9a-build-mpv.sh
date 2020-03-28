#!/bin/bash
clear && echo $0 $@

BUILD64=~/mpv-winbuild-cmake/build64

cd $BUILD64

set -x #echo on

ninja amf-headers angle-headers aom avisynth-headers \
      bzip2 dav1d expat fribidi glslang gmp lame \
		libiconv libjpeg libmfx libressl libsoxr libvpx libwebp libxml2 libzimg \
		lzo nvcodec-headers ogg \
		spirv-cross spirv-headers spirv-tools \
		uchardet x264 xvidcore xz zlib

# libsdl2