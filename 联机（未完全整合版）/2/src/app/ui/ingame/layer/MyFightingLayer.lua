--[[--
    我的战斗层
    MyFightingLayer.lua
]]
local MyFightingLayer = class("MyFightingLayer", require("app.ui.ingame.layer.BaseLayer"))

local GameData = require("app.data.ingame.GameData")
local TowerSprite = require("app.ui.ingame.node.TowerSprite")
local MonsterSprite = require("app.ui.ingame.node.MonsterSprite")
local BulletSprite = require("app.ui.ingame.node.BulletSprite")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

local touchTower = nil

--角标映射
local angelMark = {
    "artcontent/battle(ongame)/battle_interface/angelmark_towertype/towertype_tapping.png",
    "artcontent/battle(ongame)/battle_interface/angelmark_towertype/towertype_disturbance.png",
    "artcontent/battle(ongame)/battle_interface/angelmark_towertype/towertype_sup.png",
    "artcontent/battle(ongame)/battle_interface/angelmark_towertype/towertype_control.png"
}

function MyFightingLayer:ctor()
    MyFightingLayer.super.ctor(self)

    self.spNum_ = nil -- 生成所需sp

    self.bulletMap_ = {} -- 子弹
    self.towerMap_ = {} -- 塔
    self.towerStarMap_ = {} -- 塔的等级角标
    self.monsterMap_ = {} -- 小怪
    self.eliteMonsterMap_ = {} -- 精英怪
    self.bossMap_ = {} -- boss
    self.lineup_ = {} -- 我的阵容
    self.enhanceNeedSp_ = {} -- 强化所需sp

    self:init()
    self:myInitView()
end
--[[--
    用于制作测试数据

    @parm none

    @return none
]]
function MyFightingLayer:init()
    self.lineup_ = GameData:getMyTowers()
end

--[[--
    我方阵营

    @parm none

    @return none
]]
function MyFightingLayer:myInitView()
    local index_x = 120
    for i = 1, #self.lineup_ do
        --头像
        local spriteRes = "artcontent/battle(ongame)/battle_interface/tower/tower_%d.png"
        local sprite =  string.format(spriteRes, self.lineup_[i]:getTowerId())
        local towerBtn = ccui.Button:create(sprite)
        towerBtn:setPosition(index_x, 120)
        towerBtn:addTouchEventListener(function(sender, eventType)
            if eventType == 2 then
                GameData:enhance(i)
                audio.playEffect("sounds/ui_btn_click.OGG")
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
            GameData:createMyTower()
            audio.playEffect("sounds/ui_btn_click.OGG")
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
function MyFightingLayer:onTouchBegan(x, y, tower)
    if y > 720 then
        return false
    end
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
function MyFightingLayer:onTouchMoved(x, y, tower)
    GameData:moveTo(x, y, tower)
end

--[[--
    触摸结束

    @param x 类型：number
    @param y 类型：number
    @parm tower 类型：fightingTower

    @return none
]]
function MyFightingLayer:onTouchEnded(x, y, tower1)
    local tower2 = GameData:getFightingTowerByIndex(x, y, tower1)
    if tower1:getStar() >= 7 or tower2 == nil or tower1:getStar() ~= tower2:getStar() then
        local index = GameData:getTowerIndex(tower1)
        local index_x, index_y = index[1], index[2]
        GameData:moveTo(index_x, index_y, tower1)
    else
        GameData:mergingFightingTower(tower1, tower2, 1)
        audio.playEffect("sounds/tower_compose.OGG")
    end
    touchTower = nil
end

--[[--
    节点进入

    @param none

    @return none
]]
function MyFightingLayer:onEnter()
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
        local angleMark = ccui.ImageView:create(sprite)
        angleMark:setPosition(82, 87)
        self.towerStarMap_[tower] = angleMark
        node:addChild(angleMark)
        audio.playEffect("sounds/tower_build.OGG")
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
        node:setScale(2)
        self:addChild(node)
        self.bulletMap_[bullet] = node
        audio.playEffect("sounds/tower_atk.OGG")
    end)

    --销毁子弹
    EventManager:regListener(EventDef.ID.DESTORY_BULLET, self, function(bullet)
        local node = self.bulletMap_[bullet]
        node:removeFromParent()
        self.bulletMap_[bullet] = nil
        audio.playEffect("sounds/tower_atk_hit.OGG")
    end)

    --创建boss
    EventManager:regListener(EventDef.ID.CREATE_BOSS, self, function(boss)
        local spriteRes = "artcontent/battle(ongame)/randomboss_popup/boss_%d.png"
        local sprite = string.format(spriteRes, boss:getId())
        local node = MonsterSprite.new(sprite, boss)
        node:setPosition(boss:getX(), boss:getY())
        node:setScale(0.7)
        self:addChild(node)
        self.bossMap_[boss] = node
    end)

    --销毁boss
    EventManager:regListener(EventDef.ID.DESTORY_BOSS, self, function(boss)
        local node = self.bossMap_[boss]
        node:removeFromParent()
        self.bossMap_[boss] = nil
    end)

    --更新角标
    EventManager:regListener(EventDef.ID.UPDATE_STAR, self, function(tower)
        local spriteRes = "artcontent/battle(ongame)/battle_interface/anglemark_grade/%d.png"
        local sprite = string.format(spriteRes, tower:getStar())
        local node = self.towerStarMap_[tower]
        node:loadTexture(sprite)
    end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function MyFightingLayer:onExit()
    EventManager:unRegListener(EventDef.ID.CREATE_SELF, self)
    EventManager:unRegListener(EventDef.ID.DESTORY_SELF, self)
    EventManager:unRegListener(EventDef.ID.CREATE_MONSTER, self)
    EventManager:unRegListener(EventDef.ID.DESTORY_MONSTER, self)
    EventManager:unRegListener(EventDef.ID.CREATE_ELITE_MONSTER, self)
    EventManager:unRegListener(EventDef.ID.DESTORY_ELITE_MONSTER, self)
    EventManager:unRegListener(EventDef.ID.CREATE_BULLET, self)
    EventManager:unRegListener(EventDef.ID.DESTORY_BULLET, self)
    EventManager:unRegListener(EventDef.ID.CREATE_BOSS, self)
    EventManager:unRegListener(EventDef.ID.DESTORY_BOSS, self)
    EventManager:unRegListener(EventDef.ID.UPDATE_STAR, self)
end

--[[--
    帧循环

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function MyFightingLayer:update(dt)
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

    --刷新boss
    for _, node in pairs(self.bossMap_) do
        node:update(dt)
    end

    --刷新塔需要的sp
    local needSp = GameData:getEnhanceNeedSp()
    for i = 1, #self.enhanceNeedSp_ do
        self.enhanceNeedSp_[i]:setString(tostring(needSp[i]))
    end
end

return MyFightingLayer