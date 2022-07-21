--[[--
    塔详细中层
    PropertyLayer.lua
]]
local PropertyLayer =class("PropertyLayer", require("app.ui.outgame.layer.BaseLayer"))
--[[--
    构造函数

    @param none

    @return none
]]
function PropertyLayer:ctor()
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function PropertyLayer:initView()
    local rarity =self.pack:getTower():getTowerRarity() -- 当前塔的稀有度
    local tempfilename
    local value1TTF=nil
    local width, height = display.width, 1120

    --底图
    local sprite1 = display.newSprite("artcontent/lobby_ongame/atlas_interface/tower_detailpopup/basemap_popup.png")

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(sprite1:getContentSize().width,sprite1:getContentSize().height)
    self.container_:setAnchorPoint(0.5, 0)
    self.container_:setPosition(width/2-25,0)
    self.container_:addTo(self)
    --属性
    --类型
    local typeCheckBox = ccui.CheckBox:
    create("artcontent/lobby_ongame/atlas_interface/tower_detailpopup/basemap_properties_default.png", nil,
    "artcontent/lobby_ongame/atlas_interface/tower_detailpopup/basemap_properties_enhanced.png", nil, nil)
    typeCheckBox:setAnchorPoint(0, 1)
    typeCheckBox:setPosition(25,sprite1:getContentSize().height-300)
    self.container_:addChild(typeCheckBox)
    tempfilename="artcontent/lobby_ongame/atlas_interface/tower_detailpopup/text_details/text_15.png"
    local textType = display.newSprite(tempfilename)
    textType:setAnchorPoint(0, 0.5)
    textType:setPosition(typeCheckBox:getContentSize().width/2-60,typeCheckBox:getContentSize().height/2+20)
    typeCheckBox:addChild(textType)
    tempfilename="artcontent/lobby_ongame/atlas_interface/tower_detailpopup/icon_properties/type.png"
    local typeSprite = display.newSprite(tempfilename)
    typeSprite:setAnchorPoint(1, 0.5)
    typeSprite:setPosition(typeCheckBox:getContentSize().width/2-80,typeCheckBox:getContentSize().height/2)
    typeCheckBox:addChild(typeSprite)
    local typeTTF=display.newTTFLabel({
        text = "攻击向塔",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, typeCheckBox:getContentSize().width/2,typeCheckBox:getContentSize().height/2-20)
    :addTo(typeCheckBox)
    if self.pack:getTower():getTowerType()==1 then
        typeTTF:setString("攻击向塔")
    elseif self.pack:getTower():getTowerType()==2 then
        typeTTF:setString("干扰向塔")
    elseif self.pack:getTower():getTowerType()==3 then
        typeTTF:setString("辅助向塔")
    elseif self.pack:getTower():getTowerType()==4 then
        typeTTF:setString("控制向塔")
    end
--攻击力
    local atkCheckBox = ccui.CheckBox:
    create("artcontent/lobby_ongame/atlas_interface/tower_detailpopup/basemap_properties_default.png", nil,
    "artcontent/lobby_ongame/atlas_interface/tower_detailpopup/basemap_properties_enhanced.png", nil, nil)
    atkCheckBox:setAnchorPoint(0, 1)
    atkCheckBox:setPosition(25+sprite1:getContentSize().width/2,sprite1:getContentSize().height-300)
    self.container_:addChild(atkCheckBox)

    tempfilename="artcontent/lobby_ongame/atlas_interface/tower_detailpopup/text_details/text_6.png"
    local textAck = display.newSprite(tempfilename)
    textAck:setAnchorPoint(0, 0.5)
    textAck:setPosition(typeCheckBox:getContentSize().width/2-60,typeCheckBox:getContentSize().height/2+20)
    atkCheckBox:addChild(textAck)

    tempfilename="artcontent/lobby_ongame/atlas_interface/tower_detailpopup/icon_properties/atk.png"
    local atkSprite = display.newSprite(tempfilename)
    atkSprite:setAnchorPoint(1, 0.5)
    atkSprite:setPosition(typeCheckBox:getContentSize().width/2-70,typeCheckBox:getContentSize().height/2)
    atkCheckBox:addChild(atkSprite)

    local atkTTF=display.newTTFLabel({
        text = "攻击向塔",
        size = 30,
        color =  display.COLOR_WHITE
    })
    :align(display.LEFT_CENTER, typeCheckBox:getContentSize().width/2-60,typeCheckBox:getContentSize().height/2-20)
    :addTo(atkCheckBox)
    atkTTF:setString(self.pack:getTower():getTowerAtk())

    local atkChange=display.newTTFLabel({
        text = "+",
        size = 25,
        color =cc.c3b(255, 215, 0)
    })
    :align(display.RIGHT_CENTER, typeCheckBox:getContentSize().width-20,typeCheckBox:getContentSize().height/2-20)
    :addTo(atkCheckBox)
    atkChange:setVisible(false)
--攻速
    local atkSpeedCheckBox = ccui.CheckBox:
    create("artcontent/lobby_ongame/atlas_interface/tower_detailpopup/basemap_properties_default.png", nil,
    "artcontent/lobby_ongame/atlas_interface/tower_detailpopup/basemap_properties_enhanced.png", nil, nil)
    atkSpeedCheckBox:setAnchorPoint(0, 1)
    atkSpeedCheckBox:setPosition(25,sprite1:getContentSize().height-415)
    self.container_:addChild(atkSpeedCheckBox)
    tempfilename="artcontent/lobby_ongame/atlas_interface/tower_detailpopup/text_details/text_8.png"
    local textAtkSpeed = display.newSprite(tempfilename)
    textAtkSpeed:setAnchorPoint(0, 0.5)
    textAtkSpeed:setPosition(typeCheckBox:getContentSize().width/2-60,typeCheckBox:getContentSize().height/2+20)
    atkSpeedCheckBox:addChild(textAtkSpeed)
    tempfilename="artcontent/lobby_ongame/atlas_interface/tower_detailpopup/icon_properties/atkspeed.png"
    local atkSpeedSprite = display.newSprite(tempfilename)
    atkSpeedSprite:setAnchorPoint(1, 0.5)
    atkSpeedSprite:setPosition(typeCheckBox:getContentSize().width/2-70,typeCheckBox:getContentSize().height/2)
    atkSpeedCheckBox:addChild(atkSpeedSprite)
    local fireCdTTF=display.newTTFLabel({
        text = "1S",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.LEFT_CENTER, typeCheckBox:getContentSize().width/2-60,typeCheckBox:getContentSize().height/2-20)
    :addTo(atkSpeedCheckBox)
    fireCdTTF:setString(self.pack:getTower():getTowerFireCd().."S")
    local fireCdChange=display.newTTFLabel({
        text = "+",
        size = 25,
        color = cc.c3b(255, 215, 0)
    })
    :align(display.RIGHT_CENTER, typeCheckBox:getContentSize().width-20,typeCheckBox:getContentSize().height/2-20)
    :addTo(atkSpeedCheckBox)
    fireCdChange:setVisible(false)
--目标
    local targetCheckBox =ccui.CheckBox:
    create("artcontent/lobby_ongame/atlas_interface/tower_detailpopup/basemap_properties_default.png", nil,
    "artcontent/lobby_ongame/atlas_interface/tower_detailpopup/basemap_properties_enhanced.png", nil, nil)
    targetCheckBox:setAnchorPoint(0, 1)
    targetCheckBox:setPosition(25+sprite1:getContentSize().width/2,sprite1:getContentSize().height-415)
    self.container_:addChild(targetCheckBox)
    tempfilename="artcontent/lobby_ongame/atlas_interface/tower_detailpopup/text_details/text_16.png"
    local textTarget = display.newSprite(tempfilename)
    textTarget:setAnchorPoint(0, 0.5)
    textTarget:setPosition(typeCheckBox:getContentSize().width/2-60,typeCheckBox:getContentSize().height/2+20)
    targetCheckBox:addChild(textTarget)
    tempfilename="artcontent/lobby_ongame/atlas_interface/tower_detailpopup/icon_properties/target.png"
    local targetSprite = display.newSprite(tempfilename)
    targetSprite:setAnchorPoint(1, 0.5)
    targetSprite:setPosition(typeCheckBox:getContentSize().width/2-70,typeCheckBox:getContentSize().height/2)
    targetCheckBox:addChild(targetSprite)
    local targetTTF=display.newTTFLabel({
        text = "攻击向塔",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.LEFT_CENTER, typeCheckBox:getContentSize().width/2-60,typeCheckBox:getContentSize().height/2-20)
    :addTo(targetCheckBox)
    targetTTF:setString(self.pack:getTower():getAtkTarget())
--技能1
    local skill1num = self.pack:getTower():getTowerSkill1Num()
    local skill2num = self.pack:getTower():getTowerSkill2Num()
    local skill1CheckBox = ccui.CheckBox:
    create("artcontent/lobby_ongame/atlas_interface/tower_detailpopup/basemap_properties_default.png", nil,
    "artcontent/lobby_ongame/atlas_interface/tower_detailpopup/basemap_properties_enhanced.png", nil, nil)
    skill1CheckBox:setAnchorPoint(0, 1)
    skill1CheckBox:setPosition(25,sprite1:getContentSize().height-530)
    self.container_:addChild(skill1CheckBox)
    if skill1num then
        tempfilename="artcontent/lobby_ongame/atlas_interface/tower_detailpopup/text_details/text_%d.png"
        local textSkill1 = display.newSprite(string.format(tempfilename,skill1num))
        textSkill1:setAnchorPoint(0, 0.5)
        textSkill1:setPosition(typeCheckBox:getContentSize().width/2-60,typeCheckBox:getContentSize().height/2+20)
        skill1CheckBox:addChild(textSkill1)
        tempfilename="artcontent/lobby_ongame/atlas_interface/tower_detailpopup/icon_properties/slowdown.png"
        local slowdownSprite = display.newSprite(tempfilename)
        slowdownSprite:setAnchorPoint(1, 0.5)
        slowdownSprite:setPosition(typeCheckBox:getContentSize().width/2-70,typeCheckBox:getContentSize().height/2)
        skill1CheckBox:addChild(slowdownSprite)
        value1TTF=display.newTTFLabel({
            text = "攻击向塔",
            size = 30,
            color = display.COLOR_WHITE
        })
        :align(display.LEFT_CENTER, typeCheckBox:getContentSize().width/2-60,typeCheckBox:getContentSize().height/2-20)
        :addTo(skill1CheckBox)
        if skill1num==3 or skill1num==10 then
            value1TTF:setString(self.pack:getTower():getSkill1Value().."s")
        elseif skill1num==9 or skill1num==7 or skill1num==14 or skill1num==13 or skill1num==17 then
            value1TTF:setString(100*self.pack:getTower():getSkill1Value().."%")
        else
            value1TTF:setString(self.pack:getTower():getSkill1Value())
        end
    else
        display.newTTFLabel({
            text = "-",
            size = 30,
            color = display.COLOR_WHITE
        })
        :align(display.LEFT_CENTER, typeCheckBox:getContentSize().width/2-60,typeCheckBox:getContentSize().height/2-20)
        :addTo(skill1CheckBox)
    end
    local value1Change=display.newTTFLabel({
        text = "+",
        size = 25,
        color = cc.c3b(255, 215, 0)
    })
    :align(display.RIGHT_CENTER, typeCheckBox:getContentSize().width-20,typeCheckBox:getContentSize().height/2-20)
    :addTo(skill1CheckBox)
    value1Change:setVisible(false)

--技能2
    local skill2CheckBox = ccui.CheckBox:
    create("artcontent/lobby_ongame/atlas_interface/tower_detailpopup/basemap_properties_default.png", nil,
    "artcontent/lobby_ongame/atlas_interface/tower_detailpopup/basemap_properties_enhanced.png", nil, nil)
    skill2CheckBox:setAnchorPoint(0, 1)
    skill2CheckBox:setPosition(25+sprite1:getContentSize().width/2,sprite1:getContentSize().height-530)
    self.container_:addChild(skill2CheckBox)
    if skill2num then
        tempfilename="artcontent/lobby_ongame/atlas_interface/tower_detailpopup/text_details/text_%d.png"
        local textSkill2 = display.newSprite(string.format(tempfilename, skill2num))
        textSkill2:setAnchorPoint(0, 0.5)
        textSkill2:setPosition(typeCheckBox:getContentSize().width/2-60,typeCheckBox:getContentSize().height/2+20)
        skill2CheckBox:addChild(textSkill2)
        tempfilename="artcontent/lobby_ongame/atlas_interface/tower_detailpopup/icon_properties/skill_trigger.png"
        local skillTrigger = display.newSprite(tempfilename)
        skillTrigger:setAnchorPoint(1, 0.5)
        skillTrigger:setPosition(typeCheckBox:getContentSize().width/2-70,typeCheckBox:getContentSize().height/2)
        skill2CheckBox:addChild(skillTrigger)
        local value2TTF=display.newTTFLabel({
            text = "攻击向塔",
            size = 30,
            color = display.COLOR_WHITE
        })
        :align(display.LEFT_CENTER, typeCheckBox:getContentSize().width/2-60,typeCheckBox:getContentSize().height/2-20)
        :addTo(skill2CheckBox)
        value2TTF:setString(self.pack:getTower():getSkill2Value().."s")
    else
        display.newTTFLabel({
            text = "-",
            size = 30,
            color = display.COLOR_WHITE
        })
        :align(display.LEFT_CENTER, typeCheckBox:getContentSize().width/2-60,typeCheckBox:getContentSize().height/2-20)
        :addTo(skill2CheckBox)
    end

    --取消触摸
    typeCheckBox:setTouchEnabled(false)
    atkCheckBox:setTouchEnabled(false)
    atkSpeedCheckBox:setTouchEnabled(false)
    targetCheckBox:setTouchEnabled(false)
    skill1CheckBox:setTouchEnabled(false)
    skill2CheckBox:setTouchEnabled(false)

    --升级改变
    if cc.UserDefault:getInstance():getBoolForKey("攻击")==true then
        atkTTF:setString(self.pack:getTower():getTowerAtk())
        atkCheckBox:setSelected(true)
        atkChange:setVisible(true)
        atkChange:setString("+"..tostring(self.pack:getTower():getAtkUpgrade()))
    else
        atkCheckBox:setSelected(false)
    end
    if cc.UserDefault:getInstance():getBoolForKey("攻速")==true then
        fireCdTTF:setString(self.pack:getTower():getTowerFireCd().."S")
        atkSpeedCheckBox:setSelected(true)
        fireCdChange:setVisible(true)
        fireCdChange:setString("-"..tostring(self.pack:getTower():getFireCdUpgrade().."S"))
    else
        fireCdChange:setVisible(false)
        atkSpeedCheckBox:setSelected(false)
    end
    if cc.UserDefault:getInstance():getBoolForKey("技能")==true then
        if skill1num==3 or skill1num==10 then
            value1TTF:setString(self.pack:getTower():getSkill1Value().."s")
        elseif skill1num==9 or skill1num==7 or skill1num==14 or skill1num==13 or skill1num==17 then
            value1TTF:setString(100*self.pack:getTower():getSkill1Value().."%")
        else
            value1TTF:setString(self.pack:getTower():getSkill1Value())
        end
        skill1CheckBox:setSelected(true)
        value1Change:setVisible(true)
        if skill1num==3 or skill1num==10 then
            value1Change:setString("+"..tostring(self.pack:getTower():getValueUpgrade()).."s")
        elseif skill1num==9 or skill1num==7 or skill1num==14 or skill1num==13 or skill1num==17 then
            value1Change:setString("+"..
            100*tostring(self.pack:getTower():getValueUpgrade()).."%")
        else
            value1Change:setString("+"..tostring(self.pack:getTower():getValueUpgrade()))
        end
    else
        value1Change:setVisible(false)
        skill1CheckBox:setSelected(false)
    end
end

-- --[[--
--     传入塔数据

--     @param pack 类型：table，PackItem塔

--     @return none
-- ]]
-- function PropertyLayer:setChange(a,b,c)
--     self.a=a
--     self.b=b
--     self.c=c
-- end

--[[--
    传入塔数据

    @param pack 类型：table，PackItem塔

    @return none
]]
function PropertyLayer:setTower(pack)
    self.pack=pack
end

return PropertyLayer

