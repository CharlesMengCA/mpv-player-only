#!/bin/bash
source $(pwd)/functions.sh

clear && echo $0 $@

MPV_BUILD_FOLDER=~/mpv-winbuild-cmake/
cp lua-remove-comments.sh "$MPV_BUILD_FOLDER"packages/
cd $MPV_BUILD_FOLDER

# misc
comment_line CMakeLists.txt "mpv-release"
comment_line CMakeLists.txt "mpv-packaging"
comment_line CMakeLists.txt "curl"

#vapoursynth
comment_line CMakeLists.txt "vapoursynth"
comment_line ffmpeg "vapoursynth"
comment_line ffmpeg "--enable-vapoursynth"

comment_line mpv "vapoursynth"
replace_option mpv "--enable-vapoursynth" "--disable-vapoursynth"

#mpv manual.pdf
comment_line mpv "--enable-pdf-build"
delete_line mpv "manual.pdf"

#debug build
add_option mpv "--enable-static-build" "--disable-debug-build"

# Simple DirectMedia Layer is a cross-platform development library designed to
# provide low level access to audio, keyboard, mouse, joystick, and graphics hardware
# via OpenGL and Direct3D.
comment_line CMakeLists.txt "libsdl2"
comment_line mpv "libsdl2"
comment_line mpv "--enable-sdl2"

add_option mpv "UPDATE_COMMAND \"\"" "PATCH_COMMAND \${EXEC} \${CMAKE_CURRENT_SOURCE_DIR}/lua-remove-comments.sh"

comment_line mpv "mujs"
replace_option mpv "--enable-javascript" "--disable-javascript"

