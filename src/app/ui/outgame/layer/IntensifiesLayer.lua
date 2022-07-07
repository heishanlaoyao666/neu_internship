--[[--
    塔详细层
    IntensifiesLayer.lua
]]
local IntensifiesLayer =class("IntensifiesLayer",function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 123))
end)
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
local OutGameData = require("app.data.outgame.OutGameData")
local ConstDef = require("app.def.outgame.ConstDef")
local PropertyLayer = require("app.ui.outgame.layer.PropertyLayer")
local BigTowerLayer = require("app.ui.outgame.layer.BigTowerLayer")
local TowerLayer = require("app.ui.outgame.layer.TowerLayer")
local FrontLayer = require("app.ui.outgame.layer.FrontLayer")
--[[--
    构造函数

    @param none

    @return none
]]
function IntensifiesLayer:ctor()
    self.usingLayer_=nil -- 类型：UsingLayer，使用塔层
    self.bigtowerLayer_=nil -- 类型：BigTowerLayer，静态大塔层
    self.towerLayer_=nil -- 类型：TowerLayer，塔层
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function IntensifiesLayer:initView()
    cc.UserDefault:getInstance():setBoolForKey("攻击",false)
    cc.UserDefault:getInstance():setBoolForKey("攻速",false)
    cc.UserDefault:getInstance():setBoolForKey("技能",false)
    local rarity =self.pack:getTower():getTowerRarity() -- 当前塔的稀有度
    local tempfilename
    local width, height = display.width, 1120

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, display.cy)

    --静态大塔
    self.bigtowerLayer_=BigTowerLayer.new():addTo(self.container_)
    --底图
    local sprite1=display.newSprite("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_popup.png")
    sprite1:setAnchorPoint(0.5, 0)
    sprite1:setPosition(width/2,30)
    self.container_:addChild(sprite1)

    self.ratio=display.newTTFLabel({
        text = "XXX%",
        size = 22,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite1:getContentSize().width/2-10,33)
    :addTo(sprite1)
    self.ratioadd=display.newTTFLabel({
        text = "+X%",
        size = 22,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite1:getContentSize().width/2+150,33)
    :addTo(sprite1)
    if self.pack:getTower():getLevel()==1 then
        self.ratioadd:setString("+1%")
    elseif self.pack:getTower():getLevel()==2 then
        self.ratioadd:setString("+2%")
    else
        self.ratioadd:setString("+3%")
    end
    self.ratio:setString(OutGameData:getRatio())
    --x按钮
    local sprite2= ccui.Button:create("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/button_off.png")
    sprite1:addChild(sprite2)
    sprite2:setAnchorPoint(1, 1)
    sprite2:setPosition(sprite1:getContentSize().width-10, sprite1:getContentSize().height-10)
    sprite2:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                EventManager:doEvent(EventDef.ID.KNAPSACK_CHANGE)
                EventManager:doEvent(EventDef.ID.BATTLE)
                self:removeFromParent(true)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_close.OGG",false)
                end
            end
        end
    )
    --属性类型
    PropertyLayer.new():addTo(sprite1)

    --技能1
    local skill1num = self.pack:getTower():getTowerSkill1Num()

    self.typefilename={"towertype_tapping","towertype_disturbance","towertype_sup","towertype_control"}
    self.basemapfilename={"basemap_tower_normal","basemap_tower_rare","basemap_tower_epic","basemap_towerlegend"}
    --塔图片
    FrontLayer.new():addTo(sprite1)
    local sprite26 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/"
    ..self.basemapfilename[rarity]..".png")
    sprite26:setAnchorPoint(0, 1)
    sprite26:setPosition(50,sprite1:getContentSize().height-25)
    sprite1:addChild(sprite26)

    self.towerLayer_=TowerLayer.new():addTo(sprite26)
    --升级按钮
    local sprite3= ccui.Button:create("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/button_upgrade.png")
    sprite1:addChild(sprite3)
    sprite3:setAnchorPoint(0.5, 0)
    sprite3:setPosition(sprite1:getContentSize().width/2, 60)
    sprite3:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                if self.pack:getTower():getLevel()<13 then
                    if cc.UserDefault:getInstance():getBoolForKey("音效") then
                        audio.playEffect("sounds/ui_btn_close.OGG",false)
                    end
                    if OutGameData:towerLevelUp(self.pack)==2 then
                        EventManager:doEvent(EventDef.ID.GAMEDATA_CHANGE)
                        if self.pack:getTower():getAtkUpgrade() then
                            cc.UserDefault:getInstance():setBoolForKey("攻击",true)
                        else
                            cc.UserDefault:getInstance():setBoolForKey("攻击",false)
                        end
                        if self.pack:getTower():getFireCdUpgrade() then
                            cc.UserDefault:getInstance():setBoolForKey("攻速",true)
                        else
                            cc.UserDefault:getInstance():setBoolForKey("攻速",false)
                        end

                        if self.pack:getTower():getLevel()==1 then
                            self.ratioadd:setString("+2%")
                        elseif self.pack:getTower():getLevel()==2 then
                            self.ratioadd:setString("+3%")
                        else
                            self.ratioadd:setString("+3%")
                        end
                        self.ratio:setString(OutGameData:getRatio().."%")
                        if skill1num then
                            if self.pack:getTower():getValueUpgrade() then
                                cc.UserDefault:getInstance():setBoolForKey("技能",true)
                            else
                                cc.UserDefault:getInstance():setBoolForKey("技能",false)
                            end
                        end
                    else
                        cc.UserDefault:getInstance():setBoolForKey("攻击",false)
                        cc.UserDefault:getInstance():setBoolForKey("攻速",false)
                        cc.UserDefault:getInstance():setBoolForKey("技能",false)
                    end
                    self.gold:setString(ConstDef.LEVEL_UP_NEED_GOLD[self.pack:getTower():getLevel()+1][rarity])
                    self.towerLayer_:removeFromParent(true)
                    self.towerLayer_=TowerLayer.new():addTo(sprite26)
                    PropertyLayer.new():addTo(sprite1)
                end
            end
        end
    )
    local sprite24 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/icon_glod.png")
    sprite24:setAnchorPoint(0.5, 0.5)
    sprite24:setPosition(sprite3:getContentSize().width/2-30,sprite3:getContentSize().height/2-20)
    sprite3:addChild(sprite24)
    self.gold=display.newTTFLabel({
        text = "584",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.LEFT_CENTER, sprite3:getContentSize().width/2-10,sprite3:getContentSize().height/2-20)
    :addTo(sprite3)
    self.gold:setString(ConstDef.LEVEL_UP_NEED_GOLD[self.pack:getTower():getLevel()+1][rarity])
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
    Intensifiespack=self.pack
    local sprite5= ccui.Button:create("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/button_use.png")
    sprite1:addChild(sprite5)
    sprite5:setAnchorPoint(0.5, 0)
    sprite5:setPosition(sprite1:getContentSize().width/2+200, 60)
    sprite5:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                cc.UserDefault:getInstance():setIntegerForKey("available",1)--1可用，2不可用
                EventManager:doEvent(EventDef.ID.USING,Intensifiespack)
                self:removeFromParent(true)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_close.OGG",false)
                end
            end
        end
    )
    -- 屏蔽点击
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) 
        if event.name == "began" then
            return true
        end
    end)
    self:setTouchEnabled(true)
end

--[[--
    传入升级数据

    @param pack 类型：table，PackItem塔

    @return none
]]
function IntensifiesLayer:setUpgrade()
    self.value1change:setVisible(true)
end

--[[--
    传入塔数据

    @param pack 类型：table，PackItem塔

    @return none
]]
function IntensifiesLayer:setTower(pack)
    FrontLayer:setTower(pack)
    PropertyLayer:setTower(pack)
    BigTowerLayer:setTower(pack)
    TowerLayer:setTower(pack)
    self.pack=pack
end

return IntensifiesLayer

