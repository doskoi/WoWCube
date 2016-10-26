-- RedOut Script
-- by jINx of Purgatory LAN Organization
-- http://jinx.purgatorylan.org/wow/

-- Description:
-- Shades Out the Action Bar buttons when they are out of range

-- Version 2.4
-- * Updated TOC for patch 1.8
-- * Created user specific configuration profiles (Name specific, not Realm)
-- * Shifted around the allocation of many resources especially in the update and usable areas
-- * Disabled Equip Monitor though its still here (deprecated in Blizzard 1.8)
-- * Added the functionality to change Hotkey text color
-- * Completely revamped the options window, for the new features
-- * .... Set the Hotkey text color
-- * .... Toggle the use of extensions (updating other ui buttons)
-- * .... Interval adjustment

-- 2.4 Known Issues:
-- * At this time the Extensions have not been updated, the supported mods may or may not be effected,
--   or they may contain their own system for range detection. UI Mod support only exists from previous
--   requests. Submit requests using the form at: http://jinx.purgatorylan.org/wow/

-- Version 2.3
-- * Added a new RedOut timer to monitor updates (Made it far more responsive)

-- Version 2.2
-- * Added Equip Monitor to line action buttons in yellow when equipped

-- Version 2.1
-- * Fixed an issue with loading multiple times	

-- Version 2.0
-- * Flicker was reduced or stopped for the most part
-- * Added support for Telo's Sidebar
-- * Changed load sequence to ensure it checks for other scripts last

-- Version 1.0
-- * First Released Version
-- * Created Options frame to allow Enable/Disable and Custom Color
-- * Fixed an Issue that was causing Usability to not take into account
-- * Verified and created functionality for the following bars:
-- * .... Standard Bar
-- * .... BiB Toolbars
-- * .... CT Bar Mod
-- * .... Gypsy Bars
-- * .... Edit by Bryan

-- This is the Time (in seconds) between RedOut Update procedures
-- 2.4 -- jx: Deprecated - This is now configurable and saved per profile
-- local RedOut.Interval = 0.2

local RedOutVersion = 2.4
local isLoaded = false;

-- EquipMonitor:
-- This is deprecated, the Blizzard action buttons now do this. I had only enabled it 
-- for Blizzard bars since I used it on my second row when they added additional bars
-- I have no plan to continue anything toward this, and all the logic can be removed
-- and replaced with one simple function that now returns if a particular item on
-- an action button is equipped. (A+ Slouken)

-- Question:
--   WTF is this still here? Get this and the Yeti it was born from out of my UI if its not ever going to be used.
-- Answer:
--   No, I like Yeti's.

local EquipMonitor = false;

local equipslots = equipslot;

local eq = { };

-- Generic echo
-- 2.4 -- jx: When I profiled the options, I added the ability to set a custom ChatFrame to output to: 
--            /script RedOut.ChatFrame = "StringFrameName"; otherwise it uses default chat frame if it exists
--     ++ jx: Ah, in order for that to save. You have to open and close the options via /redout
local function echo(str,r,g,b)
	if ( not r ) then r = 1.0 end
	if ( not g ) then g = 1.0 end
	if ( not b ) then b = 0.0 end
	if ( RedOut.ChatFrame ) then
		getglobal(RedOut.ChatFrame):AddMessage(str,r,g,b);
	elseif ( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(str,r,g,b);
	end
end

-- Standard hook to trail the original function
local function SetHook(myFunction, HookFunc)
	local oldFunction = getglobal(HookFunc);
	local newFunction =
		function(e,...)
			oldFunction(e,...);
			myFunction(e,...);
		end
	setglobal(HookFunc, newFunction);
end

function RedOut_OptionsCheckButtonOnClick()
	if ( this:GetName() == "RedOutOptions_EnableCheck" ) then
		RedOut.Enabled = not RedOut.Enabled;
	elseif ( this:GetName() == "RedOutOptions_HotkeyCheck") then
		RedOut.Hotkey = not RedOut.Hotkey;
	elseif ( this:GetName() == "RedOutOptions_ExtCheckBlizzard" ) then
		RedOut.Ext["Blizzard"] = not RedOut.Ext["Blizzard"];
		if (type(ActionButton_OnUpdate) ~= 'function') then
			echo(REDOUT_TEXT_FAILD.."Blizzard Bars");
			RedOut.Ext["Blizzard"] = false;
			this:SetChecked(0);
		end
	elseif ( this:GetName() == "RedOutOptions_ExtCheckCTMod" ) then
		RedOut.Ext["CTMod"] = not RedOut.Ext["CTMod"];
		if (type(CT_ActionButton_OnUpdate) ~= 'function') then
			echo(REDOUT_TEXT_FAILD.."CT Mod");
			RedOut.Ext["CTMod"] = false;
			this:SetChecked(0);
		end
	elseif ( this:GetName() == "RedOutOptions_ExtCheckGypsy" ) then
		RedOut.Ext["Gypsy"] = not RedOut.Ext["Gypsy"];	
		if (type(Gypsy_ActionButtonOnUpdate) ~= 'function') then
			echo(REDOUT_TEXT_FAILD.."Gypsy bars");
			RedOut.Ext["Gypsy"] = false;
			this:SetChecked(0);
		end
	elseif ( this:GetName() == "RedOutOptions_ExtCheckTelo" ) then
		RedOut.Ext["Telo"] = not RedOut.Ext["Telo"];
		if (type(SideBarButton_OnUpdate) ~= 'function') then
			echo(REDOUT_TEXT_FAILD.."Telo's Sidebar");
			RedOut.Ext["Telo"] = false;
			this:SetChecked(0);		
		end
	end
end

function RedOutOptions_Defaults()
	RedOut = { };		
	RedOut.Enabled = true;
	RedOut.Color = { r = 1.0, g = 0.1, b = 0.1 };
	RedOut.Hotkey = false;
	RedOut.HotkeyColor = { r = 0.6, g = 0.6, b = 0.6 };	
	RedOut.Ext= { };
	RedOut.Ext["Blizzard"] = true;
	RedOut.Ext["CTMod"] = false;
	RedOut.Ext["Gypsy"] = false;
	RedOut.Ext["Telo"] = false;
	RedOut.Interval = 0.2;
end

function RedOutOptions_Show()
	-- 2.4 -- jx: Localization

	getglobal("RedOutOptionsGeneralTitle"):SetText(REDOUT_TEXT_GENERAL);
	getglobal("RedOutOptionsExtTitle"):SetText();
	getglobal("RedOutOptionsAdvancedTitle"):SetText(REDOUT_TEXT_INTERVAL);
	
	getglobal("RedOutOptionsSave"):SetText(REDOUT_TEXT_SAVE);
	getglobal("RedOutOptionsReset"):SetText(REDOUT_TEXT_DEFAULT);

	getglobal("RedOutOptions_EnableCheckText"):SetText(REDOUT_TEXT_ENABLE);
	getglobal("RedOutOptions_EnableCheck").tooltipText = REDOUT_TEXT_ENABLETIP;
	getglobal("RedOutOptions_HotkeyCheckText"):SetText(REDOUT_TEXT_HOTKEYCHECK);
	getglobal("RedOutOptions_HotkeyCheck").tooltipText = REDOUT_TEXT_HOTKEYCHECKTIP;

	getglobal("RedOutOptions_Range_ColorSwatchText"):SetText(REDOUT_TEXT_COLOR); -- "Choose a Color to Fade To"
	getglobal("RedOutOptions_Range_ColorSwatch").tooltipText = REDOUT_TEXT_COLORTIP; -- "Select the Color for the Out of Range shade";
	getglobal("RedOutOptions_Hotkey_ColorSwatchText"):SetText(REDOUT_TEXT_HOTKEYCHECK); 
	getglobal("RedOutOptions_Hotkey_ColorSwatch").tooltipText = REDOUT_TEXT_HOTKEYCHECKTIP; 
		
	getglobal("RedOutOptions_ExtCheckBlizzardText"):SetText("Blizzard Bars");
	getglobal("RedOutOptions_ExtCheckCTModText"):SetText("CT Mod");
	getglobal("RedOutOptions_ExtCheckGypsyText"):SetText("Gypsy Bars");
	getglobal("RedOutOptions_ExtCheckTeloText"):SetText("Telo's Sidebar");
	
	getglobal("RedOutOptions_IntervalLow"):SetText("0.05");
	getglobal("RedOutOptions_IntervalHigh"):SetText("1.00");
	getglobal("RedOutOptions_Interval"):SetValue(RedOut.Interval);
	getglobal("RedOutOptions_Interval").tooltipText = REDOUT_TEXT_INTERVALTIP;
	
end

function RedOutOptions_Update()
	if ( not RedOut ) then -- Error trap in case options are opened and for some reason no settings exist
		RedOutOptions_Defaults();
	end

	local frame = getglobal("RedOutOptions_Range");
	frame.r = RedOut.Color.r;	frame.g = RedOut.Color.g;	frame.b = RedOut.Color.b;
	frame.swatchFunc = RedOutOptions_SetRangeColor;
	frame.cancelFunc = RedOutOptions_CancelRangeColor;
	getglobal("RedOutOptions_Range_ColorSwatchNormalTexture"):SetVertexColor(RedOut.Color.r, RedOut.Color.g, RedOut.Color.b);

	frame = getglobal("RedOutOptions_Hotkey");
	frame.r = RedOut.HotkeyColor.r;	frame.g = RedOut.HotkeyColor.g;	frame.b = RedOut.HotkeyColor.b;
	frame.swatchFunc = RedOutOptions_SetHotkeyColor;
	frame.cancelFunc = RedOutOptions_CancelHotkeyColor;
	getglobal("RedOutOptions_Hotkey_ColorSwatchNormalTexture"):SetVertexColor(RedOut.HotkeyColor.r, RedOut.HotkeyColor.g, RedOut.HotkeyColor.b);

	local button = getglobal("RedOutOptions_EnableCheck");
	if ( RedOut.Enabled ) then
		button:SetChecked(1);
	else
		button:SetChecked(0);
	end
	local button = getglobal("RedOutOptions_HotkeyCheck");
	if ( RedOut.Hotkey ) then
		button:SetChecked(1);
	else
		button:SetChecked(0);
	end

	local button = getglobal("RedOutOptions_ExtCheckBlizzard");
	if ( RedOut.Ext["Blizzard"]  ) then
		button:SetChecked(1);
	else
		button:SetChecked(0);
	end
	local button = getglobal("RedOutOptions_ExtCheckCTMod");
	if ( RedOut.Ext["CTMod"]  ) then
		button:SetChecked(1);
	else
		button:SetChecked(0);
	end
	local button = getglobal("RedOutOptions_ExtCheckGypsy");
	if ( RedOut.Ext["Gypsy"]  ) then
		button:SetChecked(1);
	else
		button:SetChecked(0);
	end
	local button = getglobal("RedOutOptions_ExtCheckTelo");
	if ( RedOut.Ext["Telo"]  ) then
		button:SetChecked(1);
	else
		button:SetChecked(0);
	end

	getglobal("RedOutOptions_Interval"):SetValue(RedOut.Interval);
	getglobal("RedOutOptions_IntervalText"):SetText(string.format("%.2f",RedOut.Interval));
end

function RedOutOptions_UpdateSlider()
	RedOut.Interval = this:GetValue();
	getglobal("RedOutOptions_IntervalText"):SetText(string.format("%.2f",RedOut.Interval));
end

function RedOutOptions_SetRangeColor()
	local r,g,b = ColorPickerFrame:GetColorRGB();
	local frame = getglobal("RedOutOptions_Range");
	getglobal("RedOutOptions_Range_ColorSwatchNormalTexture"):SetVertexColor(r,g,b);
	frame.r = r;		frame.g = g;		frame.b = b;
	RedOut.Color.r = r;	RedOut.Color.g = g;	RedOut.Color.b = b;
end

function RedOutOptions_CancelRangeColor(original)
	local frame = getglobal("RedOutOptions_Range");
	getglobal("RedOutOptions_Range_ColorSwatchNormalTexture"):SetVertexColor(original.r,original.g,original.b);
	frame.r = original.r;		frame.g = original.g;		frame.b = original.b;
	RedOut.Color.r = original.r;	RedOut.Color.g = original.g;	RedOut.Color.b = original.b;
end

-- 2.4 -- jx: For some reason my brain was not able to find out how to get the proper button from ColorPickerFrame, so I had to make two funcs
--     ++ jx: the ColorPickerFrame's parent is always UIParent for some reason       
function RedOutOptions_SetHotkeyColor()
	local r,g,b = ColorPickerFrame:GetColorRGB();
	local frame = getglobal("RedOutOptions_Hotkey");
	getglobal("RedOutOptions_Hotkey_ColorSwatchNormalTexture"):SetVertexColor(r,g,b);
	frame.r = r;			frame.g = g;			frame.b = b;
	RedOut.HotkeyColor.r = r;	RedOut.HotkeyColor.g = g;	RedOut.HotkeyColor.b = b;
end

function RedOutOptions_CancelHotkeyColor(original)
	local frame = getglobal("RedOutOptions_Hotkey");
	getglobal("RedOutOptions_Hotkey_ColorSwatchNormalTexture"):SetVertexColor(original.r,original.g,original.b);
	frame.r = original.r;			frame.g = original.g;			frame.b = original.b;
	RedOut.HotkeyColor.r = original.r;	RedOut.HotkeyColor.g = original.g;	RedOut.HotkeyColor.b = original.b;
end

-- Saved Variables used in the following function: RedOutProfiles
-- 2.4 -- jx: I have decided every time I come back to add redundant error checking here that I will simply say that I will not check it here. 
--     ++ jx: I will not error check this function. 
--     ++ jx: If this function were ever called at any point in which these variables did not exist, then this shouldn't be happening. I will not error check this function.
function RedOutOptions_Hide()
	-- Set profile to new session settings (save)
	RedOutProfiles[UnitName("player")] = RedOut;
	RedOutOptions:Hide();
end

-- Command parser
function RedOut_Command(arg1)
	RedOutOptions:Show();
end

function RedOutAction_OnLoad()
	--[[
	if ( not RedOutText[GetLocale()] ) then
		-- If no text for locale default to English, United States
		locale = "enUS";
	else
		locale = GetLocale();
	end
	]]
	this:RegisterEvent("PLAYER_LOGIN");

	if ( EquipMonitor ) then	
		this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	end

	SlashCmdList["REDOUTCMD"] = RedOut_Command;
	SLASH_REDOUTCMD1 = "/redout";

	
	Red_Register();
end

function Red_Register()
if ( gLim_RegisterButton ) then
  gLim_RegisterButton (
	REDOUT_TITLE,			
	REDOUT_OPTION,			
	"Interface\\Icons\\Spell_Shadow_DestructiveSoul", 
	function()			
		if ( RedOutOptions:IsShown() ) then
			RedOutOptions:Hide()
		else
			RedOutOptions:Show()
		end
	end,
	2,				
	6				
	);
end
end

local function RedOut_NameFromLink(link)
	local name;
	if( not link ) then
		return nil;
	end
	for name in string.gfind(link, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r") do
		return name;
	end
	return nil;
end

local function RedOut_UpdateEqList()
	-- Cycle eq and update the Eq table
	local item
	for i = 1, getn(equipslots), 1 do
		item = RedOut_NameFromLink(GetInventoryItemLink("player",GetInventorySlotInfo(equipslots[i].name)));
		eq[i] = item;
	end	
end

function RedOutAction_OnEvent(event)
	if( (event=="PLAYER_LOGIN") and (not isLoaded) ) then
		RedOutAction_Setup();
	end
	
	if ( not isLoaded ) then
		return;
	end

	-- Equipment Monitor events	
	if ( EquipMonitor ) then
		if ( ( event == "UNIT_INVENTORY_CHANGED") and ( arg1 == "player" ) ) then
			RedOut_UpdateEqList();
		end
	end
end

-- Note: The saving system uses a separate stored variable for profiles. We initialize all per sessions first, 
--       and then table traverse to override them with the saved profile. This way we can add new extensions or options and
--       the defaults will be created if they don't already exist. Making it far more future friendly.

local function RedOut_LoadPlayerData(i,j)
	RedOut[i] = j;
end

-- Saved Variables used in the following function: RedOutProfiles
function RedOutAction_Setup()
	-- Initialize
	if ( not RedOutProfiles ) then 
		RedOutProfiles = { };	
	end

	-- Set all default per session variables
	RedOutOptions_Defaults();
	
	-- Load Profile
	if ( RedOutProfiles[UnitName("player")] ) then
		-- Override the defaults with saved profile
		-- RedOut = RedOutProfiles[UnitName("player")];
		table.foreach(RedOutProfiles[UnitName("player")], RedOut_LoadPlayerData);
	else
		-- It doesn't exist, initialize it and dump in the defaults
		RedOutProfiles[UnitName("player")] = { };
		RedOutProfiles[UnitName("player")] = RedOut;
	end

	-- Just a string keeping track of what we hook
	local hooks;

	if (type(ActionButton_OnUpdate) == 'function') then
		-- Hook Standard Buttons
		SetHook(RedOutAction_OnUpdate, "ActionButton_OnUpdate");
		SetHook(RedOutAction_UpdateUsable, "ActionButton_UpdateUsable");
		hooks = "Blizzard Bars";
	else
		RedOut.Ext["Blizzard"] = false;
	end

	-- CT Mod
	if (type(CT_ActionButton_OnUpdate) == 'function') then
		SetHook(RedOutAction_CT_OnUpdate, "CT_ActionButton_OnUpdate");
		SetHook(RedOutAction_CT_UpdateUsable, "CT_ActionButton_UpdateUsable");
		if ( hooks ) then hooks = hooks..", "; hooks = hooks.."CT ToolBars"; else hooks = "CT ToolBars"; end
	else
		RedOut.Ext["CTMod"] = false;
	end

	-- Gypsy Bars
	if (type(Gypsy_ActionButtonOnUpdate) == 'function') then
		SetHook(RedOutAction_OnUpdate, "Gypsy_ActionButtonOnUpdate");
		SetHook(RedOutAction_UpdateUsable, "Gypsy_ActionButtonUpdateUsable");
		if ( hooks ) then hooks = hooks..", "; hooks = hooks.."Gypsy Bars"; else hooks = "Gypsy Bars"; end
	else
		RedOut.Ext["Gypsy"] = false;
	end


	-- Telo Sidebar
	if (type(SideBarButton_OnUpdate)== 'function') then
		SetHook(RedOutAction_TS_OnUpdate, "SideBarButton_OnUpdate");
		SetHook(RedOutAction_TS_UpdateUsable, "SideBarButton_UpdateUsable");
		if ( hooks ) then hooks = hooks..", "; hooks = hooks.."Telo's Sidebar"; else hooks = "Telo's Sidebar"; end
	else
		RedOut.Ext["Telo"] = false;
	end
	
	if ( not hooks ) then hooks = "Nothing"; end

	--echo(string.format("Red Out loaded version %.1f, valid extensions:",RedOutVersion),0.0,1.0,0.0);
	--echo("  "..hooks,0.0,1.0,0.0);

	isLoaded = true;
end

-- 2.4 -- jx: I don't quite remember what I was thinking when I wrote this, cause it was a long time ago...
--     ++ jx: I'm thinking the idea is to Retain the color, because when UpdateUsable fires it'll reset the vertex color when doing the mana checks.
function RedOutAction_UpdateUsable(arg)
	if ( not RedOut.Enabled ) or ( not RedOut.Ext["Blizzard"] ) then
		return;
	end

	-- Get the Icon and Normal Texture for the Action Button
	local icon = getglobal(this:GetName().."Icon");
	local normalTexture = getglobal(this:GetName().."NormalTexture");

	if ( IsActionInRange(ActionButton_GetPagedID(this)) == 0 ) then
		if ( RedOut.Hotkey ) then
			local hotkey = getglobal(this:GetName().."HotKey");
			hotkey:SetVertexColor(RedOut.HotkeyColor.r, RedOut.HotkeyColor.g, RedOut.HotkeyColor.b);
		end
		icon:SetVertexColor(RedOut.Color.r, RedOut.Color.g, RedOut.Color.b);
		normalTexture:SetVertexColor(RedOut.Color.r, RedOut.Color.g, RedOut.Color.b);
	else
		-- Check if its usable
		local isUsable, notEnoughMana = IsUsableAction(ActionButton_GetPagedID(this));

		if ( isUsable ) then
			icon:SetVertexColor(1.0, 1.0, 1.0);
			normalTexture:SetVertexColor(1.0, 1.0, 1.0);
		elseif ( notEnoughMana ) then
			icon:SetVertexColor(0.5, 0.5, 1.0);
			normalTexture:SetVertexColor(0.5, 0.5, 1.0);
		else
			icon:SetVertexColor(0.4, 0.4, 0.4);
			normalTexture:SetVertexColor(1.0, 1.0, 1.0);
		end
	end

	if ( EquipMonitor ) then
		RedOutTooltip:SetAction(ActionButton_GetPagedID(this));
		local text = RedOutTooltipTextLeft1:GetText();
		local item = RedOutTooltipTextLeft2:GetText();
		
		if ( item == "Soulbound" ) then
			for i = 1, getn(equipslots), 1 do
				if ( not text ) then
					text = "n/a";
				end
				if ( text == eq[i] ) then
					this:SetChecked(1);
				end
			end
		end
	end
end

function RedOutAction_TS_UpdateUsable(arg)
	if ( not RedOut.Enabled ) or ( not RedOut.Ext["Telo"] ) then
		return;
	end

	-- Get the Icon and Normal Texture for the Action Button
	local icon = getglobal(this:GetName().."Icon");
	local normalTexture = getglobal(this:GetName().."NormalTexture");

	if ( IsActionInRange(SideBarButton_GetID(this)) == 0 ) then
		if ( RedOut.Hotkey ) then
			local hotkey = getglobal(this:GetName().."HotKey");
			hotkey:SetVertexColor(RedOut.HotkeyColor.r, RedOut.HotkeyColor.g, RedOut.HotkeyColor.b);
		end
		icon:SetVertexColor(RedOut.Color.r, RedOut.Color.g, RedOut.Color.b);
		normalTexture:SetVertexColor(RedOut.Color.r, RedOut.Color.g, RedOut.Color.b);
	else
		-- Check if its usable 
		local isUsable, notEnoughMana = IsUsableAction(SideBarButton_GetID(this));

		if ( isUsable ) then
			icon:SetVertexColor(1.0, 1.0, 1.0);
			normalTexture:SetVertexColor(1.0, 1.0, 1.0);
		elseif ( notEnoughMana ) then
			icon:SetVertexColor(0.5, 0.5, 1.0);
			normalTexture:SetVertexColor(0.5, 0.5, 1.0);
		else
			icon:SetVertexColor(0.4, 0.4, 0.4);
			normalTexture:SetVertexColor(1.0, 1.0, 1.0);
		end
	end
end

function RedOutAction_CT_UpdateUsable(arg)
	if ( not RedOut.Enabled ) or ( not RedOut.Ext["CTMod"] ) then
		return;
	end

	-- Get the Icon and Normal Texture for the Action Button
	local icon = getglobal(this:GetName().."Icon");
	local normalTexture = getglobal(this:GetName().."NormalTexture");

	if ( IsActionInRange(CT_ActionButton_GetPagedID(this)) == 0 ) then
		if ( RedOut.Hotkey ) then
			local hotkey = getglobal(this:GetName().."HotKey");
			hotkey:SetVertexColor(RedOut.HotkeyColor.r, RedOut.HotkeyColor.g, RedOut.HotkeyColor.b);
		end
		icon:SetVertexColor(RedOut.Color.r, RedOut.Color.g, RedOut.Color.b);
		normalTexture:SetVertexColor(RedOut.Color.r, RedOut.Color.g, RedOut.Color.b);
	else
		-- Check if its usable 
		local isUsable, notEnoughMana = IsUsableAction(CT_ActionButton_GetPagedID(this));
	
		if ( isUsable ) then
			icon:SetVertexColor(1.0, 1.0, 1.0);
			normalTexture:SetVertexColor(1.0, 1.0, 1.0);
		elseif ( notEnoughMana ) then
			icon:SetVertexColor(0.5, 0.5, 1.0);
			normalTexture:SetVertexColor(0.5, 0.5, 1.0);
		else
			icon:SetVertexColor(0.4, 0.4, 0.4);
			normalTexture:SetVertexColor(1.0, 1.0, 1.0);
		end
	end
end

-- Update Function, sent elapsed time since last update (ms)
function RedOutAction_OnUpdate(self,elapsed)
	if ( not RedOut.Enabled ) or ( not RedOut.Ext["Blizzard"] ) then
		return;
	end

	-- Original Func is run in the inline function of SetHook

	if ( this.redoutTimer ) then
		this.redoutTimer = this.redoutTimer - elapsed;
		if ( this.redoutTimer < 0 ) then
			-- Get the Icon and Normal Texture for the Action Button
			local icon = getglobal(this:GetName().."Icon");
			local normalTexture = getglobal(this:GetName().."NormalTexture");

			if ( IsActionInRange(ActionButton_GetPagedID(this)) == 0 ) then
				if ( RedOut.Hotkey ) then
					local hotkey = getglobal(this:GetName().."HotKey");
					hotkey:SetVertexColor(RedOut.HotkeyColor.r, RedOut.HotkeyColor.g, RedOut.HotkeyColor.b);
				end
				icon:SetVertexColor(RedOut.Color.r, RedOut.Color.g, RedOut.Color.b);
				normalTexture:SetVertexColor(RedOut.Color.r, RedOut.Color.g, RedOut.Color.b);
			else
				-- Check if its usable
				local isUsable, notEnoughMana = IsUsableAction(ActionButton_GetPagedID(this));

				if ( isUsable ) then
					icon:SetVertexColor(1.0, 1.0, 1.0);
					normalTexture:SetVertexColor(1.0, 1.0, 1.0);
				elseif ( notEnoughMana ) then
					icon:SetVertexColor(0.5, 0.5, 1.0);
					normalTexture:SetVertexColor(0.5, 0.5, 1.0);
				else
					icon:SetVertexColor(0.4, 0.4, 0.4);
					normalTexture:SetVertexColor(1.0, 1.0, 1.0);
				end
			end
			this.redoutTimer = RedOut.Interval;
		end
	else
		if ( this.rangeTimer ) then
			this.redoutTimer = RedOut.Interval;
		end
	end
end

function RedOutAction_CT_OnUpdate(elapsed)
	if ( not RedOut.Enabled ) or ( not RedOut.Ext["CTMod"] ) then
		return;
	end

	-- Original Func is run in the inline function of SetHook

	if ( this.redoutTimer ) then
		this.redoutTimer = this.redoutTimer - elapsed;
		if ( this.redoutTimer < 0 ) then
			-- Get the Icon and Normal Texture for the Action Button
			local icon = getglobal(this:GetName().."Icon");
			local normalTexture = getglobal(this:GetName().."NormalTexture");

			if ( IsActionInRange(CT_ActionButton_GetPagedID(this)) == 0 ) then
				if ( RedOut.Hotkey ) then
					local hotkey = getglobal(this:GetName().."HotKey");
					hotkey:SetVertexColor(RedOut.HotkeyColor.r, RedOut.HotkeyColor.g, RedOut.HotkeyColor.b);
				end
				icon:SetVertexColor(RedOut.Color.r, RedOut.Color.g, RedOut.Color.b);
				normalTexture:SetVertexColor(RedOut.Color.r, RedOut.Color.g, RedOut.Color.b);
			else
				-- Check if its usable
				local isUsable, notEnoughMana = IsUsableAction(CT_ActionButton_GetPagedID(this));

				if ( isUsable ) then
					icon:SetVertexColor(1.0, 1.0, 1.0);
					normalTexture:SetVertexColor(1.0, 1.0, 1.0);
				elseif ( notEnoughMana ) then
					icon:SetVertexColor(0.5, 0.5, 1.0);
					normalTexture:SetVertexColor(0.5, 0.5, 1.0);
				else
					icon:SetVertexColor(0.4, 0.4, 0.4);
					normalTexture:SetVertexColor(1.0, 1.0, 1.0);
				end
			end
		end
	else
		if ( this.rangeTimer ) then
			this.redoutTimer = RedOut.Interval;
		end
	end
end

-- Telo Sidebar Update Function, sent elapsed time since last update (ms)
function RedOutAction_TS_OnUpdate(elapsed)
	if ( not RedOut.Enabled ) or ( not RedOut.Ext["Telo"] ) then
		return;
	end

	-- Original Func is run in the inline function of SetHook

	if ( this.redoutTimer ) then
		this.redoutTimer = this.redoutTimer - elapsed;
		if ( this.redoutTimer < 0 ) then
			-- Get the Icon and Normal Texture for the Action Button
			local icon = getglobal(this:GetName().."Icon");
			local normalTexture = getglobal(this:GetName().."NormalTexture");

			if ( IsActionInRange(SideBarButton_GetID(this)) == 0 ) then
				if ( RedOut.Hotkey ) then
					local hotkey = getglobal(this:GetName().."HotKey");
					hotkey:SetVertexColor(RedOut.HotkeyColor.r, RedOut.HotkeyColor.g, RedOut.HotkeyColor.b);
				end
				icon:SetVertexColor(RedOut.Color.r, RedOut.Color.g, RedOut.Color.b);
				normalTexture:SetVertexColor(RedOut.Color.r, RedOut.Color.g, RedOut.Color.b);
			else
				-- Check if its usable
				local isUsable, notEnoughMana = IsUsableAction(SideBarButton_GetID(this));

				if ( isUsable ) then
					icon:SetVertexColor(1.0, 1.0, 1.0);
					normalTexture:SetVertexColor(1.0, 1.0, 1.0);
				elseif ( notEnoughMana ) then
					icon:SetVertexColor(0.5, 0.5, 1.0);
					normalTexture:SetVertexColor(0.5, 0.5, 1.0);
				else
					icon:SetVertexColor(0.4, 0.4, 0.4);
					normalTexture:SetVertexColor(1.0, 1.0, 1.0);
				end
			end
		end
	else
		if ( this.rangeTimer ) then
			this.redoutTimer = RedOut.Interval;
		end
	end

end

