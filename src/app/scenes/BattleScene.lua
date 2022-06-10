local BattleScene = class("BattleScene", function ()
    return display.newScene("BattleScene")
end)

--[[--
    构造函数
    @param none
    @return none
]]
function BattleScene:ctor()
    self.life_ = 100         -- 生命值
    self.score_ = 0          -- 得分
    self.spritePlayer_ = nil         --玩家飞机
    self.xCurPlayer_ = display.width/2       --玩家移动当前位置
    self.yCurPlayer_ = display.cy - 250

    self.addBulletEntry_ = nil       --子弹发射计时器控制
    self.tickCollision_ = nil       --飞机碰撞检测计时器
    self.addEnemy_ = nil        --敌人刷新计时器
    self.tickTxt = nil          --文字刷新计时器

    self.audio_ = require("framework.audio")     --音乐播放
    self.isStop_ = false         --判断游戏暂停
    self.bullet_ = {}            --存放子弹
    self.enemy_ = {}             --存放所有生成的敌机
    self:createLayer()
end

function BattleScene:create()
    local scene = BattleScene.new()
    return scene
end

--[[
    单个炮弹生成及发射
]]
function BattleScene:createBullet()
    -- 每个炮弹创建单独的一个层
    local bulletLayer = ccui.Layout:create()

    -- 飞机炮弹显示
    local bulletSprite = cc.Sprite:create("player/blue_bullet.png")
    bulletSprite:setPosition(display.width/2, display.cy - 250)
    bulletSprite:setAnchorPoint(0.5, 0)

    print("x,y bullet:", self.xCurPlayer_, self.yCurPlayer_)
    bulletSprite:setPosition(self.xCurPlayer_, self.yCurPlayer_)       --飞机炮弹发射位置

    if self.isStop_ == false then
        bulletLayer:addTo(self)
        bulletSprite:addTo(bulletLayer)
        table.insert(self.bullet_, bulletSprite)
    end
    -- 炮弹发射
    bulletSprite:scheduleUpdateWithPriorityLua(function (dt)
        self:removeBullet()
        if self.isStop_ == false then
            -- body
            local x = bulletSprite:getPositionX()
            local y = bulletSprite:getPositionY() + 15
            --print("子弹y：", y)
            bulletSprite:setPosition(x, y)
        end
    end, 0)
end

--删除超出屏幕的子弹
function BattleScene:removeBullet()
    for i,b in ipairs(self.bullet_) do
        local bullet = self.bullet_[i]
        local x,y = bullet:getPosition()
        if y > display.height then
            bullet:removeFromParent()
            table.remove(self.bullet_, i)
        end
    end
end


--[[
    炮弹连续发射
]]
function BattleScene:fireContinue()
    -- 飞机炮弹连射
    self.addBulletEntry_ = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function (dt)
        self:createBullet()
        local audio = require("framework.audio")
        audio.loadFile("sounds/fireEffect.ogg",function ()
            audio.playEffect("sounds/fireEffect.ogg",false)
        end)
    end, 0.2, false)
end

--[[
    炮弹停止发射
]]
function BattleScene:stopFire()
    print("Stop Fire")
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.addBulletEntry_)
end

--[[
    单个敌机生成
]]
function BattleScene:createEnemy()
    -- 每个敌机创建单独的一个层
    local enemyLayer = ccui.Layout:create()

    local enemySprite = cc.Sprite:create("player/small_enemy.png")
    enemySprite:setPosition(math.random(25, display.width-25), display.height+5)
    --enemySprite:setPosition(display.width/2, display.height+5)
    enemySprite:setAnchorPoint(0.5, 0.5)

    self.indexInAllEnemy = 0    --当前敌机在表中的编号

    if self.isStop_ == false then
        enemyLayer:addTo(self)
        enemySprite:addTo(enemyLayer)
        table.insert(self.enemy_, enemySprite)

        for i,e in ipairs(self.enemy_) do
            print("加入敌机", i, e)
        end
    end
        --local curX = backgroundSprite:getPositionX()
    --local moveAction = cc.MoveTo:create(1, cc.p(curX, display.height-150))  -- 参数1：动作持续的时间(float)  参数2：终点位置
    --backgroundSprite:runAction(moveAction)
    -- 敌机运动
    enemySprite:scheduleUpdateWithPriorityLua(function (dt)
        self:removeEnemy()
        if self.isStop_ == false then
            local x = enemySprite:getPositionX()
            local y = enemySprite:getPositionY() - 10
            enemySprite:setPosition(x, y)
        end
    end, 0)
end

--删除超出屏幕的敌机
function BattleScene:removeEnemy()
    for i,e in ipairs(self.enemy_) do
        local enemy = self.enemy_[i]
        local x,y = enemy:getPosition()
        if y < -enemy:getContentSize().height/2 then
            enemy:removeFromParent()
            table.remove(self.enemy_, i)
        end
    end
end

--[[
    敌机连续生成
]]
function BattleScene:EnemyRefresh()
    self.addEnemy_ = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function (dt)
        self:createEnemy()
    end, 1, false)
end

--[[
    敌机停止生成
]]
function BattleScene:stopEnemyRefresh()
    print("Stop Enemy Refresh")
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.addEnemy_)
end


--[[
    创建层
]]
function BattleScene:createLayer()
    -- 动画加载
    self:loadBoomAnimation()

    -- 音乐默认播放
    self.audio_.loadFile("sounds/bgMusic.ogg",function ()
        self.audio_.playBGM("sounds/bgMusic.ogg",true)
    end)

    --面板设置
    local battleLayer = ccui.Layout:create()         --创建层
    battleLayer:setBackGroundImage("ui/main/bg_menu.jpg")
    battleLayer:setBackGroundColor(cc.c3b(100,50,100))
    battleLayer:setBackGroundColorType(1)
    battleLayer:setContentSize(display.width,display.height)
    battleLayer:setPosition(display.width/2, display.top/2)
    battleLayer:setAnchorPoint(0.5, 0.5)             --设置锚点
    battleLayer:addTo(self)

    -------------------------------------------------------------------
    -- 背景显示区
    local backSprite1 = cc.Sprite:create("img_bg/img_bg_1.jpg")
    backSprite1:setAnchorPoint(0, 0)
    backSprite1:setPosition(0, 0)
    backSprite1:addTo(battleLayer)

    backSprite1:scheduleUpdateWithPriorityLua(function (dt)
        if self.isStop_ == false then
            local x = backSprite1:getPositionX()
            local y = backSprite1:getPositionY() - 5
            if y <= -1280 then
                y = 0
                backSprite1:setPosition(x, y)
            else
                backSprite1:setPosition(x, y)
            end
        end
    end, 0)

    local backSprite2 = cc.Sprite:create("img_bg/img_bg_1.jpg")
    backSprite2:setAnchorPoint(0, 0)
    backSprite2:setPosition(0, 1280)
    backSprite2:addTo(battleLayer)

    backSprite2:scheduleUpdateWithPriorityLua(function (dt)
        if self.isStop_ == false then
            local x = backSprite2:getPositionX()
            local y = backSprite2:getPositionY() - 5
            if y <= 0 then
                y = 1280
                backSprite2:setPosition(x, y)
            else
                backSprite2:setPosition(x, y)
            end
        end
    end, 0)


    -- 暂停按钮
    local buttonStop = ccui.Button:create("ui/battle/uiPause.png")
    buttonStop:setAnchorPoint(0, 1)
    buttonStop:setScale9Enabled(true)        --九宫格
    buttonStop:pos(10, display.height-20)
    buttonStop:addTo(battleLayer)
    -- 按钮点击事件
    buttonStop:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            --director:popScene()
            self:createStopLayer()
            self.isStop_ = true
            print("isStop:", self.isStop_)
            self:stopFire()
            self:stopEnemyRefresh()
            self.audio_:pauseAll()       --音乐暂停
            self:Collision(false)
            --cc.Director:sharedDirector():pause()
        end
    end)

    -- game over按钮（临时测试）
    local buttonGameOver = ccui.Button:create()
    buttonGameOver:setTitleText("游戏结束")
    buttonGameOver:setTitleFontSize(25)
    buttonGameOver:setAnchorPoint(0, 1)
    buttonGameOver:setScale9Enabled(true)        --九宫格
    buttonGameOver:pos(10, 200)
    buttonGameOver:addTo(battleLayer)
    -- 按钮点击事件
    buttonGameOver:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            --director:popScene()
            self:createGameOverLayer()
            self.isStop_ = true
            print("isStop:", self.isStop_)
            self:stopFire()
            self:stopEnemyRefresh()
            self.audio_:stopAll()       --音乐停止
            self:Collision(false)
        end
    end)

    ------------------------------------------------------------------
    -- 分数显示区
    -- 生命标志图片
    local spriteLife = cc.Sprite:create("ui/battle/ui_life.png")
    spriteLife:setPosition(display.width/3, display.height - 30)
    spriteLife:setAnchorPoint(0, 1)
    spriteLife:addTo(self)

    local lifeTxt = ccui.TextBMFont:create(self.life_, "islandcvbignum.fnt")
    lifeTxt:setScale(0.25)
    lifeTxt:addTo(battleLayer)
    lifeTxt:setAnchorPoint(0, 1)
    lifeTxt:pos(display.width/3 + 50, display.height - 30)

    -- 分数标志图片
    local spriteScore = cc.Sprite:create("ui/battle/ui_score.png")
    spriteScore:setPosition(display.width/2 + 80, display.height - 30)
    spriteScore:setAnchorPoint(0, 1)
    spriteScore:addTo(self)

    local scoreTxt = ccui.TextBMFont:create(self.score_, "islandcvbignum.fnt")
    scoreTxt:setScale(0.25)
    scoreTxt:addTo(battleLayer)
    scoreTxt:setAnchorPoint(0, 1)
    scoreTxt:pos(display.width/2 + 130, display.height - 30)

    --文字刷新
    self.tickTxt = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function (dt)
        if self.isStop_ == false then
            lifeTxt:setString(self.life_)
            scoreTxt:setString(self.score_)
        end
    end, 0.2, false)

    -------------------------------------------------------------------
    -- 飞机显示区
    self.spritePlayer_ = cc.Sprite:create("player/red_plane.png")
    --self.spritePlayer:setAnchorPoint(0.5, 0.5)
    self.spritePlayer_:pos(display.width/2, 0)
    --self.spritePlayer:addTo(battleLayer)

    --飞机拖尾粒子
    local particlePlane = cc.ParticleSystemQuad:create("particle/fire.plist")
    particlePlane:setPosition(display.width/2, -10)
    particlePlane:setAngle(270)        --设置朝向（旋转）
    particlePlane:addTo(battleLayer)

    self.spritePlayer_:runAction(cc.MoveTo:create(0.3, cc.p(display.cx, display.cy - 250)))
    particlePlane:runAction(cc.MoveTo:create(0.5, cc.p(display.width/2, display.cy - 260)))
    --触摸事件
    self.spritePlayer_:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        dump(event)
        if event.name == "began" then
            return true
        elseif event.name == "moved" then
            index = event.prevX
            if index > display.right - 10 then
                index = display.right - 10
            end
            if index < display.left + 10 then
                index = display.left + 10
            end
            self.spritePlayer_:pos(index, display.cy - 250)       --玩家位置
            particlePlane:setPosition(index, display.cy - 260)      --飞机拖尾
            self.xCurPlayer_ = index
            self.yCurPlayer_ = display.cy - 250
            print("x,y :", self.xCurPlayer_, self.yCurPlayer_)
        end
    end)
    -- 玩家位置
    self.spritePlayer_:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)
    self.spritePlayer_:setTouchEnabled(true)
    self.spritePlayer_:setAnchorPoint(0.5, 0.5)
    self:addChild(self.spritePlayer_)

    self:fireContinue()

    -------------------------------------------------------------------
    -- 敌机显示区
    --self:createEnemy()
    self:EnemyRefresh()

    -------------------------------------------------------------------
    --碰撞检测
    self:Collision(true)

    return battleLayer
end

function BattleScene:Collision(isStart)
    if isStart == true then
        self.tickCollision_ = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function (dt)
            local areaPlayer = self.spritePlayer_:getBoundingBox()
            for i,e in ipairs(self.enemy_) do
                local areaEnemy = e:getBoundingBox()

                -- 敌机与玩家碰撞，减少生命值
                if cc.rectIntersectsRect(areaEnemy, areaPlayer) then
                    print("飞机相撞")
                    self.life_ = self.life_ - 20

                    --受损音效
                    self.audio_.loadFile("sounds/shipDestroyEffect.ogg", function ()
                        audio.playEffect("sounds/shipDestroyEffect.ogg", false)
                    end)
                    self:enemyBoom(i)       --敌机销毁
                    self:playerDamageAni()  --玩家受损动画

                    if self.life_ <= 0 then
                        --结束游戏
                        self:createGameOverLayer()
                        self.isStop_ = true
                        print("isStop:", self.isStop_)
                        self:stopFire()
                        self:stopEnemyRefresh()
                        self.audio_:stopAll()       --音乐停止
                        self:Collision(false)
                        break
                    end
                end

                --子弹与敌机碰撞检测
                for j,b in ipairs(self.bullet_) do
                    local bullet = self.bullet_[j]
                    local posBullet = cc.p(bullet:getPosition())
                    if cc.rectContainsPoint(areaEnemy, posBullet) then
                        bullet:removeFromParent()
                        table.remove(self.bullet_, j)
                        print("碰撞")
                        self.score_ = self.score_ + 10

                        --爆炸音效
                        self.audio_.loadFile("sounds/explodeEffect.ogg", function ()
                            audio.playEffect("sounds/explodeEffect.ogg", false)
                        end)

                        self:enemyBoom(i)
                        break
                    end
                end

            end
        end, 0, false)
    else
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.tickCollision_)
    end
end

--加载爆炸动画
function BattleScene:loadBoomAnimation()
    local spriteFrameCache = cc.SpriteFrameCache:getInstance()
    spriteFrameCache:addSpriteFrames("animation/explosion.plist")

    local spriteFrames = {}         --储存序列，类似CCArray:create
    for i = 1, 35 do
        local spriteFrame = spriteFrameCache:getSpriteFrame("explosion_0"..i..".png")
        table.insert(spriteFrames, spriteFrame)
    end

    local animation = cc.Animation:createWithSpriteFrames(spriteFrames, 0.04)   --参数：(table，每帧持续时间)
    cc.AnimationCache:getInstance():addAnimation(animation, "ENEMYBOOM")
end

local function removeEnemy(node, table)
    node:removeFromParent()
end

--敌机爆炸
function BattleScene:enemyBoom(idx)
    local enemy = self.enemy_[idx]
    --enemy:removeFromParent()
    table.remove(self.enemy_, idx)

    --爆炸动画后removeFromParent
    local animation = cc.AnimationCache:getInstance():getAnimation("ENEMYBOOM")
    local animate = cc.Animate:create(animation)
    local callFunc = cc.CallFunc:create(removeEnemy)
    local seq = cc.Sequence:create(animate, callFunc)
    enemy:runAction(seq)
end

--玩家受损
function BattleScene:playerDamageAni()
     -- 创建SpineFireBoom动画
     local spineFireBoom = sp.SkeletonAnimation:createWithJsonFile(
        "spine/fireBoom/7_1_fireBoom.json", "spine/fireBoom/7_1_fireBoom.atlas"
    )
    --spineFireBoom:setScale(0.5)
    spineFireBoom:pos(self.spritePlayer_:getPositionX(), self.spritePlayer_:getPositionY()):addTo(self)
    spineFireBoom:setAnimation(0, "7_1_fireBoom", false)      --从第0帧开始，播放名为run的动画，true为无限循环
    spineFireBoom:performWithDelay(function ()
        spineFireBoom:removeFromParent()
    end, 1)
end

--[[--
    创建暂停界面（半透明蒙层，在战斗层之上）
]]
function BattleScene:createStopLayer()
    local director = cc.Director:getInstance()
    --面板设置（半透明灰色蒙版）
    local stopLayer = ccui.Layout:create()
    stopLayer:setAnchorPoint(0.5, 0.5)
    stopLayer:setBackGroundColor(cc.c4b(0,0,0,50))
    --设置透明度
    stopLayer:runAction(cc.FadeTo:create(0, 150))

    stopLayer:opacity(128)
    stopLayer:setBackGroundColorType(1)
    stopLayer:setContentSize(display.width, display.height)
    stopLayer:pos(display.width/2, display.height/2)
    stopLayer:addTo(self)

    --本地最高分数显示
    local scoreLocalMax = cc.UserDefault:getInstance():getIntegerForKey("ScoreLocalMax")
    local highestScoreTxt = display.newTTFLabel({
        text = "本地最高得分："..scoreLocalMax,
        font = "FontNormal.ttf",
        size = 20
    })
    highestScoreTxt:pos(display.width/2, display.height/1.5)
    highestScoreTxt:setAnchorPoint(0.5, 0.5)
    highestScoreTxt:setColor(cc.c4b(255,50,50,100))
    highestScoreTxt:addTo(stopLayer)

    --子弹发射计时器控制
    local addBulletEntry = nil
    --继续按钮
    local buttonContinue = ccui.Button:create("ui/continue/pauseResume.png")
    buttonContinue:setAnchorPoint(0.5, 0.5)
    buttonContinue:setPosition(display.width/2, display.height/2 + 50)
    --buttonContinue:setContentSize(150, 45)
    buttonContinue:addTo(stopLayer)
    buttonContinue:addTouchEventListener(function (sender, eventType)
        if 2 == eventType then
            stopLayer:setVisible(false)
            -- 飞机炮弹连射
            self:fireContinue()
            self.audio_:resumeAll()
            self:EnemyRefresh()
            self.isStop_ = false
            self:Collision(true)
        end
    end)

    -- 返回主页面按钮
    local buttonBack = ccui.Button:create("ui/continue/pauseBackRoom.png")
    buttonBack:setAnchorPoint(0.5, 0.5)
    buttonBack:pos(display.width/2, display.height/2)
    --buttonSet:setTitleFontSize(20)
    buttonBack:addTo(stopLayer)
    -- 按钮点击事件
    buttonBack:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            director:popScene()
        end
    end)

end

--[[--
    创建战斗结束界面（半透明蒙层，在战斗层之上）
]]
function BattleScene:createGameOverLayer()
    local director = cc.Director:getInstance()
    --面板设置（半透明灰色蒙版）
    local gameOverLayer = ccui.Layout:create()
    gameOverLayer:setAnchorPoint(0.5, 0.5)
    gameOverLayer:setBackGroundColor(cc.c4b(0,0,0,50))
    --设置透明度
    gameOverLayer:runAction(cc.FadeTo:create(0, 150))

    gameOverLayer:opacity(128)
    gameOverLayer:setBackGroundColorType(1)
    gameOverLayer:setContentSize(display.width, display.height)
    gameOverLayer:pos(display.width/2, display.height/2)
    gameOverLayer:addTo(self)

    --重新开始按钮
    local buttonReStart = ccui.Button:create("ui/gameover/restart.png")
    buttonReStart:setAnchorPoint(0.5, 0.5)
    buttonReStart:setPosition(display.width/2, display.height/2 + 50)
    --buttonContinue:setContentSize(150, 45)
    buttonReStart:addTo(gameOverLayer)
    buttonReStart:addTouchEventListener(function (sender, eventType)
        if 2 == eventType then
            gameOverLayer:setVisible(false)
            self:createLayer()
            self.isStop_ = false
            self.life_ = 100
            self.score_ = 0
            self.xCurPlayer_ = display.cx
            self.yCurPlayer_ = display.cy - 250
        end
    end)

    -- 返回主页面按钮
    local buttonBack = ccui.Button:create("ui/gameover/back.png")
    buttonBack:setAnchorPoint(0.5, 0.5)
    buttonBack:pos(display.width/2, display.height/2)
    --buttonSet:setTitleFontSize(20)
    buttonBack:addTo(gameOverLayer)
    -- 按钮点击事件
    buttonBack:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            director:popScene()
        end
    end)

    --本地最高分数显示
    local scoreLocalMax = cc.UserDefault:getInstance():getIntegerForKey("ScoreLocalMax")
    local highestScoreTxt = display.newTTFLabel({
        text = "本地最高得分："..scoreLocalMax,
        font = "FontNormal.ttf",
        size = 20
    })
    highestScoreTxt:pos(display.width/2, display.height/1.5)
    highestScoreTxt:setAnchorPoint(0.5, 0.5)
    highestScoreTxt:setColor(cc.c4b(255,50,50,100))
    highestScoreTxt:addTo(gameOverLayer)

    --本地存储最高分数
    local scoreLocalMax = cc.UserDefault:getInstance():getIntegerForKey("ScoreLocalMax")
    print("本地最高纪录：", scoreLocalMax)
    if self.score_ > scoreLocalMax then
        print("新的记录：", self.score_)
        cc.UserDefault:getInstance():setIntegerForKey("ScoreLocalMax", self.score_)    -- 字符串(键-值)

        --本地最高分数显示
        local reScore = cc.UserDefault:getInstance():getIntegerForKey("ScoreLocalMax")
        local highestScoreTxt = display.newTTFLabel({
            text = "恭喜更新记录！",
            font = "FontNormal.ttf",
            size = 20
        })
        highestScoreTxt:pos(display.width/2, display.height/1.5 + 50)
        highestScoreTxt:setAnchorPoint(0.5, 0.5)
        highestScoreTxt:setColor(cc.c4b(255,50,50,100))
        highestScoreTxt:addTo(gameOverLayer)
    end
end

return BattleScene