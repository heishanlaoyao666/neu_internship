--[[
    LobbyData.lua
    大厅数据
    描述：大厅数据
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]

local Queue = require("lua.Queue")

local LobbyData = {}


LobbyData.mappingQueue = Queue:new(2) -- 匹配队列
LobbyData.onLinePlayer = {}

function LobbyData:ifOnLine(nick)
    if self:searchPlayer(nick) ~= nil then
        return true
    end
    return false
end

function LobbyData:addPlayer(nick)
    table.insert(self.onLinePlayer, nick)
end

function LobbyData:removePlayer(nick)
    local index = self:searchPlayer(nick)
    if index ~= nil then
        table.remove(self.onLinePlayer, index)
    end
end

function LobbyData:searchPlayer(nick)
    for i = 1, #self.onLinePlayer do
        if self.onLinePlayer[i] == nick then
            return i
        end
    end
    return nil
end

return LobbyData