#!/bin/bash
echo $0 $@

sed -i -e 's/2021/'$(date +"%Y")'/g' version.py
sed -i -e '/^NEW_REVISION = .*/i version=version.replace("34.0-", "34.1-").replace("4-dirty", "8-dirty").replace("-dirty", "")' version.py
sed -i -e 's/date.strftime("%a %b %d %I:%M:%S %Y")/datetime.now().strftime("%Y-%m-%d %I:%M:%S %p")/g' version.py

sed -i -e "/configuration += '-Dprefix='/d" meson.build
sed -i -e "s/conf_data.set_quoted('FULLCONFIG', feature_str)/conf_data.set_quoted('FULLCONFIG', feature_str.replace('win32 win32-desktop win32-executable win32-internal-pthreads ',''))/g" meson.build
sed -i -e "s/configuration = 'meson build '/configuration = 'meson build'/g" meson.build

cd player/lua

sed -i -e '/\-\-\[\[/,/\-\-\]\]/{d}' *.lua
sed -i -e '/^\s*--/{d}' *.lua
sed -i -e 's/\s\+--.*$//' *.lua
sed -i -e 's/\-\- bar, line, slider, inverted or none//' *.lua

#git commit -a -m 'remove lua comments'
