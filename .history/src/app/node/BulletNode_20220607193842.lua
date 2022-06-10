local BulletNode =
    class(
    "BulletNode",
    function()
        return cc.Node:create()
    end
)

function BulletNode:create(x, y)
    local bulletNode = BulletNode.new()
    bulletNode:addChild(bulletNode:init(bulletNode, x, y))
    Log.i(tostring(bulletNode:getContentSize().width))
    return bulletNode
end

function BulletNode:ctor()
    self.x = 0
    self.y = 0

    self.bullet = nil
end

function BulletNode:init(bulletNode, x, y)
    -- body
    local layer = ccui.Layout:create()
    self.bullet = cc.Sprite:create(ConstantsUtil.PATH_BULLET_PNG):addTo(layer)
    y = y + self.bullet:getContentSize().height / 2
    self.bullet:setPosition(x, y)
    self.bullet:setTag(ConstantsUtil.TAG_BULLET)
    self.x = x
    self.y = y
    -- 移动
    local function move()
        self.y = self.y + ConstantsUtil.SPEED_BULLET_MOVE
        self:setPositionY(self.y)
        if self.y > ConstantsUtil.DIE_BULLET then
            self:removeFromParent()
            table.removebyvalue(bulletArray, self, false)
        end
    end
    self.bullet:scheduleUpdateWithPriorityLua(move, ConstantsUtil.LEVEL_VISIABLE_MEDIUM)
    table.insert(bulletArray, bulletNode)
    return layer
end

return BulletNode
