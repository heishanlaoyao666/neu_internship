--[[--
    当前阵容的塔层
    CurrentTowerLayer.lua
]]
local CurrentTowerLayer = class("CurrentTowerLayer", require("app.ui.outgame.layer.BaseLayer"))
local OutGameData = require("app.data.outgame.OutGameData")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
--[[--
    构造函数

    @param none

    @return none
]]
function CurrentTowerLayer:ctor()
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function CurrentTowerLayer:initView()
    -- cc.UserDefault:getInstance():setIntegerForKey("current1",1)
    -- cc.UserDefault:getInstance():setIntegerForKey("current2",2)
    -- cc.UserDefault:getInstance():setIntegerForKey("current3",3)
    -- cc.UserDefault:getInstance():setIntegerForKey("current4",4)
    -- cc.UserDefault:getInstance():setIntegerForKey("current5",5)
    print(cc.UserDefault:getInstance():getIntegerForKey("current2"))
    local table={cc.UserDefault:getInstance():getIntegerForKey("current1"),
    cc.UserDefault:getInstance():getIntegerForKey("current2"),
    cc.UserDefault:getInstance():getIntegerForKey("current3"),
    cc.UserDefault:getInstance():getIntegerForKey("current4"),
    cc.UserDefault:getInstance():getIntegerForKey("current5")}

    local tempfilename
    local width, height = display.width, 1120
    local spriteC7 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/current_lineup/basemap_area.png")
    spriteC7:isVisible(false)


    self.container_lineups = ccui.Layout:create()
    self.container_lineups:setContentSize(self.width_, self.height_)
    self:addChild(self.container_lineups)
    self.container_lineups:setAnchorPoint(0.5, 0.5)
    self.container_lineups:setPosition(self.width_/2, self.height_/2)

    self.typefilename={"artcontent/lobby(ongame)/atlas_interface/current_lineup/towertype_tapping.png",
    "artcontent/lobby(ongame)/atlas_interface/current_lineup/towertype_disturbance.png",
    "artcontent/lobby(ongame)/atlas_interface/current_lineup/towertype_sup.png",
    "artcontent/lobby(ongame)/atlas_interface/current_lineup/towertype_control.png"}
    --塔
    for i=1,5 do
        tempfilename=string.format("artcontent/lobby(ongame)/currency/icon_tower/%02d.png", table[i])
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
                    cc.UserDefault:getInstance():setIntegerForKey("current2",self.id)
                    print(cc.UserDefault:getInstance():getIntegerForKey("current2"))
                    EventManager:doEvent(EventDef.ID.KNAPSACK_CHANGE)
                    EventManager:doEvent(EventDef.ID.BATTLE)
                    self:removeFromParent(true)
                end
            end
        )
        --等级底图
        local spriteD7 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/current_lineup/basemap_grade.png")
        towerbtn:addChild(spriteD7)
        spriteD7:setAnchorPoint(0.5, 0)
        spriteD7:setPosition(towerbtn:getContentSize().width/2,-30)

        tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_list/grade/Lv.%d.png"
        local spriteD9 = display.newSprite(string.format(tempfilename,OutGameData:getTower(table[i]):getLevel()))
        spriteD7:addChild(spriteD9)
        spriteD9:setAnchorPoint(0.5, 0.5)
        spriteD9:setPosition(spriteD7:getContentSize().width/2,spriteD7:getContentSize().height/2)

        local spriteD10 = display.newSprite(self.typefilename[OutGameData:getTower(table[i]):getTowerType()])
        towerbtn:addChild(spriteD10)
        spriteD10:setAnchorPoint(1, 1)
        spriteD10:setPosition(towerbtn:getContentSize().width-20,towerbtn:getContentSize().height)
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