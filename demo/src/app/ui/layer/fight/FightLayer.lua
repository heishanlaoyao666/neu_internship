--[[--
    背景层
    FightLayer.lua
    编写：李昊
]]
local FightLayer = class("FightLayer", require("app.ui.layer.BaseLayer"))
local EventManager = require("app.manager.EventManager")
local EnemySprite  = require("src.app.ui.node.EnemySprite")
local CardSprite = require("src.app.ui.node.CardSprite")
local EventDef = require("src.app.def.EventDef")
local BulletSprite = require("src.app.ui.node.BulletSprite")
local EnemyLifeSprite = require("src.app.ui.node.EnemyLifeSprite")
local CardStarLevelSprite = require("src.app.ui.node.CardStarLevelSprite")
local BossSprite =  require("src.app.ui.node.BossSprite")
local StateSprite = require("src.app.ui.node.StateSprite")
local HurtSprite = require("src.app.ui.node.HurtSprite")

--[[
    构造函数

    @param none

    @return none
]]
function FightLayer:ctor()
    FightLayer.super.ctor(self)
    self:initView()
    self.enemyMap_ = {}
    self.cardMap_ = {}
    self.hurtMap_ = {}
    self.bulletMap_ = {}
    self.enemyLifeMap_ = {}
    self.cardStarMap_ = {}
    self.bossMap_ = {}
    self.state1Map_ = {}
end

--[[--
    界面初始化
    
    @param none

    @return none
]]
function FightLayer:initView()
end

--[[--
    节点进入

    @param none

    @return none
]]
function FightLayer:onEnter()
    EventManager:regListener(EventDef.ID.ENEMY_CREATE, self, function(enemy)
        local enemyNode = EnemySprite.new("image/fight/fight/little_monster.png", enemy)
        self:addChild(enemyNode)
        self.enemyMap_[enemy] = enemyNode
    end)

    EventManager:regListener(EventDef.ID.ENEMY_DEATH, self, function(enemy)
        local enemyNode = self.enemyMap_[enemy]
        enemyNode:removeFromParent()
        self.enemyMap_[enemy] = nil
    end)

    EventManager:regListener(EventDef.ID.CARD_CREATE, self, function(card)
        local cardNode = CardSprite.new(card:getSmallColorSpriteImg(), card)
        self:addChild(cardNode)
        self.cardMap_[card] = cardNode
    end)

    EventManager:regListener(EventDef.ID.CARD_DEATH, self, function(card)
        local cardNode = self.cardMap_[card]
        cardNode:removeFromParent()
        self.cardMap_[card] = nil
    end)

    EventManager:regListener(EventDef.ID.BULLET_CREATE, self, function(bullet)
        local bulletNode = BulletSprite.new("",bullet)
        self:addChild(bulletNode)
        self.bulletMap_[bullet] = bulletNode
    end)

    EventManager:regListener(EventDef.ID.BULLET_DEATH, self, function(bullet)
        local bulletNode = self.bulletMap_[bullet]
        bulletNode:removeFromParent()
        self.bulletMap_[bullet] = nil
    end)

    EventManager:regListener(EventDef.ID.ENEMY_LIFE_CREATE, self, function(enemy)
        local enemyLife = EnemyLifeSprite.new(enemy)
        self:addChild(enemyLife)
        self.enemyLifeMap_[enemy] = enemyLife
    end)

    EventManager:regListener(EventDef.ID.ENEMY_LIFE_DEATH, self, function(enemy)
        local enemyLife = self.enemyLifeMap_[enemy]
        enemyLife:removeFromParent()
        self.enemyLifeMap_[enemy] = nil
    end)
 
    EventManager:regListener(EventDef.ID.CARD_ENHANCE_LEVEL_CREATE, self, function(card)
        local cardStar = CardStarLevelSprite.new(card)
        self:addChild(cardStar)
        self.cardStarMap_[card] = cardStar 
    end)

    EventManager:regListener(EventDef.ID.CARD_ENHANCE_LEVEL_DEATH, self, function(card)
        local cardStar = self.cardStarMap_[card]
        cardStar :removeFromParent()
        self.cardStarMap_[card] = nil
    end)

    EventManager:regListener(EventDef.ID.BOSS_CREATE, self, function(boss)
        local bossSprite = BossSprite.new(boss)
        self:addChild(bossSprite)
        self.bossMap_[boss] = bossSprite
    end)

    EventManager:regListener(EventDef.ID.BOSS_DEATH, self, function(boss)
        local bossSprite = self.bossMap_[boss]
        bossSprite :removeFromParent()
        self.bossMap_[boss] = nil 
    end)

    EventManager:regListener(EventDef.ID.STATE_CREATE, self, function(enemy)
        local stateSprite = StateSprite.new(enemy)
        self:addChild(stateSprite)
        if  self.state1Map_[enemy] == nil then
        else
            self.state1Map_[enemy]:removeFromParent()
            self.state1Map_[enemy] = nil
        end
        self.state1Map_[enemy] = stateSprite
    end)

    EventManager:regListener(EventDef.ID.STATE_DEATH, self, function(enemy)
        local stateSprite = self.state1Map_[enemy]
        stateSprite :removeFromParent()
        self.state1Map_[enemy] = nil 
    end)

    EventManager:regListener(EventDef.ID.HURT_CREATE, self, function(hurt)
        local hurtSprite = HurtSprite.new(hurt)
        self:addChild(hurtSprite)
        self.hurtMap_[hurt] = hurtSprite
    end)

    EventManager:regListener(EventDef.ID.HURT_DEATH, self, function(hurt)
        local hurtSprite = self.hurtMap_[hurt]
        hurtSprite:removeFromParent()
        self.hurtMap_[hurt] = nil 
    end)

end

--[[--
    节点退出

    @param none

    @return none
]]
function FightLayer:onExit()
    EventManager:unRegListener(EventDef.ID.CREATE_ENEMY, self)
    EventManager:unRegListener(EventDef.ID.ENEMY_DEATH, self)
    EventManager:unRegListener(EventDef.ID.CARD_CREATE, self)
    EventManager:unRegListener(EventDef.ID.CARD_DEATH, self)
    EventManager:unRegListener(EventDef.ID.BULLET_CREATE, self)
    EventManager:unRegListener(EventDef.ID.BULLET_DEATH, self)
    EventManager:unRegListener(EventDef.ID.ENEMY_LIFE_CREATE, self)
    EventManager:unRegListener(EventDef.ID.ENEMY_LIFE_DEATH, self)
    EventManager:unRegListener(EventDef.ID.CARD_ENHANCE_LEVEL_CREATE, self)
    EventManager:unRegListener(EventDef.ID.CARD_ENHANCE_LEVEL_DEATH, self)
    EventManager:unRegListener(EventDef.ID.STATE_CREATE, self)
    EventManager:unRegListener(EventDef.ID.STATE_DEATH, self)
    EventManager:unRegListener(EventDef.ID.HURT_CREATE, self)
    EventManager:unRegListener(EventDef.ID.HURT_DEATH, self)
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔

    @return none
]]
function FightLayer:update(dt)
    for _, node in pairs(self.enemyMap_) do
        node:update(dt)
    end

    for _, node in pairs(self.cardMap_) do
        node:update(dt)
    end

    for _, node in pairs(self.bulletMap_) do
        node:update(dt)
    end

    for _, node in pairs(self.enemyLifeMap_) do
        node:update(dt)
    end

    for _, node in pairs(self.bossMap_) do
        node:update(dt)
    end

    for _, node in pairs(self.state1Map_) do
        node:update(dt)
    end

    for _, node in pairs(self.hurtMap_) do
        node:update(dt)
    end

end

return FightLayer