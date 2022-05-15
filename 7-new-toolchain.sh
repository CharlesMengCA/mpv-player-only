#!/bin/bash
# try out new toolchain
source $(pwd)/functions.sh

clear && echo $0 $@

baseFolder=$(pwd)
cd ~/mpv-winbuild-cmake/

#set -x #echo on

#append_option mingw-w64 "GIT_REPOSITORY https:\/\/github.com\/mirror\/mingw-w64.git" "GIT_TAG 3d2042584a6c2521fad29a723312d095e0c75006"



#gcc v12
#replace_option gcc "11-20220429" "12-20220507"
#replace_option gcc "218b2bc9cba09829d76f695fa3d0db8ea4c15b4af3cb8364eb65adc6c8e0dd80765f0b7ae36e111ad0355bb2883599413f9d93feb12d880a4baa7c499d47758c" \
#						 "c656c15e3f72af53ecf11f873c214d9379c7e43c3474ad56bb13669871835c55bcfc3d0b9df41aa571954ace21e1547f034d53ca912cb50acdcfde077d86b75d"
