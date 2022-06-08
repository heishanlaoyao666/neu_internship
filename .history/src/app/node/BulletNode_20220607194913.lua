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
    y = y + self.bullet:getContentSize().height / 2
    self.bullet:setPosition(x, y)
    self.bullet:setAnchorPoint(0.5, 0.5)
    self.bullet:setTag(ConstantsUtil.TAG_BULLET)
    self.x = x
    self.y = y
    -- 移动
    return layer
end

return BulletNode
