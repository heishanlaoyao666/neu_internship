--- 依赖相关
local defaults = cc.UserDefault:getInstance()

local Enemy = require("app.entity.Enemy")
local Fighter = require("app.entity.Fighter")
local Bullet = require("app.entity.Bullet")
local SystemConst = require("app.utils.SystemConst")
local audio = require("framework.audio")

---------------------------------------------------------------------------

--- 定义与生命周期

local GamePlayScene = class("GamePlayScene", function()
	local scene = cc.Scene:createWithPhysics()
	-- 不受重力影响
	scene:getPhysicsWorld():setGravity(cc.p(0,0))
    return scene
end)

function GamePlayScene.create()
	local scene = GamePlayScene.new()
	return scene
end

function GamePlayScene:ctor()
	print("GamePlayScene Init.")

	-- 成员变量
	self.test = "This is a test!"
	self.score = 0
	self.scorePlaceholder = 0
	self.size = cc.Director:getInstance():getWinSize()
	self.schedulerId = nil
	self.schedulerEntry = nil
	self.backgroundEntry = nil
	self.sharedScheduler = cc.Director:getInstance():getScheduler()
	self.touchFighterListener = nil
	self.contactListener = nil
	self.bgLayer = nil
	self.mainLayer = nil
	self.pauseLayer = nil
	self.fighter = nil
	self.enemy = nil
	self.background1 = nil
	self.background2 = nil
	self.writablePath = cc.FileUtils:getInstance():getWritablePath()

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

function GamePlayScene:onExit()
	print("GamePlayScene onExit")

	-- 停止游戏调度
	if(self.schedulerId ~= nil) then
		self.sharedScheduler:unscheduleScriptEntry(self.schedulerId)
	end

	if(self.schedulerEntry ~= nil) then
		self.sharedScheduler:unscheduleScriptEntry(self.schedulerEntry)
	end

	if(self.backgroundEntry ~= nil) then
		self.sharedScheduler:unscheduleScriptEntry(self.backgroundEntry)
	end

	-- 注销事件监听器
	local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

	if nil ~= self.touchFighterListener then
		eventDispatcher:removeEventListener(self.touchFighterListener)
	end

	if nil ~= self.contactListener then
		eventDispatcher:removeEventListener(self.contactListener)
	end

	-- 删除layer节点以及其子节点
	self.mainLayer:removeAllChildren()
	self.mainLayer:removeFromParent()
	self.mainLayer = nil
end

function GamePlayScene:onEnter()
	print("GamePlayScene onEnter")
	self:addChild(self:createLayer())
end

function GamePlayScene:onEnterTransitionFinish()
	print("GamePlayScene OnEnterTransitionFinish")
	if defaults:getBoolForKey(SystemConst.MUSIC_KEY) then
		audio.loadFile(SystemConst.GAME_BG_MUSIC, function ()
			audio.playBGM(SystemConst.GAME_BG_MUSIC)
		end)
	end
end

---------------------------------------------------------------------------

--- 创建层

-- 创建背景层
function GamePlayScene:createInitBGLayer()

	self.bgLayer = ccui.Layout:create()

	self.background1 = cc.Sprite:create(SystemConst.GAME_BG_NAME)
	self.background1:setAnchorPoint(cc.p(0, 0))
	self.background1:setPosition(cc.p(0, 0))
	self.bgLayer:addChild(self.background1)

	self.background2 = cc.Sprite:create(SystemConst.GAME_BG_NAME)
	self.background2:setAnchorPoint(cc.p(0, 0))
	self.background2:setPosition(cc.p(0, self.background1:getContentSize().height - 2))
	self.bgLayer:addChild(self.background2)

	self.backgroundEntry = self.sharedScheduler:scheduleScriptFunc(function()
		self.backgroundMove(self)
	end, 0.01, false)

	return self.bgLayer
end

-- 创建游戏主层
function GamePlayScene:createLayer()

	--- 主体栏

	-- 主层
    self.mainLayer = ccui.Layout:create()
    self.mainLayer:setContentSize(display.width, display.height)
    self.mainLayer:setPosition(display.cx, 0)
    self.mainLayer:setAnchorPoint(0.5, 0)
    self.mainLayer:setCascadeOpacityEnabled(true)
    self.mainLayer:setOpacity(1 * 255)

	-- 敌机
	self.enemy = Enemy.create()
	self.mainLayer:addChild(self.enemy, 10, SystemConst.GameSceneNodeTag.Enemy)

	-- 玩家
	self.fighter = Fighter.create(SystemConst.ENEMY_PLANE_NAME)
	self.fighter:setPos(cc.p(self.size.width/2, 0))
	self.mainLayer:addChild(self.fighter, 10, SystemConst.GameSceneNodeTag.Fighter)

	--- 状态栏

	-- 生命值的标签
	local lifeImg = ccui.ImageView:create(SystemConst.LIFE_NAME)
	lifeImg:setPosition(80, self.size.height - 30)
	lifeImg:setAnchorPoint(cc.p(0 ,0))
	lifeImg:setScale(1, 1)
	self.mainLayer:addChild(lifeImg, 8)

	-- 得分标签
	local scoreImg = ccui.ImageView:create(SystemConst.SCORE_NAME)
	scoreImg:setPosition(200, self.size.height - 30)
	scoreImg:setAnchorPoint(cc.p(0 ,0))
	scoreImg:setScale(1, 1)
	self.mainLayer:addChild(scoreImg, 8)

	-- 暂停控件
	local images = {
		normal = SystemConst.PAUSE_BUTTON_NORMAL,
		pressed = SystemConst.PAUSE_BUTTON_PRESSED,
		disabled = SystemConst.PAUSE_BUTTON_DISABLED
	}
	-- 暂停按钮
	local pauseBtn = ccui.Button:create(images["normal"], images["pressed"], images["disabled"])
	pauseBtn:setAnchorPoint(cc.p(0 ,1))
	pauseBtn:setPosition(cc.p(0, self.size.height))
	pauseBtn:setEnabled(true)
	pauseBtn:addTouchEventListener(function(sender)
		self.menuPauseCallback(self)
	end)
	-- 无法添加到mainLayer是因为Z轴太小了
	self.mainLayer:addChild(pauseBtn, 10)

	--- 局部函数

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
	self.touchFighterListener = cc.EventListenerTouchOneByOne:create()
	self.touchFighterListener:setSwallowTouches(true)
	-- EVENT_TOUCH_BEGAN回调函数
	self.touchFighterListener:registerScriptHandler(self.touchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	-- EVENT_TOUCH_MOVED回调函数
	self.touchFighterListener:registerScriptHandler(self.touchMoved, cc.Handler.EVENT_TOUCH_MOVED)

	-- 创建一个接触检测事件监听器
	self.contactListener = cc.EventListenerPhysicsContact:create()
	self.contactListener:registerScriptHandler(onContactBegin, cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)

	local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
	-- 添加监听器
	eventDispatcher:addEventListenerWithSceneGraphPriority(self.touchFighterListener, self.fighter)
	eventDispatcher:addEventListenerWithSceneGraphPriority(self.contactListener, self.mainLayer)

	--- 初始化
	if defaults:getBoolForKey("flag") then
		local table = self:readFromFile()
		self.fighter:setPosition(table.fighterPosX, table.fighterPosY)
		self.enemy:setPosition(table.enemyPosX, table.enemyPosY)
		self.fighter.hitPoints = table.life
		self.score = table.score
		self.scorePlaceholder = self.scorePlaceholder
	else
		self.score = 0
		self.scorePlaceholder = 0
	end

	if self.fighter:getPositionY() < 70 then
		-- MoveTo
		self.fighter:runAction(cc.MoveTo:create(1, cc.p(self.size.width/2, 70)))
	end

	self:updateStatusBarFighter()
	self:updateStatusBarScore()

	-- 每0.2秒调用shootBullet函数发射一发炮弹
	self.schedulerEntry = self.sharedScheduler:scheduleScriptFunc(function()
		self.shootBullet(self, 1)
	end, 0.5, false)

	return self.mainLayer
end

---------------------------------------------------------------------------

--- 其他功能函数

-- 触控相关
function GamePlayScene.touchBegan(touch, event)
	return true
end

function GamePlayScene.touchMoved(touch, event)
	-- 获取事件所绑定的node
	local node = event:getCurrentTarget()
	local currentPosX, currentPosY = node:getPosition()
	local diff = touch:getDelta()
	-- 移动当前按钮精灵的坐标位置(不移动y轴)
	node:setPos(cc.p(currentPosX + diff.x, currentPosY))
end

-- 暂停
function GamePlayScene:menuPauseCallback()
	print("MenuPauseCallback")
	if defaults:getBoolForKey(SystemConst.SOUND_KEY) then
		audio.loadFile(SystemConst.BUTTON_EFFECT, function ()
			audio.playEffect(SystemConst.BUTTON_EFFECT, false)
		end)
	end

	if defaults:getBoolForKey(SystemConst.MUSIC_KEY) then
		audio.pauseAll()
	end

	-- 暂停当前层中的node
	self.mainLayer:pause()
	if(self.schedulerId ~= nil) then
		self.sharedScheduler:unscheduleScriptEntry(self.schedulerId)
	end

	if(self.schedulerEntry ~= nil) then
		self.sharedScheduler:unscheduleScriptEntry(self.schedulerEntry)
	end

	if(self.backgroundEntry ~= nil) then
		self.sharedScheduler:unscheduleScriptEntry(self.backgroundEntry)
	end

	-- layer子节点暂停
	local pChildren = self.mainLayer:getChildren()
	for i = 1, #pChildren, 1 do
		local child = pChildren[i]
		child:pause()
	end

	------------------------------------------------------------

	-- 暂停层
	self.pauseLayer = ccui.Layout:create()
	self.pauseLayer:setBackGroundColor(cc.c3b(125, 125, 125))
	self.pauseLayer:setBackGroundColorType(1)
	self.pauseLayer:setContentSize(display.width, display.height)
	self.pauseLayer:setPosition(display.cx, display.cy)
	self.pauseLayer:setAnchorPoint(0.5, 0.5)
	self.pauseLayer:setCascadeOpacityEnabled(true)
	self.pauseLayer:setOpacity(0.5 * 255)
	-- 将暂停层添加到主层中(数值变大可以让其位于顶部)
	self.pauseLayer:addTo(self.mainLayer, 15)

	--- 返回主页面按钮
	local backImages = {
		normal = SystemConst.PAUSE_BUTTON_BACK_ROOM_NORMAL,
		pressed = SystemConst.PAUSE_BUTTON_BACK_ROOM_PRESSED,
		disabled = SystemConst.PAUSE_BUTTON_BACK_ROOM_DISABLED
	}

	local backBtn = ccui.Button:create(backImages["normal"], backImages["pressed"], backImages["disabled"])
	backBtn:setAnchorPoint(cc.p(0.5 ,0.5))
	-- 居中
	backBtn:setPosition(cc.p(display.cx, display.cy - 30))
	-- 设置缩放程度
	backBtn:setScale(0.75, 0.75)
	-- 设置是否禁用(false为禁用)
	backBtn:setEnabled(true)
	self.pauseLayer:addChild(backBtn, 16)

	-- 注册函数
	backBtn:addTouchEventListener(function(sender)
		self:menuBackCallback(sender)
	end)

	--- 继续按钮
	local resumeImages = {
		normal = SystemConst.PAUSE_BUTTON_RESUME_NORMAL,
		pressed = SystemConst.PAUSE_BUTTON_RESUME_PRESSED,
		disabled = SystemConst.PAUSE_BUTTON_RESUME_DISABLED
	}

	local resumeBtn = ccui.Button:create(resumeImages["normal"], resumeImages["pressed"], resumeImages["disabled"])
	resumeBtn:setAnchorPoint(cc.p(0.5 ,0.5))
	-- 居中
	resumeBtn:setPosition(cc.p(display.cx, display.cy + 30))
	-- 设置缩放程度
	resumeBtn:setScale(0.75, 0.75)
	-- 设置是否禁用(false为禁用)
	resumeBtn:setEnabled(true)
	self.pauseLayer:addChild(resumeBtn, 16)
	--resumeBtn:registerScriptHandler(self.menuPauseCallback)
	resumeBtn:addTouchEventListener(function(sender)
		self.menuResumeCallback(self, sender)
	end)

end

-- 1.返回主页菜单回调函数
function GamePlayScene:menuBackCallback(sender)
	print("MenuBackCallBack")

	defaults:setBoolForKey(SystemConst.IF_CONTINUE, true)
	-- 保存状态

	self:writeToFile()
	defaults:setBoolForKey("flag", true)

	cc.Director:getInstance():pushScene(require("app.scenes.MainScene").new())

	if defaults:getBoolForKey(SystemConst.SOUND_KEY) then
		audio.loadFile(SystemConst.BUTTON_EFFECT, function ()
			audio.playEffect(SystemConst.BUTTON_EFFECT, false)
		end)
	end

	if defaults:getBoolForKey(SystemConst.MUSIC_KEY) then
		audio.resumeAll()
	end
end

-- 2.继续菜单回调函数
function GamePlayScene:menuResumeCallback(sender)
	print("MenuResumeCallback")
	if defaults:getBoolForKey(SystemConst.SOUND_KEY) then
		audio.loadFile(SystemConst.BUTTON_EFFECT, function ()
			audio.playEffect(SystemConst.BUTTON_EFFECT, false)
		end)
	end

	if defaults:getBoolForKey(SystemConst.MUSIC_KEY) then
		audio.resumeAll()
	end

	-- 销毁暂停层
	self.pauseLayer:removeAllChildren()
	self.pauseLayer:removeFromParent()
	self.pauseLayer = nil

	self.mainLayer:resume()

	-- 重新注册发射子弹事件
	self.schedulerId = nil
	self.schedulerId = self.sharedScheduler:scheduleScriptFunc(function()
		self:shootBullet(self, 1)
	end, 0.5, false)

	self.backgroundEntry = self.sharedScheduler:scheduleScriptFunc(function()
		self.backgroundMove(self)
	end, 0.01, false)

	-- layer子节点继续
	local pChildren = self.mainLayer:getChildren()
	for i = 1, #pChildren, 1 do
		local child = pChildren[i]
		child:resume()
	end

end

-- 炮弹与敌人接触检测
function GamePlayScene:handleBulletCollidingWithEnemy(enemy)

	print("子弹与敌人发生碰撞")
	enemy.hitPoints = enemy.hitPoints - 1

	if enemy.hitPoints <= 0 then
		-- 爆炸和音效
		local node = self.mainLayer:getChildByTag(SystemConst.GameSceneNodeTag.ExplosionParticleSystem)

		if nil ~= node then
			self:removeChild(node)
		end

		-- 添加爆炸特效
		local posX, posY = enemy:getPosition()
		self:showExplosionOfBullet(posX, posY)


		if defaults:getBoolForKey(SystemConst.SOUND_KEY) then
			audio.loadFile(SystemConst.EXPLODE_EFFECT, function ()
				audio.playEffect(SystemConst.EXPLODE_EFFECT, false)
			end)
		end

		self.score = self.score + SystemConst.ENEMY_SCORE
		self.scorePlaceholder = self.scorePlaceholder + SystemConst.ENEMY_SCORE

		-- 每次获得1000分数，生命值+1，scorePlaceholder恢复0

		if self.scorePlaceholder >= 1000 then
			self.fighter.hitPoints = self.fighter.hitPoints + 1
			self:updateStatusBarFighter()
			self.scorePlaceholder = self.scorePlaceholder - 1000
		end

		self:updateStatusBarScore()

		-- 设置敌人消失
		enemy:setVisible(false)
		enemy:spawn()

	end
end

-- 发射子弹
function GamePlayScene:shootBullet(delta)
	if nil ~= self.fighter and self.fighter:isVisible() then

		if defaults:getBoolForKey(SystemConst.SOUND_KEY) then
			audio.loadFile(SystemConst.FIRE_EFFECT, function ()
				audio.playEffect(SystemConst.FIRE_EFFECT, false)
			end)
		end

		local bullet = Bullet.create(SystemConst.BULLET_NAME)
		self.mainLayer:addChild(bullet, 0, SystemConst.GameSceneNodeTag.Bullet)
		bullet:shootBulletFromFighter(self.fighter)
	end
end

-- 处理玩家和敌人的接触检测
function GamePlayScene:handleFighterCollidingWithEnemy(enemy)

	print("玩家与敌人发生碰撞!")

	self:removeChildByTag(SystemConst.GameSceneNodeTag.ExplosionParticleSystem)

	-- 添加爆炸特效
	local posX, posY = self.fighter:getPosition()
	self:showExplosionOfPlane(posX, posY)

	if defaults:getBoolForKey(SystemConst.SOUND_KEY) then
		audio.loadFile(SystemConst.SHIP_DESTROY_EFFECT, function ()
			audio.playEffect(SystemConst.SHIP_DESTROY_EFFECT, false)
		end)
	end

	-- 设置敌人消失
	enemy:setVisible(false)
	enemy:spawn()

	-- 设置玩家消失
	self.fighter.hitPoints = self.fighter.hitPoints - 1
	self:updateStatusBarFighter()

	-- 游戏结束
	if self.fighter.hitPoints <= 0 then
		print("GameOver!")
		-- GameOverScene
		local GameOverScene = require("app.scenes.GameOverScene")
		local scene = GameOverScene.create(self.score)
		local tsc = cc.TransitionFade:create(1.0, scene)
		cc.Director:getInstance():pushScene(tsc)
	else 
		self.fighter:setPosition(cc.p(self.size.width/2, 70))
		local ac1 = cc.Show:create()
		local ac2 = cc.FadeIn:create(5.0)
		local seq = cc.Sequence:create(ac1, ac2)
		self.fighter:runAction(seq)
	end

end

-- 在状态栏中设置玩家的生命值
function GamePlayScene:updateStatusBarFighter()

	-- 先移除上次的精灵
	self.mainLayer:removeChildByTag(SystemConst.GameSceneNodeTag.StatusBarLife)

	if self.fighter.hitPoints < 0 then
		self.fighter.hitPoints = 0
	end

	local life = string.format("x%d", self.fighter.hitPoints)
	local lblLife = display.newTTFLabel({
		text = life,
		font = "Marker Felt",
		size = 20,
		color = cc.c3b(255, 255, 255)
	})

	lblLife:setAnchorPoint(0, 0)
	lblLife:setPosition(cc.p( 130, self.size.height - 30))
	self.mainLayer:addChild(lblLife, 8, SystemConst.GameSceneNodeTag.StatusBarLife)

end

--在状态栏中显示得分
function GamePlayScene:updateStatusBarScore()
	self.mainLayer:removeChildByTag(SystemConst.GameSceneNodeTag.StatusBarScore)

	if self.score < 0 then
		self.score = 0
	end

	local strScore = string.format("%d", self.score)

	local lblScore = display.newTTFLabel({
		text = strScore,
		font = "Marker Felt",
		size = 20,
		color = cc.c3b(255, 255, 255)
	})

	lblScore:setAnchorPoint(0, 0)
	lblScore:setPosition(cc.p(250, self.size.height - 30))
	self.mainLayer:addChild(lblScore, 8, SystemConst.GameSceneNodeTag.StatusBarScore)
end

-- 爆炸
function GamePlayScene:showExplosionOfPlane(posX, posY)

	local spineSP = sp.SkeletonAnimation:createWithJsonFile(
			"spine/fireBoom/7_1_fireBoom.json", "spine/fireBoom/7_1_fireBoom.atlas"
	)
	spineSP:setScale(0.5)
	spineSP:pos(posX, posY):addTo(self)
	spineSP:setAnimation(0, "7_1_fireBoom", false)

end

function GamePlayScene:showExplosionOfBullet(posX, posY)

	local spriteFrame = cc.SpriteFrameCache:getInstance()
	-- 添加plist
	spriteFrame:addSpriteFrames(SystemConst.EXPLODE_NAME)

	-- 创建精灵
	local sprite = cc.Sprite:create()
	sprite:setPosition(posX, posY)
	sprite:addTo(self)

	local animation = cc.Animation:create()
	for i=1, 35 do
		animation:addSpriteFrame(spriteFrame:getSpriteFrame("explosion_"..(i<10 and "0" or "")..i..".png"))
	end
	-- 播放间隔
	animation:setDelayPerUnit(0.01)
	-- 播放完成回归初始状态
	--    animation:setRestoreOriginalFrame(true)
	local action = cc.Animate:create(animation)
	sprite:runAction(cc.Sequence:create(
			action, cc.CallFunc:create(function()
				sprite:removeFromParent()
				sprite = nil
			end)))
end

-- 背景移动
function GamePlayScene:backgroundMove()
	self.background1:setPositionY(self.background1:getPositionY() - 2)
	self.background2:setPositionY(self.background1:getPositionY() + self.background1:getContentSize().height - 2)
	if self.background2:getPositionY() == 0 then
		self.background1:setPositionY(0)
	end
end

-- 写文件
function GamePlayScene:writeToFile()
	local temp = {
		["fighterPosX"] = self.fighter:getPositionX(),
		["fighterPosY"] = self.fighter:getPositionY(),
		["score"] = self.score,
		["life"] = self.fighter.hitPoints,
		["scorePlaceholder"] = self.scorePlaceholder,
		["enemyPosX"] = self.enemy:getPositionX(),
		["enemyPosY"] = self.enemy:getPositionY()
	}

	local str = json.encode(temp)
	local f = io.open(self.writablePath .. SystemConst.JSON_STATE, "w")
	io.output(f)
	io.write(str)
	io.close(f)
end

-- 读文件
function GamePlayScene:readFromFile()
	local f = io.open(self.writablePath .. SystemConst.JSON_STATE, "r")
	io.input(f)
	local temp = io.read("*a")
	io.close(f)
	local tb = json.decode(temp)
	return tb
end

return GamePlayScene