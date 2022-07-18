--[[--
    UserInfo.lua

    描述：玩家信息数据类
]]
local UserInfo = {}
local Log = require("app.util.Log")

---------------------------------------------------------------------------
-- 成员变量定义
---------------------------------------------------------------------------
UserInfo.userId_ = 0 -- 类型：number，玩家id
UserInfo.nickname_ = "" -- 类型：string，玩家昵称
UserInfo.trophy_ = 0 -- 类型：number，奖杯数量
UserInfo.gold_ = 0 -- 类型：number，金币数量
UserInfo.diamond_ = 0 -- 类型：number，钻石数量

--[[--
    描述：获取玩家id

    @param none

    @return number
]]
function UserInfo:getUserId()
    return self.userId_
end

--[[--
    描述：获取玩家昵称

    @param none

    @return string
]]
function UserInfo:getNickname()
    return self.nickname_
end

--[[--
    描述：获取玩家奖杯数量

    @param none

    @return number
]]
function UserInfo:getTrophy()
    return self.trophy_
end

--[[--
    描述：获取玩家金币数量

    @param none

    @return number
]]
function UserInfo:getGold()
    return self.gold_
end

--[[--
    描述：获取玩家钻石数量

    @param none

    @return number
]]
function UserInfo:getDiamond()
    return self.diamond_
end

return UserInfo