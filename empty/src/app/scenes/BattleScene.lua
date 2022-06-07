local BattleScene = class("BattleScene", function()
    return display.newScene("BattleScene")
end)
--全局数值
local life
local score
local gamePanel
local pausePanel
local gameoverPanel
local playerPlane
local size=cc.Director:getInstance():getWinSize()
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

    --精灵区
    gamePanel=self:createSpritePanel()

    --菜单区
    self:createMiddleMiddlePanel()
    --暂停界面
    pausePanel=self:createPausePanel()
    pausePanelBack(0)
    --游戏结束界面
    gameoverPanel=self:createGameoverPanel()
    gameoverPanelBack(0)
    --self:createPausePanel()
end


function BattleScene:createMiddleMiddlePanel()
    --全屏菜单区设置
    local battleLayer = ccui.Layout:create()
    battleLayer:setContentSize(width, height)
    battleLayer:setPosition(width*0.5, height *0.5)
    battleLayer:setAnchorPoint(0.5, 0.5)
    --inputLayer:setScale9Enabled(true)
    battleLayer:addTo(self)

    --左上角暂停
    local uiPause=ccui.Button:create("ui/battle/uiPause.png","ui/battle/uiPause.png")
    uiPause:setScale(2)
    uiPause:setAnchorPoint(0,1)
    uiPause:pos(0,height)
    uiPause:addTo(battleLayer)
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
    LifeLayer:addTo(battleLayer)
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
    ScoreLayer:addTo(battleLayer)
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
end

function BattleScene:createSpritePanel()
    
    local layer=ccui.Layout:create()
    layer:setContentSize(width, height)
    layer:setPosition(width*0.5, height *0.5)
    layer:setAnchorPoint(0.5, 0.5)
    layer:addTo(self)

    playerCreate(layer)
    --注册敌人飞机
    local enemyCreatetime=0
    local function updata(delta)

        enemyCreatetime=enemyCreatetime+delta
        if enemyCreatetime>=1 then
            enemyCreate(layer)
            enemyCreatetime=0
        end
        

    end

    --开始游戏调度
    local function onNodeEvent(tag)
        if tag=="exit"then
            --停止游戏调度
            layer:unscheduleUpdate()
        end
    end
    layer:registerScriptHandler(onNodeEvent)
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

function enemyCreate(node)
    local enemy=cc.Sprite:create("player/small_enemy.png")
    enemy:setAnchorPoint(0.5,0.5)
    enemy:setPosition(enemy:getContentSize().width,enemy:getContentSize().height)
    enemy:setScale(2)
    enemy:setPosition((width-enemy:getContentSize().width)*math.random(0,10)*0.1+enemy:getContentSize().width,height+enemy:getContentSize().height)
    local function updata(delta)
        --飞机移动
        local x,y=enemy:getPosition()
        enemy:setPosition(x,y-1)
        --碰撞检测
    end
    enemy:scheduleUpdateWithPriorityLua(updata,0)

    function enemy:Destroy()
        --销毁
        enemy:removeFromParent()
    end
    enemy:addTo(node)
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
    local bulletCreatetime=0
    local function updata(delta)
        bulletCreatetime=bulletCreatetime+delta
        if bulletCreatetime>=1 then
            bulletCreate(node,playerPlane)
            bulletCreatetime=0
        end
    end
    playerPlane:scheduleUpdateWithPriorityLua(updata,0)

    playerPlane:setTouchMode(cc.TOUCHES_ONE_BY_ONE)
    playerPlane:setTouchEnabled(true)
    playerPlane:addTo(node)
    return playerPlane
end
function bulletCreate(node,playerPlane)
    local bullet=cc.Sprite:create("player/blue_bullet.png")
    bullet:setAnchorPoint(0.5,0)
    local playerx,playery=playerPlane:getPosition()
    bullet:setPosition(playerx,playery+playerPlane:getContentSize().height*2)
    local function updata(delta)
        --子弹移动
        local x,y=bullet:getPosition()
        bullet:setPosition(x,y+1.5)
        --碰撞检测
    end
    bullet:scheduleUpdateWithPriorityLua(updata,0)

    function bullet:Destroy()
        --销毁

    end
    bullet:addTo(node)
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
end

function scoreChange(number)
    score=score+tonumber(number)
end
function BattleScene:onEnter()
end

function BattleScene:onExit()
end


return BattleScene