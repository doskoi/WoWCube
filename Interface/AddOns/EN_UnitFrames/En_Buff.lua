local buff


-- Party Buffs/Debuffs --

for i = 1, 4 do
	local str = "PartyMemberFrame"..i
	-- buff
	for j = 1, 16 do
		buff = CreateFrame("Button", str.."Buff"..j, getglobal(str), "TargetBuffButtonTemplate")
		buff:SetID(j)
		buff:SetWidth(15)
		buff:SetHeight(15)
		buff:SetScript("OnEnter",function()
			GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT", 15, -25)
			GameTooltip:SetUnitBuff("party"..this:GetParent():GetID(), this:GetID())
		end)
		
		buff:SetScript("OnUpdate",function()
			

		end)

		buff:SetScript("OnLeave",function()
			GameTooltip:Hide()
		end)


		if j == 1 then
			buff:SetPoint("TOPLEFT", str, "TOPLEFT", 47, -32)
		else
			buff:SetPoint("LEFT", str.."Buff"..j-1, "RIGHT", 2, 0)
		end
	end
	-- debuff
	local debuffbutton1 = getglobal(str.."Debuff1")
	debuffbutton1:ClearAllPoints()
	debuffbutton1:SetPoint("LEFT", str, "RIGHT", 21, 25)
	for j = 5, 10 do
		buff = CreateFrame("Button", str.."Debuff"..j, getglobal(str), "PartyBuffButtonTemplate")
		buff:SetPoint("LEFT", str.."Debuff"..j-1, "RIGHT", 2, 0)
	end
end


-- Pet Buffs/Debuffs --

for i = 1, 10 do
	buff = CreateFrame("Button", "PetFrameBuff"..i, PetFrame, "TargetBuffButtonTemplate")
	buff:SetID(i)
	buff:SetWidth(15)
	buff:SetHeight(15)	
	buff:SetScript("OnEnter",function()
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
		GameTooltip:SetUnitBuff("pet", this:GetID())
	end)

	buff:SetScript("OnUpdate",function()
		

	end)

	buff:SetScript("OnLeave",function()
		GameTooltip:Hide()
	end)

	if i == 1 then
		buff:SetPoint("TOPLEFT", PetFrame, "TOPLEFT", 48, -42)
	else
		buff:SetPoint("LEFT", "PetFrameBuff"..i-1, "RIGHT", 2, 0)
	end
	buff = CreateFrame("Button", "PetFrameDebuff"..i, PetFrame, "PartyPetBuffButtonTemplate")
end


function PartyMemberBuffTooltip_Update(isPet)
end

local ORG_RefreshBuffs = RefreshBuffs
function RefreshBuffs(button, showBuffs, unit)
	local tmp = MAX_PARTY_DEBUFFS
	if string.find(unit, "party") and string.len(unit) == 6 then
		MAX_PARTY_DEBUFFS = 10
		for i = 1, 16 do
			_, _, buff = UnitBuff(unit, i)
			if buff then
				getglobal(button:GetName().."Buff"..i.."Icon"):SetTexture(buff)
				getglobal(button:GetName().."Buff"..i):Show()
			else
				getglobal(button:GetName().."Buff"..i):Hide()
			end
		end
	elseif unit == "pet" then
		return PetFrame_RefreshBuffs()
	end
	ORG_RefreshBuffs(button, showBuffs, unit)
	MAX_PARTY_DEBUFFS = tmp
end

function PetFrame_RefreshBuffs()
	for i = 1, 10 do
		_, _, buff = UnitBuff("pet", i)
		if buff then
			getglobal("PetFrameBuff"..i.."Icon"):SetTexture(buff)
			getglobal("PetFrameBuff"..i):Show()
		else
			getglobal("PetFrameBuff"..i):Hide()
		end
	end
	for i = 1, 10 do
		getglobal("PetFrameDebuff"..i):ClearAllPoints()
		getglobal("PetFrameDebuff"..i):SetPoint("TOP", "PetFrameBuff"..i, "BOTTOM", 0, -2)
		_, _, buff = UnitDebuff("pet", i)
		if buff then
			getglobal("PetFrameDebuff"..i.."Icon"):SetTexture(buff)
			getglobal("PetFrameDebuff"..i):Show()
		else
			getglobal("PetFrameDebuff"..i):Hide()
		end
	end
end


-- Player BuffTime --

local lOriginalBuffFrame_UpdateDuration = BuffFrame_UpdateDuration

function BuffFrame_UpdateDuration(buffButton, timeLeft)
	local duration = getglobal(buffButton:GetName().."Duration")
	if SHOW_BUFF_DURATIONS == "1" and timeLeft then
		if EUF_CurrentOptions["PLAYERTIME"] == 1 then
			local d, h, m, s
			local text
			if timeLeft <= 0 then
				text = ""
			elseif timeLeft < 60 then
				d, h, m, s = ChatFrame_TimeBreakDown(timeLeft)
				text = format("|c00FF0000%ds|r", s)
			elseif timeLeft < 3600 then
				d, h, m, s = ChatFrame_TimeBreakDown(timeLeft)
				text = format("|c00FF9B00%d:%02d|r", m, s)
			elseif timeLeft < 86400 then
				d, h, m, s = ChatFrame_TimeBreakDown(timeLeft)
				text = format("|c0000FF00%dh%dm|r", h, m)
			else
				d, h, m, s = ChatFrame_TimeBreakDown(timeLeft)
				text = format("|c0000FF00%dday", d)
			end
			duration:SetFormattedText(text)
		else
			duration:SetFormattedText(SecondsToTimeAbbrev(timeLeft))
		end
		duration:Show()
	else
		duration:Hide()
	end
end
