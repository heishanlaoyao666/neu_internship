--[[
    DiamondStoreComp.lua
    钻石商店组件
    描述：钻石商店组件
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local DiamondStoreComp = class("DiamondStoreComp", require("app.ui.layer.BaseUILayout"))
local ConstDef = require("app.def.ConstDef")
local DialogManager = require("app.manager.DialogManager")
local BoxOpenConfirmDialog = require("app.ui.layer.lobby.store.dialog.BoxOpenConfirmDialog")
local StoreData = require("app.data.StoreData")
--[[--
    构造函数

    @param none

    @return none
]]
function DiamondStoreComp:ctor()
    DiamondStoreComp.super.ctor(self)

    self.container_ = nil -- 全局容器
    self.normalBox_ = nil -- 普通宝箱
    self.rareBox_ = nil -- 稀有宝箱
    self.epicBox_ = nil -- 史诗宝箱
    self.legendBox_ = nil -- 传说宝箱

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function DiamondStoreComp:initView()
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(ConstDef.WINDOW_SIZE.DIAMOND_STORE.WIDTH,
            ConstDef.WINDOW_SIZE.DIAMOND_STORE.HEIGHT)
    self.container_:setAnchorPoint(0, 0)
    self.container_:setPosition(0, 300)
    self:addChild(self.container_)

    -- 牌匾
    local tablet = ccui.Layout:create()
    tablet:setBackGroundImage("image/lobby/store/diamond/title_bg.png")
    tablet:setContentSize(ConstDef.WINDOW_SIZE.TABLET.WIDTH,
            ConstDef.WINDOW_SIZE.TABLET.HEIGHT)
    tablet:setPosition(0, ConstDef.WINDOW_SIZE.DIAMOND_STORE.HEIGHT)
    local tabletTitle = ccui.ImageView:create("image/lobby/store/diamond/store_title.png")
    tabletTitle:setAnchorPoint(0, 0)
    tabletTitle:setPosition((tablet:getContentSize().width - tabletTitle:getContentSize().width)/2,
            (tablet:getContentSize().height - tabletTitle:getContentSize().height)/2)
    tablet:addChild(tabletTitle)
    self.container_:addChild(tablet)


    local width, height = ConstDef.CARD_SIZE.TYPE_4.WIDTH, ConstDef.CARD_SIZE.TYPE_4.HEIGHT

    -- 普通宝箱
    self.normalBox_ = ccui.Layout:create()
    self.normalBox_:setBackGroundImage("image/lobby/store/diamond/normal_bg.png")
    self.normalBox_:setContentSize(width, height)
    self.normalBox_:setAnchorPoint(0.5, 0.5)
    self.normalBox_:setPosition(0.175*ConstDef.WINDOW_SIZE.DIAMOND_STORE.WIDTH,
            0.75*ConstDef.WINDOW_SIZE.DIAMOND_STORE.WIDTH)
    local normalBoxIcon = ccui.ImageView:create("image/lobby/store/diamond/normal_box.png")
    normalBoxIcon:setPosition(0.5*width, 0.5*height)
    self.normalBox_:addChild(normalBoxIcon)
    local diamondIcon = ccui.ImageView:create("image/lobby/store/diamond/diamond_icon.png")
    diamondIcon:setPosition(0.3*width, 0.15*height)
    self.normalBox_:addChild(diamondIcon)
    local normalBoxText = ccui.Text:create(ConstDef.STORE_COST.DIAMOND.NORMAL, "font/fzbiaozjw.ttf", 25)
    normalBoxText:enableShadow(cc.c4b(17, 17, 60, 255), cc.size(0, -2)) -- 阴影
    normalBoxText:enableOutline(cc.c4b(15, 16, 59, 255), 1) -- 描边
    normalBoxText:setAnchorPoint(1, 0) -- 文本右对齐
    normalBoxText:setPosition(0.7*width, 0.1*height)
    self.normalBox_:addChild(normalBoxText)
    self.container_:addChild(self.normalBox_)

    self.normalBox_:addTouchEventListener(function(sender, event)
        if event == 0 then
            -- 放大事件
            local ac1 = cc.ScaleTo:create(0.1, 1.1)
            local ac2 = cc.ScaleTo:create(0.1, 1)
            local action = cc.Sequence:create(ac1, ac2)
            self.normalBox_:runAction(action)
            return true
        elseif event == 2 then
            local dialog = BoxOpenConfirmDialog.new(150, "image/lobby/store/diamond/normal_box.png", StoreData:getNormalBox())
            DialogManager:showDialog(dialog)
            return true
        end
    end)
    self.normalBox_:setTouchEnabled(true)


    -- 稀有宝箱
    self.rareBox_ = ccui.Layout:create()
    self.rareBox_:setBackGroundImage("image/lobby/store/diamond/rare_bg.png")
    self.rareBox_:setContentSize(width, height)
    self.rareBox_:setAnchorPoint(0.5, 0.5)
    self.rareBox_:setPosition(0.5*ConstDef.WINDOW_SIZE.DIAMOND_STORE.WIDTH,
            0.75*ConstDef.WINDOW_SIZE.DIAMOND_STORE.WIDTH)
    local rareBoxIcon = ccui.ImageView:create("image/lobby/store/diamond/rare_box.png")
    rareBoxIcon:setPosition(0.5*width, 0.5*height)
    self.rareBox_:addChild(rareBoxIcon)
    local diamondIcon = ccui.ImageView:create("image/lobby/store/diamond/diamond_icon.png")
    diamondIcon:setPosition(0.3*width, 0.15*height)
    self.rareBox_:addChild(diamondIcon)
    local rareBoxText = ccui.Text:create(ConstDef.STORE_COST.DIAMOND.RARE, "font/fzbiaozjw.ttf", 25)
    rareBoxText:enableShadow(cc.c4b(17, 17, 60, 255), cc.size(0, -2)) -- 阴影
    rareBoxText:enableOutline(cc.c4b(15, 16, 59, 255), 1) -- 描边
    rareBoxText:setAnchorPoint(1, 0) -- 文本右对齐
    rareBoxText:setPosition(0.7*width, 0.1*height)
    self.rareBox_:addChild(rareBoxText)
    self.container_:addChild(self.rareBox_)

    self.rareBox_:addTouchEventListener(function(sender, event)
        if event == 0 then
            -- 放大事件
            local ac1 = cc.ScaleTo:create(0.1, 1.1)
            local ac2 = cc.ScaleTo:create(0.1, 1)
            local action = cc.Sequence:create(ac1, ac2)
            self.rareBox_:runAction(action)
            return true
        elseif event == 2 then
            local dialog = BoxOpenConfirmDialog.new(250, "image/lobby/store/diamond/rare_box.png", StoreData:getRareBox())
            DialogManager:showDialog(dialog)
            return true
        end
    end)
    self.rareBox_:setTouchEnabled(true)


    -- 史诗宝箱
    self.epicBox_ = ccui.Layout:create()
    self.epicBox_:setBackGroundImage("image/lobby/store/diamond/epic_bg.png")
    self.epicBox_:setContentSize(width, height)
    self.epicBox_:setAnchorPoint(0.5, 0.5)
    self.epicBox_:setPosition(0.825*ConstDef.WINDOW_SIZE.DIAMOND_STORE.WIDTH,
            0.75*ConstDef.WINDOW_SIZE.DIAMOND_STORE.WIDTH)
    local epicBoxIcon = ccui.ImageView:create("image/lobby/store/diamond/epic_box.png")
    epicBoxIcon:setPosition(0.5*width, 0.5*height)
    self.epicBox_:addChild(epicBoxIcon)
    local diamondIcon = ccui.ImageView:create("image/lobby/store/diamond/diamond_icon.png")
    diamondIcon:setPosition(0.3*width, 0.15*height)
    self.epicBox_:addChild(diamondIcon)
    local epicBoxText = ccui.Text:create(ConstDef.STORE_COST.DIAMOND.EPIC, "font/fzbiaozjw.ttf", 25)
    epicBoxText:enableShadow(cc.c4b(17, 17, 60, 255), cc.size(0, -2)) -- 阴影
    epicBoxText:enableOutline(cc.c4b(15, 16, 59, 255), 1) -- 描边
    epicBoxText:setAnchorPoint(1, 0) -- 文本右对齐
    epicBoxText:setPosition(0.7*width, 0.1*height)
    self.epicBox_:addChild(epicBoxText)
    self.container_:addChild(self.epicBox_)

    self.epicBox_:addTouchEventListener(function(sender, event)
        if event == 0 then
            -- 放大事件
            local ac1 = cc.ScaleTo:create(0.1, 1.1)
            local ac2 = cc.ScaleTo:create(0.1, 1)
            local action = cc.Sequence:create(ac1, ac2)
            self.epicBox_:runAction(action)
            return true
        elseif event == 2 then
            local dialog = BoxOpenConfirmDialog.new(750, "image/lobby/store/diamond/epic_box.png", StoreData:getEpicBox())
            DialogManager:showDialog(dialog)
            return true
        end
    end)
    self.epicBox_:setTouchEnabled(true)


    width, height = ConstDef.CARD_SIZE.TYPE_5.WIDTH, ConstDef.CARD_SIZE.TYPE_5.HEIGHT

    -- 传奇宝箱
    self.legendBox_ = ccui.Layout:create()
    self.legendBox_:setBackGroundImage("image/lobby/store/diamond/legend_bg.png")
    self.legendBox_:setContentSize(width, height)
    self.legendBox_:setAnchorPoint(0.5, 0.5)
    self.legendBox_:setPosition(0.5*ConstDef.WINDOW_SIZE.DIAMOND_STORE.WIDTH,
            0.3*ConstDef.WINDOW_SIZE.DIAMOND_STORE.WIDTH)
    local legendBoxIcon = ccui.ImageView:create("image/lobby/store/diamond/legend_box.png")
    legendBoxIcon:setPosition(0.5*width, 0.5*height)
    self.legendBox_:addChild(legendBoxIcon)
    local diamondIcon = ccui.ImageView:create("image/lobby/store/diamond/diamond_icon.png")
    diamondIcon:setPosition(0.3*width, 0.15*height)
    self.legendBox_:addChild(diamondIcon)
    local legendBoxText = ccui.Text:create(ConstDef.STORE_COST.DIAMOND.LEGEND, "font/fzbiaozjw.ttf", 25)
    legendBoxText:enableShadow(cc.c4b(17, 17, 60, 255), cc.size(0, -2)) -- 阴影
    legendBoxText:enableOutline(cc.c4b(15, 16, 59, 255), 1) -- 描边
    legendBoxText:setAnchorPoint(1, 0) -- 文本右对齐
    legendBoxText:setPosition(0.7*width, 0.1*height)
    self.legendBox_:addChild(legendBoxText)
    self.container_:addChild(self.legendBox_)

    self.legendBox_:addTouchEventListener(function(sender, event)
        if event == 0 then
            -- 放大事件
            local ac1 = cc.ScaleTo:create(0.1, 1.1)
            local ac2 = cc.ScaleTo:create(0.1, 1)
            local action = cc.Sequence:create(ac1, ac2)
            self.legendBox_:runAction(action)
            return true
        elseif event == 2 then
            local dialog = BoxOpenConfirmDialog.new(2500, "image/lobby/store/diamond/legend_box.png", StoreData:getLegendBox())
            DialogManager:showDialog(dialog)
        end
    end)
    self.legendBox_:setTouchEnabled(true)

end

return DiamondStoreComp