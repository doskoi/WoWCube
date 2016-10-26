﻿-- Version : Simplified Chinese
-- Translated by Yeachan
-- Email:yeachan@live.com

function TitanLocalizeCN()
     TITAN_DEBUG = "<Titan>";
     TITAN_INFO = "<Titan>"
     
	   TITAN_NA = "N/A";
	   TITAN_SECONDS = "秒";
	   TITAN_MINUTES = "分";
	   TITAN_HOURS = "小时";
	   TITAN_DAYS = "天";
	   TITAN_SECONDS_ABBR = "秒";
	   TITAN_MINUTES_ABBR = "分";
	   TITAN_HOURS_ABBR = "小时";
	   TITAN_DAYS_ABBR = "天";
	   TITAN_MILLISECOND = "毫秒";
	   TITAN_KILOBYTES_PER_SECOND = "KB/s";
	   TITAN_KILOBITS_PER_SECOND = "kbps"
	   TITAN_MEGABYTE = "MB";
     TITAN_NONE = "无";
     
     TITAN_MOVABLE_TOOLTIP = "点击拖动";

     TITAN_PANEL_ERROR_DUP_PLUGIN = " 被注册两次. 这可能使Titan失效，请重载以修复这个问题.";
     TITAN_PANEL_ERROR_PROF_DELCURRENT = "你无法删除你当前的配置设置.";
     TITAN_PANEL_RESET_WARNING = GREEN_FONT_COLOR_CODE.."警告:"..FONT_COLOR_CODE_CLOSE.."这个选项将把面板的设置重置为默认值并且会重建你的配置文件。确定请按 '接受' (将重载界面), 取消请按 '取消' 或 'Esc' 键.";
     
     -- slash command help
     TITAN_PANEL_SLASH_STRING2 = LIGHTYELLOW_FONT_COLOR_CODE.."用法: |cffffffff/titan {reset | reset tipfont/tipalpha/panelscale/spacing}";
     TITAN_PANEL_SLASH_STRING3 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset: |cffffffff重置面板到默认值.";
     TITAN_PANEL_SLASH_STRING4 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset tipfont: |cffffffff重置面板的提示文字大小缩放.";
     TITAN_PANEL_SLASH_STRING5 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset tipalpha: |cffffffff重置面板说明文字的透明度.";
     TITAN_PANEL_SLASH_STRING6 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset panelscale: |cffffffff重置面板缩放到默认值.";
     TITAN_PANEL_SLASH_STRING7 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset spacing: |cffffffff重置面板按钮的间隔到默认值.";
     TITAN_PANEL_SLASH_STRING8 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."gui control: |cffffffff打开Ace3控制台.";
     TITAN_PANEL_SLASH_STRING9 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."gui trans: |cffffffff打开Ace3透明度控制台.";
     TITAN_PANEL_SLASH_STRING10 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."gui skin: |cffffffff打开Ace3皮肤控制台.";
     TITAN_PANEL_SLASH_STRING11 = LIGHTYELLOW_FONT_COLOR_CODE.."想获得BonusScanner的帮助信息, type : |cffffffff/bscan";
     
     -- slash command responses
     TITAN_PANEL_SLASH_RESP1 = LIGHTYELLOW_FONT_COLOR_CODE.."Titan 提示文字缩放已被重置.";
     TITAN_PANEL_SLASH_RESP2 = LIGHTYELLOW_FONT_COLOR_CODE.."Titan 提示的透明度已被重置.";
     TITAN_PANEL_SLASH_RESP3 = LIGHTYELLOW_FONT_COLOR_CODE.."Titan 面板的缩放已被重置.";
     TITAN_PANEL_SLASH_RESP4 = LIGHTYELLOW_FONT_COLOR_CODE.."Titan 面板的按钮间距已被重置.";
     
     -- general panel locale
     TITAN_PANEL = "Titan 面板";
     TITAN_PANEL_VERSION_INFO = "|cffff8c00Titan Dev Team |cffffffff Presents ".." |cffffffff(HonorGoG, joejanko, Lothayer, Tristanian, oXidFoX, urnati & StingerSoft，Yeachan)";     
     TITAN_PANEL_MENU_TITLE = "Titan 面板";
     TITAN_PANEL_MENU_HIDE = "隐藏";
     TITAN_PANEL_MENU_CUSTOMIZE = "设置";
     TITAN_PANEL_MENU_IN_COMBAT_LOCKDOWN = "(战斗中)";
     TITAN_PANEL_MENU_RELOADUI = "(将重载界面)";
     TITAN_PANEL_MENU_SHOW_COLORED_TEXT = "显示彩色文本";
     TITAN_PANEL_MENU_SHOW_ICON = "显示图标";
     TITAN_PANEL_MENU_SHOW_LABEL_TEXT = "显示名称";
     TITAN_PANEL_MENU_AUTOHIDE = "自动隐藏";
     TITAN_PANEL_MENU_BGMINIMAP = "战场微缩地图";
     TITAN_PANEL_MENU_CENTER_TEXT = "文字居中";
     TITAN_PANEL_MENU_DISPLAY_ONTOP = "显示在顶部";
     TITAN_PANEL_MENU_DISPLAY_BOTH = "同时显示2个titan条";
     TITAN_PANEL_MENU_DISABLE_PUSH = "禁用自动适应屏幕";
     TITAN_PANEL_MENU_DISABLE_MINIMAP_PUSH = "禁用微缩地图自动出现";
     TITAN_PANEL_MENU_DISABLE_LOGS = "自动记录";
     TITAN_PANEL_MENU_BUILTINS = "Titan内置插件";
     TITAN_PANEL_MENU_LEFT_SIDE = "左侧";
     TITAN_PANEL_MENU_RIGHT_SIDE = "右侧";
     TITAN_PANEL_MENU_PROFILES = "配置";
     TITAN_PANEL_MENU_PROFILE = "配置";
     TITAN_PANEL_MENU_PROFILE_CUSTOM = "个人";
     TITAN_PANEL_MENU_PROFILE_DELETED = " 已删除.";
     TITAN_PANEL_MENU_PROFILE_SERVERS = "服务器";
     TITAN_PANEL_MENU_PROFILE_CHARS = "角色";
     TITAN_PANEL_MENU_PROFILE_RELOADUI = "按下 '确定' 界面将重载来保存你的个人配置.";
     TITAN_PANEL_MENU_PROFILE_SAVE_CUSTOM_TITLE = "为你的配置文件输入一个名称:\n(20字符限制，不能有空格)";
     TITAN_PANEL_MENU_PROFILE_SAVE_PENDING = "现有设置已经被保存为配置文件: ";
     TITAN_PANEL_MENU_PROFILE_ALREADY_EXISTS = "配置文件名称已存在. 你确定要覆盖它? 按 '接受' 确定, 按 '取消' 取消.";
     TITAN_PANEL_MENU_MANAGE_SETTINGS = "加载配置";
     TITAN_PANEL_MENU_LOAD_SETTINGS = "载入";
     TITAN_PANEL_MENU_DELETE_SETTINGS = "删除";
     TITAN_PANEL_MENU_SAVE_SETTINGS = "保存";
     TITAN_PANEL_MENU_DOUBLE_BAR = "双信息条";
     TITAN_PANEL_MENU_CONFIGURATION = "配置设置";
     TITAN_PANEL_MENU_OPTIONS = "选项";
     TITAN_PANEL_MENU_OPTIONS_PANEL = "面板";
     TITAN_PANEL_MENU_OPTIONS_BARS = "Titan条";
     TITAN_PANEL_MENU_OPTIONS_TOOLTIPS = "提示说明";
     TITAN_PANEL_MENU_OPTIONS_FRAMES = "框体";
     TITAN_PANEL_MENU_OPTIONS_LDB = "数据统计";
     TITAN_PANEL_MENU_PLUGINS = "模块";
     TITAN_PANEL_MENU_LOCK_BUTTONS = "锁定按钮";
     TITAN_PANEL_MENU_VERSION_SHOWN = "显示插件版本";
     TITAN_PANEL_MENU_LDB_SHOWN = "在菜单中添加统计后缀";
     TITAN_PANEL_MENU_LDB_SIDE = "模块置于右侧";
     TITAN_PANEL_MENU_LDB_FORCE_LAUNCHER = "强制置于右侧";
     TITAN_PANEL_MENU_DISABLE_FONT = "禁用字体缩放";
     TITAN_PANEL_MENU_CATEGORIES = {"常规插件","战斗插件","信息插件","界面插件","专业技能插件"}
     TITAN_PANEL_MENU_TOOLTIPS_SHOWN = "显示提示信息";
     TITAN_PANEL_MENU_TOOLTIPS_SHOWN_IN_COMBAT = "战斗中隐藏提示信息";
     TITAN_PANEL_MENU_CASTINGBAR = "移动施法条";
     TITAN_PANEL_MENU_RESET = "重置泰坦面板";
     TITAN_PANEL_MENU_TEXTURE_SETTINGS = "样式设置";     
     TITAN_PANEL_MENU_FONT = "字体样式";
     TITAN_PANEL_MENU_LSM_FONTS = "LibSharedMedia库 字体样式"
     TITAN_PANEL_MENU_ENABLED = "启用";
     TITAN_PANEL_MENU_DISABLED = "禁用";
     
     -- localization strings for AceConfigDialog-3.0     
		 TITAN_PANEL_CONFIG_MAIN_LABEL = "信息显示插件. 允许用户在屏幕上方或下方的信息条上添加扩展模块.";			 
		 TITAN_TRANS_MENU_TEXT_SHORT = "透明度";
		 TITAN_TRANS_MENU_DESC = "用于设置Titan及其提示的透明度.";		
		 TITAN_TRANS_MAIN_CONTROL_TITLE = "主信息条";
     TITAN_TRANS_AUX_CONTROL_TITLE = "底部信息条";
     TITAN_TRANS_CONTROL_TITLE_TOOLTIP = "提示说明";		 
		 TITAN_TRANS_MAIN_BAR_DESC = "设置主信息条透明度.";
		 TITAN_TRANS_AUX_BAR_DESC = "设置附属信息条的透明度.";
		 TITAN_TRANS_TOOLTIP_DESC = "设置模块的提示说明透明度.";
		 TITAN_UISCALE_MENU_TEXT = "Titan面板设置";
		 TITAN_UISCALE_CONTROL_TITLE_UI = "界面缩放";
		 TITAN_UISCALE_CONTROL_TITLE_PANEL = "Titan面板缩放";
		 TITAN_UISCALE_CONTROL_TITLE_BUTTON = "按钮间距";
		 TITAN_UISCALE_CONTROL_TOOLTIP_TOOLTIPFONT = "提示文字缩放";
		 TITAN_UISCALE_TOOLTIP_DISABLE_TEXT = "禁用提示文字缩放";		 
		 TITAN_UISCALE_MENU_DESC = "设置Titan面板和插件的外观.";
		 TITAN_UISCALE_SLIDER_DESC = "控制你所有插件的缩放.";
		 TITAN_UISCALE_PANEL_SLIDER_DESC = "设置Titan面板的按钮和图标缩放.";
		 TITAN_UISCALE_BUTTON_SLIDER_DESC = "调整左侧模块的间距.";
		 TITAN_UISCALE_TOOLTIP_SLIDER_DESC = "调整Titan的扩展模块的提示说明缩放.";
		 TITAN_UISCALE_DISABLE_TOOLTIP_DESC = "禁用Titan的提示文字缩放.";
		 TITAN_SKINS_MAIN_DESC = "管理Titan信息条的皮肤.";
		 TITAN_SKINS_LIST_TITLE = "皮肤列表";
		 TITAN_SKINS_SET_DESC = "给Titan信息条选择一个皮肤.";
		 TITAN_SKINS_SET_HEADER = "设置面板皮肤";
		 TITAN_SKINS_NEW_HEADER = "添加新皮肤";
		 TITAN_SKINS_NAME_TITLE = "皮肤名称";
		 TITAN_SKINS_NAME_DESC = "为新皮肤输入一个名称.";
		 TITAN_SKINS_NAME_EXAMPLE = "例如: 我的Titan皮肤";
		 TITAN_SKINS_PATH_TITLE = "皮肤路径";
		 TITAN_SKINS_PATH_DESC = "输入皮肤的准确路径, 如范例所示.";
		 TITAN_SKINS_PATH_EXAMPLE = "例如: Interface\\AddOns\\Titan\\Artwork\\Custom\\<My Skin folder>\\";
		 TITAN_SKINS_ADD_HEADER = "添加皮肤";
		 TITAN_SKINS_ADD_DESC = "添加一个新皮肤到面板可用皮肤列表.";
		 TITAN_SKINS_REMOVE_HEADER = "删除皮肤";
		 TITAN_SKINS_REMOVE_DESC = "从面板可用皮肤列表删除一个皮肤.";
		 TITAN_SKINS_REMOVE_BUTTON = "删除";
		 TITAN_SKINS_REMOVE_BUTTON_DESC = "从面板可用皮肤列表删除一个皮肤.";
		 TITAN_SKINS_NOTES = "|cff19ff19说明:|r 当添加一个新的皮肤，请一定确保在载入魔兽世界之前，你想要的皮肤文件已经存在于一个文件夹，并且绝对路径一定要含有 '\\'.";
		 -- /end localization strings for AceConfigDialog-3.0
     
     TITAN_AUTOHIDE_TOOLTIP = "面板自动隐藏 开/关";
     TITAN_AUTOHIDE_MENU_TEXT = "自动隐藏";
     
     TITAN_AMMO_FORMAT = "%d";
     TITAN_AMMO_BUTTON_LABEL_AMMO = "弹药: ";
     TITAN_AMMO_BUTTON_LABEL_THROWN = "投掷武器: ";
     TITAN_AMMO_BUTTON_LABEL_AMMO_THROWN = "弹药/投掷武器: ";
     TITAN_AMMO_TOOLTIP = "已装备的弹药和投掷武器计数";
     TITAN_AMMO_MENU_TEXT = "弹药/投掷武器";
     TITAN_AMMO_BUTTON_NOAMMO = "无弹药";
     TITAN_AMMO_MENU_REFRESH = "刷新";
     TITAN_AMMO_BULLET_NAME = "Show ammo name";
     
     TITAN_BAG_FORMAT = "%d/%d";
     TITAN_BAG_BUTTON_LABEL = "背包: ";
     TITAN_BAG_TOOLTIP = "背包状态";
     TITAN_BAG_TOOLTIP_HINTS = "提示: 左键点击打开所有背包.";
     TITAN_BAG_MENU_TEXT = "背包监视";
     TITAN_BAG_USED_SLOTS = "已用空间";
     TITAN_BAG_FREE_SLOTS = "剩余空间";
     TITAN_BAG_BACKPACK = "背包";
     TITAN_BAG_MENU_SHOW_USED_SLOTS = "显示已用空间";
     TITAN_BAG_MENU_SHOW_AVAILABLE_SLOTS = "显示可用空间";
     TITAN_BAG_MENU_SHOW_DETAILED = "显示详细的提示信息";
     TITAN_BAG_MENU_IGNORE_AMMO_POUCH_SLOTS = "忽略弹药包空间";
     TITAN_BAG_MENU_IGNORE_SHARD_BAGS_SLOTS = "忽略灵魂袋空间";
     TITAN_BAG_MENU_IGNORE_PROF_BAGS_SLOTS = "忽略各专业背包空间";
     TITAN_BAG_SHARD_BAG_NAMES = {"灵魂袋", "小灵魂袋", "灵魂箱", "恶魔布包", "熔火恶魔布包", "黑色暗影背包", "深渊背包"};
     TITAN_BAG_AMMO_POUCH_NAMES = {"裂蹄牛皮箭袋", "座狼皮箭袋", "龙筋箭袋", "蛛魔强固箭袋", "千羽箭袋", "结缔皮箭袋", "鹰身人皮箭袋", "雷布里的箭袋", "快捷箭袋", "重型箭袋", "守夜人箭袋", "狩猎箭袋", "中型箭袋", "轻皮箭袋", "小箭袋", "轻型箭袋", "走私者的弹药包", "龙鳞弹药包", "结缔皮弹药包", "虚空鳞片弹药包", "豺狼人皮弹药包", "厚皮弹药包", "重皮弹药包", "守夜人的弹药包", "中型弹药包", "猎枪弹药包", "轻皮弹药包", "小型弹药包"};
     TITAN_BAG_PROF_BAG_NAMES = {"魔化魔纹布包", "魔化符文布包", "大附魔袋", "附魔师之袋", "神秘背包", "魔焰背包", "氪金工具箱", "魔铁工具", "重工具箱", "宝石袋", "珠宝袋", "加固矿工袋", "矿物包", "猛犸皮矿石包", "制皮匠的背包", "大皮袋", "猎户的旅行背包", "草药袋", "塞纳里奥草药包", "塞纳留斯之袋", "麦卡的草药包", "抄写员的背包", "无尽口袋"};

     TITAN_BGMINIMAP_MENU_TEXT = "战场作战地图"
     TITAN_BGMINIMAP_TOOLTIP = "打开战场作战地图"
     
     TITAN_CLOCK_TOOLTIP = "时钟";     
     TITAN_CLOCK_TOOLTIP_VALUE = "与服务器的时差: ";
     TITAN_CLOCK_TOOLTIP_LOCAL_TIME = "本地时间: ";
     TITAN_CLOCK_TOOLTIP_SERVER_TIME = "服务器时间: ";
     TITAN_CLOCK_TOOLTIP_SERVER_ADJUSTED_TIME = "修正服务器时间: ";
     TITAN_CLOCK_TOOLTIP_HINT1 = "提示: 左键单击来修正时间"
     TITAN_CLOCK_TOOLTIP_HINT2 = "(仅服务器时间) 24小时模式.";
     TITAN_CLOCK_TOOLTIP_HINT3 = "Shift+左键单击 打开/关闭日历.";
     TITAN_CLOCK_CONTROL_TOOLTIP = "服务器时差: ";
     TITAN_CLOCK_CONTROL_TITLE = "时差";
     TITAN_CLOCK_CONTROL_HIGH = "+12";
     TITAN_CLOCK_CONTROL_LOW = "-12";
     TITAN_CLOCK_CHECKBUTTON = "24小时制";
     TITAN_CLOCK_CHECKBUTTON_TOOLTIP = "切换 12/24 小时制显示";
     TITAN_CLOCK_MENU_TEXT = "时钟";
     TITAN_CLOCK_MENU_LOCAL_TIME = "显示本地时间";
     TITAN_CLOCK_MENU_SERVER_TIME = "显示服务器时间";
     TITAN_CLOCK_MENU_SERVER_ADJUSTED_TIME = "显示修正后的服务器时间";
     TITAN_CLOCK_MENU_DISPLAY_ON_RIGHT_SIDE = "在最右侧显示";
     TITAN_CLOCK_MENU_HIDE_GAMETIME = "隐藏 时间/日历 按钮";
     
     TITAN_COORDS_FORMAT = "(%.d, %.d)";
     TITAN_COORDS_FORMAT2 = "(%.1f, %.1f)";
     TITAN_COORDS_FORMAT3 = "(%.2f, %.2f)";
     TITAN_COORDS_FORMAT_LABEL = "(xx , yy)";
     TITAN_COORDS_FORMAT2_LABEL = "(xx.x , yy.y)";
     TITAN_COORDS_FORMAT3_LABEL = "(xx.xx , yy.yy)";
     TITAN_COORDS_FORMAT_COORD_LABEL = "坐标格式";
     TITAN_COORDS_BUTTON_LABEL = "位置: ";
     TITAN_COORDS_TOOLTIP = "所在位置信息";
     TITAN_COORDS_TOOLTIP_HINTS_1 = "提示: Shift + 左键单击添加所在位置";
     TITAN_COORDS_TOOLTIP_HINTS_2 = "信息到聊天窗口.";
     TITAN_COORDS_TOOLTIP_ZONE = "区域: ";
     TITAN_COORDS_TOOLTIP_SUBZONE = "具体地点: ";
     TITAN_COORDS_TOOLTIP_PVPINFO = "PVP 信息: ";
     TITAN_COORDS_TOOLTIP_HOMELOCATION = "炉石位置";
     TITAN_COORDS_TOOLTIP_INN = "旅店: ";
     TITAN_COORDS_MENU_TEXT = "坐标";
     TITAN_COORDS_MENU_SHOW_ZONE_ON_PANEL_TEXT = "显示区域信息";
     TITAN_COORDS_MENU_SHOW_COORDS_ON_MAP_TEXT = "在世界地图上显示坐标";
     TITAN_COORDS_MAP_CURSOR_COORDS_TEXT = "鼠标位置(X,Y): %s";
     TITAN_COORDS_MAP_PLAYER_COORDS_TEXT = "玩家位置(X,Y): %s";
     TITAN_COORDS_NO_COORDS = "无坐标";
     
     TITAN_FPS_FORMAT = "%.1f";
     TITAN_FPS_BUTTON_LABEL = "FPS: ";
     TITAN_FPS_MENU_TEXT = "FPS";
     TITAN_FPS_TOOLTIP_CURRENT_FPS = "当前FPS: ";
     TITAN_FPS_TOOLTIP_AVG_FPS = "平均 FPS: ";
     TITAN_FPS_TOOLTIP_MIN_FPS = "最低 FPS: ";
     TITAN_FPS_TOOLTIP_MAX_FPS = "最高 FPS: ";
     TITAN_FPS_TOOLTIP = "每秒画面帧数";
     
     TITAN_LATENCY_FORMAT = "%d"..TITAN_MILLISECOND;
     TITAN_LATENCY_BANDWIDTH_FORMAT = "%.3f "..TITAN_KILOBYTES_PER_SECOND;
     TITAN_LATENCY_BUTTON_LABEL = "延迟: ";
     TITAN_LATENCY_TOOLTIP = "网络状况信息";
     TITAN_LATENCY_TOOLTIP_LATENCY = "延迟: ";
     TITAN_LATENCY_TOOLTIP_BANDWIDTH_IN = "接受带宽: ";
     TITAN_LATENCY_TOOLTIP_BANDWIDTH_OUT = "发送带宽: ";
     TITAN_LATENCY_MENU_TEXT = "延迟";
     
     TITAN_LOOTTYPE_BUTTON_LABEL = "分配: ";
     TITAN_LOOTTYPE_FREE_FOR_ALL = "自由拾取";
     TITAN_LOOTTYPE_ROUND_ROBIN = "轮流拾取";
     TITAN_LOOTTYPE_MASTER_LOOTER = "队长分配";
     TITAN_LOOTTYPE_GROUP_LOOT = "队伍分配";
     TITAN_LOOTTYPE_NEED_BEFORE_GREED = "需求优先";
     TITAN_LOOTTYPE_TOOLTIP = "分配方式";
     TITAN_LOOTTYPE_MENU_TEXT = "分配方式";
     TITAN_LOOTTYPE_RANDOM_ROLL_LABEL = "Roll点";
     TITAN_LOOTTYPE_TOOLTIP_HINT1 = "左键单击将Roll点.";
     TITAN_LOOTTYPE_TOOLTIP_HINT2 = "右键点击选择Roll点类型.";
     
     TITAN_MEMORY_FORMAT = "%.3f"..TITAN_MEGABYTE;
     TITAN_MEMORY_FORMAT_KB = "%d".."KB";
     TITAN_MEMORY_RATE_FORMAT = "%.3f"..TITAN_KILOBYTES_PER_SECOND;
     TITAN_MEMORY_BUTTON_LABEL = "内存: ";
     TITAN_MEMORY_TOOLTIP = "内存使用";
     TITAN_MEMORY_TOOLTIP_CURRENT_MEMORY = "当前: ";
     TITAN_MEMORY_TOOLTIP_INITIAL_MEMORY = "起始: ";
     TITAN_MEMORY_TOOLTIP_INCREASING_RATE = "增长率: ";
     TITAN_MEMORY_KBMB_LABEL = "KB/MB";     
     --TITAN_MEMORY_MENU_TEXT = "内存使用";
     --TITAN_MEMORY_MENU_RESET_SESSION = "重置内存统计数据.;
     
     TITAN_MONEY_GOLD = "金";
     TITAN_MONEY_SILVER = "银";
     TITAN_MONEY_COPPER = "铜";
     TITAN_MONEY_FORMAT = "%d"..TITAN_MONEY_GOLD..", %d"..TITAN_MONEY_SILVER..", %d"..TITAN_MONEY_COPPER;

	TITAN_MONEY_MENU_TEXT = "金钱";
	TITAN_MONEY_MENU_RESET_SESSION = "重置金钱统计";
	TITAN_MONEY_TOOLTIP = "显示金钱变化";
	TITAN_MONEY_TOOLTIP_HINTS = "左键单击拿取金钱";
	TITAN_MONEY_TOOLTIP_CURRENT = "当前：";
	TITAN_MONEY_TOOLTIP_INITIAL = "初始：";
	TITAN_MONEY_TOOLTIP_EARNED = "收入：";
	TITAN_MONEY_TOOLTIP_LOST = "支出：";
	TITAN_MONEY_TOOLTIP_EARNED_HOUR = "每小时获取：";
	TITAN_MONEY_TOOLTIP_LOST_HOUR = "每小时花费：";
     
     TITAN_PERFORMANCE_TOOLTIP = "性能信息";
     TITAN_PERFORMANCE_MENU_TEXT = "性能";
     TITAN_PERFORMANCE_ADDONS = "插件使用";
     TITAN_PERFORMANCE_ADDON_MEM_USAGE_LABEL = "插件的内存使用";
     TITAN_PERFORMANCE_ADDON_MEM_FORMAT_LABEL = "插件内存占用形式";
     TITAN_PERFORMANCE_ADDON_CPU_USAGE_LABEL = "插件CPU使用";
     TITAN_PERFORMANCE_ADDON_NAME_LABEL = "名称:";
     TITAN_PERFORMANCE_ADDON_USAGE_LABEL = "使用";
     TITAN_PERFORMANCE_ADDON_RATE_LABEL = "Rate";
     TITAN_PERFORMANCE_ADDON_TOTAL_MEM_USAGE_LABEL = "插件使用内存总量:";
     TITAN_PERFORMANCE_ADDON_TOTAL_CPU_USAGE_LABEL = "CPU使用总量:";
     TITAN_PERFORMANCE_MENU_SHOW_FPS = "显示 FPS";
     TITAN_PERFORMANCE_MENU_SHOW_LATENCY = "显示延迟";
     TITAN_PERFORMANCE_MENU_SHOW_MEMORY = "显示内存使用";
     TITAN_PERFORMANCE_MENU_SHOW_ADDONS = "显示插件内存使用量";
     TITAN_PERFORMANCE_MENU_SHOW_ADDON_RATE = "显示插件内存使用率";
     TITAN_PERFORMANCE_MENU_CPUPROF_LABEL = "CPU 使用图形显示模式";
     TITAN_PERFORMANCE_MENU_CPUPROF_LABEL_ON = "启用CPU图形显示 ";
     TITAN_PERFORMANCE_MENU_CPUPROF_LABEL_OFF = "禁用CPU图形显示 ";
     TITAN_PERFORMANCE_CONTROL_TOOLTIP = "监视的插件: ";
     TITAN_PERFORMANCE_CONTROL_TITLE = "被监视的插件";
     TITAN_PERFORMANCE_CONTROL_HIGH = "40";
     TITAN_PERFORMANCE_CONTROL_LOW = "1";
     TITAN_PERFORMANCE_TOOLTIP_HINT = "左键点击回收内存.";
	TITAN_RIDER_LOCALE = {
		menu = "坐骑",
		tooltip = "坐骑",
		button = "坐骑"
	};
	TITAN_RIDER_HINT = "当前状态：";
	TITAN_RIDER_OPTIONS_SHOWSTATE = "显示玩家状态";
	TITAN_RIDER_OPTIONS_DISMOUNTDELAY = "下马延时";
	TITAN_RIDER_OPTIONS_EQUIP = "装备物品";
	TITAN_RIDER_STATES = {"步行", "骑乘", "飞行", "地铁", "游泳", "被变形"};
	TITAN_RIDER_ITEMS = 6;
	TITAN_RIDER_ITEMS_LABEL = "Rider Items";
	TITAN_RIDER_ITEM_NAMES = {nil,"棍子上的胡萝卜",nil,"马鞭","Skybreaker Whip"};
	TITAN_RIDER_ITEM_DESCS = {"密银马刺",nil,"略微提升坐骑速度",nil,nil};
	TITAN_RIDER_ITEM_SLOTS = {"FeetSlot","Trinket0Slot","HandsSlot","Trinket0Slot","Trinket0Slot"}
	TITAN_RIDER_DRUID_FLIGHT_FORM = "Flight Form";
	TITAN_RIDER_DRUID_SWIFTFLIGHT_FORM = "Swift Flight Form";

  	TITAN_TRANS_TOOLTIP = "透明度控制";
	TITAN_TRANS_TOOLTIP_VALUE = "主面板透明度:";
	TITAN_AUXTRANS_TOOLTIP_VALUE = "辅助面板透明度: ";
	TITAN_TRANS_TOOLTIP_HINT1 = "左键点击调整";
	TITAN_TRANS_TOOLTIP_HINT2 = "面板透明度";
	TITAN_TRANS_CONTROL_TOOLTIP = "面板透明度：";
	TITAN_AUXTRANS_CONTROL_TOOLTIP = "面板透明度: ";
	TITAN_TRANS_MAIN_CONTROL_TITLE = "主\n工具栏";
	TITAN_TRANS_AUX_CONTROL_TITLE = "辅助\n工具栏";
	TITAN_TRANS_CONTROL_HIGH = "100%";
	TITAN_TRANS_CONTROL_LOW = "0%";
	TITAN_TRANS_MENU_TEXT = "透明度控制";
	
	TITAN_UISCALE_TOOLTIP = "UI/面板缩放";
	TITAN_UISCALE_TOOLTIP_VALUE_UI = "UI缩放比例：";
	TITAN_UISCALE_TOOLTIP_VALUE_PANEL = "面板缩放比例：";
	TITAN_UISCALE_TOOLTIP_VALUE_BUTTON = "按钮间隔: ";
	TITAN_UISCALE_TOOLTIP_VALUE_TOOLTIPTRANS = "提示信息透明度: ";
	TITAN_UISCALE_TOOLTIP_VALUE_TOOLTIPFONT = "提示信息字体缩放: ";
	TITAN_UISCALE_TOOLTIP_DISABLE_TEXT = "关";
	TITAN_UISCALE_TOOLTIP_DISABLE_TOOLTIP = "禁止 Titan的提示信息字体缩放 Control";
	TITAN_UISCALE_TOOLTIP_HINT1 = "左键点击调整面板或";
	TITAN_UISCALE_TOOLTIP_HINT2 = "游戏界面(UI)的尺寸大小";
	TITAN_UISCALE_CONTROL_TOOLTIP_UI = "UI缩放比例：";
	TITAN_UISCALE_CONTROL_TOOLTIP_PANEL = "面板缩放比例：";
	TITAN_UISCALE_CONTROL_TOOLTIP_BUTTON = "按钮间隔: ";
	TITAN_UISCALE_CONTROL_TOOLTIP_TOOLTIPTRANS = "提示信息透明度: ";
	TITAN_UISCALE_CONTROL_TOOLTIP_TOOLTIPFONT = "提示信息字体缩放: ";
	TITAN_UISCALE_CONTROL_TITLE_UI = "UI\n缩放比例";
	TITAN_UISCALE_CONTROL_TITLE_PANEL = "面板\n缩放比例";
	TITAN_UISCALE_CONTROL_TITLE_BUTTON = "按钮\n间隔";
	TITAN_UISCALE_CONTROL_TITLE_TOOLTIPTRANS = "提示信息\n透明度";
	TITAN_UISCALE_CONTROL_TITLE_TOOLTIPFONT = "提示信息\n字体";
	TITAN_UISCALE_CONTROL_HIGH_UI = "100%";
	TITAN_UISCALE_CONTROL_HIGH_PANEL = "125%";
	TITAN_UISCALE_CONTROL_HIGH_BUTTON = "100%";
	TITAN_UISCALE_CONTROL_HIGH_TOOLTIPTRANS = "100%";
	TITAN_UISCALE_CONTROL_HIGH_TOOLTIPFONT = "130%";
	TITAN_UISCALE_CONTROL_LOW_UI = "64%";
	TITAN_UISCALE_CONTROL_LOW_PANEL = "75%";
	TITAN_UISCALE_CONTROL_LOW_BUTTON = "6%";
	TITAN_UISCALE_CONTROL_LOW_TOOLTIPTRANS = "0%";
	TITAN_UISCALE_CONTROL_LOW_TOOLTIPFONT = "50%";
	TITAN_UISCALE_MENU_TEXT = "面板控制";
	
	TITAN_VOLUME_TOOLTIP = "音量信息";
	TITAN_VOLUME_MASTER_TOOLTIP_VALUE = "主音量: ";
	TITAN_VOLUME_SOUND_TOOLTIP_VALUE = "效果音量: ";
	TITAN_VOLUME_AMBIENCE_TOOLTIP_VALUE = "环境音量: ";
	TITAN_VOLUME_MUSIC_TOOLTIP_VALUE = "音乐音量: ";
	TITAN_VOLUME_MICROPHONE_TOOLTIP_VALUE = "麦克风音量: ";
	TITAN_VOLUME_SPEAKER_TOOLTIP_VALUE = "谈话音量: ";
	TITAN_VOLUME_TOOLTIP_HINT1 = "提示: 单击左键调整"
	TITAN_VOLUME_TOOLTIP_HINT2 = "音量.";
	TITAN_VOLUME_CONTROL_TOOLTIP = "音量控制: ";
	TITAN_VOLUME_CONTROL_TITLE = "音量控制";
	TITAN_VOLUME_MASTER_CONTROL_TITLE = "主";
	TITAN_VOLUME_SOUND_CONTROL_TITLE = "效果";
	TITAN_VOLUME_AMBIENCE_CONTROL_TITLE = "环境";
	TITAN_VOLUME_MUSIC_CONTROL_TITLE = "音乐";
	TITAN_VOLUME_MICROPHONE_CONTROL_TITLE = "麦克风";
	TITAN_VOLUME_SPEAKER_CONTROL_TITLE = "谈话";
	TITAN_VOLUME_CONTROL_HIGH = "高";
	TITAN_VOLUME_CONTROL_LOW = "低";
	TITAN_VOLUME_MENU_TEXT = "音量控制";
		     
     TITAN_XP_FORMAT = "%d";
     TITAN_XP_PERCENT_FORMAT = TITAN_XP_FORMAT.." (%.1f%%)";
     TITAN_XP_BUTTON_LABEL_XPHR_LEVEL = "经验/小时 当前等级: ";
     TITAN_XP_BUTTON_LABEL_XPHR_SESSION = "经验/小时 本次连接: ";
     TITAN_XP_BUTTON_LABEL_TOLEVEL_TIME_LEVEL = "升级所需时间: ";
		 TITAN_XP_LEVEL_COMPLETE = "升级: ";
		 TITAN_XP_TOTAL_RESTED = "剩余: ";
		 TITAN_XP_XPTOLEVELUP = "升级所需经验: ";
     TITAN_XP_TOOLTIP = "经验相关信息";
     TITAN_XP_TOOLTIP_TOTAL_TIME = "总共游戏时间: ";
     TITAN_XP_TOOLTIP_LEVEL_TIME = "当前等级的游戏时间: ";
     TITAN_XP_TOOLTIP_SESSION_TIME = "本次连接游戏时间: ";
     TITAN_XP_TOOLTIP_TOTAL_XP = "当前级别总经验: ";
     TITAN_XP_TOOLTIP_LEVEL_XP = "当前等级所获经验: ";
     TITAN_XP_TOOLTIP_TOLEVEL_XP = "升级所需经验: ";
     TITAN_XP_TOOLTIP_SESSION_XP = "本次连接所获经验: ";
     TITAN_XP_TOOLTIP_XPHR_LEVEL = "经验/小时 当前级别: ";
     TITAN_XP_TOOLTIP_XPHR_SESSION = "经验/小时 本次连接: ";     
     TITAN_XP_TOOLTIP_TOLEVEL_LEVEL = "升级时间 (按等级效率): ";
     TITAN_XP_TOOLTIP_TOLEVEL_SESSION = "升级时间 (按连接效率): ";
     TITAN_XP_MENU_TEXT = "经验";
     TITAN_XP_MENU_SHOW_XPHR_THIS_LEVEL = "显示当前级别 经验/小时";
     TITAN_XP_MENU_SHOW_XPHR_THIS_SESSION = "显示本次连接 经验/小时";
     TITAN_XP_MENU_SHOW_RESTED_TOLEVELUP = "更多信息显示";
     TITAN_XP_MENU_SIMPLE_BUTTON_TITLE = "按钮";
     TITAN_XP_MENU_SIMPLE_BUTTON_RESTED = "显示双倍的经验值";
     TITAN_XP_MENU_SIMPLE_BUTTON_TOLEVELUP = "显示升级所需经验";
     TITAN_XP_MENU_SIMPLE_BUTTON_KILLS = "显示升级所需的预估击杀数";
     TITAN_XP_MENU_RESET_SESSION = "重置连接时间";
     TITAN_XP_MENU_REFRESH_PLAYED = "刷新计时器";
     TITAN_XP_UPDATE_PENDING = "更新中...";
     TITAN_XP_UNKNOWN = "未知";
     TITAN_XP_KILLS_LABEL = "升级所需击杀数 (基于最后一个的经验 %d): ";
     TITAN_XP_KILLS_LABEL_SHORT = "预估击杀数: ";
     
     TITAN_REGEN_MENU_TEXT = "恢复"
     TITAN_REGEN_MENU_TOOLTIP_TITLE = "恢复速度"
     TITAN_REGEN_MENU_SHOW1 = "显示"
     TITAN_REGEN_MENU_SHOW2 = "生命值"
     TITAN_REGEN_MENU_SHOW3 = "法力值"
     TITAN_REGEN_MENU_SHOW4 = "显示百分比"
     TITAN_REGEN_BUTTON_TEXT_HP = "生命值: "..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
     TITAN_REGEN_BUTTON_TEXT_HP_PERCENT = "生命值: "..HIGHLIGHT_FONT_COLOR_CODE.."%.2f"..FONT_COLOR_CODE_CLOSE;
     TITAN_REGEN_BUTTON_TEXT_MP = " 法力值: "..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
     TITAN_REGEN_BUTTON_TEXT_MP_PERCENT = " 法力值: "..HIGHLIGHT_FONT_COLOR_CODE.."%.2f"..FONT_COLOR_CODE_CLOSE;
     TITAN_REGEN_TOOLTIP1 = "生命值: \t"..GREEN_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE.." / " ..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE.." ("..RED_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE..")";
     TITAN_REGEN_TOOLTIP2 = "法力值: \t"..GREEN_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE.." / " ..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE.." ("..RED_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE..")";
     TITAN_REGEN_TOOLTIP3 = "最快生命回复速度: \t"..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
     TITAN_REGEN_TOOLTIP4 = "最慢生命回复速度: \t"..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
     TITAN_REGEN_TOOLTIP5 = "最快法力回复速度: \t"..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
     TITAN_REGEN_TOOLTIP6 = "最慢法力回复速度: \t"..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
     TITAN_REGEN_TOOLTIP7 = "上次战斗法力回复值: \t"..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE.." ("..GREEN_FONT_COLOR_CODE.."%.2f"..FONT_COLOR_CODE_CLOSE.."%%)";

     TITAN_ITEMBONUSES_TEXT = "装备奖励";
     TITAN_ITEMBONUSES_DISPLAY_NONE = "不显示任何属性";
     TITAN_ITEMBONUSES_SHORTDISPLAY = "显示摘要";
     TITAN_ITEMBONUSES_BONUSSCANNER_MISSING = "需要BonusScanner插件";
     TITAN_ITEMBONUSES_AVERAGE_ILVL = "Display average item level";     
     TITAN_ITEMBONUSES_RATING_CONVERSION = "显示为等级点数/百分比";
     TITAN_ITEMBONUSES_SHOWGEMS = "显示各颜色宝石数目";

     TITAN_ITEMBONUSES_CAT_ATT = "属性";
     TITAN_ITEMBONUSES_CAT_RES = "抗性";
     TITAN_ITEMBONUSES_CAT_SKILL = "技能";
     TITAN_ITEMBONUSES_CAT_BON = "近战/远程相关属性";
     TITAN_ITEMBONUSES_CAT_SBON = "法术";
     TITAN_ITEMBONUSES_CAT_OBON = "生命和法力值";
     TITAN_ITEMBONUSES_CAT_EBON = "特殊奖励";

     --Titan Repair
     REPAIR_LOCALE = {
          pattern = "^耐久度 (%d+) / (%d+)$",
          menu = "修理",
          tooltip = "耐久度信息",
          button = "耐久度: ",
          normal = "修理费用 (正常): ",
          friendly = "修理费用 (友善): ",
          honored = "修理费用 (尊敬): ",
          revered = "修理费用 (崇敬): ",
          exalted = "修理费用 (崇拜): ",
          buttonNormal = "显示正常费用",
          buttonFriendly = "显示(声望友善)费用 (5%折扣)",
          buttonHonored = "显示(声望尊敬)费用 (10%折扣)",
          buttonRevered = "显示(声望崇敬)费用 (15%折扣)",
          buttonExalted = "显示(声望崇拜)费用 (20%折扣)",
          percentage = "显示为百分比",
          itemname = "显示耐久度最低的",
--        itemnames = "显示物品名称",
          mostdamaged = "耐久度最低的",
          showdurabilityframe = "显示耐久度面板",
          undamaged = "显示未掉耐久度的物品",
          discount = "折扣",
          nothing = "没有需要修理的物品",
          confirmation = "你确定要修理所有装备吗 ?",
          badmerchant = "这个商人不能修理，现在将显示正常费用",
          popup = "显示维修框",
          showinventory = "统计背包中的需修理物品",
          WholeScanInProgress = "更新中...",
          AutoReplabel = "自动修理",
          AutoRepitemlabel = "自动修理所有物品",
          ShowRepairCost = "显示修理费用",
     };

     TITAN_PLUGINS_MENU_TITLE = "扩展模块";
     
end