--[[
    TowerDetailDialog.lua
    塔详情弹窗
    描述：塔详情弹窗
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local TowerDetailDialog = class("TowerDetailDialog", require("app.ui.layer.BaseUILayout"))
local ConstDef = require("app.def.ConstDef")
local ReplaceCardDialog = require("app.ui.layer.lobby.pictorial.dialog.dialog.ReplaceCardDialog")
local DialogManager = require("app.manager.DialogManager")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")
local PlayerData = require("app.data.PlayerData")
local FailDialog = require("app.ui.layer.lobby.general.dialog.FailDialog")
local CardAttrComp = require("app.ui.layer.lobby.pictorial.component.component.component.CardAttrComp")
local MsgManager = require("app.manager.MsgManager")
local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

--[[--
    构造函数

    @param card 类型：card，卡片

    @return none
]]
function TowerDetailDialog:ctor(card)
    TowerDetailDialog.super.ctor(self)

    self.cardAttrComp_ = nil

    self.container_ = nil -- 全局容器
    self.processBarFG_ = nil
    self.levelIcon_ = nil
    self.pieceNumText_ = nil
    self.goldText_ = nil

    -- 加载音效资源
    audio.loadFile("audio/tower_level_up.ogg", function() end)

    self:initParam(card)
    self:initView()
    self:hideView()
end


--[[--
    参数初始化

    @param none

    @return none
]]
function TowerDetailDialog:initParam(card)
    self.card_ = card
    -- 卡片栏
    self.rarityBG_ = self.card_:getRarityBG() -- 稀有度背景
    self.typeImg_ = self.card_:getTypeImg() -- 塔类型角标
    self.spriteImg_ = self.card_:getSmallSpriteImg() -- 塔的小图
    self.levelImg_ = self.card_:getLevelImg() -- 卡片等级
    self.totalPieceNum_ = self.card_:getNum() -- 拥有卡牌碎片数量
    self.updatePieceNum_ = self.card_:getRequireCardNum() -- 升级所需卡牌数量

    -- 基本信息栏
    self.id_ = self.card_:getId()
    self.name_ = self.card_:getName()
    self.rarityTextImg_ = self.card_:getRarityTextImg()
    self.intro_ = self.card_:getIntro()

    -- 功能栏
    self.cost_ = self.card_:getRequireGoldNum()
    self.criticalDamage_ = PlayerData:getCriticalDamage()

    self.tag_ = self.card_:getId()

end

--[[--
    界面初始化

    @param none

    @return none
]]
function TowerDetailDialog:initView()

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
    dialog:setBackGroundImage("image/lobby/pictorial/towerdetail/dialog_bg.png")
    local dialogWidth, dialogHeight = dialog:getBackGroundImageTextureSize().width, dialog:getBackGroundImageTextureSize().height
    dialog:setContentSize(dialogWidth, dialogHeight)
    dialog:setAnchorPoint(0.5, 0.5)
    dialog:setPosition(display.width/2, 0.35*display.height)
    self.container_:addChild(dialog)

    -- 关闭按钮
    local closeBtn = ccui.Button:create("image/lobby/pictorial/towerdetail/close_btn.png")
    closeBtn:setPosition(0.95*dialogWidth, 0.95*dialogHeight)
    closeBtn:addClickEventListener(function()
        self:hideView()
    end)
    dialog:addChild(closeBtn)


    --- 卡片栏

    local cardWidth, cardHeight = ConstDef.CARD_SIZE.TYPE_2.WIDTH,
    ConstDef.CARD_SIZE.TYPE_2.HEIGHT

    -- Card组件 - 背景
    local cardContainer = ccui.Layout:create()
    cardContainer:setBackGroundImage(self.rarityBG_)
    cardContainer:setAnchorPoint(0.5, 0.5)
    cardContainer:setPosition(0.2*dialogWidth, 0.825*dialogHeight)
    cardContainer:setContentSize(cardWidth, cardHeight)
    dialog:addChild(cardContainer)

    -- 精灵图标
    local spriteIcon = ccui.ImageView:create(self.spriteImg_)
    spriteIcon:setPosition(0.5*cardWidth, 0.6*cardHeight)
    cardContainer:addChild(spriteIcon)

    -- 类型图标
    local typeIcon = ccui.ImageView:create(self.typeImg_)
    typeIcon:setPosition(0.8*cardWidth, 0.8*cardHeight)
    cardContainer:addChild(typeIcon)

    -- 碎片数量进度条背景
    local processBarBG = ccui.ImageView:create("image/lobby/pictorial/towerlist/progressbar_bg.png")
    processBarBG:setPosition(0.5*cardWidth, 0.15*cardHeight)
    cardContainer:addChild(processBarBG)

    -- 碎片数量进度条前景
    self.processBarFG_ = ccui.ImageView:create("image/lobby/pictorial/towerlist/progressbar_own_number.png")
    self.processBarFG_:setAnchorPoint(0, 0.5)
    self.processBarFG_:setPosition(0.1*cardWidth, 0.15*cardHeight)
    local scale = self.totalPieceNum_ / self.updatePieceNum_
    self.processBarFG_:setScale(scale<=1 and scale or 1, 1)
    cardContainer:addChild(self.processBarFG_)

    -- 碎片数量文字
    local text = string.format("%d/%d", self.totalPieceNum_, self.updatePieceNum_)
    self.pieceNumText_ = ccui.Text:create(text, "font/fzbiaozjw.ttf", 24)
    self.pieceNumText_:enableOutline(cc.c4b(0, 0, 0, 255), 3) -- 描边
    self.pieceNumText_:setTextColor(cc.c4b(165, 237, 255, 255))
    self.pieceNumText_:setPosition(0.5*cardWidth, 0.15*cardHeight)
    cardContainer:addChild(self.pieceNumText_)

    -- 等级
    self.levelIcon_ = ccui.ImageView:create(self.levelImg_)
    self.levelIcon_:setPosition(0.5*cardWidth, 0.3*cardHeight)
    cardContainer:addChild(self.levelIcon_)


    --- 信息栏

    -- 名字
    local nameTitle = ccui.ImageView:create("image/lobby/pictorial/towerdetail/text/name_text.png")
    nameTitle:setAnchorPoint(0, 0.5)
    nameTitle:setPosition(0.35*dialogWidth, 0.95*dialogHeight)
    dialog:addChild(nameTitle)

    local nameText = ccui.Text:create(self.name_, "font/fzzdhjw.ttf", 34)
    nameText:setTextColor(cc.c4b(255, 255, 255, 255))
    nameText:setAnchorPoint(0, 0.5) -- 文本右对齐
    nameText:setPosition(0.35*dialogWidth, 0.9*dialogHeight)
    dialog:addChild(nameText)

    -- 稀有度
    local rarityTitle = ccui.ImageView:create("image/lobby/pictorial/towerdetail/text/rarity_text.png")
    rarityTitle:setAnchorPoint(0, 0.5)
    rarityTitle:setPosition(0.75*dialogWidth, 0.95*dialogHeight)
    dialog:addChild(rarityTitle)

    local rarityText = ccui.ImageView:create(self.rarityTextImg_)
    rarityText:setAnchorPoint(0.5, 0.5)
    rarityText:setScale(1.5)
    rarityText:setPosition(0.8*dialogWidth, 0.9*dialogHeight)
    dialog:addChild(rarityText)

    -- 技能介绍
    local introBG = ccui.ImageView:create("image/lobby/pictorial/towerdetail/skill_bg.png")
    introBG:setAnchorPoint(0.5, 0.5)
    introBG:setPosition(0.65*dialogWidth, 0.775*dialogHeight)
    dialog:addChild(introBG)

    local introTitle = ccui.ImageView:create("image/lobby/pictorial/towerdetail/text/skill_intro_text.png")
    introTitle:setAnchorPoint(0, 0.5)
    introTitle:setPosition(0.35*dialogWidth, 0.825*dialogHeight)
    dialog:addChild(introTitle)

    local introText = ccui.TextField:create(self.intro_, "font/fzbiaozjw.ttf", 20)
    introText:setTextColor(cc.c4b(255, 255, 255, 255))
    introText:setAnchorPoint(0, 0) -- 文本右对齐
    introText:ignoreContentAdaptWithSize(false)
    introText:setContentSize(cc.size(0.6*dialogWidth, 0.2*dialogHeight))
    introText:setPosition(0.35*dialogWidth, 0.6*dialogHeight)
    dialog:addChild(introText)

    --- 属性栏
    self.cardAttrComp_ = CardAttrComp.new(self.card_)
    self.cardAttrComp_:setPosition(0.5*display.width, 0.35*display.height)
    self.container_:addChild(self.cardAttrComp_)


    --- 按钮栏

    -- 强化
    local enhanceBtn = ccui.Button:create("image/lobby/pictorial/towerdetail/enhance_btn.png")
    enhanceBtn:setAnchorPoint(0, 0.5)
    enhanceBtn:setPosition(0.1*display.width, 0.12*display.height)
    enhanceBtn:addTouchEventListener(function(touch, event)
        print(event)
        if event == 0 then
            EventManager:doEvent(EventDef.ID.CARD_ENFORCE_SHOW)
        elseif event == 2 or event == 3 then
            EventManager:doEvent(EventDef.ID.CARD_ENFORCE_HIDE)
        end
    end)
    self.container_:addChild(enhanceBtn)

    -- 升级
    local upgradeBtn = ccui.Layout:create()
    upgradeBtn:setBackGroundImage("image/lobby/pictorial/towerdetail/upgrade_btn.png")
    local btnWidth, btnHeight = upgradeBtn:getBackGroundImageTextureSize().width, upgradeBtn:getBackGroundImageTextureSize().height
    upgradeBtn:setContentSize(btnWidth, btnHeight)
    upgradeBtn:setAnchorPoint(0.5, 0.5)
    upgradeBtn:setPosition(0.5*display.width, 0.12*display.height)
    upgradeBtn:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            -- 放大事件
            local ac1 = cc.ScaleTo:create(0.1, 1.1)
            local ac2 = cc.ScaleTo:create(0.1, 1)
            local action = cc.Sequence:create(ac1, ac2)
            upgradeBtn:runAction(action)
            return true
        else
            local state = PlayerData:upgradeCard(self.id_)

            if state == 0 then -- 判断逻辑
                print("升级成功")
                audio.playEffect("audio/tower_level_up.ogg", false)
                EventManager:doEvent(EventDef.ID.CARD_UPGRADE, self.tag_)
            elseif state == 1 then -- 卡牌不足
                local dialog = FailDialog.new(ConstDef.FAIL_CODE.UPGRADE_CARD_DEFICIENCY)
                DialogManager:showDialog(dialog)
                print("卡牌不足")
            else -- 金币不足
                local dialog = FailDialog.new(ConstDef.FAIL_CODE.UPGRADE_GOLD_DEFICIENCY)
                DialogManager:showDialog(dialog)
                print("金币不足")
            end
        end
    end)
    upgradeBtn:setTouchEnabled(true)
    self.container_:addChild(upgradeBtn)

    local goldIcon = ccui.ImageView:create("image/lobby/pictorial/towerdetail/gold_icon.png")
    goldIcon:setAnchorPoint(0.5, 0.5)
    goldIcon:setPosition(0.3*btnWidth, 0.22*btnHeight)
    upgradeBtn:addChild(goldIcon)

    self.goldText_ = ccui.Text:create(self.cost_, "font/fzbiaozjw.ttf", 24)
    self.goldText_:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 2像素纯黑色描边
    self.goldText_:setTextColor(cc.c4b(255, 255, 255, 255))
    self.goldText_:setPosition(0.4*btnWidth, 0.22*btnHeight)
    self.goldText_:setAnchorPoint(0, 0.5)
    upgradeBtn:addChild(self.goldText_)


    -- 使用
    local useBtn = ccui.Button:create("image/lobby/pictorial/towerdetail/use_btn.png")
    useBtn:setAnchorPoint(1, 0.5)
    useBtn:setPosition(0.9*display.width, 0.12*display.height)
    useBtn:addClickEventListener(
            function()
                self:hideView()
                EventManager:doEvent(EventDef.ID.COLLECTION_VIEW_HIDE)
                local dialog = ReplaceCardDialog.new(self.card_)
                DialogManager:showDialog(dialog)
            end
    )
    self.container_:addChild(useBtn)

    --- 暴击

    -- 当前暴击伤害
    local currentCriticalDamageValue = string.format("%d%%", self.criticalDamage_)
    self.currentCriticalDamageValueText_ = ccui.Text:create(currentCriticalDamageValue, "font/fzhzgbjw.ttf", 20)
    self.currentCriticalDamageValueText_:enableOutline(cc.c4b(0, 0, 0, 255), 1) -- 1像素纯黑色描边
    self.currentCriticalDamageValueText_:setTextColor(cc.c4b(255, 193, 46, 255))
    self.currentCriticalDamageValueText_:setPosition(0.5*dialogWidth, 0.09*dialogHeight)
    self.currentCriticalDamageValueText_:setAnchorPoint(0, 0.5)
    self.container_:addChild(self.currentCriticalDamageValueText_)

    -- 升级后
    local upgradedCriticalDamageValue = string.format("+%d%%", 3)
    local upgradedCriticalDamageValueText = ccui.Text:create(upgradedCriticalDamageValue, "font/fzhzgbjw.ttf", 20)
    upgradedCriticalDamageValueText:enableOutline(cc.c4b(0, 0, 0, 255), 1) -- 1像素纯黑色描边
    upgradedCriticalDamageValueText:setTextColor(cc.c4b(255, 193, 46, 255))
    upgradedCriticalDamageValueText:setPosition(0.75*dialogWidth, 0.09*dialogHeight)
    upgradedCriticalDamageValueText:setAnchorPoint(0, 0.5)
    self.container_:addChild(upgradedCriticalDamageValueText)


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

            end

            return true
        end
        return false
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    eventDispatcher:addEventListenerWithSceneGraphPriority(self.listener_, self)

end

--[[--
    onEnter

    @param none

    @return none
]]
function TowerDetailDialog:onEnter()
    EventManager:regListener(EventDef.ID.CARD_UPGRADE, self, function(tag)
        if self.tag_ == tag then
            self:update()
        end
    end)
    -- 生命周期
    -- 购买卡牌与购买宝箱时TowerDetailDialog不存在,其生命周期较短
end

--[[--
    onExit

    @param none

    @return none
]]
function TowerDetailDialog:onExit()
    EventManager:unRegListener(EventDef.ID.CARD_UPGRADE, self)
end

--[[--
    界面刷新

    @param none

    @return none
]]
function TowerDetailDialog:update()
    self.goldText_:setString(self.card_:getRequireGoldNum())
    self.pieceNumText_:setString(string.format("%d/%d", self.card_:getNum(), self.card_:getRequireCardNum()))
    self.levelIcon_:loadTexture(self.card_:getLevelImg())
    local scale = self.card_:getNum()/self.card_:getRequireCardNum()
    self.processBarFG_:setScale(scale<=1 and scale or 1, 1)
    local currentCriticalDamageValue = string.format("%d%%", PlayerData:getCriticalDamage())
    self.currentCriticalDamageValueText_:setString(currentCriticalDamageValue)
    -- 向服务端更新数据
    MsgManager:sendPlayerData()
end


return TowerDetailDialog