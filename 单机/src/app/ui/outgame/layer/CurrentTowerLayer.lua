--[[--
    当前阵容的塔层
    CurrentTowerLayer.lua
]]
local CurrentTowerLayer = class("CurrentTowerLayer", require("app.ui.outgame.layer.BaseLayer"))
local OutGameData = require("app.data.outgame.OutGameData")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
local GameData= require("app.data.ingame.GameData")
--[[--
    构造函数

    @param none

    @return none
]]
function CurrentTowerLayer:ctor()
    CurrentTowerLayer.super.ctor(self)

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function CurrentTowerLayer:initView()
    currentlineup=cc.UserDefault:getInstance():getIntegerForKey("currentlineup")
    -- cc.UserDefault:getInstance():setIntegerForKey("current1"..currentlineup,1)
    -- cc.UserDefault:getInstance():setIntegerForKey("current2"..currentlineup,2)
    -- cc.UserDefault:getInstance():setIntegerForKey("current3"..currentlineup,3)
    -- cc.UserDefault:getInstance():setIntegerForKey("current4"..currentlineup,4)
    -- cc.UserDefault:getInstance():setIntegerForKey("current5"..currentlineup,5)
    local table={cc.UserDefault:getInstance():getIntegerForKey("current1"..currentlineup),
    cc.UserDefault:getInstance():getIntegerForKey("current2"..currentlineup),
    cc.UserDefault:getInstance():getIntegerForKey("current3"..currentlineup),
    cc.UserDefault:getInstance():getIntegerForKey("current4"..currentlineup),
    cc.UserDefault:getInstance():getIntegerForKey("current5"..currentlineup)}
    local tempfilename
    local width, height = display.width, 1120
    local spriteC7 = display.newSprite("artcontent/lobby_ongame/atlas_interface/current_lineup/basemap_area.png")
    spriteC7:isVisible(false)


    self.container_lineups = ccui.Layout:create()
    self.container_lineups:setContentSize(self.width_, self.height_)
    self:addChild(self.container_lineups)
    self.container_lineups:setAnchorPoint(0.5, 0.5)
    self.container_lineups:setPosition(self.width_/2, self.height_/2)

    self.typefilename={"artcontent/lobby_ongame/atlas_interface/current_lineup/towertype_tapping.png",
    "artcontent/lobby_ongame/atlas_interface/current_lineup/towertype_disturbance.png",
    "artcontent/lobby_ongame/atlas_interface/current_lineup/towertype_sup.png",
    "artcontent/lobby_ongame/atlas_interface/current_lineup/towertype_control.png"}
    --塔
    for i=1,5 do
        tempfilename=string.format("artcontent/lobby_ongame/currency/icon_tower/%02d.png", table[i])
        local towerbtn = ccui.Button:create(tempfilename)
        self:addChild(towerbtn)
        towerbtn:setScale(0.9)
        towerbtn:setAnchorPoint(0.5, 0)
        towerbtn:setPosition(self.width_/2+(120*i-360),self.height_/2-40)
        towerbtn:addTouchEventListener(
            function(sender, eventType)
                -- ccui.TouchEventType
                if 2 == eventType then -- touch end
                    if cc.UserDefault:getInstance():getBoolForKey("音效") then
                        audio.playEffect("sounds/ui_btn_click.OGG",false)
                    end
                    for j=1,5 do
                        local tempi =  cc.UserDefault:getInstance():getIntegerForKey("current"..i..currentlineup)
                        local tempj =  cc.UserDefault:getInstance():getIntegerForKey("current"..j..currentlineup)
                        if self.id==tempj and i~=j then
                            cc.UserDefault:getInstance():setIntegerForKey("current"..j..currentlineup,tempi)
                        end
                    end
                    cc.UserDefault:getInstance():setIntegerForKey("current"..i..currentlineup,self.id)
                    --end
                    cc.UserDefault:getInstance():setIntegerForKey("available",2)
                    EventManager:doEvent(EventDef.ID.BATTLE)
                    EventManager:doEvent(EventDef.ID.KNAPSACK_CHANGE)
                    self:removeFromParent(true)
                end
            end
        )
        if cc.UserDefault:getInstance():getIntegerForKey("available")==1 then
            towerbtn:setTouchEnabled(true)
        else
            towerbtn:setTouchEnabled(false)
        end
        --等级底图
        local basemap = display.newSprite("artcontent/lobby_ongame/atlas_interface/current_lineup/basemap_grade.png")
        towerbtn:addChild(basemap)
        basemap:setAnchorPoint(0.5, 0)
        basemap:setPosition(towerbtn:getContentSize().width/2,-30)

        tempfilename="artcontent/lobby_ongame/atlas_interface/tower_list/grade/Lv.%d.png"
        local grade = display.newSprite(string.format(tempfilename,OutGameData:getTower(table[i]):getLevel()))
        basemap:addChild(grade)
        grade:setAnchorPoint(0.5, 0.5)
        grade:setPosition(basemap:getContentSize().width/2,basemap:getContentSize().height/2)

        local towerType = display.newSprite(self.typefilename[OutGameData:getTower(table[i]):getTowerType()])
        towerbtn:addChild(towerType)
        towerType:setAnchorPoint(1, 1)
        towerType:setPosition(towerbtn:getContentSize().width-20,towerbtn:getContentSize().height)
        OutGameData:setCurrentTower(OutGameData:getTower(table[i]),i)
    end
end

--[[--
    传入塔id

    @param id 类型：number，塔id

    @return none
]]
function CurrentTowerLayer:setContentSize(width,height)
    self.width_=width
    self.height_=height
end

--[[--
    传入塔id

    @param id 类型：number，塔id

    @return none
]]
function CurrentTowerLayer:setId(id)
    self.id=id
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function CurrentTowerLayer:update(dt)
end

return CurrentTowerLayer