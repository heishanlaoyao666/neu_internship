--[[
    GameData.lua
    玩家信息总文件
    描述：存放信息、名字、账号、积分等
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local GameData = {}

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

-- local GamePlayer = require("src.app.data.GamePlayer")
local tcp = require("src.app.data.TCP")

-- local enemyPlayer = GamePlayer.new(1)
-- local mePlayer = GamePlayer.new(2)

function GameData:init()
    print("init")
    -- 客户端给服务端发一个消息表示开赛
    tcp.send(7, {data="start"})

    --注册一个监听器监听服务端发来的消息
    tcp.regListener(0x80000+7, function(resp)
        print("接收到了消息")
        dump(resp)
    end)
end

function GameData:update(dt,data)
    -- enemyPlayer:update(dt,data.player1)
end

return GameData
