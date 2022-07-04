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
function TowerDetailDialog:ctor(card)
    TowerDetailDialog.super.ctor(self)

    self.container_ = nil -- 全局容器
    self.card_ = card

    -- 卡片栏
    self.rarityBG_ = card:getRarityBG() -- 稀有度背景
    self.typeImg_ = card:getTypeImg() -- 塔类型角标
    self.spriteImg_ = card:getSmallSpriteImg() -- 塔的小图
    self.levelImg_ = card:getLevelImg() -- 卡片等级
    self.totalPieceNum_ = card:getNum() -- 拥有卡牌碎片数量
    self.updatePieceNum_ = card:getRequireCardNum() -- 升级所需卡牌数量

    -- 基本信息栏
    self.name_ = card:getName()
    self.rarityTextImg_ = card:getRarityTextImg()
    self.intro_ = card:getIntro()

    -- 技能栏
    self.typeTextImg_ = card:getTypeTextImg()
    self.type_ = card:getType()
    self.atkTextImg_ = card:getAtkTextImg()
    self.atk_ = card:getAtk()
    self.fireCdTextImg_ = card:getFireCdTextImg()
    self.fireCd_ = card:getFireCd()
    self.targetTextImg_ = card:getTargetTextImg()
    self.target_ = card:getTarget()
    self.skillOneTextImg_ = card:getSkillOneTextImg()
    self.skillOneValue_ = card:getSkillOneValue()
    self.skillTwoTextImg_ = card:getSkillTwoTextImg()
    self.skillTwoValue_ = card:getSkillTwoValue()


    self:initView()
    self:hideView()
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

    -- 碎片数量进度条
    local processBar = ccui.ImageView:create("image/lobby/pictorial/towerlist/progressbar_own_number.png")
    processBar:setPosition(0.5*cardWidth, 0.15*cardHeight)
    cardContainer:addChild(processBar)

    -- 碎片数量文字
    local text = string.format("%d/%d", self.totalPieceNum_, self.updatePieceNum_)
    local pieceNumText = ccui.Text:create(text, "font/fzbiaozjw.ttf", 24)
    pieceNumText:enableOutline(cc.c4b(0, 0, 0, 255), 3) -- 描边
    pieceNumText:setTextColor(cc.c4b(165, 237, 255, 255))
    pieceNumText:setPosition(0.5*cardWidth, 0.15*cardHeight)
    cardContainer:addChild(pieceNumText)

    -- 等级
    local level = ccui.ImageView:create(self.levelImg_)
    level:setPosition(0.5*cardWidth, 0.3*cardHeight)
    cardContainer:addChild(level)


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

    -- 类型
    local typeAttr = ccui.Layout:create()
    typeAttr:setBackGroundImage("image/lobby/pictorial/towerdetail/default_attr_bg.png")
    local attrWidth, attrHeight = typeAttr:getBackGroundImageTextureSize().width, typeAttr:getBackGroundImageTextureSize().height
    typeAttr:setContentSize(attrWidth, attrHeight)
    typeAttr:setAnchorPoint(0.5, 0.5)
    typeAttr:setPosition(0.25*dialogWidth, 0.575*dialogHeight)
    dialog:addChild(typeAttr)

    local typeIcon = ccui.ImageView:create("image/lobby/pictorial/towerdetail/attr/type_icon.png")
    typeIcon:setPosition(0.2*attrWidth, 0.5*attrHeight)
    typeAttr:addChild(typeIcon)

    local typeTitle = ccui.ImageView:create(self.typeTextImg_)
    typeTitle:setAnchorPoint(0, 0.5)
    typeTitle:setPosition(0.3*attrWidth, 0.75*attrHeight)
    typeAttr:addChild(typeTitle)


    -- 攻击力
    local atkAttr = ccui.Layout:create()
    atkAttr:setBackGroundImage("image/lobby/pictorial/towerdetail/default_attr_bg.png")
    atkAttr:setContentSize(attrWidth, attrHeight)
    atkAttr:setAnchorPoint(0.5, 0.5)
    atkAttr:setPosition(0.75*dialogWidth, 0.575*dialogHeight)
    dialog:addChild(atkAttr)

    local atkIcon = ccui.ImageView:create("image/lobby/pictorial/towerdetail/attr/attack_icon.png")
    atkIcon:setPosition(0.2*attrWidth, 0.5*attrHeight)
    atkAttr:addChild(atkIcon)

    local atkTitle = ccui.ImageView:create(self.atkTextImg_)
    atkTitle:setAnchorPoint(0, 0.5)
    atkTitle:setPosition(0.3*attrWidth, 0.75*attrHeight)
    atkAttr:addChild(atkTitle)

    local atkText = ccui.Text:create(self.atk_, "font/fzzdhjw.ttf", 26)
    atkText:setTextColor(cc.c4b(165, 237, 255, 255))
    atkText:enableOutline(cc.c4b(20, 20, 66, 255), 2) -- 描边
    atkText:setAnchorPoint(0, 0.5)
    atkText:setPosition(0.3*attrWidth, 0.3*attrHeight)
    atkAttr:addChild(atkText)

    -- 攻速
    local asAttr = ccui.Layout:create()
    asAttr:setBackGroundImage("image/lobby/pictorial/towerdetail/default_attr_bg.png")
    asAttr:setContentSize(attrWidth, attrHeight)
    asAttr:setAnchorPoint(0.5, 0.5)
    asAttr:setPosition(0.25*dialogWidth, 0.4375*dialogHeight)
    dialog:addChild(asAttr)

    local asIcon = ccui.ImageView:create("image/lobby/pictorial/towerdetail/attr/attack_speed_icon.png")
    asIcon:setPosition(0.2*attrWidth, 0.5*attrHeight)
    asAttr:addChild(asIcon)

    local asTitle = ccui.ImageView:create(self.fireCdTextImg_)
    asTitle:setAnchorPoint(0, 0.5)
    asTitle:setPosition(0.3*attrWidth, 0.75*attrHeight)
    asAttr:addChild(asTitle)

    local asText = ccui.Text:create(self.fireCd_, "font/fzzdhjw.ttf", 26)
    asText:setTextColor(cc.c4b(165, 237, 255, 255))
    asText:enableOutline(cc.c4b(20, 20, 66, 255), 2) -- 描边
    asText:setAnchorPoint(0, 0.5)
    asText:setPosition(0.3*attrWidth, 0.3*attrHeight)
    asAttr:addChild(asText)

    -- 目标
    local targetAttr = ccui.Layout:create()
    targetAttr:setBackGroundImage("image/lobby/pictorial/towerdetail/default_attr_bg.png")
    targetAttr:setContentSize(attrWidth, attrHeight)
    targetAttr:setAnchorPoint(0.5, 0.5)
    targetAttr:setPosition(0.75*dialogWidth, 0.4375*dialogHeight)
    dialog:addChild(targetAttr)

    local targetIcon = ccui.ImageView:create("image/lobby/pictorial/towerdetail/attr/target_icon.png")
    targetIcon:setPosition(0.2*attrWidth, 0.5*attrHeight)
    targetAttr:addChild(targetIcon)

    local targetTitle = ccui.ImageView:create(self.targetTextImg_)
    targetTitle:setAnchorPoint(0, 0.5)
    targetTitle:setPosition(0.3*attrWidth, 0.75*attrHeight)
    targetAttr:addChild(targetTitle)

    local targetText = ccui.Text:create(self.target_, "font/fzzdhjw.ttf", 26)
    targetText:setTextColor(cc.c4b(165, 237, 255, 255))
    targetText:enableOutline(cc.c4b(20, 20, 66, 255), 2) -- 描边
    targetText:setAnchorPoint(0, 0.5)
    targetText:setPosition(0.3*attrWidth, 0.3*attrHeight)
    targetAttr:addChild(targetText)

    -- 技能1
    local skillOneAttr = ccui.Layout:create()
    skillOneAttr:setBackGroundImage("image/lobby/pictorial/towerdetail/default_attr_bg.png")
    skillOneAttr:setContentSize(attrWidth, attrHeight)
    skillOneAttr:setAnchorPoint(0.5, 0.5)
    skillOneAttr:setPosition(0.25*dialogWidth, 0.3*dialogHeight)
    dialog:addChild(skillOneAttr)

    local skillOneIcon = ccui.ImageView:create("image/lobby/pictorial/towerdetail/attr/skill_one_icon.png")
    skillOneIcon:setPosition(0.2*attrWidth, 0.5*attrHeight)
    skillOneAttr:addChild(skillOneIcon)

    local skillOneTitle = ccui.ImageView:create(self.skillOneTextImg_)
    skillOneTitle:setAnchorPoint(0, 0.5)
    skillOneTitle:setPosition(0.3*attrWidth, 0.75*attrHeight)
    skillOneAttr:addChild(skillOneTitle)

    local skillOneText = ccui.Text:create(self.skillOneValue_, "font/fzzdhjw.ttf", 26)
    skillOneText:setTextColor(cc.c4b(165, 237, 255, 255))
    skillOneText:enableOutline(cc.c4b(20, 20, 66, 255), 2) -- 描边
    skillOneText:setAnchorPoint(0, 0.5)
    skillOneText:setPosition(0.3*attrWidth, 0.3*attrHeight)
    skillOneAttr:addChild(skillOneText)

    -- 技能2
    local skillTwoAttr = ccui.Layout:create()
    skillTwoAttr:setBackGroundImage("image/lobby/pictorial/towerdetail/default_attr_bg.png")
    skillTwoAttr:setContentSize(attrWidth, attrHeight)
    skillTwoAttr:setAnchorPoint(0.5, 0.5)
    skillTwoAttr:setPosition(0.75*dialogWidth, 0.3*dialogHeight)
    dialog:addChild(skillTwoAttr)

    local skillTwoIcon = ccui.ImageView:create("image/lobby/pictorial/towerdetail/attr/skill_two_icon.png")
    skillTwoIcon:setPosition(0.2*attrWidth, 0.5*attrHeight)
    skillTwoAttr:addChild(skillTwoIcon)

    local skillTwoTitle = ccui.ImageView:create(self.skillTwoTextImg_)
    skillTwoTitle:setAnchorPoint(0, 0.5)
    skillTwoTitle:setPosition(0.3*attrWidth, 0.75*attrHeight)
    skillTwoAttr:addChild(skillTwoTitle)

    local skillTwoText = ccui.Text:create(self.skillTwoValue_, "font/fzzdhjw.ttf", 26)
    skillTwoText:setTextColor(cc.c4b(165, 237, 255, 255))
    skillTwoText:enableOutline(cc.c4b(20, 20, 66, 255), 2) -- 描边
    skillTwoText:setAnchorPoint(0, 0.5)
    skillTwoText:setPosition(0.3*attrWidth, 0.3*attrHeight)
    skillTwoAttr:addChild(skillTwoText)


    --- 按钮栏

    -- 强化
    local enforceBtn = ccui.Button:create("image/lobby/pictorial/towerdetail/enforce_btn.png")
    enforceBtn:setAnchorPoint(0, 0.5)
    enforceBtn:setPosition(0.1*display.width, 0.12*display.height)
    self.container_:addChild(enforceBtn)

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

        end
    end)
    upgradeBtn:setTouchEnabled(true)
    self.container_:addChild(upgradeBtn)

    local goldIcon = ccui.ImageView:create("image/lobby/pictorial/towerdetail/gold_icon.png")
    goldIcon:setAnchorPoint(0.5, 0.5)
    goldIcon:setPosition(0.3*btnWidth, 0.22*btnHeight)
    upgradeBtn:addChild(goldIcon)

    local goldText = ccui.Text:create(1000, "font/fzbiaozjw.ttf", 24)
    goldText:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 2像素纯黑色描边
    goldText:setTextColor(cc.c4b(255, 255, 255, 255))
    goldText:setPosition(0.4*btnWidth, 0.22*btnHeight)
    goldText:setAnchorPoint(0, 0.5)
    upgradeBtn:addChild(goldText)


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
    local currentCriticalDamageValue = string.format("%d%%", 200)
    local currentCriticalDamageValueText = ccui.Text:create(currentCriticalDamageValue, "font/fzhzgbjw.ttf", 20)
    currentCriticalDamageValueText:enableOutline(cc.c4b(0, 0, 0, 255), 1) -- 1像素纯黑色描边
    currentCriticalDamageValueText:setTextColor(cc.c4b(255, 193, 46, 255))
    currentCriticalDamageValueText:setPosition(0.5*dialogWidth, 0.09*dialogHeight)
    currentCriticalDamageValueText:setAnchorPoint(0, 0.5)
    self.container_:addChild(currentCriticalDamageValueText)

    -- 升级后
    local upgradedCriticalDamageValue = string.format("%d%%", 203)
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
                self:hideView()
            end

            return true
        end
        return false
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    eventDispatcher:addEventListenerWithSceneGraphPriority(self.listener_, self)


end

return TowerDetailDialog