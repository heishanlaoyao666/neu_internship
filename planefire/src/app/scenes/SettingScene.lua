local SettingScene = class("SettingScene", function()
    return display.newScene("MenuScencee")
end)

function SettingScene:ctor()
    do
        --背景图片
        local background = display.newSprite("ui/main/bg_menu.jpg")
        background:pos(display.cx, display.cy)
        self:addChild(background)
    end
    self:initView()
end

function SettingScene:effectMusic(path)
    if cc.UserDefault:getInstance():getBoolForKey("effectMusic") then
        audio.loadFile(path, function ()
            audio.playEffect(path, false)
        end)
    end
end

function SettingScene:initView()
    --返回按钮
    local btn = ccui.Button:create("ui/back_peek0.png", "ui/back_peek1.png")
    btn:setScale9Enabled(true)
    btn:addTouchEventListener(function(sender, eventType)
        self:effectMusic("sounds/buttonEffet.ogg")
        if 2 == eventType then
            local AnotherScence = require("src/app/scenes/MenuScene")
            local MenuScene = AnotherScence:new()
            display.replaceScene(MenuScene, "fade", 0.5, cc.c3b(255, 255, 255))
        end
    end)
    btn:setAnchorPoint(0, 1)
    btn:pos(display.left, display.top)
    btn:addTo(self)

    --音乐控制按钮
    local btn = ccui.Button:create("ui/setting/bg_music_contrl_cover.png")
    btn:setScale9Enabled(true)
    btn:setAnchorPoint(0.5, 0.5)
    btn:pos(display.right * 2/5, display.top * 3/5)
    btn:addTo(self)

    --音乐开关按钮
    local checkbox1 = ccui.CheckBox:create(
        "ui/setting/soundon2_cover.png", --普通状态
        "ui/setting/soundon2_cover.png", --普通按下
        "ui/setting/soundon1_cover.png", --选中禁用
        "ui/setting/soundon2_cover.png", --普通禁用
        "ui/setting/soundon1_cover.png"  --选中禁用
    )
    if cc.UserDefault:getInstance():getBoolForKey("mainMainMusic") then
        checkbox1:setSelected(true)
    else
        checkbox1:setSelected(false)
    end
    checkbox1:pos(display.right * 3/5, display.top * 3/5)
    checkbox1:setAnchorPoint(0.5, 0.5)
    checkbox1:setScale(0.5)
    checkbox1:addEventListener(function(sender, eventType)
        self:effectMusic("sounds/buttonEffet.ogg")
        if eventType == ccui.CheckBoxEventType.selected then
            print("On")
            cc.UserDefault:getInstance():setBoolForKey("mainMainMusic", true)
            audio.loadFile("sounds/mainMainMusic.ogg", function ()
                audio.playBGM("sounds/mainMainMusic.ogg")
            end)
        elseif eventType == ccui.CheckBoxEventType.unselected then
            print("Off")
            cc.UserDefault:getInstance():setBoolForKey("mainMainMusic", false)
            audio.stopBGM()
        end
    end)
    checkbox1:addTo(self)

    --音效控制按钮
    local btn = ccui.Button:create("ui/setting/sound_click_contrl_cover.png")
    btn:setScale9Enabled(true)
    btn:setAnchorPoint(0.5, 0.5)
    btn:pos(display.right * 2/5, display.top * 2/5)
    btn:addTo(self)

    --音效开关按钮
    local checkbox2 = ccui.CheckBox:create(
        "ui/setting/soundon2_cover.png", --普通状态
        "ui/setting/soundon2_cover.png", --普通按下
        "ui/setting/soundon1_cover.png", --选中禁用
        "ui/setting/soundon2_cover.png", --普通禁用
        "ui/setting/soundon1_cover.png"  --选中禁用
    )
    if cc.UserDefault:getInstance():getBoolForKey("effectMusic") then
        checkbox2:setSelected(true)
    else
        checkbox2:setSelected(false)
    end
    checkbox2:pos(display.right * 3/5, display.top * 2/5)
    checkbox2:setAnchorPoint(0.5, 0.5)
    checkbox2:setScale(0.5)
    checkbox2:addEventListener(function(sender, eventType)
        self:effectMusic("sounds/buttonEffet.ogg")
        if eventType == ccui.CheckBoxEventType.selected then
            cc.UserDefault:getInstance():setBoolForKey("effectMusic", true)
        elseif eventType == ccui.CheckBoxEventType.unselected then
            cc.UserDefault:getInstance():setBoolForKey("effectMusic", false)
            audio.stopEffect()
        end
    end)
    checkbox2:addTo(self)

    --版本号
    local version = cc.Label:createWithTTF("版本号:1.0.0v","ui/font/FontNormal.ttf",12)
    version:pos(display.cx, display.top * 3/10)
    version:setColor(cc.c3b(255, 0, 0))
    version:setAnchorPoint(0.5, 0.5)
    version:setOpacity(100)
    version:addTo(self)

    --联系方式
    local mes = cc.Label:createWithTTF("联系方式:15504026800","ui/font/FontNormal.ttf",12)
    mes:pos(display.cx, display.top * 1/5)
    mes:setColor(cc.c3b(255, 0, 0))
    mes:setAnchorPoint(0.5, 0.5)
    mes:addTo(self)
end

local function checkBoxSelect(string)
    
end

function SettingScene:onEnter()
end

function SettingScene:onExit()
end

return SettingScene