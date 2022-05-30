
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    local label = display.newTTFLabel({
        text = "Hello, World",
        size = 64,
    })
    label:align(display.CENTER, display.cx, display.cy)
    label:addTo(self)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
