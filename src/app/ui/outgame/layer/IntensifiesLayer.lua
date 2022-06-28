--[[--
    信息层
    TopInfoLayer.lua
]]
local IntensifiesLayer =class("IntensifiesLayer", function()
    return display.newScene("IntensifiesLayer")
end)

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
    local width, height = display.width, 1120
    --遮罩
    local sprite0 = ccui.Button:
    create("res\\artcontent\\lobby(ongame)\\currency\\mask_popup.png")
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
    local sprite1 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\basemap_popup.png")
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
    local sprite2= ccui.Button:
    create("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\button_off.png")
    sprite1:addChild(sprite2)
    sprite2:setAnchorPoint(1, 1)
    sprite2:setPosition(sprite1:getContentSize().width-20, sprite1:getContentSize().height-20)
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
    --升级按钮
    local sprite3= ccui.Button:
    create("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\button_upgrade.png")
    sprite1:addChild(sprite3)
    sprite3:setAnchorPoint(0.5, 0)
    sprite3:setPosition(sprite1:getContentSize().width/2, 60)
    sprite3:addTouchEventListener(
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
    local sprite24 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\icon_glod.png")
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
    local sprite4= ccui.Button:
    create("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\button_enhanced.png")
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
    local sprite5= ccui.Button:
    create("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\button_use.png")
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
    --属性类型
    local sprite6 = ccui.CheckBox:
    create("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\basemap_properties_default.png", nil,
    "res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\basemap_properties_enhanced.png", nil, nil)
    sprite6:setAnchorPoint(0, 1)
    sprite6:setPosition(25,sprite1:getContentSize().height-300)
    sprite1:addChild(sprite6)
    local sprite12 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\text_details\\text_15.png")
    sprite12:setAnchorPoint(0, 0.5)
    sprite12:setPosition(sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2+20)
    sprite6:addChild(sprite12)
    local sprite13 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\icon_properties\\type.png")
    sprite13:setAnchorPoint(1, 0.5)
    sprite13:setPosition(sprite6:getContentSize().width/2-70,sprite6:getContentSize().height/2)
    sprite6:addChild(sprite13)
    self.type=display.newTTFLabel({
        text = "攻击向塔",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite6:getContentSize().width/2,sprite6:getContentSize().height/2-20)
    :addTo(sprite6)
--攻击力
    local sprite7 = ccui.CheckBox:
    create("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\basemap_properties_default.png", nil,
    "res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\basemap_properties_enhanced.png", nil, nil)
    sprite7:setAnchorPoint(0, 1)
    sprite7:setPosition(25+sprite1:getContentSize().width/2,sprite1:getContentSize().height-300)
    sprite1:addChild(sprite7)
    local sprite14 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\text_details\\text_6.png")
    sprite14:setAnchorPoint(0, 0.5)
    sprite14:setPosition(sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2+20)
    sprite7:addChild(sprite14)
    local sprite15 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\icon_properties\\atk.png")
    sprite15:setAnchorPoint(1, 0.5)
    sprite15:setPosition(sprite6:getContentSize().width/2-70,sprite6:getContentSize().height/2)
    sprite7:addChild(sprite15)
    self.atk=display.newTTFLabel({
        text = "攻击向塔",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite6:getContentSize().width/2,sprite6:getContentSize().height/2-20)
    :addTo(sprite7)
    self.atk:setString(self.pack:getTower():GetTowerAtk())
--攻速
    local sprite8 = ccui.CheckBox:
    create("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\basemap_properties_default.png", nil,
    "res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\basemap_properties_enhanced.png", nil, nil)
    sprite8:setAnchorPoint(0, 1)
    sprite8:setPosition(25,sprite1:getContentSize().height-415)
    sprite1:addChild(sprite8)
    local sprite16 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\text_details\\text_8.png")
    sprite16:setAnchorPoint(0, 0.5)
    sprite16:setPosition(sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2+20)
    sprite8:addChild(sprite16)
    local sprite17 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\icon_properties\\atkspeed.png")
    sprite17:setAnchorPoint(1, 0.5)
    sprite17:setPosition(sprite6:getContentSize().width/2-70,sprite6:getContentSize().height/2)
    sprite8:addChild(sprite17)
    self.fireCd=display.newTTFLabel({
        text = "攻击向塔",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite6:getContentSize().width/2,sprite6:getContentSize().height/2-20)
    :addTo(sprite8)
    self.fireCd:setString(self.pack:getTower():GetTowerFireCd())
--目标
    local sprite9 =ccui.CheckBox:
    create("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\basemap_properties_default.png", nil,
    "res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\basemap_properties_enhanced.png", nil, nil)
    sprite9:setAnchorPoint(0, 1)
    sprite9:setPosition(25+sprite1:getContentSize().width/2,sprite1:getContentSize().height-415)
    sprite1:addChild(sprite9)
    local sprite18 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\text_details\\text_16.png")
    sprite18:setAnchorPoint(0, 0.5)
    sprite18:setPosition(sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2+20)
    sprite9:addChild(sprite18)
    local sprite19 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\icon_properties\\target.png")
    sprite19:setAnchorPoint(1, 0.5)
    sprite19:setPosition(sprite6:getContentSize().width/2-70,sprite6:getContentSize().height/2)
    sprite9:addChild(sprite19)
    self.target=display.newTTFLabel({
        text = "攻击向塔",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite6:getContentSize().width/2,sprite6:getContentSize().height/2-20)
    :addTo(sprite9)
    self.target:setString(self.pack:getTower():GetAtkTarget())
--技能减速效果
    local sprite10 = ccui.CheckBox:
    create("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\basemap_properties_default.png", nil,
    "res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\basemap_properties_enhanced.png", nil, nil)
    sprite10:setAnchorPoint(0, 1)
    sprite10:setPosition(25,sprite1:getContentSize().height-530)
    sprite1:addChild(sprite10)
    local sprite20 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\text_details\\text_13.png")
    sprite20:setAnchorPoint(0, 0.5)
    sprite20:setPosition(sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2+20)
    sprite10:addChild(sprite20)
    local sprite21 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\icon_properties\\slowdown.png")
    sprite21:setAnchorPoint(1, 0.5)
    sprite21:setPosition(sprite6:getContentSize().width/2-70,sprite6:getContentSize().height/2)
    sprite10:addChild(sprite21)
    self.type=display.newTTFLabel({
        text = "攻击向塔",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite6:getContentSize().width/2,sprite6:getContentSize().height/2-20)
    :addTo(sprite10)
--技能触发时间
    local sprite11 = ccui.CheckBox:
    create("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\basemap_properties_default.png", nil,
    "res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\basemap_properties_enhanced.png", nil, nil)
    sprite11:setAnchorPoint(0, 1)
    sprite11:setPosition(25+sprite1:getContentSize().width/2,sprite1:getContentSize().height-530)
    sprite1:addChild(sprite11)
    local sprite22 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\text_details\\text_11.png")
    sprite22:setAnchorPoint(0, 0.5)
    sprite22:setPosition(sprite6:getContentSize().width/2-60,sprite6:getContentSize().height/2+20)
    sprite11:addChild(sprite22)
    local sprite23 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\icon_properties\\skill_trigger.png")
    sprite23:setAnchorPoint(1, 0.5)
    sprite23:setPosition(sprite6:getContentSize().width/2-70,sprite6:getContentSize().height/2)
    sprite11:addChild(sprite23)
    self.type=display.newTTFLabel({
        text = "攻击向塔",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite6:getContentSize().width/2,sprite6:getContentSize().height/2-20)
    :addTo(sprite11)

    --塔图片
    local sprite26 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\basemap_towerlegend.png")
    sprite26:setAnchorPoint(0, 1) 

    --介绍底图
    local sprite25= display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\basemap_skillintroduction.png")
    sprite25:setAnchorPoint(0, 1)
    sprite25:setPosition(sprite1:getContentSize().width/2-120,sprite1:getContentSize().height-120)
    sprite1:addChild(sprite25)
    --塔类型
    local sprite27 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\text_details\\title_3.png")
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
    --self.target:setString(self.pack:getTower():GetAtkTarget())
    --稀有度
    local sprite28 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\text_details\\title_4.png")
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
    local sprite29 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_detailpopup\\text_details\\title_2.png")
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
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function IntensifiesLayer:update(dt)
end

return IntensifiesLayer

