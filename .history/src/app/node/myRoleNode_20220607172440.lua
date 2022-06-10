local MyRoleNode =
    class(
    "MyRoleNode",
    function()
        return cc.Node:create()
    end
)

function MyRoleNode:create(painting)
    local myRoleNode = MyRoleNode.new()
    myRoleNode.addChild(myRoleNode:init(painting))
    return myRoleNode
end

function MyRoleNode:ctor()
    self.x = 0
    self.y = 0
    self.hp = ConstantsUtil.DEFAULT_HP
    self.score = ConstantsUtil.DEFAULT_SCORE
    self.tailFlame = nil
end

function MyRoleNode:init(painting)
    -- body
    local layer = ccui.Layout:create()
    local myRole = cc.Sprite:create(ConstantsUtil.PATH_ROLE[painting]):addTo(layer)
    myRole:setTag(ConstantsUtil.TAG_MY_ROLE)
    myRole:setAnchorPoint(0.5, 0.5)
end

return MyRoleNode
