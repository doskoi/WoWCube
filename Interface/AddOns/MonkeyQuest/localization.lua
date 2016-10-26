--[[

	MonkeyQuest:
	Displays your quests for quick viewing.
	
	Website:	http://toctastic.net/
	Author:		Trentin (trentin@toctastic.net)
	
	
	Contributors:
	Celdor
		- Help with the Quest Log Freeze bug
		
	Diungo
		- Toggle grow direction
		
	Pkp
		- Color Quest Titles the same as the quest level
	
	wowpendium.de
		- German translation

	MarsMod
		- Valid player name before the VARIABLES_LOADED event bug
		- Settings resetting bug

	Juki
		- French translation

	Global
		- PvP Quests
	
	Jim Bim
		- Updated German translation

--]]

-- ** NOTE ** The other languages are getting out of date, 
-- if you'd like to submit an update please email it to trentin@toctastic.net


if (GetLocale() == "zhCN") then

	MONKEYQUEST_TITLE					= "任务监视";
	MONKEYQUEST_VERSION					= "2.8";
	MONKEYQUEST_TITLE_VERSION			= MONKEYQUEST_TITLE .. " v" .. MONKEYQUEST_VERSION;
	MONKEYQUEST_DESCRIPTION				= "快速显示任务相关信息";
	MONKEYQUEST_INFO_COLOUR				= "|cffffff00";
	MONKEYQUEST_LOADED_MSG				= MONKEYQUEST_INFO_COLOUR .. MONKEYQUEST_TITLE .. " v" .. MONKEYQUEST_VERSION .. " 已载入";


	MONKEYQUEST_QUEST_DONE				= "完成";
	MONKEYQUEST_QUEST_FAILED			= "失败";
	MONKEYQUEST_CONFIRM_RESET			= "确认恢复 " .. MONKEYQUEST_TITLE .. " 默认设置?";


	MONKEYQUEST_CHAT_COLOUR				= "|cff00ff00";
	MONKEYQUEST_SET_WIDTH_MSG			= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": 你需要用'/console reloadui'来观看宽度的修改效果";
	MONKEYQUEST_RESET_MSG				= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": 设置已经恢复到默认值";

	MONKEYQUEST_HELP_MSG				= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest help <command>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "<command>为下列各参数: \n" ..
										  "reset, open, close, showhidden, hidehidden, useoverviews, nooverviews, " ..
										  "tipanchor, alpha, width, hideheaders, showheaders, hideborder, showborder, " ..
										  "growup, growdown, hidenumquests, shownumquests, lock, unlock, colourtitleon, " ..
										  "colourtitleoff, hidecompletedquests, showcompletedquests, hidecompletedobjectives, " ..
										  "showcompletedobjectives, fontheight, showtooltipobjectives, hidetootipobjectives, " ..
										  "allowrightclick, disallowrightclick, hidetitlebuttons, showtitlebuttons.";
	MONKEYQUEST_HELP_RESET_MSG			= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest reset\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "显示重设配置对话框。\n";


	MONKEYQUEST_HELP_OPEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest open\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "显示主 " .. MONKEYQUEST_TITLE .. " 窗体。\n";
	MONKEYQUEST_HELP_CLOSE_MSG			= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest close\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隐藏主 " .. MONKEYQUEST_TITLE .. " 窗体。\n";
	MONKEYQUEST_HELP_SHOWHIDDEN_MSG		= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest showhidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "显示失败的地区名称并隐藏任务。\n";
	MONKEYQUEST_HELP_HIDEHIDDEN_MSG		= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest hidehidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隐藏失败的地区名称并隐藏任务.\n";
	MONKEYQUEST_HELP_USEOVERVIEWS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest useoverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "显示没有物品收集或者怪物猎杀的任务摘要。\n";
	MONKEYQUEST_HELP_NOOVERVIEWS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest nooverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隐藏没有物品收集或者怪物猎杀的任务摘要。\n";
	MONKEYQUEST_HELP_TIPANCHOR_MSG		= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest tipanchor=<anchor position>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "设置提示栏的位置到 <anchor position> " .. 
										  "下列位置可用:\nANCHOR_TOPLEFT(左上), ANCHOR_TOPRIGHT(右上), ANCHOR_TOP(中上), ANCHOR_LEFT(左), " ..
										  "ANCHOR_RIGHT(右), ANCHOR_BOTTOMLEFT(下左), ANCHOR_BOTTOMRIGHT(下右), ANCHOR_BOTTOM(下), ANCHOR_CURSOR(鼠标指针), " .. 
										  "DEFAULT(默认), NONE(无)";
	MONKEYQUEST_HELP_ALPHA_MSG			= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest alpha=<0 - 255>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "设置背景透明度到指定的值。\n";
	MONKEYQUEST_HELP_WIDTH_MSG			= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest width=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "设置宽度到指定的值，默认是255。\n";
	MONKEYQUEST_HELP_HIDEHEADERS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest hideheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "从不显示地区名称。\n";
	MONKEYQUEST_HELP_SHOWHEADERS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest showheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "一直显示地区名称。\n";
	MONKEYQUEST_HELP_HIDEBORDER_MSG		= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest hideborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隐藏主 " .. MONKEYQUEST_TITLE .. " 窗体的边框。\n";
	MONKEYQUEST_HELP_SHOWBORDER_MSG		= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest showborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "显示主 " .. MONKEYQUEST_TITLE .. " 窗体的边框。\n";
	MONKEYQUEST_HELP_GROWUP_MSG			= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest growup\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "使主 " .. MONKEYQUEST_TITLE .. " 窗体向上扩展。\n";
	MONKEYQUEST_HELP_GROWDOWN_MSG		= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest growdown\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "使主 " .. MONKEYQUEST_TITLE .. " 窗体向下扩展。\n";
	MONKEYQUEST_HELP_HIDENUMQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest hidenumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隐藏标题栏上的任务数量。\n";
	MONKEYQUEST_HELP_SHOWNUMQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest shownumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "显示主标题栏上的任务数量。\n";
	MONKEYQUEST_HELP_LOCK_MSG			= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest lock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "锁定 " .. MONKEYQUEST_TITLE .. " 窗体。\n";
	MONKEYQUEST_HELP_UNLOCK_MSG			= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest unlock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "解锁 " .. MONKEYQUEST_TITLE .. " 窗体。\n";
	MONKEYQUEST_HELP_COLOURTITLEON_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest colourtitleon\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "根据任务难度使用颜色来标示任务标题。\n";
	MONKEYQUEST_HELP_COLOURTITLEOFF_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest colourtitleoff\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "不根据任务难度使用颜色来标示任务标题。\n";
	MONKEYQUEST_HELP_HIDECOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest hidecompletedquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隐藏已完成任务。\n";
	MONKEYQUEST_HELP_SHOWCOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest showcompletedquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "显示已完成任务。\n";
	MONKEYQUEST_HELP_HIDECOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest hidecompletedobjectives\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隐藏完整任务描述。\n";
	MONKEYQUEST_HELP_SHOWCOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest showcompletedobjectives\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "显示完整任务描述。\n";
	MONKEYQUEST_HELP_FONTHEIGHT_MSG		= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest fontheight=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "设置字体大小到指定值，默认是12。\n";
	MONKEYQUEST_HELP_SHOWTOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest showtooltipobjectives\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "在提示窗口添加一条线显示完整任务提示。\n";
	MONKEYQUEST_HELP_HIDETOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest hidetooltipobjectives\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "不在提示窗口添加一条线显示完整任务提示。\n";
	MONKEYQUEST_HELP_ALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest allowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "允许右键点击打开MonkeyBuddy。\n";
	MONKEYQUEST_HELP_DISALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest disallowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "禁止右键点击打开MonkeyBuddy。\n";
	MONKEYQUEST_HELP_HIDETITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest hidetitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隐藏标题栏按钮。\n";
	MONKEYQUEST_HELP_SHOWTITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest showtitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "显示标题栏按钮。\n";

										  
	-- tooltip strings
	MONKEYQUEST_TOOLTIP_QUEST			= "任务";
	MONKEYQUEST_TOOLTIP_QUESTITEM		= "任务相关";		-- as it appears in the tooltip of unique quest items
	MONKEYQUEST_TOOLTIP_SLAIN			= "已杀死";			-- as it appears in the objective text

	-- misc quest strings
	MONKEYQUEST_DUNGEON					= "副本";
	MONKEYQUEST_PVP						= "PvP";

	-- noob tips
	MONKEYQUEST_NOOBTIP_HEADER			= "新手提示:";

	MONKEYQUEST_NOOBTIP_CLOSE			= "点击关闭。再次打开:";
	MONKEYQUEST_NOOBTIP_MINIMIZE		= "点击此处最小化主窗体";
	MONKEYQUEST_NOOBTIP_RESTORE			= "点击此处最大化主窗体";
	MONKEYQUEST_NOOBTIP_SHOWALLHIDDEN	= "点击此处显示被隐藏条目";
	MONKEYQUEST_NOOBTIP_HIDEALLHIDDEN	= "点击此处隐藏可隐藏条目";
	MONKEYQUEST_NOOBTIP_HIDEBUTTON		= "点击此处隐藏该任务。 开启 '显示隐藏的全部条目' 便于再次浏览这项任务";
	MONKEYQUEST_NOOBTIP_TITLE			= "右键点击打开 MonkeyBuddy 配置面板";
	MONKEYQUEST_NOOBTIP_QUESTHEADER		= "点击此处隐藏/显示该地区的全部任务。 开启 '显示隐藏的全部条目' 以便显示你隐藏的地区标题。";

	-- bindings
	BINDING_HEADER_MONKEYQUEST 			= MONKEYQUEST_TITLE;
	BINDING_NAME_MONKEYQUEST_CLOSE 		= "关闭/打开";
	BINDING_NAME_MONKEYQUEST_MINIMIZE 	= "最小化/最大化";
	BINDING_NAME_MONKEYQUEST_HIDDEN		= "隐藏/显示条目";
	BINDING_NAME_MONKEYQUEST_NOHEADERS	= "切换标题显示";

	-- using to get the number of Quest Item in Chinese
	MONKEYQUEST_QUESTITEM_COLON		= "：";

elseif ( GetLocale() == "zhTW") then

	MONKEYQUEST_TITLE					= "任務監視";
	MONKEYQUEST_VERSION					= "2.8";
	MONKEYQUEST_TITLE_VERSION			= MONKEYQUEST_TITLE .. " v" .. MONKEYQUEST_VERSION;
	MONKEYQUEST_DESCRIPTION				= "快速顯示任務相關信息";
	MONKEYQUEST_INFO_COLOUR				= "|cffffff00";
	MONKEYQUEST_LOADED_MSG				= MONKEYQUEST_INFO_COLOUR .. MONKEYQUEST_TITLE .. " v" .. MONKEYQUEST_VERSION .. " 已載入";


	MONKEYQUEST_QUEST_DONE				= "完成";
	MONKEYQUEST_QUEST_FAILED			= "失敗";
	MONKEYQUEST_CONFIRM_RESET			= "確認恢復 " .. MONKEYQUEST_TITLE .. " 默認設置?";


	MONKEYQUEST_CHAT_COLOUR				= "|cff00ff00";
	MONKEYQUEST_SET_WIDTH_MSG			= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": 你需要用'/console reloadui'來觀看寬度的修改效果";
	MONKEYQUEST_RESET_MSG				= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": 設置已經恢復到默認值";

	MONKEYQUEST_HELP_MSG				= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest help <command>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "<command>為下列各參數: \n" ..
										  "reset, open, close, showhidden, hidehidden, useoverviews, nooverviews, " ..
										  "tipanchor, alpha, width, hideheaders, showheaders, hideborder, showborder, " ..
										  "growup, growdown, hidenumquests, shownumquests, lock, unlock, colourtitleon, " ..
										  "colourtitleoff, hidecompletedquests, showcompletedquests, hidecompletedobjectives, " ..
										  "showcompletedobjectives, fontheight, showtooltipobjectives, hidetootipobjectives, " ..
										  "allowrightclick, disallowrightclick, hidetitlebuttons, showtitlebuttons.";
	MONKEYQUEST_HELP_RESET_MSG			= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest reset\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "顯示重設配置對話框。\n";


	MONKEYQUEST_HELP_OPEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest open\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "顯示主 " .. MONKEYQUEST_TITLE .. " 窗體。\n";
	MONKEYQUEST_HELP_CLOSE_MSG			= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest close\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隱藏主 " .. MONKEYQUEST_TITLE .. " 窗體。\n";
	MONKEYQUEST_HELP_SHOWHIDDEN_MSG		= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest showhidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "顯示失敗的地區名稱並隱藏任務。\n";
	MONKEYQUEST_HELP_HIDEHIDDEN_MSG		= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest hidehidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隱藏失敗的地區名稱並隱藏任務.\n";
	MONKEYQUEST_HELP_USEOVERVIEWS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest useoverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "顯示沒有物品收集或者怪物獵殺的任務摘要。\n";
	MONKEYQUEST_HELP_NOOVERVIEWS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest nooverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隱藏沒有物品收集或者怪物獵殺的任務摘要。\n";
	MONKEYQUEST_HELP_TIPANCHOR_MSG		= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest tipanchor=<anchor position>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "設置提示欄的位置到 <anchor position> " .. 
										  "下列位置可用:\nANCHOR_TOPLEFT(左上), ANCHOR_TOPRIGHT(右上), ANCHOR_TOP(中上), ANCHOR_LEFT(左), " ..
										  "ANCHOR_RIGHT(右), ANCHOR_BOTTOMLEFT(下左), ANCHOR_BOTTOMRIGHT(下右), ANCHOR_BOTTOM(下), ANCHOR_CURSOR(鼠標指針), " .. 
										  "DEFAULT(默認), NONE(無)";
	MONKEYQUEST_HELP_ALPHA_MSG			= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest alpha=<0 - 255>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "設置背景透明度到指定的值。\n";
	MONKEYQUEST_HELP_WIDTH_MSG			= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest width=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "設置寬度到指定的值，默認是255。\n";
	MONKEYQUEST_HELP_HIDEHEADERS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest hideheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "從不顯示地區名稱。\n";
	MONKEYQUEST_HELP_SHOWHEADERS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest showheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "一直顯示地區名稱。\n";
	MONKEYQUEST_HELP_HIDEBORDER_MSG		= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest hideborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隱藏主 " .. MONKEYQUEST_TITLE .. " 窗體的邊框。\n";
	MONKEYQUEST_HELP_SHOWBORDER_MSG		= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest showborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "顯示主 " .. MONKEYQUEST_TITLE .. " 窗體的邊框。\n";
	MONKEYQUEST_HELP_GROWUP_MSG			= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest growup\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "使主 " .. MONKEYQUEST_TITLE .. " 窗體向上擴展。\n";
	MONKEYQUEST_HELP_GROWDOWN_MSG		= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest growdown\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "使主 " .. MONKEYQUEST_TITLE .. " 窗體向下擴展。\n";
	MONKEYQUEST_HELP_HIDENUMQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest hidenumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隱藏標題欄上的任務數量。\n";
	MONKEYQUEST_HELP_SHOWNUMQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest shownumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "顯示主標題欄上的任務數量。\n";
	MONKEYQUEST_HELP_LOCK_MSG			= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest lock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "鎖定 " .. MONKEYQUEST_TITLE .. " 窗體。\n";
	MONKEYQUEST_HELP_UNLOCK_MSG			= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest unlock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "解鎖 " .. MONKEYQUEST_TITLE .. " 窗體。\n";
	MONKEYQUEST_HELP_COLOURTITLEON_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest colourtitleon\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "根據任務難度使用顏色來標示任務標題。\n";
	MONKEYQUEST_HELP_COLOURTITLEOFF_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest colourtitleoff\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "不根據任務難度使用顏色來標示任務標題。\n";
	MONKEYQUEST_HELP_HIDECOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest hidecompletedquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隱藏已完成任務。\n";
	MONKEYQUEST_HELP_SHOWCOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest showcompletedquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "顯示已完成任務。\n";
	MONKEYQUEST_HELP_HIDECOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest hidecompletedobjectives\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隱藏完整任務描述。\n";
	MONKEYQUEST_HELP_SHOWCOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest showcompletedobjectives\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "顯示完整任務描述。\n";
	MONKEYQUEST_HELP_FONTHEIGHT_MSG		= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest fontheight=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "設置字體大小到指定值，默認是12。\n";
	MONKEYQUEST_HELP_SHOWTOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest showtooltipobjectives\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "在提示窗口添加一條線顯示完整任務提示。\n";
	MONKEYQUEST_HELP_HIDETOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest hidetooltipobjectives\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "不在提示窗口添加一條線顯示完整任務提示。\n";
	MONKEYQUEST_HELP_ALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest allowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "允許右鍵點擊打開MonkeyBuddy。\n";
	MONKEYQUEST_HELP_DISALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest disallowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "禁止右鍵點擊打開MonkeyBuddy。\n";
	MONKEYQUEST_HELP_HIDETITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest hidetitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隱藏標題欄按鈕。\n";
	MONKEYQUEST_HELP_SHOWTITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "用法: /mquest showtitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "顯示標題欄按鈕。\n";

										  
	-- tooltip strings
	MONKEYQUEST_TOOLTIP_QUEST			= "任務";
	MONKEYQUEST_TOOLTIP_QUESTITEM		= "任務相關";		-- as it appears in the tooltip of unique quest items
	MONKEYQUEST_TOOLTIP_SLAIN			= "已殺死";			-- as it appears in the objective text

	-- misc quest strings
	MONKEYQUEST_DUNGEON					= "副本";
	MONKEYQUEST_PVP						= "PvP";

	-- noob tips
	MONKEYQUEST_NOOBTIP_HEADER			= "新手提示:";

	MONKEYQUEST_NOOBTIP_CLOSE			= "點擊關閉。再次打開:";
	MONKEYQUEST_NOOBTIP_MINIMIZE		= "點擊此處最小化主窗體";
	MONKEYQUEST_NOOBTIP_RESTORE			= "點擊此處最大化主窗體";
	MONKEYQUEST_NOOBTIP_SHOWALLHIDDEN	= "點擊此處顯示被隱藏條目";
	MONKEYQUEST_NOOBTIP_HIDEALLHIDDEN	= "點擊此處隱藏可隱藏條目";
	MONKEYQUEST_NOOBTIP_HIDEBUTTON		= "點擊此處隱藏該任務。 開啟 '顯示隱藏的全部條目' 便於再次瀏覽這項任務";
	MONKEYQUEST_NOOBTIP_TITLE			= "右鍵點擊打開 MonkeyBuddy 配置面板";
	MONKEYQUEST_NOOBTIP_QUESTHEADER		= "點擊此處隱藏/顯示該地區的全部任務。 開啟 '顯示隱藏的全部條目' 以便顯示你隱藏的地區標題。";

	-- bindings
	BINDING_HEADER_MONKEYQUEST 			= MONKEYQUEST_TITLE;
	BINDING_NAME_MONKEYQUEST_CLOSE 		= "關閉/打開";
	BINDING_NAME_MONKEYQUEST_MINIMIZE 	= "最小化/最大化";
	BINDING_NAME_MONKEYQUEST_HIDDEN		= "隱藏/顯示條目";
	BINDING_NAME_MONKEYQUEST_NOHEADERS	= "切換標題顯示";

	-- using to get the number of Quest Item in Chinese
	MONKEYQUEST_QUESTITEM_COLON		= "：";

else

MONKEYQUEST_TITLE					= "MonkeyQuest";
MONKEYQUEST_VERSION				= "2.8";
MONKEYQUEST_TITLE_VERSION			= MONKEYQUEST_TITLE .. " v" .. MONKEYQUEST_VERSION;
MONKEYQUEST_DESCRIPTION				= "Displays your quests for quick viewing.";
MONKEYQUEST_INFO_COLOUR				= "|cffffff00";
MONKEYQUEST_LOADED_MSG				= MONKEYQUEST_INFO_COLOUR .. MONKEYQUEST_TITLE .. " v" .. MONKEYQUEST_VERSION .. " loaded";

MONKEYQUEST_QUEST_DONE				= "done";
MONKEYQUEST_QUEST_FAILED			= "failed";
MONKEYQUEST_CONFIRM_RESET			= "Okay to reset " .. MONKEYQUEST_TITLE .. " settings to default values?";

MONKEYQUEST_CHAT_COLOUR				= "|cff00ff00";
MONKEYQUEST_SET_WIDTH_MSG			= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": You may need to '/console reloadui' to see the changes in width.";
MONKEYQUEST_RESET_MSG				= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": Settings reset.";

MONKEYQUEST_HELP_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest help <command>\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Where <command> is any of the following: \n" ..
									  "reset, open, close, showhidden, hidehidden, useoverviews, nooverviews, " ..
									  "tipanchor, alpha, width, hideheaders, showheaders, hideborder, showborder, " ..
									  "growup, growdown, hidenumquests, shownumquests, lock, unlock, colourtitleon, " ..
									  "colourtitleoff, hidecompletedquests, showcompletedquests, hidecompletedobjectives, " ..
									  "showcompletedobjectives, fontheight, showtooltipobjectives, hidetootipobjectives, " ..
									  "allowrightclick, disallowrightclick, hidetitlebuttons, showtitlebuttons.";
MONKEYQUEST_HELP_RESET_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest reset\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Displays the reset config variables dialog.\n";
MONKEYQUEST_HELP_OPEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest open\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Shows the main " .. MONKEYQUEST_TITLE .. " frame.\n";
MONKEYQUEST_HELP_CLOSE_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest close\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Hides the main " .. MONKEYQUEST_TITLE .. " frame.\n";
MONKEYQUEST_HELP_SHOWHIDDEN_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showhidden\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Shows collapsed zone headers and hidden quests.\n";
MONKEYQUEST_HELP_HIDEHIDDEN_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidehidden\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Hides collapsed zone headers and hidden quests.\n";
MONKEYQUEST_HELP_USEOVERVIEWS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest useoverviews\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Displays the quest overview for quests without objectives.\n";
MONKEYQUEST_HELP_NOOVERVIEWS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest nooverviews\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Don't display the quest overview for quests without objectives.\n";
MONKEYQUEST_HELP_TIPANCHOR_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest tipanchor=<anchor position>\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Sets the anchor point of the tooltip where <anchor position> " .. 
									  "can be any of the following:\nANCHOR_TOPLEFT, ANCHOR_TOPRIGHT, ANCHOR_TOP, ANCHOR_LEFT, " ..
									  "ANCHOR_RIGHT, ANCHOR_BOTTOMLEFT, ANCHOR_BOTTOMRIGHT, ANCHOR_BOTTOM, ANCHOR_CURSOR, " .. 
									  "DEFAULT, NONE";
MONKEYQUEST_HELP_ALPHA_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest alpha=<0 - 255>\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Sets the backdrop alpha to the specified value.\n";
MONKEYQUEST_HELP_WIDTH_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest width=<positive integer>\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Sets the width to the specified value, the default is 255.\n";
MONKEYQUEST_HELP_HIDEHEADERS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hideheaders\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Never display any zone headers.\n";
MONKEYQUEST_HELP_SHOWHEADERS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showheaders\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Display zone headers.\n";
MONKEYQUEST_HELP_HIDEBORDER_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hideborder\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Hide the border around the main " .. MONKEYQUEST_TITLE .. " frame.\n";
MONKEYQUEST_HELP_SHOWBORDER_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showborder\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Show the border around the main " .. MONKEYQUEST_TITLE .. " frame.\n";
MONKEYQUEST_HELP_GROWUP_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest growup\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Makes the main " .. MONKEYQUEST_TITLE .. " frame expand upwards.\n";
MONKEYQUEST_HELP_GROWDOWN_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest growdown\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Makes the main " .. MONKEYQUEST_TITLE .. " frame expand downwards.\n";
MONKEYQUEST_HELP_HIDENUMQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidenumquests\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Hide the number of quests next to the title.\n";
MONKEYQUEST_HELP_SHOWNUMQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest shownumquests\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Show the number of quests next to the title.\n";
MONKEYQUEST_HELP_LOCK_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest lock\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Locks the " .. MONKEYQUEST_TITLE .. " frame in place.\n";
MONKEYQUEST_HELP_UNLOCK_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest unlock\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Unlocks the " .. MONKEYQUEST_TITLE .. " frame, making it movable.\n";
MONKEYQUEST_HELP_COLOURTITLEON_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest colourtitleon\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Uses the difficulty to colour the entier quest title.\n";
MONKEYQUEST_HELP_COLOURTITLEOFF_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest colourtitleoff\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Doesn't colour the entier quest title by difficulty.\n";
MONKEYQUEST_HELP_HIDECOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidecompletedquests\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Hides completed quests.\n";
MONKEYQUEST_HELP_SHOWCOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showcompletedquests\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Shows completed quests.\n";
MONKEYQUEST_HELP_HIDECOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidecompletedobjectives\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Hides completed objectives.\n";
MONKEYQUEST_HELP_SHOWCOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showcompletedobjectives\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Shows completed objectives.\n";
MONKEYQUEST_HELP_FONTHEIGHT_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest fontheight=<positive integer>\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Sets the font height to the specified value, the default is 12.\n";
MONKEYQUEST_HELP_SHOWTOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showtooltipobjectives\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Adds a line to the tooltip which shows the completeness of that quest objective.\n";
MONKEYQUEST_HELP_HIDETOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidetooltipobjectives\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Does not add a line to the tooltip about the completeness of that quest objective.\n";
MONKEYQUEST_HELP_ALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest allowrightclick\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Allows you to right-click to open MonkeyBuddy.\n";
MONKEYQUEST_HELP_DISALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest disallowrightclick\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Disallows you from right-clicking to open MonkeyBuddy.\n";
MONKEYQUEST_HELP_HIDETITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidetitlebuttons\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Hides the title buttons.\n";
MONKEYQUEST_HELP_SHOWTITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showtitlebuttons\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Shows the title buttons.\n";
MONKEYQUEST_HELP_ALLOWWORKCOMPLETE_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest allowworkcomplete\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Enables >work complete< sound.\n";
MONKEYQUEST_HELP_DISALLOWWORKCOMPLETE_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest disallowworkcomplete\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Disables >work complete< sound.\n";

									  
-- tooltip strings
MONKEYQUEST_TOOLTIP_QUESTITEM		= "Quest Item";		-- as it appears in the tooltip of unique quest items
MONKEYQUEST_TOOLTIP_QUEST			= "Quest";
MONKEYQUEST_TOOLTIP_SLAIN			= "slain";			-- as it appears in the objective text

-- misc quest strings
MONKEYQUEST_DUNGEON					= "Dungeon";
MONKEYQUEST_PVP						= "PvP";

-- noob tips
MONKEYQUEST_NOOBTIP_HEADER			= "Noob Tip:";

MONKEYQUEST_NOOBTIP_CLOSE			= "Click here to close the main frame. To get it back try:";
MONKEYQUEST_NOOBTIP_MINIMIZE		= "Click here to minimize the main frame";
MONKEYQUEST_NOOBTIP_RESTORE			= "Click here to restore the main frame";
MONKEYQUEST_NOOBTIP_SHOWALLHIDDEN	= "Click here to show all hidden items";
MONKEYQUEST_NOOBTIP_HIDEALLHIDDEN	= "Click here to hide all hidden items";
MONKEYQUEST_NOOBTIP_HIDEBUTTON		= "Click here to hide this quest. Activate 'Show all hidden items' to see this quest again";
MONKEYQUEST_NOOBTIP_TITLE			= "Right Click here to open MonkeyBuddy so you can configure " .. MONKEYQUEST_TITLE;
MONKEYQUEST_NOOBTIP_QUESTHEADER		= "Click here to hide/show all the quests under this zone. Activate 'Show all hidden items' to show zone headers you've hidden.";

-- bindings
BINDING_HEADER_MONKEYQUEST 			= MONKEYQUEST_TITLE;
BINDING_NAME_MONKEYQUEST_CLOSE 		= "Close/Open";
BINDING_NAME_MONKEYQUEST_MINIMIZE 	= "Minimize/Restore";
BINDING_NAME_MONKEYQUEST_HIDDEN		= "Hide/Show all hidden items";
BINDING_NAME_MONKEYQUEST_NOHEADERS	= "Toggle No Headers";

end