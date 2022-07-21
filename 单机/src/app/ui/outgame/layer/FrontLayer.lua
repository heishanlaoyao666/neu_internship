--[[--
    塔详细上层
    FrontLayer.lua
]]
local FrontLayer =class("FrontLayer", require("app.ui.outgame.layer.BaseLayer"))
--[[--
    构造函数

    @param none

    @return none
]]
function FrontLayer:ctor()
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
    local basemap = display.newSprite("artcontent/lobby_ongame/atlas_interface/tower_detailpopup/basemap_popup.png")

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(basemap:getContentSize().width,basemap:getContentSize().height)
    self.container_:setAnchorPoint(0.5, 0)
    self.container_:setPosition(width/2-25,0)
    self.container_:addTo(self)
    self.basemapfilename={"basemap_tower_normal","basemap_tower_rare","basemap_tower_epic","basemap_towerlegend"}

    --介绍底图
    tempfilename ="artcontent/lobby_ongame/atlas_interface/tower_detailpopup/basemap_skillintroduction.png"
    local introductionBasemap= display.newSprite(tempfilename)
    introductionBasemap:setAnchorPoint(0, 1)
    introductionBasemap:setPosition(basemap:getContentSize().width/2-120,basemap:getContentSize().height-120)
    self.container_:addChild(introductionBasemap)
    --塔类型
    tempfilename ="artcontent/lobby_ongame/atlas_interface/tower_detailpopup/text_details/title_3.png"
    local typeSprite = display.newSprite(tempfilename)
    typeSprite:setAnchorPoint(0, 1)
    typeSprite:setPosition(basemap:getContentSize().width/2-120,basemap:getContentSize().height-25)
    self.container_:addChild(typeSprite)
    local towerType=display.newTTFLabel({
        text = "攻击向塔",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, basemap:getContentSize().width/2-60,basemap:getContentSize().height-75)
    :addTo(self.container_)
    if self.pack:getTower():getTowerType()==1 then
        towerType:setString("攻击向塔")
    elseif self.pack:getTower():getTowerType()==2 then
        towerType:setString("干扰向塔")
    elseif self.pack:getTower():getTowerType()==3 then
        towerType:setString("辅助向塔")
    elseif self.pack:getTower():getTowerType()==4 then
        towerType:setString("控制向塔")
    end
    --稀有度
    tempfilename = "artcontent/lobby_ongame/atlas_interface/tower_detailpopup/text_details/title_4.png"
    local towerRarity = display.newSprite(tempfilename)
    towerRarity:setAnchorPoint(0, 1)
    towerRarity:setPosition(basemap:getContentSize().width-200,basemap:getContentSize().height-25)
    self.container_:addChild(towerRarity)
    local rarityTTF=display.newTTFLabel({
        text = "普通",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, basemap:getContentSize().width-170,basemap:getContentSize().height-75)
    :addTo(self.container_)
    if rarity==1 then
        rarityTTF:setString("普通")
    elseif rarity==2 then
        rarityTTF:setString("稀有")
    elseif rarity==3 then
        rarityTTF:setString("史诗")
    elseif rarity==4 then
        rarityTTF:setString("传说")
    end
    --技能介绍
    tempfilename = "artcontent/lobby_ongame/atlas_interface/tower_detailpopup/text_details/title_2.png"
    local towerSkill = display.newSprite(tempfilename)
    towerSkill:setAnchorPoint(1, 1)
    towerSkill:setPosition(85,introductionBasemap:getContentSize().height-10)
    introductionBasemap:addChild(towerSkill)
    local introduction=display.newTTFLabel({
        text = "无",
        size = 20,
        color = display.COLOR_WHITE
    })
    :align(display.LEFT_CENTER, 10,introductionBasemap:getContentSize().height-50)
    :addTo(introductionBasemap)
    local skillinfo=self.pack:getTower():getTowerInfo()
        if #skillinfo>=20*3 then
            local stringfront=string.sub(skillinfo, 1, 19*3)
            local stringback=string.sub(skillinfo, 19*3+1, -1)
            introduction:setString(stringfront.."\n"..stringback)
        else
            introduction:setString(skillinfo)
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

