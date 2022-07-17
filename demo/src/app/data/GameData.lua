--[[
    GameData.lua
    玩家信息总文件
    描述：存放信息、名字、账号、积分等
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local GameData = {
    hurt_ = {}
}

local GamePlayer = require("src.app.data.GamePlayer")
local Hurt = require("src.app.data.Hurt")
local TCP = require("app.network.TCP")
local MsgDef = require("src.app.def.MsgDef")

local Card1 = require("src.app.data.card.Card1") 
local Card2 = require("src.app.data.card.Card2") 
local Card3 = require("src.app.data.card.Card3") 
local Card4 = require("src.app.data.card.Card4") 
local Card5 = require("src.app.data.card.Card5") 
local Card6 = require("src.app.data.card.Card6") 
local Card7 = require("src.app.data.card.Card7") 
local Card8 = require("src.app.data.card.Card8") 
local Card9 = require("src.app.data.card.Card9") 
local Card10 = require("src.app.data.card.Card10") 
local Card11 = require("src.app.data.card.Card11") 
local Card12 = require("src.app.data.card.Card12")
local Card13 = require("src.app.data.card.Card13")
local Card14 = require("src.app.data.card.Card14")
local Card15 = require("src.app.data.card.Card15")
local Card16 = require("src.app.data.card.Card16")
local Card17 = require("src.app.data.card.Card17")
local Card18 = require("src.app.data.card.Card18")
local Card19 = require("src.app.data.card.Card19")
local Card20 = require("src.app.data.card.Card20")

local Card = {
    Card1,Card2,Card3,Card4,Card5,
    Card6,Card7,Card8,Card9,Card10,
    Card11,Card12,Card13,Card14,Card15,
    Card16,Card17,Card18,Card19,Card20,
}

local enemyPlayer = GamePlayer.new(1)
local mePlayer = GamePlayer.new(2)
local bossTime = 120 

function GameData:init()
end

function GameData:getBossTime()
    return bossTime
end

function GameData:getEnemyPlayer()
    return enemyPlayer
end

function GameData:getMePlayer()
    return mePlayer
end


function GameData:createCard()
    local msg = {}
    local data = {}
    data["size"] = "CREATE_CARD"
    msg["data"] = data
    TCP.send(MsgDef.REQ_TYPE.CREATE_TOWER,msg)
end

function GameData:send(num,msg)
    TCP.send(num,msg)
end

function GameData:update(dt, data)
    if data == nil then 
        print("Offline!")
        return
    else
        bossTime = data.time/1000
        enemyPlayer:update(data.player1)
        mePlayer:update(data.player2)
    end

    --伤害处理
    for i = 1,#data.hurt do
        if  self.hurt_[data.hurt[i].id] == nil then
            print("----- create hurt -----")
            self.hurt_[data.hurt[i].id] = 
            Hurt.new(data.hurt[i].x,data.hurt[i].y,data.hurt[i].id,data.hurt[i].num,data.hurt[i].color)
        else
            self.hurt_[data.hurt[i].id]:update(data.hurt[i])
        end
    end

    for  i, v in pairs(self.hurt_) do
        local isDestroy = true
        for j = 1,#data.hurt do
            if self.hurt_[i]:getId() == data.hurt[j].id then
                isDestroy = false
                break
            end
        end
        if isDestroy then
            self.hurt_[i]:destroy()
            self.hurt_[i] = nil
            break
        end
    end
end

return GameData
