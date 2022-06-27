
 
local SettingMusic = {}

local isMusic1 = false
local isMusic2 = false
local isMusic3 = false

function SettingMusic:isMusic1()
    return isMusic1
end

function SettingMusic:setMusic1(isOn)
    isMusic1 = isOn 
    return isMusic1
end

function SettingMusic:isMusic2()
    return isMusic2
end

function SettingMusic:setMusic2(isOn)
    isMusic2 = isOn 
    return isMusic2
end

function SettingMusic:isMusic3()
    return isMusic3
end

function SettingMusic:setMusic3(isOn)
    isMusic3 = isOn 
    return isMusic3
end

return SettingMusic