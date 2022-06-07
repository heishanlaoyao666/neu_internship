
local play1 = class("play1", function()
    return display.newScene("play1")
end)

local music = true
local sound = true

local audio = require("framework.audio")

audio.loadFile("texture/sounds/bgMusic.ogg", function ()
    audio.playBGM("texture/sounds/bgMusic.ogg")
end)

audio.loadFile("texture/sounds/shipDestroyEffect.ogg", function ()
end)

audio.loadFile("texture/sounds/fireEffect.ogg", function ()
end)

audio.loadFile("texture/sounds/explodeEffect.ogg", function ()
end)

audio.loadFile("texture/sounds/buttonEffet.ogg", function ()
end)

function play1:ctor()
    local scheduler = require("framework.scheduler")
    local updateHandle = scheduler.scheduleUpdateGlobal(handler(self, self.update))
    hp = 100
    score = 0
    pause = false
    b1= display.newSprite("texture/img_bg/img_bg_1.jpg")
    :pos(display.cx,display.cy)
    :addTo(self)

    b2= display.newSprite("texture/img_bg/img_bg_1.jpg")
    :pos(display.cx,display.cy-1280)
    :addTo(self)

    palyerPlane = display.newSprite("texture/player/purple_plane.png")
    :pos(display.cx,display.cy-300)
    :addTo(self)

    danmu = {{x = display.cx ,y = display.cy-300,danmu1 = display.newSprite("texture/player/blue_bullet.png")
    :pos(display.cx,display.cy-300)
    :addTo(self)
    }}
    enemy = {{life = 100,x = display.cx ,y = display.top-300,enemy1 = display.newSprite("texture/player/small_enemy.png")
    :pos(display.cx,display.top-300)
    :addTo(self)
    }}

    palyerPlane:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
		dump(event)
		if event.name == "began" then
			return true
		end
        if event.name == "moved" then
            if(event.x > 10 and event.x < display.right - 10 and event.y >10 and event.y < display.top -10)then
                palyerPlane:setPosition(cc.p(event.x,event.y))
            end
		end
        if event.name == "ended" then
            if(event.x > 10 and event.x < display.right - 10 and event.y >10 and event.y < display.top -10)then
                palyerPlane:setPosition(cc.p(event.x,event.y))
            end
		end
	end)
    palyerPlane:setTouchEnabled(true)

    local move1 = cc.MoveBy:create(10,cc.p(0,1000))
    local move2 = cc.MoveBy:create(0,cc.p(0,-1280))
    local move3 = cc.MoveBy:create(2.80,cc.p(0,280))

    local move4 = cc.MoveBy:create(12.80,cc.p(0,1280))
    local move5 = cc.MoveBy:create(0,cc.p(0,-1280))

    local SequenceAction1 = cc.Sequence:create(move1,move2,move3)
    local SequenceAction2 = cc.Sequence:create(move4,move5)

    transition.execute(b1,cc.RepeatForever:create(SequenceAction1))
    transition.execute(b2,cc.RepeatForever:create(SequenceAction2))
    
    hp2 = ccui.Button:create(nil, nil)
    hp2:setAnchorPoint(1.0, 1.0)
    hp2:setScale9Enabled(true)
    hp2:setContentSize(45,25)
    hp2:pos(display.right-145,display.top)
    hp2:addTo(self)
    hp2:setTitleText(hp)

    local hp1 = ccui.Button:create("texture/ui/battle/ui_life.png", "texture/ui/battle/ui_life.png")
    hp1:setAnchorPoint(1.0, 1.0)
    hp1:setScale9Enabled(true)
    hp1:setContentSize(45,25)
    hp1:pos(display.right-190,display.top)
    hp1:addTo(self)

    score2 = ccui.Button:create(nil, nil)
    score2:setAnchorPoint(1.0, 1.0)
    score2:setScale9Enabled(true)
    score2:setContentSize(90,25)
    score2:pos(display.right,display.top)
    score2:addTo(self)
    score2:setTitleText(score)

    local score1 = ccui.Button:create("texture/ui/battle/ui_score.png", "texture/ui/battle/ui_score.png")
    score1:setAnchorPoint(1.0, 1.0)
    score1:setScale9Enabled(true)
    score1:setContentSize(45,25)
    score1:pos(display.right-90,display.top)
    score1:addTo(self)

    pauseLayer = ccui.Layout:create()
    pauseLayer:setBackGroundColor(cc.c3b(128, 128, 128))
    pauseLayer:setCascadeOpacityEnabled(true)
    pauseLayer:setOpacity(180)
    pauseLayer:setBackGroundColorType(1)
    pauseLayer:setContentSize(1400, 2960)
    pauseLayer:setPosition(display.cx,display.cy)
    pauseLayer:setAnchorPoint(0.5, 0.5)
    pauseLayer:addTo(self)
    pauseLayer:setVisible(false)

    local back = ccui.Button:create("texture/ui/continue/pauseBackRoom.png", "texture/ui/continue/pauseBackRoom.png")
    back:setAnchorPoint(0.5, 0.5)
    back:setScale9Enabled(true)
    back:setContentSize(307,75)
    back:pos(display.cx,display.cy+25)
    back:addTo(self)
    back:setVisible(false)
    back:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
            audio.playEffect("texture/sounds/buttonEffet.ogg")
			local  menu = import("src.app.scenes.menu"):new()
            display.replaceScene(menu)
		end
	end)

 
    enemyTime = 4
    realTime = 0;
    self.scheduler = require('framework.scheduler')-- 定义一个定时器  
    self.handler = self.scheduler.scheduleGlobal(function()    -- 这里必须如此定义，否则self内的成员不可用，返回一个全局的定时器handler，用来取消定时
        local x = palyerPlane:getPositionX()
        local y = palyerPlane:getPositionY()
        bullet = display.newSprite("texture/player/blue_bullet.png")
        :pos(x,y)
        :addTo(self)
        audio.playEffect("texture/sounds/fireEffect.ogg")
        danmu2 = {x = x ,y = y ,danmu1 = bullet} 
        table.insert(danmu,danmu2)

        realTime = realTime+1
        if realTime == 10 then
            realTime = 0
            x = math.random(display.right - 50) +25
            y = math.random(500)+display.top  
            enemy3 = display.newSprite("texture/player/small_enemy.png")
            :pos(x,y)
            :addTo(self)
            enemy2 = {life = 100,x = x,y = y,enemy1 = enemy3 }
            table.insert(enemy,enemy2)
        end

    end, 0.2)  -- 每秒回调一次self.OnTimer函数

    local continue = ccui.Button:create("texture/ui/continue/pauseResume.png", "texture/ui/continue/pauseResume.png")
    continue:setAnchorPoint(0.5, 0.5)
    continue:setScale9Enabled(true)
    continue:setContentSize(307,75)
    continue:pos(display.cx,display.cy-25)
    continue:addTo(self)
    continue:setVisible(false)
    
    continue:addTouchEventListener(function(sender1, eventType)
		if 2 == eventType then
            audio.playEffect("texture/sounds/buttonEffet.ogg")
            self.handler = self.scheduler.scheduleGlobal(function()    -- 这里必须如此定义，否则self内的成员不可用，返回一个全局的定时器handler，用来取消定时
                local x = palyerPlane:getPositionX()
                local y = palyerPlane:getPositionY()
                bullet = display.newSprite("texture/player/blue_bullet.png")
                :pos(x,y)
                :addTo(self)
                audio.playEffect("texture/sounds/fireEffect.ogg")
                danmu2 = {x = x ,y = y ,danmu1 = bullet} 
                table.insert(danmu,danmu2)
        
                realTime = realTime+1
                if realTime == 10 then
                    realTime = 0
                    x = math.random(display.right - 50) +25
                    y = math.random(500)+display.top  
                    enemy3 = display.newSprite("texture/player/small_enemy.png")
                    :pos(x,y)
                    :addTo(self)
                    enemy2 = {life = 100,x = x,y = y,enemy1 = enemy3 }
                    table.insert(enemy,enemy2)
                end
        
            end, 0.2)  -- 每秒回调一次self.OnTimer函数
            palyerPlane:setTouchEnabled(true)
            pause = false
            transition.resumeTarget(b1)
            transition.resumeTarget(b2)
            back:setVisible(false)
            pauseLayer:setVisible(false)
            continue:setVisible(false)
		end
	end)

    local confirmButton = ccui.Button:create("texture/ui/battle/uiPause.png", "texture/ui/battle/uiPause.png")
    confirmButton:setAnchorPoint(0.0, 1.0)
    confirmButton:setScale9Enabled(true)
    confirmButton:setContentSize(45,44)
    confirmButton:pos(display.left,display.top)
    confirmButton:addTo(self)

    confirmButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then  
            audio.playEffect("texture/sounds/buttonEffet.ogg")
            palyerPlane:setTouchEnabled(false)
            pause = true
            self.scheduler.unscheduleGlobal(self.handler)
            transition.pauseTarget(b1)
            transition.pauseTarget(b2)
            back:setVisible(true)
            pauseLayer:setVisible(true)
            continue:setVisible(true)
		end
	end)
    
end
 
function play1:update(dt)
    if(pause) then 
        return
    end
    if hp <= 0 then
        palyerPlane:setTouchEnabled(false)
        pause = true
        self.scheduler.unscheduleGlobal(self.handler)
        transition.pauseTarget(b1)
        transition.pauseTarget(b2)
        pauseLayer:setVisible(true)

        local back1 = ccui.Button:create("texture/ui/gameover/back.png", "texture/ui/gameover/back.png")
        back1:setAnchorPoint(0.5, 0.5)
        back1:setScale9Enabled(true)
        back1:setContentSize(307,75)
        back1:pos(display.cx,display.cy+25)
        back1:addTo(self)
    
        back1:addTouchEventListener(function(sender4, eventType)
            if 2 == eventType then  
                audio.playEffect("texture/sounds/buttonEffet.ogg")
                local  menu = import("src.app.scenes.menu"):new()
                display.replaceScene(menu)
            end
        end)

        local restart1 = ccui.Button:create("texture/ui/gameover/restart.png", "texture/ui/gameover/restart.png")
        restart1:setAnchorPoint(0.5, 0.5)
        restart1:setScale9Enabled(true)
        restart1:setContentSize(307,75)
        restart1:pos(display.cx,display.cy-25)
        restart1:addTo(self)
    
        restart1:addTouchEventListener(function(sender5, eventType)
            if 2 == eventType then  
                audio.playEffect("texture/sounds/buttonEffet.ogg")
                palyerPlane:setTouchEnabled(true)
                pause = false
                self.handler = self.scheduler.scheduleGlobal(function()    -- 这里必须如此定义，否则self内的成员不可用，返回一个全局的定时器handler，用来取消定时
                    local x = palyerPlane:getPositionX()
                    local y = palyerPlane:getPositionY()
                    bullet = display.newSprite("texture/player/blue_bullet.png")
                    :pos(x,y)
                    :addTo(self)
                    audio.playEffect("texture/sounds/fireEffect.ogg")
                    danmu2 = {x = x ,y = y ,danmu1 = bullet} 
                    table.insert(danmu,danmu2)
            
                    realTime = realTime + 1
                    if realTime == 10 then
                        realTime = 0
                        x = math.random(display.right - 50) +25
                        y = math.random(500)+display.top  
                        enemy3 = display.newSprite("texture/player/small_enemy.png")
                        :pos(x,y)
                        :addTo(self)
                        enemy2 = {life = 100,x = x,y = y,enemy1 = enemy3 }
                        table.insert(enemy,enemy2)
                    end
            
                end, 0.2)  -- 每秒回调一次self.OnTimer函数
                transition.resumeTarget(b1)
                transition.resumeTarget(b2)
                pauseLayer:setVisible(false)
                back1:setVisible(false)
                restart1:setVisible(false)
                hp = 100
                hp2:setTitleText(hp)
                score = 0 
                score2:setTitleText(score)
                palyerPlane:setPosition(display.cx,display.cy-300)
                for _,v in pairs(danmu) do
                    self:removeChild(v.danmu1)
                end
                for _,v in pairs(enemy) do
                    self:removeChild(v.enemy1)
                end
                danmu = {{x = display.cx ,y = display.cy-300,danmu1 = display.newSprite("texture/player/blue_bullet.png")
                :pos(display.cx,display.cy-300)
                :addTo(self)
                }}
                
                enemy = {{life = 100,x = display.cx ,y = display.top-300,enemy1 = display.newSprite("texture/player/small_enemy.png")
                :pos(display.cx,display.top-300)
                :addTo(self)
                }}
            end
        end)
    end
    local z = 0
    local bulletDeath = {}
    for _,v in pairs(danmu) do
        z = z+1
        v.y = v.y + 900*dt
        v.danmu1:setPosition(v.x,v.y)
        if v.y > (display.top + 300 ) then
            a = z
            table.insert(bulletDeath,a)
        else
            for _,s in pairs(enemy) do
                if math.abs(s.y - v.y) < 18 then
                    if  math.abs(s.x - v.x) < 18 then
                        a = z
                        table.insert(bulletDeath,a)
                        if s.y < display.top then
                            s.life = s.life - 20
                        end
                    end
                end
            end
        end
    end

    z = 0
    for _,v in pairs(bulletDeath) do
        danmu[v-z].x = nil
        danmu[v-z].y = nil
        self:removeChild(danmu[v-z].danmu1)
        danmu[v-z].danmu1 = nil
        table.remove(danmu,v-z)
        z = z+1
    end

    z = 0
    local enemyDeath = {}
    for _,v in pairs(enemy) do
        z = z+1
        v.y = v.y -200*dt
        v.enemy1:setPosition(v.x,v.y)
        if v.y <= -100 then 
            a = z
            table.insert(enemyDeath,a)
        elseif v.life <= 0 then
            a = z
            table.insert(enemyDeath,a)
            score = score +10
            score2:setTitleText(score)
        elseif math.abs(v.y - palyerPlane:getPositionY()) <18  then
            if math.abs(v.x - palyerPlane:getPositionX()) <35 then
                hp = hp - 10
                hp2:setTitleText(hp)
                a = z
                table.insert(enemyDeath,a)
            end
        end
    end
    z = 0
    for _,v in pairs(enemyDeath) do
        enemy[v-z].x = nil
        enemy[v-z].y = nil
        self:removeChild(enemy[v-z].enemy1)
        audio.playEffect("texture/sounds/explodeEffect.ogg")
        enemy[v-z].enemy1 = nil
        table.remove(enemy,v-z)
        z = z + 1
    end
end

function play1:onEnter()   
end

function play1:onExit()
end

return play1
