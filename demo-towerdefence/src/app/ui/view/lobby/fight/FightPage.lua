--[[--
    FightPage.lua

    描述：战斗界面
]]
local FightPage = class("FightPage", require("app.ui.view.common.BasePage"))
local RankmapNode = require("app.ui.view.lobby.fight.RankmapNode")
local MyTowerNode = require("app.ui.view.lobby.fight.MyTowerNode")
local SendMsg = require("app.msg.SendMsg")
local SceneManager = require("app.manager.SceneManager")
local Log = require("app.util.Log")

local RES_DIR = "img/lobby/fight/"

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------
local _initFightTowers

--[[--
    描述：构造函数

    @param none

    @return none
]]
function FightPage:ctor()
    FightPage.super.ctor(self)

    Log.d()

    self.rankmapNode_ = nil -- 类型：RankmapNode，天梯模块节点
    self.myTowerNodeMap_ = {} -- 类型：table，我的塔数据，key为塔id，value为MyTowerNode
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function FightPage:onEnter()
    FightPage.super.onEnter(self)

    Log.d()

    self:setContentSize(cc.size(display.width, display.height))
    self:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    self:setPosition(0, 0)

    -- 初始化底图
    local bgSprite = display.newSprite(RES_DIR .. "bg.png", 0, 0)
    bgSprite:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    bgSprite:setScaleX(display.scaleX)
    bgSprite:setScaleY(display.scaleY)
    self:addChild(bgSprite, -1)

    -- 初始化天梯模块节点
    self.rankmapNode_ = RankmapNode.new()
    self:addChild(self.rankmapNode_)

    -- 初始化开始游戏按钮
    local playBtn = ccui.Button:create(RES_DIR .. "btn_play.png"):addTo(self)
    playBtn:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
    playBtn:setPosition(display.cx - 20 * display.scale, display.cy - 100 * display.scale)
    playBtn:setScale(display.scale)
    playBtn:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            -- TODO 播放按钮音效
            Log.d("对战按钮点击")

            SendMsg:sendMatchSignupReq()
        end
    end)

    -- 初始化我的出战塔
    _initFightTowers(self)
end

---------------------------------------------------------------------------
-- 私有函数实现
---------------------------------------------------------------------------

--[[
    描述：初始化出战的塔

    @param self 类型：FightPage，当前节点

    @return none
]]
function _initFightTowers(self)
    -- 初始化容器，整体缩放，调整坐标
    local rootNode = cc.Node:create()
    rootNode:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER_BOTTOM])
    rootNode:setPosition(display.cx, display.bottom + 150 * display.scale)
    rootNode:setScale(display.scale) -- 内部元素都是图片，整体缩放
    self:addChild(rootNode)

    -- TODO 此处数据应来自我的数据
    local ids = { 1, 3, 12, 15, 19, }
    local levels = { 1, 2, 3, 4, 5, }

    local offsetX = 10
    local width, height = 0, 0
    for i = 1, #ids do
        local id = ids[i]
        local towerNode = MyTowerNode.new(id, levels[i])
        towerNode:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
        towerNode:setPosition(width, 0)
        rootNode:addChild(towerNode)
        self.myTowerNodeMap_[id] = towerNode
        local size = towerNode:getContentSize()
        width = width + size.width + (i < #ids and offsetX or 0)
        height = size.height
    end

    rootNode:setContentSize(cc.size(width, height))
end

return FightPage