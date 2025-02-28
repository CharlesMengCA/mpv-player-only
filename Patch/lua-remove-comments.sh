#!/bin/bash

${0%/*}/cm-patch.sh

echo $0 $@

COMMITS=$(git describe | sed 's/[^-]*-\([^-]*\)-.*/\1/')
if [[ ${COMMITS: -1} == "4" ]]; then
   git reset --soft HEAD~1
fi

MIN=$(date '+%M')
MIN=${MIN:1:1}

if [[ $MIN == "3" ]] || [[ $MIN == "4" ]]; then
   while [[ $MIN -ne "5" ]]
   do
      sleep 0.1
      MIN=$(date '+%M')
      MIN=${MIN:1:1}
   done
fi

mpv_version=$(git describe | sed 's/v//g' | sed 's/4$/8/g')
build_date=$(date '+%Y-%m-%d###%-I:%M###%p')
sed -i -e 's/@VERSION@/'$mpv_version'/g' common/version.h.in
sed -i -e 's/__DATE__ " " __TIME__/"'$build_date'"/g' common/version.h.in
sed -i -e 's/###/ /g' common/version.h.in

sed -i -e "s#set_quoted('FULLCONFIG', feature_str)#set_quoted('FULLCONFIG', feature_str.replace('win32 win32-desktop win32-executable win32-smtc win32-threads ','').replace('build-date ',''))#g" meson.build
sed -i -e "s#set_quoted('CONFIGURATION', configuration)#set_quoted('CONFIGURATION', configuration.replace('-Dpdf-build=disabled -Dmanpage-build=disabled ','').replace('-Dprefix=/home/cm/mpv-winbuild-cmake/build64/install/x86_64-w64-mingw32 -Dlibdir=/home/cm/mpv-winbuild-cmake/build64/install/x86_64-w64-mingw32/lib ','').replace('-Dprefix=/home/cm/mpv-winbuild-cmake/clang_root/x86_64-w64-mingw32 -Dlibdir=/home/cm/mpv-winbuild-cmake/clang_root/x86_64-w64-mingw32/lib ','').replace(' --cross-file=/home/cm/mpv-winbuild-cmake/build64/meson_cross.txt',''))#g" meson.build

#sed -i '/extern const struct vo_driver video_out_tct/d' video/out/vo.c
sed -i '/video_out_tct/d' video/out/vo.c
sed -i '/extern const struct vo_driver video_out_sixel/d' video/out/vo.c
#sed -i '/extern const struct vo_driver video_out_kitty/d' video/out/vo.c
sed -i '/video_out_kitty/d' video/out/vo.c

sed -i '/vo_tct/d' meson.build
sed -i '/vo_kitty/d' meson.build

BACKUP_FOLDER=$(pwd | sed -r 's#^(.*/)src_packages.*#\1#')


cd player/lua

mkdir $BACKUP_FOLDER/mpv-lua/ 
cp -R --preserve=timestamps *.lua $BACKUP_FOLDER/mpv-lua/

sed -i -e '/^--\[\[/,/\]\]/{d}' *.lua
sed -i -e '/--\[\[/,/--\]\]/{d}' *.lua
sed -i -e '/^\s*--/{d}' *.lua
sed -i -e 's/\s\+--\s.*$//' *.lua
sed -i -e 's/\s\+--.*$//' osc.lua
sed -i -e 's/\-\- bar, line, slider, inverted or none//' *.lua

sed -i '/user-data\/osc\/margins/d' osc.lua
sed -i -e "s/try_ytdl_first = false/try_ytdl_first = true/g" ytdl_hook.lua
#-------------
#sed -i -e "s/plot_tonemapping_lut = true/plot_tonemapping_lut = false/g" stats.lua
#sed -i -e "/font_size = o\.font_size \* scale/d" stats.lua

mkdir $BACKUP_FOLDER/mpv-lua-mod/ 
cp -R --preserve=timestamps *.lua $BACKUP_FOLDER/mpv-lua-mod/

git_revision=$(git describe)
#git_revision=${git_revision/35.0-/35.1-}

if [ "${git_revision: -1}" == "4" ]; then
  git_revision=${git_revision::-1}8
fi
#sed -i -e 's/Drop files or URLs to play here./'${git_revision}' Drop files or URLs to play here./g' osc.lua
#git commit -a -m 'remove lua comments'
