#!/bin/bash
source $(pwd)/functions.sh

clear && echo $0 $@

cd ~/mpv-winbuild-cmake/build64/packages/mpv-prefix/src/mpv
build_dir=mpv-x86_64-v3-$(date -u +%Y%m%d)-git-$(git rev-parse --short=7 HEAD)-jxl

cd ~
mkdir $build_dir

cd mpv-winbuild-cmake

uncomment_line ffmpeg "libjxl"
uncomment_line ffmpeg "--enable-libjxl"
append_option ffmpeg --disable-encoders --enable-encoder=libjxl

uncomment_line mpv "-Dlibmpv=true"

rm ~/mpv-winbuild-cmake/build64/packages/mpv-prefix/src/mpv-build/mpv*.dll
rm ~/mpv-winbuild-cmake/build64/packages/mpv-prefix/src/mpv-build/mpv*.exe

~/mpv/9u-build-mpv.sh

cd ~/mpv-winbuild-cmake/build64/packages/mpv-prefix/src/mpv-build/


if ls mpv.exe 1> /dev/null 2>&1; then
 cp mpv.exe ~/$build_dir/
 cp libmpv-2.dll ~/$build_dir/mpv-2.dll
 
 echo "*** No compiling error"
 
 cd ~/$build_dir
 ls -g -o --time-style=iso

 exit
fi

if ls libmpv*.dll 1> /dev/null 2>&1; then
 echo "*** Errror in built libmpv*.dll"
 exit
fi

~/mpv-winbuild-cmake/build64/install/bin/x86_64-w64-mingw32-gcc -s -o mpv-2.dll osdep_mpv.rc_mpv.o libmpv-2.dll.p/audio_aframe.c.obj libmpv-2.dll.p/audio_chmap.c.obj libmpv-2.dll.p/audio_chmap_sel.c.obj libmpv-2.dll.p/audio_decode_ad_lavc.c.obj libmpv-2.dll.p/audio_decode_ad_spdif.c.obj libmpv-2.dll.p/audio_filter_af_drop.c.obj libmpv-2.dll.p/audio_filter_af_format.c.obj libmpv-2.dll.p/audio_filter_af_lavcac3enc.c.obj libmpv-2.dll.p/audio_filter_af_scaletempo.c.obj libmpv-2.dll.p/audio_filter_af_scaletempo2.c.obj libmpv-2.dll.p/audio_filter_af_scaletempo2_internals.c.obj libmpv-2.dll.p/audio_fmt-conversion.c.obj libmpv-2.dll.p/audio_format.c.obj libmpv-2.dll.p/audio_out_ao.c.obj libmpv-2.dll.p/audio_out_ao_lavc.c.obj libmpv-2.dll.p/audio_out_ao_null.c.obj libmpv-2.dll.p/audio_out_ao_pcm.c.obj libmpv-2.dll.p/audio_out_buffer.c.obj libmpv-2.dll.p/common_av_common.c.obj libmpv-2.dll.p/common_av_log.c.obj libmpv-2.dll.p/common_codecs.c.obj libmpv-2.dll.p/common_common.c.obj libmpv-2.dll.p/common_encode_lavc.c.obj libmpv-2.dll.p/common_msg.c.obj libmpv-2.dll.p/common_playlist.c.obj libmpv-2.dll.p/common_recorder.c.obj libmpv-2.dll.p/common_stats.c.obj libmpv-2.dll.p/common_tags.c.obj libmpv-2.dll.p/common_version.c.obj libmpv-2.dll.p/demux_codec_tags.c.obj libmpv-2.dll.p/demux_cue.c.obj libmpv-2.dll.p/demux_cache.c.obj libmpv-2.dll.p/demux_demux.c.obj libmpv-2.dll.p/demux_demux_cue.c.obj libmpv-2.dll.p/demux_demux_disc.c.obj libmpv-2.dll.p/demux_demux_edl.c.obj libmpv-2.dll.p/demux_demux_lavf.c.obj libmpv-2.dll.p/demux_demux_mf.c.obj libmpv-2.dll.p/demux_demux_mkv.c.obj libmpv-2.dll.p/demux_demux_mkv_timeline.c.obj libmpv-2.dll.p/demux_demux_null.c.obj libmpv-2.dll.p/demux_demux_playlist.c.obj libmpv-2.dll.p/demux_demux_raw.c.obj libmpv-2.dll.p/demux_demux_timeline.c.obj libmpv-2.dll.p/demux_ebml.c.obj libmpv-2.dll.p/demux_packet.c.obj libmpv-2.dll.p/demux_timeline.c.obj libmpv-2.dll.p/filters_f_async_queue.c.obj libmpv-2.dll.p/filters_f_autoconvert.c.obj libmpv-2.dll.p/filters_f_auto_filters.c.obj libmpv-2.dll.p/filters_f_decoder_wrapper.c.obj libmpv-2.dll.p/filters_f_demux_in.c.obj libmpv-2.dll.p/filters_f_hwtransfer.c.obj libmpv-2.dll.p/filters_f_lavfi.c.obj libmpv-2.dll.p/filters_f_output_chain.c.obj libmpv-2.dll.p/filters_f_swresample.c.obj libmpv-2.dll.p/filters_f_swscale.c.obj libmpv-2.dll.p/filters_f_utils.c.obj libmpv-2.dll.p/filters_filter.c.obj libmpv-2.dll.p/filters_frame.c.obj libmpv-2.dll.p/filters_user_filters.c.obj libmpv-2.dll.p/input_cmd.c.obj libmpv-2.dll.p/input_event.c.obj libmpv-2.dll.p/input_input.c.obj libmpv-2.dll.p/input_ipc.c.obj libmpv-2.dll.p/input_keycodes.c.obj libmpv-2.dll.p/misc_bstr.c.obj libmpv-2.dll.p/misc_charset_conv.c.obj libmpv-2.dll.p/misc_dispatch.c.obj libmpv-2.dll.p/misc_json.c.obj libmpv-2.dll.p/misc_natural_sort.c.obj libmpv-2.dll.p/misc_node.c.obj libmpv-2.dll.p/misc_rendezvous.c.obj libmpv-2.dll.p/misc_thread_pool.c.obj libmpv-2.dll.p/misc_thread_tools.c.obj libmpv-2.dll.p/options_m_config_core.c.obj libmpv-2.dll.p/options_m_config_frontend.c.obj libmpv-2.dll.p/options_m_option.c.obj libmpv-2.dll.p/options_m_property.c.obj libmpv-2.dll.p/options_options.c.obj libmpv-2.dll.p/options_parse_commandline.c.obj libmpv-2.dll.p/options_parse_configfile.c.obj libmpv-2.dll.p/options_path.c.obj libmpv-2.dll.p/player_audio.c.obj libmpv-2.dll.p/player_client.c.obj libmpv-2.dll.p/player_command.c.obj libmpv-2.dll.p/player_configfiles.c.obj libmpv-2.dll.p/player_external_files.c.obj libmpv-2.dll.p/player_loadfile.c.obj libmpv-2.dll.p/player_main.c.obj libmpv-2.dll.p/player_misc.c.obj libmpv-2.dll.p/player_osd.c.obj libmpv-2.dll.p/player_playloop.c.obj libmpv-2.dll.p/player_screenshot.c.obj libmpv-2.dll.p/player_scripting.c.obj libmpv-2.dll.p/player_sub.c.obj libmpv-2.dll.p/player_video.c.obj libmpv-2.dll.p/stream_cookies.c.obj libmpv-2.dll.p/stream_stream.c.obj libmpv-2.dll.p/stream_stream_avdevice.c.obj libmpv-2.dll.p/stream_stream_cb.c.obj libmpv-2.dll.p/stream_stream_concat.c.obj libmpv-2.dll.p/stream_stream_edl.c.obj libmpv-2.dll.p/stream_stream_file.c.obj libmpv-2.dll.p/stream_stream_lavf.c.obj libmpv-2.dll.p/stream_stream_memory.c.obj libmpv-2.dll.p/stream_stream_mf.c.obj libmpv-2.dll.p/stream_stream_null.c.obj libmpv-2.dll.p/stream_stream_slice.c.obj libmpv-2.dll.p/sub_ass_mp.c.obj libmpv-2.dll.p/sub_dec_sub.c.obj libmpv-2.dll.p/sub_draw_bmp.c.obj libmpv-2.dll.p/sub_filter_sdh.c.obj libmpv-2.dll.p/sub_img_convert.c.obj libmpv-2.dll.p/sub_lavc_conv.c.obj libmpv-2.dll.p/sub_osd.c.obj libmpv-2.dll.p/sub_osd_libass.c.obj libmpv-2.dll.p/sub_sd_ass.c.obj libmpv-2.dll.p/sub_sd_lavc.c.obj libmpv-2.dll.p/video_csputils.c.obj libmpv-2.dll.p/video_decode_vd_lavc.c.obj libmpv-2.dll.p/video_filter_refqueue.c.obj libmpv-2.dll.p/video_filter_vf_format.c.obj libmpv-2.dll.p/video_filter_vf_sub.c.obj libmpv-2.dll.p/video_fmt-conversion.c.obj libmpv-2.dll.p/video_hwdec.c.obj libmpv-2.dll.p/video_image_loader.c.obj libmpv-2.dll.p/video_image_writer.c.obj libmpv-2.dll.p/video_img_format.c.obj libmpv-2.dll.p/video_mp_image.c.obj libmpv-2.dll.p/video_mp_image_pool.c.obj libmpv-2.dll.p/video_out_aspect.c.obj libmpv-2.dll.p/video_out_bitmap_packer.c.obj libmpv-2.dll.p/video_out_dither.c.obj libmpv-2.dll.p/video_out_dr_helper.c.obj libmpv-2.dll.p/video_out_filter_kernels.c.obj libmpv-2.dll.p/video_out_gpu_context.c.obj libmpv-2.dll.p/video_out_gpu_error_diffusion.c.obj libmpv-2.dll.p/video_out_gpu_hwdec.c.obj libmpv-2.dll.p/video_out_gpu_lcms.c.obj libmpv-2.dll.p/video_out_gpu_libmpv_gpu.c.obj libmpv-2.dll.p/video_out_gpu_osd.c.obj libmpv-2.dll.p/video_out_gpu_ra.c.obj libmpv-2.dll.p/video_out_gpu_shader_cache.c.obj libmpv-2.dll.p/video_out_gpu_spirv.c.obj libmpv-2.dll.p/video_out_gpu_user_shaders.c.obj libmpv-2.dll.p/video_out_gpu_utils.c.obj libmpv-2.dll.p/video_out_gpu_video.c.obj libmpv-2.dll.p/video_out_gpu_video_shaders.c.obj libmpv-2.dll.p/video_out_libmpv_sw.c.obj libmpv-2.dll.p/video_out_vo.c.obj libmpv-2.dll.p/video_out_vo_gpu.c.obj libmpv-2.dll.p/video_out_vo_image.c.obj libmpv-2.dll.p/video_out_vo_lavc.c.obj libmpv-2.dll.p/video_out_vo_libmpv.c.obj libmpv-2.dll.p/video_out_vo_null.c.obj libmpv-2.dll.p/video_out_vo_tct.c.obj libmpv-2.dll.p/video_out_win_state.c.obj libmpv-2.dll.p/video_repack.c.obj libmpv-2.dll.p/video_sws_utils.c.obj libmpv-2.dll.p/osdep_io.c.obj libmpv-2.dll.p/osdep_semaphore_osx.c.obj libmpv-2.dll.p/osdep_subprocess.c.obj libmpv-2.dll.p/osdep_threads.c.obj libmpv-2.dll.p/osdep_timer.c.obj libmpv-2.dll.p/ta_ta.c.obj libmpv-2.dll.p/ta_ta_talloc.c.obj libmpv-2.dll.p/ta_ta_utils.c.obj libmpv-2.dll.p/osdep_win32_pthread.c.obj libmpv-2.dll.p/osdep_timer-win2.c.obj libmpv-2.dll.p/osdep_w32_keyboard.c.obj libmpv-2.dll.p/osdep_windows_utils.c.obj libmpv-2.dll.p/input_ipc-win.c.obj libmpv-2.dll.p/osdep_main-fn-win.c.obj libmpv-2.dll.p/osdep_path-win.c.obj libmpv-2.dll.p/osdep_subprocess-win.c.obj libmpv-2.dll.p/osdep_terminal-win.c.obj libmpv-2.dll.p/video_out_w32_common.c.obj libmpv-2.dll.p/video_out_win32_displayconfig.c.obj libmpv-2.dll.p/video_out_win32_droptarget.c.obj libmpv-2.dll.p/osdep_glob-win.c.obj libmpv-2.dll.p/audio_chmap_avchannel.c.obj libmpv-2.dll.p/stream_stream_dvdnav.c.obj libmpv-2.dll.p/demux_demux_libarchive.c.obj libmpv-2.dll.p/stream_stream_libarchive.c.obj libmpv-2.dll.p/stream_stream_bluray.c.obj libmpv-2.dll.p/player_lua.c.obj libmpv-2.dll.p/video_filter_vf_fingerprint.c.obj libmpv-2.dll.p/video_zimg.c.obj libmpv-2.dll.p/audio_out_ao_wasapi.c.obj libmpv-2.dll.p/audio_out_ao_wasapi_changenotify.c.obj libmpv-2.dll.p/audio_out_ao_wasapi_utils.c.obj libmpv-2.dll.p/video_out_vo_direct3d.c.obj libmpv-2.dll.p/video_out_placebo_ra_pl.c.obj libmpv-2.dll.p/video_out_placebo_utils.c.obj libmpv-2.dll.p/video_out_vo_gpu_next.c.obj libmpv-2.dll.p/video_out_gpu_next_context.c.obj libmpv-2.dll.p/video_out_gpu_spirv_shaderc.c.obj libmpv-2.dll.p/video_out_d3d11_context.c.obj libmpv-2.dll.p/video_out_d3d11_ra_d3d11.c.obj libmpv-2.dll.p/video_out_gpu_d3d11_helpers.c.obj libmpv-2.dll.p/video_out_vulkan_context.c.obj libmpv-2.dll.p/video_out_vulkan_context_display.c.obj libmpv-2.dll.p/video_out_vulkan_utils.c.obj libmpv-2.dll.p/video_out_vulkan_context_win.c.obj libmpv-2.dll.p/video_cuda.c.obj libmpv-2.dll.p/video_out_hwdec_hwdec_cuda.c.obj libmpv-2.dll.p/video_out_hwdec_hwdec_cuda_vk.c.obj libmpv-2.dll.p/video_d3d.c.obj libmpv-2.dll.p/video_filter_vf_d3d11vpp.c.obj libmpv-2.dll.p/video_out_d3d11_hwdec_d3d11va.c.obj libmpv-2.dll.p/video_out_d3d11_hwdec_dxva2dxgi.c.obj -flto -Wl,--allow-shlib-undefined -Wl,-O1 -shared -Wl,--start-group -Wl,--out-implib=libmpv.dll.a -Wl,--nxcompat,--no-seh,--dynamicbase /root/mpv-winbuild-cmake/build64/install/mingw/lib/libass.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libiconv.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libgdi32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libfontconfig.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libexpat.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libharfbuzz.a -lm /root/mpv-winbuild-cmake/build64/install/mingw/lib/libfribidi.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libfreetype.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libbz2.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libpng16.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libz.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libavutil.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libmfx.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libstdc++.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libole32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libuuid.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libuser32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libbcrypt.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libatomic.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libavcodec.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libvpx.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/liblzma.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libdav1d.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libopus.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libvorbis.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libogg.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libjxl.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libhwy.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libbrotlienc.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libbrotlidec.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libbrotlicommon.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/liblcms2.a -lpthread /root/mpv-winbuild-cmake/build64/install/mingw/lib/libjxl_threads.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libswresample.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libsoxr.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libavformat.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libxml2.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libbluray.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libudfread.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libgmp.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libsrt.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libadvapi32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libshell32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libmingw32.a /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/libgcc.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libmoldname.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libkernel32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libssh.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libmbedtls.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libmbedx509.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libmbedcrypto.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libwsock32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libws2_32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libswscale.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libavfilter.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libmysofa.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libzimg.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libpostproc.a -pthread /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/../../../../x86_64-w64-mingw32/lib/../lib/libavrt.a /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/../../../../x86_64-w64-mingw32/lib/../lib/libdwmapi.a /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/../../../../x86_64-w64-mingw32/lib/../lib/libgdi32.a /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/../../../../x86_64-w64-mingw32/lib/../lib/libole32.a /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/../../../../x86_64-w64-mingw32/lib/../lib/libuuid.a /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/../../../../x86_64-w64-mingw32/lib/../lib/libversion.a /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/../../../../x86_64-w64-mingw32/lib/../lib/libwinmm.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libdvdnav.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libdvdread.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libdvdcss.a /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/../../../../x86_64-w64-mingw32/lib/../lib/libiconv.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libarchive.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/liblzo2.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libavdevice.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libpsapi.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libstrmiids.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/liboleaut32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libshlwapi.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libvfw32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libluajit-5.1.a /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/../../../../x86_64-w64-mingw32/lib/../lib/libatomic.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libuchardet.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libjpeg.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libplacebo.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libversion.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libshaderc_combined.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libvulkan.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libcfgmgr32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libspirv-cross-c-shared.a -lkernel32 -luser32 -lgdi32 -lwinspool -lshell32 -lole32 -loleaut32 -luuid -lcomdlg32 -ladvapi32 -Wl,--end-group
cp mpv*.dll ~/$build_dir/

if ls mpv*.exe 1> /dev/null 2>&1; then
 exit
fi

cd ~/mpv-winbuild-cmake
comment_line mpv "-Dlibmpv=true"

~/mpv/9u-build-mpv.sh

#/root/mpv-winbuild-cmake/build64/install/mingw/lib/libmingwex.a
cd ~/mpv-winbuild-cmake/build64/packages/mpv-prefix/src/mpv-build/
~/mpv-winbuild-cmake/build64/install/bin/x86_64-w64-mingw32-gcc -s -o mpv.exe osdep_mpv.rc_mpv.o mpv.exe.p/audio_aframe.c.obj mpv.exe.p/audio_chmap.c.obj mpv.exe.p/audio_chmap_sel.c.obj mpv.exe.p/audio_decode_ad_lavc.c.obj mpv.exe.p/audio_decode_ad_spdif.c.obj mpv.exe.p/audio_filter_af_drop.c.obj mpv.exe.p/audio_filter_af_format.c.obj mpv.exe.p/audio_filter_af_lavcac3enc.c.obj mpv.exe.p/audio_filter_af_scaletempo.c.obj mpv.exe.p/audio_filter_af_scaletempo2.c.obj mpv.exe.p/audio_filter_af_scaletempo2_internals.c.obj mpv.exe.p/audio_fmt-conversion.c.obj mpv.exe.p/audio_format.c.obj mpv.exe.p/audio_out_ao.c.obj mpv.exe.p/audio_out_ao_lavc.c.obj mpv.exe.p/audio_out_ao_null.c.obj mpv.exe.p/audio_out_ao_pcm.c.obj mpv.exe.p/audio_out_buffer.c.obj mpv.exe.p/common_av_common.c.obj mpv.exe.p/common_av_log.c.obj mpv.exe.p/common_codecs.c.obj mpv.exe.p/common_common.c.obj mpv.exe.p/common_encode_lavc.c.obj mpv.exe.p/common_msg.c.obj mpv.exe.p/common_playlist.c.obj mpv.exe.p/common_recorder.c.obj mpv.exe.p/common_stats.c.obj mpv.exe.p/common_tags.c.obj mpv.exe.p/common_version.c.obj mpv.exe.p/demux_codec_tags.c.obj mpv.exe.p/demux_cue.c.obj mpv.exe.p/demux_cache.c.obj mpv.exe.p/demux_demux.c.obj mpv.exe.p/demux_demux_cue.c.obj mpv.exe.p/demux_demux_disc.c.obj mpv.exe.p/demux_demux_edl.c.obj mpv.exe.p/demux_demux_lavf.c.obj mpv.exe.p/demux_demux_mf.c.obj mpv.exe.p/demux_demux_mkv.c.obj mpv.exe.p/demux_demux_mkv_timeline.c.obj mpv.exe.p/demux_demux_null.c.obj mpv.exe.p/demux_demux_playlist.c.obj mpv.exe.p/demux_demux_raw.c.obj mpv.exe.p/demux_demux_timeline.c.obj mpv.exe.p/demux_ebml.c.obj mpv.exe.p/demux_packet.c.obj mpv.exe.p/demux_timeline.c.obj mpv.exe.p/filters_f_async_queue.c.obj mpv.exe.p/filters_f_autoconvert.c.obj mpv.exe.p/filters_f_auto_filters.c.obj mpv.exe.p/filters_f_decoder_wrapper.c.obj mpv.exe.p/filters_f_demux_in.c.obj mpv.exe.p/filters_f_hwtransfer.c.obj mpv.exe.p/filters_f_lavfi.c.obj mpv.exe.p/filters_f_output_chain.c.obj mpv.exe.p/filters_f_swresample.c.obj mpv.exe.p/filters_f_swscale.c.obj mpv.exe.p/filters_f_utils.c.obj mpv.exe.p/filters_filter.c.obj mpv.exe.p/filters_frame.c.obj mpv.exe.p/filters_user_filters.c.obj mpv.exe.p/input_cmd.c.obj mpv.exe.p/input_event.c.obj mpv.exe.p/input_input.c.obj mpv.exe.p/input_ipc.c.obj mpv.exe.p/input_keycodes.c.obj mpv.exe.p/misc_bstr.c.obj mpv.exe.p/misc_charset_conv.c.obj mpv.exe.p/misc_dispatch.c.obj mpv.exe.p/misc_json.c.obj mpv.exe.p/misc_natural_sort.c.obj mpv.exe.p/misc_node.c.obj mpv.exe.p/misc_rendezvous.c.obj mpv.exe.p/misc_thread_pool.c.obj mpv.exe.p/misc_thread_tools.c.obj mpv.exe.p/options_m_config_core.c.obj mpv.exe.p/options_m_config_frontend.c.obj mpv.exe.p/options_m_option.c.obj mpv.exe.p/options_m_property.c.obj mpv.exe.p/options_options.c.obj mpv.exe.p/options_parse_commandline.c.obj mpv.exe.p/options_parse_configfile.c.obj mpv.exe.p/options_path.c.obj mpv.exe.p/player_audio.c.obj mpv.exe.p/player_client.c.obj mpv.exe.p/player_command.c.obj mpv.exe.p/player_configfiles.c.obj mpv.exe.p/player_external_files.c.obj mpv.exe.p/player_loadfile.c.obj mpv.exe.p/player_main.c.obj mpv.exe.p/player_misc.c.obj mpv.exe.p/player_osd.c.obj mpv.exe.p/player_playloop.c.obj mpv.exe.p/player_screenshot.c.obj mpv.exe.p/player_scripting.c.obj mpv.exe.p/player_sub.c.obj mpv.exe.p/player_video.c.obj mpv.exe.p/stream_cookies.c.obj mpv.exe.p/stream_stream.c.obj mpv.exe.p/stream_stream_avdevice.c.obj mpv.exe.p/stream_stream_cb.c.obj mpv.exe.p/stream_stream_concat.c.obj mpv.exe.p/stream_stream_edl.c.obj mpv.exe.p/stream_stream_file.c.obj mpv.exe.p/stream_stream_lavf.c.obj mpv.exe.p/stream_stream_memory.c.obj mpv.exe.p/stream_stream_mf.c.obj mpv.exe.p/stream_stream_null.c.obj mpv.exe.p/stream_stream_slice.c.obj mpv.exe.p/sub_ass_mp.c.obj mpv.exe.p/sub_dec_sub.c.obj mpv.exe.p/sub_draw_bmp.c.obj mpv.exe.p/sub_filter_sdh.c.obj mpv.exe.p/sub_img_convert.c.obj mpv.exe.p/sub_lavc_conv.c.obj mpv.exe.p/sub_osd.c.obj mpv.exe.p/sub_osd_libass.c.obj mpv.exe.p/sub_sd_ass.c.obj mpv.exe.p/sub_sd_lavc.c.obj mpv.exe.p/video_csputils.c.obj mpv.exe.p/video_decode_vd_lavc.c.obj mpv.exe.p/video_filter_refqueue.c.obj mpv.exe.p/video_filter_vf_format.c.obj mpv.exe.p/video_filter_vf_sub.c.obj mpv.exe.p/video_fmt-conversion.c.obj mpv.exe.p/video_hwdec.c.obj mpv.exe.p/video_image_loader.c.obj mpv.exe.p/video_image_writer.c.obj mpv.exe.p/video_img_format.c.obj mpv.exe.p/video_mp_image.c.obj mpv.exe.p/video_mp_image_pool.c.obj mpv.exe.p/video_out_aspect.c.obj mpv.exe.p/video_out_bitmap_packer.c.obj mpv.exe.p/video_out_dither.c.obj mpv.exe.p/video_out_dr_helper.c.obj mpv.exe.p/video_out_filter_kernels.c.obj mpv.exe.p/video_out_gpu_context.c.obj mpv.exe.p/video_out_gpu_error_diffusion.c.obj mpv.exe.p/video_out_gpu_hwdec.c.obj mpv.exe.p/video_out_gpu_lcms.c.obj mpv.exe.p/video_out_gpu_libmpv_gpu.c.obj mpv.exe.p/video_out_gpu_osd.c.obj mpv.exe.p/video_out_gpu_ra.c.obj mpv.exe.p/video_out_gpu_shader_cache.c.obj mpv.exe.p/video_out_gpu_spirv.c.obj mpv.exe.p/video_out_gpu_user_shaders.c.obj mpv.exe.p/video_out_gpu_utils.c.obj mpv.exe.p/video_out_gpu_video.c.obj mpv.exe.p/video_out_gpu_video_shaders.c.obj mpv.exe.p/video_out_libmpv_sw.c.obj mpv.exe.p/video_out_vo.c.obj mpv.exe.p/video_out_vo_gpu.c.obj mpv.exe.p/video_out_vo_image.c.obj mpv.exe.p/video_out_vo_lavc.c.obj mpv.exe.p/video_out_vo_libmpv.c.obj mpv.exe.p/video_out_vo_null.c.obj mpv.exe.p/video_out_vo_tct.c.obj mpv.exe.p/video_out_win_state.c.obj mpv.exe.p/video_repack.c.obj mpv.exe.p/video_sws_utils.c.obj mpv.exe.p/osdep_io.c.obj mpv.exe.p/osdep_semaphore_osx.c.obj mpv.exe.p/osdep_subprocess.c.obj mpv.exe.p/osdep_threads.c.obj mpv.exe.p/osdep_timer.c.obj mpv.exe.p/ta_ta.c.obj mpv.exe.p/ta_ta_talloc.c.obj mpv.exe.p/ta_ta_utils.c.obj mpv.exe.p/osdep_win32_pthread.c.obj mpv.exe.p/osdep_timer-win2.c.obj mpv.exe.p/osdep_w32_keyboard.c.obj mpv.exe.p/osdep_windows_utils.c.obj mpv.exe.p/input_ipc-win.c.obj mpv.exe.p/osdep_main-fn-win.c.obj mpv.exe.p/osdep_path-win.c.obj mpv.exe.p/osdep_subprocess-win.c.obj mpv.exe.p/osdep_terminal-win.c.obj mpv.exe.p/video_out_w32_common.c.obj mpv.exe.p/video_out_win32_displayconfig.c.obj mpv.exe.p/video_out_win32_droptarget.c.obj mpv.exe.p/osdep_glob-win.c.obj mpv.exe.p/audio_chmap_avchannel.c.obj mpv.exe.p/stream_stream_dvdnav.c.obj mpv.exe.p/demux_demux_libarchive.c.obj mpv.exe.p/stream_stream_libarchive.c.obj mpv.exe.p/stream_stream_bluray.c.obj mpv.exe.p/player_lua.c.obj mpv.exe.p/video_filter_vf_fingerprint.c.obj mpv.exe.p/video_zimg.c.obj mpv.exe.p/audio_out_ao_wasapi.c.obj mpv.exe.p/audio_out_ao_wasapi_changenotify.c.obj mpv.exe.p/audio_out_ao_wasapi_utils.c.obj mpv.exe.p/video_out_vo_direct3d.c.obj mpv.exe.p/video_out_placebo_ra_pl.c.obj mpv.exe.p/video_out_placebo_utils.c.obj mpv.exe.p/video_out_vo_gpu_next.c.obj mpv.exe.p/video_out_gpu_next_context.c.obj mpv.exe.p/video_out_gpu_spirv_shaderc.c.obj mpv.exe.p/video_out_d3d11_context.c.obj mpv.exe.p/video_out_d3d11_ra_d3d11.c.obj mpv.exe.p/video_out_gpu_d3d11_helpers.c.obj mpv.exe.p/video_out_vulkan_context.c.obj mpv.exe.p/video_out_vulkan_context_display.c.obj mpv.exe.p/video_out_vulkan_utils.c.obj mpv.exe.p/video_out_vulkan_context_win.c.obj mpv.exe.p/video_cuda.c.obj mpv.exe.p/video_out_hwdec_hwdec_cuda.c.obj mpv.exe.p/video_out_hwdec_hwdec_cuda_vk.c.obj mpv.exe.p/video_d3d.c.obj mpv.exe.p/video_filter_vf_d3d11vpp.c.obj mpv.exe.p/video_out_d3d11_hwdec_d3d11va.c.obj mpv.exe.p/video_out_d3d11_hwdec_dxva2dxgi.c.obj -flto -Wl,--allow-shlib-undefined -Wl,-O1 -Wl,--nxcompat,--no-seh,--dynamicbase -Wl,--start-group /root/mpv-winbuild-cmake/build64/install/mingw/lib/libass.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libiconv.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libgdi32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libfontconfig.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libexpat.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libharfbuzz.a -lm /root/mpv-winbuild-cmake/build64/install/mingw/lib/libfribidi.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libfreetype.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libbz2.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libpng16.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libz.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libavutil.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libmfx.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libstdc++.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libole32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libuuid.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libuser32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libbcrypt.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libatomic.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libavcodec.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libvpx.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/liblzma.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libdav1d.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libopus.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libvorbis.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libogg.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libjxl.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libhwy.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libbrotlienc.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libbrotlidec.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libbrotlicommon.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/liblcms2.a -lpthread /root/mpv-winbuild-cmake/build64/install/mingw/lib/libjxl_threads.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libswresample.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libsoxr.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libavformat.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libxml2.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libbluray.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libudfread.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libgmp.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libsrt.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libadvapi32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libshell32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libmingw32.a /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/libgcc.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libmoldname.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libkernel32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libssh.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libmbedtls.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libmbedx509.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libmbedcrypto.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libwsock32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libws2_32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libswscale.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libavfilter.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libmysofa.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libzimg.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libpostproc.a -pthread /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/../../../../x86_64-w64-mingw32/lib/../lib/libavrt.a /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/../../../../x86_64-w64-mingw32/lib/../lib/libdwmapi.a /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/../../../../x86_64-w64-mingw32/lib/../lib/libgdi32.a /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/../../../../x86_64-w64-mingw32/lib/../lib/libole32.a /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/../../../../x86_64-w64-mingw32/lib/../lib/libuuid.a /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/../../../../x86_64-w64-mingw32/lib/../lib/libversion.a /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/../../../../x86_64-w64-mingw32/lib/../lib/libwinmm.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libdvdnav.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libdvdread.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libdvdcss.a /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/../../../../x86_64-w64-mingw32/lib/../lib/libiconv.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libarchive.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/liblzo2.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libavdevice.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libpsapi.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libstrmiids.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/liboleaut32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libshlwapi.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libvfw32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libluajit-5.1.a /root/mpv-winbuild-cmake/build64/install/lib/gcc/x86_64-w64-mingw32/12.1.1/../../../../x86_64-w64-mingw32/lib/../lib/libatomic.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libuchardet.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libjpeg.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libplacebo.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libversion.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libshaderc_combined.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libvulkan.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libcfgmgr32.a /root/mpv-winbuild-cmake/build64/install/mingw/lib/libspirv-cross-c-shared.a -Wl,--subsystem,windows:6.0 -lkernel32 -luser32 -lgdi32 -lwinspool -lshell32 -lole32 -loleaut32 -luuid -lcomdlg32 -ladvapi32 -Wl,--end-group
cp *.exe ~/$build_dir/


cd ~/$build_dir
ls -g -o --time-style=iso
