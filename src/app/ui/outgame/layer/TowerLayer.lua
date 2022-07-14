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
    local typefilename={"towertype_tapping","towertype_disturbance","towertype_sup","towertype_control"}
    local width, height = display.width, 1120

    local basemap=display.newSprite("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_popup.png")
    self.container_1 = ccui.Layout:create()
    self.container_1:setContentSize(basemap:getContentSize().width,basemap:getContentSize().height)
    self.container_1:addTo(self)
    self.container_1:setAnchorPoint(0.5, 0.5)
    self.container_1:setPosition(basemap:getContentSize().width/2,basemap:getContentSize().height/2)

    tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/basemap_tower_normal.png"
    local normal = display.newSprite(tempfilename)

    tempfilename=string.format("artcontent/lobby(ongame)/currency/icon_tower/%02d.png",id)
    local towerSprite = display.newSprite(tempfilename)
    self:addChild(towerSprite)
    towerSprite:setAnchorPoint(0.5, 0.5)
    towerSprite:setPosition(normal:getContentSize().width/2,normal:getContentSize().height/2+30)
    grade = display.
    newSprite(string.format("artcontent/lobby(ongame)/atlas_interface/tower_list/grade/Lv.%d.png",
    self.pack:getTower():getLevel()))
    self:addChild(grade)
    grade:setAnchorPoint(0.5, 0.5)
    grade:setPosition(normal:getContentSize().width/2,normal:getContentSize().height/2-40)
    tempfilename ="artcontent/lobby(ongame)/atlas_interface/tower_list/progressbar_basemap_fragmentsnumber.png"
    local progressbar = display.newSprite(tempfilename)
    self:addChild(progressbar)
    progressbar:setAnchorPoint(0.5, 0.5)
    progressbar:setPosition(normal:getContentSize().width/2,normal:getContentSize().height/2-80)
    tempfilename ="artcontent/lobby(ongame)/atlas_interface/tower_list/progress_progress_fragmentsnumber.png"
    local progress= display.newSprite(tempfilename)
    progressbar:addChild(progress)
    progress:setAnchorPoint(0.5, 0.5)
    progress:setPosition(progressbar:getContentSize().width/2,progressbar:getContentSize().height/2)
    local num=display.newTTFLabel({
        text = "0/1",
        size = 22,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, progress:getContentSize().width/2,progress:getContentSize().height/2)
    :addTo(progress)
    self.needcard=ConstDef.LEVEL_UP_NEED_CARD[self.pack:getTower():getLevel()+1][rarity]
    num:setString(self.pack:getTowerNumber().."/"..self.needcard)
    local towerBasemap = display.newSprite("artcontent/lobby(ongame)/atlas_interface/tower_detailpopup/"
    ..typefilename[self.pack:getTower():getTowerType()]..".png")
    self:addChild(towerBasemap)
    towerBasemap:setAnchorPoint(1, 1)
    towerBasemap:setPosition(normal:getContentSize().width-10,normal:getContentSize().height)
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

