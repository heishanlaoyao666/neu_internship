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
    -- 顶部栏背景图 - 720 * 153
    local topBarBG = display.newSprite("image/lobby/top/topbar_bg.png")
    topBarBG:setScale(self.bgScaleFactor_)
    topBarBG:setAnchorPoint(0.5, 0.5)
    topBarBG:setPosition(display.cx, display.size.height - topBarBG:getContentSize().height/2)
    self:addChild(topBarBG)

    -- 昵称背景图 - 298 * 93
    local nicknameBG = display.newSprite("image/lobby/top/nickname_bg.png")
    nicknameBG:setScale(self.bgScaleFactor_)
    nicknameBG:setAnchorPoint(0.8, 0.5)
    nicknameBG:setPosition(topBarBG:getPositionX(), topBarBG:getPositionY())
    self:addChild(nicknameBG)

    -- 奖杯图标
    local trophyIcon = display.newSprite("image/lobby/top/trophy_icon.png")
    trophyIcon:setScale(self.bgScaleFactor_)
    trophyIcon:setAnchorPoint(6, 1.2)
    trophyIcon:setPosition(nicknameBG:getPositionX(), nicknameBG:getPositionY())
    self:addChild(trophyIcon)

    -- 钻石背景图 - 147 * 37
    local diamondBG = display.newSprite("image/lobby/top/resource_bg.png")
    diamondBG:setScale(self.bgScaleFactor_)
    diamondBG:setAnchorPoint(-0.7, -0.1)
    diamondBG:setPosition(topBarBG:getPositionX(), topBarBG:getPositionY())
    self:addChild(diamondBG)

    -- 金币背景图 - 147 * 37
    local goldBG = display.newSprite("image/lobby/top/resource_bg.png")
    goldBG:setScale(self.bgScaleFactor_)
    goldBG:setAnchorPoint(-0.7, 1.2)
    goldBG:setPosition(topBarBG:getPositionX(), topBarBG:getPositionY())
    self:addChild(goldBG)

    -- 钻石图标 - 42 * 40
    local diamondIcon = display.newSprite("image/lobby/top/diamond_icon.png")
    diamondIcon:setScale(self.bgScaleFactor_)
    diamondIcon:setAnchorPoint(-2, 1.2)
    diamondIcon:setPosition(diamondBG:getPositionX(), diamondBG:getPositionY())
    self:addChild(diamondIcon)

    -- 金币图标 - 43 * 38
    local goldIcon = display.newSprite("image/lobby/top/gold_icon.png")
    goldIcon:setScale(self.bgScaleFactor_)
    goldIcon:setAnchorPoint(-2, -0.1)
    goldIcon:setPosition(goldBG:getPositionX(), goldBG:getPositionY())
    self:addChild(goldIcon)

end

return BGLayer