--[[--
    GameData.lua
    游戏数据总文件，注意：只有一份，全局唯一
]]
local GameData = {}

local ConstDef = require("app/def/ConstDef.lua")
local EventDef = require("app/def/EventDef.lua")
local TowerDef = require("app/def/TowerDef.lua")
local EventManager = require("app/manager/EventManager.lua")

local KnapsackData = require("app/data/KnapsackData.lua")
local Enemy = require("app/data/Enemy.lua")
local Tower = require("app/data/Tower.lua")
local Bullet = require("app/data/Bullet.lua")
local DamageInfo =require("app/data/DamageInfo.lua")
local BuffTable = require("app/data/BuffTable.lua")
-- local SHOOT_INTERVAL = 0.2 -- 类型：number，射击间隔
-- local ENEMY_INTERVAL = 1 -- 类型：number，敌机生成间隔

local up_bullets_ = {} -- 类型：上方子弹数组
local down_bullets_ = {} -- 类型：下方子弹数组

local up_enemies_ = {} -- 类型：上方敌人数组
local down_enemies_ = {} -- 类型：下方敌人数组

local up_array_ = {}  --类型:上方塔阵容
local down_array_ = {}  --类型:下方塔阵容

local up_towers_ = {} -- 类型：上方塔数组
local down_towers_ = {} -- 类型：下方塔数组

local damages_ = {} --类型:伤害信息数组
local up_frist_monster = 1 --最前方怪物
local down_frist_monster = 1 --最前方怪物

local MONSTER_INTERVAL_ =1 --怪物生成间隔

local moveTower = {
    tower =nil,
    x = 0,
    y = 0,
    location = 0,
}
--[[--
    初始化数据

    @param none

    @return none
]]
function GameData:init()
    self.sp_ = 0 -- 类型：number，sp点数
    self.opposite_ = ConstDef.GAME_TYPE.NULL --类型：number,游戏对手


    for i = 1, 15 do
        up_towers_[i] = nil
        down_towers_[i] =nil
    end
    self.monster_tick_ = 0 --类型：number,怪物生成tick
    -- 类型：number，游戏状态
    self.gameState_ = ConstDef.GAME_STATE.INIT
    self.monster_tick_=MONSTER_INTERVAL_
    
    EventManager:regListener(EventDef.ID.INIT_DAMAGE, self, function(damage)
        damages_[#damages_+1] = damage
        --audio.playEffect("sounds/fireEffect.ogg", false)
    end)
    EventManager:regListener(EventDef.ID.INIT_BULLET, self, function(tower)
        if tower:getY()<= display.cy then
            self:bulletCreate(tower,ConstDef.GAME_TAG.DOWN)
        end
        if tower:getY()> display.cy then
            self:bulletCreate(tower,ConstDef.GAME_TAG.UP)
        end
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
    local pos_y=(y-ConstDef.TOWER_POS.DOWN_Y)/ConstDef.TOWER_POS.MOVE_Y-0.5

    pos_x= math.ceil(pos_x)
    pos_y = math.ceil(pos_y)
    print(pos_x.." "..pos_y)
    if pos_x<1 or pos_x> 6 then
        return false
    end
    if pos_y<0 or pos_y> 2 then
        return false
    end
    local move_tower = down_towers_[pos_x+pos_y*5]
    if move_tower then
        moveTower.tower=move_tower
        moveTower.x = move_tower:getX()
        moveTower.y = move_tower:getY()
        moveTower.location = pos_x+pos_y*5
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
    移动塔结束处理

    @param x 类型：number
    @param y 类型：number

    @return none
]]
function GameData:moveToEnd(x, y)
    -- print("是否移动")
    local pos_x=(x-ConstDef.TOWER_POS.DOWN_X)/ConstDef.TOWER_POS.MOVE_X+0.5
    local pos_y=(y-ConstDef.TOWER_POS.DOWN_Y)/ConstDef.TOWER_POS.MOVE_Y-0.5

    pos_x= math.ceil(pos_x)
    pos_y = math.ceil(pos_y)
    local move_tower = down_towers_[pos_x+pos_y*5]
    if move_tower and move_tower~=moveTower.tower then
        --进行合成
        if move_tower:getID() ==  moveTower.tower:getID() and  move_tower:getGrade()==moveTower.tower:getGrade() then
            move_tower:destory()
            down_towers_[pos_x+pos_y*5]=moveTower.tower
            moveTower.tower:setGrade()
            moveTower.tower:setX(move_tower:getX())
            moveTower.tower:setY(move_tower:getY())
            down_towers_[moveTower.location]=nil
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
    if self.monster_tick_>=MONSTER_INTERVAL_ then
        self.monster_tick_=self.monster_tick_-MONSTER_INTERVAL_
        -- local enemy_up = Enemy.new()
        -- enemy_up:setTarget(ConstDef.TARGET.UP)
        -- up_enemies_[#up_enemies_+1] = enemy_up
        local enemy_down = Enemy.new()
        enemy_down:setTarget(ConstDef.TARGET.DOWN)
        down_enemies_[#down_enemies_+1] = enemy_down
    end
    self.monster_tick_=self.monster_tick_+dt 
    -- self:shoot(dt)
    -- self:createEnemyPlane(dt)

    local destoryBullets = {}
    local destoryTowers = {}
    local destoryMonster = {}
    for i = 1, #down_bullets_ do
        local bullet = down_bullets_[i]
        bullet:update(dt)
        if bullet:isDeath() then
            destoryBullets[#destoryBullets + 1] = bullet
        else
            self:checkCollider(bullet:getTarget(),bullet)
        end
    end
    for i = 1, 15 do
        if down_towers_[i] ~= nil then
            local tower = down_towers_[i]
            tower:update(dt)
        end
        -- if bullet:isDeath() then
        --     destoryBullets[#destoryBullets + 1] = bullet
        -- end
    end

    for i = 1, #down_enemies_ do
        down_enemies_[i]:update(dt)
        if not down_enemies_[i]:isDeath() then
        else
            destoryMonster[#destoryMonster + 1] = down_enemies_[i]
        end
    end

    for i = 1, #damages_ do
        damages_[i]:update(dt)
    end
    -- for i = 1, #allies_ do
    --     allies_[i]:update(dt)
    -- end

    -- 清理失效子弹
    for i = #destoryBullets, 1, -1 do
        for j = #down_bullets_, 1, -1 do
            if down_bullets_[j] == destoryBullets[i] then
                table.remove(down_bullets_, j)
            end
        end
        for j = #up_bullets_, 1, -1 do
            if up_bullets_[j] == destoryBullets[i] then
                table.remove(up_bullets_, j)
            end
        end
    end

    -- 清理失效怪物
    for i = #destoryMonster, 1, -1 do
        for j = #up_enemies_, 1, -1 do
            if up_enemies_[j] == destoryMonster[i] then
                table.remove(up_enemies_, j)
            end
        end
        for j = #down_enemies_, 1, -1 do
            if down_enemies_[j] == destoryMonster[i] then
                table.remove(down_enemies_, j)
            end
        end
    end
    
    -- -- 生命值小于0，结算
    -- if self.life_ <= 0 then
    --     self:setGameState(ConstDef.GAME_STATE.RESULT)
    -- end
end
--[[--
    子弹创建

    @param tower 类型:塔
    @param tag 类型:number 标签区分上下

    @return number
]]
function GameData:bulletCreate(tower,tag)

    if tag == ConstDef.GAME_TAG.DOWN then
        if #down_enemies_ == 0 then
            return
        end
    end
    if tag ==ConstDef.GAME_TAG.UP then
        if #up_enemies_ == 0 then
            return
        end
    end
    local bullet = Bullet.new(tower)
    bullet:setX(tower:getX())
    bullet:setY(tower:getY())
    if tag == ConstDef.GAME_TAG.DOWN then
        down_bullets_[#down_bullets_+1] = bullet
    end
    if tag ==ConstDef.GAME_TAG.UP then
        up_bullets_[#up_bullets_+1] = bullet
    end
    --为子弹添加buff
    for i = 1, #TowerDef.BUFF[tower:getID()].BULLET do
        local data = TowerDef.BUFF[tower:getID()].BULLET[i]
        local value = TowerDef.TABLE[tower:getID()].SKILLS[i]
        bullet:addBuff(BuffTable:addBuffInfo(
            nil,
            bullet,
            BuffTable[data.NAME],
            BuffTable[data.ADDSTACK],
            true,
            BuffTable[data.PERMANENT],
            0,
            value.VALUE+value.VALUE_UPGRADE*(tower:getLevel()-1)+value.VALUE_ENHANCE*(tower:getGrade()-1)
        ))
    end
    local monster = nil
    if tower:getMode() == TowerDef.MODE.FRIST then
        if tag == ConstDef.GAME_TAG.DOWN then
            monster = down_enemies_[down_frist_monster]
        end
        if tag ==ConstDef.GAME_TAG.UP then
            monster = up_enemies_[up_frist_monster]
        end
    end
    if tower:getMode() == TowerDef.MODE.MAXLIFE then
        if tag == ConstDef.GAME_TAG.DOWN then
            monster=down_enemies_[1]
            for i = 1, #down_enemies_ do
                if monster:getLife()<down_enemies_[i]:getLife() then
                    monster=down_enemies_[i]
                end
            end
        end
        if tag ==ConstDef.GAME_TAG.UP then
            monster=up_enemies_[1]
            for i = 1, #up_enemies_ do
                if monster:getLife()<up_enemies_[i] then
                    monster=up_enemies_[i]
                end
            end
        end
    end
    if tower:getMode() == TowerDef.MODE.RANDOM then
        if tag == ConstDef.GAME_TAG.DOWN then
            monster =down_enemies_[math.random(1,#down_enemies_)]
        end
        if tag == ConstDef.GAME_TAG.UP then
            monster =up_enemies_[math.random(1,#up_enemies_)]
        end
    end
    if monster then
        bullet:setTarget(monster)
    end
end
--[[--
    塔创建

    @param tower_id 类型:number 塔id
    @param level 类型:number 塔等级
    @param tag 类型:number 上下

    @return number
]]
function GameData:createTower(tower_id,level,tag)
    local tower = Tower.new(tower_id,level)
    if tag == ConstDef.GAME_TAG.DOWN then
        local random = math.random(1,15)
        local sum = 0
        while down_towers_[random]~=nil do
            if sum == 15 then
                return
            end
            sum =sum+1
            random = math.random(1,15)
        end
        local x = random%5
        local y =math.modf(random/5)+1
        if x == 0 then
            x = 5
        end
        if random%5 == 0 then
            y = y-1
        end
        tower:setX(ConstDef.TOWER_POS.DOWN_X+ConstDef.TOWER_POS.MOVE_X*(x-1))
        tower:setY(ConstDef.TOWER_POS.DOWN_Y+ConstDef.TOWER_POS.MOVE_Y*(y-1))
        down_towers_[random] = tower
    end
    --为塔添加buff
    for i = 1, #TowerDef.BUFF[tower_id].TOWER do
        local data = TowerDef.BUFF[tower_id].TOWER[i]
        local value = TowerDef.TABLE[tower_id].SKILLS[i]
        tower:addBuff(BuffTable:addBuffInfo(
            nil,
            tower,
            BuffTable[data.NAME],
            BuffTable[data.ADDSTACK],
            true,
            BuffTable[data.PERMANENT],
            0,
            value.VALUE+value.VALUE_UPGRADE*(tower:getLevel()-1)+value.VALUE_ENHANCE*(tower:getGrade()-1)
        ))
    end
end
--[[--
    碰撞检查

    @param monster 类型：Enemy，怪物
    @param bullets 类型：Bullet数组

    @return none
]]
function GameData:checkCollider(monster, bullet)
    if not bullet:isDeath() then
        if monster:isCollider(bullet) and not monster:isDeath()then
            self:hitMonster(monster, bullet)
        end
    end
end
--[[--
    获取子弹所在半区怪物信息

    @param bullet

    @return number
]]
function GameData:getMonsterForBullet(bullet)
    for i = 1, #up_bullets_ do
        if up_bullets_[i] == bullet then
            return up_enemies_
        end
    end
    return down_enemies_
end
--[[--
    伤害处理

    @param monster 类型：Enemy，怪物
    @param bullet 类型：Bullet

    @return none
]]
function GameData:hitMonster(monster, bullet)
    DamageInfo.new(bullet,monster,bullet:getAtk(),ConstDef.DAMAGE.NORMAL,self)
    bullet:destory()
end


return GameData