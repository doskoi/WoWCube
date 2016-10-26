--[[
Enhanced Unit Frames
]]

En_RealmName = GetCVar("realmName")
if not En_RealmName then
	En_RealmName = "EnUF"
end
En_PlayerName = UnitName("player")
if not En_PlayerName then
	En_PlayerName = "Unknown"
end
En_PlayerId = En_RealmName .. "|" .. En_PlayerName

EUF_Version = "2.3"
EUF_AddonId = "EUF"
EUF_AddonName = "Enhanced Unit Frames"

EUF_Options = {}

local EUF_DefaultOptions= {
	["VERSION"] = EUF_Version,
	["COMPATIBLEVERSION"] = "2.3",
	["PLAYERELITE"] = 0,
	["TOPPANEL"] = 1,
	["NOEXTBORDER"] = 0,
	["PLAYERHPMP"] = 1,
	["PLAYERXPRP"] = 1,
	["PLAYERXPPCT"] = 0,
	["PLAYERRPSHOW"] = 0,
	["PLAYERTIME"] = 0,
	["PETHPMP"] = 1,
	["PARTYHPMP"] = 1,
	["PARTYLEVEL"] = 1,
	["PARTYCLASS"] = 1,
	["TARGETHPPCT"] = 1,
	["TARGETTYPE"] = 1,
	["TARGETCLASS"] = 1,
	["TARGETICON"] = 1,
	["TARGETSHIELD"] = 1,
	["OTWARNING"] = 1,
	["TOTFRAME"] = 1,
	["TOTHPPERCENT"] = 1,
	["TOTOTFRAME"] = 1,
	["SHIFTMOVE"] = 1,
}

function EUF_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED")
	SLASH_EUF1 = "/euf"
	SLASH_EUF2 = "/enuf"
	SlashCmdList[EUF_AddonId] = function(msg)
        if EUF_OptionFrame then
            EUF_OptionFrame:Show()
        end
	end
end

function glim_Enu_Registry()
if ( gLim_RegisterButton ) then
	gLim_RegisterButton (
	EUF_TEXT_TITLE,
	EUF_TEXT_OPTION,
	"Interface\\Icons\\Spell_Shadow_DemonicTactics",
	function()	
		if ( EUF_OptionFrame:IsShown() ) then
			EUF_OptionFrame:Hide()
		else
			EUF_OptionFrame:Show()
		end
	end,
	1,
	4
	);
end
end

function EUF_OnEvent(event)
	if event == "VARIABLES_LOADED" then
		EUF_Options_Init()
		if EUF_Frame_Init then
			EUF_Frame_Init()
		end
		if EUF_TargetInfo_Update then
			EUF_TargetInfo_Update()
		end
	glim_Enu_Registry()
	--	DEFAULT_CHAT_FRAME:AddMessage(string.format("%s %s loaded.", EUF_AddonName, EUF_Version))
	end
end

function EUF_Options_Init()
	if not EUF_Options then
		EUF_Options = {}
	end
	EUF_CurrentOptions = EUF_Options[En_PlayerId]
	if not EUF_CurrentOptions then
		EUF_OptionsDefault_Load()
	end
	if not EUF_CurrentOptions["VERSION"] or EUF_DefaultOptions["COMPATIBLEVERSION"] > EUF_CurrentOptions["VERSION"] then
		EUF_OptionsDefault_Load()
	end
	EUF_CurrentOptions["VERSION"] = null
	local index, value
	for index, value in pairs(EUF_DefaultOptions) do
		if not EUF_CurrentOptions[index] then
			EUF_CurrentOptions[index] = value
		end
	end
end

function EUF_OptionsDefault_Load()
	if not EUF_Options then
		EUF_Options = {}
	end
	EUF_Options[En_PlayerId] = {}
	for index, value in pairs(EUF_DefaultOptions) do
		EUF_Options[En_PlayerId][index] = value
	end
	EUF_CurrentOptions = EUF_Options[En_PlayerId]
end

function EUF_Options_Update(oOptionId, oValue)
	if not oOptionId or not oValue then
		return -1
	end
	local optionId = string.upper(oOptionId)
	local value = tonumber(oValue)
	if value ~= 1 then
		value = 0
	end
	if not EUF_CurrentOptions[optionId] or EUF_CurrentOptions[optionId] == value then
		return
	end
	EUF_CurrentOptions[optionId] = value

	if (optionId == "PLAYERELITE") or (optionId == "TOPPANEL") then
		if EUF_PlayerFrameElite_Update then
			EUF_PlayerFrameElite_Update()
		end
	elseif (optionId == "NOEXTBORDER") then
        if EUF_PlayerFrameExtBor_Update and EUF_FrameXPRP_Update and EUF_PlayerTargetGap_Update and EUF_PlayerFrameDisplay_Update then
            EUF_PlayerFrameExtBor_Update()
            EUF_FrameXPRP_Update()
            EUF_PlayerTargetGap_Update()
            EUF_PlayerFrameDisplay_Update()
        end
	elseif (optionId == "PLAYERHPMP") then
        if EUF_PlayerFrameExtBor_Update and EUF_PlayerTargetGap_Update and EUF_PlayerFrameDisplay_Update then
            EUF_PlayerFrameExtBor_Update()
            EUF_PlayerTargetGap_Update()
            EUF_PlayerFrameDisplay_Update()
        end
	elseif (optionId == "PETHPMP") then
        if EUF_PetFrameDisplay_Update then
            EUF_PetFrameDisplay_Update()
        end
	elseif (optionId == "TARGETHPPCT") then
        if EUF_TargetFrameDisplay_Update and EUF_PlayerTargetGap_Update then
            EUF_TargetFrameDisplay_Update()
            EUF_PlayerTargetGap_Update()
        end
	elseif (optionId == "PARTYHPMP") then
        if EUF_PartyFrameDisplay_Update then
            EUF_PartyFrameDisplay_Update()
        end
    elseif (optionId == "PLAYERXPRP") or (optionId == "PLAYERXPPCT") or (optionId == "PLAYERRPSHOW") then
        if EUF_FrameXPRP_Update then
            EUF_FrameXPRP_Update()
        end
    elseif (optionId == "TARGETTYPE") then
        if EUF_TargetInfoType_Update then
            EUF_TargetInfoType_Update()
        end
    elseif (optionId == "TARGETCLASS") then
        if EUF_TargetInfoClass_Update then
            EUF_TargetInfoClass_Update()
        end
    elseif (optionId == "TARGETICON") then
        if EUF_TargetInfoIcon_Update then
            EUF_TargetInfoIcon_Update()
        end
    elseif (optionId == "TARGETSHIELD") then
        if EUF_TargetShield_Update then
            EUF_TargetShield_Update()
        end
    elseif (optionId == "OTWARNING") then
        if OTWARNING_OnUpdate then
	    OTWARNING_OnUpdate()
        end

    elseif (optionId == "TOTHPPERCENT") then
	if EUF_ToTHPPercent_Display then
		EUF_ToTHPPercent_Display()
	end
    elseif ( optionId == "TOTFRAME" ) then
	if ( EUF_CurrentOptions["TOTFRAME"] == 1 ) then
		RegisterUnitWatch(ToT_Frame)
	else
		UnregisterUnitWatch(ToT_Frame)
		ToT_Frame:Hide()
	end
    elseif ( optionId == "TOTOTFRAME" ) then
	if ( EUF_CurrentOptions["TOTOTFRAME"] == 1 ) then
		RegisterUnitWatch(ToToT_Frame)
	else
		UnregisterUnitWatch(ToToT_Frame)
		ToToT_Frame:Hide()
	end
    else
		return -1
	end
end

function EUF_GetPercentColor(value, valueMax)
	local r = 0
	local g = 1
	local b = 0
	if (value and valueMax) then
		local valuePercent =  tonumber(value) / tonumber(valueMax)
		if (valuePercent >= 0 and valuePercent <= 1) then
			if (valuePercent > 0.5) then
				r = (1.0 - valuePercent) * 2
				g = 1.0
			else
				r = 1.0
				g = valuePercent * 2
			end
		end
	end
	if r < 0 then
		r = 0
	end
	if g < 0 then
		g = 0
	end
	if b < 0 then
		b = 0
	end
	if r > 1 then
		r = 1
	end
	if g > 1 then
		g = 1
	end
	if b > 1 then
		b = 1
	end
	return r, g, b
end