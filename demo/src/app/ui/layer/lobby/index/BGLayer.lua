--[[
    BGLayer.lua
    背景层
    描述：背景层
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local BGLayer = class("BGLayer", require("app.ui.layer.BaseLayer"))

--[[--
    构造函数

    @param none

    @return none
]]
function BGLayer:ctor()
    BGLayer.super.ctor(self)
    self.bgScaleFactor_ = 1 -- 类型：number，背景缩放系数

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function BGLayer:initView()
    -- 主页背景 - 1280 * 720
    local indexBG = display.newSprite("image/lobby/index/index_bg.png")
    indexBG:setScale(self.bgScaleFactor_)
    indexBG:setAnchorPoint(0.5, 0.5)
    indexBG:setPosition(display.cx, display.cy)
    self:addChild(indexBG)

end

return BGLayer