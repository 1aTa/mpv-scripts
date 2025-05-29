# mpv-scipts

## autoHDR.lua

Automatically switches Windows SDR and HDR modes for HDR passthrough based on the content of the video being played by mpv.

If Windows HDR is already enabled the script will exit, if HDR is disabled and it detects an HDR video it enables HDR at the start of playback and disables HDR at the end.

Requires HDRCmd from [HDRTray](https://github.com/res2k/HDRTray/releases)
