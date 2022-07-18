--[[--
    MenuDialog.lua

    描述：菜单对话框
]]
local MenuDialog = class("MenuDialog", require("app.ui.view.dialog.BaseDialog"))
local MenuButton = require("app.ui.view.dialog.MenuButton")
local ToastManager = require("app.manager.ToastManager")
local Log = require("app.util.Log")

local RES_DIR = "img/lobby/menu/"

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------
local _onClickMenuBtn

--[[--
    描述：构造函数

    @param none

    @return none
]]
function MenuDialog:ctor()
    MenuDialog.super.ctor(self)

    Log.d()

    self.menuBtnMap_ = {} -- 类型：table，按钮数据，key为按钮id，value为MenuButton
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function MenuDialog:onEnter()
    MenuDialog.super.onEnter(self)

    Log.d()

    local x = display.right - 100 * display.scale
    local y = display.top - 100 * display.scale
    self:initRoot(RES_DIR .. "bg.png", display.ANCHOR_POINTS[display.RIGHT_TOP], x, y)

    local size = self.rootNode_:getContentSize()
    local cx = size.width * 0.5
    local offsetY = 90 * display.scale
    local btnY = size.height - 65 * display.scale
    local btnIds = { MenuButton.ID.NOTICE, MenuButton.ID.MAIL, MenuButton.ID.RECORD, MenuButton.ID.SETTING }
    for i = 1, #btnIds do
        local id = btnIds[i]
        local btn = MenuButton.new(id, handler(self, _onClickMenuBtn))
        btn:setPosition(cx, btnY)
        self.rootNode_:addChild(btn)
        btnY = btnY - offsetY
    end
end

---------------------------------------------------------------------------
-- 私有函数实现
---------------------------------------------------------------------------

--[[
    描述：菜单按钮点击回调

    @param self 类型：MenuDialog，当前节点
    @param btnId 类型：number，按钮id

    @return none
]]
function _onClickMenuBtn(self, btnId)
    Log.d("btnId=", btnId)

    ToastManager:showToast(string.format("功能未开发（%d）", btnId))
end

return MenuDialog