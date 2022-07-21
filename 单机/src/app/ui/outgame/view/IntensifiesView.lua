--[[--
    塔详细层
    IntensifiesView.lua
]]
local IntensifiesView =class("IntensifiesView",function()
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
function IntensifiesView:ctor()
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
function IntensifiesView:initView()
    cc.UserDefault:getInstance():setBoolForKey("攻击",false)
    cc.UserDefault:getInstance():setBoolForKey("攻速",false)
    cc.UserDefault:getInstance():setBoolForKey("技能",false)
    local rarity =self.pack:getTower():getTowerRarity() -- 当前塔的稀有度
    local skill1num = self.pack:getTower():getTowerSkill1Num() --技能1
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
    local basemap=display.newSprite("artcontent/lobby_ongame/atlas_interface/tower_detailpopup/basemap_popup.png")
    basemap:setAnchorPoint(0.5, 0)
    basemap:setPosition(width/2,30)
    self.container_:addChild(basemap)

    local ratio=display.newTTFLabel({
        text = "XXX%",
        size = 22,
        color = cc.c3b(255, 215, 0)
    })
    :align(display.CENTER, basemap:getContentSize().width/2-10,33)
    :addTo(basemap)
    local ratioadd=display.newTTFLabel({
        text = "+X%",
        size = 22,
        color = cc.c3b(255, 215, 0)
    })
    :align(display.CENTER, basemap:getContentSize().width/2+150,33)
    :addTo(basemap)
    if self.pack:getTower():getLevel()==1 then
        ratioadd:setString("+1%")
    elseif self.pack:getTower():getLevel()==2 then
        ratioadd:setString("+2%")
    else
        ratioadd:setString("+3%")
    end
    ratio:setString(OutGameData:getRatio())
    --x按钮
    local offBtn= ccui.Button:create("artcontent/lobby_ongame/atlas_interface/tower_detailpopup/button_off.png")
    basemap:addChild(offBtn)
    offBtn:setAnchorPoint(1, 1)
    offBtn:setPosition(basemap:getContentSize().width-10, basemap:getContentSize().height-10)
    offBtn:addTouchEventListener(
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
    PropertyLayer.new():addTo(basemap)

    --self.typefilename={"towertype_tapping","towertype_disturbance","towertype_sup","towertype_control"}
    local basemapFilename={"basemap_tower_normal","basemap_tower_rare","basemap_tower_epic","basemap_towerlegend"}
    --塔图片
    FrontLayer.new():addTo(basemap)
    local towerSprite = display.newSprite("artcontent/lobby_ongame/atlas_interface/tower_detailpopup/"
    ..basemapFilename[rarity]..".png")
    towerSprite:setAnchorPoint(0, 1)
    towerSprite:setPosition(50,basemap:getContentSize().height-25)
    basemap:addChild(towerSprite)

    self.towerLayer_=TowerLayer.new():addTo(towerSprite)
    --升级按钮
    local upgradeBtn= ccui.Button:create("artcontent/lobby_ongame/atlas_interface/tower_detailpopup/button_upgrade.png")
    basemap:addChild(upgradeBtn)
    upgradeBtn:setAnchorPoint(0.5, 0)
    upgradeBtn:setPosition(basemap:getContentSize().width/2, 60)

    local glod = display.newSprite("artcontent/lobby_ongame/atlas_interface/tower_detailpopup/icon_glod.png")
    glod:setAnchorPoint(0.5, 0.5)
    glod:setPosition(upgradeBtn:getContentSize().width/2-30,upgradeBtn:getContentSize().height/2-20)
    upgradeBtn:addChild(glod)
    goldTTF=display.newTTFLabel({
        text = "584",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.LEFT_CENTER, upgradeBtn:getContentSize().width/2-10,upgradeBtn:getContentSize().height/2-20)
    :addTo(upgradeBtn)
    goldTTF:setString(ConstDef.LEVEL_UP_NEED_GOLD[self.pack:getTower():getLevel()+1][rarity])

    upgradeBtn:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                if self.pack:getTower():getLevel()<13 then
                    if cc.UserDefault:getInstance():getBoolForKey("音效") then
                        audio.playEffect("sounds/tower_level_up.OGG",false)
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
                            ratioadd:setString("+2%")
                        elseif self.pack:getTower():getLevel()==2 then
                            ratioadd:setString("+3%")
                        else
                            ratioadd:setString("+3%")
                        end
                        ratio:setString(OutGameData:getRatio().."%")
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
                    goldTTF:setString(ConstDef.LEVEL_UP_NEED_GOLD[self.pack:getTower():getLevel()+1][rarity])
                    self.towerLayer_:removeFromParent(true)
                    self.towerLayer_=TowerLayer.new():addTo(towerSprite)
                    PropertyLayer.new():addTo(basemap)
                end
            end
        end
    )

    --强化按钮
    local enhancedBtn= ccui.Button:create("artcontent/lobby_ongame/atlas_interface/tower_detailpopup/button_enhanced.png")
    basemap:addChild(enhancedBtn)
    enhancedBtn:setAnchorPoint(0.5, 0)
    enhancedBtn:setPosition(basemap:getContentSize().width/2-200, 60)
    enhancedBtn:addTouchEventListener(
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
    local useBtn= ccui.Button:create("artcontent/lobby_ongame/atlas_interface/tower_detailpopup/button_use.png")
    basemap:addChild(useBtn)
    useBtn:setAnchorPoint(0.5, 0)
    useBtn:setPosition(basemap:getContentSize().width/2+200, 60)
    useBtn:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                cc.UserDefault:getInstance():setIntegerForKey("available",1)--1可用，2不可用
                EventManager:doEvent(EventDef.ID.USING,Intensifiespack)
                self:removeFromParent(true)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_click.OGG",false)
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
function IntensifiesView:setUpgrade()
    self.value1change:setVisible(true)
end

--[[--
    传入塔数据

    @param pack 类型：table，PackItem塔

    @return none
]]
function IntensifiesView:setTower(pack)
    FrontLayer:setTower(pack)
    PropertyLayer:setTower(pack)
    BigTowerLayer:setTower(pack)
    TowerLayer:setTower(pack)
    self.pack=pack
end

return IntensifiesView

