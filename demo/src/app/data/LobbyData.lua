--[[
    LobbyData.lua
    大厅数据
    描述：存放大厅的临时状态信息
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]

local LobbyData = {}


local curSelectedTower = nil -- 当前被选中的塔(用于替换当前阵容)

--[[--
    初始化

    @param none 初始化

    @return none
]]
function LobbyData:init()

end

--[[--
    获取当前被选中的塔

    @param none

    @return card
]]
function LobbyData:getCurSelectedTower()
    return curSelectedTower
end

--[[--
    设置当前被选中的塔

    @param card

    @return none
]]
function LobbyData:setCurSelectedTower(card)
    curSelectedTower = card
end


return LobbyData