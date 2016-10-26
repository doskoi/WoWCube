-- TipBuddy: Copyright 2004 by Chester --

TIPBUDDY_VERSION = GetAddOnMetadata("TipBuddy", "Version");
TIPBUDDYTITLE = "TipBuddy";
TIPBUDDYTITAN = "TipBuddyTitan";

TB_FADE_TIMER = 1;
TB_POPUP_TIMER = 0.2;

-- Colors
TB_NML_TXT = "|cffffd200"
TB_WHT_TXT = "|cffffffff"
TB_GRY_TXT = "|cffC0C0C0"
TB_DGY_TXT = "|cff585858"
TB_RED_TXT = "|cffff2020"
TB_GRN_TXT = "|cff20ff20"
TB_YLW_TXT = "|cffffff00"
TB_BLE_TXT = "|cff3366ff"
TB_PNK_TXT = "|cffff00ff"
--TB_DBL_TXT = "|cff3399ff"
--TB_DGN_TXT = "|cff339900"
--TB_DRD_TXT = "|cffcc0000"

-- Menu Button

if (GetLocale() == "zhCN") then
TB_MENU_BUTTON_TOOLTIP = "打开信息跟随\n选项菜单";
TB_TIPBUDDYANCHOR_TOOLTIP = "左键点击拖动定位器\n右键点击选择提示框吸附位置";
TB_TIPBUDDYANCHORCLOSE_TOOLTIP = "点击隐藏定位器.\n\n"..TB_GRY_TXT.."(在定位器选项里点击可再次显示.)";
elseif (GetLocale() == "zhTW") then
TB_MENU_BUTTON_TOOLTIP = "打開信息跟隨\n選項菜單";
TB_TIPBUDDYANCHOR_TOOLTIP = "左鍵點擊拖動定位器\n右鍵點擊選擇提示框吸附位置";
TB_TIPBUDDYANCHORCLOSE_TOOLTIP = "點擊隱藏定位器.\n\n"..TB_GRY_TXT.."(在定位器選項裡點擊可再次顯示.)";
else
TB_MENU_BUTTON_TOOLTIP = "Open TipBuddy\noptions menu.";
TB_TIPBUDDYANCHOR_TOOLTIP = "Left Click and drag to move the anchor around.\nRight Click to select which corner the tooltip will attach to.";
TB_TIPBUDDYANCHORCLOSE_TOOLTIP = "Click this to HIDE the TipBuddyAnchor.\n\n"..TB_GRY_TXT.."(To show it again, open the options menu and click the 'Display TipBuddyAnchor' button under the 'Anchoring' section.)";
end

-- Checkboxes
if (GetLocale() == "zhCN") then
TB_PC_FRIEND = "友方玩家";
TB_PC_PARTY = "同队玩家";
TB_PC_ENEMY = "敌对玩家";
TB_NPC_FRIEND = "友方NPC";
TB_NPC_NEUTRAL = "中立NPC";
TB_NPC_ENEMY = "敌对NPC";
TB_PET_FRIEND = "友方宠物";
TB_PET_ENEMY = "敌对宠物";
TB_CORPSE = "尸体";
elseif (GetLocale() == "zhTW") then
TB_PC_FRIEND = "友方玩家";
TB_PC_PARTY = "同隊玩家";
TB_PC_ENEMY = "敵對玩家";
TB_NPC_FRIEND = "友方NPC";
TB_NPC_NEUTRAL = "中立NPC";
TB_NPC_ENEMY = "敵對NPC";
TB_PET_FRIEND = "友方寵物";
TB_PET_ENEMY = "敵對寵物";
TB_CORPSE = "屍體";
else
TB_PC_FRIEND = "Friendly Players";
TB_PC_PARTY = "Friendly Players in Party";
TB_PC_ENEMY = "Enemy Players";
TB_NPC_FRIEND = "Friendly NPCs";
TB_NPC_NEUTRAL = "Neutral NPCs";
TB_NPC_ENEMY = "Enemy NPCs";
TB_PET_FRIEND = "Friendly Pets";
TB_PET_ENEMY = "Enemy Pets";
TB_CORPSE = "Corpses";
end

TB_DEFAULTBG_COLOR = {r = 0.09, g = 0.09, b = 0.19};

TipBuddy = {};
TipBuddyUnitReaction = {
	{ r = "hostile" },	-- 1 Exceptionally hostile		?
	{ r = "hostile" },	-- 2 Very Hostile				Hostile Mobs
	{ r = "caution" },	-- 3 Hostile					2006.12.26: Changed from hostile to caution
	{ r = "neutral" },	-- 4 Neutral					Just neutral
	{ r = "friendly" },	-- 5 Friendly					Non-PvP
	{ r = "pvp" },		-- 6 Very Friendly				PvP Players
	{ r = "friendly" },	-- 7 Exceptionally friendly		PvP NPC's
	{ r = "exalted" },	-- 8 Exalted
};

TB_ANCHOR = {
	["TOPRIGHT"] = {a="BOTTOMRIGHT",b="TOPRIGHT"},
	["RIGHT"] = {a="BOTTOMLEFT",b="TOPRIGHT"},
	["BOTTOMRIGHT"] = {a="TOPLEFT",b="BOTTOMRIGHT"},
	["TOPLEFT"] = {a="BOTTOMLEFT",b="TOPLEFT"},
	["LEFT"] = {a="BOTTOMRIGHT",b="TOPLEFT"},
	["BOTTOMLEFT"] = {a="TOPRIGHT",b="BOTTOMLEFT"},
};


if (GetLocale() == "zhCN") then

TB_OPTION_COMPACTONLY = TB_YLW_TXT.."(仅限于简洁模式)\n";
TB_OPTION_DEFAULTONLY = TB_YLW_TXT.."(仅限于默认模式)\n";
TB_OPTION_GLD = "公会";
TB_OPTION_GLD_TOOLTIP = TB_NML_TXT.."显示目标的:\n"..TB_WHT_TXT.."公会名称";
TB_OPTION_GLD_TITLE = "头衔";
TB_OPTION_GLD_TITLE_TOOLTIP = TB_NML_TXT.."显示目标的:\n"..TB_WHT_TXT.."头衔 "..TB_GRY_TXT.."(如果可用)";
TB_OPTION_HTH = "生命条/魔法条";
TB_OPTION_HTH_TOOLTIP = TB_OPTION_COMPACTONLY..TB_NML_TXT.."显示目标的:\n"..TB_WHT_TXT.."生命条\n魔法条 "..TB_GRY_TXT.."(如果可用)";
TB_OPTION_RAC = "种族";
TB_OPTION_RAC_TOOLTIP = TB_NML_TXT.."显示目标的:\n"..TB_WHT_TXT.."种族\n"..TB_GRY_TXT.." (\"等级--职业\" 必须被打开)";
TB_OPTION_CFC = "城市阵营";
TB_OPTION_CFC_TOOLTIP = TB_NML_TXT.."显示目标的:\n"..TB_WHT_TXT.."城市阵营\n"..TB_GRY_TXT.." (奥格瑞玛, 暴风城等 - 如果可用)";
TB_OPTION_CLS = "等级 -- 职业/类型";
TB_OPTION_CLS_TOOLTIP = TB_NML_TXT.."显示目标的:\n"..TB_WHT_TXT.."等级\n---\n职业名称";
TB_OPTION_CLS_TYPE = "等级 -- 职业/类型";
TB_OPTION_CLS_TYPE_TOOLTIP = TB_NML_TXT.."显示目标的:\n"..TB_WHT_TXT.."等级\n---\n职业名称\n"..TB_WHT_TXT.."生物名称\n"..TB_DGY_TXT.."(\"熊\", \"蜘蛛\")\n"..TB_WHT_TXT.."生物种类名称\n"..TB_DGY_TXT.."(\"人形\", \"野兽\")\n"..TB_GRY_TXT.."(基于可用程度)";
-- resists aren't used  :(
TB_OPTION_FAC = "阵营/PvP 状态";
TB_OPTION_FAC_TOOLTIP = TB_NML_TXT.."显示目标的:\n"..TB_WHT_TXT.."阵营徽章(图标显示)"..TB_GRY_TXT.." (如果打开PVP标识)";
TB_OPTION_BFF = "增益/减益魔法";
TB_OPTION_BFF_TOOLTIP = TB_NML_TXT.."显示目标的:\n"..TB_WHT_TXT.."增益魔法\n"..TB_WHT_TXT.."减益魔法";
TB_OPTION_XTR = "其他信息";
TB_OPTION_XTR_TOOLTIP = TB_NML_TXT.."显示目标的:\n"..TB_WHT_TXT.."其他信息，比如其他的提示工具提供的信息";
TB_OPTION_RNK = "军衔图标";
TB_OPTION_RNK_TOOLTIP = TB_NML_TXT.."显示目标的:\n"..TB_WHT_TXT.."军衔图标(名字左侧显示)"..TB_GRY_TXT.." (如果他们有PvP军衔)";
TB_OPTION_TRG = "目标的目标";
TB_OPTION_TRG_TOOLTIP = TB_NML_TXT.."显示"..TB_WHT_TXT.."目标的目标"..TB_GRY_TXT.."\n(只显示选项内已选中的目标类型\n并用以下颜色区分目标类型:)\n"..TB_WHT_TXT.."白色"..TB_GRY_TXT..": 你自己\n"..TB_GRN_TXT.."绿色"..TB_GRY_TXT..": 友方玩家\n"..TB_RED_TXT.."红色"..TB_GRY_TXT..": 敌对玩家\n"..TB_BLE_TXT.."蓝色"..TB_GRY_TXT..": NPC\n"..TB_PNK_TXT.."紫色"..TB_GRY_TXT..": 你的队友";
TB_OPTION_RNM = "军衔名称";
TB_OPTION_RNM_TOOLTIP = TB_NML_TXT.."显示目标的:\n"..TB_WHT_TXT.."军衔名称"..TB_GRY_TXT.." (如果他们有PvP军衔)";

TB_TEXTVARS_HELP_1 =	"$nl\n$nm\n$gu\n$lv\n$cl\n$rc\n$fa\n$cf\n$hc\n$hm\n$hp\n$mc\n$mm\n$mp\n$ns\n$nt\n$nf\n$tp\n$re\n$pr\n$pn\n$pv\n$ml\n$df\n$tn\n   \n   \nColoring:\n@Crn\n@Crg\n@Cdf\n@Ccl\n@Ctt\n@Ccp\n@Cor\n@Cwt\n@Cgy\n@Crd\n@Cgn\n@Cyw\n@Cbl\n@Cpk"
TB_TEXTVARS_HELP_2 =	"换行 (\\n 也行)\n名字\n工会或头衔\n级别\n职业\n种族 (仅玩家)\n阵营 (仅玩家)\n城市阵营 (仅NPC)\n当前生命\n最大生命\n生命百分比\n当前魔法\n最大魔法\n魔法值百分比\n稀有度 (精英,BOSS等)\n类型 (野兽,人形等)\n分类 (熊,猫等)\n被接触 (被他人接触)\n友好度 (敌对,中立)\n荣誉称号\n荣誉等级\n军衔图标\nMana Label (法力,能量,愤怒等)\n难易度 (困难,简单等)\n目标的目标\n   \n   \n   \n好感度颜色(名字)\n好感度颜色(工会)\n难易度颜色\n职业颜色\n目标的目标\n尸体颜色\nOrange\nWhite\nGrey\nRed\nGreen\nYellow\nBlue\nPink"

TB_OPTION_CURSOR = "跟随鼠标模式";
TB_OPTION_CURSOR_TOOLTIP = "允许TipBuddy提示框悬跟随在鼠标指针之上而不是在鼠标一侧";
TB_OPTION_SCALE = "提示框大小";
TB_OPTION_SCALE_TOOLTIP = TB_OPTION_COMPACTONLY..TB_NML_TXT.."改变"..TB_WHT_TXT.."简洁模式"..TB_NML_TXT.."提示框大小";
TB_OPTION_GTTSCALE = "提示框大小";
TB_OPTION_GTTSCALE_TOOLTIP = TB_OPTION_DEFAULTONLY..TB_NML_TXT.."改变"..TB_WHT_TXT.."默认模式"..TB_NML_TXT.."提示框大小";
TB_OPTION_ANCHORED = "自定义提示框位置";
TB_OPTION_ANCHORED_TOOLTIP = "将提示框吸附于TipBuddy定位器\n\n"..TB_WHT_TXT.."定位器可以被移动到屏幕任意位置\n\n该选项对非单位目标的提示无效\n(比如技能)\n\n如果定位器被不慎关闭，请点击"..TB_NML_TXT.."【显示定位器】"..TB_WHT_TXT.."按钮";
TB_OPTION_DELAY = "提示框延迟时间";
TB_OPTION_DELAY_TOOLTIP = TB_OPTION_COMPACTONLY..TB_NML_TXT.."当你的鼠标离开目标后多久开始消隐";
TB_OPTION_FADETIME = "提示框消隐时间";
TB_OPTION_FADETIME_TOOLTIP = TB_OPTION_COMPACTONLY..TB_NML_TXT.."消隐提示框所需时间(从'延迟'结束后开始计时)";
TB_OPTION_HIDEDEFAULT = "隐藏默认提示";
TB_OPTION_HIDEDEFAULT_TOOLTIP = "选择这项将会隐藏魔兽世界对目标默认的提示框，但是不会隐藏对于非单位目标的提示框（例如：钓鱼等）";
TB_OPTION_OFFSETX_TOOLTIP = "设置提示信息水平坐标的偏移量";
TB_OPTION_OFFSETY_TOOLTIP = "设置提示信息垂直坐标的偏移量";
TB_OPTION_COLORBUTTON_TOOLTIP = "为这种类型目标选择背景颜色";
TB_OPTION_COLORBUTTON_BOR_TOOLTIP = "为这种类型目标选择边框颜色";
TB_OPTION_SAMEGUILD = "公会背景颜色";
TB_OPTION_SAMEGUILD_TOOLTIP = "选择和你同公会的玩家的背景颜色";
TB_OPTION_SAMEGUILDB = "公会边框颜色";
TB_OPTION_SAMEGUILDB_TOOLTIP = "选择和你同公会的玩家的边框颜色";
TB_OPTION_NONUNITBG = "非单位背景颜色";
TB_OPTION_NONUNITBG_TOOLTIP = "选择非单位提示框背景颜色"..TB_GRY_TXT.."\n(按钮,图标,物品,技能,等)";
TB_OPTION_NONUNITBGB = "非单位边框颜色";
TB_OPTION_NONUNITBGB_TOOLTIP = "选择非单位提示框边框颜色"..TB_GRY_TXT.."\n(按钮,图标,物品,技能,等)";
TB_OPTION_CLASSCOLOR = "职业文字颜色显示";
TB_OPTION_CLASSCOLOR_TOOLTIP = "允许为玩家的职业文字使用颜色代码";
TB_OPTION_FADEDEFAULT = "提示框渐隐";
TB_OPTION_FADEDEFAULT_TOOLTIP = "打开这个选项将使默认提示框渐隐而不是立刻消失";
TB_OPTION_BLIZZARDDEFAULT = "游戏提供的提示信息";
TB_OPTION_BLIZZARDDEFAULT_TOOLTIP = "使用游戏默认显示."..TB_GRY_TXT.."\n用来显示猎人查看野兽信息等\n(可以继续使用选项的背景颜色，增益/减益魔法，pvp军衔图标功能)";
TB_OPTION_REPOSITIONMODS = "保持信息停留于屏幕";
TB_OPTION_REPOSITIONMODS_TOOLTIP = "使你所有的提示信息保持停留于屏幕上";
TB_OPTION_UBERTIPANCH = "锚定非单位目标提示框";
TB_OPTION_UBERTIPANCH_TOOLTIP = "打开该项将会把非单位目标(例如：按钮等)提示框绑定于TipBuddy定位器替代指针指向\n\n如果'使用Tipbuddy定位器'选项打开，所有的锚点将会自动绑定到TipBuddy定位器上";
TB_OPTION_DIFFBACKGROUND = "显示难度背景"
TB_OPTION_DIFFBACKGROUND_TOOLTIP = "打开这个选项将根据目标相对于你的难易度确定提示框背景色，其他背景色的设置将不起作用"

TB_OPTION_NONUNITPOS_TOOLTIP = "选择非单位提示框显示的位置";
TB_OPTION_CURSORPOS_TOOLTIP = "选择提示框相对于鼠标的位置";
TB_OPTION_COLORTEXTBUTTON_TOOLTIP = "提示框文字颜色菜单";
TB_OPTION_STYLEMODE_TOOLTIP = "为此类型选择提示框模式";

TB_OPTION_BORDER_TOOLTIP = "选择提示框边框颜色";
TB_OPTION_BACKDROP_TOOLTIP = "选择提示框背景颜色";

TB_OPTION_TRG_PL = "友好玩家";
TB_OPTION_TRG_PL_TOOLTIP = "";
TB_OPTION_TRG_EN = "敌对玩家";
TB_OPTION_TRG_EN_TOOLTIP = "";
TB_OPTION_TRG_NP = "  NPC";
TB_OPTION_TRG_NP_TOOLTIP = "";
TB_OPTION_TRG_PA = "  队友";
TB_OPTION_TRG_PA_TOOLTIP = "";
TB_OPTION_TRG_2L = "隔行显示";
TB_OPTION_TRG_2L_TOOLTIP = "显示单位的目标在他们名字的分割线上";

TB_RESETVARS_DIALOG =  "请确定是否重置所有的设置?";

elseif (GetLocale() == "zhTW") then

TB_OPTION_COMPACTONLY = TB_YLW_TXT.."(僅限於簡潔模式)\n";
TB_OPTION_DEFAULTONLY = TB_YLW_TXT.."(僅限於默認模式)\n";
TB_OPTION_GLD = "公會";
TB_OPTION_GLD_TOOLTIP = TB_NML_TXT.."顯示目標的:\n"..TB_WHT_TXT.."公會名稱";
TB_OPTION_GLD_TITLE = "頭銜";
TB_OPTION_GLD_TITLE_TOOLTIP = TB_NML_TXT.."顯示目標的:\n"..TB_WHT_TXT.."頭銜 "..TB_GRY_TXT.."(如果可用)";
TB_OPTION_HTH = "生命條/魔法條";
TB_OPTION_HTH_TOOLTIP = TB_OPTION_COMPACTONLY..TB_NML_TXT.."顯示目標的:\n"..TB_WHT_TXT.."生命條\n魔法條 "..TB_GRY_TXT.."(如果可用)";
TB_OPTION_RAC = "種族";
TB_OPTION_RAC_TOOLTIP = TB_NML_TXT.."顯示目標的:\n"..TB_WHT_TXT.."種族\n"..TB_GRY_TXT.." (\"等級--職業\" 必須被打開)";
TB_OPTION_CFC = "城市陣營";
TB_OPTION_CFC_TOOLTIP = TB_NML_TXT.."顯示目標的:\n"..TB_WHT_TXT.."城市陣營\n"..TB_GRY_TXT.." (奧格瑞瑪, 暴風城等 - 如果可用)";
TB_OPTION_CLS = "等級 -- 職業/類型";
TB_OPTION_CLS_TOOLTIP = TB_NML_TXT.."顯示目標的:\n"..TB_WHT_TXT.."等級\n---\n職業名稱";
TB_OPTION_CLS_TYPE = "等級 -- 職業/類型";
TB_OPTION_CLS_TYPE_TOOLTIP = TB_NML_TXT.."顯示目標的:\n"..TB_WHT_TXT.."等級\n---\n職業名稱\n"..TB_WHT_TXT.."生物名稱\n"..TB_DGY_TXT.."(\"熊\", \"蜘蛛\")\n"..TB_WHT_TXT.."生物種類名稱\n"..TB_DGY_TXT.."(\"人形\", \"野獸\")\n"..TB_GRY_TXT.."(基於可用程度)";
-- resists aren't used  :(
TB_OPTION_FAC = "陣營/PvP 狀態";
TB_OPTION_FAC_TOOLTIP = TB_NML_TXT.."顯示目標的:\n"..TB_WHT_TXT.."陣營徽章(圖標顯示)"..TB_GRY_TXT.." (如果打開PVP標識)";
TB_OPTION_BFF = "增益/減益魔法";
TB_OPTION_BFF_TOOLTIP = TB_NML_TXT.."顯示目標的:\n"..TB_WHT_TXT.."增益魔法\n"..TB_WHT_TXT.."減益魔法";
TB_OPTION_XTR = "其他信息";
TB_OPTION_XTR_TOOLTIP = TB_NML_TXT.."顯示目標的:\n"..TB_WHT_TXT.."其他信息，比如其他的提示工具提供的信息";
TB_OPTION_RNK = "軍銜圖標";
TB_OPTION_RNK_TOOLTIP = TB_NML_TXT.."顯示目標的:\n"..TB_WHT_TXT.."軍銜圖標(名字左側顯示)"..TB_GRY_TXT.." (如果他們有PvP軍銜)";
TB_OPTION_TRG = "目標的目標";
TB_OPTION_TRG_TOOLTIP = TB_NML_TXT.."顯示"..TB_WHT_TXT.."目標的目標"..TB_GRY_TXT.."\n(只顯示選項內已選中的目標類型\n並用以下顏色區分目標類型:)\n"..TB_WHT_TXT.."白色"..TB_GRY_TXT..": 你自己\n"..TB_GRN_TXT.."綠色"..TB_GRY_TXT..": 友方玩家\n"..TB_RED_TXT.."紅色"..TB_GRY_TXT..": 敵對玩家\n"..TB_BLE_TXT.."藍色"..TB_GRY_TXT..": NPC\n"..TB_PNK_TXT.."紫色"..TB_GRY_TXT..": 你的隊友";
TB_OPTION_RNM = "軍銜名稱";
TB_OPTION_RNM_TOOLTIP = TB_NML_TXT.."顯示目標的:\n"..TB_WHT_TXT.."軍銜名稱"..TB_GRY_TXT.." (如果他們有PvP軍銜)";

TB_TEXTVARS_HELP_1 =	"$nl\n$nm\n$gu\n$lv\n$cl\n$rc\n$fa\n$cf\n$hc\n$hm\n$hp\n$mc\n$mm\n$mp\n$ns\n$nt\n$nf\n$tp\n$re\n$pr\n$pn\n$pv\n$ml\n$df\n$tn\n   \n   \nColoring:\n@Crn\n@Crg\n@Cdf\n@Ccl\n@Ctt\n@Ccp\n@Cor\n@Cwt\n@Cgy\n@Crd\n@Cgn\n@Cyw\n@Cbl\n@Cpk"
TB_TEXTVARS_HELP_2 =	"換行 (\\n 也行)\n名字\n工會或頭銜\n級別\n職業\n種族 (僅玩家)\n陣營 (僅玩家)\n城市陣營 (僅NPC)\n當前生命\n最大生命\n生命百分比\n當前魔法\n最大魔法\n魔法值百分比\n稀有度 (精英,BOSS等)\n類型 (野獸,人形等)\n分類 (熊,貓等)\n被接觸 (被他人接觸)\n友好度 (敵對,中立)\n榮譽稱號\n榮譽等級\n軍銜圖標\nMana Label (法力,能量,憤怒等)\n難易度 (困難,簡單等)\n目標的目標\n   \n   \n   \n好感度顏色(名字)\n好感度顏色(工會)\n難易度顏色\n職業顏色\n目標的目標\n屍體顏色\nOrange\nWhite\nGrey\nRed\nGreen\nYellow\nBlue\nPink"

TB_OPTION_CURSOR = "跟隨滑鼠模式";
TB_OPTION_CURSOR_TOOLTIP = "允許TipBuddy提示框懸跟隨在滑鼠指針之上而不是在滑鼠一側";
TB_OPTION_SCALE = "提示框大小";
TB_OPTION_SCALE_TOOLTIP = TB_OPTION_COMPACTONLY..TB_NML_TXT.."改變"..TB_WHT_TXT.."簡潔模式"..TB_NML_TXT.."提示框大小";
TB_OPTION_GTTSCALE = "提示框大小";
TB_OPTION_GTTSCALE_TOOLTIP = TB_OPTION_DEFAULTONLY..TB_NML_TXT.."改變"..TB_WHT_TXT.."默認模式"..TB_NML_TXT.."提示框大小";
TB_OPTION_ANCHORED = "自定義提示框位置";
TB_OPTION_ANCHORED_TOOLTIP = "將提示框吸附於TipBuddy定位器\n\n"..TB_WHT_TXT.."定位器可以被移動到屏幕任意位置\n\n該選項對非單位目標的提示無效\n(比如技能)\n\n如果定位器被不慎關閉，請點擊"..TB_NML_TXT.."【顯示定位器】"..TB_WHT_TXT.."按鈕";
TB_OPTION_DELAY = "提示框延遲時間";
TB_OPTION_DELAY_TOOLTIP = TB_OPTION_COMPACTONLY..TB_NML_TXT.."當你的滑鼠離開目標後多久開始消隱";
TB_OPTION_FADETIME = "提示框消隱時間";
TB_OPTION_FADETIME_TOOLTIP = TB_OPTION_COMPACTONLY..TB_NML_TXT.."消隱提示框所需時間(從'延遲'結束後開始計時)";
TB_OPTION_HIDEDEFAULT = "隱藏默認提示";
TB_OPTION_HIDEDEFAULT_TOOLTIP = "選擇這項將會隱藏魔獸世界對目標默認的提示框，但是不會隱藏對於非單位目標的提示框（例如：釣魚等）";
TB_OPTION_OFFSETX_TOOLTIP = "設置提示信息水平坐標的偏移量";
TB_OPTION_OFFSETY_TOOLTIP = "設置提示信息垂直坐標的偏移量";
TB_OPTION_COLORBUTTON_TOOLTIP = "為這種類型目標選擇背景顏色";
TB_OPTION_COLORBUTTON_BOR_TOOLTIP = "為這種類型目標選擇邊框顏色";
TB_OPTION_SAMEGUILD = "公會背景顏色";
TB_OPTION_SAMEGUILD_TOOLTIP = "選擇和你同公會的玩家的背景顏色";
TB_OPTION_SAMEGUILDB = "公會邊框顏色";
TB_OPTION_SAMEGUILDB_TOOLTIP = "選擇和你同公會的玩家的邊框顏色";
TB_OPTION_NONUNITBG = "非單位背景顏色";
TB_OPTION_NONUNITBG_TOOLTIP = "選擇非單位提示框背景顏色"..TB_GRY_TXT.."\n(按鈕,圖標,物品,技能,等)";
TB_OPTION_NONUNITBGB = "非單位邊框顏色";
TB_OPTION_NONUNITBGB_TOOLTIP = "選擇非單位提示框邊框顏色"..TB_GRY_TXT.."\n(按鈕,圖標,物品,技能,等)";
TB_OPTION_CLASSCOLOR = "職業文字顏色顯示";
TB_OPTION_CLASSCOLOR_TOOLTIP = "允許為玩家的職業文字使用顏色代碼";
TB_OPTION_FADEDEFAULT = "提示框漸隱";
TB_OPTION_FADEDEFAULT_TOOLTIP = "打開這個選項將使默認提示框漸隱而不是立刻消失";
TB_OPTION_BLIZZARDDEFAULT = "遊戲提供的提示信息";
TB_OPTION_BLIZZARDDEFAULT_TOOLTIP = "使用遊戲默認顯示."..TB_GRY_TXT.."\n用來顯示獵人查看野獸信息等\n(可以繼續使用選項的背景顏色，增益/減益魔法，pvp軍銜圖標功能)";
TB_OPTION_REPOSITIONMODS = "保持信息停留於熒幕";
TB_OPTION_REPOSITIONMODS_TOOLTIP = "使你所有的提示信息保持停留於熒幕上";
TB_OPTION_UBERTIPANCH = "錨定非單位目標提示框";
TB_OPTION_UBERTIPANCH_TOOLTIP = "打開該項將會把非單位目標(例如：按鈕等)提示框綁定於TipBuddy定位器替代指針指向\n\n如果'使用Tipbuddy定位器'選項打開，所有的錨點將會自動綁定到TipBuddy定位器上";
TB_OPTION_DIFFBACKGROUND = "顯示難度背景"
TB_OPTION_DIFFBACKGROUND_TOOLTIP = "打開這個選項將根據目標相對於你的難易度確定提示框背景色，其他背景色的設置將不起作用"

TB_OPTION_NONUNITPOS_TOOLTIP = "選擇非單位提示框顯示的位置";
TB_OPTION_CURSORPOS_TOOLTIP = "選擇提示框相對於滑鼠的位置";
TB_OPTION_COLORTEXTBUTTON_TOOLTIP = "提示框文字顏色菜單";
TB_OPTION_STYLEMODE_TOOLTIP = "為此類型選擇提示框模式";

TB_OPTION_BORDER_TOOLTIP = "選擇提示框邊框顏色";
TB_OPTION_BACKDROP_TOOLTIP = "選擇提示框背景顏色";

TB_OPTION_TRG_PL = "友好玩家";
TB_OPTION_TRG_PL_TOOLTIP = "";
TB_OPTION_TRG_EN = "敵對玩家";
TB_OPTION_TRG_EN_TOOLTIP = "";
TB_OPTION_TRG_NP = "  NPC";
TB_OPTION_TRG_NP_TOOLTIP = "";
TB_OPTION_TRG_PA = "  隊友";
TB_OPTION_TRG_PA_TOOLTIP = "";
TB_OPTION_TRG_2L = "隔行顯示";
TB_OPTION_TRG_2L_TOOLTIP = "顯示單位的目標在他們名字的分割線上";

TB_RESETVARS_DIALOG =  "請確定是否重置所有的設置?";

else

TB_OPTION_COMPACTONLY = TB_YLW_TXT.."(Compact Mode Only)\n";
TB_OPTION_DEFAULTONLY = TB_YLW_TXT.."(Default Mode Only)\n";
TB_OPTION_GLD = "Guild";
TB_OPTION_GLD_TOOLTIP = TB_NML_TXT.."Show Target's:\n"..TB_WHT_TXT.."Guild Name";
TB_OPTION_GLD_TITLE = "Title";
TB_OPTION_GLD_TITLE_TOOLTIP = TB_NML_TXT.."Show Target's:\n"..TB_WHT_TXT.."Title "..TB_GRY_TXT.."(if available)";
TB_OPTION_HTH = "Health Bar";
TB_OPTION_HTH_TOOLTIP = TB_NML_TXT.."Show Target's:\n"..TB_WHT_TXT.."Health Bar\nMana Bar "..TB_GRY_TXT.."(if available) "..TB_OPTION_COMPACTONLY;
TB_OPTION_RAC = "Race";
TB_OPTION_RAC_TOOLTIP = TB_NML_TXT.."Show Target's:\n"..TB_WHT_TXT.."Race\n"..TB_GRY_TXT.." (\"Level--Class\" must be shown as well)";
TB_OPTION_CFC = "City Faction";
TB_OPTION_CFC_TOOLTIP = TB_NML_TXT.."Show Target's:\n"..TB_WHT_TXT.."City Faction\n"..TB_GRY_TXT.." (Orgrimmar, Stormwind, etc - If available)";
TB_OPTION_CLS = "Level -- Class";
TB_OPTION_CLS_TOOLTIP = TB_NML_TXT.."Show Target's:\n"..TB_WHT_TXT.."Level\n---\nClass Name";
TB_OPTION_CLS_TYPE = "Level -- Class/Type";
TB_OPTION_CLS_TYPE_TOOLTIP = TB_NML_TXT.."Show Target's:\n"..TB_WHT_TXT.."Level\n---\nClass Name\n"..TB_WHT_TXT.."Creature Family Name\n"..TB_DGY_TXT.."(\"Bear\", \"Spider\")\n"..TB_WHT_TXT.."Creature Type Name\n"..TB_DGY_TXT.."(\"Humanoid\", \"Beast\")\n"..TB_GRY_TXT.."(depending on availibility)";
-- resists aren't used  :(
TB_OPTION_FAC = "Faction/PvP State";
TB_OPTION_FAC_TOOLTIP = TB_NML_TXT.."Show Target's:\n"..TB_WHT_TXT.."Faction and PvP setting.  Will show unit's faction emblem by default or text only if text option is set"..TB_GRY_TXT.." (if they are currently flagged for PvP or FFA)";
TB_OPTION_BFF = "Buffs/Debuffs";
TB_OPTION_BFF_TOOLTIP = TB_NML_TXT.."Show Target's:\n"..TB_WHT_TXT.."Buffs\n"..TB_WHT_TXT.."Debuffs";
TB_OPTION_XTR = "Extras";
TB_OPTION_XTR_TOOLTIP = TB_NML_TXT.."Show Target's:\n"..TB_WHT_TXT.."Extra information inserted into the tooltip such as by another tooltip mod";
TB_OPTION_RNK = "Rank Icon";
TB_OPTION_RNK_TOOLTIP = TB_NML_TXT.."Show Target's:\n"..TB_WHT_TXT.."Rank icon to the left of their name"..TB_GRY_TXT.." (if the are ranked in PvP)";
TB_OPTION_TRG = "Target's Target";
TB_OPTION_TRG_TOOLTIP = TB_NML_TXT.."Show Target's:\n"..TB_WHT_TXT.."Currently selected target"..TB_GRY_TXT.."\n(the target's target name is color coded as follows:\n"..TB_WHT_TXT.."WHITE"..TB_GRY_TXT..": Is targeting you\n"..TB_GRN_TXT.."GREEN"..TB_GRY_TXT..": Is targeting a friendly player\n"..TB_BLE_TXT.."BLUE"..TB_GRY_TXT..": Is targeting a non-hostile NPC\n"..TB_RED_TXT.."RED"..TB_GRY_TXT..": Is targeting a hostile enemy\n"..TB_YLW_TXT.."YELLOW"..TB_GRY_TXT..": Is targeting one of your party members)\n";
TB_OPTION_RNM = "Rank Title Text";
TB_OPTION_RNM_TOOLTIP = TB_NML_TXT.."Show Target's:\n"..TB_WHT_TXT.."Rank Title which is displayed before their name"..TB_GRY_TXT.." (if the are ranked in PvP)";

TB_TEXTVARS_HELP_1 =	"$nl\n$nm\n$gu\n$gt\n$lv\n$cl\n$rc\n$fa\n$cf\n$hc\n$hm\n$hp\n$mc\n$mm\n$mp\n$ns\n$nt\n$nf\n$tp\n$re\n$pr\n$pn\n$pv\n$ml\n$df\n$tn\n   \n   \nColoring:\n@Crn\n@Crg\n@Cdf\n@Ccl\n@Ctt\n@Ccp\n@Cor\n@Cwt\n@Cgy\n@Crd\n@Cgn\n@Cyw\n@Cbl\n@Cpk"
TB_TEXTVARS_HELP_2 =	"New line (\\n also works)\nUnit's Name\nUnit's Guild or Title\nUnit's Title Rank in Guild\nUnit's Level\nUnit's Class\nRace (players only)\nFaction (players only)\nCity Faction (NPCs only)\nCurrent Health (actual)\nMax Health (actual)\nHealth as a percent\nCurrent Mana (actual)\nMax Mana (actual)\nMana as a percent\nNPC Classification (Elite, Boss, etc.)\nNPC Type (Beast, Humanoid, etc.)\nNPC Family (Bear, Cat, etc.)\nTapped (TAPPED or nothing)\nUnit Reaction (Hostile, Neutral)\nPVP Rank\nPVP Rank Number\nPVP Flagged (PvP or Free For All)\nMana Label (Mana, Energy, Rage, etc.)\nUnit Difficulty (Difficult, Trivial, etc.)\nUnit Target's Target Name\n   \n   \n   \nReaction Color(Name)\nReaction Color(Guild)\nDifficulty Color\nClass Color\nTarget's Target (only if unit has target)\nCorpse Color (only if unit is corpse)\nOrange\nWhite\nGrey\nRed\nGreen\nYellow\nBlue\nPink"

TB_OPTION_CURSOR = "TipBuddy Above Cursor";
TB_OPTION_CURSOR_TOOLTIP = "Enable to position TipBuddy directly above your cursor's position instead of on the side";
TB_OPTION_SCALE = "Compact Scale";
TB_OPTION_SCALE_TOOLTIP = TB_OPTION_COMPACTONLY..TB_NML_TXT.."Changes the size of the "..TB_WHT_TXT.."Compact"..TB_NML_TXT.." TipBuddy tooltip";
TB_OPTION_GTTSCALE = "Default Tooltip Scale";
TB_OPTION_GTTSCALE_TOOLTIP = TB_OPTION_DEFAULTONLY..TB_NML_TXT.."Changes the scale of the "..TB_WHT_TXT.."Default"..TB_NML_TXT.." tooltip";
TB_OPTION_ANCHORED = "Anchor Unit Tips";
TB_OPTION_ANCHORED_TOOLTIP = "Enable to anchor your unit tips to the TipBuddyAnchor.  Non-unit tips (such as buttons) are not affected by this and have their own setting in the dropdown below this\n\nTo show the TipBuddyAnchor after you've hidden it, click the 'Display TipBuddyAnchor' button";
TB_OPTION_DELAY = "Tooltip Delay Time";
TB_OPTION_DELAY_TOOLTIP = "The time it takes to start fading from the moment your cursor leaves a unit";
TB_OPTION_FADETIME = "Tooltip Fade Time";
TB_OPTION_FADETIME_TOOLTIP = "The time it takes to fade TipBuddy out (starts fading after the 'Delay' has expired)";
TB_OPTION_OFFSETX_TOOLTIP = "The offset your tooltip will display in relation to the cursor on the horizontal axis";
TB_OPTION_OFFSETY_TOOLTIP = "The offset your tooltip will display in relation to the cursor on the vertical axis";
TB_OPTION_COLORBUTTON_TOOLTIP = "Select the tooltip background color to display for this unit type";
TB_OPTION_COLORBUTTON_BOR_TOOLTIP = "Select the tooltip border color to display for this unit type";
TB_OPTION_SAMEGUILD = "Guild BG Color";
TB_OPTION_SAMEGUILD_TOOLTIP = "Select the tooltip background color to display for players in the same guild as you";
TB_OPTION_SAMEGUILDB = "Guild Border Color";
TB_OPTION_SAMEGUILDB_TOOLTIP = "Select the tooltip border color to display for players in the same guild as you";
TB_OPTION_NONUNITBG = "Non-Unit BG Color";
TB_OPTION_NONUNITBG_TOOLTIP = "Select the tooltip background color to display for everything that isn't a unit."..TB_GRY_TXT.."\n(buttons, icons, items, spells, etc)";
TB_OPTION_NONUNITBGB = "Non-Unit Border Color";
TB_OPTION_NONUNITBGB_TOOLTIP = "Select the tooltip border color to display for everything that isn't a unit."..TB_GRY_TXT.."\n(buttons, icons, items, spells, etc)";
TB_OPTION_CLASSCOLOR = "Colored Class Text";
TB_OPTION_CLASSCOLOR_TOOLTIP = "Enable this to have the class text for players be color coded";
TB_OPTION_FADEDEFAULT = "Fade Default Tooltip";
TB_OPTION_FADEDEFAULT_TOOLTIP = "Enable this to make the Default tooltip mode fade away instead of disappearing immediately";
TB_OPTION_BLIZZARDDEFAULT = "Blizzard Default";
TB_OPTION_BLIZZARDDEFAULT_TOOLTIP = "Enable this to display your tooltips in the default Blizzard style and not take advantage of the coloring or formatting that TipBuddy provides."..TB_GRY_TXT.."\n(You will still be able to take advantage of the anchoring, background colors, buffs, pvp icon and rank icon options, however)";
TB_OPTION_REPOSITIONMODS = "Keep Tips On Screen";
TB_OPTION_REPOSITIONMODS_TOOLTIP = "Enabling this will keep all of your tooltips from extending off the side of the screen  (usually by other mods)";
TB_OPTION_UBERTIPANCH = "Anchor Non-Unit Tips";
TB_OPTION_UBERTIPANCH_TOOLTIP = "Enable this to have your non-unit tips (buttons, etc) anchor to the TipBuddyAnchor instead of the cursor.\n\nIf the 'Use TipBuddyAnchor' checkbox is checked, then all tooltips will anchor the the TipBuddyAnchor automatically";
TB_OPTION_DIFFBACKGROUND = "Difficulty as Backdrop"
TB_OPTION_DIFFBACKGROUND_TOOLTIP = "Enabling this will display your tooltip backdrops to be colored based on the units difficulty to you instead of the custom colors"

TB_OPTION_NONUNITPOS_TOOLTIP = "Select how you want your non-unit tips to anchor";
TB_OPTION_CURSORPOS_TOOLTIP = "Select the position of the tooltip in relation to your cursor";
TB_OPTION_COLORTEXTBUTTON_TOOLTIP = "Options menu for selecting your tooltip text colors";
TB_OPTION_STYLEMODE_TOOLTIP = "Choose which style tooltip to use for this unit type";

TB_OPTION_BORDER_TOOLTIP = "Choose how you would like your tooltip BORDERS colored";
TB_OPTION_BACKDROP_TOOLTIP = "Choose how you would like your tooltip BACKDROPS colored";

TB_OPTION_TRG_PL = "Friendly Players";
TB_OPTION_TRG_PL_TOOLTIP = "";
TB_OPTION_TRG_EN = "Enemies";
TB_OPTION_TRG_EN_TOOLTIP = "";
TB_OPTION_TRG_NP = "Non-Hostile NPCs";
TB_OPTION_TRG_NP_TOOLTIP = "";
TB_OPTION_TRG_PA = "Party Members";
TB_OPTION_TRG_PA_TOOLTIP = "";
TB_OPTION_TRG_2L = "Seperate Line";
TB_OPTION_TRG_2L_TOOLTIP = "Check to show the unit's target on a seperate line than their name";

TB_RESETVARS_DIALOG = "Are you sure you wish to reset all of your settings?";

end


TipBuddy_OptionsFrame_Sliders = {
	{ text = TB_OPTION_SCALE, type = "general", var = "scalemod", minValue = 0, maxValue = 6, valueStep = 1, tooltipText = TB_OPTION_SCALE_TOOLTIP},
	{ text = TB_OPTION_DELAY, type = "general", var = "delaytime", minValue = 0.0, maxValue = 4.0, valueStep = 0.1, tooltipText = TB_OPTION_DELAY_TOOLTIP},
	{ text = TB_OPTION_FADETIME, type = "general", var = "fadetime", minValue = 0.0, maxValue = 4.0, valueStep = 0.1, tooltipText = TB_OPTION_FADETIME_TOOLTIP},
	{ text = "X Offset", type = "general", var = "offset_x", minValue = -100, maxValue = 100, valueStep = 1, tooltipText = TB_OPTION_OFFSETX_TOOLTIP},
	{ text = "Y Offset", type = "general", var = "offset_y", minValue = -100, maxValue = 100, valueStep = 1, tooltipText = TB_OPTION_OFFSETY_TOOLTIP},
	{ text = TB_OPTION_GTTSCALE, type = "general", var = "gtt_scale", minValue = 0.5, maxValue = 1.5, valueStep = 0.05, tooltipText = TB_OPTION_GTTSCALE_TOOLTIP},
};

TipBuddy_ColorPicker_Buttons = {
	{ frame = "TipBuddy_OptionsFrame_ColorPicker1", type = "pc_friend", var = "bgcolor", tooltipText = TB_OPTION_COLORBUTTON_TOOLTIP},
	{ frame = "TipBuddy_OptionsFrame_ColorPicker2", type = "pc_party", var = "bgcolor", tooltipText = TB_OPTION_COLORBUTTON_TOOLTIP},
	{ frame = "TipBuddy_OptionsFrame_ColorPicker3", type = "pc_enemy", var = "bgcolor", tooltipText = TB_OPTION_COLORBUTTON_TOOLTIP},
	{ frame = "TipBuddy_OptionsFrame_ColorPicker4", type = "npc_friend", var = "bgcolor", tooltipText = TB_OPTION_COLORBUTTON_TOOLTIP},
	{ frame = "TipBuddy_OptionsFrame_ColorPicker5", type = "npc_neutral", var = "bgcolor", tooltipText = TB_OPTION_COLORBUTTON_TOOLTIP},
	{ frame = "TipBuddy_OptionsFrame_ColorPicker6", type = "npc_enemy", var = "bgcolor", tooltipText = TB_OPTION_COLORBUTTON_TOOLTIP},
	{ frame = "TipBuddy_OptionsFrame_ColorPicker7", type = "pet_friend", var = "bgcolor", tooltipText = TB_OPTION_COLORBUTTON_TOOLTIP},
	{ frame = "TipBuddy_OptionsFrame_ColorPicker8", type = "pet_enemy", var = "bgcolor", tooltipText = TB_OPTION_COLORBUTTON_TOOLTIP},
	{ text = TB_OPTION_SAMEGUILD, frame = "TipBuddy_OptionsFrame_ColorPicker9", type = "guild", var = "bgcolor", tooltipText = TB_OPTION_SAMEGUILD_TOOLTIP},
	{ frame = "TipBuddy_OptionsFrame_ColorPicker10", type = "corpse", var = "bgcolor", tooltipText = TB_OPTION_COLORBUTTON_TOOLTIP},
	{ frame = "TipBuddy_OptionsFrame_ColorPicker11", type = "pc_friend", var = "bgbcolor", tooltipText = TB_OPTION_COLORBUTTON_BOR_TOOLTIP},
	{ frame = "TipBuddy_OptionsFrame_ColorPicker12", type = "pc_party", var = "bgbcolor", tooltipText = TB_OPTION_COLORBUTTON_BOR_TOOLTIP},
	{ frame = "TipBuddy_OptionsFrame_ColorPicker13", type = "pc_enemy", var = "bgbcolor", tooltipText = TB_OPTION_COLORBUTTON_BOR_TOOLTIP},
	{ frame = "TipBuddy_OptionsFrame_ColorPicker14", type = "npc_friend", var = "bgbcolor", tooltipText = TB_OPTION_COLORBUTTON_BOR_TOOLTIP},
	{ frame = "TipBuddy_OptionsFrame_ColorPicker15", type = "npc_neutral", var = "bgbcolor", tooltipText = TB_OPTION_COLORBUTTON_BOR_TOOLTIP},
	{ frame = "TipBuddy_OptionsFrame_ColorPicker16", type = "npc_enemy", var = "bgbcolor", tooltipText = TB_OPTION_COLORBUTTON_BOR_TOOLTIP},
	{ frame = "TipBuddy_OptionsFrame_ColorPicker17", type = "pet_friend", var = "bgbcolor", tooltipText = TB_OPTION_COLORBUTTON_BOR_TOOLTIP},
	{ frame = "TipBuddy_OptionsFrame_ColorPicker18", type = "pet_enemy", var = "bgbcolor", tooltipText = TB_OPTION_COLORBUTTON_BOR_TOOLTIP},
	{ text = TB_OPTION_SAMEGUILDB, frame = "TipBuddy_OptionsFrame_ColorPicker19", type = "guild", var = "bgbcolor", tooltipText = TB_OPTION_SAMEGUILDB_TOOLTIP},
	{ frame = "TipBuddy_OptionsFrame_ColorPicker20", type = "corpse", var = "bgbcolor", tooltipText = TB_OPTION_COLORBUTTON_BOR_TOOLTIP},
	{ text = TB_OPTION_NONUNITBG, frame = "TipBuddy_OptionsFrame_ColorPicker21", type = "general", var = "bgcolor", tooltipText = TB_OPTION_NONUNITBG_TOOLTIP},
	{ text = TB_OPTION_NONUNITBGB, frame = "TipBuddy_OptionsFrame_ColorPicker22", type = "general", var = "bgbcolor", tooltipText = TB_OPTION_NONUNITBGB_TOOLTIP},
};


if (GetLocale() == "zhCN") then
TipBuddy_ColorPicker_Buttons_Text = {

	{ text = "敌对", frame = "TipBuddy_OptionsFrame_ColorPicker_Text1", type = "textcolors", var = "nam_hos", tooltipText = ""},
	{ text = "中立", frame = "TipBuddy_OptionsFrame_ColorPicker_Text2", type = "textcolors", var = "nam_neu", tooltipText = ""},
	{ text = "友好", frame = "TipBuddy_OptionsFrame_ColorPicker_Text3", type = "textcolors", var = "nam_fri", tooltipText = ""},
	{ text = "不友好", frame = "TipBuddy_OptionsFrame_ColorPicker_Text4", type = "textcolors", var = "nam_cau", tooltipText = ""},
	{ text = "友好(打开PvP)", frame = "TipBuddy_OptionsFrame_ColorPicker_Text5", type = "textcolors", var = "nam_pvp", tooltipText = ""},
	{ text = "被你锁定", frame = "TipBuddy_OptionsFrame_ColorPicker_Text6", type = "textcolors", var = "nam_tpp", tooltipText = ""},
	{ text = "被别人锁定", frame = "TipBuddy_OptionsFrame_ColorPicker_Text7", type = "textcolors", var = "nam_tpo", tooltipText = ""},

	{ text = "敌对", frame = "TipBuddy_OptionsFrame_ColorPicker_Text8", type = "textcolors", var = "gld_hos", tooltipText = ""},
	{ text = "中立", frame = "TipBuddy_OptionsFrame_ColorPicker_Text9", type = "textcolors", var = "gld_neu", tooltipText = ""},
	{ text = "友好", frame = "TipBuddy_OptionsFrame_ColorPicker_Text10", type = "textcolors", var = "gld_fri", tooltipText = ""},
	{ text = "不友好", frame = "TipBuddy_OptionsFrame_ColorPicker_Text11", type = "textcolors", var = "gld_cau", tooltipText = ""},
	{ text = "友好(打开PvP)", frame = "TipBuddy_OptionsFrame_ColorPicker_Text12", type = "textcolors", var = "gld_pvp", tooltipText = ""},
	{ text = "被你锁定", frame = "TipBuddy_OptionsFrame_ColorPicker_Text13", type = "textcolors", var = "gld_tpp", tooltipText = ""},
	{ text = "被别人锁定", frame = "TipBuddy_OptionsFrame_ColorPicker_Text14", type = "textcolors", var = "gld_tpo", tooltipText = ""},
	{ text = "公会成员", frame = "TipBuddy_OptionsFrame_ColorPicker_Text15", type = "textcolors", var = "gld_mte", tooltipText = ""},

	{ text = "地狱",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text16", type = "textcolors", var = "lvl_imp", tooltipText = ""},
	{ text = "噩梦",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text17", type = "textcolors", var = "lvl_vdf", tooltipText = ""},
	{ text = "困难",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text18", type = "textcolors", var = "lvl_dif", tooltipText = ""},
	{ text = "普通",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text19", type = "textcolors", var = "lvl_stn", tooltipText = ""},
	{ text = "小菜",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text20", type = "textcolors", var = "lvl_trv", tooltipText = ""},
	{ text = "战友",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text21", type = "textcolors", var = "lvl_sfc", tooltipText = ""},

	{ text = "法师",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text22", type = "textcolors", var = "cls_mag", tooltipText = ""},
	{ text = "术士",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text23", type = "textcolors", var = "cls_wlk", tooltipText = ""},
	{ text = "牧师",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text24", type = "textcolors", var = "cls_pri", tooltipText = ""},
	{ text = "德鲁伊",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text25", type = "textcolors", var = "cls_drd", tooltipText = ""},
	{ text = "萨满祭司",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text26", type = "textcolors", var = "cls_shm", tooltipText = ""},
	{ text = "圣骑士",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text27", type = "textcolors", var = "cls_pal", tooltipText = ""},
	{ text = "潜行者",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text28", type = "textcolors", var = "cls_rog", tooltipText = ""},
	{ text = "猎人",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text29", type = "textcolors", var = "cls_hun", tooltipText = ""},
	{ text = "战士",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text30", type = "textcolors", var = "cls_war", tooltipText = ""},
	{ text = "其他职业",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text31", type = "textcolors", var = "cls_oth", tooltipText = ""},

	{ text = "稀有(怪物)信息",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text32", type = "textcolors", var = "elite_rar", tooltipText = ""},
	{ text = "Boss(怪物)信息",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text33", type = "textcolors", var = "elite_bss", tooltipText = ""},

	{ text = "尸体文字",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text34", type = "textcolors", var = "other_crp", tooltipText = ""},
	{ text = "其他文字",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text35", type = "textcolors", var = "other_unk", tooltipText = ""},
	{ text = "种族文字",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text36", type = "textcolors", var = "other_rac", tooltipText = ""},
	{ text = "城市阵营",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text37", type = "textcolors", var = "other_ctf", tooltipText = ""},
};
elseif (GetLocale() == "zhTW") then
TipBuddy_ColorPicker_Buttons_Text = {
	{ text = "敵對", frame = "TipBuddy_OptionsFrame_ColorPicker_Text1", type = "textcolors", var = "nam_hos", tooltipText = ""},
	{ text = "中立", frame = "TipBuddy_OptionsFrame_ColorPicker_Text2", type = "textcolors", var = "nam_neu", tooltipText = ""},
	{ text = "友好", frame = "TipBuddy_OptionsFrame_ColorPicker_Text3", type = "textcolors", var = "nam_fri", tooltipText = ""},
	{ text = "不友好", frame = "TipBuddy_OptionsFrame_ColorPicker_Text4", type = "textcolors", var = "nam_cau", tooltipText = ""},
	{ text = "友好(打開PvP)", frame = "TipBuddy_OptionsFrame_ColorPicker_Text5", type = "textcolors", var = "nam_pvp", tooltipText = ""},
	{ text = "被你鎖定", frame = "TipBuddy_OptionsFrame_ColorPicker_Text6", type = "textcolors", var = "nam_tpp", tooltipText = ""},
	{ text = "被別人鎖定", frame = "TipBuddy_OptionsFrame_ColorPicker_Text7", type = "textcolors", var = "nam_tpo", tooltipText = ""},

	{ text = "敵對", frame = "TipBuddy_OptionsFrame_ColorPicker_Text8", type = "textcolors", var = "gld_hos", tooltipText = ""},
	{ text = "中立", frame = "TipBuddy_OptionsFrame_ColorPicker_Text9", type = "textcolors", var = "gld_neu", tooltipText = ""},
	{ text = "友好", frame = "TipBuddy_OptionsFrame_ColorPicker_Text10", type = "textcolors", var = "gld_fri", tooltipText = ""},
	{ text = "不友好", frame = "TipBuddy_OptionsFrame_ColorPicker_Text11", type = "textcolors", var = "gld_cau", tooltipText = ""},
	{ text = "友好(打開PvP)", frame = "TipBuddy_OptionsFrame_ColorPicker_Text12", type = "textcolors", var = "gld_pvp", tooltipText = ""},
	{ text = "被你鎖定", frame = "TipBuddy_OptionsFrame_ColorPicker_Text13", type = "textcolors", var = "gld_tpp", tooltipText = ""},
	{ text = "被別人鎖定", frame = "TipBuddy_OptionsFrame_ColorPicker_Text14", type = "textcolors", var = "gld_tpo", tooltipText = ""},
	{ text = "公會成員", frame = "TipBuddy_OptionsFrame_ColorPicker_Text15", type = "textcolors", var = "gld_mte", tooltipText = ""},

	{ text = "地獄",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text16", type = "textcolors", var = "lvl_imp", tooltipText = ""},
	{ text = "噩夢",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text17", type = "textcolors", var = "lvl_vdf", tooltipText = ""},
	{ text = "困難",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text18", type = "textcolors", var = "lvl_dif", tooltipText = ""},
	{ text = "普通",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text19", type = "textcolors", var = "lvl_stn", tooltipText = ""},
	{ text = "小菜",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text20", type = "textcolors", var = "lvl_trv", tooltipText = ""},
	{ text = "戰友",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text21", type = "textcolors", var = "lvl_sfc", tooltipText = ""},

	{ text = "法師",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text22", type = "textcolors", var = "cls_mag", tooltipText = ""},
	{ text = "術士",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text23", type = "textcolors", var = "cls_wlk", tooltipText = ""},
	{ text = "牧師",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text24", type = "textcolors", var = "cls_pri", tooltipText = ""},
	{ text = "德魯伊",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text25", type = "textcolors", var = "cls_drd", tooltipText = ""},
	{ text = "薩滿祭司",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text26", type = "textcolors", var = "cls_shm", tooltipText = ""},
	{ text = "聖騎士",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text27", type = "textcolors", var = "cls_pal", tooltipText = ""},
	{ text = "盜賊",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text28", type = "textcolors", var = "cls_rog", tooltipText = ""},
	{ text = "獵人",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text29", type = "textcolors", var = "cls_hun", tooltipText = ""},
	{ text = "戰士",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text30", type = "textcolors", var = "cls_war", tooltipText = ""},
	{ text = "其他職業",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text31", type = "textcolors", var = "cls_oth", tooltipText = ""},

	{ text = "稀有(怪物)信息",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text32", type = "textcolors", var = "elite_rar", tooltipText = ""},
	{ text = "Boss(怪物)信息",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text33", type = "textcolors", var = "elite_bss", tooltipText = ""},

	{ text = "屍體文字",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text34", type = "textcolors", var = "other_crp", tooltipText = ""},
	{ text = "其他文字",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text35", type = "textcolors", var = "other_unk", tooltipText = ""},
	{ text = "種族文字",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text36", type = "textcolors", var = "other_rac", tooltipText = ""},
	{ text = "城市陣營",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text37", type = "textcolors", var = "other_ctf", tooltipText = ""},
};

else

TipBuddy_ColorPicker_Buttons_Text = {

	{ text = "Hostile", frame = "TipBuddy_OptionsFrame_ColorPicker_Text1", type = "textcolors", var = "nam_hos", tooltipText = ""},
	{ text = "Neutral", frame = "TipBuddy_OptionsFrame_ColorPicker_Text2", type = "textcolors", var = "nam_neu", tooltipText = ""},
	{ text = "Friendly", frame = "TipBuddy_OptionsFrame_ColorPicker_Text3", type = "textcolors", var = "nam_fri", tooltipText = ""},
	{ text = "Caution", frame = "TipBuddy_OptionsFrame_ColorPicker_Text4", type = "textcolors", var = "nam_cau", tooltipText = ""},
	{ text = "Friendly PvP", frame = "TipBuddy_OptionsFrame_ColorPicker_Text5", type = "textcolors", var = "nam_pvp", tooltipText = ""},
	{ text = "Tapped by You", frame = "TipBuddy_OptionsFrame_ColorPicker_Text6", type = "textcolors", var = "nam_tpp", tooltipText = ""},
	{ text = "Tapped by Other", frame = "TipBuddy_OptionsFrame_ColorPicker_Text7", type = "textcolors", var = "nam_tpo", tooltipText = ""},

	{ text = "Hostile", frame = "TipBuddy_OptionsFrame_ColorPicker_Text8", type = "textcolors", var = "gld_hos", tooltipText = ""},
	{ text = "Neutral", frame = "TipBuddy_OptionsFrame_ColorPicker_Text9", type = "textcolors", var = "gld_neu", tooltipText = ""},
	{ text = "Friendly", frame = "TipBuddy_OptionsFrame_ColorPicker_Text10", type = "textcolors", var = "gld_fri", tooltipText = ""},
	{ text = "Caution", frame = "TipBuddy_OptionsFrame_ColorPicker_Text11", type = "textcolors", var = "gld_cau", tooltipText = ""},
	{ text = "Friendly PvP", frame = "TipBuddy_OptionsFrame_ColorPicker_Text12", type = "textcolors", var = "gld_pvp", tooltipText = ""},
	{ text = "Tapped by You", frame = "TipBuddy_OptionsFrame_ColorPicker_Text13", type = "textcolors", var = "gld_tpp", tooltipText = ""},
	{ text = "Tapped by Other", frame = "TipBuddy_OptionsFrame_ColorPicker_Text14", type = "textcolors", var = "gld_tpo", tooltipText = ""},
	{ text = "Guild Mates", frame = "TipBuddy_OptionsFrame_ColorPicker_Text15", type = "textcolors", var = "gld_mte", tooltipText = ""},

	{ text = "Impossible",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text16", type = "textcolors", var = "lvl_imp", tooltipText = ""},
	{ text = "Very Difficult",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text17", type = "textcolors", var = "lvl_vdf", tooltipText = ""},
	{ text = "Difficult",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text18", type = "textcolors", var = "lvl_dif", tooltipText = ""},
	{ text = "Standard",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text19", type = "textcolors", var = "lvl_stn", tooltipText = ""},
	{ text = "Trivial",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text20", type = "textcolors", var = "lvl_trv", tooltipText = ""},
	{ text = "Same Faction",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text21", type = "textcolors", var = "lvl_sfc", tooltipText = ""},

	{ text = "Mage",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text22", type = "textcolors", var = "cls_mag", tooltipText = ""},
	{ text = "Warlock",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text23", type = "textcolors", var = "cls_wlk", tooltipText = ""},
	{ text = "Priest",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text24", type = "textcolors", var = "cls_pri", tooltipText = ""},
	{ text = "Druid",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text25", type = "textcolors", var = "cls_drd", tooltipText = ""},
	{ text = "Shaman",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text26", type = "textcolors", var = "cls_shm", tooltipText = ""},
	{ text = "Paladin",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text27", type = "textcolors", var = "cls_pal", tooltipText = ""},
	{ text = "Rogue",		frame = "TipBuddy_OptionsFrame_ColorPicker_Text28", type = "textcolors", var = "cls_rog", tooltipText = ""},
	{ text = "Hunter",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text29", type = "textcolors", var = "cls_hun", tooltipText = ""},
	{ text = "Warrior",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text30", type = "textcolors", var = "cls_war", tooltipText = ""},
	{ text = "Other Class",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text31", type = "textcolors", var = "cls_oth", tooltipText = ""},

	{ text = "Rare Text",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text32", type = "textcolors", var = "elite_rar", tooltipText = ""},
	{ text = "Boss Text",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text33", type = "textcolors", var = "elite_bss", tooltipText = ""},

	{ text = "Corpse Text",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text34", type = "textcolors", var = "other_crp", tooltipText = ""},
	{ text = "Other Text",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text35", type = "textcolors", var = "other_unk", tooltipText = ""},
	{ text = "Race Text",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text36", type = "textcolors", var = "other_rac", tooltipText = ""},
	{ text = "City Faction",	frame = "TipBuddy_OptionsFrame_ColorPicker_Text37", type = "textcolors", var = "other_ctf", tooltipText = ""},
};

end


TB_Op_Checks = {
	{ frame = "TB_Op_Check1", text = TB_OPTION_OFF, type = "pc_friend", var = "off", tooltipText = TB_OPTION_OFF_TOOLTIP },
	{ frame = "TB_Op_Check2", text = TB_OPTION_GLD, type = "pc_friend", var = "gld", tooltipText = TB_OPTION_GLD_TOOLTIP },
	{ frame = "TB_Op_Check3", text = TB_OPTION_HTH, type = "pc_friend", var = "hth", tooltipText = TB_OPTION_HTH_TOOLTIP },
	{ frame = "TB_Op_Check4", text = TB_OPTION_RAC, type = "pc_friend", var = "rac", tooltipText = TB_OPTION_RAC_TOOLTIP },
	{ frame = "TB_Op_Check5", text = TB_OPTION_CLS, type = "pc_friend", var = "cls", tooltipText = TB_OPTION_CLS_TOOLTIP },
	{ frame = "TB_Op_Check6", text = TB_OPTION_FAC, type = "pc_friend", var = "fac", tooltipText = TB_OPTION_FAC_TOOLTIP },
	{ frame = "TB_Op_Check7", text = TB_OPTION_BFF, type = "pc_friend", var = "bff", tooltipText = TB_OPTION_BFF_TOOLTIP },
	{ frame = "TB_Op_Check8", text = TB_OPTION_RNK, type = "pc_friend", var = "rnk", tooltipText = TB_OPTION_RNK_TOOLTIP },

	{ frame = "TB_Op_Check9", text = TB_OPTION_OFF, type = "pc_party", var = "off", tooltipText = TB_OPTION_OFF_TOOLTIP },
	{ frame = "TB_Op_Check10", text = TB_OPTION_GLD, type = "pc_party", var = "gld", tooltipText = TB_OPTION_GLD_TOOLTIP },
	{ frame = "TB_Op_Check11", text = TB_OPTION_HTH, type = "pc_party", var = "hth", tooltipText = TB_OPTION_HTH_TOOLTIP },
	{ frame = "TB_Op_Check12", text = TB_OPTION_RAC, type = "pc_party", var = "rac", tooltipText = TB_OPTION_RAC_TOOLTIP },
	{ frame = "TB_Op_Check13", text = TB_OPTION_CLS, type = "pc_party", var = "cls", tooltipText = TB_OPTION_CLS_TOOLTIP },
	{ frame = "TB_Op_Check14", text = TB_OPTION_FAC, type = "pc_party", var = "fac", tooltipText = TB_OPTION_FAC_TOOLTIP },
	{ frame = "TB_Op_Check15", text = TB_OPTION_BFF, type = "pc_party", var = "bff", tooltipText = TB_OPTION_BFF_TOOLTIP },
	{ frame = "TB_Op_Check16", text = TB_OPTION_RNK, type = "pc_party", var = "rnk", tooltipText = TB_OPTION_RNK_TOOLTIP },

	{ frame = "TB_Op_Check17", text = TB_OPTION_OFF, type = "pc_enemy", var = "off", tooltipText = TB_OPTION_OFF_TOOLTIP },
	{ frame = "TB_Op_Check18", text = TB_OPTION_GLD, type = "pc_enemy", var = "gld", tooltipText = TB_OPTION_GLD_TOOLTIP },
	{ frame = "TB_Op_Check19", text = TB_OPTION_HTH, type = "pc_enemy", var = "hth", tooltipText = TB_OPTION_HTH_TOOLTIP },
	{ frame = "TB_Op_Check20", text = TB_OPTION_RAC, type = "pc_enemy", var = "rac", tooltipText = TB_OPTION_RAC_TOOLTIP },
	{ frame = "TB_Op_Check21", text = TB_OPTION_CLS, type = "pc_enemy", var = "cls", tooltipText = TB_OPTION_CLS_TOOLTIP },
	{ frame = "TB_Op_Check22", text = TB_OPTION_FAC, type = "pc_enemy", var = "fac", tooltipText = TB_OPTION_FAC_TOOLTIP },
	{ frame = "TB_Op_Check23", text = TB_OPTION_BFF, type = "pc_enemy", var = "bff", tooltipText = TB_OPTION_BFF_TOOLTIP },
	{ frame = "TB_Op_Check24", text = TB_OPTION_RNK, type = "pc_enemy", var = "rnk", tooltipText = TB_OPTION_RNK_TOOLTIP },

	{ frame = "TB_Op_Check25", text = TB_OPTION_OFF, type = "npc_friend", var = "off", tooltipText = TB_OPTION_OFF_TOOLTIP },
	{ frame = "TB_Op_Check26", text = TB_OPTION_GLD_TITLE, type = "npc_friend", var = "gld", tooltipText = TB_OPTION_GLD_TITLE_TOOLTIP },
	{ frame = "TB_Op_Check27", text = TB_OPTION_HTH, type = "npc_friend", var = "hth", tooltipText = TB_OPTION_HTH_TOOLTIP },
	{ frame = "TB_Op_Check28", text = TB_OPTION_CFC, type = "npc_friend", var = "cfc", tooltipText = TB_OPTION_CFC_TOOLTIP },
	{ frame = "TB_Op_Check29", text = TB_OPTION_CLS_TYPE, type = "npc_friend", var = "cls", tooltipText = TB_OPTION_CLS_TYPE_TOOLTIP },
	{ frame = "TB_Op_Check30", text = TB_OPTION_FAC, type = "npc_friend", var = "fac", tooltipText = TB_OPTION_FAC_TOOLTIP },
	{ frame = "TB_Op_Check31", text = TB_OPTION_BFF, type = "npc_friend", var = "bff", tooltipText = TB_OPTION_BFF_TOOLTIP },
	{ frame = "TB_Op_Check32", text = TB_OPTION_XTR, type = "npc_friend", var = "xtr", tooltipText = TB_OPTION_XTR_TOOLTIP },

	{ frame = "TB_Op_Check33", text = TB_OPTION_OFF, type = "npc_enemy", var = "off", tooltipText = TB_OPTION_OFF_TOOLTIP },
	{ frame = "TB_Op_Check34", text = TB_OPTION_GLD_TITLE, type = "npc_enemy", var = "gld", tooltipText = TB_OPTION_GLD_TITLE_TOOLTIP },
	{ frame = "TB_Op_Check35", text = TB_OPTION_HTH, type = "npc_enemy", var = "hth", tooltipText = TB_OPTION_HTH_TOOLTIP },
	{ frame = "TB_Op_Check36", text = TB_OPTION_CFC, type = "npc_enemy", var = "cfc", tooltipText = TB_OPTION_CFC_TOOLTIP },
	{ frame = "TB_Op_Check37", text = TB_OPTION_CLS_TYPE, type = "npc_enemy", var = "cls", tooltipText = TB_OPTION_CLS_TYPE_TOOLTIP },
	{ frame = "TB_Op_Check38", text = TB_OPTION_FAC, type = "npc_enemy", var = "fac", tooltipText = TB_OPTION_FAC_TOOLTIP },
	{ frame = "TB_Op_Check39", text = TB_OPTION_BFF, type = "npc_enemy", var = "bff", tooltipText = TB_OPTION_BFF_TOOLTIP },
	{ frame = "TB_Op_Check40", text = TB_OPTION_XTR, type = "npc_enemy", var = "xtr", tooltipText = TB_OPTION_XTR_TOOLTIP },

	{ frame = "TB_Op_Check41", text = TB_OPTION_OFF, type = "pet_friend", var = "off", tooltipText = TB_OPTION_OFF_TOOLTIP },
	{ frame = "TB_Op_Check42", text = TB_OPTION_GLD_TITLE, type = "pet_friend", var = "gld", tooltipText = TB_OPTION_GLD_TITLE_TOOLTIP },
	{ frame = "TB_Op_Check43", text = TB_OPTION_HTH, type = "pet_friend", var = "hth", tooltipText = TB_OPTION_HTH_TOOLTIP },
	{ frame = "TB_Op_Check44", text = TB_OPTION_CFC, type = "pet_friend", var = "cfc", tooltipText = TB_OPTION_CFC_TOOLTIP },
	{ frame = "TB_Op_Check45", text = TB_OPTION_CLS_TYPE, type = "pet_friend", var = "cls", tooltipText = TB_OPTION_CLS_TYPE_TOOLTIP },
	{ frame = "TB_Op_Check46", text = TB_OPTION_FAC, type = "pet_friend", var = "fac", tooltipText = TB_OPTION_FAC_TOOLTIP },
	{ frame = "TB_Op_Check47", text = TB_OPTION_BFF, type = "pet_friend", var = "bff", tooltipText = TB_OPTION_BFF_TOOLTIP },
	{ frame = "TB_Op_Check48", text = TB_OPTION_XTR, type = "pet_friend", var = "xtr", tooltipText = TB_OPTION_XTR_TOOLTIP },

	{ frame = "TB_Op_Check49", text = TB_OPTION_OFF, type = "pet_enemy", var = "off", tooltipText = TB_OPTION_OFF_TOOLTIP },
	{ frame = "TB_Op_Check50", text = TB_OPTION_GLD_TITLE, type = "pet_enemy", var = "gld", tooltipText = TB_OPTION_GLD_TITLE_TOOLTIP },
	{ frame = "TB_Op_Check51", text = TB_OPTION_HTH, type = "pet_enemy", var = "hth", tooltipText = TB_OPTION_HTH_TOOLTIP },
	{ frame = "TB_Op_Check52", text = TB_OPTION_CFC, type = "pet_enemy", var = "cfc", tooltipText = TB_OPTION_CFC_TOOLTIP },
	{ frame = "TB_Op_Check53", text = TB_OPTION_CLS_TYPE, type = "pet_enemy", var = "cls", tooltipText = TB_OPTION_CLS_TYPE_TOOLTIP },
	{ frame = "TB_Op_Check54", text = TB_OPTION_FAC, type = "pet_enemy", var = "fac", tooltipText = TB_OPTION_FAC_TOOLTIP },
	{ frame = "TB_Op_Check55", text = TB_OPTION_BFF, type = "pet_enemy", var = "bff", tooltipText = TB_OPTION_BFF_TOOLTIP },
	{ frame = "TB_Op_Check56", text = TB_OPTION_XTR, type = "pet_enemy", var = "xtr", tooltipText = TB_OPTION_XTR_TOOLTIP },

	{ frame = "TB_Op_Check57", text = TB_OPTION_ANCHORED, type = "general", var = "anchored", tooltipText = TB_OPTION_ANCHORED_TOOLTIP },
	{ frame = "TB_Op_Check58", text = TB_OPTION_CLASSCOLOR, type = "general", var = "classcolor", tooltipText = TB_OPTION_CLASSCOLOR_TOOLTIP },
	{ frame = "TB_Op_Check59", text = TB_OPTION_FADEDEFAULT, type = "general", var = "gtt_fade", tooltipText = TB_OPTION_FADEDEFAULT_TOOLTIP },
	{ frame = "TB_Op_Check60", text = TB_OPTION_BLIZZARDDEFAULT, type = "general", var = "blizdefault", tooltipText = TB_OPTION_BLIZZARDDEFAULT_TOOLTIP },

	{ frame = "TB_Op_Check61", text = TB_OPTION_REPOSITIONMODS, type = "general", var = "reposmods", tooltipText = TB_OPTION_REPOSITIONMODS_TOOLTIP },
	{ frame = "TB_Op_Check62", text = TB_OPTION_DIFFBACKGROUND, type = "general", var = "diff_bg", tooltipText = TB_OPTION_DIFFBACKGROUND_TOOLTIP },

	{ frame = "TB_Op_Check63", text = TB_OPTION_RNM, type = "pc_friend", var = "rnm", tooltipText = TB_OPTION_RNM_TOOLTIP },
	{ frame = "TB_Op_Check64", text = TB_OPTION_RNM, type = "pc_party", var = "rnm", tooltipText = TB_OPTION_RNM_TOOLTIP },
	{ frame = "TB_Op_Check65", text = TB_OPTION_RNM, type = "pc_enemy", var = "rnm", tooltipText = TB_OPTION_RNM_TOOLTIP },

	{ frame = "TB_Op_Check66", text = "", type = "general", var = "c", tooltipText = "" },
	{ frame = "TB_Op_Check67", text = "", type = "general", var = "c", tooltipText = "" },
	{ frame = "TB_Op_Check68", text = "", type = "general", var = "c", tooltipText = "" },
	{ frame = "TB_Op_Check69", text = "", type = "general", var = "c", tooltipText = "" },

	{ frame = "TB_Op_Check70", text = TB_OPTION_OFF, type = "npc_neutral", var = "off", tooltipText = TB_OPTION_OFF_TOOLTIP },
	{ frame = "TB_Op_Check71", text = TB_OPTION_GLD_TITLE, type = "npc_neutral", var = "gld", tooltipText = TB_OPTION_GLD_TITLE_TOOLTIP },
	{ frame = "TB_Op_Check72", text = TB_OPTION_HTH, type = "npc_neutral", var = "hth", tooltipText = TB_OPTION_HTH_TOOLTIP },
	{ frame = "TB_Op_Check73", text = TB_OPTION_CFC, type = "npc_neutral", var = "cfc", tooltipText = TB_OPTION_CFC_TOOLTIP },
	{ frame = "TB_Op_Check74", text = TB_OPTION_CLS_TYPE, type = "npc_neutral", var = "cls", tooltipText = TB_OPTION_CLS_TYPE_TOOLTIP },
	{ frame = "TB_Op_Check75", text = TB_OPTION_FAC, type = "npc_neutral", var = "fac", tooltipText = TB_OPTION_FAC_TOOLTIP },
	{ frame = "TB_Op_Check76", text = TB_OPTION_BFF, type = "npc_neutral", var = "bff", tooltipText = TB_OPTION_BFF_TOOLTIP },
	{ frame = "TB_Op_Check77", text = TB_OPTION_XTR, type = "npc_neutral", var = "xtr", tooltipText = TB_OPTION_XTR_TOOLTIP },

	{ frame = "TB_Op_Check78", text = TB_OPTION_TRG, type = "pc_friend",	var = "trg", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_Op_Check79", text = TB_OPTION_TRG, type = "pc_party",	var = "trg", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_Op_Check80", text = TB_OPTION_TRG, type = "pc_enemy",	var = "trg", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_Op_Check81", text = TB_OPTION_TRG, type = "npc_friend",	var = "trg", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_Op_Check82", text = TB_OPTION_TRG, type = "npc_neutral",	var = "trg", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_Op_Check83", text = TB_OPTION_TRG, type = "npc_enemy",	var = "trg", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_Op_Check84", text = TB_OPTION_TRG, type = "pet_friend",	var = "trg", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_Op_Check85", text = TB_OPTION_TRG, type = "pet_enemy",	var = "trg", tooltipText = TB_OPTION_TRG_TOOLTIP },

	{ frame = "TB_Op_Check86", text = TB_OPTION_OFF, type = "corpse", var = "off", tooltipText = TB_OPTION_OFF_TOOLTIP },
	{ frame = "TB_Op_Check87", text = TB_OPTION_GLD_TITLE, type = "corpse", var = "gld", tooltipText = TB_OPTION_GLD_TITLE_TOOLTIP },
	{ frame = "TB_Op_Check88", text = TB_OPTION_CFC, type = "corpse", var = "cfc", tooltipText = TB_OPTION_CFC_TOOLTIP },
	{ frame = "TB_Op_Check89", text = TB_OPTION_CLS_TYPE, type = "corpse", var = "cls", tooltipText = TB_OPTION_CLS_TYPE_TOOLTIP },

	{ frame = "TB_Op_Check78_PlusPopup_1", text = TB_OPTION_TRG_PL, type = "pc_friend",	var = "trg_pl", tooltipText = TB_OPTION_TRG_PL_TOOLTIP },
	{ frame = "TB_Op_Check78_PlusPopup_2", text = TB_OPTION_TRG_EN, type = "pc_friend",	var = "trg_en", tooltipText = TB_OPTION_TRG_EN_TOOLTIP },
	{ frame = "TB_Op_Check78_PlusPopup_3", text = TB_OPTION_TRG_NP, type = "pc_friend",	var = "trg_np", tooltipText = TB_OPTION_TRG_NP_TOOLTIP },
	{ frame = "TB_Op_Check78_PlusPopup_4", text = TB_OPTION_TRG_PA, type = "pc_friend",	var = "trg_pa", tooltipText = TB_OPTION_TRG_PA_TOOLTIP },
	{ frame = "TB_Op_Check78_PlusPopup_5", text = TB_OPTION_TRG_2L, type = "pc_friend",	var = "trg_2l", tooltipText = TB_OPTION_TRG_2L_TOOLTIP },

	{ frame = "TB_Op_Check79_PlusPopup_1", text = TB_OPTION_TRG_PL, type = "pc_party",	var = "trg_pl", tooltipText = TB_OPTION_TRG_PL_TOOLTIP },
	{ frame = "TB_Op_Check79_PlusPopup_2", text = TB_OPTION_TRG_EN, type = "pc_party",	var = "trg_en", tooltipText = TB_OPTION_TRG_EN_TOOLTIP },
	{ frame = "TB_Op_Check79_PlusPopup_3", text = TB_OPTION_TRG_NP, type = "pc_party",	var = "trg_np", tooltipText = TB_OPTION_TRG_NP_TOOLTIP },
	{ frame = "TB_Op_Check79_PlusPopup_4", text = TB_OPTION_TRG_PA, type = "pc_party",	var = "trg_pa", tooltipText = TB_OPTION_TRG_PA_TOOLTIP },
	{ frame = "TB_Op_Check79_PlusPopup_5", text = TB_OPTION_TRG_2L, type = "pc_party",	var = "trg_2l", tooltipText = TB_OPTION_TRG_2L_TOOLTIP },

	{ frame = "TB_Op_Check80_PlusPopup_1", text = TB_OPTION_TRG_PL, type = "pc_enemy",	var = "trg_pl", tooltipText = TB_OPTION_TRG_PL_TOOLTIP },
	{ frame = "TB_Op_Check80_PlusPopup_2", text = TB_OPTION_TRG_EN, type = "pc_enemy",	var = "trg_en", tooltipText = TB_OPTION_TRG_EN_TOOLTIP },
	{ frame = "TB_Op_Check80_PlusPopup_3", text = TB_OPTION_TRG_NP, type = "pc_enemy",	var = "trg_np", tooltipText = TB_OPTION_TRG_NP_TOOLTIP },
	{ frame = "TB_Op_Check80_PlusPopup_4", text = TB_OPTION_TRG_PA, type = "pc_enemy",	var = "trg_pa", tooltipText = TB_OPTION_TRG_PA_TOOLTIP },
	{ frame = "TB_Op_Check80_PlusPopup_5", text = TB_OPTION_TRG_2L, type = "pc_enemy",	var = "trg_2l", tooltipText = TB_OPTION_TRG_2L_TOOLTIP },

	{ frame = "TB_Op_Check81_PlusPopup_1", text = TB_OPTION_TRG_PL, type = "npc_friend",	var = "trg_pl", tooltipText = TB_OPTION_TRG_PL_TOOLTIP },
	{ frame = "TB_Op_Check81_PlusPopup_2", text = TB_OPTION_TRG_EN, type = "npc_friend",	var = "trg_en", tooltipText = TB_OPTION_TRG_EN_TOOLTIP },
	{ frame = "TB_Op_Check81_PlusPopup_3", text = TB_OPTION_TRG_NP, type = "npc_friend",	var = "trg_np", tooltipText = TB_OPTION_TRG_NP_TOOLTIP },
	{ frame = "TB_Op_Check81_PlusPopup_4", text = TB_OPTION_TRG_PA, type = "npc_friend",	var = "trg_pa", tooltipText = TB_OPTION_TRG_PA_TOOLTIP },
	{ frame = "TB_Op_Check81_PlusPopup_5", text = TB_OPTION_TRG_2L, type = "npc_friend",	var = "trg_2l", tooltipText = TB_OPTION_TRG_2L_TOOLTIP },

	{ frame = "TB_Op_Check82_PlusPopup_1", text = TB_OPTION_TRG_PL, type = "npc_neutral",	var = "trg_pl", tooltipText = TB_OPTION_TRG_PL_TOOLTIP },
	{ frame = "TB_Op_Check82_PlusPopup_2", text = TB_OPTION_TRG_EN, type = "npc_neutral",	var = "trg_en", tooltipText = TB_OPTION_TRG_EN_TOOLTIP },
	{ frame = "TB_Op_Check82_PlusPopup_3", text = TB_OPTION_TRG_NP, type = "npc_neutral",	var = "trg_np", tooltipText = TB_OPTION_TRG_NP_TOOLTIP },
	{ frame = "TB_Op_Check82_PlusPopup_4", text = TB_OPTION_TRG_PA, type = "npc_neutral",	var = "trg_pa", tooltipText = TB_OPTION_TRG_PA_TOOLTIP },
	{ frame = "TB_Op_Check82_PlusPopup_5", text = TB_OPTION_TRG_2L, type = "npc_neutral",	var = "trg_2l", tooltipText = TB_OPTION_TRG_2L_TOOLTIP },

	{ frame = "TB_Op_Check83_PlusPopup_1", text = TB_OPTION_TRG_PL, type = "npc_enemy",	var = "trg_pl", tooltipText = TB_OPTION_TRG_PL_TOOLTIP },
	{ frame = "TB_Op_Check83_PlusPopup_2", text = TB_OPTION_TRG_EN, type = "npc_enemy",	var = "trg_en", tooltipText = TB_OPTION_TRG_EN_TOOLTIP },
	{ frame = "TB_Op_Check83_PlusPopup_3", text = TB_OPTION_TRG_NP, type = "npc_enemy",	var = "trg_np", tooltipText = TB_OPTION_TRG_NP_TOOLTIP },
	{ frame = "TB_Op_Check83_PlusPopup_4", text = TB_OPTION_TRG_PA, type = "npc_enemy",	var = "trg_pa", tooltipText = TB_OPTION_TRG_PA_TOOLTIP },
	{ frame = "TB_Op_Check83_PlusPopup_5", text = TB_OPTION_TRG_2L, type = "npc_enemy",	var = "trg_2l", tooltipText = TB_OPTION_TRG_2L_TOOLTIP },

	{ frame = "TB_Op_Check84_PlusPopup_1", text = TB_OPTION_TRG_PL, type = "pet_friend",	var = "trg_pl", tooltipText = TB_OPTION_TRG_PL_TOOLTIP },
	{ frame = "TB_Op_Check84_PlusPopup_2", text = TB_OPTION_TRG_EN, type = "pet_friend",	var = "trg_en", tooltipText = TB_OPTION_TRG_EN_TOOLTIP },
	{ frame = "TB_Op_Check84_PlusPopup_3", text = TB_OPTION_TRG_NP, type = "pet_friend",	var = "trg_np", tooltipText = TB_OPTION_TRG_NP_TOOLTIP },
	{ frame = "TB_Op_Check84_PlusPopup_4", text = TB_OPTION_TRG_PA, type = "pet_friend",	var = "trg_pa", tooltipText = TB_OPTION_TRG_PA_TOOLTIP },
	{ frame = "TB_Op_Check84_PlusPopup_5", text = TB_OPTION_TRG_2L, type = "pet_friend",	var = "trg_2l", tooltipText = TB_OPTION_TRG_2L_TOOLTIP },

	{ frame = "TB_Op_Check85_PlusPopup_1", text = TB_OPTION_TRG_PL, type = "pet_enemy",	var = "trg_pl", tooltipText = TB_OPTION_TRG_PL_TOOLTIP },
	{ frame = "TB_Op_Check85_PlusPopup_2", text = TB_OPTION_TRG_EN, type = "pet_enemy",	var = "trg_en", tooltipText = TB_OPTION_TRG_EN_TOOLTIP },
	{ frame = "TB_Op_Check85_PlusPopup_3", text = TB_OPTION_TRG_NP, type = "pet_enemy",	var = "trg_np", tooltipText = TB_OPTION_TRG_NP_TOOLTIP },
	{ frame = "TB_Op_Check85_PlusPopup_4", text = TB_OPTION_TRG_PA, type = "pet_enemy",	var = "trg_pa", tooltipText = TB_OPTION_TRG_PA_TOOLTIP },
	{ frame = "TB_Op_Check85_PlusPopup_5", text = TB_OPTION_TRG_2L, type = "pet_enemy",	var = "trg_2l", tooltipText = TB_OPTION_TRG_2L_TOOLTIP },

	{ frame = "TB_Op_Check3_PlusPopup_1", text = "", type = "pc_friend",	var = "txt_hth", tooltipText = "" },
	{ frame = "TB_Op_Check3_PlusPopup_2", text = "", type = "pc_friend",	var = "txt_mna", tooltipText = "" },

	{ frame = "TB_Op_Check11_PlusPopup_1", text = "", type = "pc_party",	var = "txt_hth", tooltipText = "" },
	{ frame = "TB_Op_Check11_PlusPopup_2", text = "", type = "pc_party",	var = "txt_mna", tooltipText = "" },

	{ frame = "TB_Op_Check19_PlusPopup_1", text = "", type = "pc_enemy",	var = "txt_hth", tooltipText = "" },
	{ frame = "TB_Op_Check19_PlusPopup_2", text = "", type = "pc_enemy",	var = "txt_mna", tooltipText = "" },

	{ frame = "TB_Op_Check27_PlusPopup_1", text = "", type = "npc_friend",	var = "txt_hth", tooltipText = "" },
	{ frame = "TB_Op_Check27_PlusPopup_2", text = "", type = "npc_friend",	var = "txt_mna", tooltipText = "" },

	{ frame = "TB_Op_Check72_PlusPopup_1", text = "", type = "npc_neutral",	var = "txt_hth", tooltipText = "" },
	{ frame = "TB_Op_Check72_PlusPopup_2", text = "", type = "npc_neutral",	var = "txt_mna", tooltipText = "" },

	{ frame = "TB_Op_Check35_PlusPopup_1", text = "", type = "npc_enemy",	var = "txt_hth", tooltipText = "" },
	{ frame = "TB_Op_Check35_PlusPopup_2", text = "", type = "npc_enemy",	var = "txt_mna", tooltipText = "" },

	{ frame = "TB_Op_Check43_PlusPopup_1", text = "", type = "pet_friend",	var = "txt_hth", tooltipText = "" },
	{ frame = "TB_Op_Check43_PlusPopup_2", text = "", type = "pet_friend",	var = "txt_mna", tooltipText = "" },

	{ frame = "TB_Op_Check51_PlusPopup_1", text = "", type = "pet_enemy",	var = "txt_hth", tooltipText = "" },
	{ frame = "TB_Op_Check51_PlusPopup_2", text = "", type = "pet_enemy",	var = "txt_mna", tooltipText = "" },

	--Faction/PvP text
	{ frame = "TB_Op_Check6_PlusPopup_1", text = "", type = "pc_friend",	var = "txt_pvp", tooltipText = "" },
	{ frame = "TB_Op_Check14_PlusPopup_1", text = "", type = "pc_party",	var = "txt_pvp", tooltipText = "" },
	{ frame = "TB_Op_Check22_PlusPopup_1", text = "", type = "pc_enemy",	var = "txt_pvp", tooltipText = "" },
	{ frame = "TB_Op_Check30_PlusPopup_1", text = "", type = "npc_friend",	var = "txt_pvp", tooltipText = "" },
	{ frame = "TB_Op_Check75_PlusPopup_1", text = "", type = "npc_neutral",	var = "txt_pvp", tooltipText = "" },
	{ frame = "TB_Op_Check38_PlusPopup_1", text = "", type = "npc_enemy",	var = "txt_pvp", tooltipText = "" },
	{ frame = "TB_Op_Check46_PlusPopup_1", text = "", type = "pet_friend",	var = "txt_pvp", tooltipText = "" },
	{ frame = "TB_Op_Check54_PlusPopup_1", text = "", type = "pet_enemy",	var = "txt_pvp", tooltipText = "" },
};

TB_EditBoxes = {
	{ frame = "TB_EditBox_01_1", text = TB_OPTION_TRG, type = "pc_friend",	var = "ebx1", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_EditBox_01_2", text = TB_OPTION_TRG, type = "pc_friend",	var = "ebx2", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_EditBox_02_1", text = TB_OPTION_TRG, type = "pc_party",	var = "ebx1", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_EditBox_02_2", text = TB_OPTION_TRG, type = "pc_party",	var = "ebx2", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_EditBox_03_1", text = TB_OPTION_TRG, type = "pc_enemy",	var = "ebx1", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_EditBox_03_2", text = TB_OPTION_TRG, type = "pc_enemy",	var = "ebx2", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_EditBox_04_1", text = TB_OPTION_TRG, type = "npc_friend",	var = "ebx1", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_EditBox_04_2", text = TB_OPTION_TRG, type = "npc_friend",	var = "ebx2", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_EditBox_05_1", text = TB_OPTION_TRG, type = "npc_neutral",	var = "ebx1", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_EditBox_05_2", text = TB_OPTION_TRG, type = "npc_neutral",	var = "ebx2", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_EditBox_06_1", text = TB_OPTION_TRG, type = "npc_enemy",	var = "ebx1", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_EditBox_06_2", text = TB_OPTION_TRG, type = "npc_enemy",	var = "ebx2", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_EditBox_07_1", text = TB_OPTION_TRG, type = "pet_friend",	var = "ebx1", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_EditBox_07_2", text = TB_OPTION_TRG, type = "pet_friend",	var = "ebx2", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_EditBox_08_1", text = TB_OPTION_TRG, type = "pet_enemy",	var = "ebx1", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_EditBox_08_2", text = TB_OPTION_TRG, type = "pet_enemy",	var = "ebx2", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_EditBox_09_1", text = TB_OPTION_TRG, type = "corpse",	var = "ebx1", tooltipText = TB_OPTION_TRG_TOOLTIP },
	{ frame = "TB_EditBox_09_2", text = TB_OPTION_TRG, type = "corpse",	var = "ebx2", tooltipText = TB_OPTION_TRG_TOOLTIP },
};

-- I hate doing this, but Bliz won't give us a function to look up an NPC's Faction.
-- This list will certainly break down at some point if/when more get added by Bliz.  :(
-- The factions are broken out by first letter to make the search much faster
-- thanks to Quindo Ma from worldofwar for obtaining this full list!  6/25/06
if (GetLocale() == "zhCN") then
TB_Factions = {
	["A"] = {
		[1] = "联盟",
		[2] = "联盟部队",			
		[3] = "银色黎明",
		[4] = "灰舌死誓者",
		},
	["B"] = {
		[1] = "黑暗深渊",				
		[2] = "血帆海盗",
		[3] = "蓝",						
		[4] = "藏宝海湾",
		[5] = "诺兹多姆的子嗣",
		[6] = "火刃氏族",				
		},
	["C"] = {
		[1] = "凯尔达隆",				
		[2] = "塞纳里奥议会",
		[3] = "塞纳里奥远征队",
		},
	["D"] = {
		[1] = "达拉然",					
		[2] = "黑铁矮人",			
		[3] = "暗月马戏团",
		[4] = "暗矛巨魔",			
		[5] = "达纳苏斯",
		[6] = "迪菲亚兄弟会",			
		[7] = "迪菲亚兄弟会叛节者",	
		},
	["E"] = {
		[1] = "永望镇",
		[2] = "埃克索多",
		},
	["F"] = {
		[1] = "弃灵",			
		[2] = "霜狼氏族",
		},
	["G"] = {
		[1] = "加基森",
		[2] = "吉尔吉斯半人马",
		[3] = "诺莫瑞根逃亡者",
		},
	["H"] = {
		[1] = "希尔斯布莱德, 南海镇",	
		[2] = "希尔斯布莱德民兵",				
		[3] = "荣耀堡",
		[4] = "部落",
		[5] = "部落军队",					
		[6] = "守夜人",				
		[7] = "海达希亚水元素",
		},
	["I"] = {
		[1] = "铁炉堡",
		},
	["J"] = {
		[1] = "加德纳尔",				
		},
	["K"] = {
		[1] = "时光守护者",
		[2] = "库雷尼",
		[3] = "库尔森独裁者",	
		},
	["L"] = {
		[1] = "失落者",				
		[2] = "贫民窟",
		},
	["M"] = {
		[1] = "玛格拉姆半人马",	
		[2] = "龙虾人",				
		[3] = "玛洛迪",				
		[4] = "卡利姆多联军",		
		},
	["N"] = {
		[1] = "奈瑟加德",			
		[2] = "奈瑟加德商队",	
		[3] = "灵翼之龙",
		},
	["O"] = {
		[1] = "食人魔",					
		[2] = "奥格里拉",
		[3] = "奥格瑞玛",
		},
	["R"] = {
		[1] = "棘齿城",
		[2] = "暴掠龙训练师",		
		[3] = "拉文霍德",
		[4] = "红",					
		[5] = "恶齿巨魔",		
		},
	["S"] = {
		[1] = "血色十字军",		
		[2] = "天灾军团",		
		[3] = "沙塔空卫队",
		[4] = "暗影蛛丝偷猎者",		
		[5] = "碎矛巨魔 ",	
		[6] = "辛德拉",
		[7] = "异种蝎",				
		[8] = "异种虫类",		
		[9] = "银月城",
		[10] = "银翼要塞",
		[11] = "南海海盗",	
		[12] = "孢子村",
		[13] = "热砂港",	
		[14] = "雷矛卫队",
		[15] = "暴风城",
		[16] = "辛迪加",
		},
	["T"] = {
		[1] = "工头费苏勒",		
		[2] = "奥尔多",
		[3] = "星界财团",
		[4] = "污染者",
		[5] = "铁炉堡军团",	
		[6] = "阿拉索联军",
		[7] = "流沙之鳞",
		[8] = "塞尔斯",
		[9] = "沙塔尔",
		[10] = "紫罗兰之眼",
		[11] = "塞拉摩",				
		[12] = "瑟银兄弟会",
		[13] = "雷霆崖",
		[14] = "木喉要塞",
		[15] = "训练假人",		
		[16] = "塔奎林",
		},
	["U"] = {
		[1] = "幽暗城",
		},
	["V"] = {
		[1] = "风险投资公司",		
		},
	["W"] = {
		[1] = "哀嚎洞穴",		
		[2] = "战歌氏族",		
		[3] = "蛮锤部族",
		[4] = "冬刃豹训练师",
		},
	["Z"] = {
		[1] = "赞达拉部族",
		},
};
elseif (GetLocale() == "zhTW") then
TB_Factions = {
	["A"] = {
		[1] = "聯盟",
		[2] = "聯盟部隊",			
		[3] = "銀色黎明",
		[4] = "灰舌死誓者",
		},
	["B"] = {
		[1] = "黑暗深淵",				
		[2] = "血帆海盜",
		[3] = "藍",						
		[4] = "藏寶海灣",
		[5] = "諾茲多姆的子嗣",
		[6] = "火刃氏族",				
		},
	["C"] = {
		[1] = "凱爾達隆",				
		[2] = "塞納裡奧議會",
		[3] = "塞納裡奧遠征隊",
		},
	["D"] = {
		[1] = "達拉然",					
		[2] = "黑鐵矮人",			
		[3] = "暗月馬戲團",
		[4] = "暗矛巨魔",			
		[5] = "達納蘇斯",
		[6] = "迪菲亞兄弟會",			
		[7] = "迪菲亞兄弟會叛節者",	
		},
	["E"] = {
		[1] = "永望鎮",
		[2] = "埃克索多",
		},
	["F"] = {
		[1] = "棄靈",			
		[2] = "霜狼氏族",
		},
	["G"] = {
		[1] = "加基森",
		[2] = "吉爾吉斯半人馬",
		[3] = "諾莫瑞根逃亡者",
		},
	["H"] = {
		[1] = "希爾斯布萊德, 南海鎮",	
		[2] = "希爾斯布萊德民兵",				
		[3] = "榮耀堡",
		[4] = "部落",
		[5] = "部落軍隊",					
		[6] = "守夜人",				
		[7] = "海達希亞水元素",
		},
	["I"] = {
		[1] = "鐵爐堡",
		},
	["J"] = {
		[1] = "加德納爾",				
		},
	["K"] = {
		[1] = "時光守護者",
		[2] = "庫雷尼",
		[3] = "庫爾森獨裁者",	
		},
	["L"] = {
		[1] = "失落者",				
		[2] = "貧民窟",
		},
	["M"] = {
		[1] = "瑪格拉姆半人馬",	
		[2] = "龍蝦人",				
		[3] = "瑪洛迪",				
		[4] = "卡利姆多聯軍",		
		},
	["N"] = {
		[1] = "奈瑟加德",			
		[2] = "奈瑟加德商隊",	
		[3] = "靈翼之龍",
		},
	["O"] = {
		[1] = "食人魔",					
		[2] = "奧格里拉",
		[3] = "奧格瑞瑪",
		},
	["R"] = {
		[1] = "棘齒城",
		[2] = "暴掠龍訓練師",		
		[3] = "拉文霍德",
		[4] = "紅",					
		[5] = "惡齒巨魔",		
		},
	["S"] = {
		[1] = "血色十字軍",		
		[2] = "天災軍團",		
		[3] = "沙塔空衛隊",
		[4] = "暗影蛛絲偷獵者",		
		[5] = "碎矛巨魔 ",	
		[6] = "辛德拉",
		[7] = "異種蠍",				
		[8] = "異種蟲類",		
		[9] = "銀月城",
		[10] = "銀翼要塞",
		[11] = "南海海盜",	
		[12] = "孢子村",
		[13] = "熱砂港",	
		[14] = "雷矛衛隊",
		[15] = "暴風城",
		[16] = "辛迪加",
		},
	["T"] = {
		[1] = "工頭費蘇勒",		
		[2] = "奧爾多",
		[3] = "星界財團",
		[4] = "污染者",
		[5] = "鐵爐堡軍團",	
		[6] = "阿拉索聯軍",
		[7] = "流沙之鱗",
		[8] = "塞爾斯",
		[9] = "沙塔爾",
		[10] = "紫羅蘭之眼",
		[11] = "塞拉摩",				
		[12] = "瑟銀兄弟會",
		[13] = "雷霆崖",
		[14] = "木喉要塞",
		[15] = "訓練假人",		
		[16] = "塔奎林",
		},
	["U"] = {
		[1] = "幽暗城",
		},
	["V"] = {
		[1] = "風險投資公司",		
		},
	["W"] = {
		[1] = "哀嚎洞穴",		
		[2] = "戰歌氏族",		
		[3] = "蠻錘部族",
		[4] = "冬刃豹訓練師",
		},
	["Z"] = {
		[1] = "贊達拉部族",
		},
};

else

TB_Factions = {
	["A"] = {
		[1] = "Alliance",
		[2] = "Alliance Forces",			-- who?
		[3] = "Argent Dawn",
		[4] = "Ashtongue Deathsworn",
		},
	["B"] = {
		[1] = "Blackfathom",				-- who?
		[2] = "Bloodsail Buccaneers",
		[3] = "Blue",						-- who?
		[4] = "Booty Bay",
		[5] = "Brood of Nozdormu",
		[6] = "Burning Blade",				-- who?
		},
	["C"] = {
		[1] = "Caer Darrow",				-- who?
		[2] = "Cenarion Circle",
		[3] = "Cenarion Expedition",
		},
	["D"] = {
		[1] = "Dalaran",					-- who?
		[2] = "Dark Iron Dwarves",			-- who?
		[3] = "Darkmoon Faire",
		[4] = "Darkspear Trolls",			-- who?
		[5] = "Darnassus",
		[6] = "Defias Brotherhood",			-- who?
		[7] = "Defias Brotherhood Traitor",	-- who?
		},
	["E"] = {
		[1] = "Everlook",
		[2] = "Exodar",
		},
	["F"] = {
		[1] = "Forlorn Spirit",			-- who?
		[2] = "Frostwolf Clan",
		},
	["G"] = {
		[1] = "Gadgetzan",
		[2] = "Gelkis Clan Centaur",
		[3] = "Gnomeregan Exiles",
		},
	["H"] = {
		[1] = "Hillsbrad, Southshore Mayor",	-- who?
		[2] = "Hillsbrad Militia",				-- who?
		[3] = "Honor Hold",
		[4] = "Horde",
		[5] = "Horde Forces",					-- who?
		[6] = "Human, Night Watch",				-- who?
		[7] = "Hydraxian Waterlords",
		},
	["I"] = {
		[1] = "Ironforge",
		},
	["J"] = {
		[1] = "Jaedenar",				-- who?
		},
	["K"] = {
		[1] = "Keepers of Time",
		[2] = "Kurenai",
		[3] = "Kurzen's Mercenaries",	-- who?
		},
	["L"] = {
		[1] = "Lost Ones",				-- who?
		[2] = "Lower City",
		},
	["M"] = {
		[1] = "Magram Clan Centaur",	-- who?
		[2] = "Makrura",				-- who?
		[3] = "Maraudine",				-- who?
		[4] = "Might of Kalimdor",		-- who?
		},
	["N"] = {
		[1] = "Nethergarde",			-- who?
		[2] = "Nethergarde Caravan",	-- who?
		[3] = "Netherwing",
		},
	["O"] = {
		[1] = "Ogre",					-- who?
		[2] = "Ogri'la",
		[3] = "Orgrimmar",
		},
	["R"] = {
		[1] = "Ratchet",
		[2] = "Ravasaur Trainers",		-- who?
		[3] = "Ravenholdt",
		[4] = "Red",					-- who?
		[5] = "Revantusk Trolls",		-- who?
		},
	["S"] = {
		[1] = "Scarlet Crusade",		-- who?
		[2] = "Scourge Invaders",		-- who?
		[3] = "Sha'tari Skyguard",
		[4] = "Shadowsilk Poacher",		-- who?
		[5] = "Shatterspear Trolls",	-- who?
		[6] = "Shen'dralar",
		[7] = "Silithid",				-- who?
		[8] = "Silithid Attackers",		-- who?
		[9] = "Silvermoon City",
		[10] = "Silverwing Sentinels",
		[11] = "Southsea Freebooters",	-- who?
		[12] = "Sporeggar",
		[13] = "Steamwheedle Cartel",	-- who?
		[14] = "Stormpike Guard",
		[15] = "Stormwind",
		[16] = "Syndicate",
		},
	["T"] = {
		[1] = "Taskmaster Fizzule",		-- who?
		[2] = "The Aldor",
		[3] = "The Consortium",
		[4] = "The Defilers",
		[5] = "The Ironforge Brigade",	-- who?
		[6] = "The League of Arathor",
		[7] = "The Scale of the Sands",
		[8] = "The Scryers",
		[9] = "The Sha'tar",
		[10] = "The Violet Eye",
		[11] = "Theramore",				-- who?
		[12] = "Thorium Brotherhood",
		[13] = "Thunder Bluff",
		[14] = "Timbermaw Hold",
		[15] = "Training Dummy",		-- who?
		[16] = "Tranquillien",
		},
	["U"] = {
		[1] = "Undercity",
		},
	["V"] = {
		[1] = "Venture Company",		-- who?
		},
	["W"] = {
		[1] = "Wailing Caverns",		-- who?
		[2] = "Warsong Outriders",		-- who?
		[3] = "Wildhammer Clan",
		[4] = "Wintersaber Trainers",
		},
	["Z"] = {
		[1] = "Zandalar Tribe",
		},
};

end

function TipBuddy_Register()
	if ( gLim_RegisterButton and IsAddOnLoaded("TipBuddy") ) then
		gLim_RegisterButton (
		TIPBUDDY_TITLE,
		TIPBUDDY_OPTION,
		"Interface\\Icons\\INV_Misc_Note_03",
		function()
			TipBuddy_ToggleOptionsFrame();
		end,
		1,
		5
		);
	end
end

function TipBuddy_Variable_Initialize()
	-- Return if the same version
	if (TipBuddy_SavedVars) and (TipBuddy_SavedVars["version"] == TIPBUDDY_VERSION) then
		return;
	end
	-- reset table
	if (not TipBuddy_SavedVars) then
		TipBuddy_SavedVars = { };
	end
	-- versions specific changes
	if (tonumber(TipBuddy_SavedVars["version"]) ~= nil) and (tonumber(TipBuddy_SavedVars["version"]) < 1.55) then
		TipBuddy_ResetOffState();
	elseif (tonumber(TipBuddy_SavedVars["version"]) ~= nil) and (tonumber(TipBuddy_SavedVars["version"]) < 1.74) then
		-- nothing
	end
	-- Init all variables
	TipBuddy_SavedVars["version"] = TIPBUDDY_VERSION;
--	TipBuddy_Msg("Initializing TipBuddy Variables");
	-- Player Friends
	if (TipBuddy_SavedVars["pc_friend"]) then
		if (TipBuddy_SavedVars["pc_friend"]["bgcolor"] == nil) then
			TipBuddy_SavedVars["pc_friend"].bgcolor = { r = 0.1, g = 0.22, b = 0.35, a = 0.78 };
		end
		if (TipBuddy_SavedVars["pc_friend"]["bgbcolor"] == nil) then
			TipBuddy_SavedVars["pc_friend"].bgbcolor = { r = 0.8, g = 0.8, b = 0.9, a = 1 };
		end
		if (not TipBuddy_SavedVars["pc_friend"]["off"]) then
			TipBuddy_SavedVars["pc_friend"].off = 0;
		end
		if (not TipBuddy_SavedVars["pc_friend"]["nam"]) then
			TipBuddy_SavedVars["pc_friend"].nam = 1;
		end
		if (not TipBuddy_SavedVars["pc_friend"]["cls"]) then
			TipBuddy_SavedVars["pc_friend"].cls = 1;
		end
		if (not TipBuddy_SavedVars["pc_friend"]["gld"]) then
			TipBuddy_SavedVars["pc_friend"].gld = 1;
		end
		if (not TipBuddy_SavedVars["pc_friend"]["fac"]) then
			TipBuddy_SavedVars["pc_friend"].fac = 1;
		end
		if (not TipBuddy_SavedVars["pc_friend"]["cfc"]) then
			TipBuddy_SavedVars["pc_friend"].cfc = 1;
		end
		if (not TipBuddy_SavedVars["pc_friend"]["bff"]) then
			TipBuddy_SavedVars["pc_friend"].bff = 1;
		end
		if (not TipBuddy_SavedVars["pc_friend"]["dbf"]) then
			TipBuddy_SavedVars["pc_friend"].dbf = 1;
		end
		if (not TipBuddy_SavedVars["pc_friend"]["xtr"]) then
			TipBuddy_SavedVars["pc_friend"].xtr = 1;
		end
		if (not TipBuddy_SavedVars["pc_friend"]["rac"]) then
			TipBuddy_SavedVars["pc_friend"].rac = 0;
		end
		if (not TipBuddy_SavedVars["pc_friend"]["rnk"]) then
			TipBuddy_SavedVars["pc_friend"].rnk = 1;
		end
		if (not TipBuddy_SavedVars["pc_friend"]["trg"]) then
			TipBuddy_SavedVars["pc_friend"].trg = 0;
		end
		if (not TipBuddy_SavedVars["pc_friend"]["trg_pl"]) then
			TipBuddy_SavedVars["pc_friend"].trg_pl = 0;
			TipBuddy_SavedVars["pc_friend"].trg_en = 0;
			TipBuddy_SavedVars["pc_friend"].trg_np = 0;
			TipBuddy_SavedVars["pc_friend"].trg_pa = 0;
		end
		if (not TipBuddy_SavedVars["pc_friend"]["txt_hth"]) then
			TipBuddy_SavedVars["pc_friend"].txt_hth = 0;
			TipBuddy_SavedVars["pc_friend"].txt_mna = 0;
			TipBuddy_SavedVars["pc_friend"].txt_pvp = 0;
		end
	else
		TipBuddy_SavedVars["pc_friend"] = {
				["bgcolor"] = {	a = 0.78, r = 0.1, g = 0.22, b = 0.35 },
				["bgbcolor"] = { a = 1,	r = 0.8, g = 0.8, b = 0.9 },
				["hth"] = 1,
				["xtr"] = 0,
				["off"] = 0,
				["cls"] = 1,
				["fac"] = 0,
				["bff"] = 0,
				["cfc"] = 0,
				["gld"] = 1,
				["rac"] = 1,
				["rnk"] = 1,
				["trg"] = 0,
				["trg_pl"] = 0,
				["trg_en"] = 0,
				["trg_np"] = 0,
				["trg_pa"] = 0,
				["txt_hth"] = 0,
				["txt_mna"] = 0,
				["txt_pvp"] = 0,
				};
	end
	-- Players Party
	if (TipBuddy_SavedVars["pc_party"]) then
		if (not TipBuddy_SavedVars["pc_party"]["bgcolor"]) then
			TipBuddy_SavedVars["pc_party"].bgcolor = { r = 0.07, g = 0.24, b = 0.19, a = 0.78 };
		end
		if (TipBuddy_SavedVars["pc_party"]["bgbcolor"] == nil) then
			TipBuddy_SavedVars["pc_party"].bgbcolor = { r = 0.8, g = 0.8, b = 0.9, a = 1 };
		end
		if (not TipBuddy_SavedVars["pc_party"]["off"]) then
			TipBuddy_SavedVars["pc_party"].off = 0;
		end
		if (not TipBuddy_SavedVars["pc_party"]["nam"]) then
			TipBuddy_SavedVars["pc_party"].nam = 1;
		end
		if (not TipBuddy_SavedVars["pc_party"]["cls"]) then
			TipBuddy_SavedVars["pc_party"].cls = 1;
		end
		if (not TipBuddy_SavedVars["pc_party"]["gld"]) then
			TipBuddy_SavedVars["pc_party"].gld = 1;
		end
		if (not TipBuddy_SavedVars["pc_party"]["fac"]) then
			TipBuddy_SavedVars["pc_party"].fac = 1;
		end
		if (not TipBuddy_SavedVars["pc_party"]["cfc"]) then
			TipBuddy_SavedVars["pc_party"].cfc = 1;
		end
		if (not TipBuddy_SavedVars["pc_party"]["bff"]) then
			TipBuddy_SavedVars["pc_party"].bff = 1;
		end
		if (not TipBuddy_SavedVars["pc_party"]["dbf"]) then
			TipBuddy_SavedVars["pc_party"].dbf = 1;
		end
		if (not TipBuddy_SavedVars["pc_party"]["xtr"]) then
			TipBuddy_SavedVars["pc_party"].xtr = 1;
		end
		if (not TipBuddy_SavedVars["pc_party"]["rac"]) then
			TipBuddy_SavedVars["pc_party"].rac = 1;
		end
		if (not TipBuddy_SavedVars["pc_party"]["rnk"]) then
			TipBuddy_SavedVars["pc_party"].rnk = 1;
		end
		if (not TipBuddy_SavedVars["pc_party"]["trg"]) then
			TipBuddy_SavedVars["pc_party"].trg = 1;
		end
		if (not TipBuddy_SavedVars["pc_party"]["trg_pl"]) then
			TipBuddy_SavedVars["pc_party"].trg_pl = 0;
			TipBuddy_SavedVars["pc_party"].trg_en = 0;
			TipBuddy_SavedVars["pc_party"].trg_np = 0;
			TipBuddy_SavedVars["pc_party"].trg_pa = 0;
		end
		if (not TipBuddy_SavedVars["pc_party"]["txt_hth"]) then
			TipBuddy_SavedVars["pc_party"].txt_hth = 0;
			TipBuddy_SavedVars["pc_party"].txt_mna = 0;
			TipBuddy_SavedVars["pc_party"].txt_pvp = 0;
		end
	else
		TipBuddy_SavedVars["pc_party"] = {
				["bgcolor"] = { a = 0.78, r = 0.07, g = 0.24, b = 0.19 },
				["bgbcolor"] = {a = 1, r = 0.8, g = 0.8, b = 0.9 },
				["hth"] = 1,
				["xtr"] = 0,
				["off"] = 0,
				["cls"] = 1,
				["fac"] = 0,
				["bff"] = 1,
				["cfc"] = 0,
				["gld"] = 1,
				["rac"] = 0,
				["rnk"] = 1,
				["trg"] = 1,
				["trg_pl"] = 0,
				["trg_en"] = 0,
				["trg_np"] = 0,
				["trg_pa"] = 0,
				["txt_hth"] = 0,
				["txt_mna"] = 0,
				["txt_pvp"] = 0,
				};
	end
	-- Players Enemies
	if (TipBuddy_SavedVars["pc_enemy"]) then
		if (not TipBuddy_SavedVars["pc_enemy"]["bgcolor"]) then
			TipBuddy_SavedVars["pc_enemy"].bgcolor = { r = 0.37, g = 0.12, b = 0.07, a = 0.78 };
		end
		if (TipBuddy_SavedVars["pc_enemy"]["bgbcolor"] == nil) then
			TipBuddy_SavedVars["pc_enemy"].bgbcolor = { r = 0.8, g = 0.8, b = 0.9, a = 1 };
		end
		if (not TipBuddy_SavedVars["pc_enemy"]["off"]) then
			TipBuddy_SavedVars["pc_enemy"].off = 0;
		end
		if (not TipBuddy_SavedVars["pc_enemy"]["nam"]) then
			TipBuddy_SavedVars["pc_enemy"].nam = 1;
		end
		if (not TipBuddy_SavedVars["pc_enemy"]["cls"]) then
			TipBuddy_SavedVars["pc_enemy"].cls = 1;
		end
		if (not TipBuddy_SavedVars["pc_enemy"]["gld"]) then
			TipBuddy_SavedVars["pc_enemy"].gld = 1;
		end
		if (not TipBuddy_SavedVars["pc_enemy"]["fac"]) then
			TipBuddy_SavedVars["pc_enemy"].fac = 1;
		end
		if (not TipBuddy_SavedVars["pc_enemy"]["cfc"]) then
			TipBuddy_SavedVars["pc_enemy"].cfc = 1;
		end
		if (not TipBuddy_SavedVars["pc_enemy"]["bff"]) then
			TipBuddy_SavedVars["pc_enemy"].bff = 1;
		end
		if (not TipBuddy_SavedVars["pc_enemy"]["dbf"]) then
			TipBuddy_SavedVars["pc_enemy"].dbf = 1;
		end
		if (not TipBuddy_SavedVars["pc_enemy"]["xtr"]) then
			TipBuddy_SavedVars["pc_enemy"].xtr = 1;
		end
		if (not TipBuddy_SavedVars["pc_enemy"]["rac"]) then
			TipBuddy_SavedVars["pc_enemy"].rac = 0;
		end
		if (not TipBuddy_SavedVars["pc_enemy"]["rnk"]) then
			TipBuddy_SavedVars["pc_enemy"].rnk = 1;
		end
		if (not TipBuddy_SavedVars["pc_enemy"]["trg"]) then
			TipBuddy_SavedVars["pc_enemy"].trg = 1;
		end
		if (not TipBuddy_SavedVars["pc_enemy"]["trg_pl"]) then
			TipBuddy_SavedVars["pc_enemy"].trg_pl = 0;
			TipBuddy_SavedVars["pc_enemy"].trg_en = 0;
			TipBuddy_SavedVars["pc_enemy"].trg_np = 0;
			TipBuddy_SavedVars["pc_enemy"].trg_pa = 0;
		end
		if (not TipBuddy_SavedVars["pc_enemy"]["txt_hth"]) then
			TipBuddy_SavedVars["pc_enemy"].txt_hth = 0;
			TipBuddy_SavedVars["pc_enemy"].txt_mna = 0;
			TipBuddy_SavedVars["pc_enemy"].txt_pvp = 0;
		end
	else
		TipBuddy_SavedVars["pc_enemy"] = {
				["bgcolor"] = { a = 0.78, r = 0.37, g = 0.12, b = 0.07 },
				["bgbcolor"] = { a = 1, r = 0.8, g = 0.8, b = 0.9 },
				["hth"] = 1,
				["xtr"] = 0,
				["off"] = 0,
				["cls"] = 1,
				["fac"] = 1,
				["bff"] = 1,
				["cfc"] = 0,
				["gld"] = 1,
				["rac"] = 1,
				["rnk"] = 1,
				["trg"] = 1,
				["trg_pl"] = 0,
				["trg_en"] = 0,
				["trg_np"] = 0,
				["trg_pa"] = 0,
				["txt_hth"] = 0,
				["txt_mna"] = 0,
				["txt_pvp"] = 0,
				};
	end
	-- NPC Friends
	if (TipBuddy_SavedVars["npc_friend"]) then
		if (not TipBuddy_SavedVars["npc_friend"]["bgcolor"]) then
			TipBuddy_SavedVars["npc_friend"].bgcolor = { r = 0.26, g = 0.01, b = 0.44, a = 0.78 };
		end
		if (TipBuddy_SavedVars["npc_friend"]["bgbcolor"] == nil) then
			TipBuddy_SavedVars["npc_friend"].bgbcolor = { r = 0.8, g = 0.8, b = 0.9, a = 1 };
		end
		if (not TipBuddy_SavedVars["npc_friend"]["off"]) then
			TipBuddy_SavedVars["npc_friend"].off = 0;
		end
		if (not TipBuddy_SavedVars["npc_friend"]["nam"]) then
			TipBuddy_SavedVars["npc_friend"].nam = 1;
		end
		if (not TipBuddy_SavedVars["npc_friend"]["cls"]) then
			TipBuddy_SavedVars["npc_friend"].cls = 1;
		end
		if (not TipBuddy_SavedVars["npc_friend"]["gld"]) then
			TipBuddy_SavedVars["npc_friend"].gld = 1;
		end
		if (not TipBuddy_SavedVars["npc_friend"]["fac"]) then
			TipBuddy_SavedVars["npc_friend"].fac = 1;
		end
		if (not TipBuddy_SavedVars["npc_friend"]["cfc"]) then
			TipBuddy_SavedVars["npc_friend"].cfc = 1;
		end
		if (not TipBuddy_SavedVars["npc_friend"]["bff"]) then
			TipBuddy_SavedVars["npc_friend"].bff = 1;
		end
		if (not TipBuddy_SavedVars["npc_friend"]["dbf"]) then
			TipBuddy_SavedVars["npc_friend"].dbf = 1;
		end
		if (not TipBuddy_SavedVars["npc_friend"]["xtr"]) then
			TipBuddy_SavedVars["npc_friend"].xtr = 1;
		end
		if (not TipBuddy_SavedVars["npc_friend"]["trg"]) then
			TipBuddy_SavedVars["npc_friend"].trg = 0;
		end
		if (not TipBuddy_SavedVars["npc_friend"]["trg_pl"]) then
			TipBuddy_SavedVars["npc_friend"].trg_pl = 0;
			TipBuddy_SavedVars["npc_friend"].trg_en = 0;
			TipBuddy_SavedVars["npc_friend"].trg_np = 0;
			TipBuddy_SavedVars["npc_friend"].trg_pa = 0;
		end
		if (not TipBuddy_SavedVars["npc_friend"]["txt_hth"]) then
			TipBuddy_SavedVars["npc_friend"].txt_hth = 0;
			TipBuddy_SavedVars["npc_friend"].txt_mna = 0;
			TipBuddy_SavedVars["npc_friend"].txt_pvp = 0;
		end
	else
		TipBuddy_SavedVars["npc_friend"] = {
				["bgcolor"] = { a = 0.78, r = 0.26, g = 0.01, b = 0.44 },
				["bgbcolor"] = { a = 1, r = 0.8, g = 0.8, b = 0.9 },
				["hth"] = 0,
				["xtr"] = 0,
				["off"] = 0,
				["cls"] = 0,
				["fac"] = 0,
				["bff"] = 0,
				["cfc"] = 1,
				["gld"] = 1,
				["trg"] = 0,
				["trg_pl"] = 0,
				["trg_en"] = 0,
				["trg_np"] = 0,
				["trg_pa"] = 0,
				["txt_hth"] = 0,
				["txt_mna"] = 0,
				["txt_pvp"] = 0,
				};
	end
	-- NPC Neutral
	if (TipBuddy_SavedVars["npc_neutral"]) then
		if (not TipBuddy_SavedVars["npc_neutral"]["bgcolor"]) then
			TipBuddy_SavedVars["npc_neutral"].bgcolor = { r = 0.25, g = 0.22, b = 0.02, a = 0.78 };
		end
		if (TipBuddy_SavedVars["npc_neutral"]["bgbcolor"] == nil) then
			TipBuddy_SavedVars["npc_neutral"].bgbcolor = { r = 0.8, g = 0.8, b = 0.9, a = 1 };
		end
		if (not TipBuddy_SavedVars["npc_neutral"]["off"]) then
			TipBuddy_SavedVars["npc_neutral"].off = 0;
		end
		if (not TipBuddy_SavedVars["npc_neutral"]["nam"]) then
			TipBuddy_SavedVars["npc_neutral"].nam = 1;
		end
		if (not TipBuddy_SavedVars["npc_neutral"]["cls"]) then
			TipBuddy_SavedVars["npc_neutral"].cls = 1;
		end
		if (not TipBuddy_SavedVars["npc_neutral"]["gld"]) then
			TipBuddy_SavedVars["npc_neutral"].gld = 1;
		end
		if (not TipBuddy_SavedVars["npc_neutral"]["fac"]) then
			TipBuddy_SavedVars["npc_neutral"].fac = 1;
		end
		if (not TipBuddy_SavedVars["npc_neutral"]["cfc"]) then
			TipBuddy_SavedVars["npc_neutral"].cfc = 1;
		end
		if (not TipBuddy_SavedVars["npc_neutral"]["bff"]) then
			TipBuddy_SavedVars["npc_neutral"].bff = 0;
		end
		if (not TipBuddy_SavedVars["npc_neutral"]["dbf"]) then
			TipBuddy_SavedVars["npc_neutral"].dbf = 0;
		end
		if (not TipBuddy_SavedVars["npc_neutral"]["xtr"]) then
			TipBuddy_SavedVars["npc_neutral"].xtr = 0;
		end
		if (not TipBuddy_SavedVars["npc_neutral"]["trg"]) then
			TipBuddy_SavedVars["npc_neutral"].trg = 1;
		end
		if (not TipBuddy_SavedVars["npc_neutral"]["trg_pl"]) then
			TipBuddy_SavedVars["npc_neutral"].trg_pl = 0;
			TipBuddy_SavedVars["npc_neutral"].trg_en = 0;
			TipBuddy_SavedVars["npc_neutral"].trg_np = 0;
			TipBuddy_SavedVars["npc_neutral"].trg_pa = 0;
		end
		if (not TipBuddy_SavedVars["npc_neutral"]["txt_hth"]) then
			TipBuddy_SavedVars["npc_neutral"].txt_hth = 0;
			TipBuddy_SavedVars["npc_neutral"].txt_mna = 0;
			TipBuddy_SavedVars["npc_neutral"].txt_pvp = 0;
		end
	else
		TipBuddy_SavedVars["npc_neutral"] = {
				["bgcolor"] = { a = 0.78, r = 0.25, g = 0.22, b = 0.02 },
				["bgbcolor"] = { a = 1, r = 0.8, g = 0.8, b = 0.9 },
				["hth"] = 1,
				["xtr"] = 0,
				["off"] = 0,
				["cls"] = 1,
				["fac"] = 1,
				["bff"] = 1,
				["cfc"] = 1,
				["gld"] = 1,
				["trg"] = 1,
				["trg_pl"] = 0,
				["trg_en"] = 0,
				["trg_np"] = 0,
				["trg_pa"] = 0,
				["txt_hth"] = 0,
				["txt_mna"] = 0,
				["txt_pvp"] = 0,
				};
	end
	-- NPC Enemies
	if (TipBuddy_SavedVars["npc_enemy"]) then
		if (not TipBuddy_SavedVars["npc_enemy"]["bgcolor"]) then
			TipBuddy_SavedVars["npc_enemy"].bgcolor = { r = 0.35, g = 0.09, b = 0.13, a = 0.78 };
		end
		if (TipBuddy_SavedVars["npc_enemy"]["bgbcolor"] == nil) then
			TipBuddy_SavedVars["npc_enemy"].bgbcolor = { r = 0.8, g = 0.8, b = 0.9, a = 1 };
		end
		if (not TipBuddy_SavedVars["npc_enemy"]["off"]) then
			TipBuddy_SavedVars["npc_enemy"].off = 0;
		end
		if (not TipBuddy_SavedVars["npc_enemy"]["nam"]) then
			TipBuddy_SavedVars["npc_enemy"].nam = 1;
		end
		if (not TipBuddy_SavedVars["npc_enemy"]["cls"]) then
			TipBuddy_SavedVars["npc_enemy"].cls = 1;
		end
		if (not TipBuddy_SavedVars["npc_enemy"]["gld"]) then
			TipBuddy_SavedVars["npc_enemy"].gld = 1;
		end
		if (not TipBuddy_SavedVars["npc_enemy"]["fac"]) then
			TipBuddy_SavedVars["npc_enemy"].fac = 1;
		end
		if (not TipBuddy_SavedVars["npc_enemy"]["cfc"]) then
			TipBuddy_SavedVars["npc_enemy"].cfc = 1;
		end
		if (not TipBuddy_SavedVars["npc_enemy"]["bff"]) then
			TipBuddy_SavedVars["npc_enemy"].bff = 1;
		end
		if (not TipBuddy_SavedVars["npc_enemy"]["dbf"]) then
			TipBuddy_SavedVars["npc_enemy"].dbf = 1;
		end
		if (not TipBuddy_SavedVars["npc_enemy"]["xtr"]) then
			TipBuddy_SavedVars["npc_enemy"].xtr = 1;
		end
		if (not TipBuddy_SavedVars["npc_enemy"]["trg"]) then
			TipBuddy_SavedVars["npc_enemy"].trg = 1;
		end
		if (not TipBuddy_SavedVars["npc_enemy"]["trg_pl"]) then
			TipBuddy_SavedVars["npc_enemy"].trg_pl = 0;
			TipBuddy_SavedVars["npc_enemy"].trg_en = 0;
			TipBuddy_SavedVars["npc_enemy"].trg_np = 0;
			TipBuddy_SavedVars["npc_enemy"].trg_pa = 0;
		end
		if (not TipBuddy_SavedVars["npc_enemy"]["txt_hth"]) then
			TipBuddy_SavedVars["npc_enemy"].txt_hth = 0;
			TipBuddy_SavedVars["npc_enemy"].txt_mna = 0;
			TipBuddy_SavedVars["npc_enemy"].txt_pvp = 0;
		end
	else
		TipBuddy_SavedVars["npc_enemy"] = {
				["bgcolor"] = { a = 0.78, r = 0.35, g = 0.09, b = 0.13 },
				["bgbcolor"] = { a = 1, r = 0.8, g = 0.8, b = 0.9 },
				["hth"] = 1,
				["xtr"] = 0,
				["off"] = 0,
				["cls"] = 1,
				["fac"] = 1,
				["bff"] = 1,
				["cfc"] = 1,
				["gld"] = 1,
				["trg"] = 1,
				["trg_pl"] = 0,
				["trg_en"] = 0,
				["trg_np"] = 0,
				["trg_pa"] = 0,
				["txt_hth"] = 0,
				["txt_mna"] = 0,
				["txt_pvp"] = 0,
				};
	end
	-- Pet Friends
	if (TipBuddy_SavedVars["pet_friend"]) then
		if (not TipBuddy_SavedVars["pet_friend"]["bgcolor"]) then
			TipBuddy_SavedVars["pet_friend"].bgcolor = { r = 0.14, g = 0.29, b = 0.24, a = 0.78 };
		end
		if (TipBuddy_SavedVars["pet_friend"]["bgbcolor"] == nil) then
			TipBuddy_SavedVars["pet_friend"].bgbcolor = { r = 0.8, g = 0.8, b = 0.9, a = 1 };
		end
		if (not TipBuddy_SavedVars["pet_friend"]["off"]) then
			TipBuddy_SavedVars["pet_friend"].off = 0;
		end
		if (not TipBuddy_SavedVars["pet_friend"]["nam"]) then
			TipBuddy_SavedVars["pet_friend"].nam = 1;
		end
		if (not TipBuddy_SavedVars["pet_friend"]["cls"]) then
			TipBuddy_SavedVars["pet_friend"].cls = 1;
		end
		if (not TipBuddy_SavedVars["pet_friend"]["gld"]) then
			TipBuddy_SavedVars["pet_friend"].gld = 1;
		end
		if (not TipBuddy_SavedVars["pet_friend"]["fac"]) then
			TipBuddy_SavedVars["pet_friend"].fac = 1;
		end
		if (not TipBuddy_SavedVars["pet_friend"]["cfc"]) then
			TipBuddy_SavedVars["pet_friend"].cfc = 1;
		end
		if (not TipBuddy_SavedVars["pet_friend"]["bff"]) then
			TipBuddy_SavedVars["pet_friend"].bff = 1;
		end
		if (not TipBuddy_SavedVars["pet_friend"]["dbf"]) then
			TipBuddy_SavedVars["pet_friend"].dbf = 1;
		end
		if (not TipBuddy_SavedVars["pet_friend"]["xtr"]) then
			TipBuddy_SavedVars["pet_friend"].xtr = 1;
		end
		if (not TipBuddy_SavedVars["pet_friend"]["trg_pl"]) then
			TipBuddy_SavedVars["pet_friend"].trg_pl = 0;
			TipBuddy_SavedVars["pet_friend"].trg_en = 0;
			TipBuddy_SavedVars["pet_friend"].trg_np = 0;
			TipBuddy_SavedVars["pet_friend"].trg_pa = 0;
		end
		if (not TipBuddy_SavedVars["pet_friend"]["txt_hth"]) then
			TipBuddy_SavedVars["pet_friend"].txt_hth = 0;
			TipBuddy_SavedVars["pet_friend"].txt_mna = 0;
			TipBuddy_SavedVars["pet_friend"].txt_pvp = 0;
		end
	else
		TipBuddy_SavedVars["pet_friend"] = {
				["bgcolor"] = { a = 0.78, r = 0.14, g = 0.29, b = 0.24 },
				["bgbcolor"] = { a = 1, r = 0.8, g = 0.8, b = 0.9 },
				["hth"] = 0,
				["xtr"] = 0,
				["off"] = 0,
				["cls"] = 1,
				["fac"] = 1,
				["bff"] = 1,
				["cfc"] = 0,
				["gld"] = 1,
				["trg"] = 1,
				["trg_pl"] = 0,
				["trg_en"] = 0,
				["trg_np"] = 0,
				["trg_pa"] = 0,
				["txt_hth"] = 0,
				["txt_mna"] = 0,
				["txt_pvp"] = 0,
				};
	end
	-- Pet Enemies
	if (TipBuddy_SavedVars["pet_enemy"]) then
		if (not TipBuddy_SavedVars["pet_enemy"]["bgcolor"]) then
			TipBuddy_SavedVars["pet_enemy"].bgcolor = { r = 0.29, g = 0.16, b = 0.05, a = 0.78 };
		end
		if (TipBuddy_SavedVars["pet_enemy"]["bgbcolor"] == nil) then
			TipBuddy_SavedVars["pet_enemy"].bgbcolor = { r = 0.8, g = 0.8, b = 0.9, a = 1 };
		end
		if (not TipBuddy_SavedVars["pet_enemy"]["off"]) then
			TipBuddy_SavedVars["pet_enemy"].off = 0;
		end
		if (not TipBuddy_SavedVars["pet_enemy"]["nam"]) then
			TipBuddy_SavedVars["pet_enemy"].nam = 1;
		end
		if (not TipBuddy_SavedVars["pet_enemy"]["cls"]) then
			TipBuddy_SavedVars["pet_enemy"].cls = 1;
		end
		if (not TipBuddy_SavedVars["pet_enemy"]["gld"]) then
			TipBuddy_SavedVars["pet_enemy"].gld = 1;
		end
		if (not TipBuddy_SavedVars["pet_enemy"]["fac"]) then
			TipBuddy_SavedVars["pet_enemy"].fac = 1;
		end
		if (not TipBuddy_SavedVars["pet_enemy"]["cfc"]) then
			TipBuddy_SavedVars["pet_enemy"].cfc = 1;
		end
		if (not TipBuddy_SavedVars["pet_enemy"]["bff"]) then
			TipBuddy_SavedVars["pet_enemy"].bff = 1;
		end
		if (not TipBuddy_SavedVars["pet_enemy"]["dbf"]) then
			TipBuddy_SavedVars["pet_enemy"].dbf = 1;
		end
		if (not TipBuddy_SavedVars["pet_enemy"]["xtr"]) then
			TipBuddy_SavedVars["pet_enemy"].xtr = 1;
		end
		if (not TipBuddy_SavedVars["pet_enemy"]["trg"]) then
			TipBuddy_SavedVars["pet_enemy"].trg = 1;
		end
		if (not TipBuddy_SavedVars["pet_enemy"]["trg_pl"]) then
			TipBuddy_SavedVars["pet_enemy"].trg_pl = 0;
			TipBuddy_SavedVars["pet_enemy"].trg_en = 0;
			TipBuddy_SavedVars["pet_enemy"].trg_np = 0;
			TipBuddy_SavedVars["pet_enemy"].trg_pa = 0;
		end
		if (not TipBuddy_SavedVars["pet_enemy"]["txt_hth"]) then
			TipBuddy_SavedVars["pet_enemy"].txt_hth = 0;
			TipBuddy_SavedVars["pet_enemy"].txt_mna = 0;
			TipBuddy_SavedVars["pet_enemy"].txt_pvp = 0;
		end
	else
		TipBuddy_SavedVars["pet_enemy"] = {
				["bgcolor"] = { a = 0.78, r = 0.29, g = 0.16, b = 0.05 },
				["bgbcolor"] = { a = 1, r = 0.8, g = 0.8, b = 0.9 },
				["hth"] = 1,
				["xtr"] = 0,
				["off"] = 0,
				["cls"] = 1,
				["fac"] = 1,
				["bff"] = 1,
				["cfc"] = 1,
				["gld"] = 1,
				["trg"] = 1,
				["trg_pl"] = 0,
				["trg_en"] = 0,
				["trg_np"] = 0,
				["trg_pa"] = 0,
				["txt_hth"] = 0,
				["txt_mna"] = 0,
				["txt_pvp"] = 0,
				};
	end
	-- Corpse
	if (TipBuddy_SavedVars["corpse"]) then
		if (not TipBuddy_SavedVars["corpse"]["bgcolor"]) then
			TipBuddy_SavedVars["corpse"].bgcolor = { r = 0.09, g = 0.09, b = 0.19, a = 0.78 };
		end
		if (not TipBuddy_SavedVars["corpse"]["bgbcolor"]) then
			TipBuddy_SavedVars["corpse"].bgcolor = { r = 0.8, g = 0.8, b = 0.9, a = 1 };
		end
		if (not TipBuddy_SavedVars["corpse"]["off"]) then
			TipBuddy_SavedVars["corpse"].off = 0;
		end
		--/script TipBuddy_SavedVars["corpse"].off = 2;
		--/script TipBuddy_SavedVars["corpse"].off = 0;
		if (not TipBuddy_SavedVars["corpse"]["nam"]) then
			TipBuddy_SavedVars["corpse"].nam = 1;
		end
		if (not TipBuddy_SavedVars["corpse"]["cls"]) then
			TipBuddy_SavedVars["corpse"].cls = 1;
		end
		if (not TipBuddy_SavedVars["corpse"]["gld"]) then
			TipBuddy_SavedVars["corpse"].gld = 1;
		end
		if (not TipBuddy_SavedVars["corpse"]["fac"]) then
			TipBuddy_SavedVars["corpse"].fac = 0;
		end
		if (not TipBuddy_SavedVars["corpse"]["cfc"]) then
			TipBuddy_SavedVars["corpse"].cfc = 0;
		end
		if (not TipBuddy_SavedVars["corpse"]["bff"]) then
			TipBuddy_SavedVars["corpse"].bff = 0;
		end
		if (not TipBuddy_SavedVars["corpse"]["dbf"]) then
			TipBuddy_SavedVars["corpse"].dbf = 0;
		end
		if (not TipBuddy_SavedVars["corpse"]["xtr"]) then
			TipBuddy_SavedVars["corpse"].xtr = 1;
		end
		if (not TipBuddy_SavedVars["corpse"]["trg"]) then
			TipBuddy_SavedVars["corpse"].trg = 0;
		end
		if (not TipBuddy_SavedVars["corpse"]["trg_pl"]) then
			TipBuddy_SavedVars["corpse"].trg_pl = 0;
			TipBuddy_SavedVars["corpse"].trg_en = 0;
			TipBuddy_SavedVars["corpse"].trg_np = 0;
			TipBuddy_SavedVars["corpse"].trg_pa = 0;
		end
		if (not TipBuddy_SavedVars["corpse"]["txt_hth"]) then
			TipBuddy_SavedVars["corpse"].txt_hth = 0;
			TipBuddy_SavedVars["corpse"].txt_mna = 0;
			TipBuddy_SavedVars["corpse"].txt_pvp = 0;
		end
	else
		TipBuddy_SavedVars["corpse"] = {
				["bgcolor"] = { a = 0.78, r = 0.09, g = 0.09, b = 0.19 },
				["bgbcolor"] = { a = 1, r = 0.8, g = 0.8, b = 0.9 },
				["hth"] = 0,
				["xtr"] = 1,
				["off"] = 0,
				["cls"] = 1,
				["fac"] = 1,
				["bff"] = 0,
				["cfc"] = 1,
				["gld"] = 1,
				["trg"] = 0,
				["trg_pl"] = 0,
				["trg_en"] = 0,
				["trg_np"] = 0,
				["trg_pa"] = 0,
				["txt_hth"] = 0,
				["txt_mna"] = 0,
				["txt_pvp"] = 0,
				};
	end
	-- Guild
	if (TipBuddy_SavedVars["guild"]) then
		if (not TipBuddy_SavedVars["guild"]["bgcolor"]) then
			TipBuddy_SavedVars["guild"].bgcolor = { r = 0.25, g = 0.05, b = 0.29, a = 0.78 };
		end
		if (TipBuddy_SavedVars["guild"]["bgbcolor"] == nil) then
			TipBuddy_SavedVars["guild"].bgbcolor = { r = 0.8, g = 0.8, b = 0.9, a = 1 };
		end
	else
		TipBuddy_SavedVars["guild"] = {
				["bgcolor"] = { a = 0.78, r = 0.25, g = 0.05, b = 0.29 },
				["bgbcolor"] = { a = 1, r = 0.8, g = 0.8, b = 0.9 },
			};
	end
	-- General
	if (TipBuddy_SavedVars["general"]) then
		if (not TipBuddy_SavedVars["general"]["bgcolor"]) then
			TipBuddy_SavedVars["general"].bgcolor = { r = 0.1, g = 0.1, b = 0.1, a = 0.78 };
		end
		if (not TipBuddy_SavedVars["general"]["bgbcolor"]) then
			TipBuddy_SavedVars["general"].bgbcolor = { r = 0.8, g = 0.8, b = 0.9, a = 1 };
		end
		if (not TipBuddy_SavedVars["general"]["hidedefault"]) then
			TipBuddy_SavedVars["general"].hidedefault = 1;
		end
		if (not TipBuddy_SavedVars["general"]["blizdefault"]) then
			TipBuddy_SavedVars["general"].blizdefault = 0;
		end
		if (not TipBuddy_SavedVars["general"]["cursorpos"]) then
			TipBuddy_SavedVars["general"].cursorpos = "Top";
		end
		if (not TipBuddy_SavedVars["general"]["fadetime"]) then
			TipBuddy_SavedVars["general"].fadetime = 0.3;
		end
		if (not TipBuddy_SavedVars["general"]["scalemod"]) then
			TipBuddy_SavedVars["general"].scalemod = 4;
		end
		if (not TipBuddy_SavedVars["general"]["framepos_L"]) then
			TipBuddy_SavedVars["general"].framepos_L = 0;
		end
		if (not TipBuddy_SavedVars["general"]["framepos_T"]) then
			TipBuddy_SavedVars["general"].framepos_T = 0;
		end
		if (not TipBuddy_SavedVars["general"]["delaytime"]) then
			TipBuddy_SavedVars["general"].delaytime = 0.1;
		end
		if (not TipBuddy_SavedVars["general"]["anchored"]) then
			TipBuddy_SavedVars["general"].anchored = 0;
		end
		if (not TipBuddy_SavedVars["general"]["anchor_pos"]) then
			TipBuddy_SavedVars["general"].anchor_pos = "Top Right";
		end
		if (not TipBuddy_SavedVars["general"]["anchor_vis"]) then
			TipBuddy_SavedVars["general"].anchor_vis = 0;
		end
		if (not TipBuddy_SavedVars["general"]["rankname"]) then
			TipBuddy_SavedVars["general"].rankname = 0;
		end
		if (not TipBuddy_SavedVars["general"]["classcolor"]) then
			TipBuddy_SavedVars["general"].classcolor = 1;
		end
		if (not TipBuddy_SavedVars["general"]["gtt_fade"]) then
			TipBuddy_SavedVars["general"].gtt_fade = 0;
		end
		if (not TipBuddy_SavedVars["general"]["nonunit_anchor"]) then
			TipBuddy_SavedVars["general"].nonunit_anchor = 2;
		end
		if (not TipBuddy_SavedVars["general"]["offset_x"]) then
			TipBuddy_SavedVars["general"].offset_x = 0;
		end
		if (not TipBuddy_SavedVars["general"]["offset_y"]) then
			TipBuddy_SavedVars["general"].offset_y = 0;
		end
		if (not TipBuddy_SavedVars["general"]["gtt_scale"]) then
			TipBuddy_SavedVars["general"].gtt_scale = (GetCVar("uiscale") + 0);
		end
		if (not TipBuddy_SavedVars["general"]["diff_bg"]) then
			TipBuddy_SavedVars["general"].diff_bg = 0;
		end
		if (not TipBuddy_SavedVars["general"]["reposmods"]) then
			TipBuddy_SavedVars["general"].reposmods = 1;
		end
		if (not TipBuddy_SavedVars["general"]["hookunitframes"]) then
			TipBuddy_SavedVars["general"].hookunitframes = 1;
		end
	else
		TipBuddy_SavedVars["general"] = {
			["bgcolor"] = { a = 0.78, r = 0.1, g = 0.1, b = 0.1 },
			["bgbcolor"] = { a = 1, r = 0.8, g = 0.8, b = 0.9 },
			["hidedefault"] = 1,
			["blizdefault"] = 0,
			["cursorpos"] = "Top",
			["fadetime"] = 0.3,
			["scalemod"] = 3,
			["framepos_L"] = 0,
			["framepos_T"] = 0,
			["delaytime"] = 0.1,
			["anchored"] = 0,
			["anchor_pos"] = "Top Right",
			["anchor_vis"] = 0,
			["rankname"] = 0,
			["classcolor"] = 1,
			["gtt_fade"] = 0,
			["nonunit_anchor"] = 2,
			["offset_x"] = 0,
			["offset_y"] = 0,
			["gtt_scale"] = (GetCVar("uiscale") + 0),
			["diff_bg"] = 0,
			["reposmods"] = 1,
			["hookunitframes"] = 1,
		};
	end
	-- Colors
	if (not TipBuddy_SavedVars["textcolors"]) then
		TipBuddy_ResetColors();
	end
end

function TipBuddy_ResetColors()
	-- Simple Table Copy func
	local function CopyTable(source)
		local dest = {};
		for k in pairs(source) do
			dest[k] = source[k];
		end
		return dest;
	end
	-- Default Colors
	TipBuddy_SavedVars["textcolors"] = {
		-- name
		nam_hos = { a = 1, r = 0.9, g = 0.1, b = 0.1 },
		nam_neu = { a = 1, r = 1, g = 0.9, b = 0 },
		nam_fri = { a = 1, r = 0.1, g = 0.7, b = 1 },
		nam_cau = { a = 1, r = 0.9, g = 0.4, b = 0 },
		nam_pvp = { a = 1, r = 0.15, g = 0.9, b = 0 },
		nam_tpp = { a = 1, r = 1, g = 0, b = 0 },
		nam_tpo = { a = 1, r = 0.6, g = 0.6, b = 0.6 },
		-- gld
		gld_hos = { a = 1, r = 0.7, g = 0.1, b = 0.1 },
		gld_neu = { a = 1, r = 0.9, g = 0.7, b = 0 },
		gld_fri = { a = 1, r = 0, g = 0.5, b = 0.8 },
		gld_cau = { a = 1, r = 0.65, g = 0.4, b = 0.0 },
		gld_pvp = { a = 1, r = 0.05, g = 0.7, b = 0 },
		gld_tpp = { a = 1, r = 0.8, g = 0, b = 0 },
		gld_tpo = { a = 1, r = 0.45, g = 0.45, b = 0.45 },
		gld_mte = { a = 1, r = 1, g = 0.2, b = 1 },
		-- lvl (old)
--		lvl_imp = { a = 1, r = 1, g = 0.1, b = 0.1 },
--		lvl_vdf = { a = 1, r = 1, g = 0.5, b = 0.25 },
--		lvl_dif = { a = 1, r = 1, g = 1, b = 0 },
--		lvl_stn = { a = 1, r = 0.25, g = 0.75, b = 0.25 },
--		lvl_trv = { a = 1, r = 0.5, g = 0.5, b = 0.5 },
--		lvl_sfc = { a = 1, r = 0.85, g = 0.85, b = 0.85 },
		-- lvl (copy from blizz table)
		lvl_imp = CopyTable(QuestDifficultyColor["impossible"]);
		lvl_vdf = CopyTable(QuestDifficultyColor["verydifficult"]);
		lvl_dif = CopyTable(QuestDifficultyColor["difficult"]);
		lvl_stn = CopyTable(QuestDifficultyColor["standard"]);
		lvl_trv = CopyTable(QuestDifficultyColor["trivial"]);
		lvl_sfc = { r = 0.85, g = 0.85, b = 0.85 },
		-- class (old)
--		cls_drd = { a = 1, r = 0.9, g = 0.55, b = 0.1 },
--		cls_hun = { a = 1, r = 0.1, g = 0.85, b = 0.1 },
--		cls_mag = { a = 1, r = 0.5, g = 1, b = 1 },
--		cls_pal = { a = 1, r = 1, g = 0.4, b = 0.58 },
--		cls_pri = { a = 1, r = 0.8, g = 0.8, b = 0.8 },
--		cls_rog = { a = 1, r = 0.95, g = 0.9, b = 0.1 },
--		cls_shm = { a = 1, r = 0.0,	g = 0.86, b = 0.73 }, -- r = 0.9, g = 0.4, b = 0.65
--		cls_wlk = { a = 1, r = 0.5, g = 0.26, b = 0.9 },
--		cls_war = { a = 1, r = 0.7, g = 0.5, b = 0.25 },
		-- class (new, blizz color)
		cls_oth = { r = 1, g = 1, b = 1 },
		cls_drd = CopyTable(RAID_CLASS_COLORS.DRUID),
		cls_hun = CopyTable(RAID_CLASS_COLORS.HUNTER),
		cls_mag = CopyTable(RAID_CLASS_COLORS.MAGE),
		cls_pal = CopyTable(RAID_CLASS_COLORS.PALADIN),
		cls_pri = CopyTable(RAID_CLASS_COLORS.PRIEST),
		cls_rog = CopyTable(RAID_CLASS_COLORS.ROGUE),
		cls_shm = CopyTable(RAID_CLASS_COLORS.SHAMAN),
		cls_wlk = CopyTable(RAID_CLASS_COLORS.WARLOCK),
		cls_war = CopyTable(RAID_CLASS_COLORS.WARRIOR),
		-- elite
		elite_rar = { a = 1, r = 1, g = 1, b = 1 },
		elite_bss = { a = 1, r = 1, g = 1, b = 1 },
		-- other
		other_crp = { a = 1, r = 0.5, g = 0.5, b = 0.5 },
		other_unk = { a = 1, r = 1, g = 1, b = 1 },
		other_rac = { a = 1, r = 1, g = 1, b = 1 },
		other_ctf = { a = 1, r = 0.85, g = 0.85, b = 0.85 },
	};
end

function TipBuddy_ResetOffState()
	TipBuddy_SavedVars["pc_friend"].off = 0;
	TipBuddy_SavedVars["pc_enemy"].off = 0;
	TipBuddy_SavedVars["pc_party"].off = 0;
	TipBuddy_SavedVars["pet_friend"].off = 0;
	TipBuddy_SavedVars["pet_enemy"].off = 0;
	TipBuddy_SavedVars["npc_friend"].off = 0;
	TipBuddy_SavedVars["npc_enemy"].off = 0;
	TipBuddy_SavedVars["corpse"].off = 0;
end

function TipBuddy_ResetXtraState()
	TipBuddy_SavedVars["pc_friend"].xtr = 0;
	TipBuddy_SavedVars["pc_enemy"].xtr = 0;
	TipBuddy_SavedVars["pc_party"].xtr = 0;
	TipBuddy_SavedVars["pet_friend"].xtr = 0;
	TipBuddy_SavedVars["pet_enemy"].xtr = 0;
	TipBuddy_SavedVars["npc_friend"].xtr = 0;
	TipBuddy_SavedVars["npc_enemy"].xtr = 0;
	TipBuddy_SavedVars["npc_neutral"].xtr = 0;
end