--[[--
    GameData.lua

    描述：游戏数据
]]
local GameData = {}
local GameDef = require("app.def.GameDef")
local Log = require("app.util.Log")

---------------------------------------------------------------------------
-- 成员变量定义
---------------------------------------------------------------------------

local PLAYER_INFO = {
    spCount = 0, -- 类型：number，sp剩余数量
    spCost = 0, -- 类型：number，生成塔sp消耗

    newEnemys_ = {}, -- 类型：table，新增的敌人数据，内部元素Enemy
    enemyMap_ = {}, -- 类型：table，敌人数据，key为对象id，value为Enemy
    delEnemyIds_ = {}, -- 类型：table，删除的敌人，内部元素对象id

    newBullets_ = {}, -- 类型：table，新增的子弹数据，内部元素Bullet
    bulletMap_ = {}, -- 类型：table，子弹数据，内部元素Bullet
    hitBulets_ = {}, -- 类型：table，命中敌人的子弹，内部元素Bullet

    towerMap_ = {}, -- 类型：table，塔数据，内部元素Tower
}

GameData.state_ = GameDef.STATE.NONE -- 类型：number，游戏状态
GameData.isWin_ = false -- 类型：boolean，自己是否获胜

-- TODO 此处的初始值是为了调试方便，正常不应在此处初始化
GameData.selfInfo_ = clone(PLAYER_INFO) -- 类型：table，我的信息
GameData.opponentInfo_ = clone(PLAYER_INFO) -- 类型：table，对手的信息

--[[--
    描述：初始化一场比赛

    @param none

    @return none
]]
function GameData:initGame()
    Log.d()

    self.state_ = GameDef.STATE.PLAY -- TODO 应该时boss选择状态
    self.isWin_ = false

    -- TODO 应该封装对象，每次开赛重新new
    self.selfInfo_ = clone(PLAYER_INFO)
    self.opponentInfo_ = clone(PLAYER_INFO)
end

return GameData