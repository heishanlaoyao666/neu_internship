--[[
    GoldStorePurchaseConfirmDialog.lua
    金币商店购买确认弹窗
    描述：金币商店购买确认弹窗
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local GoldStorePurchaseConfirmDialog = class("GoldStorePurchaseConfirmDialog", require("app.ui.layer.BaseLayer"))
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")
local PlayerData = require("app.data.PlayerData")
local FailDialog = require("app.ui.layer.lobby.general.dialog.FailDialog")
local DialogManager = require("app.manager.DialogManager")
local ConstDef = require("app.def.ConstDef")
local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

--[[--
    构造函数

    @param id 类型：string，卡牌id
    @param pieceNum 类型：number，碎片数量
    @param cost 类型：number，花费
    @param bg 类型：string，背景图片地址

    @return none
]]
function GoldStorePurchaseConfirmDialog:ctor(id, pieceNum, cost, bg, tag)
    GoldStorePurchaseConfirmDialog.super.ctor(self)

    self.container_ = nil -- 全局容器

    self.id_ = id
    self.pieceNum_ = pieceNum
    self.cost_ = cost
    self.bg_ = bg
    self.tag_ = tag

    self:initView()
    self:hideView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function GoldStorePurchaseConfirmDialog:initView()

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.width/2, display.height/2)
    self.container_:setBackGroundColor(cc.c3b(0, 0, 0))
    self.container_:setBackGroundColorType(1)
    self.container_:setCascadeOpacityEnabled(false) -- 穿透
    self.container_:setOpacity(0.8 * 255)
    self:addChild(self.container_)

    local dialog = ccui.Layout:create()
    dialog:setBackGroundImage("image/lobby/store/gold/dialog/dialog_bg.png")
    local dialogWidth, dialogHeight = dialog:getBackGroundImageTextureSize().width, dialog:getBackGroundImageTextureSize().height
    dialog:setContentSize(dialogWidth, dialogHeight)
    dialog:setAnchorPoint(0.5, 0.5)
    dialog:setPosition(display.width/2, display.height/2)
    self.container_:addChild(dialog)

    -- 关闭按钮
    local closeBtn = ccui.Button:create("image/lobby/store/gold/dialog/close_btn.png")
    closeBtn:setPosition(1.1*dialogWidth, 2.1*dialogHeight)
    closeBtn:addClickEventListener(function()
        self:hideView()
    end)
    self.container_:addChild(closeBtn)

    -- 卡牌背景
    local cardBG = ccui.ImageView:create(self.bg_)
    cardBG:setScale(0.8)
    cardBG:setPosition(dialogWidth/2, dialogHeight/2)
    dialog:addChild(cardBG)

    -- 碎片数量
    local text = string.format("x%d", self.pieceNum_)
    local pieceText = ccui.Text:create(text, "font/fzbiaozjw.ttf", 25)
    pieceText:enableOutline(cc.c4b(0, 0, 0, 255), 1) -- 1像素纯黑色描边
    pieceText:setTextColor(cc.c4b(255, 206, 55, 255))
    pieceText:setPosition(0.5*dialogWidth, 0.35*dialogHeight)
    dialog:addChild(pieceText)

    -- 购买
    local purchaseContainer = ccui.Layout:create()
    purchaseContainer:setBackGroundImage("image/lobby/store/gold/dialog/purchase_btn.png")
    local purchaseWidth, purchaseHeight = purchaseContainer:getBackGroundImageTextureSize().width, purchaseContainer:getBackGroundImageTextureSize().height
    purchaseContainer:setContentSize(purchaseWidth, purchaseHeight)
    purchaseContainer:setAnchorPoint(0.5, 0.5)
    purchaseContainer:setPosition(0.5*dialogWidth, 0.15*dialogHeight)
    purchaseContainer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            -- 放大事件
            local ac1 = cc.ScaleTo:create(0.1, 1.1)
            local ac2 = cc.ScaleTo:create(0.1, 1)
            local action = cc.Sequence:create(ac1, ac2)
            purchaseContainer:runAction(action)
            return true
        else
            -- 执行对应的操作
            local state = PlayerData:purchaseCard(self.id_, self.pieceNum_, self.cost_)
            if state == 0 then
                EventManager:doEvent(EventDef.ID.CARD_PURCHASE, self.tag_)
                print("Purchase success!")
                self:hideView()
            else
                local dialog = FailDialog.new(ConstDef.FAIL_CODE.PURCHASE_GOLD_DEFICIENCY)
                DialogManager:showDialog(dialog)
                print("Gold is not enough!")
            end
        end
    end)
    purchaseContainer:setTouchEnabled(true)
    dialog:addChild(purchaseContainer)

    -- 金币图标
    local goldIcon = ccui.ImageView:create("image/lobby/store/gold/dialog/gold_icon.png")
    goldIcon:setAnchorPoint(0.5, 0.5)
    goldIcon:setPosition(0.3*purchaseWidth, 0.5*purchaseHeight)
    purchaseContainer:addChild(goldIcon)

    -- 金币花费
    local costText = ccui.Text:create(self.cost_, "font/fzbiaozjw.ttf", 30)
    costText:enableOutline(cc.c4b(0, 0, 0, 255), 1) -- 1像素纯黑色描边
    costText:setTextColor(cc.c4b(255, 255, 255, 255))
    costText:setPosition(0.6*purchaseWidth, 0.5*purchaseHeight)
    purchaseContainer:addChild(costText)


    -- 事件监听(空白处关闭)
    self.listener_ = cc.EventListenerTouchOneByOne:create()
    self.listener_:registerScriptHandler(function(touch, event)
        if self.isListening_ then
            local touchPosition = touch:getLocation()
            local x = dialog:getPositionX()
            local y = dialog:getPositionY()
            local nodeSize = dialog:getContentSize()

            local rect = cc.rect(x - nodeSize.width/2, y - nodeSize.height/2,
                    nodeSize.width, nodeSize.height)

            if not cc.rectContainsPoint(rect, touchPosition) then -- 点击黑色遮罩关闭弹窗
                self:hideView()
            end

            return true
        end
        return false
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    eventDispatcher:addEventListenerWithSceneGraphPriority(self.listener_, self)

end

return GoldStorePurchaseConfirmDialog