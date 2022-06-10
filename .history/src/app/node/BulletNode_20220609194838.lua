local BulletNode =
    class(
    "BulletNode",
    function()
        return cc.Node:create()
    end
)
-- local
local BulletModel = require("app.model.BulletModel")
--

function BulletNode:create(x, y)
    local bulletNode = BulletNode.new(x, y)
    bulletNode:addChild(bulletNode:init())
    return bulletNode
end

function BulletNode:ctor(x, y)
    self.dataModel = BulletModel.new(x, y)
    self.bullet = nil
end

function BulletNode:getPositionX()
    return self.dataModel.x
end

function BulletNode:getPositionY()
    return self.dataModel.y
end

function BulletNode:getPosition()
    return self.dataModel.x, self.dataModel.y
end

function BulletNode:getWidth()
    return self.bullet:getBoundingBox().width
end

function BulletNode:getHeight()
    return self.bullet:getBoundingBox().height
end

function BulletNode:init()
    -- body
    local layer = ccui.Layout:create()
    self.bullet = cc.Sprite:create(ConstantsUtil.PATH_BULLET_PNG):addTo(layer)
    self.dataModel.y = self.dataModel.y + self.bullet:getContentSize().height / 2
    self.bullet:setPosition(self.dataModel.x, self.dataModel.y)
    self.bullet:setAnchorPoint(0.5, 0.5)

    local function bulletMove()
        self.dataModel.y = self.dataModel.y + ConstantsUtil.SPEED_BULLET_MOVE
        self.bullet:setPositionY(self.dataModel.y)
        if self.dataModel.y > WinSize.height then
            self:removeFromParent()
            table.removebyvalue(GameHandler.BulletArray, self, false)
        end
    end
    -- 每帧刷新一次
    self.bullet:scheduleUpdateWithPriorityLua(bulletMove, 0)
    table.insert(GameHandler.BulletArray, self)
    return layer
end

return BulletNode
