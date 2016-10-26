--[[

	MonkeyBuddy:
	Helps you configure your MonkeyMods.
	
	Website:	http://www.toctastic.net/
	Author:		Trentin (monkeymods@gmail.com)
	
	
	Contributors:
	Pkp
		- Some initial xml work.

	Juki
		- French translation

	Sasmira
		- Additional French translation
		
	Jim Bim
		- German translation
		
	Kagar
		- Fixed Tab text

--]]


-- English
MONKEYBUDDY_TITLE							= "MonkeyBuddy";
MONKEYBUDDY_VERSION						= "2.9";
MONKEYBUDDY_FRAME_TITLE						= MONKEYBUDDY_TITLE .. " v" .. MONKEYBUDDY_VERSION;
MONKEYBUDDY_DESCRIPTION						= "Helps you configure your MonkeyMods.";
MONKEYBUDDY_INFO_COLOUR					= "|cffffff00";
MONKEYBUDDY_LOADED_MSG						= MONKEYBUDDY_INFO_COLOUR .. MONKEYBUDDY_TITLE .. " v" .. MONKEYBUDDY_VERSION .. " loaded";

MONKEYBUDDY_TOOLTIP_CLOSE					= "Close";
MONKEYBUDDY_RESET_ALL						= "Reset All";
MONKEYBUDDY_RESET							= "Reset";

MONKEYBUDDY_GUI_TEXT						="This addon allows you to easily configure your MonkeyMods"
MONKEYBUDDY_GUI_ICON						="\124TInterface\\AddOns\\MonkeyLibrary\\Textures\\MonkeyBuddyIcon.tga:0\124t "
MONKEYBUDDY_GUI_MBLOADED					= MONKEYBUDDY_GUI_ICON .. "MonkeyBuddy successfully loaded!"
MONKEYBUDDY_GUI_MMINSTALLED					="Installed MonkeyMods:"
MONKEYBUDDY_GUI_MBMINIMAP					="Show the MonkeyBuddy minimap icon"
MONKEYBUDDY_GUI_MQEXTRA					="MonkeyQuest Extra:"
MONKEYBUDDY_GUI_MQEDAILY					="Show the daily quest counter in the title"
MONKEYBUDDY_GUI_MBOPENCFG					="Click on the following Button to open"

-- defs for MonkeyQuest
MONKEYBUDDY_QUEST_TITLE						= "MonkeyQuest";
MONKEYBUDDY_QUEST_OPEN						= "Open MonkeyQuest";
MONKEYBUDDY_QUEST_SHOWHIDDEN				= "Show hidden items";
MONKEYBUDDY_QUEST_USEOVERVIEWS				= "Use overviews when there's no objectives";
MONKEYBUDDY_QUEST_HIDEHEADERS				= "Hide zone headers if not showing hidden items";
MONKEYBUDDY_QUEST_ALWAYSHEADERS				= "Always show zone headers, always";
MONKEYBUDDY_QUEST_HIDEBORDER				= "Hide the border";
MONKEYBUDDY_QUEST_GROWUP					= "Expand upwards";
MONKEYBUDDY_QUEST_SHOWNUMQUESTS				= "Show the number of quests";
MONKEYBUDDY_QUEST_LOCK						= "Lock the MonkeyQuest frame";
MONKEYBUDDY_QUEST_COLOURTITLEON				= "Colour the quest titles by difficulty";
MONKEYBUDDY_QUEST_HIDECOMPLETEDQUESTS		= "Hide completed quests";
MONKEYBUDDY_QUEST_HIDECOMPLETEDOBJECTIVES	= "Hide completed objectives";
MONKEYBUDDY_QUEST_SHOWTOOLTIPOBJECTIVES		= "Show objective completeness in tooltips";
MONKEYBUDDY_QUEST_ALLOWRIGHTCLICK			= "Allow right click to open MonkeyBuddy";
MONKEYBUDDY_QUEST_HIDETITLEBUTTONS			= "Hide the title buttons";
MONKEYBUDDY_QUEST_HIDETITLE					= "Hide the title (" .. MONKEYBUDDY_QUEST_TITLE .. ") text";
MONKEYBUDDY_QUEST_CRASHFONT					= "Use the skinny font";
MONKEYBUDDY_QUEST_CRASHBORDER				= "Use the golden border colour";
MONKEYBUDDY_QUEST_SHOWNOOBTIPS				= "Show helpful tooltips for Noobs";
MONKEYBUDDY_QUEST_SHOWZONEHIGHLIGHT			= "Show quest zone highlighting";
MONKEYBUDDY_QUEST_SHOWQUESTLEVEL			= "Show the quest levels";
MONKEYBUDDY_QUEST_WORKCOMPLETE				= "Enable >work complete< sound";

MONKEYBUDDY_QUEST_QUESTTITLECOLOUR			= "Quest Titles";
MONKEYBUDDY_QUEST_HEADEROPENCOLOUR			= "Open Zone Headers";
MONKEYBUDDY_QUEST_HEADERCLOSEDCOLOUR		= "Closed Zone Headers";
MONKEYBUDDY_QUEST_OVERVIEWCOLOUR			= "Quest Overviews";
MONKEYBUDDY_QUEST_SPECIALOBJECTIVECOLOUR		= "Special Objectives";
MONKEYBUDDY_QUEST_INITIALOBJECTIVECOLOUR		= "Objectives at 0%";
MONKEYBUDDY_QUEST_MIDOBJECTIVECOLOUR			= "Objectives at 50%";
MONKEYBUDDY_QUEST_COMPLETEOBJECTIVECOLOUR		= "Objectives at <100%";
MONKEYBUDDY_QUEST_FINISHOBJECTIVECOLOUR		= "Finished Objectives";
MONKEYBUDDY_QUEST_ZONEHIGHLIGHTCOLOUR		= "Current Zone Highlight";

MONKEYBUDDY_QUEST_FRAMEALPHASLIDER			= "Global Alpha";
MONKEYBUDDY_QUEST_ALPHASLIDER				= "Background Alpha";
MONKEYBUDDY_QUEST_WIDTHSLIDER				= "Frame Width";
MONKEYBUDDY_QUEST_FONTSLIDER				= "Font Size";
MONKEYBUDDY_QUEST_PADDINGSLIDER				= "Quest Padding";

-- defs for MonkeySpeed
MONKEYBUDDY_SPEED_TITLE						= "MonkeySpeed";
MONKEYBUDDY_SPEED_OPEN						= "Open MonkeySpeed";
MONKEYBUDDY_SPEED_PERCENT					= "Show speed as a percent";
MONKEYBUDDY_SPEED_BAR						= "Show speed as a background colour";
MONKEYBUDDY_SPEED_LOCK						= "Lock the MonkeySpeed frame";
MONKEYBUDDY_SPEED_ALLOWRIGHTCLICK			= "Allow right click to open MonkeyBuddy";

MONKEYBUDDY_SPEED_WIDTHSLIDER				= "Frame Width";

-- defs for MonkeyClock
MONKEYBUDDY_CLOCK_TITLE						= "MonkeyClock";
MONKEYBUDDY_CLOCK_OPEN						= "Open MonkeyClock";
MONKEYBUDDY_CLOCK_HIDEBORDER				= "Hide the border";
MONKEYBUDDY_CLOCK_USEMILITARYTIME			= "Use 24 hour clock";
MONKEYBUDDY_CLOCK_LOCK						= "Lock the MonkeyClock frame";
MONKEYBUDDY_CLOCK_CHATALARM				= "Use the alarm message in the chat window";
MONKEYBUDDY_CLOCK_DIALOGALARM				= "Use the alarm dialog box with snooze button";
MONKEYBUDDY_CLOCK_ALLOWRIGHTCLICK			= "Allow right click to open MonkeyBuddy";

MONKEYBUDDY_CLOCK_HOURSLIDER		= "Hour Offset";
MONKEYBUDDY_CLOCK_MINUTESLIDER		= "Minute Offset";

MONKEYBUDDY_CLOCK_ALARMHOURSLIDER	= "Alarm Hour";
MONKEYBUDDY_CLOCK_ALARMMINUTESLIDER	= "Alarm Minute";

-- bindings
BINDING_HEADER_MONKEYBUDDY 			= MONKEYBUDDY_TITLE;
BINDING_NAME_MONKEYBUDDY_OPEN 		= "Open/Close the config frame";


if ( GetLocale() == "zhCN" ) then

-- Chinese
MONKEYBUDDY_TITLE				= "MonkeyBuddy";
MONKEYBUDDY_VERSION				= MONKEYLIB_VERSION;
MONKEYBUDDY_FRAME_TITLE				= MONKEYBUDDY_TITLE .. " v" .. MONKEYBUDDY_VERSION;
MONKEYBUDDY_DESCRIPTION				= "帮助你设置 Money 系列插件。";
MONKEYBUDDY_INFO_COLOUR				= "|cffffff00";
MONKEYBUDDY_LOADED_MSG				= MONKEYBUDDY_INFO_COLOUR .. MONKEYBUDDY_TITLE .. " v" .. MONKEYBUDDY_VERSION .. " 已载入";

MONKEYBUDDY_TOOLTIP_CLOSE			= "关闭";
MONKEYBUDDY_RESET_ALL				= "全部重置";
MONKEYBUDDY_RESET				= "重置";



-- defs for MonkeyQuest
MONKEYBUDDY_QUEST_TITLE				= "MonkeyQuest";
MONKEYBUDDY_QUEST_OPEN				= "打开 MonkeyQuest";
MONKEYBUDDY_QUEST_SHOWHIDDEN			= "显示隐藏条目";
MONKEYBUDDY_QUEST_USEOVERVIEWS			= "无物品收集和怪物猎杀时显示任务摘要";
MONKEYBUDDY_QUEST_HIDEHEADERS			= "当隐藏条目时隐藏区域标题";
MONKEYBUDDY_QUEST_HIDEBORDER			= "隐藏边框";
MONKEYBUDDY_QUEST_GROWUP			= "MonkeyQuest 窗口向上扩展";
MONKEYBUDDY_QUEST_SHOWNUMQUESTS			= "显示任务数量";
MONKEYBUDDY_QUEST_LOCK				= "锁定 MonkeyQuest 窗口";
MONKEYBUDDY_QUEST_COLOURTITLEON			= "根据任务难度为任务标题上色";
MONKEYBUDDY_QUEST_HIDECOMPLETEDQUESTS		= "隐藏已完成的任务";
MONKEYBUDDY_QUEST_HIDECOMPLETEDOBJECTIVES	= "隐藏已完成的任务部分";
MONKEYBUDDY_QUEST_SHOWTOOLTIPOBJECTIVES		= "在游戏信息提示框显示任务相关信息";
MONKEYBUDDY_QUEST_ALLOWRIGHTCLICK		= "允许右键点击打开 MonkeyBuddy";
MONKEYBUDDY_QUEST_HIDETITLEBUTTONS		= "隐藏标题按钮";
MONKEYBUDDY_QUEST_HIDETITLE			= "隐藏标题(任务监视)";
MONKEYBUDDY_QUEST_CRASHFONT			= "使用黑体字体";
MONKEYBUDDY_QUEST_CRASHBORDER			= "使用边框颜色";
MONKEYBUDDY_QUEST_SHOWNOOBTIPS			= "显示新手提示";


MONKEYBUDDY_QUEST_QUESTTITLECOLOUR		= "任务标题";
MONKEYBUDDY_QUEST_HEADEROPENCOLOUR		= "打开地区分类显示";
MONKEYBUDDY_QUEST_HEADERCLOSEDCOLOUR		= "关闭地区分类显示";
MONKEYBUDDY_QUEST_OVERVIEWCOLOUR		= "任务摘要";
MONKEYBUDDY_QUEST_SPECIALOBJECTIVECOLOUR	= "特殊目标";
MONKEYBUDDY_QUEST_INITIALOBJECTIVECOLOUR	= "完成度 0%";
MONKEYBUDDY_QUEST_MIDOBJECTIVECOLOUR		= "完成度 50%";
MONKEYBUDDY_QUEST_COMPLETEOBJECTIVECOLOUR	= "完成度 100%";
MONKEYBUDDY_QUEST_ZONEHIGHLIGHTCOLOUR		= "高亮当前所在地区";

MONKEYBUDDY_QUEST_FRAMEALPHASLIDER		= "全局透明度";
MONKEYBUDDY_QUEST_ALPHASLIDER			= "背景透明度";
MONKEYBUDDY_QUEST_WIDTHSLIDER			= "窗口宽度";
MONKEYBUDDY_QUEST_FONTSLIDER			= "字体大小";
MONKEYBUDDY_QUEST_PADDINGSLIDER			= "任务间距";

MONKEYBUDDY_QUEST_ALWAYSHEADERS				= "总是显示地区标签";
MONKEYBUDDY_QUEST_SHOWZONEHIGHLIGHT			= "高亮显示任务地区";
MONKEYBUDDY_QUEST_SHOWQUESTLEVEL			= "显示任务等级";

-- defs for MonkeySpeed
MONKEYBUDDY_SPEED_TITLE				= "|cffccccccMonkeySpeed|r";
MONKEYBUDDY_SPEED_OPEN				= "Open MonkeySpeed";
MONKEYBUDDY_SPEED_PERCENT			= "Show speed as a percent";
MONKEYBUDDY_SPEED_BAR				= "Show speed as a background colour";
MONKEYBUDDY_SPEED_LOCK				= "Lock the MonkeySpeed frame";

MONKEYBUDDY_SPEED_WIDTHSLIDER			= "Frame Width";

-- defs for MonkeyClock
MONKEYBUDDY_CLOCK_TITLE				= "|cffccccccMonkeyClock|r";
MONKEYBUDDY_CLOCK_OPEN				= "Open MonkeyClock";
MONKEYBUDDY_CLOCK_HIDEBORDER			= "Hide the border";
MONKEYBUDDY_CLOCK_USEMILITARYTIME		= "Use 24 hour clock";
MONKEYBUDDY_CLOCK_LOCK				= "Lock the MonkeyClock frame";
MONKEYBUDDY_CLOCK_CHATALARM			= "Use the alarm message in the chat window";
MONKEYBUDDY_CLOCK_DIALOGALARM			= "Use the alarm dialog box with snooze button";

MONKEYBUDDY_CLOCK_HOURSLIDER			= "Hour Offset";
MONKEYBUDDY_CLOCK_MINUTESLIDER			= "Minute Offset";

MONKEYBUDDY_CLOCK_ALARMHOURSLIDER		= "Alarm Hour";
MONKEYBUDDY_CLOCK_ALARMMINUTESLIDER		= "Alarm Minute";

-- bindings
BINDING_HEADER_MONKEYBUDDY 			= MONKEYBUDDY_TITLE;
BINDING_NAME_MONKEYBUDDY_OPEN 			= "打开设置面板";

end    


if ( GetLocale() == "zhTW" ) then

MONKEYBUDDY_TITLE				= "MonkeyBuddy";
MONKEYBUDDY_VERSION				= MONKEYLIB_VERSION;
MONKEYBUDDY_FRAME_TITLE				= MONKEYBUDDY_TITLE .. " v" .. MONKEYBUDDY_VERSION;
MONKEYBUDDY_DESCRIPTION				= "幫助你設置 Money 系列插件。";
MONKEYBUDDY_INFO_COLOUR				= "|cffffff00";
MONKEYBUDDY_LOADED_MSG				= MONKEYBUDDY_INFO_COLOUR .. MONKEYBUDDY_TITLE .. " v" .. MONKEYBUDDY_VERSION .. " 已載入";

MONKEYBUDDY_TOOLTIP_CLOSE			= "關閉";
MONKEYBUDDY_RESET_ALL				= "全部重置";
MONKEYBUDDY_RESET				= "重置";

-- defs for MonkeyQuest
MONKEYBUDDY_QUEST_TITLE				= "MonkeyQuest";
MONKEYBUDDY_QUEST_OPEN				= "打開 MonkeyQuest";
MONKEYBUDDY_QUEST_SHOWHIDDEN			= "顯示隱藏條目";
MONKEYBUDDY_QUEST_USEOVERVIEWS			= "無物品收集和怪物獵殺時顯示任務摘要";
MONKEYBUDDY_QUEST_HIDEHEADERS			= "當隱藏條目時隱藏區域標題";
MONKEYBUDDY_QUEST_HIDEBORDER			= "隱藏邊框";
MONKEYBUDDY_QUEST_GROWUP			= "MonkeyQuest 窗口向上擴展";
MONKEYBUDDY_QUEST_SHOWNUMQUESTS			= "顯示任務數量";
MONKEYBUDDY_QUEST_LOCK				= "鎖定 MonkeyQuest 窗口";
MONKEYBUDDY_QUEST_COLOURTITLEON			= "根據任務難度為任務標題上色";
MONKEYBUDDY_QUEST_HIDECOMPLETEDQUESTS		= "隱藏已完成的任務";
MONKEYBUDDY_QUEST_HIDECOMPLETEDOBJECTIVES	= "隱藏已完成的任務部分";
MONKEYBUDDY_QUEST_SHOWTOOLTIPOBJECTIVES		= "在遊戲信息提示框顯示任務相關信息";
MONKEYBUDDY_QUEST_ALLOWRIGHTCLICK		= "允許右鍵點擊打開 MonkeyBuddy";
MONKEYBUDDY_QUEST_HIDETITLEBUTTONS		= "隱藏標題按鈕";
MONKEYBUDDY_QUEST_HIDETITLE			= "隱藏標題(任務監視)";
MONKEYBUDDY_QUEST_CRASHFONT			= "使用黑體字體";
MONKEYBUDDY_QUEST_CRASHBORDER			= "使用邊框顏色";
MONKEYBUDDY_QUEST_SHOWNOOBTIPS			= "顯示新手提示";


MONKEYBUDDY_QUEST_QUESTTITLECOLOUR		= "任務標題";
MONKEYBUDDY_QUEST_HEADEROPENCOLOUR		= "打開地區分類顯示";
MONKEYBUDDY_QUEST_HEADERCLOSEDCOLOUR		= "關閉地區分類顯示";
MONKEYBUDDY_QUEST_OVERVIEWCOLOUR		= "任務摘要";
MONKEYBUDDY_QUEST_SPECIALOBJECTIVECOLOUR	= "特殊目標";
MONKEYBUDDY_QUEST_INITIALOBJECTIVECOLOUR	= "完成度 0%";
MONKEYBUDDY_QUEST_MIDOBJECTIVECOLOUR		= "完成度 50%";
MONKEYBUDDY_QUEST_COMPLETEOBJECTIVECOLOUR	= "完成度 100%";
MONKEYBUDDY_QUEST_ZONEHIGHLIGHTCOLOUR		= "高亮當前所在地區";

MONKEYBUDDY_QUEST_FRAMEALPHASLIDER		= "全局透明度";
MONKEYBUDDY_QUEST_ALPHASLIDER			= "背景透明度";
MONKEYBUDDY_QUEST_WIDTHSLIDER			= "窗口寬度";
MONKEYBUDDY_QUEST_FONTSLIDER			= "字體大小";
MONKEYBUDDY_QUEST_PADDINGSLIDER			= "任務間距";

MONKEYBUDDY_QUEST_ALWAYSHEADERS				= "總是顯示地區標籤";
MONKEYBUDDY_QUEST_SHOWZONEHIGHLIGHT			= "高亮顯示任務地區";
MONKEYBUDDY_QUEST_SHOWQUESTLEVEL			= "顯示任務等級";

-- defs for MonkeySpeed
MONKEYBUDDY_SPEED_TITLE				= "|cffccccccMonkeySpeed|r";
MONKEYBUDDY_SPEED_OPEN				= "Open MonkeySpeed";
MONKEYBUDDY_SPEED_PERCENT			= "Show speed as a percent";
MONKEYBUDDY_SPEED_BAR				= "Show speed as a background colour";
MONKEYBUDDY_SPEED_LOCK				= "Lock the MonkeySpeed frame";

MONKEYBUDDY_SPEED_WIDTHSLIDER			= "Frame Width";

-- defs for MonkeyClock
MONKEYBUDDY_CLOCK_TITLE				= "|cffccccccMonkeyClock|r";
MONKEYBUDDY_CLOCK_OPEN				= "Open MonkeyClock";
MONKEYBUDDY_CLOCK_HIDEBORDER			= "Hide the border";
MONKEYBUDDY_CLOCK_USEMILITARYTIME		= "Use 24 hour clock";
MONKEYBUDDY_CLOCK_LOCK				= "Lock the MonkeyClock frame";
MONKEYBUDDY_CLOCK_CHATALARM			= "Use the alarm message in the chat window";
MONKEYBUDDY_CLOCK_DIALOGALARM			= "Use the alarm dialog box with snooze button";

MONKEYBUDDY_CLOCK_HOURSLIDER			= "Hour Offset";
MONKEYBUDDY_CLOCK_MINUTESLIDER			= "Minute Offset";

MONKEYBUDDY_CLOCK_ALARMHOURSLIDER		= "Alarm Hour";
MONKEYBUDDY_CLOCK_ALARMMINUTESLIDER		= "Alarm Minute";

-- bindings
BINDING_HEADER_MONKEYBUDDY 			= MONKEYBUDDY_TITLE;
BINDING_NAME_MONKEYBUDDY_OPEN 			= "打開設置面板";

end    

