--[[--
    DialogDef.lua

    描述：弹窗常量定义类
]]
local DialogDef = {}

-- 弹窗id，注意，key值要对应弹窗类名，用以匹配
DialogDef.ID = {
    MENU = "MenuDialog", -- 菜单对话框
    NOTICE = "NoticeDialog", -- （通用）通知对话框
    GIVEUP = "GiveupDialog", -- 放弃对话框
}

return DialogDef