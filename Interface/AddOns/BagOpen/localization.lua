if ( GetLocale() == "zhCN") then
	BAGOPEN_TITLE = "包裹全开";
	BAGOPEN_OPTION = "包裹全开设置选项";
	BAGOPEN_OPTION_INFO		= "与银行和商人对话的时候打开所有包裹.";
	BAGOPEN_CONFIG_ONOFF			= "自动打开包裹";
	BAGOPEN_CONFIG_ONOFF_INFO		= "选中则在银行和商人自动打开所有包裹";
	BAGOPEN_CONFIG_KEEPONOFF		= "保持包裹打开状态";
	BAGOPEN_CONFIG_KEEPONOFF_INFO		= "选中则离开银行和商人的时候保持包裹打开状态";
elseif ( GetLocale() == "zhTW") then
	BAGOPEN_TITLE = "包裹全開";
	BAGOPEN_OPTION = "包裹全開設置選項";
	BAGOPEN_OPTION_INFO		= "與銀行和商人對話的時候打開所有包裹.";
	BAGOPEN_CONFIG_ONOFF			= "自動打開包裹";
	BAGOPEN_CONFIG_ONOFF_INFO		= "選中則在銀行和商人自動打開所有包裹";
	BAGOPEN_CONFIG_KEEPONOFF		= "保持包裹打開狀態";
	BAGOPEN_CONFIG_KEEPONOFF_INFO		= "選中則離開銀行和商人的時候保持包裹打開狀態";
else
	BAGOPEN_TITLE = "BagOpen";
	BAGOPEN_OPTION = "BagOpen Option";
	BAGOPEN_OPTION_INFO		= "Open your all bags when taik with bank and NPCs.";
	BAGOPEN_CONFIG_ONOFF			= "Enable BagOpen";
	BAGOPEN_CONFIG_ONOFF_INFO		= "Toggle with Enabled/Disabled BagOpen";
	BAGOPEN_CONFIG_KEEPONOFF		= "Kepp BagOpen status";
	BAGOPEN_CONFIG_KEEPONOFF_INFO		= "Toggle with keep bags status when leave bank and NPCs";
end