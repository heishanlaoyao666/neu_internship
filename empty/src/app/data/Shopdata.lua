local Shopdata = {}
local ShopDef = require("app.def.ShopDef")
--[[
    函数用途：随机获得ID
    --]]
function Shopdata:randomId(TYPE)
    local normalArray = {"01","04","07","09","18","20"}
    local rareArray = {"03","10","14","15"}
    local epicArray = {"02","08","11","12","16","17"}
    if TYPE == 1 then
        local index = math.random(1, #normalArray)
        return normalArray[index]
    elseif TYPE == 2 then
        local index = math.random(1, #rareArray)
        return rareArray[index]
    elseif TYPE == 3 then
        local index = math.random(1, #epicArray)
        return epicArray[index]
    end
end

--[[
    函数用途：比较日期大小
    --]]
function Shopdata:compareDate(preMonth,preDay)
    self.month = tonumber(os.date("%m"))--本次月
    self.day = tonumber(os.date("%d"))--本次日
    if preMonth<=self.month then
        if preDay<self.day then
            return true--本次的时间比上次的时间大则返回true
        end
    else
        return false
    end
    --local times = os.date("%m/%d")
end
--[[
    函数用途：初始化ID
--]]
function Shopdata:initItem(shopData)
    for i = 1, 6 do
        ShopDef.ITEM[i].ID = shopData[i]["ID"]
        ShopDef.ITEM[i].SOLD_OUT = shopData[i]["SOLD_OUT"]
    end
end

return Shopdata