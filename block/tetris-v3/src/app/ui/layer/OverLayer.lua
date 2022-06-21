--[[--
    游戏结束层
    OverLayer.lua
]]
local OverLayer = class("OverLayer", require("app.ui.layer.BaseLayer"))
local ConstDef = require("app.def.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

--[[--
    构造函数

    @param none

    @return none
]]
function OverLayer:ctor(gameData)

    OverLayer.super.ctor(self)

    self.gameData_ = gameData

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function OverLayer:initView()

    -- 重新开始
    local restartImages = {
        normal =  ConstDef.BUTTON_RESTART,
        pressed = ConstDef.BUTTON_RESTART,
        disabled = ConstDef.BUTTON_RESTART
    }

    self.restartBtn = ccui.Button:create(restartImages["normal"], restartImages["pressed"], restartImages["disabled"])
    self.restartBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    -- 居中
    self.restartBtn:setPosition(cc.p(display.cx, display.cy + 60))
    -- 设置是否禁用(false为禁用)
    self.restartBtn:setEnabled(true)
    self.restartBtn:addClickEventListener(function ()
        EventManager:doEvent(EventDef.ID.RESTART_GAME)
    end)

    self:addChild(self.restartBtn)


    -- 退出游戏
    local exitImages = {
        normal = ConstDef.BUTTON_EXIT,
        pressed = ConstDef.BUTTON_EXIT,
        disabled = ConstDef.BUTTON_EXIT
    }

    self.exitBtn = ccui.Button:create(exitImages["normal"], exitImages["pressed"], exitImages["disabled"])
    self.exitBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    -- 居中
    self.exitBtn:setPosition(cc.p(display.cx, display.cy - 60))
    -- 设置是否禁用(false为禁用)
    self.exitBtn:setEnabled(true)
    self.exitBtn:addClickEventListener(function ()
        EventManager:doEvent(EventDef.ID.EXIT_GAME)
    end)

    self:addChild(self.exitBtn)

end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function OverLayer:update(dt)

end

return OverLayer

