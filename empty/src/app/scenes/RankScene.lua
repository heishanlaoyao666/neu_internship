local RankScene = class("RankScene", function()
    return display.newScene("RankScene")
end)

--[[--
    构造函数

    @param none

    @return none
]]
function RankScene:ctor()
    -- 贴居中
    self:createLeftTopPanel()
    self:createMiddleMiddlePanel()
end
--- 函数定义
local RankItem


function RankScene:createLeftTopPanel()
    local width, height = display.width, display.top
    local ReturnLayer = ccui.Layout:create()
    ReturnLayer:setContentSize(width, height)
    ReturnLayer:setPosition(0, height)
    ReturnLayer:setAnchorPoint(0, 1)
    --inputLayer:setScale9Enabled(true)
    ReturnLayer:addTo(self)
    -- 返回
    local new_gameButton = ccui.Button:create("ui/back_peek0.png", "ui/back_peek1.png")
    new_gameButton:setAnchorPoint(0, 1)
    new_gameButton:setContentSize(200, 60)
	new_gameButton:setTitleText("")
    new_gameButton:pos(0, height)
	--continueButton:setTitleFontSize(20)
    new_gameButton:addTo(ReturnLayer)

    -- 点击返回菜单
    new_gameButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			local nextScene=import("app/scenes/MainScene"):new()
            display.replaceScene(nextScene)
		end
	end)
    
end

function RankScene:createMiddleMiddlePanel()
    local width, height = display.width - 30, 400
    local bottomLayer = ccui.Layout:create()
    bottomLayer:setBackGroundImage("ui/rank/rank_bg.png")
    bottomLayer:setBackGroundImageScale9Enabled(true)
    bottomLayer:setContentSize(width, height)
    bottomLayer:setPosition(display.cx, display.top*0.5)
    bottomLayer:setAnchorPoint(0.5, 0.5)
    bottomLayer:addTo(self)
    --img
    
    local listView = ccui.ListView:create()
    -- 以某个元素宽度做容器宽度
	listView:setContentSize(display.width - 30, height -10)
    listView:setAnchorPoint(0, 0.5)
	listView:setPosition(10, height * 0.5)
    listView:setDirection(1)
	listView:addTo(bottomLayer)
    for i = 1, 10 do
        --添加排行榜信息
        listView:pushBackCustomItem(RankItem(i,"名字"..i))
    end

    -- local bmFontlistView = ccui.ListView:create()
	-- bmFontlistView:setContentSize(180, height -10)
    -- bmFontlistView:setAnchorPoint(0, 0.5)
	-- bmFontlistView:setPosition(200, height * 0.5)
    -- bmFontlistView:setDirection(1)
	-- bmFontlistView:addTo(bottomLayer)
    -- for i = 1, 15 do
    --     local font = ccui.TextBMFont:create(tostring(math.random(1, 100)), "islandcvbignum.fnt")
    --     bmFontlistView:pushBackCustomItem(font)
    -- end

    ---ttf
    -- local txtListView = ccui.ListView:create()
	-- txtListView:setContentSize(width * 0.5, 100)
    -- txtListView:setAnchorPoint(1, 0.5)
	-- txtListView:setPosition(width - 10, height * 0.5)
    -- txtListView:setDirection(2)
	-- txtListView:addTo(bottomLayer)
    -- for i = 1, 15 do
    --     local font = ccui.Text:create(" 我是谁 ", "FontNormal.ttf", 25)
    --     txtListView:pushBackCustomItem(font)
    -- end

    -- local itemWidth, itemHeight = 100, 100
    -- local testView = ccui.ListView:create()
	-- testView:setContentSize(width * 0.5, itemHeight)
    -- testView:setAnchorPoint(1, 0)
	-- testView:setPosition(width - 10, 10)
    -- testView:setDirection(2)
	-- testView:addTo(bottomLayer)
    -- for i = 1, 15 do
    --     local itemLayer = ccui.Layout:create()
    --     itemLayer:setBackGroundColor(cc.c3b(math.random(100, 200), math.random(100, 200), math.random(100, 200)))
    --     itemLayer:setBackGroundColorType(1)
    --     itemLayer:setContentSize(itemWidth, itemHeight)
    --     itemLayer:addTo(testView)

    --     local font = ccui.Text:create(" btn" .. i .. " ", "FontNormal.ttf", 25)
    --     font:addTo(itemLayer)
    --     font:setAnchorPoint(0.5, 1)
    --     font:pos(itemWidth * 0.5, itemHeight)

    --     local btn = ccui.Button:create("rank_bg.png", "rank_bg.png")
    --     btn:setAnchorPoint(0.5, 0)
    --     btn:setScale9Enabled(true)
    --     btn:setContentSize(itemWidth, 50)
    --     btn:setTitleText(" btn" .. i .. " ")
    --     btn:pos(itemWidth * 0.5, 0)
    --     btn:setTitleFontSize(20)
    --     btn:addTo(itemLayer)

    --     -- 点击输出输入框的内容
    --     btn:addTouchEventListener(function(sender, eventType)
    --         if 2 == eventType then
    --             print("you click btn =", font:getString())
    --         end
    --     end)
    -- end
end
--[[--
    排行榜item的构造

    @param number int
    @param name string

    @return rankItemLayer
]]
function RankItem(number,name,score)
    local rankItemLayer = ccui.Layout:create()
    rankItemLayer:setContentSize(display.width, 50) --设置容器大小
    rankItemLayer:setAnchorPoint(0, 0.5)  --设置锚点
     --设置名字
     local name = ccui.Text:create(tostring(name), "ui/font/FontNormal.ttf", 30)
     name:setAnchorPoint(0.5, 0.5)
     name:addTo(rankItemLayer)
     name:pos(display.width*0.4,25)
    
    --设置分数和名次
    if score then

    else
        if(tonumber(number)<4) then
            local score = ccui.TextBMFont:create(tostring(((11-tonumber(number))*1000)), "ui/rank/islandcvbignum.fnt")
            score:setScale(0.3)
            score:setAnchorPoint(1, 0.5)
            score:addTo(rankItemLayer)
            score:pos(display.width*0.8,25)
            --设置名次
            local rank = ccui.TextBMFont:create(tostring(number), "ui/rank/islandcvbignum.fnt")
            rank:setScale(0.3)
            rank:setAnchorPoint(1, 0.5)
            rank:addTo(rankItemLayer)
            rank:pos(display.width*0.2,25)  
        else
            local score = ccui.Text:create(tostring(((11-tonumber(number))*1000)), "ui/font/FontNormal.ttf", 30)
            score:setAnchorPoint(1, 0.5)
            score:addTo(rankItemLayer)
            score:pos(display.width*0.8,25)
            --设置名次
            local rank = ccui.Text:create(tostring(number), "ui/font/FontNormal.ttf", 30)
            rank:setAnchorPoint(1, 0.5)
            rank:addTo(rankItemLayer)
            rank:pos(display.width*0.2,25)           
        end
    end

    return rankItemLayer

end
function RankScene:onEnter()
end

function RankScene:onExit()
end


return RankScene