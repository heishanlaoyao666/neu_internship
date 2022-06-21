--[[--
    游戏主界面
    LoadView.lua
]]
local LoadView = class("LoadView", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)
local LoadBGLayer = require("app.ui.outgame.layer.LoadBGLayer")
local LoadInfoLayer = require("app.ui.outgame.layer.LoadInfoLayer")


--[[--
    构造函数

    @param none

    @return none
]]
function LoadView:ctor()
    self.bgLayer_ = nil -- 加载背景层
    self.loadInfoLayer_ = nil -- 加载信息层

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function LoadView:initView()
    self.bgLayer_ = LoadBGLayer.new()
    self:addChild(self.bgLayer_)

    self.loadInfoLayer_ = LoadInfoLayer.new()
    self:addChild(self.loadInfoLayer_)
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function LoadView:update(dt)
    self.loadInfoLayer_:update(dt)
end

return LoadView