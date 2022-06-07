

local defaults=cc.UserDefault:getInstance()

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

--[[--
    构造函数

    @param none

    @return none
]]
function MainScene:ctor()
    --启动音乐
    local audio = require("framework.audio")
    cc.FileUtils:getInstance():addSearchPath("res/")
    -- 贴居中
    self:createMiddleMiddlePanel()
end

--[[--
    

    @param none

    @return none
]]
function MainScene:createMiddleMiddlePanel()
    local width, height = display.width, display.top
    local inputLayer = ccui.Layout:create()
    inputLayer:setBackGroundImage("ui/main/bg_menu.jpg")
    inputLayer:setBackGroundImageScale9Enabled(true)
    --inputLayer:setBackGroundColor(cc.c3b(0, 100, 0))
    --inputLayer:setBackGroundColorType(1)
    inputLayer:setContentSize(width, height)
    inputLayer:setPosition(width*0.5, height *0.5)
    inputLayer:setAnchorPoint(0.5, 0.5)
    --inputLayer:setScale9Enabled(true)
    inputLayer:addTo(self)

    -- 新游戏
    local new_gameButton = ccui.Button:create("ui/main/new_game1.png", "ui/main/new_game2.png")
    new_gameButton:setAnchorPoint(0.5, 0.5)
    new_gameButton:setContentSize(200, 60)
	new_gameButton:setTitleText("")
    new_gameButton:pos(width * 0.5, height*0.7)
	--continueButton:setTitleFontSize(20)
    new_gameButton:addTo(inputLayer)

    -- 点击输出输入框的内容
    new_gameButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			local battleScene=import("app/scenes/BattleScene"):new()
            display.replaceScene(battleScene)
		end
	end)
    -- 继续
    local continueButton = ccui.Button:create("ui/main/continue_menu.png", "ui/main/continue_menu2.png")
    continueButton:setAnchorPoint(0.5, 0.5)
    continueButton:setContentSize(200, 60)
	continueButton:setTitleText("")
    continueButton:pos(width * 0.5, height*0.6)
	--continueButton:setTitleFontSize(20)
    continueButton:addTo(inputLayer)

    -- 点击事件
    continueButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			
		end
	end)
    -- 排行榜
    local rankButton = ccui.Button:create("ui/main/rank_menu.png", "ui/main/rank_menu2.png")
    rankButton:setAnchorPoint(0.5, 0.5)
    rankButton:setContentSize(200, 60)
	rankButton:setTitleText("")
    rankButton:pos(width * 0.5, height*0.5)
	--continueButton:setTitleFontSize(20)
    rankButton:addTo(inputLayer)

    -- 点击事件
    rankButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			local nextScene=import("app/scenes/RankScene"):new()
            display.replaceScene(nextScene)
		end
	end)
    -- 设置
    local shezhiButton = ccui.Button:create("ui/main/shezhi1_cover.png", "ui/main/shezhi2_cover.png")
    shezhiButton:setAnchorPoint(0.5, 0.5)
    shezhiButton:setContentSize(200, 60)
	shezhiButton:setTitleText("")
    shezhiButton:pos(width * 0.5, height*0.4)
	--continueButton:setTitleFontSize(20)
    shezhiButton:addTo(inputLayer)

    -- 点击事件
    shezhiButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			local nextScene=import("app/scenes/ShezhiScene"):new()
            display.replaceScene(nextScene)
		end
	end)

    --测试用
    -- local Layer = ccui.Layout:create()
    -- Layer:setBackGroundColor(cc.c3b(0,100, 0))
    -- Layer:setVisible(true)
    -- Layer:setBackGroundColorType(1)
    -- Layer:setContentSize(width, height)
    -- Layer:setPosition(width*0.5, height *0.5)
    -- Layer:setAnchorPoint(0.5, 0.5)
    -- --inputLayer:setScale9Enabled(true)
    -- Layer:addTo(self)
end

--[[--
    创建下方居中面板

    @param none

    @return none
]]
function MainScene:createBottomPanel()
    local width, height = display.width - 30, 400
    local bottomLayer = ccui.Layout:create()
    bottomLayer:setBackGroundColor(cc.c3b(100, 100, 100))
    bottomLayer:setBackGroundColorType(1)
    bottomLayer:setContentSize(width, height)
    bottomLayer:setPosition(display.cx, 10)
    bottomLayer:setAnchorPoint(0.5, 0)
    bottomLayer:addTo(self)

    --img
    local temp = ccui.ImageView:create("rank_bg.png")
    local listView = ccui.ListView:create()
    -- 以某个元素宽度做容器宽度
	listView:setContentSize(temp:getContentSize().width, height -10)
    listView:setAnchorPoint(0, 0.5)
	listView:setPosition(10, height * 0.5)
    listView:setDirection(1)
	listView:addTo(bottomLayer)
    for i = 1, 5 do
        local img = ccui.ImageView:create("rank_bg.png")
        listView:pushBackCustomItem(img)
    end

    local bmFontlistView = ccui.ListView:create()
	bmFontlistView:setContentSize(180, height -10)
    bmFontlistView:setAnchorPoint(0, 0.5)
	bmFontlistView:setPosition(200, height * 0.5)
    bmFontlistView:setDirection(1)
	bmFontlistView:addTo(bottomLayer)
    for i = 1, 15 do
        local font = ccui.TextBMFont:create(tostring(math.random(1, 100)), "islandcvbignum.fnt")
        bmFontlistView:pushBackCustomItem(font)
    end

    --ttf
    local txtListView = ccui.ListView:create()
	txtListView:setContentSize(width * 0.5, 100)
    txtListView:setAnchorPoint(1, 0.5)
	txtListView:setPosition(width - 10, height * 0.5)
    txtListView:setDirection(2)
	txtListView:addTo(bottomLayer)
    for i = 1, 15 do
        local font = ccui.Text:create(" 我是谁 ", "FontNormal.ttf", 25)
        txtListView:pushBackCustomItem(font)
    end

    local itemWidth, itemHeight = 100, 100
    local testView = ccui.ListView:create()
	testView:setContentSize(width * 0.5, itemHeight)
    testView:setAnchorPoint(1, 0)
	testView:setPosition(width - 10, 10)
    testView:setDirection(2)
	testView:addTo(bottomLayer)
    for i = 1, 15 do
        local itemLayer = ccui.Layout:create()
        itemLayer:setBackGroundColor(cc.c3b(math.random(100, 200), math.random(100, 200), math.random(100, 200)))
        itemLayer:setBackGroundColorType(1)
        itemLayer:setContentSize(itemWidth, itemHeight)
        itemLayer:addTo(testView)

        local font = ccui.Text:create(" btn" .. i .. " ", "FontNormal.ttf", 25)
        font:addTo(itemLayer)
        font:setAnchorPoint(0.5, 1)
        font:pos(itemWidth * 0.5, itemHeight)

        local btn = ccui.Button:create("rank_bg.png", "rank_bg.png")
        btn:setAnchorPoint(0.5, 0)
        btn:setScale9Enabled(true)
        btn:setContentSize(itemWidth, 50)
        btn:setTitleText(" btn" .. i .. " ")
        btn:pos(itemWidth * 0.5, 0)
        btn:setTitleFontSize(20)
        btn:addTo(itemLayer)

        -- 点击输出输入框的内容
        btn:addTouchEventListener(function(sender, eventType)
            if 2 == eventType then
                print("you click btn =", font:getString())
            end
        end)
    end
end


function MainScene:onEnter()
end

function MainScene:onExit()
end


return MainScene
