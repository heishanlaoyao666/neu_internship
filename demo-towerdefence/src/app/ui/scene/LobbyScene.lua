--[[--
    LobbyScene.lua

    描述：大厅场景类
]]
local LobbyScene = class("LobbyScene", require("app.ui.scene.BaseScene"))
local TopBar = require("app.ui.view.lobby.TopBar")
local BottomBar = require("app.ui.view.lobby.BottomBar")
local ShopPage = require("app.ui.view.lobby.shop.ShopPage")
local FightPage = require("app.ui.view.lobby.fight.FightPage")
local AtlasPage = require("app.ui.view.lobby.atlas.AtlasPage")
local LobbyDef = require("app.def.LobbyDef")
local SoundManager = require("app.manager.SoundManager")
local Log = require("app.util.Log")

-- PageView的页面序号与页面id对应关系
local PAGE_INDEX_2_ID = {
    [0] = LobbyDef.PAGE_ID.SHOP,
    [1] = LobbyDef.PAGE_ID.FIGHT,
    [2] = LobbyDef.PAGE_ID.ATLAS,
}

-- 页面id对应关系与PageView的页面序号
local PAGE_ID_2_INDEX = {
    [LobbyDef.PAGE_ID.SHOP] = 0,
    [LobbyDef.PAGE_ID.FIGHT] = 1,
    [LobbyDef.PAGE_ID.ATLAS] = 2,
}

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------
local _initPages
local _onPageEvent
local _onSelectPage

--[[--
    描述：构造函数
    
    @param ...
    
    @return none
]]
function LobbyScene:ctor(...)
    LobbyScene.super.ctor(self, ...)

    Log.d()

    self.topBar_ = nil -- 类型：TopBar，顶部信息栏
    self.bottomBar_ = nil -- 类型：BottomBar，底部按钮栏
    self.pageView_ = nil -- 类型：PageView，中间滑动区域
    self.shopPage_ = nil -- 类型：ShopPage，商城页面
    self.fightPage_ = nil -- 类型：FightPage，战斗页面
    self.atlasPage_ = nil -- 类型：AtlasPage，图鉴页面
end

--[[--
    描述：场景进入

    @param none

    @return none
]]
function LobbyScene:onEnter()
    LobbyScene.super.onEnter(self)

    Log.d()

    -- 初始化顶部信息栏
    self.topBar_ = TopBar.new()
    self:addChild(self.topBar_, 1)

    -- 初始化底部按钮栏
    self.bottomBar_ = BottomBar.new(handler(self, _onSelectPage))
    self:addChild(self.bottomBar_, 1)

    -- 初始化中间滑动区域
    _initPages(self)
end

--[[--
    2dx 中 scene 的生命周期，由 2dx 回调 onEnterTransitionFinish
    @param none

    @return none
]]
function LobbyScene:onEnterTransitionFinish()
    LobbyScene.super.onEnterTransitionFinish(self)

    Log.d()

    SoundManager:playBGM(SoundManager.DEF.BGM.LOBBY)
end

---------------------------------------------------------------------------
-- 私有函数实现
---------------------------------------------------------------------------

--[[
    描述：初始化页面（商城、战斗、图鉴）

    @param self 类型：LobbyScene，当前节点

    @return none
]]
function _initPages(self)
    -- 初始化容器，此处使用cocos提供的PageView实现滑动区域容器，容器对应全屏，内部元素自行适配
    self.pageView_ = ccui.PageView:create()
    self.pageView_:setContentSize(cc.size(display.width, display.height))
    self.pageView_:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    self.pageView_:setPosition(0, 0)
    self:addChild(self.pageView_)

    -- 初始化商店页面
    self.shopPage_ = ShopPage.new()
    self.pageView_:addPage(self.shopPage_)

    -- 初始化战斗页面
    self.fightPage_ = FightPage.new()
    self.pageView_:addPage(self.fightPage_)

    -- 初始化图鉴页面
    self.atlasPage_ = AtlasPage.new()
    self.pageView_:addPage(self.atlasPage_)

    self.pageView_:addEventListener(handler(self, _onPageEvent))
    self.pageView_:scrollToPage(PAGE_ID_2_INDEX[LobbyDef.PAGE_ID.FIGHT])
end

--[[
    描述：滑动页面事件回调

    @param self 类型：LobbyScene，当前节点
    @param sender 类型：PageView，事件发送者
    @param event 类型：number，滑动事件

    @return none
]]
function _onPageEvent(self, sender, event)
    if event == ccui.PageViewEventType.turning then
        local pageIndex = sender:getCurPageIndex()

        Log.d("pageIndex=", pageIndex)

        self.bottomBar_:setPageId(PAGE_INDEX_2_ID[pageIndex])
    end
end

--[[
    描述：页面选择回调

    @param self 类型：LobbyScene，当前节点
    @param pageId 类型：number，选中的页面

    @return none
]]
function _onSelectPage(self, pageId)
    Log.d("pageId=", pageId)

    self.pageView_:scrollToPage(PAGE_ID_2_INDEX[pageId])
end

return LobbyScene