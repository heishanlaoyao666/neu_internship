local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)

scheduler = require("framework.scheduler")

function GameScene:effectMusic(path)
    if cc.UserDefault:getInstance():getBoolForKey("effectMusic") then
        audio.loadFile(path, function ()
            audio.playEffect(path, false)
        end)
    end
end

function GameScene:ctor()
    --数据
    local score = 0
    local point = 100

    --背景图片
    local background = display.newSprite("img_bg/img_bg_1.jpg")
    background:pos(display.cx, 0)
    background:setAnchorPoint(0.5,0)
    background:addTo(self)

    local background1 = display.newSprite("img_bg/img_bg_1.jpg")
    background1:pos(display.cx, 1440)
    background1:setAnchorPoint(0.5,0)
    background1:addTo(self)

    local function bgMove()
        if background:getPositionY() <= -1280 then
            background:pos(display.cx, 0)
            background1:pos(display.cx, 1440)
        end
        background:runAction(cc.MoveTo:create(15,cc.p(display.cx,-1440)))
        background1:runAction(cc.MoveTo:create(15,cc.p(display.cx,0)))
    end


    --暂停按钮
    local btn = ccui.Button:create("ui/battle/uiPause.png", "ui/battle/uiPause.png")
    btn:setScale9Enabled(true)
    btn:addTouchEventListener(function(sender, eventType)
        self:effectMusic("sounds/buttonEffet.ogg")
        self.luaToJson()
        display.pause()
        require("src/app/scenes/PauseScene.lua"):new():addTo(self)
    end)
    btn:setAnchorPoint(0, 1)
    btn:pos(display.left, display.top)
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

    plane = cc.Sprite:create("player/red_plane.png")
    plane:pos(display.cx, display.cy - 380)
    if cc.UserDefault:getInstance():getBoolForKey("isDoc") == false then
        plane:runAction(cc.MoveTo:create(1,cc.p(display.cx,display.cy-250)))
    end
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
    plane:addTo(self)

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
        bullet:addTo(self)
        table.insert(bullets, bullet)
        effectMusic("sounds/fireEffect.ogg")
        --bullet:removeSelf()
        for k, v in pairs(bullets) do
            local _,bullety = v:getPosition()
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
        e:addTo(self)
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

    --继续游戏
    if cc.UserDefault:getInstance():getBoolForKey("isDoc") then
        local file = io.open("D:/wk/helloworld/document.txt")
        io.input(file)
        local f = io.read()
        local t = json.decode(f)
        for k, v in pairs(t[1]) do
            local e = cc.Sprite:create("player/small_enemy.png")
            e:pos(v[1], v[2])
            e:setAnchorPoint(0.5, 0.5)
            e:runAction(cc.MoveTo:create(2,cc.p(v[1], -10)))
            e:addTo(self)
            table.insert(enemies, e)
        end
        plane:pos(t[2][1], t[2][2])
        font_lift:setString(t[3])
        font_score:setString(t[4])
    end

    --爆炸动画
    local function explosionAnimation(x,y)
        local spriteFrame  = cc.SpriteFrameCache:getInstance()
        spriteFrame:addSpriteFrames("animation/explosion.plist")
        local boom = cc.Sprite:createWithSpriteFrameName("explosion_01.png")
        boom:pos(x,y)
        boom:addTo(self)
        local animation =cc.Animation:create()
        for i=2,12 do
            local frameName = string.format("explosion_%02d.png",i)
            local spriteFrame = spriteFrame:getSpriteFrame(frameName)
            animation:addSpriteFrame(spriteFrame)
        end
        animation:setDelayPerUnit(0.15)          --设置两个帧播放时间
        animation:setRestoreOriginalFrame(true)    --动画执行后还原初始状态
        local action =cc.Animate:create(animation)
        local function CallBack()
            boom:removeSelf()
        end
        local cb = cc.CallFunc:create(CallBack)
        local seq = cc.Sequence:create(action,cb)
        boom:runAction(cc.Sequence:create(seq))
    end

    --碰撞检测
    local function boxclid()
        for k1, v1 in pairs(enemies) do
            for k2, v2 in pairs(bullets) do
                local rectA = v2:getBoundingBox()
                local rectB = v1:getBoundingBox()
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
                point = point - 20
                if point <= 0 then
                    effectMusic("sounds/shipDestroyEffect.ogg")
                    cc.UserDefault:getInstance():setStringForKey("score", score)
                    display.pause()
                    require("src/app/scenes/GameOverScene.lua"):new():addTo(self)
                end
                font_lift:setString(point)
            end
        end
    end

    --json 转码
    self.luaToJson = function()
        local enemiesPosition = {}
        for k, v in pairs(enemies) do
            local x,y = v:getPosition()
            table.insert(enemiesPosition, {x, y})
        end
        local planePosition = {plane:getPosition()}
        local t = {
            enemiesPosition,
            planePosition,
            point,
            score,
        }
        local str_json = json.encode(t)
        file = io.open("D:/wk/helloworld/document.txt","w+")
        io.output(file)
        io.write(str_json)
        io.close()
    end

    self.handler1 = scheduler.scheduleGlobal(fire,0.2)
    self.handler2 = scheduler.scheduleGlobal(enemy,1)
    self.handler3 = scheduler.scheduleGlobal(boxclid,0.1)
    self.handler4 = scheduler.scheduleGlobal(hurtclid,0.1)
    bgMove()
    self.handler5 = scheduler.scheduleGlobal(bgMove,15)

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
    scheduler.unscheduleGlobal(self.handler1)
    scheduler.unscheduleGlobal(self.handler2)
    scheduler.unscheduleGlobal(self.handler3)
    scheduler.unscheduleGlobal(self.handler4)
    scheduler.unscheduleGlobal(self.handler5)
end

return GameScene