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
rm -rf fontconfig-prefix
rm -rf vulkan-prefix

if [ "$backup_only" = true ]; then
#	backup fontconfig
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
#	restore fontconfig
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
	#rm -rf lame-prefix
	#rm -rf libbluray-prefix
	rm -rf libjxl-prefix
	rm -rf libsrt-prefix
	#rm -rf libssh-prefix
	rm -rf luajit-prefix
	rm -rf mbedtls-prefix
	rm -rf mujs-prefix
	rm -rf nettle-prefix
	rm -rf spirv-cross-prefix
	rm -rf vulkan-header-prefix
	rm -rf vulkan-prefix

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
