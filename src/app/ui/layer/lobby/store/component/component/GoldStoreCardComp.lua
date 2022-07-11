--[[
    GoldStoreCardComp.lua
    金币商店卡片组件
    描述：金币商店卡片组件
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local GoldStoreCardComp = class("GoldStoreCardComp", require("app.ui.layer.BaseUILayout"))
local ConstDef = require("app.def.ConstDef")
local GoldStorePurchaseConfirmDialog = require("app.ui.layer.lobby.store.dialog.GoldStorePurchaseConfirmDialog")
local DialogManager = require("app.manager.DialogManager")
local PlayerData = require("app.data.PlayerData")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")

--[[--
    构造函数

    @param storeCard

    @return none
]]
function GoldStoreCardComp:ctor(storeCard, tag)
    GoldStoreCardComp.super.ctor(self)

    self.container_ = nil -- 全局容器

    self:initParam(storeCard, tag)
    self:initView()
end
--[[--
    参数初始化

    @param none

    @return none
]]
function GoldStoreCardComp:initParam(storeCard, tag)

    self.storeCard_ = storeCard
    self.tag_ = tag
    self.card_ = PlayerData:getCardById(self.storeCard_.cardId)
end

--[[--
    界面初始化

    @param none

    @return none
]]
function GoldStoreCardComp:initView()

    -- Card组件
    self.container_ = ccui.Layout:create()
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setContentSize(ConstDef.CARD_SIZE.TYPE_3.WIDTH,
            ConstDef.CARD_SIZE.TYPE_3.HEIGHT)

    local piece = string.format("x%d", self.storeCard_.pieceNum)
    local width, height = ConstDef.CARD_SIZE.TYPE_3.WIDTH, ConstDef.CARD_SIZE.TYPE_3.HEIGHT

    if self.storeCard_.type == 3 then -- 卡牌
        self.container_:setBackGroundImage(self.card_:getMediumSpriteImg())

        local goldIcon = ccui.ImageView:create("image/lobby/store/gold/gold_small_icon.png")
        goldIcon:setPosition(0.3*width, 0.15*height)
        self.container_:addChild(goldIcon)

        local goldText = ccui.Text:create(self.storeCard_.cost, "font/fzbiaozjw.ttf", 25)
        goldText:enableOutline(cc.c4b(0, 0, 0, 255), 1) -- 描边
        goldText:setPosition(0.8*width, 0.075*height)
        goldText:setAnchorPoint(1, 0)
        self.container_:addChild(goldText)

        local pieceBG = ccui.ImageView:create("image/lobby/store/gold/piece_num_bg.png")
        pieceBG:setPosition(0.7*width, 0.85*height)
        self.container_:addChild(pieceBG)

        local pieceText = ccui.Text:create(piece, "font/fzzchjw.ttf", 19)
        pieceText:setTextColor(cc.c4b(255, 206, 55, 255))
        pieceText:enableOutline(cc.c4b(0, 0, 0, 255), 1) -- 描边
        pieceText:setPosition(0.9*width, 0.8*height)
        pieceText:setAnchorPoint(1, 0)
        self.container_:addChild(pieceText)
    else
        self.container_:setBackGroundImage("image/lobby/store/gold/free_bg.png")

        local priceTitle = ccui.ImageView:create("image/lobby/store/gold/free_title.png")
        priceTitle:setPosition(0.5*width, 0.15*height)
        self.container_:addChild(priceTitle)

        local pieceText = ccui.Text:create(piece, "font/fzbiaozjw.ttf", 24)
        pieceText:enableOutline(cc.c4b(0, 0, 0, 255), 1) -- 描边
        pieceText:setTextColor(cc.c4b(173, 196, 255, 255))
        pieceText:setPosition(0.5*width, 0.35*height)
        self.container_:addChild(pieceText)

        if self.storeCard_.type == 1 then -- 金币
            local icon = ccui.ImageView:create("image/lobby/store/gold/gold_big_icon.png")
            icon:setAnchorPoint(0.5, 0)
            icon:setPosition(0.5*width, 0.5*height)
            self.container_:addChild(icon)
        else -- 钻石
            local icon = ccui.ImageView:create("image/lobby/store/gold/diamond_icon.png")
            icon:setAnchorPoint(0.5, 0)
            icon:setPosition(0.5*width, 0.5*height)
            self.container_:addChild(icon)
        end
    end

    self:addChild(self.container_)

    -- 蒙版
    self.mask_ = ccui.ImageView:create("image/lobby/store/gold/mask.png")
    self.mask_:setOpacity(255/2)
    self.mask_:setVisible(false)
    self:addChild(self.mask_)

    -- 容器事件
    self.container_:addTouchEventListener(function(sender, event)
        if event == 0 then
            -- 放大事件
            local ac1 = cc.ScaleTo:create(0.1, 1.1)
            local ac2 = cc.ScaleTo:create(0.1, 1)
            local action = cc.Sequence:create(ac1, ac2)
            self.container_:runAction(action)

            return true
        elseif event == 2 then
            -- 如果购买的是卡片则显示金币商店购买确认弹窗
            if self.storeCard_.type == 3 then
                local dialog = GoldStorePurchaseConfirmDialog.new(
                        self.storeCard_.cardId, self.storeCard_.pieceNum,
                        self.storeCard_.cost, self.card_:getMediumSpriteImg(),
                        self.tag_)
                DialogManager:showDialog(dialog)
            else -- 免费资源
                self.mask_:setVisible(true)
            end

            return true
        end
    end)
    self.container_:setTouchEnabled(true)

    -- 蒙版事件
    self.mask_:addTouchEventListener(function(sender, event)
        return true
    end )
    self.mask_:setTouchEnabled(true)

end

--[[--
    onEnter

    @param none

    @return none
]]
function GoldStoreCardComp:onEnter()
    EventManager:regListener(EventDef.ID.CARD_PURCHASE, self, function(tag)
        if self.tag_ == tag then
            self.mask_:setVisible(true)
        end
    end)
end

--[[--
    onExit

    @param none

    @return none
]]
function GoldStoreCardComp:onExit()
    EventManager:unRegListener(EventDef.ID.CARD_PURCHASE, self)
end

--[[--
    界面刷新

    @param none

    @return none
]]
function GoldStoreCardComp:update()

end

return GoldStoreCardComp