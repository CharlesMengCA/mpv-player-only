#!/bin/bash
source $(pwd)/functions.sh

backup (){
	mv $1-prefix $1-prefix-bak
}
restore (){
	rm -r $1-prefix
	mv $1-prefix-bak $1-prefix
}

backup_only=true

StartTime=$(date '+%H:%M:%S')

clear && echo $0 $@

cd ~/mpv-winbuild-cmake/build64/

rm -r mpv-*

cd packages

rm -rf mpv-prefix
rm -rf ffmpeg-prefix
rm -rf freetype2-prefix
rm -rf libssh-prefix

if [ "$backup_only" = true ]; then
	backup fontconfig
	#backup lame
	backup libbluray
	backup libjxl
	backup libsrt
	backup luajit
	backup mbedtls
	backup mujs
	backup nettle
	backup spirv-cross
	backup vulkan

	cd ..
	ninja lzo

	cd packages
	restore fontconfig
	#restore lame
	restore libbluray
	restore libjxl
	restore libsrt
	restore luajit
	restore mbedtls
	restore mujs
	restore nettle
	restore spirv-cross
	restore vulkan
else
	rm -r fontconfig-prefix
	#rm -r lame-prefix
	#rm -r libbluray-prefix
	rm -r libjxl-prefix
	rm -r libsrt-prefix
	#rm -r libssh-prefix
	rm -r luajit-prefix
	rm -r mbedtls-prefix
	rm -r mujs-prefix
	rm -r nettle-prefix
	rm -r spirv-cross-prefix
	rm -r vulkan-header-prefix
	rm -r vulkan-prefix

	#rm -r libbs2b-prefix
	#rm -r libepoxy-prefix
	#rm -r libmodplug-prefix
fi

cd ..

ninja shaderc
ninja spirv-cross
ninja libarchive
ninja libass
#ninja harfbuzz
ninja libssh
ninja libjxl
ninja libplacebo

ninja mpv

cd mpv-x86_64* && ls -g -o --time-style=iso *.exe
cd ../mpv-dev-x86_64-* && ls -g -o --time-style=iso *.dll

echo 'Build:' $StartTime '->' $(date '+%H:%M:%S')
