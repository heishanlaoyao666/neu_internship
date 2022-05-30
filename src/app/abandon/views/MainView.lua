local BaseView = require("BaseView")
local MainView = class("MainView", BaseView)

function MainView:onCreate()
    -- body
    Log.i("MainView:onCreate")
    self:add(MvcManager:getNewView("testV2"))
    local item1 = cc.MenuItemFont:create("show data in testV2 Model")
    local testController = MvcManager:getController("testC1")

    local function call2(sender)
        testController:showModel2()
    end

    item1:registerScriptTapHandler(call2)

    local menu = cc.Menu.create()
    menu.addChild(item1)
    self:add(menu)
    menu:setPosition(cc.p(display.cx, display.cy))
    menu:alignItmeVertically()
end

function MainView:modelUpdate(model)
    Log.i("MainView update()")
    -- body
end

function MainView:bind()
    -- body
    Log.i("MainView bind")
end
