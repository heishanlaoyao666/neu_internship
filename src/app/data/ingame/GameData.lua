--[[--
    GameData.lua
    游戏战斗战斗数据
]]

local GameData = {}

--local OutGameData = require("app.data.outgame.OutGameData.lua")
local Tower = require("app.data.outgame.Tower")
local FightTower = require("app.data.ingame.FightTower")

local myTowers_ = {} -- 我阵容的塔
local enemyTowers_ = {} -- 敌方阵容的塔
local indexTable_ = {} -- 塔的位置
local indexs_ = {} -- 塔有可能生成的下标

local towers_ = {} -- 塔数组


function GameData:init()
    self.myPoint_ = 3 -- 我的血量
    self.enemypoint_ = 3 -- 敌人的血量
    self.sumSp_ = 2000 -- 总的sp
    self.needSp_ = 10 -- 生成塔需要的sp

    indexTable_ = {{160, 528}, {260, 528}, {359, 528}, {458, 528}, {556, 528},
                   {160, 431}, {260, 431}, {359, 431}, {458, 431}, {556, 431},
                   {160, 338}, {260, 338}, {359, 338}, {458, 338}, {556, 338}}
    indexs_ = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ,12 , 13, 14, 15}

end

--[[--
    获取我的血量

    @parm none

    @return self.myPoint_, 类型：number
]]
function GameData:getMyPoint()
    return self.myPoint_
end

--[[--
    获取敌人的血量

    @parm none

    @return self.enemypoint_, 类型：number
]]
function GameData:getEnemyPoint()
    return self.enemypoint_
end

--[[--
    获取总的sp数

    @parm none

    @return self.sumSp_, 类型：number
]]
function GameData:getSumSp()
    return self.sumSp_
end

--[[--
    增加总的sp数

    @parm n, 类型：number

    @return none
]]
function GameData:addSumSp(n)
    self.sumSp_ = self.sumSp_ + n
end

--[[--
    获取生成塔需要的sp

    @parm none

    @return self.needSp_, 类型：number
]]
function GameData:getNeedSp()
    return self.needSp_
end

--[[--
    随机生成塔

    @parm none

    @return none
]]
function GameData:generateTower()
    if self.sumSp_ > self.needSp_ then
        self.sumSp_ = self.sumSp_ - self.needSp_
        self.needSp_ = self.needSp_ + 10
    end
end

--[[--
    获取我方塔的阵容

    @parm none

    @return myTowers_, 类型：table
]]
function GameData:getMyTowers()
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

    myTowers_ = {tower_1, tower_2, tower_3, tower_4, tower_5}
    return myTowers_
end

--[[--
    获取敌方塔的阵容

    @parm none

    @return 类型：table
]]
function GameData:getEnemyTowers()
    return enemyTowers_
end

--[[--
    获取塔数组

    @parm none

    @return 类型：table
]]
function GameData:getTowers()
    return towers_
end

--[[--
    随机生成塔

    @parm none

    @return none
]]
function GameData:creatTower()
    if #indexs_ ~= 0 and self.sumSp_ >= self.needSp_ then
        math.randomseed(os.time())
        local indexTower = math.random(1, 5)
        local tower = myTowers_[indexTower]
        local index = math.random(1, #indexs_)
        local fightTower = FightTower.new(tower, indexTable_, indexs_[index])
        table.remove(indexs_, index)
        towers_[#towers_ + 1] = fightTower
        self.sumSp_ = self.sumSp_ - self.needSp_
        self.needSp_ = self.needSp_ + 10
    end
end

--[[--
    获取该位置的塔

    @parm x 类型：number
    @parm y 类型：number

    @return FightingTower
]]
function GameData:getFightingTowerByIndex(x, y, tower)
    for key, value in pairs(towers_) do
        if self:isValidTouch(value, x, y) then
            if value ~= tower then
                return towers_[key]
            end
        end
    end
    return nil
end

--[[--
    位置是否在我方塔有效范围（判定能否点击）

    @parm x 类型：number
    @parm y 类型：number

    @return boolean
]]
function GameData:isValidTouch(tower, x, y)
    return tower:isContain(x, y)
end

--[[--
    移动我方塔

    @parm x 类型：number
    @parm y 类型：number
    @parm tower 类型：object

    @return none
]]
function GameData:moveTo(x, y, tower)
    if x > display.right or x < display.left or y > display.top or y < display.bottom then
        local index = GameData:getTowerIndex(tower)
        local index_x, index_y = index[1], index[2]
        x, y = index_x, index_y
    end
        tower:setX(x)
        tower:setY(y)
end

--[[--
    融合塔

    @parm tower1 类型：FightingTower
    @parm tower2 类型：FightingTower

    @return none
]]
function GameData:mergingFightingTower(toewr1, tower2)
end

--[[--
    获取塔原来的位置

    @parm tower 类型：fightingTower

    @return table
]]
function GameData:getTowerIndex(tower)
    return indexTable_[tower:getIndex()]
end

return GameData