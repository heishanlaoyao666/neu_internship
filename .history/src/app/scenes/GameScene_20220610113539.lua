---require
-- require("AudioEngine")
---
local GameScene =
    class(
    "GameScene",
    function()
        return display.newScene("GameScene")
    end
)
---local
local MyRoleNode = require("app.node.MyRoleNode")
local PauseNode = require("app.node.PauseNode")
local OverNode = require("app.node.OverNode")
local BulletNode = require("app.node.BulletNode")
local EnemyNode = require("app.node.EnemyNode")
---
function GameScene:ctor()
    GameHandler.cleanupView()
    display.addSpriteFrames(ConstantsUtil.PATH_EXPLOSION_PLIST, ConstantsUtil.PATH_EXPLOSION_PNG)
end

function GameScene:init()
    -- "继续游戏"的初始化
    if GameHandler.isContinue == true then
        if GameHandler.PlaneData ~= nil then
            GameHandler.myRole = MyRoleNode:create(ConstantsUtil.ROLE_PURPLE_PLANE, GameHandler.PlaneData)
        end
        for i = 1, #(GameHandler.BulletData) do
            local bullet = BulletNode:create(0, 0, GameHandler.BulletData[i]):addTo(self)
        end
        for i = 1, #(GameHandler.EnmeyData) do
            local enemy = EnemyNode:create(0, 0, GameHandler.EnemyData[i]):addTo(self)
        end
    end
    if GameHandler.myRole == nil then
        GameHandler.myRole = MyRoleNode:create(ConstantsUtil.ROLE_PURPLE_PLANE, nil)
    end
    GameHandler.myRole:addTo(self)
    GameHandler.isPause = false
    GameHandler.isContinue = false
end

function GameScene:onEnter()
    local gameScene =
        CSLoader:createNodeWithFlatBuffersFile("GameScene.csb"):addTo(self, ConstantsUtil.LEVEL_VISIABLE_LOW)

    --- 暂停
    local pauseButton = tolua.cast(ccui.Helper:seekWidgetByName(gameScene, "pause"), "ccui.Button")
    pauseButton:addTouchEventListener(
        function(ref, event)
            if cc.EventCode.BEGAN == event then
                --- 按下
            elseif cc.EventCode.ENDED == event then
                --- 松开
                if GameHandler.isPause == false then
                    --- 当前关闭 点击后开启
                    --
                    GameHandler.isPause = true
                    GameHandler.PlaneData = clone(GameHandler.myRole.dataModel)
                    for i = 1, #(GameHandler.BulletArray) do
                        table.insert(GameHandler.BulletData, GameHandler.BulletArray[i].dataModel)
                    end
                    for i = 1, #(GameHandler.EnemyArray) do
                        table.insert(GameHandler.EnemyData, GameHandler.EnemyArray[i].datamodel)
                    end
                    --
                    local pause = PauseNode:create(ConstantsUtil.COLOR_GREW_TRANSLUCENT, GameHandler.myRole)
                    pause:addTo(self)
                    Director:pause()
                end
            end
        end
    )

    --初始化
    self:init()

    --- 我方飞机
    if GameHandler.isContinue == false then
        GameHandler.myRole:initMove(2, WinSize.width * 0.5, WinSize.height * 0.17)
    end

    --- 生命与分数
    local hp = tolua.cast(ccui.Helper:seekWidgetByName(gameScene, "life"), "ccui.Layout")

    local hp_item =
        ccui.TextBMFont:create(
        TypeConvert.Integer2StringLeadingZero(GameHandler.myRole:getMyHp(), 3),
        ConstantsUtil.PATH_BIG_NUM
    )
    hp:addChild(hp_item)
    hp_item:setScale(0.4)
    hp_item:setAnchorPoint(1, 1)
    hp_item:pos(hp:getContentSize().width * 0, hp:getContentSize().height * 0.5)
    hp_item:setContentSize(0, hp:getContentSize().height)

    local score = tolua.cast(ccui.Helper:seekWidgetByName(gameScene, "score"), "ccui.Layout")
    local score_item =
        ccui.TextBMFont:create(
        TypeConvert.Integer2StringLeadingZero(GameHandler.myRole:getMyScore(), 3),
        ConstantsUtil.PATH_BIG_NUM
    )
    score:addChild(score_item)
    score_item:setScale(0.4)
    score_item:setAnchorPoint(1, 1)
    score_item:pos(score:getContentSize().width * 0, score:getContentSize().height * 0.5)
    score_item:setContentSize(0, score:getContentSize().height)

    -- 子弹
    local function addBullet()
        if effectKey then
            Audio.playEffectSync(ConstantsUtil.PATH_FIRE_EFFECT, false)
        end

        local x, y = GameHandler.myRole:getPosition()
        local bullet = BulletNode:create(x, y):addTo(self)
    end
    addBulletEntry = Scheduler:scheduleScriptFunc(addBullet, ConstantsUtil.INTERVAL_BULLET, false)

    -- 敌军
    local function newEnemy()
        -- body
        local enemy = EnemyNode:create(math.random() * WinSize.width):addTo(self)
    end
    addEnemyEntry = Scheduler:scheduleScriptFunc(newEnemy, ConstantsUtil.INTERVAL_ENEMY, false)

    --- 爆炸动画
    local explosionSprite = display.newSprite("#explosion_01.png")
    self:addChild(explosionSprite, 6)
    local function getExplosion(x, y)
        -- body
        explosionSprite:setPosition(x, y)
        local frames = display.newFrames("explosion_%02d.png", 1, 35)
        local animation = display.newAnimation(frames, ConstantsUtil.SPEED_EXPLOSION)
        local animate = cc.Animate:create(animation)
        explosionSprite:runAction(animate)
    end

    -- 子弹与敌人碰撞
    local function collisionBetweenBUlletAndEnemy()
        local bulletArraySize = #(GameHandler.BulletArray)
        local enemyArraySize = #(GameHandler.EnemyArray)
        for i = 1, bulletArraySize do
            if #(GameHandler.BulletArray) < i then
                break
            end
            for j = 1, enemyArraySize do
                if #(GameHandler.EnemyArray) < j then
                    break
                end
                if GameHandler.EnemyArray[j]:isCollision(GameHandler.BulletArray[i]) then
                    -- sound
                    if effectKey then
                        Audio.playEffectSync(ConstantsUtil.PATH_EXPLOSION_EFFECT, false)
                    end
                    -- score
                    if GameHandler.myRole:getMyScore() < 999 then
                        GameHandler.myRole:setMyScore(GameHandler.myRole:getMyScore() + ConstantsUtil.PLUS_ENEMY_SCORE)
                        score_item:setString(TypeConvert.Integer2StringLeadingZero(GameHandler.myRole:getMyScore(), 3))
                    end
                    -- 爆炸动画
                    getExplosion(GameHandler.EnemyArray[j]:getPositionX(), GameHandler.EnemyArray[j]:getPositionY())
                    -- body
                    GameHandler.BulletArray[i]:removeFromParent()
                    GameHandler.EnemyArray[j]:removeFromParent()
                    table.remove(GameHandler.BulletArray, i)
                    table.remove(GameHandler.EnemyArray, j)
                    i = i - 1
                    j = j - 1
                    bulletArraySize = bulletArraySize - 1
                    enemyArraySize = enemyArraySize - 1
                end
            end
        end
    end
    collisionBetweenBUlletAndEnemyEntry =
        Scheduler:scheduleScriptFunc(collisionBetweenBUlletAndEnemy, ConstantsUtil.INTERVAL_COLLISION, false)

    -- 自己与敌人碰撞
    local function collisionBetweenMyRoleAndEnemy()
        local enemyArraySize = #(GameHandler.EnemyArray)
        for i = 1, enemyArraySize do
            if GameHandler.EnemyArray[i] == nil then
                break
            end
            if GameHandler.EnemyArray[i]:isCollision(GameHandler.myRole) then
                -- sound
                if effectKey then
                    Audio.playEffectSync(ConstantsUtil.PATH_DESTROY_EFFECT, false)
                end
                --- 爆炸动画
                if GameHandler.myRole:getMyHp() - ConstantsUtil.MINUS_ENEMY_COLLISION > 0 then
                    GameHandler.myRole:setMyHp(GameHandler.myRole:getMyHp() - ConstantsUtil.MINUS_ENEMY_COLLISION)
                    hp_item:setString(TypeConvert.Integer2StringLeadingZero(GameHandler.myRole:getMyHp(), 3))
                else
                    -- 寄了
                    --
                    GameHandler.isPause = true
                    --
                    Director:pause()
                    local over = OverNode:create(ConstantsUtil.COLOR_GREW_TRANSLUCENT)
                    over:addTo(self)
                end
                getExplosion(GameHandler.myRole:getPositionX(), GameHandler.myRole:getPositionY())
                --body
                GameHandler.EnemyArray[i]:removeFromParent()
                table.remove(GameHandler.EnemyArray, i)
                i = i - 1
                enemyArraySize = enemyArraySize - 1
            end
        end
    end
    collisionBetweenMyRoleAndEnemyEntry =
        Scheduler:scheduleScriptFunc(collisionBetweenMyRoleAndEnemy, ConstantsUtil.INTERVAL_COLLISION, false)

    -- 背景移动
    local bg0 = tolua.cast(ccui.Helper:seekWidgetByName(gameScene, "background_0"), "cc.Sprite")
    local bg1 = tolua.cast(ccui.Helper:seekWidgetByName(gameScene, "background_1"), "cc.Sprite")
    local bg = {}
    bg[0] = bg0
    bg[1] = bg1
    local nowBg = 0

    local function backgroundMove()
        bg[nowBg]:setPositionY(bg[nowBg]:getPositionY() - ConstantsUtil.SPEED_BG_MOVE)
        bg[(nowBg + 1) % 2]:setPositionY(bg[nowBg]:getPositionY() + WinSize.height - ConstantsUtil.SPEED_BG_MOVE) --- 吐槽 为什么连异或操作都没有 裂开
        if bg[(nowBg + 1) % 2]:getPositionY() == WinSize.height / 2 then
            bg[nowBg]:setPositionY(WinSize.height * 1.5)
            nowBg = (nowBg + 1) % 2
        end
    end
    backgroundEntry = Scheduler:scheduleScriptFunc(backgroundMove, ConstantsUtil.INTERVAL_BACKGROUND_MOVE, false)

    -- 重新设置continue
    if GameHandler.isContinue == true then
        GameHandler.isContinue = false
    end
end

function GameScene:destroy()
    Scheduler:unscheduleScriptEntry(backgroundEntry)
    Scheduler:unscheduleScriptEntry(addBulletEntry)
    Scheduler:unscheduleScriptEntry(addEnemyEntry)
    Scheduler:unscheduleScriptEntry(collisionBetweenBUlletAndEnemyEntry)
    Scheduler:unscheduleScriptEntry(collisionBetweenMyRoleAndEnemyEntry)
end

-- 好像不可以这么用
function GameScene:myRemove()
    for i = 1, #(GameHandler.BulletArray) do
        if GameHandler.BulletArray[i] == nil then
            table.remove(GameHandler.BulletArray, i)
            i = i - 1
        end
        GameHandler.BulletArray[i]:removeFromParentAndCleanup(false)
    end
    for i = 1, #(GameHandler.EnemyArray) do
        if GameHandler.EnemyArray[i] == nil then
            table.remove(GameHandler.EnemyArray, i)
            i = i - 1
        end
        GameHandler.EnemyArray[i]:removeFromParentAndCleanup(false)
    end
    GameHandler.myRole:removeFromParentAndCleanup(false)
end

-- 看了一下源代码 如果调用了Director的replaceScene
-- 那么会先调用onExit 再调用cleanup 所以可以先在这里处理一下子弹、敌人和飞机
function GameScene:onExit()
    self:destroy()
    GameHandler.cleanupView()
    -- self:myRemove()
end

return GameScene
