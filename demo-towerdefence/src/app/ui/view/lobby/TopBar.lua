--[[--
    TopBar.lua

    描述：顶部信息栏
]]
local TopBar = class("TopBar", require("app.ui.view.common.BaseNode"))
local SoundManager = require("app.manager.SoundManager")
local DialogManager = require("app.manager.DialogManager")
local UserInfo = require("app.data.UserInfo")
local Log = require("app.util.Log")

local RES_DIR = "img/lobby/topbar/"

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------
local _initUserInfo
local _addIconLabel

--[[--
    描述：构造函数

    @param ...

    @return none
]]
function TopBar:ctor()
    TopBar.super.ctor(self)

    Log.d()

    self.figureSprite_ = nil -- 类型：Sprite，头像精灵
    self.nicknameLabel_ = nil -- 类型：Label，昵称文本
    self.trophyLabel_ = nil -- 类型：Label，奖杯文本
    self.goldLabel_ = nil -- 类型：Label，金币文本
    self.diamondLabel_ = nil -- 类型：Label，钻石文本
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function TopBar:onEnter()
    TopBar.super.onEnter(self)

    Log.d()

    -- 初始化底图
    local bgSprite = display.newSprite(RES_DIR .. "bg.png")
    bgSprite:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    bgSprite:setPosition(0, 0)
    bgSprite:setScaleX(display.scaleX)
    bgSprite:setScaleY(display.scale)
    self:addChild(bgSprite, -1)

    -- 重置容器
    self:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_TOP])
    local bgSize = bgSprite:getContentSize()
    local width, height = bgSize.width * display.scaleX, bgSize.height * display.scale
    self:setContentSize(width, height)
    self:setPosition(display.left, display.top)
    local cx, cy = width * 0.5, height * 0.5

    -- 初始化头像
    self.figureSprite_ = display.newSprite(RES_DIR .. "figure_default.png")
    self.figureSprite_:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_CENTER])
    self.figureSprite_:setPosition(10 * display.scaleX, cy)
    self.figureSprite_:setScale(display.scale)
    self:addChild(self.figureSprite_)

    -- 初始化玩家信息
    _initUserInfo(self)

    -- 添加金币
    local x = cx + 90 * display.scaleX
    self.goldLabel_ = _addIconLabel(self, true, tostring(UserInfo:getGold()), x, cy + 30 * display.scale)

    -- 添加钻石
    self.diamondLabel_ = _addIconLabel(self, false, tostring(UserInfo:getDiamond()), x, cy - 30 * display.scale)

    -- 初始化菜单按钮
    local menuBtn = ccui.Button:create(RES_DIR .. "btn_menu.png"):addTo(self)
    menuBtn:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
    menuBtn:setPosition(display.right - 65 * display.scaleX, cy)
    menuBtn:setScale(display.scale)
    menuBtn:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            SoundManager:playEffect(SoundManager.DEF.EFFECT.BTN_CLICK)
            DialogManager:showDialog(DialogManager.DEF.ID.MENU)
        end
    end)

    self:setTouchEnable(true)
end

--[[--
    描述：节点退出

    @param none

    @return none
]]
function TopBar:onExit()
    TopBar.super.onExit(self)

    Log.d()
end

---------------------------------------------------------------------------
-- 私有函数实现
---------------------------------------------------------------------------

--[[
    描述：初始化玩家信息（头像、昵称、奖杯）

    @param self 类型：TopBar，当前节点

    @return none
]]
function _initUserInfo(self)
    local cy = self:getContentSize().height * 0.5

    -- 初始化底图
    local bgSprite = display.newSprite(RES_DIR .. "bg_userinfo.png")
    bgSprite:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_CENTER])
    bgSprite:setPosition(130 * display.scale, cy)
    bgSprite:setScaleX(display.scaleX)
    bgSprite:setScaleY(display.scale)
    self:addChild(bgSprite)

    local left = 140 * display.scale

    -- 初始化昵称
    self.nicknameLabel_ = display.newTTFLabel({
        text = UserInfo:getNickname(),
        font = "font/fzzchjw.ttf",
        size = 20 * display.scaleX,
    })
    self.nicknameLabel_:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_CENTER])
    self.nicknameLabel_:setPosition(left + 5 * display.scaleX, cy + 20 * display.scale)
    self:addChild(self.nicknameLabel_)

    -- 初始化奖杯图标
    local iconSprite = display.newSprite(RES_DIR .. "icon_trophy.png")
    iconSprite:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_CENTER])
    iconSprite:setPosition(left, cy - 20 * display.scale)
    iconSprite:setScale(display.scale)
    self:addChild(iconSprite)

    -- 初始化奖杯文本
    self.trophyLabel_ = display.newTTFLabel({
        text = tostring(UserInfo:getTrophy()),
        font = "font/fzbiaozjw.ttf",
        size = 20 * display.scale,
    })
    self.trophyLabel_:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_CENTER])
    self.trophyLabel_:setPosition(190 * display.scaleX, iconSprite:getPositionY())
    self:addChild(self.trophyLabel_)
end

--[[
    描述：创建图标文本

    @param self 类型：TopBar，当前节点
    @param isGold 类型：boolean，是否金币，true 为金币；false 为钻石
    @param text 类型：string，文本显示内容
    @param x 类型：number，容器坐标x
    @param y 类型：number，容器坐标y

    @return Label
]]
function _addIconLabel(self, isGold, text, x, y)
    -- 初始化容器
    local node = display.newNode()
    node:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_CENTER])
    node:setPosition(x, y)
    self:addChild(node)

    -- 初始化底图
    local bgSprite = display.newSprite(RES_DIR .. "bg_money.png")
    bgSprite:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    bgSprite:setPosition(0, 0)
    bgSprite:setScaleX(display.scaleX)
    bgSprite:setScaleY(display.scale)
    node:addChild(bgSprite)

    local bgSize = bgSprite:getContentSize()
    local width, height = bgSize.width * display.scaleX, bgSize.height * display.scale
    local cy = height * 0.5
    node:setContentSize(width, height)

    -- 初始化图标
    local iconSprite = display.newSprite(RES_DIR .. (isGold and "icon_gold.png" or "icon_diamond.png"))
    iconSprite:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_CENTER])
    iconSprite:setPosition(0, cy)
    iconSprite:setScale(display.scale)
    node:addChild(iconSprite)

    -- 初始化文本
    local label = display.newTTFLabel({
        text = text,
        font = "font/fzbiaozjw.ttf",
        size = 26 * display.scale,
        color = display.COLOR_WHITE,
    })
    label:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_CENTER])
    label:setPosition(iconSprite:getContentSize().width * display.scale + 10 * display.scale, cy)
    node:addChild(label)
end

return TopBar