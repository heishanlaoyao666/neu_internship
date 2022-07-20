--[[--
    StringDef.lua
    字符串定义
    请把字符串相关的常量放在这里
    如果是路径的话请加上 “PATH_” 前缀
    这样的做是为了便于管理，当某个路径发生变化时，只需要在这里改一下就好了，否则需要遍历所有文件找到所有的路径进行修改
    ::>_<::
]]
local StringDef = {
    --图鉴页面，已收集中使用的彩色图标
    PATH_ICON_01 = "res/collected/1.png",
    PATH_ICON_02 = "res/collected/2.png",
    PATH_ICON_03 = "res/collected/3.png",
    PATH_ICON_04 = "res/collected/4.png",
    PATH_ICON_05 = "res/collected/5.png",
    PATH_ICON_06 = "res/collected/6.png",
    PATH_ICON_07 = "res/collected/7.png",
    PATH_ICON_08 = "res/collected/8.png",
    PATH_ICON_09 = "res/collected/9.png",
    PATH_ICON_10 = "res/collected/10.png",
    PATH_ICON_11 = "res/collected/11.png",
    PATH_ICON_12 = "res/collected/12.png",
    PATH_ICON_13 = "res/collected/13.png",
    PATH_ICON_14 = "res/collected/14.png",
    PATH_ICON_15 = "res/collected/15.png",
    PATH_ICON_16 = "res/collected/16.png",
    PATH_ICON_17 = "res/collected/17.png",
    PATH_ICON_18 = "res/collected/18.png",
    PATH_ICON_19 = "res/collected/19.png",
    PATH_ICON_20 = "res/collected/20.png",
    --阵容队列中使用的图标
    PATH_ICON_LINEUP_01 = "res/icon_lineup/1.png",
    PATH_ICON_LINEUP_02 = "res/icon_lineup/2.png",
    PATH_ICON_LINEUP_03 = "res/icon_lineup/3.png",
    PATH_ICON_LINEUP_04 = "res/icon_lineup/4.png",
    PATH_ICON_LINEUP_05 = "res/icon_lineup/5.png",
    PATH_ICON_LINEUP_06 = "res/icon_lineup/6.png",
    PATH_ICON_LINEUP_07 = "res/icon_lineup/7.png",
    PATH_ICON_LINEUP_08 = "res/icon_lineup/8.png",
    PATH_ICON_LINEUP_09 = "res/icon_lineup/9.png",
    PATH_ICON_LINEUP_10 = "res/icon_lineup/10.png",
    PATH_ICON_LINEUP_11 = "res/icon_lineup/11.png",
    PATH_ICON_LINEUP_12 = "res/icon_lineup/12.png",
    PATH_ICON_LINEUP_13 = "res/icon_lineup/13.png",
    PATH_ICON_LINEUP_14 = "res/icon_lineup/14.png",
    PATH_ICON_LINEUP_15 = "res/icon_lineup/15.png",
    PATH_ICON_LINEUP_16 = "res/icon_lineup/16.png",
    PATH_ICON_LINEUP_17 = "res/icon_lineup/17.png",
    PATH_ICON_LINEUP_18 = "res/icon_lineup/18.png",
    PATH_ICON_LINEUP_19 = "res/icon_lineup/19.png",
    PATH_ICON_LINEUP_20 = "res/icon_lineup/20.png",
    --图鉴界面，未使用中的黑白图标
    PATH_ICON_UNCOLLECTED_01 = "res/uncollected/1.png",
    PATH_ICON_UNCOLLECTED_02 = "res/uncollected/2.png",
    PATH_ICON_UNCOLLECTED_03 = "res/uncollected/3.png",
    PATH_ICON_UNCOLLECTED_04 = "res/uncollected/4.png",
    PATH_ICON_UNCOLLECTED_05 = "res/uncollected/5.png",
    PATH_ICON_UNCOLLECTED_06 = "res/uncollected/6.png",
    PATH_ICON_UNCOLLECTED_07 = "res/uncollected/7.png",
    PATH_ICON_UNCOLLECTED_08 = "res/uncollected/8.png",
    PATH_ICON_UNCOLLECTED_09 = "res/uncollected/9.png",
    PATH_ICON_UNCOLLECTED_10 = "res/uncollected/10.png",
    PATH_ICON_UNCOLLECTED_11 = "res/uncollected/11.png",
    PATH_ICON_UNCOLLECTED_12 = "res/uncollected/12.png",
    PATH_ICON_UNCOLLECTED_13 = "res/uncollected/13.png",
    PATH_ICON_UNCOLLECTED_14 = "res/uncollected/14.png",
    PATH_ICON_UNCOLLECTED_15 = "res/uncollected/15.png",
    PATH_ICON_UNCOLLECTED_16 = "res/uncollected/16.png",
    PATH_ICON_UNCOLLECTED_17 = "res/uncollected/17.png",
    PATH_ICON_UNCOLLECTED_18 = "res/uncollected/18.png",
    PATH_ICON_UNCOLLECTED_19 = "res/uncollected/19.png",
    PATH_ICON_UNCOLLECTED_20 = "res/uncollected/20.png",
    --
    PATH_BASEMAP_AREA = "res/home/guide/subinterface_current_lineup/base_area.png",
    PATH_BASEMAP_TITLE = "res/home/guide/subinterface_current_lineup/base_title.png",
    PATH_NUMBER_1 = "res/home/guide/subinterface_current_lineup/one.png",
    PATH_NUMBER_2 = "res/home/guide/subinterface_current_lineup/two.png",
    PATH_NUMBER_3 = "res/home/guide/subinterface_current_lineup/three.png",
    PATH_TEXTURE_NOWLINEUP = "res/home/guide/subinterface_current_lineup/text_current_lineup.png",
    PATH_BASEMAP_CONNECTION = "res/home/guide/subinterface_current_lineup/base_lineup.png",
    PATH_ICON_CHOOSE = "res/home/guide/subinterface_current_lineup/icon_selected.png",
    PATH_ICON_UNCHOOSE = "res/home/guide/subinterface_current_lineup/icon_unselected.png",
    PATH_BASEMAP_TIP = "res/home/guide/subinterface_tips/base_tips.png",
    PATH_TEXTURE_LONG = "res/home/guide/subinterface_tips/text_tips.png",
    PATH_TEXTURE_SHORT = "res/home/guide/subinterface_tips/text_total_critical_strike_damage.png",
    PATH_SPLITLINE_COLLECTED = "res/home/guide/subinterface_tower_list/split_collected.png",
    PATH_SPLITLINE_UNCOLLECTED = "res/home/guide/subinterface_tower_list/split_not_collected.png",
    --防御塔的正常颜色和灰色
    PATH_TOWER_01 = "home/general/icon_tower/01.png", PATH_TOWER_GREY_01 = "home/general/icon_tower_grey/1.png",
    PATH_TOWER_02 = "home/general/icon_tower/02.png", PATH_TOWER_GREY_02 = "home/general/icon_tower_grey/2.png",
    PATH_TOWER_03 = "home/general/icon_tower/03.png", PATH_TOWER_GREY_03 = "home/general/icon_tower_grey/3.png",
    PATH_TOWER_04 = "home/general/icon_tower/04.png", PATH_TOWER_GREY_04 = "home/general/icon_tower_grey/4.png",
    PATH_TOWER_05 = "home/general/icon_tower/05.png", PATH_TOWER_GREY_05 = "home/general/icon_tower_grey/5.png",
    PATH_TOWER_06 = "home/general/icon_tower/06.png", PATH_TOWER_GREY_06 = "home/general/icon_tower_grey/6.png",
    PATH_TOWER_07 = "home/general/icon_tower/07.png", PATH_TOWER_GREY_07 = "home/general/icon_tower_grey/7.png",
    PATH_TOWER_08 = "home/general/icon_tower/08.png", PATH_TOWER_GREY_08 = "home/general/icon_tower_grey/8.png",
    PATH_TOWER_09 = "home/general/icon_tower/09.png", PATH_TOWER_GREY_09 = "home/general/icon_tower_grey/9.png",
    PATH_TOWER_10 = "home/general/icon_tower/10.png", PATH_TOWER_GREY_10 = "home/general/icon_tower_grey/10.png",
    PATH_TOWER_11 = "home/general/icon_tower/11.png", PATH_TOWER_GREY_11 = "home/general/icon_tower_grey/11.png",
    PATH_TOWER_12 = "home/general/icon_tower/12.png", PATH_TOWER_GREY_12 = "home/general/icon_tower_grey/12.png",
    PATH_TOWER_13 = "home/general/icon_tower/13.png", PATH_TOWER_GREY_13 = "home/general/icon_tower_grey/13.png",
    PATH_TOWER_14 = "home/general/icon_tower/14.png", PATH_TOWER_GREY_14 = "home/general/icon_tower_grey/14.png",
    PATH_TOWER_15 = "home/general/icon_tower/15.png", PATH_TOWER_GREY_15 = "home/general/icon_tower_grey/15.png",
    PATH_TOWER_16 = "home/general/icon_tower/16.png", PATH_TOWER_GREY_16 = "home/general/icon_tower_grey/16.png",
    PATH_TOWER_17 = "home/general/icon_tower/17.png", PATH_TOWER_GREY_17 = "home/general/icon_tower_grey/17.png",
    PATH_TOWER_18 = "home/general/icon_tower/18.png", PATH_TOWER_GREY_18 = "home/general/icon_tower_grey/18.png",
    PATH_TOWER_19 = "home/general/icon_tower/19.png", PATH_TOWER_GREY_19 = "home/general/icon_tower_grey/19.png",
    PATH_TOWER_20 = "home/general/icon_tower/20.png", PATH_TOWER_GREY_20 = "home/general/icon_tower_grey/20.png",
    -- level
    PATH_SUBINTERFACE_TOWER_LEVEL_01 = "res/home/guide/subinterface_tower_list/level/Lv.1.png",
    PATH_SUBINTERFACE_TOWER_LEVEL_02 = "res/home/guide/subinterface_tower_list/level/Lv.2.png",
    PATH_SUBINTERFACE_TOWER_LEVEL_03 = "res/home/guide/subinterface_tower_list/level/Lv.3.png",
    PATH_SUBINTERFACE_TOWER_LEVEL_04 = "res/home/guide/subinterface_tower_list/level/Lv.4.png",
    PATH_SUBINTERFACE_TOWER_LEVEL_05 = "res/home/guide/subinterface_tower_list/level/Lv.5.png",
    PATH_SUBINTERFACE_TOWER_LEVEL_06 = "res/home/guide/subinterface_tower_list/level/Lv.6.png",
    PATH_SUBINTERFACE_TOWER_LEVEL_07 = "res/home/guide/subinterface_tower_list/level/Lv.7.png",
    PATH_SUBINTERFACE_TOWER_LEVEL_08 = "res/home/guide/subinterface_tower_list/level/Lv.8.png",
    PATH_SUBINTERFACE_TOWER_LEVEL_09 = "res/home/guide/subinterface_tower_list/level/Lv.9.png",
    PATH_SUBINTERFACE_TOWER_LEVEL_10 = "res/home/guide/subinterface_tower_list/level/Lv.10.png",
    PATH_SUBINTERFACE_TOWER_LEVEL_11 = "res/home/guide/subinterface_tower_list/level/Lv.11.png",
    PATH_SUBINTERFACE_TOWER_LEVEL_12 = "res/home/guide/subinterface_tower_list/level/Lv.12.png",
    PATH_SUBINTERFACE_TOWER_LEVEL_13 = "res/home/guide/subinterface_tower_list/level/Lv.13.png",
    PATH_SUBINTERFACE_TOWER_LEVEL_14 = "res/home/guide/subinterface_tower_list/level/Lv.14.png",
    PATH_SUBINTERFACE_TOWER_LEVEL_15 = "res/home/guide/subinterface_tower_list/level/Lv.15.png",
    PATH_SUBINTERFACE_TOWER_LEVEL_16 = "res/home/guide/subinterface_tower_list/level/Lv.16.png",
    PATH_SUBINTERFACE_TOWER_LEVEL_17 = "res/home/guide/subinterface_tower_list/level/Lv.17.png",
    PATH_SUBINTERFACE_TOWER_LEVEL_18 = "res/home/guide/subinterface_tower_list/level/Lv.18.png",
    PATH_SUBINTERFACE_TOWER_LEVEL_19 = "res/home/guide/subinterface_tower_list/level/Lv.19.png",
    PATH_SUBINTERFACE_TOWER_LEVEL_20 = "res/home/guide/subinterface_tower_list/level/Lv.20.png",
    -- lineup level
    PATH_SUBINTERFACE_TOWER_LINE_UP_01 = "res/home/guide/subinterface_current_lineup/level/Lv.1.png",
    PATH_SUBINTERFACE_TOWER_LINE_UP_02 = "res/home/guide/subinterface_current_lineup/level/Lv.2.png",
    PATH_SUBINTERFACE_TOWER_LINE_UP_03 = "res/home/guide/subinterface_current_lineup/level/Lv.3.png",
    PATH_SUBINTERFACE_TOWER_LINE_UP_04 = "res/home/guide/subinterface_current_lineup/level/Lv.4.png",
    PATH_SUBINTERFACE_TOWER_LINE_UP_05 = "res/home/guide/subinterface_current_lineup/level/Lv.5.png",
    PATH_SUBINTERFACE_TOWER_LINE_UP_06 = "res/home/guide/subinterface_current_lineup/level/Lv.6.png",
    PATH_SUBINTERFACE_TOWER_LINE_UP_07 = "res/home/guide/subinterface_current_lineup/level/Lv.7.png",
    PATH_SUBINTERFACE_TOWER_LINE_UP_08 = "res/home/guide/subinterface_current_lineup/level/Lv.8.png",
    PATH_SUBINTERFACE_TOWER_LINE_UP_09 = "res/home/guide/subinterface_current_lineup/level/Lv.9.png",
    PATH_SUBINTERFACE_TOWER_LINE_UP_10 = "res/home/guide/subinterface_current_lineup/level/Lv.10.png",
    PATH_SUBINTERFACE_TOWER_LINE_UP_11 = "res/home/guide/subinterface_current_lineup/level/Lv.11.png",
    PATH_SUBINTERFACE_TOWER_LINE_UP_12 = "res/home/guide/subinterface_current_lineup/level/Lv.12.png",
    PATH_SUBINTERFACE_TOWER_LINE_UP_13 = "res/home/guide/subinterface_current_lineup/level/Lv.13.png",
    PATH_SUBINTERFACE_TOWER_LINE_UP_14 = "res/home/guide/subinterface_current_lineup/level/Lv.14.png",
    PATH_SUBINTERFACE_TOWER_LINE_UP_15 = "res/home/guide/subinterface_current_lineup/level/Lv.15.png",
    PATH_SUBINTERFACE_TOWER_LINE_UP_16 = "res/home/guide/subinterface_current_lineup/level/Lv.16.png",
    PATH_SUBINTERFACE_TOWER_LINE_UP_17 = "res/home/guide/subinterface_current_lineup/level/Lv.17.png",
    PATH_SUBINTERFACE_TOWER_LINE_UP_18 = "res/home/guide/subinterface_current_lineup/level/Lv.18.png",
    PATH_SUBINTERFACE_TOWER_LINE_UP_19 = "res/home/guide/subinterface_current_lineup/level/Lv.19.png",
    PATH_SUBINTERFACE_TOWER_LINE_UP_20 = "res/home/guide/subinterface_current_lineup/level/Lv.20.png",
    --音乐音效
    PATH_LOBBY_BGM_120BPM = "sound_ogg/lobby_bgm_120bpm.ogg",
    PATH_GET_FREE_ITEM = "sound_ogg/get_free_item.ogg",
    PATH_GET_PADI_ITEM = "sound_ogg/get_paid_item.ogg",
    PATH_OPEN_BOX = "sound_ogg/open_box.ogg",
    PATH_BTN_CLICK = "sound_ogg/ui_btn_click.ogg",
    PATH_BUY_PAID_ITEM = "sound_ogg/buy_paid_item.ogg",
    --图片
    PATH_BACKGROUND_GUIDE = "res/home/guide/backgroung_guide.png",
    PATH_BASE_BATTLE = "res/home/battle/base_battle.png",
    PATH_BASE_SELECTED_TEAM = "res/home/battle/base_selected_team.png",
    PATH_BUTTON_BATTLE = "res/home/battle/button_battle.png",

    PATH_BUTTON_CLOSE = "res/home/general/second_open_confirm_popup/button_close.png",
    PATH_SECOND_BASE_POPUP = "res/home/general/second_open_treasure_popup/base_popup.png",
    PATH_SECOND_ICON_COIN = "res/home/general/second_open_treasure_popup/icon_coin.png",
    PATH_SECOND_BUTTON_CONFIRM = "res/home/general/second_open_treasure_popup/button_confirm.png",

    PATH_SECOND_MATCHING_BASE_POPUP = "res/home/battle/second_matching/base_popup.png",
    PATH_SECOND_MATCHING_BUTTON_CANCEL = "res/home/battle/second_matching/button_cancel.png",
    PATH_SECOND_MATCHING_IMAGE = "res/home/battle/second_matching/image.png",

    PATH_SECOND_OPEN_BASE_POPUP = "res/home/general/second_open_confirm_popup/base_popup.png",
    PATH_SECOND_OPEN_BUTTON_CLOSE = "res/home/general/second_open_confirm_popup/button_close.png",
    PATH_SECOND_OPEN_BUTTON_OPEN = "res/home/general/second_open_confirm_popup/button_open.png",

    PATH_ANIMATION_OPEN_TREASURE_BOX_JSON = "res/animation/out_game/open_treasure_box/open.json",
    PATH_ANIMATION_OPEN_TREASURE_BOX_ATLAS = "res/animation/out_game/open_treasure_box/open.atlas",

    PATH_SECOND_USE_TOWER_BUTTON_CANCEL = "res/home/guide/second_use_tower/BT.png",
    PATH_SECOND_USE_TOWER_BASE = "res/home/guide/second_use_tower/base.png",

    PATH_POPUP = "res/home/guide/second_tower_infor_popup/base_popup.png",
    PATH_BASE_SKILL_INTRODUCTION = "res/home/guide/second_tower_infor_popup/base_skill_introduction.png",
    PATH_SKILL_INTRODUCTION = "res/home/guide/second_tower_infor_popup/text_details/skill_introduction.png",

    PATH_TEXTURE_TYPE_1 = "res/home/guide/second_tower_infor_popup/text_details/type_1.png",
    PATH_TEXTURE_TYPE = "res/home/guide/second_tower_infor_popup/text_details/type.png",
    PATH_TEXTURE_ATK = "res/home/guide/second_tower_infor_popup/text_details/atk.png",
    PATH_TEXTURE_ATK_SPEED = "res/home/guide/second_tower_infor_popup/text_details/attack_speed.png",
    PATH_TEXTURE_SKILL_TRIGGER_TIME = "res/home/guide/second_tower_infor_popup/text_details/skill_trigger_time.png",
    PATH_TEXTURE_TARGET = "res/home/guide/second_tower_infor_popup/text_details/goal.png",
    PATH_TEXTURE_SKILL_SLOW = "res/home/guide/second_tower_infor_popup/text_details/skill_slowing_effect.png",

    PATH_SUBINTERFACE_TOWER_TYPE_ATTACK = "home/guide/subinterface_tower_list/type_attack.png",
    PATH_SUBINTERFACE_TOWER_TYPE_DISTURB = "home/guide/subinterface_tower_list/type_disturb.png",
    PATH_SUBINTERFACE_TOWER_TYPE_AUX = "home/guide/subinterface_tower_list/type_assist.png",
    PATH_SUBINTERFACE_TOWER_TYPE_CONTROL = "home/guide/subinterface_tower_list/type_control.png",

    PATH_SUBINTERFACE_TOWER_PROGRESS = "res/home/guide/subinterface_tower_list/progress_progress_fragments_number.png",
    PATH_SUBINTERFACE_TOWER_PROGRESS_BASE = "res/home/guide/subinterface_tower_list/progress_base_fragments_number.png",

    PATH_ICON_PROPERTY_TYPE = "res/home/guide/second_tower_infor_popup/icon_property/type.png",
    PATH_ICON_PROPERTY_ATK = "res/home/guide/second_tower_infor_popup/icon_property/atk.png",
    PATH_ICON_PROPERTY_ATK_SPEED = "res/home/guide/second_tower_infor_popup/icon_property/atk_speed.png",
    PATH_ICON_PROPERTY_SKILL_TRIGGER_TIME = "res/home/guide/second_tower_infor_popup/icon_property/skill_trigger_time.png",
    PATH_ICON_PROPERTY_SKILL_SLOW = "res/home/guide/second_tower_infor_popup/icon_property/slow.png",
    PATH_ICON_PROPERTY_TARGET = "res/home/guide/second_tower_infor_popup/icon_property/target.png",
    PATH_ICON_COIN = "res/home/guide/second_tower_infor_popup/icon_coin.png",

    PATH_BUTTON_INTENSIFY = "res/home/guide/second_tower_infor_popup/button_intensify.png",
    PATH_BUTTON_USE = "res/home/guide/second_tower_infor_popup/button_use.png",
    PATH_BUTTON_LEVELUP = "res/home/guide/second_tower_infor_popup/button_levelup.png",
    PATH_RATITY = "res/home/guide/second_tower_infor_popup/text_details/rarity.png",
    PATH_BASE_ATTRIBUTE_DEFAULT = "res/home/guide/second_tower_infor_popup/base_attribute_default.png",
    PATH_BASE_ATTRIBUTE_ENHANCED = "res/home/guide/second_tower_infor_popup/base_attribute_enhanced.png",

    PATH_HIGH_LADDER_BACKGROUND = "res/home/battle/high_ladder/background.png",
    PATH_HIGH_LADDER_ICON_SLIDE_LEFT = "res/home/battle/high_ladder/icon_slide_left.png",
    PATH_HIGH_LADDER_ICON_SLIDE_RIGHT = "res/home/battle/high_ladder/icon_slide_right.png",
    PATH_HIGH_LADDER_CALIBRATED_SCALE = "res/home/battle/high_ladder/calibrated scale/calibrated_scale.png",
    PATH_HIGH_LADDER_CALIBRATED_SCALE_SCALE = "res/home/battle/high_ladder/calibrated scale/scale.png",
    PATH_HIGH_LADDER_CALIBRATED_SCALE_KEY = "res/home/battle/high_ladder/calibrated scale/key.png",
    PATH_HIGH_LADDER_CALIBRATED_SCALE_CUTOFF = "res/home/battle/high_ladder/calibrated scale/cutoff/cutoff.png",
    PATH_HIGH_LADDER_CALIBRATED_SCALE_CUTOFF_SCALE = "res/home/battle/high_ladder/calibrated scale/cutoff/cutoff_scale.png",
    PATH_HIGH_LADDER_UNLOCKED_UNRECEIVED_YELLOW_BORDER = "res/home/battle/high_ladder/unlocked_unreceived_yellow_border.png",
    PATH_HIGH_LADDER_CAN_RECEIVE = "res/home/battle/high_ladder/can_receive.png",
    PATH_HIGH_LADDER_DECORATE_BAR = "res/home/battle/high_ladder/calibrated scale/rectangle.png",
    PATH_HIGH_LADDER_COIN = "res/home/battle/high_ladder/coin.png",
    PATH_HIGH_LADDER_DIAMOND = "res/home/battle/high_ladder/diamond.png",
    --
    PATH_BACKGROUND_SHOP = "home/shop/background_shop.png",
    PATH_COIN_SHOP_BASE_SHADE = "home/shop/coins_shop/base_shade.png",
    PATH_COIN_SHOP_BASE_TITLE = "home/shop/coins_shop/base_title.png",
    PATH_COIN_SHOP_BASE_REFRESH = "home/shop/coins_shop/base_remaining_refresh_time.png",
    PATH_COIN_SHOP_TIP_REFRESH = "home/shop/coins_shop/tips_remaining_refresh_time.png",
    PATH_COIN_SHOP_FREE_DIAMOND = "home/shop/coins_shop/base_free_merchandise.png",
    PATH_COIN_SHOP_ICON_FREE = "home/shop/coins_shop/icon_free.png",
    PATH_COIN_SHOP_DIAMOND = "home/shop/coins_shop/commodity_icon_diamond.png",
    PATH_COIN_SHOP_COIN = "home/shop/coins_shop/commodity_icon_coin.png",
    PATH_COIN_SHOP_BASE_FRAGMENT = "home/shop/coins_shop/base_fragments_number.png",
    PATH_COIN_SHOP_ICON_COIN = "home/shop/coins_shop/icon_coin.png",
    PATH_COIN_SHOP_STORE_TITLE = "home/shop/coins_shop/title_coin_store.png",
    PATH_COIN_SHOP_BASE_SHADE = "home/shop/coins_shop/base_shade.png",
    --
    PATH_SHOP_SECOND_PURCHASE_CONFIRM_BASE = "home/shop/second_purchase_confirmation_popup/base_popup.png",
    PATH_SHOP_SECOND_PURCHASE_CONFIRM_CLOSE = "home/shop/second_purchase_confirmation_popup/button_close.png",
    PATH_SHOP_SECOND_PURCHASE_CONFIRM_BUY = "home/shop/second_purchase_confirmation_popup/button_buy.png",
    PATH_SHOP_SECOND_PURCHASE_ICON_COIN = "home/shop/second_purchase_confirmation_popup/icon_coin.png",
    --
    PATH_COIN_SHOP_TOWER_FRAGMENT_01 = "home/shop/coins_shop/commodity_icon_tower_fragment/1.png",
    PATH_COIN_SHOP_TOWER_FRAGMENT_02 = "home/shop/coins_shop/commodity_icon_tower_fragment/2.png",
    PATH_COIN_SHOP_TOWER_FRAGMENT_03 = "home/shop/coins_shop/commodity_icon_tower_fragment/3.png",
    PATH_COIN_SHOP_TOWER_FRAGMENT_04 = "home/shop/coins_shop/commodity_icon_tower_fragment/4.png",
    PATH_COIN_SHOP_TOWER_FRAGMENT_05 = "home/shop/coins_shop/commodity_icon_tower_fragment/5.png",
    PATH_COIN_SHOP_TOWER_FRAGMENT_06 = "home/shop/coins_shop/commodity_icon_tower_fragment/6.png",
    PATH_COIN_SHOP_TOWER_FRAGMENT_07 = "home/shop/coins_shop/commodity_icon_tower_fragment/7.png",
    PATH_COIN_SHOP_TOWER_FRAGMENT_08 = "home/shop/coins_shop/commodity_icon_tower_fragment/8.png",
    PATH_COIN_SHOP_TOWER_FRAGMENT_09 = "home/shop/coins_shop/commodity_icon_tower_fragment/9.png",
    PATH_COIN_SHOP_TOWER_FRAGMENT_10 = "home/shop/coins_shop/commodity_icon_tower_fragment/10.png",
    PATH_COIN_SHOP_TOWER_FRAGMENT_11 = "home/shop/coins_shop/commodity_icon_tower_fragment/11.png",
    PATH_COIN_SHOP_TOWER_FRAGMENT_12 = "home/shop/coins_shop/commodity_icon_tower_fragment/12.png",
    PATH_COIN_SHOP_TOWER_FRAGMENT_13 = "home/shop/coins_shop/commodity_icon_tower_fragment/13.png",
    PATH_COIN_SHOP_TOWER_FRAGMENT_14 = "home/shop/coins_shop/commodity_icon_tower_fragment/14.png",
    PATH_COIN_SHOP_TOWER_FRAGMENT_15 = "home/shop/coins_shop/commodity_icon_tower_fragment/15.png",
    PATH_COIN_SHOP_TOWER_FRAGMENT_16 = "home/shop/coins_shop/commodity_icon_tower_fragment/16.png",
    PATH_COIN_SHOP_TOWER_FRAGMENT_17 = "home/shop/coins_shop/commodity_icon_tower_fragment/17.png",
    PATH_COIN_SHOP_TOWER_FRAGMENT_18 = "home/shop/coins_shop/commodity_icon_tower_fragment/18.png",
    PATH_COIN_SHOP_TOWER_FRAGMENT_19 = "home/shop/coins_shop/commodity_icon_tower_fragment/19.png",
    PATH_COIN_SHOP_TOWER_FRAGMENT_20 = "home/shop/coins_shop/commodity_icon_tower_fragment/20.png",
    --
    PATH_DIAMOND_SHOP_BASE_TITLE = "home/shop/diamond_shop/base_title.png",
    PATH_DIAMOND_SHOP_TITLE_STORE = "home/shop/diamond_shop/title_diamond_store.png",
    PATH_DIAMOND_SHOP_ICON_DIAMOND = "home/shop/diamond_shop/commodity_icon_diamond.png",
    --
    PATH_DIAMOND_SHOP_BASE_NORMAL = "home/shop/diamond_shop/base_normal.png",
    PATH_DIAMOND_SHOP_BASE_RARE = "home/shop/diamond_shop/base_rare.png",
    PATH_DIAMOND_SHOP_BASE_EPIC = "home/shop/diamond_shop/base_epic.png",
    PATH_DIAMOND_SHOP_BASE_LEGEND = "home/shop/diamond_shop/base_legend.png",
    --
    PATH_SECOND_CONFIRM_BOX_NORMAL = "res/home/general/second_open_confirm_popup/icon_box_normal.png",
    PATH_SECOND_CONFIRM_BOX_RARE = "res/home/general/second_open_confirm_popup/icon_box_rare.png",
    PATH_SECOND_CONFIRM_BOX_EPIC = "res/home/general/second_open_confirm_popup/icon_box_epic.png",
    PATH_SECOND_CONFIRM_BOX_LEGEND = "res/home/general/second_open_confirm_popup/icon_box_legend.png",
    --
    PATH_DIAMOND_SHOP_BOX_NORMAL = "home/shop/diamond_shop/box_normal.png",
    PATH_DIAMOND_SHOP_BOX_RARE = "home/shop/diamond_shop/box_rare.png",
    PATH_DIAMOND_SHOP_BOX_EPIC = "home/shop/diamond_shop/box_epic.png",
    PATH_DIAMOND_SHOP_BOX_LEGEND = "home/shop/diamond_shop/box_legend.png",
    --
    PATH_SECOND_CONFIRM_RANDOM_CARD_NORMAL = "res/home/general/second_open_confirm_popup/icon_normal.png",
    PATH_SECOND_CONFIRM_RANDOM_CARD_RARE = "res/home/general/second_open_confirm_popup/icon_rare.png",
    PATH_SECOND_CONFIRM_RANDOM_CARD_EPIC = "res/home/general/second_open_confirm_popup/icon_epic.png",
    PATH_SECOND_CONFIRM_RANDOM_CARD_LEGEND = "res/home/general/second_open_confirm_popup/icon_legend.png",
    --
    PATH_DIAMOND_SHOP_BASE_PRE = "home/shop/diamond_shop/base_",
    --
    PATH_DEFAULT_AVATAR = "home/top_player_info/default_avatar.png",
    -- TTF
    PATH_FONT_FZBIAOZJW = "res/font/fzbiaozjw.ttf",
    PATH_FONT_FZZCHJW = "font/fzzchjw.ttf",
    PATH_TTF_HZGBJW = "res/font/fzhzgbjw.ttf",
    PATH_TTF_BIAOZJW = "res/font/fzbiaozjw.ttf",
    --
    PATH_POSTFIX_PNG = ".png",


    -- string
    STR_TYPE_ATTACK = "攻击",
    STR_TYPE_DISTURB = "干扰",
    STR_TYPE_AUX = "辅助",
    STR_TYPE_CONTROL = "控制",
    --
    STR_RARITY_R = "普通",
    STR_RARITY_SR = "稀有",
    STR_RARITY_SSR = "史诗",
    STR_RARITY_UR = "传奇",
    --
    STR_ATK_TARGET_FRONT = "前方",
    STR_ATK_TARGET_BACK = "后方",
    STR_ATK_TARGET_LEFT = "左方",
    STR_ATK_TARGET_RIGHT = "右方",
    STR_ATK_TARGET_RANDOM = "随机",
    STR_ATK_TARGET_HP_FIRST = "优先血量最高",

}
return StringDef
