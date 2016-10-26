-- <= == == == == == == == == == == == == =>
-- => 
-- =>   Common.lua
-- => 
-- =>   The Common Function
-- =>   Bryan
-- => 
-- <= == == == == == == == == == == == == =>

StaticPopupDialogs["FIRST_TIME"] = {
	text = GLIM_WELCOME,
	button1 = TEXT(GLIM_SETTING),
	OnAccept = function()
		CubeConfig.First = 1;
		gLimModSecBookShowConfig("gLimConfig");
	end,
	timeout = 0,
	showAlert = 1,
};

StaticPopupDialogs["RELOADUI_CONFIRM"] = {
	text = GLIM_RELOADUI_CONFIRM,
	button1 = TEXT(OKAY),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		ReloadUI();
	end,
	OnCancel = function(_, reason)
		if ( reason == "clicked" or reason == "timeout" ) then
			ShowUIPanel(gLimConfigSubFrame);
			gLimModMaster_DrawData();
		end 
	end,
	timeout = 30,
	showAlert = 1,
	hideOnEscape = 1
};

function RequestReloadUI()
	StaticPopup_Show("RELOADUI_CONFIRM");
end

 function CheckRevision(name)
 	local _, _, _, enabled = GetAddOnInfo(name);
	if (GetAddOnMetadata(name, "X-Revision") ~= "gLimMod" or not enabled ) then 
		return false; 
	end
	return true; 
end

function CheckStatus(var, name)
	if ( not var ) then
		return
	end
	if ( not name ) then
		name = var
	end
	local _var = AddOnConfig[var]
	if ( _var and _var == 1) then
		if (not IsAddOnLoaded(name)) then
			LoadAddOn(name);
			gLimButton_OnShow();
		end
	else
		if (IsAddOnLoaded(name)) then
			gLimConfigSubFrame:Hide();
			RequestReloadUI();
		end
	end
end