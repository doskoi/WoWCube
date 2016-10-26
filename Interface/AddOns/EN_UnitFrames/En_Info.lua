local EUF_SHIELD_THRESHOLD_RED = 2250
local EUF_SHIELD_THRESHOLD_YELLOW = 900
local EUF_CLASS_ICON = {
	["WARRIOR"]	= {0, 0.25, 0, 0.25},
	["MAGE"]	= {0.25, 0.49609375, 0, 0.25},
	["ROGUE"]	= {0.49609375, 0.7421875, 0, 0.25},
	["DRUID"]	= {0.7421875, 0.98828125, 0, 0.25},
	["HUNTER"]	= {0, 0.25, 0.25, 0.5},
	["SHAMAN"]	= {0.25, 0.49609375, 0.25, 0.5},
	["PRIEST"]	= {0.49609375, 0.7421875, 0.25, 0.5},
	["WARLOCK"]	= {0.7421875, 0.98828125, 0.25, 0.5},
	["PALADIN"]	= {0, 0.25, 0.5, 0.75}
}

function EUF_TargetInfo_OnLoad()
    this:RegisterEvent("PLAYER_TARGET_CHANGED")
end

function EUF_TargetInfo_OnEvent(event)
    if event == "PLAYER_TARGET_CHANGED" then
		EUF_TargetInfo_Update()
    end
end

function EUF_TargetInfo_Update()
	EUF_TargetInfoType_Update()
	EUF_TargetInfoClass_Update()
	EUF_TargetInfoIcon_Update()
	EUF_TargetShield_Update()
end

-- Target Type --
TargetFrame:CreateFontString("EUF_TargetFrameType", "ARTWORK", "GameTooltipTextSmall")
EUF_TargetFrameType:SetPoint("BOTTOMLEFT", TargetFrameNameBackground, "TOPLEFT", 0, 3)
EUF_TargetFrameType:SetTextColor(1, 0.75, 0)

function EUF_TargetInfoType_Update()
	local type = ""
	if EUF_CurrentOptions["TARGETTYPE"] == 1 then
		if UnitRace("target") and UnitIsPlayer("target") then
			type = type .. UnitRace("target")
		elseif UnitPlayerControlled("target") then
			if UnitCreatureFamily("target") then
				type = type .. UnitCreatureFamily("target")
			end
		else
			if UnitCreatureType("target") then
				type = type .. UnitCreatureType("target")
			end
		end
	end
	EUF_TargetFrameType:SetText(type)
end

-- Target Class --
TargetFrame:CreateFontString("EUF_TargetFrameClass", "ARTWORK", "GameFontNormalSmall")
EUF_TargetFrameClass:SetPoint("BOTTOMRIGHT", TargetFrameNameBackground, "TOPRIGHT", -6, 1)

function EUF_TargetInfoClass_Update()
	if EUF_CurrentOptions["TARGETCLASS"] == 1 and UnitIsPlayer("target") then
		local class, classEN = UnitClass("target")
		local color = RAID_CLASS_COLORS[classEN]
		EUF_TargetFrameClass:SetText(class)
		EUF_TargetFrameClass:SetTextColor(color.r, color.g, color.b)
	else
		EUF_TargetFrameClass:SetText("")
	end
end

function EUF_TargetInfoIcon_Update()
	if EUF_CurrentOptions["TARGETICON"] == 1 and UnitIsPlayer("target") then
		local class, classEN = UnitClass("target")
		EUF_TargetClassIcon:SetTexCoord(
			EUF_CLASS_ICON[classEN][1],
			EUF_CLASS_ICON[classEN][2],
			EUF_CLASS_ICON[classEN][3],
			EUF_CLASS_ICON[classEN][4])
		EUF_TargetClass:Show()
	else
		EUF_TargetClass:Hide()
	end
end

-- Target Shield --
TargetFrame:CreateFontString("EUF_TargetFrameShield", "ARTWORK", "GameFontNormalSmall")
EUF_TargetFrameShield:SetPoint("BOTTOMRIGHT", TargetFrameNameBackground, "TOPRIGHT", -15, 1)

function EUF_TargetShield_Update()
	local targetShieldString = ""
	if EUF_CurrentOptions["TARGETSHIELD"] == 1 and UnitExists("target") and not UnitIsPlayer("target") and not UnitIsDead("target") then
		local i, debuffTexture, debuffCount
		local targetShield = 0
		for i = 1, 16 do
			_, _, debuffTexture, debuffCount = UnitDebuff("target", i)
			if debuffTexture and debuffCount and debuffTexture == "Interface\\Icons\\Ability_Warrior_Sunder" then
				targetShield = debuffCount * 450
			end
		end
		if targetShield > 0 then
			if (targetShield < EUF_SHIELD_THRESHOLD_YELLOW) then
				targetShieldString = "|cffffffff" .. targetShield .. "|r"
			elseif (targetShield < EUF_SHIELD_THRESHOLD_RED) then
				targetShieldString = "|cffffff00" .. targetShield .. "|r"
			else
				targetShieldString = "|cffff0000" .. targetShield .. "|r"
			end
			targetShieldString = ">>" .. targetShieldString
		end
	end
	EUF_TargetFrameShield:SetText(targetShieldString)
end


-- Party Info --
for i = 1, 4 do
	local str = "PartyMemberFrame"..i
	local text = getglobal(str):CreateFontString(str.."Level", "ARTWORK", "GameFontNormalSmall")
	text:SetPoint("TOPLEFT", str, "BOTTOMLEFT", -10, 16)
	text:SetJustifyH("LEFT")
	text = getglobal(str):CreateFontString(str.."Class", "ARTWORK", "GameFontNormalSmall")
	text:SetPoint("TOPLEFT", str, "BOTTOMLEFT", -10, 4)
	text:SetJustifyH("LEFT")
end

local ORG_PartyMemberFrame_OnUpdate = PartyMemberFrame_OnUpdate
function PartyMemberFrame_OnUpdate(self, elapsed)
	ORG_PartyMemberFrame_OnUpdate(self, elapsed)
	if this.zPartyCountdown and this.zPartyCountdown > 0 then
		this.zPartyCountdown = this.zPartyCountdown - elapsed
		return
	end
	this.zPartyCountdown = 2
	local unit = "party"..this:GetID()
	if EUF_CurrentOptions["PARTYLEVEL"] == 1 then
		local level
		if UnitLevel(unit) and UnitLevel(unit) > 0 then
			level = UnitLevel(unit)
		else
			level = "??"
		end
		getglobal("PartyMemberFrame"..this:GetID().."Level"):SetText(level)
	else
		getglobal("PartyMemberFrame"..this:GetID().."Level"):SetText("")
	end
	if EUF_CurrentOptions["PARTYCLASS"] == 1 then
		local class, classEN = UnitClass(unit)
		if UnitClass(unit) then
			local color = RAID_CLASS_COLORS[classEN]
			getglobal("PartyMemberFrame"..this:GetID().."Class"):SetTextColor(color.r, color.g, color.b)
		else
			class = "??"
			getglobal("PartyMemberFrame"..this:GetID().."Class"):SetTextColor(1, 0.75, 0)
		end
		getglobal("PartyMemberFrame"..this:GetID().."Class"):SetText(class)
	else
		getglobal("PartyMemberFrame"..this:GetID().."Class"):SetText("")
	end
end