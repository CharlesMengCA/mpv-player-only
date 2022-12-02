#!/bin/bash
echo $0 $@

sed -i -e 's/2021/'$(date +"%Y")'/g' version.py
sed -i -e '/^NEW_REVISION = .*/i version=version.replace("35.0-", "35.0-").replace("4-dirty", "8-dirty").replace("-dirty", "")' version.py
#sed -i -e 's/date.strftime("%a %b %d %I:%M:%S %Y")/datetime.now().strftime("%Y-%m-%d %I:%M:%S %p")/g' version.py
sed -i -e 's/date.strftime("%a %b %d %I:%M:%S %Y")/datetime.now().strftime("%Y-%m-%d %-I:%M %p")/g' version.py

sed -i -e "/configuration += '-Dprefix='/d" meson.build
sed -i -e "s/conf_data.set_quoted('FULLCONFIG', feature_str)/conf_data.set_quoted('FULLCONFIG', feature_str.replace('win32 win32-desktop win32-executable win32-internal-pthreads ',''))/g" meson.build
sed -i -e "s/configuration = 'meson build '/configuration = 'meson build'/g" meson.build



#BUILD_DATE=$(date +"%F %l:%M %p")
#sed -i -e "s/= BUILDDATE;/= \"$BUILD_DATE\";/g" common/version.c

cd player/lua
sed -i -e '/\-\-\[\[/,/\-\-\]\]/{d}' *.lua
sed -i -e '/^\s*--/{d}' *.lua
sed -i -e 's/\s\+--.*$//' *.lua
sed -i -e 's/\-\- bar, line, slider, inverted or none//' *.lua

git_revision=$(git describe)
git_revision=${git_revision/34.0-/34.1-}

if [ "${git_revision: -1}" == "4" ]; then
  git_revision=${git_revision::-1}8
fi

#sed -i -e 's/Drop files or URLs to play here./'${git_revision}' Drop files or URLs to play here./g' osc.lua

#git commit -a -m 'remove lua comments'
