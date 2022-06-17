--[[--
    信息层
    InfoLayer.lua
]]
local InfoLayer = class("InfoLayer", require("app.ui.layer.BaseLayer"))
local ConstDef = require("app.def.ConstDef")
local GameData = require("app.data.GameData")

--[[--
    构造函数

    @param none

    @return none
]]
function InfoLayer:ctor()
    InfoLayer.super.ctor(self)

    self.lifeLabelBmf_ = nil -- 类型：TextBMFont，生命值
    self.scoreLabelBmf_ = nil -- 类型：TextBMFont，分值

    self:initView()
end

--[[--
    界面初始化
    
    @param none

    @return none
]]
function InfoLayer:initView()
    local width, height = display.width, display.height
    self.container_ = ccui.Layout:create()
    --self.container_:setBackGroundColor(cc.c3b(200, 0, 0))
    --self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 1)
    self.container_:setPosition(width, height)

    --左移动按钮
    local leftmoveBtn = ccui.Button:create("c_2.png")
    self.container_:addChild(leftmoveBtn)
    leftmoveBtn:setAnchorPoint(0.5, 0.5)
    leftmoveBtn:setPosition(display.cx-50, height * 0.2)
    leftmoveBtn:addTouchEventListener(function(sender, eventType) 
        if eventType == 2 then
            GameData:blockMoveTo(1,0)
        end
    end)
    --右移动按钮
    local rightmoveBtn = ccui.Button:create("c_2.png")
    self.container_:addChild(rightmoveBtn)
    rightmoveBtn:setAnchorPoint(0.5, 0.5)
    rightmoveBtn:setRotation(180)
    rightmoveBtn:setPosition(display.cx-50, height * 0.1)
    rightmoveBtn:addTouchEventListener(function(sender, eventType) 
        if eventType == 2 then
            GameData:blockMoveTo(-1,0)
        end
    end)
    --右旋转按钮
    local rightrotationBtn = ccui.Button:create("c_1.png")
    self.container_:addChild(rightrotationBtn)
    rightrotationBtn:setAnchorPoint(0.5, 0.5)
    rightrotationBtn:setRotation(180)
    rightrotationBtn:setPosition(display.cx-50, height * 0.3)
    rightrotationBtn:addTouchEventListener(function(sender, eventType) 
        if eventType == 2 then
            GameData:rotationBlock(ConstDef.ROTATION_DIRECTION.RIGHT)
        end
    end)

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

