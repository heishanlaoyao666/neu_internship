--[[
    信息层
    InfoLayer.lua
    描述：信息层
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local ConstDef = require("app.def.ConstDef")
local InfoLayer = class("InfoLayer", require("app.ui.layer.BaseLayer"))

--[[--
    构造函数

    @param none

    @return none
]]
function InfoLayer:ctor()
    InfoLayer.super.ctor(self)

    self.container_ = nil -- 容器

    self.goldLabelTtf_ = nil -- 金币
    self.diamondLabelTtf_ = nil -- 钻石
    self.nicknameLabelTtf_ = nil -- 昵称
    self.trophyLabelTtf_ = nil -- 奖杯

    self.goldText_ = 1000
    self.diamondText_ = 1000
    self.nicknameText_ = "Harry"
    self.trophyText_ = 100

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function InfoLayer:initView()
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(ConstDef.WINDOW_SIZE.TOPBAR.WIDTH,
            ConstDef.WINDOW_SIZE.TOPBAR.HEIGHT) -- 设置为顶部栏大小
    self.container_:setAnchorPoint(0, 1)
    self.container_:setPosition(0, display.size.height)
    self:addChild(self.container_)

    -- 金币
    self.goldLabelTtf_ = display.newTTFLabel({
        text = self.goldText_,
        font = "font/fzbiaozjw.ttf",
        size = 26,
        color = cc.c3b(255, 255, 255)
    })

    self.goldLabelTtf_:setAnchorPoint(1, 0)
    self.goldLabelTtf_:setPosition( 600, 85)
    self.container_:addChild(self.goldLabelTtf_)

    -- 钻石
    self.diamondLabelTtf_ = display.newTTFLabel({
        text = self.diamondText_,
        font = "font/fzbiaozjw.ttf",
        size = 26,
        color = cc.c3b(255, 255, 255),
    })

    self.diamondLabelTtf_:setAnchorPoint(1, 0)
    self.diamondLabelTtf_:setPosition( 600, 35)
    self.container_:addChild(self.diamondLabelTtf_)

    -- 昵称
    self.nicknameLabelTtf_ = display.newTTFLabel({
        text = self.nicknameText_,
        font = "font/fzzchjw.ttf",
        size = 20,
        color = cc.c3b(255, 255, 255)
    })

    self.nicknameLabelTtf_:setAnchorPoint(0, 0)
    self.nicknameLabelTtf_:setPosition( 180, 85)
    self.container_:addChild(self.nicknameLabelTtf_)

    -- 奖杯
    self.trophyLabelTtf_ = display.newTTFLabel({
        text = self.trophyText_,
        font = "font/fzbiaozjw.ttf",
        size = 24,
        color = cc.c3b(255, 206, 55)
    })

    self.trophyLabelTtf_:setAnchorPoint(0, 0)
    self.trophyLabelTtf_:setPosition( 200, 40)
    self.container_:addChild(self.trophyLabelTtf_)

end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function InfoLayer:update(dt)
end

return InfoLayer

