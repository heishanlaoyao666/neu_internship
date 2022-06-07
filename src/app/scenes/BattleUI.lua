local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

local scheduler = require("framework.scheduler")

local BattleUI = class("BattleUI", function()
	return display.newScene("BattleUI")
end)

function BattleUI:ctor()
	self:addNodeEventListener(cc.NODE_EVENT, function(e)
		if e.name == "enter" then
			self:onEnter()
		elseif e.name == "exit" then
			eventDispatcher:removeEventListener(self.eventListenerCustom_)
		end
	end)
end

function BattleUI:onEnter()
	print(cc.UserDefault:getInstance():getStringForKey("yinyue"))

	if cc.UserDefault:getInstance():getStringForKey("yinyue")==true then
		audio.loadFile("res\\sounds\\bgMusic.ogg", function ()
			audio.playBGM("res\\sounds\\bgMusic.ogg",true)
		end)
	end
	local width,height = 480,720
		-- body
	-- local startLayer = ccui.Layout:create()
    -- startLayer:setBackGroundImage("res\\img_bg\\img_bg_1.jpg")
	-- startLayer:setBackGroundColorType(1)
    -- startLayer:setContentSize(cc.size(width,height))
    -- startLayer:setPosition(display.cx, display.cy)
    -- startLayer:setAnchorPoint(cc.p(0.5, 0.5))
	-- startLayer:addTo(self)

	local layer=display.newSprite("res\\img_bg\\img_bg_1.jpg")
	layer:setAnchorPoint(cc.p(0.5, 0))
	layer:setContentSize(cc.size(width,height))
	layer:setPosition(display.cx, 0)
	layer:addTo(self)
	-- layer:runAction(cc.MoveTo:create(1280/150,cc.p(display.cx,-1280)))

	-- local layer1=display.newSprite("res\\img_bg\\img_bg_1.jpg")
	-- layer1:setAnchorPoint(cc.p(0.5, 0))
	-- layer1:setContentSize(cc.size(width,height))
	-- layer1:setPosition(display.cx,1280)
	-- layer1:addTo(self)
	-- layer1:runAction(cc.MoveTo:create(2*1280/150,cc.p(display.cx,-1280)))

	-- function move1()
	-- 	-- body
	-- 	if layer:getPositionY()<=-1280 then
	-- 		layer:pos(display.cx,layer1:getPositionY())
	-- 		layer:runAction(cc.MoveTo:create(layer1:getPositionY()/150,cc.p(display.cx,-1280)))
	-- 	end
	-- end

	-- function move2()
	-- 	-- body
	-- 	if layer1:getPositionY()<=-1280 then
	-- 		layer1:pos(display.cx,layer:getPositionY())
	-- 		layer1:runAction(cc.MoveTo:create(layer:getPositionY()/150,cc.p(display.cx,-1280)))
	-- 	end
	-- end

	-- scheduler.scheduleGlobal(move1,0.05)
	-- scheduler.scheduleGlobal(move2,0.05)
	--生命
	local sprite3 = display.newSprite("res\\ui\\battle\\ui_life.png")
	sprite3:setAnchorPoint(0,1)
    sprite3:pos(display.left+120, display.top -20)
	sprite3:addTo(self)

	cc.UserDefault:getInstance():setStringForKey("life",100)
	local font = ccui.TextBMFont:create(cc.UserDefault:getInstance():getStringForKey("life"), "islandcvbignum.fnt")
		font:setScale(0.3)
		font:setAnchorPoint(0,1)
		font:pos(display.left+180, display.top -15)
        font:addTo(self)

	--分数
	local sprite1 = display.newSprite("res\\ui\\battle\\ui_score.png")
	sprite1:setAnchorPoint(0,1)
    sprite1:pos(display.left+330,display.top -20)
	sprite1:addTo(self)
	cc.UserDefault:getInstance():setStringForKey("grade",0)
	local font1 = ccui.TextBMFont:create(cc.UserDefault:getInstance():getStringForKey("grade"), "islandcvbignum.fnt")
		font1:setScale(0.3)
		font1:setAnchorPoint(0,1)
		font1:pos(display.left+400, display.top -15)
        font1:addTo(self)

	--我方飞机
	local playerPlane = display.newSprite("res\\player\\red_plane.png")
    playerPlane:pos(display.cx, 0)
	playerPlane:addTo(self)
	playerPlane:runAction(cc.MoveTo:create(2,cc.p(display.cx,display.cy-250)))
	--尾焰(粒子系统)
	local particle=cc.ParticleSystemQuad:create("res\\particle\\fire.plist")
	particle:setRotation(180)
	particle:setPosition(display.cx, -25)
	particle:runAction(cc.MoveTo:create(2,cc.p(display.cx,display.cy-275)))
	particle:addTo(self)
--子弹
	local bullets ={}
	local function fire()
		-- body
	if cc.UserDefault:getInstance():getBoolForKey("yinxiao") then
		audio.playEffect("res\\sounds\\fireEffect.ogg",false)
	end
	bullet =display.newSprite("res\\player\\blue_bullet.png")
	local px,py= playerPlane:getPosition()
	bullet:addTo(self)
	bullet:setPosition(px,py+30)
	bullet:runAction(cc.MoveTo:create(2,cc.p(px,display.cy+400)))
	table.insert(bullets,bullet)
    -- bullets[i]=bullet
	-- i=i+1
	for k,v in pairs(bullets) do
		-- body
		local _,py1 = v:getPosition()
		if py1>=720 then
			bullets[k]:removeSelf()
			bullets[k]=nil
		end
	end
	end
	--
	handle1=scheduler.scheduleGlobal(fire, 0.2)

	playerPlane:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
		dump(event)
		if event.name == "began" then
			return true
		elseif event.name == "moved" then
			if event.prevX<=10 then
				playerPlane:pos(10,display.cy-250)
				particle:setPosition(10,display.cy-275)
				elseif event.prevX>=display.right-10 then
					-- body
				playerPlane:pos(display.right-10,display.cy-250)
				particle:setPosition(display.right-10,display.cy-275)
				else
					-- body
				playerPlane:pos(event.prevX,display.cy-250)
	            particle:setPosition(event.prevX,display.cy-275)
			end
	        --particle:addTo(self)
		end
	end)
	playerPlane:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE) -- default mode
	playerPlane:setTouchEnabled(true)


	--敌机

	local enemies = {}
	function enemy()
		-- body
	local enemyPlane =display.newSprite("res\\player\\small_enemy.png")
	enemyPlane:pos(math.random(10, 470), display.cy+350)
	local enemyPosX = enemyPlane:getPosition()
	enemyPlane:addTo(self)
	enemyPlane:runAction(cc.MoveTo:create(4,cc.p(enemyPosX,0)))
	table.insert(enemies, enemyPlane)
	for i,v in pairs(enemies) do
		-- body
		local _,py1 = v:getPosition()
		if py1<=100 then
			enemies[i]:removeSelf()
			enemies[i]=nil
		end
	end
	end
	handle2=scheduler.scheduleGlobal(enemy, 1)


--爆炸帧动画
function ani(x,y)
	-- body
	local spriteFrame  = cc.SpriteFrameCache:getInstance()
        spriteFrame:addSpriteFrames("animation/explosion.plist")
        local sprite = cc.Sprite:createWithSpriteFrameName("explosion_01.png")
        sprite:pos(x,y)
        self:addChild(sprite)
        local animation =cc.Animation:create()
        for i=2,12 do
            local frameName = string.format("explosion_%02d.png",i)
            local spriteFrames = spriteFrame:getSpriteFrame(frameName)
            animation:addSpriteFrame(spriteFrames)
        end
        animation:setDelayPerUnit(0.15)          --设置两个帧播放时间
        animation:setRestoreOriginalFrame(true)    --动画执行后还原初始状态
        local action =cc.Animate:create(animation)
        sprite:runAction(action)

end

--碰撞

local function boxclid()
	for k1, v1 in pairs(enemies) do
		--local x,y = v1.getPosition()
		for k2, v2 in pairs(bullets) do
			local rectA = bullets[k2]:getBoundingBox()
			local rectB = enemies[k1]:getBoundingBox()
			--local x,y = enemies[k1].getPosition()
			if(math.abs(
				bullets[k2]:getPositionX() - enemies[k1]:getPositionX()) * 2 <= (rectA.width + rectB.width))
			and(math.abs(
				bullets[k2]:getPositionY() - enemies[k1]:getPositionY()) * 2 <= (rectA.height + rectB.height))
			then
				if cc.UserDefault:getInstance():getBoolForKey("yinxiao") then
					audio.playEffect("res\\sounds\\explodeEffect.ogg",false)
				end
				local x,y = enemies[k1]:getPosition()
				ani(x,y)
				bullets[k2]:removeSelf()
				enemies[k1]:removeSelf()
				bullets[k2] = nil
				enemies[k1] = nil
				cc.UserDefault:getInstance():setStringForKey("grade",cc.UserDefault:getInstance():getStringForKey("grade")+10)
				font1:setString(cc.UserDefault:getInstance():getStringForKey("grade"))
			end
		end
	end
end

local function boxclid1()
	for k1, v1 in pairs(enemies) do
		--local x,y = v1.getPosition()
			local rectA = playerPlane:getBoundingBox()
			local rectB = enemies[k1]:getBoundingBox()
			--local x,y = enemies[k1].getPosition()
			if(math.abs(
				playerPlane:getPositionX() - enemies[k1]:getPositionX()) * 2 <= (rectA.width + rectB.width))
			and(math.abs(
				playerPlane:getPositionY() - enemies[k1]:getPositionY()) * 2 <= (rectA.height + rectB.height))
			then
				if cc.UserDefault:getInstance():getBoolForKey("yinxiao") then
					audio.playEffect("res\\sounds\\explodeEffect.ogg",false)
				end
				local x,y = enemies[k1]:getPosition()
				ani(x,y)
				enemies[k1]:removeSelf()
				enemies[k1] = nil
				cc.UserDefault:getInstance():setStringForKey("life",cc.UserDefault:getInstance():getStringForKey("life")-20)
				font:setString(cc.UserDefault:getInstance():getStringForKey("life"))
				if cc.UserDefault:getInstance():getStringForKey("life")=="0" then
					audio.playEffect("res\\sounds\\shipDestroyEffect.ogg",false)
					local x1,y1 = playerPlane:getPosition()
				    ani(x1,y1)
					playerPlane:removeSelf()
				    particle:removeSelf()
					require("app.scenes.EndUI"):new():addTo(self)
			        display.pause()
				end
			end
	end
end
handle3=scheduler.scheduleGlobal(boxclid, 0.1)
handle4=scheduler.scheduleGlobal(boxclid1, 0.1)
--暂停
    local cancelButton = ccui.Button:create("res\\ui\\battle\\uiPause.png",  1)
    cancelButton:setAnchorPoint(0,1)
	--cancelButton:setScale9Enabled(true)
	--cancelButton:setContentSize(cc.size(50, 40))
	cancelButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			-- local AnotherScene=require("app.scenes.PauseUI"):new()
			-- display.replaceScene(AnotherScene, "fade", 0.5)
			--playerPlane:setTouchEnabled(false)
			require("app.scenes.PauseUI"):new():addTo(self)
			display.pause()
		end
	end)
	cancelButton:pos(10, display.top-10 )
	cancelButton:addTo(self)

end

return BattleUI

