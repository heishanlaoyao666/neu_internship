local testV2 = class("testV2", require("BaseView"))

function testV2:onCreate()
    Log.i("testV2 onCreate()")
    self.lbl =
        cc.Label:createWithSystemFont("testV2 View", "Arial", 40):move(display.cx - 200, display.cy - 200):addTo(self)
end

function testV2:bind()
    Log.i("testV2 bind()")
    MvcManager:getModel("testM2"):registerView(self)
end

function testV2:modelUpdate(model)
    -- body
    Log.i("testV2 update")
    self.lbl.setString(model.testStr)
end

return testV2
