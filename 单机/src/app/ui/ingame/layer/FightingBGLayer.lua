--[[--
    背景层
    FightingBGLayer.lua
]]
local FightingBGLayer = class("FightingBGLayer", require("app.ui.ingame.layer.BaseLayer"))

--[[--
    构造函数

    @param none

    @return none
]]
function FightingBGLayer:ctor()
    FightingBGLayer.super.ctor(self)
    self.bgScaleFactorHeight_ = 1 -- 类型：number，背景高度缩放系数
    self.bgScaleFactorWeight_ = 1 -- 类型：number，背景宽度缩放系数

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function FightingBGLayer:initView()
    -- 背景图底图上960 * 1480
    -- 背景图底图下960 * 1480
    -- 设计尺寸 720 * 1280
    self.bgScaleFactorHeight_ = 1280/1480
    self.bgScaleFactorWeight_ = 720/960

    local bgSprite1 = display.newSprite("artcontent/battle_ongame/battle_interface/basemap_bottom.png")
    bgSprite1:setAnchorPoint(0.5,0.5)
    bgSprite1:pos(display.cx, display.cy)
    bgSprite1:setScale(1, self.bgScaleFactorHeight_)
    --bgSprite1:setScale(self.bgScaleFactorWeight_, 1)
    self:addChild(bgSprite1)

    local bgSprite2 = display.newSprite("artcontent/battle_ongame/battle_interface/basemap_top.png")
    bgSprite2:setAnchorPoint(0.5,0.5)
    bgSprite2:pos(display.cx, display.cy)
    bgSprite2:setScale(1, self.bgScaleFactorHeight_)
    --bgSprite2:setScale(self.bgScaleFactorWeight_, 1)
    self:addChild(bgSprite2)
end

return FightingBGLayer