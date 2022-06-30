--[[--
    战斗层
    FightingLayer.lua
]]
local FightingLayer = class("FightingLayer", require("app.ui.ingame.layer.BaseLayer"))

local GameData = require("app.data.ingame.GameData")
local TowerSprite = require("app.ui.ingame.node.TowerSprite")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

local touchTower = nil

function FightingLayer:ctor()
    FightingLayer.super.ctor(self)

    GameData:init()

    self.spNum_ = nil -- 生成所需sp

    self.bulletMap_ = {}
    self.towerMap_ = {}
    self.enemyMap = {}
    self.bossMap_ = {}
    self.lineup_ = {} -- 我的阵容
    self.enhanceNeedSp_ = {}

    self:init()
    self:initView()
end
--[[--
    用于制作测试数据

    @parm none

    @return none
]]
function FightingLayer:init()
    self.lineup_ = GameData:getMyTowers()
end

function FightingLayer:initView()
    --角标映射
    local angelMark = {
        "artcontent/battle(ongame)/battle_interface/angelmark_towertype/towertype_tapping.png",
        "artcontent/battle(ongame)/battle_interface/angelmark_towertype/towertype_disturbance.png",
        "artcontent/battle(ongame)/battle_interface/angelmark_towertype/towertype_sup.png",
        "artcontent/battle(ongame)/battle_interface/angelmark_towertype/towertype_control.png"
    }

    --self.lineup_ = OutGameData:getMyLineup()
    local index_x = 120
    for i = 1, #self.lineup_ do
        --头像
        local towerBtn = ccui.Button:create(
            string.format("artcontent/battle(ongame)/battle_interface/tower/tower_%d.png",
            self.lineup_[i]:getTowerId()))
        towerBtn:setPosition(index_x, 120)
        towerBtn:addTouchEventListener(function(sender, eventType)
            if eventType == 2 then
                print(self.lineup_[i]:getTowerId())
            end
        end)
        towerBtn:addTo(self)

        --等级
        local levelSprite = cc.Sprite:create(
            string.format("artcontent/battle(ongame)/battle_interface/grade/LV.%d.png",
             self.lineup_[i]:getLevel()))
        levelSprite:setPosition(index_x, 50)
        levelSprite:addTo(self)

        --强化sp底图
        local spSprite = cc.Sprite:create("artcontent/battle(ongame)/battle_interface/basemap_sp.png")
        spSprite:setPosition(index_x, 80)
        spSprite:setScale(0.8)
        spSprite:addTo(self)

        --强化所需sp
        local needSpText = ccui.Text:create("100", "artcontent/font/fzbiaozjw.ttf", 20)
        needSpText:setPosition(index_x, 80)
        needSpText:setAnchorPoint(0.2, 0.5)
        needSpText:addTo(self)
        table.insert(self.enhanceNeedSp_, i, needSpText)

        --塔类型角标
        local angleMarkSprite = cc.Sprite:create(angelMark[self.lineup_[i]:getTowerType()])
        angleMarkSprite:setPosition(index_x + 33, 150)
        angleMarkSprite:addTo(self)
        index_x = index_x + 120
    end

    --生成塔按钮
    local buildBtn = ccui.Button:create("artcontent/battle(ongame)/battle_interface/button_generate.png")
    buildBtn:addTouchEventListener(function(sender, eventType)
        if eventType == 2 then
            GameData:creatTower()
        end
    end)
    buildBtn:setPosition(display.cx, 240)
    buildBtn:addTo(self)

    --生成塔所需sp数值
    self.spNum_ = ccui.Text:create("10", "artcontent/font/fzbiaozjw.ttf", 26)
    self.spNum_:setAnchorPoint(0.1, 0.5)
    self.spNum_:setPosition(display.cx, 200)
    self.spNum_:addTo(self)

    --添加触摸事件
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if touchTower == nil then
            touchTower = GameData:getFightingTowerByIndex(event.x, event.y)
        end
        if event.name == "began" then
            return self:onTouchBegan(event.x, event.y, touchTower)
        elseif event.name == "moved" then
            self:onTouchMoved(event.x, event.y, touchTower)
        elseif event.name == "ended" then
            self:onTouchEnded(event.x, event.y, touchTower)
        end
    end)
    self:setTouchEnabled(true)
end

--[[--
    触摸开始

    @param x 类型：number
    @param y 类型：number
    @parm tower 类型：fightingTower

    @return boolean
]]
function FightingLayer:onTouchBegan(x, y, tower)
    if tower ~= nil then
        GameData:moveTo(x, y, tower)
        return true
    end
    return false
end

--[[--
    触摸移动

    @param x 类型：number
    @param y 类型：number
    @parm tower 类型：fightingTower

    @return none
]]
function FightingLayer:onTouchMoved(x, y, tower)
    GameData:moveTo(x, y, tower)
end

--[[--
    触摸结束

    @param x 类型：number
    @param y 类型：number
    @parm tower 类型：fightingTower

    @return none
]]
function FightingLayer:onTouchEnded(x, y, tower1)
    tower2 = GameData:getFightingTowerByIndex(x, y, tower1)
    if tower2 == nil or tower1:getStar() ~= tower2:getStar() then
        local index = GameData:getTowerIndex(tower1)
        local index_x, index_y = index[1], index[2]
        GameData:moveTo(index_x, index_y, tower1)
    else
        print("融合")
    end
    touchTower = nil
end



--[[--
    节点进入

    @param none

    @return none
]]
function FightingLayer:onEnter()
    --生成塔与角标
    EventManager:regListener(EventDef.ID.CREATE_SELF, self, function(tower)
        local towerNode = TowerSprite.new(
            string.format("artcontent/battle(ongame)/battle_interface/tower/tower_%d.png",
            tower:getTower():getTowerId()), tower)
        towerNode:setScale(1, 0.9)
        towerNode:setPosition(tower:getX(), tower:getY())
        self:addChild(towerNode)
        self.towerMap_[tower] = towerNode
        local angleMark = ccui.ImageView:create(string.format(
            "artcontent/battle(ongame)/battle_interface/anglemark_grade/%d.png",
            tower:getStar()))
        angleMark:setPosition(82, 87)
        towerNode:addChild(angleMark)
    end)

    --销毁塔
    EventManager:regListener(EventDef.ID.DESTORY_SELF, self, function(tower)
        local node = self.towerMap_[tower]
        node:removeFromParent()
        self.towerMap_[tower] = nil
    end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function FightingLayer:onExit()
    EventManager:unRegListener(EventDef.ID.CREATE_SELF, self)
    EventManager:unRegListener(EventDef.ID.DESTORY_SELF, self)
end

--[[--
    帧循环

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function FightingLayer:update(dt)
    self.spNum_:setString(GameData:getNeedSp())

    for _, node in pairs(self.towerMap_) do
        node:update(dt)
    end
end

return FightingLayer