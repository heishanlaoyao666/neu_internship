local testC1 = class("testC1", require("BaseController"))

function testC1:showModel2()
    local model = MvcManager:getModel("testM2")
    model.testStr = "Click m2"
    model:update()
    -- body
end

return testC1
