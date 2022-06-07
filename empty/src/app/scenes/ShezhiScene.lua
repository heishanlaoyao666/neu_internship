local ShezhiScene = class("ShezhiScene", function()
    return display.newScene("ShezhiScene")
end)

--[[--
    构造函数

    @param none

    @return none
]]
function ShezhiScene:ctor()
    
    
    -- 创建居中
    self:createMiddleMiddlePanel()
    --创建中下版本号
    self:createMiddleBelowPanel()
end

function ShezhiScene:createMiddleMiddlePanel()
    local width, height = display.width, display.top
    local settingLayer = ccui.Layout:create()
    settingLayer:setBackGroundImage("ui/main/bg_menu.jpg")
    settingLayer:setBackGroundImageScale9Enabled(true)
    settingLayer:setContentSize(width, height)
    settingLayer:setPosition(width*0.5, height *0.5)
    settingLayer:setAnchorPoint(0.5, 0.5)
    --inputLayer:setScale9Enabled(true)
    settingLayer:addTo(self)
    -- 返回
    local new_gameButton = ccui.Button:create("ui/back_peek0.png", "ui/back_peek1.png")
    new_gameButton:setAnchorPoint(0, 1)
    new_gameButton:setContentSize(200, 60)
	new_gameButton:setTitleText("")
    new_gameButton:pos(0, height)
	--continueButton:setTitleFontSize(20)
    new_gameButton:addTo(settingLayer)

    -- 点击返回菜单
    new_gameButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			local nextScene=import("app/scenes/MainScene"):new()
            display.replaceScene(nextScene)
		end
	end)

    -- 音乐控制
    local bg_music_contrl = ccui.ImageView:create("ui/setting/bg_music_contrl_cover.png")
    bg_music_contrl:setAnchorPoint(0.5, 0.5)
    bg_music_contrl:pos(width*0.5, height*0.8)
    bg_music_contrl:addTo(settingLayer)
    local function onChangedCheckBox1(sender,eventType)
        local state=false
        if eventType==ccui.CheckBoxEventType.selected then
            state=true
            else if eventType==ccui.CheckBoxEventType.unselected then
                state=false
            end
        end
        --按照state执行命令
        if state then
            print("1")
            else 
                print("2")
            
        end

    end
    local bg_music_contrlButton=ccui.CheckBox:create(
        "ui/setting/soundon2_cover.png",
        "ui/setting/soundon2_cover.png",
        "ui/setting/soundon1_cover.png",
        "ui/setting/soundon1_cover.png",
        "ui/setting/soundon1_cover.png")
    bg_music_contrlButton:setAnchorPoint(0.5,0.5)
    bg_music_contrlButton:pos(width*0.5, height*0.7)
    bg_music_contrlButton:addTo(settingLayer)
    bg_music_contrlButton:addEventListener(onChangedCheckBox1)

    -- 音效控制
    local sound_click_contrl = ccui.ImageView:create("ui/setting/sound_click_contrl_cover.png")
    sound_click_contrl:setAnchorPoint(0.5, 0.5)
    sound_click_contrl:pos(width*0.5, height*0.6)
    sound_click_contrl:addTo(settingLayer)
    local function onChangedCheckBox2(sender,eventType)
        local state=false
        if eventType==ccui.CheckBoxEventType.selected then
            state=true
            else if eventType==ccui.CheckBoxEventType.unselected then
                state=false
            end
        end
        --按照state执行命令
        if state then
            print("1")
            else 
                print("2")
            
        end

    end
    local sound_click_contrlButton=ccui.CheckBox:create(
        "ui/setting/soundon2_cover.png",
        "ui/setting/soundon2_cover.png",
        "ui/setting/soundon1_cover.png",
        "ui/setting/soundon1_cover.png",
        "ui/setting/soundon1_cover.png")
    sound_click_contrlButton:setAnchorPoint(0.5,0.5)
    sound_click_contrlButton:pos(width*0.5, height*0.5)
    sound_click_contrlButton:addTo(settingLayer)
    sound_click_contrlButton:addEventListener(onChangedCheckBox2)
end

function ShezhiScene:createMiddleBelowPanel()
    local width, height = display.width, display.top
    local informationLayer=ccui.Layout:create()
    informationLayer:setContentSize(width, 100)
    informationLayer:setPosition(width*0.5, 0)
    informationLayer:setAnchorPoint(0.5, 0)
    informationLayer:addTo(self)

    --版本号
    local font = ccui.Text:create("版本号:1.0 ", "ui/font/FontNormal.ttf", 25)
    font:setAnchorPoint(0.5, 0.5)
    font:setTextColor(cc.c4b(255,0,0,128))
	font:setPosition(width*0.5, height * 0.4)
	font:addTo(informationLayer)

    --联系方式
    local font = ccui.Text:create("联系方式：508851346 ", "ui/font/FontNormal.ttf", 25)
    font:setAnchorPoint(0.5, 0.5)
	font:setPosition(width*0.5, height*0.35)
	font:addTo(informationLayer)
    --联系方式下划线
    
end
function ShezhiScene:onEnter()
end

function ShezhiScene:onExit()
end


return ShezhiScene