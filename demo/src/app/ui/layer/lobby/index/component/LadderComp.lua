--[[
    LadderComp.lua
    天梯奖励展示组件
    描述：主页内天梯奖励展示栏
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local LadderComp = class("LadderComp", require("app.ui.layer.BaseLayer"))
local LadderAwardDef = require("app.def.LadderAwardDef")
local ConstDef = require("app.def.ConstDef")
local LadderItemComp = require("app.ui.layer.lobby.index.component.component.LadderItemComp")

--[[--
    构造函数

    @param none

    @return none
]]
function LadderComp:ctor()
    LadderComp.super.ctor(self)

    self.container_ = nil

    self:initParam()
    self:initView()
end

--[[--
    参数初始化

    @param none

    @return none
]]
function LadderComp:initParam()
    self.award_ = LadderAwardDef
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
        local item = LadderItemComp.new(i, self.award_[i], i)
        item:setContentSize(width, height)
        self.ladderListView_:pushBackCustomItem(item)
    end
    self.container_:addChild(self.ladderListView_)
end


return LadderComp