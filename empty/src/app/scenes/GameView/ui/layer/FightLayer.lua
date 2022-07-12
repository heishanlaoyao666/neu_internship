--[[--
    主战斗层，放战斗元素
    FightLayer.lua
]]
local FightLayer = class("FightLayer", require("app/scenes/GameView/ui/layer/BaseLayer.lua"))
-- local BulletSprite = require("app/ui/node/BulletSprite.lua")
local EnemySprite = require("app/scenes/GameView/ui/node/EnemySprite.lua")
local TowerSprite = require("app/scenes/GameView/ui/node/TowerSprite.lua")
local BulletSprite = require("app/scenes/GameView/ui/node/BulletSprite.lua")
local DamageSprite = require("app/scenes/GameView/ui/node/DamageSprite.lua")
local GameData = require("app/data/GameData.lua")
local ConstDef = require("app.def.ConstDef.lua")
local EventDef = require("app.def.EventDef.lua")
local EventManager = require("app/manager/EventManager.lua")


local moveTower = nil
--[[--
    构造函数

    @param none

    @return none
]]
function FightLayer:ctor()
    FightLayer.super.ctor(self)

    self.bulletMap_ = {} -- 类型：table，Key：bullet， Value：bulletSprite 子弹
    self.towerMap_ = {} -- 类型：table，Key：plane，Value：towerSprite 我方飞机
    self.enemyMap_ = {} -- 类型：table，Key：plane，Value：enemySprite 敌方飞机
    self.damageMap_ ={} --类型: table,Key :damage,Value: damageSprite 伤害数字

    -- -- 加载音效资源
    -- audio.loadFile("sounds/fireEffect.ogg", function() end)
    -- audio.loadFile("sounds/explodeEffect.ogg", function() end)
    -- audio.loadFile("sounds/shipDestroyEffect.ogg", function() end)
    -- audio.loadFile("sounds/bgMusic.ogg", function() 
    --     audio.playBGM("sounds/bgMusic.ogg", true)
    -- end)

    self:initView()
end

--[[--
    节点进入

    @param none

    @return none
]]
function FightLayer:onEnter()
    EventManager:regListener(EventDef.ID.CREATE_DAMAGE, self, function(damage)
        local damageNode = DamageSprite.new(damage)
        self:addChild(damageNode,60,1)
        self.damageMap_[damage] =damageNode
        --audio.playEffect("sounds/fireEffect.ogg", false)
    end)
    EventManager:regListener(EventDef.ID.DESTORY_DAMAGE, self, function(damage)
        local node=self.damageMap_[damage]
        node:removeFromParent()
        self.damageMap_[damage]= nil
    end)

    EventManager:regListener(EventDef.ID.CREATE_BULLET, self, function(bullet)
        local bulletNode = BulletSprite.new(string.format("ui/battle/Battle interface/Bullet/%u.png",bullet:getID()), bullet)
        self:addChild(bulletNode,30,1)
        self.bulletMap_[bullet] = bulletNode

        --audio.playEffect("sounds/fireEffect.ogg", false)
    end)

    EventManager:regListener(EventDef.ID.DESTORY_BULLET, self, function(bullet)
        local node = self.bulletMap_[bullet]
        node:removeFromParent()
        self.bulletMap_[bullet] = nil
    end)

    EventManager:regListener(EventDef.ID.CREATE_ENEMY, self, function(enemy)
        local enemyNode = EnemySprite.new("ui/battle/Battle interface/monster.png", enemy)
        if enemy:getTag()==ConstDef.MONSTER_TAG.PLUS then
            enemyNode:setTexture("ui/battle/Battle interface/monsterPlus.png")
            enemyNode:setLocalZOrder(50)
        elseif enemy:getTag()==ConstDef.MONSTER_TAG.BOSS_1 then
            enemyNode:setTexture("ui/battle/Battle interface/monsterPlus.png")
            enemyNode:setLocalZOrder(50)
        elseif enemy:getTag()==ConstDef.MONSTER_TAG.BOSS_2 then
            enemyNode:setTexture("ui/battle/Battle interface/monsterPlus.png")
            enemyNode:setLocalZOrder(50)
        elseif enemy:getTag()==ConstDef.MONSTER_TAG.BOSS_3 then
            enemyNode:setTexture("ui/battle/Battle interface/monsterPlus.png")
            enemyNode:setLocalZOrder(50)
        elseif enemy:getTag()==ConstDef.MONSTER_TAG.BOSS_4 then
            enemyNode:setTexture("ui/battle/Battle interface/monsterPlus.png")
            enemyNode:setLocalZOrder(50)
        end
        self:addChild(enemyNode)
        self.enemyMap_[enemy] = enemyNode
    end)

    EventManager:regListener(EventDef.ID.DESTORY_ENEMY, self, function(enemy)
        local node = self.enemyMap_[enemy]
        node:removeFromParent()
        self.enemyMap_[enemy] = nil
    end)
    EventManager:regListener(EventDef.ID.CREATE_TOWER, self, function(tower)
        local towerNode = TowerSprite.new(string.format("ui/battle/Battle interface/Tower/tower_%u.png",tower:getID()), tower)
        self:addChild(towerNode)
        self.towerMap_[tower] = towerNode

    end)

    EventManager:regListener(EventDef.ID.DESTORY_TOWER, self, function(tower)
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
function FightLayer:onExit()
    EventManager:unRegListener(EventDef.ID.CREATE_BULLET, self)
    EventManager:unRegListener(EventDef.ID.DESTORY_BULLET, self)
    EventManager:unRegListener(EventDef.ID.CREATE_ENEMY, self)
    EventManager:unRegListener(EventDef.ID.DESTORY_ENEMY, self)
    EventManager:unRegListener(EventDef.ID.CREATE_TOWER, self)
    EventManager:unRegListener(EventDef.ID.DESTORY_TOWER, self)
end

--[[--
    初始化界面

    @param none

    @return none
]]
function FightLayer:initView()
    -- local allies = GameData:getAllies()
    -- for i = 1, #allies do
    --     local plane = PlaneSprite.new("player/red_plane.png", allies[i])
    --     self:addChild(plane)
    --     self.allyMap_[allies[i]] = plane

    --     -- 添加飞机粒子
    --     local particle = cc.ParticleSystemQuad:create("particle/fire.plist")
    --     plane:addChild(particle)
    --     particle:setRotation(180)
    --     particle:setPosition(plane:getContentSize().width * 0.5, 5)

    --     -- 执行初始移动，游戏开始，飞机移动到制定区域
    --     if GameData:getGameState() == ConstDef.GAME_STATE.INIT then
    --         plane:setPosition(display.cx, display.bottom - 30)
    --         plane:runAction(cc.Sequence:create(
    --             cc.MoveTo:create(1, cc.p(display.cx, 200)),
    --             cc.CallFunc:create(function() 
    --                 GameData:initTo(display.cx, 200)
    --                 GameData:setGameState(ConstDef.GAME_STATE.PLAY)
    --             end))
    --         )
    --     end
    -- end

    -- local bullets = GameData:getBullets()
    -- for i = 1, #bullets do
    --     local bullet = BulletSprite.new("player/blue_bullet.png", bullets[i])
    --     self:addChild(bullet)
    --     self.bulletMap_[bullets[i]] = bullet
    -- end

    -- local enemies = GameData:getEnemies()
    -- for i = 1, #enemies do
    --     local plane = PlaneSprite.new("player/small_enemy.png", enemies[i])
    --     self:addChild(plane)
    --     self.enemyMap_[enemies[i]] = plane
    -- end

    
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) 
        if event.name == "began" then
            return self:onTouchBegan(event.x, event.y)
        elseif event.name == "moved" then
            if moveTower then
                self:onTouchMoved(event.x, event.y)
            end
        elseif event.name == "ended" then
            if moveTower then
                self:onTouchEnded(event.x, event.y)
            end
        end
    end)
    self:setTouchEnabled(true)
end

--[[--
    触摸开始

    @param x 类型：number
    @param y 类型：number

    @return boolean
]]
function FightLayer:onTouchBegan(x, y)
    local tower = GameData:isValidTouch(x, y)
    if tower~=false then
        moveTower=self.towerMap_[tower]
        moveTower:setLocalZOrder(50)
        GameData:moveTo(x, y)
        return true
    end

    return false
end

--[[--
    触摸移动

    @param x 类型：number
    @param y 类型：number

    @return none
]]
function FightLayer:onTouchMoved(x, y)
    GameData:moveTo(x, y)
end

--[[--
    触摸结束

    @param x 类型：number
    @param y 类型：number

    @return none
]]
function FightLayer:onTouchEnded(x, y)
    GameData:moveToEnd(x, y)
    moveTower:getParent()
    moveTower:setLocalZOrder(10)
end
--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function FightLayer:update(dt)
    for _, node in pairs(self.bulletMap_) do
        node:update(dt)
    end

    for _, node in pairs(self.towerMap_) do
        node:update(dt)
    end

    for _, node in pairs(self.enemyMap_) do
        node:update(dt)
    end
    for _, node in pairs(self.damageMap_) do
        node:update(dt)
    end
end

return FightLayer