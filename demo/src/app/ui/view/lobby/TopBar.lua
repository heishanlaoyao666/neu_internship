--[[
    TopBar.lua
    TopBar顶部栏
    描述：TopBar顶部栏
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local TopBar = class("TopBar", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)

local BGLayer = require("app.ui.layer.lobby.top.BGLayer")
local InfoLayer = require("app.ui.layer.lobby.top.InfoLayer")
local SpriteLayer = require("app.ui.layer.lobby.top.SpriteLayer")

--[[--
    构造函数

    @param none

    @return none
]]
function TopBar:ctor()
    self.bgLayer_ = nil -- 类型：BGLayer，背景层
    self.infoLayer_ = nil -- 类型：InfoLayer，信息层
    self.spriteLayer_ = nil -- 类型：MenuLayer，菜单层
    self.avatarDialog_ = nil

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
function TopBar:initView()

    self.bgLayer_ = BGLayer.new()
    self:addChild(self.bgLayer_)

    self.infoLayer_ = InfoLayer.new()
    self:addChild(self.infoLayer_)

    self.spriteLayer_ = SpriteLayer.new()
    self:addChild(self.spriteLayer_)

end

--[[--
    节点进入

    @param none

    @return none
]]
function TopBar:onEnter()
end

--[[--
    节点退出

    @param none

    @return none
]]
function TopBar:onExit()
end


return TopBar