BUTTON_PAUSE_PATH = "D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/battle/uiPause.png"
TEXTURE_LIFE_PATH = "D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/battle/ui_life.png"
TEXTURE_SCORE_PATH = "D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/battle/ui_score.png"
FONT_PATH="D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/font/FontNormal.ttf"
--PICTURE_BATTLE_PATH = "D:/quick-cocos2dx-community/test/src/app/scenes/picture/img_bg/img_bg_1.jpg"
BG_PATH = "D:/quick-cocos2dx-community/test/src/app/scenes/picture/img_bg/img_bg_1.jpg"
PLAYER_RED_PATH = "D:/quick-cocos2dx-community/test/src/app/scenes/picture/player/red_plane.png"
ENEMY_PATH = "D:/quick-cocos2dx-community/test/src/app/scenes/picture/player/small_enemy.png"
BULLET_PATH = "D:/quick-cocos2dx-community/test/src/app/scenes/picture/player/blue_bullet.png"
PARTICLE_PLIST_PATH = "D:/quick-cocos2dx-community/test/src/app/scenes/picture/particle/fire.plist"
PARTICLE_PNG_PATH = "D:/quick-cocos2dx-community/test/src/app/scenes/picture/particle/fire.png"
ANIMATION_PLIST_PATH = "D:/quick-cocos2dx-community/test/src/app/scenes/picture/animation/explosion.plist"
ANIMATION_PNG_PATH =   "D:/quick-cocos2dx-community/test/src/app/scenes/picture/animation/explosion.png"
EXPLODE_EFFECT_PATH="D:/quick-cocos2dx-community/test/src/app/scenes/picture/sounds/explodeEffect.ogg"
require("D:/quick-cocos2dx-community/test/src/cocos/cocos2d/Cocos2d.lua")
require("D:/quick-cocos2dx-community/test/src/app/scenes/SettingScene.lua")

local scheduler = require("D:/quick-cocos2dx-community/test/src/framework/scheduler.lua")
local BattleScene =
    class(
    "BattleScene",
    function()
        return display.newPhysicsScene("BattleScene")
    end
)
--local scene=cc.Scene:create()
function BattleScene:ctor()
    --local layer=cc.Layer:create()
    print(soundsEnable)
    local bulletArr = {}
    local background = {}
    local enemyArr = {}
    local boundaryDistance = 10
    local nowBg = display.newSprite(BG_PATH)
    local nextBg = display.newSprite(BG_PATH)
    nowBg:setAnchorPoint(0, 0)
    nowBg:setPosition(0, 0)
    nextBg:setAnchorPoint(0, 0)
    nextBg:setPosition(0, nowBg:getContentSize().height)
    local life=100
    local score=0
    --now:setPosition(nowBg:getContentSize().width*0.5,nowBg:getContentSize().height*0.5)
    table.insert(background, nowBg)
    self:add(nowBg)
    nowBg:add(nextBg)
    
    

    local function moveBackground()
        local move = cc.MoveTo:create(10, cc.p(0, -nowBg:getContentSize().height))
        nowBg:runAction(move)
        cc.Director:getInstance():getScheduler():scheduleScriptFunc(
            function()
                local x, y = nowBg:getPosition()
                --local x1,y1=nextBg:getPosition()
                if (y == -nowBg:getContentSize().height) then
                    nowBg:setPosition(0, 0)
                    moveBackground()
                --elseif (y1==0) then
                --nextBg:setPosition(0,nowBg:getContentSize().height)
                end
            end,
            1,
            false
        )
    end
    moveBackground()
    
    local pause=ccui.Button:create(BUTTON_PAUSE_PATH,BUTTON_PAUSE_PATH)
    self:add(pause)
    pause:setAnchorPoint(0,1)
    pause:setScale9Enabled(true)
    pause:pos(0,cc.Director:getInstance():getWinSize().height)
    pause:setPressedActionEnabled(true)

    local scoreTexture=display.newSprite(TEXTURE_SCORE_PATH)
    self:add(scoreTexture)
    scoreTexture:setAnchorPoint(0,1)
    scoreTexture:setPosition(cc.p(cc.Director:getInstance():getWinSize().width*0.7,cc.Director:getInstance():getWinSize().height))
    local ttf={}
    ttf.fontFilePath=FONT_PATH
    ttf.fontSize=20
    local scoreLabel=cc.Label:createWithTTF(ttf,"0")
    scoreTexture:add(scoreLabel)
    scoreLabel:setAnchorPoint(0,0)
    scoreLabel:setPosition(scoreTexture:getContentSize().width,0)
    scoreLabel:setString(" "..score)
    
    
    local lifeTexture = display.newSprite(TEXTURE_LIFE_PATH)
    self:add(lifeTexture)
    lifeTexture:setAnchorPoint(0,1)
    lifeTexture:setPosition(cc.p(cc.Director:getInstance():getWinSize().width*0.4,cc.Director:getInstance():getWinSize().height))
    local lifeLabel=cc.Label:createWithTTF(ttf,"0")
    lifeTexture:add(lifeLabel)
    lifeLabel:setAnchorPoint(0,0)
    lifeLabel:setPosition(lifeTexture:getContentSize().width,0)
    lifeLabel:setString(" "..life)

    local player = display.newSprite(PLAYER_RED_PATH)
    self:add(player)
    local playBody = cc.PhysicsBody:createBox(player:getContentSize(), cc.PHYSICSBODY_MATERIAL_DEFAULT, cc.p(0, 0))
    playBody:setCategoryBitmask(0x01)
    playBody:setCollisionBitmask(0x01)
    playBody:setContactTestBitmask(0x01)
    playBody:setGravityEnable(false)
    player:setPhysicsBody(playBody)
    player:setAnchorPoint(0.5, 0)
    player:setPosition(cc.Director:getInstance():getWinSize().width * 0.5, -100)
    player:setTag(001)
    player:runAction(cc.MoveTo:create(2, cc.p(cc.Director:getInstance():getWinSize().width * 0.5, 10)))
    local fire = cc.ParticleSystemQuad:create(PARTICLE_PLIST_PATH)
    local playerX, playerY = player:getPosition()
    player:add(fire)
    fire:setAnchorPoint(0.5, 0)
    fire:setRotation(180)
    fire:setPosition(player:getContentSize().width * 0.5, 0)

    local function OnTouchBegan(touch, event)
        return true
    end
    local function OnTouchMoved(touch, event)
        local x, y = player:getPosition()
        local d = touch:getDelta()
        if (x + d.x) < boundaryDistance then
            player:setPosition(boundaryDistance, y)
        elseif (x + d.x) > cc.Director:getInstance():getWinSize().width - boundaryDistance then
            player:setPosition(cc.Director:getInstance():getWinSize().width - boundaryDistance, y)
        else
            player:setPosition(x + d.x, y)
        end
    end
    local function OnTouchEnded(touch, event)
        -- body
    end
    local touchListen = cc.EventListenerTouchOneByOne:create()
    touchListen:registerScriptHandler(OnTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    touchListen:registerScriptHandler(OnTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    touchListen:registerScriptHandler(OnTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)

    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(touchListen, player)
    --player:addNodeEventListener(cc.EVENT_TOUCH_ONE_BY_ONE,OnTouchMoved)
    --player:setTouchEnabled(true)
    local function shoot()
        local bullet = display.newSprite(BULLET_PATH)
        self:add(bullet)
        local bulletBody =
            cc.PhysicsBody:createBox(bullet:getContentSize(), cc.PHYSICSBODY_MATERIAL_DEFAULT, cc.p(0, 0))
        bulletBody:setCategoryBitmask(0x02)
        bulletBody:setCollisionBitmask(0x02)
        bulletBody:setContactTestBitmask(0x02)
        bulletBody:setGravityEnable(false)
        bullet:setPhysicsBody(bulletBody)
        table.insert(bulletArr, bullet)
        local x, y = player:getPosition()
        bullet:setPosition(x, y + player:getContentSize().height)
        bullet:setTag(002)
        x, y = bullet:getPosition()
        local moveTo = cc.MoveTo:create(3, cc.p(x, cc.Director:getInstance():getWinSize().height * 1.1))
        bullet:runAction(moveTo)
        --[[local function destory()
            print("yes")
            bullet=nil
            bullet:removeFromParents()
        end]]
        --cc.Director:getInstance():getScheduler():scheduleScriptFunc(destory,7,true)
    end
    local function destoryBullet()
        for i = table.getn(bulletArr), 1, -1 do
            local Bullet = bulletArr[i]
            local x, y = Bullet:getPosition()
            if y > cc.Director:getInstance():getWinSize().height then
                Bullet:removeSelf()
                table.remove(bulletArr, i)
            end
        end
    end
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(shoot, 1, false)
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(destoryBullet, 3, false)
    local function getTrueRandom(min, max)
        local strTime = tostring(os.time())
        local strRev = string.reverse(strTime)
        local strRandomTime = string.sub(strRev, 1, 6)
        math.randomseed(strRandomTime)
        return math.random(min, max)
    end
    local function enemyCreate()
        local enemy = display.newSprite(ENEMY_PATH)
        self:add(enemy)
        local enemyBody = cc.PhysicsBody:createBox(enemy:getContentSize(), cc.PHYSICSBODY_MATERIAL_DEFAULT, cc.p(0, 0))
        enemyBody:setGravityEnable(false)
        enemyBody:setCategoryBitmask(0x03)
        enemyBody:setCollisionBitmask(0x03)
        enemyBody:setContactTestBitmask(0x03)
        enemy:setPhysicsBody(enemyBody)
        enemy:setTag(003)
        enemy:setAnchorPoint(0.5, 0)
        table.insert(enemyArr, enemy)
        local right = 0 + enemy:getContentSize().width * 0.5
        local left = cc.Director:getInstance():getWinSize().width - enemy:getContentSize().width * 0.5
        enemy:setPosition(cc.p(getTrueRandom(right, left), cc.Director:getInstance():getWinSize().height + 50))
        local x, y = enemy:getPosition()
        local move = cc.MoveTo:create(4, cc.p(x, -60))
        enemy:runAction(move)
    end
    local function enemyDestory()
        for i = table.getn(enemyArr), 1, -1 do
            local Enemy = enemyArr[i]
            local x, y = Enemy:getPosition()
            if y <= -50 then
                if soundsEnable then 
                audio.loadFile(EXPLODE_EFFECT_PATH,function ()
                    audio.playEffect(EXPLODE_EFFECT_PATH,false)-- body
                    end)
                end
                Enemy:removeSelf()
                table.remove(enemyArr, i)
            end
        end
    end
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(enemyCreate, 1, false)
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(enemyDestory, 8, false)

    local function boomAnimation()
        --[[local spfc = cc.SpriteFrameCache:getInstance()
        spfc:addSpriteFrames(ANIMATION_PLIST_PATH)
        local frames = {}
        for i = 1, 4 do
            -- 根据在TexturePacker中的图片的名称获取
            local frame = spfc:getSpriteFrame("explosion_0"..i .. ".png")
            table.insert(frames, frame)
        end
        -- 通过table创建动画并设置帧间隔
        local animation = cc.Animation:createWithSpriteFrames(frames, 0.1)
        -- 将动画按照自定义的名字进行缓存
        cc.AnimationCache:getInstance():addAnimation(animation, "boom")
        --player:runAction(cc.Animate:create(animation))
        -- 本次可以直接调用animation进行runAction即可
        -- 下一次可以通过动画缓存中获取动画
        --cc.AnimationCache:getInstance():getAnimation("boom")]]
        
        --[[local spriteFrame=cc.SpriteFrameCache:getInstance()
        spriteFrame:addSpriteFrames(ANIMATION_PLIST_PATH)
        local  sprite = cc.Sprite:createWithSpriteFrameName(ANIMATION_PNG_PATH)
        sprite:setPosition(cc.p(display.cx,display.cy))
        self:add(sprite)
        local animation=cc.Animation:create()
        for i=1,4 do
            local spriteFrame=spriteFrame:getSpriteFrameByName("explosion_0"..i..".png")
            animation:addSpriteFrame(spriteFrame)
        end
        animation:setDelayPerUnit(0.15)
        animation:setRestorOriginalFrame(true)
        local action=aa.Animate:create(animation)
        sprite:runAction(cc.RepeatForever:create(action))]]
    end
    boomAnimation()
    local function onContactBegin(contact)
        local tag1 = contact:getShapeA():getBody():getNode():getTag()
        local tag2 = contact:getShapeB():getBody():getNode():getTag()
        if (tag1 == 001 and tag2 == 003) then
            local x, y = contact:getShapeB():getBody():getNode():getPosition()
            contact:getShapeB():getBody():getNode():setPosition(x, -50)
            enemyDestory()
            life=life-20
            lifeLabel:setString(" "..life)
            return
        end
        if (tag1 == 003 and tag2 == 001) then
            local x, y = contact:getShapeA():getBody():getNode():getPosition()
            contact:getShapeA():getBody():getNode():setPosition(x, -50)
            enemyDestory()
            life=life-20
            lifeLabel:setString(" "..life)
            return
        end
        if (tag1 == 002 and tag2 == 003) then
            local x, y = contact:getShapeB():getBody():getNode():getPosition()
            contact:getShapeB():getBody():getNode():setPosition(x, -50)
            --local animation=cc.AnimationCache:getInstance():getAnimation("boom")
            --local animate = cc.Animate:create(animation)
            --contact:getShapeB():getBody():getNode():runAction(animate)
            enemyDestory()

            local x1, y1 = contact:getShapeA():getBody():getNode():getPosition()
            contact:getShapeA():getBody():getNode():setPosition(x, cc.Director:getInstance():getWinSize().height + 50)
            destoryBullet()
            score=score+10
            scoreLabel:setString(" "..score)
            return
        end
        if (tag1 == 003 and tag2 == 002) then
            local x, y = contact:getShapeA():getBody():getNode():getPosition()
            contact:getShapeA():getBody():getNode():setPosition(x, -50)
            enemyDestory()

            local x1, y1 = contact:getShapeB():getBody():getNode():getPosition()
            contact:getShapeB():getBody():getNode():setPosition(x, cc.Director:getInstance():getWinSize().height + 50)
            destoryBullet()
            score=score+10
            scoreLabel:setString(" "..score)
            return
        end
    end
    local contactListener = cc.EventListenerPhysicsContact:create()
    contactListener:registerScriptHandler(onContactBegin, cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
    eventDispatcher:addEventListenerWithFixedPriority(contactListener, 1)

    local pauseLayer=ccui.Layout:create()
    self:add(pauseLayer)
    pauseLayer:setAnchorPoint(0.5,0.5)
    pauseLayer:setPosition(cc.p(cc.Director:getInstance():getWinSize().width*0.5,cc.Director:getInstance():getWinSize().height*0.5))
    pauseLayer:setContentSize(cc.Director:getInstance():getWinSize().width*0.7,cc.Director:getInstance():getWinSize().height*0.7)
    pauseLayer:setBackGroundColor(cc.c3b(155,155,155))
end
    
return BattleScene
