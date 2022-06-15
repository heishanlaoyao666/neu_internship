-- 模块变量

-- 分数
local score = 0
-- 记录0~999分数
local scorePlaceholder = 0
-- 大小
local size = cc.Director:getInstance():getWinSize()

local schedulerId = nil
local sharedScheduler = cc.Director:getInstance():getScheduler()
-- 主游戏层
local mainLayer
-- 暂停层
local pauseLayer


local defaults = cc.UserDefault:getInstance()

--


-- 引入其他依赖文件
local Enemy = require("app.scenes.Enemy")
local Fighter = require("app.scenes.Fighter")
local Bullet = require("app.scenes.Bullet")
local SystemConst = require("app.scenes.SystemConst")



local ThirdScene = class("GamePlayScene", function()
	local scene = cc.Scene:createWithPhysics()
	-- scene:getPhysicsWorld():setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
	-- 不受重力影响
	scene:getPhysicsWorld():setGravity(cc.p(0,0))
    return scene
end)


function ThirdScene.create()
	local scene = ThirdScene.new()
	return scene
end

function ThirdScene:ctor()
	print("GamePlayScene Init.")

	-- 添加背景层
	self:addChild(self:createInitBGLayer())

	-- 场景生命周期事件处理
	local function onNodeEvent(event)
		if event == "enter" then
			self:onEnter()
		elseif event == "enterTransitionFinish" then
			self:onEnterTransitionFinish()
		elseif event == "exit" then
			self:onExit()
		elseif event == "exitTransitionStart" then
			self:onExitTransitionStart()
		elseif event == "cleanup" then
			self:cleanup()
		end
	end

	self:registerScriptHandler(onNodeEvent)
end


-- 创建背景层
function ThirdScene:createInitBGLayer()
	print("背景层初始化")
	local bg = cc.Sprite:create("img_bg/bg.jpg")
    bg:setPosition(cc.p(size.width/2, size.height/2))
    bg:setScale(0.8, 0.8)
    return bg
end


function ThirdScene:onExit()
	print("GameScene onExit")

	-- 停止游戏调度
	if(schedulerId ~= nil) then
		sharedScheduler:unscheduleScriptEntry(schedulerId)
	end

	-- 注销事件监听器
	local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

	if nil ~= touchFighterListener then
		eventDispatcher:removeEventListener(touchFighterListener)
	end

	if nil ~= contactListener then
		eventDispatcher:removeEventListener(contactListener)
	end

	-- 删除layer节点以及其子节点
	mainLayer:removeAllChildren()
	mainLayer:removeFromParent()
	mainLayer = nil

end


function ThirdScene:onEnter()
	print("GameScene onEnter")
	-- self:addChild(self:createLayer())
	self:createLayer()

end


-- 创建游戏主层
function ThirdScene:createLayer()

	--- 主体栏
	

    mainLayer = ccui.Layout:create()
    -- mainLayer:setBackGroundColor(cc.c3b(24, 78, 168))
    -- mainLayer:setBackGroundColorType(1)
    mainLayer:setContentSize(display.width, display.height)
    mainLayer:setPosition(display.cx, 0)
    mainLayer:setAnchorPoint(0.5, 0)
    mainLayer:setCascadeOpacityEnabled(true)
    mainLayer:setOpacity(1 * 255)

	-- 添加敌机
	local enemyFighter1 = Enemy.create()
	mainLayer:addChild(enemyFighter1, 10, SystemConst.GameSceneNodeTag.Enemy)

	local enemyFighter2 = Enemy.create()
	mainLayer:addChild(enemyFighter2, 10, SystemConst.GameSceneNodeTag.Enemy)

	local enemyFighter3 = Enemy.create()
	mainLayer:addChild(enemyFighter3, 10, SystemConst.GameSceneNodeTag.Enemy)


	-- 添加玩家
	fighter = Fighter.create("player/red_plane.png")
	fighter:setPos(cc.p(size.width/2, 70))
	print(fighter)
	mainLayer:addChild(fighter, 10, SystemConst.GameSceneNodeTag.Fighter)
	-- 发射子弹
	local function shootBullet(delta)
		if nil ~= fighter and fighter:isVisible() then

			local SettingMusic = require("src/app/scenes/SettingMusic")
			local MusicOn = SettingMusic:isMusic()
			--print(MusicOn)
			if MusicOn == true then
				local audio3 = require("framework.audio")
				audio3.loadFile("sounds/fireEffect.ogg", function ()
					audio3.playEffect("sounds/fireEffect.ogg")
				end)
			else

				local audio = require("framework.audio")
				audio.loadFile("sounds/buttonEffet.ogg", function ()
					audio.stopEffect("sounds/buttonEffet.ogg")
				end)
			end

			local bullet = Bullet.create(SystemConst.BulletName)
			mainLayer:addChild(bullet, 0, SystemConst.GameSceneNodeTag.Bullet)
			bullet:shootBulletFromFighter(fighter)
		end
	end

	--- 添加状态栏

	-- 生命值的标签
	local lifeImg = ccui.ImageView:create(SystemConst.LifeName)
	lifeImg:setPosition(80, size.height - 30)
	lifeImg:setAnchorPoint(cc.p(0 ,0))
	lifeImg:setScale(1, 1)
	mainLayer:addChild(lifeImg, 20)

	-- 得分标签
	local scoreImg = ccui.ImageView:create(SystemConst.ScoreName)
	scoreImg:setPosition(200, size.height - 30)
	scoreImg:setAnchorPoint(cc.p(0 ,0))
	scoreImg:setScale(1, 1)
	mainLayer:addChild(scoreImg, 20)

	--- 回调函数

	-- 接触检测事件回调函数
	local function touchBegan(touch, event)
		return true
	end

	-- 接触检测事件回调函数
	local function touchMoved(touch, event)

		-- 获取事件所绑定的node
		local node = event:getCurrentTarget()

		local currentPosX, currentPosY = node:getPosition()
		local diff = touch:getDelta()

		-- 移动当前按钮精灵的坐标位置
		node:setPos(cc.p(currentPosX + diff.x, currentPosY + diff.y))
	end

	-- 暂停菜单回调函数
	local function menuPauseCallback(sender, eventType)
		print("MenuPauseCallback")
		if defaults:getBoolForKey(SOUND_KEY) then
			AudioEngine.playEffect(sound_1)
		end

		-- 暂停当前层中的node
		mainLayer:pause()
		if(schedulerId ~= nil) then
			sharedScheduler:unscheduleScriptEntry(schedulerId)
		end

		-- layer子节点暂停
		local pChildren = mainLayer:getChildren()
		for i = 1, #pChildren, 1 do
			local child = pChildren[i]
			child:pause()
		end
		-- 暂停层
		local pauseLayer = ccui.Layout:create()
		pauseLayer:setBackGroundColor(cc.c3b(125, 125, 125))
		pauseLayer:setBackGroundColorType(1)
		pauseLayer:setContentSize(display.width, display.height)
		pauseLayer:setPosition(display.cx, display.cy)
		pauseLayer:setAnchorPoint(0.5, 0.5)
		pauseLayer:setCascadeOpacityEnabled(true)
		pauseLayer:setOpacity(0.5 * 255)
		-- 将暂停层添加到主层中
		pauseLayer:addTo(mainLayer)

		-- 继续菜单回调函数
		local function menuResumeCallback(sender, eventType)
			print("MenuResumeCallback")
			if defaults:getBoolForKey(SOUND_KEY) then
				AudioEngine.playEffect(sound_1)
			end
		
			mainLayer:resume()
			schedulerId = nil
			schedulerId = sharedScheduler:scheduleScriptFunc(shootBullet, 0.5, false)
		
			-- layer子节点继续
			local pChildren = mainLayer:getChildren()
			for i = 1, #pChildren, 1 do
				local child = pChildren[i]
				child:resume()
			end
		
			mainLayer:removeChild(pauseLayer)
		end

		

    	-- 返回主页面按钮
    	local backImages = {
        	normal = "ui/continue/pauseBackRoom.png",
        	pressed = "ui/continue/pauseBackRoom.png",
        	disabled = "ui/continue/pauseBackRoom.png"
    	}
		-- 返回主页菜单回调函数

		local function menuBackCallback(sender, eventType)
			print("MenuBackCallBack")
			--cc.Director:getInstance():popScene()
			
			cc.Director:getInstance():pushScene(require("app.scenes.SecScene").new())
		   
			if defaults:getBoolForKey(SOUND_KEY) then
				AudioEngine.playEffect(sound_1)
			end
		end

    	local backBtn = ccui.Button:create(backImages["normal"], backImages["pressed"], backImages["disabled"])
    	backBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    	-- 居中
    	backBtn:setPosition(cc.p(display.cx, display.cy - 30))
    	-- 设置缩放程度
    	backBtn:setScale(0.75, 0.75)
    	-- 设置是否禁用(false为禁用)
    	backBtn:setEnabled(true)

    	-- 注册函数
    	backBtn:addTouchEventListener(menuBackCallback)

    	pauseLayer:addChild(backBtn, 4,10)


    	-- 继续按钮
    	local resumeImages = {
        	normal = "ui/continue/pauseResume.png",
        	pressed = "ui/continue/pauseResume.png",
        	disabled = "ui/continue/pauseResume.png"
    	}

    	local resumeBtn = ccui.Button:create(resumeImages["normal"], resumeImages["pressed"], resumeImages["disabled"])
    	resumeBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    	-- 居中
    	resumeBtn:setPosition(cc.p(display.cx, display.cy + 30))
    	-- 设置缩放程度
    	resumeBtn:setScale(0.75, 0.75)
    	-- 设置是否禁用(false为禁用)
    	resumeBtn:setEnabled(true)
    	resumeBtn:addTouchEventListener(menuResumeCallback)

    	pauseLayer:addChild(resumeBtn, 4)
	end



	-- 返回主页菜单回调函数
	local function menuBackCallback(sender)
		print("MenuBackCallBack")
		cc.Director:getInstance():popScene()
		if defaults:getBoolForKey(SOUND_KEY) then
			AudioEngine.playEffect(sound_1)
		end
	end

	

	-- 每0.2秒调用shootBullet函数发射一发炮弹
	schedulerEntry = sharedScheduler:scheduleScriptFunc(shootBullet, 0.5, false)


	-- 接触检测事件回调函数
	local function onContactBegin(contact)

		local spriteA = contact:getShapeA():getBody():getNode()
		local spriteB = contact:getShapeB():getBody():getNode()


		local enemy1 = nil
		-- 飞机与敌人的接触
		if spriteA:getTag() == SystemConst.GameSceneNodeTag.Fighter
				and spriteB:getTag() == SystemConst.GameSceneNodeTag.Enemy then
			enemy1 = spriteB
		end

		if spriteA:getTag() == SystemConst.GameSceneNodeTag.Enemy
				and spriteB:getTag() == SystemConst.GameSceneNodeTag.Fighter then
			enemy1 = spriteA
		end

		if nil ~= enemy1 then -- 发生接触
			self:handleFighterCollidingWithEnemy(enemy1)
			return false
		end

		-- 子弹与敌人的接触
		local enemy2 = nil
		if spriteA:getTag() == SystemConst.GameSceneNodeTag.Bullet
			and spriteB:getTag() == SystemConst.GameSceneNodeTag.Enemy then
			-- 不可见的炮弹不发生碰撞
			if spriteA:isVisible() == false then
				return false
			end

			-- 使炮弹消失
			spriteA:setVisible(false)
			enemy2 = spriteB
		end

		if spriteA:getTag() == SystemConst.GameSceneNodeTag.Enemy
			and spriteB:getTag() == SystemConst.GameSceneNodeTag.Bullet then
			-- 不可见的炮弹不发生接触
			if spriteB:isVisible() == false then
				return false
			end

			-- 使得炮弹消失
			spriteB:setVisible(false)
			enemy2 = spriteA
		end

		if nil ~= enemy2 then  -- 发生接触
			self:handleBulletCollidingWithEnemy(enemy2)
		end

		return false
	end


	--- 监听与注册

	-- 创建一个事件监听器OneByOne为单点触摸
	touchFighterListener = cc.EventListenerTouchOneByOne:create()
	touchFighterListener:setSwallowTouches(true)
	-- EVENT_TOUCH_BEGAN回调函数
	touchFighterListener:registerScriptHandler(touchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	-- EVENT_TOUCH_MOVED回调函数
	touchFighterListener:registerScriptHandler(touchMoved, cc.Handler.EVENT_TOUCH_MOVED)

	-- 创建一个接触检测事件监听器
	contactListener = cc.EventListenerPhysicsContact:create()
	contactListener:registerScriptHandler(onContactBegin, cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)

	local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
	-- 添加监听器
	eventDispatcher:addEventListenerWithSceneGraphPriority(touchFighterListener, fighter)
	eventDispatcher:addEventListenerWithSceneGraphPriority(contactListener, mainLayer)



	--- 初始化暂停按钮
	-- 暂停
    local images = {
        normal = "ui/battle/uiPause.png",
        pressed = "ui/battle/uiPause.png",
        disabled = "ui/battle/uiPause.png"
    }

    local pauseBtn = ccui.Button:create(images["normal"], images["pressed"], images["disabled"])
    -- 设置锚点
    pauseBtn:setAnchorPoint(cc.p(0 ,1))
    -- 居中
    pauseBtn:setPosition(display.left, display.top)
    -- 设置缩放程度
    pauseBtn:setScale(1, 1)
    -- 设置是否禁用(false为禁用)
    pauseBtn:setEnabled(true)
	pauseBtn:addClickEventListener(function()
        print("lalala")
    end)
    pauseBtn:addTouchEventListener(menuPauseCallback)

	--pauseBtn:addClickEventListener(function ()
	--	cc.Director:getInstance():pushScene(require("app.scenes.ResumeScene").new())
	--end)
    --
	--pauseBtn:addTouchEventListener(function(sender, eventType)
	--	if eventType == ccui.TouchEventType.ended then
	--		local registerBtn = import("app.scenes.ResumeScene"):new()
	--		display.replaceScene(registerBtn,"turnOffTiles",0.5)
	--		print(transform)
	--	end
	--end)
    mainLayer:addChild(pauseBtn, 20)



	-- 分数
	score = 0
	-- 记录0~999分数
	scorePlaceholder = 0

	  -- 在状态栏中设置玩家的生命值
	  self:updateStatusBarFighter()
	  -- 在状态栏显示得分
	  self:updateStatusBarScore()

	  mainLayer:addTo(self)
	return mainLayer
end

function ThirdScene:onEnterTransitionFinish()
	print("OnEnterTransitionFinish")
	if defaults:getBoolForKey(MUSIC_KEY) then
		AudioEngine.playMusic(bg_music_2, true)
	end
end


-- 炮弹与敌人接触检测

-- 调用了4次函数？

function ThirdScene:handleBulletCollidingWithEnemy(enemy)

	print("子弹敌人碰撞")
	enemy.hitPoints = enemy.hitPoints - 1

	if enemy.hitPoints <= 0 then
		-- 爆炸和音效
		local node = mainLayer:getChildByTag(SystemConst.GameSceneNodeTag.ExplosionParticleSystem)
		if nil ~= node then
			self:removeChild(node)
		end

		local explosion = cc.ParticleSystemQuad:create(SystemConst.ExplosionName)
		explosion:setPosition(enemy:getPosition())
		self:addChild(explosion, 2, SystemConst.GameSceneNodeTag.ExplosionParticleSystem)
		if defaults:getBoolForKey(SOUND_KEY) then
			AudioEngine.playEffect(sound_2)
		end

		score = score + SystemConst.EnemyScores
		scorePlaceholder = scorePlaceholder + SystemConst.EnemyScores


		-- 每次获得1000分数，生命值+1，scorePlaceholder恢复0

		if scorePlaceholder >= 1000 then
			fighter.hitPoints = fighter.hitPoints + 1
			self:updateStatusBarFighter()
			scorePlaceholder = scorePlaceholder - 1000
		end

		self:updateStatusBarScore()

		-- 设置敌人消失
		enemy:setVisible(false)
		enemy:spawn()

	end
end


-- 处理玩家和敌人的接触检测
function ThirdScene:handleFighterCollidingWithEnemy(enemy)

	print("玩家敌人碰撞")

	self:removeChildByTag(SystemConst.GameSceneNodeTag.ExplosionParticleSystem)

	local explosion = cc.ParticleSystemQuad:create(SystemConst.ExplosionName)
	explosion:setPosition(fighter:getPosition())
	self:addChild(explosion, 2, SystemConst.GameSceneNodeTag.ExplosionParticleSystem)
	if defaults:getBoolForKey(SOUND_KEY) then
		AudioEngine.playEffect(sound_2)
	end

	-- 设置敌人消失
	enemy:setVisible(false)
	enemy:spawn()

	-- 设置玩家消失
	fighter.hitPoints = fighter.hitPoints - 1
	self:updateStatusBarFighter()

	-- 游戏结束
	if fighter.hitPoints <= 0 then
		print("GameOver!")
		-- GameOverScene

	else 
		fighter:setPosition(cc.p(size.width/2, 70))
		local ac1 = cc.Show:create()
		local ac2 = cc.FadeIn:create(1.0)
		local seq = cc.Sequence:create(ac1, ac2)
		fighter:runAction(seq) 
	end

end





-- 在状态栏中设置玩家的生命值
function ThirdScene:updateStatusBarFighter()

	---- 先移除上次的精灵
	mainLayer:removeChildByTag(SystemConst.GameSceneNodeTag.StatusBarLife)

	if fighter.hitPoints <= 0 then
		fighter.hitPoints = 0
		local mask = ccui.Layout:create()
		mask:setBackGroundColor(cc.c3b(125, 125, 125))
		mask:setBackGroundColorType(1)
		mask:setContentSize(display.width, display.height)
		mask:setPosition(display.cx, display.cy)
		mask:setAnchorPoint(0.5, 0.5)
		mask:setCascadeOpacityEnabled(true)
		mask:setOpacity(0.5 * 255)
		mask:addTo(self)

		local gmoverImages = {
			normal = "ui/gameover/back.png",
			pressed = " ",
			disabled = "ui/gameover/back.png"
		}
	
		local GMOverBtn = ccui.Button:create(gmoverImages["normal"], gmoverImages["pressed"], gmoverImages["disabled"])
		GMOverBtn:setAnchorPoint(cc.p(0.5 ,0.5))
		-- 居中
		GMOverBtn:setPosition(cc.p(display.cx, display.cy + 30))
		-- 设置缩放程度
		GMOverBtn:setScale(0.75, 0.75)
		-- 设置是否禁用(false为禁用)
		GMOverBtn:setEnabled(true)
		GMOverBtn:addClickEventListener(function ()
			 cc.Director:getInstance():pushScene(require("app.scenes.SecScene").new())
		end)
	
		self:addChild(GMOverBtn, 4)


		--gameover2
		local newgmImages = {
			normal = "ui/gameover/restart.png",
			pressed = " ",
			disabled = "ui/gameover/restart.png"
		}
	
		local newgmBtn = ccui.Button:create(newgmImages["normal"], newgmImages["pressed"], newgmImages["disabled"])
		newgmBtn:setAnchorPoint(cc.p(0.5 ,0.5))
		-- 居中
		newgmBtn:setPosition(cc.p(display.cx, display.cy - 30))
		-- 设置缩放程度
		newgmBtn:setScale(0.75, 0.75)
		-- 设置是否禁用(false为禁用)
		newgmBtn:setEnabled(true)
		newgmBtn:addClickEventListener(function ()
			 cc.Director:getInstance():pushScene(require("app.scenes.ThirdScene").new())
		end)
	
		self:addChild(newgmBtn, 4)
	end

	local life = string.format("x%d", fighter.hitPoints)
	local lblLife = display.newTTFLabel({
		text = life,
		font = "Marker Felt",
		size = 20,
		color = cc.c3b(255, 255, 255)
	})

	lblLife:setAnchorPoint(0, 0)
	lblLife:setPosition(cc.p( 130, size.height - 30))
	mainLayer:addChild(lblLife, 20, SystemConst.GameSceneNodeTag.StatusBarLife)

end


--在状态栏中显示得分

function ThirdScene:updateStatusBarScore()
	mainLayer:removeChildByTag(SystemConst.GameSceneNodeTag.StatusBarScore)

	if score < 0 then
		score = 0
	end

	local strScore = string.format("%d", score)

	local lblScore = display.newTTFLabel({
		text = strScore,
		font = "Marker Felt",
		size = 20,
		color = cc.c3b(255, 255, 255)
	})

	lblScore:setAnchorPoint(0, 0)
	lblScore:setPosition(cc.p(250, size.height - 30))
	mainLayer:addChild(lblScore, 20, SystemConst.GameSceneNodeTag.StatusBarScore)
end




return ThirdScene