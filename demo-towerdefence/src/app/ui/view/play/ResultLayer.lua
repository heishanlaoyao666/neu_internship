--[[--
    ResultLayer.lua

    描述：结算层
]]
local ResultLayer = class("ResultLayer", require("app.ui.view.common.BaseNode"))
local GameData = require("app.data.GameData")
local SceneManager = require("app.manager.SceneManager")
local Log = require("app.util.Log")

local RES_DIR = "img/play/result/"

--[[--
    描述：构造函数

    @param none

    @return none
]]
function ResultLayer:ctor()
    ResultLayer.super.ctor(self)

    Log.d("isWin=", GameData.isWin_)

    self.isWin_ = GameData.isWin_ -- 类型：boolean，我是否获胜
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function ResultLayer:onEnter()
    ResultLayer.super.onEnter(self)

    Log.d()

    local width, height = display.width, display.height
    self:setContentSize(cc.size(width, height))
    self:align(display.CENTER, display.cx, display.cy)
    local cx, cy = width * 0.5, height * 0.5

    self:setClickEnable(true) -- 屏蔽下层点击

    self:initTestBg(cc.c4b(0, 0, 0, 180))

    -- TODO 简单实现
    local label = display.newTTFLabel({
        text = self.isWin_ and "胜利" or "失败",
        size = 54 * display.scale,
        align = cc.TEXT_ALIGNMENT_CENTER,
        color = cc.c3b(245, 245, 245),
    })
    label:align(display.CENTER, cx, cy)
    self:addChild(label)

    -- 初始化确定按钮
    local confirmBtn = ccui.Button:create(RES_DIR .. "btn_confirm.png"):addTo(self)
    confirmBtn:align(display.CENTER, cx, cy - 200 * display.scale)
    confirmBtn:setScale(display.scale)
    confirmBtn:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            SceneManager:changeScene({
                sceneId = SceneManager.DEF.ID.LOBBY,
                transitionType = "slideInL",
                transitionTime = 0.3,
            })
        end
    end)
end

--[[--
    描述：显示结算

    @param none

    @return none
]]
function ResultLayer:show()
    Log.d()

    -- TODO 播放进场动画
end

return ResultLayer