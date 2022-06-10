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
local myRoleNode = require("app.node.MyRoleNode")
local pauseNode = require("app.node.PauseNode")
---
function GameScene:ctor()
    self.myRoleWithTail = nil -- 飞机
    self.gameScene = nil -- scene
    self.pauseButton = nil -- 暂停按钮
    ConstantsUtil.puase = false
    display.addSpriteFrames(ConstantsUtil.PATH_EXPLOSION_PLIST, ConstantsUtil.PATH_EXPLOSION_PNG)
end

function GameScene:onEnter()
    self.gameScene =
        CSLoader:createNodeWithFlatBuffersFile("GameScene.csb"):addTo(self, ConstantsUtil.LEVEL_VISIABLE_LOW)

    --- 暂停
    self.pauseButton = tolua.cast(ccui.Helper:seekWidgetByName(self.gameScene, "pause"), "ccui.Button")
    self.pauseButton:addTouchEventListener(
        function(ref, event)
            Log.i("pauseButton")
            if cc.EventCode.BEGAN == event then
                --- 按下
            elseif cc.EventCode.ENDED == event then
                --- 松开
                if ConstantsUtil.puase == false then
                    --- 当前关闭 点击后开启
                    ConstantsUtil.puase = true
                    local pause = pauseNode:create(ConstantsUtil.COLOR_GREW_TRANSLUCENT)
                    pause:addTo(self)
                    Director:pause()
                end
            end
        end
    )

    --- 生命与分数
    local hp_val = ConstantsUtil.DEFAULT_HP
    local hp = tolua.cast(ccui.Helper:seekWidgetByName(self.gameScene, "life"), "ccui.Layout")

    local hp_item = ccui.TextBMFont:create(TypeConvert.Integer2StringLeadingZero(hp_val, 3), ConstantsUtil.PATH_BIG_NUM)
    hp:addChild(hp_item)
    hp_item:setScale(0.4)
    hp_item:setAnchorPoint(1, 1)
    hp_item:pos(hp:getContentSize().width * 0, hp:getContentSize().height * 0.5)
    hp_item:setContentSize(0, hp:getContentSize().height)

    local score_val = ConstantsUtil.DEFAULT_SCORE
    local score = tolua.cast(ccui.Helper:seekWidgetByName(self.gameScene, "score"), "ccui.Layout")
    local score_item =
        ccui.TextBMFont:create(TypeConvert.Integer2StringLeadingZero(score_val, 3), ConstantsUtil.PATH_BIG_NUM)
    score:addChild(score_item)
    score_item:setScale(0.4)
    score_item:setAnchorPoint(1, 1)
    score_item:pos(score:getContentSize().width * 0, score:getContentSize().height * 0.5)
    score_item:setContentSize(0, score:getContentSize().height)

    --- 背景移动
    local bg0 = tolua.cast(ccui.Helper:seekWidgetByName(self.gameScene, "background_0"), "cc.Sprite")
    local bg1 = tolua.cast(ccui.Helper:seekWidgetByName(self.gameScene, "background_1"), "cc.Sprite")
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

    --- 我方飞机相关
    self.myRoleWithTail =
        myRoleNode:create(ConstantsUtil.ROLE_PURPLE_PLANE, 2, WinSize.width * 0.5, WinSize.height * 0.17):addTo(
        self,
        ConstantsUtil.LEVEL_VISIABLE_MEDIUM
    )
    local target = self.myRoleWithTail:getChildren()
    for i = 1, #(target) do
        Log.i(target[i]:getName())
    end
    local myRole = tolua.cast(self.myRoleWithTail:getChildByName(ConstantsUtil.TAG_MY_ROLE), "cc.Sprite")
    Log.i(myRole:getName())

    -- local myRole = tolua.cast(ccui.Helper:seekWidgetByName(self.gameScene, "my_role"), "cc.Sprite")
    -- -- myRole:setScale(1.5)
    -- myRole:setTag(ConstantsUtil.TAG_MY_ROLE)
    -- local myFireBloom = tolua.cast(ccui.Helper:seekWidgetByName(self.gameScene, "role_fire"), "cc.ParticleSystemQuad")
    -- -- myFireBloom:setScale(1.5)

    -- --- 我方飞机登场
    -- myRole:runAction(roleShowUp)
    -- local fireShowUp =
    --     cc.MoveTo:create(2, cc.p(WinSize.width * 0.5, WinSize.height * 0.17 - myRole:getContentSize().height / 2))
    -- myFireBloom:runAction(fireShowUp)

    -- --- 单点触摸移动
    -- local function onTouchBegan(touch, event)
    --     Log.i("touch begin")
    --     return true
    -- end
    -- local function onTouchEnded(touch, event)
    --     Log.i("touch end")
    -- end
    -- local function onTouchMoved(touch, event)
    --     local target = event:getCurrentTarget() --获取当前的控件
    --     local posX, posY = target:getPosition() --获取当前的位置
    --     local delta = touch:getDelta() --获取滑动的距离
    --     target:setPosition(cc.p(posX + delta.x, posY + delta.y)) --给精灵重新设置位置
    --     --- 火焰也需要重新设置位置
    --     myFireBloom:setPosition(cc.p(posX + delta.x, posY + delta.y - target:getContentSize().height / 2))
    -- end

    -- --- 事件分发器
    -- local eventDispatcher = self:getEventDispatcher()
    -- local listener1 = cc.EventListenerTouchOneByOne:create() --创建一个单点事件监听
    -- listener1:setSwallowTouches(false) --是否向下传递
    -- listener1:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    -- listener1:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    -- listener1:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    -- eventDispatcher:addEventListenerWithSceneGraphPriority(listener1, myRole) --分发监听事件

    --- 子弹发射
    local bulletArray = {}
    local function addBullet()
        if effectKey then
            Audio.playEffectSync(ConstantsUtil.PATH_FIRE_EFFECT, false)
        end

        local x, y = myRole:getPosition()
        local bullet = cc.Sprite:create(ConstantsUtil.PATH_BULLET_PNG)
        bullet:setTag(ConstantsUtil.TAG_BULLET)
        local bulletPosition = cc.p(x, y + myRole:getContentSize().height / 2 + bullet:getContentSize().height / 2)
        bullet:setPosition(bulletPosition)
        bullet:addTo(self)

        local function bulletMove()
            local bulletY = bullet:getPositionY() + ConstantsUtil.SPEED_BULLET_MOVE
            bullet:setPositionY(bulletY)
            if bulletY > WinSize.height then
                bullet:removeFromParent()
                table.removebyvalue(bulletArray, bullet, false)
            end
        end
        -- 每帧刷新一次
        bullet:scheduleUpdateWithPriorityLua(bulletMove, 0)
        table.insert(bulletArray, bullet)
    end
    addBulletEntry = Scheduler:scheduleScriptFunc(addBullet, ConstantsUtil.INTERVAL_BULLET, false)

    --- 敌军
    local enemyArray = {}
    local function newEnemy()
        -- body
        local enemyX = math.random() * WinSize.width
        local enemyY = ConstantsUtil.BORN_PLACE_ENEMY * WinSize.height
        local enemy = cc.Sprite:create(ConstantsUtil.PATH_SMALL_ENEMY_PNG)
        -- enemy:setScale(1.5)
        enemy:setTag(ConstantsUtil.TAG_ENEMY)
        enemy:setPosition(enemyX, enemyY)
        enemy:addTo(self)

        local function enemyMove()
            local newEnemyY = enemy:getPositionY() - ConstantsUtil.SPEED_ENEMY_MOVE
            enemy:setPositionY(newEnemyY)
            if newEnemyY <= ConstantsUtil.DIE_PLACE_ENEMY then
                enemy:removeFromParent()
                table.removebyvalue(enemyArray, enemy, false)
            end
        end
        enemy:scheduleUpdateWithPriorityLua(enemyMove, 0)
        table.insert(enemyArray, enemy)
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

    --- 子弹与敌人碰撞
    local function collisionBetweenBUlletAndEnemy()
        local bulletArraySize = #(bulletArray)
        local enemyArraySize = #(enemyArray)
        for i = 1, bulletArraySize do
            if #(bulletArray) < i then
                break
            end
            local rectA = bulletArray[i]:getBoundingBox()
            for j = 1, enemyArraySize do
                if #(enemyArray) < j then
                    break
                end
                local rectB = enemyArray[j]:getBoundingBox()
                if
                    math.abs(bulletArray[i]:getPositionX() - enemyArray[j]:getPositionX()) * 2 <=
                        (rectA.width + rectB.width) and
                        (math.abs(bulletArray[i]:getPositionY() - enemyArray[j]:getPositionY()) * 2) <=
                            (rectA.height + rectB.height)
                 then
                    -- 爆炸
                    --sound
                    if effectKey then
                        Audio.playEffectSync(ConstantsUtil.PATH_EXPLOSION_EFFECT, false)
                    end
                    -- score
                    if score_val < 999 then
                        score_val = score_val + ConstantsUtil.PLUS_ENEMY_SCORE
                        score_item:setString(TypeConvert.Integer2StringLeadingZero(score_val, 3))
                    end
                    -- 爆炸动画
                    getExplosion(enemyArray[j]:getPositionX(), enemyArray[j]:getPositionY())
                    -- body
                    bulletArray[i]:removeFromParent()
                    enemyArray[j]:removeFromParent()
                    table.remove(bulletArray, i)
                    table.remove(enemyArray, j)
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

    -- 敌人与自己碰撞
    local function collisionBetweenMyRoleAndEnemy()
        local enemyArraySize = #(enemyArray)
        local rectMyRole = myRole:getBoundingBox()
        for i = 1, enemyArraySize do
            if #(enemyArray) < i then
                break
            end
            local rect = enemyArray[i]:getBoundingBox()
            if
                math.abs((enemyArray[i]:getPositionX() - myRole:getPositionX())) * 2 <= (rect.width + rectMyRole.width) and
                    math.abs(enemyArray[i]:getPositionY() - myRole:getPositionY()) * 2 <=
                        (rect.height + rectMyRole.height)
             then
                -- sound
                if effectKey then
                    Audio.playEffectSync(ConstantsUtil.PATH_DESTROY_EFFECT, false)
                end
                --- 爆炸动画
                if hp_val - ConstantsUtil.MINUS_ENEMY_COLLISION > 0 then
                    hp_val = hp_val - ConstantsUtil.MINUS_ENEMY_COLLISION
                    hp_item:setString(TypeConvert.Integer2StringLeadingZero(hp_val, 3))
                end
                getExplosion(myRole:getPositionX(), myRole:getPositionY())
                --body
                enemyArray[i]:removeFromParent()
                table.remove(enemyArray, i)
                i = i - 1
                enemyArraySize = enemyArraySize - 1
            end
        end
    end
    collisionBetweenMyRoleAndEnemyEntry =
        Scheduler:scheduleScriptFunc(collisionBetweenMyRoleAndEnemy, ConstantsUtil.INTERVAL_COLLISION, false)
end

function GameScene:onExit()
    Scheduler:unscheduleScriptEntry(backgroundEntry)
    Scheduler:unscheduleScriptEntry(addBulletEntry)
    Scheduler:unscheduleScriptEntry(addEnemyEntry)
    Scheduler:unscheduleScriptEntry(collisionBetweenBUlletAndEnemyEntry)
    Scheduler:unscheduleScriptEntry(collisionBetweenMyRoleAndEnemyEntry)
end

return GameScene
