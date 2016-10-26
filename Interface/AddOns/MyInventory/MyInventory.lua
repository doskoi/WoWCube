﻿-- -----------------------------------------------------------------
-- File: MyInventory.lua
--
-- Purpose: Functions for MyInventory WoW Window.
-- 
-- Author: Darklin - Dec, 2006
--         Ramble - Previous updater as of May, 2005
--         Svarten - MyInventory origional author.
-- 
-- Credits: 
--   Sarf, for the original concept.
--   Telo, for LootLink which I love.
--   Kaitlin, for showing me how a good code should look.
--   Pan and Nirre, for testing Svarten's corrupt code during development.
--   Ramble, for keeping it alive as long as he did.
-- -----------------------------------------------------------------
-- Vim command: :% s/^.* -LITE\({\_.\{-}}-LITE\)\=\(\s*-->\)\=$/
-- RegExp to remove Lite stuff: ^.* -LITE\({\_.\{-}}-LITE\)\=\(\s*-->\)\=$
-- This removes all lines ending in -LITE
--
-- And All Lines with a -LITE{ Starting line ended with 
-- this at the end }-LITE
-- 
-- Also will work in XML so <!-- -LITE{
-- This works too
-- }-LITE -->
MyInventoryDEBUG                = 0;
-- Global declarations {{{
-----------------------
-- Saved Configuration  
-----------------------
local MyInventoryProfile = {}
local PlayerName = nil;
-----------------------
-- Local Configuration
-----------------------
-- Constants {{{
MYINVENTORY_MAX_ID              = 160;
MYINVENTORY_COLUMNS_MIN         =   2;
MYINVENTORY_COLUMNS_MAX         =  20;

MYINVENTORY_TOP_HEIGHT          =  20;
MYINVENTORY_BOTTOM_HEIGHT       =  16;

MYINVENTORY_FIRST_ITEM_OFFSET_X =   8;
MYINVENTORY_FIRST_ITEM_OFFSET_Y = -28;
MYINVENTORY_ITEM_OFFSET_X       =  39;
MYINVENTORY_ITEM_OFFSET_Y       = -39;

MyInventory_Loaded              = nil;
MyInventory_Initialized         = nil;
--}}}
-- Saved Between sessions:These are also the defaults
MyInventoryColumns              = 8;

MyInventoryReplaceBags          = 1;
MyInventoryBags                 = "11111";
MyInventoryGraphics             = 1; -- -LITE
MyInventoryHighlightItems       = 1;
MyInventoryHighlightBags        = 1;
MyInventoryFreeze               = 0;
-- Keep the window from closing with Close
-- These options are on the MI Window itself.
MyInventoryLock                 = 0; -- Lock the window in place
MyInventoryBagView              = 0;
--Visibility
MyInventoryCount                = 1;
MyInventoryBackground           = 1;
MyInventoryShowTitle            = 1;
MyInventoryCash                 = 1;
MyInventoryButtons              = 1;
MyInventoryAIOIStyle            = 0;
MyInventoryItemBorder           = 1;
MyInventoryScale                = 1; --tonumber(GetCVar("uiscale"));

-- Hooked functions {{{
MyInventory_Saved_ToggleBag                        = nil;
MyInventory_Saved_OpenBag                          = nil;
MyInventory_Saved_CloseBag                         = nil;
MyInventory_Saved_ToggleBackpack                   = nil;
MyInventory_Saved_CloseBackpack                    = nil;
MyInventory_Saved_OpenBackpack                     = nil;
MyInventory_Saved_OpenAllBags                      = nil;
MyInventory_Saved_CloseAllBags                     = nil;

MyInventory_Saved_BackpackButton_OnClick           = nil;

MyInventory_Saved_LootFrame_OnShow                 = nil;
-- }}}
-- }}}

-- Loading {{{
function MyInventoryFrame_OnLoad() -- {{{
	ContainerFrame_OnLoad(this);
	MyInventory_Register();
--	MyInventory_Print(MYINVENTORY_MSG_LOADED);
end -- }}}
function MyInventory_InitializeProfile() --{{{
	if MyInventory_Initialized == true then
		return
	end
	if ( UnitName('player') ) then
		PlayerName = UnitName('player').."|"..MyInventory_Trim(GetCVar("realmName"));
		MyInventory_LoadSettings();
	--	MyInventory_Print(format(MYINVENTORY_MSG_INIT_s,PlayerName));
		MyInventory_Initialized = true;
		MyInventoryFrame_UpdateLook();
		MyInventory_SetFreeze();
	end
end --}}}
function MyInventory_LoadSettings() --{{{
	if ( MyInventoryProfile[PlayerName] == nil ) then
		MyInventoryProfile[PlayerName] = {};
	--	MyInventory_Print(format(MYINVENTORY_MSG_CREATE_s,PlayerName));
	end
	local MI_SoD = MyInventory_SavedOrDefault;
	MyInventoryColumns        = MI_SoD("Columns");
	MyInventoryReplaceBags    = MI_SoD("ReplaceBags");
	MyInventoryFreeze         = MI_SoD("Freeze");
	MyInventoryLock           = MI_SoD("Lock");
	MyInventoryHighlightItems = MI_SoD("HighlightItems");
	MyInventoryHighlightBags  = MI_SoD("HighlightBags");
	MyInventoryBagView        = MI_SoD("BagView");
	MyInventoryGraphics       = MI_SoD("Graphics"); -- -LITE
	MyInventoryBackground     = MI_SoD("Background");
	MyInventoryCount          = MI_SoD("Count");
	MyInventoryShowTitle      = MI_SoD("ShowTitle");
	MyInventoryCash           = MI_SoD("Cash");
	MyInventoryButtons        = MI_SoD("Buttons");
	MyInventoryScale          = MI_SoD("Scale");
	MyInventoryBags           = MI_SoD("Bags");
	MyInventoryAIOIStyle      = MI_SoD("AIOIStyle");
	MyInventoryItemBorder     = MI_SoD("ItemBorder");

	MyInventory_SetScale(tonumber(MyInventoryScale));
end -- }}}
function MyInventory_SavedOrDefault(varname) -- {{{
	if PlayerName == nil or varname == nil then
		MyInventory_DEBUG("ERR: nil value");
		return nil;
	end
	if MyInventoryProfile[PlayerName][varname] == nil then -- Setting not set
		MyInventoryProfile[PlayerName][varname] = getglobal("MyInventory"..varname); -- Load Default
	end
	return MyInventoryProfile[PlayerName][varname];  -- Return Setting.
end -- }}}
function MyInventory_Register() -- {{{
	SlashCmdList["MYINVENTORYSLASHMAIN"] = MyInventory_ChatCommandHandler;
	SLASH_MYINVENTORYSLASHMAIN1 = "/myinventory";
	SLASH_MYINVENTORYSLASHMAIN2 = "/mi";
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("ADDON_LOADED");

	this:RegisterEvent("BAG_UPDATE")
	this:RegisterEvent("ITEM_LOCK_CHANGED")
	this:RegisterEvent("BAG_UPDATE_COOLDOWN")
	this:RegisterEvent("UPDATE_INVENTORY_ALERTS")

end -- }}}
function MyInventory_MyAddonsRegister() -- {{{
	if (myAddOnsFrame) then
		myAddOnsList.MyInventory = {
			name = MYINVENTORY_MYADDON_NAME,
			description = MYINVENTORY_MYADDON_DESCRIPTION,
			version = MYINVENTORY_MYADDON_VERSION,
			category = MYADDONS_CATEGORY_INVENTORY,
			frame = "MyInventoryFrame",
			optionsframe = "MyInventoryOptionsFrame"
		};
	end
end -- }}}
-- }}}
-- Hooks functions. {{{
function MyInventory_Setup_Hooks(toggle) -- {{{
	MyInventory_Saved_ToggleBag = ToggleBag;
	ToggleBag = MyInventory_ToggleBag;
	
	MyInventory_Saved_CloseBag = CloseBag;
	CloseBag = MyInventory_CloseBag;
	MyInventory_Saved_OpenBag = OpenBag;
	OpenBag = MyInventory_OpenBag;

	MyInventory_Saved_OpenAllBags = OpenAllBags;
	OpenAllBags = MyInventory_OpenAllBags;
	MyInventory_Saved_CloseAllBags = CloseAllBags;
	CloseAllBags = MyInventory_CloseAllBags;

	MyInventory_Saved_ToggleBackpack = ToggleBackpack;
	ToggleBackpack = MyInventory_ToggleBackpack;
	MyInventory_Saved_CloseBackpack = CloseBackpack;
	CloseBackpack = MyInventory_CloseBackpack; 
	MyInventory_Saved_OpenBackpack = OpenBackpack;
	OpenBackpack = MyInventory_OpenBackpack;
--	MyInventory_Saved_LootFrame_OnShow = LootFrame_OnShow;
--	LootFrame_OnShow = MyInventory_LootFrame_OnShow;
end -- }}}
-- Does things with the hooked function -- {{{
--[[function MyInventory_LootFrame_OnShow()
	MyInventory_Saved_LootFrame_OnShow();
	LootFrame:Raise();
end--]]
-- }}}
-- Toggling Bags/Backpack {{{
function MyInventory_ShouldOverrideBag(bag)
	if (  (bag >= 0) and (bag <= 4) ) then
		if strsub(MyInventoryBags,(1+bag),(1+bag)) == "1" then
			return true;
		else
			return false
		end
	else
		return false;
	end
end

function MyInventory_ToggleBackpack()
	MyInventory_DEBUG("ToggleBackpack called");
	if ((MyInventoryReplaceBags == 1) and MyInventory_ShouldOverrideBag(0)) then
		ToggleMyInventoryFrame();
		return;
	end
	MyInventory_Saved_ToggleBackpack()
end

function MyInventory_ToggleBag(bag)
	MyInventory_DEBUG("ToggleBag"..bag.." called");
	if ((MyInventoryReplaceBags == 1) and MyInventory_ShouldOverrideBag(bag)) then
		ToggleMyInventoryFrame();
		return;
	else
		MyInventory_Saved_ToggleBag(bag);
	end
end

function MyInventory_OpenBackpack()
	MyInventory_DEBUG("Open Backpack called");
	if ( MyInventoryReplaceBags == 1 ) then  
		OpenMyInventoryFrame();
		return;
	end
	MyInventory_Saved_OpenBackpack()
end

function MyInventory_CloseBackpack()
	MyInventory_DEBUG("Close Backpack called");
	if ( MyInventoryReplaceBags == 1 and MyInventory_ShouldOverrideBag(0)) then
		if ( MyInventoryFreeze == 0) then
			CloseMyInventoryFrame();
		end
		return;
	end
	MyInventory_DEBUG("Default close");
	MyInventory_Saved_CloseBackpack()
end

function MyInventory_CloseBag(bag)
	MyInventory_DEBUG("Close Bag"..bag.." called");
	if ((MyInventoryReplaceBags == 1) and MyInventory_ShouldOverrideBag(bag)) then
		return;
	else
		MyInventory_Saved_CloseBag(bag);
	end
end

function MyInventory_OpenBag(bag)
	if ((MyInventoryReplaceBags == 1) and MyInventory_ShouldOverrideBag(bag)) then
		return;
	else
		MyInventory_Saved_OpenBag(bag)
	end
end

function MyInventory_OpenAllBags(forceOpen)
	MyInventory_DEBUG("Open All Bags Called");
	if ((MyInventoryReplaceBags == 1)) then
		MyInventory_DEBUG("Replacing function");
		-- OK, first determine if All bags are open, and if they are then close instead ::((
		local bagsOpen=0;
		local totalbags=0;
		for i=0,4 do
			if GetContainerNumSlots(i) > 0 then
				totalbags=totalbags+1;
				if MyInventoryFrame:IsVisible() and MyInventory_ShouldOverrideBag(i) then
					bagsOpen = bagsOpen+1;
				end
			end
		end
		for i=1,NUM_CONTAINER_FRAMES,1 do
			local containerFrame = getglobal("ContainerFrame"..i);
			if containerFrame:IsVisible() then
				bagsOpen=bagsOpen+1;
			end
		end
		if totalbags==bagsOpen and not forceOpen then
			CloseAllBags(1);
		else
			OpenMyInventoryFrame();
			for i=0,4 do
				if not MyInventory_ShouldOverrideBag(i) then
					MyInventory_DEBUG("Opening bag "..i);
					OpenBag(i);
				end
			end
		end
		return;
	else
		MyInventory_Saved_OpenAllBags(forceOpen);
	end
end

function MyInventory_CloseAllBags(force)
	MyInventory_DEBUG("Close All Bags Called");
	if ((MyInventoryReplaceBags == 1)) then
		MyInventory_DEBUG("Replacing function");
		if MyInventoryFreeze==0 or force==1 then
			CloseMyInventoryFrame();
		end
		for i=0,4 do
			if not MyInventory_ShouldOverrideBag(i) then
				CloseBag(i);
			end
		end
		return
	else
		MyInventory_Saved_CloseAllBags(arg);
	end
end

-- }}}
-- }}}

-- Options {{{
-- Slash commands {{{
function MyInventory_ChatCommandHandler(msg) -- {{{

	if ( ( not msg ) or ( strlen(msg) <= 0 ) ) then
		MyInventory_Print(MYINVENTORY_CHAT_COMMAND_USAGE);
		return;
	end
	
	local commandName, params = MyInventory_Extract_NextParameter(msg);
  
	if ( ( commandName ) and ( strlen(commandName) > 0 ) ) then
		commandName = string.lower(commandName);
	else
		commandName = "";
	end
 
	if ( (strfind(commandName, "show")) or (strfind(commandName, "toggle")) ) then
		ToggleMyInventoryFrame();
	elseif ( strfind(commandName, "config") or strfind(commandName, "option") ) then
		MyInventoryOptionsFrame:Show();
	elseif ( strfind(commandName, "replace") ) then
		MyInventory_Toggle_Option("ReplaceBags");
	elseif ( strfind(commandName, "freeze") ) then
		MyInventory_Toggle_Option("Freeze");
	elseif ( strfind(commandName, "aioi") ) then
		MyInventory_Toggle_Option("AIOIStyle", nil, nil, 1);
	elseif ( strfind(commandName, "lock") ) then
		MyInventory_Toggle_Option("Lock",nil,nil,1);
	elseif ( strfind(commandName, "cash") or strfind(commandName, "money")) then
		MyInventory_Toggle_Option("Cash",nil,nil,1);
	elseif ( strfind(commandName, "button") ) then
		MyInventory_Toggle_Option("Buttons",nil,nil,1);
	elseif ( strfind(commandName, "title") ) then
		MyInventory_Toggle_Option("ShowTitle",nil,nil,1);
	elseif ( strfind(commandName, "count") or strfind(commandName, "slot")) then
		MyInventory_Toggle_Option("Count",nil,nil,1);
	elseif ( strfind(commandName, "graphic") or strfind(commandName, "art") ) then -- -LITE
		MyInventory_Toggle_Option("Graphics",nil,nil,1); -- -LITE
	elseif ( strfind(commandName, "back") ) then
		MyInventory_Toggle_Option("Background",nil,nil,1);
	elseif ( strfind(commandName, "bagview") ) then
		MyInventory_Toggle_Option("BagView",nil,nil,1);
	elseif ( strfind(commandName, "quality") ) then
		MyInventory_Toggle_Option("ItemBorder",nil,nil,1);
	elseif ( strfind(commandName, "col") ) then
		cols, params = MyInventory_Extract_NextParameter(params);
		if cols then
			MyInventoryFrame_SetColumns(cols);
		end
	elseif ( strfind(commandName, "scale") ) then
		scale, params = MyInventory_Extract_NextParameter(params);
		if tonumber(scale) and tonumber(scale) >= 0.5 and tonumber(scale) <= 1.5 then
			MyInventory_SetScale(scale);
		else
			MyInventory_Print("MyInventory: Scale is at "..MyInventoryScale);
		end
	elseif ( strfind(commandName, "resetpos") ) then
		MyInventoryAnchorFrame:ClearAllPoints();
		MyInventoryAnchorFrame:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", 0, 50);
		MyInventoryFrame:ClearAllPoints();
		MyInventoryFrame:SetPoint("BOTTOMRIGHT", "MyInventoryAnchorFrame", "BOTTOMRIGHT");
	else
		MyInventory_Print(MYINVENTORY_CHAT_COMMAND_USAGE);
		return;
	end
end -- }}}
function MyInventory_Extract_NextParameter(msg) -- {{{
	local params = msg;
	local command = params;
	local index = strfind(command, " ");
	if ( index ) then
		command = strsub(command, 1, index-1);
		params = strsub(params, index+1);
	else
		params = "";
	end
	return command, params;
end -- }}}
-- }}}
function MyInventory_Toggle_Option(option, value, quiet, updateLook) -- {{{
	if value == nil then
		if getglobal("MyInventory"..option) == 1 then
			value = 0;
		else
			value = 1;
		end
	end
	setglobal("MyInventory"..option, value);
	MyInventoryProfile[PlayerName][option] = value;
	if not quiet or  quiet ~= 1 then
		local chat_message;
		local globalName = "MYINVENTORY_CHAT_"..string.upper(option);
		if value == 0 then
			globalName = globalName.."OFF";
		else
			globalName = globalName.."ON";
		end
		chat_message = getglobal(globalName);
		if ( chat_message ) then
			MyInventory_Print(MYINVENTORY_CHAT_PREFIX..chat_message);
		else
			MyInventory_DEBUG("ERROR: No global "..globalName);
		end
	end
	if MyInventoryBagView == 1 and MyInventoryColumns < 5 then
		MyInventoryFrame_SetColumns(5);
	end
	if updateLook and updateLook == 1 then
		MyInventoryFrame_UpdateLook();
	end
	if option=="Freeze" then
		MyInventory_SetFreeze()
	elseif option=="ReplaceBags" then
		MyInventory_SetReplace();
	elseif option=="Graphics" then -- -LITE
		MyInventoryFrame_Update(); -- -LITE
	elseif option=="ItemBorder" then
		MyInventoryFrame_Update();
	end
end -- }}}
function MyInventory_SetFreeze() -- {{{
	if MyInventoryFreeze == 0 then
		tinsert(UISpecialFrames, "MyInventoryFrame"); -- Esc Closes Inventory 
	else
		for key, value in pairs(UISpecialFrames) do
			if value == "MyInventoryFrame" then
				table.remove(UISpecialFrames, key);
			end
		end
	end
end -- }}}
function MyInventory_SetReplace() -- {{{
	if MyInventoryReplaceBags==1 then
		for i=0,4 do
			local val=strsub(MyInventoryBags,(1+i),(1+i));
			if val=="1" then
				MyInventory_DEBUG("replacing bag "..i);
				for j=1,NUM_CONTAINER_FRAMES,1 do
					local containerFrame = getglobal("ContainerFrame"..j);
					if containerFrame:GetID() == i then
						containerFrame:Hide();
					end
				end
			end
		end
	end
end -- }}}
function MyInventory_SetScale(scale) -- {{{
	MyInventoryFrame:SetScale(tonumber(scale));
	MyInventory_Toggle_Option("Scale", scale, 1);
end -- }}}
function MyInventoryFrame_SetColumns(col) -- {{{
	if ( type(col) ~= "number" ) then
		col = tonumber(col);
	end
	if (type(col) ~= "number" or col == 0) then
		return
	end
	if MyInventoryBagView == 1 and col < 5 then
		col = 5;
	end
	if ( ( col >= MYINVENTORY_COLUMNS_MIN ) and ( col <= MYINVENTORY_COLUMNS_MAX ) ) then
		MyInventoryColumns = col;
		MyInventoryProfile[PlayerName].Columns = MyInventoryColumns;
		MyInventoryFrame_UpdateLook();
	end
end -- }}}
-- }}}

-- Text related functions. {{{
function MyInventory_Trim (s) -- {{{
	return (string.gsub(s, "^%s*(.-)%s*$", "%1"));
end --}}}
function MyInventory_Print(msg,r,g,b,frame,id,unknown4th) -- {{{
	--if ( Print ) then
	--	Print(msg, r, g, b, frame, id, unknown4th);
	--	return;
	--end
	if(unknown4th) then
		local temp = id;
		id = unknown4th;
		unknown4th = id;
	end
	
	if (not r) then r = 1.0; end
	if (not g) then g = 1.0; end
	if (not b) then b = 1.0; end
	if not frame then
		if DEFAULT_CHAT_FRAME then
			frame = DEFAULT_CHAT_FRAME
		else
			MyInventory_DEBUG("quitting print");
			return
		end
	end
	if type(msg) == "table" then
		for key, value in pairs(msg) do
			frame:AddMessage(value, r, g, b,id,unknown4th);
		end
	else
		frame:AddMessage(msg, r, g, b,id,unknown4th);
	end
end  -- }}}
function MyInventory_DEBUG(msg) --{{{
	-- If Debug is not set, just skip it.
	if ( not MyInventoryDEBUG or MyInventoryDEBUG == 0 ) then
		return;
	end
	
	msg = "*** DEBUG(MyInventory): "..msg;
	if ( DEFAULT_CHAT_FRAME ) then 
		DEFAULT_CHAT_FRAME:AddMessage(msg, 1.0, 1.0, 0.0);
	end
end -- }}}
-- }}}
-- Toggle Frame {{{
function ToggleMyInventoryFrame() -- {{{
	if ( MyInventoryFrame:IsVisible() ) then
		CloseMyInventoryFrame();
	else
		OpenMyInventoryFrame();
	end
	MyInventory_UpdateBagState();
end -- }}}
function CloseMyInventoryFrame() -- {{{
	if ( MyInventoryFrame:IsVisible() ) then
		MyInventoryFrame:Hide();
	end
	MyInventory_UpdateBagState();
end --}}}
function OpenMyInventoryFrame() -- {{{
	MyInventoryFrame_UpdateLookIfNeeded();
	MyInventoryFrame:Show();
	MyInventory_UpdateBagState();
end --}}}
-- }}}
-- Update Bag State: Setting Checks {{{
function MyInventory_IsBagOpen(id) -- {{{
	local formatStr = "ContainerFrame%d";
	local frame = nil;
	for i = 1, NUM_CONTAINER_FRAMES do
		frame = getglobal(format(formatStr, i));
		if ( ( frame ) and ( frame:IsVisible() ) and ( frame:GetID() == id ) ) then
			return true;
		end
	end
	return false;
end --}}}
function MyInventory_GetBagState(toggle) -- {{{
	if ( ( toggle == true ) or ( toggle == 1 ) ) then
		return 1;
	else
		return 0;
	end
end -- }}}
function MyInventory_UpdateBagState() -- {{{
	local visible = MyInventoryFrame:IsVisible();
	local val = strsub(MyInventoryBags, 1,1);
	MainMenuBarBackpackButton:SetChecked(MyInventory_GetBagState((val=="1" and visible) or MyInventory_IsBagOpen(0)));
	MyInventoryBackpackButton:SetChecked(MyInventory_GetBagState((val=="1" and visible)));
	local bagButton = nil;
	local mibagButton1 = nil
	local mibagButton2 = nil
	local formatStr = "CharacterBag%dSlot";
	local formatStr2= "MyInventoBag%dSlot";

	for i = 0, 3 do 
		local val = strsub(MyInventoryBags, i+2,i+2);
		bagButton   = getglobal(format(formatStr, i));
		mibagButton2 = getglobal(format(formatStr2, i)); 
		if ( bagButton ) then
			bagButton:SetChecked(MyInventory_GetBagState((val=="1" and visible) or MyInventory_IsBagOpen(i+1)));
			mibagButton2:SetChecked(MyInventory_GetBagState((val=="1" and visible) ));
		end
	end
end -- }}}
-- }}}

StaticPopupDialogs["MB_CONFIG_CONFIRM"] = {
	text = MB_CONFIG_TEXT,
	button1 = TEXT(MYINVENTORY_MYADDON_NAME),
	button2 = TEXT(MYBANK_MYADDON_NAME),
	OnAccept = function()
		ShowUIPanel(MyInventoryOptionsFrame);
	end,
	OnCancel = function()
		ShowUIPanel(MyBankConfigFrame);
	end,
	timeout = 0,
	hideOnEscape = 1
};

-- Frame Events {{{
function MyInventoryFrame_OnEvent(event) -- {{{
	if ( event == "ADDON_LOADED" and arg1 == "MyInventory" ) then
		MyInventory_Setup_Hooks(1);
		MyInventory_DEBUG("Variables Loaded...");
		MyInventory_Loaded = true;
		MyInventory_MyAddonsRegister();
		MyInventory_InitializeProfile();

	if ( gLim_RegisterButton and IsAddOnLoaded("MyInventory") ) then
	gLim_RegisterButton (
		BINDING_HEADER_MYINVENTORYHEADER,
		BINDING_NAME_MYINVENTORYCONFIG,
		"Interface\\Icons\\INV_Misc_Bag_08",
		function()
			StaticPopup_Show("MB_CONFIG_CONFIRM");
		end,
		1,
		7
		);
	end
end


	if not MyInventory_Loaded then
		return
	end
	if ( event == "UNIT_NAME_UPDATE" and arg1 == "player" and UnitName("player") ~= UNKNOWNOBJECT) then
		MyInventory_InitializeProfile();
	end
	if PlayerName == nil then 
		return
	end
	if ( event == "BAG_UPDATE" ) then
		if ( this:IsVisible() ) then
			MyInventory_DEBUG("BAG_UPDATE Event fired.");
			MyInventoryFrame_Update(MyInventoryFrame);
		end
	elseif ( event == "ITEM_LOCK_CHANGED" or event == "BAG_UPDATE_COOLDOWN" or event == "UPDATE_INVENTORY_ALERTS" ) then
		if ( this:IsVisible() ) then
			MyInventoryFrame_Update(MyInventoryFrame);
		end
	end
end -- }}}
function MyInventoryFrame_OnHide() -- {{{
	PlaySound("igBackPackClose");
	MyInventory_UpdateBagState();
end -- }}}
function MyInventoryFrame_OnShow() -- {{{
	if MyInventory_Initialized == false then
		MyInventoryFrame:Hide();
		return;
	end
	MyInventoryFrame_Update(MyInventoryFrame);
	PlaySound("igBackPackOpen");
	MyInventoryFrame:ClearAllPoints();
	MyInventoryFrame:SetPoint("BOTTOMRIGHT", "MyInventoryAnchorFrame", "BOTTOMRIGHT");
	local pScale = MyInventoryFrame:GetParent():GetScale();
	MyInventoryFrame:SetScale(MyInventoryScale);
end -- }}}
function MyInventoryFrame_OnMouseDown(arg1) -- {{{
	if ( arg1 == "LeftButton" ) then
		if ( MyInventoryLock == 0 ) then
			-- this:StartMoving();
			MyInventoryAnchorFrame:StartMoving();
		else
		--	MyInventory_Print("MyInventory is locked and can not move...");
		end
	end
end -- }}}
function MyInventoryFrame_OnMouseUp(arg1) -- {{{
	if ( arg1 == "LeftButton" ) then
		this:StopMovingOrSizing();
		MyInventoryAnchorFrame:StopMovingOrSizing();
	end
end -- }}}
-- }}}
-- Item Button Events {{{
function MyInventoryFrameItemButton_OnLoad() -- {{{
	getglobal(this:GetName().."NormalTexture"):SetTexture("Interface\\AddOns\\MyInventory\\Skin\\Button");
end  -- }}}
function MyInventoryFrameItemButton_OnClick(button, ignoreShift) -- {{{
	local bag, slot = this.bagIndex, this.itemIndex;
	if ( button == "LeftButton" ) then
		if ( IsShiftKeyDown() and not ignoreShift ) then
			if ( ChatFrameEditBox:IsVisible() ) then
				ChatFrameEditBox:Insert(GetContainerItemLink(bag, slot));
			else
				local texture, itemCount, locked = GetContainerItemInfo(bag, slot);
				if ( not locked ) then
					this.SplitStack = function(button, split)
						SplitContainerItem(bag, slot, split);
					end
					OpenStackSplitFrame(this.count, this, "BOTTOMRIGHT", "TOPRIGHT");
				end
			end
		else
			PickupContainerItem(bag, slot);
		end
	elseif ( button == "RightButton" ) then
		if ( IsShiftKeyDown() and MerchantFrame:IsVisible() and not ignoreShift ) then
			this.SplitStack = function(button, split)
				SplitContainerItem(button:GetParent():GetID(), button:GetID(), split);
				MerchantItemButton_OnClick("LeftButton");
			end
			OpenStackSplitFrame(this.count, this, "BOTTOMRIGHT", "TOPRIGHT");
		else
			UseContainerItem(bag, slot);
		end
	end
end -- }}}
function MyInventory_ContainerFrameItemButton_OnEnter() -- {{{
	MyInventoryFrameItemButton_OnEnter()
end --}}}
function MyInventoryFrameItemButton_OnEnter() -- {{{
	local bag, slot = this.bagIndex, this.itemIndex;
	this:GetParent():SetID(this.bagIndex);
	this:SetID(this.itemIndex);
	ContainerFrameItemButton_OnEnter(this)
	MyInventory_HighlightItemBag(bag);
end -- }}}
function MyInventoryFrameItemButton_OnLeave() -- {{{
	MyInventory_HighlightItemBag(this.bagIndex, 1);
	this.updateTooltip = nil;
	GameTooltip:Hide();
	ResetCursor();
end -- }}}
function MyInventoryFrameItemButton_OnUpdate(elapsed) -- {{{
	if ( not this.updateTooltip ) then
		return;
	end
	
	this.updateTooltip = this.updateTooltip - elapsed;
	if ( this.updateTooltip > 0 ) then
		return;
	end
	
	if ( GameTooltip:IsOwned(this) ) then
		MyInventoryFrameItemButton_OnEnter();
	else
		this.updateTooltip = nil;
	end
end -- }}}
-- }}}
-- Bag Button Events {{{
function MyInventory_Backpack_OnEnter() -- {{{
	GameTooltip:SetOwner(this,"ANCHOR_LEFT");
	GameTooltip:SetText(TEXT(BACKPACK_TOOLTIP),1.0,1.0,1.0);
	local keyBinding = GetBindingKey("TOGGLEBACKPACK");
	if ( keyBinding ) then
	  GameTooltip:AppendText(" "..NORMAL_FONT_COLOR_CODE.."("..keyBinding..")"..FONT_COLOR_CODE_CLOSE);
	end
	MyInventory_HighlightBagItems(0);
end -- }}}
function MyInventory_Backpack_OnLeave() -- {{{
	GameTooltip:Hide();
	MyInventory_HighlightBagItems(0,1);
end -- }}}
function MyInventory_BagButton_OnEnter() -- {{{
	GameTooltip:SetOwner(this,"ANCHOR_LEFT");
	if GameTooltip:SetInventoryItem("player", this:GetID()) then
		local bindingkey = GetBindingKey("TOGGLEBAG"..(4-(this:GetID()-CharacterBag0Slot:GetID())));
		if bindingkey then
			GameTooltip:AppendText(" "..NORMAL_FONT_COLOR_CODE.."("..bindingkey..")"..FONT_COLOR_CODE_CLOSE);
		end
		MyInventory_HighlightBagItems(1+this:GetID()-MyInventoBag0Slot:GetID());
	else
		GameTooltip:SetText(TEXT(EQUIP_CONTAINER),1.0,1.0,1.0);
	end
end -- }}}
function MyInventory_BagButton_OnLeave() -- {{{
   this.updateTooltip = nil;
   GameTooltip:Hide();
   ResetCursor();
	local bagID = 1+this:GetID()-MyInventoBag0Slot:GetID();
	MyInventory_HighlightBagItems(bagID, 1);
end -- }}}
function MyInventory_BagButton_OnClick(isMMB) -- {{{
	--local index = tonumber(strsub(this:GetName(), 13, 13))+2;
	local bagID = 1+this:GetID()-MyInventoBag0Slot:GetID();
	local val = strsub(MyInventoryBags, bagID+1, bagID+1);
	if not PutItemInBag(this:GetID()) then
		if IsShiftKeyDown() or not isMMB then
			MyInventory_HighlightBagItems(bagID, 1);
			if val == "1" then
				val = "0"
			else
				val = "1"
				CloseBag(bagID);
			end
			MyInventoryBags = strsub(MyInventoryBags, 1, bagID)..val..strsub(MyInventoryBags, bagID+2);
			MyInventory_Toggle_Option("Bags", MyInventoryBags);
			MyInventory_UpdateBagState();
			MyInventoryFrame_UpdateLook();
			MyInventoryFrame_Update();
		else
			ToggleBag(bagID);
		end
	end
end -- }}}
function MyInventory_Backpack_OnClick(isMMB) -- {{{
	local val = strsub(MyInventoryBags, 1, 1);
	if not PutItemInBackpack() then
		if IsShiftKeyDown() or not isMMB then
			MyInventory_HighlightBagItems(0,1);
			if val == "1" then
				val = "0"
			else
				CloseBackpack();
				val = "1"
			end
			MyInventoryBags = val..strsub(MyInventoryBags, 2);
			MyInventory_UpdateBagState();
			MyInventoryFrame_UpdateLook();
			MyInventoryFrame_Update();
			MyInventory_Toggle_Option("Bags", MyInventoryBags);
		else
			ToggleBackpack();
		end
	end
end -- }}}
function MyInventory_BagButton_OnDragStart() -- {{{
	--BagSlotButton_OnDrag();
	PickupBagFromSlot(this:GetID());
	PlaySound("BAGMENUBUTTONPRESS");
end -- }}}
function MyInventory_BagButton_OnReceiveDrag() -- {{{
	PutItemInBag(this:GetID());
end -- }}}
-- }}}
-- Highlighting {{{
function MyInventory_HighlightBagItems(bagID, off) -- {{{
	if MyInventoryHighlightItems == 0 then
		return
	end
	local found;
	local itemButton;
	for i = 1,MYINVENTORY_MAX_ID do
		local bag, slot;
		itemButton = getglobal("MyInventoryFrameItem"..i);
		--bag = itemButton:GetParent():GetID();
		bag = itemButton.bagIndex;
		if bag == bagID then
			found = true;
			if off and off == 1 then
				itemButton:UnlockHighlight();
			else
				itemButton:LockHighlight();
			end
		else
			if found then 
				break;
			end
		end
	end
end -- }}}
function MyInventory_HighlightItemBag(bagID, off) -- {{{
	if MyInventoryHighlightBags == 0 then
		return
	end
	local BagButton1, BagButton2;
	if bagID == 0 then
		BagButton1= getglobal("MyInventoryBackpackButton");
		BagButton2= getglobal("MainMenuBarBackpackButton");
	else
		BagButton1= getglobal("MyInventoBag"..(bagID-1).."Slot");
		BagButton2= getglobal("CharacterBag"..(bagID-1).."Slot");
	end
	if off then
		BagButton1:UnlockHighlight();
		BagButton2:UnlockHighlight();
	else
		BagButton1:LockHighlight();
		BagButton2:LockHighlight();
	end
end -- }}}
-- }}}
-- Update Visuals, toggled options {{{
-- Update Look {{{
function MyInventoryFrame_UpdateLookIfNeeded() -- {{{
	local slots = MyInventory_GetBagsTotalSlots();
	if ( ( not MyInventoryFrame.size ) or ( slots ~= MyInventoryFrame.size ) ) then
		MyInventoryFrame_UpdateLook();
	end
end -- }}}
function MyInventoryFrame_UpdateLook() -- {{{
	--local frameSize = MyInventory_GetBagsTotalSlots();
	local frameSize = MyInventory_GetBagsReplacingSlots();
	MyInventoryTitle_Update(); -- Update Title
	MyInventory_SetLock();		-- Set Lock Icon
	MyInventory_ShowButtons(); -- Show or Hide Buttons
	
	MyInventoryFrame.size = frameSize;
	
	local name = MyInventoryFrame:GetName();
	-- Update Size Anchor to bottom right
	local columns, rows = MyInventoryColumns, ceil(frameSize / MyInventoryColumns);

	local height, width = MyInventoryFrame_GetAppropriateHeight(rows), MyInventoryFrame_GetAppropriateWidth(columns);

	MyInventoryFrame:SetHeight(height);
	MyInventoryFrame:SetWidth(width);
	
	MyInventory_SetGraphics(); -- Turn on or Off Blizzard Graphics
	-- Border	
	local First_Y = -6 ;
	-- Title
	local show = false
	if MyInventoryGraphics == 1 then -- -LITE{
		show = true;
	end -- }-LITE
	if MyInventoryShowTitle==1 or MyInventoryButtons == 1 or show then
		First_Y = First_Y - MYINVENTORY_TOP_HEIGHT;
	end
	-- BagButtons
	MyInventoryBagButtonsBar:ClearAllPoints();
	-- -LITE{
	if MyInventoryGraphics == 1 then
		if MyInventoryColumns == 5 then
			First_Y = First_Y + MYINVENTORY_ITEM_OFFSET_Y;
			MyInventoryBagButtonsBar:SetPoint("TOP", "MyInventoryFrame", "TOP", 0, First_Y);
		else
			MyInventoryBagButtonsBar:SetPoint("TOP", "MyInventoryFrame", "TOP", 20, First_Y);
			First_Y = First_Y + MYINVENTORY_ITEM_OFFSET_Y;
		end
	else
		-- }-LITE
		MyInventoryBagButtonsBar:SetPoint("TOP", "MyInventoryFrame", "TOP", 0, First_Y);
	end -- -LITE
	
	if MyInventoryBagView == 1 then
		if MyInventoryGraphics == 0 or MyInventoryColumns == 5 then -- -LITE
			First_Y = First_Y + MYINVENTORY_ITEM_OFFSET_Y;
		end -- -LITE
		MyInventoryBagButtonsBar:Show();
	else
		MyInventoryBagButtonsBar:Hide();
	end
	local curCol;
	if MyInventoryAIOIStyle==1 then
		curCol=columns-(mod(frameSize, columns)-1);
		if curCol>columns then 
			curCol=curCol-columns;
		end
	else
		curCol=1;
	end
	local curRow=1;
	for j=1, frameSize, 1 do
		local itemButton = getglobal(name.."Item"..j);
		itemButton:SetID(j);
		-- Set first button
		itemButton:ClearAllPoints();
		local dx, dy, baseframe;
		if ( j == 1 ) then
			baseframe = name;
			if MyInventoryAIOIStyle == 1 then
				dx = (curCol-1)*MYINVENTORY_ITEM_OFFSET_X + MYINVENTORY_FIRST_ITEM_OFFSET_X;
				dy =    First_Y;
			else
				dx = MYINVENTORY_FIRST_ITEM_OFFSET_X;
				dy = First_Y;
			end
		else
			if ( mod((curCol+j-2), columns) == 0 ) then
				baseframe = "MyInventoryFrame";
				dx = MYINVENTORY_FIRST_ITEM_OFFSET_X;
				dy = First_Y + MYINVENTORY_ITEM_OFFSET_Y*curRow;
				curRow=curRow+1;
			else
				baseframe = name.."Item"..(j - 1);
				dy = 0;
				dx = MYINVENTORY_ITEM_OFFSET_X;
			end
		end
		itemButton:SetPoint("TOPLEFT", baseframe, "TOPLEFT", dx, dy);
		
		itemButton:Show();
	end
	local button = nil;
	for i = frameSize+1, MYINVENTORY_MAX_ID do
		button = getglobal("MyInventoryFrameItem"..i);
		if ( button ) then
			button:Hide();
		end
	end
end -- }}}
-- }}}
-- Get Height and Width {{{
function MyInventoryFrame_GetAppropriateHeight(rows) -- {{{
	-- Border 6 on top, 6 on bottom
	-- First row is 28 pixels down.
	-- BASE_HEIGHT = 44
	if MyInventoryGraphics == 1 then -- -LITE{
		rows = rows+1; 
	end -- }-LITE
	if MyInventoryBagView == 1 then
		if MyInventoryGraphics == 0 or MyInventoryColumns == 5 then -- -LITE
			rows = rows+1;
		end -- -LITE
	end
	local height = 12;
	if MyInventoryButtons==1 or MyInventoryShowTitle==1 or MyInventoryGraphics == 1 then
		height = height + MYINVENTORY_TOP_HEIGHT;
	end
	if (MyInventoryCash==1) or (MyInventoryCount > -1)  then
		height = height + MYINVENTORY_BOTTOM_HEIGHT;
	end
	height = height + (-MYINVENTORY_ITEM_OFFSET_Y) * rows;
  return height;
end -- }}}
function MyInventoryFrame_GetAppropriateWidth(cols) -- {{{
	return 12 + ( MYINVENTORY_ITEM_OFFSET_X * cols );
end -- }}}
-- }}}
-- Get Bag Slots {{{
function MyInventory_GetBagsTotalSlots() -- {{{
	local slots = 0;
	for bag = 0, 4 do
		slots = slots + GetContainerNumSlots(bag);
	end
	return slots;
end -- }}}
function MyInventory_GetBagsReplacingSlots() -- {{{
	local slots = 0;
	for bag = 0, 4 do
		if MyInventory_ShouldOverrideBag(bag) then
			slots = slots + GetContainerNumSlots(bag);
		end
	end
	return slots;
end  -- }}}
function MyInventory_GetIdAsBagSlot(id) -- {{{
	-- depreciated
	local button = getglobal("MyInventoryFrameItem"..id);
	if button.bagIndex then
		return button.bagIndex, button.itemIndex;
	end
	return -1,-1;
end -- }}}
-- }}}
function MyInventoryTitle_Update() -- {{{
	if MyInventoryCash == 1 then
		MyInventoryFrameMoneyFrame:Show();
	else
		MyInventoryFrameMoneyFrame:Hide();
	end
	MyInventorySlots_Update();
	if MyInventoryShowTitle == 0 then
		if MyInventoryGraphics == 0 then -- -LITE
			MyInventoryFrameName:Hide();
			return;
		end -- -LITE
	end
	MyInventoryFrameName:Show();
	if ( UnitName('player') ) then
		local player, realm = UnitName('player'),MyInventory_Trim(GetCVar("realmName")); 
		if (MyInventoryColumns < 5 ) then
			MyInventoryFrameName:SetText(MYINVENTORY_TITLE);
		elseif (MyInventoryColumns < 7 ) then
			if MyInventoryGraphics == 1 then -- -LITE
				MyInventoryFrameName:SetText(MYINVENTORY_TITLE); -- -LITE
			else -- -LITE
				MyInventoryFrameName:SetText(format(MYINVENTORY_TITLE_S, player));
			end -- -LITE
		else
			if MyInventoryGraphics == 1 and MyInventoryColumns < 9 then -- -LITE
				MyInventoryFrameName:SetText(format(MYINVENTORY_TITLE_S, player)); -- -LITE
			else -- -LITE
				MyInventoryFrameName:SetText(format(MYINVENTORY_TITLE_SS,player, realm));
			end -- -LITE
		end
		MyInventoryFrameName:SetTextColor(1.0, 1.0, 1.0);
			
	end
end -- }}}
function MyInventorySlots_Update() -- {{{
	local i, j, totalSlots= 0, 0, 0;
	local takenSlots = 0;
	
	for i = 0, 4 do
		local slots = GetContainerNumSlots(i)
		if MyInventory_ShouldOverrideBag(i) then 
			totalSlots = totalSlots + slots;
			for j = 1, slots do
				if GetContainerItemInfo(i,j) then
					takenSlots=takenSlots + 1;
				end
			end
		end
	end
	if MyInventoryCount == 0 then
		MyInventoryFrameSlots:Show();
		MyInventoryFrameSlots:SetText(format(MYINVENTORY_SLOTS_DD, (totalSlots-takenSlots),totalSlots));
	elseif MyInventoryCount == 1 then
		MyInventoryFrameSlots:Show();
		MyInventoryFrameSlots:SetText(format(MYINVENTORY_SLOTS_DD, (takenSlots),totalSlots));
	else
		MyInventoryFrameSlots:Hide();
	end
end -- }}}
function MyInventory_SetLock() -- {{{
	if MyInventoryLock == 1 then
		MILockNormalTexture:SetTexture("Interface\\AddOns\\MyInventory\\Skin\\LockButton-Locked-Up");
	else
		MILockNormalTexture:SetTexture("Interface\\AddOns\\MyInventory\\Skin\\LockButton-Unlocked-Up");
	end
	MyInventoryFrame:EnableMouse(1-MyInventoryLock);
end -- }}}
function MyInventory_ShowButtons() -- {{{
	local show = false;
	if MyInventoryGraphics == 1 then -- -LITE{
		show = true 
	end -- }-LITE
	if MyInventoryButtons == 1 or show then
		MyInventoryFrameCloseButton:Show();
		MyInventoryFrameLockButton:Show();
		MyInventoryFrameHideBagsButton:Show();
	else
		MyInventoryFrameCloseButton:Hide();
		MyInventoryFrameLockButton:Hide();
		MyInventoryFrameHideBagsButton:Hide();
	end
end -- }}}
function MyInventory_SetGraphics() -- {{{
	-- -LITE{
	if MyInventoryGraphics == 1 then
		MyInventoryFrame:SetBackdropColor(0,0,0,0);
		MyInventoryFrame:SetBackdropBorderColor(0,0,0,0);
		
		MyInventoryFramePortrait:Show();
		MyInventoryFrameTextureTopLeft:Show();
		MyInventoryFrameTextureTopCenter:Show();
		MyInventoryFrameTextureTopRight:Show();
		MyInventoryFrameTextureLeft:Show();
		MyInventoryFrameTextureCenter:Show();
		MyInventoryFrameTextureRight:Show();
		MyInventoryFrameTextureBottomLeft:Show();
		MyInventoryFrameTextureBottomCenter:Show();
		MyInventoryFrameTextureBottomRight:Show();
		MyInventoryFrameName:ClearAllPoints();
		MyInventoryFrameName:SetPoint("TOPLEFT", "MyInventoryFrame", "TOPLEFT", 70, -8);
		MyInventoryFrameCloseButton:ClearAllPoints();
		MyInventoryFrameCloseButton:SetPoint("TOPRIGHT", "MyInventoryFrame", "TOPRIGHT", 10, 0);
	else	-- }-LITE
		
		if MyInventoryBackground==1 then
			MyInventoryFrame:SetBackdropColor(0,0,0,1.0);
			MyInventoryFrame:SetBackdropBorderColor(1,1,1,1.0);
		else
			MyInventoryFrame:SetBackdropColor(0,0,0,0);
			MyInventoryFrame:SetBackdropBorderColor(1,1,1,0);
		end
			
		MyInventoryFramePortrait:Hide();
		MyInventoryFrameTextureTopLeft:Hide();
		MyInventoryFrameTextureTopCenter:Hide();
		MyInventoryFrameTextureTopRight:Hide();
		MyInventoryFrameTextureLeft:Hide();
		MyInventoryFrameTextureCenter:Hide();
		MyInventoryFrameTextureRight:Hide();
		MyInventoryFrameTextureBottomLeft:Hide();
		MyInventoryFrameTextureBottomCenter:Hide();
		MyInventoryFrameTextureBottomRight:Hide();
		MyInventoryFrameName:ClearAllPoints();
		MyInventoryFrameName:SetPoint("TOPLEFT", "MyInventoryFrame", "TOPLEFT", 5, -6);
		MyInventoryFrameCloseButton:ClearAllPoints();
		MyInventoryFrameCloseButton:SetPoint("TOPRIGHT", "MyInventoryFrame", "TOPRIGHT", 2, 2);
	end -- -LITE
end -- }}}
-- }}}
function MyInventoryFrame_Update(frame) --- {{{
	if (not frame) then
		frame = getglobal("MyInventoryFrame");
	end
	if (not frame or not frame:IsVisible()) then
		return;
	end
	MyInventoryFrame_UpdateLookIfNeeded();
	local name = frame:GetName();
	local index = 0;
	MyInventorySlots_Update();
	local altbag=0; -- Even or odd bag
	for bag=0, 4 do
		if MyInventory_ShouldOverrideBag(bag) and GetContainerNumSlots(bag)>0 then 
			altbag=math.abs(altbag-1); -- Even or odd (couting the replaced ones only)

			local otherBag = nil;
			local bagLink;
			if (bag > 0) then			
				bagLink = getglobal("MyInventoBag"..(bag-1).."Slot");
			end			
			if (bagLink) then
				local link = GetInventoryItemLink("player", bagLink:GetID());
				if (link) then
					local bagType = select(7, GetItemInfo(link));
					if (bagType and (
						bagType == MYINVENTORY_QUIVER or 
						bagType == MYINVENTORY_AMMO or 
						bagType == MYINVENTORY_SOUL_BAG or
						bagType == MYINVENTORY_HERB_BAG or
						bagType == MYINVENTORY_ENCH_BAG or
						bagType == MYINVENTORY_ENG_BAG or 
						bagType == MYINVENTORY_ORE_BAG or
						bagType == MYINVENTORY_GEM_BAG )) then
						otherBag = 1;
					end
				end
			end

			for slot=1, GetContainerNumSlots(bag) do
				index = index + 1;
				local itemButton = getglobal(name.."Item"..index);
				local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag, slot);
				itemButton.bagIndex = bag; itemButton.itemIndex = slot; -- Save the slot and bag, MUCH easier then looking it up every time.
				if not texture and MyInventoryGraphics==1 then -- -LITE{
					SetItemButtonTexture(itemButton, "Interface\\AddOns\\MyInventory\\Skin\\blank");
				else -- }-LITE
					SetItemButtonTexture(itemButton, texture);
				end -- -LITE
				SetItemButtonCount(itemButton, itemCount);
				SetItemButtonDesaturated(itemButton, locked, 0.5, 0.5, 0.5);
				local color = { ["r"]=0.5, ["g"]=0.5, ["b"]=0.5 };
				if (MyInventoryItemBorder == 1) and  ( quality and quality >= 2 ) then    
					if quality == 3 then
						color = { ["r"]=0.0,["g"]=0.0,["b"]=1.0} -- Cause everyone LOVES the blue
					elseif quality == 2 then
						color = { ["r"]=0.0,["g"]=1.0,["b"]=0.0}
					elseif quality == 4 then
						color = { ["r"]=0.7,["g"]=0.0,["b"]=0.7}
					else
						-- color = getglobal("ITEM_QUALITY".. quality .."_TOOLTIP_COLOR");					
						color = { ["r"]=0.0,["g"]=0.0,["b"]=0.0}
					end
				elseif MyInventoryItemBorder == 2 then
					if altbag == 0 then
						color = { ["r"]=0.0,["g"]=0.0,["b"]=1.0} 
					else
						color = { ["r"]=0.0,["g"]=1.0,["b"]=0.0} 
					end
				end
				SetItemButtonNormalTextureVertexColor(itemButton, color.r, color.g, color.b);
				 -- If it is a other
				if (otherBag and MyInventoryItemBorder == 1 ) then
					SetItemButtonNormalTextureVertexColor(itemButton, 1.0, 1.0, 0.0);
					--getglobal(itemButton:GetName().."Border"):SetVertexColor(1.0, 1.0, 0.0, 0.6);
				end
				if ( texture ) then
					local cooldown = getglobal(itemButton:GetName().."Cooldown");
					local start, duration, enable = GetContainerItemCooldown(bag, slot);
					CooldownFrame_SetTimer(cooldown, start, duration, enable);
					if ( duration > 0 and enable == 0 ) then
						SetItemButtonTextureVertexColor(button, 0.4, 0.4, 0.4);
					end
				else
					getglobal(name.."Item"..index.."Cooldown"):Hide();
				end

				itemButton.readable = readable;
				local showSell = nil;
				if ( GameTooltip:IsOwned(itemButton) ) then
					if ( texture ) then
						local hasCooldown, repairCost = GameTooltip:SetBagItem(bag, slot);
						if ( hasCooldown ) then
							itemButton.updateTooltip = TOOLTIP_UPDATE_TIME;
						else
							itemButton.updateTooltip = nil;
						end
						if ( InRepairMode() and (repairCost > 0) ) then
							GameTooltip:AddLine(TEXT(REPAIR_COST), "", 1, 1, 1);
							SetTooltipMoney(GameTooltip, repairCost);
							GameTooltip:Show();
						elseif ( MerchantFrame:IsVisible() and not locked) then
							showSell = 1;
						end
					else
						GameTooltip:Hide();    
					end
					if ( showSell ) then
						ShowContainerSellCursor(bag, slot);
					elseif ( readable ) then    
						ShowInspectCursor();
					else      
						ResetCursor();
					end 
				end
			end
		end
	end
end -- }}}
