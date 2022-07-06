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
--OnCast(buff,target,...)
--OnHit(buff,target,...)
function GradeDamage(buff,tower,damageinfo)
   local monsterMap = damageinfo:getGameData():getMonsterForBullet(target)
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
function BossDamage(buff,bullet,damageinfo)
    local buffmap=damageinfo:getTarget():getBuff()
    for i = 1, #buffmap do
        if buffmap[i]:getID() == "boss_tag" then
            damageinfo:setDamage(bullet:getAtk())
        end
    end
end
--OnTick(buff,target,...)
function SpeedUp(buff,target)
    target:setBuffSpeed(target:getSpeed())
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