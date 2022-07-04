--[[
    SpriteLayer.lua
    精灵层
    描述：精灵层
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local SpriteLayer = class("SpriteLayer", require("app.ui.layer.BaseLayer"))
local CollectionComp = require("app.ui.layer.lobby.pictorial.component.CollectionComp")
local CurrentTeamComp = require("app.ui.layer.lobby.pictorial.component.CurrentTeamComp")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")

--[[--
    构造函数

    @param none

    @return none
]]
function SpriteLayer:ctor()
    SpriteLayer.super.ctor(self)

    self.container_ = nil

    self.currentTeamComp_ = nil -- 当前队伍组件
    self.collectionComp_ = nil -- 卡牌收集组件
    self.replaceCardComp_ = nil -- 替换卡片组件

    self.damageValue_ = 20 -- 暴击伤害

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function SpriteLayer:initView()
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, display.cy)

    -- 当前阵容
    self.currentTeamComp_ = CurrentTeamComp.new()
    self.container_:addChild(self.currentTeamComp_)


    -- 总暴击伤害
    local damage = ccui.Layout:create()
    damage:setBackGroundImage("image/lobby/pictorial/damage/damage_bg.png")
    local width, height = damage:getBackGroundImageTextureSize().width,
            damage:getBackGroundImageTextureSize().height
    damage:setContentSize(width, height)
    damage:setAnchorPoint(0.5, 0.5)
    damage:setPosition(display.width/2, 0.575*display.height)
    self.container_:addChild(damage)

    local damageTitle = ccui.ImageView:create("image/lobby/pictorial/damage/damage_title.png")
    damageTitle:setAnchorPoint(0.5, 0.5)
    damageTitle:setPosition(0.4*width, 0.7*height)
    damage:addChild(damageTitle)

    local damageText = ccui.ImageView:create("image/lobby/pictorial/damage/damage_text.png")
    damageText:setAnchorPoint(0.5, 0.5)
    damageText:setPosition(0.5*width, 0.2*height)
    damage:addChild(damageText)


    local value = string.format("%d%%", self.damageValue_)
    local damageValue = ccui.Text:create(value, "font/fzbiaozjw.ttf", 35)
    damageValue:setTextColor(cc.c4b(255, 206, 55, 255))
    damageValue:setAnchorPoint(1, 0.5)
    damageValue:setPosition(0.7*width, 0.7*height)
    damage:addChild(damageValue)


    -- 卡片收集列表
    self.collectionComp_ = CollectionComp.new()
    self.container_:addChild(self.collectionComp_)


end

--[[--
    节点进入

    @param none

    @return none
]]
function SpriteLayer:onEnter()
    EventManager:regListener(EventDef.ID.COLLECTION_VIEW_HIDE, self, function()
        self.collectionComp_:setVisible(false)
    end)
    EventManager:regListener(EventDef.ID.COLLECTION_VIEW_SHOW, self, function()
        self.collectionComp_:setVisible(true)
    end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function SpriteLayer:onExit()
    EventManager:unRegListener(EventDef.ID.COLLECTION_VIEW_HIDE, self)
    EventManager:unRegListener(EventDef.ID.COLLECTION_VIEW_SHOW, self)
end

return SpriteLayer