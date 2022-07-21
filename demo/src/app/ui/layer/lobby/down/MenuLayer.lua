--[[
    SpriteLayer.lua
    菜单层
    描述：菜单层
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]

local MenuLayer = class("MenuLayer", require("app.ui.layer.BaseLayer"))
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")
local ConstDef = require("app.def.ConstDef")

--[[--
    构造函数

    @param none

    @return none
]]
function MenuLayer:ctor()
    MenuLayer.super.ctor(self)

    self.container_ = nil

    self.storeBtn_ = nil
    self.pictorialBtn_ = nil
    self.pictorialBtn_ = nil

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function MenuLayer:initView()
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(ConstDef.WINDOW_SIZE.DOWNBAR.WIDTH,
            ConstDef.WINDOW_SIZE.DOWNBAR.HEIGHT) -- 设置为顶部栏大小
    self.container_:setAnchorPoint(0, 0)
    self.container_:setPosition(0, 0)
    self:addChild(self.container_)


    local width, height = ConstDef.TAB_SIZE.UNSELECTED.WIDTH,
            ConstDef.TAB_SIZE.UNSELECTED.HEIGHT


    -- 商店
    self.unselectedStoreTab_ = ccui.Layout:create() -- 未选中
    self.unselectedStoreTab_:setBackGroundImage("image/lobby/down/unselected_left_tab.png")
    self.unselectedStoreTab_:setContentSize(width, height)
    self.unselectedStoreTab_:setAnchorPoint(0, 0)
    self.unselectedStoreTab_:setPosition(0, 0)
    self:addChild(self.unselectedStoreTab_)
    local unselectStoreIcon = ccui.ImageView:create("image/lobby/down/store_icon.png")
    unselectStoreIcon:setPosition(0.5*width, 0.5*height)
    self.unselectedStoreTab_:addChild(unselectStoreIcon)

    self.selectedStoreTab_ = ccui.Layout:create() -- 选中
    self.selectedStoreTab_:setBackGroundImage("image/lobby/down/selected_tab.png")
    self.selectedStoreTab_:setContentSize(width, height)
    self.selectedStoreTab_:setAnchorPoint(0, 0)
    self.selectedStoreTab_:setPosition(0, 0)
    self:addChild(self.selectedStoreTab_)
    local selectStoreIcon = ccui.ImageView:create("image/lobby/down/store_icon.png")
    selectStoreIcon:setPosition(0.5*width, 0.7*height)
    self.selectedStoreTab_:addChild(selectStoreIcon)
    local selectedStoreTitle = ccui.ImageView:create("image/lobby/down/store_title.png")
    selectedStoreTitle:setPosition(0.5*width, 0.2*height)
    self.selectedStoreTab_:addChild(selectedStoreTitle)
    self.selectedStoreTab_:setVisible(false)

    self.unselectedStoreTab_:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        print("商店")
        if event.name == "began" then
            EventManager:doEvent(EventDef.ID.LOBBY_VIEW_SWITCH, ConstDef.LOBBY_VIEW_CODE.STORE)
        end
    end)
    self.unselectedStoreTab_:setTouchEnabled(true)


    -- 战斗
    self.unselectedFightTab_ = ccui.Layout:create() -- 未选中
    self.unselectedFightTab_:setBackGroundImage("image/lobby/down/unselected_middle_tab.png")
    self.unselectedFightTab_:setContentSize(width, height)
    self.unselectedFightTab_:setAnchorPoint(0.5, 0)
    self.unselectedFightTab_:setPosition(0.5*display.width, 0)
    self:addChild(self.unselectedFightTab_)
    local unselectedFightIcon = ccui.ImageView:create("image/lobby/down/fight_icon.png")
    unselectedFightIcon:setPosition(width/2, height/2)
    self.unselectedFightTab_:addChild(unselectedFightIcon)

    self.selectedFightTab_ = ccui.Layout:create() -- 选中
    self.selectedFightTab_:setBackGroundImage("image/lobby/down/selected_tab.png")
    self.selectedFightTab_:setContentSize(width, height)
    self.selectedFightTab_:setAnchorPoint(0.5, 0)
    self.selectedFightTab_:setPosition(0.5*display.width, 0)
    self:addChild(self.selectedFightTab_)
    local selectFightIcon = ccui.ImageView:create("image/lobby/down/fight_icon.png")
    selectFightIcon:setPosition(0.5*width, 0.7*height)
    self.selectedFightTab_:addChild(selectFightIcon)
    local selectedFightTitle = ccui.ImageView:create("image/lobby/down/fight_title.png")
    selectedFightTitle:setPosition(0.5*width, 0.2*height)
    self.selectedFightTab_:addChild(selectedFightTitle)
    self.selectedFightTab_:setVisible(true)

    self.unselectedFightTab_:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        print("战斗")
        if event.name == "began" then
            EventManager:doEvent(EventDef.ID.LOBBY_VIEW_SWITCH, ConstDef.LOBBY_VIEW_CODE.INDEX)
        end
    end)
    self.unselectedFightTab_:setTouchEnabled(true)


    -- 图鉴
    self.unselectedPictorialTab_ = ccui.Layout:create() -- 未选中
    self.unselectedPictorialTab_:setBackGroundImage("image/lobby/down/unselected_right_tab.png")
    self.unselectedPictorialTab_:setContentSize(width, height)
    self.unselectedPictorialTab_:setAnchorPoint(1, 0)
    self.unselectedPictorialTab_:setPosition(display.width, 0)
    self:addChild(self.unselectedPictorialTab_)
    local unselectedPictorialIcon = ccui.ImageView:create("image/lobby/down/pictorial_icon.png")
    unselectedPictorialIcon:setPosition(width/2, height/2)
    self.unselectedPictorialTab_:addChild(unselectedPictorialIcon)

    self.selectedPictorialTab_ = ccui.Layout:create() -- 选中
    self.selectedPictorialTab_:setBackGroundImage("image/lobby/down/selected_tab.png")
    self.selectedPictorialTab_:setContentSize(width, height)
    self.selectedPictorialTab_:setAnchorPoint(1, 0)
    self.selectedPictorialTab_:setPosition(display.width, 0)
    self:addChild(self.selectedPictorialTab_)
    local selectedPictorialIcon = ccui.ImageView:create("image/lobby/down/pictorial_icon.png")
    selectedPictorialIcon:setPosition(0.5*width, 0.7*height)
    self.selectedPictorialTab_:addChild(selectedPictorialIcon)
    local selectedPictorialTitle = ccui.ImageView:create("image/lobby/down/fight_title.png")
    selectedPictorialTitle:setPosition(0.5*width, 0.2*height)
    self.selectedPictorialTab_:addChild(selectedPictorialTitle)
    self.selectedPictorialTab_:setVisible(false)

    self.unselectedPictorialTab_:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        print("图鉴")
        if event.name == "began" then
            EventManager:doEvent(EventDef.ID.LOBBY_VIEW_SWITCH, ConstDef.LOBBY_VIEW_CODE.PICTORIAL)
        end
    end)
    self.unselectedPictorialTab_:setTouchEnabled(true)

end

--[[--
    节点进入

    @param none

    @return none
]]
function MenuLayer:onEnter()

    -- 大厅视图切换事件
    EventManager:regListener(EventDef.ID.LOBBY_VIEW_SWITCH, self, function(code)
        if code == ConstDef.LOBBY_VIEW_CODE.STORE then -- 商店
            self.selectedStoreTab_:setVisible(true)
            self.selectedFightTab_:setVisible(false)
            self.selectedPictorialTab_:setVisible(false)
        elseif code == ConstDef.LOBBY_VIEW_CODE.INDEX then -- 主页
            self.selectedStoreTab_:setVisible(false)
            self.selectedFightTab_:setVisible(true)
            self.selectedPictorialTab_:setVisible(false)
        elseif code == ConstDef.LOBBY_VIEW_CODE.PICTORIAL then -- 图鉴
            self.selectedStoreTab_:setVisible(false)
            self.selectedFightTab_:setVisible(false)
            self.selectedPictorialTab_:setVisible(true)
        end
    end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function MenuLayer:onExit()
    EventManager:unRegListener(EventDef.ID.LOBBY_VIEW_SWITCH, self)
end


--[[--
    帧循环

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function MenuLayer:update(dt)
end

return MenuLayer