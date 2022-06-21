--[[--
    信息层(展示得分与等级)
    InfoLayer.lua
]]
local InfoLayer = class("InfoLayer", require("app.ui.layer.BaseLayer"))
local ConstDef = require("app.def.ConstDef")

--[[--
    构造函数

    @param none

    @return none
]]
function InfoLayer:ctor(gameData)

    InfoLayer.super.ctor(self)

    self.scoreLabelTTF_ = nil -- 类型：TextTTFFont，分值
    self.levelLabelTTF_ = nil -- 类型：TextTTFFont，等级

    self.gameData_ = gameData

    self:initView()
end

--[[--
    界面初始化
    
    @param none

    @return none
]]
function InfoLayer:initView()

    -- 容器
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize( -- 设置信息面板的大小
            cc.p(ConstDef.GRID_SIZE * ConstDef.INFO_BOARD_WIDTH,
            ConstDef.GRID_SIZE * ConstDef.INFO_BOARD_HEIGHT))

    self.container_:addTo(self)
    self.container_:setAnchorPoint(1, 1)
    self.container_:setPosition(display.width - 100, display.height - 50) -- 相对定位

    -- 得分
    local scoreLabel = display.newTTFLabel({
        text = "分数",
        font = "Marker Felt",
        size = 35,
        color = cc.c3b(255, 255, 255)
    })
    scoreLabel:setAnchorPoint(0.5, 0.5)
    self.container_:addChild(scoreLabel)

    self.scoreLabelTTF_ = display.newTTFLabel({
        text = tostring(self.gameData_:getScore()),
        font = "Marker Felt",
        size = 30,
        color = cc.c3b(255, 255, 255)
    })
    self.scoreLabelTTF_:setAnchorPoint(0.5, 0.5)
    self.scoreLabelTTF_:setPosition(cc.p(scoreLabel:getPositionX(), scoreLabel:getPositionY() - 50))
    self.scoreLabelTTF_:setVisible(true)
    self.container_:addChild(self.scoreLabelTTF_)


    -- 等级
    local levelLabel = display.newTTFLabel({
        text = "等级",
        font = "Marker Felt",
        size = 35,
        color = cc.c3b(255, 255, 255)
    })
    levelLabel:setAnchorPoint(0.5, 0.5)
    levelLabel:setPosition(cc.p(scoreLabel:getPositionX(), scoreLabel:getPositionY() - 100))
    levelLabel:setVisible(true)
    self.container_:addChild(levelLabel)

    self.levelLabelTTF_ = display.newTTFLabel({
        text = self.gameData_:getLevel(),
        font = "Marker Felt",
        size = 30,
        color = cc.c3b(255, 255, 255)
    })
    self.levelLabelTTF_:setAnchorPoint(0.5, 0.5)
    self.levelLabelTTF_:setPosition(cc.p(scoreLabel:getPositionX(), scoreLabel:getPositionY() - 150))
    self.levelLabelTTF_:setVisible(true)
    self.container_:addChild(self.levelLabelTTF_)

end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function InfoLayer:update(dt)
    self.scoreLabelTTF_:setString(tostring(self.gameData_:getScore()))
    self.levelLabelTTF_:setString(tostring(self.gameData_:getLevel()))
end

return InfoLayer

