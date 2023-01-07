clear
target_folder=$(pwd)
cd ~/mpv-winbuild-cmake/build64/packages/mpv-prefix/src/mpv/
target_folder="$target_folder/Mod/mpv-x86_64-v3-$(date '+%Y%m%d')-git-$(git rev-parse --short=7 HEAD)-jxl"
cd ../mpv-build/
mingw_lib=$(echo $(pwd) | sed -e "s#packages/mpv-prefix/src/mpv-build#install/mingw/lib/libmingwex.a#g")
#mingw_lib=$(echo $mingw_lib | sed -e "s#/#\\\\/#g")

echo "build mpv.exe ..."
build_exe=$(sed -n '/-o mpv.exe/p' ../mpv-stamp/mpv-build-out.log)
$(echo $build_exe | sed -e "s#"$mingw_lib"#-s#g")

build_dll=$(sed -n '/-o libmpv-2.dll/p' ../mpv-stamp/mpv-build-out.log)
$(echo $build_dll | sed -e "s#"$mingw_lib"#-s#g")

mkdir $target_folder
cp mpv.exe $target_folder
cp libmpv-2.dll $target_folder/mpv-2.dll

clear
cd $target_folder
ls -g -o --group-directories-first --time-style=iso