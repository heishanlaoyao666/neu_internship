--[[
    CardAttrComp.lua
    图鉴卡片属性组件
    描述：图鉴卡片属性组件
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local CardAttrComp = class("CardAttrComp", require("app.ui.layer.BaseUILayout"))
local ConstDef = require("app.def.ConstDef")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")
local PlayerData = require("app.data.PlayerData")
--[[--
    构造函数

    @param card 类型：CardBase，卡片

    @return none
]]
function CardAttrComp:ctor(card)
    CardAttrComp.super.ctor(self)

    self.container_ = nil
    self.typeAttr_ = nil
    self.atkAttr_ = nil
    self.atkText_ = nil
    self.fireCdAttr_ = nil
    self.fireCdText_ = nil
    self.skillOneAttr_ = nil
    self.skillOneText_ = nil
    self.skillTwoAttr_ = nil

    self.atkUpgradedDeltaText_ = nil
    self.atkEnhancedDeltaText_ = nil
    self.fireCdUpgradedDeltaText_ = nil
    self.skillOneUpgradedDeltaText_ = nil
    self.skillOneEnhancedDeltaText_ = nil

    self:initParam(card)
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function CardAttrComp:initParam(card)

    self.card_ = card

    -- 技能栏
    self.typeTextImg_ = self.card_:getTypeTextImg()
    self.type_ = self.card_:getType()
    self.atkTextImg_ = self.card_:getAtkTextImg()
    self.atk_ = self.card_:getCurAtk()
    self.atkUpgradedDelta_ = self.card_:getAtkUpgradedDelta()
    self.atkEnhancedDelta_ = self.card_:getAtkEnhancedDelta()
    self.fireCdTextImg_ = self.card_:getFireCdTextImg()
    self.fireCd_ = self.card_:getCurFireCd()
    self.fireCdUpgradedDelta_ = self.card_:getFireCdUpgradedDelta()
    self.targetTextImg_ = self.card_:getTargetTextImg()
    self.target_ = self.card_:getTarget()
    self.skillOneTextImg_ = self.card_:getSkillOneTextImg()
    self.skillOneValue_ = self.card_:getCurSkillOneValue()
    self.skillOneUpgradedDelta_ = self.card_:getSkillOneUpgradedDelta()
    self.skillOneEnhancedDelta_ = self.card_:getSkillOneEnhancedDelta()
    self.skillTwoTextImg_ = self.card_:getSkillTwoTextImg()
    self.skillTwoValue_ = self.card_:getSkillTwoValue()

    self.tag_ = self.card_:getId()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function CardAttrComp:initView()

    local tempText = ""

    local width, height = ConstDef.DIALOG_SIZE.TOWER_DETAIL.ATTR.WIDTH,
            ConstDef.DIALOG_SIZE.TOWER_DETAIL.ATTR.HEIGHT
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(width, height)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setCascadeOpacityEnabled(false) -- 穿透
    self:addChild(self.container_)


    -- 类型
    self.typeAttr_ = ccui.Layout:create()
    self.typeAttr_:setBackGroundImage("image/lobby/pictorial/towerdetail/default_attr_bg.png")
    local attrWidth, attrHeight = self.typeAttr_:getBackGroundImageTextureSize().width, self.typeAttr_:getBackGroundImageTextureSize().height
    self.typeAttr_:setContentSize(attrWidth, attrHeight)
    self.typeAttr_:setAnchorPoint(0.5, 0.5)
    self.typeAttr_:setPosition(0.25* width, 0.575* height)
    self.container_:addChild(self.typeAttr_)

    local typeIcon = ccui.ImageView:create("image/lobby/pictorial/towerdetail/attr/type_icon.png")
    typeIcon:setPosition(0.2*attrWidth, 0.5*attrHeight)
    self.typeAttr_:addChild(typeIcon)

    local typeTitle = ccui.ImageView:create(self.typeTextImg_)
    typeTitle:setAnchorPoint(0, 0.5)
    typeTitle:setPosition(0.3*attrWidth, 0.75*attrHeight)
    self.typeAttr_:addChild(typeTitle)

    local map = { "攻击向", "干扰", "辅助", "控制" }
    local typeText = ccui.Text:create(map[self.type_], "font/fzzdhjw.ttf", 26)
    typeText:setTextColor(cc.c4b(165, 237, 255, 255))
    typeText:enableOutline(cc.c4b(20, 20, 66, 255), 2) -- 描边
    typeText:setAnchorPoint(0, 0.5)
    typeText:setPosition(0.3*attrWidth, 0.3*attrHeight)
    self.typeAttr_:addChild(typeText)

    -- 攻击力
    self.atkAttr_ = ccui.Layout:create()
    self.atkAttr_:setBackGroundImage("image/lobby/pictorial/towerdetail/default_attr_bg.png")
    self.atkAttr_:setContentSize(attrWidth, attrHeight)
    self.atkAttr_:setAnchorPoint(0.5, 0.5)
    self.atkAttr_:setPosition(0.75* width, 0.575* height)
    self.container_:addChild(self.atkAttr_)

    local atkIcon = ccui.ImageView:create("image/lobby/pictorial/towerdetail/attr/attack_icon.png")
    atkIcon:setPosition(0.2*attrWidth, 0.5*attrHeight)
    self.atkAttr_:addChild(atkIcon)

    local atkTitle = ccui.ImageView:create(self.atkTextImg_)
    atkTitle:setAnchorPoint(0, 0.5)
    atkTitle:setPosition(0.3*attrWidth, 0.75*attrHeight)
    self.atkAttr_:addChild(atkTitle)

    tempText = self.atk_ ~= nil and string.format("%d", self.atk_) or "--"
    self.atkText_ = ccui.Text:create(tempText, "font/fzzdhjw.ttf", 26)
    self.atkText_:setTextColor(cc.c4b(165, 237, 255, 255))
    self.atkText_:enableOutline(cc.c4b(20, 20, 66, 255), 2) -- 描边
    self.atkText_:setAnchorPoint(0, 0.5)
    self.atkText_:setPosition(0.3*attrWidth, 0.3*attrHeight)
    self.atkAttr_:addChild(self.atkText_)

    tempText = self.atkUpgradedDelta_ ~= nil and string.format("+%d", self.atkUpgradedDelta_) or ""
    self.atkUpgradedDeltaText_ = ccui.Text:create(tempText, "font/fzzdhjw.ttf", 22)
    self.atkUpgradedDeltaText_:setTextColor(cc.c4b(255, 249, 60, 255))
    self.atkUpgradedDeltaText_:enableOutline(cc.c4b(20, 20, 66, 255), 2)
    self.atkUpgradedDeltaText_:setAnchorPoint(0, 0.5)
    self.atkUpgradedDeltaText_:setPosition(0.8*attrWidth, 0.3*attrHeight)
    self.atkAttr_:addChild(self.atkUpgradedDeltaText_)

    tempText = self.atkEnhancedDelta_ ~= nil and string.format("+%d", self.atkEnhancedDelta_) or ""
    self.atkEnhancedDeltaText_ = ccui.Text:create(tempText, "font/fzzdhjw.ttf", 22)
    self.atkEnhancedDeltaText_:setTextColor(cc.c4b(255, 249, 60, 255))
    self.atkEnhancedDeltaText_:enableOutline(cc.c4b(20, 20, 66, 255), 2)
    self.atkEnhancedDeltaText_:setAnchorPoint(0, 0.5)
    self.atkEnhancedDeltaText_:setPosition(0.8*attrWidth, 0.3*attrHeight)
    self.atkAttr_:addChild(self.atkEnhancedDeltaText_ )
    self.atkEnhancedDeltaText_:setVisible(false)


    -- 攻速
    self.fireCdAttr_ = ccui.Layout:create()
    self.fireCdAttr_:setBackGroundImage("image/lobby/pictorial/towerdetail/default_attr_bg.png")
    self.fireCdAttr_:setContentSize(attrWidth, attrHeight)
    self.fireCdAttr_:setAnchorPoint(0.5, 0.5)
    self.fireCdAttr_:setPosition(0.25* width, 0.4375* height)
    self.container_:addChild(self.fireCdAttr_)

    local fireCdIcon = ccui.ImageView:create("image/lobby/pictorial/towerdetail/attr/attack_speed_icon.png")
    fireCdIcon:setPosition(0.2*attrWidth, 0.5*attrHeight)
    self.fireCdAttr_:addChild(fireCdIcon)

    local fireCdTitle = ccui.ImageView:create(self.fireCdTextImg_)
    fireCdTitle:setAnchorPoint(0, 0.5)
    fireCdTitle:setPosition(0.3*attrWidth, 0.75*attrHeight)
    self.fireCdAttr_:addChild(fireCdTitle)

    tempText = self.fireCd_ ~= nil and string.format("%0.2fs", self.fireCd_) or "--"
    self.fireCdText_ = ccui.Text:create(tempText, "font/fzzdhjw.ttf", 26)
    self.fireCdText_:setTextColor(cc.c4b(165, 237, 255, 255))
    self.fireCdText_:enableOutline(cc.c4b(20, 20, 66, 255), 2) -- 描边
    self.fireCdText_:setAnchorPoint(0, 0.5)
    self.fireCdText_:setPosition(0.3*attrWidth, 0.3*attrHeight)
    self.fireCdAttr_:addChild(self.fireCdText_)

    tempText = self.fireCdUpgradedDelta_ ~= nil and string.format("%0.2fs", self.fireCdUpgradedDelta_) or ""
    self.fireCdUpgradedDeltaText_ = ccui.Text:create(tempText, "font/fzzdhjw.ttf", 22)
    self.fireCdUpgradedDeltaText_:setTextColor(cc.c4b(255, 249, 60, 255))
    self.fireCdUpgradedDeltaText_:enableOutline(cc.c4b(20, 20, 66, 255), 2)
    self.fireCdUpgradedDeltaText_:setAnchorPoint(0, 0.5)
    self.fireCdUpgradedDeltaText_:setPosition(0.7*attrWidth, 0.3*attrHeight)
    self.fireCdAttr_:addChild(self.fireCdUpgradedDeltaText_)


    -- 目标
    local targetAttr = ccui.Layout:create()
    targetAttr:setBackGroundImage("image/lobby/pictorial/towerdetail/default_attr_bg.png")
    targetAttr:setContentSize(attrWidth, attrHeight)
    targetAttr:setAnchorPoint(0.5, 0.5)
    targetAttr:setPosition(0.75* width, 0.4375* height)
    self.container_:addChild(targetAttr)

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
    self.skillOneAttr_ = ccui.Layout:create()
    self.skillOneAttr_:setBackGroundImage("image/lobby/pictorial/towerdetail/default_attr_bg.png")
    self.skillOneAttr_:setContentSize(attrWidth, attrHeight)
    self.skillOneAttr_:setAnchorPoint(0.5, 0.5)
    self.skillOneAttr_:setPosition(0.25* width, 0.3* height)
    self.container_:addChild(self.skillOneAttr_)

    local skillOneIcon = ccui.ImageView:create("image/lobby/pictorial/towerdetail/attr/skill_one_icon.png")
    skillOneIcon:setPosition(0.2*attrWidth, 0.5*attrHeight)
    self.skillOneAttr_:addChild(skillOneIcon)

    local skillOneTitle = ccui.ImageView:create(self.skillOneTextImg_)
    skillOneTitle:setAnchorPoint(0, 0.5)
    skillOneTitle:setPosition(0.3*attrWidth, 0.75*attrHeight)
    self.skillOneAttr_:addChild(skillOneTitle)

    tempText = self.skillOneValue_ ~= nil and string.format("%0.3f", self.skillOneValue_) or "--"
    self.skillOneText_ = ccui.Text:create(tempText, "font/fzzdhjw.ttf", 26)
    self.skillOneText_:setTextColor(cc.c4b(165, 237, 255, 255))
    self.skillOneText_:enableOutline(cc.c4b(20, 20, 66, 255), 2) -- 描边
    self.skillOneText_:setAnchorPoint(0, 0.5)
    self.skillOneText_:setPosition(0.3*attrWidth, 0.3*attrHeight)
    self.skillOneAttr_:addChild(self.skillOneText_)

    tempText = self.skillOneUpgradedDelta_ ~= nil and string.format("%0.3f", self.skillOneUpgradedDelta_) or ""
    self.skillOneUpgradedDeltaText_ = ccui.Text:create(tempText, "font/fzzdhjw.ttf", 22)
    self.skillOneUpgradedDeltaText_:setTextColor(cc.c4b(255, 249, 60, 255))
    self.skillOneUpgradedDeltaText_:enableOutline(cc.c4b(20, 20, 66, 255), 2)
    self.skillOneUpgradedDeltaText_:setAnchorPoint(0, 0.5)
    self.skillOneUpgradedDeltaText_:setPosition(0.7*attrWidth, 0.3*attrHeight)
    self.skillOneAttr_:addChild(self.skillOneUpgradedDeltaText_)

    tempText = self.skillOneEnhancedDelta_ ~= nil and string.format("%0.3f", self.skillOneEnhancedDelta_) or ""
    self.skillOneEnhancedDeltaText_ = ccui.Text:create(tempText, "font/fzzdhjw.ttf", 22)
    self.skillOneEnhancedDeltaText_:setTextColor(cc.c4b(255, 249, 60, 255))
    self.skillOneEnhancedDeltaText_:enableOutline(cc.c4b(20, 20, 66, 255), 2)
    self.skillOneEnhancedDeltaText_:setAnchorPoint(0, 0.5)
    self.skillOneEnhancedDeltaText_:setPosition(0.7*attrWidth, 0.3*attrHeight)
    self.skillOneAttr_:addChild(self.skillOneEnhancedDeltaText_)
    self.skillOneEnhancedDeltaText_:setVisible(false)


    -- 技能2
    self.skillTwoAttr_ = ccui.Layout:create()
    self.skillTwoAttr_:setBackGroundImage("image/lobby/pictorial/towerdetail/default_attr_bg.png")
    self.skillTwoAttr_:setContentSize(attrWidth, attrHeight)
    self.skillTwoAttr_:setAnchorPoint(0.5, 0.5)
    self.skillTwoAttr_:setPosition(0.75* width, 0.3* height)
    self.container_:addChild(self.skillTwoAttr_)

    local skillTwoIcon = ccui.ImageView:create("image/lobby/pictorial/towerdetail/attr/skill_two_icon.png")
    skillTwoIcon:setPosition(0.2*attrWidth, 0.5*attrHeight)
    self.skillTwoAttr_:addChild(skillTwoIcon)

    local skillTwoTitle = ccui.ImageView:create(self.skillTwoTextImg_)
    skillTwoTitle:setAnchorPoint(0, 0.5)
    skillTwoTitle:setPosition(0.3*attrWidth, 0.75*attrHeight)
    self.skillTwoAttr_:addChild(skillTwoTitle)

    tempText = self.skillTwoValue_ ~= nil and string.format("%ds", self.skillTwoValue_) or "--"
    local skillTwoText = ccui.Text:create(self.skillTwoValue_, "font/fzzdhjw.ttf", 26)
    skillTwoText:setTextColor(cc.c4b(165, 237, 255, 255))
    skillTwoText:enableOutline(cc.c4b(20, 20, 66, 255), 2) -- 描边
    skillTwoText:setAnchorPoint(0, 0.5)
    skillTwoText:setPosition(0.3*attrWidth, 0.3*attrHeight)
    self.skillTwoAttr_:addChild(skillTwoText)

end

--[[--
    onEnter事件

    @param none

    @return none
]]
function CardAttrComp:onEnter()
    EventManager:regListener(EventDef.ID.CARD_UPGRADE, self, function(tag)
        if self.tag_ == tag then
            self.atkText_:setString(self.card_:getCurAtk() ~= nil and string.format("%d", self.card_:getCurAtk()) or "--")
            self.fireCdText_:setString(self.card_:getCurFireCd() ~= nil and string.format("%0.2fs", self.card_:getCurFireCd()) or "--")
            self.skillOneText_:setString(self.card_:getCurSkillOneValue() ~= nil and string.format("%0.3f", self.card_:getCurSkillOneValue()) or "--")
        end
    end)
    EventManager:regListener(EventDef.ID.CARD_ENFORCE_SHOW, self, function()
        self.atkAttr_:setBackGroundImage("image/lobby/pictorial/towerdetail/enhance_attr_bg.png")
        self.skillOneAttr_:setBackGroundImage("image/lobby/pictorial/towerdetail/enhance_attr_bg.png")
        self.atkUpgradedDeltaText_:setVisible(false)
        self.atkEnhancedDeltaText_:setVisible(true)
        self.skillOneUpgradedDeltaText_:setVisible(false)
        self.skillOneEnhancedDeltaText_:setVisible(true)
    end)
    EventManager:regListener(EventDef.ID.CARD_ENFORCE_HIDE, self, function()
        self.atkAttr_:setBackGroundImage("image/lobby/pictorial/towerdetail/default_attr_bg.png")
        self.skillOneAttr_:setBackGroundImage("image/lobby/pictorial/towerdetail/default_attr_bg.png")
        self.atkUpgradedDeltaText_:setVisible(true)
        self.atkEnhancedDeltaText_:setVisible(false)
        self.skillOneUpgradedDeltaText_:setVisible(true)
        self.skillOneEnhancedDeltaText_:setVisible(false)
    end)
end

--[[--
    onExit事件

    @param none

    @return none
]]
function CardAttrComp:onExit()
    EventManager:unRegListener(EventDef.ID.CARD_UPGRADE, self)
    EventManager:unRegListener(EventDef.ID.CARD_ENFORCE_SHOW, self)
    EventManager:unRegListener(EventDef.ID.CARD_ENFORCE_HIDE, self)
end

--[[--
    界面初始化

    @param none

    @return none
]]
function CardAttrComp:update()

end

return CardAttrComp