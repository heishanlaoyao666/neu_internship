--[[--
    砖石商店层
    DiamondShopLayer.lua
]]
local DiamondShopLayer = class("DiamondShopLayer", require("app.ui.outgame.layer.BaseLayer"))
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
local ObtainItemLayer = require("app.ui.outgame.layer.ObtainItemLayer")
--[[--
    构造函数

    @param none

    @return none
]]
function DiamondShopLayer:ctor()
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function DiamondShopLayer:initView()
    local width, height = display.width, 1120
    --商店界面
    self.container_1 = ccui.Layout:create()
    self.container_1:setContentSize(display.width, height)
    self.container_1:setPosition(0, 0)
    self.container_1:addTo(self)

    --砖石商城
    local spriteB10 = display.newSprite("artcontent/lobby(ongame)/store/diamondstore/basemap_diamondstore.png")
    self.container_1:addChild(spriteB10)
    spriteB10:setAnchorPoint(0.5, 0)
    spriteB10:setPosition(width/2,650)

    local spriteB11 = display.newSprite("artcontent/lobby(ongame)/store/diamondstore/title_diamondstore.png")
    self.container_1:addChild(spriteB11)
    spriteB11:setAnchorPoint(0.5, 0)
    spriteB11:setPosition(width/2,660)

    --普通宝箱
    local spriteB12 = ccui.Button:create("artcontent/lobby(ongame)/store/diamondstore/basemap_normal.png")
    self.container_1:addChild(spriteB12)
    spriteB12:setAnchorPoint(0.5, 0)
    spriteB12:setPosition(120,350)
    spriteB12:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/open_box.OGG",false)
                end
                ObtainItemLayer:SetData(1,285)
                EventManager:doEvent(EventDef.ID.OBTAINITEM)
            end
        end
    )

    local spriteB13 = display.newSprite("artcontent/lobby(ongame)/store/diamondstore/chest_normal.png")
    self.container_1:addChild(spriteB13)
    spriteB13:setAnchorPoint(0.5, 0)
    spriteB13:setPosition(120,420)


    local spriteB14 = display.newSprite("artcontent/lobby(ongame)/store/diamondstore/titile_diamond.png")
    self.container_1:addChild(spriteB14)
    spriteB14:setAnchorPoint(0.5, 0)
    spriteB14:setPosition(90,370)
    display.newTTFLabel({
        text = "150",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, 140,390)
    :addTo(self.container_1)


    --稀有宝箱
    local spriteB15 = ccui.Button:create("artcontent/lobby(ongame)/store/diamondstore/basemap_rare.png")
    self.container_1:addChild(spriteB15)
    spriteB15:setAnchorPoint(0.5, 0)
    spriteB15:setPosition(width/3+120,350)
    spriteB15:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/open_box.OGG",false)
                end
                ObtainItemLayer:SetData(2,456)
                EventManager:doEvent(EventDef.ID.OBTAINITEM)
            end
        end
    )

    local spriteB16 = display.newSprite("artcontent/lobby(ongame)/store/diamondstore/chest_rare.png")
    self.container_1:addChild(spriteB16)
    spriteB16:setAnchorPoint(0.5, 0)
    spriteB16:setPosition(width/3+120,420)

    local spriteB17 = display.newSprite("artcontent/lobby(ongame)/store/diamondstore/titile_diamond.png")
    self.container_1:addChild(spriteB17)
    spriteB17:setAnchorPoint(0.5, 0)
    spriteB17:setPosition(width/3+90,370)
    display.newTTFLabel({
        text = "250",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, width/3+140,390)
    :addTo(self.container_1)

    --史诗宝箱
    local spriteB18 = ccui.Button:create("artcontent/lobby(ongame)/store/diamondstore/basemap_epic.png")
    self.container_1:addChild(spriteB18)
    spriteB18:setAnchorPoint(0.5, 0)
    spriteB18:setPosition(width*2/3+120,350)
    spriteB18:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/open_box.OGG",false)
                end
                ObtainItemLayer:SetData(3,1280)
                EventManager:doEvent(EventDef.ID.OBTAINITEM)
            end
        end
    )

    local spriteB19 = display.newSprite("artcontent/lobby(ongame)/store/diamondstore/chest_epic.png")
    self.container_1:addChild(spriteB19)
    spriteB19:setAnchorPoint(0.5, 0)
    spriteB19:setPosition(width*2/3+120,420)

    local spriteB20 = display.newSprite("artcontent/lobby(ongame)/store/diamondstore/titile_diamond.png")
    self.container_1:addChild(spriteB20)
    spriteB20:setAnchorPoint(0.5, 0)
    spriteB20:setPosition(width*2/3+90,370)
    display.newTTFLabel({
        text = "750",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, width*2/3+140,390)
    :addTo(self.container_1)

    --传说宝箱
    local spriteB21 = ccui.Button:create("artcontent/lobby(ongame)/store/diamondstore/basemap_legend.png")
    self.container_1:addChild(spriteB21)
    spriteB21:setAnchorPoint(0.5, 0)
    spriteB21:setPosition(width/3+120,30)
    spriteB21:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/open_box.OGG",false)
                end
                ObtainItemLayer:SetData(4,3040)
                EventManager:doEvent(EventDef.ID.OBTAINITEM)
            end
        end
    )

    local spriteB22 = display.newSprite("artcontent/lobby(ongame)/store/diamondstore/chest_legend.png")
    self.container_1:addChild(spriteB22)
    spriteB22:setAnchorPoint(0.5, 0)
    spriteB22:setPosition(width/3+120,100)

    local spriteB23 = display.newSprite("artcontent/lobby(ongame)/store/diamondstore/titile_diamond.png")
    self.container_1:addChild(spriteB23)
    spriteB23:setAnchorPoint(0.5, 0)
    spriteB23:setPosition(width/3+90,55)
    display.newTTFLabel({
        text = "2500",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, width/3+140,70)
    :addTo(self.container_1)
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function DiamondShopLayer:update(dt)
end

return DiamondShopLayer

