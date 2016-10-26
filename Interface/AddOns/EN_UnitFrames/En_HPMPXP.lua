function EUF_Frame_OnLoad()
	this:RegisterEvent("UNIT_HEALTH")
	this:RegisterEvent("UNIT_MANA")
	this:RegisterEvent("UNIT_FOCUS")
	this:RegisterEvent("UNIT_ENERGY")
	this:RegisterEvent("UNIT_RAGE")
	this:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
	this:RegisterEvent("UNIT_LEVEL")
	this:RegisterEvent("UNIT_DISPLAYPOWER")
	this:RegisterEvent("UNIT_PET")
	this:RegisterEvent("PARTY_MEMBERS_CHANGED")
    this:RegisterEvent("PLAYER_XP_UPDATE")
    this:RegisterEvent("UPDATE_EXHAUSTION")
    this:RegisterEvent("UPDATE_FACTION")
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("VARIABLES_LOADED")
end

function EUF_Frame_OnEvent(event)
	if event == "UNIT_HEALTH" then
		EUF_HP_Update(arg1)
	elseif event == "UNIT_MANA" or event == "UNIT_FOCUS" or event == "UNIT_ENERGY" or event == "UNIT_RAGE" or event == "UPDATE_SHAPESHIFT_FORMS" then
		EUF_MP_Update(arg1)
	elseif event == "UNIT_LEVEL" or event == "UNIT_DISPLAYPOWER" then
		EUF_HP_Update(arg1)
		EUF_MP_Update(arg1)
	elseif event == "UNIT_PET" then
		EUF_PetFrameHPMP_Update()
	elseif event == "PARTY_MEMBERS_CHANGED" then
		EUF_PartyFrameHPMP_Update()
		EUF_PartyFrameDisplay_Update()
	elseif event == "PLAYER_XP_UPDATE" or event == "UPDATE_EXHAUSTION" or event == "UPDATE_FACTION" then
		EUF_FrameXPRP_Update()
	elseif event == "PLAYER_ENTERING_WORLD" then
		EUF_Frame_Update()
	elseif event == "VARIABLES_LOADED" then
		EUF_Frame_Init()
	end
end

function EUF_Frame_Init()
	PetFrame:SetPoint("TOPLEFT", "PlayerFrame", "TOPLEFT", 72, -72)
	PetName:SetPoint("BOTTOMLEFT", "PetFrame", "BOTTOMLEFT", 50, 32)
	PartyMemberFrame1:ClearAllPoints()
	PartyMemberFrame1:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 15, -180)
	PartyMemberFrame2:SetPoint("TOPLEFT", "PartyMemberFrame1PetFrame", "BOTTOMLEFT", -23, -16)
	PartyMemberFrame3:SetPoint("TOPLEFT", "PartyMemberFrame2PetFrame", "BOTTOMLEFT", -23, -16)
	PartyMemberFrame4:SetPoint("TOPLEFT", "PartyMemberFrame3PetFrame", "BOTTOMLEFT", -23, -16)
	EUF_Frame_Update()
end

function EUF_HP_Update(unit)
	if not unit or (unit ~= "player" and unit ~= "pet" and not string.find(unit, "^party%d$")) then
		return
	end
	local currValue = UnitHealth(unit)
	local maxValue = UnitHealthMax(unit)
	local percent = math.floor(currValue * 100 / maxValue)
	local digit = currValue  .. "/" .. maxValue

	if percent and maxValue > 0 then
		percent = percent .. "%"
	else
		percent = ""
		digit = ""
	end

	local unitId
	if unit == "player" then
		EUF_PlayerFrameHP:SetText(digit)
		EUF_PlayerFrameHPPercent:SetText(percent)
		PlayerFrameHealthBar:SetStatusBarColor(EUF_GetPercentColor(currValue, maxValue))
	elseif unit == "pet" then
		EUF_PetFrameHP:SetText(digit)
		PetFrameHealthBar:SetStatusBarColor(EUF_GetPercentColor(currValue, maxValue))
	elseif unit == "target" then
		EUF_TargetFrameHPPercent:SetText(percent)
		TargetFrameHealthBar:SetStatusBarColor(EUF_GetPercentColor(currValue, maxValue))
	else
		unitId = string.sub(unit, -1)
		getglobal("EUF_PartyFrame" .. unitId .. "HP"):SetText(digit)
		getglobal("PartyMemberFrame" .. unitId .. "HealthBar"):SetStatusBarColor(EUF_GetPercentColor(currValue, maxValue))
	end
end

function EUF_MP_Update(unit)
	if not unit or (unit ~= "player" and unit ~= "pet" and not string.find(unit, "^party%d$")) then
		return
	end
	local currValue = UnitMana(unit)
	local maxValue = UnitManaMax(unit)
	local digit = currValue  .. "/" .. maxValue

	if maxValue <= 0 then
		digit = ""
	end

	local unitId
	if unit == "player" then
		EUF_PlayerFrameMP:SetText(digit)
	elseif unit == "pet" then
		EUF_PetFrameMP:SetText(digit)
	elseif unit == "target" then
		if MobHealth3BlizzardPowerText or MI2_MobManaText then
			digit = ""
		end
		EUF_TargetFrameMP:SetText(digit)
	else
		unitId = string.sub(unit, -1)
		getglobal("EUF_PartyFrame" .. unitId .. "MP"):SetText(digit)
	end
end

function EUF_FrameXPRP_Update()
	if EUF_CurrentOptions["PLAYERXPRP"] == 1 then
		local name, reaction, minRP, maxRP, value = GetWatchedFactionInfo()
		if EUF_CurrentOptions["PLAYERRPSHOW"] == 1 and name then
			local color = FACTION_BAR_COLORS[reaction]
			value = value - minRP
			maxRP = maxRP - minRP
			minRP = 0
			if EUF_CurrentOptions["NOEXTBORDER"] ~= 1 then
				local pctRP = (value * 100) / maxRP
				EUF_PlayerFrameXPRPText:SetText(string.format("%s / %s   (%.1f%%)", value, maxRP, pctRP))
			else
				EUF_PlayerFrameXPRPText:SetText(string.format("%s / %s", value, maxRP))
			end
			EUF_PlayerFrameXPRPBar:SetMinMaxValues(minRP, maxRP)
			EUF_PlayerFrameXPRPBar:SetValue(value)
			EUF_PlayerFrameXPRPBar:SetStatusBarColor(color.r, color.g, color.b)
		else
			local playerXP = UnitXP("player")
			local playerXPMax = UnitXPMax("player")
			local playerXPRest = GetXPExhaustion()
			if EUF_CurrentOptions["NOEXTBORDER"] ~= 1 then
				if EUF_CurrentOptions["PLAYERXPPCT"] == 1 then
					local playerXPPct = (playerXP * 100) / playerXPMax
					EUF_PlayerFrameXPRPText:SetText(string.format("%s / %s   (%.1f%%)", playerXP, playerXPMax, playerXPPct))
				elseif playerXPRest and playerXPRest > 0 then
					EUF_PlayerFrameXPRPText:SetText(string.format("%s/%s  (+%s)", playerXP, playerXPMax, playerXPRest/2))
				else
					EUF_PlayerFrameXPRPText:SetText(string.format("%s / %s", playerXP, playerXPMax))
				end
			else
				EUF_PlayerFrameXPRPText:SetText(string.format("%s / %s", playerXP, playerXPMax))
			end
			EUF_PlayerFrameXPRPBar:SetMinMaxValues(min(0, playerXP), playerXPMax)
			EUF_PlayerFrameXPRPBar:SetValue(playerXP)
			if playerXPRest then
				EUF_PlayerFrameXPRPBar:SetStatusBarColor(0, 0.39, 0.88)
			else
				EUF_PlayerFrameXPRPBar:SetStatusBarColor(0.58, 0, 0.55)
			end
		end
		EUF_PlayerFrameXPRPText:Show()
		EUF_PlayerFrameXPRPBar:Show()
	else
		EUF_PlayerFrameXPRPText:Hide()
		EUF_PlayerFrameXPRPBar:Hide()
	end
end

function EUF_PlayerFrameHPMP_Update()
	EUF_HP_Update("player")
	EUF_MP_Update("player")
end

function EUF_PetFrameHPMP_Update()
	EUF_HP_Update("pet")
	EUF_MP_Update("pet")
end

function EUF_PartyFrameHPMP_Update()
	local i
	for i=1, GetNumPartyMembers() do
		EUF_HP_Update("party"..i)
		EUF_MP_Update("party"..i)
	end
end

function EUF_FrameHPMP_Update()
	EUF_PlayerFrameHPMP_Update()
	EUF_PetFrameHPMP_Update()
	EUF_PartyFrameHPMP_Update()
end

function EUF_PlayerFrameElite_Update()
	local yOffset = -8
	if EUF_CurrentOptions["TOPPANEL"] == 1 then
		yOffset = -26
	end
	if EUF_CurrentOptions["PLAYERELITE"] == 1 then
		PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite")
		PlayerFrame:SetPoint("TOPLEFT","UIParent","TOPLEFT", 4, yOffset)
		EUF_PlayerFrameTextureExt:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite")
		EUF_PlayerFrameXPRPBarBorder:SetDesaturated(nil)
		EUF_PlayerFrameXPRPBarBorderExt:SetDesaturated(nil)
	else
		PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame")
		PlayerFrame:SetPoint("TOPLEFT","UIParent","TOPLEFT", -25, yOffset)
		EUF_PlayerFrameTextureExt:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame")
		EUF_PlayerFrameXPRPBarBorder:SetDesaturated(1)
		EUF_PlayerFrameXPRPBarBorderExt:SetDesaturated(1)
	end
end

function EUF_PlayerFrameExtBor_Update()
	if EUF_CurrentOptions["NOEXTBORDER"] == 1 then
		EUF_PlayerFrameHP:ClearAllPoints()
		EUF_PlayerFrameHP:SetPoint("LEFT", "PlayerFrame", "TOPLEFT", 229, -47)
		EUF_PlayerFrameMP:ClearAllPoints()
		EUF_PlayerFrameMP:SetPoint("LEFT", "PlayerFrame", "TOPLEFT", 229, -58)
		if EUF_CurrentOptions["PLAYERHPMP"] == 1 then
			EUF_PlayerFrameHPPercent:ClearAllPoints()
			EUF_PlayerFrameHPPercent:SetPoint("LEFT", "PlayerFrame", "TOPLEFT", 229, -32)
		else
			EUF_PlayerFrameHPPercent:ClearAllPoints()
			EUF_PlayerFrameHPPercent:SetPoint("LEFT", "PlayerFrame", "TOPLEFT", 229, -47)
		end
		EUF_PlayerFrameBackground:Hide()
		EUF_PlayerFrameTextureExt:Hide()
		EUF_PlayerFrameXPRPBarBkgExt:SetWidth(122)
		EUF_PlayerFrameXPRPBarBorderExt:SetWidth(9)
		EUF_PlayerFrameXPRPBarBorderExt:SetTexCoord(0.84765625, 0.8828125, 0, 1)
		EUF_PlayerFrameXPRPBar:SetWidth(119)
		EUF_PlayerFrameXPRPText:ClearAllPoints()
		EUF_PlayerFrameXPRPText:SetPoint("CENTER", "PlayerFrame", 56, -19)
	else
		EUF_PlayerFrameHP:ClearAllPoints()
		EUF_PlayerFrameHP:SetPoint("CENTER", "PlayerFrame", "TOPLEFT", 262, -47)
		EUF_PlayerFrameMP:ClearAllPoints()
		EUF_PlayerFrameMP:SetPoint("CENTER", "PlayerFrame", "TOPLEFT", 262, -58)
		EUF_PlayerFrameHPPercent:ClearAllPoints()
		EUF_PlayerFrameHPPercent:SetPoint("CENTER", "PlayerFrame", "TOPLEFT", 262, -32)
		EUF_PlayerFrameBackground:Show()
		EUF_PlayerFrameTextureExt:Show()
		EUF_PlayerFrameXPRPBarBkgExt:SetWidth(192)
		EUF_PlayerFrameXPRPBarBorderExt:SetWidth(80)
		EUF_PlayerFrameXPRPBarBorderExt:SetTexCoord(0.5703125, 0.8828125, 0, 1)
		EUF_PlayerFrameXPRPBar:SetWidth(190)
		EUF_PlayerFrameXPRPText:ClearAllPoints()
		EUF_PlayerFrameXPRPText:SetPoint("CENTER", "PlayerFrame", 90, -19)
	end
end

function EUF_PlayerTargetGap_Update()
	local gap
	if EUF_CurrentOptions["NOEXTBORDER"] == 0 then
		gap = 72
	else
		if EUF_CurrentOptions["PLAYERHPMP"] == 1 then
			gap = 65
		else
			gap = 36
		end
	end
	if EUF_CurrentOptions["TARGETHPPCT"] == 1 then
		gap = gap + 45
	else
		gap = gap + 10
	end
	TargetFrame:SetPoint("TOPLEFT", "PlayerFrame", "TOPRIGHT", gap, 0)
end

function EUF_PlayerFrameDisplay_Update()
	if EUF_CurrentOptions["NOEXTBORDER"] == 1 and EUF_CurrentOptions["PLAYERHPMP"] ~= 1 then
		EUF_PlayerFrameHP:Hide()
		EUF_PlayerFrameMP:Hide()
	else
		EUF_PlayerFrameHP:Show()
		EUF_PlayerFrameMP:Show()
	end
end

function EUF_PetFrameDisplay_Update()
	local classLoc, class = UnitClass("player")
	if class == "HUNTER" then
		EUF_PetFrameHP:SetPoint("TOPLEFT", "PetFrame", "TOPLEFT", 147, -20)
		EUF_PetFrameMP:SetPoint("TOPLEFT", "PetFrame", "TOPLEFT", 147, -29)
	end
	if EUF_CurrentOptions["PETHPMP"] == 1 then
		EUF_PetFrameHP:Show()
		EUF_PetFrameMP:Show()
	else
		EUF_PetFrameHP:Hide()
		EUF_PetFrameMP:Hide()
	end
end

function EUF_TargetFrameDisplay_Update()
	if EUF_CurrentOptions["TARGETHPPCT"] == 1 then
		EUF_TargetFrameHPPercent:Show()
	else
		EUF_TargetFrameHPPercent:Hide()
	end
end

function EUF_PartyFrameDisplay_Update()
	local i
	for i=1, GetNumPartyMembers() do
		if EUF_CurrentOptions["PARTYHPMP"] == 1 then
			getglobal("EUF_PartyFrame"..i.."HP"):Show()
			getglobal("EUF_PartyFrame"..i.."MP"):Show()
		else
			getglobal("EUF_PartyFrame"..i.."HP"):Hide()
			getglobal("EUF_PartyFrame"..i.."MP"):Hide()
		end
	end
end

function EUF_FrameDisplay_Update()
	EUF_PlayerFrameDisplay_Update()
	EUF_PetFrameDisplay_Update()
	EUF_TargetFrameDisplay_Update()
	EUF_PartyFrameDisplay_Update()
end

function EUF_Frame_Update()
	EUF_FrameHPMP_Update()
	EUF_FrameXPRP_Update()
	EUF_FrameDisplay_Update()
	EUF_PlayerFrameElite_Update()
	EUF_PlayerFrameExtBor_Update()
	EUF_PlayerTargetGap_Update()
end