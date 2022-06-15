
local FightingScene = class("FightingScene", function()
    return display.newScene("FightingScene")
end)

function FightingScene:ctor()
    self:bgRoll()--背景滚动
    self:pausePanel()--暂停面板
    self:planeCreate()--飞机与敌机处理事件
    self:topPanel()--顶部生命与分数面板
end

--[[
    函数用途：制作游戏背景的无限滚动
    --]]
function FightingScene:bgRoll()
    --主界面背景图
    bg1 = display.newSprite("img_bg/img_bg_1.jpg")
                 :pos(display.cx,display.cy+280)
                 :setAnchorPoint(0.5,0.5)
                 :addTo(self)
    bg2 = display.newSprite("img_bg/img_bg_1.jpg")
                 :pos(display.cx,display.cy+1280+280)
            :setAnchorPoint(0.5,0.5)
                 :addTo(self)
    bgroll = cc.Director:getInstance():getScheduler()
    bgroll_handler = bgroll:scheduleScriptFunc(--背景滚动移动定时器
            function()
                if bg1:getPositionY() == -640 then
                    bg1:setPosition(display.cx,display.cy+1280+280)
                end
                if bg2:getPositionY() == -640 then
                    bg2:setPosition(display.cx,display.cy+1280+280)
                end
                bg1:setPosition(display.cx,bg1:getPositionY()-2)
                bg2:setPosition(display.cx,bg2:getPositionY()-2)
            end,1/60,false)
end

--[[
    函数用途：播放音效
    --]]
function FightingScene:playEffect(path)
    local effectPath = path
    local audio = require("framework.audio")
    audio.loadFile(effectPath,function()
        audio.playEffect(effectPath,false)
    end)
end


--[[
    函数用途：刷新生命与分数
    --]]
function FightingScene:topPanel()
    life = display.newSprite("ui/battle/ui_life.png")--飞机生命
                  :pos(120,690)
                  :setAnchorPoint(0.5,0.5)
                  :addTo(self)
    life_num = 20--初始生命为100
    lifeLabel = cc.Label:createWithTTF(life_num,"font/FontNormal.ttf",25)
    lifeLabel:setPosition(170,690)
    lifeLabel:setColor(cc.c3b(255,128,0))
    lifeLabel:addTo(self)
    lifeNum = cc.Director:getInstance():getScheduler()--刷新生命计时器
    lifeNum_handler = lifeNum:scheduleScriptFunc(
            function()
                lifeLabel:setString(life_num)
            end,1/60,false)

    score = display.newSprite("ui/battle/ui_score.png")--得分
                   :pos(250,690)
                   :setAnchorPoint(0.5,0.5)
                   :addTo(self)
    score_num = 0--初始为0分
    scoreLabel = cc.Label:createWithTTF(score_num,"font/FontNormal.ttf",25)
    scoreLabel:setPosition(300,690)
    scoreLabel:setColor(cc.c3b(255,128,0))
    scoreLabel:addTo(self)
    scoreNum = cc.Director:getInstance():getScheduler()--刷新得分计时器
    scoreNum_handler = scoreNum:scheduleScriptFunc(
            function()
                scoreLabel:setString(score_num)
            end,1/60,false)
end

--[[
    函数用途：实现爆炸动画
     --]]
function FightingScene:boomAnimation(X,Y)
    local x = X
    local y = Y
    display.addSpriteFrames("explosion.plist","explosion.png")
    frames = display.newFrames("explosion_%02d.png",1,35)
    animation = display.newAnimation(frames,2/60)--2秒内播放60帧
    animation:setRestoreOriginalFrame(true)
    animate = cc.Animate:create(animation)
    sprite = display.newSprite("#explosion_01.png")
    sprite:setPosition(x,y)
    sprite:addTo(self)
    sprite:runAction(animate)
end

function FightingScene:planeCreate()

    --飞机层
    planeLayer = ccui.Layout:create()
    planeLayer:setBackGroundColor(cc.c3b(128, 128, 128))--设置为白色
    planeLayer:setBackGroundColorOpacity(180)--设置为半透明
    planeLayer:setContentSize(480, 720)--占满全屏
    planeLayer:setPosition(0, display.top)--左上角
    planeLayer:setAnchorPoint(0, 1)
    planeLayer:addTo(self)

    --使用图片创建飞机精灵
    plane = cc.Sprite:create("player/red_plane.png")
    plane:setAnchorPoint(0, 1)
    plane:addTo(planeLayer)
    plane:setPosition(200,100)

    --*****************************使用图片创建敌方飞机*****************************
    enemy1 = cc.Sprite:create("player/small_enemy.png")
    enemy1:setScale(1.2,1.2)
    enemy1:setPosition(100,900)
    enemy1:setAnchorPoint(0, 1)
    enemy1:addTo(planeLayer)

    enemy2 = cc.Sprite:create("player/small_enemy.png")
    enemy2:setScale(1.2,1.2)
    enemy2:setPosition(220,900)
    enemy2:setAnchorPoint(0, 1)
    enemy2:addTo(planeLayer)

    enemy3 = cc.Sprite:create("player/small_enemy.png")
    enemy3:setScale(1.2,1.2)
    enemy3:setPosition(340,900)
    enemy3:setAnchorPoint(0, 1)
    enemy3:addTo(planeLayer)

    --*****************************创建敌方飞机出生计时器*****************************

    --敌机1出生计时器
    enemyBorn1 = cc.Director:getInstance():getScheduler()
    enemyBorn1_handler = enemyBorn1:scheduleScriptFunc(
            function()
                if enemy1:getPositionY() == 800  then--800即被击中暂时挪到屏幕外，0即为未击中自行回到初始位置
                    enemy1:setPosition(100,900)
                    print("enemy1:reborn")

                elseif enemy1:getPositionY() == 900   then--一开始的移动
                    print("enemy1:startMove")
                    Y1 = enemy1:getPositionY()

                    enemyFly1 = cc.Director:getInstance():getScheduler()
                    enemyFly1_handler = enemyFly1:scheduleScriptFunc(--敌机1移动定时器
                            function()
                                enemy1:setPosition(100,Y1)
                                Y1 = Y1-2
                            end,1/60,false)

                elseif enemy1:getPositionY() < 0  then--未击中自行回到初始位置
                    Y1 = 900
                    enemy1:setPosition(800,800)
                    print("enemy1:reborn")
                end
            end,1/60,false)

    --敌机2出生计时器
    enemyBorn2 = cc.Director:getInstance():getScheduler()
    enemyBorn2_handler = enemyBorn2:scheduleScriptFunc(
            function()
                if enemy2:getPositionY() == 800  then--800即被击中暂时挪到屏幕外，0即为未击中自行回到初始位置
                    enemy2:setPosition(220,900)
                    print("enemy2:reborn")

                elseif enemy2:getPositionY() == 900   then--一开始的移动
                    print("enemy2:startMove")
                    Y2 = enemy2:getPositionY()
                    enemyFly2 = cc.Director:getInstance():getScheduler()
                    enemyFly2_handler = enemyFly2:scheduleScriptFunc(--敌机2移动定时器
                            function()
                                enemy2:setPosition(220,Y2)
                                Y2 = Y2-2
                            end,1/60,false)

                elseif enemy2:getPositionY() < 0  then--未击中自行回到初始位置
                    Y2 = 900
                    enemy2:setPosition(800,800)
                    print("enemy2:reborn")
                end
            end,1/60,false)

    --敌机3出生计时器
    enemyBorn3 = cc.Director:getInstance():getScheduler()
    enemyBorn3_handler = enemyBorn3:scheduleScriptFunc(
            function()
                if enemy3:getPositionY() == 800  then--800即被击中暂时挪到屏幕外，0即为未击中自行回到初始位置
                    enemy3:setPosition(340,900)
                    print("enemy3:reborn")

                elseif enemy3:getPositionY() == 900   then--一开始的移动
                    print("enemy3:startMove")
                    Y3 = enemy3:getPositionY()
                    enemyFly3 = cc.Director:getInstance():getScheduler()
                    enemyFly3_handler = enemyFly3:scheduleScriptFunc(--敌机1移动定时器
                            function()
                                enemy3:setPosition(340,Y3)
                                Y3 = Y3-2
                            end,1/60,false)

                elseif enemy3:getPositionY() < 0  then--未击中自行回到初始位置
                    Y3 = 900
                    enemy3:setPosition(800,800)
                    print("enemy1:reborn")
                end
            end,1/60,false)


    --*****************************生成飞机拖尾粒子*****************************
    local ps = cc.ParticleSystemQuad:create("particle/fire.plist")
    ps:setRotation(180)
    ps:setPosition(plane:getPositionX()+25,plane:getPositionY()-50)
    ps:addTo(planeLayer)

    --*****************************子弹的生成与移动*****************************
    bulletBorn = cc.Director:getInstance():getScheduler()
    bulletBorn_handler = bulletBorn:scheduleScriptFunc(function()--子弹生成定时器
        self:playEffect("sounds/fireEffect.ogg")--播放子弹发射音效
        local bullet = cc.Sprite:create("player/blue_bullet.png")
        bullet:addTo(planeLayer)

        local X = plane:getPositionX()+25--获取飞机所在位置并移动25点距离作为子弹出生的X坐标
        bullet:setPosition(plane:getPositionX()+25,plane:getPositionY()+20)--子弹出生点坐标

        bulletFly = cc.Director:getInstance():getScheduler()
        bulletFly_handler = bulletFly:scheduleScriptFunc(function()--子弹移动定时器
                bullet:setPosition(X,bullet:getPositionY()+20)--子弹定时向上移动
                local rect = bullet:getBoundingBox()--获取子弹的矩形区域
                local e1 = enemy1:getBoundingBox()--获取敌方飞机1的矩形区域
                local e2 = enemy2:getBoundingBox()--获取敌方飞机2的矩形区域
                local e3 = enemy3:getBoundingBox()--获取敌方飞机3的矩形区域

                 if  cc.rectIntersectsRect(rect,e1) then--如果矩形区域相交则将敌方飞机1移出屏幕外
                     print("hit on")
                     self:boomAnimation(enemy1:getPositionX()+20,enemy1:getPositionY()-20)--开始爆炸动画
                     self:playEffect("sounds/explodeEffect.ogg")
                     enemy1:setPosition(800,800)--敌机移出屏幕外
                     score_num = score_num+10--得到分数
                     bullet:setPosition(100,1000)--子弹消失在屏幕中
                     Y1 = 900

                     elseif  cc.rectIntersectsRect(rect,e2) then--如果矩形区域相交则将敌方飞机2移出屏幕外
                     print("hit on")
                     self:boomAnimation(enemy2:getPositionX()+20,enemy2:getPositionY()-20)
                     self:playEffect("sounds/explodeEffect.ogg")
                     enemy1:setPosition(800,800)--移出屏幕外
                     score_num = score_num+10
                     bullet:setPosition(100,1000)
                     Y2 = 900

                    elseif  cc.rectIntersectsRect(rect,e3) then--如果矩形区域相交则将敌方飞机3移出屏幕外
                     print("hit on")
                     self:boomAnimation(enemy3:getPositionX()+20,enemy3:getPositionY()-20)
                     self:playEffect("sounds/explodeEffect.ogg")
                     enemy3:setPosition(800,800)--移出屏幕外
                     score_num = score_num+10
                     bullet:setPosition(100,1000)
                     Y3 = 900

                end
            end,1/30,false)--子弹向上移动计时器
        end,1/2,false)

    --*****************************检测敌人与飞机的碰撞并削减飞机生命值*****************************
    boomEvent = cc.Director:getInstance():getScheduler()
    boomEvent_handler = boomEvent:scheduleScriptFunc(function()--检测碰撞定时器
        local planeRect = plane:getBoundingBox()--获取飞机的矩形区域
        local e1 = enemy1:getBoundingBox()--获取敌方飞机1的矩形区域
        local e2 = enemy2:getBoundingBox()--获取敌方飞机1的矩形区域
        local e3 = enemy3:getBoundingBox()--获取敌方飞机1的矩形区域

        --若生命值为0结束游戏并进入结算界面
        if life_num == 0 then
            finalScore = score_num--取最后的分数
            self:endPanel()--打开结算面板
        end

        if  cc.rectIntersectsRect(planeRect,e1) then--如果矩形区域相交则将敌方飞机1移出屏幕外
            self:boomAnimation(enemy1:getPositionX()+20,enemy1:getPositionY()-20)--播放爆炸动画
            self:playEffect("sounds/shipDestroyEffect.ogg")--播放爆炸音效
            enemy1:setPosition(800,800)--将敌人移出屏幕外
            Y1 = 900
            life_num = life_num-20--生命值削减20

        elseif  cc.rectIntersectsRect(planeRect,e2) then--如果矩形区域相交则将敌方飞机2移出屏幕外
            self:boomAnimation(enemy2:getPositionX()+20,enemy2:getPositionY()-20)
            self:playEffect("sounds/shipDestroyEffect.ogg")
            enemy2:setPosition(800,800)--移出屏幕外
            Y2 = 900
            life_num = life_num-20


        elseif  cc.rectIntersectsRect(planeRect,e3) then--如果矩形区域相交则将敌方飞机3移出屏幕外
            self:boomAnimation(enemy3:getPositionX()+20,enemy3:getPositionY()-20)
            self:playEffect("sounds/shipDestroyEffect.ogg")
            enemy3:setPosition(800,800)--移出屏幕外
            Y3 = 900
            life_num = life_num-20
        end

    end,1/60,false)


    --*****************************屏幕触摸事件：处理飞机和拖尾粒子的位移*****************************
    local listener = cc.EventListenerTouchOneByOne:create()--单点触摸

    local function onTouchBegan(touch, event)
        local target = event:getCurrentTarget()
        local size = target:getContentSize()
        local rect = cc.rect(0, 0, size.width, size.height)
        local p = touch:getLocation()
        p = target:convertTouchToNodeSpace(touch)
        if cc.rectContainsPoint(rect, p) then
            return true
        end
        return false
    end

    local function onTouchMoved(touch, event)
        local location = touch:getStartLocationInView()
        local x1 = location["x"] or 0
        --print(x1 )
        --local y1 = location["y"] or 0
        --print(y1)
        local location2 = touch:getLocationInView()
        local x2 = location2["x"] or 0
        --print(x2)
        --local y2 = location2["y"] or 0
        --print(y2)
        if x1<x2 then
            if x2<430 then
                plane:setPosition(x2,plane:getPositionY())
                ps:setPosition(x2+25,plane:getPositionY()-50)
            end
        elseif x1>x2 then
            if x2>0 then
                plane:setPosition(x2,plane:getPositionY())
                ps:setPosition(x2+25,plane:getPositionY()-50)
            end
        end
        --print("move")
    end
    local function onTouchEnded(touch, event)
        print("触摸事件")
    end

    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, plane)--将事件绑定在飞机上

    return planeLayer
end

--[[
    函数用途：点击暂停按钮弹出暂停菜单
    --]]
function FightingScene:pausePanel()
    --暂停按钮的设置
    pauseButton = ccui.Button:create("ui/battle/uiPause.png","ui/battle/uiPause.png")
    pauseButton:setScale(1,1)
    pauseButton:pos(50 , 690)
    pauseButton:setAnchorPoint(0.5,0.5)
    pauseButton:addTouchEventListener(function(sender,eventType)
        if eventType == ccui.TouchEventType.ended then--弹出暂停菜单
            pauseButton:setVisible(false)--隐藏返回按钮
            audio.stopBGM()--停止当前背景音乐
            cc.Director:getInstance():getScheduler():setTimeScale(0)--全局游戏停止

            --暂停页面的设置
            pauseLayer = ccui.Layout:create()
            pauseLayer:setBackGroundColor(cc.c3b(128, 128, 128))--设置为红色
            pauseLayer:setBackGroundColorOpacity(180)--设置为半透明
            pauseLayer:setBackGroundColorType(1)
            pauseLayer:setContentSize(480, 720)--占满全屏
            pauseLayer:setPosition(0, display.top)--左上角
            pauseLayer:setAnchorPoint(0, 1)
            pauseLayer:addTo(self)

            --按钮：继续游戏
            local continueButton = ccui.Button:create("pauseResume.png","pauseResume.png")
            continueButton:setScale(1.2,1.2)
            continueButton:pos(250 , 500)
            continueButton:setAnchorPoint(0.5,0.5)
            continueButton:addTouchEventListener(function(sender,eventType)
                if eventType == ccui.TouchEventType.ended then--回到游戏
                    pauseLayer:setVisible(false)
                    pauseButton:setVisible(true)--隐藏返回按钮
                    cc.Director:getInstance():getScheduler():setTimeScale(1)--全局游戏恢复
                    self:playMainMusic("sounds/bgMusic.ogg")--播放战斗音乐
                end
            end)
            continueButton:addTo(pauseLayer)

            --按钮：返回主界面
            local backButton = ccui.Button:create("pauseBackRoom.png","pauseBackRoom.png")
            backButton:setScale(1.2,1.2)
            backButton:pos(250 , 300)
            backButton:setAnchorPoint(0.5,0.5)
            backButton:addTouchEventListener(function(sender,eventType)
                if eventType == ccui.TouchEventType.ended then--跳转至主界面
                    self:stopAllSchedules()--停止所有计时器
                    cc.Director:getInstance():getScheduler():setTimeScale(1)--全局游戏开始
                    local mainScene = import("app.scenes.MainScene"):new()
                    display.replaceScene(mainScene,"turnOffTiles",0.5)
                    print(transform)
                end
            end)
            backButton:addTo(pauseLayer)
        end
    end)
    pauseButton:addTo(self)
end

--[[
    函数用途：游戏结束界面
    --]]
function FightingScene:endPanel()
    cc.Director:getInstance():getScheduler():setTimeScale(0)--全局游戏停止
    audio.stopBGM()--停止当前背景音乐
    --结束页面
    endLayer = ccui.Layout:create()
    endLayer:setBackGroundColor(cc.c3b(128, 128, 128))--设置为红色
    endLayer:setBackGroundColorOpacity(180)--设置为透明
    endLayer:setBackGroundColorType(1)
    endLayer:setContentSize(480, 720)--占满全屏
    endLayer:setPosition(0, display.top)--左上角
    endLayer:setAnchorPoint(0, 1)
    endLayer:addTo(self)
    --得分区域
    endScore = cc.Label:createWithTTF("分数","font/FontNormal.ttf",50)
    endScore:setPosition(290,550)
    endScore:setColor(cc.c3b(255,128,0))
    endScore:addTo(endLayer)
    endScoreLabel = cc.Label:createWithTTF(finalScore,"font/FontNormal.ttf",50)
    endScoreLabel:setPosition(380,550)
    endScoreLabel:setColor(cc.c3b(255,128,0))
    endScoreLabel:addTo(endLayer)
    --昵称区域
    endNameLabel = cc.Label:createWithTTF("星尘","font/FontNormal.ttf",50)
    endNameLabel:setPosition(100,550)
    endNameLabel:setColor(cc.c3b(255,128,0))
    endNameLabel:addTo(endLayer)
    --返回菜单按钮
    backToMainButton = ccui.Button:create("ui/gameover/back.png","ui/gameover/back.png")
    backToMainButton:setScale(1.2,1.2)
    backToMainButton:pos(250 , 300)
    backToMainButton:setAnchorPoint(0.5,0.5)
    backToMainButton:addTouchEventListener(function(sender,eventType)
        if eventType == ccui.TouchEventType.ended then--跳转至菜单界面
            self:stopAllSchedules()
            cc.Director:getInstance():getScheduler():setTimeScale(1)--全局游戏开始
            local mainScene = import("app.scenes.MainScene"):new()
            display.replaceScene(mainScene,"turnOffTiles",0.5)
            print(transform)
        end
    end)
    backToMainButton:addTo(endLayer)
    --重新开始按钮
    restartButton = ccui.Button:create("ui/gameover/restart.png","ui/gameover/restart.png")
    restartButton:setScale(1.2,1.2)
    restartButton:pos(250 , 400)
    restartButton:setAnchorPoint(0.5,0.5)
    restartButton:addTouchEventListener(function(sender,eventType)
        if eventType == ccui.TouchEventType.ended then--初始化所有参数
        print(restartScene)
        endLayer:setVisible(false)
        plane:setPosition(200,100)
        life_num = 100
        score_num = 0
        enemy1:setPosition(100,900)
        enemy2:setPosition(220,900)
        enemy3:setPosition(340,900)
        Y1 = 900
        Y2 = 900
        Y3 = 900
        cc.Director:getInstance():getScheduler():setTimeScale(1)--全局游戏开始
        self:playMainMusic("sounds/bgMusic.ogg")--播放战斗音乐
    end
    end)
    restartButton:addTo(endLayer)

end


--[[
    函数用途：播放背景音乐
    --]]
function FightingScene:playMainMusic(path)
    local musicPath = path
    audio = require("framework.audio")
    audio.loadFile(musicPath,function()
        audio.playBGM(musicPath,isLoop)
    end)
end

--[[
    函数用途：停止所有定时器
    --]]
function FightingScene:stopAllSchedules()
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(bgroll_handler)

        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(bulletFly_handler)
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(bulletBorn_handler)

        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(enemyFly1_handler)
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(enemyFly2_handler)
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(enemyFly3_handler)

        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(enemyBorn1_handler)
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(enemyBorn2_handler)
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(enemyBorn3_handler)

        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(scoreNum_handler)
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(lifeNum_handler)
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(boomEvent_handler)
end

function FightingScene:onEnter()

end

function FightingScene:onExit()
end

return FightingScene

