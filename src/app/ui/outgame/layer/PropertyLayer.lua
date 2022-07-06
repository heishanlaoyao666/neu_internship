--[[--
    塔详细层
    PropertyLayer.lua
]]
local PropertyLayer =class("PropertyLayer", require("app.ui.outgame.layer.BaseLayer"))
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
local OutGameData = require("app.data.outgame.OutGameData")
local ConstDef = require("app.def.outgame.ConstDef")
--[[--
    构造函数

    @param none

    @return none
]]
function PropertyLayer:ctor()
    self.UsingLayer_=nil -- 类型：UsingLayer，使用塔层
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
    local width, height = display.width, 1120

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0)
    self.container_:setPosition(display.cx+10, 190-display.cy)

    -- --底图
    -- local sprite1 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_popup.png")
    -- sprite1:setAnchorPoint(0.5, 0)
    -- sprite1:setPosition(width/2,30)
    -- self.container_:addChild(sprite1)
    -- sprite1:setVisible(false)

    --属性类型
    local sprite6 = ccui.CheckBox:
    create("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_properties_default.png", nil,
    "artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_properties_enhanced.png", nil, nil)
    sprite6:setAnchorPoint(0, 1)
    sprite6:setPosition(50,self.container_:getContentSize().height-300)
    self.container_:addChild(sprite6)
    tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/text_details/text_15.png"
    local sprite12 = display.newSprite(tempfilename)
    sprite12:setAnchorPoint(0, 0.5)
    sprite12:setPosition(sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2+20)
    sprite6:addChild(sprite12)
    tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/icon_properties/type.png"
    local sprite13 = display.newSprite(tempfilename)
    sprite13:setAnchorPoint(1, 0.5)
    sprite13:setPosition(sprite6:getContentSize().width/2-80,sprite6:getContentSize().height/2)
    sprite6:addChild(sprite13)
    self.type=display.newTTFLabel({
        text = "攻击向塔",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite6:getContentSize().width/2,sprite6:getContentSize().height/2-20)
    :addTo(sprite6)
    if self.pack:getTower():getTowerType()==1 then
        self.type:setString("攻击向塔")
    elseif self.pack:getTower():getTowerType()==2 then
        self.type:setString("干扰向塔")
    elseif self.pack:getTower():getTowerType()==3 then
        self.type:setString("辅助向塔")
    elseif self.pack:getTower():getTowerType()==4 then
        self.type:setString("控制向塔")
    end
--攻击力
    local sprite7 = ccui.CheckBox:
    create("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_properties_default.png", nil,
    "artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_properties_enhanced.png", nil, nil)
    sprite7:setAnchorPoint(0, 1)
    sprite7:setPosition(self.container_:getContentSize().width/2,self.container_:getContentSize().height-300)
    self.container_:addChild(sprite7)
    tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/text_details/text_6.png"
    local sprite14 = display.newSprite(tempfilename)
    sprite14:setAnchorPoint(0, 0.5)
    sprite14:setPosition(sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2+20)
    sprite7:addChild(sprite14)
    tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/icon_properties/atk.png"
    local sprite15 = display.newSprite(tempfilename)
    sprite15:setAnchorPoint(1, 0.5)
    sprite15:setPosition(sprite6:getContentSize().width/2-70,sprite6:getContentSize().height/2)
    sprite7:addChild(sprite15)
    self.atk=display.newTTFLabel({
        text = "攻击向塔",
        size = 30,
        color =  display.COLOR_WHITE
    })
    :align(display.LEFT_CENTER, sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2-20)
    :addTo(sprite7)
    self.atk:setString(self.pack:getTower():getTowerAtk())
    self.atkchange=display.newTTFLabel({
        text = "+",
        size = 25,
        color =cc.c3b(255, 215, 0)
    })
    :align(display.RIGHT_CENTER, sprite6:getContentSize().width-20,sprite6:getContentSize().height/2-20)
    :addTo(sprite7)
    self.atkchange:setVisible(false)
--攻速
    local sprite8 = ccui.CheckBox:
    create("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_properties_default.png", nil,
    "artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_properties_enhanced.png", nil, nil)
    sprite8:setAnchorPoint(0, 1)
    sprite8:setPosition(50,self.container_:getContentSize().height-415)
    self.container_:addChild(sprite8)
    tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/text_details/text_8.png"
    local sprite16 = display.newSprite(tempfilename)
    sprite16:setAnchorPoint(0, 0.5)
    sprite16:setPosition(sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2+20)
    sprite8:addChild(sprite16)
    tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/icon_properties/atkspeed.png"
    local sprite17 = display.newSprite(tempfilename)
    sprite17:setAnchorPoint(1, 0.5)
    sprite17:setPosition(sprite6:getContentSize().width/2-70,sprite6:getContentSize().height/2)
    sprite8:addChild(sprite17)
    self.fireCd=display.newTTFLabel({
        text = "1S",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.LEFT_CENTER, sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2-20)
    :addTo(sprite8)
    self.fireCd:setString(self.pack:getTower():getTowerFireCd().."S")
    self.fireCdchange=display.newTTFLabel({
        text = "+",
        size = 25,
        color = cc.c3b(255, 215, 0)
    })
    :align(display.RIGHT_CENTER, sprite6:getContentSize().width-20,sprite6:getContentSize().height/2-20)
    :addTo(sprite8)
    self.fireCdchange:setVisible(false)
--目标
    local sprite9 =ccui.CheckBox:
    create("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_properties_default.png", nil,
    "artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_properties_enhanced.png", nil, nil)
    sprite9:setAnchorPoint(0, 1)
    sprite9:setPosition(self.container_:getContentSize().width/2,self.container_:getContentSize().height-415)
    self.container_:addChild(sprite9)
    tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/text_details/text_16.png"
    local sprite18 = display.newSprite(tempfilename)
    sprite18:setAnchorPoint(0, 0.5)
    sprite18:setPosition(sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2+20)
    sprite9:addChild(sprite18)
    tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/icon_properties/target.png"
    local sprite19 = display.newSprite(tempfilename)
    sprite19:setAnchorPoint(1, 0.5)
    sprite19:setPosition(sprite6:getContentSize().width/2-70,sprite6:getContentSize().height/2)
    sprite9:addChild(sprite19)
    self.target=display.newTTFLabel({
        text = "攻击向塔",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.LEFT_CENTER, sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2-20)
    :addTo(sprite9)
    self.target:setString(self.pack:getTower():getAtkTarget())
--技能1
    local skill1num = self.pack:getTower():getTowerSkill1Num()
    local skill2num = self.pack:getTower():getTowerSkill2Num()
    local sprite10 = ccui.CheckBox:
    create("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_properties_default.png", nil,
    "artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_properties_enhanced.png", nil, nil)
    sprite10:setAnchorPoint(0, 1)
    sprite10:setPosition(50,self.container_:getContentSize().height-530)
    self.container_:addChild(sprite10)
    if skill1num then
        tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/text_details/text_%d.png"
        local sprite20 = display.newSprite(string.format(tempfilename,skill1num))
        sprite20:setAnchorPoint(0, 0.5)
        sprite20:setPosition(sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2+20)
        sprite10:addChild(sprite20)
        tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/icon_properties/slowdown.png"
        local sprite21 = display.newSprite(tempfilename)
        sprite21:setAnchorPoint(1, 0.5)
        sprite21:setPosition(sprite6:getContentSize().width/2-70,sprite6:getContentSize().height/2)
        sprite10:addChild(sprite21)
        self.value1=display.newTTFLabel({
            text = "攻击向塔",
            size = 30,
            color = display.COLOR_WHITE
        })
        :align(display.LEFT_CENTER, sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2-20)
        :addTo(sprite10)
        print(self.pack:getTower():getSkill1Value())
        self.value1:setString(self.pack:getTower():getSkill1Value())
    else
        display.newTTFLabel({
            text = "-",
            size = 30,
            color = display.COLOR_WHITE
        })
        :align(display.LEFT_CENTER, sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2-20)
        :addTo(sprite10)
    end
    self.value1change=display.newTTFLabel({
        text = "+",
        size = 25,
        color = cc.c3b(255, 215, 0)
    })
    :align(display.RIGHT_CENTER, sprite6:getContentSize().width-20,sprite6:getContentSize().height/2-20)
    :addTo(sprite10)
    self.value1change:setVisible(false)

--技能2
    local sprite11 = ccui.CheckBox:
    create("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_properties_default.png", nil,
    "artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_properties_enhanced.png", nil, nil)
    sprite11:setAnchorPoint(0, 1)
    sprite11:setPosition(self.container_:getContentSize().width/2,self.container_:getContentSize().height-530)
    self.container_:addChild(sprite11)
    if skill2num then
        tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/text_details/text_%d.png"
        local sprite22 = display.newSprite(string.format(tempfilename, skill2num))
        sprite22:setAnchorPoint(0, 0.5)
        sprite22:setPosition(sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2+20)
        sprite11:addChild(sprite22)
        tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/icon_properties/skill_trigger.png"
        local sprite23 = display.newSprite(tempfilename)
        sprite23:setAnchorPoint(1, 0.5)
        sprite23:setPosition(sprite6:getContentSize().width/2-70,sprite6:getContentSize().height/2)
        sprite11:addChild(sprite23)
        self.value2=display.newTTFLabel({
            text = "攻击向塔",
            size = 30,
            color = display.COLOR_WHITE
        })
        :align(display.LEFT_CENTER, sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2-20)
        :addTo(sprite11)
        self.value2:setString(self.pack:getTower():getSkill2Value())
    else
        display.newTTFLabel({
            text = "-",
            size = 30,
            color = display.COLOR_WHITE
        })
        :align(display.LEFT_CENTER, sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2-20)
        :addTo(sprite11)
    end

end

--[[--
    传入塔数据

    @param pack 类型：table，PackItem塔

    @return none
]]
function PropertyLayer:setTower(pack)
    self.pack=pack
end

return PropertyLayer

