#!/bin/bash
source $(pwd)/functions.sh

check_update (){
   cd $1-prefix/src/$1 2>/dev/null
   
   if [ $? -eq 1 ]; then return; fi
   
   git_url=$(git config --get remote.origin.url)

   remote_commit=$(git ls-remote -q --heads | grep 'heads/main\|heads/master')
   remote_commit=${remote_commit:0:40}
   
   local_commit=$(git rev-parse HEAD)
   
   cd ../../..
   
   if [[ "$git_url" == *"mpv-winbuild-cmake"* ]]; then
      echo "$1 - not a git repo"
      return 
   fi
   
   if [ "$local_commit" = "$remote_commit" ]; then
     echo "$1 - backup"
     mv $1-prefix $1-prefix-bak
   else
     echo "$1 - remove"
     rm -rf $1-prefix
   fi
}

clear && echo $0 $@
cd ~/mpv-winbuild-cmake/build64/

rm -rf mpv-*

cd packages

find ./ -type d -name '*-prefix' | while read line; do
    check_update ${line:2:-7}
done

cd ..
ninja bzip2
cd packages

find ./ -type d -name '*-prefix-bak' | while read line; do
    rm -rf ${line:0:-4} 
    mv $line ${line:0:-4} 
    echo "${line:2:-11} - restored"
done

cd ..

StartTime=$(date '+%H:%M:%S')

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
