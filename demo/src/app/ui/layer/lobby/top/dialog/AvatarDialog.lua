--[[
    AvatarDialog.lua
    头像弹窗
    描述：头像弹窗
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local AvatarDialog = class("AvatarDialog", require("app.ui.layer.BaseLayer"))
local ConstDef = require("app.def.ConstDef")
local PlayerData = require("app.data.PlayerData")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")
local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

--[[--
    构造函数

    @param none

    @return none
]]
function AvatarDialog:ctor()
    AvatarDialog.super.ctor(self)

    self.container_ = nil -- 全局容器

    self.curAvatar_ = nil -- 当前头像
    self.curName_ = nil -- 当前名称

    self.curAvatarImg_ = nil
    self.curNameText_ = nil

    self.avatarListView_ = nil -- 头像列表

    self.listener_ = nil
    self.isListening_ = false -- 是否监听

    -- 已获得卡组
    self.obtainedCardGroup_ = PlayerData:getObtainedCardGroup()

    -- 未获得卡组
    self.notObtainCardGroup_ = PlayerData:getNotObtainCardGroup()

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function AvatarDialog:initView()

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self.container_:setBackGroundColor(cc.c3b(0, 0, 0))
    self.container_:setBackGroundColorType(1)
    self.container_:setCascadeOpacityEnabled(false) -- 穿透
    self.container_:setOpacity(0.8 * 255)
    self:addChild(self.container_)

    local dialogBG = ccui.ImageView:create("image/lobby/top/avatar/dialog_bg.png")
    dialogBG:setPosition(0.5*display.width, 0.5*display.height)
    self.container_:addChild(dialogBG)

    -- Dialog大小
    local width, height = dialogBG:getContentSize().width, dialogBG:getContentSize().height

    -- 头像名称
    self.curName_ = ccui.Text:create(self.curNameText__, "font/fzbiaozjw.ttf", 30)
    self.curName_:setPosition(0.5*width, 0.975*height)
    self.container_:addChild(self.curName_)

    -- 头像图像
    self.curAvatar_ = ccui.ImageView:create(self.curAvatarImg_) -- 默认图片
    self.curAvatar_:setPosition(0.3*width, 0.94*height)
    self.container_:addChild(self.curAvatar_)

    -- tip
    local tipText = ccui.ImageView:create("image/lobby/top/avatar/tip_text.png")
    tipText:setPosition(0.65*width, 0.925*height)
    self.container_:addChild(tipText)

    -- 关闭按钮
    local closeBtn = ccui.Button:create("image/lobby/top/avatar/close_btn.png")
    closeBtn:setPosition(width, 1.06*height)
    closeBtn:addClickEventListener(function()
        print("Close Button was clicked!")
        self:hideView()
    end)
    self.container_:addChild(closeBtn)

    -- 确认按钮
    local confirmBtn = ccui.Button:create("image/lobby/top/avatar/confirm_btn.png")
    confirmBtn:setPosition(0.57*width, 0.18*height)
    confirmBtn:addClickEventListener(function()
        print("Confirm Button was clicked!")
        -- 替换头像
        EventManager:doEvent(EventDef.ID.AVATAR_SWITCH, self.curAvatarImg_)
        self:hideView()
    end)
    self.container_:addChild(confirmBtn)

    -- 头像列表
    self.avatarListView_ = ccui.ListView:create()
    self.avatarListView_:setBackGroundImage("image/lobby/top/avatar/dialog_bg.png")
    self.avatarListView_:setContentSize(ConstDef.WINDOW_SIZE.AVATAR_VIEW.WIDTH,
            ConstDef.WINDOW_SIZE.AVATAR_VIEW.HEIGHT)
    self.avatarListView_:setPosition((display.width - ConstDef.WINDOW_SIZE.AVATAR_VIEW.WIDTH)/2, 0.2*display.height)
    self.avatarListView_:setDirection(1)
    self:addChild(self.avatarListView_)

    -- 已获得分割线
    local obtainLine = ccui.ImageView:create("image/lobby/top/avatar/line_obtain.png")
    obtainLine:ignoreAnchorPointForPosition(true)
    obtainLine:setAnchorPoint(0.04, 0)
    self.avatarListView_:pushBackCustomItem(obtainLine)

    local listLen = #self.obtainedCardGroup_ -- 已获得头像数量
    local rowNum = math.ceil(listLen / 4) -- 行数
    local cardWidth, cardHeight = ConstDef.CARD_SIZE.TYPE_1.WIDTH, ConstDef.CARD_SIZE.TYPE_1.HEIGHT -- 卡片大小

    local obtainContainer = ccui.Layout:create()
    obtainContainer:setContentSize(ConstDef.WINDOW_SIZE.AVATAR_VIEW.WIDTH,
            rowNum*cardHeight)
    self.avatarListView_:pushBackCustomItem(obtainContainer)

    for i = 1, listLen do
        local avatarBtn = ccui.Button:create(self.obtainedCardGroup_[i]:getSmallSpriteImg())
        avatarBtn:setPosition((1+(i-1)%4)*cardWidth,
                (rowNum-math.floor((i-1)/4))*cardHeight-0.5*cardHeight)
        avatarBtn:addClickEventListener(function()
            print("Avatar Button was clicked!")
            self.curNameText_ = self.obtainedCardGroup_[i]:getName()
            self.curName_:setString(self.curNameText_)
            self.curAvatarImg_ = self.obtainedCardGroup_[i]:getSmallSpriteImg()
            self.curAvatar_:loadTexture(self.curAvatarImg_)
        end)
        obtainContainer:addChild(avatarBtn)
    end

    -- 未获得分割线
    local notObtainLine = ccui.ImageView:create("image/lobby/top/avatar/line_not_obtain.png")
    notObtainLine:ignoreAnchorPointForPosition(true)
    notObtainLine:setAnchorPoint(0.04, 0)
    self.avatarListView_:pushBackCustomItem(notObtainLine)


    listLen = #self.notObtainCardGroup_ -- 未获得头像数量
    rowNum = math.ceil(listLen / 4) -- 行数

    local notObtainContainer = ccui.Layout:create()
    notObtainContainer:setContentSize(ConstDef.WINDOW_SIZE.AVATAR_VIEW.WIDTH,
            rowNum *ConstDef.CARD_SIZE.TYPE_1.HEIGHT)
    self.avatarListView_:pushBackCustomItem(notObtainContainer)

    for i = 1, listLen do
        local imageView = ccui.ImageView:create(self.notObtainCardGroup_[i]:getSmallSpriteImg())
        imageView:setPosition((1+(i-1)%4)*cardWidth,
                (rowNum-math.floor((i-1)/4))*cardHeight-0.5*cardHeight)
        notObtainContainer:addChild(imageView)
    end

    -- 事件监听
    self.listener_ = cc.EventListenerTouchOneByOne:create()
    self.listener_:registerScriptHandler(function(touch, event)
        if self.isListening_ then
            local touchPosition = touch:getLocation()
            local x = dialogBG:getPositionX()
            local y = dialogBG:getPositionY()
            local nodeSize = dialogBG:getContentSize()

            local rect = cc.rect(x - nodeSize.width/2, y - nodeSize.height/2,
                    nodeSize.width, nodeSize.height)

            if not cc.rectContainsPoint(rect, touchPosition) then -- 点击黑色遮罩关闭弹窗
                self:hideView()
            end

            return true
        end
        return false
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    eventDispatcher:addEventListenerWithSceneGraphPriority(self.listener_, self)
end

return AvatarDialog