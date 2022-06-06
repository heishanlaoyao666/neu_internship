local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)

scheduler = require("framework.scheduler")

function GameScene:ctor()
    --数据
    local score = 0
    local point = 10

    --背景图片
    local background = display.newSprite("img_bg/img_bg_1.jpg")
    background:pos(display.cx, display.cy)
    self:addChild(background)

    --暂停按钮
    local btn = ccui.Button:create("ui/battle/uiPause.png", "ui/battle/uiPause.png")
    btn:setScale9Enabled(true)
    btn:addTouchEventListener(function(sender, eventType)
        display.pause()
        require("src/app/scenes/PauseScene.lua"):new():addTo(self)
    end)
    btn:setAnchorPoint(0, 1)
    btn:pos(display.left + 10, display.top - 20)
    btn:addTo(self)

    --生命UI
    local img_lift = ccui.ImageView:create("ui/battle/ui_life.png")
    img_lift:setScale9Enabled(true)
    img_lift:setAnchorPoint(0, 1)
    img_lift:pos(display.left + 100, display.top - 30)
    img_lift:addTo(self)

    --生命值
    local font_lift = ccui.Text:create(point, "ui/font/FontNormal.ttf",24)
    font_lift:pos(display.left + 180, display.top - 26)
    font_lift:setAnchorPoint(0, 1)
    font_lift:addTo(self)

    --分数UI
    local img_point = ccui.ImageView:create("ui/battle/ui_score.png")
    img_point:setScale9Enabled(true)
    img_point:setAnchorPoint(0, 1)
    img_point:pos(display.left + 280, display.top - 30)
    img_point:addTo(self)

    --得分
    local font_score = ccui.Text:create(score, "ui/font/FontNormal.ttf",24)
    font_score:pos(display.left + 350, display.top - 26)
    font_score:setAnchorPoint(0, 1)
    font_score:addTo(self)

    --音效
    local function effectMusic(path)
        if cc.UserDefault:getInstance():getBoolForKey("effectMusic") then
            audio.loadFile(path, function ()
                audio.playEffect(path, false)
            end)
        end
    end

    local plane = cc.Sprite:create("player/red_plane.png")
    plane:pos(display.cx, display.cy - 380)
    plane:runAction(cc.MoveTo:create(1,cc.p(display.cx,display.cy-250)))
    --触控
    plane:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
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
			plane:pos(index,display.cy-250)
		end
	end)
	plane:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)
	plane:setTouchEnabled(true)
    plane:setAnchorPoint(0.5, 0.5)
    self:addChild(plane)

    --粒子系统
    local particleSystem = cc.ParticleSystemQuad:create("particle/fire.plist")
    particleSystem:pos(28, 0)
    particleSystem:setAnchorPoint(0.5, 0.5)
    particleSystem:setRotation(180)
    plane:addChild(particleSystem)

    --子弹生成
    local bullets = {}
    local function fire()
        local bullet = cc.Sprite:create("player/blue_bullet.png")
        local x, y = plane:getPosition()
        bullet:pos(x, y + 20)
        bullet:setAnchorPoint(0.5, 0.5)
        bullet:setScale(0.5)
        bullet:runAction(cc.MoveTo:create(0.5,cc.p(x, 720)))
        self:addChild(bullet)
        table.insert(bullets, bullet)
        effectMusic("sounds/fireEffect.ogg")
        --bullet:removeSelf()
        for k, v in pairs(bullets) do
            local _,bullety = bullets[k]:getPosition()
            if bullety >= 720 then
                bullets[k]:removeSelf()
                bullets[k] = nil
            end
        end
    end

    --敌人的生成
    local enemies = {}
    local function enemy()
        local e = cc.Sprite:create("player/small_enemy.png")
        mytime = os.time()
        math.randomseed(mytime)
        x = math.random(10, 470)
        e:pos(x, 740)
        e:setAnchorPoint(0.5, 0.5)
        e:runAction(cc.MoveTo:create(2,cc.p(x, -10)))
        self:addChild(e)
        table.insert(enemies, e)
        --e:removeSelf()
        for k, v in pairs(enemies) do
            local _,y = v:getPosition()
            if y <= 0 then
                enemies[k]:removeSelf()
                enemies[k] = nil
            end
        end
    end

    --爆炸动画
    local function explosionAnimation(x,y)
        local spriteFrame  = cc.SpriteFrameCache:getInstance()
        spriteFrame:addSpriteFrames("animation/explosion.plist")
        local sprite = cc.Sprite:createWithSpriteFrameName("explosion_01.png")
        sprite:pos(x,y)
        self:addChild(sprite)
        local animation =cc.Animation:create()
        for i=2,12 do
            local frameName = string.format("explosion_%02d.png",i)
            local spriteFrame = spriteFrame:getSpriteFrame(frameName)
            animation:addSpriteFrame(spriteFrame)
        end
        animation:setDelayPerUnit(0.15)          --设置两个帧播放时间
        animation:setRestoreOriginalFrame(true)    --动画执行后还原初始状态
        local action =cc.Animate:create(animation)
        sprite:runAction(action)
    end

    --碰撞检测
    local function boxclid()
        for k1, v1 in pairs(enemies) do
            for k2, v2 in pairs(bullets) do
                local rectA = bullets[k2]:getBoundingBox()
                local rectB = enemies[k1]:getBoundingBox()
                if(math.abs(bullets[k2]:getPositionX() - enemies[k1]:getPositionX()) * 2 <= (rectA.width + rectB.width))
                    and
                    (math.abs(bullets[k2]:getPositionY() - enemies[k1]:getPositionY()) * 2 <= (rectA.height + rectB.height))
                then
                    effectMusic("sounds/explodeEffect.ogg")
                    local x,y = enemies[k1]:getPosition()
                    explosionAnimation(x,y)
                    bullets[k2]:removeSelf()
                    enemies[k1]:removeSelf()
                    bullets[k2] = nil
                    enemies[k1] = nil
                    score = score + 10
                    font_score:setString(score)
                end
            end
        end
    end

    --受伤检测
    local function hurtclid()
        for k, v in pairs(enemies) do
            local rectA = plane:getBoundingBox()
            local rectB = enemies[k]:getBoundingBox()
            if(math.abs(plane:getPositionX() - enemies[k]:getPositionX()) * 2 <= (rectA.width + rectB.width))
                and
                (math.abs(plane:getPositionY() - enemies[k]:getPositionY()) * 2 <= (rectA.height + rectB.height))
            then
                local x,y = enemies[k]:getPosition()
                explosionAnimation(x,y)
                enemies[k]:removeSelf()
                enemies[k] = nil
                point = point - 10
                if point == 0 then
                    effectMusic("sounds/shipDestroyEffect.ogg")
                    cc.UserDefault:getInstance():setStringForKey("score", score)
                    display.pause()
                    require("src/app/scenes/GameOverScene.lua"):new():addTo(self)
                end
                font_lift:setString(point)
            end
        end
    end

    handler1 = scheduler.scheduleGlobal(fire,0.2)
    handler2 = scheduler.scheduleGlobal(enemy,1)
    handler3 = scheduler.scheduleGlobal(boxclid,0.1)
    handler4 = scheduler.scheduleGlobal(hurtclid,0.1)

end


function GameScene:onEnter()
    --开关背景音乐
    if cc.UserDefault:getInstance():getBoolForKey("mainMainMusic") then
        audio.loadFile("sounds/bgMusic.ogg", function ()
            audio.playBGM("sounds/bgMusic.ogg")
        end)
    else
        audio.stopBGM()
    end
end

function GameScene:onExit()
    scheduler.unscheduleGlobal(handler1)
    scheduler.unscheduleGlobal(handler2)
    scheduler.unscheduleGlobal(handler3)
    scheduler.unscheduleGlobal(handler4)
end

return GameScene