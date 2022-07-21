--[[
    DialogManger.lua
    弹窗管理器
    描述：管理所有弹窗
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local DialogManger = {}
local root_ = nil -- 根节点
local currentDialog_ = nil -- 当前展示中的弹窗

--[[--
    初始化

    @param node 类型：node，待监听节点

    @return none
]]
function DialogManger:init(node)
    root_ = node
    currentDialog_ = nil
end

--[[--
    创建弹窗

    @param node 类型：node，待添加节点

    @return none
]]
function DialogManger:createDialog(node)
    currentDialog_ = node
    root_:addChild(currentDialog_)
end

--[[--
    销毁弹窗

    @param node  类型：node，
    
    @return none
]]
function DialogManger:destroyDialog()
    if currentDialog_ then
        currentDialog_:removeFromParent()
    end
end

--[[--
    显示弹窗

    @param node  类型：node，

    @return none
]]
function DialogManger:showDialog(node)
    self:destroyDialog()
    self:createDialog(node)
    node:showView()
    return true
end

return DialogManger