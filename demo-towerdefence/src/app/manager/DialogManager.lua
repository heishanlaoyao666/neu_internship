--[[--
    DialogManager.lua

    描述：弹窗管理类
]]
local DialogManager = {}
local SceneManager = require("app.manager.SceneManager")
local DialogDef = require("app.def.DialogDef")
local Log = require("app.util.Log")

DialogManager.DEF = DialogDef -- 此处进行桥接，为了少require一个文件

local CLASS_DIR = "app.ui.view.dialog."

local dialogMap_ = {} -- 类型：table，对话框数据，key为id，value为对话框
local dialogIds_ = {} -- 类型：table，对话框数组，最新显示的在最后面

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------
local _isDialogIdValid
local _removeDialog

--[[--
    描述：显示弹窗，返回当前创建的弹窗

    @param dialogId 类型：number，弹窗id
    @param ... 透传给弹窗的参数

    @return BaseDialog
]]
function DialogManager:showDialog(dialogId, ...)
    if not _isDialogIdValid(dialogId) then
        Log.e("dialogId is not valid, dialogId=", dialogId)
        return
    end

    local scene = SceneManager:getCurrentScene()
    if not scene then
        Log.e("scene not exist.")
        return
    end

    local dialog = require(CLASS_DIR .. dialogId).new(...)
    scene:addChild(dialog, SceneManager.DEF.ZORDER.DIALOG)
    dialog:show(nil)

    dialogMap_[dialogId] = dialog
    dialogIds_[#dialogIds_ + 1] = dialogId
end

--[[--
    描述：隐藏弹窗

    @param dialogId 类型：number，弹窗id

    @return none
]]
function DialogManager:hideDialog(dialogId)
    if not _isDialogIdValid(dialogId) then
        Log.e("dialogId is not valid, dialogId=", dialogId)
        return
    end

    local dialog = dialogMap_[dialogId]
    if not dialog then
        Log.e("dialog not found, dialogId=", dialogId)
        return
    end

    dialog:hide(function()
        _removeDialog(dialogId)
    end)
end

--[[--
    描述：隐藏所有弹窗

    @param none

    @return none
]]
function DialogManager:hideAllDialog()
    for id, dialog in pairs(dialogMap_) do
        dialog:hide(function()
            _removeDialog(id)
        end)
    end

    dialogMap_ = {}
end

--[[--
    描述：移除最顶层的对话框

    @param none

    @return none
]]
function DialogManager:hideTopDialog()
    DialogManager:hideDialog(dialogIds_[#dialogIds_])
end

---------------------------------------------------------------------------
-- 私有函数实现
---------------------------------------------------------------------------

--[[
    描述：检查dialogId是否合法

    @param dialogId 类型：number，弹窗id

    @return boolean
]]
function _isDialogIdValid(dialogId)
    local isValid = false
    if not isString(dialogId) then
        return isValid
    end

    -- 检查id是否存在
    -- 注意，此处的设计并不好，应该将数据结构转换为map，通过查表的方式检查，而不是遍历
    for _, id in pairs(DialogDef.ID) do
        if id == dialogId then
            isValid = true
            break
        end
    end

    return isValid
end

--[[
    描述：移除对话框

    @param dialogId 类型：number，对话框id

    @return none
]]
function _removeDialog(dialogId)
    local dialog = dialogMap_[dialogId]
    dialog:removeSelf()
    dialogMap_[dialogId] = nil

    for i = 1, #dialogIds_ do
        if dialogId == dialogIds_[i] then
            table.remove(dialogIds_, i)
            break
        end
    end
end

return DialogManager