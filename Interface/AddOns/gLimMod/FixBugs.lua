-- <= == == == == == == == == == == == == =>
-- => 
-- => This AddOns Fix more bugs from Game
-- => 
-- <= == == == == == == == == == == == == =>
local FixBugs = CreateFrame("Frame")
FixBugs:RegisterEvent("VARIABLES_LOADED")
FixBugs:RegisterEvent("ADDON_LOADED")
FixBugs:RegisterEvent("PLAYER_ENTERING_WORLD")
FixBugs:SetScript("OnEvent", function ()
	if ( event == "ADDON_LOADED" and arg1 == "Blizzard_RaidUI" ) then
		local i;
		for i = 1, 40 do 
			local button = getglobal("RaidGroupButton"..i);
			if( button and button.unit) then
				button:SetAttribute("type", "target");
				button:SetAttribute("unit", button.unit);
			end
		end
	elseif ( event == "VARIABLES_LOADED" or event == "PLAYER_ENTERING_WORLD" ) then
			PetActionBarFrame:SetAttribute("unit", "pet");
			RegisterUnitWatch(PetActionBarFrame);
	end
end);

UIParent:UnregisterEvent("ADDON_ACTION_BLOCKED");
