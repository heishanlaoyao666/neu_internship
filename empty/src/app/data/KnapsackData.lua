--[[--
    KnapsackData.lua
    背包数据总文件，注意：只有一份，全局唯一
]]
local KnapsackData = {}
local TowerDef = require("app/def/TowerDef.lua")

local MsgController=require("app/msg/MsgController.lua")
local MsgDef=require("app.msg.MsgDef")

local towerData = {} --类型: table ,key 塔id，value：unlock(塔解锁模式),fragment(塔碎片),level(塔等级)
local towerArray = {} --类型:table, key 阵容顺序(12345),value:tower_id_(塔id),tower_level_(塔等级)
local initlevel = {}
local a = {}

local isLogin = false --类型:boolen,是否已经注册
local co = nil --类型:function,携程判断
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

    MsgController:connect()

    for i = 1, 20 do
        towerData[i]={}
        towerData[i].unlock_=false
        towerData[i].fragment_=0 --塔持有的碎片
        towerData[i].level_= 1  --塔当前等级
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

    --初始化msg控制器的监听
    MsgController:registerListener(self,function (msg)
        if msg["type"] == MsgDef.MSG_TYPE_ACK.LOGIN then
            self.goldcoin_=msg["gold"]
            self.diamonds_=msg["diamond"]
            self.cups=msg["cup"]

            for i = 1, 20 do
                towerData[i].unlock_=msg["towerData"][i]["unlock"]
                towerData[i].fragment_=msg["towerData"][i]["fragment"]
                towerData[i].level_= msg["towerData"][i]["level"]
            end

            for i = 1, 3 do
                for j = 1, 5 do
                    towerArray[i][j].tower_id_ = msg["towerArray"][i][j]["id"]
                    towerArray[i][j].tower_level_ = msg["towerArray"][i][j]["level"]
                end
            end
        end
    end)
end
--[[--
    背包注册

    @param none

    @return none
]]
function KnapsackData:Login()
    local msg = {
        type = MsgDef.MSG_TYPE_REQ.LOGIN,
        loginname = "5088",
    }
    MsgController:sendMsg(msg)
    isLogin=true
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
    获取塔当前解锁状态

    @param id 类型:number 塔的id

    @return none
]]
function KnapsackData:getTowerUnlock_(id)
    --向服务器拿数据
    return towerData[id].unlock_
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
    --向服务器推送数据
    self:sendData()
    return towerData[id].fragment_
end
--[[--
    --向服务器推送数据

    @param none

    @return none
]]
function KnapsackData:sendData()
    --全部数据向服务器推送
    if MsgController:isConnect() then
        local msg = {
            type = MsgDef.MSG_TYPE_REQ.UPDATE_DATA,
            loginname = "5088",
            gold=self.goldcoin_,
            diamond=self.diamonds_,
            cup=self.cups_
        }
        msg.towerData={}
        for i = 1, 20 do
            msg.towerData[i]={}
            msg.towerData[i].unlock=towerData[i].unlock_
            msg.towerData[i].fragment=towerData[i].fragment_ --塔持有的碎片
            msg.towerData[i].level=towerData[i].level_  --塔当前等级
        end
        MsgController:sendMsg(msg)
    end
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
    print(towerData[id].level_)
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
--[[--
    背包界面帧循环

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function KnapsackData:update(dt)
    if not isLogin and MsgController:isConnect() then
        self:Login()
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