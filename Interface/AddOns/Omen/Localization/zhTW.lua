-- zhTW localization
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Omen", "zhTW")
if not L then return end

-- Main Omen window
L["<Unknown>"] = "<未知的>"
L["Omen Quick Menu"] = "Omen 快捷選單"
L["Use Focus Target"] = "使用focus目標"
L["Test Mode"] = "測試模式"
L["Open Config"] = "打開配置"
L["Open Omen's configuration panel"] = "打開 Omen 配置面板"
L["Hide Omen"] = "隱藏 Omen"
L["Name"] = "名字"
L["Threat [%]"] = "威脅[%]"
L["Threat"] = "威脅"
L["TPS"] = "TPS"
L["Toggle Focus"] = "開/關focus"
L["> Pull Aggro <"] = ">獲得仇恨<"

-- Warnings
L["|cffff0000Error:|r Omen cannot use shake warning if you have turned on nameplates at least once since logging in."] = "|cffff0000錯誤:|r 如果您在登錄後啟動過一次姓名版,Omen 將無法使用震動警報功能."
L["Passed %s%% of %s's threat!"] = "已超過>%2$s<的%1$2.0f%%威脅！"

-- Config module titles
L["General Settings"] = "綜合配置"
L["Profiles"] = "配置檔"
L["Slash Command"] = "斜槓命令"

-- Config strings, general settings section
L["OMEN_DESC"] = "Omen 是一個佔用少量系統資源監控威脅的 UI,可以顯示你和同伴參與戰鬥中怪物的威脅列表.你可以改變 Omen 的外觀,並且根據不同的角色儲存不同的設定."
L["Alpha"] = "透明度"
L["Controls the transparency of the main Omen window."] = "控制 Omen 主視窗的透明度."
L["Scale"] = "縮放"
L["Controls the scaling of the main Omen window."] = "控制 Omen 主視窗的尺寸."
L["Frame Strata"] = "框架階層"
L["Controls the frame strata of the main Omen window. Default: MEDIUM"] = "控制 Omen 主要視窗的框架階層.預設:中"
L["Clamp To Screen"] = "螢幕鎖定"
L["Controls whether the main Omen window can be dragged offscreen"] = "控制 Omen 主要視窗是否可以被拖動到螢幕外."
L["Tells Omen to additionally check your 'focus' and 'focustarget' before your 'target' and 'targettarget' in that order for threat display."] = "讓 Omen 額外檢查您的「focus」和「focus目標」位於「目標」和「目標的目標」之前的順序顯示威脅."
L["Tells Omen to enter Test Mode so that you can configure Omen's display much more easily."] = "讓 Omen 進入測試模式,你可以更容易的配置 Omen 顯示."
L["Collapse to show a minimum number of bars"] = "收起以顯示最小數量的棒條"
L["Lock Omen"] = "鎖定 Omen"
L["Locks Omen in place and prevents it from being dragged or resized."] = "鎖定 Omen,使其無法移動或調整大小."
L["Show minimap button"] = "顯示小地圖按鈕"
L["Show the Omen minimap button"] = "顯示 Omen 小地圖按鈕"
L["Ignore Player Pets"] = "忽略玩家寵物"
L["IGNORE_PLAYER_PETS_DESC"] = [[
讓 Omen 忽略敵對玩家寵物以確定顯示哪些單位的威脅.

玩家寵物|cffffff78攻擊|r或者|cffffff78防禦|r狀態保持威脅與正常的怪物相同,正被攻擊目標具有最高的威脅.如果寵物指定攻擊一個具體目標,寵物仍然保持在威脅列表,但保持在指定的目標定義100%威脅之上.玩家寵物可以被嘲諷以攻擊你.

然而,玩家寵物在|cffffff78被動|r模式並沒有威脅列表,嘲諷依然不起作用.它們只攻擊指定的目標和指令時沒有仇恨列表.

當玩家寵物處於|cffffff78跟隨|r狀態時,寵物的威脅列表被消除並立刻停止攻擊,雖然它可能會立即重新指定目標位於攻擊/防禦模式.
]]
L["Autocollapse"] = "自動收起"
L["Autocollapse Options"] = "自動收起選項"
L["Grow bars upwards"] = "棒條向上增加"
L["Hide Omen on 0 bars"] = "當沒有棒條時隱藏 Omen"
L["Hide Omen entirely if it collapses to show 0 bars"] = "當沒有棒條時收起並隱藏 Omen"
L["Max bars to show"] = "棒條的顯示數量"
L["Max number of bars to show"] = "棒條最大顯示數量"
L["Background Options"] = "背景選項"
L["Background Texture"] = "背景材質"
L["Texture to use for the frame's background"] = "框體背景材質"
L["Border Texture"] = "邊框材質"
L["Texture to use for the frame's border"] = "框體邊框材質"
L["Background Color"] = "背景顏色"
L["Frame's background color"] = "框體背景顏色"
L["Border Color"] = "邊框顏色"
L["Frame's border color"] = "框體邊框顏色"
L["Tile Background"] = "標題背景"
L["Tile the background texture"] = "標題背景材質"
L["Background Tile Size"] = "標題背景尺寸"
L["The size used to tile the background texture"] = "標題背景材質尺寸"
L["Border Thickness"] = "邊框厚度"
L["The thickness of the border"] = "邊框厚度"
L["Bar Inset"] = "嵌入棒條"
L["Sets how far inside the frame the threat bars will display from the 4 borders of the frame"] = "威脅棒條顯示的內框與外框之間距離"

-- Config strings, title bar section
L["Title Bar Settings"] = "標題欄設定"
L["Configure title bar settings."] = "配置標題欄設定"
L["Show Title Bar"] = "顯示標題欄"
L["Show the Omen Title Bar"] = "顯示 Omen 標題欄"
L["Title Bar Height"] = "標題欄高度"
L["Height of the title bar. The minimum height allowed is twice the background border thickness."] = "標題欄高度.最小厚度為背景邊框厚度的一倍."
L["Title Text Options"] = "標題文字選項"
L["The font that the title text will use"] = "標題文字字體"
L["The outline that the title text will use"] = "標題文字字體輪廓"
L["The color of the title text"] = "標題字體顏色"
L["Control the font size of the title text"] = "標題文字字體大小"
L["Use Same Background"] = "使用同樣背景"
L["Use the same background settings for the title bar as the main window's background"] = "標題欄使用如同與主視窗同樣的背景設定"
L["Title Bar Background Options"] = "標題欄背景選項"

-- Config strings, show when... section
L["Show When..."] = "當何時顯示"
L["Show Omen when..."] = "當何時顯示 Omen"
L["This section controls when Omen is automatically shown or hidden."] = "這些設定將控制 Omen 何時自動顯示或隱藏."
L["Use Auto Show/Hide"] = "使用自動顯示/隱藏"
L["Show Omen when any of the following are true"] = "當符合以下條件時 Omen 會被顯示"
L["You have a pet"] = "有寵物"
L["Show Omen when you have a pet out"] = "當你的寵物存在時顯示 Omen"
L["You are alone"] = "無隊伍"
L["Show Omen when you are alone"] = "當你沒有隊伍時顯示 Omen"
L["You are in a party"] = "有隊伍"
L["Show Omen when you are in a 5-man party"] = "當你在5人隊伍中顯示 Omen"
L["You are in a raid"] = "有團隊"
L["Show Omen when you are in a raid"] = "當你在團隊中顯示 Omen"
L["However, hide Omen if any of the following are true (higher priority than the above)."] = "但選定其他項時 Omen 將被隱藏(比以上項更具優先級)."
L["You are resting"] = "當你在休息"
L["Turning this on will cause Omen to hide whenever you are in a city or inn."] = "當你位於城市或者旅店時,啟用此項會使 Omen 隱藏."
L["You are in a battleground"] = "當你在戰場"
L["Turning this on will cause Omen to hide whenever you are in a battleground or arena."] = "當你位於戰場或競技場時,啟用此項會使 Omen 隱藏."
L["You are not in combat"] = "你不在戰鬥"
L["Turning this on will cause Omen to hide whenever you are not in combat."] = "如選擇此項,離開戰鬥後 Omen 會被隱藏."
L["AUTO_SHOW/HIDE_NOTE"] = "注意:如果您手動切換 Omen 顯示或隱藏,將忽略自動顯示/隱藏設定,加入或退出隊伍或團隊和更改任何自動顯示/隱藏設定,切換區域之前它仍將顯示或隱藏."

-- Config strings, show classes... section
L["Show Classes..."] = "顯示職業"
L["SHOW_CLASSES_DESC"] = "Omen 將顯示以下職業的威脅.除非你點選「不在隊伍中」的選項,否則 Omen 將只顯示你隊伍中的玩家."
L["Show bars for these classes"] = "顯示的職業條"
L["DEATHKNIGHT"] = "死亡騎士"
L["DRUID"] = "德魯伊"
L["HUNTER"] = "獵人"
L["MAGE"] = "法師"
L["PALADIN"] = "聖騎士"
L["PET"] = "寵物"
L["PRIEST"] = "牧師"
L["ROGUE"] = "盜賊"
L["SHAMAN"] = "薩滿"
L["WARLOCK"] = "術士"
L["WARRIOR"] = "戰士"
L["*Not in Party*"] = "*不在隊伍中*"

-- Config strings, bar settings section
L["Bar Settings"] = "棒條設定"
L["Configure bar settings."] = "配置棒條設定."
L["Animate Bars"] = "動態棒條"
L["Smoothly animate bar changes"] = "平滑動態棒條"
L["Short Numbers"] = "簡化數字"
L["Display large numbers in Ks"] = "大數字時用千位(K)顯示"
L["Bar Texture"] = "棒條材質"
L["The texture that the bar will use"] = "棒條材質"
L["Bar Height"] = "棒條高度"
L["Height of each bar"] = "每個棒條的高度"
L["Bar Spacing"] = "棒條間距"
L["Spacing between each bar"] = "棒條之間的距離"
L["Show TPS"] = "顯示 TPS"
L["Show threat per second values"] = "顯示每秒威脅值"
L["TPS Window"] = "TPS 視窗"
L["TPS_WINDOW_DESC"] = "每秒威脅值的計算是根據最後X秒視窗內的變化而決定的."
L["Show Threat Values"] = "顯示威脅值"
L["Show Threat %"] = "顯示威脅值%"
L["Show Headings"] = "顯示標題"
L["Show column headings"] = "顯示主標題欄"
L["Heading BG Color"] = "主標題的背景顏色"
L["Heading background color"] = "主標題的背景顏色"
L["Use 'My Bar' color"] = "使用「My Bar」顏色"
L["Use a different colored background for your threat bar in Omen"] = "在 Omen 中為威脅棒條使用不同的背景顏色"
L["'My Bar' BG Color"] = "「My Bar」背景顏色"
L["The background color for your threat bar"] = "威脅棒條的背景顏色"
L["Use Tank Bar color"] = "使用坦克棒條顏色"
L["Use a different colored background for the tank's threat bar in Omen"] = "為 Omen 坦克威脅棒條使用不同背景顏色."
L["Tank Bar Color"] = "坦克棒條顏色"
L["The background color for your tank's threat bar"] = "坦克威脅棒條背景顏色"
L["Show Pull Aggro Bar"] = "顯示獲得仇恨棒條"
L["Show a bar for the amount of threat you will need to reach in order to pull aggro."] = "顯示獲得仇恨所需威脅數值的棒條."
L["Pull Aggro Bar Color"] = "獲得仇恨棒條顏色"
L["The background color for your Pull Aggro bar"] = "獲得仇恨棒條背景顏色"
L["Use Class Colors"] = "使用職業顏色"
L["Use standard class colors for the background color of threat bars"] = "使用標準職業顏色威脅棒條背景顏色"
L["Pet Bar Color"] = "寵物棒條顏色"
L["The background color for pets"] = "寵物棒條背景顏色"
L["Bar BG Color"] = "棒條背景顏色"
L["The background color for all threat bars"] = "所有威脅棒條背景顏色"
L["Always Show Self"] = "總是顯示自己"
L["Always show your threat bar on Omen (ignores class filter settings), showing your bar on the last row if necessary"] = "總是顯示你的 Omen 威脅棒條(忽略職業過濾設定),如需要顯示你的棒條位於最後一排."
L["Bar Label Options"] = "棒條標籤選項"
L["Font"] = "字體"
L["The font that the labels will use"] = "標籤字體"
L["Font Size"] = "字體大小"
L["Control the font size of the labels"] = "標籤字體大小"
L["Font Color"] = "字體顏色"
L["The color of the labels"] = "標籤顏色"
L["Font Outline"] = "字體輪廓"
L["The outline that the labels will use"] = "標籤輪廓"
L["None"] = "無"
L["Outline"] = "輪廓"
L["Thick Outline"] = "加倍輪廓"

-- Config strings, slash command section
L["OMEN_SLASH_DESC"] = "這些按鈕與斜槓命令有相同的效果(/omen)"
L["Toggle Omen"] = "開/關 Omen"
L["Center Omen"] = "中置Omen"
L["Configure"] = "設定"
L["Open the configuration dialog"] = "打開 Omen 配置視窗"

-- Config strings, warning settings section
L["Warning Settings"] = "警報設定"
L["OMEN_WARNINGS_DESC"] = "這裡可以調整 Omen 何時用何種方式給你提出仇恨警報."
L["Enable Sound"] = "開啟音效"
L["Causes Omen to play a chosen sound effect"] = "令 Omen 播放所選擇的音效"
L["Enable Screen Flash"] = "開啟螢幕閃動"
L["Causes the entire screen to flash red momentarily"] = "令整個螢幕閃動紅色"
L["Enable Screen Shake"] = "開啟螢幕震動"
L["Causes the entire game world to shake momentarily. This option only works if nameplates are turned off."] = "令整個遊戲螢幕震動.此選項只有在不啟用名牌時才可用."
L["Enable Warning Message"] = "開啟警報消息"
L["Print a message to screen when you accumulate too much threat"] = "當你仇恨過高時在螢幕上顯示警報消息"
L["Warning Threshold %"] = "警告臨界值(百分比)"
L["Sound to play"] = "播放音效"
L["Disable while tanking"] = "當為坦克時關閉警報"
L["DISABLE_WHILE_TANKING_DESC"] = "如果在防禦姿態,熊形態,正義之怒與冰霜系時,不顯示警報."
L["Test warnings"] = "測試警報"

-- Config strings, for Fubar
L["Click|r to toggle the Omen window"] = "點擊|r開/關 Omen 視窗"
L["Right-click|r to open the options menu"] = "右鍵|r打開選項選單"
L["FuBar Options"] = "FuBar 選項"
L["Attach to minimap"] = "依附到小地圖"
L["Hide minimap/FuBar icon"] = "隱藏小地圖/Fubar 小圖標"
L["Show icon"] = "顯示小圖標"
L["Show text"] = "顯示文字"
L["Position"] = "位置"
L["Left"] = "左邊"
L["Center"] = "中置"
L["Right"] = "右邊"

-- FAQ
L["Help File"] = "幫助文件"
L["A collection of help pages"] = "幫助頁匯集"
L["FAQ Part 1"] = "FAQ 第1部分"
L["FAQ Part 2"] = "FAQ 第2部分"
L["Frequently Asked Questions"] = "常見問題"
L["Warrior"] = "戰士"

L["GENERAL_FAQ"] = [[
|cffffd200Omen3 與 Omen2 的區別|r

Omen3 使用 Blizzard 所提供的仇恨應用程式界面,與 Omen2 不一樣,Omen3 不會去預測或者計算仇恨,仇恨值是通過應用程式界面直接向伺服器端獲取.

Omen2 使用 Threat-2.0 數據庫,這個數據庫是根據檢測的戰鬥記錄,法術,增益與減益,姿態和裝備來計算不同的仇恨值.仇恨的計算是根據現有的資料與檢測所得到的數據計算的.很多技能是假設值,無法驗證(如擊退,我們假設擊退仇恨降低50%).

Threat 2.0數據庫也包含了其他人都用這個數據庫的時候同步整個團隊的威脅值,這些威脅數據用來提供給整個團隊以供參考.

從 Patch 3.0.2 開始 Omen 將不再做這些動作,Threat 資料庫不再需要.Omen3 所使用 Blizzard 內建威脅監視器,並從中獲取威脅資料,這也造成 Omen 不再需要同步資料,檢測戰鬥記錄與猜測數據.效果因減少資料的傳送而提升,包括 CPU 與內存的使用量都會減少,針對特殊首領的威脅變化事件也不再需要.

更進一步說受益包括一些 NPC 對怪物的威脅,比如太陽之井高地人類形態的卡雷苟斯的威脅.但是也有一些不利的地方,威脅數據更新也變得慢了,團隊中如果沒有人的目標是那個 NPC 的話,他的威脅也無法得到,而你沒有直接參與的戰鬥你也無法獲得威脅(如你沒有造成任何傷害,或者製造任何威脅你將無法得到威脅值,就算你讓你的寵物上去攻擊而你沒有攻擊也一樣不能得到威脅值).

|cffffd200我如何去除中間2條灰色垂直線?|r

鎖定 Omen.鎖定 Omen 將防止它被移動或調整大小,以及防止欄被調整.如果你沒有注意到,那兩條灰色垂直線是用來調整欄的大小.

|cffffd200如何將 Omen3 的外觀改成與 Omen2 類似?|r

改變背景材質與邊框材質為 Blizzard Tooltip,將背景顏色改成黑色(通過拖動亮度條調節底部顏色),邊框顏色改為藍色.

|cffffd200為什麼就算我再戰鬥中也看不到任何威脅值?|r

除非你對怪物有作出任何傷害或者造成任何威脅,否則 Blizzard 仇恨應用程式界面不會給出任何威脅值,我們估計這可能是 Blizzard 為了減少網絡資料的傳送.

|cffffd200有沒有辦法解決 Blizzard 的這個的限制?攻擊之前無法看到我的寵物的威脅.|r

我們沒有辦法在短期內解決這個限制(正如 Omen2 沒有一樣).

Omen3 的目標是提供準確的威脅數據,我們不再打算推測你的數據並降低你的 FPS.你需信任你的寵物/坦克,或者攻擊之前等待2秒並用低傷害法術(如冰槍)攻擊,這樣可以讓你可以得到初步的威脅讀數.
]]
L["GENERAL_FAQ2"] = [[
|cffffd200我們能讓 AoE 模組回來嗎?|r

同樣,如不使用猜測威脅值的方式是不可能做得到的. Blizzard 的仇恨應用程式界面僅限我們查詢某人的威脅數據於團隊目標.這意味著假如20個怪物中只有6個被團隊選定,那麼就沒有辦法獲得其他14個怪物的威脅數據.

這也是極其複雜的猜測治療和增益效果(威脅值是跟據你在與怪物戰鬥的數量來攤分)因為怪物處於控制效果(變形術,放逐,悶棍)並沒有他們的仇恨列表並且插件不能準確的告知正在與多少個怪物戰鬥.Omen2 猜測的幾乎總是錯誤的.

|cffffd200鼠標懸停單位顯示了威脅百分比與 Omen3 的仇恨百分比報告並不一致,為什麼?|r

 Blizzard 的威脅比例調整為0%至100%,這樣你總是在100%是獲得仇恨.Omen 報告的沒有調整過,獲得仇恨百分比為110%,或混戰為130%.

普遍認為,怪物的主要目標被稱為坦克並被定義為獲得100%的威脅.

|cffffd200Omen3 有同步資料或者分析戰鬥資料麼?|r

Omen3 不需要同步資料或者分析戰鬥資料,現階段沒有任何必要去這樣做.

|cffffd200威脅資料更新太慢……|r

Omen3 威脅值更新速度與 Blizzard 提供威脅數據給我們的速度是一樣的.

事實上, Blizzard 每秒更新它們一次,這個速度大大超過了 Omen2 的同步頻率.在 Omen2,你只是每3秒(坦克每1.5秒)交換一次威脅數據.

|cffffd200我要去哪裡回報 Bug 或者提出建議?|r

http://forums.wowace.com/showthread.php?t=14249

|cffffd200誰製作了 Omen3?|r

Xinhuan (Blackrock US Alliance) 美服-黑石山-聯盟:Xinhuan.

|cffffd200是否接受 Paypal(貝寶)捐助?|r

是的,發送到xinhuan@gmail.com.
]]
L["WARRIOR_FAQ"] = [[以下數據來自|cffffd200http://www.tankspot.com/forums/f200/39775-wow-3-0-threat-values.html|r2008年10月2號(Satrina 的功勞).等級80採集的數據.

|cffffd200狀態|r
戰鬥姿態 ________ x 80
狂暴姿態 _____ x 80
戰術掌握 _____ x 121/142/163
防禦姿態 _____ x 207.35

請注意,在我們原來估計的威脅(使用魔獸世界2.0),我們把1傷害等同1威脅,並因姿態和挑釁乘以1.495.我們看到 Blizzard 的做法未乘以小數點後面的數字,所以在2.x中,將已經x149(或者x149.5)；這是x207(或者207.3)在3.0版本.我想這是允許的傳輸整數值不是小數值在網際網路上的效率.看來,威脅值乘以207.35在伺服器上,然後四捨五入.

如果您仍希望使用1傷害=1威脅的方法,姿態為是0.8和2.0735,等等.

|cffffd200威脅值(姿態適用,除非另有說明):|r
戰鬥怒吼 _________ 78 (split)
順劈斬 _______________ damage + 225 (split)
命令怒吼 _____ 80 (split)
震盪猛擊 ______ damage only
傷害反射護盾 ________ damage only
挫志怒吼 ___ 63 (split)
毀滅打擊 ____________ damage + 5% of AP *** Needs re-checking for 8982 **
躲閃/招架/格擋_____ 1 (in defensive stance with Improved Defensive Stance only)
英勇打擊 ________ damage + 259
英勇投擲 _________ 1.50 x damage
怒氣獲得 ____________ 5 (stance modifier is not applied)
撕裂 _________________ damage only
復仇 ______________ damage + 121
盾擊 __________ 36
盾牌猛擊 __________ damage + 770
震盪波 ____________ damage only
猛擊 _________________ damage + 140
法術反射 ________ damage only (only for spells aimed at you)
社會仇恨 _________ 0
破甲攻擊 ________ 345 + 5%AP
雷霆一擊 _________ 1.85 x damage
警戒 ____________ 10% of target's generated threat (stance modifier is not applied)

如果你通過加強反彈魔法天賦幫助隊友反彈魔法,你不會獲得任何仇恨值,相對如果你通過此天賦幫助隊友反彈魔法,這個仇恨值將計算在隊友身上.
]]

