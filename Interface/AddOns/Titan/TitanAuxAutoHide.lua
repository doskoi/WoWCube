local TITAN_AUXAUTOHIDE_ID = "AuxAutoHide";

function TitanPanelAuxAutoHideButton_OnLoad(self)
	self.registry = {
		id = TITAN_AUXAUTOHIDE_ID,
		builtIn = 1,
		version = TITAN_VERSION,
		menuText = TITAN_AUTOHIDE_MENU_TEXT, 
		tooltipTitle = TITAN_AUTOHIDE_TOOLTIP, 
	};
end

function TitanPanelAuxAutoHideButton_OnShow()
	TitanPanelAuxAutoHideButton_SetIcon();
end

function TitanPanelAuxAutoHideButton_OnClick(self, button)
	if (button == "LeftButton") then
		TitanPanelBarButton_ToggleAuxAutoHide();
	end
end

function TitanPanelAuxAutoHideButton_SetIcon()
	local icon = TitanPanelAuxAutoHideButtonIcon;
	if (TitanPanelGetVar("AuxAutoHide")) then
		icon:SetTexture("Interface\\AddOns\\Titan\\Artwork\\TitanPanelPushpinOut");
	else
		icon:SetTexture("Interface\\AddOns\\Titan\\Artwork\\TitanPanelPushpinIn");
	end	
end

function TitanPanelRightClickMenu_PrepareAuxAutoHideMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_AUXAUTOHIDE_ID].menuText);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_AUXAUTOHIDE_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end
