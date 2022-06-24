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
	self.setFlag = flase
	return self
end

Timer.beginTimer = function(self, term)
	now = getTickCount()
	self.setFlag = true
	self.tickTerm = term
	self.tickBegin = now
	self.tickOld = now
end

Timer.countingTimer = function(self)
	now = getTickCount()
	if self.setFlag == false then
		return false
	end
	delta = 0
	newTime = now
	if (newTime >= self.tickOld) then
		delta = newTime - self.tickOld
	else
		delta = (0xFFFFFFFF - self.tickOld) + now
	end
	if delta < self.tickTerm then
		return false
	end
	self.tickOld = now
	self.tickBegin = now
	return true
end

Timer.isSet = function(self)
	return self.setFlag
end

return Timer