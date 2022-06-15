
local SettingScene = class("SettingScene", function()
    return display.newScene("SettingScene")
end)

musicOn = true
effectOn = true

function SettingScene:music()
    return musicOn
end

function SettingScene:effect()
    return effectOn
end

function SettingScene:ctor()
    --主界面背景图
    display.newSprite("ui/main/bg_menu.jpg")
           :pos(display.cx,display.cy)
           :addTo(self)
    self:backPanel()
    self:mainPanel()

end

--[[
    函数用途：返回按钮
    --]]
function SettingScene:backPanel()
    --按钮：返回主菜单
    local backButton = ccui.Button:create("ui/back_peek0.png","ui/back_peek1.png")
    backButton:setScale(1,1)
    backButton:pos(80 , 690)
    backButton:setAnchorPoint(0.5,0.5)
    backButton:addTouchEventListener(function(sender,eventType)
        if eventType == ccui.TouchEventType.ended then--场景跳转回主菜单
            local mainScene = import("app.scenes.MainScene"):new()
            display.replaceScene(mainScene,"turnOffTiles",0.5)
            print(transform)
        end
    end)
    backButton:addTo(self)
end

--[[
    函数用途：音乐设置层
    --]]
function SettingScene:mainPanel()
    --层：音乐
    local mainLayer = ccui.Layout:create()
    mainLayer:setBackGroundColorOpacity(180)--设置为透明
    mainLayer:setContentSize(300, 480)
    mainLayer:setPosition(90, display.top - 100)
    mainLayer:setAnchorPoint(0, 1)
    mainLayer:addTo(self)

    --音乐checkBox响应事件函数
    local function musicSelectedEvent(sender,eventType)
        --cclog(eventType)
        if eventType == ccui.CheckBoxEventType.selected then
            musicOn = false
            print("eventType == ccui.CheckBoxEventType.selected")
            print(musicOn)

        elseif eventType == ccui.CheckBoxEventType.unselected then
            print("ccui.CheckBoxEventType.unselected  unselected")
            musicOn = true
            print(musicOn)
        end
    end
    --音效checkBox响应事件函数
    local function effectSelectedEvent(sender,eventType)
        --cclog(eventType)
        if eventType == ccui.CheckBoxEventType.selected then
            effectOn = false
            print("eventType == ccui.CheckBoxEventType.selected")
            print(effectOn)

        elseif eventType == ccui.CheckBoxEventType.unselected then
            print("ccui.CheckBoxEventType.unselected  unselected")
            effectOn = true
            print(effectOn)
        end
    end

    --checkBox：音乐开关，用于开启和关闭背景音乐
    local musicCheckBox = ccui.CheckBox:create()
    musicCheckBox:setScale(0.6,0.6)
    musicCheckBox:setTouchEnabled(true)
    musicCheckBox:loadTextures("soundon1_cover.png", "soundon1_cover.png","soundon2_cover.png","soundon1_cover.png","soundon2_cover.png")
    musicCheckBox:setPosition(250,500)
    musicCheckBox:setAnchorPoint(0.5,0.5)
    musicCheckBox:setContentSize(100,100)
    musicCheckBox:addEventListener(musicSelectedEvent)--注册事件
    musicCheckBox:addTo(self)
    --图标：音乐控制
    display.newSprite("bg_music_contrl_cover.png")
           :setScale(0.8,0.8)
           :pos(150,490)
           :addTo(self)

    --按钮：音效开关，用于开启关闭音效
    --checkBox：音效开关，用于开启关闭音效
    local soundCheckBox = ccui.CheckBox:create()
    soundCheckBox:setScale(0.6,0.6)
    soundCheckBox:setTouchEnabled(true)
    soundCheckBox:loadTextures("soundon1_cover.png", "soundon1_cover.png","soundon2_cover.png","soundon1_cover.png","soundon2_cover.png")
    soundCheckBox:setPosition(250,420)
    soundCheckBox:setAnchorPoint(0.5,0.5)
    soundCheckBox:setContentSize(100,100)
    soundCheckBox:addEventListener(effectSelectedEvent)--注册事件
    soundCheckBox:addTo(self)
    --图标：音效控制
    display.newSprite("sound_click_contrl_cover.png")
           :setScale(0.8,0.8)
           :pos(150,410)
           :addTo(self)
    --版本号
    local visionLabel = cc.Label:createWithTTF("版本号1.1","font/FontNormal.ttf",30)
    visionLabel:setPosition(150,180)
    visionLabel:setColor(cc.c3b(255,0,0))
    visionLabel:addTo(mainLayer)

    --联系方式
    local telLabel = cc.Label:createWithTTF("联系方式：xxx","font/FontNormal.ttf",30)
    telLabel:setPosition(150,100)
    --telLabel:setColor(cc.c3b(0,0,0))
    telLabel:addTo(mainLayer)

end


function SettingScene:onEnter()

end

function SettingScene:onExit()
end

return SettingScene
