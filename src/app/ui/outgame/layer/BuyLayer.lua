--[[--
    购买层
    BuyLayer.lua
]]
local BuyLayer = class("BuyLayer", require("app.ui.outgame.layer.BaseLayer"))
local OutGameData = require("app.data.outgame.OutGameData")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
--[[--
    构造函数

    @param none

    @return none
]]
function BuyLayer:ctor()
    BuyLayer.super.ctor(self)

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function BuyLayer:initView()
    --遮罩
    self.goods=1
    local sprite0 = ccui.Button:create("artcontent/lobby(ongame)/currency/mask_popup.png")
    self:addChild(sprite0)
    sprite0:setAnchorPoint(0.5, 0.5)
    sprite0:setOpacity(127)
    sprite0:setPosition(display.cx,display.cy)

    sprite0:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                self:removeFromParent(true)
            end
        end
    )

    --底图
    local sprite1 = display.newSprite("artcontent/lobby(ongame)/store/goldstore_confirmationpopup/basemap_popup.png")
    sprite1:setAnchorPoint(0.5, 0.5)

    self.container_ = ccui.Layout:create()
    -- self.container_:setBackGroundColor(cc.c3b(200, 0, 0))
    -- self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(sprite1:getContentSize().width, sprite1:getContentSize().height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5,0.5)
    self.container_:setPosition(display.cx, display.cy)
    self.container_:addChild(sprite1)
    sprite1:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height/2)

    --x按钮
    local sprite2= ccui.Button:create("artcontent/lobby(ongame)/store/goldstore_confirmationpopup/button_off.png")
    self.container_:addChild(sprite2)
    sprite2:setAnchorPoint(1, 1)
    sprite2:setPosition(sprite1:getContentSize().width-20, sprite1:getContentSize().height-20)
    sprite2:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                self:removeFromParent(true)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_close.OGG",false)
                end
            end
        end
    )

    --金币购买确认按钮
    local sprite3= ccui.Button:create("artcontent/lobby(ongame)/store/goldstore_confirmationpopup/button_purchase.png")
    self.container_:addChild(sprite3)
    sprite3:setAnchorPoint(0.5, 0.5)
    sprite3:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height/2-130)
    local buyprice = self.price
    local buytower = self.tower
    local buynum=self.num
    local i=self.i
    sprite3:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                self:removeFromParent(true)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/buy_paid_item.OGG",false)
                end
                if OutGameData:getGold()<buyprice then
                    EventManager:doEvent(EventDef.ID.POPUPWINDOW,2)
                else
                    OutGameData:setGold(-buyprice)
                    EventManager:doEvent(EventDef.ID.GAMEDATA_CHANGE)
                    OutGameData:choosePacks(buytower,buynum)
                    EventManager:doEvent(EventDef.ID.KNAPSACK_CHANGE)
                    EventManager:doEvent(EventDef.ID.GOODS_CHANGE,i)
                end
            end
        end
    )
    local sprite4= ccui.Button:create("artcontent/lobby(ongame)/store/goldstore_confirmationpopup/icon_goldcoin.png")
    sprite3:addChild(sprite4)
    sprite4:setAnchorPoint(0.5, 0.5)
    sprite4:setPosition(sprite3:getContentSize().width/2-50, sprite3:getContentSize().height/2)
    display.newTTFLabel({
        text = self.price,
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_CENTER, sprite3:getContentSize().width/2+30,sprite3:getContentSize().height/2)
    :addTo(sprite3)

    --商品图片显示
    local sprite5 = display.newSprite("artcontent/lobby(ongame)/store/goldstore/itemicon_tower/"..self.id..".png")
    sprite5:addTo(sprite1)
    sprite5:setScale(0.8)
    sprite5:setAnchorPoint(0.5, 0.5)
    sprite5:setPosition(sprite1:getContentSize().width/2,sprite1:getContentSize().height/2)
    display.newTTFLabel({
        text = "X "..self.num,
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER_BOTTOM, sprite5:getContentSize().width/2,23)
    :addTo(sprite5)

    -- -- 屏蔽点击
    -- self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) 
    --     if event.name == "began" then
    --         return true
    --     end
    -- end)
    -- self:setTouchEnabled(true)
end


--[[--
    传入购买商品数据

    @param i 类型：number，第几个商品
    @param num 类型：number，商品数目
    @param price 类型：number，商品价格
    @param tower 类型：table，商品

    @return none
]]
function BuyLayer:SetBuy(i,num,price,tower)
    self.i=i
    self.num=num
    self.price=price
    self.id=tower:getTowerId()
    self.tower=tower
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function BuyLayer:update(dt)

end

return BuyLayer

