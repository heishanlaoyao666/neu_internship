--[[--
    GameData.lua
    游戏数据总文件，注意：只有一份，全局唯一
]]
local GameData = {}

local ConstDef = require("app/def/ConstDef.lua")
local EventDef = require("app/def/EventDef.lua")
local TowerDef = require("app/def/TowerDef.lua")
local EventManager = require("app/manager/EventManager.lua")
local Player = require("app/data/Player.lua")

local DamageInfo =require("app/data/DamageInfo.lua")


local damages_ = {} --类型:伤害信息数组

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
    self.opposite_ = ConstDef.GAME_TYPE.NULL --类型：number,游戏对手

    self.player_=Player.new()

    self.monster_tick_ = 0 --类型：number,怪物生成tick
    -- 类型：number，游戏状态
    self.gameState_ = ConstDef.GAME_STATE.INIT
    self.monster_tick_=0
    self.monset_stage_=0 --怪物生成次数

    self.game_time_=0
    self.game_stage_ = 0

    EventManager:regListener(EventDef.ID.INIT_DAMAGE, self, function(damage)
        damages_[#damages_+1] = damage
        --audio.playEffect("sounds/fireEffect.ogg", false)
    end)
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
            tower_table[i].id_=table[i].tower_id_
            tower_table[i].level_=table[i].tower_level_
            tower_table[i].grade_=1
        end
        self.player_:init(tower_table,tag)
        print("初始化了么")
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
function GameData:setGameState(state)
    self.gameState_ = state
    EventManager:doEvent(EventDef.ID.GAMESTATE_CHANGE, state)
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
    local pos_x=(x-ConstDef.TOWER_POS.DOWN_X)/ConstDef.TOWER_POS.MOVE_X+0.5
    local pos_y=(y-ConstDef.TOWER_POS.DOWN_Y)/ConstDef.TOWER_POS.MOVE_Y+0.5

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
    -- print("是否移动")
    local pos_x=(x-ConstDef.TOWER_POS.DOWN_X)/ConstDef.TOWER_POS.MOVE_X+0.5
    local pos_y=(y-ConstDef.TOWER_POS.DOWN_Y)/ConstDef.TOWER_POS.MOVE_Y+0.5

    pos_x= math.ceil(pos_x)
    pos_y = math.ceil(pos_y)
    local move_tower = self.player_:getTowers()[pos_y][pos_x]
    print(pos_x.." "..pos_y)
    if move_tower and move_tower~=moveTower.tower then
        --进行合成
        if move_tower:getID() ==  moveTower.tower:getID() and  move_tower:getGrade()==moveTower.tower:getGrade() then
            print("能合成么")
            move_tower:destory()
            self.player_:getTowers()[pos_y][pos_x]=moveTower.tower
            moveTower.tower:setGrade()
            moveTower.tower:setX(move_tower:getX())
            moveTower.tower:setY(move_tower:getY())
            self.player_:getTowers()[moveTower.location_y][moveTower.location_x]=nil
            return
        end
    end
    moveTower.tower:setX(moveTower.x)
    moveTower.tower:setY(moveTower.y)
    --allies_[1]:setY(y)
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
            self.player_:createMonster(5*stage_.LIFE*(self.monset_stage_+1),stage_.SP,ConstDef.MONSTER_TAG.PLUS)
        end
        self.monster_tick_=self.monster_tick_-stage_.TICK
        for i = 1, stage_.NUMBER do
            self.player_:createMonster(stage_.LIFE*self.monset_stage_,stage_.SP,ConstDef.MONSTER_TAG.NORMAL)
        end
    end
    self.monster_tick_=self.monster_tick_+dt 
    self.game_time_=self.game_time_+dt
    if self.game_time_>=stage_.TIME then
        if stage_.BOSS then
            self.player_:createMonster(self.game_stage_*50000*self.monset_stage_,stage_.SP,self.opposite_)
        end
        self.game_stage_=self.game_stage_+1
    end
    -- self:shoot(dt)
    -- self:createEnemyPlane(dt)
    self.player_:update(dt)
    for i = 1, #damages_ do
        damages_[i]:update(dt)
    end
end



return GameData