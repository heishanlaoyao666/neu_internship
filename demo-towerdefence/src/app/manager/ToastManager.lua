--[[--
    ToastManager.lua

    描述：toast管理器类
         toast显示在scene的最上层，默认展示一段时间，后自动销毁。
         多个toast将按照队列顺序显示

         TODO 数组能够实现队列，但是数组的移除元素操作不够高效，思考更高效的队列实现
]]
local ToastManager = {}
local SceneManager = require("app.manager.SceneManager")
local ToastNode = require("app.ui.view.common.ToastNode")
local Log = require("app.util.Log")

local id_ = 0 -- 类型：number，toast唯一标识，自增序列
local idQueue_ = {} -- 类型：table，toast队列，尾部进入，头部出去，内部元素为string
local toastMap_ = {} -- 类型：table，toast数据，key为id，value为string
local currentToastId_ -- 类型：number，当前显示的toast标识
local currentToastNode_  -- 类型：ToastNode，当前显示的toast节点

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------
local _genId
local _showNext

--[[--
    描述：显示toast，返回唯一标识，用以移除

    @param text 类型：string，显示内容

    @return number
]]
function ToastManager:showToast(text)
    local id = _genId()

    -- 为统一流程，均添加到队列中
    toastMap_[id] = tostring(text) or ""
    idQueue_[#idQueue_ + 1] = id

    -- 显示toast
    _showNext()

    return id
end

--[[--
    描述：移除单个toast

    @param toastId 类型：number，toast唯一标识

    @return none
]]
function ToastManager:removeToast(toastId)
    if not isNumber(toastId) then
        Log.e("unexpect param, toastId=", toastId)
        return
    end

    if currentToastId_ and currentToastNode_ and currentToastId_ == toastId then
        currentToastNode_:removeSelf()
        currentToastNode_ = nil
        currentToastId_ = nil

        -- 移除了当前，需要检查下一个
        _showNext()
    else
        toastMap_[toastId] = nil

        -- 遍历数据检查
        for i = 1, #idQueue_ do
            if toastId == idQueue_[i] then
                table.remove(idQueue_, i)
                break
            end
        end
    end
end

--[[--
    描述：清理所有toast

    @param none

    @return none
]]
function ToastManager:removeAllToast()
    -- 移除当前显示，直接清理
    if currentToastNode_ then
        currentToastNode_:removeSelf()
        currentToastNode_ = nil
    end

    -- 清理数据
    currentToastId_ = nil
    toastMap_ = {}
    idQueue_ = {}
end

---------------------------------------------------------------------------
-- 私有函数实现
---------------------------------------------------------------------------

--[[
    描述：获取toast唯一标识，自增序列

    @param none

    @return number
]]
function _genId()
    id_ = id_ + 1
    if id_ > 99999999 then
        id_ = 1
    end

    return id_
end

--[[
    描述：显示下一个taost

    @param none

    @return none
]]
function _showNext()
    -- 检查当前是否有显示
    if currentToastId_ and currentToastNode_ then
        Log.d("here is toast on show, wait")
        return
    end

    -- 检查场景
    local scene = SceneManager:getCurrentScene()
    if not scene then
        Log.e("scene is not exist.")

        -- 场景出问题，清理所有
        ToastManager:removeAllToast()
        return
    end

    -- 检查数据
    if #idQueue_ <= 0 then
        return
    end

    -- 取队列第1个元素，取出并移除数据
    local id = idQueue_[1]
    table.remove(idQueue_, 1)

    local text = toastMap_[id]
    toastMap_[id] = nil

    local toastNode = ToastNode.new(tostring(text or ""))
    scene:addChild(toastNode, SceneManager.DEF.ZORDER.TOAST)
    toastNode:show(function()
        currentToastId_ = nil
        currentToastNode_ = nil

        -- 显示下一个
        _showNext()
    end)

    -- 记录当前显示的toast
    currentToastId_ = id
    currentToastNode_ = toastNode
end

return ToastManager