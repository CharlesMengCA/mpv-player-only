clear
target_folder=$(pwd)
gcc_version=$($HOME/mpv-winbuild-cmake/build64/toolchain/llvm-prefix/src/llvm-build/bin/llvm-config --version)
cd ~/mpv-winbuild-cmake/src_packages/mpv/
target_folder="$target_folder/Mod/mpv-x86_64-v3-$(date '+%Y%m%d')-git-$(git rev-parse --short=7 HEAD)-clang_$gcc_version"
mingw_lib=$(find $HOME/mpv-winbuild-cmake/clang_root -name libmingwex.a)
#mingw_lib=$(echo $mingw_lib | sed -e "s#/#\\\\/#g")

cd ../../build64/packages/mpv-prefix/src/mpv-build/

echo "build mpv.exe ..."
build_exe=$(sed -n '/-o mpv.exe/p' ../mpv-stamp/mpv-build-out.log)
$(echo $build_exe | sed -e "s#"$mingw_lib"#-s#g")

echo "build libmpv-2.dll ..."
build_dll=$(sed -n '/-o libmpv-2.dll/p' ../mpv-stamp/mpv-build-out.log)
$(echo $build_dll | sed -e "s#"$mingw_lib"#-s#g")

mkdir $target_folder
strip -s mpv.exe
strip -s libmpv-2.dll
cp mpv.exe $target_folder/
cp libmpv-2.dll $target_folder/
cp libmpv.dll.a $target_folder/
strip -s player/mpv.com
cp player/mpv.com $target_folder/
mkdir $target_folder/include
mkdir $target_folder/include/mpv
cp $HOME/mpv-winbuild-cmake/src_packages/mpv/libmpv/*.h $target_folder/include/mpv/

#clear
cd $target_folder
ls -g -o --group-directories-first --time-style=iso