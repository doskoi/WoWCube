MYINVENTORY_MYADDON_VERSION = "2.0.2";
if (GetLocale() == "zhCN") then
	-- MYADDONS
	MYINVENTORY_MYADDON_NAME = "背包整合";
	MYINVENTORY_MYADDON_DESCRIPTION = "将所有物品整合到单一窗口。";
	--KEYBINDINGS
	BINDING_HEADER_MYINVENTORYHEADER	= "整合背包";
	BINDING_NAME_MYINVENTORYICON		= "切换整合背包";
	BINDING_NAME_MYINVENTORYCONFIG   = "整合背包设置窗口";
	-- USAGE
	MYINVENTORY_CHAT_COMMAND_USAGE		= {
		[1] = "格式: /mi [show/|replace/|cols/|lock/|graphics/|back/|config]",
		[2] = "命令:",
		[3] = "show    - 显示/隐藏背包窗口",
		[4] = "replace - 替换缺省背包",
		[5] = "cols   - 设置每行显示多少列",
		[6] = "lock - 锁定/解锁背包窗口 - 锁定后不能拖动",
		[7] = "graphics - 设置显示风格", -- -LITE
		[8] = "back - 设置是否显示背景",
		[9] = "freeze - 离开商人时保持背包打开",
		[10]= "count - 显示剩余或者已用的格子数量",
		[11]= "title - 显示/隐藏标题",
		[12]= "cash - 显示/隐藏金钱显示",
		[13]= "buttons - 显示/隐藏按钮",
		[14]= "resetpos - 重置位置到屏幕右下脚",
		[15]= "aioi - 切换到布局风格",
		[16]= "config - 打开控制面板"
		--Didn't put these into slash commands yet
	--	[10] = "highlightitems - Highlight items when you mouse over a bag icon",
	--	[11] = "highlightbags - Highlight bag when you mouse over an item", 
	}
	--MESSAGES
	MYINVENTORY_MSG_INIT_s   = "<整合背包> %s的配置已经初始化。";
	MYINVENTORY_MSG_CREATE_s = "<整合背包> 正在创建%s的配置。";
	--OPTION TOGGLE MESSAGES
	MYINVENTORY_CHAT_PREFIX            = "<整合背包> ";
	MYINVENTORY_CHAT_REPLACEBAGSON     = "替换游戏默认背包。";
	MYINVENTORY_CHAT_REPLACEBAGSOFF    = "取消替换游戏默认背包。";
	MYINVENTORY_CHAT_GRAPHICSON        = "开启背景显示。";
	MYINVENTORY_CHAT_GRAPHICSOFF       = "关闭背景显示。";
	MYINVENTORY_CHAT_BACKGROUNDON      = "背景已经显示。";
	MYINVENTORY_CHAT_BACKGROUNDOFF     = "背景已经隐藏。";
	MYINVENTORY_CHAT_HIGHLIGHTBAGSON   = "高亮对应包裹。";
	MYINVENTORY_CHAT_HIGHLIGHTBAGSOFF  = "取消高亮对应包裹。";
	MYINVENTORY_CHAT_HIGHLIGHTITEMSON  = "高亮包裹对应的物品。";
	MYINVENTORY_CHAT_HIGHLIGHTITEMSOFF = "取消高亮包裹对应的物品。";
	MYINVENTORY_CHAT_FREEZEON          = "离开商人时保持背包显示。";
	MYINVENTORY_CHAT_FREEZEOFF         = "离开商人时自动关闭背包。";
	MYINVENTORY_CHAT_COUNTON           = "已用插槽。"
	MYINVENTORY_CHAT_COUNTOFF          = "剩余插槽。"
	MYINVENTORY_CHAT_SHOWTITLEON       = "显示标题"
	MYINVENTORY_CHAT_SHOWTITLEOFF      = "隐藏标题"
	MYINVENTORY_CHAT_CASHON            = "显示金钱数量"
	MYINVENTORY_CHAT_CASHOFF           = "隐藏金钱数量"
	MYINVENTORY_CHAT_BUTTONSON         = "显示按钮"
	MYINVENTORY_CHAT_BUTTONSOFF        = "隐藏按钮"
	MYINVENTORY_CHAT_AIOISTYLEON    = "AIOI风格的物品排序。";
	MYINVENTORY_CHAT_AIOISTYLEOFF   = "整合背包的物品排序风格。";
	--MyInventory Title
	MYINVENTORY_TITLE     = "背包";
	MYINVENTORY_TITLE_S   = "%s的背包";
	MYINVENTORY_TITLE_SS  = "%s[%s]的背包";
	MYINVENTORY_SLOTS_DD  = "%d/%d格";
	--MyInventory Options frame
	MYINVENTORY_CHECKTEXT_REPLACEBAGS    = "替换游戏默认背包";
	MYINVENTORY_CHECKTEXT_GRAPHICS       = "游戏默认背包风格";
	MYINVENTORY_CHECKTEXT_BACKGROUND     = "显示背景";
	MYINVENTORY_CHECKTEXT_HIGHLIGHTBAGS  = "高亮对应背包";
	MYINVENTORY_CHECKTEXT_HIGHLIGHTITEMS = "高亮对应物品";
	MYINVENTORY_CHECKTEXT_SHOWTITLE      = "显示标题"
	MYINVENTORY_CHECKTEXT_CASH           = "显示金钱"
	MYINVENTORY_CHECKTEXT_BUTTONS        = "显示按钮"
	MYINVENTORY_CHECKTEXT_FREEZE         = "保持窗口开启状态"
	MYINVENTORY_CHECKTEXT_COUNTUSED      = "已使用插槽"
	MYINVENTORY_CHECKTEXT_COUNTFREE      = "剩余插槽"
	MYINVENTORY_CHECKTEXT_COUNTOFF       = "关闭"

	MYINVENTORY_CHECKTIP_REPLACEBAGS     = "当勾选后，整合背包取代游戏默认的背包";
	MYINVENTORY_CHECKTIP_GRAPHICS        = "开启暴雪风格的背景";
	MYINVENTORY_CHECKTIP_BACKGROUND      = "开启或关闭背景";
	MYINVENTORY_CHECKTIP_HIGHLIGHTBAGS   = "当你移动到一个物品上将高亮显示其所在的包裹";
	MYINVENTORY_CHECKTIP_HIGHLIGHTITEMS  = "当你移动到包裹上将高亮显示该包裹对应的所有物品";
	MYINVENTORY_CHECKTIP_SHOWTITLE       = "显示/隐藏标题和玩家名称"
	MYINVENTORY_CHECKTIP_CASH            = "显示/隐藏金钱显示"
	MYINVENTORY_CHECKTIP_BUTTONS         = "显示/隐藏关闭、锁定和隐藏背包等按钮"
	MYINVENTORY_CHECKTIP_FREEZE          = "当远离商人、银行或拍卖所时保持整合背包窗口开着"
	MYINVENTORY_CHECKTIP_COUNTUSED       = "显示使用插槽"
	MYINVENTORY_CHECKTIP_COUNTFREE       = "显示剩余插槽"
	MYINVENTORY_CHECKTIP_COUNTOFF        = "隐藏插槽"

	MYINVENTORY_CHAT_ITEMBORDERON    = "物品边框颜色与质量匹配。";
	MYINVENTORY_CHAT_ITEMBORDEROFF   = "重置物品边框为缺省。";
	MYINVENTORY_CHECKTEXT_ITEMBORDER     = "质量显示边框";
	MYINVENTORY_CHECKTIP_ITEMBORDER      = "基于物品质量的颜色边框";

	MYINVENTORY_SLIDERTEXT_COLUMN = "每行列数";
	MYINVENTORY_SLIDERTEXT_SCALE = "UI缩放";

	MYINVENTORY_SOUL_BAG = "灵魂袋";
	MYINVENTORY_QUIVER = "箭袋";
	MYINVENTORY_AMMO = "弹药袋";
	MYINVENTORY_HERB_BAG = "草药袋";
	MYINVENTORY_ENCH_BAG = "附魔材料袋";
	MYINVENTORY_ENG_BAG = "工程学材料袋";
	MYINVENTORY_ORE_BAG = "矿石袋";
	MYINVENTORY_GEM_BAG = "宝石袋";

	MB_CONFIG_TEXT = "请选择要配置的插件";
elseif (GetLocale() == "zhTW") then
	-- MYADDONS
	MYINVENTORY_MYADDON_NAME = "背包整合";
	MYINVENTORY_MYADDON_DESCRIPTION = "將所有物品整合到單一窗口。";
	--KEYBINDINGS
	BINDING_HEADER_MYINVENTORYHEADER	= "整合背包";
	BINDING_NAME_MYINVENTORYICON		= "切換整合背包";
	BINDING_NAME_MYINVENTORYCONFIG   = "整合背包設置窗口";
	-- USAGE
	MYINVENTORY_CHAT_COMMAND_USAGE		= {
		[1] = "格式: /mi [show/|replace/|cols/|lock/|graphics/|back/|config]",
		[2] = "命令:",
		[3] = "show    - 顯示/隱藏背包窗口",
		[4] = "replace - 替換缺省背包",
		[5] = "cols   - 設置每行顯示多少列",
		[6] = "lock - 鎖定/解鎖背包窗口 - 鎖定後不能拖動",
		[7] = "graphics - 設置顯示風格", -- -LITE
		[8] = "back - 設置是否顯示背景",
		[9] = "freeze - 離開商人時保持背包打開",
		[10]= "count - 顯示剩餘或者已用的格子數量",
		[11]= "title - 顯示/隱藏標題",
		[12]= "cash - 顯示/隱藏金錢顯示",
		[13]= "buttons - 顯示/隱藏按鈕",
		[14]= "resetpos - 重置位置到屏幕右下腳",
		[15]= "aioi - 切換到佈局風格",
		[16]= "config - 打開控制面板"
		--Didn't put these into slash commands yet
	--	[10] = "highlightitems - Highlight items when you mouse over a bag icon",
	--	[11] = "highlightbags - Highlight bag when you mouse over an item", 
	}
	--MESSAGES
	MYINVENTORY_MSG_INIT_s   = "<整合背包> %s的配置已經初始化。";
	MYINVENTORY_MSG_CREATE_s = "<整合背包> 正在創建%s的配置。";
	--OPTION TOGGLE MESSAGES
	MYINVENTORY_CHAT_PREFIX            = "<整合背包> ";
	MYINVENTORY_CHAT_REPLACEBAGSON     = "替換遊戲默認背包。";
	MYINVENTORY_CHAT_REPLACEBAGSOFF    = "取消替換遊戲默認背包。";
	MYINVENTORY_CHAT_GRAPHICSON        = "開啟背景顯示。";
	MYINVENTORY_CHAT_GRAPHICSOFF       = "關閉背景顯示。";
	MYINVENTORY_CHAT_BACKGROUNDON      = "背景已經顯示。";
	MYINVENTORY_CHAT_BACKGROUNDOFF     = "背景已經隱藏。";
	MYINVENTORY_CHAT_HIGHLIGHTBAGSON   = "高亮對應包裹。";
	MYINVENTORY_CHAT_HIGHLIGHTBAGSOFF  = "取消高亮對應包裹。";
	MYINVENTORY_CHAT_HIGHLIGHTITEMSON  = "高亮包裹對應的物品。";
	MYINVENTORY_CHAT_HIGHLIGHTITEMSOFF = "取消高亮包裹對應的物品。";
	MYINVENTORY_CHAT_FREEZEON          = "離開商人時保持背包顯示。";
	MYINVENTORY_CHAT_FREEZEOFF         = "離開商人時自動關閉背包。";
	MYINVENTORY_CHAT_COUNTON           = "已用插槽。"
	MYINVENTORY_CHAT_COUNTOFF          = "剩餘插槽。"
	MYINVENTORY_CHAT_SHOWTITLEON       = "顯示標題"
	MYINVENTORY_CHAT_SHOWTITLEOFF      = "隱藏標題"
	MYINVENTORY_CHAT_CASHON            = "顯示金錢數量"
	MYINVENTORY_CHAT_CASHOFF           = "隱藏金錢數量"
	MYINVENTORY_CHAT_BUTTONSON         = "顯示按鈕"
	MYINVENTORY_CHAT_BUTTONSOFF        = "隱藏按鈕"
	MYINVENTORY_CHAT_AIOISTYLEON    = "AIOI風格的物品排序。";
	MYINVENTORY_CHAT_AIOISTYLEOFF   = "整合背包的物品排序風格。";
	--MyInventory Title
	MYINVENTORY_TITLE     = "背包";
	MYINVENTORY_TITLE_S   = "%s的背包";
	MYINVENTORY_TITLE_SS  = "%s[%s]的背包";
	MYINVENTORY_SLOTS_DD  = "%d/%d格";
	--MyInventory Options frame
	MYINVENTORY_CHECKTEXT_REPLACEBAGS    = "替換遊戲默認背包";
	MYINVENTORY_CHECKTEXT_GRAPHICS       = "遊戲默認背包風格";
	MYINVENTORY_CHECKTEXT_BACKGROUND     = "顯示背景";
	MYINVENTORY_CHECKTEXT_HIGHLIGHTBAGS  = "高亮對應背包";
	MYINVENTORY_CHECKTEXT_HIGHLIGHTITEMS = "高亮對應物品";
	MYINVENTORY_CHECKTEXT_SHOWTITLE      = "顯示標題"
	MYINVENTORY_CHECKTEXT_CASH           = "顯示金錢"
	MYINVENTORY_CHECKTEXT_BUTTONS        = "顯示按鈕"
	MYINVENTORY_CHECKTEXT_FREEZE         = "保持窗口開啟狀態"
	MYINVENTORY_CHECKTEXT_COUNTUSED      = "已使用插槽"
	MYINVENTORY_CHECKTEXT_COUNTFREE      = "剩餘插槽"
	MYINVENTORY_CHECKTEXT_COUNTOFF       = "關閉"

	MYINVENTORY_CHECKTIP_REPLACEBAGS     = "當勾選後，整合背包取代遊戲默認的背包";
	MYINVENTORY_CHECKTIP_GRAPHICS        = "開啟暴雪風格的背景";
	MYINVENTORY_CHECKTIP_BACKGROUND      = "開啟或關閉背景";
	MYINVENTORY_CHECKTIP_HIGHLIGHTBAGS   = "當你移動到一個物品上將高亮顯示其所在的包裹";
	MYINVENTORY_CHECKTIP_HIGHLIGHTITEMS  = "當你移動到包裹上將高亮顯示該包裹對應的所有物品";
	MYINVENTORY_CHECKTIP_SHOWTITLE       = "顯示/隱藏標題和玩家名稱"
	MYINVENTORY_CHECKTIP_CASH            = "顯示/隱藏金錢顯示"
	MYINVENTORY_CHECKTIP_BUTTONS         = "顯示/隱藏關閉、鎖定和隱藏背包等按鈕"
	MYINVENTORY_CHECKTIP_FREEZE          = "當遠離商人、銀行或拍賣所時保持整合背包窗口開著"
	MYINVENTORY_CHECKTIP_COUNTUSED       = "顯示使用插槽"
	MYINVENTORY_CHECKTIP_COUNTFREE       = "顯示剩餘插槽"
	MYINVENTORY_CHECKTIP_COUNTOFF        = "隱藏插槽"

	MYINVENTORY_CHAT_ITEMBORDERON    = "物品邊框顏色與質量匹配。";
	MYINVENTORY_CHAT_ITEMBORDEROFF   = "重置物品邊框為缺省。";
	MYINVENTORY_CHECKTEXT_ITEMBORDER     = "質量顯示邊框";
	MYINVENTORY_CHECKTIP_ITEMBORDER      = "基於物品質量的顏色邊框";

	MYINVENTORY_SLIDERTEXT_COLUMN = "每行列數";
	MYINVENTORY_SLIDERTEXT_SCALE = "UI縮放";

	MYINVENTORY_SOUL_BAG = "靈魂裂片包";
	MYINVENTORY_QUIVER = "箭袋";
	MYINVENTORY_AMMO = "彈藥袋";
	MYINVENTORY_HERB_BAG = "草藥包";
	MYINVENTORY_ENCH_BAG = "附魔包";
	MYINVENTORY_ENG_BAG = "工程包";
	MYINVENTORY_ORE_BAG = "礦石包";
	MYINVENTORY_GEM_BAG = "寶石背包";

	MB_CONFIG_TEXT = "請選擇要配置的模組";
else
-- MYADDONS
MYINVENTORY_MYADDON_NAME = "MyInventory";
MYINVENTORY_MYADDON_DESCRIPTION = "A simple, compact all in one inventory window.";
--KEYBINDINGS
BINDING_HEADER_MYINVENTORYHEADER	= "My Inventory";
BINDING_NAME_MYINVENTORYICON		= "My Inventory Toggle";
BINDING_NAME_MYINVENTORYCONFIG   = "My Inventory Config Window";
-- USAGE
MYINVENTORY_CHAT_COMMAND_USAGE		= {
	[1] = "Usage: /mi [show/|replace/|cols/|lock/|graphics/|back/|config]",
	[2] = "Commands:",
	[3] = "show    - toggles the MyInventory window",
	[4] = "replace - if it should replace the bags or not",
	[5] = "cols   - how many columns there should be in each row.",
	[6] = "lock - lock/unlock the window for dragging and auto closing.",
	[7] = "graphics - Toggle Blizzard style art", -- -LITE
	[8] = "back - Toggle background visibility",
	[9] = "freeze - keep window open at vendors",
	[10]= "count - display count of free slots or used slots",
	[11]= "title - hide/show the title",
	[12]= "cash - hide/show the money display",
	[13]= "buttons - hide/show the buttons",
	[14]= "resetpos - reset position to lower right corner of the screen",
	[15]= "aioi - toggles AIOI style bag layout",
	[16]= "config - Open control panel"
	--Didn't put these into slash commands yet
--	[10] = "highlightitems - Highlight items when you mouse over a bag icon",
--	[11] = "highlightbags - Highlight bag when you mouse over an item", 
}
--MESSAGES
MYINVENTORY_MSG_LOADED = "Darklin's MyInventory AddOn loaded.";
MYINVENTORY_MSG_INIT_s   = "MyInventory: Profile for %s initialized.";
MYINVENTORY_MSG_CREATE_s = "MyInventory: Creating new Profile for %s";
--OPTION TOGGLE MESSAGES
MYINVENTORY_CHAT_PREFIX            = "My Inventory: ";
MYINVENTORY_CHAT_REPLACEBAGSON     = "Replacing bags.";
MYINVENTORY_CHAT_REPLACEBAGSOFF    = "Not replacing bags.";
MYINVENTORY_CHAT_GRAPHICSON        = "Background art enabled.";
MYINVENTORY_CHAT_GRAPHICSOFF       = "Background art disabled.";
MYINVENTORY_CHAT_BACKGROUNDON      = "Background is now opaque.";
MYINVENTORY_CHAT_BACKGROUNDOFF     = "Background is now transparent.";
MYINVENTORY_CHAT_HIGHLIGHTBAGSON   = "Highlighting bags.";
MYINVENTORY_CHAT_HIGHLIGHTBAGSOFF  = "Not highlighting bags.";
MYINVENTORY_CHAT_HIGHLIGHTITEMSON  = "Highlighting items.";
MYINVENTORY_CHAT_HIGHLIGHTITEMSOFF = "Not highlighting items.";
MYINVENTORY_CHAT_FREEZEON          = "Staying open when leaving vendor";
MYINVENTORY_CHAT_FREEZEOFF         = "Closing when leaving vendor";
MYINVENTORY_CHAT_COUNTON           = "Counting taken slots."
MYINVENTORY_CHAT_COUNTOFF          = "Counting free slots."
MYINVENTORY_CHAT_SHOWTITLEON       = "Title shown"
MYINVENTORY_CHAT_SHOWTITLEOFF      = "Title hidden"
MYINVENTORY_CHAT_CASHON            = "Cash Shown"
MYINVENTORY_CHAT_CASHOFF           = "Cash Hidden"
MYINVENTORY_CHAT_BUTTONSON         = "Buttons Shown"
MYINVENTORY_CHAT_BUTTONSOFF        = "Buttons Hidden"
MYINVENTORY_CHAT_AIOISTYLEON    = "All-In-One-Inventory style item ordering.";
MYINVENTORY_CHAT_AIOISTYLEOFF   = "My Inventory style item ordering.";
--MyInventory Title
MYINVENTORY_TITLE     = "Inventory";
MYINVENTORY_TITLE_S   = "%s's Inventory";
MYINVENTORY_TITLE_SS  = "%s of %s's Inventory";
MYINVENTORY_SLOTS_DD  = "%d/%d Slots";
--MyInventory Options frame
MYINVENTORY_CHECKTEXT_REPLACEBAGS    = "Replace default bags";
MYINVENTORY_CHECKTEXT_GRAPHICS       = "Blizzard style artwork";
MYINVENTORY_CHECKTEXT_BACKGROUND     = "Opaque Background";
MYINVENTORY_CHECKTEXT_HIGHLIGHTBAGS  = "Highlight item's bag";
MYINVENTORY_CHECKTEXT_HIGHLIGHTITEMS = "Highlight bag's item";
MYINVENTORY_CHECKTEXT_SHOWTITLE      = "Show Title"
MYINVENTORY_CHECKTEXT_CASH           = "Show Cash"
MYINVENTORY_CHECKTEXT_BUTTONS        = "Show Buttons"
MYINVENTORY_CHECKTEXT_FREEZE         = "Keep Window Open"
MYINVENTORY_CHECKTEXT_COUNTUSED      = "Used Slots"
MYINVENTORY_CHECKTEXT_COUNTFREE      = "Free Slots"
MYINVENTORY_CHECKTEXT_COUNTOFF       = "Off"

MYINVENTORY_CHECKTIP_REPLACEBAGS     = "When checked, MyInventory takes over as the default bag";
MYINVENTORY_CHECKTIP_GRAPHICS        = "Enables Blizzard style background artwork";
MYINVENTORY_CHECKTIP_BACKGROUND      = "Turn the background on or off";
MYINVENTORY_CHECKTIP_HIGHLIGHTBAGS   = "When you mouse over an item in MyInventory it will highlight the bag that that item is in.";
MYINVENTORY_CHECKTIP_HIGHLIGHTITEMS  = "When you mouse over a bag in MyInventory it will highlight all the items that are in that bag";
MYINVENTORY_CHECKTIP_SHOWTITLE       = "Show/Hide the title and player name"
MYINVENTORY_CHECKTIP_CASH            = "Show/Hide Money display"
MYINVENTORY_CHECKTIP_BUTTONS         = "Show/Hide Close, Lock and Hide Bags Buttons"
MYINVENTORY_CHECKTIP_FREEZE          = "When leaving a vendor, Bank, or AH, keep the MI window open"
MYINVENTORY_CHECKTIP_COUNTUSED       = "Show Used slots"
MYINVENTORY_CHECKTIP_COUNTFREE       = "Show Free Slots"
MYINVENTORY_CHECKTIP_COUNTOFF        = "Hides the Slots"

-- UNTRANSLATED:
MYINVENTORY_CHAT_ITEMBORDERON    = "Item Borders colored to match quality.";
MYINVENTORY_CHAT_ITEMBORDEROFF   = "Item Borders reset to default.";
MYINVENTORY_CHECKTEXT_ITEMBORDER     = "Quality Borders";
MYINVENTORY_CHECKTIP_ITEMBORDER      = "Color borders based on item quality";


MYINVENTORY_SLIDERTEXT_COLUMN = "Columns"
MYINVENTORY_SLIDERTEXT_SCALE = "Scale"

MYINVENTORY_SOUL_BAG = "Soul Bag";
MYINVENTORY_QUIVER = "Quiver";
MYINVENTORY_AMMO = "Ammo";
MYINVENTORY_HERB_BAG = "Herb Bag";
MYINVENTORY_ENCH_BAG = "Enchanting Bag";
MYINVENTORY_ENG_BAG = "Engineering Bag";
MYINVENTORY_ORE_BAG = "Mining Bag";
MYINVENTORY_GEM_BAG = "Gem Bag";

MB_CONFIG_TEXT = "Please selete the addon need to config";
end




if ( GetLocale() == "zhCN") then
	MYBANK_MYADDON_NAME	= "银行整合";
	MYBANK_MYADDON_DESCRIPTION = "整合银行窗口，支持同账号下的银行内的物品查看.";

	MYBANK_EARTH_DISPLAY	= "显示";
	MYBANK_EARTH_CONFIG	= "选项";
	MYBANK_TOOLTIP_PLAYER	= "您正在察看此角色的银行状态.";
	MYBANK_TOOLTIP_AT	= " 位于 ";
	MYBANK_TOOLTIP_ALLPLAYER	= "察看所有服务器角色的金币总合.";

	MYBANK_CHAT_COMMAND_USAGE		= {
		[1]="使用范例: /mb cols [数值(6-18)]",
		[2]="可用选项:",
		[3]="config - 调出配置界面.",
		[4]="show - 显示/隐藏MyBank窗口",
		[5]="replace - 替换默认银行界面",
		[6]="cols - 设置银行单排物品格数，必须大于等于6小于等于18.",
		[7]="freeze - 锁定/解锁MyBank窗口.",
		[8]="graphics - 显示/隐藏暴雪默认银行窗口风格.",
		[9]="back - 显示/隐藏背景",
		[10]="player - 显示/隐藏玩家选择框.",
		[11]="highlightitems - 鼠标移到背包上时高亮物品.",
		[12]="highlightbags - 鼠标移动到物品上时高亮背包."
	};

	MYBANK_CHAT_PROFILE_CREATED   = "MyBank: New profile for %s was created";
	MYBANK_CHAT_OLDVERSION        = "Old Version detected. Clearing old profiles.";

	MYBANK_CHAT_COLUMNS_FORMAT			 = "MyBank每排物品格数设置为:%d.";
	MYBANK_CHAT_FREEZEON              = "已锁定MyBank，现在无法移动MyBank窗口.";
	MYBANK_CHAT_FREEZEOFF             = "已解锁MyBank，现在可以移动MyBank窗口.";
	MYBANK_CHAT_REPLACEBANKON         = "已将银行界面替换为MyBank.";
	MYBANK_CHAT_REPLACEBANKOFF        = "已还原银行界面为系统默认.";
	MYBANK_CHAT_HIGHLIGHTBAGSON		 = "开启鼠标移动到物品上时高亮背包功能.";
	MYBANK_CHAT_HIGHLIGHTBAGSOFF		 = "禁用鼠标移动到物品上时高亮背包功能.";
	MYBANK_CHAT_HIGHLIGHTITEMSON		 = "已开启鼠标移到背包上时高亮物品.";
	MYBANK_CHAT_HIGHLIGHTITEMSOFF		 = "已禁用鼠标移到背包上时高亮物品.";

	MYBANK_PURCHASE_CONFIRM_S = "你确定花费 %d 银币购买一个新的背包栏位吗?";
	MYBANK_PURCHASE_CONFIRM_G = "你确定花费 %d 金币币购买一个新的背包栏位吗?";

	MYBANK_ATBANK = "使用银行中";

	MYBANK_CONFIG_REPLACE = "替换银行界面";
	MYBANK_CONFIG_FREEZE  = "锁定银行窗口";
	MYBANK_CONFIG_HIGHLIGHTITEMS = "高亮背包中的物品";
	MYBANK_CONFIG_HIGHLIGHTBAGS = "高亮物品所在背包";
	MYBANK_CONFIG_HIGHLIGHTCOLOR = "高亮颜色";
	MYBANK_CONFIG_GRAPHICS = "使用暴雪默认银行窗口风格";
	MYBANK_CONFIG_BACK = "显示背景";
	MYBANK_CONFIG_TITLE = "MyBank 配置面板";
	MYBANK_CONFIG_COLUMN = "每排物品格数";

	MYBANK_FROZEN_ERROR = "MyBank窗口已经锁定，您无法对其进行拖动.";

	MYBANK_LOADED = "|c000066FFMyBank 汉化版 by 小诺 已载入,键入/mb显示帮助菜单.";

	MYBANK_FRAME_PLAYERANDREGION = "%s(%s)的银行";
	MYBANK_FRAME_PLAYERONLY      = "%s的银行";
	MYBANK_FRAME_SLOTS           = "%d/%d 格数.";
	MYBANK_FRAME_ALLREALMS       = "所有服务器";
	MYBANK_FRAME_SELECTPLAYER    = "选择显示银行的角色";
	MYBANK_FRAME_TOTAL           = "(合计)";
	MYBANK_FRAME_BUY             = "购买";
elseif ( GetLocale() == "zhTW") then
	MYBANK_MYADDON_NAME	= "銀行整合";
	MYBANK_MYADDON_DESCRIPTION = "整合銀行窗口，支持同賬號下的銀行內的物品查看.";

	MYBANK_EARTH_DISPLAY	= "顯示";
	MYBANK_EARTH_CONFIG	= "選項";
	MYBANK_TOOLTIP_PLAYER	= "您正在察看此角色的銀行狀態.";
	MYBANK_TOOLTIP_AT	= " 位於 ";
	MYBANK_TOOLTIP_ALLPLAYER	= "察看所有服務器角色的金幣總合.";

	MYBANK_CHAT_COMMAND_USAGE		= {
		[1]="使用範例: /mb cols [數值(6-18)]",
		[2]="可用選項:",
		[3]="config - 調出配置界面.",
		[4]="show - 顯示/隱藏MyBank窗口",
		[5]="replace - 替換默認銀行界面",
		[6]="cols - 設置銀行單排物品格數，必須大於等於6小於等於18.",
		[7]="freeze - 鎖定/解鎖MyBank窗口.",
		[8]="graphics - 顯示/隱藏暴雪默認銀行窗口風格.",
		[9]="back - 顯示/隱藏背景",
		[10]="player - 顯示/隱藏玩家選擇框.",
		[11]="highlightitems - 鼠標移到背包上時高亮物品.",
		[12]="highlightbags - 鼠標移動到物品上時高亮背包."
	};

	MYBANK_CHAT_PROFILE_CREATED   = "MyBank: New profile for %s was created";
	MYBANK_CHAT_OLDVERSION        = "Old Version detected. Clearing old profiles.";

	MYBANK_CHAT_COLUMNS_FORMAT			 = "MyBank每排物品格數設置為:%d.";
	MYBANK_CHAT_FREEZEON              = "已鎖定MyBank，現在無法移動MyBank窗口.";
	MYBANK_CHAT_FREEZEOFF             = "已解鎖MyBank，現在可以移動MyBank窗口.";
	MYBANK_CHAT_REPLACEBANKON         = "已將銀行界面替換為MyBank.";
	MYBANK_CHAT_REPLACEBANKOFF        = "已還原銀行界面為系統默認.";
	MYBANK_CHAT_HIGHLIGHTBAGSON		 = "開啟鼠標移動到物品上時高亮背包功能.";
	MYBANK_CHAT_HIGHLIGHTBAGSOFF		 = "禁用鼠標移動到物品上時高亮背包功能.";
	MYBANK_CHAT_HIGHLIGHTITEMSON		 = "已開啟鼠標移到背包上時高亮物品.";
	MYBANK_CHAT_HIGHLIGHTITEMSOFF		 = "已禁用鼠標移到背包上時高亮物品.";

	MYBANK_PURCHASE_CONFIRM_S = "你確定花費 %d 銀幣購買一個新的背包欄位嗎?";
	MYBANK_PURCHASE_CONFIRM_G = "你確定花費 %d 金幣幣購買一個新的背包欄位嗎?";

	MYBANK_ATBANK = "使用銀行中";

	MYBANK_CONFIG_REPLACE = "替換銀行界面";
	MYBANK_CONFIG_FREEZE  = "鎖定銀行窗口";
	MYBANK_CONFIG_HIGHLIGHTITEMS = "高亮背包中的物品";
	MYBANK_CONFIG_HIGHLIGHTBAGS = "高亮物品所在背包";
	MYBANK_CONFIG_HIGHLIGHTCOLOR = "高亮顏色";
	MYBANK_CONFIG_GRAPHICS = "使用暴雪默認銀行窗口風格";
	MYBANK_CONFIG_BACK = "顯示背景";
	MYBANK_CONFIG_TITLE = "MyBank 配置面板";
	MYBANK_CONFIG_COLUMN = "每排物品格數";

	MYBANK_FROZEN_ERROR = "MyBank窗口已經鎖定，您無法對其進行拖動.";

	MYBANK_LOADED = "|c000066FFMyBank 漢化版 by 小諾 已載入,鍵入/mb顯示幫助菜單.";

	MYBANK_FRAME_PLAYERANDREGION = "%s(%s)的銀行";
	MYBANK_FRAME_PLAYERONLY      = "%s的銀行";
	MYBANK_FRAME_SLOTS           = "%d/%d 格數.";
	MYBANK_FRAME_ALLREALMS       = "所有服務器";
	MYBANK_FRAME_SELECTPLAYER    = "選擇顯示銀行的角色";
	MYBANK_FRAME_TOTAL           = "(合計)";
	MYBANK_FRAME_BUY             = "購買";
else
-- Version : English - Ramble
-- FR Translation by : Rincevent 
BINDING_HEADER_MYBANKHEADER	= "My Bank";
BINDING_NAME_MYBANKICON		= "My Bank Frame Toggle";
BINDING_NAME_MYBANKCONFIG		= "My Bank Config Frame Toggle";

MYBANK_MYADDON_NAME	= "MyBank";
MYBANK_MYADDON_DESCRIPTION = "A simple, compact bank frame window.";

MYBANK_CHAT_COMMAND_USAGE		= {
	[1]="Usage: /mb [init|reset|show|toggle|replacebags|cols|column|freeze|unfreeze]",
	[2]="Commands:",
	[3]="show - toggles the MyBank window",
	[4]="replacebank - if it should replace the bank or not",
	[5]="cols - how many columns there should be in each row.",
	[6]="reset or init, will recreate your profile with default settings.",
	[7]="freeze/unfreeze will lock/unlock the window for dragging."
};

MYBANK_CHAT_PROFILE_CREATED   = "MyBank: New profile for %s was created";
MYBANK_CHAT_OLDVERSION        = "Old Version detected. Clearing old profiles.";

MYBANK_CHAT_COLUMNS_FORMAT			 = "MyBank number of columns set to %d.";
MYBANK_CHAT_FREEZEON              = "MyBank frozen.";
MYBANK_CHAT_FREEZEOFF             = "MyBank unfrozen.";
MYBANK_CHAT_REPLACEBANKON         = "MyBank replacing bank.";
MYBANK_CHAT_REPLACEBANKOFF        = "MyBank not replacing bank.";
MYBANK_CHAT_HIGHLIGHTBAGSON		 = "MyBank will highlight item's bag.";
MYBANK_CHAT_HIGHLIGHTBAGSOFF		 = "MyBank not highlighting item's bag.";
MYBANK_CHAT_HIGHLIGHTITEMSON		 = "MyBank will highlight bag's items.";
MYBANK_CHAT_HIGHLIGHTITEMSOFF		 = "MyBank not highlighting bag's items.";

MYBANK_PURCHASE_CONFIRM_S = "Are you sure you wish to purchase a bag slot for %d silver?";
MYBANK_PURCHASE_CONFIRM_G = "Are you sure you wish to purchase a bag slot for %d gold?";

MYBANK_ATBANK = "At Bank";

MYBANK_CONFIG_REPLACE = "Replace Bank";
MYBANK_CONFIG_FREEZE  = "Freeze MyBank";
MYBANK_CONFIG_HIGHLIGHTITEMS = "Highlight Bag's Items";
MYBANK_CONFIG_HIGHLIGHTBAGS = "Highlight Item's Bag";
MYBANK_CONFIG_HIGHLIGHTCOLOR = "Highlight Color";
MYBANK_CONFIG_GRAPHICS = "Blizzard style artwork";
MYBANK_CONFIG_BACK = "Opaque Background";
MYBANK_CONFIG_TITLE = "MyBank Config Panle";
MYBANK_CONFIG_COLUMN = "Columns";

MYBANK_FROZEN_ERROR = "MyBank is frozen and can not move...";

MYBANK_LOADED = "Ramble's MyBank AddOn loaded.";

MYBANK_FRAME_PLAYERANDREGION = "%s of %s's Bank";
MYBANK_FRAME_PLAYERONLY      = "%s's Bank";
MYBANK_FRAME_SLOTS           = "%d/%d Slots.";
MYBANK_FRAME_ALLREALMS       = "All Realms";
MYBANK_FRAME_SELECTPLAYER    = "Select Player's Bank to Show";
MYBANK_FRAME_TOTAL           = "(t)";
MYBANK_FRAME_BUY             = "Buy";
end
