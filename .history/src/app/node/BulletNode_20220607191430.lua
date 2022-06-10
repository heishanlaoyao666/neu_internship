local BulletNode =
    class(
    "BulletNode",
    function()
        return cc.Node:create()
    end
)

function BulletNode:create(x, y)
    local bulletNode = BulletNode.new()
    bulletNode:addChild(bulletNode:init(x, y))
    return bulletNode
end

function BulletNode:ctor()
    self.x = 0
    self.y = 0

    self.bullet = nil
end

function BulletNode:init(x, y)
    -- body
    local layer = ccui.Layout:create()
    self.bullet = cc.Sprite:create(ConstantsUtil.PATH_BULLET_PNG):addTo(layer)
    y = y + sp:getContentSize().height / 2
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
    table.insert(bulletArray, self)
    return sp
end

return BulletNode
