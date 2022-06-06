local RankScene = class("RankScene", function()
    return display.newScene("RankScene")
end)

function RankScene:ctor()
    do
        --背景图片
    local background = display.newSprite("ui/main/bg_menu.jpg")
    background:pos(display.cx, display.cy)
    self:addChild(background)
    end

    do
        --标题
        local title = ccui.Text:create("rank", "ui/font/FontNormal.ttf",80)
        title:setContentSize(cc.size(200, 80))
        title:setColor(cc.c3b(0, 0, 255))
        title:pos(display.cx, display.cy + 200)
        title:setAnchorPoint(0.5, 0.5)
        title:addTo(self)
    end

    self:createBottomPanel()
end

function RankScene:effectMusic(path)
    if cc.UserDefault:getInstance():getBoolForKey("effectMusic") then
        audio.loadFile(path, function ()
            audio.playEffect(path, false)
        end)
    end
end

function RankScene:createBottomPanel()
    --返回按钮
    local btn = ccui.Button:create("ui/back_peek0.png", "ui/back_peek1.png")
    btn:setScale9Enabled(true)
    btn:setContentSize(cc.size(140,50))
    btn:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            self:effectMusic("sounds/buttonEffet.ogg")
            local AnotherScence = require("src/app/scenes/MenuScene")
            local MenuScene = AnotherScence:new()
            display.replaceScene(MenuScene, "fade", 0.5, cc.c3b(255, 255, 255))
        end
    end)
    btn:setAnchorPoint(0.5, 0.5)
    btn:pos(display.cx - 180, display.cy + 320)
    btn:addTo(self)


    --创建排行榜
    local listView = ccui.ListView:create()
    listView:setBackGroundColor(cc.c3b(100, 100, 100))
	listView:setContentSize(420, 320)
    listView:setAnchorPoint(0.5, 0.5)
	listView:setPosition(display.cx, display.cy - 50)
    listView:setDirection(1)
	listView:addTo(self)

    local point = 10000
    for i = 1, 3 do
        local img_bg = ccui.ImageView:create("ui/rank/rank_item_bg.png")
        img_bg:setScale9Enabled(true)
        img_bg:setContentSize(cc.size(420, 80))
        listView:pushBackCustomItem(img_bg)

        local font_rank = ccui.TextBMFont:create(tostring(i), "ui/rank/islandcvbignum.fnt")
        font_rank:setScale(0.4)
        font_rank:setContentSize(cc.size(400, 80))
        font_rank:pos(20, 15)
        font_rank:setAnchorPoint(0, 0)
        img_bg:addChild(font_rank)

        local font_name = ccui.Text:create("昵称" .. tostring(i), "ui/font/FontNormal.ttf",50)
        font_name:setContentSize(cc.size(400, 80))
        font_name:pos(80, 10)
        font_name:setAnchorPoint(0, 0)
        img_bg:addChild(font_name)

        local font_point = ccui.TextBMFont:create(tostring(point), "ui/rank/islandcvbignum.fnt")
        point = point - 1000
        font_point:setScale(0.4)
        font_point:setContentSize(cc.size(400, 80))
        font_point:pos(220, 15)
        font_point:setAnchorPoint(0, 0)
        img_bg:addChild(font_point)
    end

    for i = 4, 5 do
        local img_bg = ccui.ImageView:create("ui/rank/rank_item_bg.png")
        img_bg:setScale9Enabled(true)
        img_bg:setContentSize(cc.size(420, 80))
        listView:pushBackCustomItem(img_bg)

        local font_rank = ccui.Text:create(tostring(i), "ui/font/FontNormal.ttf",50)
        font_rank:setContentSize(cc.size(400, 80))
        font_rank:pos(25, 10)
        font_rank:setAnchorPoint(0, 0)
        img_bg:addChild(font_rank)

        local font_name = ccui.Text:create("昵称" .. tostring(i), "ui/font/FontNormal.ttf",50)
        font_name:setContentSize(cc.size(400, 80))
        font_name:pos(80, 10)
        font_name:setAnchorPoint(0, 0)
        img_bg:addChild(font_name)

        local font_point = ccui.Text:create(tostring(point), "ui/font/FontNormal.ttf",50)
        point = point - 1000
        font_point:setContentSize(cc.size(400, 80))
        font_point:pos(220, 10)
        font_point:setAnchorPoint(0, 0)
        img_bg:addChild(font_point)
    end



end

function RankScene:onEnter()
end

function RankScene:onExit()
end

return RankScene