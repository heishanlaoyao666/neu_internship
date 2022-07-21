--[[
    CurrentTeamComp.lua
    当前阵容组件
    描述：当前阵容组件
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local CurrentTeamComp = class("CurrentTeamComp", require("app.ui.layer.BaseUILayout"))
local ConstDef = require("app.def.ConstDef")
local PlayerData = require("app.data.PlayerData")
local TeamComp = require("app.ui.layer.lobby.pictorial.component.component.TeamComp")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")

--[[--
    构造函数

    @param bg 类型：String，卡片背景图片地址
    @param type 类型：number，卡片类型

    @return none
]]
function CurrentTeamComp:ctor(bg, type)
    CurrentTeamComp.super.ctor(self)

    self.container_ = nil -- 全局容器

    self.team_1_ = nil
    self.team_2_ = nil
    self.team_3_ = nil

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function CurrentTeamComp:initView()

    -- 当前阵容框大小
    local width, height = ConstDef.WINDOW_SIZE.CURRENT_TEAM_VIEW.WIDTH,
            ConstDef.WINDOW_SIZE.CURRENT_TEAM_VIEW.HEIGHT

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(width, height)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, 0.75 * display.size.height)
    self:addChild(self.container_)

    local areaBG = ccui.ImageView:create("image/lobby/pictorial/currentteam/area_bg.png")
    areaBG:setAnchorPoint(0, 0)
    self.container_:addChild(areaBG)

    local titleBG = ccui.ImageView:create("image/lobby/pictorial/currentteam/title_bg.png")
    titleBG:setAnchorPoint(0.5, 0.5)

    -- 标头大小
    local titleWidth, titleHeight = titleBG:getContentSize().width, titleBG:getContentSize().height

    titleBG:setPosition(0.5*width, height-titleHeight/2)
    self.container_:addChild(titleBG)

    local titleText = ccui.ImageView:create("image/lobby/pictorial/currentteam/current_team_text.png")
    titleText:setAnchorPoint(0.5, 0.5)
    titleText:setPosition(width/3, height-titleHeight/2)
    self.container_:addChild(titleText)


    -- 按钮组件
    local buttonContainer = ccui.Layout:create()
    buttonContainer:setContentSize(titleWidth/3, titleHeight)

    -- 按钮容器大小
    local btnContainerWidth, btnContainerHeight = titleWidth/3, titleHeight
    buttonContainer:setAnchorPoint(0.5, 0.5)
    buttonContainer:setPosition(2*width/3, height-titleHeight/2)
    self.container_:addChild(buttonContainer)

    local lineBG = ccui.ImageView:create("image/lobby/pictorial/currentteam/line_bg.png")
    lineBG:setAnchorPoint(0.5, 0.5)
    lineBG:setPosition(btnContainerWidth /2, btnContainerHeight /2)
    buttonContainer:addChild(lineBG)

    -- 按钮1
    local btnOne = ccui.Layout:create()
    btnOne:setBackGroundImage("image/lobby/pictorial/currentteam/unselected_icon.png")
    local btnWidth, btnHeight = btnOne:getBackGroundImageTextureSize().width, btnOne:getBackGroundImageTextureSize().height
    btnOne:setContentSize(btnWidth, btnHeight)
    btnOne:setAnchorPoint(0.5, 0.5)
    btnOne:setPosition(3*btnContainerWidth/16, btnContainerHeight/2)
    buttonContainer:addChild(btnOne)

    local btnOneBG = ccui.ImageView:create("image/lobby/pictorial/currentteam/selected_icon.png")
    btnOneBG:setPosition(btnWidth/2, btnHeight/2)
    btnOne:addChild(btnOneBG)
    btnOneBG:setVisible(true)

    local btnOneText = ccui.ImageView:create("image/lobby/pictorial/currentteam/number_1.png")
    btnOneText:setAnchorPoint(0.5, 0.5)
    btnOneText:setPosition(btnWidth/2, btnHeight/2)
    btnOne:addChild(btnOneText)

    -- 按钮2
    local btnTwo = ccui.Layout:create()
    btnTwo:setBackGroundImage("image/lobby/pictorial/currentteam/unselected_icon.png")
    btnTwo:setContentSize(btnWidth, btnHeight)
    btnTwo:setAnchorPoint(0.5, 0.5)
    btnTwo:setPosition(btnContainerWidth/2, btnContainerHeight/2)
    buttonContainer:addChild(btnTwo)

    local btnTwoBG = ccui.ImageView:create("image/lobby/pictorial/currentteam/selected_icon.png")
    btnTwoBG:setPosition(btnWidth/2, btnHeight/2)
    btnTwo:addChild(btnTwoBG)
    btnTwoBG:setVisible(false)

    local btnTwoText = ccui.ImageView:create("image/lobby/pictorial/currentteam/number_2.png")
    btnTwoText:setAnchorPoint(0.5, 0.5)
    btnTwoText:setPosition(btnWidth/2, btnHeight/2)
    btnTwo:addChild(btnTwoText)

    -- 按钮3
    local btnThree = ccui.Layout:create()
    btnThree:setBackGroundImage("image/lobby/pictorial/currentteam/unselected_icon.png")
    btnThree:setContentSize(btnWidth, btnHeight)
    btnThree:setAnchorPoint(0.5, 0.5)
    btnThree:setPosition(13*btnContainerWidth/16, btnContainerHeight/2)
    buttonContainer:addChild(btnThree)

    local btnThreeBG = ccui.ImageView:create("image/lobby/pictorial/currentteam/selected_icon.png")
    btnThreeBG:setPosition(btnWidth/2, btnHeight/2)
    btnThree:addChild(btnThreeBG)
    btnThreeBG:setVisible(false)

    local btnThreeText = ccui.ImageView:create("image/lobby/pictorial/currentteam/number_3.png")
    btnThreeText:setAnchorPoint(0.5, 0.5)
    btnThreeText:setPosition(btnWidth/2, btnHeight/2)
    btnThree:addChild(btnThreeText)

    -- 绑定事件
    btnOne:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            PlayerData:setFightCardGroupIndex(1)
            btnOneBG:setVisible(true)
            btnTwoBG:setVisible(false)
            btnThreeBG:setVisible(false)

            self.team_1_:setVisible(true)
            self.team_2_:setVisible(false)
            self.team_3_:setVisible(false)
            EventManager:doEvent(EventDef.ID.CARD_GROUP_SWITCH)
        end
    end)
    btnOne:setTouchEnabled(true)

    btnTwo:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            PlayerData:setFightCardGroupIndex(2)
            btnOneBG:setVisible(false)
            btnTwoBG:setVisible(true)
            btnThreeBG:setVisible(false)

            self.team_1_:setVisible(false)
            self.team_2_:setVisible(true)
            self.team_3_:setVisible(false)
            EventManager:doEvent(EventDef.ID.CARD_GROUP_SWITCH)
        end
    end)
    btnTwo:setTouchEnabled(true)

    btnThree:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            PlayerData:setFightCardGroupIndex(3)
            btnOneBG:setVisible(false)
            btnTwoBG:setVisible(false)
            btnThreeBG:setVisible(true)

            self.team_1_:setVisible(false)
            self.team_2_:setVisible(false)
            self.team_3_:setVisible(true)
            EventManager:doEvent(EventDef.ID.CARD_GROUP_SWITCH)
        end
    end)
    btnThree:setTouchEnabled(true)

    width, height = ConstDef.WINDOW_SIZE.CURRENT_TEAM_VIEW.WIDTH,
    ConstDef.WINDOW_SIZE.CURRENT_TEAM_VIEW.HEIGHT


    -- 队伍列表组件
    self.team_1_ = TeamComp.new(1)
    self.team_1_:setScale(0.92)
    self.team_1_:setPosition(0, -0.5*height)
    self.container_:addChild(self.team_1_)
    self.team_1_:setVisible(true) -- 默认显示阵容1

    self.team_2_ = TeamComp.new(2)
    self.team_2_:setScale(0.92)
    self.team_2_:setPosition(0, -0.5*height)
    self.container_:addChild(self.team_2_)
    self.team_2_:setVisible(false)

    self.team_3_ = TeamComp.new(3)
    self.team_3_:setScale(0.92)
    self.team_3_:setPosition(0, -0.5*height)
    self.container_:addChild(self.team_3_)
    self.team_3_:setVisible(false)

end

return CurrentTeamComp