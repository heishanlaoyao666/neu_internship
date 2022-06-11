--- Bullet
local SystemConst = require("app.utils.SystemConst")

local Bullet = class("Bullet", function()
	return cc.Sprite:create()
end)

-- 构建函数
function Bullet.create(spriteFrameName)
	local sprite = Bullet.new(spriteFrameName)
	return sprite
end

function Bullet:ctor(spriteFrameName)
	self.size = cc.Director:getInstance():getWinSize()
	self:setTexture(spriteFrameName)
	self:setVisible(false)
	self.velocity = SystemConst.BULLET_VELOCITY

	local body = cc.PhysicsBody:createBox(self:getContentSize())
	body:setCategoryBitmask(0x01)  -- 定义物体类别的掩码
	body:setCollisionBitmask(0x02)  -- 定义碰撞的掩码
	body:setContactTestBitmask(0x01)  -- 定义接触检测的掩码

	self:setPhysicsBody(body)

	function onNodeEvent(tag)
		if tag == "exit" then
			-- 开始游戏调度
			self:unscheduleUpdate()
		end
	end
	self:registerScriptHandler(onNodeEvent)
end



-- 发射炮弹函数
function Bullet:shootBulletFromFighter(fighter)
	local fighterPosX, fighterPosY = fighter:getPosition()
	self:setPosition(cc.p(fighterPosX, fighterPosY + fighter:getContentSize().height/2))
	self:setVisible(true)  -- 设置炮弹可见

	-- 开始游戏调度
	local function update(delta)
		local x, y = self:getPosition()
		self:setPosition(cc.p(x + self.velocity.x * delta, y + self.velocity.y * delta))
		x, y = self:getPosition()

		-- 子弹移动到屏幕外
		if y > self.size.height then
			--self:setVisible(false)
			self:unscheduleUpdate()  -- 停止游戏循环
			self:removeFromParent(true)
		end
	end
	self:scheduleUpdateWithPriorityLua(update, 0)  -- 开启游戏调度
	
end

return Bullet