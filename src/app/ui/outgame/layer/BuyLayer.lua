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
    local maskBtn = ccui.Button:create("artcontent/lobby(ongame)/currency/mask_popup.png")
    self:addChild(maskBtn)
    maskBtn:setAnchorPoint(0.5, 0.5)
    maskBtn:setOpacity(127)
    maskBtn:setPosition(display.cx,display.cy)

    maskBtn:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                self:removeFromParent(true)
            end
        end
    )

    --底图
    local basemap = display.newSprite("artcontent/lobby(ongame)/store/goldstore_confirmationpopup/basemap_popup.png")
    basemap:setAnchorPoint(0.5, 0.5)

    self.container_ = ccui.Layout:create()
    -- self.container_:setBackGroundColor(cc.c3b(200, 0, 0))
    -- self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(basemap:getContentSize().width, basemap:getContentSize().height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5,0.5)
    self.container_:setPosition(display.cx, display.cy)
    self.container_:addChild(basemap)
    basemap:setPosition(basemap:getContentSize().width/2, basemap:getContentSize().height/2)

    --x按钮
    local offBtn= ccui.Button:create("artcontent/lobby(ongame)/store/goldstore_confirmationpopup/button_off.png")
    self.container_:addChild(offBtn)
    offBtn:setAnchorPoint(1, 1)
    offBtn:setPosition(basemap:getContentSize().width-20, basemap:getContentSize().height-20)
    offBtn:addTouchEventListener(
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
    local purchase= ccui.Button:create("artcontent/lobby(ongame)/store/goldstore_confirmationpopup/button_purchase.png")
    self.container_:addChild(purchase)
    purchase:setAnchorPoint(0.5, 0.5)
    purchase:setPosition(basemap:getContentSize().width/2, basemap:getContentSize().height/2-130)
    local buyprice = self.price
    local buytower = self.tower
    local buynum=self.num
    local i=self.i
    purchase:addTouchEventListener(
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
    local gold= ccui.Button:create("artcontent/lobby(ongame)/store/goldstore_confirmationpopup/icon_goldcoin.png")
    purchase:addChild(gold)
    gold:setAnchorPoint(0.5, 0.5)
    gold:setPosition(purchase:getContentSize().width/2-50, purchase:getContentSize().height/2)
    display.newTTFLabel({
        text = self.price,
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_CENTER, purchase:getContentSize().width/2+30,purchase:getContentSize().height/2)
    :addTo(purchase)

    --商品图片显示
    local tower = display.newSprite("artcontent/lobby(ongame)/store/goldstore/itemicon_tower/"..self.id..".png")
    tower:addTo(basemap)
    tower:setScale(0.8)
    tower:setAnchorPoint(0.5, 0.5)
    tower:setPosition(basemap:getContentSize().width/2,basemap:getContentSize().height/2)
    display.newTTFLabel({
        text = "X "..self.num,
        size = 25,
        color = cc.c3b(255, 215, 0)
    })
    :align(display.CENTER_BOTTOM, tower:getContentSize().width/2,23)
    :addTo(tower)

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

