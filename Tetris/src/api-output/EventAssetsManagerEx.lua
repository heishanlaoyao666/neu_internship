cc = cc or {}
---EventAssetsManagerEx object
---@class EventAssetsManagerEx : EventCustom
local EventAssetsManagerEx = {}
cc.EventAssetsManagerEx = EventAssetsManagerEx

--------------------------------
--
---@return AssetsManagerEx
function EventAssetsManagerEx:getAssetsManagerEx() end

--------------------------------
--
---@return string
function EventAssetsManagerEx:getAssetId() end

--------------------------------
--
---@return int
function EventAssetsManagerEx:getCURLECode() end

--------------------------------
--
---@return string
function EventAssetsManagerEx:getMessage() end

--------------------------------
--
---@return int
function EventAssetsManagerEx:getCURLMCode() end

--------------------------------
--
---@return float
function EventAssetsManagerEx:getPercentByFile() end

--------------------------------
--
---@return int
function EventAssetsManagerEx:getEventCode() end

--------------------------------
--
---@return float
function EventAssetsManagerEx:getPercent() end

--------------------------------
--- Constructor
---@param eventName string
---@param manager AssetsManagerEx
---@param code int
---@param percent float
---@param percentByFile float
---@param assetId string
---@param message string
---@param curle_code int
---@param curlm_code int
---@return EventAssetsManagerEx
function EventAssetsManagerEx:EventAssetsManagerEx(eventName, manager, code, percent, percentByFile, assetId, message, curle_code, curlm_code) end

return EventAssetsManagerEx