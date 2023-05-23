#!/bin/bash

${0%/*}/cm-patch.sh

echo $0 $@

#git reset --soft HEAD~1

sed -i -e 's/2023/'$(date +"%Y")'/g' version.py
sed -i -e '/^NEW_REVISION = .*/i version=version.replace("35.0-", "35.1-").replace("4-dirty", "8-dirty").replace("-dirty", "")' version.py
#sed -i -e 's/date.strftime("%a %b %d %I:%M:%S %Y")/datetime.now().strftime("%Y-%m-%d %I:%M:%S %p")/g' version.py
sed -i -e 's/date.strftime("%a %b %d %I:%M:%S %Y")/datetime.now().strftime("%Y-%m-%d %-I:%M %p")/g' version.py

sed -i -e "s/conf_data.set_quoted('FULLCONFIG', feature_str)/conf_data.set_quoted('FULLCONFIG', feature_str.replace('win32 win32-desktop win32-executable win32-internal-pthreads ',''))/g" meson.build
sed -i -e "s/set_quoted('CONFIGURATION', configuration)/set_quoted('CONFIGURATION', 'meson build')/g" meson.build

#sed -i '/extern const struct vo_driver video_out_tct/d' video/out/vo.c
sed -i '/video_out_tct/d' video/out/vo.c
sed -i '/extern const struct vo_driver video_out_sixel/d' video/out/vo.c
#sed -i '/extern const struct vo_driver video_out_kitty/d' video/out/vo.c
sed -i '/video_out_kitty/d' video/out/vo.c

sed -i '/vo_tct/d' meson.build
sed -i '/vo_kitty/d' meson.build


cd player/lua
sed -i -e '/\-\-\[\[/,/\-\-\]\]/{d}' *.lua
sed -i -e '/^\s*--/{d}' *.lua
sed -i -e 's/\s\+--.*$//' *.lua
sed -i -e 's/\-\- bar, line, slider, inverted or none//' *.lua
sed -i '/user-data\/osc\/margins/d' osc.lua

git_revision=$(git describe)
git_revision=${git_revision/35.0-/35.1-}

if [ "${git_revision: -1}" == "4" ]; then
  git_revision=${git_revision::-1}8
fi

#sed -i -e 's/Drop files or URLs to play here./'${git_revision}' Drop files or URLs to play here./g' osc.lua

#git commit -a -m 'remove lua comments'