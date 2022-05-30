MvcManager = {}

MvcManager.modelList = {}
MvcManager.controllerList = {}

function MvcManager:getModel(modelName)
    local model = self.modelList[modelName]
    if model == nil then
        --- nil 新建
        local funStr = "return (" .. modelName .. '.new("' .. modelName .. '"))'
        model = loadstring(funStr)()
        self.modelList[modelName] = model
    end
    return model
end

function MvcManager:getController(controllerName)
    Log.i("MvcManger:getController")
    local controller = self.controllerList[controllerName]
    if controller == nil then
        local funStr = "return (" .. controllerName .. '.new("' .. controllerName .. '"))'
        controller = loadstring(funStr)()
        self.controllerList[controllerName] = controller
    end
    return controller
end

function MvcManager:getNewView(viewName)
    local funStr = "return " .. viewName .. ':create("' .. viewName .. '")'
    local view = loadstring(funStr)()
    return view
end

function MvcManager:cleanViewBind(viewName) --删除视图的绑定
    for _, v in pairs(self.modelList) do
        v:removeViewBind(viewName)
    end
end

return MvcManager
