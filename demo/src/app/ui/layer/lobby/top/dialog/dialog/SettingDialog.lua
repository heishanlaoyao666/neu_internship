--[[
    SettingDialog.lua
    设置弹窗
    描述：设置弹窗
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local SettingDialog = class("SettingDialog", require("app.ui.layer.BaseLayer"))
local ConstDef = require("app.def.ConstDef")
local DialogManager = require("app.manager.DialogManager")
local QuitGameDialog = require("app.ui.layer.lobby.top.dialog.dialog.dialog.QuitGameDialog")
local QuitAccountDialog = require("app.ui.layer.lobby.top.dialog.dialog.dialog.QuitAccountDialog")
local ConstDef = require("app.def.ConstDef")
local defaults = cc.UserDefault:getInstance()
local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

--[[--
    构造函数

    @param none

    @return none
]]
function SettingDialog:ctor()
    SettingDialog.super.ctor(self)

    self.container_ = nil -- 全局容器

    self.listener_ = nil
    self.isListening_ = false -- 是否监听

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function SettingDialog:initView()

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self.container_:setBackGroundColor(cc.c3b(0, 0, 0))
    self.container_:setBackGroundColorType(1)
    self.container_:setCascadeOpacityEnabled(false) -- 穿透
    self.container_:setOpacity(0.8 * 255)
    self:addChild(self.container_)

    local dialogBG = ccui.ImageView:create("image/lobby/top/setting/dialog_bg.png")
    dialogBG:setPosition(display.width/2, display.height/2)
    self.container_:addChild(dialogBG)

    local width, height = dialogBG:getContentSize().width, dialogBG:getContentSize().height

    -- 关闭按钮
    local closeBtn = ccui.Button:create("image/lobby/top/setting/close_btn.png")
    closeBtn:setPosition(width, 1.8*height)
    closeBtn:addClickEventListener(function()
        self:hideView()
    end)
    self.container_:addChild(closeBtn)

    -- 音效
    local effectTitle = ccui.ImageView:create("image/lobby/top/setting/effect_title.png")
    effectTitle:setPosition(0.25*width, 1.6*height)
    effectTitle:setAnchorPoint(0, 0.5)
    self.container_:addChild(effectTitle)
    local effectCheckBox = ccui.CheckBox:create()
    effectCheckBox:loadTextures("image/lobby/top/setting/close_checkbox.png",
            "image/lobby/top/setting/close_checkbox.png",
            "image/lobby/top/setting/open_checkbox.png",
            "image/lobby/top/setting/open_checkbox.png",
            "image/lobby/top/setting/open_checkbox.png")
    effectCheckBox:setPosition(0.7*width, 1.6*height)
    effectCheckBox:addClickEventListener(function()
        print("Effect CheckBox was clicked!")
        if defaults:getBoolForKey(ConstDef.SOUND_KEY) then
            defaults:setBoolForKey(ConstDef.SOUND_KEY, false)
        else
            defaults:setBoolForKey(ConstDef.SOUND_KEY, true)
        end
    end)
    self.container_:addChild(effectCheckBox)

    if defaults:getBoolForKey(ConstDef.SOUND_KEY) then
        effectCheckBox:setSelected(true)
    end

    -- 音乐
    local musicTitle = ccui.ImageView:create("image/lobby/top/setting/music_title.png")
    musicTitle:setPosition(0.25*width, 1.45*height)
    musicTitle:setAnchorPoint(0, 0.5)
    self.container_:addChild(musicTitle)
    local musicCheckBox = ccui.CheckBox:create()
    musicCheckBox:loadTextures("image/lobby/top/setting/close_checkbox.png",
            "image/lobby/top/setting/close_checkbox.png",
            "image/lobby/top/setting/open_checkbox.png",
            "image/lobby/top/setting/open_checkbox.png",
            "image/lobby/top/setting/open_checkbox.png")
    musicCheckBox:setPosition(0.7*width, 1.45*height)
    musicCheckBox:addClickEventListener(function()
        print("Music CheckBox was clicked!")
        if defaults:getBoolForKey(ConstDef.MUSIC_KEY) then
            defaults:setBoolForKey(ConstDef.MUSIC_KEY, false)
        else
            defaults:setBoolForKey(ConstDef.MUSIC_KEY, true)
        end
    end)
    self.container_:addChild(musicCheckBox)

    if defaults:getBoolForKey(ConstDef.MUSIC_KEY) then
        musicCheckBox:setSelected(true)
    end

    -- 技能介绍
    local skillTitle = ccui.ImageView:create("image/lobby/top/setting/skill_title.png")
    skillTitle:setPosition(0.25*width, 1.3*height)
    skillTitle:setAnchorPoint(0, 0.5)
    self.container_:addChild(skillTitle)
    local skillCheckBox = ccui.CheckBox:create()
    skillCheckBox:loadTextures("image/lobby/top/setting/close_checkbox.png",
            "image/lobby/top/setting/close_checkbox.png",
            "image/lobby/top/setting/open_checkbox.png",
            "image/lobby/top/setting/open_checkbox.png",
            "image/lobby/top/setting/open_checkbox.png")
    skillCheckBox:setPosition(0.7*width, 1.3*height)
    skillCheckBox:addClickEventListener(function()
        print("Skill CheckBox was clicked!")
    end)
    self.container_:addChild(skillCheckBox)

    -- 退出游戏
    local quitGameBtn = ccui.Button:create("image/lobby/top/setting/quit_game_btn.png")
    quitGameBtn:setPosition(0.35*width, 1.1*height)
    quitGameBtn:addClickEventListener(function()
        local quitGameDialog = QuitGameDialog.new()
        DialogManager:showDialog(quitGameDialog)
    end)
    self.container_:addChild(quitGameBtn)

    -- 退出账号
    local quitAccountBtn = ccui.Button:create("image/lobby/top/setting/quit_account_btn.png")
    quitAccountBtn:setPosition(0.75*width, 1.1*height)
    quitAccountBtn:addClickEventListener(function()
        local quitAccountDialog = QuitAccountDialog.new()
        DialogManager:showDialog(quitAccountDialog)
    end)
    self.container_:addChild(quitAccountBtn)

    -- 版本号
    local version = string.format("版本号：%s", ConstDef.VERSION)
    local versionText = ccui.Text:create(version, "font/fzbiaozjw.ttf", 21)
    versionText:setTextColor(cc.c4b(255, 255, 255, 60))
    versionText:setPosition(0.55*width, 0.975*height)
    self.container_:addChild(versionText)

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

return SettingDialog