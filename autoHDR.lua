-- Auto HDR v1.0
-- If Windows HDR is already enabled the script will exit, if HDR is disabled and it detects an HDR video it enables HDR at the start of playback and disables HDR at the end
-- Script uses HDRCmd from HDRTray for Windows HDR checking and switching
-- Download HDRTray (https://github.com/res2k/HDRTray/releases) and adjust path to HDRCmd.exe below

require "mp.msg"
require "mp.options"

local HDR_CMD = '"C:\\path\\to\\HDRCmd.exe"'

local HDR_enabled = false

mp.register_event("end-file", function()
    if HDR_enabled then
        os.execute(HDR_CMD .. " off")
        HDR_enabled = false
    end
end)

mp.observe_property("video-params", "native", function(_, params)
    if not params or not params.primaries then
        return
    end
    
    if params.primaries == "bt.2020" then
        if not HDR_enabled then
            local handle = io.popen(HDR_CMD .. " status")
            local result
            if handle then
                result = handle:read("*l")
                handle:close()
            end
            if not result or not result:match("on$") then
                os.execute(HDR_CMD .. " on")
                HDR_enabled = true
            end
        end
    elseif HDR_enabled then
        os.execute(HDR_CMD .. " off")
        HDR_enabled = false
    end
end)
