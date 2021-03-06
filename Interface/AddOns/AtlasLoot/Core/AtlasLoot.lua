--[[
Atlasloot Enhanced
Author Daviesh
Loot browser associating loot with instance bosses
Can be integrated with Atlas (http://www.atlasmod.com)

Functions:
AtlasLoot_OnEvent(event)
AtlasLoot_ShowMenu()
AtlasLoot_OnVariablesLoaded()
AtlasLoot_SlashCommand(msg)
AtlasLootOptions_Toggle()
AtlasLoot_OnLoad()
AtlasLootBoss_OnClick()
AtlasLoot_ShowItemsFrame()
AtlasLoot_GenerateAtlasMenu(dataID, pFrame)
AtlasLoot_SetupForAtlas()
AtlasLoot_SetItemInfoFrame()
AtlasLootItemsFrame_OnCloseButton()
AtlasLootMenuItem_OnClick()
AtlasLoot_NavButton_OnClick()
AtlasLoot_HeroicModeToggle()
AtlasLoot_IsLootTableAvailable(dataID)
AtlasLoot_GetLODModule(dataSource)
AtlasLoot_LoadAllModules()
AtlasLoot_ShowQuickLooks(button)
AtlasLoot_RefreshQuickLookButtons()
]]

AtlasLoot = LibStub("AceAddon-3.0"):NewAddon("AtlasLoot");

--Instance required libraries
local BabbleBoss = LibStub("LibBabble-Boss-3.0"):GetLookupTable();
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

--Establish version number and compatible version of Atlas
local VERSION_MAJOR = "5";
local VERSION_MINOR = "03";
local VERSION_BOSSES = "02";
ATLASLOOT_VERSION = "|cffFF8400AtlasLoot Enhanced v"..VERSION_MAJOR.."."..VERSION_MINOR.."."..VERSION_BOSSES.."|r";
ATLASLOOT_CURRENT_ATLAS = "1.13.0";
ATLASLOOT_PREVIEW_ATLAS = "1.13.1";
ATLASLOOT_POSITION = AL["Position:"];

--Standard indent to line text up with Atlas text
ATLASLOOT_INDENT = "   ";

--Make the Dewdrop menu in the standalone loot browser accessible here
AtlasLoot_Dewdrop = AceLibrary("Dewdrop-2.0");
AtlasLoot_DewdropSubMenu = AceLibrary("Dewdrop-2.0");

--Variable to cap debug spam
ATLASLOOT_DEBUGSHOWN = false;

-- Colours stored for code readability
local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";

--Establish number of boss lines in the Atlas frame for scrolling
local ATLAS_LOOT_BOSS_LINES	= 25;

--Flag so that error messages do not spam
local ATLASLOOT_POPUPSHOWN = false;

--Set the default anchor for the loot frame to the Atlas frame
AtlasLoot_AnchorFrame = AtlasFrame;

--Variables to hold hooked Atlas functions
Hooked_Atlas_Refresh = nil;
Hooked_Atlas_OnShow = nil;
Hooked_AtlasScrollBar_Update = nil;

AtlasLootCharDB={};

local AtlasLootDBDefaults = { 
    profile = {
        SavedTooltips = {},
        SafeLinks = true,
        DefaultTT = true,
        LootlinkTT = false,
        ItemSyncTT = false,
        EquipCompare = false,
        Opaque = false,
        ItemIDs = false,
        ItemSpam = false,
        MinimapButton = false,
        FuBarAttached = true,
        FuBarText = true,
        FuBarIcon = true,
        HidePanel = false,
        LastBoss = "EmptyTable",
        HeroicMode = false,
        Bigraid = false,
        AtlasLootVersion = "1",
        FuBarPosition = 1,
        AutoQuery = false,
        LoDNotify = false,
        LoadAllLoDStartup = false,
        PartialMatching = true,
        MinimapButtonAngle = 240,
        MinimapButtonRadius = 75,
        LootBrowserScale = 1.0,
        SearchOn = {
            All = true,
        },
    }
}

AtlasLoot_MenuList = {
	"PVPSET",
	"PVP70RepSET",
	"ARENASET",
	"ARENA2SET",
	"ARENA3SET",
	"ARENA4SET",
	"ENGINEERINGMENU",
	"COOKINGMENU",
};

-- Popup Box for first time users
StaticPopupDialogs["ATLASLOOT_SETUP"] = {
  text = AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."],
  button1 = AL["Setup"],
  OnAccept = function()
	  AtlasLootOptions_Toggle();
  end,
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1
};

--Popup Box for an old version of Atlas
StaticPopupDialogs["ATLASLOOT_OLD_ATLAS"] = {
  text = AL["It has been detected that your version of Atlas does not match the version that Atlasloot is tuned for ("]..ATLASLOOT_CURRENT_ATLAS..AL[").  Depending on changes, there may be the occasional error, so please visit http://www.atlasmod.com as soon as possible to update."],
  button1 = AL["OK"],
  OnAccept = function()
	  DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..RED..AL["Incompatible Atlas Detected"]);
  end,
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1
};

--[[
AtlasLoot_OnEvent(event):
event - Name of the event, passed from the API
Invoked whenever a relevant event is detected by the engine.  The function then
decides what action to take depending on the event.
]]
function AtlasLoot_OnEvent(event)
	--Addons all loaded
	if(event == "ADDON_LOADED" and arg1 == "AtlasLoot" ) then
		AtlasLoot_OnVariablesLoaded();
	--Taint errors
    elseif(event == "PLAYER_ENTERING_WORLD") then
        AtlasLootOptions_MinimapToggle();
        AtlasLootOptions_MinimapToggle();
	elseif(arg1 == "AtlasLoot") then
		--Junk command to suppress taint message
		local i=3;
	end
end

--[[
AtlasLoot_ShowMenu:
Legacy function used in Cosmos integration to open the loot browser
]]
function AtlasLoot_ShowMenu()
	AtlasLootDefaultFrame:Show();
end

--[[
AtlasLoot_OnVariablesLoaded:
Invoked by the VARIABLES_LOADED event.  Now that we are sure all the assets
the addon needs are in place, we can properly set up the mod
]]
function AtlasLoot_OnVariablesLoaded()
    AtlasLoot.db = LibStub("AceDB-3.0"):New("AtlasLootDB");
    AtlasLoot.db:RegisterDefaults(AtlasLootDBDefaults);
	if not AtlasLootCharDB then AtlasLootCharDB = {} end
	if not AtlasLootCharDB["WishList"] then AtlasLootCharDB["WishList"] = {} end
    if not AtlasLootCharDB["QuickLooks"] then AtlasLootCharDB["QuickLooks"] = {} end
	if not AtlasLootCharDB["SearchResult"] then AtlasLootCharDB["SearchResult"] = {} end
	--Add the loot browser to the special frames tables to enable closing wih the ESC key
	tinsert(UISpecialFrames, "AtlasLootDefaultFrame");
	--Set up options frame
	AtlasLootOptions_OnLoad();
	--Legacy code for those using the ultimately failed attempt at making Atlas load on demand
	if AtlasButton_LoadAtlas then
		AtlasButton_LoadAtlas();
	end
	--Hook the necessary Atlas functions
    Hooked_Atlas_Refresh = Atlas_Refresh;
    Atlas_Refresh = AtlasLoot_Refresh;
	Hooked_Atlas_OnShow = Atlas_OnShow;
	Atlas_OnShow = AtlasLoot_Atlas_OnShow;
	--Instead of hooking, replace the scrollbar driver function
    Hooked_AtlasScrollBar_Update = AtlasScrollBar_Update;
	AtlasScrollBar_Update = AtlasLoot_AtlasScrollBar_Update;
	--Disable options that don't have the supporting mods
	if( not LootLink_SetTooltip and (AtlasLoot.db.profile.LootlinkTT == true)) then
		AtlasLoot.db.profile.LootlinkTT = false;
		AtlasLoot.db.profile.DefaultTT = true;
	end
	if( not ItemSync and (AtlasLoot.db.profile.ItemSyncTT == true)) then
		AtlasLoot.db.profile.ItemSyncTT = false;
		AtlasLoot.db.profile.DefaultTT = true;
	end
	--If using an opaque items frame, change the alpha value of the backing texture
	if (AtlasLoot.db.profile.Opaque) then
		AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 1);
	else
		AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 0.65);
	end
	--If Atlas is installed, set up for Atlas
	if ( Hooked_Atlas_Refresh ) then
		AtlasLoot_SetupForAtlas();
		--If a first time user, set up options
		if( (AtlasLoot.db.profile.AtlasLootVersion == nil) or (tonumber(AtlasLoot.db.profile.AtlasLootVersion) < 40500)) then
			AtlasLoot.db.profile.SafeLinks = true;
			AtlasLoot.db.profile.AllLinks = false;
			AtlasLoot.db.profile.AtlasLootVersion = VERSION_MAJOR..VERSION_MINOR..VERSION_BOSSES;
			StaticPopup_Show ("ATLASLOOT_SETUP");
		end
		--If not the expected Atlas version
		if( ATLAS_VERSION ~= ATLASLOOT_CURRENT_ATLAS and ATLAS_VERSION ~= ATLASLOOT_PREVIEW_ATLAS ) then
			StaticPopup_Show ("ATLASLOOT_OLD_ATLAS");
		end
		Hooked_Atlas_Refresh();
	else
		--If we are not using Atlas, keep the items frame out of the way
		AtlasLootItemsFrame:Hide();
	end
	--Check and migrate old WishList entry format to the newer one
	if(((AtlasLootCharDB.AtlasLootVersion == nil) or (tonumber(AtlasLootCharDB.AtlasLootVersion) < 40301)) and AtlasLootCharDB and AtlasLootCharDB["WishList"] and #AtlasLootCharDB["WishList"]~=0) then
		--Check if we really need to do a migration since it will load all modules
		--We also create a helper table here which store IDs that need to search for
		local idsToSearch = {};
		for i = 1, #AtlasLootCharDB["WishList"] do
			if (AtlasLootCharDB["WishList"][i][1] > 0 and not AtlasLootCharDB["WishList"][i][5]) then
				tinsert(idsToSearch, i, AtlasLootCharDB["WishList"][i][1]);
			end
		end
		if #idsToSearch > 0 then
			--Let's do this
			AtlasLoot_LoadAllModules();
			for _, dataSource in ipairs(AtlasLoot_SearchTables) do
				if AtlasLoot_Data[dataSource] then
					for dataID, lootTable in pairs(AtlasLoot_Data[dataSource]) do
						for _, entry in ipairs(lootTable) do
							for k, v in pairs(idsToSearch) do
								if(entry[1] == v)then
									AtlasLootCharDB["WishList"][k][5] = dataID.."|"..dataSource;
									break;
								end
							end
						end
					end
				end
			end
		end
		AtlasLootCharDB.AtlasLootVersion = VERSION_MAJOR..VERSION_MINOR..VERSION_BOSSES;
	end
	if((AtlasLootCharDB.AtlasLootVersion == nil) or (tonumber(AtlasLootCharDB.AtlasLootVersion) < 40301)) then
		AtlasLootCharDB.AtlasLootVersion = VERSION_MAJOR..VERSION_MINOR..VERSION_BOSSES;
		AtlasLootCharDB.AutoQuery = false;
		AtlasLootOptions_Init();
	end
	--Adds an AtlasLoot button to the Feature Frame in Cosmos
	if(EarthFeature_AddButton) then
		EarthFeature_AddButton(
			{
				id = string.sub(ATLASLOOT_VERSION, 11, 28);
				name = string.sub(ATLASLOOT_VERSION, 11, 28);
				subtext = string.sub(ATLASLOOT_VERSION, 30, 39);
				tooltip = "";
				icon = "Interface\\Icons\\INV_Box_01";
				callback = AtlasLoot_ShowMenu;
				test = nil;
			}
	);
	--Adds AtlasLoot to old style Cosmos installations
	elseif(Cosmos_RegisterButton) then
		Cosmos_RegisterButton(
			string.sub(ATLASLOOT_VERSION, 11, 28),
			string.sub(ATLASLOOT_VERSION, 11, 28),
			"",
			"Interface\\Icons\\INV_Box_01",
			AtlasLoot_ShowMenu
		);
	end
	--Set up the menu in the loot browser
	AtlasLoot_DewdropRegister();
	--[[Enable or disable AtlasLootFu based on selected options
	if AtlasLoot.db.profile.MinimapButton == false then
        AtlasLoot.db.profile.MinimapButton = true;
        AtlasLootOptions_MinimapToggle();
	else
        AtlasLoot.db.profile.MinimapButton = false;
        AtlasLootOptions_MinimapToggle();
    end]]
	--If EquipCompare is available, use it
	if((EquipCompare_RegisterTooltip) and (AtlasLoot.db.profile.EquipCompare == true)) then
		EquipCompare_RegisterTooltip(AtlasLootTooltip);
	end
	--Position relevant UI objects for loot browser and set up menu
	AtlasLootDefaultFrame_SelectedCategory:SetPoint("TOP", "AtlasLootDefaultFrame_Menu", "BOTTOM", 0, -4);
	AtlasLootDefaultFrame_SelectedTable:SetPoint("TOP", "AtlasLootDefaultFrame_SubMenu", "BOTTOM", 0, -4);
	AtlasLootDefaultFrame_SelectedCategory:SetText(AL["Choose Table ..."]);
	AtlasLootDefaultFrame_SelectedTable:SetText("");
	AtlasLootDefaultFrame_SelectedCategory:Show();
	AtlasLootDefaultFrame_SelectedTable:Show();
	AtlasLootDefaultFrame_SubMenu:Disable();
	if (AtlasLoot.db.profile.LoadAllLoDStartup == true) then
		AtlasLoot_LoadAllModules();
	else
		collectgarbage("collect");
	end
    panel = getglobal("AtlasLootOptionsFrame");
    panel.name=AL["AtlasLoot"];
    InterfaceOptions_AddCategory(panel);
    panel = getglobal("AtlasLootHelpFrame");
    panel.name=AL["Help"];
    panel.parent=AL["AtlasLoot"];
    InterfaceOptions_AddCategory(panel);
--    LibStub("LibAboutPanel").new(AL["AtlasLoot"], "AtlasLoot");    
    AtlasLoot_UpdateLootBrowserScale();
end

function AtlasLoot_Reset(data)
    AtlasLootDefaultFrame:Hide();
    if AtlasFrame then
        AtlasFrame:Hide();
    end
    if data == "frames" then
        AtlasLoot.db.profile.LastBoss = "EmptyTable";
		AtlasLootDefaultFrame:ClearAllPoints();
		AtlasLootDefaultFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
        if AtlasLootFu then
            AtlasLootFu.db.profile.minimapPosition = 200;
            AtlasLootFu:Hide();
            AtlasLootFu:Show();
        end
        AtlasLoot.db.profile.LootBrowserScale = 1.0;
        AtlasLoot_UpdateLootBrowserScale();
    elseif data == "quicklooks" then
        AtlasLoot.db.profile.LastBoss = "EmptyTable";
        AtlasLootCharDB["QuickLooks"] = {};
        AtlasLoot_RefreshQuickLookButtons();
    elseif data == "wishlist" then
        AtlasLoot.db.profile.LastBoss = "EmptyTable";
        AtlasLootCharDB["WishList"] = {};
        AtlasLootCharDB["SearchResult"] = {};
        AtlasLootCharDB.LastSearchedText = "";
    elseif data == "all" then
        AtlasLoot.db.profile.LastBoss = "EmptyTable";
		AtlasLootDefaultFrame:ClearAllPoints();
		AtlasLootDefaultFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
        if AtlasLootFu then
            AtlasLootFu.db.profile.minimapPosition = 200;
            AtlasLootFu:Hide();
            AtlasLootFu:Show();
        end
        AtlasLoot.db.profile.LootBrowserScale = 1.0;
        AtlasLoot_UpdateLootBrowserScale();
        AtlasLootCharDB["QuickLooks"] = {};
        AtlasLoot_RefreshQuickLookButtons();
        AtlasLootCharDB["WishList"] = {};
        AtlasLootCharDB["SearchResult"] = {};
        AtlasLootCharDB.LastSearchedText = "";
    end
    DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..RED..AL["Reset complete!"]);
end
        

--[[
AtlasLoot_SlashCommand(msg):
msg - takes the argument for the /atlasloot command so that the appropriate action can be performed
If someone types /atlasloot, bring up the options box
]]
function AtlasLoot_SlashCommand(msg)
	if msg == AL["reset"] then
		AtlasLoot_Reset("frames");
	elseif msg == AL["options"] then
		AtlasLootOptions_Toggle();
	else
		AtlasLootDefaultFrame:Show();
	end
end

--[[
AtlasLootOptions_Toggle:
Toggle on/off the options window
]]
function AtlasLootOptions_Toggle()
    if InterfaceOptionsFrame_OpenToCategory then
	    InterfaceOptionsFrame_OpenToCategory(AL["AtlasLoot"]);
    else
        InterfaceOptionsFrame_OpenToFrame(AL["AtlasLoot"]);
    end
    InterfaceOptionsFrame:SetFrameStrata("DIALOG");
    if(AtlasLoot.db.profile.DefaultTT == true) then
		AtlasLootOptions_DefaultTTToggle();
	elseif(AtlasLoot.db.profile.LootlinkTT == true) then
		AtlasLootOptions_LootlinkTTToggle();
	elseif(AtlasLoot.db.profile.ItemSyncTT == true) then
		AtlasLootOptions_ItemSyncTTToggle();
    end
end

--[[
AtlasLoot_OnLoad:
Performs inital setup of the mod and registers it for further setup when
the required resources are in place
]]
function AtlasLoot_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("ADDON_ACTION_FORBIDDEN");
	this:RegisterEvent("ADDON_ACTION_BLOCKED");
	--Enable the use of /al or /atlasloot to open the loot browser
	SLASH_ATLASLOOT1 = "/atlasloot";
	SLASH_ATLASLOOT2 = "/al";
	SlashCmdList["ATLASLOOT"] = function(msg)
		AtlasLoot_SlashCommand(msg);
	end
end

--[[
AtlasLoot_ShowItemsFrame(dataID, dataSource, boss, pFrame):
dataID - Name of the loot table
dataSource - Table in the database where the loot table is stored
boss - Text string to use as a title for the loot page
pFrame - Data structure describing how and where to anchor the item frame (more details, see the function AtlasLoot_SetItemInfoFrame)
This fuction is not normally called directly, it is usually invoked by AtlasLoot_ShowBossLoot.
It is the workhorse of the mod and allows the loot tables to be displayed any way anywhere in any mod.
]]
function AtlasLoot_ShowItemsFrame(dataID, dataSource, boss, pFrame)
	--Set up local variables needed for GetItemInfo, etc
	local itemName, itemLink, itemQuality, itemLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture, itemColor;
	local iconFrame, nameFrame, extraFrame, itemButton;
	local text, extra;
	local wlPage, wlPageMax = 1, 1;
	local isItem;
	local spellName, spellIcon;

    --If the loot table name has not been passed, throw up a debugging statement
	if dataID==nil then
		DEFAULT_CHAT_FRAME:AddMessage("No dataID!");
        return;
	end
    
    	--Get AtlasQuest out of the way
	if (AtlasQuestInsideFrame) then
		HideUIPanel(AtlasQuestInsideFrame);
	end
    
    	--Hide the toggle to switch between heroic and normal loot tables, we will only show it if required
	AtlasLootItemsFrame_Heroic:Hide();
    AtlasLoot10Man25ManSwitch:Hide();
    
    --Ditch the Quicklook selector
    AtlasLoot_QuickLooks:Hide();
    AtlasLootQuickLooksButton:Hide();
    
	dataSource_backup = dataSource;
	if dataID == "SearchResult" or dataID == "WishList" then
        dataSource = {};
        -- Match the page number to display
        wlPage = tonumber(dataSource_backup:match("%d+$"));
        -- Aquiring items of the page
        if dataID == "SearchResult" then
            dataSource[dataID], wlPageMax = AtlasLoot:GetSearchResultPage(wlPage);
        elseif dataID == "WishList" then
            dataSource[dataID], wlPageMax = AtlasLoot_GetWishListPage(wlPage);
        end
        -- Make page number reasonable
        if wlPage < 1 then wlPage = 1 end
        if wlPage > wlPageMax then wlPage = wlPageMax end
    else
        dataSource = AtlasLoot_Data;
    end

	--Set up checks to see if we have a heroic loot table or not
	local HeroicCheck=string.sub(dataID, string.len(dataID)-5, string.len(dataID));
	local HeroicdataID=dataID.."HEROIC";
	local NonHeroicdataID=string.sub(dataID, 1, string.len(dataID)-6);

	local BigraidCheck=string.sub(dataID, string.len(dataID)-4, string.len(dataID));
	local BigraiddataID=dataID.."25Man";
	local SmallraiddataID=string.sub(dataID, 1, string.len(dataID)-5);
    
	--Change the dataID to be consistant with the Heroic Mode toggle
	if dataSource then
		if((AtlasLoot.db.profile.HeroicMode == nil) or (AtlasLoot.db.profile.HeroicMode == false)) then
			if(HeroicCheck == "HEROIC") then
				if dataSource[NonHeroicdataID] then
					dataID=NonHeroicdataID;
				end
			end
		elseif(AtlasLoot.db.profile.HeroicMode == true) then
			if(HeroicCheck ~= "HEROIC") then
				if dataSource[HeroicdataID] then
					dataID=HeroicdataID;
				end
			end
		end
        if((AtlasLoot.db.profile.Bigraid == nil) or (AtlasLoot.db.profile.Bigraid == false)) then
			if(BigraidCheck == "25Man") then
				if dataSource[SmallraiddataID] then
					dataID=SmallraiddataID;
				end
			end
		elseif(AtlasLoot.db.profile.Bigraid == true) then
			if(BigraidCheck ~= "25Man") then
				if dataSource[BigraiddataID] then
					dataID=BigraiddataID;
				end
			end
		end
	end

	--Hide UI objects so that only needed ones are shown
	for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i.."_Unsafe"):Hide();
		getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootItem_"..i):Hide();
        getglobal("AtlasLootItem_"..i).itemID = 0;
	end
    
    if AtlasLoot_TableNames[dataID][2] == "Menu" then
        AtlasLoot_GenerateAtlasMenu(dataID, pFrame);
        return;
    end

	--Escape out of this function if creating a menu, this function only handles loot tables.
	--Inserting escapes in this way allows consistant calling of data whether it is a loot table or a menu.
	if(dataID=="PVPSET") then
		AtlasLootPVPSetMenu();
	elseif(dataID=="PVP70RepSET") then
		AtlasLootPVP70RepSetMenu();
	elseif(dataID=="ARENASET") then
		AtlasLootARENASetMenu();
	elseif(dataID=="ARENA2SET") then
		AtlasLootARENA2SetMenu();
	elseif(dataID=="ARENA3SET") then
		AtlasLootARENA3SetMenu();
	elseif(dataID=="ARENA4SET") then
		AtlasLootARENA4SetMenu();
	elseif(dataID=="ENGINEERINGMENU") then
		AtlasLoot_EngineeringMenu();
	elseif(dataID=="COOKINGMENU") then
		AtlasLoot_CookingMenu();
	elseif (dataID == "SearchResult") or (dataID == "WishList") or (AtlasLoot_IsLootTableAvailable(dataID)) then
		--Iterate through each item object and set its properties
		for i = 1, 30, 1 do
			--Check for a valid object (that it exists, and that it has a name)
			if(dataSource[dataID][i] ~= nil and dataSource[dataID][i][4] ~= "") then
				if string.sub(dataSource[dataID][i][2], 1, 1) == "s" then
					isItem = false;
				else
					isItem = true;
				end
				if isItem then
					itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture = GetItemInfo(dataSource[dataID][i][2]);
					--If the client has the name of the item in cache, use that instead.
					--This is poor man's localisation, English is replaced be whatever is needed
					if(GetItemInfo(dataSource[dataID][i][2])) then
						_, _, _, itemColor = GetItemQualityColor(itemQuality);
						text = itemColor..itemName;
					else
						if(GetItemInfo(dataSource[dataID][i][2])) then
							_, _, _, itemColor = GetItemQualityColor(itemQuality);
							text = itemColor..itemName;
						else
							--If the item is not in cache, use the saved value and process it
							text = dataSource[dataID][i][4];
							text = AtlasLoot_FixText(text);
						end
					end
				else
					spellName, _, spellIcon, _, _, _, _, _, _ = GetSpellInfo(string.sub(dataSource[dataID][i][2], 2));
					text = AtlasLoot_FixText(string.sub(dataSource[dataID][i][4], 1, 4)..spellName);
				end

				--Store data about the state of the items frame to allow minor tweaks or a recall of the current loot page
				AtlasLootItemsFrame.refresh = {dataID, dataSource_backup, boss, pFrame};
                
				--Insert the item description
                if dataSource[dataID][i][6] and dataSource[dataID][i][6] ~= "" then
                	extra = dataSource[dataID][i][6];
                elseif dataSource[dataID][i][5] then
                    extra = dataSource[dataID][i][5];
                else
                    extra = "";
                end
				extra = AtlasLoot_FixText(extra);

				--Use shortcuts for easier reference to parts of the item button
				itemButton = getglobal("AtlasLootItem_"..dataSource[dataID][i][1]);
				iconFrame  = getglobal("AtlasLootItem_"..dataSource[dataID][i][1].."_Icon");
				nameFrame  = getglobal("AtlasLootItem_"..dataSource[dataID][i][1].."_Name");
				extraFrame = getglobal("AtlasLootItem_"..dataSource[dataID][i][1].."_Extra");

				--If there is no data on the texture an item should have, show a big red question mark
				if dataSource[dataID][i][3] == "?" then
					iconFrame:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
				elseif dataSource[dataID][i][3] == "" then
					iconFrame:SetTexture(GetItemIcon(dataSource[dataID][i][2]));
				elseif (not isItem) and (spellIcon) then
					if tonumber(dataSource[dataID][i][3]) then
						iconFrame:SetTexture(GetItemIcon(tonumber(dataSource[dataID][i][3])));
					elseif dataSource[dataID][i][3] == "" then
						iconFrame:SetTexture(spellIcon);
                    elseif type(dataSource[dataID][i][3]) == "string" then
						iconFrame:SetTexture("Interface\\Icons\\"..dataSource[dataID][i][3]);
					else
						iconFrame:SetTexture(spellIcon);
					end
				else
					--else show the texture
					iconFrame:SetTexture("Interface\\Icons\\"..dataSource[dataID][i][3]);
				end
				itemButton.itemTexture = dataSource[dataID][i][3];
                if iconFrame:GetTexture() == nil then
					iconFrame:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
				end
                itemButton.name = text;
                itemButton.extra = extra;
				
                --Highlight items in the wishlist
                if dataSource[dataID][i][2] ~= "" and dataSource[dataID][i][2] ~= 0 and dataID ~= "WishList" then
                    if AtlasLoot_WishListCheck(dataSource[dataID][i][2]) then
                        text = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t "..text;
                    end
                end
                --Set the name and description of the item
				nameFrame:SetText(text);
				extraFrame:SetText(extra);
				extraFrame:Show();

				--For convenience, we store information about the objects in the objects so that it can be easily accessed later
				itemButton.itemID = dataSource[dataID][i][2];
                itemButton.iteminfo = {};
				if isItem then
					itemButton.iteminfo.idcore = dataSource[dataID][i][2];
					itemButton.iteminfo.icontexture = GetItemIcon(dataSource[dataID][i][2]);
				    itemButton.storeID = dataSource[dataID][i][2];
                    itemButton.dressingroomID = dataSource[dataID][i][2];
                else
				    itemButton.iteminfo.idcore = dataSource[dataID][i][3];
					itemButton.iteminfo.icontexture = GetItemIcon(dataSource[dataID][i][3]);
                    itemButton.storeID = dataSource[dataID][i][3];
                    itemButton.dressingroomID = dataSource[dataID][i][3];
				end
                if dataSource[dataID][i][5] then
                    itemButton.desc = dataSource[dataID][i][5];
                else
                    itemButton.desc = nil;
                end
                if dataSource[dataID][i][6] then
                    itemButton.price = dataSource[dataID][i][6];
                else
                    itemButton.price = nil;
                end
                if dataSource[dataID][i][7] then
				    itemButton.droprate = dataSource[dataID][i][7];
                else
                    itemButton.droprate = nil;
                end
                if (dataID == "SearchResult" or dataID == "WishList") and dataSource[dataID][i][8] then
                    itemButton.sourcePage = dataSource[dataID][i][8];
                end
				itemButton.i = 1;
				itemButton:Show();
                
                if dataSource[dataID][i][2] == 0 then getglobal("AtlasLootItem_"..i.."_Unsafe"):Hide(); end
            end
		end

        AtlasLootItemsFrame.refresh = {dataID, dataSource_backup, boss, pFrame};

        --If the item is not in cache, querying the server may cause a disconnect
        --Show a red box around the item to indicate this to the user
        --((dataSource[dataID][i][2] ~= 0) and (not GetItemInfo(dataSource[dataID][i][2]))
        for i = 1, 30, 1 do
            itemID = getglobal("AtlasLootItem_"..i).itemID;
            if itemID and itemID ~= 0 and (string.sub(itemID, 1, 1) ~= "s") then
                if GetItemInfo(itemID) then
                    getglobal("AtlasLootItem_"..i.."_Unsafe"):Hide();
                else
                    getglobal("AtlasLootItem_"..i.."_Unsafe"):Show();
                end
            else
                getglobal("AtlasLootItem_"..i.."_Unsafe"):Hide();
            end
        end
        
        --This is a valid QuickLook, so show the UI objects
        AtlasLoot_QuickLooks:Show();
        AtlasLootQuickLooksButton:Show();
        
        --Decide whether to show the Heroic mode toggle
        --Checks if a heroic version of the loot table is available.
        HeroicCheck=string.sub(dataID, string.len(dataID)-5, string.len(dataID));
        HeroicdataID=dataID.."HEROIC";
        NonHeroicdataID=string.sub(dataID, 1, string.len(dataID)-6);
        if dataSource[HeroicdataID] then
            AtlasLootItemsFrame_Heroic:Show();
            AtlasLootItemsFrame_Heroic:SetChecked(false);
            AtlasLootItemsFrame_Heroic:Enable();
        else
            if HeroicCheck=="HEROIC" then
                AtlasLootItemsFrame_Heroic:Show();
                AtlasLootItemsFrame_Heroic:SetChecked(true);
                if dataSource[NonHeroicdataID] then
                    AtlasLootItemsFrame_Heroic:Enable();
                else
                    AtlasLootItemsFrame_Heroic:Disable();
                end
            end
        end
        BigraidCheck=string.sub(dataID, string.len(dataID)-4, string.len(dataID));
        BigraiddataID=dataID.."25Man";
        if BigraidCheck=="25Man" then
            AtlasLoot10Man25ManSwitch:SetText(AL["Show 10 Man Loot"]);
            AtlasLoot10Man25ManSwitch.lootpage = string.sub(dataID, 1, string.len(dataID)-5);
            AtlasLoot10Man25ManSwitch:Show();
        else
            if dataSource[BigraiddataID] then
                AtlasLoot10Man25ManSwitch:SetText(AL["Show 25 Man Loot"]);
                AtlasLoot10Man25ManSwitch.lootpage = BigraiddataID;
                AtlasLoot10Man25ManSwitch:Show();
            end
        end
        
		--Hide navigation buttons by default, only show what we need
		getglobal("AtlasLootItemsFrame_BACK"):Hide();
		getglobal("AtlasLootItemsFrame_NEXT"):Hide();
		getglobal("AtlasLootItemsFrame_PREV"):Hide();
        if dataID ~= "SearchResult" and dataID ~= "WishList" then
		    AtlasLoot_BossName:SetText(AtlasLoot_TableNames[dataID][1]);
        else
            AtlasLoot_BossName:SetText(boss);
        end
		--Consult the button registry to determine what nav buttons are required
		if dataID == "SearchResult" or dataID == "WishList" then
			if wlPage < wlPageMax then
				getglobal("AtlasLootItemsFrame_NEXT"):Show();
				getglobal("AtlasLootItemsFrame_NEXT").lootpage = dataID.."Page"..(wlPage + 1);
			end
			if wlPage > 1 then
				getglobal("AtlasLootItemsFrame_PREV"):Show();
				getglobal("AtlasLootItemsFrame_PREV").lootpage = dataID.."Page"..(wlPage - 1);
			end
		else
			local tablebase = dataSource[dataID];
			if tablebase.Next then
				getglobal("AtlasLootItemsFrame_NEXT"):Show();
				getglobal("AtlasLootItemsFrame_NEXT").lootpage = tablebase.Next;
			end
			if tablebase.Prev then
				getglobal("AtlasLootItemsFrame_PREV"):Show();
				getglobal("AtlasLootItemsFrame_PREV").lootpage = tablebase.Prev;
			end
			if tablebase.Back then
				getglobal("AtlasLootItemsFrame_BACK"):Show();
				getglobal("AtlasLootItemsFrame_BACK").lootpage = tablebase.Back;
			end
		end
	end

	--For Alphamap and Atlas integration, show a 'close' button to hide the loot table and restore the map view
	if (AtlasLootItemsFrame:GetParent() == AlphaMapAlphaMapFrame or AtlasLootItemsFrame:GetParent() == AtlasFrame) then
		AtlasLootItemsFrame_CloseButton:Show();
	else
		AtlasLootItemsFrame_CloseButton:Hide();
	end

	--Anchor the item frame where it is supposed to be
	AtlasLoot_SetItemInfoFrame(pFrame);
end

--[[
AtlasLoot_GenerateAtlasMenu(dataID, pFrame)
dataID - Identifier of the loot table to show
pFrame - Where to anchor the menu
This function allows menus to be defined in essentially the same way as
normal loot tables
]]
function AtlasLoot_GenerateAtlasMenu(dataID, pFrame)
    local extra;
    local text;
    local dataSource = AtlasLoot_Data;
    --Hide UI objects so that only needed ones are shown
	for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i.."_Unsafe"):Hide();
		getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootItem_"..i):Hide();
	end
    for i = 1, 30, 1 do
        --Check for a valid object (that it exists, and that it has a name)
        if(AtlasLoot_Data[dataID][i] ~= nil and AtlasLoot_Data[dataID][i][4] ~= "") then

            text = AtlasLoot_Data[dataID][i][4];
            text = AtlasLoot_FixText(text);
            
            --Store data about the state of the items frame to allow minor tweaks or a recall of the current loot page
            AtlasLootItemsFrame.refresh = {dataID, "", "", pFrame};
                
            --Insert the item description
            if AtlasLoot_Data[dataID][i][5] then
                extra = AtlasLoot_Data[dataID][i][5];
            else
                extra = "";
            end
            extra = AtlasLoot_FixText(extra);

            --Use shortcuts for easier reference to parts of the item button
            itemButton = getglobal("AtlasLootMenuItem_"..AtlasLoot_Data[dataID][i][1]);
            iconFrame  = getglobal("AtlasLootMenuItem_"..AtlasLoot_Data[dataID][i][1].."_Icon");
            nameFrame  = getglobal("AtlasLootMenuItem_"..AtlasLoot_Data[dataID][i][1].."_Name");
            extraFrame = getglobal("AtlasLootMenuItem_"..AtlasLoot_Data[dataID][i][1].."_Extra");

            --If there is no data on the texture an item should have, show a big red question mark
            if AtlasLoot_Data[dataID][i][3] == "?" then
                iconFrame:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
            else
                iconFrame:SetTexture("Interface\\Icons\\"..AtlasLoot_Data[dataID][i][3]);
            end
            itemButton.itemTexture = AtlasLoot_Data[dataID][i][3];
            if iconFrame:GetTexture() == nil then
                iconFrame:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
            end
            itemButton.name = text;
            itemButton.extra = extra;
            --Store where we want the menu button to link to
            itemButton.lootpage = AtlasLoot_Data[dataID][i][2];
				
            --Set the name and description of the item
            nameFrame:SetText(text);
            extraFrame:SetText(extra);
            extraFrame:Show();

            itemButton.i = 1;
            itemButton:Show();
			
        end
        
    end
    
    
    AtlasLoot_BossName:SetText(AtlasLoot_TableNames[dataID][1]);
    
    --This is not a valid QuickLook, so hide the UI objects
    AtlasLoot_QuickLooks:Hide();
    AtlasLootQuickLooksButton:Hide();
    
    AtlasLootItemsFrame_Heroic:Hide();
    AtlasLoot10Man25ManSwitch:Hide();
    
    BigraidCheck=string.sub(dataID, string.len(dataID)-4, string.len(dataID));
    BigraiddataID=dataID.."25Man";
    if BigraidCheck=="25Man" then
        AtlasLoot10Man25ManSwitch:SetText(AL["Show 10 Man Loot"]);
        AtlasLoot10Man25ManSwitch.lootpage = string.sub(dataID, 1, string.len(dataID)-5);
        AtlasLoot10Man25ManSwitch:Show();
    else
        if dataSource[BigraiddataID] then
            AtlasLoot10Man25ManSwitch:SetText(AL["Show 25 Man Loot"]);
            AtlasLoot10Man25ManSwitch.lootpage = BigraiddataID;
            AtlasLoot10Man25ManSwitch:Show();
        end
    end
    
    --Hide navigation buttons by default, only show what we need
    getglobal("AtlasLootItemsFrame_BACK"):Hide();
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    
    local tablebase = AtlasLoot_Data[dataID];
    if tablebase.Next then
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
        getglobal("AtlasLootItemsFrame_NEXT").lootpage = tablebase.Next;
    end
    if tablebase.Prev then
        getglobal("AtlasLootItemsFrame_PREV"):Show();
        getglobal("AtlasLootItemsFrame_PREV").lootpage = tablebase.Prev;
    end
    if tablebase.Back then
        getglobal("AtlasLootItemsFrame_BACK"):Show();
        getglobal("AtlasLootItemsFrame_BACK").lootpage = tablebase.Back;
    end
    
    --For Alphamap and Atlas integration, show a 'close' button to hide the loot table and restore the map view
	if (AtlasLootItemsFrame:GetParent() == AlphaMapAlphaMapFrame or AtlasLootItemsFrame:GetParent() == AtlasFrame) then
		AtlasLootItemsFrame_CloseButton:Show();
	else
		AtlasLootItemsFrame_CloseButton:Hide();
	end

	--Anchor the item frame where it is supposed to be
	AtlasLoot_SetItemInfoFrame(pFrame);
    
end

--[[
AtlasLoot_SetItemInfoFrame(pFrame):
pFrame - Data structure with anchor info.  Format: {Anchor Point, Relative Frame, Relative Point, X Offset, Y Offset }
This function anchors the item frame where appropriate.  The main Atlas frame can be passed instead of a custom pFrame.
If no pFrame is specified, the Atlas Frame is used if Atlas is installed.
]]
function AtlasLoot_SetItemInfoFrame(pFrame)
	if ( pFrame ) then
		--If a pFrame is specified, use it
		if(pFrame==AtlasFrame and AtlasFrame) then
			AtlasLootItemsFrame:ClearAllPoints();
			AtlasLootItemsFrame:SetParent(AtlasFrame);
			AtlasLootItemsFrame:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84);
		else
			AtlasLootItemsFrame:ClearAllPoints();
			AtlasLootItemsFrame:SetParent(pFrame[2]);
			AtlasLootItemsFrame:ClearAllPoints();
			AtlasLootItemsFrame:SetPoint(pFrame[1], pFrame[2], pFrame[3], pFrame[4], pFrame[5]);
		end
	elseif ( AtlasFrame ) then
		--If no pFrame is specified and Atlas is installed, anchor in Atlas
		AtlasLootItemsFrame:ClearAllPoints();
		AtlasLootItemsFrame:SetParent(AtlasFrame);
		AtlasLootItemsFrame:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84);
	else
		--Last resort, dump the items frame in the middle of the screen
		AtlasLootItemsFrame:ClearAllPoints();
		AtlasLootItemsFrame:SetParent(UIParent);
		AtlasLootItemsFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
	end
	AtlasLootItemsFrame:Show();
end

--[[
AtlasLootItemsFrame_OnCloseButton:
Called when the close button on the item frame is clicked
]]
function AtlasLootItemsFrame_OnCloseButton()
	--Set no loot table as currently selected
	AtlasLootItemsFrame.activeBoss = nil;
	--Fix the boss buttons so the correct icons are displayed
    if AtlasFrame and AtlasFrame:IsVisible() then
        if ATLAS_CUR_LINES then
            for i=1,ATLAS_CUR_LINES do
                if getglobal("AtlasBossLine"..i.."_Selected"):IsVisible() then
                    getglobal("AtlasBossLine"..i.."_Selected"):Hide();
                    getglobal("AtlasBossLine"..i.."_Loot"):Show();
                end
            end
        end
    end
	--Hide the item frame
	AtlasLootItemsFrame:Hide();
end

--[[
AtlasLootMenuItem_OnClick:
Requests the relevant loot page from a menu screen
]]
function AtlasLootMenuItem_OnClick()
	if this.lootpage ~= nil and this.lootpage ~= "" then
		AtlasLoot_ShowBossLoot(this.lootpage, "", AtlasLoot_AnchorFrame);
	end
end

--[[
AtlasLoot_NavButton_OnClick:
Called when <-, -> or 'Back' are pressed and calls up the appropriate loot page
]]
function AtlasLoot_NavButton_OnClick()
	if AtlasLootItemsFrame.refresh and AtlasLootItemsFrame.refresh[4] then
		if strsub(this.lootpage, 1, 16) == "SearchResultPage" then
			AtlasLoot_ShowItemsFrame("SearchResult", this.lootpage, (AL["Search Result: %s"]):format(AtlasLootCharDB.LastSearchedText or ""), AtlasLootItemsFrame.refresh[4]);
		elseif strsub(this.lootpage, 1, 12) == "WishListPage" then
			AtlasLoot_ShowItemsFrame("WishList", this.lootpage, AL["WishList"], AtlasLootItemsFrame.refresh[4]);
		else
			AtlasLoot_ShowItemsFrame(this.lootpage, "", "", AtlasLootItemsFrame.refresh[4]);
		end
    else
		--Fallback for if the requested loot page is a menu and does not have a .refresh instance
		AtlasLoot_ShowItemsFrame(this.lootpage, "", "", AtlasFrame);
	end
end

--[[
AtlasLoot_HeroicModeToggle:
Switches between the heroic and normal versions of a loot page
]]
function AtlasLoot_HeroicModeToggle()
	local Heroic = AtlasLootItemsFrame.refresh[1].."HEROIC";
	local dataID = AtlasLootItemsFrame.refresh[1];
	local HeroicCheck=string.sub(dataID, string.len(dataID)-5, string.len(dataID));
	local Lootpage;
	if HeroicCheck=="HEROIC" then
		Lootpage=string.sub(dataID, 1, string.len(dataID)-6);
		AtlasLoot.db.profile.HeroicMode = false;
	else
		Lootpage=Heroic;
		AtlasLoot.db.profile.HeroicMode = true;
	end
	AtlasLoot_ShowItemsFrame(Lootpage, "", "", AtlasLootItemsFrame.refresh[4]);
end

--[[
AtlasLoot_10Man25ManToggle:
Switches between the heroic and normal versions of a loot page
]]
function AtlasLoot_10Man25ManToggle()
	local Lootpage = AtlasLoot10Man25ManSwitch.lootpage;
    if AtlasLoot.db.profile.Bigraid == true then
        AtlasLoot.db.profile.Bigraid = false
    else
        AtlasLoot.db.profile.Bigraid = true
    end
    if AtlasLootItemsFrame.refresh then
	    AtlasLoot_ShowItemsFrame(Lootpage, "", "", AtlasLootItemsFrame.refresh[4]);
    elseif AtlasLootDefaultFrame:IsVisible() then
        AtlasLoot_ShowItemsFrame(Lootpage, "", "", { "TOPLEFT", "AtlasLootDefaultFrame_LootBackground", "TOPLEFT", "2", "-2" });
    else
        AtlasLoot_ShowItemsFrame(Lootpage, "", "", nil);
    end
end

--[[
AtlasLoot_IsLootTableAvailable(dataID):
Checks if a loot table is in memory and attempts to load the correct LoD module if it isn't
dataID: Loot table dataID
]]
function AtlasLoot_IsLootTableAvailable(dataID)

	local menu_check=false;

	local moduleName=nil;

	for k,v in pairs(AtlasLoot_MenuList) do
		if v == dataID then
			menu_check=true;
		end
	end

	if menu_check then
		return true;
	else
		if not AtlasLoot_TableNames[dataID] then
			DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot Error!"].." "..WHITE..dataID..AL[" not listed in loot table registry, please report this message to the AtlasLoot forums at http://www.atlasloot.net"]);
			return false;
		end

		local dataSource = AtlasLoot_TableNames[dataID][2];

		moduleName = AtlasLoot_GetLODModule(dataSource);

		if AtlasLoot_Data[dataID] then
			return true;
		else
			if moduleName then
                if not IsAddOnLoaded(moduleName) then
                    loaded, reason=LoadAddOn(moduleName);
                    if not loaded then
                        if (reason == "MISSING") or (reason == "DISABLED") then
                            DEFAULT_CHAT_FRAME:AddMessage(GREEN..AL["AtlasLoot"]..": "..ORANGE..AtlasLoot_TableNames[dataID][1]..WHITE..AL[" is unavailable, the following load on demand module is required: "]..ORANGE..moduleName);
                            return false;
                        else
                            DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot Error!"].." "..WHITE..AL["Status of the following module could not be determined: "]..ORANGE..moduleName);
                            return false;
                        end
                    end
                end
                if AtlasLoot_Data[dataID] then
                    if AtlasLoot.db.profile.LoDNotify then
                        DEFAULT_CHAT_FRAME:AddMessage(GREEN..AL["AtlasLoot"]..": "..ORANGE..moduleName..WHITE.." "..AL["sucessfully loaded."]);
                    end
                    collectgarbage("collect");
                    return true;
                else
                    DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot Error!"].." "..ORANGE..AtlasLoot_TableNames[dataID][1]..WHITE..AL[" could not be accessed, the following module may be out of date: "]..ORANGE..moduleName);
                    return false;
                end
            else
                DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot Error!"].." "..ORANGE..AL["Loot module returned as nil!"]);
                return false;
            end
		end
	end
end

--[[
AtlasLoot_GetLODModule(dataSource)
Returns the name of the module that needs to be loaded
dataSource: Location of the loot table
]]
function AtlasLoot_GetLODModule(dataSource)
	if (dataSource=="AtlasLootOriginalWoW") then
		return "AtlasLoot_OriginalWoW";
	elseif (dataSource=="AtlasLootBurningCrusade") then
		return "AtlasLoot_BurningCrusade";
	elseif (dataSource=="AtlasLootCrafting") then
		return "AtlasLoot_Crafting";
	elseif (dataSource=="AtlasLootWorldEvents") then
		return "AtlasLoot_WorldEvents";
	elseif (dataSource=="AtlasLootWotLK") then
		return "AtlasLoot_WrathoftheLichKing";
	end
end

--[[
AtlasLoot_LoadAllModules()
Used to load all available LoD modules
]]
function AtlasLoot_LoadAllModules()
	local orig, bc, wotlk, craft, world;
    orig, _ = LoadAddOn("AtlasLoot_OriginalWoW");
    bc, _ = LoadAddOn("AtlasLoot_BurningCrusade");
    craft, _ = LoadAddOn("AtlasLoot_Crafting");
    world, _ = LoadAddOn("AtlasLoot_WorldEvents");
    wotlk, _ = LoadAddOn("AtlasLoot_WrathoftheLichKing");
    local flag=0;
	if not orig then
		LoadAddOn("AtlasLoot_OriginalWoW");
		flag=1;
	end
	if not bc then
		LoadAddOn("AtlasLoot_BurningCrusade");
		flag=1;
	end
    if not craft then
		LoadAddOn("AtlasLoot_Crafting");
		flag=1;
	end
    if not world then
		LoadAddOn("AtlasLoot_WorldEvents");
		flag=1;
	end
    if not wotlk then
		LoadAddOn("AtlasLoot_WrathoftheLichKing");
		flag=1;
	end
	if flag == 1 then
		if AtlasLoot.db.profile.LoDNotify then
			DEFAULT_CHAT_FRAME:AddMessage(GREEN..AL["AtlasLoot"]..": "..WHITE..AL["All Available Modules Loaded"]);
		end
		collectgarbage("collect");
	end
end

--[[
AtlasLoot_ShowQuickLooks(button)
button: Identity of the button pressed to trigger the function
Shows the GUI for setting Quicklooks
]]
function AtlasLoot_ShowQuickLooks(button)
	local dewdrop = AceLibrary("Dewdrop-2.0");
	if dewdrop:IsOpen(button) then
		dewdrop:Close(1);
	else
		local setOptions = function()
			dewdrop:AddLine(
				"text", AL["QuickLook"].." 1",
				"tooltipTitle", AL["QuickLook"].." 1",
				"tooltipText", AL["Assign this loot table\n to QuickLook"].." 1",
				"func", function()
                    AtlasLootCharDB["QuickLooks"][1]={AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[4]};
                    AtlasLoot_RefreshQuickLookButtons();
                    dewdrop:Close(1);
				end
			);
			dewdrop:AddLine(
				"text", AL["QuickLook"].." 2",
				"tooltipTitle", AL["QuickLook"].." 2",
				"tooltipText", AL["Assign this loot table\n to QuickLook"].." 2",
				"func", function()
					AtlasLootCharDB["QuickLooks"][2]={AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[4]};
                    AtlasLoot_RefreshQuickLookButtons();
                    dewdrop:Close(1);
				end
			);
            dewdrop:AddLine(
				"text", AL["QuickLook"].." 3",
				"tooltipTitle", AL["QuickLook"].." 3",
				"tooltipText", AL["Assign this loot table\n to QuickLook"].." 3",
				"func", function()
					AtlasLootCharDB["QuickLooks"][3]={AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[4]};
                    AtlasLoot_RefreshQuickLookButtons();
                    dewdrop:Close(1);
				end
			);
            dewdrop:AddLine(
				"text", AL["QuickLook"].." 4",
				"tooltipTitle", AL["QuickLook"].." 4",
				"tooltipText", AL["Assign this loot table\n to QuickLook"].." 4",
				"func", function()
					AtlasLootCharDB["QuickLooks"][4]={AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[4]};
                    AtlasLoot_RefreshQuickLookButtons();
                    dewdrop:Close(1);
				end
			);
		end;
		dewdrop:Open(button,
			'point', function(parent)
				return "BOTTOMLEFT", "BOTTOMRIGHT";
			end,
			"children", setOptions
		);
	end
end

--[[
AtlasLoot_RefreshQuickLookButtons()
Enables/disables the quicklook buttons depending on what is assigned
]]
function AtlasLoot_RefreshQuickLookButtons()
    i=1;
    while i<5 do
        if ((not AtlasLootCharDB["QuickLooks"][i]) or (not AtlasLootCharDB["QuickLooks"][i][1])) or (AtlasLootCharDB["QuickLooks"][i][1]==nil) then
            getglobal("AtlasLootPanel_Preset"..i):Disable();
            getglobal("AtlasLootDefaultFrame_Preset"..i):Disable();
        else
            getglobal("AtlasLootPanel_Preset"..i):Enable();
            getglobal("AtlasLootDefaultFrame_Preset"..i):Enable();
        end
        i=i+1;
    end
end

--[[
AtlasLoot_QueryLootPage()
Querys all valid items on the current loot page.
]]
function AtlasLoot_QueryLootPage()
    i=1;
    while i<31 do
        button = getglobal("AtlasLootItem_"..i);
        queryitem = button.itemID;
        if (queryitem) and (queryitem ~= nil) and (queryitem ~= "") and (queryitem ~= 0) and (string.sub(queryitem, 1, 1) ~= "s") then
            GameTooltip:SetHyperlink("item:"..queryitem..":0:0:0:0:0:0:0");
        end
        i=i+1;
    end
end

