--[[
    BoxObtainCardComp.lua
    宝箱开启后获得卡片组件
    描述：宝箱开启后获得卡片组件
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local BoxObtainCardComp = class("BoxObtainCardComp", require("app.ui.layer.BaseUILayout"))
local ConstDef = require("app.def.ConstDef")

--[[--
    构造函数

    @param card 类型：card，卡片
    @param pieceNum 类型：number，卡片碎片数量

    @return none
]]
function BoxObtainCardComp:ctor(card, pieceNum)
    BoxObtainCardComp.super.ctor(self)

    self.container_ = nil -- 全局容器
    self.card_ = card -- 卡片
    self.pieceNum_ = pieceNum

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function BoxObtainCardComp:initView()

    local width, height = 1.2*ConstDef.CARD_SIZE.TYPE_1.WIDTH,
            1.25*ConstDef.CARD_SIZE.TYPE_1.HEIGHT

    -- Card组件
    self.container_ = ccui.Layout:create()
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setContentSize(width, height)
    self:addChild(self.container_)

    -- 卡牌精灵
    local cardSprite = ccui.ImageView:create(self.card_:getSmallColorSpriteImg())
    cardSprite:setAnchorPoint(0.5, 0.5)
    cardSprite:setPosition(0.5*width, 0.6*height)
    self.container_:addChild(cardSprite)

    -- 碎片数量
    local pieceNum = string.format("x%d", self.pieceNum_)
    local pieceNumText = ccui.Text:create(pieceNum, "font/fzzchjw.ttf", 21)
    pieceNumText:setTextColor(cc.c4b(255, 255, 255, 255))
    pieceNumText:enableOutline(cc.c4b(0, 0, 0, 255), 1) -- 描边
    pieceNumText:setAnchorPoint(0.5, 0.5)
    pieceNumText:setPosition(0.8*width, 0.9*height)
    self.container_:addChild(pieceNumText)


    -- 卡牌稀有度
    local rareTitle = ccui.ImageView:create(self.card_:getRarityTextImg())
    rareTitle:setAnchorPoint(0.5, 0.5)
    rareTitle:setPosition(0.5*width, 0.1*height)
    self.container_:addChild(rareTitle)

end

return BoxObtainCardComp