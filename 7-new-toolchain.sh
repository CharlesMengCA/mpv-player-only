#!/bin/bash
# try out new toolchain
source $(pwd)/functions.sh

clear && echo $0 $@

baseFolder=$(pwd)
cd ~/mpv-winbuild-cmake/

#set -x #echo on

#append_option mingw-w64 "GIT_REPOSITORY https:\/\/github.com\/mirror\/mingw-w64.git" "GIT_TAG 3d2042584a6c2521fad29a723312d095e0c75006"


#gcc v11
#replace_option gcc "11.3.0-RC-20220414" "11-20220429"
#replace_option gcc "7e5399726bb44d142a3f263a24b8875001a9d177fc563cd631ffcb34b026f8ccdf3d9c95b4af248075a622fbe2a8a0ecacd3c951c30168997b323673456ce7f1" \
#						 "218b2bc9cba09829d76f695fa3d0db8ea4c15b4af3cb8364eb65adc6c8e0dd80765f0b7ae36e111ad0355bb2883599413f9d93feb12d880a4baa7c499d47758c"
