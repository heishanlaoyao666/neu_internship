--[[
    Timer.lua
    描述：用于定时任务，拷贝自原始的服务器框架
    编写：
    修订：
    检查：
]]
local Timer = {}

local now_ = nil

Timer = {
	tickTerm = 0,
	tickBegin = 0,
	tickOld = 0,
	setFlag = false,
}

Timer.__index = Timer

Timer.new = function()
	local self = {}
	setmetatable(self, Timer)
	self.tickTerm = 0
	self.tickBegin = 0
	self.tickOld = 0
	self.setFlag = false
	return self
end

Timer.beginTimer = function(self, term)
	now_= getTickCount()
	self.setFlag = true
	self.tickTerm = term
	self.tickBegin = now_
	self.tickOld = now_
end

Timer.countingTimer = function(self)
	now_ = getTickCount()
	if self.setFlag == false then
		return false
	end
	local delta = 0
	local newTime = now_
	if (newTime >= self.tickOld) then
		delta = newTime - self.tickOld
	else
		delta = (0xFFFFFFFF - self.tickOld) + now_
	end
	if delta < self.tickTerm then
		return false
	end
	self.tickOld = now_
	self.tickBegin = now_
	return true
end

Timer.isSet = function(self)
	return self.setFlag
end

return Timer