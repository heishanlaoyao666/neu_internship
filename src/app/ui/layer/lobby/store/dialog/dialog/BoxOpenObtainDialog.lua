--[[
    BoxOpenObtainDialog.lua
    宝箱开启获得物品弹窗
    描述：宝箱开启获得物品弹窗
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local BoxOpenObtainDialog = class("BoxOpenObtainDialog", require("app.ui.layer.BaseUILayout"))
local BoxObtainCardComp = require("app.ui.layer.lobby.store.component.component.BoxObtainCardComp")
local StoreData = require("app.data.StoreData")
local PlayerData = require("app.data.PlayerData")
local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

--[[--
    构造函数

    @param cost 类型：number，花费
    @param boxSprite 类型：string，宝箱精灵图片
    @param normalPieceNum 类型：number，普通卡碎片数量
    @param rarePieceNum 类型：number，稀有卡碎片数量
    @param epicPieceNum 类型：number，史诗卡碎片数量
    @param legendPieceNum 类型：number，传奇卡碎片数量

    @return none
]]
function BoxOpenObtainDialog:ctor(boxCards)
    BoxOpenObtainDialog.super.ctor(self)

    self.container_ = nil -- 全局容器

    self:initParam(boxCards)
    self:initView()
    self:hideView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function BoxOpenObtainDialog:initParam(boxCards)
    self.gold_ = boxCards.gold
    self.cards_ = boxCards.cards
end

--[[--
    界面初始化

    @param none

    @return none
]]
function BoxOpenObtainDialog:initView()

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.width/2, display.height/2)
    self.container_:setBackGroundColor(cc.c3b(0, 0, 0))
    self.container_:setBackGroundColorType(1)
    self.container_:setCascadeOpacityEnabled(false) -- 穿透
    self.container_:setOpacity(0.8 * 255)
    self:addChild(self.container_)

    -- 弹窗背景
    local dialog = ccui.Layout:create()
    dialog:setBackGroundImage("image/lobby/general/boxobtain/dialog_bg.png")
    local dialogWidth, dialogHeight = dialog:getBackGroundImageTextureSize().width, dialog:getBackGroundImageTextureSize().height
    dialog:setContentSize(dialogWidth, dialogHeight)
    dialog:setAnchorPoint(0.5, 0.5)
    dialog:setPosition(display.width/2, display.height/2)
    self.container_:addChild(dialog)


    -- 金币
    local goldIcon = ccui.ImageView:create("image/lobby/general/boxobtain/gold_icon.png")
    goldIcon:setPosition(0.45*dialogWidth, -0.12*dialogHeight)
    dialog:addChild(goldIcon)

    local goldNum = ccui.Text:create(self.gold_, "font/fzbiaozjw.ttf", 30)
    goldNum:setTextColor(cc.c4b(255, 255, 255, 255))
    goldNum:enableOutline(cc.c4b(20, 20, 66, 255), 2) -- 描边
    goldNum:setPosition(0.55*dialogWidth, -0.12*dialogHeight)
    dialog:addChild(goldNum)

    -- 卡牌
    local length = #self.cards_
    local rowNum = math.ceil(length/4)

    for i = 1, length do
        local card = BoxObtainCardComp.new(PlayerData:getCardById(self.cards_[i].cardId), self.cards_[i].pieceNum)
        card:setScale(0.9)
        card:setAnchorPoint(0.5, 0.5)
        card:setPosition(0.2*dialogWidth+((i-1)%4)*dialogWidth/5, 0.5*dialogHeight-(math.floor((i-1)/4))*dialogHeight/(1.5*rowNum))
        dialog:addChild(card)
    end

    -- 确认按钮
    local confirmBtn = ccui.Button:create("image/lobby/general/boxobtain/confirm_btn.png")
    confirmBtn:setPosition(0.5*dialogWidth, -0.35*dialogHeight)
    confirmBtn:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            -- 放大事件
            local ac1 = cc.ScaleTo:create(0.1, 1.1)
            local ac2 = cc.ScaleTo:create(0.1, 1)
            local action = cc.Sequence:create(ac1, ac2)
            confirmBtn:runAction(action)
            return true
        else
            -- 执行对应的操作
            self:hideView()
        end
    end)
    confirmBtn:setTouchEnabled(true)
    dialog:addChild(confirmBtn)

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

return BoxOpenObtainDialog