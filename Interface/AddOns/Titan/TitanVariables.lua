-- Global variables 
TitanSettings = nil;
TitanPlayerSettings = nil;
TitanPluginSettings = nil;
TitanPanelSettings = nil;

TITAN_VERSION = "4.1.5.30000";

local _G = getfenv(0);

-- LSM 3.0 registration
local media = LibStub("LibSharedMedia-3.0")

function TitanVariables_InitTitanSettings()
	if (not TitanSettings) then
		TitanSettings = {};
	end
	
	TitanSettings.Version = TITAN_VERSION;
	TITAN_PANEL_SELECTED = "Main";
end

function TitanVariables_InitDetailedSettings()
	if (not TitanPlayerSettings) then
		TitanVariables_InitPlayerSettings();
		if (TitanPlayerSettings) then
						
			-- Syncronize Plugins/Panel settings
			TitanVariables_SyncPluginSettings();
			TitanVariables_SyncPanelSettings();
			TitanVariables_HandleLDB();
		end					
	end	
end

function TitanVariables_HandleLDB()
-- Handle LDB
			 local plugin, index, id;
				for index, id in pairs(TitanPluginsIndex) do
		 		plugin = TitanUtils_GetPlugin(id);		 			
		 		  if plugin.ldb == "launcher" and TitanGetVar(id, "DisplayOnRightSide") then
			    	  local button = TitanUtils_GetButton(id);
			    		local buttonText = _G[button:GetName().."Text"];
			    		if not TitanGetVar(id, "ShowIcon") then
						  	TitanToggleVar(id, "ShowIcon");	
						  end
			    		TitanPanelButton_UpdateButton(id);
								if buttonText then
										buttonText:SetText("")
										button:SetWidth(16);
								  	TitanPlugins[id].buttonTextFunction = nil;
										_G["TitanPanel"..id.."ButtonText"] = nil;
										local found = nil;
										for index, _ in ipairs(TITAN_PANEL_NONMOVABLE_PLUGINS) do
												if id == TITAN_PANEL_NONMOVABLE_PLUGINS[index] then
									  			found = true;
												end
										end
										if not found then table.insert(TITAN_PANEL_NONMOVABLE_PLUGINS, id); end
											if button:IsVisible() then
												TitanPanel_RemoveButton(id);
												TitanPanel_AddButton(id);
										  end
							  end
					elseif plugin.ldb == "launcher" and not TitanGetVar(id, "DisplayOnRightSide") then
						local button = TitanUtils_GetButton(id);
			    	local buttonText = _G[button:GetName().."Text"];
			    		if not buttonText then
			    			TitanPlugins[id].buttonTextFunction = "TitanLDBShowText";
								button:CreateFontString("TitanPanel"..id.."ButtonText", "OVERLAY", "GameFontNormalSmall")
								buttonText = _G[button:GetName().."Text"];
								buttonText:SetJustifyH("LEFT");
								-- set font for the fontstring
								local currentfont = media:Fetch("font", TitanPanelGetVar("FontName"))
								buttonText:SetFont(currentfont, 10);
								local index;
								local found = nil;
									for index, _ in ipairs(TITAN_PANEL_NONMOVABLE_PLUGINS) do
										if id == TITAN_PANEL_NONMOVABLE_PLUGINS[index] then
											found = index;
										end
									end
									if found then table.remove(TITAN_PANEL_NONMOVABLE_PLUGINS, found); end
									if button:IsVisible() then
										TitanPanel_RemoveButton(id);
										TitanPanel_AddButton(id);
						  		end
			    		end
					end
		 		end
			-- /Handle LDB
end

function TitanVariables_InitPlayerSettings() 
	-- Titan should not be nil
	if (not TitanSettings) then
		return;
	end
	
	-- Init TitanSettings.Players
	if (not TitanSettings.Players ) then
		TitanSettings.Players = {};
	end
	
	local playerName = UnitName("player");
	local serverName = GetCVar("realmName");
	-- Do nothing if player name is not available
	if (playerName == nil or playerName == UNKNOWNOBJECT or playerName == UKNOWNBEING) then
		return;
	end

	if (TitanSettings.Players[playerName] and not TitanSettings[playerName .. "@" .. serverName]) then
		TitanSettings.Players[playerName.."@"..serverName] = TitanSettings.Players[playerName];
		TitanSettings.Players[playerName]=nil;
	end
	
	-- Init TitanPlayerSettings
	if (not TitanSettings.Players[playerName.."@"..serverName]) then
		TitanSettings.Players[playerName.."@"..serverName] = {};
		TitanSettings.Players[playerName.."@"..serverName].Plugins = {};
		TitanSettings.Players[playerName.."@"..serverName].Panel = {};
	end	
	
	-- Set global variables
	TitanPlayerSettings = TitanSettings.Players[playerName.."@"..serverName];
	TitanPluginSettings = TitanPlayerSettings["Plugins"];
	TitanPanelSettings = TitanPlayerSettings["Panel"];	
end

function TitanVariables_SyncPluginSettings()
	-- Init each and every plugin
	for id, plugin in pairs(TitanPlugins) do
		if (plugin and plugin.savedVariables) then
			-- Init savedVariables table
			if (not TitanPluginSettings[id]) then
				TitanPluginSettings[id] = {};
			end					
			
			-- Synchronize registered and saved variables
			TitanVariables_SyncRegisterSavedVariables(plugin.savedVariables, TitanPluginSettings[id]);			
		else
			-- Remove plugin savedVariables table if there's one
			if (TitanPluginSettings[id]) then
				TitanPluginSettings[id] = nil;
			end								
		end
	end
end

function TitanVariables_SyncPanelSettings() 
	-- Synchronize registered and saved variables
	TitanVariables_SyncRegisterSavedVariables(TITAN_PANEL_SAVED_VARIABLES, TitanPanelSettings);			
end

function TitanVariables_SyncRegisterSavedVariables(registeredVariables, savedVariables)
	if (registeredVariables and savedVariables) then
		-- Init registeredVariables
		for index, value in pairs(registeredVariables) do
			if (not TitanUtils_TableContainsIndex(savedVariables, index)) then
				savedVariables[index] = value;
			end
		end
					
		-- Remove out-of-date savedVariables
		for index, value in pairs(savedVariables) do
			if (not TitanUtils_TableContainsIndex(registeredVariables, index)) then
				savedVariables[index] = nil;
			end
		end
	end
end

function TitanGetVar(id, var)
	if (id and var and TitanPluginSettings and TitanPluginSettings[id]) then		
		-- compatibility check
		if TitanPluginSettings[id][var] == "Titan Nil" then TitanPluginSettings[id][var] = false end
		return TitanUtils_Ternary(TitanPluginSettings[id][var] == false, nil, TitanPluginSettings[id][var]);
	end
end

function TitanSetVar(id, var, value)
	if (id and var and TitanPluginSettings and TitanPluginSettings[id]) then		
		TitanPluginSettings[id][var] = TitanUtils_Ternary(value, value, false);		
	end
end

function TitanGetVarTable(id, var, position)
	if (id and var and TitanPluginSettings and TitanPluginSettings[id]) then		
		-- compatibility check
		if TitanPluginSettings[id][var][position] == "Titan Nil" then TitanPluginSettings[id][var][position] = false end
		return TitanUtils_Ternary(TitanPluginSettings[id][var][position] == false, nil, TitanPluginSettings[id][var][position]);
	end
end

function TitanSetVarTable(id, var, position, value)
	if (id and var and TitanPluginSettings and TitanPluginSettings[id]) then		
		TitanPluginSettings[id][var][position] = TitanUtils_Ternary(value, value, false);
	end
end

function TitanToggleVar(id, var)
	if (id and var and TitanPluginSettings and TitanPluginSettings[id]) then
		TitanSetVar(id, var, TitanUtils_Toggle(TitanGetVar(id, var)));
	end
end

function TitanPanelGetVar(var)
	if (var and TitanPanelSettings) then		
		if TitanPanelSettings[var] == "Titan Nil" then TitanPanelSettings[var] = false end		
		return TitanUtils_Ternary(TitanPanelSettings[var] == false, nil, TitanPanelSettings[var]);
	end
end

function TitanPanelSetVar(var, value)
	if (var and TitanPanelSettings) then		
		TitanPanelSettings[var] = TitanUtils_Ternary(value, value, false);
	end
end

function TitanPanelToggleVar(var)
	if (var and TitanPanelSettings) then
		TitanPanelSetVar(var, TitanUtils_Toggle(TitanPanelGetVar(var)));
	end
end


function TitanVariables_AppendNonMovableButtons(buttons)
	if ( buttons and type(buttons) == "table" ) then		
		for index, id in TITAN_PANEL_NONMOVABLE_PLUGINS do
			if ( not TitanUtils_TableContainsValue(buttons, id) ) then
				table.insert(buttons, id);
			end
		end
	end
	return buttons;
end


function TitanVariables_UseSettings(value)
if not value then return end

local i,k,pos;
local TitanCopyPlayerSettings = nil;
local TitanCopyPluginSettings = nil;
local TitanCopyPanelSettings = nil;

	TitanCopyPlayerSettings = TitanSettings.Players[value];
	TitanCopyPluginSettings = TitanCopyPlayerSettings["Plugins"];
	TitanCopyPanelSettings = TitanCopyPlayerSettings["Panel"];

	for index, id in pairs(TitanPanelSettings["Buttons"]) do
		local currentButton = TitanUtils_GetButton(TitanPanelSettings["Buttons"][index]);
		-- safeguard
		if currentButton then
		currentButton:Hide();
		end	
	end

	for index, id in pairs(TitanCopyPanelSettings) do
  	TitanPanelSetVar(index, TitanCopyPanelSettings[index]);		
	end
	
	
	for index, id in pairs(TitanCopyPluginSettings) do
		for var, id in pairs(TitanCopyPluginSettings[index]) do		
			TitanSetVar(index, var, TitanCopyPluginSettings[index][var])
		end
	end
	
	
	TitanVariables_HandleLDB();
	TitanPanel_InitPanelBarButton();
	TitanPanel_InitPanelButtons();
	
	-- Set panel font
			local isfontvalid, newfont, index, id;
			isfontvalid = media:IsValid("font", TitanPanelGetVar("FontName"))
			if isfontvalid then
				newfont = media:Fetch("font", TitanPanelGetVar("FontName"))
					for index, id in pairs(TitanPluginsIndex) do
						local button = TitanUtils_GetButton(id);
						local buttonText = _G[button:GetName().."Text"];
							if buttonText then
								buttonText:SetFont(newfont, 10);
							end
							-- account for plugins with child buttons
						local childbuttons = {button:GetChildren()};
							for _, child in ipairs(childbuttons) do
			  				if child then
			  					local childbuttonText = _G[child:GetName().."Text"];
			  						if childbuttonText then
			  							childbuttonText:SetFont(newfont, 10);
			  						end
			  				end
			  			end
					end
					TitanPanel_RefreshPanelButtons();				
			end
			
	if (TitanPanelGetVar("AutoHide")) then
		TitanPanelBarButton_Hide("TitanPanelBarButton", TitanPanelGetVar("Position"));
	end
	if (TitanPanelGetVar("AuxAutoHide")) then
		TitanPanelBarButton_Hide("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
	end		
	TitanPanelRightClickMenu_Close();
end
