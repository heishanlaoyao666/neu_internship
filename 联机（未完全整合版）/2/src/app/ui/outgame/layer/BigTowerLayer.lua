--[[--
    静态大塔层
    BigTowerLayer.lua
]]
local BigTowerLayer =class("BigTowerLayer",require("app.ui.outgame.layer.BaseLayer"))
--[[--
    构造函数

    @param none

    @return none
]]
function BigTowerLayer:ctor()
    BigTowerLayer.super.ctor(self)
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function BigTowerLayer:initView()
    local id =self.pack:getTower():getTowerId()-- 当前塔的id
    local tempfilename
    local width, height = display.width, 1120

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, display.cy)

    tempfilename="artcontent/lobby_ongame/atlas_interface/tower_detailpopup/static_bigtower/sec_tower_"
    self.bigtower=display.newSprite(tempfilename..id..".png")
    self.bigtower:setAnchorPoint(0.5,0.5)
    self.bigtower:setPosition(display.cx, display.cy)
    self.container_:addChild(self.bigtower)
end

--[[--
    传入塔数据

    @param pack 类型：table，PackItem塔

    @return none
]]
function BigTowerLayer:setTower(pack)
    self.pack=pack
end

return BigTowerLayer

