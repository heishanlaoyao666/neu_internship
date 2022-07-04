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

--[[--
    构造函数

    @param id 类型：String，卡片id
    @param bg 类型：String，卡片背景图片地址
    @param type 类型：number，卡片类型

    @return none
]]
function GoldStoreCardComp:ctor(id, bg, type)
    GoldStoreCardComp.super.ctor(self)

    self.container_ = nil -- 全局容器
    self.card_ = nil -- 卡片

    self.id_ = id -- 卡片id - 用于定位
    self.bg_ = bg -- 卡片背景图片地址
    self.type_ = type -- 卡片类型
    self.listener_ = nil

    self.isCard_ = false
    self.cost_ = 0
    self.piece_ = 0

    self:initParam()
    self:initView()
end
--[[--
    参数初始化

    @param none

    @return none
]]
function GoldStoreCardComp:initParam()

    if self.type_ == 1 then -- 金币
        self.isCard_ = false
        self.piece_ = ConstDef.STORE_COST.GOLD.GOLD
        self.cost_ = 0
    elseif self.type_ == 2 then -- 钻石
        self.isCard_ = false
        self.piece_ = ConstDef.STORE_COST.GOLD.DIAMOND
        self.cost_ = 0
    elseif self.type_ == 3 then -- 普通卡
        self.isCard_ = true
        self.cost_ = ConstDef.STORE_COST.GOLD.NORMAL
        self.piece_ = 36
    elseif self.type_ == 4 then -- 稀有卡
        self.isCard_ = true
        self.cost_ = ConstDef.STORE_COST.GOLD.RARE
        self.piece_ = 6
    elseif self.type_ == 5 then -- 史诗卡
        self.isCard_ = true
        self.cost_ = ConstDef.STORE_COST.GOLD.EPIC
        self.piece_ = 1
    end
end

--[[--
    界面初始化

    @param none

    @return none
]]
function GoldStoreCardComp:initView()

    -- Card组件
    self.card_ = ccui.Layout:create()
    self.card_:setBackGroundImage(self.bg_)
    self.card_:setAnchorPoint(0.5, 0.5)
    self.card_:setContentSize(ConstDef.CARD_SIZE.TYPE_3.WIDTH,
            ConstDef.CARD_SIZE.TYPE_3.HEIGHT)

    local piece = string.format("x%d", self.piece_)
    local width, height = ConstDef.CARD_SIZE.TYPE_3.WIDTH, ConstDef.CARD_SIZE.TYPE_3.HEIGHT

    if self.isCard_ == true then
        local goldIcon = ccui.ImageView:create("image/lobby/store/gold/gold_small_icon.png")
        goldIcon:setPosition(0.3*width, 0.15*height)
        self.card_:addChild(goldIcon)

        local goldText = ccui.Text:create(self.cost_, "font/fzbiaozjw.ttf", 25)
        goldText:enableOutline(cc.c4b(0, 0, 0, 255), 1) -- 描边
        goldText:setPosition(0.8*width, 0.075*height)
        goldText:setAnchorPoint(1, 0)
        self.card_:addChild(goldText)

        local pieceBG = ccui.ImageView:create("image/lobby/store/gold/piece_num_bg.png")
        pieceBG:setPosition(0.7*width, 0.85*height)
        self.card_:addChild(pieceBG)

        local pieceText = ccui.Text:create(piece, "font/fzzchjw.ttf", 19)
        pieceText:setTextColor(cc.c4b(255, 206, 55, 255))
        pieceText:enableOutline(cc.c4b(0, 0, 0, 255), 1) -- 描边
        pieceText:setPosition(0.9*width, 0.8*height)
        pieceText:setAnchorPoint(1, 0)
        self.card_:addChild(pieceText)
    else
        local priceTitle = ccui.ImageView:create("image/lobby/store/gold/free_title.png")
        priceTitle:setPosition(0.5*width, 0.15*height)
        self.card_:addChild(priceTitle)

        local pieceText = ccui.Text:create(piece, "font/fzbiaozjw.ttf", 24)
        pieceText:enableOutline(cc.c4b(0, 0, 0, 255), 1) -- 描边
        pieceText:setTextColor(cc.c4b(173, 196, 255, 255))
        --pieceText:setAnchorPoint(0.5, 0.5)
        pieceText:setPosition(0.5*width, 0.35*height)
        self.card_:addChild(pieceText)

        if self.type_ == 1 then -- 金币
            local icon = ccui.ImageView:create("image/lobby/store/gold/gold_big_icon.png")
            icon:setAnchorPoint(0.5, 0)
            icon:setPosition(0.5*width, 0.5*height)
            self.card_:addChild(icon)
        else -- 钻石
            local icon = ccui.ImageView:create("image/lobby/store/gold/diamond_icon.png")
            icon:setAnchorPoint(0.5, 0)
            icon:setPosition(0.5*width, 0.5*height)
            self.card_:addChild(icon)
        end
    end

    self:addChild(self.card_)

    self.card_:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            -- 放大事件
            local ac1 = cc.ScaleTo:create(0.1, 1.1)
            local ac2 = cc.ScaleTo:create(0.1, 1)
            local action = cc.Sequence:create(ac1, ac2)
            self.card_:runAction(action)

            -- 如果购买的是卡片则显示金币商店购买确认弹窗
            if self.isCard_ then
                local dialog = GoldStorePurchaseConfirmDialog.new(self.id_, self.piece_, self.cost_, self.bg_)
                DialogManager:showDialog(dialog)
            else -- 免费资源

            end

            return true
        end
    end)
    self.card_:setTouchEnabled(true)
end

return GoldStoreCardComp