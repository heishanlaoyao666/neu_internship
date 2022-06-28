--[[--
    GameData.lua
    游戏战斗战斗数据
]]

local GameData = {}


local myTower = {} -- 拥有的塔


function GameData:init()
    self.myPoint_ = 3 -- 我的血量
    self.enemypoint_ = 3 -- 敌人的血量
    self.sumSp_ = 100 -- 总的sp
    self.needSp_ = 10 -- 生成塔需要的sp
end

--[[--
    获取我的血量

    @parm none

    @return 类型：number
]]
function GameData:getMyPoint()
    return self.myPoint_
end

--[[--
    获取敌人的血量

    @parm none

    @return 类型：number
]]
function GameData:getEnemyPoint()
    return self.enemypoint_
end

--[[--
    获取总的sp数

    @parm none

    @return 类型：number
]]
function GameData:getSumSp()
    return self.sumSp_
end

--[[--
    获取生成塔需要的sp

    @parm none

    @return 类型：number
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

return GameData