
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

local scheduler = require("framework.scheduler")

function MainScene:ctor()
    local label = display.newTTFLabel({
        text = "Hello",
        size = 64,
    })
    label:align(display.CENTER, display.cx, display.cy)
    label:addTo(self)
    if cc.UserDefault:getInstance():getBoolForKey("yinyue") then
        -- body
        audio.playBGM("res\\sounds\\mainMainMusic.ogg",true)
        else
        audio.stopBGM("res\\sounds\\mainMainMusic.ogg")
            -- body
    end

    self:createStartPanel()

end

function MainScene:onEnter()
end

function MainScene:onExit()
end

function MainScene:createStartPanel()
--     -- 初始化开始界面
    local width,height = 480,720
    local startLayer = ccui.Layout:create()
    --startLayer:setBackGroundColor(cc.c3b(100, 0, 0))
    startLayer:setBackGroundImage("res\\ui\\main\\bg_menu.jpg")
    startLayer:setBackGroundColorType(1)
    startLayer:setContentSize(cc.size(width,height))
    startLayer:setPosition(display.cx, display.cy)
    startLayer:setAnchorPoint(cc.p(0.5, 0.5))

    -- layer:setContentSize(cc.size(300, 300))
    -- layer:setAnchorPoint(cc.p(0.5, 0.5))
    -- layer:pos(display.cx, display.cy + 250)
    startLayer:addTo(self)

    local function getUUID() local curTime = os.time() local uuid = curTime + math.random(10000000)
        return uuid end
    local btn_Name = {"res\\ui\\main\\new_game1.png","res\\ui\\main\\continue_menu.png",
    "res\\ui\\main\\rank_menu.png","res\\ui\\main\\shezhi1_cover.png"}
    local btn_Name1 = {"res\\ui\\main\\new_game2.png","res\\ui\\main\\continue_menu2.png",
    "res\\ui\\main\\rank_menu2.png","res\\ui\\main\\shezhi2_cover.png"}
     for i=1,4 do
    --     local itemLayer = ccui.Layout:create()
    --     itemLayer:setBackGroundColor(cc.c3b(math.random(100, 200), math.random(100, 200), math.random(100, 200)))
    --     itemLayer:setBackGroundColorType(1)
    --     itemLayer:setContentSize(width, height)
    --     itemLayer:addTo(startLayer)
    --     -- 开始界面按钮
        local btn = ccui.Button:create(btn_Name[i], btn_Name1[i], 1)
        btn:setScale9Enabled(true)
        btn:setContentSize(cc.size(150, 50))
        --btn:setTitleText(btn_Name[i])
        btn:setTitleFontSize(24)

        btn:pos(width*0.5, height*(1-0.2*i))
        if i==1 then
            -- body
            btn:addTouchEventListener(function(sender, eventType)
                -- ccui.TouchEventType
                if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("yinxiao") then
                    audio.playEffect("res\\sounds\\buttonEffet.ogg",false)
                end
                if cc.UserDefault:getInstance():getStringForKey("id")~="" then
                    cc.UserDefault:getInstance():setBoolForKey("document",false)
                local AnotherScene=require("src\\app\\scenes\\BattleUI.lua"):new()
                display.replaceScene(AnotherScene, "fade", 0.5)
                -- if cc.UserDefault:getInstance():getStringForKey("yinyue") then
                --     audio.loadFile("res\\sounds\\bgMusic.ogg", function ()
                --         audio.playBGM("res\\sounds\\bgMusic.ogg",true)
                --     end)
                -- end
                else
                    -- body
                    local AnotherScene=require("app.scenes.zhucheUI"):new()
                    display.replaceScene(AnotherScene, "fade", 0.5)
                end
            end
        end)
    elseif i==2 then
        btn:addTouchEventListener(function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
            if cc.UserDefault:getInstance():getBoolForKey("document") then
                local AnotherScene=require("src\\app\\scenes\\BattleUI.lua"):new()
                display.replaceScene(AnotherScene, "fade", 0.5)
            end
            if cc.UserDefault:getInstance():getBoolForKey("yinxiao") then
                audio.playEffect("res\\sounds\\buttonEffet.ogg",false)
            end
        end
    end)
        -- body
    elseif i==3 then
        btn:addTouchEventListener(function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
            if cc.UserDefault:getInstance():getBoolForKey("yinxiao") then
                audio.playEffect("res\\sounds\\buttonEffet.ogg",false)
            end
            local AnotherScene=require("app.scenes.RankUI"):new()
                display.replaceScene(AnotherScene, "fade", 0.5)
        end
    end)
            -- body
    elseif i==4 then
        btn:addTouchEventListener(function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
            if cc.UserDefault:getInstance():getBoolForKey("yinxiao") then
                audio.playEffect("res\\sounds\\buttonEffet.ogg",false)
            end
            local AnotherScene=require("app.scenes.SheZhiUI"):new()
            display.replaceScene(AnotherScene, "fade", 0.5)
        end
    end)

    end

    btn:addTo(startLayer)

    end

end

function MainScene:update(dt)
    -- print("dt=", dt)
end

return MainScene
