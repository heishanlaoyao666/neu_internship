--[[--
    KnapsackData.lua
    背包数据总文件，注意：只有一份，全局唯一
]]
local KnapsackData = {}
local TowerDef = require("app/def/TowerDef.lua")

local MsgController=require("app/msg/MsgController.lua")
local MsgDef=require("app.msg.MsgDef")

local EventManager = require("app/manager/EventManager.lua")
local EventDef = require("app/def/EventDef.lua")

local towerData = {} --类型: table ,key 塔id，value：unlock(塔解锁模式),fragment(塔碎片),level(塔等级)
local towerArray = {} --类型:table, key 阵容顺序(12345),value:tower_id_(塔id),tower_level_(塔等级)
local initlevel = {}
local a = {}

local Shopdata = require("app.data.Shopdata")
local ShopDef = require("app.def.ShopDef")

local isLogin = false --类型:boolen,是否已经注册
local isMatch = false --类型:是否正在匹配
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
    self.pid_ = 0
    math.randomseed(tostring(os.time()):reverse():sub(1,7))
    self.name_ = "50885"..math.random(10)
    for i = 1, 20 do
        towerData[i]={}
        towerData[i].unlock_=false --塔是否解锁
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

    for i = 1,6 do
        ShopDef.ITEM[i].SOLD_OUT = false
        ShopDef.ITEM[i].ID = 01
    end

    --初始化msg控制器的监听
    MsgController:registerListener(self,function (msg)
        if msg["type"] == MsgDef.MSG_TYPE_ACK.LOGIN then
            self.goldcoin_=msg["gold"]
            self.diamonds_=msg["diamond"]
            self.cups=msg["cup"]
            self.pid_=msg["pid"]
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
            Shopdata:initItem(msg["shopData"])
            EventManager:doEvent(EventDef.ID.KNAPSACK_LOGIN)
        end
        if msg["type"] == MsgDef.MSG_TYPE_ACK.UPDATE_DATA then
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
        if msg["type"] == MsgDef.MSG_TYPE_ACK.STARTGAME then
            EventManager:doEvent(EventDef.ID.CREATE_GAME,msg)
        end
        if msg["type"] == MsgDef.MSG_TYPE_ACK.SHOPDATA then
            Shopdata:initItem(msg["shopData"])
        end
        if msg["type"] == MsgDef.MSG_TYPE_ACK.SHOPREFRESH then
            Shopdata:initItem(msg["shopData"])
        end
    end)
end
--[[--
    背包获取用户pid

    @param none

    @return none
]]
function KnapsackData:getPidid()
    return self.pid_
end
--[[--
    背包获取用户名

    @param none

    @return none
]]
function KnapsackData:getName()
    return self.name_
end
--[[--
    背包注册

    @param none

    @return none
]]
function KnapsackData:Login()
    MsgController:connect()
    co=coroutine.create(function (flag)
        while flag==false do
            coroutine.yield()
        end
        local msg = {
            type = MsgDef.MSG_TYPE_REQ.LOGIN,
            loginname = self.name_,
        }
        MsgController:sendMsg(msg)
        isLogin=true
        co=nil
    end)
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
    if towerData[id].fragment_ + number <0 then
        print("碎片不足无法购买")
        return false
    else
    towerData[id].fragment_=towerData[id].fragment_+number
    --向服务器推送数据
    self:sendData()
    return towerData[id].fragment_
    end
end
--[[--
    --向服务器推送数据

    @param none

    @return none
]]
function KnapsackData:sendData()
    print("数据推送函数调用")
    --全部数据向服务器推送
    if MsgController:isConnect() then
        local msg = self:getDataTable()
        msg.type=MsgDef.MSG_TYPE_REQ.UPDATE_DATA
        MsgController:sendMsg(msg)
    end
end
--[[--
    --背包数据变成表

    @param none

    @return none
]]
function KnapsackData:getDataTable()
    local table = {
        loginname = self.name_,
        gold=self.goldcoin_,
        diamond=self.diamonds_,
        cup=self.cups_
    }
    --塔数据
    table.towerData={}
    for i = 1, 20 do
        table.towerData[i]={}
        table.towerData[i].unlock=towerData[i].unlock_
        table.towerData[i].fragment=towerData[i].fragment_ --塔持有的碎片
        table.towerData[i].level=towerData[i].level_  --塔当前等级
    end
    --塔阵容数据
    return table
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
    获取商品ID

    @param i 商品编号

    @return none
]]
function KnapsackData:getITEM_ID(i)
    --向服务器拿数据
    return ShopDef.ITEM[i].ID
end
--[[--
    更改商品ID

    @param i,state 商品编号，id

    @return none
]]
function KnapsackData:setITEM_ID(i,id)
    ShopDef.ITEM[i].ID = id
    --向服务器推送数据
end


--[[--
    获取商品出售状态

    @param i 商品编号

    @return none
]]
function KnapsackData:getSoldOutState(i)
    --向服务器拿数据
    return ShopDef.ITEM[i].SOLD_OUT
end
--[[--
    更改商品出售状态

    @param i,state 商品编号，状态

    @return none
]]
function KnapsackData:setSoldOutState(i,state)
    ShopDef.ITEM[i].SOLD_OUT = state
    --向服务器推送数据
    if MsgController:isConnect() then
        local msg={
            loginname = self.name_,
            i_=i,
            SOLD_OUT=state
        }
        msg.type=MsgDef.MSG_TYPE_REQ.SHOPDATA
        MsgController:sendMsg(msg)
    end
end
--[[--
    让服务器更新商店

    @param i,state 商品编号，状态

    @return none
]]
function KnapsackData:shopRefresh()
    --向服务器推送数据
    if MsgController:isConnect() then
        local msg={
            loginname = self.name_,
        }
        msg.type=MsgDef.MSG_TYPE_REQ.SHOPREFRESH
        MsgController:sendMsg(msg)
    end
end







--[[--
    升级塔

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

function KnapsackData:getFirecd(id)
    print(towerData[id].level_)
    return TowerDef.TABLE[id].FIRECD +(towerData[id].level_ -initlevel[id])*TowerDef.TABLE[id].FIRECD_UPGRADE
end

function KnapsackData:getSkill1(id)
    print(towerData[id].level_)
    return TowerDef.TABLE[id].SKILLS[1].VALUE +(towerData[id].level_ -initlevel[id])*TowerDef.TABLE[id].SKILLS[1].VALUE_UPGRADE
end

function KnapsackData:getSkill2(id)
    print(towerData[id].level_)
    return TowerDef.TABLE[id].SKILLS[2].VALUE +(towerData[id].level_ -initlevel[id])*TowerDef.TABLE[id].SKILLS[2].VALUE_UPGRADE
end




function KnapsackData:getupgradecoin(id)
    local num = towerData[id].level_
    if a[id] ~=0 then
        return TowerDef.UPLEVELCOIN2[num]
    else
        return "已满级"
    end
end

function KnapsackData:getupgradefrag(id)
    local num = towerData[id].level_
    if a[id] ~=0 then
        return TowerDef.UPLEVELFRAG2[num]
    else
        return "已满级"
    end
end

function KnapsackData:getTowerData(id)
    return towerData[id]
end
--[[--
    背包界面帧循环

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function KnapsackData:update(dt)
    if co~=nil then
        coroutine.resume(co,MsgController:isConnect())
    end
end
--[[--
    匹配消息发送

    @param none

    @return none
]]
function KnapsackData:gameMatch()
    local msg = {
        type = MsgDef.MSG_TYPE_REQ.GAMEMATCH,
        loginname = self.name_,
    }
    isMatch=true
    MsgController:sendMsg(msg)
end
--[[--
    取消匹配消息发送

    @param none

    @return none
]]
function KnapsackData:cancelMatch()
    local msg = {
        type = MsgDef.MSG_TYPE_REQ.CANCELMATCH,
        loginname = self.name_,
    }
    isMatch=false
    MsgController:sendMsg(msg)
end
--[[--
    获取是否匹配中

    @param none

    @return isMatach
]]
function KnapsackData:getMatch()
    return isMatch
end
-- function KnapsackData:setatk(id)
--     TowerDef.TABLE[id].ATK = TowerDef.TABLE[id].ATK+TowerDef.TABLE[id].ATK_UPGRADE
--     return true
-- end

-- function KnapsackData:getatk(id)
--     return TowerDef.TABLE[id].ATK
-- end
return KnapsackData