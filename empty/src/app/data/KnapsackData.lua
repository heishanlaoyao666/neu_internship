--[[--
    KnapsackData.lua
    背包数据总文件，注意：只有一份，全局唯一
]]
local KnapsackData = {}
local TowerDef = require("app/def/TowerDef.lua")

local towerData = {} --类型:二维数组 塔id 
--[[--
    初始化数据

    @param none

    @return none
]]
function KnapsackData:init()
    self.goldcoin_ = 10000
    self.diamonds_ = 10000
    self.cups_ = 0
    --向服务器拿数据初始化

    for i = 1, 20 do
        towerData[i]={}
        towerData[i].unlock_=true
        towerData[i].fragment_=50 --塔持有的碎片
        towerData[i].grade_=1  --塔当前等级
    end
    
end
--[[--
    塔升级

    @param id 类型:number 塔的id

    @return none
]]
function KnapsackData:upTowerGrade(id)
    --向服务器拿数据
    towerData[id].grade_=towerData[id].grade_+1
    return towerData[id].grade_
end
--[[--
    获取塔当前等级

    @param id 类型:number 塔的id

    @return none
]]
function KnapsackData:getTowerGrade(id)
    --向服务器拿数据
    return towerData[id].grade_
end
--[[--
    解锁塔

    @param id 类型:number 塔的id

    @return none
]]
function KnapsackData:unlockTower(id)
    --向服务器拿数据
    towerData[id].unlock_=true
    return towerData[id].unlock_
end
--[[--
    通过塔id获取塔的当前碎片

    @param id 类型:number 塔的id

    @return none
]]
function KnapsackData:getTowerFragment_(id)
    --向服务器拿数据

    return towerData[id].fragment_
end
--[[--
    通过塔id获取塔的当前碎片

    @param id 类型:number 塔的id
    @param number 类型:number 塔的id

    @return none
]]
function KnapsackData:setTowerFragment_(id,number)
    --向服务器拿数据
    towerData[id].fragment_=towerData[id].fragment_+number
    return towerData[id].fragment_
end

--[[--
    获取金币数

    @param none

    @return none
]]
function KnapsackData:getGoldCoin()
    --向服务器拿数据

    return self.goldcoin_
end
--[[--
    更改金币数

    @param number 更改的金币数量

    @return none
]]
function KnapsackData:setGoldCoin(number)
    self.goldcoin_=self.goldcoin_+number
    --向服务器推送数据

end
--[[--
    获取钻石数

    @param none

    @return none
]]
function KnapsackData:getDiamonds()
    --向服务器拿数据

    return self.diamonds_
end
--[[--
    更改钻石数

    @param number 更改的钻石数量

    @return none
]]
function KnapsackData:setDiamonds(number)
    self.diamonds_=self.diamonds_ + number
    --向服务器推送数据

end
--[[--
    获取奖杯数

    @param none

    @return none
]]
function KnapsackData:getCups()
    --向服务器拿数据

    return self.cups_
end
--[[--
    更改奖杯数

    @param number 更改的奖杯数量

    @return none
]]
function KnapsackData:setCups(number)
    self.cups=self.cups + number
    --向服务器推送数据
end
return KnapsackData