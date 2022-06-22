--[[--
    信息层
    TopInfoLayer.lua
]]
local ShopLayer = class("ShopLayer", require("src\\app\\ui\\outgame\\layer\\BaseLayer.lua"))
-- local ShopLayer = class("ShopLayer", function()
--     return display.newScene("ShopLayer")
-- end)
-- local ConstDef = require("app.def.ConstDef")
-- local GameData = require("app.data.GameData")

--[[--
    构造函数

    @param none

    @return none
]]
function ShopLayer:ctor()
    ShopLayer.super.ctor(self)

    -- self.lifeLabelBmf_ = nil -- 类型：TextBMFont，生命值
    -- self.scoreLabelBmf_ = nil -- 类型：TextBMFont，分值

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function ShopLayer:initView()
    local width, height = display.width, 1120
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, display.cy)
    print(display.height)

    local sprite = display.newSprite("res\\美术资源\\大厅（游戏外）\\商店界面\\底图-商店界面.png")
    self.container_:addChild(sprite)
    sprite:setAnchorPoint(0.5, 0.5)
    sprite:setPosition(width/2,height/2)

    local sprite1 = display.newSprite("res\\美术资源\\大厅（游戏外）\\商店界面\\金币商店\\底图-标题栏.png")
    self.container_:addChild(sprite1)
    sprite1:setAnchorPoint(0.5, 1)
    sprite1:setPosition(width/2,height-100)

    local sprite2 = display.newSprite("res\\美术资源\\大厅（游戏外）\\商店界面\\金币商店\\标题-金币商店.png")
    self.container_:addChild(sprite2)
    sprite2:setAnchorPoint(0.5, 1)
    sprite2:setPosition(width/2,height-110)






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
function ShopLayer:update(dt)
    -- self.lifeLabelBmf_:setString(tostring(GameData:getLife()))
    -- self.scoreLabelBmf_:setString(tostring(GameData:getScore()))
end

return ShopLayer

