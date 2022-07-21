--[[
    Boss.lua
    描述：boss在服务器端运行的规则
    编写：李昊
]]

local Boss  = {
    x_ = 0, --类型：number
    y_ = 0,--类型：number
    x1_ = 0, --类型：number
    y1_ = 0,--类型：number

    --- 怪物基本信息
    hp_ = 0, --血量 number
    time_ = 0, --到达终点需要的时间 number
    sp_ = 0,-- 消灭后获的能量
    size_ = 0,--boss种类

    id_ = 0, --同意局游戏生成的第几只
    
    action_ = {}, -- number数组 路线上的关键点
    
    --怪物的状态 buff
    buff_ = {}, --buff数组 状态buff

    state_ = {},

    player_ = nil --玩家
}

local EnemyDef = require("lua.inGame.def.EnemyDef")
local Utils = require("lua.Utils")

--[[
    new函数
    @param id,hp,sp
    @return enemy 敌人
]]
function Boss:new(player,id,hp,sp,size)
    local boss = {}
    self.__index = self
    setmetatable(boss,self)
    boss:init(player,id,hp,sp,size)
    print(boss)
    return boss
end

--[[
    init函数
    @param none
    @return none
]]
function Boss:init(player,id,hp,sp, size)
     --- 怪物基本信息
     self.hp_ = hp --血量 number
     self.time_ = EnemyDef.TIME --到达终点需要的时间 number
     self.id_ = ""..id --同意局游戏生成的第几只
     self.player_ = player
     self.sp_ = sp
     self.downAction_ = {}
     self.upAction_ = {}
     self.dafHp_ = hp
     self.state_ = {}
     self.size_ = size
 
     
     for i = 1,#EnemyDef.COM_ENEMY_ACTION_DOWN do
         local action = {dot = EnemyDef.COM_ENEMY_ACTION_DOWN[i], isRoad = 0,time = 0,length = 0,speedX = 0,speedY = 0}
         self.downAction_[i]  = action
         --位置和是否经过，1为已经来过，0为未来过,在上一个点去这个点的时候所需要的时间,length为距离上一个点的长度
     end
     for i = 1,#EnemyDef.COM_ENEMY_ACTION_UP do
         local action = {dot = EnemyDef.COM_ENEMY_ACTION_UP[i], isRoad = 0,time = 0,length = 0,speedX = 0,speedY = 0} 
         self.upAction_[i]  = action
         --位置和是否经过，1为已经来过，0为未来过,在上一个点去这个点的时候所需要的时间,length为距离上一个点的长度
     end
 
     local allLength = 0
     for i = 2,#self.downAction_ do
         self.downAction_[i].length =  math.sqrt((self.downAction_[i].dot.x - self.downAction_[i-1].dot.x)*
         (self.downAction_[i].dot.x - self.downAction_[i-1].dot.x)
         +(self.downAction_[i].dot.y - self.downAction_[i-1].dot.y)*(self.downAction_[i].dot.y - self.downAction_[i-1].dot.y))
         allLength  = allLength + self.downAction_[i].length 
         self.downAction_[i].speedX = self.downAction_[i].dot.x - self.downAction_[i-1].dot.x
         self.downAction_[i].speedY = self.downAction_[i].dot.y - self.downAction_[i-1].dot.y
     end
 
     for i = 2,#self.downAction_ do  
         self.downAction_[i].time = EnemyDef.TIME*(self.downAction_[i].length/allLength)
         self.downAction_[i].speedX = self.downAction_[i].speedX/self.downAction_[i].time
         self.downAction_[i].speedY = self.downAction_[i].speedY/self.downAction_[i].time
     end
 
     allLength = 0
     for i = 2,#self.upAction_ do
         self.upAction_[i].length =  math.sqrt((self.upAction_[i].dot.x - self.upAction_[i-1].dot.x)*
         (self.upAction_[i].dot.x - self.upAction_[i-1].dot.x)
         +(self.upAction_[i].dot.y - self.upAction_[i-1].dot.y)*(self.upAction_[i].dot.y - self.upAction_[i-1].dot.y))
         allLength  = allLength + self.upAction_[i].length 
         self.upAction_[i].speedX = self.upAction_[i].dot.x - self.upAction_[i-1].dot.x
         self.upAction_[i].speedY = self.upAction_[i].dot.y - self.upAction_[i-1].dot.y
     end
 
     for i = 2,#self.upAction_ do  
         self.upAction_[i].time = EnemyDef.TIME*(self.upAction_[i].length/allLength)
         self.upAction_[i].speedX = self.upAction_[i].speedX/self.upAction_[i].time
         self.upAction_[i].speedY = self.upAction_[i].speedY/self.upAction_[i].time
     end
 
     self:setX(self.downAction_[1].dot.x)
     self:setY(self.downAction_[1].dot.y)
     self.x1_ = self.upAction_[1].dot.x
     self.y1_ = self.upAction_[1].dot.y
 
     self.downAction_[1].isRoad = 1 --默认去过初始点  
     self.upAction_[1].isRoad = 1

end

--[[
    move函数
    @param dt 类型：number，帧间隔，单位秒
    @return none
]]
function Boss:move(dt)

    local dot = 0 -- 获取未到达点的序号

    for i = 2,#self.downAction_ do
        if self.downAction_[i].isRoad == 0 then 
            dot = i
            break
        end
    end

    if dot == 0 then
        self:destroy()
        return
    end

    if dt >self.downAction_[dot].time then
        self.upAction_[dot].isRoad = 1
        self.downAction_[dot].isRoad = 1
        if dot == 4 then
            self:attack()
            return
        end
        self:setX(self.downAction_[dot].dot.x)
        self:setY(self.downAction_[dot].dot.y)
        self.x1_ = self.upAction_[dot].dot.x
        self.y1_ = self.upAction_[dot].dot.y
        self:move(dt - self.downAction_[dot].time)
    end

    self:setX(self.x_ + dt*self.downAction_[dot].speedX)
    self:setY(self.y_ + dt*self.downAction_[dot].speedY)

    dot = 0
    for i = 2,#self.upAction_ do
        if self.upAction_[i].isRoad == 0 then 
            dot = i
            break
        end
    end

    if dot == 0 then
        self:destroy()
        return
    end

    if dt >self.upAction_[dot].time then
        self.upAction_[dot].isRoad = 1
        self.downAction_[dot].isRoad = 1
        if dot == 4 then
            self:attack()
            return
        end
        self:setX(self.downAction_[dot].dot.x)
        self:setY(self.downAction_[dot].dot.y)
        self.x1_ = self.upAction_[dot].dot.x
        self.y1_ = self.upAction_[dot].dot.y
        self:move(dt - self.upAction_[dot].time)
    end

    self.x1_ = self.x1_ + dt*self.upAction_[dot].speedX
    self.y1_ = self.y1_ + dt*self.upAction_[dot].speedY

    self.time_ = self.time_ - dt

    self.upAction_[dot].time = self.upAction_[dot].time - dt

    self.downAction_[dot].time = self.downAction_[dot].time - dt


end

--[[
    attack函数
    @param dt 类型：number，帧间隔，单位秒
    @return none
]]
function Boss:attack()
    self.player_:attack(2)
    self.player_.sp_ = self.player_.sp_ + 100
    self:destroy()
end


--[[
    getId函数
    @param dt 类型：number，帧间隔，单位秒
    @return none
]]
function Boss:getId()
    return self.id_
end

--[[
    getHp函数
    @param dt 类型：number，帧间隔，单位秒
    @return none
]]
function Boss:getHp()
    return self.hp_
end

function Boss:getSp()
    return self.sp_
end

function Boss:getSize()
    return self.size_
end

--[[--
    销毁

    @param none

    @return none
]]
function Boss:destroy()
    self.player_:removeBoss(self)
end

--[[
    update
    @param dt 类型：number，帧间隔，单位秒
    @return none
]]
function Boss:update(dt)
    for k,v in pairs (self.state_) do
        v:update(dt)
    end
    if self.hp_ <=  0 then
        self.player_.sp_ = self.player_.sp_ + self.sp_
        self:destroy()
    end
    self:move(dt)
end

function Boss:getState()
    if #self.state_ == 0 then 
        return nil
    end
    local info = {}
    for k,v in pairs (self.state_) do
        info[v.size_] = 1
    end
    return info
end

--[[--
    设置x

    @param x 类型：number

    @return none
]]
function Boss:setX(x)
    self.x_ = x
end

--[[--
    获取x

    @param none

    @return number
]]
function Boss:getX()
    return self.x_
end

--[[--
    设置y

    @param y 类型：number

    @return none
]]
function Boss:setY(y)
    self.y_ = y
end

--[[--
    获取y

    @param none

    @return number
]]
function Boss:getY()
    return self.y_
end


return Boss