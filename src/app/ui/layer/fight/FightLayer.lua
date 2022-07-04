--[[--
    背景层
    FightLayer.lua
    编写：李昊
]]
local FightLayer = class("FightLayer", require("app.ui.layer.BaseLayer"))

--[[--
    构造函数

    @param none

    @return none
]]
function FightLayer:ctor()
    FightLayer.super.ctor(self)
    self:initView()
end

--[[--
    界面初始化
    
    @param none

    @return none
]]
function FightLayer:initView()

end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔

    @return none
]]
function FightLayer:update(dt)
end

return FightLayer