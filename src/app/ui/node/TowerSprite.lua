---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Asus.
--- DateTime: 2022/6/22 14:14
---
--[[--
    塔节点
    TowerSprite
]]
local TowerSprite = class("towerSprite", function(res)
    return display.newSprite(res)
end)

local StringDef = require("app.def.StringDef")
local Factory = require("app.utils.Factory")

--[[--
    @description: 构造函数
    @param res type:string, 图片资源
    @return none
]]
function TowerSprite:ctor(res, data)
    self.data_ = data --type: table,精灵对应的数据

    local towerType = Factory:createTowerType(self.data_.type)
    local towerLevel = Factory:createTowerLevel(self.data_.level)

    self.levelSprite_ = towerLevel --type:sprite, 塔等级对应的精灵

    local size = self:getContentSize()
    towerType:setPosition(size.width * .85, size.height)
    towerLevel:setPosition(size.width * .5, -5)
    self:addChild(towerLevel)
    self:addChild(towerType)

end

--[[--
    @description: 帧刷新
    @param dt type:number, 帧间隔，单位秒
    @return none
]]
function TowerSprite:update(dt)
    --local texture = CCTextureCache:sharedTextureCache():addImage("res/home/guide/subinterface_tower_list/level/Lv." ..
    --    self.data_.level .. ".png")
    self.levelSprite_:setTexture(StringDef.PATH_PREFIX_SUBINTERFACE_TOWER_LEVEL ..
        self.data_.level .. ".png")
end

return TowerSprite
