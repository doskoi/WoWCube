-- TipBuddy: Copyright 2004 by Chester --

local lGameTooltip_OnEvent_Orig;
local lGameTooltip_OnShow_Orig;

function TipBuddy_OnLoad()
--	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_LOGIN");

	this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	this:RegisterEvent("UNIT_LEVEL");
	this:RegisterEvent("UNIT_FACTION");
	this:RegisterEvent("UNIT_DYNAMIC_FLAGS");
	this:RegisterEvent("UNIT_CLASSIFICATION_CHANGED");
	this:RegisterEvent("PLAYER_PVPLEVEL_CHANGED");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("PLAYER_FLAGS_CHANGED");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_MAXHEALTH");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_RAGE");
	this:RegisterEvent("UNIT_FOCUS");
	this:RegisterEvent("UNIT_ENERGY");
	this:RegisterEvent("UNIT_HAPPINESS");
	this:RegisterEvent("UNIT_MAXMANA");
	this:RegisterEvent("UNIT_MAXRAGE");
	this:RegisterEvent("UNIT_MAXFOCUS");
	this:RegisterEvent("UNIT_MAXENERGY");
	this:RegisterEvent("UNIT_MAXHAPPINESS");
	this:RegisterEvent("UNIT_DISPLAYPOWER");
	this:RegisterEvent("UNIT_PVP_UPDATE");
	this:RegisterEvent("UPDATE_SHAPESHIFT_FORMS");

	SlashCmdList["TIPBUDDY"] = TipBuddy_SlashCommand;
	SLASH_TIPBUDDY1 = "/tipbuddy";
	SLASH_TIPBUDDY2 = "/tbuddy";
	SLASH_TIPBUDDY3 = "/tip";

	-- commented out cause it fucked up my buttons
	-- Add TipBuddy_OptionsFrame to the UIPanelWindows list
	--UIPanelWindows["TipBuddy_OptionsFrame"] = { area = "center", pushable = 0 };
end

--------------------------------------------------------------------------------------------------------
--                                          OnEvent Handler                                           --
--------------------------------------------------------------------------------------------------------
function TipBuddy_OnEvent()
	-- Variables Loaded
	--if (event == "ADDON_LOADED" and arg1 == "TipBuddy" ) then
	if (event == "VARIABLES_LOADED" ) then
		TipBuddy_Variable_Initialize();
		TipBuddy_Register();
		TipBuddy_InitializeTextColors();
		TB_GameTooltip_IniHooks();
		TipBuddy.uiscale = TipBuddy_GetUIScale();

		if (TipBuddy_SavedVars["general"].framepos_L or TipBuddy_SavedVars["general"].framepos_T) then
			TipBuddy_Header_Frame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", TipBuddy_SavedVars["general"].framepos_L, TipBuddy_SavedVars["general"].framepos_T);
		end
		--if (not TipBuddy_SavedVars["general"].delaytime) then
		--	TipBuddy_SavedVars["general"].delaytime = "0.5";
		--end
		--if (not TipBuddy_SavedVars["general"].fadetime) then
		--	TipBuddy_SavedVars["general"].fadetime = "0.3";
		--end
		--if (not TipBuddy_SavedVars["general"].gtt_anchored) then
		--	TipBuddy_SavedVars["general"].gtt_anchored = 0;
		--end

		-- Init Anchor
		if (TipBuddy_SavedVars["general"].anchored == 1) then
			if (not TipBuddy_SavedVars["general"].anchor_vis_first or TipBuddy_SavedVars["general"].anchor_vis == 1) then
				TipBuddy_SavedVars["general"].anchor_vis_first = 1;
				TipBuddy_Header_Frame:Show();
			else
				TipBuddy_Header_Frame:Show();
				TipBuddy_Header_Frame:Hide();
			end
			TipBuddy.anchor, TipBuddy.fanchor, TipBuddy.offset = TipBuddy_GetFrameAnchorPos();
			this:SetPoint(TipBuddy.anchor,"TipBuddy_Header_Frame",TipBuddy.fanchor,0,1);
		elseif (not TipBuddy_SavedVars["general"].anchor_vis_first) then
			TipBuddy_ResetAnchorPos();
			TipBuddy_Header_Frame:Hide();
		else
			TipBuddy_Header_Frame:Show();
			TipBuddy_Header_Frame:Hide();
		end
		-- Loaded
		-- TipBuddy_Msg("Version |1"..TIPBUDDY_VERSION.."|r Loaded.");
	-- Player Login
	elseif (event == "PLAYER_LOGIN") then
		-- Add TipBuddy to myAddOns addons list
		if (myAddOnsFrame) then
			myAddOnsList.TipBuddy = {
					name = "|cff20ff20TipBuddy",
					description = "Enhanced, configurable unit tooltip.",
					version = "|cffffff00"..TIPBUDDY_VERSION,
					author = "chester",
					email = "chester.dent@gmail.com",
					category = MYADDONS_CATEGORY_OTHERS,
					frame = "TipBuddy_OptionsFrame",
					optionsframe = "TipBuddy_OptionsFrame"
					};
		end

		--local BackdropGlow = {bgFile = "Interface\\AddOns\\TipBuddy\\gfx\\UI-Tooltip-Background", edgeFile = "Interface\\AddOns\\TipBuddy\\gfx\\Glow-Border", edgeSize = 22, insets = { left = 5, right = 5, top = 5, bottom = 5 }};
		--local BackdropInfoPanel = {bgFile="Interface\\AddOns\\TipBuddy\\gfx\\UI-Tooltip-Background",edgeFile="Interface\\AddOns\\TipBuddy\\gfx\\InfoPanel-Border",tile=true,tileSize=32,edgeSize=14,insets={ left = 4, right = 4, top = 4, bottom = 4 }};

		--local BackdropTextPanel = {bgFile="Interface\\AddOns\\TipBuddy\\gfx\\UI-Tooltip-Background",edgeFile="Interface\\Glues\\Common\\TextPanel-Border",tile=true,tileSize=32,edgeSize=22,insets={ left = 5, right = 5, top = 5, bottom = 5 }};
		--local BackdropRounded = {bgFile = "Interface\\AddOns\\TipBuddy\\gfx\\UI-Tooltip-Background", edgeFile = "Interface\\Minimap\\TooltipBackdrop", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }};
		--local BackdropDialogueBox = {bgFile="Interface\\AddOns\\TipBuddy\\gfx\\UI-Tooltip-Background",edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 16, edgeSize = 20, insets = { left = 5, right = 5, top = 5, bottom = 5 }};

		--local BackdropNormal = {bgFile="Interface\\Tooltips\\UI-Tooltip-Background",edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",tile=true,tileSize=32,edgeSize=16,insets={ left = 4, right = 4, top = 4, bottom = 4 }};
		local BackdropDefault = {bgFile="Interface\\AddOns\\TipBuddy\\gfx\\UI-Tooltip-Background",edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",tile=true,tileSize=32,edgeSize=16,insets={ left = 4, right = 4, top = 4, bottom = 4 }};

		TipBuddy.xpoint, TipBuddy.xpos, TipBuddy.ypos = TipBuddy_GetFrameCursorOffset();
		TipBuddy.anchor, TipBuddy.fanchor, TipBuddy.offset = TipBuddy_GetFrameAnchorPos();
		-- Init GTT
		GameTooltip:SetOwner(UIParent,"ANCHOR_RIGHT");
		GameTooltip:SetPoint("BOTTOM","TipBuddy_Parent_Frame","CENTER",0,0);
		GameTooltip:SetText(" ");
		GameTooltip:SetBackdrop(BackdropDefault);
		GameTooltip:Hide();
		-- Init TBTT
		TipBuddyTooltip:SetOwner(UIParent,"ANCHOR_RIGHT");
		TipBuddyTooltip:SetPoint("BOTTOM","TipBuddy_Parent_Frame","CENTER",0,0);
		TipBuddyTooltip:SetText(" ");
		TipBuddyTooltip:SetBackdrop(BackdropDefault);
		TipBuddyTooltip:Hide();
		-- MainFrame
		TipBuddy_Main_Frame:SetBackdrop({bgFile="Interface\\AddOns\\TipBuddy\\gfx\\UI-Tooltip-Background",edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",tile=true,tileSize=32,edgeSize=8,insets={ left = 2, right = 2, top = 2, bottom = 2 }});

--/script TipBuddyTooltip:SetOwner(TipBuddy_Parent_Frame); TipBuddyTooltip:SetPoint("BOTTOM", "TipBuddy_Parent_Frame", "CENTER", 0, 0); TipBuddyTooltip:SetText("player");
--/script TipBuddyTooltip:SetOwner(TipBuddy_Parent_Frame); TipBuddyTooltip:SetPoint("BOTTOM", "TipBuddy_Parent_Frame"); TipBuddyTooltip:SetText("player");
--/script TipBuddyTooltip:SetPoint("BOTTOM", "TipBuddy_Parent_Frame", "CENTER", 0, 0);

	-- New unit under the mouse.
	-- The "mouseover" unit does not generate events like normal units (target, party3 etc.) except UPDATE_MOUSEOVER_UNIT when set
	elseif (event == "UPDATE_MOUSEOVER_UNIT") then
		if (UnitExists("mouseover")) then
			TipBuddy.hasTarget = 1;
			TipBuddy_ShowUnitTooltip("mouseover");
		end
	-- Special Changes
	elseif (event == "UNIT_LEVEL" or event == "UNIT_FACTION" or event == "PLAYER_PVPLEVEL_CHANGED" or event == "UNIT_DYNAMIC_FLAGS" or event == "UNIT_MAXHEALTH") then
		if (TipBuddy.targetUnit) and (UnitIsUnit(TipBuddy.targetUnit,arg1 or "")) then
			TipBuddy_ShowUnitTooltip(TipBuddy.targetUnit);
		end
	-- Unit Buff Change
	elseif (event == "UNIT_AURA") then
		if (TipBuddy.targetUnit) and (UnitIsUnit(TipBuddy.targetUnit,arg1 or "")) then
			TipBuddy_TargetBuffs_Update(TipBuddy.targetType,arg1);
		end
	-- Health Change
	elseif (event == "UNIT_HEALTH") then
		if (TipBuddy.targetUnit) and (UnitIsUnit(TipBuddy.targetUnit,arg1 or "")) then
			-- New unit tip if unit died
			if (UnitHealth(arg1) <= 0) then
				TipBuddy_ShowUnitTooltip("mouseover");
			-- Otherwise just update the bars
			elseif (TipBuddy.compactvis) then
				TipBuddy_UpdateHealthText(TipBuddy_HealthText,TipBuddy.targetType,arg1);
				TipBuddy_UpdateManaText(TipBuddy_ManaText,TipBuddy.targetType,arg1);
				TipBuddy_TargetInfo_FindExtras(arg1);
			else
				TipBuddyTooltipStatusBar:SetValue(UnitHealth(arg1));

				TipBuddy_UpdateHealthText(TipBuddy_HealthTextGTT,TipBuddy.targetType,arg1);
				TipBuddy_UpdateManaText(TipBuddy_ManaTextGTT,TipBuddy.targetType,arg1);
			end
		end
	-- Mana, Energy, Rage etc. change
	elseif (event == "UNIT_MANA" or event == "UNIT_RAGE" or event == "UNIT_FOCUS" or event == "UNIT_ENERGY" or event == "UNIT_HAPPINESS" or
			event == "UNIT_MAXMANA" or event == "UNIT_MAXRAGE" or event == "UNIT_MAXFOCUS" or event == "UNIT_MAXENERGY" or
			event == "UNIT_MAXHAPPINESS" or event == "UNIT_DISPLAYPOWER" or event == "UPDATE_SHAPESHIFT_FORMS") then
		if (TipBuddy.targetUnit) and (UnitIsUnit(TipBuddy.targetUnit,arg1 or "")) then
			if ( TipBuddy_SavedVars[TipBuddy.targetType].off and TipBuddy_SavedVars[TipBuddy.targetType].off ~= 0) then
				TipBuddy_SetFrame_Visibility(TipBuddy.targetType,arg1,1);
				TipBuddy_SetFrame_BackgroundColor(TipBuddy.targetType,arg1);
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------
--                                           Slash Handler                                            --
--------------------------------------------------------------------------------------------------------
function TipBuddy_SlashCommand(cmd)
	-- No paramter, Open option frame
	if (not cmd or cmd == "") then
		if (TipBuddy_ToggleOptionsFrame) then
			TipBuddy_ToggleOptionsFrame();
		else
			TipBuddy_Msg("OptionsFrame not Initialized!");
		end
	-- Reset Anchor
	elseif (cmd == "resetanchor") then
		TipBuddy_ResetAnchorPos();
		TipBuddy_Msg("Resetting TipBuddyAnchor Position.");
	-- Scale
	elseif (string.find(cmd,"scale") ~= nil) then
		--local i, s = string.find(cmd, "%d+");
		local scale;
		for s in string.gmatch(cmd,"scale%s(%d.*)") do
			scale = tonumber(s);
		end
		if (scale) then
			if (scale > 2) then
				scale = 2;
			elseif (scale < 0.25) then
				scale = 0.25;
			end
			GameTooltip:SetScale(2);
			TipBuddyTooltip:SetScale(2);
			--GameTooltip:SetScale(UIParent:GetScale() * TipBuddy.s);
			TipBuddy_SetEffectiveScale(GameTooltip, scale, UIParent);
			TipBuddy_SetEffectiveScale(TipBuddyTooltip, scale, UIParent);
			--TipBuddy_SavedVars["general"].gtt_scale = (UIParent:GetScale() * TipBuddy.s);
			TipBuddy_SavedVars["general"].gtt_scale = scale;
		else
			TipBuddy_Msg("Please type a scale number after 'scale' (valid numbers: 0.25-2)");
		end
		return;
	-- Blizzard tips
	elseif (cmd == "blizdefault") then
		if (TipBuddy_SavedVars["general"].blizdefault == 1) then
			TipBuddy_SavedVars["general"].blizdefault = 0;
			TipBuddy_Msg("Default tooltips are now enhanced.");
		else
			TipBuddy_SavedVars["general"].blizdefault = 1;
			TipBuddy_Msg("Default tooltips are no longer enhanced.");
		end
	-- Extras
	elseif (string.find(cmd,"extras")) then
		local type = nil;
		for foundType in string.gmatch(cmd,"extras%s(.+)") do
			type = TipBuddy_ToggleExtras(foundType);
		end
		if (not type) then
			TipBuddy_Msg("Please specify |1on|r, |1off|r or a target type (ex: |1/tip extras pc_friend|2)");
			return;
		end
		return;
	-- TEST: Report
	elseif (cmd == "report") then
		TipBuddy_ReportVarStats();
	-- TEST: GTTText
	elseif (cmd == "gtttext") then
		local text, lineL, lineR;
		for i = 1, GameTooltip:NumLines() do
			lineL = getglobal("GameTooltipTextLeft"..i):GetText();
			lineR = getglobal("GameTooltipTextRight"..i):GetText();
			text = "";
			if (lineL) and (lineL ~= "") then
				text = "|1"..lineL.."|r"
			end
			if (lineR) and (lineR ~= "") then
				text = text.."  |2"..lineR.."|r"
			end
			TipBuddy_Msg(text);
		end
	-- TEST: Debugging
	elseif (cmd == "debug") then
		TipBuddy_SavedVars.debug = not TipBuddy_SavedVars.debug;
		TipBuddy_Msg("Debugging is now turned |1"..(TipBuddy_SavedVars.debug and "|cff80ff80On" or "|cffff8080Off").."|r.");
	-- TEST: targetType
	elseif (cmd == "type") then
		TipBuddy_Msg("Target Unit Type = |1"..TipBuddy_TargetInfo_GetTargetType("target").."|r.");
	-- Invalid or No Paramter
	else
		TipBuddy_Msg("Valid slash command parameters:");
		TipBuddy_Msg(" |2resetanchor|r = Resets the tooltip anchor position");
		TipBuddy_Msg(" |2scale 'value'|r = Sets the scale of the tooltips");
		TipBuddy_Msg(" |2blizdefault|r = Use default Blizzard tooltips");
		TipBuddy_Msg(" |2extras 'on/off/type'|r = Copy extra tooltip lines added by abilities and mods (e.g. Beast Lore)");
	end
end

--------------------------------------------------------------------------------------------------------
--                                         Show Unit Tooltip                                          --
--------------------------------------------------------------------------------------------------------
function TipBuddy_ShowUnitTooltip(unit,refresh)
	-- If we have a new unit, get their stats first
	if (not refresh) then
		TipBuddy.targetUnit = unit;
		TipBuddy.uName, TipBuddy.uRealm = UnitName(unit);
		TipBuddy.uLevel = UnitLevel(unit);
		TipBuddy.uClass = UnitClass(unit);
		TipBuddy.uRace = UnitRace(unit);
		TipBuddy.uGuild = GetGuildInfo(unit);
		TipBuddy.uReaction = TipBuddy_GetUnitReaction(unit);
		TipBuddy.targetType = TipBuddy_TargetInfo_GetTargetType(unit);
	end
	-- Update
	TipBuddy_SetFrame_Visibility(TipBuddy.targetType,unit,refresh);
	TipBuddy_SetFrame_BackgroundColor(TipBuddy.targetType,unit);
	TipBuddy_ShowRank(TipBuddy.targetType,unit);
	TipBuddy_TargetBuffs_Update(TipBuddy.targetType,unit);
end

--------------------------------------------------------------------------------------------------------
--                                         Get Target Type                                            --
--------------------------------------------------------------------------------------------------------
function TipBuddy_TargetInfo_GetTargetType(unit)
	-- Corpse
	if (UnitHealth(unit) <= 0) then
		return "corpse";
	-- Alive unit
	elseif (UnitHealthMax(unit) > 0) then
		-- UnitPlayerControlled() returns 1 even for pets and totems. But can return nil if unit is out of range, UnitIsPlayer() dont do that.
		if (UnitIsPlayer(unit)) or (UnitPlayerControlled(unit)) then
			if (UnitIsFriend(unit,"player")) then
				if (UnitIsUnit(unit,"pet") or TipBuddy_TargetInfo_CheckPet()) then
					return "pet_friend";
				elseif (UnitInParty(unit)) then
					return "pc_party";
				else
					return "pc_friend";
				end
			elseif (UnitIsEnemy(unit,"player")) then
				if (TipBuddy_TargetInfo_CheckPet()) then
					return "pet_enemy";
				else
					return "pc_enemy";
				end
			else
				return "pet_friend";
			end
		-- Non player units
		else
			if (UnitIsFriend(unit,"player")) then
				if (TipBuddy_TargetInfo_CheckPet()) then
					return ("pet_friend");
				else
					return ("npc_friend");
				end
			elseif (UnitIsEnemy(unit,"player")) then
				if (TipBuddy_TargetInfo_CheckPet()) then
					return ("pet_enemy");
				else
					return ("npc_enemy");
				end
			else
				return ("npc_neutral");
			end
		end
	-- No unit, hide
	else
		TipBuddy_Hide(TipBuddy_Main_Frame);
		return;
	end
end

-- Check if unit is a pet
function TipBuddy_TargetInfo_CheckPet()
	local tipText;
	for i = 1, GameTooltip:NumLines() do
		tipText = getglobal("GameTooltipTextLeft"..i):GetText();
		if (tipText) and (string.find(tipText,TB_pet) or string.find(tipText,TB_minion) or
			string.find(tipText,TB_guardian) or string.find(tipText,TB_creation)) then
			return 1;
		end
	end
	return;
end

--------------------------------------------------------------------------------------------------------
--                                             Get Extras                                             --
--------------------------------------------------------------------------------------------------------
function TipBuddy_TargetInfo_FindExtras(unit)
	TipBuddy_GTT_GetExtraLines(20,unit);
	TipBuddy_TargetInfo_ShowExtras();
end

function TipBuddy_TargetInfo_ShowExtras()
	if (TipBuddy.gtt_xtra) then
		-- clear all extra lines
		for i = 1, 20 do
			getglobal("TipBuddy_Xtra"..i.."_Text"):Hide();
			getglobal("TipBuddy_Xtra"..i.."_Text"):SetText("");
			getglobal("TipBuddy_XtraR"..i.."_Text"):Hide();
			getglobal("TipBuddy_XtraR"..i.."_Text"):SetText("");
		end
		-- add extra lines
		local lineL, lineR;
		for i = 1, table.getn(TipBuddy.gtt_xtra) do
			-- left text
			lineL = getglobal("TipBuddy_Xtra"..i.."_Text");
			if (TipBuddy.gtt_xtra[i.."color"]) then
				lineL:SetVertexColor(TipBuddy.gtt_xtra[i.."color"].r,TipBuddy.gtt_xtra[i.."color"].g,TipBuddy.gtt_xtra[i.."color"].b);
			else
				lineL:SetTextColor(HIGHLIGHT_FONT_COLOR.r,HIGHLIGHT_FONT_COLOR.g,HIGHLIGHT_FONT_COLOR.b);
			end
			lineL:SetText(TEXT(TipBuddy.gtt_xtra[i]));
			lineL:Show();
			-- right text
			if (TipBuddy.gtt_xtraR) then
				lineR = getglobal("TipBuddy_XtraR"..i.."_Text");
				if (TipBuddy.gtt_xtraR[i.."color"]) then
					lineR:SetVertexColor(TipBuddy.gtt_xtraR[i.."color"].r,TipBuddy.gtt_xtraR[i.."color"].g,TipBuddy.gtt_xtraR[i.."color"].b);
				else
					lineR:SetTextColor(HIGHLIGHT_FONT_COLOR.r,HIGHLIGHT_FONT_COLOR.g,HIGHLIGHT_FONT_COLOR.b);
				end
				lineR:SetText(TEXT(TipBuddy.gtt_xtraR[i]));
				lineR:Show();
			end
		end
	end
end

function TipBuddy_GTT_GetExtraLines(numlines,unit)
	if (not numlines) then
		return;
	end
	-- Initialize
	TipBuddy.gtt_xtra = {};
	TipBuddy.gtt_xtraR = {};
	if (not TipBuddy.gtt_lastline) then
		if (GameTooltip:IsVisible()) then
			TipBuddy.gtt_lastline = GameTooltip:NumLines();
		else
			TipBuddy.gtt_lastline = 2;
		end
	end
	--TB_DebugMsg("!! lastline: "..TipBuddy.gtt_lastline..", numlines (stored): "..TipBuddy.gtt_numlines..", numlines (real): "..GameTooltip:NumLines());
	if (numlines > TipBuddy.gtt_lastline) then
		--TB_DebugMsg("numlines > TipBuddy.gtt_lastline");
		--/script GameTooltipTextLeft1:SetText(GameTooltipTextLeft1:GetText().."\nSecondLine");GameTooltip:Show();
		local line, lineR;
		local j = 1;
		for i = TipBuddy.gtt_lastline + 1, numlines do
			line = getglobal("GameTooltipTextLeft"..i);
			lineR = getglobal("GameTooltipTextRight"..i);
			if (not line or not line:GetText() or string.find(line:GetText(),PVP_ENABLED)) then
				return;
			else
				TipBuddy.gtt_xtra[j.."color"] = {};
				TipBuddy.gtt_xtra[j.."color"].r, TipBuddy.gtt_xtra[j.."color"].g, TipBuddy.gtt_xtra[j.."color"].b = line:GetTextColor();
				TipBuddy.gtt_xtra[j] = line:GetText();
			end
			--GREEN_FONT_COLOR_CODE..PVP_RANK_CIVILIAN..FONT_COLOR_CODE_CLOSE
			if (lineR:GetText()) and (lineR:IsShown()) then
				TipBuddy.gtt_xtraR[j.."color"] = {};
				TipBuddy.gtt_xtraR[j.."color"].r, TipBuddy.gtt_xtraR[j.."color"].g, TipBuddy.gtt_xtraR[j.."color"].b = lineR:GetTextColor();
				TipBuddy.gtt_xtraR[j] = lineR:GetText();
			else
				TipBuddy.gtt_xtraR[j] = "";
			end
			--TB_DebugMsg(line:GetText());
			j = j + 1;
			--/script --TB_DebugMsg(GameTooltipTextLeft2:GetText());
		end
	else
		return;
	end
end

function TipBuddy_GTT_AddExtras()
	if (TipBuddy.gtt_xtra) then
		for i = 1, table.getn(TipBuddy.gtt_xtra) do
			-- copy colors
			local lCr, lCg, lCb, rCr, rCg, rCb;
			if (TipBuddy.gtt_xtra[i.."color"]) then
				lCr, lCg, lCb = TipBuddy.gtt_xtra[i.."color"].r, TipBuddy.gtt_xtra[i.."color"].g, TipBuddy.gtt_xtra[i.."color"].b;
			else
				lCr, lCg, lCb = HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b;
			end
			if (TipBuddy.gtt_xtraR and TipBuddy.gtt_xtraR[i.."color"]) then
				rCr, rCg, rCb = TipBuddy.gtt_xtraR[i.."color"].r, TipBuddy.gtt_xtraR[i.."color"].g, TipBuddy.gtt_xtraR[i.."color"].b;
			else
				rCr, rCg, rCb = HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b;
			end
			-- add lines
			if (TipBuddy.gtt_xtraR) then
				TipBuddyTooltip:AddDoubleLine(TipBuddy.gtt_xtra[i], TipBuddy.gtt_xtraR[i], lCr, lCg, lCb, rCr, rCg, rCb);
			else
				TipBuddyTooltip:AddLine(TipBuddy.gtt_xtra[i], lCr, lCg, lCb);
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------
--                                             Visibility                                             --
--------------------------------------------------------------------------------------------------------

-- Target Types are:
-- pc_friend, pc_party, pc_enemy
-- npc_friend, npc_neutral, npc_enemy
-- pet_friend, pet_enemy

function TipBuddy_SetFrame_Visibility(type,unit,refresh)
	local targettype = TipBuddy_SavedVars[type];
	if (not targettype) then
		TipBuddy_SetFrame_BackgroundColor("corpse",unit);
		return;
	end

	if (TipBuddy_SavedVars["general"].blizdefault == 0) then
		if (targettype.off == 1) then
			TipBuddy_ForceHide(TipBuddy_Main_Frame);
			if (not TipBuddy_Main_Frame:IsVisible()) then
				TipBuddy_Main_Frame:Show();
				TipBuddy_Main_Frame:SetAlpha(1);
			end
			TipBuddy.compactvis = 1;
		else
			TipBuddy_ForceHide(TipBuddy_Main_Frame);
		end
	end

	TipBuddy_SetFrame_TargetType(type,unit,refresh);
	TipBuddy.vis = 1;
	TipBuddy.gotextras = 1;
end

--------------------------------------------------------------------------------------------------------
--                                             Check Name                                             --
--------------------------------------------------------------------------------------------------------
function TipBuddy_TargetInfo_CheckName(type,unit)
	TipBuddy.gtt_namecolor = "";
	local targettype = TipBuddy_SavedVars[type];
	if (targettype.off == 2) then
		return;
	end
	-- NameColor
	if (UnitHealth(unit) <= 0) then
		TipBuddy.gtt_namecolor = tbcolor_corpse;
	elseif (TipBuddy.uReaction) then
		TipBuddy.gtt_namecolor = getglobal("tbcolor_nam_"..TipBuddy.uReaction);
	elseif (UnitIsTapped(unit)) and (not UnitIsTappedByPlayer(unit)) then
		TipBuddy.gtt_namecolor = tbcolor_nam_tappedother.." >";
	elseif (UnitIsTappedByPlayer(unit)) then
		TipBuddy.gtt_namecolor = tbcolor_nam_tappedplayer;
	else
		TipBuddy.gtt_namecolor = tbcolor_unknown;
	end
	-- Refresh
	if (TipBuddy.refresh == 1) and (TipBuddy.gtt_name) then
		GameTooltip:Hide();
		return;
	end
	-- Player specific stuff
	if (UnitIsPlayer(unit)) then
		-- PVP Rank
		if (targettype.rnm == 1) and (UnitPVPName(unit)) then
			TipBuddy.gtt_name = UnitPVPName(unit);
		end
		-- Az 2006.12.11: AFK and DND support (no option yet)
		if (UnitIsAFK(unit)) then
			TipBuddy.gtt_status = "<AFK> "
		elseif (UnitIsDND(unit)) then
			TipBuddy.gtt_status = "<DND> "
		end
		-- Az 2006.10.23: Added for realm support (no option yet)
		if (TipBuddy.uRealm) then
			TipBuddy.gtt_realm = TipBuddy.uRealm;
		end
	end
	-- If we still have an empty name...
	if (TipBuddy.gtt_name == "") then
		if (TipBuddy.uName) then
			TipBuddy.gtt_name = TipBuddy.uName;
		else
			TipBuddy.gtt_name = TB_notspecified;
		end
	end
end
--------------------------------------------------------------------------------------------------------
--                                        Get Target's Target                                         --
--------------------------------------------------------------------------------------------------------
function TipBuddy_TargetInfo_TargetsTarget(type,unit)
	-- Is target of target enabled?
	if (TipBuddy_SavedVars[type].trg == 0) and (TipBuddy_SavedVars[type].off ~= 2) then
		return;
	end
	-- Code
	local tunit = unit.."target";
	local target = UnitName(tunit);
	if (not target) then
		TipBuddy.tt = 0;
		TipBuddy.gtt_target = "";
	else
		if (target == UNKNOWNOBJECT) then
			return;
		end
		TipBuddy.tt = 1;
		local tcolor = "";
		-- Target is player
		if (UnitIsUnit(tunit,"player")) then
			tcolor = TB_WHT_TXT;
			target = "YOU"
		-- Target is someone in our party (Az: Add UnitInRaid() here maybe?)
		elseif (UnitInParty(tunit) == 1) then
			if (TipBuddy_SavedVars[type].trg_pa == 0) then
				return;
			else
				tcolor = TB_YLW_TXT; -- Az: Changed to TB_YLW_TXT from TB_PNK_TXT to avoid confusion with same guild color.
			end
		-- Dead target
		elseif (UnitHealth(tunit) <= 0) then
			tcolor = TB_DGY_TXT;
		-- Player or player controlled unit (enemy or friendly)
		elseif (UnitIsPlayer(tunit)) or (UnitPlayerControlled(tunit)) then
			if (UnitCanAttack(tunit,"player") or UnitCanAttack("player",tunit)) then
				if (TipBuddy_SavedVars[type].trg_en == 0) then
					return;
				else
					tcolor = TB_RED_TXT;
				end
			else
				if (TipBuddy_SavedVars[type].trg_pl == 0) then
					return;
				else
					tcolor = TB_GRN_TXT;
				end
			end
		-- Hostile NPC
		elseif (UnitIsEnemy(tunit,"player")) then
			if (TipBuddy_SavedVars[type].trg_en == 0) then
				return;
			else
				tcolor = TB_RED_TXT;
			end
		-- NPCs
		else
			if (TipBuddy_SavedVars[type].trg_np == 0) then
				return;
			else
				tcolor = TB_BLE_TXT;
			end
		end
		-- Set complete target text
		if (TipBuddy_SavedVars[type].trg_2l) and (TipBuddy_SavedVars[type].trg_2l == 1) then
			TipBuddy.gtt_target = "\n "..tcolor.."["..target.."]";
		else
			TipBuddy.gtt_target = TB_WHT_TXT.." : "..tcolor.."["..target.."]";
		end
	end
end

-- Used for advanced mode
function TipBuddy_Adv_TargetsTarget(unit)
	local tunit = unit.."target";
	local target = UnitName(tunit);
	if (target) then
		--local treaction = TipBuddy_GetUnitReaction(tunit);
		local tcolor = "";
		if (target == UnitName("player")) then
			return "YOU", TB_WHT_TXT;
		elseif (UnitInParty(tunit) == 1) then
			return target, TB_YLW_TXT;
		elseif (UnitHealth(tunit) <= 0) then
			return target, TB_DGY_TXT;
		elseif (UnitIsPlayer(tunit)) or (UnitPlayerControlled(tunit)) then
			if (UnitCanAttack(tunit,"player") or UnitCanAttack("player",tunit)) then
				return target, TB_RED_TXT;
			else
				return target, TB_GRN_TXT;
			end
		elseif (UnitIsEnemy(tunit,"player")) then
			return target, TB_RED_TXT;
		else
			return target, TB_BLE_TXT;
		end
	else
		return "", "";
	end
end

--------------------------------------------------------------------------------------------------------
--                                            Get Guild                                               --
--------------------------------------------------------------------------------------------------------
function TipBuddy_TargetInfo_GetGuild(type,unit)
	-- On Refresh
	if (TipBuddy.refresh == 1) and (TipBuddy.gtt_guild == nil or TipBuddy.gtt_guild == "") then
		return; -- Az: sure we have to return if guild is unset on a refresh?
	end
	-- Init
	local targettype = TipBuddy_SavedVars[type];
	TipBuddy.gtt_guildcolor = "";
	-- Get guild color, only when not in Advanced mode
	if (targettype.off ~= 2) then
		local playerGuild = GetGuildInfo("player");
		if (TipBuddy.uGuild) and (playerGuild) and (TipBuddy.uGuild == playerGuild) then
			TipBuddy.gtt_guildcolor = tbcolor_gld_mate;
		elseif (UnitIsTappedByPlayer(unit)) then
			TipBuddy.gtt_guildcolor = tbcolor_gld_tappedplayer;
		elseif (UnitIsTapped(unit)) then
			TipBuddy.gtt_guildcolor = tbcolor_gld_tappedother;
		elseif (TipBuddy.uReaction) then
			TipBuddy.gtt_guildcolor = getglobal("tbcolor_gld_"..TipBuddy.uReaction);
		else
			TipBuddy.gtt_guildcolor = tbcolor_unknown;
		end
		if (TipBuddy.refresh == 1) then
			return;
		end
	end
	-- Set normal guild string
	if (TipBuddy.uGuild) then
		TipBuddy.gtt_guild = TipBuddy.uGuild;
	-- NPC titles
	else
		local line2Text = GameTooltipTextLeft2:GetText();
		if (line2Text) and (not string.find(line2Text,LEVEL)) then
			TipBuddy.gtt_guild = line2Text;
		end
	end
	return;
end

--------------------------------------------------------------------------------------------------------
--                                         Get Class/Type                                             --
--------------------------------------------------------------------------------------------------------
function TipBuddy_TargetInfo_GetClass(type,unit)
	-- Init
	local targettype = TipBuddy_SavedVars[type];
	TipBuddy.gtt_classlvlcolor = "";
	TipBuddy.gtt_classcorpse = "";
	TipBuddy.gtt_classcolor = "";
	TipBuddy.gtt_class = "";
	TipBuddy.gtt_race = "";
	-- Class Level color?
	if (targettype.off == 2) then
		return;
	elseif (TipBuddy_SavedVars["general"].classcolor == 1) then
		TipBuddy.gtt_classlvlcolor = "";
	elseif (UnitCanAttack(unit,"player") or UnitCanAttack("player",unit) or UnitIsPVP(unit)) then
		TipBuddy.gtt_classlvlcolor = TipBuddy_GetDifficultyColor(TipBuddy.uLevel);
	else
		TipBuddy.gtt_classlvlcolor = tbcolor_lvl_same_faction;
	end
	-- Corpse color
	if (UnitHealth(unit) <= 0) then
		TipBuddy.gtt_classlvlcolor = tbcolor_corpse;
		TipBuddy.gtt_classcorpse = " "..CORPSE.."|r";
	end
	-- Race
	if (targettype.rac == 1) and (TipBuddy.uRace) then
		TipBuddy.gtt_race = tbcolor_race..TipBuddy.uRace.." |r";
	else
		TipBuddy.gtt_race = "|r";
	end
	-- Class color (Only color players)
	if (UnitIsPlayer(unit)) then
		local _, unitClass = UnitClass(unit);
		if (tbcolor_cls[unitClass]) then
			TipBuddy.gtt_classcolor = tbcolor_cls[unitClass];
		else
			TipBuddy.gtt_classcolor = tbcolor_cls_other;
		end
	else
		TipBuddy.gtt_classcolor = tbcolor_cls_other;
	end
	-- Family or Type
	local creatureFamily = UnitCreatureFamily(unit);
	if (UnitPlayerControlled(unit) or TipBuddy.uRace) and (type ~= "pet_friend") and (type ~= "pet_enemy") then
		TipBuddy.gtt_class = TipBuddy.uClass.."|r";
	elseif (creatureFamily) then
		TipBuddy.gtt_class = creatureFamily.."|r";
	else
		local creatureType = UnitCreatureType(unit);
		if (not creatureType) then
			TipBuddy.gtt_class = TB_Unknown.."|r";
		elseif (creatureType == TB_notspecified) then
			TipBuddy.gtt_class = TB_creature.."|r";
		elseif (creatureType) then
			TipBuddy.gtt_class = creatureType.."|r";
		else
			TipBuddy.gtt_class = "|r";
		end
	end

end
--------------------------------------------------------------------------------------------------------
--                                            Get Level                                               --
--------------------------------------------------------------------------------------------------------
function TipBuddy_TargetInfo_GetLevel(type,unit)
	local targettype = TipBuddy_SavedVars[type];
	if (targettype.off == 2) then
		return;
	end
	-- Fix for unknown level (to make it con right)
	local targetLevel = TipBuddy.uLevel;
	if (targetLevel == -1) then
		targetLevel = 500;
	end
	-- Color level number
	local color;
	if (UnitHealth(unit) <= 0) then
		color = tbcolor_corpse;
	--elseif (UnitCanAttack(unit,"player") or UnitCanAttack("player",unit) or UnitIsPVP(unit)) then
	elseif (UnitCanAttack(unit,"player") or UnitCanAttack("player",unit)) then -- Az: changed this, dont con just because they are pvp
		color = TipBuddy_GetDifficultyColor(targetLevel);
	else
		color = tbcolor_lvl_same_faction;
	end
	-- Unknown level
	if (targetLevel == 500) then
		targetLevel = "??";
	-- Level Padding (disabled)
	--elseif (targetLevel < 10) then
	--	targetLevel = "0"..targetLevel;
	end
	-- Set Level Text
	local classification = UnitClassification(unit);
	if (targetLevel == 0) then
		TipBuddy.gtt_level = "?|r";
	elseif (classification == "worldboss") then
		TipBuddy.gtt_level = color..targetLevel..tbcolor_elite_worldboss.." ("..TB_worldboss..")|r";
	elseif (classification == "rareelite") then
		TipBuddy.gtt_level = color.."+"..targetLevel..tbcolor_elite_rare.." ("..TB_rare..")|r";
	elseif (classification == "elite") then
		TipBuddy.gtt_level = color.."+"..targetLevel.."|r";
	elseif (classification == "rare") then
		TipBuddy.gtt_level = color..targetLevel..tbcolor_elite_rare.." ("..TB_rare..")|r";
	else
		TipBuddy.gtt_level = color..targetLevel.."|r";
	end
end

--------------------------------------------------------------------------------------------------------
--                                      Get/Show City Faction                                         --
--------------------------------------------------------------------------------------------------------
function TipBuddy_TargetInfo_ShowCityFaction(type,unit)
	-- If unit is player, skip
	if (UnitIsPlayer(unit)) or (UnitPlayerControlled(unit)) then
		return;
	end
	-- find faction of unit
	local line;
	for i = 1, GameTooltip:NumLines()-1 do
		line = getglobal("GameTooltipTextLeft"..i):GetText();
		-- if this line contains level information, next line should contain faction
		if (line) and (string.find(line,LEVEL..".+")) then
			line = getglobal("GameTooltipTextLeft"..(i+1)):GetText();
			-- break if line is nil, line is empty or line is PvP info.
			if (line == nil or line == "\n" or string.find(line,PVP_ENABLED)) then
				break;
			end
			-- look up faction in the faction table
			local first = string.sub(line,0,1);
			if (first) and (TB_Factions[first]) then
				for j = 1, table.getn(TB_Factions[first]) do
					if (line == TB_Factions[first][j]) then
						TipBuddy.gtt_lastline = (i + 1);
						TipBuddy.gtt_cityfac = tbcolor_cityfac..line;
						break;
					end
				end
			end
		end
	end
end

-- Finds the last real line in the GTT, no extras
function TipBuddy_ConfirmLastLine(unit)
	if (not unit) then
		unit = "mouseover";
		TipBuddy.targetUnit = unit;
	end
	if (not TipBuddy.gtt_numlines) then
		if (GameTooltip:IsVisible()) then
			TipBuddy.gtt_numlines = GameTooltip:NumLines();
		else
			TipBuddy.gtt_numlines = 2;
		end
	end
	local line;
	for i = TipBuddy.gtt_numlines, 1, -1 do
		line = getglobal("GameTooltipTextLeft"..i):GetText();
		if (line == nil or string.find(line,PVP_ENABLED) or string.find(line,LEVEL) or (TipBuddy.gtt_cityfac ~= "" and string.find(line,TipBuddy.gtt_cityfac))) then
			if (i > TipBuddy.gtt_lastline) then
				TipBuddy.gtt_lastline = i;
			end
			break;
		end
	end
end

--------------------------------------------------------------------------------------------------------
--                                        Update Health / Mana                                        --
--------------------------------------------------------------------------------------------------------
function TipBuddy_UnitFrame_UpdateHealth(unit)
	UnitFrameHealthBar_Update(TipBuddy_TargetFrameHealthBar,unit);
end

function TipBuddy_UnitFrame_UpdateMana(unit)
	local powerColor = ManaBarColor[UnitPowerType(unit)];
	TipBuddy_TargetFrameManaBar:SetStatusBarColor(powerColor.r,powerColor.g,powerColor.b);
	UnitFrameManaBar_Update(TipBuddy_TargetFrameManaBar,unit);
end
--------------------------------------------------------------------------------------------------------
--                                           Health Text                                              --
--------------------------------------------------------------------------------------------------------
function TipBuddy_UpdateHealthText(frame,type,unit)
	
	if (not type) or (not frame) then
		if (frame) then
			frame:Hide();
		end
		return;
	elseif (not TipBuddy_SavedVars[type] or not TipBuddy_SavedVars[type].txt_hth or TipBuddy_SavedVars[type].txt_hth == 0) then
		TipBuddy_SavedVars[type].txt_hth = 0;
		frame:Hide();
		return;
	end

	-- Get Health
	local health = UnitHealth(unit);
	local text = getglobal(frame:GetName().."Text");
	--local percent = tonumber(format("%.0f", ( (health / UnitHealthMax(unit)) * 100 ) ));

	if (UnitIsUnit(unit,"player") or UnitIsUnit(unit,"pet") or UnitPlayerOrPetInParty(unit) or UnitPlayerOrPetInRaid(unit)) then
		text:SetText(health.." / "..UnitHealthMax(unit));
	else
		if (MobHealthDB) and (MobHealth_PPP) then
			local ppp = MobHealth_PPP(UnitName(unit)..":"..UnitLevel(unit));
			local curHP = math.floor(health * ppp + 0.5);
			local maxHP = math.floor(100 * ppp + 0.5);

			if (curHP and maxHP and maxHP ~= 0) then
				text:SetText(curHP.." / "..maxHP);
			else
				text:SetText(health.." / "..UnitHealthMax(unit));
			end
		else
			text:SetText(health);
		end
	end
	frame:Show();
end

-- UpdateManaText
function TipBuddy_UpdateManaText(frame,type,unit)
	if (not type) or (not frame) then
		if (frame) then
			frame:Hide();
		end
		return;
	elseif (not frame or not unit or not TipBuddy_SavedVars[type].txt_mna or TipBuddy_SavedVars[type].txt_mna == 0) then
		TipBuddy_SavedVars[type].txt_mna = 0;
		frame:Hide();
		return;
	end

	local unitMana = UnitMana(unit);
	local text = getglobal(frame:GetName().."Text");
	--local percent = (UnitMana(unit) / UnitManaMax(unit)) * 100;
	if (unitMana) and (unitMana > 0) then
		frame:Show();
		text:SetText(unitMana.." / "..UnitManaMax(unit));
	end

end


--------------------------------------------------------------------------------------------------------
--                                         Get/Show Buffs                                             --
--------------------------------------------------------------------------------------------------------

-- Buff & Debuff Icons
function TipBuddy_TargetBuffs_Update(type,unit)
	-- Init Vars
	local targettype = TipBuddy_SavedVars[type];
	local _, buff, debuff;
	local frame, bframe;
	if (TipBuddy_SavedVars["general"].blizdefault == 1 or targettype.off ~= 1) then
		frame = "TipBuddy_BuffFrameGTT";
	else
		frame = "TipBuddy_BuffFrame";
	end
	-- Check for the 8 first buffs/debuffs
	for i = 1, 8 do
		-- Buffs
		_,_,buff = UnitBuff(unit,i);
		bframe = getglobal(frame.."B"..i);
		if (buff) and (targettype) and (targettype.bff == 1) then
			getglobal(frame.."B"..i.."Icon"):SetTexture(buff);
			bframe:Show();
		else
			bframe:Hide();
		end
		-- Debuffs
		_,_,buff = UnitDebuff(unit,i);
		bframe = getglobal(frame.."D"..i);
		if (buff) and (targettype.bff == 1) then
			getglobal(frame.."D"..i.."Icon"):SetTexture(buff);
			bframe:Show();
		else
			bframe:Hide();
		end
	end
end

-- PvP Rank (Az: this one needs to be changed since ranks are not in the current pvp rules)
function TipBuddy_ShowRank(type,unit)
	TipBuddy_RankFrameGTT:Hide();
	TipBuddy_RankFrame:Hide();
	if (not UnitIsPlayer(unit)) or (TipBuddy_SavedVars[type].rnk == 0) then
		return;
	end
	-- Get info
	local rankName, rankNumber = GetPVPRankInfo(UnitPVPRank(unit));
	local rankFrame, srankFrame;
	if (rankNumber == 0) then
		return;
	elseif (TipBuddy_SavedVars[type].off == 1) then
		rankFrame = getglobal("TipBuddy_RankFrame");
		srankFrame = "TipBuddy_RankFrame";
	else
		rankFrame = getglobal("TipBuddy_RankFrameGTT");
		srankFrame = "TipBuddy_RankFrameGTT";
	end
	-- Set icon
	local rankFrameIcon = getglobal(srankFrame.."Icon");
	if (rankNumber > 0) then
		rankFrameIcon:SetTexture(format("%s%02d","Interface\\PvPRankBadges\\PvPRank",rankNumber));
		rankFrame:Show();
	else
		rankFrame:Hide();
	end
end
--------------------------------------------------------------------------------------------------------
--                                    Get/Show Faction Icon (A/H)                                     --
--------------------------------------------------------------------------------------------------------
function TipBuddy_TargetInfo_ShowFaction(type,unit)
	TipBuddy_FactionFrameGTT:Hide();
	TipBuddy_FactionFrame:Hide();

	local factionGroup = UnitFactionGroup(unit);
	if (not factionGroup) then
		return;
	end

	local frame, sframe;
	if (TipBuddy_SavedVars[TipBuddy.targetType].off == 1) then
		frame = getglobal("TipBuddy_FactionFrame");
		sframe = "TipBuddy_FactionFrame";
	else
		frame = getglobal("TipBuddy_FactionFrameGTT");
		sframe = "TipBuddy_FactionFrameGTT";
	end
	local frameIcon = getglobal(sframe.."Icon");
	local frameText = getglobal(sframe.."Text");
	--how in the world does this happen?

	-- FFA PvP
	if (UnitIsPVPFreeForAll(unit)) then
		frameIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA");
		frame:Show();
		if (TipBuddy_SavedVars[TipBuddy.targetType].txt_pvp == 1) then
			frameIcon:Hide();
			frameText:Show();
			frameText:SetText("FFA");
		else
			frameIcon:Show();
			frameText:Hide();
		end
	-- Normal PvP
	elseif (UnitIsPVP(unit)) then
		frameIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..factionGroup);
		frame:Show();
		if (TipBuddy_SavedVars[TipBuddy.targetType].txt_pvp == 1) then
			frameIcon:Hide();
			frameText:Show();
			frameText:SetText("PvP");
		else
			frameIcon:Show();
			frameText:Hide();
		end
	else
		frame:Hide();
	end
end

--------------------------------------------------------------------------------------------------------
--                                             TargetType                                             --
--------------------------------------------------------------------------------------------------------
function TipBuddy_SetFrame_TargetType(type,unit,refresh)
	local targettype = TipBuddy_SavedVars[type];
	-- If not Blizz default tips
	if (TipBuddy_SavedVars["general"].blizdefault ~= 1) then
		if (refresh) then
			--TB_DebugMsg("!! lastline: "..TipBuddy.gtt_lastline..", numlines (stored): "..TipBuddy.gtt_numlines..", numlines (real): "..GameTooltip:NumLines());
			TipBuddy.refresh = 1;
			--TB_DebugMsg("!! REFRESH");
		else
			--TB_DebugMsg("!! CLEARING ALL DATA");
			TipBuddy.refresh = nil;
			TipBuddy.gtt_numlines = GameTooltip:NumLines();
			TipBuddy.gtt_lastline = 1;
			TipBuddy.gtt_xtra = nil;
			TipBuddy.gtt_name = "";
			TipBuddy.gtt_realm = "";
			TipBuddy.gtt_status = "";
			TipBuddy.gtt_target = "";
			TipBuddy.gtt_guild = "";
			TipBuddy.gtt_level = "";
			TipBuddy.gtt_race = "";
			TipBuddy.gtt_class = "";
			TipBuddy.gtt_cityfac = "";
		end

		if not (TipBuddy.gtt_numlines) then
			TipBuddy.gtt_numlines = 0;
		end

		TipBuddy_TargetInfo_CheckName(type,unit);
		TipBuddy_TargetInfo_TargetsTarget(type,unit);
		TipBuddy_TargetInfo_GetGuild(type,unit);
		TipBuddy_TargetInfo_GetClass(type,unit);
		TipBuddy_TargetInfo_GetLevel(type,unit);
		if (TipBuddy.refresh ~= 1) then
			TipBuddy_TargetInfo_ShowCityFaction(type,unit);
			TipBuddy_ConfirmLastLine(unit);
			if (targettype.off ~= 1) then
				TipBuddy_GTT_GetExtraLines(TipBuddy.gtt_numlines);
			end
		end

	end
	-- Compact Mode
	if (targettype.off == 1) then
		if (TipBuddy_SavedVars["general"].blizdefault == 1) then
			TipBuddy_ClearFade(TipBuddyTooltip, 1);
			TipBuddyTooltip:SetUnit(unit);
			TipBuddy_GTT_AddExtras();
			TipBuddyTooltip:Show();
		else
			-- Status + Name + Realm + [\n + Target]
			if (TipBuddy.gtt_realm) and (TipBuddy.gtt_realm ~= "") then
				TipBuddy_TargetName_Text:SetText(tbcolor_unknown..TipBuddy.gtt_status..TipBuddy.gtt_namecolor..TipBuddy.gtt_name.." - "..TipBuddy.gtt_realm..TipBuddy.gtt_target);
			else
				TipBuddy_TargetName_Text:SetText(tbcolor_unknown..TipBuddy.gtt_status..TipBuddy.gtt_namecolor..TipBuddy.gtt_name..TipBuddy.gtt_target);
			end
			TipBuddy_TargetName_Text:Show();
			-- Level
			TipBuddy_TargetLevel_Text:SetText(TipBuddy.gtt_level);
			-- Guild
			if (targettype.gld == 1) and (TipBuddy.gtt_guild) and (TipBuddy.gtt_guild ~= "") then
				TipBuddy_TargetGuild_Text:SetText(TipBuddy.gtt_guildcolor.."<"..TipBuddy.gtt_guild..TipBuddy.gtt_guildcolor..">");
				TipBuddy_TargetGuild_Text:Show();
			else
				TipBuddy_TargetGuild_Text:Hide();
			end
			-- Health & Mana bar
			if (targettype.hth == 1) then
				TipBuddy_TargetFrameHealthBar:Show();
				if (UnitMana(unit) > 0) then
					TipBuddy_TargetFrameManaBar:Show();
				else
					TipBuddy_TargetFrameManaBar:Hide();
				end
				TipBuddy_UnitFrame_UpdateHealth(unit);
				TipBuddy_UnitFrame_UpdateMana(unit);
				TipBuddy_UpdateHealthText(TipBuddy_HealthText,type,unit);
				TipBuddy_UpdateManaText(TipBuddy_ManaText,type,unit);
			else
				TipBuddy_TargetFrameHealthBar:Hide();
				TipBuddy_TargetFrameManaBar:Hide();
			end
			-- City Faction
			if (targettype.cfc == 1) and (TipBuddy.gtt_cityfac ~= "") then
				TipBuddy_TargetCityFac_Text:SetText(tbcolor_cityfac..TipBuddy.gtt_cityfac);
				TipBuddy_TargetCityFac_Text:Show();
			else
				TipBuddy_TargetCityFac_Text:Hide();
			end
			-- Class
			if (targettype.cls == 1) and (TipBuddy.gtt_class ~= "") then
				TipBuddy_TargetClass_Text:SetText(TipBuddy.gtt_race..TipBuddy.gtt_classcolor..TipBuddy.gtt_classlvlcolor..TipBuddy.gtt_class..TipBuddy.gtt_classcorpse);
				TipBuddy_TargetClass_Text:Show();
				TipBuddy_TargetLevel_Text:Show();
			else
				TipBuddy_TargetClass_Text:Hide();
				TipBuddy_TargetLevel_Text:Hide();
			end

			TipBuddy_TargetInfo_FindExtras(unit);
			TipBuddy_FrameHeights_Initialize(type);
			TipBuddy_SetFrame_Width();
		end
	-- Default & Advanced Mode
	else
		--TB_DebugMsg(getglobal("TipBuddyTooltipTextLeft1"):GetText());
		TipBuddy_ClearFade(TipBuddyTooltip,1);
		TipBuddyTooltip:SetUnit(unit);
		--TB_DebugMsg("setunit show:  ("..TipBuddyTooltip:GetTop()..")");

		--/script TipBuddy_SavedVars.npc_friend.off = 2
		-- Blizzard Style
		if (TipBuddy_SavedVars["general"].blizdefault == 1) then
			-- do nothing
		-- Advanced Mode
		elseif (targettype.off == 2) then
			GameTooltip.variables1 = {};
			GameTooltip.variables2 = {};
			if (not targettype.ebx1) then
				targettype.ebx1 = "";
			end
			if (not targettype.ebx2) then
				targettype.ebx2 = "";
			end
			local ebtext1 = targettype.ebx1;
			local ebtext2 = targettype.ebx2;
			for variable in pairs(TB_VARIABLE_FUNCTIONS) do
				if (string.find(ebtext1, variable)) then
					GameTooltip.variables1[variable] = true;
				end
				if (string.find(ebtext2, variable)) then
					GameTooltip.variables2[variable] = true;
				end
			end

			local maxchar = 256;
			TipBuddyTooltipTextLeft1:SetTextColor(1,1,1);
			if ((not ebtext1) or ebtext1 == "") then
				TipBuddyTooltip:SetText("     ");
				--TipBuddyTooltipTextLeft1:Show();
			else
				for var in pairs(GameTooltip.variables1) do
					ebtext1 = TB_VARIABLE_FUNCTIONS[var].func(ebtext1, unit);
				end
				if (string.len(ebtext1) > maxchar) then
					ebtext1 = string.sub(ebtext1, 1, maxchar);
				end
				TipBuddyTooltip:SetText(ebtext1);
				--TipBuddyTooltipTextLeft1:Show();
			end

			maxchar = 2048;
			if ((not ebtext2) or ebtext2 == "") then
				--TipBuddyTooltipTextLeft2:SetText(" ");
				--TipBuddyTooltipTextLeft1:Show();
			else
				for var in pairs(GameTooltip.variables2) do
					ebtext2 = TB_VARIABLE_FUNCTIONS[var].func(ebtext2, unit);
				end
				if (string.len(ebtext2) > maxchar) then
					ebtext2 = string.sub(ebtext2, 1, maxchar);
				end

				--strip out the empty lines
				ebtext2 = string.gsub(ebtext2,"|r\n|r\n","|r\n");
				ebtext2 = string.gsub(ebtext2,"^|r\n","");

				TipBuddyTooltip:AddLine(ebtext2);
				TipBuddyTooltipTextLeft2:SetTextColor(1,1,1);
			end
		-- Default Mode
		else
			-- Status + Name + Realm + [\n + Target]
			if (TipBuddy.gtt_realm) and (TipBuddy.gtt_realm ~= "") then
				TipBuddyTooltip:SetText(tbcolor_unknown..TipBuddy.gtt_status..TipBuddy.gtt_namecolor..TipBuddy.gtt_name.." - "..TipBuddy.gtt_realm..TipBuddy.gtt_target);
			else
				TipBuddyTooltip:SetText(tbcolor_unknown..TipBuddy.gtt_status..TipBuddy.gtt_namecolor..TipBuddy.gtt_name..TipBuddy.gtt_target);
			end
			-- Guild
			if (targettype.gld == 1) and (TipBuddy.gtt_guild) and (TipBuddy.gtt_guild ~= "") then
				TipBuddyTooltip:AddLine(TipBuddy.gtt_guildcolor.."<"..TipBuddy.gtt_guild..TipBuddy.gtt_guildcolor..">".."|r");
			end
			-- Class
			if (targettype.cls == 1) and (TipBuddy.gtt_class ~= "" or TipBuddy.gtt_level ~= "") then
				TipBuddyTooltip:AddLine(TipBuddy.gtt_level.."|r  "..TipBuddy.gtt_race..TipBuddy.gtt_classcolor..TipBuddy.gtt_classlvlcolor..TipBuddy.gtt_class..TipBuddy.gtt_classcorpse.."|r");
			end

			-- City Faction
			if (targettype.cfc == 1) and (TipBuddy.gtt_cityfac ~= "") then
				TipBuddyTooltip:AddLine(TipBuddy.gtt_cityfac.."|r");
			end

		end

		TipBuddy_GTT_AddExtras();
		if (targettype.hth == 1) then
			TipBuddyTooltipStatusBar:Show();
		else
			TipBuddyTooltipStatusBar:Hide();
		end
		TipBuddyTooltip:Show();
		TipBuddy_UpdateHealthText(TipBuddy_HealthTextGTT,type,unit);
		TipBuddy_UpdateManaText( TipBuddy_ManaTextGTT,type,unit );
	end
	-- ShowFactionIcon/Text
	if (targettype.fac == 1) then
		TipBuddy_TargetInfo_ShowFaction(type,unit);
	else
		TipBuddy_FactionFrameGTT:Hide();
		TipBuddy_FactionFrame:Hide();
	end
end

--------------------------------------------------------------------------------------------------------
--                                       Set Background Color                                         --
--------------------------------------------------------------------------------------------------------
function TipBuddy_SetFrame_BackgroundColor(type,unit)
	if (not type) then
		TipBuddy_SetFrame_NonUnit_BackgroundColor("general");
		return;
	end
	-- Init
	local targettype = TipBuddy_SavedVars[type];
	local r, g, b, a, br, bg, bb, ba;

	if (not targettype.c_bdp) then
		targettype.c_bdp = 0;
	end
	if (not targettype.c_bdb) then
		targettype.c_bdb = 0;
	end
	--TB_DebugMsg("bdp = "..targettype.c_bdp);
	-- Find Background Color
	local playerGuild = GetGuildInfo("player");
	if (playerGuild) and (playerGuild == GetGuildInfo(unit)) then
		type = "guild";
		targettype = TipBuddy_SavedVars[type];
		r, g, b, a = targettype.bgcolor.r, targettype.bgcolor.g, targettype.bgcolor.b, targettype.bgcolor.a;
	elseif (targettype.c_bdp == 1) then
		local levelDiff = UnitLevel(unit) - UnitLevel("player");
		local colors = TipBuddy_SavedVars["textcolors"];
		if (levelDiff >= 5) then
			r, g, b = colors.lvl_imp.r, colors.lvl_imp.g, colors.lvl_imp.b;
		elseif (levelDiff >= 3) then
			r, g, b = colors.lvl_vdf.r, colors.lvl_vdf.g, colors.lvl_vdf.b;
		elseif (levelDiff >= -2) then
			r, g, b = colors.lvl_dif.r, colors.lvl_dif.g, colors.lvl_dif.b;
		elseif (-levelDiff <= GetQuestGreenRange()) then
			r, g, b = colors.lvl_stn.r, colors.lvl_stn.g, colors.lvl_stn.b;
		else
			r, g, b = colors.lvl_trv.r, colors.lvl_trv.g, colors.lvl_trv.b;
		end
		r, g, b = TB_NoNegative(r - 0.35), TB_NoNegative(g - 0.35), TB_NoNegative(b - 0.35);
		a = targettype.bgcolor.a;
	elseif (targettype.c_bdp == 2) then
		local reaction = TipBuddy_GetUnitReaction(unit);
		local colors = TipBuddy_SavedVars["textcolors"];
		if (reaction == "hostile") then
			r, g, b = colors.nam_hos.r, colors.nam_hos.g, colors.nam_hos.b;
		elseif (reaction == "neutral") then
			r, g, b = colors.nam_neu.r, colors.nam_neu.g, colors.nam_neu.b;
		elseif (reaction == "friendly") then
			r, g, b = colors.nam_fri.r, colors.nam_fri.g, colors.nam_fri.b;
		elseif (reaction == "exalted") then
			r, g, b = colors.nam_fri.r, colors.nam_fri.g, colors.nam_fri.b;
		elseif (reaction == "caution") then
			r, g, b = colors.nam_cau.r, colors.nam_cau.g, colors.nam_cau.b;
		elseif (reaction == "pvp") then
			r, g, b = colors.nam_pvp.r, colors.nam_pvp.g, colors.nam_pvp.b;
		elseif (reaction == "tappedplayer") then
			r, g, b = colors.nam_tpp.r, colors.nam_tpp.g, colors.nam_tpp.b;
		elseif (reaction == "tappedother") then
			r, g, b = colors.nam_tpo.r, colors.nam_tpo.g, colors.nam_tpo.b;
		else
			r, g, b = targettype.bgcolor.r, targettype.bgcolor.g, targettype.bgcolor.b;
		end
		r, g, b = TB_NoNegative(r - 0.35), TB_NoNegative(g - 0.35), TB_NoNegative(b - 0.35);
		a = targettype.bgcolor.a;
	else
		r, g, b, a = targettype.bgcolor.r, targettype.bgcolor.g, targettype.bgcolor.b, targettype.bgcolor.a;
	end

	-- Find Border Color
	if (targettype.c_bdb == 1) then
		local levelDiff = UnitLevel(unit) - UnitLevel("player");
		local colors = TipBuddy_SavedVars["textcolors"];
		if (levelDiff >= 5) then
			br, bg, bb = colors.lvl_imp.r, colors.lvl_imp.g, colors.lvl_imp.b;
		elseif (levelDiff >= 3) then
			br, bg, bb = colors.lvl_vdf.r, colors.lvl_vdf.g, colors.lvl_vdf.b;
		elseif (levelDiff >= -2) then
			br, bg, bb = colors.lvl_dif.r, colors.lvl_dif.g, colors.lvl_dif.b;
		elseif (-levelDiff <= GetQuestGreenRange()) then
			br, bg, bb = colors.lvl_stn.r, colors.lvl_stn.g, colors.lvl_stn.b;
		else
			br, bg, bb = colors.lvl_trv.r, colors.lvl_trv.g, colors.lvl_trv.b;
		end
		ba = targettype.bgbcolor.a;
	elseif (targettype.c_bdb == 2) then
		local reaction = TipBuddy_GetUnitReaction(unit);
		local colors = TipBuddy_SavedVars["textcolors"];
		if (reaction == "hostile") then
			br, bg, bb = colors.nam_hos.r, colors.nam_hos.g, colors.nam_hos.b;
		elseif (reaction == "neutral") then
			br, bg, bb = colors.nam_neu.r, colors.nam_neu.g, colors.nam_neu.b;
		elseif (reaction == "friendly") then
			br, bg, bb = colors.nam_fri.r, colors.nam_fri.g, colors.nam_fri.b;
		elseif (reaction == "caution") then
			br, bg, bb = colors.nam_cau.r, colors.nam_cau.g, colors.nam_cau.b;
		elseif (reaction == "pvp") then
			br, bg, bb = colors.nam_pvp.r, colors.nam_pvp.g, colors.nam_pvp.b;
		elseif (reaction == "tappedplayer") then
			br, bg, bb = colors.nam_tpp.r, colors.nam_tpp.g, colors.nam_tpp.b;
		elseif (reaction == "tappedother") then
			br, bg, bb = colors.nam_tpo.r, colors.nam_tpo.g, colors.nam_tpo.b;
		else
			br, bg, bb = targettype.bgcolor.r, targettype.bgcolor.g, targettype.bgcolor.b;
		end
		ba = targettype.bgbcolor.a;
	else
		targettype = TipBuddy_SavedVars[type];
		if (not targettype.bgbcolor) then
			targettype.bgbcolor = {};
			targettype.bgbcolor.r = 0.8;
			targettype.bgbcolor.g = 0.8;
			targettype.bgbcolor.b = 0.9;
			targettype.bgbcolor.a = 1;
		end
		br, bg, bb, ba = targettype.bgbcolor.r, targettype.bgbcolor.g, targettype.bgbcolor.b, targettype.bgbcolor.a;
	end

	--if (TipBuddy_SavedVars["general"].blizdefault == 1) then
	--	GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b, 1);
	--	GameTooltip:SetBackdropBorderColor(0.8, 0.8, 0.9, 1);

	-- Set the colors
	if (TipBuddy.compactvis) then
		TipBuddy_Main_Frame:SetBackdropColor(r,g,b,a);
		TipBuddy_Main_Frame:SetBackdropBorderColor(0,0,0,0.9);
	else
		TipBuddyTooltip:SetBackdropColor(r,g,b,a);
		--/script GameTooltip:SetBackdropBorderColor(1, 1, 1, 1);
		TipBuddyTooltip:SetBackdropBorderColor(br,bg,bb,ba);
	end
	-- Color first line as normal Blizz tips
	if (TipBuddy_SavedVars["general"].blizdefault == 1) then
		TipBuddyTooltipTextLeft1:SetTextColor(GameTooltip_UnitColor(unit));
	end
end
--------------------------------------------------------------------------------------------------------
--                                    Set Non-Unit Background Color                                   --
--------------------------------------------------------------------------------------------------------
function TipBuddy_SetFrame_NonUnit_BackgroundColor(type)
	local targettype = TipBuddy_SavedVars[type];
	if (not targettype.bgcolor) then
		targettype.bgcolor = {};
		targettype.bgcolor.r = 0.1;
		targettype.bgcolor.g = 0.1;
		targettype.bgcolor.b = 0.1;
		targettype.bgcolor.a = 0.78;
	end
	if (not targettype.bgbcolor) then
		targettype.bgbcolor = {};
		targettype.bgbcolor.r = 0.8;
		targettype.bgbcolor.g = 0.8;
		targettype.bgbcolor.b = 0.9;
		targettype.bgbcolor.a = 1;
	end
	GameTooltip:SetBackdropColor(targettype.bgcolor.r,targettype.bgcolor.g,targettype.bgcolor.b,targettype.bgcolor.a);
	GameTooltip:SetBackdropBorderColor(targettype.bgbcolor.r,targettype.bgbcolor.g,targettype.bgbcolor.b,targettype.bgbcolor.a);
end
--------------------------------------------------------------------------------------------------------
--                                          Parent On Update                                          --
--------------------------------------------------------------------------------------------------------
function TipBuddy_ParentTip_OnUpdate()
	this:ClearAllPoints();
	-- Get positions and anchors
	local x, y = TipBuddy_PositionFrameToCursor();
	if (not TipBuddy.xpoint or not TipBuddy.xpos or not TipBuddy.anchor or not TipBuddy.fanchor) then
		TipBuddy.xpoint, TipBuddy.xpos, TipBuddy.ypos = TipBuddy_GetFrameCursorOffset();
		TipBuddy.anchor, TipBuddy.fanchor, TipBuddy.offset = TipBuddy_GetFrameAnchorPos();
	end
	-- Units
	if (TipBuddy.hasTarget == 1) then
		local tipName, tipUnit = GameTooltip:GetUnit();
		-- Refresh current unit
		if (tipUnit) and (UnitIsUnit(tipUnit,"mouseover")) then
			GameTooltip:SetAlpha(0);
			if (GetTime() - (TipBuddy.lastUpdate or 0) > 0.5) then
				TipBuddy_ShowUnitTooltip(TipBuddy.targetUnit);
				TipBuddy.lastUpdate = GetTime();
			end
		-- Unit no longer shown, either no GTT at all, or GTT now shows a non-unit tip
		else
			-- Hide the GTT only if it was showning a unit before and isn't showing a non-unit tip now
			if (tipName) and (tipName == TipBuddy.uName) then
				GameTooltip:SetText("");
				GameTooltip:Hide();
				if (TipBuddy_SavedVars["general"].gtt_fade == 1) then
					--TipBuddyTooltip:FadeOut();
					TipBuddy_Hide(TipBuddyTooltip);
				else
					TipBuddy_ForceHide(TipBuddyTooltip);
				end
			end
			-- Az 2007.05.26: Is this needed?
			if (TipBuddy_Main_Frame:IsVisible()) then
				TipBuddy_Hide(TipBuddy_Main_Frame);
			end
			-- Reset target vars
			TipBuddy.hasTarget = 0;
			TipBuddy.uName = nil;
			TipBuddy.vis = nil;
		end
		-- Set Anchor
		if (TipBuddy_SavedVars["general"].anchored == 1) then
			this:SetPoint(TipBuddy.anchor,"TipBuddy_Header_Frame",TipBuddy.fanchor,0,0);
		else
			this:SetPoint(TipBuddy.xpoint,"UIParent","BOTTOMLEFT",x,y);
		end
	-- Non Units (just refresh anchor)
	else
		if (TipBuddy_SavedVars["general"].nonunit_anchor == 0) then
			this:SetPoint(TipBuddy.xpoint,"UIParent","BOTTOMLEFT",x,y);
		elseif (TipBuddy_SavedVars["general"].nonunit_anchor == 1) then
			this:SetPoint(TipBuddy.anchor,"TipBuddy_Header_Frame",TipBuddy.fanchor,0,0);
		else
			this:SetPoint(TipBuddy.xpoint,"UIParent","BOTTOMLEFT",x,y);
		end
	end
	-- First hint
	if (not TipBuddy.first) then
		GameTooltip.default = nil;
		TipBuddy.first = 1;
	end
end

function TipBuddyTooltip_OnUpdate()
	if (this.fadingout) then
		if (this:GetAlpha() <= 0) then
			TipBuddy_FadeOut_Finished(this);
		end
	elseif (this.fadingin) then
		if (this:GetAlpha() >= 1) then
			TipBuddy_FadeIn_Finished(this);
		end
	end
	if (this:IsVisible()) then
		if (TipBuddy.hasTarget ~= 1) and (not this.fadingout) then
			if (not this.startTime or not this.endTime) then
				TipBuddy_ForceHide(this);
				return;
			end
			GameTooltip:SetAlpha(0);
			local fraction = (GetTime() - this.startTime) / (this.endTime - this.startTime);
			if (fraction >= 1.0) then
				TipBuddy_FadeOut(this);
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------
--                                         Main On Update                                             --
--------------------------------------------------------------------------------------------------------
function TipBuddy_MainTip_OnUpdate()
	--/script TipBuddy_SavedVars["general"].cursorpos = 1;
	--/script TipBuddy_SavedVars["general"].cursorpos = 0;
	if (this.fadingout) then
		if (this:GetAlpha() <= 0) then
			TipBuddy_FadeOut_Finished(this);
		end
	elseif (this.fadingin) then
		if (this:GetAlpha() >= 1) then
			TipBuddy_FadeIn_Finished(this);
		end
	end
	if (this:IsVisible()) then
		if ((TipBuddy.hasTarget ~= 1) and (not this.fadingout)) then
			TipBuddy.compactvis = nil;
			--/script --TB_DebugMsg(TipBuddy_Main_Frame.fadingout);
			if (not this.startTime or not this.endTime) then
				TipBuddy_SetFrame_NonUnit_BackgroundColor("general");
				TipBuddy_ForceHide(this);
				return;
			end
			GameTooltip:SetAlpha(0);
			local fraction = (GetTime() - this.startTime) / (this.endTime - this.startTime);
			if (fraction >= 1.0) then
				TipBuddy_FadeOut(this);
			elseif (GameTooltip:IsVisible() and TipBuddy.compactvis ~= 1) then
				TipBuddy_SetFrame_NonUnit_BackgroundColor("general");
				TipBuddy_ForceHide(this);
			end
		elseif (GameTooltip:IsVisible() and TipBuddy.compactvis ~= 1) then
			TipBuddy_SetFrame_NonUnit_BackgroundColor("general");
			TipBuddy_ForceHide(this);
		end
	end
end
--------------------------------------------------------------------------------------------------------
--                                             Set Anchor                                             --
--------------------------------------------------------------------------------------------------------
-- If it is set to be anchored, anchor it to TipBuddyAnchor otherwise, set it to the cursor
function TipBuddy_SetFrame_Anchor(frame)
	if (not TipBuddy.xpoint or not TipBuddy.anchor) then
		TipBuddy.xpoint, TipBuddy.xpos, TipBuddy.ypos = TipBuddy_GetFrameCursorOffset();
		TipBuddy.anchor, TipBuddy.fanchor, TipBuddy.offset = TipBuddy_GetFrameAnchorPos();
	end
	frame:ClearAllPoints();
	if (TipBuddy_SavedVars["general"].anchored == 1) then
		frame:SetPoint(TipBuddy.anchor,"TipBuddy_Parent_Frame",TipBuddy.fanchor,0,TipBuddy.offset);
	else
		frame:SetPoint(TipBuddy.xpoint,"TipBuddy_Parent_Frame","CENTER",0,0);
	end
end
--------------------------------------------------------------------------------------------------------
--                                       Set Heights (Compact)                                        --
--------------------------------------------------------------------------------------------------------
-- /script TipBuddy_SavedVars["general"].scalemod = "1";
-- /script TipBuddy_SavedVars["general"].scalemod = "0";

function TipBuddy_FrameHeights_Initialize(type)
	local scale = TipBuddy_SavedVars["general"].scalemod;

	TipBuddy_FactionFrameIcon:SetHeight(30 + (scale * 1.5));
	TipBuddy_FactionFrameIcon:SetWidth(30 + (scale * 1.5));

	TipBuddy_TargetName_Text:SetTextHeight(11 + scale);
	TipBuddy_TargetName_TextR:SetTextHeight(11 + scale);
	if (TipBuddy.tt) and (TipBuddy.tt == 1) and (TipBuddy_SavedVars[type]) and (TipBuddy_SavedVars[type].trg_2l) and (TipBuddy_SavedVars[type].trg_2l == 1) then
		TipBuddy_TargetName_Text:SetHeight((11 + scale) * 2);
		TipBuddy_TargetName_TextR:SetHeight((11 + scale) * 2);
	else
		TipBuddy_TargetName_Text:SetHeight(11 + scale);
		TipBuddy_TargetName_TextR:SetHeight(11 + scale);
	end

	TipBuddy_TargetGuild_Text:SetTextHeight(8 + scale);
	TipBuddy_TargetGuild_Text:SetHeight(8 + scale);
	TipBuddy_TargetGuild_TextR:SetTextHeight(8 + scale);
	TipBuddy_TargetGuild_TextR:SetHeight(8 + scale);

	TipBuddy_TargetLevel_Text:SetTextHeight(10 + scale);
	TipBuddy_TargetLevel_Text:SetHeight(10 + scale);
	--TipBuddy_TargetLevel_Text:SetTextHeight(8 + scale);
	--TipBuddy_TargetLevel_Text:SetHeight(8 + scale);
	TipBuddy_TargetClass_Text:SetTextHeight(10 + scale);
	TipBuddy_TargetClass_Text:SetHeight(10 + scale);

	TipBuddy_TargetCityFac_Text:SetTextHeight(8 + scale);
	TipBuddy_TargetCityFac_Text:SetHeight(8 + scale);
	TipBuddy_TargetCityFac_TextR:SetTextHeight(8 + scale);
	TipBuddy_TargetCityFac_TextR:SetHeight(8 + scale);

	local line;
	for i = 1, 20 do
		line = getglobal("TipBuddy_Xtra"..i.."_Text");
		line:SetTextHeight(8 + scale);
		line:SetHeight(8 + scale);
		line = getglobal("TipBuddy_XtraR"..i.."_Text");
		line:SetTextHeight(8 + scale);
		line:SetHeight(8 + scale);
	end

	TipBuddy_TargetFrameHealthBar:SetHeight(5 + scale);
	TipBuddy_TargetFrameManaBar:SetHeight(3 + scale);
	TipBuddy_HealthTextText:SetTextHeight(TipBuddy_TargetFrameHealthBar:GetHeight() + 6);
	TipBuddy_ManaTextText:SetTextHeight(TipBuddy_TargetFrameManaBar:GetHeight() + 3.5);

	TipBuddy_RankFrameIcon:SetHeight(12 + scale);
	TipBuddy_RankFrameIcon:SetWidth(12 + scale);

	-- hack to fix the fonts scaling badly
	TipBuddy_Main_Frame:SetScale(2);
	TipBuddy_Main_Frame:SetScale(1);

	TipBuddy_SetFrame_Height();
end

-- Width
function TipBuddy_SetFrame_Width()
	local scale = TipBuddy_SavedVars["general"].scalemod;
	-- Get Width or Normal Fields
	local targetNameLength = TipBuddy_TargetName_Text:GetStringWidth() + (4 + scale);
	local targetGuildLength = TipBuddy_TargetGuild_Text:GetStringWidth() + (4 + scale);
	local targetClassLength = (TipBuddy_TargetClass_Text:GetStringWidth() + TipBuddy_TargetLevel_Text:GetStringWidth() + (10 + scale));
	-- If not visable, make them very small in the calculation
	if (not TipBuddy_TargetGuild_Text:IsVisible()) then
		targetGuildLength = 1;
	end
	if (not TipBuddy_TargetClass_Text:IsVisible()) then
		targetClassLength = 1;
	end
	-- Find the longest
	if (targetNameLength > targetGuildLength) then
		if (targetNameLength < targetClassLength) then
			targetNameLength = targetClassLength;
		end
	elseif (targetGuildLength > targetClassLength) then
		targetNameLength = targetGuildLength;
	else
		targetNameLength = targetClassLength;
	end
	-- Check Xtras
	local t1 = targetNameLength;
	local t2;
	for i = 1, 20 do
		t2 = (getglobal("TipBuddy_Xtra"..i.."_Text"):GetStringWidth() + (5 + scale)) + (getglobal("TipBuddy_XtraR"..i.."_Text"):GetStringWidth() + (12 + scale));
		if (t2 > t1) then
			t1 = t2;
		end
	end
	-- 72 units is our min allowed width
	if (t1 < 72) then
		t1 = 72;
	end
	-- Set MainFrame + Bars
	TipBuddy_Main_Frame:SetWidth(t1 + scale);
	TipBuddy_TargetFrameHealthBar:SetWidth(TipBuddy_Main_Frame:GetWidth() - 6);
	TipBuddy_TargetFrameManaBar:SetWidth(TipBuddy_Main_Frame:GetWidth() - 6);
end

-- Height
function TipBuddy_SetFrame_Height()
	local scale = TipBuddy_SavedVars["general"].scalemod;
	local nameFrame, guildFrame, classFrame, healthFrame, manaFrame, cityfacFrame = 0, 0, 0, 0, 0, 0;
	local lastparent = "TipBuddy_TargetName_Text";
	local lastparentr = "TipBuddy_TargetName_TextR";
	-- Name
	if (TipBuddy_TargetName_Text:IsVisible()) then
		nameFrame = TipBuddy_TargetName_Text:GetHeight();
	end
	-- Guild
	if (TipBuddy_TargetGuild_Text:IsVisible()) then
		guildFrame = TipBuddy_TargetGuild_Text:GetHeight();
		TipBuddy_TargetGuild_Text:SetPoint("TOPLEFT",lastparent,"BOTTOMLEFT",0,1);
		TipBuddy_TargetGuild_TextR:SetPoint("TOPRIGHT",lastparentr,"BOTTOMRIGHT",0,1);
		lastparent = "TipBuddy_TargetGuild_Text";
		lastparentr = "TipBuddy_TargetGuild_TextR";
	end
	-- HealthBar
	if (TipBuddy_TargetFrameHealthBar:IsVisible()) then
		healthFrame = (TipBuddy_TargetFrameHealthBar:GetHeight() + 5);
		TipBuddy_TargetFrameHealthBar:SetPoint("TOPLEFT",lastparent,"BOTTOMLEFT",2,-4);
		lastparent = "TipBuddy_TargetFrameHealthBar";
		lastparentr = "TipBuddy_TargetFrameHealthBar";
	end
	-- ManaBar
	if (TipBuddy_TargetFrameManaBar:IsVisible()) then
		manaFrame = (TipBuddy_TargetFrameManaBar:GetHeight() + 4);
		lastparent = "TipBuddy_TargetFrameManaBar";
		lastparentr = "TipBuddy_TargetFrameManaBar";
	end
	-- CityFaction
	if (TipBuddy_TargetCityFac_Text:IsVisible()) then
		cityfacFrame = TipBuddy_TargetCityFac_Text:GetHeight();
		TipBuddy_TargetCityFac_Text:SetPoint("TOPLEFT",lastparent,"BOTTOMLEFT",0,0);
		TipBuddy_TargetCityFac_TextR:SetPoint("TOPRIGHT",lastparentr,"BOTTOMRIGHT",0,0);
		lastparent = "TipBuddy_TargetCityFac_Text";
		lastparentr = "TipBuddy_TargetCityFac_TextR";
	end
	-- Level
	if (TipBuddy_TargetLevel_Text:IsVisible()) then
		classFrame = (TipBuddy_TargetLevel_Text:GetHeight() + 1);
		TipBuddy_TargetLevel_Text:SetPoint("TOPLEFT",lastparent,"BOTTOMLEFT",0,-1);
		TipBuddy_TargetClass_Text:SetPoint("TOPRIGHT",lastparentr,"BOTTOMRIGHT",0,-1);
		lastparent = "TipBuddy_TargetLevel_Text";
		lastparentr = "TipBuddy_TargetClass_Text";
	end
	-- Xtra1
	if (TipBuddy_Xtra1_Text:IsVisible()) then
		TipBuddy_Xtra1_Text:SetPoint("TOPLEFT",lastparent,"BOTTOMLEFT",0,-3);
		TipBuddy_XtraR1_Text:SetPoint("TOPRIGHT",lastparentr,"BOTTOMRIGHT",0,-3);
	end
	-- Xtras
	local xtraHeight = 0;
	local xtraLineL, xtraLineR;
	for i = 1, 20 do
		xtraLineL = getglobal("TipBuddy_Xtra"..i.."_Text");
		xtraLineR = getglobal("TipBuddy_XtraR"..i.."_Text");
		if (xtraLineL:IsVisible()) then
			xtraHeight = (xtraHeight + xtraLineL:GetHeight() + 1);
		elseif (xtraLineR:IsVisible()) then
			xtraHeight = (xtraHeight + xtraLineR:GetHeight() + 1); -- Az: 2007.01.24 - Changed from xtraLineL, copy/paste bug?
		end
	end
	if (xtraHeight ~= 0) then
		xtraHeight = xtraHeight + 2;
	end
	-- Set Final Height
	local tipFrameHeight = ((nameFrame + guildFrame + classFrame + healthFrame + manaFrame + cityfacFrame + xtraHeight) + 4);
	TipBuddy_Main_Frame:SetHeight(tipFrameHeight);
end

--------------------------------------------------------------------------------------------------------
--                                            Positioning                                             --
--------------------------------------------------------------------------------------------------------
--/script --TB_DebugMsg(UIParent:GetWidth()..", "..UIParent:GetHeight()); local x, y = GetCursorPosition(UIParent); --TB_DebugMsg(x..", "..y);
function TipBuddy_PositionFrameToCursor()
	-- Init
	local x, y = GetCursorPosition(UIParent);
	local x1, x2, y1, y2, tip;
	x = (x / TipBuddy.uiscale) + TipBuddy.xpos;
	y = (y / TipBuddy.uiscale) + TipBuddy.ypos;
	-- Get Frame
	if (TipBuddyTooltip:IsVisible()) then
		tip = getglobal("TipBuddyTooltip");
	elseif (TipBuddy_Main_Frame:IsVisible()) then
		tip = getglobal("TipBuddy_Main_Frame");
	else
		tip = getglobal("GameTooltip");
	end
	-- X
	if (TipBuddy.xpoint == "LEFT") then
		x1 = 0;
		x2 = (TipBuddy.uiwidth - tip:GetWidth());
	elseif (TipBuddy.xpoint == "RIGHT") then
		x1 = tip:GetWidth();
		x2 = TipBuddy.uiwidth;
	else
		x1 = tip:GetWidth() * 0.5;
		x2 = (TipBuddy.uiwidth - x1);
	end
	-- Y
	y1 = (TipBuddy.uiheight - tip:GetHeight());
	if (TipBuddy.xpoint == "TOP") then
		y2 = tip:GetHeight();
	elseif (xpoint == "BOTTOM") then
		y2 = 0;
	else
		y2 = (tip:GetHeight() * 0.5);
	end
	-- Correct
	if (x < x1) then
		x = x1;
	end
	if (x > x2) then
		x = x2;
	end
	if (y > y1) then
		y = y1;
	end
	if (y < y2) then
		y = y2;
	end

	return x, y;
end

-- GetIconAnchorPos
function TipBuddy_GetIconAnchorPos(frame)
	local x, y = TipBuddy_PositionFrameToCursor();

	if (not frame or not frame:GetLeft()) then
		return;
	end

	if (not TipBuddy.uiwidth) then
		TipBuddy.uiscale = UIParent:GetScale();
		TipBuddy.uiwidth = UIParent:GetWidth() / TipBuddy.uiscale;
		TipBuddy.uiheight = UIParent:GetHeight() / TipBuddy.uiscale;
	end

	if (y > (TipBuddy.uiheight * 0.75)) then
		--topright
		if (x > (TipBuddy.uiwidth * 0.75)) then
			if (frame:GetLeft() <= (TipBuddy.uiwidth * 0.2)) then
				return "ANCHOR_NONE", "BOTTOM", "TOP";
			end
			return "ANCHOR_BOTTOMLEFT", "TOPRIGHT", "BOTTOMLEFT";
		--topmidright
		elseif (x > (TipBuddy.uiwidth * 0.5)) then
			if (frame:GetLeft() <= (TipBuddy.uiwidth * 0.2)) then
				return "ANCHOR_NONE", "BOTTOM", "TOP";
			end
			return "ANCHOR_BOTTOMLEFT", "TOPRIGHT", "BOTTOMRIGHT";
		--cursor is topmidleft
		elseif (x > (TipBuddy.uiwidth * 0.25)) then
			if (frame:GetRight() >= (TipBuddy.uiwidth * 0.8)) then
				return "ANCHOR_NONE", "BOTTOM", "TOP";
			end
			return "ANCHOR_BOTTOMRIGHT", "TOPLEFT", "BOTTOMLEFT";
		--cursor is topleft
		else
			if (frame:GetRight() >= (TipBuddy.uiwidth * 0.8)) then
				return "ANCHOR_NONE", "BOTTOM", "TOP";
			end
			return "ANCHOR_BOTTOMRIGHT", "TOPLEFT", "BOTTOMRIGHT";
		end
	elseif (y > (TipBuddy.uiheight * 0.25)) then
		--midright
		if (x > (TipBuddy.uiwidth * 0.75)) then
			if (frame:GetLeft() <= (TipBuddy.uiwidth * 0.2)) then
				return "ANCHOR_NONE", "BOTTOM", "TOP";
			end
			return "ANCHOR_NONE", "BOTTOMRIGHT", "BOTTOMLEFT";
		else
			if (frame:GetRight() >= (TipBuddy.uiwidth * 0.8)) then
				return "ANCHOR_NONE", "BOTTOM", "TOP";
			end
			return "ANCHOR_NONE", "BOTTOMLEFT", "BOTTOMRIGHT";
		end
	else
		if (x > (TipBuddy.uiwidth * 0.75)) then
			if (frame:GetLeft() <= (TipBuddy.uiwidth * 0.2)) then
				return "ANCHOR_NONE", "BOTTOM", "TOP";
			end
			return "ANCHOR_LEFT", "BOTTOMRIGHT", "TOPLEFT";
		else
			if (frame:GetRight() >= (TipBuddy.uiwidth * 0.8)) then
				return "ANCHOR_NONE", "BOTTOM", "TOP";
			end
			return "ANCHOR_RIGHT", "BOTTOMLEFT", "TOPRIGHT";
		end
	end
end

-- GetFrameCursorOffset
local TipBuddy_CursorOffsets = {
	["Top"] = "BOTTOM",
	["Bottom"] = "TOP",
	["Right"] = "LEFT",
	["Left"] = "RIGHT",
	["Top Left"] = "BOTTOMRIGHT",
	["Top Right"] = "BOTTOMLEFT",
	["Bottom Left"] = "TOPRIGHT",
	["Bottom Right"] = "TOPLEFT",
};

function TipBuddy_GetFrameCursorOffset()
	local curpos = TipBuddy_SavedVars["general"].cursorpos;
	TipBuddy.uiscale = UIParent:GetScale();
	TipBuddy.uiwidth = UIParent:GetWidth() / TipBuddy.uiscale;
	TipBuddy.uiheight = UIParent:GetHeight() / TipBuddy.uiscale;

	local xpoint = TipBuddy_CursorOffsets[curpos] or "BOTTOMRIGHT";
	return xpoint, TipBuddy_SavedVars["general"].offset_x, TipBuddy_SavedVars["general"].offset_y;
end

-- GetFrameAnchorPos
function TipBuddy_GetFrameAnchorPos()
	local anchorpos = TipBuddy_SavedVars["general"].anchor_pos;
	-- Return: anchor, fanchor, offset
	if (anchorpos == "Top Right") then
		return "BOTTOMRIGHT", "TOPRIGHT", -2;
	elseif (anchorpos == "Top Left") then
		return "BOTTOMLEFT", "TOPLEFT", -2;
	elseif (anchorpos == "Bottom Right") then
		return "TOPRIGHT", "BOTTOMRIGHT", 2;
	elseif (anchorpos == "Bottom Left") then
		return "TOPLEFT", "BOTTOMLEFT", 2;
	elseif (anchorpos == "Top Center") then
		return "BOTTOM", "TOP", -2;
	elseif (anchorpos == "Bottom Center") then
		return "TOP", "BOTTOM", 2;
	end
end

--------------------------------------------------------------------------------------------------------
--                                               Fading                                               --
--------------------------------------------------------------------------------------------------------
function TipBuddy_Hide(frame)
	TipBuddy.hasTarget = 0;

	if (frame:GetName() == "TipBuddy_Main_Frame") then
		if (GameTooltip:IsVisible()) and (TipBuddy.compactvis ~= 1) and (not UnitExists("mouseover")) then
			TipBuddy_ForceHide(frame);
			return;
		elseif (UnitExists("mouseover")) then
			TipBuddy_ForceHide(frame);
			return;
		elseif (frame.fadingout) then
			return;
		end
	end

	local delayTime;
	if (TipBuddy_SavedVars["general"].delaytime) then
		delayTime = TipBuddy_SavedVars["general"].delaytime;
	else
		delayTime = 0;
	end
	TipBuddy.uName = nil;

	frame.startTime = GetTime();
	frame.endTime = frame.startTime + (0.01 + delayTime);
end

function TipBuddy_FadeOut(frame,func)
	if (frame:GetName() == "TipBuddy_Main_Frame") then
		TipBuddy.compactvis = nil;
	end
	if (frame.fadingout) then
		return;
	end

	frame.fadingout = 1;
	frame.fadingin = nil;
	frame.targetalpha = 0;
	frame.animfunc_fade = func;

	local fadeTime;
	if (TipBuddy_SavedVars["general"].fadetime) then
		fadeTime = TipBuddy_SavedVars["general"].fadetime;
	else
		fadeTime = 0;
	end
	UIFrameFadeRemoveFrame(frame);
	UIFrameFadeOut(frame, (0.01 + fadeTime), frame:GetAlpha(), frame.targetalpha);
end

function TipBuddy_FadeOut_Finished()
	this:Hide();
	this:SetAlpha(1);

	this.fadingout = nil;
	if (this.animfunc_fade) then
		this.animfunc_fade();
	end
end

function TipBuddy_FadeIn(frame, func)
	if (frame.fadingin) then
		return;
	end
	if (frame.fadingout) then
		UIFrameFadeRemoveFrame(frame);
	end

	frame.fadingin = 1;
	frame.fadingout = nil;
	frame.targetalpha = 1;
	frame.animfunc_fade = func;
	UIFrameFadeRemoveFrame(frame);
	UIFrameFadeIn(frame, 0.01, 0.9, frame.targetalpha);
end

function TipBuddy_FadeIn_Finished()
	this:SetAlpha(1);

	this.fadingin = nil;
	if (this.animfunc_fade) then
		this.animfunc_fade();
	end
end

--------------------------------------------------------------------------------------------------------
--                                            GameTooltip                                             --
--------------------------------------------------------------------------------------------------------
function TB_GameTooltip_IniHooks()
	-- HOOK: GameTooltip's AddLine
	if (not GameTooltip.tborgAddLine) then
		GameTooltip.tborgAddLine = GameTooltip.AddLine;
		GameTooltip.AddLine = TipBuddy_GameTooltip_AddLine;
	end
	-- HOOK: GameTooltip's AddDoubleLine
	if (not GameTooltip.tborgAddDoubleLine) then
		GameTooltip.tborgAddDoubleLine = GameTooltip.AddDoubleLine;
		GameTooltip.AddDoubleLine = TipBuddy_GameTooltip_AddDoubleLine;
	end
	-- HOOK: GameTooltip's SetUnit
	if (not GameTooltip.orgSetUnit) then
		GameTooltip.orgSetUnit = GameTooltip.SetUnit;
		GameTooltip.SetUnit = TipBuddy_GameTooltip_SetUnit;
	end
	-- HOOK GameTooltip's FadeOut
	if (not GameTooltip.orgFadeOut) then
		GameTooltip.orgFadeOut = GameTooltip.FadeOut;
		GameTooltip.FadeOut = TipBuddy_GameTooltip_FadeOut;
	end
	-- HOOK GameTooltip's SetOwner
	if (not GameTooltip.orgSetOwner) then
		GameTooltip.orgSetOwner = GameTooltip.SetOwner;
		GameTooltip.SetOwner = TipBuddy_GameTooltip_SetOwner;
	end
	-- HOOK GameTooltip's SetPoint
	if (not GameTooltip.orgSetPoint) then
		GameTooltip.orgSetPoint = GameTooltip.SetPoint;
		GameTooltip.SetPoint = TipBuddy_GameTooltip_SetPoint;
	end
	-- HOOK: GameTooltip's OnEvent
	if (not lGameTooltip_OnEvent_Orig) then
		lGameTooltip_OnEvent_Orig = GameTooltip:GetScript("OnEvent");
		GameTooltip:SetScript("OnEvent",TipBuddy_GameTooltip_OnEvent);
	end
	-- HOOK: GameTooltip's OnShow
	if (not lGameTooltip_OnShow_Orig) then
		lGameTooltip_OnShow_Orig = GameTooltip:GetScript("OnShow");
		GameTooltip:SetScript("OnShow",TipBuddy_GameTooltip_OnShow);
	end
end

-- HOOK: GameTooltip_SetDefaultAnchor
TB_GameTooltip_SetDefaultAnchor_Old = GameTooltip_SetDefaultAnchor;
function GameTooltip_SetDefaultAnchor(tooltip, parent)
	if (tooltip:GetName() ~= "GameTooltip" and tooltip:GetName() ~= "TipBuddyTooltip") then
		--TB_GameTooltip_SetDefaultAnchor_Old(tooltip,parent);
		TipBuddy.defanch = nil;
		return;
	end
	TipBuddy.defanch = 1;
	-- first
	if (not TipBuddy.first) then
		tooltip:Show();
	end
	-- Get points and anchors
	if (not TipBuddy.xpoint or not TipBuddy.anchor) then
		TipBuddy.xpoint, TipBuddy.xpos, TipBuddy.ypos = TipBuddy_GetFrameCursorOffset();
		TipBuddy.anchor, TipBuddy.fanchor, TipBuddy.offset = TipBuddy_GetFrameAnchorPos();
	end
	-- Clear Points
	TipBuddyTooltip:ClearAllPoints();
	GameTooltip:ClearAllPoints();
	-- Non units in UIParent (Mailboxes, braziers etc)
	if (parent == UIParent) then
		if (TipBuddy_SavedVars["general"].anchored == 1) then
			tooltip:SetOwner(parent,"ANCHOR_NONE");
			tooltip:SetPoint(TipBuddy.anchor,"TipBuddy_Parent_Frame",TipBuddy.fanchor,0,TipBuddy.offset);
		else
			if (TipBuddy_SavedVars["general"].gtt_fade == 1) then
				tooltip:SetOwner(parent,"ANCHOR_NONE");
				tooltip:SetPoint(TipBuddy.xpoint,"TipBuddy_Parent_Frame","CENTER",0,0);
			else
				tooltip:SetOwner(parent,"ANCHOR_CURSOR");
			end
		end
	-- Anchor: Cursor
	elseif (TipBuddy_SavedVars["general"].nonunit_anchor == 0) then
		tooltip:SetOwner(parent,"ANCHOR_NONE");
		tooltip:SetPoint(TipBuddy.xpoint,"TipBuddy_Parent_Frame","CENTER",0,0);
	-- Anchor: TipBuddyAnchor
	elseif (TipBuddy_SavedVars["general"].nonunit_anchor == 1) then
		tooltip:SetOwner(parent,"ANCHOR_NONE");
		tooltip:SetPoint(TipBuddy.anchor,"TipBuddy_Parent_Frame",TipBuddy.fanchor,0,TipBuddy.offset);
	-- Anchor: Smart
	elseif (TipBuddy_SavedVars["general"].nonunit_anchor == 2) then
		local oanchor, ganchor, panchor = TipBuddy_GetIconAnchorPos(parent);
		tooltip:ClearAllPoints();
		tooltip:SetOwner(parent,oanchor);
		tooltip:SetPoint(ganchor,parent:GetName(),panchor,0,0);
	end
	tooltip.default = nil;
	TipBuddy_ForceHide(TipBuddyTooltip);
	-- Anchor TB tip if we have a unit to show
	if (UnitExists("mouseover")) then
		GameTooltip.default = 0;
		if (TipBuddy_SavedVars["general"].anchored == 1) then
			TipBuddyTooltip:SetOwner(parent,"ANCHOR_NONE");
			TipBuddyTooltip:SetPoint(TipBuddy.anchor,"TipBuddy_Parent_Frame",TipBuddy.fanchor,0,TipBuddy.offset);
		else
			TipBuddyTooltip:SetOwner(parent,"ANCHOR_NONE");
			TipBuddyTooltip:SetPoint(TipBuddy.xpoint,"TipBuddy_Parent_Frame","CENTER",0,0);
		end
	end
	-- Misc
	TipBuddy.defanch = nil;
end

-- Clear extras
function TipBuddy_GTT_ClearExtras()
	TipBuddy.gotextras = nil;
	TipBuddy.gtt_xtra = nil;
	TipBuddy.gtt_xtraR = nil;
	TipBuddy.vis = nil;
end

-- HOOK: GameTooltip_OnShow
function TipBuddy_GameTooltip_OnShow()
	TipBuddy.xpoint, TipBuddy.xpos, TipBuddy.ypos = TipBuddy_GetFrameCursorOffset();
	TipBuddy.anchor, TipBuddy.fanchor, TipBuddy.offset = TipBuddy_GetFrameAnchorPos();
	-- call original function
	if (lGameTooltip_OnShow_Orig) then
		lGameTooltip_OnShow_Orig();
	end
	-- hmm
	if (TipBuddy_SavedVars["general"].reposmods) and (TipBuddy_SavedVars["general"].reposmods == 1) then
		--this adjusts the xy of the tooltip position ONLY if GameTooltip_SetDefaultAnchor hasn't
		--been called and then ONLY if it extends off the screen.
		if (TipBuddy.d_own) and ((TipBuddy.d_own):GetName()) then
			local owner = TipBuddy.d_own or this:GetParent();
			TB_DebugMsg("reposmods");
			if (UnitExists("mouseover")) then
				-- nothing
			else
				--local x2, y2 = TipBuddy_PositionFrameToCursor();
				if (not TipBuddy.uiwidth or not TipBuddy.uiheight) then
					TipBuddy.uiscale = UIParent:GetScale();
					TipBuddy.uiwidth = UIParent:GetWidth() / TipBuddy.uiscale;
					TipBuddy.uiheight = UIParent:GetHeight() / TipBuddy.uiscale;
				end
				if (GameTooltip:IsVisible() and GameTooltip:GetLeft()) then
					local scale = TipBuddy_SavedVars["general"].gtt_scale;
					local left = GameTooltip:GetLeft()* scale;
					local right = GameTooltip:GetRight()* scale;
					local top = GameTooltip:GetTop()* scale;
					local bottom = GameTooltip:GetBottom()* scale;
					local x, y = 0, 0;
					local off = false;
					if (left and left < -4) then
						x = (left * -1)/scale;
						off = true;
					elseif (right and right > TipBuddy.uiwidth+8) then
						x = (TipBuddy.uiwidth - right)/scale;
						off = true;
					end
					if (top and top > TipBuddy.uiheight+16) then
						y = (TipBuddy.uiheight - top)/scale;
						off = true;
					elseif (bottom and bottom < -4) then
						y = (bottom * -1)/scale;
						off = true;
					end
					TB_DebugMsg("scale="..scale.."  x="..x.."  -  y="..y.."  -  top="..top.."  -  height="..TipBuddy.uiheight);
					--only readjust it if it extends off the screen
					if (owner and owner:GetName() and off == true) then
						TB_DebugMsg("GameTooltip off edge");
						--local _, ganchor, panchor = TipBuddy_GetIconAnchorPos(owner);
						GameTooltip:ClearAllPoints();
						GameTooltip:SetPoint(TipBuddy.d_anch1, owner:GetName(), TipBuddy.d_anch2, x, y);
						--GameTooltip:orgSetPoint(ganchor, owner:GetName(), panchor, 0, 0);
						--/script GameTooltip:ClearAllPoints();GameTooltip:SetPoint(TipBuddy.anchor, this:GetParent():GetName(), TipBuddy.fanchor, 100, 0);
						--GameTooltip.default = nil;
					end
				end
				TipBuddy_ForceHide(TipBuddyTooltip);
			end
		end
	end

	--if (TipBuddy.d_own) and (UnitExists("mouseover")) then
	--	TipBuddy_SetFrame_BackgroundColor();
	--	TipBuddy_ForceHide(TipBuddyTooltip);
	--	TipBuddyTooltip:Hide();
	--	TipBuddyTooltip:ClearLines();
	--end

	-- Hide the tooltip if the mouseover unit no longer exist
	if (not UnitExists("mouseover")) then
		TipBuddy_SetFrame_BackgroundColor();
		TipBuddy_ForceHide(TipBuddyTooltip);
	end
end

-- HOOK: GameTooltip_OnHide
local TB_GameTooltip_OnHide_Old = GameTooltip_OnHide;
function GameTooltip_OnHide(self)
	TB_GameTooltip_OnHide_Old(self);
	TipBuddy_GTT_ClearExtras();
	TipBuddy.d_own = nil;
	TipBuddy.d_point = nil;
end

-- HOOK: GameTooltip_OnEvent
function TipBuddy_GameTooltip_OnEvent()
	lGameTooltip_OnEvent_Orig(event);
	TB_DebugMsg("TipBuddy_GameTooltip_OnEvent = "..event);
end

-- HOOK: GameTooltip_SetUnit
function TipBuddy_GameTooltip_SetUnit(this,unit)
	TipBuddy_GTT_ClearExtras();
	GameTooltip:orgSetUnit(unit);
	-- Az 2007.01.10: Added so it shows units for all types of unitframes, not just Blizz (in response to x-perl support)
	if (UnitIsUnit(unit,"mouseover")) then
		TipBuddy.hasTarget = 1;
		TipBuddy_ShowUnitTooltip(unit);
	end
end

-- HOOK: GameTooltip_FadeOut
function TipBuddy_GameTooltip_FadeOut()
	TB_DebugMsg("GameTooltip_FadeOut()")
	GameTooltip:orgFadeOut();
end

-- HOOK: GameTooltip_SetOwner
function TipBuddy_GameTooltip_SetOwner(this, owner, position, x, y)
	TipBuddy.d_own = nil;
	TipBuddy.d_point = nil;
	GameTooltip:orgSetOwner(owner, position, x, y);
	TB_DebugMsg(TB_WHT_TXT.."SetOwner");
	-- if this tooltip has had its default anchor set, then don't modify it any further
	if (TipBuddy_SavedVars["general"].gtt_scale) then
		GameTooltip:SetScale(2);
		local ttScale = TipBuddy_SavedVars["general"].gtt_scale;
		if (EnhancedTooltip and EnhancedTooltip:IsVisible()) then
			ttScale = 1.0;
		end
		TipBuddy_SetEffectiveScale(GameTooltip, ttScale, UIParent);
	end
	if (TipBuddy.defanch) then
		return;
	end
	--/script if (GameTooltip:IsOwned(BrowseButton1Item)) then TB_DebugMsg("0wn3d")end;
	TB_DebugMsg(TB_WHT_TXT.."SetOwner Modify");
	if (owner and owner:GetName() and TipBuddy_SavedVars["general"].reposmods and TipBuddy_SavedVars["general"].reposmods == 1) then
		-- need to check for the position because some mods don't set a position
		if (position) then
			TB_DebugMsg(position..GetTime());
			position = string.gsub(position, "ANCHOR_", "");
			--TB_DebugMsg(position);
			if (TB_ANCHOR[position]) then
				TipBuddy.d_anch1 = TB_ANCHOR[position].a;
				TipBuddy.d_anch2 = TB_ANCHOR[position].b;
			elseif (position == "NONE") then
				--don't do anything
				return;
			else
				TipBuddy.d_anch1 = "BOTTOMRIGHT";
				TipBuddy.d_anch2 = "BOTTOMLEFT";
			end
		else
			--if no positioned was passed, use the default position for anchoring
			TipBuddy.d_anch1 = "BOTTOMRIGHT";
			TipBuddy.d_anch2 = "BOTTOMLEFT";
		end
		--TB_DebugMsg(owner:GetName());
		TipBuddy.d_own = owner;
		-- we have to set the anchor to NONE because otherwise, we can't reposition it with SetPoint
		GameTooltip:orgSetOwner(owner, "ANCHOR_NONE");
		if (not x) then
			x = 0;
		end
		if (not y) then
			y = 0;
		end
		GameTooltip:ClearAllPoints();
		GameTooltip:orgSetPoint(TipBuddy.d_anch1, owner:GetName(), TipBuddy.d_anch2, x, y);
		--TB_DebugMsg(TipBuddy.d_anch1);
	end
	TB_DebugMsg(TB_WHT_TXT.."endSetOwner");
	--"ANCHOR_NONE"
end

-- HOOK: GameTooltip_SetPoint
function TipBuddy_GameTooltip_SetPoint(this,pos1,parent,pos2,x,y)
	if (not pos1 or not parent) then
		return;
	end
	TipBuddy.d_point = 1;
	if (TipBuddy_SavedVars["general"].gtt_scale) then
		TipBuddyTooltip:SetScale(2);
		TipBuddy_SetEffectiveScale(TipBuddyTooltip, TipBuddy_SavedVars["general"].gtt_scale, UIParent);
		TB_DebugMsg("SCALE = "..TipBuddy_SavedVars["general"].gtt_scale);
	end
	GameTooltip:orgSetPoint(pos1, parent, pos2, x, y);
	TB_DebugMsg(TB_WHT_TXT.."SetPoint");
end

-- HOOK: GameTooltip_AddLine
function TipBuddy_GameTooltip_AddLine(frame,text,r,g,b,nowrap)
	-- default to mouseover
	if (not TipBuddy.targetUnit) then
		TipBuddy.targetUnit = "mouseover";
	end
	-- call original handler
	GameTooltip:tborgAddLine(text,r,g,b,nowrap);
	if (not text or text == "") then
		return;
	end
	-- hmm
	if (not TipBuddyTooltip:IsVisible() and not TipBuddy_Main_Frame:IsVisible() and not TipBuddy.vis) then
		if (TipBuddy_SavedVars["general"].blizdefault == 1) and (not TipBuddy.gotextras) then
			if (not TipBuddy.gtt_xtra) then
				TipBuddy.gtt_xtra = {};
			end
			for i = 1, 32 do
				if (not TipBuddy.gtt_xtra[i]) then
					TipBuddy.gtt_xtra[i.."color"] = {};
					TipBuddy.gtt_xtra[i.."color"].r, TipBuddy.gtt_xtra[i.."color"].g, TipBuddy.gtt_xtra[i.."color"].b = r, g, b;
					TipBuddy.gtt_xtra[i] = text;
					break;
				end
			end
		end
		return;
	end
	-- get target type
	if (not TipBuddy.targetType) then
		TipBuddy.targetType = TipBuddy_TargetInfo_GetTargetType(TipBuddy.targetUnit);
	end
	-- hmm2
	if (TipBuddy_Main_Frame:IsVisible()) then
		local line;
		for i = 1, 20 do
			line = getglobal("TipBuddy_Xtra"..i.."_Text");
			if (line:GetText()) and (line:IsShown()) then
				--TB_DebugMsg("line:  "..i.." = occupied");
				--return;
			else
				line:SetText(text);
				if (not r) then
					r, g, b = NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b;
				end
				line:SetTextColor(r,g,b);
				line:Show();
				break;
			end
		end

		TipBuddy_FrameHeights_Initialize(TipBuddy.targetType);
		TipBuddy_SetFrame_Width();
	else
		if (text == " ") then
			return;
		end
		TipBuddyTooltip:AddLine(text,r,g,b,nowrap);
		TipBuddyTooltip:Show();
	end
end

--/script GameTooltip:AddDoubleLine("text", "something", 1, 0, 1, 0, 0, 1);
function TipBuddy_GameTooltip_AddDoubleLine(frame, textL, textR, Lr, Lg, Lb, Rr, Rg, Rb)
	-- default to mouseover
	if (not TipBuddy.targetUnit) then
		TipBuddy.targetUnit = "mouseover";
	end
	-- call original handler
	GameTooltip:tborgAddDoubleLine(textL, textR, Lr, Lg, Lb, Rr, Rg, Rb);
	if (not textL or textL == "") then
		return;
	end
	-- hmm
	if (not TipBuddyTooltip:IsVisible() and not TipBuddy_Main_Frame:IsVisible() and not TipBuddy.vis) then
		if (TipBuddy_SavedVars["general"].blizdefault == 1 and not TipBuddy.gotextras) then
			if (not TipBuddy.gtt_xtra) then
				TipBuddy.gtt_xtra = {};
			end
			if (not TipBuddy.gtt_xtraR) then
				TipBuddy.gtt_xtraR = {};
			end
			for i = 1, 32 do
				if (not TipBuddy.gtt_xtra[i]) then
					TipBuddy.gtt_xtra[i.."color"] = {};
					TipBuddy.gtt_xtra[i.."color"].r, TipBuddy.gtt_xtra[i.."color"].g, TipBuddy.gtt_xtra[i.."color"].b = Lr, Lg, Lb;
					TipBuddy.gtt_xtra[i] = textL;
					if (textR) then
						TipBuddy.gtt_xtraR[i.."color"] = {};
						TipBuddy.gtt_xtraR[i.."color"].r, TipBuddy.gtt_xtraR[i.."color"].g, TipBuddy.gtt_xtraR[i.."color"].b = Rr, Rg, Rb;
						TipBuddy.gtt_xtraR[i] = textR;
					end
					--TB_DebugMsg("GTTADDDOUBLELINE!!!!!!!!!:  adding = "..textL.." : "..textR);
					break;
				end
			end
		end
		return;
	end
	-- get target type
	if (not TipBuddy.targetType) then
		TipBuddy.targetType = TipBuddy_TargetInfo_GetTargetType(TipBuddy.targetUnit);
	end
	--TB_DebugMsg("GTTADDDOUBLELINE!!!!!!!!!:  "..TipBuddy.targetType.." = "..textL.." : "..textR);

	if (TipBuddy_Main_Frame:IsVisible()) then
		local lineL, lineR;
		for i = 1, 20 do
			lineL = getglobal("TipBuddy_Xtra"..i.."_Text");
			lineR = getglobal("TipBuddy_XtraR"..i.."_Text");
			if (lineL:GetText() and lineL:IsShown()) then
				--return;
			else
				lineL:SetText(textL);
				if (not Lr) then
					Lr, Lg, Lb = NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b;
				end
				lineL:SetTextColor(Lr, Lg, Lb);
				lineL:Show();
				lineR:SetText(textR);
				if (not Rr) then
					Rr, Rg, Rb = NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b;
				end
				lineR:SetTextColor(Rr, Rg, Rb);
				lineR:Show();
				break;
			end
		end
		TipBuddy_FrameHeights_Initialize(TipBuddy.targetType);
		TipBuddy_SetFrame_Width();
	else
		TipBuddyTooltip:AddDoubleLine(textL, textR, Lr, Lg, Lb, Rr, Rg, Rb);
		TipBuddyTooltip:Show();
		--/script TipBuddyTooltip:AddDoubleLine("what", "the fuck");TipBuddyTooltip:Show();
	end
end