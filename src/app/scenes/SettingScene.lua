local SettingScene = class("SettingSceneScene", function()
    return display.newScene("SettingSceneScene")
end)

--local defaults = cc.UserDefault:getInstance()

--[[--
    构造函数

    @param none

    @return none
]]
function SettingScene:ctor() 
    self:createLayer()
end

function SettingScene:create()
    local scene = SettingScene.new()
    --scene:addChild(scene:createLayer())
    return scene
end


function SettingScene:createLayer()
    local director = cc.Director:getInstance()

    --local width, height = 300, 400          --面板位置
    local setLayer = ccui.Layout:create()         --创建层
    setLayer:setBackGroundImage("ui/main/bg_menu.jpg")
    --setLayer:setBackGroundColor(cc.c3b(100, 0, 0))    --背景颜色
    --setLayer:setBackGroundColorType(1)
    --setLayer:setContentSize(width, height)         --层大小
    setLayer:setPosition(display.width/2, display.top/2)
    setLayer:setAnchorPoint(0.5, 0.5)             --设置锚点
    setLayer:addTo(self)

    -- 返回按钮
    local buttonSet = ccui.Button:create("ui/back_peek0.png", "ui/back_peek1.png")
    buttonSet:setPosition(- 80, display.height/2-30)
    buttonSet:setAnchorPoint(1, 1)
    buttonSet:setContentSize(140, 45)
    buttonSet:addTo(setLayer)
    -- 按钮点击事件(关闭 设置界面)
    buttonSet:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            --local mainScenece = require("app.scenes.MainScene"):new()    -- 设置创建对象
            --display.replaceScene(mainScenece, "turnOffTiles", 0.1)
            director:popScene()
        end
    end)

--[[--
    音乐开关
]]
    local audioBgm = require("framework.audio")

    -- 标签图片
    local spriteBgm = cc.Sprite:create("ui/setting/bg_music_contrl_cover.png")
    spriteBgm:setPosition(display.width/2 - 50, display.height/2+100)
    spriteBgm:setAnchorPoint(1, 0.5)
    spriteBgm:addTo(self)

    -- 事件回调函数
    local function onChangedCheckBoxBgm(sender, eventType)
        if eventType == ccui.CheckBoxEventType.selected then
            --audioBgm.stopBGM()
            audioBgm.pauseAll()

        elseif eventType == ccui.CheckBoxEventType.unselected then
            --audioBgm.playBGM("sounds/bgMusic.ogg")
            audioBgm.resumeAll()
        end
    end

    --创建CheckBox对象
    local ckbBgm = ccui.CheckBox:create(
        "ui/setting/soundon1_cover.png",    --普通状态
        "ui/setting/soundon1_cover.png",    --普通按下
        "ui/setting/soundon2_cover.png",    --选中状态
        "ui/setting/soundon1_cover.png",    --普通禁用
        "ui/setting/soundon2_cover.png"     --选中禁用
    )
    ckbBgm:setPosition(cc.p(display.width/2 - 50, display.height/2+100))
    ckbBgm:setAnchorPoint(0,0.5)
    --ckbBgm:setContentSize(100,100)
    ckbBgm:setScale(0.8)    --大小缩放
    -- 添加事件监听器
    ckbBgm:addEventListener(onChangedCheckBoxBgm)
    ckbBgm:addTo(self)

    --musicToggleMenuItem:registerScriptTapHandler()

--[[--
    音效开关
]]
    -- 标签图片
    local spriteBgm = cc.Sprite:create("ui/setting/sound_click_contrl_cover.png")
    spriteBgm:setPosition(display.width/2 - 50, display.height/2 + 30)
    spriteBgm:setAnchorPoint(1, 0.5)
    spriteBgm:addTo(self)

    audioBgm.loadFile("sounds/buttonEffet.ogg",function ()
        --audioBgm.playBGM("sounds/bgMusic.ogg",true)
    end)

     -- 事件回调函数
     local function onChangedCheckBoxSE(sender, eventType)
        if eventType == ccui.CheckBoxEventType.selected then
            audioBgm.stopEffect()

        elseif eventType == ccui.CheckBoxEventType.unselected then
            audioBgm.playEffect("sounds/buttonEffet.ogg")
        end
    end

    --创建CheckBox对象
    local ckbSE = ccui.CheckBox:create(
        "ui/setting/soundon1_cover.png",    --普通状态
        "ui/setting/soundon1_cover.png",    --普通按下
        "ui/setting/soundon2_cover.png",    --选中状态
        "ui/setting/soundon1_cover.png",    --普通禁用
        "ui/setting/soundon2_cover.png"     --选中禁用
    )
    ckbSE:setPosition(cc.p(display.width/2 - 50, display.height/2 + 30))
    ckbSE:setAnchorPoint(0,0.5)
    ckbSE:setScale(0.8)
    -- 添加事件监听器
    ckbSE:addEventListener(onChangedCheckBoxSE)
    ckbSE:addTo(self)

--[[--
    初始化音乐开关状态

    if defaults:getBoolForKey(MUSIC_KEY) then
        musicToggleMenuItem:setSelectedIndex(0)     --off
    else
        musicToggleMenuItem:setSelectedIndex(1)     --o
    end
]]

--[[--
    说明文字1
]]
    local labelNum1 = display.newTTFLabel({
        text = "版本号：1.1",
        font = "FontNormal.ttf",
        size = 20
    })
    labelNum1:align(display.CENTER, display.cx, display.cy-70)
    labelNum1:setColor(cc.c4b(255,50,50,100))
    labelNum1:addTo(self)

--[[--
     说明文字2
]]
    local labelNum2 = display.newTTFLabel({
        text = "联系方式：xxx",
        font = "FontNormal.ttf",
        size = 20
    })
    labelNum2:align(display.CENTER, display.cx, display.cy-100)
    labelNum2:addTo(self)
    local labelLine = display.newTTFLabel({
        text = "__________",
        font = "FontNormal.ttf",
        size = 20
    })
    labelLine:align(display.CENTER, display.cx, display.cy-100)
    labelLine:addTo(self)


    return setLayer
end
return SettingScene