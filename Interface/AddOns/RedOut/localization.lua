if ( GetLocale() == "zhCN") then
	REDOUT_TITLE = "施法距离"
	REDOUT_OPTION = "施法距离设置选项"

	REDOUT_TEXT_GENERAL = "普通"
	REDOUT_TEXT_EXTENSIONS = "扩展"
	REDOUT_TEXT_INTERVAL = "时间间隔"
	REDOUT_TEXT_SAVE = "保存"
	REDOUT_TEXT_DEFAULT = "默认"
	REDOUT_TEXT_ENABLE = "开启施法距离";
	REDOUT_TEXT_ENABLETIP = "开启或禁止施法距离";
	REDOUT_TEXT_COLOR = "超出射程颜色";
	REDOUT_TEXT_COLORTIP = "选择一个在施法距离外图标的颜色";
	REDOUT_TEXT_FAILD = "施法距离定位失败于:"
	REDOUT_TEXT_HOTKEYCHECK = "快捷键颜色";
	REDOUT_TEXT_HOTKEYCHECKTIP = "开启或禁止快捷键颜色";
	REDOUT_TEXT_HOTKEYCOLOR = "超出射程快捷键颜色";
	REDOUT_TEXT_HOTKEYCOLORTIP = "选择设置超出距离快捷键的颜色";
	REDOUT_TEXT_INTERVALTIP = "快捷键闪烁时间间隔"

	equipslot = {
	{ name = "头部" },
	{ name = "颈部" },
	{ name = "肩部" },
	{ name = "背部" },
	{ name = "胸部" },
	{ name = "衬衣" },
	{ name = "公会徽章" },
	{ name = "手腕" },
	{ name = "手" },
	{ name = "腰部" },
	{ name = "腿部" },
	{ name = "脚" },
	{ name = "手指0" },
	{ name = "手指1" },
	{ name = "饰品0" },
	{ name = "饰品1" },
	{ name = "主手" },
	{ name = "副手" },
	{ name = "远程" },
};

elseif ( GetLocale() == "zhTW") then

	REDOUT_TITLE = "施法距離"
	REDOUT_OPTION = "施法距離設置選項"

	REDOUT_TEXT_GENERAL = "普通"
	REDOUT_TEXT_EXTENSIONS = "擴展"
	REDOUT_TEXT_INTERVAL = "時間間隔"
	REDOUT_TEXT_SAVE = "保存"
	REDOUT_TEXT_DEFAULT = "默認"
	REDOUT_TEXT_ENABLE = "開啟施法距離";
	REDOUT_TEXT_ENABLETIP = "開啟或禁止施法距離";
	REDOUT_TEXT_COLOR = "超出射程顏色";
	REDOUT_TEXT_COLORTIP = "選擇一個在施法距離外圖標的顏色";
	REDOUT_TEXT_FAILD = "施法距離定位失敗於:"
	REDOUT_TEXT_HOTKEYCHECK = "快捷鍵顏色";
	REDOUT_TEXT_HOTKEYCHECKTIP = "開啟或禁止快捷鍵顏色";
	REDOUT_TEXT_HOTKEYCOLOR = "超出射程快捷鍵顏色";
	REDOUT_TEXT_HOTKEYCOLORTIP = "選擇設置超出距離快捷鍵的顏色";
	REDOUT_TEXT_INTERVALTIP = "快捷鍵閃爍時間間隔"

	equipslot = {
	{ name = "頭部" },
	{ name = "頸部" },
	{ name = "肩部" },
	{ name = "背部" },
	{ name = "胸部" },
	{ name = "襯衣" },
	{ name = "公會徽章" },
	{ name = "手腕" },
	{ name = "手" },
	{ name = "腰部" },
	{ name = "腿部" },
	{ name = "腳" },
	{ name = "手指0" },
	{ name = "手指1" },
	{ name = "飾品0" },
	{ name = "飾品1" },
	{ name = "主手" },
	{ name = "副手" },
	{ name = "遠程" },
};

else
	REDOUT_TITLE = "Red Out"
	REDOUT_OPTION = "Red Out Option"

	REDOUT_TEXT_GENERAL = "General"
	REDOUT_TEXT_EXTENSIONS = "Extensions"
	REDOUT_TEXT_INTERVAL = "Update Interval"
	REDOUT_TEXT_SAVE = "Save"
	REDOUT_TEXT_DEFAULT = "Defaults"
	REDOUT_TEXT_ENABLE = "Enable Red Out";
	REDOUT_TEXT_ENABLETIP = "Enable or Disable all features";
	REDOUT_TEXT_COLOR = "Out of Range Color";
	REDOUT_TEXT_COLORTIP = "Select the Color to shade Buttons when Out of Range";
	REDOUT_TEXT_FAILD = "RedOut failed to locate:"
	REDOUT_TEXT_HOTKEYCHECK = "Enable Hotkey Color";
	REDOUT_TEXT_HOTKEYCHECKTIP = "Enable or Disable shading the Hotkey text";
	REDOUT_TEXT_HOTKEYCOLOR = "Hotkey Text Color";
	REDOUT_TEXT_HOTKEYCOLORTIPT = "Select the Color to shade Hotkey Text when Out of Range";
	REDOUT_TEXT_INTERVALTIP = "Adjust the time interval (in seconds) between Red Out updates"

	equipslots = {
	{ name = "HeadSlot" },
	{ name = "NeckSlot" },
	{ name = "ShoulderSlot" },
	{ name = "BackSlot" },
	{ name = "ChestSlot" },
	{ name = "ShirtSlot" },
	{ name = "TabardSlot" },
	{ name = "WristSlot" },
	{ name = "HandsSlot" },
	{ name = "WaistSlot" },
	{ name = "LegsSlot" },
	{ name = "FeetSlot" },
	{ name = "Finger0Slot" },
	{ name = "Finger1Slot" },
	{ name = "Trinket0Slot" },
	{ name = "Trinket1Slot" },
	{ name = "MainHandSlot" },
	{ name = "SecondaryHandSlot" },
	{ name = "RangedSlot" },
};
end