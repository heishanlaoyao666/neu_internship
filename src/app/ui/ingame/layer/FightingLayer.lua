--[[--
    战斗层
    FightingLayer.lua
]]
local FightingLayer = class("FightingLayer", require("app.ui.ingame.layer.BaseLayer"))

local OutGameData = require("app.data.outgame.OutGameData")
local Tower = require("app.data.outgame.Tower")
local FightTower = require("app.data.ingame.FightTower")
local EventManager = require("app.manager.EventManager")

function FightingLayer:ctor()
    FightingLayer.super.ctor(self)

    self.bulletMap_ = {}
    self.towerMap_ = {}
    self.enemyMap = {}
    self.bossMap_ = {}
    self.lineup_ = {} -- 我的阵容
    self.enhanceNeedSp_ = {}

    self:init()
    self:initView()
end
--[[--
    用于制作测试数据

    @parm none

    @return none
]]
function FightingLayer:init()
    local tower_1 = Tower.new(1, 1, 1, "tower_1", "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
    "前方", 20, 3, 10, 0.8, 0.01, "额外伤害",4,20, 3, 20, nil,nil,nil)
    local tower_2 = Tower.new(2, 3, 1, "tower_2", "使星级数个怪物受到伤害。",
    "前方", 20, 5, 10, 0.8, nil, "额外伤害",4,50, 4, 40, nil,nil,nil)
    local tower_3 = Tower.new(3, 2, 1, "tower_3","使星级数个怪物受到伤害。",
    "前方", 40, 8, 20, 0.8, 0.01, "额外伤害",4 ,120, 24, 40, nil,nil, nil)
    local tower_4 = Tower.new(4, 1, 1, "tower_4","攻击生命值最高的怪物,对BOSS造成双倍伤害。",
    "最大血量", 100, 10, 100, 1, nil, nil,nil, nil, nil, nil, nil,nil, nil)
    local tower_5 = Tower.new(5, 4, 1, "tower_5","每隔一段时间可以在三个形态之间切换，二形态攻速大幅度加强，三形态攻击必定暴击。",
    "前方", 20, 3, 30, 0.6, nil, "初次变身时间", 3,6, nil, nil, "二次变身时间",5,4)

    local fightTower_1 = FightTower.new(tower_1)
    local fightTower_2 = FightTower.new(tower_2)
    local fightTower_3 = FightTower.new(tower_3)
    local fightTower_4 = FightTower.new(tower_4)
    local fightTower_5 = FightTower.new(tower_5)
    self.lineup_ = {fightTower_1, fightTower_2, fightTower_3, fightTower_4, fightTower_5}
end

function FightingLayer:initView()
    --角标映射
    local angelMark = {
        "artcontent/battle(ongame)/battle_interface/angelmark_towertype/towertype_tapping.png",
        "artcontent/battle(ongame)/battle_interface/angelmark_towertype/towertype_disturbance.png",
        "artcontent/battle(ongame)/battle_interface/angelmark_towertype/towertype_sup.png",
        "artcontent/battle(ongame)/battle_interface/angelmark_towertype/towertype_control.png"
    }

    --self.lineup_ = OutGameData:getMyLineup()
    local index_x = 120
    for i = 1, #self.lineup_ do
        --头像
        local towerBtn = ccui.Button:create(
            string.format("artcontent/battle(ongame)/battle_interface/tower/tower_%d.png",
            self.lineup_[i]:getTower():getTowerId()))
        towerBtn:setPosition(index_x, 120)
        towerBtn:addTouchEventListener(function(sender, eventType)
            if eventType == 2 then
                print(self.lineup_[i]:getTowerId())
            end
        end)
        towerBtn:addTo(self)

        --等级
        local levelSprite = cc.Sprite:create(
            string.format("artcontent/battle(ongame)/battle_interface/grade/LV.%d.png",
             self.lineup_[i]:getTower():getLevel()))
        levelSprite:setPosition(index_x, 50)
        levelSprite:addTo(self)

        --强化sp底图
        local spSprite = cc.Sprite:create("artcontent/battle(ongame)/battle_interface/basemap_sp.png")
        spSprite:setPosition(index_x, 80)
        spSprite:setScale(0.8)
        spSprite:addTo(self)

        --强化所需sp
        local needSpText = ccui.Text:create("100", "artcontent/font/fzbiaozjw.ttf", 20)
        needSpText:setPosition(index_x, 80)
        needSpText:setAnchorPoint(0.2, 0.5)
        needSpText:addTo(self)
        table.insert(self.enhanceNeedSp_, i, needSpText)

        --塔类型角标
        local angelMarkSprite = cc.Sprite:create(angelMark[self.lineup_[i]:getTower():getTowerType()])
        angelMarkSprite:setPosition(index_x + 30, 147)
        angelMarkSprite:addTo(self)
        index_x = index_x + 120
    end


end

return FightingLayer