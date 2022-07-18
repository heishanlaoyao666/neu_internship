--[[--
    BottomBar.lua

    描述：底部按钮栏
]]
local BottomBar = class("BottomBar", require("app.ui.view.common.BaseNode"))
local BottomButton = require("app.ui.view.lobby.BottomButton")
local LobbyDef = require("app.def.LobbyDef")
local Log = require("app.util.Log")

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------
local _refresh
local _onSlected

--[[--
    描述：构造函数

    @param onSelectPageCallback 类型：function，页面选中回调，参数：pageId

    @return none
]]
function BottomBar:ctor(onSelectPageCallback)
    BottomBar.super.ctor(self)

    Log.d()

    self.onSelectPageCallback_ = onSelectPageCallback -- 类型：function，页面选中回调，参数：pageId
    self.btns_ = {} -- 类型：table，按钮数组，内部元素BottomButton，注意，从左至右排序
    self.btnMap_ = {} -- 类型：table，按钮数据，key为pageId，value为BottomButton，为方便查找
    self.currentPageId_ = LobbyDef.PAGE_ID.FIGHT -- 类型：number，当前的页面id
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function BottomBar:onEnter()
    BottomBar.super.onEnter(self)

    Log.d()

    self:setContentSize(cc.size(display.width, 115 * display.scale))
    self:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    self:setPosition(0, 0)

    -- id列表，用以排序
    local ids = { LobbyDef.PAGE_ID.SHOP, LobbyDef.PAGE_ID.FIGHT, LobbyDef.PAGE_ID.ATLAS, }
    for i = 1, #ids do
        local id = ids[i]
        local isSelected = id == LobbyDef.PAGE_ID.FIGHT
        local btn = BottomButton.new(id, isSelected, handler(self, _onSlected))
        self:addChild(btn)
        self.btns_[#self.btns_ + 1] = btn
        self.btnMap_[ids[i]] = btn
    end

    _refresh(self)
end

--[[--
    描述：节点退出

    @param none

    @return none
]]
function BottomBar:onExit()
    BottomBar.super.onExit(self)

    Log.d()
end

--[[--
    描述：设置当前选中的页面id

    @param pageId 类型：number，页面id

    @return none
]]
function BottomBar:setPageId(pageId)
    if not isNumber(pageId) then
        Log.e("unexpect param, pageId=", pageId)
        return
    end

    if pageId == self.currentPageId_ then
        return
    end

    self.btnMap_[self.currentPageId_]:setSelected(false)
    self.currentPageId_ = pageId
    self.btnMap_[self.currentPageId_]:setSelected(true)

    _refresh(self)
end

---------------------------------------------------------------------------
-- 私有函数实现
---------------------------------------------------------------------------

--[[
    描述：刷新节点

    @param self 类型：BottomBar，当前节点

    @return none
]]
function _refresh(self)
    local x = 0
    for i = 1, #self.btns_ do
        local btn = self.btns_[i]
        btn:setPositionX(x)
        x = x + btn:getContentSize().width
    end
end

--[[
    描述：底部按钮选中回调

    @param self 类型：BottomBar，当前节点
    @param pageId 类型：number，页面id

    @return none
]]
function _onSlected(self, pageId)
    Log.d("pageId=", pageId)

    if pageId == self.currentPageId_ then
        return
    end

    self.btnMap_[self.currentPageId_]:setSelected(false)
    self.currentPageId_ = pageId

    _refresh(self)

    if self.onSelectPageCallback_ then
        self.onSelectPageCallback_(pageId)
    end
end

return BottomBar