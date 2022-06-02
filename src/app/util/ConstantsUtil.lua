ConstantsUtil = ConstantsUtil or {}
--- string
ConstantsUtil.BACKGROUND = "background"
ConstantsUtil.SETTING = "setting"
ConstantsUtil.RANK = "rank"
ConstantsUtil.MUSIC_KEY = "music_key"
ConstantsUtil.EFFECT_KEY = "effect_key"

--- constants
ConstantsUtil.SPEED_BG_MOVE = 5

--- path
ConstantsUtil.PATH_BG_JPG = "ui/main/bg_menu.jpg"
ConstantsUtil.PATH_SETTING_CLOSE_PNG = "ui/setting/soundon2_cover.png"
ConstantsUtil.PATH_SETTING_OPEN_PNG = "ui/setting/soundon1_cover.png"
ConstantsUtil.PATH_BACKGROUND_MUSIC = "sounds/bgMusic.ogg"

--- object
Director = cc.Director:getInstance()
Scheduler = Director:getScheduler()
WinSize = Director:getWinSize()
UserDefault = cc.UserDefault:getInstance()
CSLoader = cc.CSLoader:getInstance()
Audio = require("framework.Audio")

return ConstantsUtil
