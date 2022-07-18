--[[--
    BottomButton.lua

    描述：大厅底部按钮
]]
local BottomButton = class("BottomButton", require("app.ui.view.common.BaseNode"))
local SoundManager = require("app.manager.SoundManager")
local LobbyDef = require("app.def.LobbyDef")
local Log = require("app.util.Log")

local RES_DIR = "img/lobby/bottombar/"

local RES_DIC = {
    [LobbyDef.PAGE_ID.SHOP] = {
        bg = RES_DIR .. "bg_shop.png",
        icon = RES_DIR .. "icon_shop.png",
        text = RES_DIR .. "text_shop.png",
    },
    [LobbyDef.PAGE_ID.FIGHT] = {
        bg = RES_DIR .. "bg_fight.png",
        icon = RES_DIR .. "icon_fight.png",
        text = RES_DIR .. "text_fight.png",
    },
    [LobbyDef.PAGE_ID.ATLAS] = {
        bg = RES_DIR .. "bg_atlas.png",
        icon = RES_DIR .. "icon_atlas.png",
        text = RES_DIR .. "text_atlas.png",
    },
}

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------
local _refresh

--[[--
    描述：构造函数

    @param pageId 类型：number，页面id
    @param isSelected 类型：boolean，是否选中状态
    @param onSelectedCallback 类型：function，选中回调，参数为pageId

    @return none
]]
function BottomButton:ctor(pageId, isSelected, onSelectedCallback)
    BottomButton.super.ctor(self)

    self.pageId_ = pageId -- 类型：number，页面id
    self.isSelected_ = isSelected -- 类型：boolean，是否选中状态
    self.onSelectedCallback_ = onSelectedCallback -- 类型：function，选中回调，参数为pageId

    self.bgSprite_ = nil -- 类型：Sprite，底图精灵
    self.iconSprite_ = nil -- 类型：Sprite，图标精灵
    self.textSprite_ = nil -- 类型：Sprite，文字精灵
    self.selectedSprite_ = nil -- 类型：Sprite，选中精灵
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function BottomButton:onEnter()
    self:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    self:setClickEnable(true)

    local res = RES_DIC[self.pageId_]

    -- 初始化底图
    self.bgSprite_ = display.newSprite(res.bg)
    self.bgSprite_:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    self.bgSprite_:setPosition(0, 0)
    self.bgSprite_:setScaleX(display.scaleX)
    self.bgSprite_:setScaleY(display.scale)
    self:addChild(self.bgSprite_)

    -- 初始化选中底图
    self.selectedSprite_ = display.newSprite(RES_DIR .. "bg_selected.png")
    self.selectedSprite_:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    self.selectedSprite_:setPosition(0, 0)
    self.selectedSprite_:setScaleX(display.scaleX)
    self.selectedSprite_:setScaleY(display.scale)
    self:addChild(self.selectedSprite_)

    -- 初始化图标
    self.iconSprite_ = display.newSprite(res.icon)
    self.iconSprite_:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER_BOTTOM])
    self.iconSprite_:setScale(display.scale)
    self:addChild(self.iconSprite_)

    -- 初始化文字
    self.textSprite_ = display.newSprite(res.text)
    self.textSprite_:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER_BOTTOM])
    self.textSprite_:setScale(display.scale)
    self:addChild(self.textSprite_)

    _refresh(self)
end

--[[--
    描述：获取页面id

    @param none

    @return number
]]
function BottomButton:getPageId()
    return self.pageId_
end

--[[--
    描述：设置是否选中

    @param isSelected 类型：boolean，是否选中

    @return none
]]
function BottomButton:setSelected(isSelected)
    if not isBoolean(isSelected) then
        return
    end

    if isSelected == self.isSelected_ then
        return
    end

    self.isSelected_ = isSelected

    _refresh(self)
end

--[[--
    描述：是否选中

    @param none

    @return boolean
]]
function BottomButton:isSelected()
    return self.isSelected_
end

--[[--
    描述：点击回调

    @param none

    @return none
]]
function BottomButton:onClick()
    BottomButton.super.onClick(self)

    SoundManager:playEffect(SoundManager.DEF.EFFECT.BTN_CLICK)

    -- 设置选中，点击无非选中
    self:setSelected(true)

    -- 注意，回调执行要在页面刷新之后
    if self.onSelectedCallback_ then
        self.onSelectedCallback_(self.pageId_)
    end
end

---------------------------------------------------------------------------
-- 私有函数实现
---------------------------------------------------------------------------

--[[
    描述：刷新节点

    @param self 类型：BottomButton，当前节点

    @return none
]]
function _refresh(self)
    -- 刷新显隐
    self.selectedSprite_:setVisible(self.isSelected_)
    self.bgSprite_:setVisible(not self.isSelected_)
    self.textSprite_:setVisible(self.isSelected_)

    local size = self.bgSprite_:getContentSize()
    if self.isSelected_ then
        size = self.selectedSprite_:getContentSize()
    end

    local width = size.width * display.scaleX
    local cx = width * 0.5

    -- 重置容器，用以父节点进行坐标调整
    self:setContentSize(cc.size(width, size.height * display.scale))

    -- 调整坐标
    self.textSprite_:setPositionX(cx)

    local iconY = 0
    if self.isSelected_ then
        iconY = self.textSprite_:getContentSize().height * display.scale
    end

    self.iconSprite_:setPosition(cx, iconY)
end

return BottomButton