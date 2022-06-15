
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    display.newSprite("ui/main/bg_menu.jpg")
            :pos(display.cx,display.cy)
            :addTo(self)
    --[[local f = io.open("file/uid.txt","r")
    if f ==nil then--文件不为空
        self:registerPanel()

    else
        self:mainPanel()
    end--]]
    self:registerPanel()--注册页面
    self:playMainMusic("sounds/mainMainMusic.ogg")--加载背景音乐
end

--[[
    函数用途：播放背景音乐
    --]]
function MainScene:playMainMusic(path)
    local musicPath = path
    local audio = require("framework.audio")
    audio.loadFile(musicPath,function()
        audio.playBGM(musicPath,isLoop)
    end)
end

--[[
    函数用途：播放按钮音效
    --]]
function MainScene:playEffect(path)
    local effectPath = path
    local audio = require("framework.audio")
    audio.loadFile(effectPath,function()
        audio.playEffect(effectPath,false)
    end)
end

--[[
    函数用途：注册界面
    --]]
function MainScene:registerPanel()
    --注册层
    registerLayer = ccui.Layout:create()
    registerLayer:setBackGroundColorOpacity(180)--设置为透明
    registerLayer:setContentSize(300, 200)
    registerLayer:setPosition(90, display.top - 200)
    registerLayer:setAnchorPoint(0, 1)
    registerLayer:addTo(self)

    --输入框底部白色填充
    editLayer = ccui.Layout:create()
    editLayer:setBackGroundColor(cc.c3b(225, 225, 225))--设置为白色
    editLayer:setBackGroundColorType(1)
    editLayer:setContentSize(300, 50)
    editLayer:setAnchorPoint(0.5,0.5)
    editLayer:setPosition(150,150)
    editLayer:addTo(registerLayer)

    --输入框
    editTxt = ccui.EditBox:create(cc.size(300,50),nil,50)
    editTxt:setName("inputTxt")
    editTxt:setAnchorPoint(0.5,0.5)
    editTxt:setPosition(150,150) --设置输入框的位置
    editTxt:setFontSize(50) --设置输入设置字体的大小
    editTxt:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE) --输入键盘返回类型，done， send，go等KEYBOARD_RETURNTYPE_DONE
    editTxt:setInputMode(cc.EDITBOX_INPUT_MODE_NUMERIC) --输入模型，如整数类型，URL， 电话号码等，会检测是否符合
    editTxt:addTo(registerLayer)
    --local name = editTxt:getText()

    --注册按钮
    registerButton = ccui.Button:create("register.png","register.png")
    registerButton:setScale(1,1)
    registerButton:pos(150 , 70)
    registerButton:setAnchorPoint(0.5,0.5)
    registerButton:addTouchEventListener(function(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            self:playEffect("sounds/buttonEffet.ogg")--注册按钮的音效播放
            --uid的随机生成与存储
            local uid = getUUID()
            local file = io.open("file/uid.txt","w")
            file:write(uid)
            file:close()
            print(uid)

            --print(name)
            registerLayer:setVisible(false)
            self:mainPanel()
        end
    end)
    registerButton:addTo(registerLayer)
end

--[[
    函数用途：创建UID
   --]]
function getUUID()
    local curTime = os.time()
    local uuid = curTime+math.random(10000000)
    return uuid
end

--[[
    函数用途：主界面
    --]]
function MainScene:mainPanel()
    local menuLayer = ccui.Layout:create()
    menuLayer:setBackGroundColorOpacity(180)--设置为透明
    menuLayer:setContentSize(280, 400)
    menuLayer:setPosition(100, display.top - 150)
    menuLayer:setAnchorPoint(0, 1)
    menuLayer:addTo(self)

    --按钮：新游戏
    local newGameButton = ccui.Button:create("new_game1.png","new_game2.png")
    newGameButton:setScale(1.5,1.5)
    newGameButton:pos(140 , 380)
    newGameButton:setAnchorPoint(0.5,0.5)
    newGameButton:addTouchEventListener(function(sender,eventType)
        if eventType == ccui.TouchEventType.ended then--场景跳转
            self:playEffect("sounds/buttonEffet.ogg")--播放案按钮音效
            audio.stopBGM()--停止当前背景音乐
            self:playMainMusic("sounds/bgMusic.ogg")--播放战斗音乐
            local fightScene = import("app.scenes.FightingScene"):new()--转移到战斗场景
            display.replaceScene(fightScene,"turnOffTiles",0.5)--当前场景分成多个块，逐渐替换为新场景
            print(transform)
        end
    end)
    newGameButton:addTo(menuLayer)

    --按钮：继续游戏,暂无任何交互操作
    local continueButton = ccui.Button:create("continue_menu.png","continue_menu2.png")
    continueButton:setScale(1.5,1.5)
    continueButton:pos(150 , 280)
    continueButton:setAnchorPoint(0.5,0.5)
    continueButton:addTo(menuLayer)

    --按钮：排行榜
    local rankButton = ccui.Button:create("rank_menu.png","rank_menu2.png")
    rankButton:setScale(1.5,1.5)
    rankButton:pos(140 , 180)
    rankButton:setAnchorPoint(0.5,0.5)
    rankButton:addTouchEventListener(function(sender,eventType)
        if eventType == ccui.TouchEventType.ended then--场景跳转
            self:playEffect("sounds/buttonEffet.ogg")--播放按键音效
            local rankScene = import("app.scenes.RankScene"):new()--转换到排行榜界面
            display.replaceScene(rankScene,"turnOffTiles",0.5)
            print(transform)
        end
    end)
    rankButton:addTo(menuLayer)

    --按钮：设置
    local settingButton = ccui.Button:create("shezhi1_cover.png","shezhi2_cover.png")
    settingButton:setScale(1.5,1.5)
    settingButton:pos(140 , 80)
    settingButton:setAnchorPoint(0.5,0.5)
    settingButton:addTouchEventListener(function(sender,eventType)
        if eventType == ccui.TouchEventType.ended then--场景跳转
                self:playEffect("sounds/buttonEffet.ogg")--播放按键音效
            local settingScene = import("app.scenes.SettingScene"):new()--转换到设置界面
            display.replaceScene(settingScene,"turnOffTiles",0.5)
            print(transform)
        end
    end)
    settingButton:addTo(menuLayer)

end

function MainScene:onEnter()

end

function MainScene:onExit()
end

return MainScene
