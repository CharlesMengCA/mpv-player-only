#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh

[[ $1 == "" ]] && clear

echo_info $0 $@

cd ~/mpv-winbuild-cmake

# misc
#comment_line CMakeLists.txt "mpv-release"
comment_line CMakeLists.txt "mpv-packaging"
comment_line CMakeLists.txt "curl"

#mpv manual.pdf
replace_option mpv "-Dpdf-build=enabled" "-Dpdf-build=disabled"
delete_line mpv "manual.pdf"
append_option mpv "-Dpdf-build=disabled" "-Dmanpage-build=disabled"

#vapoursynth
comment_line CMakeLists.txt "vapoursynth"
comment_line ffmpeg "vapoursynth"
comment_line ffmpeg "--enable-vapoursynth"

comment_line mpv "vapoursynth"
replace_option mpv "-Dvapoursynth=enabled" "-Dvapoursynth=disabled"
comment_line mpv-release "vapoursynth"
replace_option mpv-release "-Dvapoursynth=enabled" "-Dvapoursynth=disabled"

# Mod format support
comment_line CMakeLists.txt libopenmpt
comment_line ffmpeg libopenmpt
comment_line ffmpeg --enable-libopenmpt

comment_line CMakeLists.txt libmodplug
comment_line ffmpeg libmodplug
comment_line ffmpeg --enable-libmodplug

# OpenAL
comment_line CMakeLists.txt openal-soft
comment_line ffmpeg "openal-soft"
comment_line ffmpeg "--enable-openal"
comment_line mpv openal-soft
comment_line mpv "-Dopenal=enabled"
comment_line mpv-release openal-soft
comment_line mpv-release "-Dopenal=enabled"

# Simple DirectMedia Layer is a cross-platform development library designed to
# provide low level access to audio, keyboard, mouse, joystick, and graphics hardware
# via OpenGL and Direct3D.
#libopenmpt and openal-soft are also depended on libsdl2
comment_line CMakeLists.txt "libsdl2"
comment_line mpv "libsdl2"
replace_option mpv "-Dsdl2=enabled" "-Dsdl2=disabled"
comment_line mpv-release "libsdl2"
replace_option mpv-release "-Dsdl2=enabled" "-Dsdl2=disabled"

cp -v $SCRIPT_DIR/Patch/lua-remove-comments.sh ./packages
add_option mpv "UPDATE_COMMAND \"\"" "PATCH_COMMAND \${EXEC} \${CMAKE_CURRENT_SOURCE_DIR}/lua-remove-comments.sh"

cp -v $SCRIPT_DIR/Patch/libass-7-digit-commit-id.sh ./packages
add_option libass "UPDATE_COMMAND \"\"" "PATCH_COMMAND \${EXEC} \${CMAKE_CURRENT_SOURCE_DIR}/libass-7-digit-commit-id.sh"

#comment_line CMakeLists.txt "libdovi"
#comment_line libplacebo "libdovi"

comment_line CMakeLists.txt "aom"
comment_line ffmpeg "aom"
comment_line ffmpeg "--enable-libaom"
#comment_line ffmpeg "--disable-decoder=libaom_av1"

comment_line libjxl "-DJPEGXL_ENABLE_AVX512=ON"
comment_line libjxl "-DJPEGXL_ENABLE_AVX512_ZEN4=ON"

#release build
replace_option mpv "-Ddebug=true" "--buildtype=release"
#delete_line mpv "-Db_ndebug=true"

replace_option libplacebo "-Ddebug=true" "--buildtype=release"
#delete_line libplacebo "-Db_ndebug=true"
