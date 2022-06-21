--- 设置页面
local SystemConst = require("app.utils.SystemConst")
local defaults = cc.UserDefault:getInstance()
local audio = require("framework.audio")

local SettingScene = class("SettingScene", function()
    return display.newScene("SettingScene")
end)

function SettingScene:ctor()

    self.size = cc.Director:getInstance():getWinSize()
    -- 背景
    local bg = cc.Sprite:create(SystemConst.MENU_BG_NAME)
    bg:setPosition(cc.p(self.size.width/2, self.size.height/2))
    bg:setScale(0.8, 0.8)
    self:addChild(bg)

    -- 返回
    local backImages = {
        normal = SystemConst.BACK_BUTTON_NORMAL,
        pressed = SystemConst.BACK_BUTTON_PRESSED,
        disabled = SystemConst.BACK_BUTTON_DISABLED
    }

    local backBtn = ccui.Button:create(backImages["normal"], backImages["pressed"], backImages["disabled"])
    -- 设置锚点
    backBtn:setAnchorPoint(cc.p(0 ,1))
    -- 居中
    backBtn:setPosition(cc.p(display.left, display.top))
    -- 设置缩放程度
    backBtn:setScale(0.75, 0.75)
    -- 设置是否禁用(false为禁用)
    backBtn:setEnabled(true)
    backBtn:addClickEventListener(function ()

        if defaults:getBoolForKey(SystemConst.SOUND_KEY) then
            audio.loadFile(SystemConst.BUTTON_EFFECT, function ()
                audio.playEffect(SystemConst.BUTTON_EFFECT, false)
            end)
        end

        cc.Director:getInstance():popScene()
    end)

    self:addChild(backBtn, 4)

    -- 音乐 - Label + CheckBox
    local musicLabel = display.newTTFLabel({
        text = "音乐控制",
        font = "Marker Felt",
        size = 24,
        color = cc.c3b(0, 190, 255) 
    })

    musicLabel:align(display.CENTER, 100, 467)
    musicLabel:addTo(self)

    local musicCheckBox = ccui.CheckBox:create() 
    musicCheckBox:loadTextures(SystemConst.MUSIC_CHECKBOX_CLOSE,
        SystemConst.MUSIC_CHECKBOX_CLOSE, SystemConst.MUSIC_CHECKBOX_OPEN,
            SystemConst.MUSIC_CHECKBOX_OPEN, SystemConst.MUSIC_CHECKBOX_OPEN)

    musicCheckBox:setPosition(cc.p(180, 450))
    musicCheckBox:setAnchorPoint(cc.p(0, 0))
    musicCheckBox:setScale(0.5, 0.5)
    musicCheckBox:addClickEventListener(function()
        self:musicToggleCallBack(self)
    end)

    self:addChild(musicCheckBox, 4)

    -- 音效
    local soundLabel = display.newTTFLabel({
        text = "音效控制",
        font = "Marker Felt",
        size = 24,
        color = cc.c3b(0, 190, 255) 
    })

    soundLabel:align(display.CENTER, 100, 417)
    soundLabel:addTo(self)

    local soundCheckBox = ccui.CheckBox:create()
    soundCheckBox:loadTextures(SystemConst.MUSIC_CHECKBOX_CLOSE,
            SystemConst.MUSIC_CHECKBOX_CLOSE, SystemConst.MUSIC_CHECKBOX_OPEN,
            SystemConst.MUSIC_CHECKBOX_OPEN, SystemConst.MUSIC_CHECKBOX_OPEN)

    soundCheckBox:setPosition(cc.p(180, 400))
    soundCheckBox:setAnchorPoint(cc.p(0, 0))
    soundCheckBox:setScale(0.5, 0.5)
    soundCheckBox:addClickEventListener(function()
        self:soundToggleCallBack(self)
    end)

    self:addChild(soundCheckBox, 4)

    -- 音乐与音效的初始化
    if defaults:getBoolForKey(SystemConst.MUSIC_KEY) then
        musicCheckBox:setSelected(true)
    end

    if defaults:getBoolForKey(SystemConst.SOUND_KEY) then
        soundCheckBox:setSelected(true)
    end

    -- 版本号
    local versionLabel = display.newTTFLabel({
        text = "版本号: 1.1",
        font = "Marker Felt",
        size = 24,
        color = cc.c3b(255, 0, 0) 
    })

    -- 设置透明度
    versionLabel:setCascadeOpacityEnabled(true)
    versionLabel:setOpacity(255 * 0.5)

    versionLabel:align(display.CENTER, display.cx, 367)
    versionLabel:addTo(self)


    -- 联系方式
    local contactLabel = display.newTTFLabel({
        text = "联系方式",
        font = "Marker Felt",
        size = 24,
        color = cc.c3b(255, 0, 0) 
    })

    -- 设置透明度
    contactLabel:setCascadeOpacityEnabled(true)
    contactLabel:setOpacity(255 * 0.5)

    contactLabel:align(display.CENTER, display.cx, 317)
    contactLabel:addTo(self)

end

function SettingScene:onEnter()
end

function SettingScene:onExit()
end

------------------------------------------------------------------

-- 音乐
function SettingScene:musicToggleCallBack(sender)
    print("Music Toggle.")
    if defaults:getBoolForKey(SystemConst.MUSIC_KEY) then
        defaults:setBoolForKey(SystemConst.MUSIC_KEY, false)
        audio.stopBGM()
    else
        defaults:setBoolForKey(SystemConst.MUSIC_KEY, true)
        audio.loadFile(SystemConst.INDEX_BG_MUSIC, function ()
            audio.playBGM(SystemConst.INDEX_BG_MUSIC, false)
        end)
    end
end

-- 音效
function SettingScene:soundToggleCallBack(sender)
    print("Sound Toggle.")
    if defaults:getBoolForKey(SystemConst.SOUND_KEY) then
        defaults:setBoolForKey(SystemConst.SOUND_KEY, false)
    else
        defaults:setBoolForKey(SystemConst.SOUND_KEY, true)
        audio.loadFile(SystemConst.BUTTON_EFFECT, function ()
            audio.playEffect(SystemConst.BUTTON_EFFECT, false)
        end)
    end
end


return SettingScene
