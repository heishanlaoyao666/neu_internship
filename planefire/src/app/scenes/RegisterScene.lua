
local RegisterScene = class("RegisterScene", function()
    return display.newScene("RegisterScene")
end)

function RegisterScene:ctor()
    do
        --背景图片
        local background = display.newSprite("ui/main/bg_menu.jpg")
        background:pos(display.cx, display.cy)
        self:addChild(background)
    end
    self:initView()
end

function RegisterScene:effectMusic(path)
    if cc.UserDefault:getInstance():getBoolForKey("effectMusic") then
        audio.loadFile(path, function ()
            audio.playEffect(path, false)
        end)
    end
end

function RegisterScene:initView()
    --标题文字
    local title = display.newTTFLabel({
        text = "飞机大战",
        size = 64,
        color = display.COLOR_BLUE,
        x = display.cx,
        y = display.cy + 100,
    })
    title:align(display.CENTER)
    self:addChild(title)

    --文本框
    local locationEditbox = ccui.EditBox:create(cc.size(200, 40), "ui/rank/rank_bg.png", 0)
    locationEditbox:setAnchorPoint(0.5,0.5)
    locationEditbox:pos(display.cx, display.cy)
    locationEditbox:addTo(self)

    --注册确定按钮
    local btn = ccui.Button:create("ui/register/register.png")        
    btn:setScale9Enabled(true)
    btn:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            --转换到主菜单界面
            self:effectMusic("sounds/buttonEffet.ogg")
            id = tostring(getUUID())
            name = tostring(locationEditbox:getText())
            if id == "" and name == "" then
                print("请输入用户名")
            else
                print(id)
                print(name)
                cc.UserDefault:getInstance():setStringForKey("id", id)
                cc.UserDefault:getInstance():setStringForKey("name", name)
                local AnotherScene = require("src/app/scenes/MenuScene.lua")
                local MenuScene = AnotherScene:new()
                display.replaceScene(MenuScene, "fade", 0.5, cc.c3b(255, 255, 255))
            end
        end
    end)
    btn:pos(display.cx, display.cy - 100)
    btn:addTo(self)

    --返回按钮
    local btn = ccui.Button:create("ui/back_peek0.png", "ui/back_peek1.png")
    btn:setScale9Enabled(true)
    btn:setContentSize(cc.size(140,50))
    btn:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            self:effectMusic("sounds/buttonEffet.ogg")
            local AnotherScence = require("src/app/scenes/MenuScene")
            local MenuScene = AnotherScence:ctor()
            display.replaceScene(MenuScene, "fade", 0.5, cc.c3b(255, 255, 255))
        end
    end)
    btn:setAnchorPoint(0.5, 0.5)
    btn:pos(display.cx - 180, display.cy + 320)
    btn:addTo(self)
end

function getUUID()
    local curTime = os.time()
    local uuid = curTime + math.random(10000000)
    return uuid
end

function RegisterScene:onEnter()
end

function RegisterScene:onExit()
end

return RegisterScene
