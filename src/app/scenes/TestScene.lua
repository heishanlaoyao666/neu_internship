--[[
    TestScene.lua
    大厅
    描述：测试场景
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local TestScene = class("LobbyScene", function()
    return display.newScene("LobbyScene")
end)
local PlayerData = require("app.data.PlayerData")


--[[--
    构造函数

    @param none

    @return none
]]
function TestScene:ctor()

    PlayerData:initCard()
    print(varDump(PlayerData:getAllCard()))
    print("Hello ")

end


--[[--
    帧循环

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function TestScene:update(dt)
end

return TestScene