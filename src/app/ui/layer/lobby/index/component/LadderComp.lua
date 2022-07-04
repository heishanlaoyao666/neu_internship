--[[
    LadderComp.lua
    天梯奖励展示组件
    描述：主页内天梯奖励展示栏
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local LadderComp = class("LadderComp", require("app.ui.layer.BaseLayer"))
local PlayerData = require("app.data.PlayerData")
local LadderAwardDef = require("app.def.LadderAwardDef")
local ConstDef = require("app.def.ConstDef")
local DialogManager = require("app.manager.DialogManager")
local BoxOpenConfirmDialog = require("app.ui.layer.lobby.store.dialog.BoxOpenConfirmDialog")

--[[--
    构造函数

    @param none

    @return none
]]
function LadderComp:ctor()
    LadderComp.super.ctor(self)

    self.container_ = nil

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function LadderComp:initView()
    self.container_ = ccui.Layout:create()
    self.container_:setBackGroundImage("image/lobby/index/ladder/ladder_bg.png")
    self.container_:setContentSize(ConstDef.WINDOW_SIZE.LADDER_VIEW.WIDTH,
            ConstDef.WINDOW_SIZE.LADDER_VIEW.HEIGHT)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, 0.75 * display.size.height)
    self:addChild(self.container_)

    -- 左划
    self.leftSlideBtn_ = ccui.Button:create("image/lobby/index/ladder/slide_left_icon.png")
    self.leftSlideBtn_:setAnchorPoint(0, 0.5)
    self.leftSlideBtn_:setPosition(0,
            2*self.container_:getContentSize().height/3)
    self.container_:addChild(self.leftSlideBtn_)

    -- 右划
    self.rightSlideBtn_ = ccui.Button:create("image/lobby/index/ladder/slide_right_icon.png")
    self.rightSlideBtn_:setAnchorPoint(1, 0.5)
    self.rightSlideBtn_:setPosition(self.container_:getContentSize().width,
            2*self.container_:getContentSize().height/3)
    self.container_:addChild(self.rightSlideBtn_)

    -- 天梯奖励展示区内容 - ListView
    self.ladderListView_ = ccui.ListView:create()
    self.ladderListView_:setContentSize(ConstDef.WINDOW_SIZE.LADDER_VIEW.WIDTH * 0.9,
            ConstDef.WINDOW_SIZE.LADDER_VIEW.HEIGHT)
    self.ladderListView_:setPosition(ConstDef.WINDOW_SIZE.LADDER_VIEW.WIDTH * 0.5,
            ConstDef.WINDOW_SIZE.LADDER_VIEW.HEIGHT * 0.5)
    self.ladderListView_:setAnchorPoint(0.5, 0.5)
    self.ladderListView_:setDirection(2)

    -- 0 - 500
    for i = 1, 10 do
        local width, height = 0.9 * ConstDef.WINDOW_SIZE.LADDER_VIEW.WIDTH / 3, ConstDef.WINDOW_SIZE.LADDER_VIEW.HEIGHT
        local itemLayer = ccui.Layout:create()
        itemLayer:setContentSize(width, height)

        local type = LadderAwardDef[i].TYPE

        -- 蓝色进度条背景
        local lineBG = ccui.ImageView:create("image/lobby/index/ladder/scale/blue_line.png")
        lineBG:setScale(1/3, 1)
        lineBG:setPosition(0.5 * width, 0.2 * height)
        itemLayer:addChild(lineBG)

        local edgeBG = ccui.ImageView:create("image/lobby/index/ladder/scale/blue_edge.png")
        edgeBG:setScale(1)
        edgeBG:setPosition(0.5 * width, 0.2 * height)
        itemLayer:addChild(edgeBG)

        -- 黄色进度条前景
        local lineFG = ccui.ImageView:create("image/lobby/index/ladder/scale/yellow_line.png")
        local scale = (PlayerData:getIntegral()-50*(i-1))/50
        scale = scale >= 0 and scale or 0
        scale = scale <=1 and scale or 1
        lineFG:setScale(scale , 1)
        lineFG:setAnchorPoint(0, 0.5)
        lineFG:setPosition(0, 0.2 * height)
        itemLayer:addChild(lineFG)

        -- 文字
        local point = 25+50*(i-1)
        local progressText = ccui.Text:create(point, "font/fzbiaozjw.ttf", 20)
        progressText:setTextColor(cc.c4b(165, 237, 255, 255))
        progressText:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 描边
        progressText:setPosition(0.5 * width, 0.1 * height)
        itemLayer:addChild(progressText)


        -- 卡片背景

        local ifGot = PlayerData:getIfGot(i)
        local ifUnlocked = PlayerData:getIntegral()-point >= 0 and true or false
        local bg = nil
        local icon = nil

        if ifGot and ifUnlocked then -- 已解锁并且已获得
            bg = "image/lobby/index/ladder/got_border.png"
            icon = "image/lobby/index/ladder/got_icon.png"
        elseif ifUnlocked then -- 已解锁但是未获得
            bg = "image/lobby/index/ladder/unlocked_border.png"
            icon = nil
        else -- 未解锁
            bg = "image/lobby/index/ladder/locked_border.png"
            icon = "image/lobby/index/ladder/locked_icon.png"
        end

        local cardBG = ccui.Layout:create()
        cardBG:setBackGroundImage(bg)
        local cardBGWidth, cardBGHeight = cardBG:getBackGroundImageTextureSize().width,
                cardBG:getBackGroundImageTextureSize().height
        cardBG:setContentSize(cardBGWidth, cardBGHeight)
        cardBG:setAnchorPoint(0.5, 0.5)
        cardBG:setPosition(0.5 * width, 0.6 * height)
        itemLayer:addChild(cardBG)

        local cardIcon = ccui.ImageView:create(icon)
        cardIcon:setAnchorPoint(0.5, 0.5)
        cardIcon:setPosition(0.5*cardBGWidth, 0)
        cardBG:addChild(cardIcon)

        -- 奖励
        if type == 1 then -- 宝箱
            local spriteBtn = ccui.ImageView:create(LadderAwardDef[i].ICON)
            spriteBtn:setScale(0.75)
            spriteBtn:setAnchorPoint(0.5, 0.5)
            spriteBtn:setPosition(0.5 * cardBGWidth, 0.5 * cardBGHeight)
            cardBG:addChild(spriteBtn)
        elseif type == 2 then -- 资源
            local spriteBtn = ccui.ImageView:create(LadderAwardDef[i].ICON)
            spriteBtn:setScale(1)
            spriteBtn:setPosition(0.5 * cardBGWidth, 0.6 * cardBGHeight)
            cardBG:addChild(spriteBtn)
            local spriteText = ccui.Text:create(LadderAwardDef[i].TEXT, "font/fzbiaozjw.ttf", 30)
            spriteText:setPosition(0.5 * cardBGWidth, 0.3 * cardBGHeight)
            cardBG:addChild(spriteText)

        elseif type == 3 then -- 卡牌
            local spriteBtn = ccui.ImageView:create(LadderAwardDef[i].ICON)
            spriteBtn:setScale(1.2)
            spriteBtn:setPosition(0.5 * cardBGWidth, 0.5 * cardBGHeight)
            cardBG:addChild(spriteBtn)
        end

        cardBG:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)

            if event.name == "began" then
                -- 放大事件
                local ac1 = cc.ScaleTo:create(0.1, 1.1)
                local ac2 = cc.ScaleTo:create(0.1, 1)
                local action = cc.Sequence:create(ac1, ac2)
                cardBG:runAction(action)
                return true
            else
                if type == 1 and ifUnlocked then -- 宝箱
                    local dialog = BoxOpenConfirmDialog.new(20, "image/lobby/store/diamond/legend_box.png", 100,100,10,10)
                    DialogManager:showDialog(dialog)
                elseif type == 2 and ifUnlocked then -- 资源
                    cardBG:setBackGroundImage("image/lobby/index/ladder/got_border.png")
                else -- 卡牌
                    cardBG:setBackGroundImage("image/lobby/index/ladder/got_border.png")
                end
                return true
            end

        end)
        cardBG:setTouchEnabled(true)



        -- 钥匙
        if i == 1 then
            local key = ccui.ImageView:create("image/lobby/index/ladder/scale/key_icon.png")
            key:setScale(1)
            key:setPosition(0.05 * width, 0.22 * height)
            itemLayer:addChild(key)
        end


        self.ladderListView_:pushBackCustomItem(itemLayer)
    end
    self.container_:addChild(self.ladderListView_)


end

return LadderComp