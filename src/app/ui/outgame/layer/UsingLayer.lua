--[[--
    使用层
    UsingLayer.lua
]]
local UsingLayer = class("UsingLayer", require("app.ui.outgame.layer.BaseLayer"))
local CurrentLineupLayer = require("app.ui.outgame.layer.CurrentLineupLayer")
local TipsLayer = require("app.ui.outgame.layer.TipsLayer")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
--[[--
    构造函数

    @param none

    @return none
]]
function UsingLayer:ctor()
    UsingLayer.super.ctor(self)


    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function UsingLayer:initView()
    local tempfilename
    local width, height = display.width, 1120
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self:addChild(self.container_)
    self.container_:setPosition(0, 0)
    --底图
    local spriteC = display.newSprite("artcontent/lobby(ongame)/atlas_interface/basemap_guide.png")
    self.container_:addChild(spriteC)
    spriteC:setAnchorPoint(0.5, 0.5)
    spriteC:setPosition(display.cx,display.cy)

    --当前阵容
    currentlineupid=self.pack:getTower():getTowerId()
    CurrentLineupLayer:setId(currentlineupid)
    CurrentLineupLayer:new():addTo(self.container_)
    --提示信息
    self.container_1 = ccui.Layout:create()
    -- self.container_1:setBackGroundColor(cc.c3b(200, 0, 0))
    -- self.container_1:setBackGroundColorType(1)
    self.container_1:setContentSize(width, 150)
    self.container_1:setAnchorPoint(0.5,0.5)
    self.container_1:setPosition(display.cx, display.cy+45)
    self.container_1:addTo(self.container_)
    TipsLayer:new():addTo(self.container_1)
    --提示信息
    self.container_2 = ccui.Layout:create()
    self.container_2:setContentSize(display.width, height)
    self.container_2:setAnchorPoint(0.5,1)
    self.container_2:setPosition(display.cx,height-560)
    self.container_2:addTo(self.container_)

    --底图
    local sprite1 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/tower_use/basemap_replacetower.png")
    self.container_2:addChild(sprite1)
    sprite1:setAnchorPoint(0.5, 1)
    sprite1:setPosition(display.cx,height)

    tempfilename="artcontent/lobby(ongame)/currency/icon_tower/%02d.png"
    local tower = display.newSprite(string.format(tempfilename, self.pack:getTower():getTowerId()))
    sprite1:addChild(tower)
    tower:setScale(0.9)
    tower:setAnchorPoint(0.5, 0.5)
    tower:setPosition(sprite1:getContentSize().width/2,sprite1:getContentSize().height/2+20)

    self.typefilename={"artcontent/lobby(ongame)/atlas_interface/current_lineup/towertype_tapping.png",
    "artcontent/lobby(ongame)/atlas_interface/current_lineup/towertype_disturbance.png",
    "artcontent/lobby(ongame)/atlas_interface/current_lineup/towertype_sup.png",
    "artcontent/lobby(ongame)/atlas_interface/current_lineup/towertype_control.png"}
    --等级底图
    local spriteD7 = display.
    newSprite("artcontent/lobby(ongame)/atlas_interface/current_lineup/basemap_grade.png")
    tower:addChild(spriteD7)
    spriteD7:setAnchorPoint(0.5, 0)
    spriteD7:setPosition(tower:getContentSize().width/2,-30)

    tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_list/grade/Lv.%d.png"
    local spriteD9 = display.newSprite(string.format(tempfilename,self.pack:getTower():getLevel()))
    spriteD7:addChild(spriteD9)
    spriteD9:setAnchorPoint(0.5, 0.5)
    spriteD9:setPosition(spriteD7:getContentSize().width/2,spriteD7:getContentSize().height/2)

    local spriteD10 = display.newSprite(self.typefilename[self.pack:getTower():getTowerType()])
    tower:addChild(spriteD10)
    spriteD10:setAnchorPoint(1, 1)
    spriteD10:setPosition(tower:getContentSize().width-20,tower:getContentSize().height)

    --取消按钮
    local cancelbtn= ccui.Button:create("artcontent/lobby(ongame)/atlas_interface/tower_use/icon_cancel.png")
    sprite1:addChild(cancelbtn)
    cancelbtn:setAnchorPoint(0.5, 0)
    cancelbtn:setPosition(sprite1:getContentSize().width/2,40)
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
end

--[[--
    传入塔数据

    @param pack 类型：table，PackItem塔

    @return none
]]
function UsingLayer:setTower(pack)
    self.pack=pack
end

--[[--
    返回塔数据

    @param pack 类型：table，PackItem塔

    @return self.pack:getTower():getTowerId() 类型：number,塔的id
]]
function UsingLayer:getTower()
    return self.pack:getTower():getTowerId()
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function UsingLayer:update(dt)
end

return UsingLayer

