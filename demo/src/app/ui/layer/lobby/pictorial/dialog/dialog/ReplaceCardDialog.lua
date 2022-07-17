--[[
    ReplaceCardDialog.lua
    卡片替换弹窗
    描述：卡片替换弹窗
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local ReplaceCardDialog = class("ReplaceCardDialog", require("app.ui.layer.BaseUILayout"))
local ConstDef = require("app.def.ConstDef")
local PlayerData = require("app.data.PlayerData")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")
local LobbyData = require("app.data.LobbyData")
local MsgManager = require("app.manager.MsgManager")
local eventDispatcher = cc.Director:getInstance():getEventDispatcher()


--[[--
    构造函数

    @param none

    @return none
]]
function ReplaceCardDialog:ctor(card)
    ReplaceCardDialog.super.ctor(self)

    self.container_ = nil
    self.card_ = card

    self:initData()
    self:initView()
end

--[[--
    数据初始化

    @param none

    @return none
]]
function ReplaceCardDialog:initData()
    LobbyData:setCurSelectedTower(self.card_)
end

--[[--
    界面初始化

    @param none

    @return none
]]
function ReplaceCardDialog:initView()

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(ConstDef.WINDOW_SIZE.COLLECTION_VIEW.WIDTH,
            ConstDef.WINDOW_SIZE.COLLECTION_VIEW.HEIGHT)
    self.container_:setAnchorPoint(0, 0)
    self.container_:setPosition(0, 0.1*display.height)
    self:addChild(self.container_)

    local dialog = ccui.Layout:create()
    dialog:setBackGroundImage("image/lobby/pictorial/towerusing/group_bg.png")
    local dialogWidth, dialogHeight = dialog:getBackGroundImageTextureSize().width,
            dialog:getBackGroundImageTextureSize().height
    dialog:setContentSize(dialogWidth, dialogHeight)
    dialog:setAnchorPoint(0.5, 0.5)
    dialog:setPosition(display.width/2, display.height/4)
    self.container_:addChild(dialog)

    -- 取消按钮
    local cancelBtn = ccui.Button:create("image/lobby/pictorial/towerusing/cancel_btn.png")
    cancelBtn:setAnchorPoint(0.5, 0.5)
    cancelBtn:setPosition(0.5*dialogWidth, 0.15*dialogHeight)
    cancelBtn:addClickEventListener(
            function()
                self:hideView()
                EventManager:doEvent(EventDef.ID.COLLECTION_VIEW_SHOW)
                LobbyData:setCurSelectedTower(nil)
            end
    )
    dialog:addChild(cancelBtn)

    -- 卡牌
    local cardWidth, cardHeight = 1.2*ConstDef.CARD_SIZE.TYPE_1.WIDTH, ConstDef.CARD_SIZE.TYPE_1.HEIGHT

    local itemLayer = ccui.Layout:create()
    itemLayer:setContentSize(cardWidth, cardHeight)
    itemLayer:setAnchorPoint(0.5, 0.5)
    itemLayer:setPosition(dialogWidth/2, dialogHeight/2)
    dialog:addChild(itemLayer)

    local card = ccui.ImageView:create(self.card_:getSmallSpriteImg())
    card:setPosition(cardWidth * 0.5, cardHeight * 0.6)
    itemLayer:addChild(card)

    local level = ccui.ImageView:create(self.card_:getLevelImg())
    level:setPosition(cardWidth * 0.5, cardHeight * 0.1)
    itemLayer:addChild(level)

    local attr = ccui.ImageView:create(self.card_:getTypeImg())
    attr:setPosition(cardWidth * 0.8, cardHeight * 0.9)
    itemLayer:addChild(attr)


    self.listener_ = cc.EventListenerTouchOneByOne:create()
    self.listener_:registerScriptHandler(function(touch, event)
        if self.isListening_ then
            local touchPosition = touch:getLocation()
            local x = display.width/2
            local y = display.height/2
            local nodeSize = ConstDef.WINDOW_SIZE.MAIN

            local rect = cc.rect(x - nodeSize.WIDTH/2, y - nodeSize.HEIGHT/2,
                    nodeSize.WIDTH, nodeSize.HEIGHT)

            if cc.rectContainsPoint(rect, touchPosition) then
                print(123)
                return false
            end

            return true
        end
        return false
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    eventDispatcher:addEventListenerWithSceneGraphPriority(self.listener_, self)

end

--[[--
    节点进入

    @param none

    @return none
]]
function ReplaceCardDialog:onEnter()

    -- 卡牌切换事件
    EventManager:regListener(EventDef.ID.CARD_SWITCH, self, function(code)
        self:hideView()
        EventManager:doEvent(EventDef.ID.COLLECTION_VIEW_SHOW)
        LobbyData:setCurSelectedTower(nil)

        self:update()
    end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function ReplaceCardDialog:onExit()
    EventManager:unRegListener(EventDef.ID.CARD_SWITCH, self)
end

--[[--
    界面刷新

    @param none

    @return none
]]
function ReplaceCardDialog:update()
    MsgManager:sendPlayerData() -- 发送数据
end

return ReplaceCardDialog