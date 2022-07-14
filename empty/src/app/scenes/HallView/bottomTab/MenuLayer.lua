----内容：底部按钮栏
----编写人员：孙靖博、郑蕾
---修订人员：郑蕾
---最后修改日期：7/12
local MenuLayer = {}

function MenuLayer:createBottomTab(layer,pageView)
    local width,height = display.width,display.top
    local menuLayer = ccui.Layout:create()
    menuLayer:setContentSize(width,140)
    menuLayer:setAnchorPoint(0,0)
    menuLayer:setPosition(0,0)
    menuLayer:addTo(layer)
    --未选择
    local shopUnselectedLayer = self:shopUnselectedLayer(menuLayer)
    local atlasUnselectedLayer = self:atlasUnselectedLayer(menuLayer)
    local battleUnselectedLayer = self:battleUnselectedLayer(menuLayer)
    --已选择
    local shopSelectedLayer = self:shopSelectedLayer(menuLayer)
    local atlasSelectedLayer = self:atlasSelectedLayer(menuLayer)
    local battleSelectedLayer = self:battleSelectedLayer(menuLayer)
    --点击事件
    self:clickEvent(pageView,shopUnselectedLayer,atlasUnselectedLayer,battleUnselectedLayer,
            shopSelectedLayer,atlasSelectedLayer,battleSelectedLayer)
end

function MenuLayer:refresh()

end

--[[
    函数用途：创建商店未选中按钮
    --]]
function MenuLayer:shopUnselectedLayer(menuLayer)
    --未选中商店
    local unselectedShop = ccui.Layout:create()
    unselectedShop:setBackGroundImage("ui/hall/bottom-tab/tab-unselected-left.png")
    unselectedShop:setContentSize(230,115)
    unselectedShop:setAnchorPoint(0,0)
    unselectedShop:setPosition(0,0)
    unselectedShop:setTouchEnabled(true)
    unselectedShop:addTo(menuLayer)
    --商店按钮图标
    local shopImage = ccui.ImageView:create("ui/hall/bottom-tab/chart-shop.png")
    shopImage:setPosition(cc.p(30, 10))
    shopImage:setAnchorPoint(0,0)
    shopImage:addTo(unselectedShop)

    return unselectedShop
end

--[[
    函数用途：创建图鉴未选中按钮
    --]]
function MenuLayer:atlasUnselectedLayer(menuLayer)
    --未选中图鉴
    local unselectedAtlas = ccui.Layout:create()
    unselectedAtlas:setBackGroundImage("ui/hall/bottom-tab/tab-unselected-right.png")
    unselectedAtlas:setContentSize(230,115)
    unselectedAtlas:setAnchorPoint(1,0)
    unselectedAtlas:setPosition(display.width,0)
    unselectedAtlas:setTouchEnabled(true)
    unselectedAtlas:addTo(menuLayer)
    --图鉴按钮图标
    local atlasImage = ccui.ImageView:create("ui/hall/bottom-tab/chart-Atlas.png")
    atlasImage:setPosition(cc.p(30, 10))
    atlasImage:setAnchorPoint(0,0)
    atlasImage:addTo(unselectedAtlas)
    return unselectedAtlas
end

--[[
    函数用途：创建战斗未选中按钮
    --]]
function MenuLayer:battleUnselectedLayer(menuLayer)
    --未选中战斗
    local unselectedBattle = ccui.Layout:create()
    unselectedBattle:setBackGroundImage("ui/hall/bottom-tab/tab-unselected-middle.png")
    unselectedBattle:setContentSize(230,115)
    unselectedBattle:setAnchorPoint(0.5,0)
    unselectedBattle:setPosition(display.cx,0)
    unselectedBattle:setTouchEnabled(true)
    unselectedBattle:addTo(menuLayer)
    --战斗按钮图标
    local battleImage = ccui.ImageView:create("ui/hall/bottom-tab/chart-battle.png")
    battleImage:setPosition(cc.p(30, 10))
    battleImage:setAnchorPoint(0,0)
    battleImage:addTo(unselectedBattle)
    return unselectedBattle
end


--[[
    函数用途：创建商店已选中按钮
    --]]
function MenuLayer:shopSelectedLayer(menuLayer)
    --选中商店
    local selectedShop = ccui.Layout:create()
    selectedShop:setBackGroundImage("ui/hall/bottom-tab/tab-selected.png")
    selectedShop:setContentSize(260,139)
    selectedShop:setAnchorPoint(0,0)
    selectedShop:setPosition(0,0)
    selectedShop:addTo(menuLayer)
    selectedShop:setVisible(false)
    --商店按钮图标
    local shopImage = ccui.ImageView:create("ui/hall/bottom-tab/chart-shop.png")
    shopImage:setPosition(cc.p(35, 30))
    shopImage:setAnchorPoint(0,0)
    shopImage:addTo(selectedShop)
    --商店标题
    local shopName = ccui.ImageView:create("ui/hall/bottom-tab/title-shop.png")
    shopName:setAnchorPoint(0, 0)
    shopName:setPosition(cc.p(95, 5))
    shopName:addTo(selectedShop)

    return selectedShop
end

--[[
    函数用途：创建图鉴已选中按钮
    --]]
function MenuLayer:atlasSelectedLayer(menuLayer)
    --选中图鉴
    local selectedAtlas = ccui.Layout:create()
    selectedAtlas:setBackGroundImage("ui/hall/bottom-tab/tab-selected.png")
    selectedAtlas:setContentSize(260,139)
    selectedAtlas:setAnchorPoint(1,0)
    selectedAtlas:setPosition(display.width,0)
    selectedAtlas:addTo(menuLayer)
    selectedAtlas:setVisible(false)
    --图鉴按钮图标
    local atlasImage = ccui.ImageView:create("ui/hall/bottom-tab/chart-Atlas.png")
    atlasImage:setPosition(cc.p(35, 30))
    atlasImage:setAnchorPoint(0,0)
    atlasImage:addTo(selectedAtlas)
    --图鉴标题
    local atlasName = ccui.ImageView:create("ui/hall/bottom-tab/title-Atlas.png")
    atlasName:setAnchorPoint(0, 0)
    atlasName:setPosition(cc.p(95, 5))
    atlasName:addTo(selectedAtlas)

    return selectedAtlas
end

--[[
    函数用途：创建战斗已选中按钮
    --]]
function MenuLayer:battleSelectedLayer(menuLayer)
    --选中战斗
    local selectedBattle = ccui.Layout:create()
    selectedBattle:setBackGroundImage("ui/hall/bottom-tab/tab-selected.png")
    selectedBattle:setContentSize(260,139) selectedBattle:setAnchorPoint(0.5,0)
    selectedBattle:setPosition(display.cx,0)
    selectedBattle:addTo(menuLayer)
    --self.selectedBattle:setVisible(false)
    --战斗按钮图标
    local battleImage = ccui.ImageView:create("ui/hall/bottom-tab/chart-battle.png")
    battleImage:setPosition(cc.p(35, 30))
    battleImage:setAnchorPoint(0,0)
    battleImage:addTo(selectedBattle)
    --战斗标题
    local battleName = ccui.ImageView:create("ui/hall/bottom-tab/title-battle.png")
    battleName:setAnchorPoint(0, 0)
    battleName:setPosition(cc.p(95, 5))
    battleName:addTo(selectedBattle)
    return selectedBattle
end

--[[
    函数用途：按钮响应事件
    --]]
function MenuLayer:clickEvent(pageView,shopUnselectedLayer,atlasUnselectedLayer,battleUnselectedLayer,
                              shopSelectedLayer,atlasSelectedLayer,battleSelectedLayer)
    shopUnselectedLayer:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            self:shopState(shopSelectedLayer,atlasSelectedLayer,battleSelectedLayer)
            pageView:scrollToPage(0)

        end
    end)
    atlasUnselectedLayer:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            self:atlasState(shopSelectedLayer,atlasSelectedLayer,battleSelectedLayer)
            pageView:scrollToPage(2)

        end
    end)
    battleUnselectedLayer:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            self:battleState(shopSelectedLayer,atlasSelectedLayer,battleSelectedLayer)
            pageView:scrollToPage(1)

        end
    end)
end

--[[
    函数用途：转换到商店状态
    --]]
function MenuLayer:shopState(shopSelectedLayer,atlasSelectedLayer,battleSelectedLayer)
    shopSelectedLayer:setVisible(true)
    atlasSelectedLayer:setVisible(false)
    battleSelectedLayer:setVisible(false)
end

--[[
    函数用途：转换到战斗状态
    --]]
function MenuLayer:battleState(shopSelectedLayer,atlasSelectedLayer,battleSelectedLayer)
    battleSelectedLayer:setVisible(true)
    atlasSelectedLayer:setVisible(false)
    shopSelectedLayer:setVisible(false)
end

--[[
    函数用途：转换到图鉴状态
    --]]
function MenuLayer:atlasState(shopSelectedLayer,atlasSelectedLayer,battleSelectedLayer)
    atlasSelectedLayer:setVisible(true)
    battleSelectedLayer:setVisible(false)
    shopSelectedLayer:setVisible(false)
end
return MenuLayer