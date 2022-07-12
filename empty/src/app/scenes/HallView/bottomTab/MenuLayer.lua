----内容：底部按钮栏
----编写人员：孙靖博、郑蕾
---修订人员：郑蕾
---最后修改日期：7/12
local MenuLayer = class("MenuLayer")

function MenuLayer:createBottomTab(layer,pageView)
    local width,height = display.width,display.top
    local menuLayer = ccui.Layout:create()
    menuLayer:setContentSize(width,140)
    menuLayer:setAnchorPoint(0,0)
    menuLayer:setPosition(0,0)
    menuLayer:addTo(layer)
    --未选择
    self:unselectedLayer(menuLayer)
    --已选择
    self:selectedLayer(menuLayer)
    --点击事件
    self:clickEvent(pageView)
end

--[[
    函数用途：创建未选中按钮
    --]]
function MenuLayer:unselectedLayer(menuLayer)
    --未选中商店
    self.unselectedShop = ccui.Layout:create()
    self.unselectedShop:setBackGroundImage("ui/hall/bottom-tab/tab-unselected-left.png")
    self.unselectedShop:setContentSize(230,115)
    self.unselectedShop:setAnchorPoint(0,0)
    self.unselectedShop:setPosition(0,0)
    self.unselectedShop:setTouchEnabled(true)
    self.unselectedShop:addTo(menuLayer)
    --商店按钮图标
    local shopImage = ccui.ImageView:create("ui/hall/bottom-tab/chart-shop.png")
    shopImage:setPosition(cc.p(30, 10))
    shopImage:setAnchorPoint(0,0)
    shopImage:addTo(self.unselectedShop)

    --未选中图鉴
    self.unselectedAtlas = ccui.Layout:create()
    self.unselectedAtlas:setBackGroundImage("ui/hall/bottom-tab/tab-unselected-right.png")
    self.unselectedAtlas:setContentSize(230,115)
    self.unselectedAtlas:setAnchorPoint(1,0)
    self.unselectedAtlas:setPosition(display.width,0)
    self.unselectedAtlas:setTouchEnabled(true)
    self.unselectedAtlas:addTo(menuLayer)
    --图鉴按钮图标
    local atlasImage = ccui.ImageView:create("ui/hall/bottom-tab/chart-Atlas.png")
    atlasImage:setPosition(cc.p(30, 10))
    atlasImage:setAnchorPoint(0,0)
    atlasImage:addTo(self.unselectedAtlas)

    --未选中战斗
    self.unselectedBattle = ccui.Layout:create()
    self.unselectedBattle:setBackGroundImage("ui/hall/bottom-tab/tab-unselected-middle.png")
    self.unselectedBattle:setContentSize(230,115)
    self.unselectedBattle:setAnchorPoint(0.5,0)
    self.unselectedBattle:setPosition(display.cx,0)
    self.unselectedBattle:setTouchEnabled(true)
    self.unselectedBattle:addTo(menuLayer)
    --战斗按钮图标
    local battleImage = ccui.ImageView:create("ui/hall/bottom-tab/chart-battle.png")
    battleImage:setPosition(cc.p(30, 10))
    battleImage:setAnchorPoint(0,0)
    battleImage:addTo(self.unselectedBattle)
end

--[[
    函数用途：创建已选中按钮
    --]]
function MenuLayer:selectedLayer(menuLayer)
    --选中商店
    self.selectedShop = ccui.Layout:create()
    self.selectedShop:setBackGroundImage("ui/hall/bottom-tab/tab-selected.png")
    self.selectedShop:setContentSize(260,139)
    self.selectedShop:setAnchorPoint(0,0)
    self.selectedShop:setPosition(0,0)
    self.selectedShop:addTo(menuLayer)
    self.selectedShop:setVisible(false)
    --商店按钮图标
    local shopImage = ccui.ImageView:create("ui/hall/bottom-tab/chart-shop.png")
    shopImage:setPosition(cc.p(35, 30))
    shopImage:setAnchorPoint(0,0)
    shopImage:addTo(self.selectedShop)
    --商店标题
    local shopName = ccui.ImageView:create("ui/hall/bottom-tab/title-shop.png")
    shopName:setAnchorPoint(0, 0)
    shopName:setPosition(cc.p(95, 5))
    shopName:addTo(self.selectedShop)

    --选中图鉴
    self.selectedAtlas = ccui.Layout:create()
    self.selectedAtlas:setBackGroundImage("ui/hall/bottom-tab/tab-selected.png")
    self.selectedAtlas:setContentSize(260,139)
    self.selectedAtlas:setAnchorPoint(1,0)
    self.selectedAtlas:setPosition(display.width,0)
    self.selectedAtlas:addTo(menuLayer)
    self.selectedAtlas:setVisible(false)
    --图鉴按钮图标
    local atlasImage = ccui.ImageView:create("ui/hall/bottom-tab/chart-Atlas.png")
    atlasImage:setPosition(cc.p(35, 30))
    atlasImage:setAnchorPoint(0,0)
    atlasImage:addTo(self.selectedAtlas)
    --图鉴标题
    local atlasName = ccui.ImageView:create("ui/hall/bottom-tab/title-Atlas.png")
    atlasName:setAnchorPoint(0, 0)
    atlasName:setPosition(cc.p(95, 5))
    atlasName:addTo(self.selectedAtlas)

    --选中战斗
    self.selectedBattle = ccui.Layout:create()
    self.selectedBattle:setBackGroundImage("ui/hall/bottom-tab/tab-selected.png")
    self.selectedBattle:setContentSize(260,139)
    self.selectedBattle:setAnchorPoint(0.5,0)
    self.selectedBattle:setPosition(display.cx,0)
    self.selectedBattle:addTo(menuLayer)
    --self.selectedBattle:setVisible(false)
    --战斗按钮图标
    local battleImage = ccui.ImageView:create("ui/hall/bottom-tab/chart-battle.png")
    battleImage:setPosition(cc.p(35, 30))
    battleImage:setAnchorPoint(0,0)
    battleImage:addTo(self.selectedBattle)
    --战斗标题
    local battleName = ccui.ImageView:create("ui/hall/bottom-tab/title-battle.png")
    battleName:setAnchorPoint(0, 0)
    battleName:setPosition(cc.p(95, 5))
    battleName:addTo(self.selectedBattle)
end

--[[
    函数用途：按钮响应事件
    --]]
function MenuLayer:clickEvent(pageView)
    self.unselectedShop:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            self.selectedShop:setVisible(true)
            self.selectedAtlas:setVisible(false)
            self.selectedBattle:setVisible(false)
            pageView:scrollToPage(0)

        end
    end)
    self.unselectedAtlas:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            self.selectedAtlas:setVisible(true)
            self.selectedBattle:setVisible(false)
            self.selectedShop:setVisible(false)
            pageView:scrollToPage(2)

        end
    end)
    self.unselectedBattle:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            self.selectedBattle:setVisible(true)
            self.selectedAtlas:setVisible(false)
            self.selectedShop:setVisible(false)
            pageView:scrollToPage(1)

        end
    end)
end
return MenuLayer