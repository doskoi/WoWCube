
local DefaultConfig = {
	["ASH"] = 0,
	["Atlas"] = 0,
	["AtlasLoot"] = 0,
	["MyInventory"] = 0,
	["PlayerLink"] = 0,
	["SCT"] = 0,
	["DamageEx"] = 0,
	["AutoEquip"] = 0,
	["Gatherer"] = 0,
	["QuestLibrary"] = 0,
	["MonkeyQuest"] = 0,
	["StatsComp"] = 0,
	["KTM"] = 0,
	["DBM"] = 0,
	["Omen"] = 0,
	["CTRaid"] = 0,
	["Decursive"] = 0,
	["DamageMeters"] = 0,
}
--table.insert(AddOnConfig[n], DefaultConfig[v])
function Config_OnEvent()
	if ( event == "VARIABLES_LOADED" ) then
		if ( not AddOnConfig ) then
			AddOnConfig = DefaultConfig;
		end
		local i, j
		for i, j in pairs(DefaultConfig) do
			if ( AddOnConfig[i] == nil ) then
				AddOnConfig[i] = j
			end
		end
		--<========== Registry ==============>
			gLim_RegisterButton (
				TEXT(ADDON_TITLE),
				TEXT(ADDON_DESC),
				"Interface\\Icons\\Inv_Misc_SummerFest_BrazierOrange",
				function()	
					gLimModSecBookShowConfig("gLimConfig");
				end,
				1,
				2
			 );

			gLim_RegisterConfigClass(
				"gLimConfig",
				"LoadOnDemand",
				"Bryan"
			);
		--<========== Registry ==============>

		--<========== UI ==============>
		if ( CheckRevision("Atlas") or CheckRevision("AtlasLoot") or CheckRevision("MyInventory") or  CheckRevision("PlayerLink") --[[or CheckRevision("TipBuddy")]]) then
			gLim_RegisterConfigSection(
				"Config_UI",
				TEXT(UI_SECTION_TITLE),
				TEXT(UI_SECTION_DESC),
				"Bryan",
				"gLimConfig"
			);
		end

		if ( CheckRevision("Atlas") ) then
			gLim_RegisterConfigCheckBox(
				"Atlas",
				TEXT(ATLASP_TITLE),
				TEXT(ATLASP_DESC),
				AddOnConfig.Atlas,
				function( toggle )
					AddOnConfig.Atlas = toggle;
					CheckStatus("Atlas");
				end,
				"gLimConfig"
			);
			CheckStatus("Atlas");
		end
		if ( CheckRevision("AtlasLoot") ) then
			gLim_RegisterConfigCheckBox(
				"AtlasLoot",
				TEXT(ATLASLOOT_TITLE),
				TEXT(ATLASLOOT_DESC),
				AddOnConfig.AtlasLoot,
				function( toggle )
					AddOnConfig.AtlasLoot = toggle;
					CheckStatus("AtlasLoot");
				end,
				"gLimConfig"
			);
			CheckStatus("AtlasLoot");
		end
		if ( CheckRevision("MyInventory") ) then
			gLim_RegisterConfigCheckBox(
				"MyInventory",
				TEXT(ONEBAG_TITLE),
				TEXT(ONEBAG_DESC),
				AddOnConfig.MyInventory,
				function( toggle )
					AddOnConfig.MyInventory = toggle;
					CheckStatus("MyInventory");
				end,
				"gLimConfig"
			);
			CheckStatus("MyInventory");
		end
		if ( CheckRevision("PlayerLink") ) then
			gLim_RegisterConfigCheckBox(
				"PlayerLink",
				TEXT(PLAYERLINK_TITLE),
				TEXT(PLAYERLINK_DESC),
				AddOnConfig.PlayerLink,
				function( toggle )
					AddOnConfig.PlayerLink = toggle;
					CheckStatus("PlayerLink");
				end,
				"gLimConfig"
			);
			CheckStatus("PlayerLink");
		end
		--[[
		if ( CheckRevision("TipBuddy") ) then
			gLim_RegisterConfigCheckBox(
				"TipBuddy",
				TEXT(TIPBUDDY_TITLE),
				TEXT(TIPBUDDY_DESC),
				AddOnConfig.TipBuddy,
				function( toggle )
					AddOnConfig.TipBuddy = toggle;
					CheckStatus("TipBuddy");
				end,
				"gLimConfig"
			);
			CheckStatus("TipBuddy");
		end
		]]
		--<========== UI ==============>

		--<========== Combat ==============>
		if ( CheckRevision("Ash_Core") or CheckRevision("CombatSct") or CheckRevision("DamageEx") or CheckRevision("EN_AutoEquip") ) then
			gLim_RegisterConfigSection(
				"Config_Combat",
				TEXT(COMBAT_TITLE),
				TEXT(COMBAT_DESC),
				"Bryan",
				"gLimConfig"
			);
		end

		if ( CheckRevision("Ash_Core") ) then
			gLim_RegisterConfigCheckBox(
				"ASH",
				TEXT(ASH_TITLE),
				TEXT(ASH_DESC),
				AddOnConfig.ASH,
				function( toggle )
					AddOnConfig.ASH = toggle;
					CheckStatus("ASH", "Ash_Core");
				end,
				"gLimConfig"
			);
			CheckStatus("ASH", "Ash_Core");
		end

		if ( CheckRevision("CombatSct") ) then
			gLim_RegisterConfigCheckBox(
				"SCT",
				TEXT(SCT_TITLE),
				TEXT(SCT_DESC),
				AddOnConfig.SCT,
				function( toggle )
					AddOnConfig.SCT = toggle;
					CheckStatus("SCT", "CombatSct");
				end,
				"gLimConfig"
			);
			CheckStatus("SCT", "CombatSct");
		end

		if ( CheckRevision("DamageEx") ) then
			gLim_RegisterConfigCheckBox(
				"DamageEx",
				TEXT(DAMAGEEX_TITLE),
				TEXT(DAMAGEEX_DESC),
				AddOnConfig.DamageEx,
				function( toggle )
					AddOnConfig.DamageEx = toggle;
					CheckStatus("DamageEx");
				end,
				"gLimConfig"
			);
			CheckStatus("DamageEx");
			if (AddOnConfig.DamageEx == 0) then
				SetCVar("CombatDamage", 1);
			end
		end
		if ( CheckRevision("EN_AutoEquip") ) then
			gLim_RegisterConfigCheckBox(
				"AutoEquip",
				TEXT(AUTOEQUIP_TITLE),
				TEXT(AUTOEQUIP_DESC),
				AddOnConfig.AutoEquip,
				function( toggle )
					AddOnConfig.AutoEquip = toggle;
					CheckStatus("AutoEquip", "EN_AutoEquip");
				end,
				"gLimConfig"
			);
			CheckStatus("AutoEquip", "EN_AutoEquip");
		end
		--<========== Combat ==============>

		--<========== Assist ==============>
		if ( CheckRevision("Gatherer") or ( (GetLocale() == "zhCN" or GetLocale() == "zhTW") and CheckRevision("QuestLibrary")) or (CheckRevision("MonkeyQuest") and CheckRevision("MonkeyLibrary") and CheckRevision("MonkeyBuddy")) ) then
			gLim_RegisterConfigSection(
				"Config_Assist",
				TEXT(ASSIST_TITLE),
				TEXT(ASSIST_DESC),
				"Bryan",
				"gLimConfig"
			);
		end

		if ( CheckRevision("Gatherer") ) then
			gLim_RegisterConfigCheckBox(
				"Gatherer",
				TEXT(GATHERER_TITLE),
				TEXT(GATHERER_DESC),
				AddOnConfig.Gatherer,
				function( toggle )
					AddOnConfig.Gatherer = toggle;
					CheckStatus("Gatherer");
				end,
				"gLimConfig"
			);
			CheckStatus("Gatherer");
		end
		if ( (GetLocale() == "zhCN" or GetLocale() == "zhTW") and CheckRevision("QuestLibrary")) then
			gLim_RegisterConfigCheckBox(
				"QuestLibrary",
				TEXT(QUESTION_TITLE),
				TEXT(QUESTION_DESC),
				AddOnConfig.QuestLibrary,
				function( toggle )
					AddOnConfig.QuestLibrary = toggle;
					CheckStatus("QuestLibrary");
				end,
				"gLimConfig"
			);
			CheckStatus("QuestLibrary");
		end
		if ( (CheckRevision("MonkeyQuest") and CheckRevision("MonkeyLibrary") and CheckRevision("MonkeyBuddy") ) ) then
			gLim_RegisterConfigCheckBox(
				"MonkeyQuest",
				TEXT(MONKEYQ_TITLE),
				TEXT(MONKEYQ_DESC),
				AddOnConfig.MonkeyQuest,
				function( toggle )
					AddOnConfig.MonkeyQuest = toggle;
					CheckStatus("MonkeyQuest", "MonkeyLibrary");
				end,
				"gLimConfig"
			);
			CheckStatus("MonkeyQuest", "MonkeyLibrary");
		end

		--<========== Assist ==============>

		--<========== Raid ==============>
		if ( CheckRevision("KLHThreatMeter") or CheckRevision("Omen") or CheckRevision("DBM-Core") or (GetLocale() == "zhCN" and CheckRevision("CT_RaidAssist")) or CheckRevision("Decursive") or CheckRevision("DamageMeters") ) then
			gLim_RegisterConfigSection(
				"Config_Raid",
				TEXT(RAID_SECTION_TITLE),
				TEXT(RAID_SECTION_DESC),
				"Bryan",
				"gLimConfig"
			);
		end

		if ( CheckRevision("KLHThreatMeter") ) then
			gLim_RegisterConfigCheckBox(
				"KLHThreatMeter",
				TEXT(KTM_TITLE),
				TEXT(KTM_DESC),
				AddOnConfig.KTM,
				function( toggle )
					AddOnConfig.KTM = toggle;
					CheckStatus("KTM", "KLHThreatMeter");
				end,
				"gLimConfig"
			);
			CheckStatus("KTM", "KLHThreatMeter");
		end

		if ( CheckRevision("Omen") ) then
			gLim_RegisterConfigCheckBox(
				"Omen",
				TEXT(OMEN_TITLE),
				TEXT(OMEN_DESC),
				AddOnConfig.Omen,
				function( toggle )
					AddOnConfig.Omen = toggle;
					CheckStatus("Omen");
				end,
				"gLimConfig"
			);
			CheckStatus("Omen");
		end

		if ( CheckRevision("DBM-Core") ) then
			gLim_RegisterConfigCheckBox(
				"DBM-Core",
				TEXT(DBM_TITLE),
				TEXT(DBM_DESC),
				AddOnConfig.DBM,
				function( toggle )
					AddOnConfig.DBM = toggle;
					CheckStatus("DBM", "DBM-Core");
				end,
				"gLimConfig"
			);
			CheckStatus("DBM", "DBM-Core");
		end
		if ( GetLocale() == "zhCN" and CheckRevision("CT_RaidAssist") ) then
			gLim_RegisterConfigCheckBox(
				"CT_RaidAssist",
				TEXT(CTRAID_TITLE),
				TEXT(CTRAID_DESC),
				AddOnConfig.CTRaid,
				function( toggle )
					AddOnConfig.CTRaid = toggle;
					CheckStatus("CTRaid", "CT_RaidAssist");
				end,
				"gLimConfig"
			);
			CheckStatus("CTRaid", "CT_RaidAssist");
		end
		if ( CheckRevision("Decursive") ) then
			gLim_RegisterConfigCheckBox(
				"Decursive",
				TEXT(DECURSIVE_TITLE),
				TEXT(DECURSIVE_DESC),
				AddOnConfig.Decursive,
				function( toggle )
					AddOnConfig.Decursive = toggle;
					CheckStatus("Decursive");
				end,
				"gLimConfig"
			);
			CheckStatus("Decursive");
		end
		if ( CheckRevision("DamageMeters") ) then
			gLim_RegisterConfigCheckBox(
				"DamageMeters",
				TEXT(DM_TITLE),
				TEXT(DM_DESC),
				AddOnConfig.DamageMeters,
				function( toggle )
					AddOnConfig.DamageMeters = toggle;
					CheckStatus("DamageMeters");
				end,
				"gLimConfig"
			);
			CheckStatus("DamageMeters");
		end
		--<========== Raid ==============>
	end
end


local Config = CreateFrame("Frame", nil, UIParent)
Config:SetScript("OnEvent", Config_OnEvent)
Config:RegisterEvent("VARIABLES_LOADED")



