--[[--
    使用层
    UsingView.lua
]]
local UsingView = class("UsingView",function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 123))
end)
local CurrentLineupLayer = require("app.ui.outgame.layer.CurrentLineupLayer")
local TipsLayer = require("app.ui.outgame.layer.TipsLayer")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
--[[--
    构造函数

    @param none

    @return none
]]
function UsingView:ctor()
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function UsingView:initView()
    local tempfilename
    local width, height = display.width, 1120
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self:addChild(self.container_)
    self.container_:setPosition(0, 0)
    --底图
    local basemapGuide = display.newSprite("artcontent/lobby(ongame)/atlas_interface/basemap_guide.png")
    self.container_:addChild(basemapGuide)
    basemapGuide:setAnchorPoint(0.5, 0.5)
    basemapGuide:setPosition(display.cx,display.cy)

    --当前阵容
    currentlineupid=self.pack:getTower():getTowerId()
    CurrentLineupLayer:setId(currentlineupid)
    CurrentLineupLayer:new():addTo(self.container_)
    --提示信息
    self.container_1 = ccui.Layout:create()
    self.container_1:setContentSize(width, 150)
    self.container_1:setAnchorPoint(0.5,0.5)
    self.container_1:setPosition(display.cx, display.cy+45)
    self.container_1:addTo(self.container_)
    TipsLayer:new():addTo(self.container_1)

    --塔信息
    self.container_2 = ccui.Layout:create()
    self.container_2:setContentSize(display.width, height)
    self.container_2:setAnchorPoint(0.5,1)
    self.container_2:setPosition(display.cx,height-560)
    self.container_2:addTo(self.container_)

    --底图
    local basemap = display.newSprite("artcontent/lobby(ongame)/atlas_interface/tower_use/basemap_replacetower.png")
    self.container_2:addChild(basemap)
    basemap:setAnchorPoint(0.5, 1)
    basemap:setPosition(display.cx,height)

    tempfilename="artcontent/lobby(ongame)/currency/icon_tower/%02d.png"
    local tower = display.newSprite(string.format(tempfilename, self.pack:getTower():getTowerId()))
    basemap:addChild(tower)
    tower:setScale(0.9)
    tower:setAnchorPoint(0.5, 0.5)
    tower:setPosition(basemap:getContentSize().width/2,basemap:getContentSize().height/2+20)

    self.typefilename={"artcontent/lobby(ongame)/atlas_interface/current_lineup/towertype_tapping.png",
    "artcontent/lobby(ongame)/atlas_interface/current_lineup/towertype_disturbance.png",
    "artcontent/lobby(ongame)/atlas_interface/current_lineup/towertype_sup.png",
    "artcontent/lobby(ongame)/atlas_interface/current_lineup/towertype_control.png"}
    --等级底图
    tempfilename="artcontent/lobby(ongame)/atlas_interface/current_lineup/basemap_grade.png"
    local basemapGrade = display.newSprite(tempfilename)
    tower:addChild(basemapGrade)
    basemapGrade:setAnchorPoint(0.5, 0)
    basemapGrade:setPosition(tower:getContentSize().width/2,-30)

    tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_list/grade/Lv.%d.png"
    local grade = display.newSprite(string.format(tempfilename,self.pack:getTower():getLevel()))
    basemapGrade:addChild(grade)
    grade:setAnchorPoint(0.5, 0.5)
    grade:setPosition(basemapGrade:getContentSize().width/2,basemapGrade:getContentSize().height/2)

    local towerType = display.newSprite(self.typefilename[self.pack:getTower():getTowerType()])
    tower:addChild(towerType)
    towerType:setAnchorPoint(1, 1)
    towerType:setPosition(tower:getContentSize().width-20,tower:getContentSize().height)

    --取消按钮
    local cancelbtn= ccui.Button:create("artcontent/lobby(ongame)/atlas_interface/tower_use/icon_cancel.png")
    basemap:addChild(cancelbtn)
    cancelbtn:setAnchorPoint(0.5, 0)
    cancelbtn:setPosition(basemap:getContentSize().width/2,40)
    cancelbtn:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                cc.UserDefault:getInstance():setIntegerForKey("available",2)
                EventManager:doEvent(EventDef.ID.KNAPSACK_CHANGE)
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
    传入塔数据

    @param pack 类型：table，PackItem塔

    @return none
]]
function UsingView:setTower(pack)
    self.pack=pack
end

--[[--
    返回塔数据

    @param pack 类型：table，PackItem塔

    @return self.pack:getTower():getTowerId() 类型：number,塔的id
]]
function UsingView:getTower()
    return self.pack:getTower():getTowerId()
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function UsingView:update(dt)
end

return UsingView

