--[[--
    CenterInfoLayer.lua

    描述：中间信息层，包括：血量、网络、剩余时间、认输按钮
]]
local CenterInfoLayer = class("CenterInfoLayer", require("app.ui.view.common.BaseNode"))
local GameData = require("app.data.GameData")
local SendMsg = require("app.msg.SendMsg")
local DialogManager = require("app.manager.DialogManager")
local Log = require("app.util.Log")

local RES_DIR = "img/play/center_info/"

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------

--[[--
    描述：构造函数

    @param none

    @return none
]]
function CenterInfoLayer:ctor()
    CenterInfoLayer.super.ctor(self)

    Log.d()
end

--[[--
    描述：构造函数

    @param none

    @return none
]]
function CenterInfoLayer:onEnter()
    CenterInfoLayer.super.onEnter(self)

    Log.d()

    local width, height = display.width, 200 * display.scale
    self:setContentSize(cc.size(width, height))
    self:align(display.CENTER, display.cx, display.cy + 60 * display.scale)
    local cx, cy = width * 0.5, height * 0.5

    --self:initTestBg(cc.c4b(255, 0, 0, 150))

    -- 初始化放弃按钮
    local giveupBtn = ccui.Button:create(RES_DIR .. "btn_giveup.png"):addTo(self)
    giveupBtn:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
    giveupBtn:setPosition(cx + 250 * display.scale, cy + 15 * display.scale)
    giveupBtn:setScale(display.scale)
    giveupBtn:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            DialogManager:showDialog(DialogManager.DEF.ID.GIVEUP, function()
                SendMsg:sendGameGiveupReq()
            end)
        end
    end)

    -- TODO 初始化网络

    -- TODO 初始化对手血量

    -- TODO 初始化我的血量

    -- TODO 初始化剩余时间
end

---------------------------------------------------------------------------
-- 私有函数实现
---------------------------------------------------------------------------

return CenterInfoLayer