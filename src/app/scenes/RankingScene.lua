local RankingScene = class("RankingScene", function ()
    return display.newScene("RankingScene")
end)

--[[--
    构造函数
    @param none
    @return none
]]
function RankingScene:ctor()
    self:createLayer()
end

function RankingScene:create()
    local scene = RankingScene.new()
    return scene
end

function RankingScene:createLayer()
    local director = cc.Director:getInstance()

    --面板设置
    local rankLayer = ccui.Layout:create()         --创建层
    rankLayer:setBackGroundImage("ui/main/bg_menu.jpg")
    rankLayer:setBackGroundColor(cc.c3b(100,50,100))
    rankLayer:setBackGroundColorType(1)
    rankLayer:setContentSize(display.width,display.height)
    rankLayer:setPosition(display.width/2, display.top/2)
    rankLayer:setAnchorPoint(0.5, 0.5)             --设置锚点
    rankLayer:addTo(self)

    -- 返回按钮
    local buttonSet = ccui.Button:create("ui/back_peek0.png", "ui/back_peek1.png")
    buttonSet:setAnchorPoint(0, 1)
    buttonSet:setScale9Enabled(true)
    buttonSet:setContentSize(140, 45)
    --buttonContinue:setTitleText("继续")
    buttonSet:pos(10, display.height-20)
    buttonSet:setTitleFontSize(20)
    buttonSet:addTo(rankLayer)
    -- 按钮点击事件(关闭 设置界面)
    buttonSet:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            director:popScene()
        end
    end)

--[[--
    排行榜滑动表格
]]
    local itemWidth, itemHeight = 100, 50
    local testView = ccui.ListView:create()
	testView:setContentSize(itemWidth*3, itemHeight*5)      --列表大小
    testView:setAnchorPoint(0.5, 0.5)
	testView:setPosition(display.width/2, display.height/2)
    testView:setDirection(1)    --1垂直，2水平
	testView:addTo(rankLayer)
    for i = 1, 6 do
        --用层存放不同内容作为表的元素
        local itemLayer = ccui.Layout:create()
        --itemLayer:setBackGroundColor(cc.c3b(math.random(100, 200), math.random(100, 200), math.random(100, 200)))
        --itemLayer:setBackGroundColorType(1)
        --itemLayer:setBackGroundImage("ui/rank/rank_item_bg.png")
        itemLayer:setContentSize(itemWidth*3, itemHeight)       --元素层大小
        itemLayer:addTo(testView)

        -- 列表背景图片
        --local spriteBack = ccui.Scale9Sprite:create("ui/rank/rank_item_bg.png")
        local spriteBack = display.newScale9Sprite("ui/rank/rank_item_bg.png", 20, 20, cc.size(itemWidth*3, itemHeight))
        spriteBack:setPosition(0, itemHeight/2)
        spriteBack:setAnchorPoint(0, 0.5)
        --spriteBack:setContentSize(cc.size(itemWidth*3, itemHeight))
        spriteBack:addTo(itemLayer)

        local font
        if i <= 3 then
            font = ccui.TextBMFont:create(i .. " ", "islandcvbignum.fnt")
            font:setScale(0.25)
        else
            font = ccui.Text:create(i .. " ", "FontNormal.ttf", 25)
        end
        font:addTo(itemLayer)
        font:setAnchorPoint(0, 0.5)
        font:pos(25, itemHeight/2)

        local fontName = ccui.Text:create("昵称 " .. i .. " ", "FontNormal.ttf", 20)
        fontName:addTo(itemLayer)
        fontName:setAnchorPoint(0, 0.5)
        fontName:pos(itemWidth-30, itemHeight * 0.5)

        local scoreTitle = ccui.Text:create("得分 ", "FontNormal.ttf", 20)
        scoreTitle:addTo(itemLayer)
        scoreTitle:setAnchorPoint(0, 0.5)
        scoreTitle:pos(itemWidth*2-55, itemHeight * 0.5)

        local fontScore
        if i <= 3 then
            fontScore = ccui.TextBMFont:create((10000 - (i-1) * 1000), "islandcvbignum.fnt")
            fontScore:setScale(0.23)
        else
            fontScore = ccui.Text:create((10000 - (i-1) * 1000), "FontNormal.ttf", 20)
        end
        fontScore:addTo(itemLayer)
        fontScore:setAnchorPoint(0, 0.5)
        fontScore:pos(itemWidth*2 - 10, itemHeight * 0.5)

    end








    --return rankLayer
end
return RankingScene




