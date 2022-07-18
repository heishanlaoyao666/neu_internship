--[[--
    BaseNode.lua

    描述：节点基类，来自CCNode，用于本工程的通用方法封装
]]
local BaseNode = class("BaseNode", function() return cc.Node:create() end)
local EventManager = require("app.manager.EventManager")
local Log = require("app.util.Log")

--[[--
    描述：构造函数

    @param none

    @return none
]]
function BaseNode:ctor()
    Log.d()

    self.isDestroy_ = false -- 类型：boolean，是否被销毁，onExit调用时被赋初值，不可逆
    self.isUpdateEnable_ = false -- 类型：boolean，是否启动帧刷新
    self.isTouchEnable_ = false -- 类型：boolean，是否允许触摸
    self.isClickEnable_ = false -- 类型：boolean，是否允许点击
    self.touchHandlerMap_ = {} -- 类型：table，touch事件处理函数表，key为began、moved、ended、cancled，value为function
    self.onClickListener_ = nil -- 类型：function，点击回调
    self.registEventIds_ = {} -- 类型：table，注册的监听，用以方便子类注册、销毁

    -- 注册触摸处理回调函数，避免每次if，注意，事件id的定义来自NodeEX扩展
    self.touchHandlerMap_["began"] = handler(self, self.onTouchBegan)
    self.touchHandlerMap_["moved"] = handler(self, self.onTouchMoved)
    self.touchHandlerMap_["ended"] = handler(self, self.onTouchEnded)
    self.touchHandlerMap_["cancelled"] = handler(self, self.onTouchCancled)

    -- NodeEX扩展，注册生命周期函数
    self:setNodeEventEnabled(true)
end

--[[--
    描述：注册事件监听，onExit时统一销毁
    
    @param eventId 类型：number，事件id
    @param listener 类型：function，监听函数
    
    @return none
]]
function BaseNode:registerEvent(eventId, listener)
    if not eventId or not isFunction(listener) then
        Log.e("unexpect param, eventId=", eventId, ", listener=", listener)
        return
    end

    self.registEventIds_[#self.registEventIds_ + 1] = eventId
    EventManager:registerListener(eventId, self, listener)
end

--[[--
    描述：初始化底图
    注意：底图会调整当前节点的size
    注意：底图的层级为-1

    @param path 类型：string，底图路径

    @return none
]]
function BaseNode:initBg(path)
    local bgSprite = display.newSprite(path, 0, 0)
    bgSprite:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    self:addChild(bgSprite)

    self:setContentSize(bgSprite:getContentSize())
end

--[[--
    描述：初始化测试底图，一个colorlayer，用以直观观察区域

    @param color4 类型：c4b，颜色

    @return none
]]
function BaseNode:initTestBg(color4)
    local colorLayer = display.newColorLayer(color4)
    colorLayer:setContentSize(self:getContentSize())
    colorLayer:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    colorLayer:setPosition(0, 0)
    self:addChild(colorLayer, -1)
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function BaseNode:onEnter()
    Log.d()
end

--[[--
    描述：节点退出

    @param none

    @return none
]]
function BaseNode:onExit()
    Log.d()

    self.isDestroy_ = true

    self:removeAllNodeEventListeners()

    if #self.registEventIds_ > 0 then
        -- 清理注册的事件
        for i = 1, #self.registEventIds_ do
            EventManager:unregisterListener(self.registEventIds_[i], self)
        end

        self.registEventIds_ = {}
    end
end

--[[--
    描述：帧刷新

    @param dt 类型：number，帧刷新间隔，单位：秒

    @return none
]]
function BaseNode:onUpdate(dt)

end

--[[--
    描述：节点是否被销毁

    @param none

    @return boolean
]]
function BaseNode:isDestroy()
    return self.isDestroy_
end

--[[--
    描述：设置帧刷新是否生效

    @param isEnable 类型：boolean，是否生效

    @return none
]]
function BaseNode:setUpdateEnable(isEnable)
    if not isBoolean(isEnable) then
        Log.e("unexpecet param, isEnable=", isEnable)
        return
    end

    if self.isUpdateEnable_ == isEnable then
        return
    end

    self.isUpdateEnable_ = isEnable

    if isEnable then
        -- NodeEX扩展，先添加帧刷新回调，再启动帧刷新
        self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.onUpdate))
        self:scheduleUpdate()
    else
        self:removeNodeEventListener(cc.NODE_ENTER_FRAME_EVENT)
    end
end

--[[--
    描述：帧刷新是否启用

    @param none

    @return boolean
]]
function BaseNode:isUpdateEnable()
    return self.isUpdateEnable_
end

--[[--
    描述：设置是否允许触摸

    @param isTouchEnable 类型：boolean，是否允许触摸

    @return none
]]
function BaseNode:setTouchEnable(isEnable)
    if not isBoolean(isEnable) then return end

    if isEnable then
        self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
            return self.touchHandlerMap_[event.name](event.x, event.y)
        end)
        self:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE) -- NodeEX扩展，注册单点
        self:setTouchSwallowEnabled(true) -- NodeEX扩展，允许吞噬触摸，防止透传
    else
        self:removeNodeEventListener(cc.NODE_TOUCH_EVENT)
    end

    -- NodeEX扩展，注意，方法名不同
    self:setTouchEnabled(self, isEnable)

    self.isTouchEnable_ = isEnable
end

--[[--
    描述：是否允许触摸

    @param none

    @return boolean
]]
function BaseNode:isTouchEnable()
    return self.isTouchEnable_
end

--[[--
    描述：设置是否允许点击

    @param isEnable 类型：boolean，是否允许点击

    @return none
]]
function BaseNode:setClickEnable(isEnable)
    if not isBoolean(isEnable) then return end

    if isEnable == self.isClickEnable_ then
        return
    end

    self.isClickEnable_ = isEnable

    if isEnable then
        self:setTouchEnable(true)
    end
end

--[[--
    描述：是否允许点击

    @param none

    @return boolean
]]
function BaseNode:isClickEnable()
    return self.isClickEnable_
end

--[[--
    描述：触摸开始回调
    
    @param touchX 类型：number，触摸坐标x
    @param touchY 类型：number，触摸坐标y
    
    @return boolean 注意，返回true，后面的move等才生效；返回false，则无后面的触摸回调；
]]
function BaseNode:onTouchBegan(x, y)
    if self.isClickEnable_ then
        return true
    end

    return false
end

--[[--
    描述：触摸移动回调

    @param touchX 类型：number，触摸坐标x
    @param touchY 类型：number，触摸坐标y

    @return none
]]
function BaseNode:onTouchMoved(x, y)
end

--[[--
    描述：触摸结束回调

    @param touchX 类型：number，触摸坐标x
    @param touchY 类型：number，触摸坐标y

    @return boolean
]]
function BaseNode:onTouchEnded(x, y)
    self:onClick()
end

--[[--
    描述：触摸取消回调

    @param touchX 类型：number，触摸坐标x
    @param touchY 类型：number，触摸坐标y

    @return boolean
]]
function BaseNode:onTouchCancled(x, y)
end

--[[--
    描述：设置点击回调

    @param onClickListener 类型：function，点击回调，参数返回当前节点

    @param none
]]
function BaseNode:setOnClickListener(onClickListener)
    self.onClickListener_ = onClickListener
end

--[[--
    描述：点击回调

    @param none

    @return none
]]
function BaseNode:onClick()
    if self.onClickListener_ then
        self.onClickListener_(self)
    end
end

return BaseNode