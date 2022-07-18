--[[--
    BottomInfoLayer.lua

    描述：底部信息层，也即我的信息+操作
]]
local BottomInfoLayer = class("BottomInfoLayer", require("app.ui.view.common.BaseNode"))
local GameData = require("app.data.GameData")
local SendMsg = require("app.msg.SendMsg")
local EventDef = require("app.def.EventDef")
local Log = require("app.util.Log")

local RES_DIR = "img/play/bottom_info/"

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------
local _initSpCount
local _initGenerateBtn
local _refreshSp

--[[--
    描述：构造函数

    @param none

    @return none
]]
function BottomInfoLayer:ctor()
    BottomInfoLayer.super.ctor(self)

    Log.d()

    self.spCount_ = GameData.selfInfo_.spCount -- 类型：number，sp数量
    self.spCost_ = GameData.selfInfo_.spCost -- 类型：number，sp消耗

    self.spCountLabel_ = nil -- 类型：Label，sp数量文本
    self.spCostLabel_ = nil -- 类型：Label，sp消耗文本

    Log.i(GameData)
end

--[[--
    描述：构造函数

    @param none

    @return none
]]
function BottomInfoLayer:onEnter()
    BottomInfoLayer.super.onEnter(self)

    Log.d()

    local width, height = display.width, 250 * display.scale
    self:setContentSize(cc.size(width, height))
    self:align(display.LEFT_BOTTOM, 0, 0)

    --self:initTestBg(cc.c4b(255, 0, 0, 150))

    -- 初始化sp数量
    _initSpCount(self)

    -- 初始化塔生成按钮
    _initGenerateBtn(self)

    -- TODO 初始化塔升级模块

    -- 注册监听
    self:registerEvent(EventDef.ID.GAME_REFRESH_SP, handler(self, _refreshSp))
end

---------------------------------------------------------------------------
-- 私有函数实现
---------------------------------------------------------------------------

--[[
    描述：初始化sp数量

    @param self 类型：BottomInfoLayer，当前节点

    @return none
]]
function _initSpCount(self)
    Log.d()

    -- 初始化容器
    local node = cc.Node:create():addTo(self)
    node:align(display.LEFT_BOTTOM, 120 * display.scale, 180 * display.scale)

    -- 初始化底图
    local bgSprite = display.newSprite(RES_DIR .. "bg_sp_count.png"):addTo(node)
    bgSprite:align(display.LEFT_BOTTOM, 0, 0)
    bgSprite:setScale(display.scale)

    local size = bgSprite:getContentSize()
    node:setContentSize(cc.size(size.width * display.scale, size.height * display.scale))

    -- 初始化sp文本
    self.spCountLabel_ = display.newTTFLabel({
        text = tostring(self.spCount_),
        size = 24 * display.scale,
        align = cc.TEXT_ALIGNMENT_CENTER,
    })
    self.spCountLabel_:addTo(node)
    self.spCountLabel_:align(display.CENTER, 80 * display.scale, node:getContentSize().height * 0.5)
end

--[[
    描述：初始化塔生成按钮

    TODO 此处是用按钮作为容器，但按钮的缩放并未影响文本，且文本在放大后会发虚，应该做一个更适合的自定义按钮

    @param self

    @return none
]]
function _initGenerateBtn(self)
    Log.d()

    -- 初始化按钮，注意，此按钮也作为容器整体缩放，将影响文本的适配方案
    local btn = ccui.Button:create(RES_DIR .. "btn_generate.png"):addTo(self)
    btn:align(display.CENTER, display.cx, 180 * display.scale)
    btn:setScale(display.scale)
    btn:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            SendMsg:sendGameTowerGenerateReq()
        end
    end)

    -- 初始化sp消耗文本
    self.spCostLabel_ = display.newTTFLabel({
        text = tostring(self.spCost_),
        size = 24,
        align = cc.TEXT_ALIGNMENT_CENTER,
    })
    self.spCostLabel_:addTo(btn)
    self.spCostLabel_:align(display.CENTER_BOTTOM, btn:getContentSize().width * 0.5 + 10, 3)
end

--[[
    描述：刷新sp

    @param self 类型：BottomInfoLayer，当前节点

    @return none
]]
function _refreshSp(self)
    -- 注意，setString是耗时行为，检查是否有变化，需要刷新才进行
    if self.spCount_ ~= GameData.selfInfo_.spCount then
        self.spCount_ = GameData.selfInfo_.spCount
        if self.spCountLabel_ then
            self.spCountLabel_:setString(tostring(self.spCount_))
        end
    end

    if self.spCost_ ~= GameData.selfInfo_.spCost then
        self.spCost_ = GameData.selfInfo_.spCost
        if self.spCostLabel_ then
            self.spCostLabel_:setString(tostring(self.spCost_))
        end
    end
end

return BottomInfoLayer