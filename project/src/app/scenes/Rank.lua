local Rank = class("Rank", function()
    return display.newScene("Rank")
end)

function Rank:ctor()
    display.newSprite("bg_menu.jpg")
           :pos(display.cx,display.cy)
           :addTo(self)

    self:createMiddleMiddlePanel()
end

function Rank:createMiddleMiddlePanel()
    --local bg = cc.Sprite:create("ui/main/bg_menu.jpg")
    --bg:setPosition(cc.p(display.cx,display.cy))
    --bg:setScale(0.5,0.5)
    --self:addChild(bg)

    local images = {
        normal = "ui/back_peek0.png",
        pressed = "ui/back_peek1.png",
        disabled = "ui/back_peek0.png",
    }

    local backBtn = ccui.Button:create(images["normal"],images["pressed"],images["disabled"])
    backBtn:setAnchorPoint(cc.p(0,1))
    backBtn:setPosition(cc.p(display.left,display.top))
    backBtn:setScale(0.5,0.5)
    backBtn:setEnabled(true)
    backBtn:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            local NewGameBtn = import("app.scenes.SecScene"):new()
            display.replaceScene(NewGameBtn,"turnOffTiles",0.5)
            print(transform)
        end
    end
        )
    self:addChild(backBtn,4)












    local list = {
        [1] = {['no'] = 1, ['name'] = "小明", ['score'] = 10000},
        [2] = {['no'] = 2, ['name'] = "小红", ['score'] = 9000},
        [3] = {['no'] = 3, ['name'] = "小李", ['score'] = 8000},
        [4] = {['no'] = 4, ['name'] = "小赵", ['score'] = 7000},
        [5] = {['no'] = 5, ['name'] = "小孙", ['score'] = 6000}
    }



    local layer = ccui.Layout:create()
    layer:setBackGroundColor(cc.c3b(24, 78, 168))
    layer:setBackGroundColorType(1)
    layer:setContentSize(300, 400)
    layer:setPosition(display.cx, 150)
    layer:setAnchorPoint(0.5, 0)
    layer:setCascadeOpacityEnabled(true)
    layer:setOpacity(0.5 * 255)
    layer:setBackGroundImageScale9Enabled(true)

    layer:addTo(self)

    --排名数目1.3
    rankColTopListView = ccui.ListView:create()
    --4.5
    rankColBottomListView = ccui.ListView:create()
    nameColListView = ccui.ListView:create()
    scoreColListView = ccui.ListView:create()
    backRowListView = ccui.ListView:create()
    --backRowListView:setScrollBarEnabled(false)

    -- 项背景列表
    backRowListView:setContentSize(300, 400)
    backRowListView:setPosition(30, 120)
    backRowListView:setDirection(1)
    backRowListView:setBackGroundImageScale9Enabled(true)

    local title = ccui.ImageView:create("ui/rank/rank_title_bg.png")
    backRowListView:pushBackCustomItem(title)

    for i = 1, 5 do



        local img =  ccui.ImageView:create("ui/rank/rank_item_bg.png")
        img:setScale(0.95, 0.95)

        --img:setBackGroundImageScale9Enabled(true)

        backRowListView:pushBackCustomItem(img)
    end

    self:addChild(backRowListView, 4)


    -- 排名分列表

    rankColTopListView:setContentSize(70, 350)
    rankColTopListView:setPosition(30, 150)
    rankColTopListView:setDirection(1)
    for i = 1, 3 do
        local font = ccui.TextBMFont:create(tostring(i), "ui/rank/islandcvbignum.fnt")
        font:setScale(0.4, 0.4)

        rankColTopListView:pushBackCustomItem(font)
    end

    -- 设置高度间隔
    rankColTopListView:setItemsMargin(-38)

    self:addChild(rankColTopListView, 4)


    rankColBottomListView:setContentSize(70, 130)
    rankColBottomListView:setPosition(60, 142)
    rankColBottomListView:setDirection(1)
    for i = 4, 5 do
        rankColBottomListView:pushBackCustomItem(ccui.Text:create(i, "FontNormal.ttf", 25))
    end

    -- 设置高度间隔
    rankColBottomListView:setItemsMargin(28)

    self:addChild(rankColBottomListView, 4)



    -- 姓名分列表
    nameColListView:setContentSize(100, 300)
    nameColListView:setPosition(150, 160)
    nameColListView:setDirection(1)
    for i = 1, 5 do
        nameColListView:pushBackCustomItem(ccui.Text:create(list[i]['name'], "FontNormal.ttf", 18))
    end

    -- 设置高度间隔
    nameColListView:setItemsMargin(41)

    self:addChild(nameColListView, 4)

    -- 得分分列表
    scoreColListView:setContentSize(100, 300)
    scoreColListView:setPosition(230, 160)
    scoreColListView:setDirection(1)
    for i = 1, 5 do
        scoreColListView:pushBackCustomItem(ccui.Text:create(list[i]['score'], "FontNormal.ttf",18))
    end

    -- 设置高度间隔
    scoreColListView:setItemsMargin(41)

    self:addChild(scoreColListView, 4)


end

function Rank:onEnter()
end

function Rank:onExit()
end

return Rank