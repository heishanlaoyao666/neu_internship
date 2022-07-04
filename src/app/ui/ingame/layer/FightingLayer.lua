--[[--
    战斗层
    FightingLayer.lua
]]
local FightingLayer = class("FightingLayer", require("app.ui.ingame.layer.BaseLayer"))

local GameData = require("app.data.ingame.GameData")
local TowerSprite = require("app.ui.ingame.node.TowerSprite")
local MonsterSprite = require("app.ui.ingame.node.MonsterSprite")
local BulletSprite = require("app.ui.ingame.node.BulletSprite")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

local touchTower = nil

function FightingLayer:ctor()
    FightingLayer.super.ctor(self)

    GameData:init()

    self.spNum_ = nil -- 生成所需sp

    self.bulletMap_ = {} -- 子弹
    self.towerMap_ = {} -- 塔
    self.monsterMap_ = {} -- 小怪
    self.eliteMonsterMap_ = {} -- 精英怪
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
        local spriteRes = "artcontent/battle(ongame)/battle_interface/tower/tower_%d.png"
        local sprite =  string.format(spriteRes, self.lineup_[i]:getTowerId())
        local towerBtn = ccui.Button:create(sprite)
        towerBtn:setPosition(index_x, 120)
        towerBtn:addTouchEventListener(function(sender, eventType)
            if eventType == 2 then
                print(self.lineup_[i]:getTowerId())
            end
        end)
        towerBtn:addTo(self)

        --等级
        spriteRes = "artcontent/battle(ongame)/battle_interface/grade/LV.%d.png"
        sprite = string.format(spriteRes, self.lineup_[i]:getLevel())
        local levelSprite = cc.Sprite:create(sprite)
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
    local tower2 = GameData:getFightingTowerByIndex(x, y, tower1)
    if tower1:getStar() >= 7 or tower2 == nil or tower1:getStar() ~= tower2:getStar() then
        local index = GameData:getTowerIndex(tower1)
        local index_x, index_y = index[1], index[2]
        GameData:moveTo(index_x, index_y, tower1)
    else
        GameData:mergingFightingTower(tower1, tower2)
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
        --塔
        local spriteRes = "artcontent/battle(ongame)/battle_interface/tower/tower_%d.png"
        local sprite = string.format(spriteRes, tower:getTower():getTowerId())
        local node = TowerSprite.new(sprite, tower)
        node:setScale(1, 0.9)
        node:setPosition(tower:getX(), tower:getY())
        self:addChild(node)
        self.towerMap_[tower] = node
        --角标
        spriteRes = "artcontent/battle(ongame)/battle_interface/anglemark_grade/%d.png"
        sprite = string.format(spriteRes, tower:getStar())
        local angleMark = cc.Sprite:create(sprite)
        angleMark:setPosition(82, 87)
        node:addChild(angleMark)
    end)

    --销毁塔
    EventManager:regListener(EventDef.ID.DESTORY_SELF, self, function(tower)
        local node = self.towerMap_[tower]
        node:removeFromParent()
        self.towerMap_[tower] = nil
    end)

    --创建小怪
    EventManager:regListener(EventDef.ID.CREATE_MONSTER, self, function(monster)
        local sprite = "artcontent/battle(ongame)/battle_interface/littlemmonster.png"
        local node = MonsterSprite.new(sprite, monster)
        node:setPosition(monster:getX(), monster:getY())
        self:addChild(node)
        self.monsterMap_[monster] = node
    end)

    --销毁小怪
    EventManager:regListener(EventDef.ID.DESTORY_MONSTER, self, function(monster)
        local node = self.monsterMap_[monster]
        node:removeFromParent()
        self.monsterMap_[monster] = nil
    end)

    --创建精英怪
    EventManager:regListener(EventDef.ID.CREATE_ELITE_MONSTER, self, function(eliteMonster)
        local sprite = "artcontent/battle(ongame)/battle_interface/elitemonster.png"
        local node = MonsterSprite.new(sprite, eliteMonster)
        node:setPosition(eliteMonster:getX(), eliteMonster:getY())
        self:addChild(node)
        self.eliteMonsterMap_[eliteMonster] = node
    end)

    --销毁精英怪
    EventManager:regListener(EventDef.ID.DESTORY_ELITE_MONSTER, self, function(elliteMonster)
        local node = self.eliteMonsterMap_[elliteMonster]
        node:removeFromParent()
        self.eliteMonsterMap_[elliteMonster] = nil
    end)

    --创建子弹
    EventManager:regListener(EventDef.ID.CREATE_BULLET, self, function(bullet)
        local spriteRes = "artcontent/battle(ongame)/battle_interface/bullet/%d.png"
        local sprite = string.format(spriteRes, bullet:getId())
        local node = BulletSprite.new(sprite, bullet)
        self:addChild(node)
        self.bulletMap_[bullet] = node
    end)

    --销毁子弹
    EventManager:regListener(EventDef.ID.DESTORY_BULLET, self, function(bullet)
        local node = self.bulletMap_[bullet]
        node:removeFromParent()
        self.bulletMap_[bullet] = nil
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
    EventManager:unRegListener(EventDef.ID.CREATE_MONSTER, self)
    EventManager:unRegListener(EventDef.ID.DESTORY_MONSTER, self)
    EventManager:unRegListener(EventDef.ID.CREATE_ELITE_MONSTER, self)
    EventManager:unRegListener(EventDef.ID.DESTORY_ELITE_MONSTER, self)
    EventManager:unRegListener(EventDef.ID.CREATE_BULLET, self)
    EventManager:unRegListener(EventDef.ID.DESTORY_BULLET, self)
end

--[[--
    帧循环

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function FightingLayer:update(dt)
    self.spNum_:setString(GameData:getNeedSp())

    --刷新塔
    for _, node in pairs(self.towerMap_) do
        node:update(dt)
    end

    --刷新小怪
    for _, node in pairs(self.monsterMap_) do
        node:update(dt)
    end

    --刷新精英怪
    for _, node in pairs(self.eliteMonsterMap_) do
        node:update(dt)
    end

    --刷新子弹
    for _, node in pairs(self.bulletMap_) do
        node:update(dt)
    end
end

return FightingLayer