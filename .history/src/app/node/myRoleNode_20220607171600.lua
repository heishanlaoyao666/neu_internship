local MyRoleNode =
    class(
    "MyRoleNode",
    function()
        return cc.Node:create()
    end
)

function MyRoleNode:create()
    local myRoleNode = MyRoleNode.new()
    myRoleNode.addChild(myRoleNode:init())
    return myRoleNode
end

function MyRoleNode:ctor()
    -- body
end

function MyRoleNode:init()
    -- body
end

return MyRoleNode
