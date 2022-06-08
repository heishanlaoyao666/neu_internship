local BattleScene = class("BattleScene", function()
    return display.newScene("BattleScene")
end)
--全局数值
local life
local score
local gamePanel
local menuPanel
local pausePanel
local gameoverPanel
local playerPlane
local SystemConst = require("app/tools/SystemConst.lua")
--函数定义
local pausePanelBack
local gameoverPanelBack
local lifeChange
local scoreChange
local playerCreate
local bulletCreate
local enemyCreate
local width, height = display.width, display.top
--[[--
    构造函数

    @param none

    @return none
]]
function BattleScene:ctor()
    life=100
    score=0
    --背景区
    self:createBackgroundPanel()
    --精灵区
    gamePanel=self:createSpritePanel()
    --菜单区
    menuPanel=self:createMenuPanel()
    --暂停界面
    pausePanel=self:createPausePanel()
    pausePanelBack(0)
    --游戏结束界面
    gameoverPanel=self:createGameoverPanel()
    gameoverPanelBack(0)
    --self:createPausePanel()
    --音乐
    local MusicOn = cc.UserDefault:getInstance():getBoolForKey("BGM")
    if MusicOn == true then
        local audio3 = require("framework.audio")
        audio3.loadFile("sounds/bgMusic.ogg", function ()
            audio3.playBGM("sounds/bgMusic.ogg")
        end)
    else
        local audio = require("framework.audio")
        audio.loadFile("sounds/bgMusic.ogg", function ()
            audio.stopBGM()
        end)
    end
end

function BattleScene:createBackgroundPanel()
    --全屏菜单区设置
    local bgLayer = ccui.Layout:create()
    bgLayer:setContentSize(width, height)
    bgLayer:setPosition(width*0.5, height *0.5)
    bgLayer:setAnchorPoint(0.5, 0.5)
    --设置背景1
    local bg1=ccui.ImageView:create("img_bg/img_bg_1.jpg")
    local bgX=bg1:getContentSize().width
    local bgY=bg1:getContentSize().height
    bg1:setAnchorPoint(0.5, 0)
    bg1:setScale(width/bgX,height/bgY)
    bg1:pos(width*0.5, 0)
    bg1:addTo(bgLayer)
    --设置背景2
    local bg2=ccui.ImageView:create("img_bg/img_bg_1.jpg")
    bg2:setAnchorPoint(0.5, 0)
    bg2:setScale(width/bgX,height/bgY)
    bg2:pos(width*0.5, height)
    bg2:addTo(bgLayer)
    local function updata(delta)

        --图片往下移动
        for i, v in pairs(bgLayer:getChildren()) do
            local x,y=v:getPosition()
            if y<=height*-1 then
                if(i==1)then
                    local x1,y1=bgLayer:getChildren()[2]:getPosition()
                    v:setPosition(x,y1+height-5)
                else
                    local x1,y1=bgLayer:getChildren()[1]:getPosition()
                    v:setPosition(x,y1+height-5)
                end
                else
                v:setPosition(x,y-5)
            end

        end
    end
    --恢复游戏调度
    function bgLayer:startUpdata()
        
        for i, v in pairs(bgLayer:getChildren()) do
            v:resume()
        end
        bgLayer:resume()
    end
    --暂停游戏调度
    function bgLayer:stopUpdata()
        for i, v in pairs(bgLayer:getChildren()) do
            v:pause()
        end
        bgLayer:pause()
    end
    bgLayer:scheduleUpdateWithPriorityLua(updata,0)
    bgLayer:addTo(self)
end
function BattleScene:createMenuPanel()
    --全屏菜单区设置
    local menuLayer = ccui.Layout:create()
    menuLayer:setContentSize(width, height)
    menuLayer:setPosition(width*0.5, height *0.5)
    menuLayer:setAnchorPoint(0.5, 0.5)
    --inputLayer:setScale9Enabled(true)
    menuLayer:addTo(self)

    --左上角暂停
    local uiPause=ccui.Button:create("ui/battle/uiPause.png","ui/battle/uiPause.png")
    uiPause:setScale(2)
    uiPause:setAnchorPoint(0,1)
    uiPause:pos(0,height)
    uiPause:addTo(menuLayer)
    --点击事件
    uiPause:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			pausePanelBack(1)
		end
	end)
    --上方中间生命值Layout
    local LifeLayer=ccui.Layout:create()
    LifeLayer:setContentSize(width*0.3,height*0.1)
    LifeLayer:setAnchorPoint(0.5,1)
    LifeLayer:setPosition(width*0.4,height)
    LifeLayer:addTo(menuLayer)
    --生命ui
    local uiLife=ccui.ImageView:create("ui/battle/ui_life.png")
    uiLife:setScale(2)
    uiLife:setAnchorPoint(0,0.5)
    uiLife:pos(0,height*0.05)
    uiLife:addTo(LifeLayer)
    --生命text
    local lifeText = ccui.TextBMFont:create(tostring(life), "ui/battle/num_account.fnt")
    lifeText:setScale(0.8)
    lifeText:setAnchorPoint(0.5, 0.5)
    lifeText:pos(width*0.25,height*0.05)
    lifeText:addTo(LifeLayer)

    --上方右边分数值Layout
    local ScoreLayer=ccui.Layout:create()
    ScoreLayer:setContentSize(width*0.3,height*0.1)
    ScoreLayer:setAnchorPoint(0.5,1)
    ScoreLayer:setPosition(width*0.8,height)
    ScoreLayer:addTo(menuLayer)
    --得分ui
    local uiScore=ccui.ImageView:create("ui/battle/ui_score.png")
    uiScore:setScale(2)
    uiScore:setAnchorPoint(0,0.5)
    uiScore:pos(0,height*0.05)
    uiScore:addTo(ScoreLayer)
    --得分text
    local scoreText = ccui.TextBMFont:create(tostring(score), "ui/battle/num_account.fnt")
    scoreText:setScale(0.8)
    scoreText:setAnchorPoint(0.5, 0.5)
    scoreText:pos(width*0.25,height*0.05)
    scoreText:addTo(ScoreLayer)
    
    function menuLayer:updataUI(newlife,newscore)
        lifeText:setString(tostring(newlife))
        scoreText:setString(tostring(newscore))
    end
    return menuLayer
end

function BattleScene:createSpritePanel()
    
    local layer=ccui.Layout:create()
    layer:setContentSize(width, height)
    layer:setPosition(width*0.5, height *0.5)
    layer:setAnchorPoint(0.5, 0.5)
    layer:addTo(self)
    local player=playerCreate()
    layer:addChild(player, 10, SystemConst.GameSceneNodeTag.Fighter)
    --注册敌人飞机
    local enemyCreatetime=0
    local bulletCreatetime=0
    local function updata(delta)
        enemyCreatetime=enemyCreatetime+delta
        bulletCreatetime=bulletCreatetime+delta
        --生成子弹
        if bulletCreatetime>=1 then
            local bullet=bulletCreate()
            local x,y=player:getPosition()
            bullet:setPosition(x,y+player:getContentSize().height*2)
            layer:addChild(bullet, 10, SystemConst.GameSceneNodeTag.Bullet)
            bulletCreatetime=0
        end
        --生成敌人
        if enemyCreatetime>=1 then
            local enemy=enemyCreate()
            layer:addChild(enemy, 10, SystemConst.GameSceneNodeTag.Enemy)
            enemyCreatetime=0
        end
        --进行碰撞检测
        for i, v in pairs(layer:getChildren()) do
            if(v:getTag()==SystemConst.GameSceneNodeTag.Enemy)then
                local rectA=v:getBoundingBox()
                local rectB=player:getBoundingBox()
                if(math.abs(v:getPositionX()-player:getPositionX())*2<=(rectA.width+rectB.width)) 
                and (math.abs(v:getPositionY()-player:getPositionY())*2<=(rectA.height+rectB.height)) then
                    lifeChange(-5)
                    v:Destroy()
                end
            end
        end
    end
    --恢复游戏调度
    function layer:startUpdata()
        
        for i, v in pairs(layer:getChildren()) do
            v:resume()
        end
        layer:resume()
    end
    --暂停游戏调度
    function layer:stopUpdata()
        for i, v in pairs(layer:getChildren()) do
            v:pause()
        end
        layer:pause()
    end
    layer:scheduleUpdateWithPriorityLua(updata,0)

    return layer
end

function enemyCreate()
    local enemy=cc.Sprite:create("player/small_enemy.png")
    enemy:setAnchorPoint(0,0)
    enemy:setContentSize(enemy:getContentSize().width*2,enemy:getContentSize().height*2)
    enemy:setScale(2)
    enemy:setPosition((width-enemy:getContentSize().width)*math.random(0,10)*0.1,height+enemy:getContentSize().height)
    local function updata(delta)
        --飞机移动
        local x,y=enemy:getPosition()
        enemy:setPosition(x,y-5)
        if y>(height+enemy:getContentSize().height) then
            enemy:removeFromParent()
            return
        end
        --碰撞检测
    end
    enemy:scheduleUpdateWithPriorityLua(updata,0)

    function enemy:Destroy()
        --销毁
        enemy:removeFromParent()
    end
    return enemy
end

function playerCreate(node)
        --玩家飞机
    playerPlane=cc.Sprite:create("player/red_plane.png")
    playerPlane:setAnchorPoint(0.5,0)
    playerPlane:setPosition(width*0.5,0)
    playerPlane:setScale(2)  
    --添加粒子
    local particleSystem=cc.ParticleSystemQuad:create("particle/fire.plist")
    particleSystem:setAnchorPoint(0.5,1)
    particleSystem:setPosition(playerPlane:getContentSize().width*0.5, 0)
    particleSystem:rotation(180)
    particleSystem:addTo(playerPlane)
    --玩家飞机触控
    
    playerPlane:addNodeEventListener(cc.NODE_TOUCH_EVENT,function (event)
        local x=playerPlane:getContentSize().width
        --不明确
        if event.name=="began" then
            return true
            elseif event.name=="moved" then
                index=event.prevX
                if index>display.right-x-10 then
                    index=display.right-x-10
                end
                if index<display.left+x+10 then
                    index=display.left+x+10
                end
                playerPlane:pos(index,playerPlane:getContentSize().height)
        end
    end)
    playerPlane:setTouchMode(cc.TOUCHES_ONE_BY_ONE)
    playerPlane:setTouchEnabled(true)
    return playerPlane
end
function bulletCreate()
    local bullet=cc.Sprite:create("player/blue_bullet.png")
    bullet:setAnchorPoint(0.5,0)
    --音效
    local MusicOn = cc.UserDefault:getInstance():getBoolForKey("Effect")
    if MusicOn == true then
        local audio3 = require("framework.audio")
        audio3.loadFile("sounds/fireEffect.ogg", function ()
            audio3.playEffect("sounds/fireEffect.ogg")
        end)
    end
    local function updata(delta)
        --子弹移动
        local x,y=bullet:getPosition()
        if y>(height+bullet:getContentSize().height) then
            bullet:removeFromParent()
            return
            else
                bullet:setPosition(x,y+1.5)
        end

        --碰撞检测
    end
    bullet:scheduleUpdateWithPriorityLua(updata,0)

    function bullet:Destroy()
        --销毁

    end
    return bullet
end
function BattleScene:createPausePanel()
    --暂停界面容器设置
    local pauseLayout = ccui.Layout:create()
    pauseLayout:setContentSize(width, height)
    pauseLayout:setPosition(width*0.5, height *0.5)
    pauseLayout:setAnchorPoint(0.5, 0.5)
    pauseLayout:addTo(self)
    
    --半透明蒙层
    local pauseLayer = ccui.Layout:create()
    pauseLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    pauseLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    pauseLayer:setBackGroundColorOpacity(128)--设置透明度
    pauseLayer:setContentSize(width, height)
    pauseLayer:pos(width*0.5, height *0.5)
    pauseLayer:setAnchorPoint(0.5, 0.5)
    pauseLayer:addTo(pauseLayout)

    --继续按钮
    local continueButton = ccui.Button:create("ui/continue/pauseResume.png", "ui/continue/pauseResume.png")
    continueButton:setAnchorPoint(0.5, 0)
    continueButton:pos(width * 0.5, height*0.5)
	--continueButton:setTitleFontSize(20)
    continueButton:addTo(pauseLayout)
    -- 点击事件
    continueButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			pausePanelBack(0)
		end
	end)

    --返回主界面按钮
    local backroomButton = ccui.Button:create("ui/continue/pauseBackRoom.png", "ui/continue/pauseBackRoom.png")
    backroomButton:setAnchorPoint(0.5, 1)
    backroomButton:pos(width * 0.5, height*0.5)
	--continueButton:setTitleFontSize(20)
    backroomButton:addTo(pauseLayout)
    -- 点击事件
    backroomButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			print("返回菜单")
            --TODO数据处理
            --返回主界面
            local nextScene=import("app/scenes/MainScene"):new()
            display.replaceScene(nextScene)
		end
	end)

    --返回暂停界面
    return pauseLayout
end

function BattleScene:createGameoverPanel()
    --游戏结束界面容器设置
    local gameoverLayout = ccui.Layout:create()
    gameoverLayout:setContentSize(width, height)
    gameoverLayout:setPosition(width*0.5, height *0.5)
    gameoverLayout:setAnchorPoint(0.5, 0.5)
    gameoverLayout:addTo(self)
    
    --半透明蒙层
    local gameoverLayer = ccui.Layout:create()
    gameoverLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    gameoverLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    gameoverLayer:setBackGroundColorOpacity(128)--设置透明度
    gameoverLayer:setContentSize(width, height)
    gameoverLayer:pos(width*0.5, height *0.5)
    gameoverLayer:setAnchorPoint(0.5, 0.5)
    gameoverLayer:addTo(gameoverLayout)

    --重新开始按钮
    local restartButton = ccui.Button:create("ui/gameover/restart.png", "ui/gameover/restart.png")
    restartButton:setAnchorPoint(0.5, 0)
    restartButton:pos(width * 0.5, height*0.4)
	--continueButton:setTitleFontSize(20)
    restartButton:addTo(gameoverLayout)
    -- 点击事件
    restartButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
            --重新开始游戏
			gameoverPanelBack(0)
		end
	end)

    --返回主界面按钮
    local backButton = ccui.Button:create("ui/gameover/back.png", "ui/gameover/back.png")
    backButton:setAnchorPoint(0.5, 1)
    backButton:pos(width * 0.5, height*0.4)
	--continueButton:setTitleFontSize(20)
    backButton:addTo(gameoverLayout)
    -- 点击事件
    backButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			print("返回菜单")
            --TODO数据处理
            --返回主界面
            local nextScene=import("app/scenes/MainScene"):new()
            display.replaceScene(nextScene)
		end
	end)

    --返回暂停界面
    return gameoverLayout
end
function pausePanelBack(scale)
    if tonumber(scale)==1 then
        gamePanel:stopUpdata()
        else
            gamePanel:startUpdata()
    end
    pausePanel:setScale(tonumber(scale))
end

function gameoverPanelBack(scale)
    gameoverPanel:setScale(tonumber(scale))
    
end

function lifeChange(number)
    life=life+tonumber(number)
    menuPanel:updataUI(life,score)
end

function scoreChange(number)
    score=score+tonumber(number)
end

function BattleScene:onEnter()
end

function BattleScene:onExit()
end


return BattleScene