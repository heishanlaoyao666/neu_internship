
 
--Music = 1--默认开启音效
local SettingMusic = {}

local isMusic = false

function SettingMusic:isMusic()
    return isMusic
end

function SettingMusic:setMusic(isOn)
    isMusic = isOn 
    return isMusic
end

return SettingMusic