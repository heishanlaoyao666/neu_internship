--[[--
    KnapsackData.lua
    背包数据总文件，注意：只有一份，全局唯一
]]
local KnapsackData = {}
local TowerDef = require("app/def/TowerDef.lua")

local MsgController=require("app.msg.MsgController")
local MsgDef=require("app.msg.MsgDef")

local towerData = {} --类型: table ,key 塔id，value：unlock(塔解锁模式),fragment(塔碎片),level(塔等级)
local towerArray = {} --类型:table, key 阵容顺序(12345),value:tower_id_(塔id),tower_level_(塔等级)
local initlevel = {}
local a = {}
--[[--
    初始化数据

    @param none

    @return none
]]
function KnapsackData:init()
    print("背包初始化开始")
    self.goldcoin_ = 0
    self.diamonds_ = 0
    self.cups_ = 0

    
    --初始化msg控制器的监听
    MsgController:registerListener(self,function (msg)
        if msg["type"] == MsgDef.MSG_TYPE_ACK.LOGIN then
            self.goldcoin_=msg["gold"]
            self.diamonds_=msg["diamond"]
            self.cups=msg["cup"]
        end
    end)




    --链接服务器

    --向服务器拿数据初始化
    -- local msg = {
    --     type = MsgDef.MSG_TYPE_REQ.LOGIN,
    --     userId = 0,
    --     pid = 5088,
    --     loginname = "???",
    -- }
    -- MsgController:sendMsg(msg)
    for i = 1, 20 do
        towerData[i]={}
        towerData[i].unlock_=true
        towerData[i].fragment_=50 --塔持有的碎片
        towerData[i].level_= TowerDef.LEVEL.START_LEVEL[TowerDef.TABLE[i].RARITY]  --塔当前等级
        -- print("bbbbb"..towerData[i].level_)
        initlevel[i] = towerData[i].level_
        -- print("ccccc"..initlevel[i])
        a[i] = 1
    end

    for i = 1, 3 do
        towerArray[i]={}
        for j = 1, 5 do
            towerArray[i][j] = {}
            towerArray[i][j].tower_id_ = j
            towerArray[i][j].tower_level_ = TowerDef.LEVEL.START_LEVEL[TowerDef.TABLE[j].RARITY]
        end
    end

end
--[[--
    塔升级

    @param i 类型:number 第几个阵容
    @param j 类型:number 第几个位置
    @param tower_id 类型:number 塔id
    @param tower_level 类型:number 塔等级

    @return none
]]
function KnapsackData:setTowerArray(i,j,tower_id,tower_level)
    towerArray[i][j].tower_id_=tower_id
    towerArray[i][j].tower_level_=tower_level
end
--[[--
    获取塔阵容

    @param i 类型:number 第几个阵容

    @return towerArray[i]
]]
function KnapsackData:getTowerArray(i)
    return towerArray[i]
end
--[[--
    塔升级

    @param id 类型:number 塔的id

    @return none
]]
function KnapsackData:upTowerGrade(id)
    --向服务器拿数据
    towerData[id].level_=towerData[id].level_+1
    return towerData[id].level_
end
--[[--
    获取塔当前等级

    @param id 类型:number 塔的id

    @return none
]]
function KnapsackData:getTowerGrade(id)
    --向服务器拿数据
    return towerData[id].level_
end
--[[--
    获取塔当前攻击力

    @param id 类型:number 塔的id

    @return atk 类型:number 塔攻击力
]]
function KnapsackData:getTowerATK(id)
    --向服务器拿数据
    if  towerData[id].unlock_ then
        return TowerDef.TABLE[id].ATK+(towerData[id].level_-1)*TowerDef.TABLE[id].ATK_UPGRADE
    end
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
    if self.goldcoin_+number <0 then
        print("金币不足无法购买")
        return false
    else
        self.goldcoin_=self.goldcoin_+number
        return true
    end
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
    if self.diamonds_ + number <0 then
        print("钻石不足无法购买")
        return false
    else
        self.diamonds_=self.diamonds_ + number
        return true
    end
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


--[[--
    更改奖杯数

    @param number atk升级

    @return none
]]
function KnapsackData:uplevel(id)
    -- print("aaaaa"..towerData[id].level_)
    
    if towerData[id].level_<13 then
        towerData[id].level_ = towerData[id].level_+1
    else 
        a[id] = 0
        updatelabel:setVisible(false)
    end

end

function KnapsackData:getatk(id)
 
    return TowerDef.TABLE[id].ATK + (towerData[id].level_-initlevel[id])*TowerDef.TABLE[id].ATK_UPGRADE
end



function KnapsackData:getupgradecoin(id)
    local num = towerData[id].level_
    if a[id] ~=0 then
        return TowerDef.UPLEVELCOIN2[num]
    else
        return "已满级"
    end
    
    
end

-- function KnapsackData:setatk(id)
--     TowerDef.TABLE[id].ATK = TowerDef.TABLE[id].ATK+TowerDef.TABLE[id].ATK_UPGRADE
--     return true
-- end

-- function KnapsackData:getatk(id)
--     return TowerDef.TABLE[id].ATK
-- end
return KnapsackData