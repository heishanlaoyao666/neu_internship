--[[--
    塔详细层
    FrontLayer.lua
]]
local FrontLayer =class("FrontLayer", require("app.ui.outgame.layer.BaseLayer"))
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
local OutGameData = require("app.data.outgame.OutGameData")
local ConstDef = require("app.def.outgame.ConstDef")
local TowerLayer = require("app.ui.outgame.layer.TowerLayer")
--[[--
    构造函数

    @param none

    @return none
]]
function FrontLayer:ctor()
    self.UsingLayer_=nil -- 类型：UsingLayer，使用塔层
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function FrontLayer:initView()
    local rarity =self.pack:getTower():getTowerRarity() -- 当前塔的稀有度
    local skill1num=self.pack:getTower():getSkill1Value()
    local tempfilename
    local width, height = display.width, 1120

    --底图
    local sprite1 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_popup.png")

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(sprite1:getContentSize().width,sprite1:getContentSize().height)
    self.container_:setAnchorPoint(0.5, 0)
    self.container_:setPosition(width/2-25,0)
    self.container_:addTo(self)
    self.basemapfilename={"basemap_tower_normal","basemap_tower_rare","basemap_tower_epic","basemap_towerlegend"}

    --介绍底图
    tempfilename ="artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_skillintroduction.png"
    local sprite25= display.newSprite(tempfilename)
    sprite25:setAnchorPoint(0, 1)
    sprite25:setPosition(sprite1:getContentSize().width/2-120,sprite1:getContentSize().height-120)
    self.container_:addChild(sprite25)
    --塔类型
    tempfilename ="artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/text_details/title_3.png"
    local sprite27 = display.newSprite(tempfilename)
    sprite27:setAnchorPoint(0, 1)
    sprite27:setPosition(sprite1:getContentSize().width/2-120,sprite1:getContentSize().height-25)
    self.container_:addChild(sprite27)
    self.type2=display.newTTFLabel({
        text = "攻击向塔",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite1:getContentSize().width/2-60,sprite1:getContentSize().height-75)
    :addTo(self.container_)
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
    self.container_:addChild(sprite28)
    self.Rarity=display.newTTFLabel({
        text = "普通",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite1:getContentSize().width-170,sprite1:getContentSize().height-75)
    :addTo(self.container_)
    if rarity==1 then
        self.Rarity:setString("普通")
    elseif rarity==2 then
        self.Rarity:setString("稀有")
    elseif rarity==3 then
        self.Rarity:setString("史诗")
    elseif rarity==4 then
        self.Rarity:setString("传说")
    end
    --技能介绍
    tempfilename = "artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/text_details/title_2.png"
    local sprite29 = display.newSprite(tempfilename)
    sprite29:setAnchorPoint(1, 1)
    sprite29:setPosition(85,sprite25:getContentSize().height-10)
    sprite25:addChild(sprite29)
    self.introduction=display.newTTFLabel({
        text = "无",
        size = 20,
        color = display.COLOR_WHITE
    })
    :align(display.LEFT_CENTER, 10,sprite25:getContentSize().height-50)
    :addTo(sprite25)
    local skillinfo=self.pack:getTower():getTowerInfo()
    if skill1num then
        if #skillinfo>19*3 then
            local stringfront=string.sub(skillinfo, 1, 19*3)
            local stringback=string.sub(skillinfo, 20*3+1, #skillinfo)
            self.introduction:setString(stringfront.."\n"..stringback)
        else
            self.introduction:setString(skillinfo)
        end
    end
end

--[[--
    传入塔数据

    @param pack 类型：table，PackItem塔

    @return none
]]
function FrontLayer:setTower(pack)
    self.pack=pack
end

return FrontLayer

