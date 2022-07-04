--[[--
    信息层
    TopInfoLayer.lua
]]
local IntensifiesLayer =class("IntensifiesLayer", function()
    return display.newScene("IntensifiesLayer")
end)
local OutGameData = require("app.data.outgame.OutGameData")
local ConstDef = require("app.def.outgame.ConstDef")
local EventDef = require("app.def.outgame.EventDef")
local EventManager = require("app.manager.EventManager")
--[[--
    构造函数

    @param none

    @return none
]]
function IntensifiesLayer:ctor()
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function IntensifiesLayer:initView()
    local tempfilename
    local width, height = display.width, 1120
    --遮罩
    local sprite0 = ccui.Button:create("artcontent/lobby(ongame)/currency/mask_popup.png")
    self:addChild(sprite0)
    sprite0:setAnchorPoint(0.5, 0.5)
    sprite0:setOpacity(127)
    sprite0:setPosition(display.cx,display.cy)

    sprite0:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                self:removeFromParent(true)
            end
        end
    )

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, display.cy)

    --底图
    local sprite1 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_popup.png")
    sprite1:setAnchorPoint(0.5, 0)
    sprite1:setPosition(width/2,30)
    self.container_:addChild(sprite1)
    display.newTTFLabel({
        text = "XXX%",
        size = 22,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite1:getContentSize().width/2-10,33)
    :addTo(sprite1)
    display.newTTFLabel({
        text = "+X%",
        size = 22,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite1:getContentSize().width/2+150,33)
    :addTo(sprite1)

    --x按钮
    local sprite2= ccui.Button:create("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/button_off.png")
    sprite1:addChild(sprite2)
    sprite2:setAnchorPoint(1, 1)
    sprite2:setPosition(sprite1:getContentSize().width-10, sprite1:getContentSize().height-10)
    sprite2:addTouchEventListener(
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
    --属性类型
    local sprite6 = ccui.CheckBox:
    create("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_properties_default.png", nil,
    "artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_properties_enhanced.png", nil, nil)
    sprite6:setAnchorPoint(0, 1)
    sprite6:setPosition(25,sprite1:getContentSize().height-300)
    sprite1:addChild(sprite6)
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
    sprite7:setPosition(25+sprite1:getContentSize().width/2,sprite1:getContentSize().height-300)
    sprite1:addChild(sprite7)
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
    self.atk:setString(self.pack:getTower():GetTowerAtk())
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
    sprite8:setPosition(25,sprite1:getContentSize().height-415)
    sprite1:addChild(sprite8)
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
    self.fireCd:setString(self.pack:getTower():GetTowerFireCd().."S")
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
    sprite9:setPosition(25+sprite1:getContentSize().width/2,sprite1:getContentSize().height-415)
    sprite1:addChild(sprite9)
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
    self.target:setString(self.pack:getTower():GetAtkTarget())
--技能1
    local skill1num = self.pack:getTower():GetTowerSkill1Num()
    local skill2num = self.pack:getTower():GetTowerSkill2Num()
    local sprite10 = ccui.CheckBox:
    create("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_properties_default.png", nil,
    "artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_properties_enhanced.png", nil, nil)
    sprite10:setAnchorPoint(0, 1)
    sprite10:setPosition(25,sprite1:getContentSize().height-530)
    sprite1:addChild(sprite10)
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
        self.value1:setString(self.pack:getTower():GetSkill1Value())
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
    sprite11:setPosition(25+sprite1:getContentSize().width/2,sprite1:getContentSize().height-530)
    sprite1:addChild(sprite11)
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
        self.value2:setString(self.pack:getTower():GetSkill2Value())
    else
        display.newTTFLabel({
            text = "-",
            size = 30,
            color = display.COLOR_WHITE
        })
        :align(display.LEFT_CENTER, sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2-20)
        :addTo(sprite11)
    end

    self.typefilename={"towertype_tapping","towertype_disturbance","towertype_sup","towertype_control"}
    self.basemapfilename={"basemap_tower_normal","basemap_tower_rare","basemap_tower_epic","basemap_towerlegend"}
    --塔图片
    local sprite26 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/"
    ..self.basemapfilename[self.pack:getTower():getTowerRarity()]..".png")
    sprite26:setAnchorPoint(0, 1)
    sprite26:setPosition(50,sprite1:getContentSize().height-25)
    sprite1:addChild(sprite26)
    tempfilename=string.format("artcontent/lobby(ongame)/currency/icon_tower/%02d.png",self.pack:getTower():getTowerId())
    local spriteD6 = display.newSprite(tempfilename)
    sprite26:addChild(spriteD6)
    spriteD6:setAnchorPoint(0.5, 0.5)
    spriteD6:setPosition(sprite26:getContentSize().width/2,sprite26:getContentSize().height/2+30)
    self.spriteD7 = display.
    newSprite(string.format("artcontent/lobby(ongame)/atlas_interface/tower_list/grade/Lv.%d.png",
    self.pack:getTower():getLevel()))
    sprite26:addChild(self.spriteD7)
    self.spriteD7:setAnchorPoint(0.5, 0.5)
    self.spriteD7:setPosition(sprite26:getContentSize().width/2,sprite26:getContentSize().height/2-40)
    tempfilename ="artcontent/lobby(ongame)/atlas_interface/tower_list/progressbar_basemap_fragmentsnumber.png"
    local spriteD8 = display.newSprite(tempfilename)
    sprite26:addChild(spriteD8)
    spriteD8:setAnchorPoint(0.5, 0.5)
    spriteD8:setPosition(sprite26:getContentSize().width/2,sprite26:getContentSize().height/2-80)
    tempfilename ="artcontent/lobby(ongame)/atlas_interface/tower_list/progress_progress_fragmentsnumber.png"
    local spriteD9= display.newSprite(tempfilename)
    spriteD8:addChild(spriteD9)
    spriteD9:setAnchorPoint(0.5, 0.5)
    spriteD9:setPosition(spriteD8:getContentSize().width/2,spriteD8:getContentSize().height/2)
    local spriteD10 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/"
    ..self.typefilename[self.pack:getTower():getTowerType()]..".png")
    sprite26:addChild(spriteD10)
    spriteD10:setAnchorPoint(1, 1)
    spriteD10:setPosition(sprite26:getContentSize().width-10,sprite26:getContentSize().height)

    --介绍底图
    tempfilename ="artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_skillintroduction.png"
    local sprite25= display.newSprite(tempfilename)
    sprite25:setAnchorPoint(0, 1)
    sprite25:setPosition(sprite1:getContentSize().width/2-120,sprite1:getContentSize().height-120)
    sprite1:addChild(sprite25)
    --塔类型
    tempfilename ="artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/text_details/title_3.png"
    local sprite27 = display.newSprite(tempfilename)
    sprite27:setAnchorPoint(0, 1)
    sprite27:setPosition(sprite1:getContentSize().width/2-120,sprite1:getContentSize().height-25)
    sprite1:addChild(sprite27)
    self.type2=display.newTTFLabel({
        text = "攻击向塔",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite1:getContentSize().width/2-60,sprite1:getContentSize().height-75)
    :addTo(sprite1)
    if self.pack:getTower():getTowerType()==1 then
        self.type2:setString("攻击向塔")
    elseif self.pack:getTower():getTowerType()==2 then
        self.type2:setString("干扰向塔")
    elseif self.pack:getTower():getTowerType()==3 then
        self.type2:setString("辅助向塔")
    elseif self.pack:getTower():getTowerType()==4 then
        self.type2:setString("控制向塔")
    end
    --稀有度
    tempfilename = "artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/text_details/title_4.png"
    local sprite28 = display.newSprite(tempfilename)
    sprite28:setAnchorPoint(0, 1)
    sprite28:setPosition(sprite1:getContentSize().width-200,sprite1:getContentSize().height-25)
    sprite1:addChild(sprite28)
    self.Rarity=display.newTTFLabel({
        text = "普通",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite1:getContentSize().width-170,sprite1:getContentSize().height-75)
    :addTo(sprite1)
    if self.pack:getTower():getTowerRarity()==1 then
        self.Rarity:setString("普通")
    elseif self.pack:getTower():getTowerRarity()==2 then
        self.Rarity:setString("稀有")
    elseif self.pack:getTower():getTowerRarity()==3 then
        self.Rarity:setString("史诗")
    elseif self.pack:getTower():getTowerRarity()==4 then
        self.Rarity:setString("传说")
    end


    --技能介绍
    local tempfileneme = "artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/text_details/title_2.png"
    local sprite29 = display.newSprite(tempfileneme)
    sprite29:setAnchorPoint(1, 1)
    sprite29:setPosition(85,sprite25:getContentSize().height-10)
    sprite25:addChild(sprite29)
    self.introduction=display.newTTFLabel({
        text = "普通",
        size = 20,
        color = display.COLOR_WHITE
    })
    :align(display.LEFT_CENTER, 10,sprite25:getContentSize().height-50)
    :addTo(sprite25)

            --升级按钮
    local sprite3= ccui.Button:create("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/button_upgrade.png")
    sprite1:addChild(sprite3)
    sprite3:setAnchorPoint(0.5, 0)
    sprite3:setPosition(sprite1:getContentSize().width/2, 60)
    sprite3:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_close.OGG",false)
                end
                if self.pack:getTower():GetAtkUpgrade() then
                    self.pack:getTower():AtkUpgrade()
                    self.atk:setString(self.pack:getTower():GetTowerAtk())
                    sprite7:setSelected(true)
                    self.atkchange:setVisible(true)
                    self.atkchange:setString("+"..tostring(self.pack:getTower():GetAtkUpgrade()))
                else
                    sprite7:setSelected(false)
                end
                if self.pack:getTower():GetFireCdUpgrade() then
                    self.pack:getTower():FireCdUpgrade()
                    self.fireCd:setString(self.pack:getTower():GetTowerFireCd().."S")
                    sprite8:setSelected(true)
                    self.fireCdchange:setVisible(true)
                    self.fireCdchange:setString("-"..tostring(self.pack:getTower():GetFireCdUpgrade().."S"))
                else
                    self.fireCdchange:setVisible(false)
                    sprite8:setSelected(false)
                end

                self.pack:getTower():levelUp()
                local tempfileneme = "artcontent/lobby(ongame)/atlas_interface/tower_list/grade/Lv.%d.png"
                self.spriteD7:setTexture(string.format(tempfileneme,self.pack:getTower():getLevel()))
                if skill1num then
                    if self.pack:getTower():GetValueUpgrade() then
                        self.pack:getTower():ValueUpgrade()
                        self.value1:setString(self.pack:getTower():GetSkill1Value())
                        sprite10:setSelected(true)
                        self.value1change:setVisible(true)
                        self.value1change:setString("+"..tostring(self.pack:getTower():GetValueUpgrade()))
                    else
                        self.value1change:setVisible(false)
                        sprite10:setSelected(false)
                    end
                end

                --EventManager:doEvent(EventDef.ID.INTENSIFIES, self.pack,self.pack:getTower():getLevel())
            end
        end
    )
    local sprite24 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/icon_glod.png")
    sprite24:setAnchorPoint(0.5, 0.5)
    sprite24:setPosition(sprite3:getContentSize().width/2-30,sprite3:getContentSize().height/2-20)
    sprite3:addChild(sprite24)
    local gold=display.newTTFLabel({
        text = "584",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite3:getContentSize().width/2+10,sprite3:getContentSize().height/2-20)
    :addTo(sprite3)
    --强化按钮
    local sprite4= ccui.Button:create("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/button_enhanced.png")
    sprite1:addChild(sprite4)
    sprite4:setAnchorPoint(0.5, 0)
    sprite4:setPosition(sprite1:getContentSize().width/2-200, 60)
    sprite4:addTouchEventListener(
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
    --使用按钮
    local sprite5= ccui.Button:create("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/button_use.png")
    sprite1:addChild(sprite5)
    sprite5:setAnchorPoint(0.5, 0)
    sprite5:setPosition(sprite1:getContentSize().width/2+200, 60)
    sprite5:addTouchEventListener(
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
end

--[[--
    传入塔数据

    @param pack 类型：table，PackItem塔

    @return none
]]
function IntensifiesLayer:setTower(pack)
    self.pack=pack
end

--[[--
    节点进入

    @param none

    @return none
]]
function IntensifiesLayer:onEnter()
    -- EventManager:regListener(EventDef.ID.LEVEL_CHANGE, self, function()
    --     self.pack
    --     self.spriteD7:setTexture(string.format("artcontent/lobby(ongame)/atlas_interface/tower_list/grade/Lv.%d.png",
    --     self.pack:getLevel()))
    -- end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function IntensifiesLayer:onExit()
    --EventManager:unRegListener(EventDef.ID.LEVEL_CHANGE, self)
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function IntensifiesLayer:update(dt)
end

return IntensifiesLayer

