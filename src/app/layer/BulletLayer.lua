--- TODO 后面有时间再拆出来
local BulletLayer =
    class(
    "BulletLayer",
    function()
        return cc.Node:create()
    end
)

--创建一个create

function Bullet:create(x, y)
    local bullet = Bullet.new()
    local layer = bullet:init(x, y)
    local x = layer:getContentSize().width
    local y = layer:getContentSize().height
    Log.i(tostring(x) .. " " .. tostring(y))
    bullet:addChild(layer)
    bullet:setContentSize(x, y)
    return bullet
end

--构造

function Bullet:ctor()
    self.bx = 0
    self.by = 0
    self.type = 0
    self.sp = nil --子弹的精灵图片
    self.winsize = cc.Director:getInstance():getWinSize()
end

--init

function Bullet:init(x, y)
    local layer = ccui.Layout:create()
    local sp = cc.Sprite:create("player/blue_bullet.png")
    layer:setContentSize(sp:getContentSize().width, sp:getContentSize().height)
    self.sp = sp
    layer:addChild(sp)
    sp:setPosition(x, y)
    self.bx = x
    self.by = y

    --- 子弹移动
    local function moveTo()
        self.by = self.by + ConstantsUtil.SPEED_BULLET_MOVE
        sp:setPositionY(self.by)
        if self.by > self.winsize.height then
            self:removeFromParent()
        end
    end
    layer:scheduleUpdateWithPriorityLua(moveTo, 0)
    return layer
end

return Bullet
