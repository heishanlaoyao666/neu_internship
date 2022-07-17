--[[
    GameData.lua
    服务器端程序，实时演算数据，将信息分配到服务器端
    编写：李昊

]]
local GameDef = require("lua.inGame.def.GameDef")
local Player = require("lua.inGame.Player")
local EnemyDef = require("lua.inGame.def.EnemyDef")
local Card1 = require("lua.inGame.card.Card1")
local Card2 = require("lua.inGame.card.Card2")
local Card3 = require("lua.inGame.card.Card3")
local Card4 = require("lua.inGame.card.Card4")
local Card5 = require("lua.inGame.card.Card5")
local Utils = require("lua.Utils")

GameData = {
    player1_ = nil, --玩家信息 
    player2_ = nil ,--玩家信息 
    bossTime_ = nil ,--boss刷新时间 number
    enemyTime_ = nil, --怪物刷新时间 number
    isPause_ = nil, --暂停 boolean
    bossFrequency_ = nil ,--boss波数 number
    enemyFrequency_ = nil,-- 怪物波数 number
    player1_ = nil, --上方玩家信息
    player2_ = nil, --下方玩家信息
    bossTime_ =  nil,--boss刷新时间
    enemyTime_ = nil,
    sid_ = nil,
    hurt_ = nil,
}

--[[
    初始化函数

    @param none

    @return none
]]
function GameData:init()

    self.isPause_ = true --暂停
    self.bossFrequency_ = 0 --boss波数 number
    self.enemyFrequency_ = 0 -- 怪物波数 number

    self.hurt_ = {}
    self.sid_ = {}

    self.bossTime_ =  GameDef.BOSS_CREATE.TIME[1] --boss刷新时间
    self.enemyTime_ = 0

end


function GameData:resetPlayer(id,enemy)
    if id == 1 then
        self.player2_:createEnemy(enemy:getDafHp(),enemy:getSp(),1)
    else
        self.player1_:createEnemy(enemy:getDafHp(),enemy:getSp(),1)
    end
    --msSleep(10000)
end

function GameData:removeHurt(hurt)
    local deleteHurt 
    for k ,v in pairs(self.hurt_) do
        if v == hurt then
            deleteHurt = k 
        end
    end
    table.remove(self.hurt_,deleteHurt)
end

function GameData:getBossFrequency()
    return self.bossFrequency_
end

--[[
    new
    攻击玩家，根据位置判断
    @param none

    @return none
]]
function GameData:new()
    local gameData = {}
    self.__index = self
    setmetatable(gameData,self)
    gameData:init()
    return gameData
end

--[[
    增加玩家
    @param 玩家信息
    @return none
]]
function GameData:addPlayer(msg)
    self.player1_  = Player:new(self,1,msg[1])
    self.player1_:createCard()
    self.sid_[1] = msg[1].sid
    self.player2_  = Player:new(self,2,msg[1])
    self.player2_:createCard()
    self.sid_[2] = msg[2].sid
    self.isPause_ = false
end

--[[
    生成敌人函数
    @param none
    @return none
]]
function GameData:createEnemy()

    --怪物血量计算
    local hp_rise = 100 --没出现boss之前的血量公差
    if(self.bossFrequency_ >= 1) then
        hp_rise = self.bossFrequency_*700--出现boss之后的血量公差
    end
    local hp --怪物血量
    if self.enemyFrequency_ == 0 then
        hp = EnemyDef.HP
    else
        hp = self.enemyFrequency_*hp_rise + EnemyDef.HP
    end
    --怪物sp计算
    local sp = (self.bossFrequency_ + 1 )*EnemyDef.SP --怪物sp

    --怪物数量计算
    local num = 0
    if self.enemyFrequency_ == 0 then 
        num = 2
    else
        num = 4
    end

    --派发到玩家在重置时间
    self.player1_:createEnemy(hp,sp,num)
    self.player2_:createEnemy(hp,sp,num)
    self.enemyFrequency_ = self.enemyFrequency_ + 1
    if self.bossFrequency_ == 0 then
        self.enemyTime_ = GameDef.ENEMY_CREATE.TIME[1]
    elseif self.bossFrequency_ == 1 then
        self.enemyTime_ = GameDef.ENEMY_CREATE.TIME[2]
    else
        self.enemyTime_ = GameDef.ENEMY_CREATE.TIME[3]
    end
end

--[[
    --信息处理
]]
function GameData:msgDispose(msg,sid)
    if msg["size"] == "CREATE_CARD" then
        if sid == self.sid_[1] then
            self.player1_:createCard()
        else
            self.player2_:createCard()
        end
    elseif msg["size"] == "ENHANCE_CARD" then
        if sid == self.sid_[1] then
            self.player1_:enhanceCard(msg["data"])
        else
            self.player2_:enhanceCard(msg["data"])
        end
    elseif msg["size"] == "COMPOUND_CARD" then
        if sid == self.sid_[1] then
            self.player1_:compoundCard(msg)
        else
            self.player2_:compoundCard(msg)
        end
    end
end

--[[
    生成boss函数

    @param none

    @return none
]]
function GameData:createBoss()
     self.bossFrequency_ = self.bossFrequency_ + 1
    self.player1_:createBoss(1)
    self.player2_:createBoss(1)
    if self.bossFrequency_ == 1 then
        self.bossTime_ = GameDef.BOSS_CREATE.TIME[1]
    else
        self.bossTime_ = GameDef.BOSS_CREATE.TIME[2]
    end
    self.enemyFrequency_ = 0
end

--[[
    update
    @param dt 类型：number，帧间隔，单位秒
    @return none
]]
function GameData:update(dt)

    if self.isPause_ then
        return
    end
    --boss刷新时间
    self.bossTime_ = self.bossTime_ - dt
    if self.bossTime_ <= 0 then
        self:createBoss()
    end

    --怪物刷新时间
    self.enemyTime_ = self.enemyTime_ - dt
    if self.enemyTime_ <= 0 then
        self:createEnemy()
    end

    local player1 = self.player1_:update(dt)
    local player2 = self.player2_:update(dt)

    local hurt1 = {}
    local hurt2 = {}

    for k ,v in pairs(self.hurt_) do
        v:update(dt)
    end

    for k ,v in pairs(self.hurt_) do
        if v.player_.id_ == 1 then
            hurt1[k] = {
                x = v.x_, y = v.y_,
                id = v.id_, num = v.num_,
                color = v.color_
            }
            hurt2[k] = {
                x = v.x1_, y = v.y1_,
                id = v.id_, num = v.num_,
                color = v.color_
            }
        else
            hurt2[k] = {
                x = v.x_, y = v.y_,
                id = v.id_, num = v.num_,
                color = v.color_
            }
            hurt1[k] = {
                x = v.x1_, y = v.y1_,
                id = v.id_, num = v.num_,
                color = v.color_
            }
        end
    end

    --Utils.print_dump(hurt)

    local info = {}
    info[1] = {
        sid = self.sid_[1],
        data = {
            time = self.bossTime_,
            player1 = player1[1],
            player2 = player2[2],
            hurt = hurt1,
        },
    }
    info[2] = {
        sid = self.sid_[2],
        data = {
            time = self.bossTime_,
            player1 = player2[1],
            player2 = player1[2],
            hurt = hurt2,
        },
    }

    return info

end

function GameData:getBossFrequency()
    return self.bossFrequency_
end

return GameData