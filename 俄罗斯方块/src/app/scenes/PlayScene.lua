
local PlayScene = class("PlayScene", function()
    return display.newScene("PlayScene")
end)

function PlayScene:ctor()
    local label = display.newTTFLabel({
        text = "Hello, World",
        size = 64,
    })
    label:align(display.CENTER, display.cx, display.cy)
    label:addTo(self)
end

function PlayScene:onEnter()
end

function PlayScene:onExit()
end

return PlayScene
