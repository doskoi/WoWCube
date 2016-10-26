function TipBuddy_AnchorDropDown_OnLoad()
	UIDropDownMenu_Initialize(this,TipBuddy_AnchorDropDown_Initialize,"MENU");
--	TipBuddy_SavedVars["general"]["anchor_pos"] = TipBuddy_AnchorPos[1];
--	UIDropDownMenu_SetSelectedValue(this, nil, TipBuddy_SavedVars["general"]["anchor_pos"]);
	UIDropDownMenu_SetButtonWidth(this, 50);
	UIDropDownMenu_SetWidth(this, 80);
end