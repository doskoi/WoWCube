-----------------------
-- Saved Configuration
-----------------------
MyBankProfile = {}
MYBANK_VERSION           =  "2.0.12.2";

local PlayerName = nil; -- Logged in player name
local bankPlayer     = nil; -- viewing player pointer
local bankPlayerName = nil; -- Viewing player name

------------------------
-- Saved Function Calls
------------------------
local BankFrame_Saved = nil;
local PurchaseSlot_Saved = nil;
-----------------------
-- Local Configuration
-----------------------
local MyBank_Loaded = nil;
local AtBank = false;

MYBANK_MAX_ID              = 224; -- 8 * 28 slot bags, 28 Bankslots
MYBANK_COLUMNS_MIN         =   8; -- 7 Bags, so it has to be at least 8 wide :)	
MYBANK_COLUMNS_MAX         =  20; -- Same as MI
MYBANK_BASE_HEIGHT         = 153; -- Height of Borders + Title + Bottom
MYBANK_ROW_HEIGHT          =  40; -- One Row
MYBANK_BASE_WIDTH          =  12; -- Width of the borders
MYBANK_COL_WIDTH           =  39; -- One Column
MYBANK_FIRST_ITEM_OFFSET_X =   7; -- Leave room for the border
MYBANK_FIRST_ITEM_OFFSET_Y = -28 - 39; -- Leave room for the title.
MYBANK_ITEM_OFFSET_X       =  39; -- Each is 39 apart
MYBANK_ITEM_OFFSET_Y       = -39; -- Each is 39 apart

MyBankDEBUG                = 0;
-- Not Saved between Sessions
MyBankAllRealms				= 0;
-- Saved Between Sessions
MyBankReplaceBank          = 1;
MyBankColumns              = 12;
MyBankFreeze					= 0;
MyBankHighlightItems			= 1;
MyBankHighlightBags			= 1;
MyBankBagView              = 1;
MyBankGraphics             = 1;
MyBankBackground           = 1;
MyBankShowPlayers          = 1;
MyBankScale                = 1;

--InitializeProfile: Initializes a players profile {{{
--  If Player's profile is not found, it makes a new one from defaults
--  If Player's profile is found, it loads the values from MyBankProfile
function MyBank_InitializeProfile()
	if ( UnitName("player") ) then
		PlayerName = UnitName('player').."|"..MyBank_Trim(GetCVar("realmName"));
		MyBank_LoadSettings();

		MyBank_DEBUG("MyBank: Profile for "..PlayerName.." Initilized.");
		MyBankFrame_PopulateFrame();
		-- TODO: why is this here?
		-- MyBank_UpdateBagCost(MyBankProfile[PlayerName].Bags);
	end
end

function MyBank_LoadSettings()
	if ( MyBankProfile[PlayerName] == nil ) then
		MyBankProfile[PlayerName] = {};
		--MyBank_Print("Mybank:Creating new Profile for "..PlayerName);
	end
	MyBankReplaceBank    = MyBank_SavedOrDefault("ReplaceBank");
	MyBankColumns        = MyBank_SavedOrDefault("Columns");
	MyBankFreeze         = MyBank_SavedOrDefault("Freeze");
	MyBankHighlightItems = MyBank_SavedOrDefault("HighlightItems");
	MyBankHighlightBags  = MyBank_SavedOrDefault("HighlightBags");
	MyBankBagView        = MyBank_SavedOrDefault("BagView");
	MyBankGraphics       = MyBank_SavedOrDefault("Graphics");
	MyBankBackground     = MyBank_SavedOrDefault("Background");
	MyBankShowPlayers    = MyBank_SavedOrDefault("ShowPlayers");
	MyBankScale          = MyBank_SavedOrDefault("Scale");
	
	MyBank_SetGraphics();
	MyBank_SetReplaceBank();
	MyBank_SetFreeze();
end
function MyBank_SavedOrDefault(varname)
	if PlayerName == nil or varname == nil then
		MyBank_DEBUG("ERR: nil value");
		return nil;
	end
	if MyBankProfile[PlayerName][varname] == nil then -- Setting not set
		MyBankProfile[PlayerName][varname] = getglobal("MyBank"..varname); -- Load Default
	end
	return MyBankProfile[PlayerName][varname];  -- Return Setting.
end
-- END  Initialization }}}
function MyBank_GetPlayer(playerName)
	if ( not MyBankProfile[playerName] ) then
		MyBank_InitializeProfile();
	end
	bankPlayerName = playerName;
	UIDropDownMenu_SetSelectedValue(MyBankDropDown, bankPlayerName);
	return MyBankProfile[playerName];
end

function MyBank_GetBag(bagIndex)
	local curBag
	if bagIndex == BANK_CONTAINER then
		curBag = bankPlayer["Bank"];
	else
		curBag = bankPlayer["Bag"..bagIndex];
	end
	return curBag;
end

function MyBank_GetBagsTotalSlots()
	local slots = 28;
	if bankPlayer == nil then
		return slots;
	end 
	for bag = 5, 11 do
		local curBag = bankPlayer["Bag"..bag];
		if (curBag ~= nil) then
			if curBag["s"] ~=nil then
				slots = slots + curBag["s"];
			end
		end
	end
	return slots;
end

-- == Event Handling == 
-- OnLoad {{{
function MyBankFrame_OnLoad()
	MyBank_Register(); -- Slash Commands
	--MyBank_Print(MYBANK_LOADED);
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("ITEM_LOCK_CHANGED");
	this:RegisterEvent("UPDATE_INVENTORY_ALERTS");
	this:RegisterEvent("BANKFRAME_OPENED");
	this:RegisterEvent("BANKFRAME_CLOSED");
	this:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
	this:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED");
	this:RegisterEvent("PLAYER_MONEY");
	tinsert(UISpecialFrames, "MyBankFrame"); -- Esc Closes MyBank
end

function MyBank_Register()
	SlashCmdList["MYBANKSLASHMAIN"] = MyBank_ChatCommandHandler;
	SLASH_MYBANKSLASHMAIN1 = "/mybank";
	SLASH_MYBANKSLASHMAIN2 = "/mb";
end
-- End Load }}}
-- Confirm Dialog for buying bag slot {{{
function MyBank_RegisterConfirm() 
	PurchaseSlot_Saved = PurchaseSlot;
	PurchaseSlot = MyBank_PurchaseSlot;
	StaticPopupDialogs["PURCHASE_BANKBAG"] = {
		text = TEXT(MYBANK_PURCHASE_CONFIRM_S),
		button1 = TEXT(ACCEPT),
		button2 = TEXT(CANCEL),
		OnAccept = function()
			PurchaseSlot_Saved();
		end,
		showAlert = 1,
		timeout = 0,
	};
end

function MyBank_PurchaseSlot()
	if not StaticPopupDialogs["PURCHASE_BANKBAG"] then
		return;
	end
	local cost = GetBankSlotCost();
	if cost < 10000 then
		StaticPopupDialogs["PURCHASE_BANKBAG"]["text"] = format(MYBANK_PURCHASE_CONFIRM_S,(cost/100)); 
	else
		StaticPopupDialogs["PURCHASE_BANKBAG"]["text"] = format(MYBANK_PURCHASE_CONFIRM_G,(cost/10000)); 
	end
	StaticPopup_Show("PURCHASE_BANKBAG");
end
-- End buy bag slot config }}}
-- Register with MyAddons
function MyBank_MyAddonsRegister()
	if (myAddOnsFrame) then
		myAddOnsList.MyBank = {
			name = MYBANK_MYADDON_NAME,
			description = MYBANK_MYADDON_DESCRIPTION,
			version = MYBANK_VERSION,
			category = MYADDONS_CATEGORY_INVENTORY,
			frame = "MyBankFrame",
			optionsframe = "MyBankConfigFrame"
		};
	end
end

function MyBankFrame_OnEvent(event)
	if ( event == "ADDON_LOADED" and arg1 == "MyInventory" ) then
		MyBank_Loaded = 1;
		MyBank_MyAddonsRegister();
		--	MyBank_InitializeProfile();
		if not BankBuyFrame then
			MyBank_RegisterConfirm();
		end
	end
	if (not MyBank_Loaded) then
		return;
	end
	
	if ( event == "UNIT_NAME_UPDATE" and arg1 == "player" and UnitName("player") ~= UNKNOWNOBJECT and bankPlayer == nil ) then
		MyBank_DEBUG("MyBank: UNIT_NAME_UPDATE event");
		PlayerName = UnitName("player").."|"..MyBank_Trim(GetCVar("realmName"));
		bankPlayer = MyBank_GetPlayer(PlayerName);
	elseif ( event == "PLAYER_ENTERING_WORLD") then
		MyBank_DEBUG("MyBank: PLAYER_ENTERING_WORLD event");
	  if (PlayerName == nil) then
	  	PlayerName = UnitName("player").."|"..MyBank_Trim(GetCVar("realmName"));
	  	bankPlayer = MyBank_GetPlayer(PlayerName);
	  end
		MyBank_InitializeProfile();
		MyBank_SaveMoney();
	elseif ( event == "BAG_UPDATE" ) then
		MyBank_DEBUG("MyBank: BAG_UPDATE event");
		if AtBank and arg1 >=5 and arg1 <=11 then
			MyBankFrame_SaveItems();
		end
	elseif (event == "PLAYERBANKSLOTS_CHANGED" or event=="PLAYERBANKBAGSLOTS_CHANGED") then
		MyBankFrame_SaveItems();
	elseif ( event == "ITEM_LOCK_CHANGED" or  event == "UPDATE_INVENTORY_ALERTS" ) then
		if ( AtBank ) then
			MyBankFrame_PopulateFrame();
		end
	end
	if (event == "BANKFRAME_OPENED") then
		AtBank = true;
		SetPortraitTexture(MyBankFramePortrait, "npc");
		MyBankFrameAtBankText:Show();
		OpenBackpack(); -- Open Backpack at Bank
		bankPlayer = MyBank_GetPlayer(PlayerName);
		MyBankFrame_SaveItems();
		MyBankFramePurchaseButton:Enable();
		if MyBankReplaceBank == 1 then
			OpenMyBankFrame();
		end
	elseif (event == "BANKFRAME_CLOSED") then
		AtBank = false;
		MyBankFramePortrait:SetTexture("Interface\\Addons\\MyBank\\Skin\\MyBankPortait");
		MyBankFrameAtBankText:Hide();
		MyBankFramePurchaseButton:Disable();
		CloseBackpack(); -- Close Backpack when leaving
	 	if MyBankReplaceBank == 1 then
			if MyBankFreeze == 0 then
				CloseMyBankFrame();
			end
		end
		if StackSplitFrame:IsVisible() then
			StackSplitFrame:Hide();
		end
	elseif (event == "PLAYER_MONEY" ) then
		MyBank_SaveMoney();
		return;
	end
end

function MyBank_HighlightBag(bagID, bagName, isItem)
	if MyBankHighlightBags == 0 and isItem then 
		return;
	end
	if MyBankHighlightItems == 0 and (not isItem) then
		return;
	end
	if isItem then
		if bagID > -1 then
			getglobal("MyBankFrameBag"..bagID):LockHighlight();
		end
	end
	if(bankPlayer[bagName])then
		local i, found;
		for i=1, MYBANK_MAX_ID do
			local itemButton = getglobal("MyBankFrameItem"..i);
			if not itemButton:IsVisible() then
				break;
			end
			if itemButton.bagIndex == bagID then
				found = true;
				itemButton:LockHighlight();
			else
				if found then
					break;
				end
			end
		end
	end
end

function MyBank_GetCooldown(item)
	if item["d"] then
		local cooldownInfo = item["d"];
		local CoolDownRemaining;
		if cooldownInfo and cooldownInfo["d"] and cooldownInfo["s"] then
			CoolDownRemaining = cooldownInfo["d"] - (GetTime() - cooldownInfo["s"]);
		else
			CoolDownRemaining = 0;
		end
		if CoolDownRemaining <= 0 then
			item["d"] = nil;
		else
			return cooldownInfo;
		end
	end
	return nil;
end

function MyBank_GetCooldownString(cooldownInfo)
	local CoolDownRemaining = cooldownInfo["d"] - (GetTime() - cooldownInfo["s"]);
	-- 60 secs in a min
	-- 3600 secs in an hour
	-- 86400 secs in a day
	local days, hours, minutes, seconds;
	days = math.floor(CoolDownRemaining / 86400);
	CoolDownRemaining = CoolDownRemaining - 86400 * days;
	hours = math.floor(CoolDownRemaining / 3600);
	CoolDownRemaining = CoolDownRemaining - 3600 * hours;
	minutes = math.floor(CoolDownRemaining / 60);
	seconds = math.floor(CoolDownRemaining - 60 * minutes);
	if days > 0 then
		return format(ITEM_COOLDOWN_TIME_DAYS_P1, days+1);
	elseif hours > 0 then
		return format(ITEM_COOLDOWN_TIME_HOURS_P1, hours+1);
	elseif minutes > 0 then
		return format(ITEM_COOLDOWN_TIME_MIN, minutes+1);
	else
		return format(ITEM_COOLDOWN_TIME_SEC, seconds);
	end
end

function MyBank_MakeLink(item)
	if item and item["l"] then
		local _, _, _, name = strfind(item["l"],"|H(item:(%d+):.+|h%[(.-)%]|h|r");
		item["name"] = name;
		item["l"] = nil;
	end
	if item and item["name"] then
		local myHyperlink;
		if ItemsMatrix_GetHyperlink then
			myHyperlink = ItemsMatrix_GetHyperlink(item["name"]);
		elseif LootLink_GetHyperlink then
			myHyperlink = LootLink_GetHyperlink(item["name"]);
		else
			myHyperlink = MyBank_GetHyperlink(item);
		end

		if myHyperlink then
			GameTooltip:Hide();
			GameTooltip:SetOwner(this,"ANCHOR_RIGHT");
			GameTooltip:SetHyperlink(myHyperlink);
			if item["sb"] then
				GameTooltipTextLeft2:SetText(ITEM_SOULBOUND);
			end
			if item["m"] then
				GameTooltip:AddLine(format(ITEM_CREATED_BY, item["m"]));
			end
			local cooldownInfo = item["d"];

			if cooldownInfo and cooldownInfo ~= 1 and cooldownInfo["e"] and cooldownInfo["e"] > 0 and cooldownInfo["d"] > 0 then
				CoolDownString = MyBank_GetCooldownString(cooldownInfo);
				GameTooltip:AddLine(CoolDownString, 1.0, 1.0, 1.0);
			end
			GameTooltip:Show();
		end
	end
end

function MyBankFrame_Button_OnEnter()
	--show tooltip
	local myLink, MadeBy, Soulbound, count;
	local bagName= strsub(this:GetName(), 12, 16);
	local curBag;
	local cooldownInfo;
	if AtBank then
		local hasCooldown, repairCost;
		GameTooltip:SetOwner(this,"ANCHOR_RIGHT");
		if (this.isBag) then
			MyBank_HighlightBag(this:GetID(), bagName);
			local inventoryID = BankButtonIDToInvSlotID(this:GetID(), 1);
			hasCooldown, repairCost = GameTooltip:SetInventoryItem("player", inventoryID);
		else
			MyBank_HighlightBag(this.bagIndex, bagName, 1);
			if this.bagIndex < 0 then
				local newIndex = BankButtonIDToInvSlotID(this.itemIndex); 
				hasCooldown, repairCost = GameTooltip:SetInventoryItem("player", newIndex);				
			else
				hasCooldown, repairCost = GameTooltip:SetBagItem(this.bagIndex, this.itemIndex);
			end
		end

	else
		if LootLink_AutoInfoOff then
			LootLink_AutoInfoOff();
		end
		if (this.isBag) then
			MyBank_MakeLink(bankPlayer[bagName]);
			MyBank_HighlightBag(this:GetID(), bagName);
		else
			MyBank_HighlightBag(this.bagIndex, bagName, 1);
			curBag = MyBank_GetBag(this.bagIndex);
			if curBag and curBag[this.itemIndex] then
				MyBank_MakeLink(curBag[this.itemIndex]);
			end

		end
		if LootLink_AutoInfoOn then
			LootLink_AutoInfoOn();
		end
	end
end
function MyBankFrame_Button_OnLeave()
	if this.isBag then
		local bagName= strsub(this:GetName(), 12, 16);
		local i, found;
		for i=1, MYBANK_MAX_ID do
			local itemButton = getglobal("MyBankFrameItem"..i);
			if itemButton.bagIndex == this:GetID() then
				found = true;
				itemButton:UnlockHighlight();
			else
				if found then
					break;
				end
			end
		end
	else
		if this.bagIndex > -1 then
			getglobal("MyBankFrameBag"..(this.bagIndex)):UnlockHighlight();
		end

	end
	GameTooltip:Hide();
end

function MyBankFrame_UpdateCooldown(button)
	if (not button.bagIndex) or (not button.itemIndex) then
		return;
	end
  local cooldown = getglobal(button:GetName().."Cooldown");
  local start, duration, enable = GetContainerItemCooldown(button.bagIndex, button.itemIndex);
  CooldownFrame_SetTimer(cooldown, start, duration, enable);
  if ( duration > 0 and enable == 0 ) then
    SetItemButtonTextureVertexColor(button, 0.4, 0.4, 0.4);
  end
end

function MyBankFrame_OnHide()
	if AtBank then
		CloseBankFrame();
	end
	PlaySound("igBackPackClose");
end

function MyBankFrame_OnShow()
	if AtBank then
		MyBankFramePurchaseButton:Enable();
	else
		MyBankFramePurchaseButton:Disable();
	end
	MyBank_UpdateTotalMoney();
	MyBankFrame_UpdateLookIfNeeded();
	PlaySound("igBackPackOpen");
end

function MyBankFrameItemButton_OnLoad()
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	this:RegisterForDrag("LeftButton");

	this.SplitStack = function(button, split)
		SplitContainerItem(button:GetParent():GetID(), button:GetID(), split);
	end
end

function MyBankFrameItemButton_OnClick(button, ignoreShift)
	local myLink;
	local item = MyBank_GetBag(this.bagIndex)[this.itemIndex];
	if (button == "LeftButton" ) then
		if (IsShiftKeyDown() and (not ignoreShift)) then
			if ChatFrameEditBox:IsVisible() then
				-- Insert Link
				if ItemsMatrix_GetLink then
					myLink = ItemsMatrix_GetLink(item["name"]);
				elseif LootLink_GetLink then
					myLink = LootLink_GetLink(item["name"]);
				else
					myLink = MyBank_GetLink(item);
				end
				if myLink then
					ChatFrameEditBox:Insert(myLink);
				end
			else
				if AtBank then
					--Shift key down, left mouse button
					local texture, itemCount, locked = GetContainerItemInfo(this.bagIndex, this.itemIndex);
					if ( not locked ) then
						this.SplitStack = function(button, split)
							SplitContainerItem(button.bagIndex, button.itemIndex, split);
						end
						OpenStackSplitFrame(this.count, this, "BOTTOMRIGHT", "TOPRIGHT");
					end
				end
			end
		else
			-- no shift, left mouse button
			if AtBank==true then
				PickupContainerItem(this.bagIndex, this.itemIndex);
			end
		end
	elseif (button == "RightButton") then
		if AtBank==true then
			UseContainerItem(this.bagIndex, this.itemIndex);
		end
	end
end
			  
function MyBankFrameItemButtonBag_OnShiftClick(button, ignoreShift) 
	local bankBag = getglobal("BankFrameBag"..(tonumber(strsub(this:GetName(), 15, 17))-4));
	local inventoryID = BankButtonIDToInvSlotID(bankBag:GetID(), 1);
	if ( ChatFrameEditBox:IsVisible() ) then
		local bagName= strsub(this:GetName(), 12, 16);
		local myLink;
		
		if ItemsMatrix_GetLink then
			myLink = ItemsMatrix_GetLink(bankPlayer[bagName]["name"]);
		elseif LootLink_GetLink then
			myLink = LootLink_GetLink(bankPlayer[bagName]["name"]);
		else
			myLink = MyBank_GetLink(bankPlayer[bagName]);
		end
		if myLink then
			ChatFrameEditBox:Insert(myLink);
		end
	else
		 -- Shift key, no chat box
		if AtBank then
			PickupBagFromSlot(inventoryID);
			PlaySound("BAGMENUBUTTONPRESS");
		end
	end
end
function MyBankFrameItemButtonBag_OnClick(button, ignoreShift) 
	MyBank_DEBUG(this:GetName());	
	local bankBag = getglobal("BankFrameBag"..(tonumber(strsub(this:GetName(), 15, 17))-4));
	local inventoryID = BankButtonIDToInvSlotID(bankBag:GetID(), 1);
	MyBank_DEBUG(bankBag:GetName().." "..inventoryID);	
		 -- No ShiftKey
	if AtBank then
		local hadItem = PutItemInBag(inventoryID);
		local id = this:GetID();
	end
end
-- == End Event Handling == 

function MyBankFrame_SetColumns(col)
	if ( type(col) ~= "number" ) then
		col = tonumber(col);
	end
	if ( col == nil ) then
		MyBank_DEBUG("Cols Error");
	else
		if ( ( col >= MYBANK_COLUMNS_MIN ) and ( col <= MYBANK_COLUMNS_MAX ) ) then
			MyBankColumns = col;
			bankPlayer.Columns = MyBankColumns;
			MyBankFrame_UpdateLook(getglobal("MyBankFrame"), MyBank_GetBagsTotalSlots());
		end
	end
end

function MyBankFrame_GetAppropriateHeight(rows)
	local height = MYBANK_BASE_HEIGHT + ( MYBANK_ROW_HEIGHT * (MyBankBagView - 1 + rows ));
	if MyBankShowPlayers == 0 and MyBankGraphics == 0 then
		height = height - MYBANK_ROW_HEIGHT;
	end
	return height;
end

function MyBankFrame_GetAppropriateWidth(cols)
	return MYBANK_BASE_WIDTH + ( MYBANK_COL_WIDTH * cols );
end

function MyBankTitle_Update()
	local i, j, totalSlots, takenSlots = 0, 0, 0, 0;
	totalSlots = MyBank_GetBagsTotalSlots();
	-- Need to calculate Free slots.
	if bankPlayer and bankPlayer["Bank"] then
		for i = 1, 28 do
			if bankPlayer["Bank"][i] then
				takenSlots = takenSlots + 1;
			end
		end
		for i = 5, 11 do
			if bankPlayer["Bag"..i] and bankPlayer["Bag"..i]["s"] then
				for j = 1, bankPlayer["Bag"..i]["s"] do
					if bankPlayer["Bag"..i][j] then
						takenSlots = takenSlots + 1;
					end
				end
			end
		end
	end

	if ( bankPlayerName ) then
		local playername = MyBank_Split(bankPlayerName, "|");
		if ( MyBankColumns >= 9 ) then
			MyBankFrameName:SetText(format(MYBANK_FRAME_PLAYERANDREGION, playername[1], playername[2]));
		else
			MyBankFrameName:SetText(format(MYBANK_FRAME_PLAYERONLY, playername[1]));
		end
		MyBankFrameName:SetTextColor(1.0, 1.0, 1.0);
	end
	MyBankFrameSlots:SetText(format(MYBANK_FRAME_SLOTS, (totalSlots-takenSlots), (totalSlots)));
end

function MyBank_UpdateTotalMoney()
	local totalMoney = 0;
	for key, value in pairs(MyBankProfile) do
		local thisRealmPlayers = MyBank_Split(key, "|")[2];
		if MyBankAllRealms == 1 or thisRealmPlayers == MyBank_Trim(GetCVar("realmName")) then
			if ( MyBankProfile[key].money ) then
				totalMoney = totalMoney + MyBankProfile[key].money;
			end
		end
	end
	if MyBankColumns < 8 then
		totalMoney = math.floor(totalMoney / 10000) * 10000;
	end
	MoneyFrame_Update("MyBank_MoneyFrameTotal", totalMoney);
end

function MyBank_UpdateBagCost(bags) 
	if not bags then
		bags=0;
	end
	if bags < 7 then
		MyBankFramePurchaseInfo:Show();
		local cost = MyBank_GetBankSlotCost(bags);
		MoneyFrame_Update("MyBankFrameDetailMoneyFrame", cost);
		if ( bankPlayer and bankPlayer["money"] and bankPlayer["money"] >= cost ) then
			SetMoneyFrameColor("MyBankFrameDetailMoneyFrame", 1.0, 1.0, 1.0);
		else
			SetMoneyFrameColor("MyBankFrameDetailMoneyFrame", 1.0, 0.1, 0.1)
		end
	else
		-- Hide frame
		MyBankFramePurchaseInfo:Hide();
	end
end

function MyBankFrame_UpdateLookIfNeeded()
	local slots = MyBank_GetBagsTotalSlots();
	if ( ( not MyBankFrame.size ) or ( slots ~= MyBankFrame.size ) ) then
		MyBankFrame_UpdateLook(getglobal("MyBankFrame"), slots);
	end
end

function MyBankFrame_UpdateLook(frame, frameSize)
	frame.size = frameSize;
	local name = frame:GetName();
	local columns = MyBankColumns;
	
	local rows = ceil(frame.size / columns);
	local height = MyBankFrame_GetAppropriateHeight(rows);
	frame:SetHeight(height);
	
	local width = MyBankFrame_GetAppropriateWidth(columns);
	frame:SetWidth(width);
	
	MyBankTitle_Update();	
	if MyBankShowPlayers ==1 then
		MyBankDropDown:Show();
		MyBank_AllRealms_Check:Show();
		--MYINVENTORY_BASE_HEIGHT = MYINVENTORY_BASE_HEIGHT - MYINVENTORY_ITEM_OFFSET_Y;
	else
		MyBankDropDown:Hide();
		MyBank_AllRealms_Check:Hide();
	end
	for j=5,11 do
		local bagButton=getglobal("MyBankFrameBag"..j);
		bagButton:ClearAllPoints();
		if j == 5 then
			bagButton:SetPoint("TOPLEFT", "MyBankBagButtonsBar", "TOPLEFT", 0, 0);
		else
			bagButton:SetPoint("TOPLEFT", "MyBankFrameBag"..(j-1), "TOPLEFT", MYBANK_ITEM_OFFSET_X, 0);
		end
		bagButton:Show();
	end
	local First_Y;
		First_Y = MYBANK_FIRST_ITEM_OFFSET_Y;
	if MyBankBagView == 1 then
		First_Y = MYBANK_FIRST_ITEM_OFFSET_Y + MYBANK_ITEM_OFFSET_Y;
		MyBankBagButtonsBar:Show();
	else
		First_Y = MYBANK_FIRST_ITEM_OFFSET_Y;
		MyBankBagButtonsBar:Hide();
	end
	if (MyBankShowPlayers == 0 and MyBankGraphics == 0 ) then
		MyBank_DEBUG("move up");
		First_Y = First_Y - MYBANK_ITEM_OFFSET_Y;
		MyBankBagButtonsBar:ClearAllPoints();
		MyBankBagButtonsBar:SetPoint("TOP", "MyBankFrame", "TOP", 0, -28);
	else
		MyBankBagButtonsBar:ClearAllPoints();
		MyBankBagButtonsBar:SetPoint("TOP", "MyBankFrame", "TOP", 0, -28-39);
		
	end
	for j=1, frame.size, 1 do
		local itemButton = getglobal(name.."Item"..j);
		MyBank_DEBUG("Name "..name.."Item"..j);	
		-- Set first button
		itemButton:ClearAllPoints();
		if ( j == 1 ) then
			itemButton:SetPoint("TOPLEFT", name, "TOPLEFT", MYBANK_FIRST_ITEM_OFFSET_X, First_Y);
		else
			if ( mod((j-1), columns) == 0 ) then
				itemButton:SetPoint("TOPLEFT", name.."Item"..(j - columns), "TOPLEFT", 0, MYBANK_ITEM_OFFSET_Y);  
			else
				itemButton:SetPoint("TOPLEFT", name.."Item"..(j - 1), "TOPLEFT", MYBANK_ITEM_OFFSET_X, 0);  
			end
		end
		
		itemButton.readable = readable;
		itemButton:Show();
	end
	local button = nil;
	for i = frame.size+1, MYBANK_MAX_ID do
		button = getglobal("MyBankFrameItem"..i);
		if ( button ) then
			button:Hide();
		end
	end
	MyBankFrame_PopulateFrame();
end


function MyBank_GetTooltipData()
	local soulbound = nil;
	local madeBy = nil;
	local field;
	local left, right;

	for index = 1, MyBankHiddenTooltip:NumLines() do
		field = getglobal("MyBankHiddenTooltipTextLeft"..index);
		if( field and field:IsVisible() ) then
			left = field:GetText();
		else
			left = "";
		end
		field = getglobal("MyBankHiddenTooltipTextRight"..index);
		if( field and field:IsVisible() ) then
			right = field:GetText();
		else
			right = "";
		end
		if ( string.find(left, ITEM_SOULBOUND) ) then
			soulbound = 1;
		end
		local iStart, iEnd, val1 = string.find(left, "<Made by (.+)>");
		if (val1) then
			madeBy = val1;
		end
	end
	return soulbound, madeBy;
end
function MyBankFrame_SaveBagInfo(currPlayer, bagIndex, bagName)
	if bagName=="Bank" then
		return 28;
	end
	local bagNum_Slots = GetContainerNumSlots(bagIndex);
	local bagNum_ID    = BankButtonIDToInvSlotID(bagIndex, 1);
	local itemLink     = GetInventoryItemLink("player", bagNum_ID);
	local texture      = GetInventoryItemTexture("player", bagNum_ID);
	local hasCooldown, repairCost = MyBankHiddenTooltip:SetInventoryItem("player", bagNum_ID);
	local soulbound, madeBy = MyBank_GetTooltipData();
	if (itemLink) then
		currPlayer[bagName]= {};
		MyBank_SaveItemData(currPlayer[bagName], itemLink, strsub(texture,17), bagNum_Slots, _ , soulbound, madeBy, _); 
		return bagNum_Slots;
	else
		currPlayer[bagName] = nil;
		return 0;
	end
end
function MyBankSaveBagItem(currPlayer, bagNewIndex, itemIndex, bagName)
	local itemLink = GetContainerItemLink(bagNewIndex, itemIndex);
	local texture, itemCount = GetContainerItemInfo(bagNewIndex, itemIndex);
	local hasCooldown, repairCost;
	if bagNewIndex == BANK_CONTAINER then
		local newIndex = 39 + itemIndex; 
		hasCooldown, repairCost = MyBankHiddenTooltip:SetInventoryItem("player", newIndex);
	else
		hasCooldown, repairCost = MyBankHiddenTooltip:SetBagItem(bagNewIndex, itemIndex);
	end
	local start, duration, enable = GetContainerItemCooldown(bagNewIndex, itemIndex);
	local soulbound, madeBy = MyBank_GetTooltipData();
	local cooldown;
	if hasCooldown and enable > 0 then
		cooldown = {
			["s"] = start,
			["d"] = duration,
			["e"] = enable
		};
	end
	if (itemLink) then
		currPlayer[bagName][itemIndex] = {};
		MyBank_SaveItemData(currPlayer[bagName][itemIndex], itemLink, strsub(texture,17), _, itemCount, soulbound, madeBy, cooldown); 
	else
		currPlayer[bagName][itemIndex] = nil;
	end
end

function MyBank_SaveItemData(MBItem, itemLink, texture, Slots, Count, soulbound, madeBy, Cooldown)
	local _, _, myColor, myLink, name = strfind(itemLink, "|c(%x+)|Hitem:(%d+:.+)|h%[(.-)%]|h|r");

--	local itemString = gsub(itemLink, "\124", "\124\124" );
--	MyBank_DEBUG("itemString:"..myLink)

	MBItem["name"] = name;
	MBItem["i"] = texture;
	MBItem["s"] = Slots;
	MBItem["c"] = Count;
	MBItem["itemlink"] = itemLink;
	if (ItemsMatrix_GetLink or LootLink_GetLink) then
		MBItem["color"] = nil;
		MBItem["item"] = nil;
	else
		MBItem["color"] = myColor;
		MBItem["item"] = myLink;
	end
	MBItem["sb"] = soulbound;
	MBItem["m"] = madeBy;
	MBItem["d"] = Cooldown;
	--MyBank_DEBUG("MyBank: MyBank_SaveItemData for "..name..", "..itemLink.." saved.");
end

function MyBank_SaveMoney()
	if ( PlayerName ) then
		if ( MyBankProfile[PlayerName] ) then
			MyBankProfile[PlayerName]["money"] = GetMoney();
		end
		if ( MyBank_MoneyFrame:IsVisible() ) then
			MoneyFrame_Update("MyBank_MoneyFrame", bankPlayer.money);
			MyBank_UpdateTotalMoney();
		end
	end
end

function MyBankFrame_SaveItems()
	local currPlayer=MyBankProfile[PlayerName];
	if currPlayer == nil then
		return;
	end
	if not AtBank then
		return;
	end
	MyBank_DEBUG("SaveItems");
	-- rewrite above...
	currPlayer.Bags, _ = GetNumBankSlots();
	local bagName, bagMaxIndex, bagNewIndex;
	for bagNum = 0, currPlayer.Bags do
		if bagNum == 0 then -- Is it the bank?
			bagName = "Bank";
			bagNewIndex = BANK_CONTAINER;
		else	-- It's in a bag slot
			bagName = "Bag"..(4+bagNum);
			bagNewIndex = (4+bagNum);
		end
		if (not currPlayer[bagName]) then
			MyBank_DEBUG("Clearing "..bagName);
			currPlayer[bagName] = {} ;
		end
		-- rewrite above
		bagMaxIndex = MyBankFrame_SaveBagInfo(currPlayer, bagNewIndex, bagName);
		for itemIndex = 1, bagMaxIndex do
			MyBankSaveBagItem(currPlayer, bagNewIndex, itemIndex, bagName);
		end
	end
	for bagNum = 5+currPlayer.Bags, 11 do
		currPlayer["Bag"..bagNum] = nil;
	end

	MyBank_SaveMoney();
	MyBankFrame_PopulateFrame();
end


function MyBankFrame_PopulateFrame()
	local texture, itemButton, itemCount;
	local bagName, bagMaxIndex, bagNewIndex;
	local buttonIndex = 1;
	local BlankTexture;
	local maxBags;
	if not bankPlayer then 
		return;
	end
	if bankPlayer.Bags then
		maxBags = bankPlayer.Bags;
	else
		maxBags = 0;
	end
	MyBank_UpdateBagCost(maxBags);
	_, BlankTexture = GetInventorySlotInfo("Bag0Slot");
	for bagNum = 0, maxBags do
		if bagNum == 0 then -- Is it the bank?
			bagName = "Bank";
			bagNewIndex = BANK_CONTAINER;
			bagMaxIndex = 28;
		else
			bagName = "Bag"..(4+bagNum);
			bagNewIndex = (4+bagNum);
			local bagButton = getglobal("MyBankFrameBag"..(bagNewIndex));
			SetItemButtonNormalTextureVertexColor(bagButton, 1.0,1.0,1.0);
			SetItemButtonTextureVertexColor(bagButton, 1.0,1.0,1.0);
			if bankPlayer[bagName] and bankPlayer[bagName]["s"] then
				bagMaxIndex = bankPlayer[bagName]["s"];
				SetItemButtonTexture(bagButton, "Interface\\Icons\\"..bankPlayer[bagName]["i"]);
			else
				bagMaxIndex = 0;
				SetItemButtonTexture(bagButton, BlankTexture);
			end
		end
		for itemIndex = 1,bagMaxIndex do
			itemButton = getglobal("MyBankFrameItem"..buttonIndex);
			buttonIndex = buttonIndex + 1;
			if(bankPlayer and bankPlayer[bagName] and bankPlayer[bagName][itemIndex]) then
				texture = "Interface\\Icons\\"..bankPlayer[bagName][itemIndex]["i"];
				itemCount = bankPlayer[bagName][itemIndex]["c"];	
			else
				texture = nil;
				itemCount = 0;
			end
			if(itemButton) then
				local locked;
				if AtBank then
					texture, itemCount, locked, _, _ = GetContainerItemInfo(bagNewIndex, itemIndex);
					MyBankFrame_UpdateCooldown(itemButton);
				else
					locked = nil;
				end
				if bankPlayer[bagName] and bankPlayer[bagName][itemIndex] and bankPlayer[bagName][itemIndex]["d"] then
					local cooldown = getglobal(itemButton:GetName().."Cooldown");
					local cooldownInfo = bankPlayer[bagName][itemIndex]["d"];
					if cooldownInfo and cooldownInfo["e"] then
						local start, duration, enable = cooldownInfo["s"], cooldownInfo["d"], cooldownInfo["e"];
						if duration > 0 then
							CooldownFrame_SetTimer(cooldown, start, duration, enable);
						else
							cooldown:Hide();
						end
					else
						cooldown:Hide();
					end
				end
				SetItemButtonTexture(itemButton, texture);
				SetItemButtonCount(itemButton, itemCount);
				SetItemButtonDesaturated(itemButton, locked, 0.5, 0.5, 0.5);
				itemButton.bagIndex = bagNewIndex;
				itemButton.itemIndex= itemIndex;
			end
		end
	end
	for bagNum = 5+maxBags, 11 do
		local bagButton = getglobal("MyBankFrameBag"..(bagNum));
		SetItemButtonNormalTextureVertexColor(bagButton, 1.0,0.1,0.1);
		SetItemButtonTextureVertexColor(bagButton, 1.0,0.1,0.1);
		SetItemButtonTexture(bagButton, BlankTexture);
	end
	if ( bankPlayer and  bankPlayer["money"] ) then
		MoneyFrame_Update("MyBank_MoneyFrame", bankPlayer["money"]);
		MyBank_MoneyFrame:Show();
	else
		MyBank_MoneyFrame:Hide();
	end
	MyBank_UpdateTotalMoney();
	MyBankFrame_UpdateLookIfNeeded();
end
-- == Viewing other peoples banks ==
function MyBank_UserDropDown_GetValue()
	if ( bankPlayerName ) then
		return bankPlayerName;
	else
		return (UnitName("player").."|"..MyBank_Trim(GetCVar("realmName")));
	end
end
function MyBank_UserDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, MyBank_UserDropDown_Initialize);
	UIDropDownMenu_SetSelectedValue(this, MyBank_UserDropDown_GetValue());
	MyBankDropDown.tooltip =  MYBANK_TOOLTIP_PLAYER;
--	UIDropDownMenu_SetWidth(self, 140, MyBankDropDown);
	-- OptionsFrame_EnableDropDown(MyBankDropDown);
end

function MyBank_UserDropDown_OnClick()
	if ( not bankPlayer ) then
		return;
	end
	if AtBank then
		CloseBankFrame();
		OpenMyBankFrame();
	end
	-- UIDropDownMenu_SetSelectedValue(MyBankDropDown, this.value);
	if ( this.value ) then
		bankPlayer = MyBank_GetPlayer(this.value);
	end
	MyBankFrame_PopulateFrame();
end

function MyBank_UserDropDown_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(MyBankDropDown);
	local info;
	for key, value in pairs(MyBankProfile) do
		local thisRealmPlayers = MyBank_Split(key, "|")[2];
		if ( table.getn(MyBankProfile[key]) > 0 or MyBankProfile[key].money ) then
			if (MyBankAllRealms == 1 or thisRealmPlayers == MyBank_Trim(GetCVar("realmName")) ) then
				info = {};
				info.text = MyBank_Split(key,"|")[1].." of "..MyBank_Split(key,"|")[2];
				info.value = key;
				info.func = MyBank_UserDropDown_OnClick;
				if ( selectedValue == info.value ) then
					info.checked = 1;
				else
					info.checked = nil;
				end
				UIDropDownMenu_AddButton(info);
			end
		end
	end
end

function MyBank_ShowAllRealms_Check_OnClick()
		if ( MyBankAllRealms == 0 ) then
			MyBankAllRealms = 1;
		else
			MyBankAllRealms = 0;
		end
		MyBank_UpdateTotalMoney();
end

function MyBank_ShowAllRealms_Check_OnShow()
	if ( MyBankAllRealms == 1 ) then
		this.checked = 1;
	else
		this.checked = nil;
	end
	BlizzardOptionsPanel_CheckButton_Enable(this);
	this:SetChecked(this.checked);
	this.tooltipText = MYBANK_FRAME_ALLREALMS;
end


-- === Toggle Functions ===
-- All toggling of options
function ToggleMyBankFrame()
	if ( MyBankFrame:IsVisible() ) then
		CloseMyBankFrame();
	else
		OpenMyBankFrame();
	end
end
function CloseMyBankFrame()
	if AtBank then
		CloseBankFrame();
	end
	if ( MyBankFrame:IsVisible() ) then
		HideUIPanel(MyBankFrame);
	end
end
function OpenMyBankFrame()
	MyBankFrame_UpdateLookIfNeeded();
	ShowUIPanel(MyBankFrame, 1);
end

function MyBank_Toggle_Option(option, value, quiet)
	if value == nil then
		if getglobal("MyBank"..option) == 1 then
			value = 0;
		else
			value = 1;
		end
	end
	setglobal("MyBank"..option, value);
	MyBankProfile[PlayerName][option] = value;
	if not quiet then
		local chat_message;
		local globalName = "MYBANK_CHAT_"..string.upper(option);
		if value == 0 then
			globalName = globalName.."OFF";
		else
			globalName = globalName.."ON";
		end
		chat_message = getglobal(globalName);
		if ( chat_message ) then
			MyBank_Print(chat_message);
		else
			MyBank_DEBUG("ERROR: No global "..globalName);
		end
	end
	if option == "ReplaceBank" then
		MyBank_SetReplaceBank();
	elseif option == "ShowPlayers" or option == "BagView" then
		MyBankFrame_UpdateLook(getglobal("MyBankFrame"),MyBank_GetBagsTotalSlots());
	elseif option == "Graphics" or option == "Background" then
		MyBank_SetGraphics();
		MyBankFrame_UpdateLook(getglobal("MyBankFrame"),MyBank_GetBagsTotalSlots());
	elseif option == "Freeze" then
		MyBank_SetFreeze();
	end
end
function MyBank_SetGraphics()
	local pScale = tonumber(MyBankFrame:GetParent():GetScale());
	local scale = MyBankScale;
	if ( pScale == nil ) then
		pScale = tonumber(GetCVar("uiscale"));
		if not pScale then
			pScale = 1;
			MyBank_DEBUG("Scale Error")
		end
	end
	if MyBankGraphics == 1 then
		MyBankFrame:SetBackdropColor(0,0,0,0);
		MyBankFrame:SetBackdropBorderColor(0,0,0,0);
		
		MyBankFramePortrait:Show();
		MyBankFrameTextureTopLeft:Show();
		MyBankFrameTextureTopCenter:Show();
		MyBankFrameTextureTopRight:Show();
		MyBankFrameTextureLeft:Show();
		MyBankFrameTextureCenter:Show();
		MyBankFrameTextureRight:Show();
		MyBankFrameTextureBottomLeft:Show();
		MyBankFrameTextureBottomCenter:Show();
		MyBankFrameTextureBottomRight:Show();
		MyBankFrameName:ClearAllPoints();
		MyBankFrameName:SetPoint("TOPLEFT", "MyBankFrame", "TOPLEFT", 70, -8);
		MyBankFrameCloseButton:ClearAllPoints();
		MyBankFrameCloseButton:SetPoint("TOPRIGHT", "MyBankFrame", "TOPRIGHT", 10, 0);
		MyBankFrame:SetScale(tonumber(scale));
	else
		if MyBankBackground==1 then
			MyBankFrame:SetBackdropColor(0,0,0,1.0);
			MyBankFrame:SetBackdropBorderColor(1,1,1,1.0);
		else
			MyBankFrame:SetBackdropColor(0,0,0,0);
			MyBankFrame:SetBackdropBorderColor(1,1,1,0);
		end
		
		MyBankFramePortrait:Hide();
		MyBankFrameTextureTopLeft:Hide();
		MyBankFrameTextureTopCenter:Hide();
		MyBankFrameTextureTopRight:Hide();
		MyBankFrameTextureLeft:Hide();
		MyBankFrameTextureCenter:Hide();
		MyBankFrameTextureRight:Hide();
		MyBankFrameTextureBottomLeft:Hide();
		MyBankFrameTextureBottomCenter:Hide();
		MyBankFrameTextureBottomRight:Hide();
		MyBankFrameName:ClearAllPoints();
		MyBankFrameName:SetPoint("TOPLEFT", "MyBankFrame", "TOPLEFT", 5, -6);
		MyBankFrameCloseButton:ClearAllPoints();
		MyBankFrameCloseButton:SetPoint("TOPRIGHT", "MyBankFrame", "TOPRIGHT", 2, 2);
		MyBankFrame:SetScale(tonumber(scale));
	end
end
function MyBank_SetFreeze()
	if MyBankFreeze == 1 then
		MBFreezeNormalTexture:SetTexture("Interface\\AddOns\\MyBank\\Skin\\LockButton-Locked-Up");
	else
		MBFreezeNormalTexture:SetTexture("Interface\\AddOns\\MyBank\\Skin\\LockButton-Unlocked-Up");
	end
end

-- SetReplaceBank: Sets if MyBank replaces the official Bank frame
-- Unhooks the Official blizzard frome from the opened and closed events
function MyBank_SetReplaceBank()
	if BankFrame_Saved == nil then
		BankFrame_Saved = getglobal("BankFrame");
	end
	if ( MyBankReplaceBank == 0 ) then
		BankFrame_Saved:RegisterEvent("BANKFRAME_OPENED");
		BankFrame_Saved:RegisterEvent("BANKFRAME_CLOSED");
		setglobal("BankFrame", BankFrame_Saved);
		BankFrame_Saved = nil;
	else
		if BankFrame_Saved:IsVisible() then
			BankFrame_Saved:Hide();
		end
		BankFrame_Saved:UnregisterEvent("BANKFRAME_OPENED");
		BankFrame_Saved:UnregisterEvent("BANKFRAME_CLOSED");
		setglobal("BankFrame", MyBankFrameAtBankText);
	end
end
-- == End Toggle Functions ==

-- Get Link and Get Hyperlink - maintain independance.
function MyBank_GetLink(item)
	if item and item.color and item.item and item.name then
		local link = "|c"..item.color.."|H"..MyBank_GetHyperlink(item).."|h["..item.name.."]|h|r";
		MyBank_DEBUG("GetLink:"..link)
		return link;
	end
	return nil;
end

function MyBank_GetHyperlink(item)
	if item and item.item then
		local link = string.gsub(item.item, "(%d+):(%d+):(%d+):(%d+)", "%1:0:%3:%4");
		--local _, itemLink = GetItemInfo(item.item);
		MyBank_DEBUG("GetHyperlink:"..link)
		return "item:"..link;
	end
	return nil;
end

function MyBank_SetScale(scale) -- {{{
	if ( type(scale) ~= "number" ) then
		scale = tonumber(scale);
	end
	if ( scale == nil ) then
		MyBank_DEBUG("Scale Error")
	else
		if ( ( scale >= 0.5 ) and ( scale <= 2 ) ) then
			local pScale = tonumber(MyBankFrame:GetParent():GetScale());
			if ( pScale == nil ) then
				pScale = tonumber(GetCVar("uiscale"));
				if not pScale then
					pScale = 1;
					MyBank_DEBUG("Scale Error")
				end
			end
			MyBankFrame:SetScale(tonumber(scale));
			MyBankScale = scale;
			bankPlayer.Scale = MyBankScale;
		end
	end
end 

--		MyBankColumns = col;
--		bankPlayer.Columns = MyBankColumns;