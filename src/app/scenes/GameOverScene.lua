
local defaults = cc.UserDefault:getInstance()
local SystemConst = require("app.utils.SystemConst")

local GameOverScene = class("GameOverScene", function()
    return cc.Scene:create()
end)

function GameOverScene.create(score)
    local scene = GameOverScene.new(score)
    scene:addChild(scene:createLayer())
    return scene
end


function GameOverScene:ctor(score)

    self.score = score
    self.listener = nil
    self.size = cc.Director:getInstance():getWinSize()
    self.writablePath = cc.FileUtils:getInstance():getWritablePath()

    -- 场景生命周期事件处理
    local function onNodeEvent(event)
        if event == "enter" then
            self:onEnter()
        elseif event == "enterTransitionFinish" then
            self:onEnterTransitionFinish()
        elseif event == "exit" then
            self:onExit()
        elseif event == "exitTransitionStart" then
            self:onExitTransitionStart()
        elseif event == "cleanup" then
            self:cleanup()
        end
    end
    self:registerScriptHandler(onNodeEvent)
end

-- 创建层
function GameOverScene:createLayer()
    print("GameOverScene init")

    -- 主层
    local layer = ccui.Layout:create()
    layer:setBackGroundColor(cc.c3b(255, 255, 255))
    layer:setBackGroundColorType(1)
    layer:setContentSize(display.width, display.height)
    layer:setPosition(display.cx, 0)
    layer:setAnchorPoint(0.5, 0)
    layer:setCascadeOpacityEnabled(true)
    layer:setOpacity(0.8 * 255)

    -- 更新排行榜
    self:updateRank()

    -- 昵称
    local nameLabel = display.newTTFLabel({
        text = "昵称",
        font = "Marker Felt",
        size = 18,
        color = cc.c3b(0, 0, 0)
    })
    nameLabel:setAnchorPoint(0.5, 0.5)
    nameLabel:setPosition(50, self.size.height - 150)

    layer:addChild(nameLabel, 1)

    local nameText = defaults:getStringForKey("name")
    local nameEntry = display.newTTFLabel({
        text = nameText,
        font = "Marker Felt",
        size = 18,
        color = cc.c3b(0, 0, 0)
    })
    nameEntry:setAnchorPoint(0.5, 0.5)
    nameEntry:setPosition(130, self.size.height - 150)

    layer:addChild(nameEntry, 1)

    -- 得分
    local scoreLabel = display.newTTFLabel({
        text = "得分",
        font = "Marker Felt",
        size = 18,
        color = cc.c3b(0, 0, 0)
    })
    scoreLabel:setAnchorPoint(0.5, 0.5)
    scoreLabel:setPosition(210, self.size.height - 150)

    layer:addChild(scoreLabel, 1)

    local scoreText = self.score
    local scoreEntry = display.newTTFLabel({
        text = scoreText,
        font = "Marker Felt",
        size = 18,
        color = cc.c3b(0, 0, 0)
    })
    scoreEntry:setAnchorPoint(0.5, 0.5)
    scoreEntry:setPosition(290, self.size.height - 150)

    layer:addChild(scoreEntry, 1)


    -- 重新开始
    local restartImages = {
        normal =  SystemConst.GAME_OVER_BUTTON_RESTART,
        pressed = SystemConst.GAME_OVER_BUTTON_RESTART,
        disabled = SystemConst.GAME_OVER_BUTTON_RESTART
    }

    local restartBtn = ccui.Button:create(restartImages["normal"], restartImages["pressed"], restartImages["disabled"])
    restartBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    -- 居中
    restartBtn:setPosition(cc.p(display.cx, display.cy + 60))
    -- 设置缩放程度
    restartBtn:setScale(0.5, 0.5)
    -- 设置是否禁用(false为禁用)
    restartBtn:setEnabled(true)
    restartBtn:addClickEventListener(function ()
        print("进入到GamePlay场景...")

        if defaults:getBoolForKey(SystemConst.SOUND_KEY) then
            audio.loadFile(SystemConst.BUTTON_EFFECT, function ()
                audio.playEffect(SystemConst.BUTTON_EFFECT, false)
            end)
        end

        defaults:setBoolForKey("flag", false)

        cc.Director:getInstance():replaceScene(require("app.scenes.GamePlayScene").new())
    end)

    layer:addChild(restartBtn, 4)


    -- 返回主菜单
    local backImages = {
        normal = SystemConst.GAME_OVER_BUTTON_BACK,
        pressed = SystemConst.GAME_OVER_BUTTON_BACK,
        disabled = SystemConst.GAME_OVER_BUTTON_BACK
    }

    local backBtn = ccui.Button:create(backImages["normal"], backImages["pressed"], backImages["disabled"])
    backBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    -- 居中
    backBtn:setPosition(cc.p(display.cx, display.cy - 20))
    -- 设置缩放程度
    backBtn:setScale(0.5, 0.5)
    -- 设置是否禁用(false为禁用)
    backBtn:setEnabled(true)
    backBtn:addClickEventListener(function ()

        defaults:setBoolForKey(SystemConst.IF_CONTINUE, false)

        if defaults:getBoolForKey(SystemConst.SOUND_KEY) then
            audio.loadFile(SystemConst.BUTTON_EFFECT, function ()
                audio.playEffect(SystemConst.BUTTON_EFFECT, false)
            end)
        end

        cc.Director:getInstance():replaceScene(require("app.scenes.MainScene").new())
    end)

    self:addChild(backBtn, 4)

    --- Tap the Screen to Play

    -- 注册触摸事件监听器
    self.listener = cc.EventListenerTouchOneByOne:create()
    self.listener:setSwallowTouches(true)
    -- EVENT_TOUCH_BEGAN事件回调函数
    self.listener:registerScriptHandler(self.touchBegan, cc.Handler.EVENT_TOUCH_BEGAN)

    -- 添加触摸事件监听器
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(self.listener, layer)
    return layer
end


function GameOverScene:onEnter()
    print("GameOverScene onEnter")
end

function GameOverScene:onEnterTransitionFinish()
    print("GameOverScene onEnterTransitionFinish")
end

function GameOverScene:onExit()
    print("GameOverScene onExit")

    if nil ~= self.listener then
        cc.Director:getInstance():getEventDispatcher():removeEventListener(self.listener)
    end
end

function GameOverScene:onExitTransitionStart()
    print("GameOverScene onExitTransitionStart")
end

function GameOverScene:cleanup()
    print("GameOverScene cleanup")
end

-----------------------------------------------------------------

-- 接触检测事件回调函数
function GameOverScene:touchBegan(touch, event)
    -- 播放音效
    if defaults:getBoolForKey(SystemConst.SOUND_KEY) then
        --AudioEngine.playEffect(SystemConst.BUTTON_EFFECT)
    end

    cc.Director:getInstance():popScene()
    return false
end

-- 排名更新函数
function GameOverScene:updateRank()
    local f = io.open(self.writablePath .. SystemConst.JSON_RANK, "r")
    io.input(f)
    local temp = io.read("*a")
    io.close(f)
    local tb = json.decode(temp)

    local item = {name = defaults:getStringForKey("name"), score = self.score}
    table.insert(tb, item)
    table.sort(tb, function (a, b)
        return a.score > b.score
    end)
    table.remove(tb)
    local str = json.encode(tb)
    f = io.open(self.writablePath .. SystemConst.JSON_RANK, "w")
    io.output(f)
    io.write(str)
    io.close(f)
end


return GameOverScene