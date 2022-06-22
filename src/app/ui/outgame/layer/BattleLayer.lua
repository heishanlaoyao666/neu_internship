--[[--
    信息层
    TopInfoLayer.lua
]]
local BattleLayer = class("BattleLayer", require("src\\app\\ui\\outgame\\layer\\BaseLayer.lua"))
-- local ConstDef = require("app.def.ConstDef")
-- local GameData = require("app.data.GameData")

--[[--
    构造函数

    @param none

    @return none
]]
function BattleLayer:ctor()
    BattleLayer.super.ctor(self)

    -- self.lifeLabelBmf_ = nil -- 类型：TextBMFont，生命值
    -- self.scoreLabelBmf_ = nil -- 类型：TextBMFont，分值

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function BattleLayer:initView()
    local width, height = display.width, 1120
    self.container_ = ccui.Layout:create()
    -- self.container_:setBackGroundColor(cc.c3b(200, 0, 0))
    -- self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(display.width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, display.cy)
    print(display.height)

    local sprite = display.newSprite("res\\美术资源\\大厅（游戏外）\\战斗界面\\底图-战斗界面.png")
    self.container_:addChild(sprite)
    --sprite1:setContentSize(width, height)
    sprite:setAnchorPoint(0.5, 0.5)
    sprite:setPosition(width/2,height/2)

    local button = ccui.Button:create("res\\美术资源\\大厅（游戏外）\\战斗界面\\按钮-对战模式.png")
    self.container_:addChild(button)
    button:setAnchorPoint(0.5, 0.5)
    button:setPosition(width/2, height/2-100)
    button:addTouchEventListener(function(sender, eventType)
        -- ccui.TouchEventType
        if 2 == eventType then -- touch end
            -- body
            local AnotherScene=require("src\\app\\ui\\outgame\\layer\\ShopLayer.lua"):new()
            display.replaceScene(AnotherScene, "moveInL", 0.5)
        end
    end)




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
function BattleLayer:update(dt)
    -- self.lifeLabelBmf_:setString(tostring(GameData:getLife()))
    -- self.scoreLabelBmf_:setString(tostring(GameData:getScore()))
end

return BattleLayer

