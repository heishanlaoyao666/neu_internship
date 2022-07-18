--[[--
    BufffTable 储存buff和buff的方法实现
]]
local ConstDef = require("app/def/ConstDef.lua")
local BuffDef = require("app.def.BuffDef")
local BuffInfo =require("app.data.BuffInfo")
local BuffObj = require("app.data.BuffObj")

local DamageInfo =require("app/data/DamageInfo.lua")
local EventManager = require("app/manager/EventManager.lua")
--表中使用的方法定义 target代表buff的携带者
--OnOccur(buff,target,...)
function BossCreate(buff,target)
    local monsters =target:getPlayer():getMonster()
    local newlife = 0
    for i = 1, #monsters do
        newlife=newlife+monsters[i]:getLife()
        monsters[i]:destory()
    end
    target:setLife(newlife*0.5)
end
function GetLife(buff,target)
    local monsters =target:getPlayer():getMonster()
    local newlife = 0
    for i = 1, #monsters do
        newlife=newlife+monsters[i]:getLife()
    end
    if newlife~=0 then
        target:setLife(newlife-target:getLife())
    end
end
--OnCast(buff,target,...)
function StackUpForAttack(buff,tower)
    buff:setStack(1)
end
--OnHit(buff,target,...)
function GradeDamage(buff,tower,damageinfo)
   local monsterMap = damageinfo:getGameData():getMonsterForBullet(tower)
   if #monsterMap<=tower:getGrade() then
      for i = 1, #monsterMap do
        DamageInfo.new(nil,monsterMap[i],buff:getValue(),ConstDef.DAMAGE.BUFF)
      end
      return
   end
   for i = 1, tower:getGrade() do
    DamageInfo.new(nil,monsterMap[i],buff:getValue(),ConstDef.DAMAGE.BUFF)
  end
end
function GiveBurn(buff,target,damageinfo)
    local newbuff = BuffTable["burn"]()
    newbuff:setData(damageinfo:getTarget(),false,2,buff:getValue())
    damageinfo:setBuffInfo(
        BuffInfo.new(
            nil,
            damageinfo:getTarget(),
            newbuff,
            1,
            true,
            2
        )
    )
end
function ExtraDamage(buff,tower,damageinfo)
    local buffmap=tower:getBuff()
    for i = 1, #buffmap do
        if buffmap[i]:getID() == "five_time" then
            if buffmap[i]:setStack(1)==6 then
                buffmap[i]:setStack(-5)
                DamageInfo.new(nil,damageinfo:getTarget(),buff:getValue(),ConstDef.DAMAGE.BUFF)
                return
            end
        end
    end
end
function BossDamage(buff,tower,damageinfo)
    local buffmap=damageinfo:getTarget():getBuff()
    for i = 1, #buffmap do
        if buffmap[i]:getID() == "boss_tag" then
            damageinfo:setDamage(tower:getAtk())
        end
    end
end
function ExtraDamage149(buff,tower,damageinfo)
    local towers=tower:getPlayer():getTowers()
    local sum=0
    for i = 1, 3 do
        for j = 1, 5 do
            if towers[i][j]~=nil and towers[i][j]:getID()==tower:getID() then
                sum=sum+1
            end
        end
    end
    if sum >= 1 then
        tower:setBuffFireCd(tower:getFrieCD()*0.3)
        DamageInfo.new(nil,damageinfo:getTarget(),buff:getValue(),ConstDef.DAMAGE.BUFF)
    end
    if sum >= 4 then
        tower:setBuffFireCd(tower:getFrieCD()*0.3)
        DamageInfo.new(nil,damageinfo:getTarget(),buff:getValue(),ConstDef.DAMAGE.BUFF)
    end
    if sum >= 9 then
        tower:setBuffFireCd(tower:getFrieCD()*0.3)
        DamageInfo.new(nil,damageinfo:getTarget(),buff:getValue(),ConstDef.DAMAGE.BUFF)
    end
    
end
function AttackDeath(buff,tower,damageinfo)
    local buffmap=damageinfo:getTarget():getBuff()
    for i = 1, #buffmap do
        if buffmap[i]:getID() == "boss_tag" then
           return
        end
    end
    if math.random()<=buff:getValue() then
        damageinfo:setDamage(99999999)
    end
end
function GivePoison(buff,target,damageinfo)
    local newbuff = BuffTable["poison"]()
    newbuff:setData(damageinfo:getTarget(),false,3,buff:getValue())
    damageinfo:setBuffInfo(
        BuffInfo.new(
            nil,
            damageinfo:getTarget(),
            newbuff,
            1,
            true,
            2
        )
    )
end
--OnTick(buff,target,...)
function SpeedUp(buff,target)
    target:setBuffSpeed(target:getSpeed())
end
function FireCdUp(buff,target)
    if buff:getRunTime()>=buff:getValue() then
        target:setBuffFireCd(target:getFireCD())
    end
end
function CriticalRateUp(buff,target)
    if buff:getRunTime()>=buff:getValue()+6 then
        target:setBuffCriticalRate(1)
    end
end
function FireCdUp149(buff,target)
    local towers=target:getPlayer():getTowers()
    local sum=0
    for i = 1, 3 do
        for j = 1, 5 do
            if towers[i][j]~=nil and towers[i][j]:getID()==target:getID() then
                sum=sum+1
            end
        end
    end
    if sum >= 1 then
        target:setBuffFireCd(target:getFireCD()*0.3)
    end
    if sum >= 4 then
        target:setBuffFireCd(target:getFireCD()*0.3)
    end
    if sum >= 9 then
        target:setBuffFireCd(target:getFireCD()*0.3)
    end
end
function FireCdUpForAttack(buff,tower)
    tower:setBuffFireCd(tower:getFrieCD()*buff:setStack(0)*buff:getValue())
end
function Poison(buff,target)
    DamageInfo.new(nil,target,buff:getValue(),ConstDef.DAMAGE.BUFF)
end
function TowerChange(buff,boss)
    local player=boss:getPlayer()
    
end
--OnBeHit(buff,state,...)
function Burn(buff,target,damageinfo)
    DamageInfo.new(nil,target,buff:getValue(),ConstDef.DAMAGE.BUFF)
    DamageInfo.new(nil,target,buff:getValue(),ConstDef.DAMAGE.BUFF)
end

BuffTable = {
    ["bullet_burn"] =  function ()
        local buff = BuffObj.new(
            "bullet_burn",
            {},
            0,
            1,
            0,
            nil,
            nil,
            GiveBurn,
            nil,
            nil,
            nil,
            nil,
            nil
        )
        return buff
    end,
    ["burn"] =  function ()
        local buff = BuffObj.new(
            "burn",
            {BuffDef.TAG.BURN},
            0,
            1,
            0,
            nil,
            nil,
            nil,
            nil,
            Burn,
            nil,
            nil,
            nil
        )
        return buff
    end,
    ["grade_damage"] =  function ()
        local buff = BuffObj.new(
            "grade_damage",
            {},
            0,
            1,
            0,
            nil,
            nil,
            GradeDamage,
            nil,
            nil,
            nil,
            nil,
            nil
        )
        return buff
    end,
    ["five_time"] =  function ()
        local buff = BuffObj.new(
            "five_time",
            {},
            0,
            6,
            0,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil
        )
        return buff
    end,
    ["extra_damage"] =  function ()
        local buff = BuffObj.new(
            "extra_damage",
            {},
            0,
            1,
            0,
            nil,
            nil,
            ExtraDamage,
            nil,
            nil,
            nil,
            nil,
            nil
        )
        return buff
    end,
    ["speed_up"] =  function ()
        local buff = BuffObj.new(
            "speed_up",
            {},
            0,
            1,
            0,
            nil,
            nil,
            nil,
            SpeedUp,
            nil,
            nil,
            nil,
            nil
        )
        return buff
    end,
    ["boss_damage"] =  function ()
        local buff = BuffObj.new(
            "boss_damage",
            {},
            0,
            1,
            0,
            nil,
            nil,
            BossDamage,
            nil,
            nil,
            nil,
            nil,
            nil
        )
        return buff
    end,
    ["fireCd_up"] =  function ()
        local buff = BuffObj.new(
            "fireCd_up",
            {},
            0,
            1,
            0,
            nil,
            nil,
            nil,
            FireCdUp,
            nil,
            nil,
            nil,
            nil
        )
        return buff
    end,
    ["criticalRate_up"] =  function ()
        local buff = BuffObj.new(
            "criticalRate_up",
            {},
            0,
            1,
            0,
            nil,
            nil,
            nil,
            FireCdUp149,
            ExtraDamage149,
            nil,
            nil,
            nil
        )
        return buff
    end,
    ["tower_149"] =  function ()
        local buff = BuffObj.new(
            "tower_149",
            {},
            0,
            1,
            0,
            nil,
            nil,
            nil,
            CriticalRateUp,
            nil,
            nil,
            nil,
            nil
        )
        return buff
    end,
    ["attack_firecd_up"] = function ()
        local buff = BuffObj.new(
            "attack_firecd_up",
            {},
            0,
            10,
            0,
            nil,
            StackUpForAttack,
            nil,
            FireCdUpForAttack,
            nil,
            nil,
            nil,
            nil
        )
        return buff
    end,
    ["attack_death"] = function ()
        local buff = BuffObj.new(
            "attack_death",
            {},
            0,
            1,
            0,
            nil,
            nil,
            AttackDeath,
            nil,
            nil,
            nil,
            nil,
            nil
        )
        return buff
    end,
    ["give_poison"] = function ()
        local buff = BuffObj.new(
            "attack_death",
            {},
            0,
            1,
            0,
            nil,
            nil,
            GivePoison,
            nil,
            nil,
            nil,
            nil,
            nil
        )
        return buff
    end,
    ["poison"] = function ()
        local buff = BuffObj.new(
            "poison",
            {BuffDef.TAG.POISON},
            0,
            1,
            1,
            nil,
            nil,
            nil,
            Poison,
            nil,
            nil,
            nil,
            nil
        )
        return buff
    end,
    ["tower_copy"] = function ()

    end,
    --怪物拥有的buff
    ["get_life"] = function ()
        local buff = BuffObj.new(
            "get_life",
            {},
            0,
            1,
            0,
            GetLife,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil
        )
        return buff
    end,
    --boss所持有的buff
    ["boss_tag"] =  function ()
        local buff = BuffObj.new(
            "boss_tag",
            {},
            0,
            1,
            0,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil
        )
        return buff
    end,
    ["boss_create"]=function ()
        local buff = BuffObj.new(
            "boss_create",
            {},
            0,
            1,
            0,
            BossCreate,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil
        )
        return buff
    end,
    ["boss_1"] = function ()
        local buff = BuffObj.new(
            "boss_1",
            {},
            0,
            1,
            10,
            nil,
            nil,
            nil,
            TowerChange,
            nil,
            nil,
            nil,
            nil
        )
        return buff
    end,

}

--[[--
    添加buff


    @param caster 释放者
    @param carrier 携带者
    @param model buff的模板
    @param addStack 添加层数
    @param durationSetTo 确实添加一个时间还是更新时间 true为添加时间，false为更新时间
    @param permanent buff是否是永久的
    @param duration 添加的时间
    @param value 添加的数值

    
    @return none
]]
function BuffTable:addBuffInfo(caster,carrier,buffmodel,addStack,durationSetTon,permanent,duration,value)
    local buff = buffmodel()
    buff:setData(carrier,permanent,duration,value)
    return BuffInfo.new(caster,carrier,buff,addStack,durationSetTon,duration)
end





--表中方法实现















return BuffTable