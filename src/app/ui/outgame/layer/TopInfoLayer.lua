--[[--
    信息层
    TopInfoLayer.lua
]]
local TopInfoLayer = class("TopInfoLayer", require("src\\app\\ui\\outgame\\layer\\BaseLayer.lua"))
-- local ConstDef = require("app.def.ConstDef")
-- local GameData = require("app.data.GameData")

--[[--
    构造函数

    @param none

    @return none
]]
function TopInfoLayer:ctor()
    TopInfoLayer.super.ctor(self)

    -- self.lifeLabelBmf_ = nil -- 类型：TextBMFont，生命值
    -- self.scoreLabelBmf_ = nil -- 类型：TextBMFont，分值

    self:initView()
end

--[[--
    界面初始化
    
    @param none

    @return none
]]
function TopInfoLayer:initView()
    local width, height = display.width, 80
    self.container_ = ccui.Layout:create()
    --self.container_:setBackGroundColor(cc.c3b(200, 0, 0))
    --self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(display.width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 1)
    self.container_:setPosition(display.cx, display.height)

    --底图
    local sprite = display.newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\base_topbar.png")
    self.container_:addChild(sprite)
    sprite:setContentSize(width, height)
    sprite:setAnchorPoint(0.5, 1)
    sprite:setPosition(width/2, 0)

    --昵称底图
    local sprite2 = display.newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\base_nickname.png")
    self.container_:addChild(sprite2)
    sprite2:setContentSize(width/2, height/2)
    sprite2:setAnchorPoint(0.5, 1)
    sprite2:setPosition(width/2-50, 0)

    --默认头像
    local sprite1 = display.newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\default_avatar.png")
    self.container_:addChild(sprite1)
    --sprite1:setContentSize(width, height)
    sprite1:setAnchorPoint(0.5, 1)
    sprite1:setPosition(width/2-280, height/2+20)

    --砖石和金币底图
    local sprite6 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\base_Diamonds&goldcoins.png")
    self.container_:addChild(sprite6)
    --sprite6:setScale(0.4)
    sprite6:setAnchorPoint(0.5, 1)
    sprite6:setPosition(width/2+190, 50)

    --金币
    local sprite3 = display.newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\goldcoin.png")
    self.container_:addChild(sprite3)
    --sprite3:setContentSize(width, height)
    sprite3:setAnchorPoint(0.5, 1)
    sprite3:setPosition(width/2+120, 50)

    --砖石和金币底图
    local sprite7 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\base_Diamonds&goldcoins.png")
    self.container_:addChild(sprite7)
    --sprite7:setScale(0.4)
    sprite7:setAnchorPoint(0.5, 1)
    sprite7:setPosition(width/2+190, 0)

    --砖石
    local sprite4 = display.newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\diamonds.png")
    self.container_:addChild(sprite4)
    --sprite4:setContentSize(width, height)
    sprite4:setAnchorPoint(0.5, 1)
    sprite4:setPosition(width/2+120, 0)

    --菜单按钮
    local sprite5 = display.newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\button_menu.png")
    self.container_:addChild(sprite5)
    sprite5:setAnchorPoint(0.5, 1)
    sprite5:setPosition(width/2+310, 40)

    --奖杯
    local sprite8 = display.newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\trophy.png")
    self.container_:addChild(sprite8)
    sprite8:setContentSize(width/2, height/2)
    sprite8:setAnchorPoint(0.5, 1)
    sprite8:setPosition(width/2-40, 10)

end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function TopInfoLayer:update(dt)
    -- self.lifeLabelBmf_:setString(tostring(GameData:getLife()))
    -- self.scoreLabelBmf_:setString(tostring(GameData:getScore()))
end

return TopInfoLayer

