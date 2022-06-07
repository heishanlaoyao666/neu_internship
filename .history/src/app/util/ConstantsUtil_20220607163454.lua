ConstantsUtil = ConstantsUtil or {}
--- object
Director = cc.Director:getInstance()
Scheduler = Director:getScheduler()
WinSize = Director:getWinSize()
UserDefault = cc.UserDefault:getInstance()
CSLoader = cc.CSLoader:getInstance()
Audio = require("framework.Audio")

--- string
ConstantsUtil.BACKGROUND = "background"
ConstantsUtil.SETTING = "setting"
ConstantsUtil.RANK = "rank"

ConstantsUtil.MUSIC_KEY = "music_key"
ConstantsUtil.EFFECT_KEY = "effect_key"
ConstantsUtil.PAUSE_KEY = "pause_key"

--- constants
ConstantsUtil.DEFAULT_HP = 100
ConstantsUtil.DEFAULT_SCORE = 0

ConstantsUtil.MINUS_ENEMY_COLLISION = 20
ConstantsUtil.PLUS_ENEMY_SCORE = 1

ConstantsUtil.SPEED_BG_MOVE = 5
ConstantsUtil.SPEED_BULLET_MOVE = 15
ConstantsUtil.SPEED_ENEMY_MOVE = 10
ConstantsUtil.SPEED_EXPLOSION = 1 / 35

ConstantsUtil.FPS = 60
ConstantsUtil.INTERVAL_ANIMATION = 1.0 / ConstantsUtil.FPS
ConstantsUtil.INTERVAL_BULLET = 0.2
ConstantsUtil.INTERVAL_BACKGROUND_MOVE = 1.0 / 60
ConstantsUtil.INTERVAL_ENEMY = 1.0
ConstantsUtil.INTERVAL_COLLISION = 1.0 / 60

ConstantsUtil.BORN_PLACE_ENEMY = 1.3
ConstantsUtil.DIE_PLACE_ENEMY = 0
ConstantsUtil.DIE_BULLET = WinSize.height

ConstantsUtil.MASK_COLLISION = 0x01

ConstantsUtil.TAG_BULLET = 0x01
ConstantsUtil.TAG_ENEMY = 0x02
ConstantsUtil.TAG_MY_ROLE = 0x04

ConstantsUtil.LEVEL_VISIABLE_HIGH = 10
ConstantsUtil.LEVEL_VISIABLE_MEDIUM = 5
ConstantsUtil.LEVEL_VISIABLE_LOW = 0

--- path
ConstantsUtil.PATH_BG_JPG = "ui/main/bg_menu.jpg"
ConstantsUtil.PATH_BULLET_PNG = "player/blue_bullet.png"
ConstantsUtil.PATH_SMALL_ENEMY_PNG = "player/small_enemy.png"
ConstantsUtil.PATH_SETTING_CLOSE_PNG = "ui/setting/soundon2_cover.png"
ConstantsUtil.PATH_SETTING_OPEN_PNG = "ui/setting/soundon1_cover.png"

ConstantsUtil.PATH_BACKGROUND_MUSIC = "sounds/bgMusic.ogg"
ConstantsUtil.PATH_MAIN_MUSIC = "sounds/mainMainMusic.ogg"
ConstantsUtil.PATH_DESTROY_EFFECT = "sounds/shipDestroyEffect.ogg"
ConstantsUtil.PATH_EXPLOSION_EFFECT = "sounds/explodeEffect.ogg"
ConstantsUtil.PATH_BUTTON_EFFECT = "sounds/buttonEffect.ogg"
ConstantsUtil.PATH_FIRE_EFFECT = "sounds/fireEffect.ogg"

ConstantsUtil.PATH_EXPLOSION_PLIST = "animation/explosion.plist"
ConstantsUtil.PATH_EXPLOSION_PNG = "animation/explosion.png"

ConstantsUtil.PATH_BIG_NUM = "ui/rank/islandcvbignum.fnt"

--- global variable
musicKey = UserDefault:getBoolForKey(ConstantsUtil.MUSIC_KEY, true)
effectKey = UserDefault:getBoolForKey(ConstantsUtil.EFFECT_KEY, true)
pauseKey = UserDefault:getBoolForKey(ConstantsUtil.PAUSE_KEY, true)

return ConstantsUtil
