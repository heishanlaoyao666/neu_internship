--[[--
    MenuButton.lua

    描述：菜单对话框按钮
]]
local MenuButton = class("MenuButton", require("app.ui.view.common.BaseNode"))
local SoundManager = require("app.manager.SoundManager")
local Log = require("app.util.Log")

-- 按钮类型，注意，此处的id对应了资源名称，用时注意
MenuButton.ID = {
    NOTICE = 1,
    MAIL = 2,
    RECORD = 3,
    SETTING = 4,
}

local RES_DIR = "img/lobby/menu/"

--[[--
    描述：构造函数

    @param btnId 类型：number，按钮id，参考：MenuButton.ID
    @param onClickCallback 类型：number，点击回调，参数：btnId

    @return none
]]
function MenuButton:ctor(btnId, onClickCallback)
    MenuButton.super.ctor(self)

    Log.d()

    self.btnId_ = btnId -- 类型：number，按钮id，参考：MenuButton.ID
    self.onClickCallback_ = onClickCallback -- 类型：number，点击回调，参数：btnId

    self.isClick_ = false -- 类型：boolean，判断是否一次点击
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function MenuButton:onEnter()
    MenuButton.super.onEnter(self)

    Log.d()

    -- 初始化底图
    self:initBg(RES_DIR .. "bg_btn.png")

    self:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
    self:setScale(display.scale) -- 内部元素都是图片，整体缩放
    self:setTouchEnable(true)

    local x = 10
    local cy = self:getContentSize().height * 0.5

    -- 初始化图标
    local iconSprite = display.newSprite(string.format("%sicon_%d.png", RES_DIR, self.btnId_))
    iconSprite:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_CENTER])
    iconSprite:setPosition(x, cy)
    self:addChild(iconSprite)

    x = x + iconSprite:getContentSize().width + 10

    -- 初始化文字
    local titleSprite = display.newSprite(string.format("%stitle_%d.png", RES_DIR, self.btnId_))
    titleSprite:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_CENTER])
    titleSprite:setPosition(x, cy)
    self:addChild(titleSprite)
end

--[[--
    描述：触摸开始回调

    @param touchX 类型：number，触摸坐标x
    @param touchY 类型：number，触摸坐标y

    @return boolean 注意，返回true，后面的move等才生效；返回false，则无后面的触摸回调；
]]
function MenuButton:onTouchBegan(x, y)
    -- 点击缩小按钮
    self:setScale(0.9 * display.scale)
    self.isClick_ = true -- 因在NodeEx中已经判断，肯定是在范围内才会调用onTouchBegan，直接设置true

    return true
end

--[[--
    描述：触摸移动回调

    @param touchX 类型：number，触摸坐标x
    @param touchY 类型：number，触摸坐标y

    @return none
]]
function MenuButton:onTouchMoved(x, y)
    if not self:hitTest(cc.p(x, y)) then
        self:setScale(display.scale)
        self.isClick_ = false
    end
end

--[[--
    描述：触摸结束回调

    @param touchX 类型：number，触摸坐标x
    @param touchY 类型：number，触摸坐标y

    @return boolean
]]
function MenuButton:onTouchEnded(x, y)
    -- 如果触摸点中途离开过按钮区域，则不认为是有效点击
    if self.isClick_ then
        SoundManager:playEffect(SoundManager.DEF.EFFECT.BTN_CLICK)

        if self.onClickCallback_ then
            self.onClickCallback_(self.btnId_)
        end
    end

    self:setScale(display.scale)
    self.isClick_ = false
end

--[[--
    描述：触摸取消回调

    @param touchX 类型：number，触摸坐标x
    @param touchY 类型：number，触摸坐标y

    @return boolean
]]
function MenuButton:onTouchCancled(x, y)
    self:setScale(display.scale)
    self.isClick_ = false
end

return MenuButton