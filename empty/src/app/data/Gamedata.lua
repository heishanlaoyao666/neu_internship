--[[--
    GameData.lua
    游戏数据总文件，注意：只有一份，全局唯一
]]
local GameData = {}

local ConstDef = require("app/def/ConstDef.lua")
local EventDef = require("app/def/EventDef.lua")
local EventManager = require("app/manager/EventManager.lua")
local Player = require("app/data/Player.lua")
local KnapsackData = require("app.data.KnapsackData")

local DamageInfo =require("app/data/DamageInfo.lua")


local MsgController=require("app/msg/MsgController.lua")
local MsgDef=require("app.msg.MsgDef")

local damages_ = {} --类型:伤害信息数组

local gameframe = 0 --类型:当前客户端游戏帧
local severframe = 1 -- 类型:当前服务器游戏帧
local runframe = 0 --类型:已经运行的游戏帧
local handelframe = {} --类型:每帧行为存放

local last_dt = 0.016
local moveTower = {
    tower =nil,
    x = 0,
    y = 0,
    location_x = 0,
    location_y = 0,
}
--[[--
    初始化数据

    @param none

    @return none
]]
function GameData:init()
    self.sp_ = 0 -- 类型：number，sp点数
    self.opposite_ = Player.new() --类型：player,游戏对手
    self.player_=Player.new() --类型：player,游戏对手

    self.monster_tick_ = 0 --类型：number,怪物生成tick
    -- 类型：number，游戏状态
    self.gameState_ = ConstDef.GAME_STATE.INIT
    self.monster_tick_=0
    self.monset_stage_=0 --怪物生成次数

    self.game_boss_ = ConstDef.GAME_TYPE.NULL
    self.game_time_=0
    self.game_stage_ = 0

    --联机游戏需要参数
    self.serialNumber = 0
    self.pid = 0
    self.waitHandle={
    }
    self.socketTick = 16
    self.remain_time = 0
    gameframe = 0 --类型:当前客户端游戏帧
    severframe = 0 -- 类型:当前服务器游戏帧
    handelframe = {} --类型:每帧行为存放
    damages_={}
    EventManager:regListener(EventDef.ID.INIT_DAMAGE, self, function(damage)
        damages_[#damages_+1] = damage
        --audio.playEffect("sounds/fireEffect.ogg", false)
    end)
    EventManager:regListener(EventDef.ID.PLAYER_SURRENDER, self, function()
        local msg = {
            type= MsgDef.MSG_TYPE_REQ.SURRENDER,
            serialNumber=self.serialNumber,
            pid=self.pid,
            sd=999,
        }
        MsgController:sendMsg(msg)
    end)
    EventManager:regListener(EventDef.ID.PLAYER_LIFE_CHANGE, self, function(monster)
        local msg = {
            type= MsgDef.MSG_TYPE_REQ.LIFECHANGE,
            serialNumber=self.serialNumber,
            number=1,
        }
        if  monster:getPlayer():getTag() == ConstDef.GAME_TAG.UP then
            msg["pid"]=self.pid
        end
        if monster:getTag()<=ConstDef.MONSTER_TAG.BOSS_4 and monster:getTag()>=ConstDef.MONSTER_TAG.BOSS_1 then
            msg["number"]=2
        end
        MsgController:sendMsg(msg)
    end)
    EventManager:regListener(EventDef.ID.OPPOSITE_ENEMY, self, function(monster)
        if monster:getTag()~=ConstDef.GAME_TAG.LIFE then
            if monster:getPlayer():getTag()~=ConstDef.GAME_TAG.UP then
                self:createMonster(self.opposite_,100,ConstDef.MONSTER_TAG.LIFE)
            else
                self:createMonster(self.player_,100,ConstDef.MONSTER_TAG.LIFE)
            end
        end
        --audio.playEffect("sounds/fireEffect.ogg", false)
    end)
    --初始化msg控制器的监听
    MsgController:registerListener(self,function (msg)
        if msg["type"] == MsgDef.MSG_TYPE_ACK.GAMEPLAY then
            if msg["severframe"]>runframe then
                severframe=msg["severframe"]
                handelframe[severframe]={}
                handelframe[severframe]["handle"]=msg["handle"] or {}
                handelframe[severframe]["dt"]=msg["dt"]/1000
                handelframe[severframe]["time"]=msg["time"]
                while gameframe<= severframe do
                    handelframe[gameframe]=handelframe[gameframe] or {}
                    handelframe[gameframe]["handle"]=handelframe[gameframe]["handle"] or {}
                    --处理塔生成
                    handelframe[gameframe]["handle"]["create"]=handelframe[gameframe]["handle"]["create"] or {}
                    for i = 1, #handelframe[gameframe]["handle"]["create"] do
                        local table = handelframe[gameframe]["handle"]["create"][i]
                        if table["pid"]==self.pid then
                            self.player_:createTowerEnd(table["id"],table["x"],table["y"])
                            self.player_:towerCreateCost()
                        else
                            self.opposite_:createTowerEnd(table["id"],table["x"],table["y"])
                            self.opposite_:towerCreateCost()
                        end
                    end
                    --处理塔合成
                    handelframe[gameframe]["handle"]["compose"]=handelframe[gameframe]["handle"]["compose"] or {}
                    for i = 1, #handelframe[gameframe]["handle"]["compose"] do
                        local table = handelframe[gameframe]["handle"]["compose"][i]
                        if table["pid"]==self.pid then
                            self.player_:composeTower(table["x1"],table["y1"],table["x2"],table["y2"],table["id"])
                        else
                            self.opposite_:composeTower(table["x1"],table["y1"],table["x2"],table["y2"],table["id"])
                        end
                    end
                    --处理塔强化
                    handelframe[gameframe]["handle"]["upgrade"]=handelframe[gameframe]["handle"]["upgrade"] or {}
                    for i = 1, #handelframe[gameframe]["handle"]["upgrade"] do
                        local table = handelframe[gameframe]["handle"]["upgrade"][i]
                        if table["pid"]==self.pid then
                            self.player_:upTowerGrade(table["i"])
                            EventManager:doEvent(EventDef.ID.UP_TOWER_GRADE)
                        else
                            self.opposite_:upTowerGrade(table["i"])
                        end
                    end
                    self:update(handelframe[gameframe]["dt"] or last_dt)
                    self.remain_time=handelframe[severframe]["time"]
                    runframe=gameframe
                    gameframe=gameframe+1
                end
            end
        elseif  msg["type"] == MsgDef.MSG_TYPE_ACK.BOSSTRUE then
            EventManager:doEvent(EventDef.ID.OPPOSITE_SELECT,ConstDef.BOSS[msg["boss"]].ID)
            self:setGameState(ConstDef.GAME_STATE.PLAY)
            gameframe=1
            self:sendGamePlay()
        elseif  msg["type"] == MsgDef.MSG_TYPE_ACK.LIFECHANGE then
            if msg["pid"]==self.pid then
                self.opposite_:setLife(msg["number"])
            else
                self.player_:setLife(msg["number"])
            end
        elseif  msg["type"] == MsgDef.MSG_TYPE_ACK.GAMEWIN then
            print("赢了怎么说赢了")
            self:setGameState(ConstDef.GAME_STATE.WIN,msg)
        elseif  msg["type"] == MsgDef.MSG_TYPE_ACK.GAMELOSE then
            print("输了怎么说输了")
            self:setGameState(ConstDef.GAME_STATE.LOSE,msg)
        elseif  msg["type"] == MsgDef.MSG_TYPE_ACK.GAMEOVER then
            msg["type"]=MsgDef.MSG_TYPE_REQ.GAMEOVER
            MsgController:sendMsg(msg)
        end
        
    end)
end
--[[--
    玩家初始化

    @param msg--类型 table,服务器消息

    @return none
]]
function GameData:playerInit(msg)
    math.randomseed(msg["random"])
    if msg["data1"]["nick"]==KnapsackData:getName() then
        print("是本家"..msg["data1"]["nick"])
        self:setTowerArray(msg["data1"]["towerArray"], ConstDef.GAME_TAG.DOWN)
        self:setTowerArray(msg["data2"]["towerArray"], ConstDef.GAME_TAG.UP)
        self.player_:setName(msg["data1"]["nick"])
        self.opposite_:setName(msg["data2"]["nick"])
    else
        print("不是本家"..msg["data1"]["nick"])
        self:setTowerArray(msg["data1"]["towerArray"], ConstDef.GAME_TAG.UP)
        self:setTowerArray(msg["data2"]["towerArray"], ConstDef.GAME_TAG.DOWN)
        self.player_:setName(msg["data2"]["nick"])
        self.opposite_:setName(msg["data1"]["nick"])
    end
    self.serialNumber=msg["serialNumber"]
    self.pid=msg["pid"]
end
--[[--
    设置塔阵容

    @param table 类型：table, 塔数据表
    @param tag 类型：number, 设置的位置

    @return none
]]
function GameData:setTowerArray(table,tag)
    if tag ==ConstDef.GAME_TAG.DOWN then
        local tower_table={}
        for i = 1, 5 do
            tower_table[i]={}
            tower_table[i].id_=table[i].id
            tower_table[i].level_=table[i].level
            tower_table[i].grade_=1
        end
        self.player_:init(tower_table,tag)
    end
    if tag == ConstDef.GAME_TAG.UP then
        local tower_table={}
        for i = 1, 5 do
            tower_table[i]={}
            tower_table[i].id_=table[i].id
            tower_table[i].level_=table[i].level
            tower_table[i].grade_=1
        end
        self.opposite_:init(tower_table,tag)
    end
end
--[[--
    获取塔阵容

    @param tag 类型：number, 获取的位置

    @return none
]]
function GameData:getTowerArray(tag)
    if tag ==ConstDef.GAME_TAG.DOWN then
        return self.player_:getTowerArray()
    else
        return self.opposite_:getTowerArray()
    end
end
--[[--
    游戏结束的处理

    @param none

    @return none
]]
function GameData:GameOver()

end
--[[--
    获取游戏总时间

    @param none

    @return boolean
]]
function GameData:getGameTime()
    return self.remain_time/1000
end

--[[--
    玩家塔强化

    @param none

    @return boolean
]]
function GameData:upTowerGrade(i)
    local table={
        ["pid"]=self.pid,
        ["i"]=i
    }
    self.waitHandle["upgrade"]=table
end
--[[--
    是否游戏中

    @param none

    @return boolean
]]
function GameData:isPlaying()
    return self.gameState_ == ConstDef.GAME_STATE.PLAY
end

--[[--
    设置游戏状态

    @param state 类型：number，游戏状态

    @return none
]]
function GameData:setGameState(state,msg)
    self.gameState_ = state
    EventManager:doEvent(EventDef.ID.GAMESTATE_CHANGE, state,msg)
end
--[[--
    位置是否在下方有效范围（判定能否点击）

    @param x 类型：number
    @param y 类型：number

    @return boolean
]]
function GameData:isValidTouch(x, y)
    if y >=display.cy then
        return false
    end
    local pos_x=(x-ConstDef.TOWER_POS.DOWN_X)/ConstDef.TOWER_POS.MOVE_X_DOWN+0.5
    local pos_y=(y-ConstDef.TOWER_POS.DOWN_Y)/ConstDef.TOWER_POS.MOVE_Y_DOWN+0.5

    pos_x= math.ceil(pos_x)
    pos_y = math.ceil(pos_y)
    if pos_x<1 or pos_x> 6 then
        return false
    end
    if pos_y<1 or pos_y> 3 then
        return false
    end
    local move_tower = self.player_:getTowers()[pos_y][pos_x]
    if move_tower then
        moveTower.tower=move_tower
        moveTower.x = move_tower:getX()
        moveTower.y = move_tower:getY()
        moveTower.location_x=pos_x
        moveTower.location_y=pos_y
        return move_tower
    end
    return false
end
--[[--
    移动塔

    @param x 类型：number
    @param y 类型：number

    @return none
]]
function GameData:moveTo(x, y)
    -- print("是否移动")
    moveTower.tower:setX(x)
    moveTower.tower:setY(y)
    --allies_[1]:setY(y)
end
--[[--
    返回游戏数据的玩家

    @param none

    @return player
]]
function GameData:getPlayer()
    return self.player_
end
--[[--
    移动塔结束处理

    @param x 类型：number
    @param y 类型：number

    @return none
]]
function GameData:moveToEnd(x, y)
    if y>display.cy then
        moveTower.tower:setX(moveTower.x)
        moveTower.tower:setY(moveTower.y)
        return
    end
    -- print("是否移动")
    local pos_x=(x-ConstDef.TOWER_POS.DOWN_X)/ConstDef.TOWER_POS.MOVE_X_DOWN+0.5
    local pos_y=(y-ConstDef.TOWER_POS.DOWN_Y)/ConstDef.TOWER_POS.MOVE_Y_DOWN+0.5

    pos_x= math.ceil(pos_x)
    pos_y = math.ceil(pos_y)
    local move_tower = self.player_:getTowers()[pos_y][pos_x]
    if move_tower and move_tower~=moveTower.tower then
        --进行合成
        if move_tower:getID() ==  moveTower.tower:getID() and  move_tower:getGrade()==moveTower.tower:getGrade() then
            if move_tower:getGrade()<7 then
                self.waitHandle["compose"]={
                    x1=pos_x,
                    y1=pos_y,
                    x2=moveTower.location_x,
                    y2=moveTower.location_y,
                    pid=self.pid
                }
            end
            --self.player_:composeTower(pos_x,pos_y,moveTower.location_x,moveTower.location_y)
            -- move_tower:destory()
            -- self.player_:getTowers()[pos_y][pos_x]=moveTower.tower
            -- moveTower.tower:setGrade()
            -- moveTower.tower:setX(move_tower:getX())
            -- moveTower.tower:setY(move_tower:getY())
            -- self.player_:getTowers()[moveTower.location_y][moveTower.location_x]=nil
            return
        end
    end
    moveTower.tower:setX(moveTower.x)
    moveTower.tower:setY(moveTower.y)
    --allies_[1]:setY(y)
end
--[[--
    获取塔执行消息

    @param none

    @return number
]]
function GameData:sendGamePlay()
    local msg = {
        type= MsgDef.MSG_TYPE_REQ.GAMEPLAY,
        serialNumber=self.serialNumber,
        pid = self.pid,
        gameframe=gameframe,
        handle=self.waitHandle
    }
    self.waitHandle={}
    MsgController:sendMsg(msg)
end
--[[--
    获取塔生成消息

    @param none

    @return number
]]
function GameData:sendTowerCreate()
    local table = self.player_:createTower()
    if table ~= nil then
        table["pid"]=self.pid
        self.waitHandle["create"]=table
    end
end
--[[--
    发送合成信息

    @param none

    @return none
]]
function GameData:sendTowerCompose()
    return self.gameState_
end
--[[--
    发送塔强化信息

    @param none

    @return none
]]
function GameData:sendTowerUpgrade()
    return self.gameState_
end
--[[--
    获取游戏状态

    @param none

    @return number
]]
function GameData:getGameState()
    return self.gameState_
end
--[[--
    获取游戏对手

    @param none

    @return number
]]
function GameData:getGameOpposite()
    return self.opposite_
end
--[[--
    设置游戏对手

    @param opposite 类型：number，游戏对手

    @return number
]]
function GameData:setGameOpposite(opposite)
    self.opposite_ =opposite
end
--[[--
    设置游戏boss

    @param boss

    @return none
]]
function GameData:setGameBoss(boss)
    local msg = {
        type= MsgDef.MSG_TYPE_REQ.BOSSTRUE,
        boss = boss,
        pid = self.pid,
        serialNumber=self.serialNumber
    }
    MsgController:sendMsg(msg)
end
--[[--
    设置游戏boss

    @param nome

    @return self.game_boss_
]]
function GameData:getGameBoss(boss)
    return self.game_boss_
end
--[[--
    创建怪物

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function GameData:createMonster(player,life,tag)
    local stage_=ConstDef.BOSS.MONSTER_STAGE[self.game_stage_]
    player:createMonster(life,stage_.SP,tag)
end
--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function GameData:update(dt)
    if self.gameState_ ~= ConstDef.GAME_STATE.PLAY then
        return
    end
    local stage_=ConstDef.BOSS.MONSTER_STAGE[self.game_stage_]
    --普通怪物
    if self.monster_tick_>=stage_.TICK then
        self.monset_stage_=self.monset_stage_+1
        --精英怪物
        if self.monset_stage_%4 == 0 then
            self:createMonster(self.player_,5*stage_.LIFE*(self.monset_stage_+1),ConstDef.MONSTER_TAG.PLUS)
            self:createMonster(self.opposite_,5*stage_.LIFE*(self.monset_stage_+1),ConstDef.MONSTER_TAG.PLUS)
        end
        self.monster_tick_=self.monster_tick_-stage_.TICK
        for i = 1, stage_.NUMBER do
            self:createMonster(self.player_,stage_.LIFE*self.monset_stage_,ConstDef.MONSTER_TAG.NORMAL)
            self:createMonster(self.opposite_,stage_.LIFE*self.monset_stage_,ConstDef.MONSTER_TAG.NORMAL)
        end

    end
    self.monster_tick_=self.monster_tick_+dt 
    self.game_time_=self.game_time_+dt
    if self.game_time_>=stage_.TIME then
        if stage_.BOSS then
            self:createMonster(self.player_,self.game_stage_*50000,self.game_boss_)
            self:createMonster(self.opposite_,self.game_stage_*50000,self.game_boss_)
            print("boss生成")
        end
        print("阶段转换")
        self.game_stage_=self.game_stage_+1
        self.monset_stage_=0
    end
    -- self:shoot(dt)
    -- self:createEnemyPlane(dt)
    self.player_:update(dt)
    self.opposite_:update(dt)
    for i = 1, #damages_ do
        damages_[i]:update(dt)
    end

    --上传操作
    self:sendGamePlay()
end



return GameData