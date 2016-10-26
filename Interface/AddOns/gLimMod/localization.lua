-- <= == == == == == == == == == == == == =>
-- => Some Keywords
-- <= == == == == == == == == == == == == =>

GLIM_NAME = "name";
GLIM_LONGDESCRIPTION = "readme";
GLIM_ICON = "icon";
GLIM_CALLBACK = "callback";
GLIM_TYPE = "type";
GLIM_PRIORITY = "PRIORITY";

GLIM_VARIABLES = "Values";
GLIM_CONFIGTYPE = "Type";

-- <= == == == == == == == == == == == == =>
-- => Menu
-- <= == == == == == == == == == == == == =>

GLIM_VARIABLE = "VARIABLE";
GLIM_AUTHOR = "AUTHOR";
GLIM_DESCRIPTION = "DESCRIPTION";
GLIM_CONFIGTYPE = "CONFIGTYPE";
GLIM_CALLBACK = "Defaultfounction";
GLIM_DEFAULTVALUE ="DefaultValue";
GLIM_STRING ="String";
GLIM_STEPVALUE = "STEPVALUE";
GLIM_MINVALUE = "MinValue";
GLIM_MAXVALUE = "MaxValue";
GLIM_STEPTEXT = "STEPTEXT";
GLIM_SUBSTRING = "SUBSTRING";

-- <= == == == == == == == == == == == == =>
-- => Localization
-- <= == == == == == == == == == == == == =>

if ( GetLocale() == "zhCN") then
	GLIM_CONFIG_ERROR_NOVALUE = "未赋值";
	GLIM_CONFIG_ERROR_NILVALUE = "注册的值不允许为空值";
	GLIM_CONFIG_ERROR_HASBEENREGSITY = "这个参数名称已经被人注册了,作者是:";
	GLIM_CONFIG_ERROR_NAMEERROR = "你选择的大类不存在";
	GLIM_CONFIG_ERROR_STRINGRROR = "说明文字不能为空";
	GLIM_CONFIG_ERROR_CALLBACKRROR = "回调的函数不能为空";
	GLIM_CONFIG_DOWNLOADERROR = "错误,没有找到这个设置的列表";
	GLIM_CONFIG_HAVENTCONFIGERROR = "错误,没有任何的设置的值";

	GLIM_OPTIONS_TITLE = "月光宝盒";
	GLIM_OPTIONS_THANKS = "月光宝盒真心感谢你的支持!";
	GLIM_CONFIG_TOTALTITLE = "综合设置";
	GLIM_CONFIG_TITLE1 = "界面设置";
	GLIM_CONFIG_TITLE2 = "战斗职业";
	GLIM_CONFIG_TITLE3 = "商业技能";
	GLIM_CONFIG_TITLE4 = "扩展功能";
	GLIM_CONFIG_TOOLTIP_TOTALTITLE = "综合设置";
	GLIM_CONFIG_TOOLTIP_TITLE1 = "界面设置";
	GLIM_CONFIG_TOOLTIP_TITLE2 = "战斗职业";
	GLIM_CONFIG_TOOLTIP_TITLE3 = "商业技能";
	GLIM_CONFIG_TOOLTIP_TITLE4 = "扩展功能";
	GLIM_CUBE_LEFT = "左键单击打开设置菜单";
	GLIM_CUBE_RIGHT = "右键拖动改变此按钮的位置";
	GLIM_SAVE_QUESTION = "设置已经改变，是否保存？"

	GLIM_BRYAN = "黑眼圈";

	GLIM_CONFIGPAGE_PAGE = "页";
	GLIM_CONFIGPAGE_TOTAL = "共";
	GLIM_CONFIGPAGE_THE = "第";
	GLIM_CONFIGPAGE_PREV = "上一页";
	GLIM_CONFIGPAGE_NEXT = "下一页";
	GLIM_CONFIGPAGE_OKAY = "确定";
	GLIM_CONFIGPAGE_CANCLE = "取消";

	GLIM_CONFIGHEAD = "月光宝盒综合设置";

	GLIMUI_SHOWICON_TEXT = "显示迷你地图按钮";
	GLIMUI_SHOWICON_DESC = "启用吸附在迷你地图旁边的月光宝盒按钮";

	GLIMUI_ICONPOSI_TEXT = "迷你地图按钮位置";
	GLIMUI_ICONPOSI_DESC = "设置月光宝盒按钮在迷你地图按钮的位置";
	GLIMUI_ICONPOSI_CAPITON = "角度";
	GLIMUI_ICONPOSI_DEGREE = "°";

	GLIMUI_SHOWANI_TEXT = "菜单动画效果";
	GLIMUI_SHOWANI_DESC = "启用设置菜单出现时的动画效果";
	GLIMUI_FIXBUG_TEXT = "修复游戏错误";
	GLIMUI_FIXBUG_DESC = "启用游戏错误修复系统";
	GLIMUI_SHOWTIME_TEXT = "聊天窗口显示时间"
	GLIMUI_SHOWTIME_DESC = "为聊天窗口的内容增加时间标签"

	GLIMUI_ACCOUNT_TEXT = "自动填写登录帐号"
	GLIMUI_ACCOUNT_DESC = "设置在登录界面中的游戏帐号,避免每次重复输入\n请勿在公共场合使用！"
	GLIMUI_ACCOUNT_CAPTION = "设置帐号"

	GLIMUI_ACCOUNT_DESC = "设置你的游戏登录帐号\n请勿在公共场合使用！"
	GLIMUI_DISTANCE_TEXT = "距离" 
	GLIMUI_YARD_TEXT = "码"
	GLIMUI_TARGETND_TEXT = "TAB前方最远距离"
	GLIMUI_TARGETND_DESC = "TAB选择前方目标的最远距离"
	GLIMUI_TARGETNDR_TEXT = "TAB后方最远距离"
	GLIMUI_TARGETNDR_DESC = "TAB选择后方目标的最远距离"
	GLIMUI_CLRPP_TEXT = "宠物战斗信息"
	GLIMUI_CLRPP_DESC = "最大获得该范围内的宠物战斗信息"
	GLIMUI_CLRFP_TEXT = "队友战斗信息"
	GLIMUI_CLRFP_DESC = "最大获得该范围内的队友战斗信息"
	GLIMUI_CLRFPP_TEXT = "队友宠物战斗信息"
	GLIMUI_CLRFPP_DESC = "最大获得该范围内的队友宠物战斗信息"
	GLIMUI_CLRHP_TEXT = "敌对玩家战斗信息"
	GLIMUI_CLRHP_DESC = "最大获得该范围内的敌对玩家战斗信息"
	GLIMUI_CLRHPP_TEXT = "敌对玩家宠物战斗信息"
	GLIMUI_CLRHPP_DESC = "最大获得该范围内的敌对玩家宠物战斗信息"
	GLIMUI_CLRC_TEXT = "生物战斗信息"
	GLIMUI_CLRC_DESC = "最大获得该范围内的生物战斗信息"
	GLIMUI_CLRP_TEXT = "友军战斗信息"
	GLIMUI_CLRP_DESC = "最大获得该范围内的友军战斗信息"
	GLIMUI_CLLR_TEXT = "战斗死亡信息"
	GLIMUI_CLLR_DESC = "最大获得该范围内的死亡信息"

	GLIMUI_RELOADUI_TEXT = "重載所有插件"
	GLIMUI_RELOADUI_DESC = "重載所有插件，时间根据您电脑的性能决定\n比登录人物所需的时间略短"
	GLIMUI_RELOADUI_CAPTION = "立即重載"
-- <= == == == == == == == == == == == == =>
-- => Load Demand
-- <= == == == == == == == == == == == == =>
	ADDON_TITLE = "插件管理";
	ADDON_DESC = "配置您需要使用的插件";

	UI_SECTION_TITLE = "界面插件";
	UI_SECTION_DESC = "动态加载游戏需要使用的插件";

	ATLASP_TITLE = "副本地图"..COLOR_GRAY.." (Atlas)";
	ATLASP_DESC = "启用或禁用\"副本地图\"";
	ATLASLOOT_TITLE = "副本掉落"..COLOR_GRAY.." (Atlas Loot)";
	ATLASLOOT_DESC = "启用或禁用\"副本掉落\"";
	ONEBAG_TITLE = "整合背包"..COLOR_GRAY.." (My Inventory)";
	ONEBAG_DESC = "启用或禁用\"整合背包\"";
	PLAYERLINK_TITLE = "玩家链接"..COLOR_GRAY.." (FriendsMenuXP)";
	PLAYERLINK_DESC = "启用或禁用\"玩家链接\"";
	--[[
	TIPBUDDY_TITLE = "提示信息"..COLOR_GRAY.." (TipBuddy)";
	TIPBUDDY_DESC = "启用或禁用\"提示信息\"";
	]]

	COMBAT_TITLE = "战斗插件";
	COMBAT_DESC = "动态加载可供设置的战斗插件";

	ASH_TITLE = "法术计时"..COLOR_GRAY.." (ASH)";
	ASH_DESC = "启用或禁用\"法术计时\""
	SCT_TITLE = "战斗信息"..COLOR_GRAY.." (SCT)";
	SCT_DESC = "启用或禁用\"战斗信息\"";
	DAMAGEEX_TITLE = "伤害显示"..COLOR_GRAY.." (DamageEx)";
	DAMAGEEX_DESC = "启用或禁用\"伤害显示\"";
	AUTOEQUIP_TITLE = "一键换装"..COLOR_GRAY.." (Enigma Auto Equip)";
	AUTOEQUIP_DESC = "启用或禁用\"一键换装\"";

	ASSIST_TITLE = "辅助插件";
	ASSIST_DESC = "动态加载可供设置的其他插件";

	QUESTION_TITLE = "任务查询"..COLOR_GRAY.." (Quest Library)";
	QUESTION_DESC = "启用或禁用\"任务查询\"";
	MONKEYQ_TITLE = "任务监视"..COLOR_GRAY.." (MonkeyQuest)";
	MONKEYQ_DESC = "启用或禁用\"任务监视\"";
	GATHERER_TITLE = "采集助手"..COLOR_GRAY.." (Gatherer)";
	GATHERER_DESC = "启用或禁用\"采集助手\"";
	STATS_TEXT = "属性统计"..COLOR_GRAY.." (Character Status Compare)";
	STATS_DESC = "启用或禁用\"属性统计\"";

	RAID_SECTION_TITLE = "团队插件";
	RAID_SECTION_DESC = "动态加载团队需要使用的插件";

	KTM_TITLE = "仇恨统计"..COLOR_GRAY.." (KLHThreatMeter)";
	KTM_DESC = "启用或禁用\"仇恨统计\"";
	OMEN_TITLE = "仇恨统计"..COLOR_GRAY.." (Omen)";
	OMEN_DESC = "启用或禁用\"仇恨统计\"";
	DBM_TITLE = "首领模块"..COLOR_GRAY.." (Deadly Boss Mod)";
	DBM_DESC = "启用或禁用\"首领模块\"";
	CTRAID_TITLE = "团队助手"..COLOR_GRAY.." (CT RaidAssist)";
	CTRAID_DESC = "启用或禁用\"团队助手\"";
	DECURSIVE_TITLE = "一键驱散"..COLOR_GRAY.." (Decursive)";
	DECURSIVE_DESC = "启用或禁用\"一键驱散\"";
	DM_TITLE = "伤害统计"..COLOR_GRAY.." (DamageMeters)";
	DM_DESC = "启用或禁用\"伤害统计\"";
-- <= == == == == == == == == == == == == =>
-- => Class
-- <= == == == == == == == == == == == == =>
	PLAYER_CLASS_WARRIOR = "战士"
	PLAYER_CLASS_MAGE	 = "法师"
	PLAYER_CLASS_ROGUE	 = "潜行者"
	PLAYER_CLASS_DRUID	 = "德鲁伊"
	PLAYER_CLASS_HUNTER	 = "猎人"
	PLAYER_CLASS_SHAMAN	 = "萨满祭司"
	PLAYER_CLASS_PRIEST	 = "牧师"
	PLAYER_CLASS_WARLOCK = "术士"
	PLAYER_CLASS_PALADIN = "圣骑士"
-- <= == == == == == == == == == == == == =>
-- => Spell
-- <= == == == == == == == == == == == == =>
	SPELL_ARCANEINTELLECT		= "奥术智慧"
	SPELL_DAMPENMAGIC		= "魔法抑制"
	SPELL_AMPLIFYMAGIC		= "魔法增效"
	SPELL_FORTITUDE			= "真言术：韧"
	SPELL_HOLYPROTECTION		= "神圣之灵"
	SPELL_SHADOWPROTECTION	= "防护暗影"
	SPELL_MARKOFTHEWILD		= "野性印记"
	SPELL_THORNS				= "荆棘术"
	SPELL_BLESSINGOFWISDOM	= "智慧祝福"
	SPELL_BLESSINGOFMIGHT		= "力量祝福"
	SPELL_BLESSINGOFKINGS		= "王者祝福"
	SPELL_BLESSINGOFLIGHT		= "光明祝福"
	SPELL_BLESSINGOFSALVATION	= "拯救祝福"
	SPELL_DETECTINVISIBILITY	= "侦测隐形"
	SPELL_RITUALOFSUMMONING	= "召唤仪式"

elseif ( GetLocale() == "zhTW") then
	GLIM_CONFIG_ERROR_NOVALUE = "未賦值";
	GLIM_CONFIG_ERROR_NILVALUE = "註冊的值不允許為空值";
	GLIM_CONFIG_ERROR_HASBEENREGSITY = "這個參數名稱已經被人註冊了,作者是:";
	GLIM_CONFIG_ERROR_NAMEERROR = "你選擇的大類不存在";
	GLIM_CONFIG_ERROR_STRINGRROR = "說明文字不能為空";
	GLIM_CONFIG_ERROR_CALLBACKRROR = "回調的函數不能為空";
	GLIM_CONFIG_DOWNLOADERROR = "錯誤,沒有找到這個設置的列表";
	GLIM_CONFIG_HAVENTCONFIGERROR = "錯誤,沒有任何的設置的值";

	GLIM_OPTIONS_TITLE = "月光寶盒";
	GLIM_OPTIONS_THANKS = "月光寶盒真心感謝你的支持!";
	GLIM_CONFIG_TOTALTITLE = "綜合設置";
	GLIM_CONFIG_TITLE1 = "界面設置";
	GLIM_CONFIG_TITLE2 = "戰鬥職業";
	GLIM_CONFIG_TITLE3 = "商業技能";
	GLIM_CONFIG_TITLE4 = "擴展功能";
	GLIM_CONFIG_TOOLTIP_TOTALTITLE = "綜合設置";
	GLIM_CONFIG_TOOLTIP_TITLE1 = "界面設置";
	GLIM_CONFIG_TOOLTIP_TITLE2 = "戰鬥職業";
	GLIM_CONFIG_TOOLTIP_TITLE3 = "商業技能";
	GLIM_CONFIG_TOOLTIP_TITLE4 = "擴展功能";
	GLIM_CUBE_LEFT = "左鍵單擊打開設置菜單";
	GLIM_CUBE_RIGHT = "右鍵拖動改變此按鈕的位置";
	GLIM_SAVE_QUESTION = "設置已經改變，是否保存？"

	GLIM_BRYAN = "黑眼圈";

	GLIM_CONFIGPAGE_PAGE = "頁";
	GLIM_CONFIGPAGE_TOTAL = "共";
	GLIM_CONFIGPAGE_THE = "第";
	GLIM_CONFIGPAGE_PREV = "上一頁";
	GLIM_CONFIGPAGE_NEXT = "下一頁";
	GLIM_CONFIGPAGE_OKAY = "確定";
	GLIM_CONFIGPAGE_CANCLE = "取消";
	GLIM_CONFIGHEAD = "月光寶盒綜合設置";
	GLIMUI_SHOWICON_TEXT = "顯示迷你地圖按鈕";
	GLIMUI_SHOWICON_DESC = "啟用吸附在迷你地圖旁邊的月光寶盒按鈕";
	GLIMUI_ICONPOSI_TEXT = "迷你地圖按鈕位置";
	GLIMUI_ICONPOSI_DESC = "設置月光寶盒按鈕在迷你地圖按鈕的位置";
	GLIMUI_ICONPOSI_CAPITON = "角度";
	GLIMUI_ICONPOSI_DEGREE = "°";
	GLIMUI_SHOWANI_TEXT = "菜單動畫效果";
	GLIMUI_SHOWANI_DESC = "啟用設置菜單出現時的動畫效果";
	GLIMUI_FIXBUG_TEXT = "修復遊戲錯誤";
	GLIMUI_FIXBUG_DESC = "啟用遊戲錯誤修復系統";
	GLIMUI_SHOWTIME_TEXT = "聊天窗口顯示時間"
	GLIMUI_SHOWTIME_DESC = "為聊天窗口的內容增加時間標籤"

	GLIMUI_ACCOUNT_TEXT = "自動填寫登錄帳號"
	GLIMUI_ACCOUNT_DESC = "設置在登錄界面中的遊戲帳號,避免每次重複輸入\n請勿在公共場合使用！"
	GLIMUI_ACCOUNT_CAPTION = "設置帳號"
	GLIMUI_ACCOUNT_DESC = "設置你的遊戲登錄帳號\n請勿在公共場合使用！"
	GLIMUI_DISTANCE_TEXT = "距離" 
	GLIMUI_YARD_TEXT = "碼"
	GLIMUI_TARGETND_TEXT = "TAB前方最遠距離"
	GLIMUI_TARGETND_DESC = "TAB選擇前方目標的最遠距離"
	GLIMUI_TARGETNDR_TEXT = "TAB後方最遠距離"
	GLIMUI_TARGETNDR_DESC = "TAB選擇後方目標的最遠距離"
	GLIMUI_CLRPP_TEXT = "寵物戰鬥信息"
	GLIMUI_CLRPP_DESC = "最大獲得該範圍內的寵物戰鬥信息"
	GLIMUI_CLRFP_TEXT = "隊友戰鬥信息"
	GLIMUI_CLRFP_DESC = "最大獲得該範圍內的隊友戰鬥信息"
	GLIMUI_CLRFPP_TEXT = "隊友寵物戰鬥信息"
	GLIMUI_CLRFPP_DESC = "最大獲得該範圍內的隊友寵物戰鬥信息"
	GLIMUI_CLRHP_TEXT = "敵對玩家戰鬥信息"
	GLIMUI_CLRHP_DESC = "最大獲得該範圍內的敵對玩家戰鬥信息"
	GLIMUI_CLRHPP_TEXT = "敵對玩家寵物戰鬥信息"
	GLIMUI_CLRHPP_DESC = "最大獲得該範圍內的敵對玩家寵物戰鬥信息"
	GLIMUI_CLRC_TEXT = "生物戰鬥信息"
	GLIMUI_CLRC_DESC = "最大獲得該範圍內的生物戰鬥信息"
	GLIMUI_CLRP_TEXT = "友軍戰鬥信息"
	GLIMUI_CLRP_DESC = "最大獲得該範圍內的友軍戰鬥信息"
	GLIMUI_CLLR_TEXT = "戰鬥死亡信息"
	GLIMUI_CLLR_DESC = "最大獲得該範圍內的死亡信息"

	GLIMUI_RELOADUI_TEXT = "重載所有插件"
	GLIMUI_RELOADUI_DESC = "重載所有插件，時間根據您電腦的性能決定\n比登錄人物所需的時間略短"
	GLIMUI_RELOADUI_CAPTION = "立即重載"
-- <= == == == == == == == == == == == == =>
-- => Load Demand
-- <= == == == == == == == == == == == == =>
	ADDON_TITLE = "插件管理";
	ADDON_DESC = "配置您需要使用的插件";

	UI_SECTION_TITLE = "界面插件";
	UI_SECTION_DESC = "動態加載遊戲需要使用的插件";

	ATLASP_TITLE = "副本地圖"..COLOR_GRAY.." (Atlas)";
	ATLASP_DESC = "啟用或禁用\"副本地圖\"";
	ATLASLOOT_TITLE = "副本掉落"..COLOR_GRAY.." (Atlas Loot)";
	ATLASLOOT_DESC = "啟用或禁用\"副本掉落\"";
	ONEBAG_TITLE = "整合背包"..COLOR_GRAY.." (My Inventory)";
	ONEBAG_DESC = "啟用或禁用\"整合背包\"";
	PLAYERLINK_TITLE = "玩家鏈接"..COLOR_GRAY.." (FriendsMenuXP)";
	PLAYERLINK_DESC = "啟用或禁用\"玩家鏈接\"";

	COMBAT_TITLE = "戰鬥插件";
	COMBAT_DESC = "動態加載可供設置的戰鬥插件";

	ASH_TITLE = "法術計時"..COLOR_GRAY.." (ASH)";
	ASH_DESC = "啟用或禁用\"法術計時\""
	SCT_TITLE = "戰鬥信息"..COLOR_GRAY.." (SCT)";
	SCT_DESC = "啟用或禁用\"戰鬥信息\"";
	DAMAGEEX_TITLE = "傷害顯示"..COLOR_GRAY.." (DamageEx)";
	DAMAGEEX_DESC = "啟用或禁用\"傷害顯示\"";
	AUTOEQUIP_TITLE = "一鍵換裝"..COLOR_GRAY.." (Enigma Auto Equip)";
	AUTOEQUIP_DESC = "啟用或禁用\"一鍵換裝\"";

	ASSIST_TITLE = "輔助插件";
	ASSIST_DESC = "動態加載可供設置的其他插件";

	QUESTION_TITLE = "任務查詢"..COLOR_GRAY.." (Quest Library)";
	QUESTION_DESC = "啟用或禁用\"任務查詢\"";
	MONKEYQ_TITLE = "任務監視"..COLOR_GRAY.." (MonkeyQuest)";
	MONKEYQ_DESC = "啟用或禁用\"任務監視\"";
	GATHERER_TITLE = "採集助手"..COLOR_GRAY.." (Gatherer)";
	GATHERER_DESC = "啟用或禁用\"採集助手\"";
	STATS_TEXT = "屬性統計"..COLOR_GRAY.." (Character Status Compare)";
	STATS_DESC = "啟用或禁用\"屬性統計\"";

	RAID_SECTION_TITLE = "團隊插件";
	RAID_SECTION_DESC = "動態加載團隊需要使用的插件";

	KTM_TITLE = "仇恨統計"..COLOR_GRAY.." (KLHThreatMeter)";
	KTM_DESC = "啟用或禁用\"仇恨統計\"";
	OMEN_TITLE = "仇恨統計"..COLOR_GRAY.." (Omen2)";
	OMEN_DESC = "启用或禁用\"仇恨统计\"";
	DBM_TITLE = "首領模塊"..COLOR_GRAY.." (Deadly Boss Mod)";
	DBM_DESC = "啟用或禁用\"首領模塊\"";
	CTRAID_TITLE = "團隊助手"..COLOR_GRAY.." (CT RaidAssist)";
	CTRAID_DESC = "啟用或禁用\"團隊助手\"";
	DECURSIVE_TITLE = "一鍵驅散"..COLOR_GRAY.." (Decursive)";
	DECURSIVE_DESC = "啟用或禁用\"一鍵驅散\"";
	DM_TITLE = "傷害統計"..COLOR_GRAY.." (DamageMeters)";
	DM_DESC = "啟用或禁用\"傷害統計\"";
-- <= == == == == == == == == == == == == =>
-- => Class
-- <= == == == == == == == == == == == == =>
	PLAYER_CLASS_WARRIOR = "戰士"
	PLAYER_CLASS_MAGE    = "法師"
	PLAYER_CLASS_ROGUE   = "盜賊"
	PLAYER_CLASS_DRUID   = "德魯伊"
	PLAYER_CLASS_HUNTER  = "獵人"
	PLAYER_CLASS_SHAMAN  = "薩滿"
	PLAYER_CLASS_PRIEST  = "牧師"
	PLAYER_CLASS_WARLOCK = "術士"
	PLAYER_CLASS_PALADIN = "聖騎士"
-- <= == == == == == == == == == == == == =>
-- => Spell
-- <= == == == == == == == == == == == == =>
	SPELL_ARCANEINTELLECT		= "奧術智慧"
	SPELL_DAMPENMAGIC		= "魔法抑制"
	SPELL_AMPLIFYMAGIC		= "魔法增效"
	SPELL_FORTITUDE			= "真言術:韌"
	SPELL_HOLYPROTECTION		= "神聖之靈"
	SPELL_SHADOWPROTECTION	= "防護暗影"
	SPELL_MARKOFTHEWILD		= "野性印記"
	SPELL_THORNS				= "荊棘術"
	SPELL_BLESSINGOFWISDOM	= "智慧祝福"
	SPELL_BLESSINGOFMIGHT		= "力量祝福"
	SPELL_BLESSINGOFKINGS		= "王者祝福"
	SPELL_BLESSINGOFLIGHT		= "光明祝福"
	SPELL_BLESSINGOFSALVATION	= "拯救祝福"
	SPELL_DETECTINVISIBILITY	= "偵測隱形"
	SPELL_RITUALOFSUMMONING	= "召喚儀式"

else
	GLIM_CONFIG_ERROR_NOVALUE = "no value";
	GLIM_CONFIG_ERROR_NILVALUE = "Error this glim values not primt nil value";
	GLIM_CONFIG_ERROR_HASBEENREGSITY = "this values has been regsity for :";
	GLIM_CONFIG_ERROR_NAMEERROR = "You Regsity class not haven";
	GLIM_CONFIG_ERROR_STRINGRROR = "CheckBOX's ReadME not primt nil value";
	GLIM_CONFIG_ERROR_CALLBACKRROR = "CALLBACK FUNCTON not primt nil value";
	GLIM_CONFIG_DOWNLOADERROR = "ERROR not that CONFIGS LIST";
	GLIM_CONFIG_HAVENTCONFIGERROR = "ERROR HAVEN'T CONFIG";

	GLIM_OPTIONS_TITLE = "gLimMod";
	GLIM_OPTIONS_THANKS = "gLimMod Thanks for your care!";
	GLIM_CONFIG_TOTALTITLE = "Mod Settings";
	GLIM_CONFIG_TITLE1 = "UI";
	GLIM_CONFIG_TITLE2 = "Combat&Profession";
	GLIM_CONFIG_TITLE3 = "Business";
	GLIM_CONFIG_TITLE4 = "Misc";
	GLIM_CONFIG_TOOLTIP_TOTALTITLE = "All Settings";
	GLIM_CONFIG_TOOLTIP_TITLE1 = "UI";
	GLIM_CONFIG_TOOLTIP_TITLE2 = "Combat&Profession";
	GLIM_CONFIG_TOOLTIP_TITLE3 = "Business";
	GLIM_CONFIG_TOOLTIP_TITLE4 = "Misc";
	GLIM_CUBE_LEFT = "Left toggle menu";
	GLIM_CUBE_RIGHT = "Right Button drag this button";
	GLIM_SAVE_QUESTION = "The setting was changed, save it ?"

	GLIM_BRYAN = "Bryan";

	GLIM_CONFIGPAGE_PAGE = "Page";
	GLIM_CONFIGPAGE_TOTAL = "Total";
	GLIM_CONFIGPAGE_THE = "The";
	GLIM_CONFIGPAGE_PREV = "Prev";
	GLIM_CONFIGPAGE_NEXT = "Next";
	GLIM_CONFIGPAGE_OKAY = "Okay";
	GLIM_CONFIGPAGE_CANCLE = "Cancel";

	GLIM_CONFIGHEAD = "gLimMod Setting";
	GLIMUI_SHOWICON_TEXT = "Show gLimMod Button";
	GLIMUI_SHOWICON_DESC = "Show gLioMod Button on Minimap";
	GLIMUI_ICONPOSI_TEXT = "Set Positon of ";
	GLIMUI_ICONPOSI_DESC = "Setting gLimMod button position on minimap";
	GLIMUI_ICONPOSI_CAPITON = "Degree";
	GLIMUI_ICONPOSI_DEGREE = "°";
	GLIMUI_SHOWANI_TEXT = "Animation menu";
	GLIMUI_SHOWANI_DESC = "show glimMod menu use animation";
	GLIMUI_FIXBUG_TEXT = "Fix WoW Bugs";
	GLIMUI_FIXBUG_DESC = "gLimMod fix WoW Bugs";
	GLIMUI_SHOWTIME_TEXT = "Show ChatFrame Time"
	GLIMUI_SHOWTIME_DESC = "Add Time tag for ChatFrame text"

	GLIMUI_ACCOUNT_TEXT = "Autofill Login Account"
	GLIMUI_ACCOUNT_DESC = "Setting the game account at login screen\ndon't use public computer"
	GLIMUI_ACCOUNT_CAPTION = "Set Account"
	GLIMUI_ACCOUNT_DESC = "Set your account name\ndon't use public computer!"
	GLIMUI_DISTANCE_TEXT = "distance" 
	GLIMUI_YARD_TEXT = "yard"
	GLIMUI_TARGETND_TEXT = "Tab targetting distance"
	GLIMUI_TARGETND_DESC = "Tab targetting distance in front of you"
	GLIMUI_TARGETNDR_TEXT = "Tab targetting Radius"
	GLIMUI_TARGETNDR_DESC = "Tab targetting distance behind you"
	GLIMUI_CLRPP_TEXT = "The pet combat info"
	GLIMUI_CLRPP_DESC = "The range of pet combat info"
	GLIMUI_CLRFP_TEXT = "The party combat info"
	GLIMUI_CLRFP_DESC = "The range of party combat info"
	GLIMUI_CLRFPP_TEXT = "The party's pet combat info"
	GLIMUI_CLRFPP_DESC = "The range of party's pet combat info"
	GLIMUI_CLRHP_TEXT = "The hostile combat info"
	GLIMUI_CLRHP_DESC = "The range of hostile combat info"
	GLIMUI_CLRHPP_TEXT = "The hostile's pet combat info"
	GLIMUI_CLRHPP_DESC = "The range of hostile's pet combat info"
	GLIMUI_CLRC_TEXT = "The creature combat info"
	GLIMUI_CLRC_DESC = "The range of creature combat info"
	GLIMUI_CLRP_TEXT = "The friendly combat info"
	GLIMUI_CLRP_DESC = "The range of friendly combat info"
	GLIMUI_CLLR_TEXT = "The death info"
	GLIMUI_CLLR_DESC = "The range of death info"

	GLIMUI_RELOADUI_TEXT = "Reload UI"
	GLIMUI_RELOADUI_DESC = "Reload UI, need some time like logon your character"
	GLIMUI_RELOADUI_CAPTION = "Now!"
-- <= == == == == == == == == == == == == =>
-- => Load Demand
-- <= == == == == == == == == == == == == =>
	ADDON_TITLE = "AddOns Manage";
	ADDON_DESC = "Configure the addons of you needs";

	UI_SECTION_TITLE = "Interface Mods";
	UI_SECTION_DESC = "Configure Interface AddOns";

	ATLASP_TITLE = "Atlas";
	ATLASP_DESC = "Enable or Disable \"Atlas\"";
	ATLASLOOT_TITLE = "AtlasLoot";
	ATLASLOOT_DESC = "Enable or Disable \"AtlasLoot\"";
	ONEBAG_TITLE = "My Inventory";
	ONEBAG_DESC = "Enable or Disable \"My Inventory\"";
	PLAYERLINK_TITLE = "FriendsMenuXP";
	PLAYERLINK_DESC = "Enable or Disable \"FriendsMenuXP\"";

	COMBAT_TITLE = "Combat Mods";
	COMBAT_DESC = "Configure Combat AddOns";

	ASH_TITLE = "Ash_Core";
	ASH_DESC = "Enable or Disable \"Ash_Core\"";
	SCT_TITLE = "CombatSct";
	SCT_DESC = "Enable or Disable \"CombatSct\"";
	DAMAGEEX_TITLE = "DagameEx";
	DAMAGEEX_DESC = "Enable or Disable \"DagameEx\"";
	AUTOEQUIP_TITLE = "Enigma Auto Equip";
	AUTOEQUIP_DESC = "Enable or Disable \"Enigma Auto Equip\"";

	ASSIST_TITLE = "Assist Mods";
	ASSIST_DESC = "Configure assist AddOns";

	QUESTION_TITLE = "QuestLibrary";
	QUESTION_DESC = "Enable or Disable \"QuestLibrary\"";
	MONKEYQ_TITLE = "MonkeyQuest";
	MONKEYQ_DESC = "Enable or Disable \"MonkeyQuest\"";
	GATHERER_TITLE = "Gatherer";
	GATHERER_DESC = "Enable or Disable \"Gatherer\"";
	STATS_TEXT = "Character Status Compare";
	STATS_DESC = "Enable or Disable \"Character Status Compare\"";

	RAID_SECTION_TITLE = "Raid Mods";
	RAID_SECTION_DESC = "Configure Raid AddOns";

	KTM_TITLE = "KLHThreatMeter";
	KTM_DESC = "Enable or Disable \"KLHThreatMeter\"";
	OMEN_TITLE = "(Omen2)";
	OMEN_DESC = "Enable or Disable \"Omen2\"";
	DBM_TITLE = "Deadly Boss Mod";
	DBM_DESC = "Enable or Disable \"Deadly Boss Mod\"";
	CTRAID_TITLE = "CT RaidAssist";
	CTRAID_DESC = "Enable or Disable \"CT RaidAssist\"";
	DECURSIVE_TITLE = "Decursive";
	DECURSIVE_DESC = "Enable or Disable \"Decursive\"";
	DM_TITLE = "Damage Meters";
	DM_DESC = "Enable or Disable \"Damage Meters\"";
-- <= == == == == == == == == == == == == =>
-- => Class
-- <= == == == == == == == == == == == == =>
	PLAYER_CLASS_WARRIOR  = "Warrior"
	PLAYER_CLASS_MAGE	  = "Mage"
	PLAYER_CLASS_ROGUE	  = "Rogue"
	PLAYER_CLASS_DRUID	  = "Druid"
	PLAYER_CLASS_HUNTER	  = "Hunter"
	PLAYER_CLASS_SHAMAN	  = "Shaman"
	PLAYER_CLASS_PRIEST	  = "Priest"
	PLAYER_CLASS_WARLOCK  = "Warlock"
	PLAYER_CLASS_PALADIN  = "Paladin"
-- <= == == == == == == == == == == == == =>
-- => Spell
-- <= == == == == == == == == == == == == =>
	SPELL_ARCANEINTELLECT		= "Arcane Intellect"
	SPELL_DAMPENMAGIC		= "Dampen Magic"
	SPELL_AMPLIFYMAGIC		= "Amplify Magic"
	SPELL_FORTITUDE			= "Power Word: Fortitude"
	SPELL_HOLYPROTECTION		= "Holy Protection"		--神圣之灵
	SPELL_SHADOWPROTECTION	= "Shadow Protection"
	SPELL_MARKOFTHEWILD		= "Mark of the Wild"
	SPELL_THORNS				= "Thorns"
	SPELL_BLESSINGOFWISDOM	= "Blessing of Wisdom"
	SPELL_BLESSINGOFMIGHT		= "Blessing of Might"
	SPELL_BLESSINGOFKINGS		= "Blessing of Kings"		--王者祝福
	SPELL_BLESSINGOFLIGHT		= "Blessing of Light"		--光明祝福
	SPELL_BLESSINGOFSALVATION	= "Blessing of Salvation"	--拯救祝福
	SPELL_DETECTINVISIBILITY	= "Detect Invisibility"
	SPELL_RITUALOFSUMMONING	= "Ritual of Summoning"
end

