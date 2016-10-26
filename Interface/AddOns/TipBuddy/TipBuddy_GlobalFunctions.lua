-- TipBuddy: Copyright 2004 by Chester --

function TipBuddy_Msg(text)
	if (text) and (DEFAULT_CHAT_FRAME) then
		if (string.find(text,"|1")) then
			text = string.gsub(text,"|1","|cffffff80");
		end
		if (string.find(text,"|2")) then
			text = string.gsub(text,"|2","|cffffffff");
		end
		DEFAULT_CHAT_FRAME:AddMessage("<|cffffffffTipBuddy|r> "..text,128/255,192/255,255/255);
	end
end
			
function TB_DebugMsg(text)
	if (text) and (TipBuddy_SavedVars.debug) then
		ChatFrame2:AddMessage(GREEN_FONT_COLOR_CODE..text);
	end
end

function TipBuddy_RGBToHex(r,g,b,text)
	if (not text) then
		text = "";
	end
	return "|cff"..string.format("%02x%02x%02x",r*255,g*255,b*255)..text;
end

--------------------------------------------------------------------------------------------------------
-- GET TARGET TYPE                                                                                    --
--------------------------------------------------------------------------------------------------------
function TipBuddy_TargetInfo_GetTargetType(unit)
	if (not unit) then
		return;
	end
	if ((UnitHealth(unit) <= 0)) then
		return ("corpse");
	elseif ((UnitHealthMax(unit) > 0)) then
		if (string.find(unit,"party.+")) then
			return ("pc_party");
		end
		if (UnitPlayerControlled(unit)) then
			if (UnitIsFriend(unit,"player")) then
				if (TipBuddy_TargetInfo_CheckPet()) then
					return ("pet_friend");
				end

				if (UnitInParty(unit)) then
					return ("pc_party");
				else
					return ("pc_friend");
				end
			elseif (UnitIsEnemy(unit,"player")) then
				if (TipBuddy_TargetInfo_CheckPet()) then
					return ("pet_enemy");
				else
					return ("pc_enemy");
				end
			else
				return ("pet_friend");
			end
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
			else --neutral
				return ("npc_neutral");
			end
		end
	else
		TipBuddy_Hide(TipBuddy_Main_Frame);
		return;
	end
end

function TB_GetHealth_Text(unit,type)
	--TipBuddy_HealthTextGTT,TipBuddy_UpdateHealthTextGTT(TipBuddy_HealthTextGTT,unit)
	--TipBuddy_HealthText
	local health,healthmax;
	if (type == "percent") then
		health = UnitHealth(unit);
		--local percent = tonumber(format("%.0f",((health / UnitHealthMax(unit)) * 100)));
		if (unit == "player" or UnitInParty(unit) or UnitInRaid(unit)) then
			--return health.."/"..UnitHealthMax(unit);
			return tonumber(format("%.0f",((health / UnitHealthMax(unit)) * 100)));
		else
			return health;
		end
	elseif (type == "current") then
		health = UnitHealth(unit);
		if (unit == "player" or UnitInParty(unit) or UnitInRaid(unit)) then
			return health;
		else
			if (MobHealthDB) and (MobHealth_PPP) then
				local ppp = MobHealth_PPP(UnitName(unit)..":"..UnitLevel(unit));
				local curHP = math.floor(health * ppp + 0.5);
				local maxHP = math.floor(100 * ppp + 0.5);

				if (curHP and maxHP and maxHP ~= 0) then
					return curHP;
				else
					return health;
				end
			else
				return health;
			end
		end
	else
		healthmax = UnitHealthMax(unit);
		if (unit == "player" or UnitInParty(unit) or UnitInRaid(unit)) then
			return healthmax;
		else
			if (MobHealthDB) and (MobHealth_PPP) then
				local ppp = MobHealth_PPP(UnitName(unit)..":"..UnitLevel(unit));
				local maxHP = math.floor(100 * ppp + 0.5);

				if (maxHP and maxHP ~= 0) then
					return maxHP;
				else
					return healthmax;
				end
			else
				return healthmax;
			end
		end
	end
end

function TipBuddy_ReportVarStats()
	if (TipBuddy_Main_Frame:IsVisible()) then
		TB_DebugMsg("MainFrame Visible,alpha: "..TipBuddy_Main_Frame:GetAlpha());
	else
		TB_DebugMsg("MainFrame NOT Visible");
	end
	if (GameTooltip:IsVisible()) then
		TB_DebugMsg("GTT Visible");
		TB_DebugMsg("GTT Bottom = "..GameTooltip:GetBottom());
	else
		TB_DebugMsg("GTT NOT Visible");
	end
	if (TipBuddy.hasTarget == 1) then
		TB_DebugMsg("TB has target");
	else
		TB_DebugMsg("TB does NOT have target");
	end
end

function TipBuddy_GetUIScale()
	local uiScale;
	if (GetCVar("useUiScale") == "1") then
		uiScale = tonumber(GetCVar("uiscale"));
		if (uiScale > 0.9) then
			uiScale = 0.9;
		end
	else
		uiScale = 0.9;
	end
	return uiScale;
end

function TipBuddy_GetEffectiveScale(frame)
    return frame:GetEffectiveScale()
end

function TipBuddy_SetEffectiveScale(frame,scale,parentframe)
    frame.scale = scale;  -- Saved in case it needs to be re-calculated when the parent's scale changes.
    local parent = getglobal(parentframe);
    if (parent) then
        scale = scale / GetEffectiveScale(parent);
    end
    frame:SetScale(scale);
end

function TipBuddy_GetDifficultyColor(level)
	local levelDiff = level - UnitLevel("player");
	local color,text;
	if (levelDiff >= 5) then
		color = tbcolor_lvl_impossible;
		text = "Impossible";
	elseif (levelDiff >= 3) then
		color = tbcolor_lvl_verydifficult;
		text = "Very Difficult";
	elseif (levelDiff >= -2) then
		color = tbcolor_lvl_difficult;
		text = "Difficult";
	elseif (-levelDiff <= GetQuestGreenRange()) then
		color = tbcolor_lvl_standard;
		text = "Standard";
	else
		color = tbcolor_lvl_trivial;
		text = "Trivial";
	end
	return color,text;
end

function TipBuddy_ForceHide(frame)
	UIFrameFadeRemoveFrame(frame);
	frame.fadingout = nil;
	frame.fadingin = nil;
	frame:SetAlpha(0);
	frame:Hide();
end

function TipBuddy_ClearFade(frame,alpha)
	UIFrameFadeRemoveFrame(frame);
	frame.fadingout = nil;
	frame.fadingin = nil;
	frame:SetAlpha(alpha);
end

-- Fix magic chars, to use in search patterns but ignore chars which normally hold a meaning for patterns
function TipBuddy_FixMagicChars(text)
	if (text) then
		text = string.gsub(text,"%%","%%%%");
		text = string.gsub(text,"%^","%%%^");
		text = string.gsub(text,"%$","%%%$");
		text = string.gsub(text,"%.","%%%.");
		text = string.gsub(text,"%*","%%%*");
		text = string.gsub(text,"%+","%%%+");
		text = string.gsub(text,"%-","%%%-");
		text = string.gsub(text,"%?","%%%?");
		text = string.gsub(text,"%(","%%%(");
		text = string.gsub(text,"%)","%%%)");
		text = string.gsub(text,"%[","%%%[");
		text = string.gsub(text,"%]","%%%]");
	end
	return text;
end

function TB_NoNegative(num)
	if (num <= 0) then
		return 0;
	else
		return num;
	end
end

-- Start the countdown on a frame
function TipBuddyPopup_StartCounting(frame)
	if (frame.parent) then
		TipBuddyPopup_StartCounting(frame.parent);
	else
		frame.showTimer = TB_POPUP_TIMER;
		frame.isCounting = 1;
	end
end

-- Stop the countdown on a frame
function TipBuddyPopup_StopCounting(frame)
	if (frame.parent) then
		TipBuddyPopup_StopCounting(frame.parent);
	else
		frame.isCounting = nil;
	end
end

-- reaction color
function TipBuddy_GetUnitReaction(unit)
	-- Player or player controlled unit
	if (UnitIsPlayer(unit)) or (UnitPlayerControlled(unit)) then
		-- Hostile players are red
		if (UnitCanAttack(unit,"player")) then
			if (not UnitCanAttack("player",unit)) then
				return "caution";
			else
				return "hostile";
			end
		-- Players we can attack but which are not hostile are yellow
		elseif (UnitCanAttack("player",unit)) then
			return "neutral";
		-- Players we can assist but are PvP flagged are green
		elseif (UnitIsPVP(unit)) then
			return "pvp";
		-- All other players are blue (the usual state on the "blue" server)
		else
			return "friendly";
		end
	elseif (UnitIsFriend(unit,"player")) and (UnitIsPVP(unit)) then
		return "pvp";
	elseif (UnitIsTapped(unit)) and (not UnitIsTappedByPlayer(unit)) then
		return "tappedother";
	elseif (UnitIsTappedByPlayer(unit)) then
		return "tappedplayer";
	else
		local reaction = UnitReaction(unit,"player");
		if (reaction) then
			return TipBuddyUnitReaction[reaction].r;
			--return "exalted";
		else
			return "friendly";
		end
	end
end

function TipBuddy_ToggleExtras(type,quiet)
	if (type == "on") then
		TipBuddy_SavedVars["pc_friend"].xtr = 1;
		TipBuddy_SavedVars["pc_enemy"].xtr = 1;
		TipBuddy_SavedVars["pc_party"].xtr = 1;
		TipBuddy_SavedVars["pet_friend"].xtr = 1;
		TipBuddy_SavedVars["pet_enemy"].xtr = 1;
		TipBuddy_SavedVars["npc_friend"].xtr = 1;
		TipBuddy_SavedVars["npc_enemy"].xtr = 1;
		TipBuddy_SavedVars["npc_neutral"].xtr = 1;
		if (not quiet) then
			TipBuddy_Msg("Extras for all target types are now |1ON|r");
		end
		return type;
	elseif (type == "off") then
		TipBuddy_SavedVars["pc_friend"].xtr = 0;
		TipBuddy_SavedVars["pc_enemy"].xtr = 0;
		TipBuddy_SavedVars["pc_party"].xtr = 0;
		TipBuddy_SavedVars["pet_friend"].xtr = 0;
		TipBuddy_SavedVars["pet_enemy"].xtr = 0;
		TipBuddy_SavedVars["npc_friend"].xtr = 0;
		TipBuddy_SavedVars["npc_enemy"].xtr = 0;
		TipBuddy_SavedVars["npc_neutral"].xtr = 0;
		if (not quiet) then
			TipBuddy_Msg("Extras for all target types are now |1OFF|r");
		end
		return type;
	elseif (type ~= nil) then
		if (not TipBuddy_SavedVars[type]) then
			TipBuddy_Msg("Could not recognize target type: |1"..type);
			return nil;
		else
			if (TipBuddy_SavedVars[type].xtr == 1) then
				TipBuddy_SavedVars[type].xtr = 0;
				TipBuddy_Msg("No longer showing extras for target type: |1"..type);
				return type;
			else
				TipBuddy_SavedVars[type].xtr = 1;
				TipBuddy_Msg("Now showing extras for target type: |1"..type);
				return type;
			end
		end
	else
		return nil;
	end
end