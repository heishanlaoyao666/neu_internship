--[[--
    背景层
    AnimLayer.lua
    编写：李昊
]]
local AnimLayer = class("AnimLayer", require("app.ui.layer.BaseLayer"))
local EventManager = require("app.manager.EventManager")
local EventDef = require("src.app.def.EventDef")
local GameData = require("src.app.data.GameData")
local MsgDef = require("src.app.def.MsgDef")

--[[--
    构造函数

    @param none

    @return none
]]
function AnimLayer:ctor()
    self.towerOnDrag_ = nil
    EventManager:regListener(EventDef.ID.CARD_BEGAN_DRAG, self, function(cardSprite)
        -- 开始拖拽，在本层新建一个和cardSprite贴图，大小均一样的精灵
        self.towerOnDrag_ = display.newSprite("image/tower/sprite/small/color/tower_2.png")
        self.towerOnDrag_:setTexture(cardSprite:getTexture())
        self.towerOnDrag_:setPosition(cardSprite:getPosition())
        self.towerOnDrag_:setScale(0.85)
        self:addChild(self.towerOnDrag_)
    end)

    EventManager:regListener(EventDef.ID.CARD_MOVED_DRAG, self, function(cardSprite)
        -- 拖拽中，位置和cardSprite保持一致
        self.towerOnDrag_:setPosition(cardSprite:getPosition())
    end)

    EventManager:regListener(EventDef.ID.CARD_ENDED_DRAG, self, function(cardSprite)
        -- 拖拽结束后，销毁这个在上层的精灵
        cardSprite:getPosition()
        local msg = {}
        local data = {}
        data["size"] = "COMPOUND_CARD"
        data["pos1"] = {cardSprite:getPosition()}
        data["pos2"] = cardSprite:getCardPos()
        msg["data"] = data
        GameData:send(MsgDef.REQ_TYPE.UPGRADE_TOWER,msg)
        self.towerOnDrag_:removeFromParent()
    end)
end

--[[--
    界面初始化
    
    @param none

    @return none
]]
function AnimLayer:initView()

end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔

    @return none
]]
function AnimLayer:update(dt)
end

return AnimLayer