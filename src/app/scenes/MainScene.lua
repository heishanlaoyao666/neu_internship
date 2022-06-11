local SettingScene = require"app.scenes.SettingScene"
local RankingScene = require"app.scenes.RankingScene"
local BattleScene = require"app.scenes.BattleScene"
--local size = cc.Director:getInstance():getWinSize()

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

--SOUND_KEY = "sound_key"
--MUSIC_KEY = "music_key"
--local defaults = cc.UserDefault:getInstance()   --定义一个作用域范围


--[[--
    构造函数

    @param none

    @return none
]]
function MainScene:ctor()
    print("ctor")
    self:uiController()
end

--[[-- 
    游戏开始界面控制
    游戏进入的时候检查UserDefault中是否有用户ID和昵称

    @param none

    @return none
]]

function MainScene:uiController()
    print("uiController")
    -- 判断是否已有用户信息
    local isMain = false
    local userName = cc.UserDefault:getInstance():getStringForKey("UserName")
    local userId = cc.UserDefault:getInstance():getStringForKey("UserId")
    if userName ~= "" and userId ~= "" then
        isMain = true
        print("UserName --> ", userName)
        print("UserId --> ", userId)
    end

    if isMain == false then
    -- 没有，创建注册界面
    self:createRegisterPanel()
    else
    -- 有，打开主界面
    self:createMainUI()
    --self:createSetUI()
    end
end

--[[--
    显示用户名称和ID
]]
function MainScene:createUserMessageUI()
    local width = 200
    local height = 150
    local userLayer = ccui.Layout:create()
    --userLayer:setBackGroundColor(cc.c3b(100, 255, 100))
    --userLayer:setBackGroundColorType(1)
    userLayer:setAnchorPoint(1, 1)
    userLayer:setContentSize(width, height)
    userLayer:pos(display.width, display.height)
    userLayer:addTo(self)

    local userName = cc.UserDefault:getInstance():getStringForKey("UserName")
    local userId = cc.UserDefault:getInstance():getStringForKey("UserId")

    local userNameTxt = display.newTTFLabel({
        text = "用户名："..userName,
        font = "FontNormal.ttf",
        size = 20
    })
    userNameTxt:pos(display.width - 20, display.height - height/2 + 40)
    userNameTxt:setAnchorPoint(1, 0.5)
    userNameTxt:setColor(cc.c4b(255,50,50,100))
    userNameTxt:addTo(self)

    local userIdTxt = display.newTTFLabel({
        text = "ID ："..userId,
        font = "FontNormal.ttf",
        size = 20
    })
    userIdTxt:pos(display.width - 20, display.height - height/2)
    userIdTxt:setAnchorPoint(1, 0.5)
    userIdTxt:setColor(cc.c4b(255,50,50,100))
    userIdTxt:addTo(self)
end

--[[--
    创建主界面

    @param none

    @return none
]]
function MainScene:createMainUI()
    print("createMainUI")
    local director = cc.Director:getInstance()

    local width, height = 480, 720          --面板位置
    local mainLayer = ccui.Layout:create()         --创建层
    --inputLayer:setBackGroundColor(cc.c3b(100, 50, 100))    --背景颜色
    mainLayer:setBackGroundImage("ui/main/bg_menu.jpg")
    --inputLayer:setBackGroundColorType(1)
    mainLayer:setContentSize(480, 720)         --层大小
    mainLayer:setPosition(display.width/2, display.top/2)
    mainLayer:setAnchorPoint(0.5, 0.5)             --设置锚点居中
    mainLayer:addTo(self)

    -- 新游戏按钮
    local buttonNewGame = ccui.Button:create("ui/main/new_game1.png", "ui/main/new_game2.png")
    buttonNewGame:setAnchorPoint(0.5, 0.5)
    buttonNewGame:setScale9Enabled(true)
    buttonNewGame:setContentSize(140, 45)
    --buttonNewGame:setTitleText("新游戏")
    buttonNewGame:pos(width * 0.5, height*0.5 + 150)
    buttonNewGame:setTitleFontSize(20)
    buttonNewGame:addTo(mainLayer)
    -- 按钮点击事件(打开排行榜界面)
    buttonNewGame:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            local battleScene = BattleScene:create()
            director:pushScene(battleScene)
        end
    end)

    -- 继续按钮
    local buttonContinue = ccui.Button:create("ui/main/continue_menu.png", "ui/main/continue_menu2.png")
    buttonContinue:setAnchorPoint(0.5, 0.5)
    buttonContinue:setScale9Enabled(true)
    buttonContinue:setContentSize(140, 45)
    --buttonContinue:setTitleText("继续")
    buttonContinue:pos(width * 0.5, height*0.5 + 50)
    buttonContinue:setTitleFontSize(20)
    buttonContinue:addTo(mainLayer)

    -- 排行榜按钮
    local buttonContinue = ccui.Button:create("ui/main/rank_menu.png", "ui/main/rank_menu2.png")
    buttonContinue:setAnchorPoint(0.5, 0.5)
    buttonContinue:setScale9Enabled(true)
    buttonContinue:setContentSize(140, 45)
    --buttonContinue:setTitleText("继续")
    buttonContinue:pos(width * 0.5, height*0.5 - 50)
    buttonContinue:setTitleFontSize(20)
    buttonContinue:addTo(mainLayer)
    -- 按钮点击事件(打开排行榜界面)
    buttonContinue:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            local rankingScene = RankingScene:create()
            director:pushScene(rankingScene)
        end
    end)

    -- 设置按钮
    local buttonSet = ccui.Button:create("ui/main/shezhi1_cover.png", "ui/main/shezhi2_cover.png")
    buttonSet:setAnchorPoint(0.5, 0.5)
    buttonSet:setScale9Enabled(true)
    buttonSet:setContentSize(140, 45)
    buttonSet:pos(width * 0.5, height*0.5 - 150)
    buttonSet:setTitleFontSize(20)
    buttonSet:addTo(mainLayer)
    -- 按钮点击事件(打开设置界面)
    buttonSet:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            local settingScene = SettingScene:create()
            director:pushScene(settingScene)
            --local reScene=cc.TransitionFadeBL:create(0.5,scene)--场景切换动画
            --display.runScene(reScene,false)
        end
    end)

    -- 音乐默认播放
    print("主界面音乐播放")
    local audio = require("framework.audio")
    audio.loadFile("sounds/mainMainMusic.ogg",function ()
        audio.playBGM("sounds/mainMainMusic.ogg",true)
    end)

    -- 显示用户信息
    self:createUserMessageUI()
end

--[[--
    创建登录注册界面

    @param none

    @return none
]]
function MainScene:createRegisterPanel()
    local registerBackLayer = ccui.Layout:create()
    registerBackLayer:setBackGroundImage("ui/main/bg_menu.jpg")
    registerBackLayer:setAnchorPoint(0.5, 0.5)
    registerBackLayer:setPosition(display.width/2, display.top/2)
    registerBackLayer:addTo(self)

    local width, height = 300, 200          --面板位置
    local registerLayer = ccui.Layout:create()         --创建层
    registerLayer:setBackGroundColor(cc.c3b(100, 0, 0))    --背景颜色
    registerLayer:setBackGroundColorType(1)
    registerLayer:setContentSize(300, 200)         --层大小
    registerLayer:setPosition(display.width/2, display.top/2)
    registerLayer:setAnchorPoint(0.5, 0.5)             --设置锚点
    registerLayer:addTo(self)

    -- 居中对齐
    -- size， respath， 0普通图片 1合集（plist)图片
    -- 注册了一个EditBox事件
    local locationEditbox = ccui.EditBox:create(cc.size(width - 10, 40), "rank_bg.png", 0)
    locationEditbox:setAnchorPoint(0.5,0.5)
	locationEditbox:pos(width * 0.5, height*0.5)
    locationEditbox:addTo(registerLayer)
    locationEditbox:setPlaceHolder("请输入昵称") --设置预制提示文本
    locationEditbox:setFontColor(cc.c4b(100,0,0,255)) --设置输入的字体颜色
    locationEditbox:registerScriptEditBoxHandler(function (eventType)
             if eventType == "began" then
                -- triggered when an edit box gains focus after keyboard is shown
            elseif eventType == "ended" then
                 -- triggered when an edit box loses focus after keyboard is hidden.
            elseif eventType == "changed" then
                 -- triggered when the edit box text was changed.
                print("cur text is ", locationEditbox:getText())
           elseif eventType == "return" then
               -- triggered when the return button was pressed or the outside area of keyboard was touched.
            end
        end)

    -- 确定
    local confirmButton = ccui.Button:create("rank_bg.png", "rank_bg.png")
    confirmButton:setAnchorPoint(0.5, 0.5)
    confirmButton:setScale9Enabled(true)
    confirmButton:setContentSize(80, 40)
    confirmButton:setTitleText("注册")
    confirmButton:pos(width * 0.5, height*0.5 - 55)
    confirmButton:setTitleFontSize(20)
    confirmButton:addTo(registerLayer)
    -- 按钮点击事件
    confirmButton:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            print("you type string =", locationEditbox:getText(),".")
            -- 点击按钮使用UserDefault保存昵称和用户ID
            print("self:userRegister(locationEditbox:getText())",self:userRegister(locationEditbox:getText()))
            if self:userRegister(locationEditbox:getText()) then
                --切换页面
                self:createMainUI()
                registerBackLayer:setVisible(false)
                registerLayer:setVisible(false)
            else
                local tipsTxt = display.newTTFLabel({
                    text = "请输入昵称!",
                    font = "FontNormal.ttf",
                    size = 20
                })
                tipsTxt:align(display.CENTER, display.cx, display.height/4)
                tipsTxt:setColor(cc.c3b(255,50,50))
                tipsTxt:addTo(self)
            end
        end
    end)

    --return signInLayer
end

--[[
    用户注册函数

    @param  string
    @return  none
]]
function MainScene:userRegister(name)
    if name ~= "" then
        cc.UserDefault:getInstance():setStringForKey("UserName", name)    -- 字符串(键-值)
        local userName = cc.UserDefault:getInstance():getStringForKey("UserName")
        --打印获得的用户数据
        print("UserName --> ", userName)

        cc.UserDefault:getInstance():setStringForKey("UserId", self:getUUID())    -- 字符串(键-值)
        local userId = cc.UserDefault:getInstance():getStringForKey("UserId")
        --打印获得的用户数据
        print("UserId --> ", userId)
    else
        return false
    end
    return true
end

--[[
    用户ID生成函数

    @param  string
    @return  none
]]
function MainScene.getUUID()
    local curTime = os.time()
    local uuid = curTime + math.random(10000000)
    return uuid
end

return MainScene
