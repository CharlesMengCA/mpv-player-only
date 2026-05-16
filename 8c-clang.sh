#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh

echo_info $0 $@
cd ~/mpv-winbuild-cmake/

echo 'Clang start: ' $(date '+%H:%M:%S') >> $HOME/build_time.txt
#set -x #echo on

#add_option llvm "-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON" "-DCMAKE_CXX_STANDARD=20"
#add_option llvm "-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON" "-DCMAKE_CXX_SCAN_FOR_MODULES=OFF"
#add_option llvm "-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON" "-DCMAKE_CXX_COMPILER_CLANG_SCAN_DEPS=OFF"
#replace_option llvm "-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON" "-DCMAKE_BUILD_WITH_INSTALL_RPATH=OFF"

#append_option llvm "-DLLVM_INCLUDE_DOCS=OFF" "-DLLVM_ENABLE_TELEMETRY=OFF"
#append_option llvm "-DLLVM_INCLUDE_DOCS=OFF" "-DLLVM_ENABLE_OCAMLDOC=OFF"
#append_option llvm "-DLLVM_INCLUDE_DOCS=OFF" "-DCLANG_INCLUDE_DOCS=OFF"

#append_option llvm "-DLLVM_INCLUDE_UTILS=OFF" "-DLLVM_BUILD_RUNTIMES=OFF"
#append_option llvm "-DLLVM_INCLUDE_UTILS=OFF" "-DLLVM_BUILD_RUNTIME=OFF"
#append_option llvm "-DLLVM_INCLUDE_UTILS=OFF" "-DLLVM_INCLUDE_RUNTIMES=OFF"

#append_option llvm "-DCLANG_TOOL_C_INDEX_TEST_BUILD=OFF" "-DCLANG_TOOL_CIR_TRANSLATE_BUILD=OFF"
#append_option llvm "-DCLANG_TOOL_C_INDEX_TEST_BUILD=OFF" "-DCLANG_TOOL_CIR_OPT_BUILD=OFF"
#append_option llvm "-DCLANG_TOOL_C_INDEX_TEST_BUILD=OFF" "-DCLANG_TOOL_CIR_LSP_SERVER_BUILD=OFF"

replace_option llvm "-DCLANG_TOOL_CLANG_SCAN_DEPS_BUILD=ON" "-DCLANG_TOOL_CLANG_SCAN_DEPS_BUILD=OFF"

#append_option llvm "-DLLVM_ENABLE_LIBXML2=OFF" "-DLLVM_ENABLE_LIBPFM=OFF"
#append_option llvm "-DLLVM_ENABLE_LIBXML2=OFF" "-DLLVM_ENABLE_LIBEDIT=OFF"

#append_option llvm "-DLLVM_TOOL_LLVM_CFI_VERIFY_BUILD=OFF" "-DLLVM_TOOL_LLVM_CGDATA_BUILD=OFF"
#append_option llvm "-DLLVM_TOOL_LLVM_CTXPROF_UTIL_BUILD=OFF" "-DLLVM_TOOL_LLVM_CVTRES_BUILD=OFF"

#append_option llvm "-DLLVM_TOOL_LLVM_EXTRACT_BUILD=OFF" "-DLLVM_TOOL_LLVM_GPU_LOADER_BUILD=OFF"

#append_option llvm "-DLLVM_TOOL_LLVM_STRESS_BUILD=OFF" "-DLLVM_TOOL_LLVM_STRINGS_BUILD=OFF"


#mkdir -p cmake/
#tar -xf ~/mpv/Others/modules.tar.gz -C cmake/
#cp -v ~/mpv/Others/modules.tar.gz .

# https://github.com/shinchiro/mpv-winbuild-cmake/blob/master/.github/workflows/llvm_clang.yml

cmake -DCOMPILER_TOOLCHAIN=clang -DTARGET_ARCH=x86_64-w64-mingw32 \
      -DGCC_ARCH=x86-64-v3 \
      -DMINGW_INSTALL_PREFIX=$PWD/build64/x86_64_v3-w64-mingw32 \
      -DCMAKE_INSTALL_PREFIX=$PWD/clang_root \
      -DSINGLE_SOURCE_LOCATION=$PWD/src_packages \
      -DRUSTUP_LOCATION=$PWD/clang_root/install_rustup \
      -G Ninja -Bbuild64 -H. -Wno-dev 

cd build64

#until git ls-remote https://github.com/facebook/zstd.git HEAD >/dev/null
#do
#   sleep 0.5
#done

#until [ -f $HOME/mpv-winbuild-cmake/src_packages/zstd-host/Makefile ]
#do
#  echo_build zstd-host
#done

#until [ -f $HOME/mpv-winbuild-cmake/src_packages/zlib-host/configure ]
#do
#  echo_build zlib-host
#done

#until [ -f $HOME/mpv-winbuild-cmake/src_packages/mimalloc/CMakeLists.txt ]
#do
#  echo_build mimalloc
#done

if [[ $1 == "a" || $2 == "a" ]]; then
   echo_build mingw-w64-gendef
else
   echo_build mingw-w64
fi

echo_build llvm

echo_build mingw-w64-crt

if [[ $1 == "a" || $2 == "a" ]]; then
   echo_build mingw-w64-winpthreads
fi

echo_build llvm-clang
[ $? -ne 0 ] && exit 1

#echo_build rustup

{ set +x; } 2>/dev/null # echo off
echo 'Clang end: ' $(date '+%H:%M:%S') >> $HOME/build_time.txt

cd ..

cmake -DCOMPILER_TOOLCHAIN=clang -DTARGET_ARCH=x86_64-w64-mingw32 \
      -DGCC_ARCH=x86-64-v3 \
      -DMINGW_INSTALL_PREFIX=$PWD/build64/x86_64_v3-w64-mingw32 \
      -DCMAKE_INSTALL_PREFIX=$PWD/clang_root \
      -DSINGLE_SOURCE_LOCATION=$PWD/src_packages \
      -DRUSTUP_LOCATION=$PWD/clang_root/install_rustup \
      -DCLANG_FLAGS="-fdata-sections -ffunction-sections" \
      -DLLD_FLAGS="-O3 --gc-sections -Xlink=-opt:safeicf" \
      -G Ninja -B build64 -H. -Wno-dev 

new_hash=$(git ls-remote https://github.com/llvm/llvm-project.git release/22.x)
new_hash=${new_hash:0:7}
old_hash=$(head -n 1 $SCRIPT_DIR/Patch/llvm_hash.txt)

if [ "$new_hash" != "$old_hash" ]; then
   echo $new_hash > $SCRIPT_DIR/Patch/llvm_hash.txt
fi

if [[ $1 == "backup" || $2 == "backup" || "$new_hash" != "$old_hash" ]]; then
   cd
   tar cf - mpv-winbuild-cmake/ | 7z a -si -mx9 "mpv/Patch/llvm_"$(date '+%y%m%d_%H%M')".tar.7z"
   echo 'Compiler cached: ' $(date '+%H:%M:%S') >> $HOME/build_time.txt
fi

#      -DCLANG_FLAGS="-fdata-sections -ffunction-sections -faddrsig" \
#      -DLLD_FLAGS="-O3 --gc-sections --icf=all" \
