--[[
    PictorialCardComp.lua
    图鉴卡片组件
    描述：图鉴卡片组件
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local PictorialCardComp = class("PictorialCardComp", require("app.ui.layer.BaseUILayout"))
local ConstDef = require("app.def.ConstDef")
local DialogManager = require("app.manager.DialogManager")
local TowerDetailDialog = require("app.ui.layer.lobby.pictorial.dialog.TowerDetailDialog")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")

--[[--
    构造函数

    @param card 类型：CardBase，卡片

    @return none
]]
function PictorialCardComp:ctor(card, isObtain)
    PictorialCardComp.super.ctor(self)

    self.container_ = nil -- 全局容器
    self.isObtain_ = isObtain

    self.processBarFG_ = nil
    self.levelIcon_ = nil
    self.pieceNumText_ = nil

    self:initParam(card)
    self:initView()
end

--[[--
    参数初始化

    @param card 类型：card，卡牌信息
    @param isObtain 类型：boolean，是否已获得

    @return none
]]
function PictorialCardComp:initParam(card)

    self.card_ = card

    -- 一级界面所需参数
    self.rarityBG_ = self.card_:getRarityBG() -- 稀有度背景
    self.typeImg_ = self.card_:getTypeImg() -- 塔类型角标
    self.spriteImg_ = self.card_:getSmallSpriteImg() -- 塔的小图
    self.levelImg_ = self.card_:getLevelImg() -- 卡片等级
    self.totalPieceNum_ = self.card_:getNum() -- 拥有卡牌碎片数量
    self.updatePieceNum_ = self.card_:getRequireCardNum() -- 升级所需卡牌数量

    self.tag_ = self.card_:getId()

end

--[[--
    界面初始化

    @param none

    @return none
]]
function PictorialCardComp:initView()

    local width, height = ConstDef.CARD_SIZE.TYPE_2.WIDTH,
            ConstDef.CARD_SIZE.TYPE_2.HEIGHT

    -- Card组件 - 背景
    self.container_ = ccui.Layout:create()
    self.container_:setBackGroundImage(self.rarityBG_)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setContentSize(width, height)
    self:addChild(self.container_)

    -- 精灵图标
    local spriteIcon = ccui.ImageView:create(self.spriteImg_)
    spriteIcon:setPosition(0.5*width, 0.6*height)
    self.container_:addChild(spriteIcon)

    -- 类型图标
    local typeIcon = ccui.ImageView:create(self.typeImg_)
    typeIcon:setPosition(0.8*width, 0.8*height)
    self.container_:addChild(typeIcon)

    -- 碎片数量进度条背景
    local processBarBG = ccui.ImageView:create("image/lobby/pictorial/towerlist/progressbar_bg.png")
    processBarBG:setPosition(0.5*width, 0.15*height)
    self.container_:addChild(processBarBG)

    -- 碎片数量进度条前景
    self.processBarFG_ = ccui.ImageView:create("image/lobby/pictorial/towerlist/progressbar_own_number.png")
    self.processBarFG_:setAnchorPoint(0, 0.5)
    self.processBarFG_:setPosition(0.1*width, 0.15*height)
    local scale = self.totalPieceNum_ / self.updatePieceNum_
    self.processBarFG_:setScale(scale<=1 and scale or 1, 1)
    self.container_:addChild(self.processBarFG_)

    -- 碎片数量文字
    local text = string.format("%d/%d", self.totalPieceNum_, self.updatePieceNum_)
    self.pieceNumText_ = ccui.Text:create(text, "font/fzbiaozjw.ttf", 24)
    self.pieceNumText_:enableOutline(cc.c4b(0, 0, 0, 255), 3) -- 描边
    self.pieceNumText_:setTextColor(cc.c4b(165, 237, 255, 255))
    self.pieceNumText_:setPosition(0.5*width, 0.15*height)
    self.container_:addChild(self.pieceNumText_)

    -- 等级
    self.levelIcon_ = ccui.ImageView:create(self.levelImg_)
    self.levelIcon_:setPosition(0.5*width, 0.3*height)
    self.container_:addChild(self.levelIcon_)
    self.container_:addTouchEventListener(function(sender, event)

        -- 如果已经获得卡牌则赋予点击响应事件
        if self.isObtain_ then
            if event == 0 then
                -- 放大事件
                local ac1 = cc.ScaleTo:create(0.1, 1.1)
                local ac2 = cc.ScaleTo:create(0.1, 1)
                local action = cc.Sequence:create(ac1, ac2)
                self.container_:runAction(action)
                return true
            elseif event == 2 then
                local dialog = TowerDetailDialog.new(self.card_)
                DialogManager:showDialog(dialog)
                return true
            end

        end
    end)
    self.container_:setTouchEnabled(true)

end

--[[--
    onEnter

    @param none

    @return none
]]
function PictorialCardComp:onEnter()
    EventManager:regListener(EventDef.ID.CARD_UPGRADE, self, function(tag)
        if self.tag_ == tag then -- 通过tag避免多次响应函数
            self:update()
        end
    end)
    EventManager:regListener(EventDef.ID.CARD_PURCHASE, self, function(tag)
        if self.tag_ == tag then -- 通过tag避免多次响应函数
            self:update()
        end
    end)
    EventManager:regListener(EventDef.ID.BOX_PURCHASE, self, function()
        print(789)
        self:update()
    end)
end

--[[--
    onExit

    @param none

    @return none
]]
function PictorialCardComp:onExit()
    EventManager:unRegListener(EventDef.ID.CARD_UPGRADE, self)
    EventManager:unRegListener(EventDef.ID.CARD_PURCHASE, self)
    EventManager:unRegListener(EventDef.ID.BOX_PURCHASE, self)
end

--[[--
    界面刷新

    @param none

    @return none
]]
function PictorialCardComp:update()
    self.pieceNumText_:setString(string.format("%d/%d", self.card_:getNum(), self.card_:getRequireCardNum()))
    self.levelIcon_:loadTexture(self.card_:getLevelImg())
    local scale = self.card_:getNum()/self.card_:getRequireCardNum()
    self.processBarFG_:setScale(scale<=1 and scale or 1, 1)
end

return PictorialCardComp