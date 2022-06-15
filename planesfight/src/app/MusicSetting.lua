
local MusicSetting = class("MusicSetting", function()
    return display.newScene("MusicSetting")
end)

local SettingMusic = {}

local isMusic = true

function MusicSetting:isMusic()
    return isMusic
end

function MusicSetting:setMusic(isOn)
    isMusic = isOn
    return isMusic
end


function MusicSetting:ctor()

end


function MusicSetting:onEnter()

end

function MusicSetting:onExit()
end

return MusicSetting
