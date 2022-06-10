local BulletNode =
    class(
    "BulletNode",
    function()
        return cc.Node:create()
    end
)

function BulletNode:create(x, y)
    local bullet = BulletNode.new()
    bullet:addChild(bullet:init(x, y))
    return bullet
end

function BulletNode:ctor()
    -- body
    self.x = 0
    self.y = 0
end

function BulletNode:init(x, y)
    -- body
    local sp = cc.Sprite:create(ConstantsUtil.PATH_BULLET_PNG)
    y = y + sp:getContentSize().height / 2
    sp:setPosition(x, y)
    sp:setTag(ConstantsUtil.TAG_BULLET)
    self.x = x
    self.y = y
    -- 移动
    local function move()
        self.y = self.y + ConstantsUtil.SPEED_BULLET_MOVE
        self:setPositionY(self.y)
        if self.y > ConstantsUtil.DIE_BULLET then
            self:removeFromParent()
            CollisionController.removeBullet(self)
        end
    end
    sp:scheduleUpdateWithPriorityLua(move, ConstantsUtil.LEVEL_VISIABLE_MEDIUM)
    CollisionController.addBullet(self)
    return sp
end

return BulletNode
