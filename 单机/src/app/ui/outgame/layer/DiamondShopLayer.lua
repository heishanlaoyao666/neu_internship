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
    local basemapSprite = display.newSprite("artcontent/lobby_ongame/store/diamondstore/basemap_diamondstore.png")
    self.container_1:addChild(basemapSprite)
    basemapSprite:setAnchorPoint(0.5, 0)
    basemapSprite:setPosition(width/2,650)

    local titleSprite = display.newSprite("artcontent/lobby_ongame/store/diamondstore/title_diamondstore.png")
    self.container_1:addChild(titleSprite)
    titleSprite:setAnchorPoint(0.5, 0)
    titleSprite:setPosition(width/2,660)

    --普通宝箱
    local basemapNormal = ccui.Button:create("artcontent/lobby_ongame/store/diamondstore/basemap_normal.png")
    self.container_1:addChild(basemapNormal)
    basemapNormal:setAnchorPoint(0.5, 0)
    basemapNormal:setPosition(120,350)
    basemapNormal:addTouchEventListener(
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

    local chestNormal = display.newSprite("artcontent/lobby_ongame/store/diamondstore/chest_normal.png")
    self.container_1:addChild(chestNormal)
    chestNormal:setAnchorPoint(0.5, 0)
    chestNormal:setPosition(120,420)


    local diamondSprite1= display.newSprite("artcontent/lobby_ongame/store/diamondstore/titile_diamond.png")
    self.container_1:addChild(diamondSprite1)
    diamondSprite1:setAnchorPoint(0.5, 0)
    diamondSprite1:setPosition(90,370)
    display.newTTFLabel({
        text = "150",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, 140,390)
    :addTo(self.container_1)


    --稀有宝箱
    local basemapRare = ccui.Button:create("artcontent/lobby_ongame/store/diamondstore/basemap_rare.png")
    self.container_1:addChild(basemapRare)
    basemapRare:setAnchorPoint(0.5, 0)
    basemapRare:setPosition(width/3+120,350)
    basemapRare:addTouchEventListener(
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

    local chestRare = display.newSprite("artcontent/lobby_ongame/store/diamondstore/chest_rare.png")
    self.container_1:addChild(chestRare)
    chestRare:setAnchorPoint(0.5, 0)
    chestRare:setPosition(width/3+120,420)

    local diamondSprite2 = display.newSprite("artcontent/lobby_ongame/store/diamondstore/titile_diamond.png")
    self.container_1:addChild(diamondSprite2)
    diamondSprite2:setAnchorPoint(0.5, 0)
    diamondSprite2:setPosition(width/3+90,370)
    display.newTTFLabel({
        text = "250",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, width/3+140,390)
    :addTo(self.container_1)

    --史诗宝箱
    local basemapEpic = ccui.Button:create("artcontent/lobby_ongame/store/diamondstore/basemap_epic.png")
    self.container_1:addChild(basemapEpic)
    basemapEpic:setAnchorPoint(0.5, 0)
    basemapEpic:setPosition(width*2/3+120,350)
    basemapEpic:addTouchEventListener(
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

    local chestEpic = display.newSprite("artcontent/lobby_ongame/store/diamondstore/chest_epic.png")
    self.container_1:addChild(chestEpic)
    chestEpic:setAnchorPoint(0.5, 0)
    chestEpic:setPosition(width*2/3+120,420)

    local diamondSprite3 = display.newSprite("artcontent/lobby_ongame/store/diamondstore/titile_diamond.png")
    self.container_1:addChild(diamondSprite3)
    diamondSprite3:setAnchorPoint(0.5, 0)
    diamondSprite3:setPosition(width*2/3+90,370)
    display.newTTFLabel({
        text = "750",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, width*2/3+140,390)
    :addTo(self.container_1)

    --传说宝箱
    local basemapLegend = ccui.Button:create("artcontent/lobby_ongame/store/diamondstore/basemap_legend.png")
    self.container_1:addChild(basemapLegend)
    basemapLegend:setAnchorPoint(0.5, 0)
    basemapLegend:setPosition(width/3+120,30)
    basemapLegend:addTouchEventListener(
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

    local chestLegend = display.newSprite("artcontent/lobby_ongame/store/diamondstore/chest_legend.png")
    self.container_1:addChild(chestLegend)
    chestLegend:setAnchorPoint(0.5, 0)
    chestLegend:setPosition(width/3+120,100)

    local diamondSprite4 = display.newSprite("artcontent/lobby_ongame/store/diamondstore/titile_diamond.png")
    self.container_1:addChild(diamondSprite4)
    diamondSprite4:setAnchorPoint(0.5, 0)
    diamondSprite4:setPosition(width/3+90,55)
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

