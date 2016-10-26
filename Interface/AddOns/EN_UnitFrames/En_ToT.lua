
function EUF_ToT_OnLoad()
	this:RegisterEvent("PLAYER_TARGET_CHANGED")
	this:RegisterEvent("VARIABLES_LOADED")
--	this:RegisterEvent("PLAYER_ENTER_COMBAT")
--	this:RegisterEvent("PLAYER_REGEN_ENABLED")
end

function EUF_ToT_OnEvent(event)
	if ( event == "VARIABLES_LOADED" ) then
		if ( EUF_CurrentOptions["TOTFRAME"] == 1 ) then
			RegisterUnitWatch(ToT_Frame)
		else
			UnregisterUnitWatch(ToT_Frame)
			ToT_Frame:Hide()
		end
		if ( EUF_CurrentOptions["TOTOTFRAME"] == 1 ) then
			RegisterUnitWatch(ToToT_Frame)
		else
			UnregisterUnitWatch(ToToT_Frame)
			ToToT_Frame:Hide()
		end
	elseif event == "PLAYER_TARGET_CHANGED" then
		EUF_OTSound_Play = 0
	end
end

function  EUF_OT_Warning()
	if EUF_CurrentOptions["OTWARNING"] == 1 then
		if GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 then
			if (UnitIsUnit("player", "targettarget") and UnitCanAttack("target", "player")) or (UnitIsUnit("player", "targettargettarget") and UnitCanAttack("targettarget", "player")) then
				if EUF_OTSound_Play ~= 1 then
					PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav")
					EUF_OTSound_Play = 1
				end
			else
				EUF_OTSound_Play = 0
			end
		end
	end
end

function EUF_ToTHPPercent_Display()
	if EUF_CurrentOptions["TOTHPPERCENT"] == 1 and ToT_Frame:IsVisible() then
		local curHP = UnitHealth("targettarget")
		local maxHP = UnitHealthMax("targettarget")
		local percent = math.floor(curHP * 100 / maxHP)
		if maxHP > 0 and percent > 0 and percent < 100 then
					ToT_FramePercent:SetText(percent .. "%")
				else
					ToT_FramePercent:SetText("")
				end
	else
		ToT_FramePercent:SetText("")
	end
end
