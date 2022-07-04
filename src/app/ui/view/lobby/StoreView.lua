--[[
    StoreView.lua
    Store界面
    描述：Store界面
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local StoreView = class("StoreView", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)

local BGLayer = require("app.ui.layer.lobby.store.BGLayer")
local SpriteLayer = require("app.ui.layer.lobby.store.SpriteLayer")

--[[--
    构造函数

    @param none

    @return none
]]
function StoreView:ctor()
    self.bgLayer_ = nil -- 类型：BGLayer，背景层
    self.spriteLayer_ = nil -- 类型：SpriteLayer，精灵层

    self:initView()

    self:registerScriptHandler(function(event)
        if event == "enter" then
            self:onEnter()
        elseif event == "exit" then
            self:onExit()
        end
    end)
end

--[[--
    界面初始化

    @param none

    @return none
]]
function StoreView:initView()
    self.bgLayer_ = BGLayer.new()
    self:addChild(self.bgLayer_)

    self.spriteLayer_ = SpriteLayer.new()
    self:addChild(self.spriteLayer_)
end

--[[--
    节点进入

    @param none

    @return none
]]
function StoreView:onEnter()
end

--[[--
    节点退出

    @param none

    @return none
]]
function StoreView:onExit()
end


return StoreView