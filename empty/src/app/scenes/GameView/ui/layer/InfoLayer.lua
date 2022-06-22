--[[--
    信息层
    InfoLayer.lua
]]
local InfoLayer = class("InfoLayer", require("app/scenes/GameView/ui/layer/BaseLayer.lua"))
local ConstDef = require("app/def/ConstDef")
local GameData = require("app/data/GameData")

--[[--
    构造函数

    @param none

    @return none
]]
function InfoLayer:ctor()
    InfoLayer.super.ctor(self)

    -- self.spLabelBmf_ = nil -- 类型：TextBMFont，sp点数
    -- self.scoreLabelBmf_ = nil -- 类型：TextBMFont，分值

    self:initView()
end

--[[--
    界面初始化
    
    @param none

    @return none
]]
function InfoLayer:initView()
    -- local width, height = display.width, 80
    -- self.container_ = ccui.Layout:create()
    -- --self.container_:setBackGroundColor(cc.c3b(200, 0, 0))
    -- --self.container_:setBackGroundColorType(1)
    -- self.container_:setContentSize(display.width, height)
    -- self.container_:addTo(self)
    -- self.container_:setAnchorPoint(0.5, 1)
    -- self.container_:setPosition(display.cx, display.height)

    -- local pauseBtn = ccui.Button:create("ui/battle/uiPause.png")
    -- self.container_:addChild(pauseBtn)
    -- pauseBtn:setAnchorPoint(0, 0.5)
    -- pauseBtn:setPosition(5, height * 0.5)
    -- pauseBtn:addTouchEventListener(function(sender, eventType) 
    --     if eventType == 2 then
    --         GameData:setGameState(ConstDef.GAME_STATE.PAUSE)
    --     end
    -- end)

    -- local life = ccui.ImageView:create("ui/battle/life.png")
    -- life:setAnchorPoint(1, 0.5)
    -- life:setPosition(display.cx - 70, height * 0.5)
    -- self.container_:addChild(life)

    -- self.lifeLabelBmf_ = ccui.TextBMFont:create(tostring(GameData:getLife()), "ui/battle/num_account.fnt")
    -- self.lifeLabelBmf_:setAnchorPoint(0, 0.5)
    -- self.lifeLabelBmf_:setPosition(life:getPositionX() + 5, height * 0.5 + 3)
    -- self.lifeLabelBmf_:setScale(0.6)
    -- self.container_:addChild(self.lifeLabelBmf_)

    -- local score = ccui.ImageView:create("ui/battle/score.png")
    -- score:setAnchorPoint(1, 0.5)
    -- score:setPosition(life:getPositionX() + 170, height * 0.5)
    -- self.container_:addChild(score)

    -- self.scoreLabelBmf_ = ccui.TextBMFont:create(tostring(GameData:getScore()), "ui/battle/num_account.fnt")
    -- self.scoreLabelBmf_:setAnchorPoint(0, 0.5)
    -- self.scoreLabelBmf_:setPosition(score:getPositionX() + 5, height * 0.5 + 3)
    -- self.scoreLabelBmf_:setScale(0.6)
    -- self.container_:addChild(self.scoreLabelBmf_)
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function InfoLayer:update(dt)
    -- self.lifeLabelBmf_:setString(tostring(GameData:getLife()))
    -- self.scoreLabelBmf_:setString(tostring(GameData:getScore()))
end

return InfoLayer

