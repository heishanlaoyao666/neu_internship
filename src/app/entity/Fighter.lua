--- Fighter
local SystemConst = require("app.utils.SystemConst")

local Fighter = class("Fighter", function()
	return cc.Sprite:create()
end)

function Fighter.create(spriteFrameName)  -- 工厂函数
	local fighter = Fighter.new(spriteFrameName)
	return fighter
end

function Fighter:ctor(spriteFrameName)

	self.size = cc.Director:getInstance():getWinSize()
	self.hitPoints = SystemConst.FIGHTER_INITIAL_HIT_POINTS  -- 当前的生命值
	self:setTexture(spriteFrameName)

	local ps = cc.ParticleSystemQuad:create(SystemConst.PARTICLE_NAME)
	ps:setPosition(cc.p(self:getContentSize().width/2, 0))
	ps:setScale(0.5)
	ps:setRotation(180)

	self:addChild(ps)

	local verts = {  -- 定义飞机顶点坐标
		cc.p(-43.5, 15.5),
		cc.p(-23.5, 33),
		cc.p(28.5, 34),
		cc.p(48, 17.5),
		cc.p(0, -39.5)
	}

	local body = cc.PhysicsBody:createPolygon(verts)  -- 创建物理世界的多边形物体

	body:setCategoryBitmask(0x01)
	body:setCollisionBitmask(0x02)
	body:setContactTestBitmask(0x01)

	-- -- 将上面定义好的物体对象，设置到Fighter对象中，这样就可以使得Fighter对象具有物理特性了
	self:setPhysicsBody(body)

end

-- 设置位置函数
function Fighter:setPos(newPosition)
	local halfWidth = self:getContentSize().width/2
	local halfHeight = self:getContentSize().height/2
	local pos_x = newPosition.x
	local pos_y = newPosition.y

	-- 计算Fighter对象的x, y轴坐标
	if pos_x < halfWidth + 10 then
		pos_x = halfWidth + 10
	elseif pos_x > (self.size.width - halfWidth - 10) then
		pos_x = self.size.width - halfWidth - 10
	end

	if pos_y < halfHeight then
		pos_y = halfHeight
	elseif pos_y > (self.size.height - halfHeight) then
		pos_y = self.size.height - halfHeight
	end

	self:setPosition(cc.p(pos_x, pos_y))
	self:setAnchorPoint(cc.p(0.5, 0.5))
end

return Fighter