#!/bin/bash
source $(pwd)/functions.sh
bashFolder=$(pwd)
clear && echo $0 $@

cd ~/mpv-winbuild-cmake

# misc
comment_line CMakeLists.txt "mpv-release"
comment_line CMakeLists.txt "mpv-packaging"
comment_line CMakeLists.txt "curl"

#vapoursynth
comment_line CMakeLists.txt "vapoursynth"
comment_line ffmpeg "vapoursynth"
comment_line ffmpeg "--enable-vapoursynth"

comment_line mpv "vapoursynth"
replace_option mpv "-Dvapoursynth=enabled" "-Dvapoursynth=disabled"

#mpv manual.pdf
replace_option mpv "-Dpdf-build=enabled" "-Dpdf-build=disabled"
delete_line mpv "manual.pdf"
append_option mpv "-Dpdf-build=disabled" "-Dmanpage-build=disabled"

# Simple DirectMedia Layer is a cross-platform development library designed to
# provide low level access to audio, keyboard, mouse, joystick, and graphics hardware
# via OpenGL and Direct3D.
comment_line CMakeLists.txt "libsdl2"
comment_line mpv "libsdl2"
replace_option mpv "-Dsdl2=enabled" "-Dsdl2=disabled"

comment_line mpv "mujs"
replace_option mpv "-Djavascript=enabled" "-Djavascript=disabled"

cp $bashFolder/lua-remove-comments.sh ./packages
add_option mpv "UPDATE_COMMAND \"\"" "PATCH_COMMAND \${EXEC} \${CMAKE_CURRENT_SOURCE_DIR}/lua-remove-comments.sh"

cp $bashFolder/libass-7-digit-commit-id.sh ./packages
add_option libass "UPDATE_COMMAND \"\"" "PATCH_COMMAND \${EXEC} \${CMAKE_CURRENT_SOURCE_DIR}/libass-7-digit-commit-id.sh"
