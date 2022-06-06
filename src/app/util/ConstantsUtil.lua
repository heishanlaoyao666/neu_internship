ConstantsUtil = ConstantsUtil or {}
--- string
ConstantsUtil.BACKGROUND = "background"
ConstantsUtil.SETTING = "setting"
ConstantsUtil.RANK = "rank"
ConstantsUtil.MUSIC_KEY = "music_key"
ConstantsUtil.EFFECT_KEY = "effect_key"

--- constants
ConstantsUtil.FPS = 60
ConstantsUtil.SPEED_BG_MOVE = 5
ConstantsUtil.SPEED_BULLET_MOVE = 15
ConstantsUtil.SPEED_ENEMY_MOVE = 10

ConstantsUtil.INTERVAL_BULLET = 0.2
ConstantsUtil.INTERVAL_BACKGROUND_MOVE = 1.0 / 60
ConstantsUtil.INTERVAL_ENEMY = 1.0
ConstantsUtil.INTERVAL_COLLISION = 1.0 / 60

ConstantsUtil.BORN_PLACE_ENEMY = 1.3
ConstantsUtil.DIE_PLACE_ENEMY = 0

ConstantsUtil.MASK_COLLISION = 0x01

ConstantsUtil.TAG_BULLET = 0x01
ConstantsUtil.TAG_ENEMY = 0x02
ConstantsUtil.TAG_MY_ROLE = 0x04

--- path
ConstantsUtil.PATH_BG_JPG = "ui/main/bg_menu.jpg"
ConstantsUtil.PATH_BULLET_PNG = "player/blue_bullet.png"
ConstantsUtil.PATH_SMALL_ENEMY_PNG = "player/small_enemy.png"
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
