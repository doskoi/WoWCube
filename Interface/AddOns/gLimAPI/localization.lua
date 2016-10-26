if ( GetLocale() == "zhCN") then
	GLIM_WELCOME = "欢迎使用月光宝盒 "..GetAddOnMetadata("gLimMod", "Version").."\n\n|cff2dedff新的月光宝盒使用插件动态加载机制，能有效避免内存的浪费，提高你的游戏整体性能。|r\n\n|cffff8000首先请你花一点时间在下面的菜单里开启你所需要的插件。|r\n\n当然你也可以跳过，今后在\"|cfffff419月光宝盒菜单 - 插件管理|r\"里开启这些插件。\n\n|cffffffcc祝你在艾泽拉斯冒险愉快，"..UnitName("player").."！|r\n\n请到官网获取最新更新信息:\n"..GetAddOnMetadata("gLimMod", "X-Website");
	GLIM_SETTING = "设置";
	GLIM_RELOADUI_CONFIRM = "禁用插件要|cffff7000重新载入界面|r才能生效,\n是否选择立即重载？\n如果取消|cffffff00下次登录|r将会禁用此模块";
elseif ( GetLocale() == "zhTW") then
	GLIM_WELCOME = "歡迎使用月光寶盒 "..GetAddOnMetadata("gLimMod", "Version").."\n\n|cff2dedff新的月光寶盒使用插件動態加載機制，能有效避免內存的浪費，提高你的遊戲整體性能。|r\n\n|cffff8000首先請你花一點時間在下面的菜單裡開啟你所需要的插件。|r\n\n當然你也可以跳過，今後在\"|cfffff419月光寶盒菜單 - 插件管理|r\"裡開啟這些插件。\n\n|cffffffcc祝你在艾澤拉斯冒險愉快，"..UnitName("player").."！|r\n\n請到官網獲取最新更新信息:\n"..GetAddOnMetadata("gLimMod", "X-Website");
	GLIM_SETTING = "設置";
	GLIM_RELOADUI_CONFIRM = "禁用插件要|cffff7000重新載入界面|r才能生效,\n是否選擇立即重載？\n如果取消|cffffff00下次登錄|r將會禁用此模塊";
else
	GLIM_WELCOME = "|cffff7000Welcome to use gLimMod|r "..GetAddOnMetadata("gLimMod", "Version").."\n\ngLimMod uses load on demand.\n\nPlease use a little time to\n\"|cff00ff00gLimMod Menu - AddOns Manage|r\"\nEnable the addon of you need\n\n|cffffff00Wish you enjoy in the Azeroth,"..UnitName("player").."!|r\n\nCheck new version at website:\n"..GetAddOnMetadata("gLimMod", "X-Website");
	GLIM_SETTING = "Setting";
	GLIM_RELOADUI_CONFIRM = "Disable addons will be |cffff7000reload ui|r, Are you sure?\nIf cancel will disable it on |cffffff00next login|r";
end
