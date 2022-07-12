--[[--
    静态大塔层
    TowerLayer.lua
]]
local TowerLayer =class("TowerLayer",require("app.ui.outgame.layer.BaseLayer"))
local ConstDef = require("app.def.outgame.ConstDef")
--[[--
    构造函数

    @param none

    @return noneT
]]
function TowerLayer:ctor()
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function TowerLayer:initView()
    local rarity =self.pack:getTower():getTowerRarity() -- 当前塔的稀有度
    local id =self.pack:getTower():getTowerId()-- 当前塔的id
    local tempfilename
    local width, height = display.width, 1120
    self.spritemap=display.newSprite("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_popup.png")
    self.container_1 = ccui.Layout:create()
    self.container_1:setContentSize(self.spritemap:getContentSize().width,self.spritemap:getContentSize().height)
    self.container_1:addTo(self)
    self.container_1:setAnchorPoint(0.5, 0.5)
    self.container_1:setPosition(self.spritemap:getContentSize().width/2,self.spritemap:getContentSize().height/2)

    self.basemapfilename="artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_tower_normal.png"
    local spritebasemap = display.newSprite(self.basemapfilename)
    self.typefilename={"towertype_tapping","towertype_disturbance","towertype_sup","towertype_control"}
    tempfilename=string.format("artcontent/lobby(ongame)/currency/icon_tower/%02d.png",id)
    local spriteD6 = display.newSprite(tempfilename)
    self:addChild(spriteD6)
    spriteD6:setAnchorPoint(0.5, 0.5)
    spriteD6:setPosition(spritebasemap:getContentSize().width/2,spritebasemap:getContentSize().height/2+30)
    self.spriteD7 = display.
    newSprite(string.format("artcontent/lobby(ongame)/atlas_interface/tower_list/grade/Lv.%d.png",
    self.pack:getTower():getLevel()))
    self:addChild(self.spriteD7)
    self.spriteD7:setAnchorPoint(0.5, 0.5)
    self.spriteD7:setPosition(spritebasemap:getContentSize().width/2,spritebasemap:getContentSize().height/2-40)
    tempfilename ="artcontent/lobby(ongame)/atlas_interface/tower_list/progressbar_basemap_fragmentsnumber.png"
    local spriteD8 = display.newSprite(tempfilename)
    self:addChild(spriteD8)
    spriteD8:setAnchorPoint(0.5, 0.5)
    spriteD8:setPosition(spritebasemap:getContentSize().width/2,spritebasemap:getContentSize().height/2-80)
    tempfilename ="artcontent/lobby(ongame)/atlas_interface/tower_list/progress_progress_fragmentsnumber.png"
    local spriteD9= display.newSprite(tempfilename)
    spriteD8:addChild(spriteD9)
    spriteD9:setAnchorPoint(0.5, 0.5)
    spriteD9:setPosition(spriteD8:getContentSize().width/2,spriteD8:getContentSize().height/2)
    self.num=display.newTTFLabel({
        text = "0/1",
        size = 22,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, spriteD9:getContentSize().width/2,spriteD9:getContentSize().height/2)
    :addTo(spriteD9)
    self.needcard=ConstDef.LEVEL_UP_NEED_CARD[self.pack:getTower():getLevel()+1][rarity]
    self.num:setString(self.pack:getTowerNumber().."/"..self.needcard)
    local spriteD10 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/"
    ..self.typefilename[self.pack:getTower():getTowerType()]..".png")
    self:addChild(spriteD10)
    spriteD10:setAnchorPoint(1, 1)
    spriteD10:setPosition(spritebasemap:getContentSize().width-10,spritebasemap:getContentSize().height)
end
--[[--
    传入塔数据

    @param pack 类型：table，PackItem塔

    @return none
]]
function TowerLayer:setTower(pack)
    self.pack=pack
end

return TowerLayer

