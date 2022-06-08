
require("config")
require("cocos.init")
require("framework.init")

local AppBase = require("framework.AppBase")
local MyApp = class("MyApp", AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    local id=cc.UserDefault:getInstance():getIntegerForKey("id")
    if(id~="") then
        self:enterScene("MainScene")
    else
        self:enterScene("RegisterScene")
    end
end

return MyApp
