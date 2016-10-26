-- <= == == == == == == == == == == == == =>
-- => 
-- =>   main.lua
-- =>
-- =>   Bryan
-- =>   doskoi.panda@gmail.com
-- =>
-- <= == == == == == == == == == == == == =>

local DefaultVarConfig = {
	["CombatLogRangeParty"] = 50,
	["CombatLogRangePartyPet"] = 50,
	["CombatLogRangeFriendlyPlayers"] = 50,
	["CombatLogRangeFriendlyPlayersPets"] = 50,
	["CombatLogRangeHostilePlayers"] = 50,
	["CombatLogRangeHostilePlayersPets"] = 50,
	["CombatLogRangeCreature"] = 50,
	["CombatDeathLogRange"] = 50
}

function gLim_Register()

	gLim_RegisterButton (
		GLIM_OPTIONS_TITLE,
		GLIM_CONFIG_TOTALTITLE,
		"Interface\\Icons\\Spell_Holy_Absolution",
		function()
			gLimModSecBookShowConfig("gLimSysConfig");
		end,
		1,
		1
	);

	gLim_RegisterConfigClass(
		"gLimSysConfig",
		"doskoi",
		GLIM_BRYAN
	);
	gLim_RegisterConfigSection(
		"gLimSetting",
		GLIM_CONFIG_TOTALTITLE,
		GLIM_CONFIGHEAD,
		GLIM_BRYAN,
		"gLimSysConfig"
	);

	gLim_RegisterConfigCheckBox(
		"gLimShowIcon",
		GLIMUI_SHOWICON_TEXT,
		GLIMUI_SHOWICON_DESC,
		CubeConfig.ShowIcon,
		function( toggle )
			CubeConfig.ShowIcon = toggle;
			checkCubeIcon();
		end,
		"gLimSysConfig"
	);
	checkCubeIcon();
	gLim_RegisterConfigSlider(
		"gLimIconPosition",
		GLIMUI_ICONPOSI_TEXT,
		GLIMUI_ICONPOSI_DESC,
		GLIMUI_ICONPOSI_CAPITON,
		GLIMUI_ICONPOSI_DEGREE,
		1,
		0,
		360,
		CubeConfig.ButtonPosition,
		function( value )
			CubeConfig.ButtonPosition = value
			CubeButton_UpdatePosition();
		end,
		"gLimSysConfig"
	);
	CubeButton_UpdatePosition();
	gLim_RegisterConfigSection(
		"gLimUISetting",
		UIOPTIONS_MENU,
		UIOPTIONS_MENU,
		GLIM_BRYAN,
		"gLimSysConfig"
	);
	gLim_RegisterConfigCheckBox(
		"gLimShowBuff",
		SHOW_BUFF_DURATION_TEXT,
		OPTION_TOOLTIP_SHOW_BUFF_DURATION,
		tonumber(SHOW_BUFF_DURATIONS),
		function( toggle )
			setglobal("SHOW_BUFF_DURATIONS", tostring(toggle))
		end,
		"gLimSysConfig"
	);
	gLim_RegisterConfigCheckBox(
		"gLimAutoCursor",
		LOOT_UNDER_MOUSE_TEXT,
		OPTION_TOOLTIP_LOOT_UNDER_MOUSE,
		tonumber(LOOT_UNDER_MOUSE),
		function( toggle )
			setglobal("LOOT_UNDER_MOUSE",  tostring(toggle))
		end,
		"gLimSysConfig"
	);
	gLim_RegisterConfigCheckBox(
		"gLimQuestFading",
		SHOW_QUEST_FADING_TEXT,
		OPTION_TOOLTIP_SHOW_QUEST_FADING,
		tonumber(QUEST_FADING_DISABLE),
		function( toggle )
			setglobal("QUEST_FADING_DISABLE", tostring(toggle))
		end,
		"gLimSysConfig"
	);
	gLim_RegisterConfigCheckBox(
		"gLimShowTime",
		GLIMUI_SHOWTIME_TEXT,
		GLIMUI_SHOWTIME_DESC,
		CubeConfig.ChatTime,
		function( toggle )
			CubeConfig.ChatTime = toggle
		end,
		"gLimSysConfig"
	);
	gLim_RegisterConfigSection(
		"gLimGameSetting",
		ADVANCED_OPTIONS,
		ADVANCED_OPTIONS_TOOLTIP,
		GLIM_BRYAN,
		"gLimSysConfig"
	);
	--[[
	gLim_RegisterConfigCheckBox(
		"gLimFixBugs",
		GLIMUI_FIXBUG_TEXT,
		GLIMUI_FIXBUG_DESC,
		CubeConfig.FixBug,
		function( toggle )
			CubeConfig.FixBug = toggle;
			checkFix();
		end,
		"gLimSysConfig"
	);
	checkFix()
	]]
	gLim_RegisterConfigButton(
		"gLimAccountName",
		GLIMUI_ACCOUNT_TEXT,
		GLIMUI_ACCOUNT_DESC,
		GLIMUI_ACCOUNT_CAPTION,
		function()
			if ( gLimConfigSubFrame ) then
				gLimConfigSubFrame:Hide();
			end
			StaticPopup_Show ("ACCOUNT_NAME");
		end,
		"gLimSysConfig"
	);
	gLim_RegisterConfigButton(
		"gLimChatlog",
		strsub(SLASH_CHATLOG2, 2),
		CHATLOGENABLED,
		ENABLE,
		function()
			local info = ChatTypeInfo["SYSTEM"];
			if ( LoggingChat() ) then
				LoggingChat(false);
				DEFAULT_CHAT_FRAME:AddMessage(CHATLOGDISABLED, info.r, info.g, info.b, info.id);
				getglobal(this:GetName()):SetText(ENABLE)
			else
				LoggingChat(true);
				DEFAULT_CHAT_FRAME:AddMessage(CHATLOGENABLED, info.r, info.g, info.b, info.id);
				getglobal(this:GetName()):SetText(DISABLE)
			end
		end,
		"gLimSysConfig"
	);
	gLim_RegisterConfigButton(
		"gLimCombatlog",
		COMBAT_LOG,
		COMBATLOGENABLED,
		ENABLE,
		function()
			local info = ChatTypeInfo["SYSTEM"];
			if ( LoggingCombat() ) then
				LoggingCombat(false);
				DEFAULT_CHAT_FRAME:AddMessage(COMBATLOGDISABLED, info.r, info.g, info.b, info.id);
				getglobal(this:GetName()):SetText(ENABLE)
			else
				LoggingCombat(true);
				DEFAULT_CHAT_FRAME:AddMessage(COMBATLOGENABLED, info.r, info.g, info.b, info.id);
				getglobal(this:GetName()):SetText(DISABLE)
			end
		end,
		"gLimSysConfig"
	);
--[[
	gLim_RegisterConfigSlider(
		"gLim_targetNearestDistance",
		GLIMUI_TARGETND_TEXT,
		GLIMUI_TARGETND_DESC,
		GLIMUI_DISTANCE_TEXT,
		GLIMUI_YARD_TEXT,
		1,
		10,
		50,
		GetCVar("targetNearestDistance"),
		function( value )
			SetCVar("targetNearestDistance", value)
		end,
		"gLimSysConfig"
	);
	gLim_RegisterConfigSlider(
		"gLim_targetNearestDistanceRadius",
		GLIMUI_TARGETNDR_TEXT,
		GLIMUI_TARGETNDR_DESC,
		GLIMUI_DISTANCE_TEXT,
		GLIMUI_YARD_TEXT,
		1,
		10,
		50,
		GetCVar("targetNearestDistanceRadius"),
		function( value )
			SetCVar("targetNearestDistanceRadius", value)
		end,
		"gLimSysConfig"
	);
]]
--<==================================>


	if ( not VarConfig) then
		VarConfig = DefaultVarConfig
	end

	RegisterCVar("CombatLogRangeParty");
	RegisterCVar("CombatLogRangePartyPet");
	RegisterCVar("CombatLogRangeFriendlyPlayers");
	RegisterCVar("CombatLogRangeFriendlyPlayersPets");
	RegisterCVar("CombatLogRangeHostilePlayers");
	RegisterCVar("CombatLogRangeHostilePlayersPets");
	RegisterCVar("CombatLogRangeCreature");
	RegisterCVar("CombatDeathLogRange");

	gLim_RegisterConfigSlider(
		"gLim_CombatLogRangeParty",
		COLOR_SKY..GLIMUI_CLRP_TEXT,
		GLIMUI_CLRP_DESC,
		GLIMUI_DISTANCE_TEXT,
		GLIMUI_YARD_TEXT,
		1,
		30,
		200,
		VarConfig.CombatLogRangeParty,
		function( value )
			SetCVar("CombatLogRangeParty", value)
			VarConfig.CombatLogRangeParty = value
		end,
		"gLimSysConfig"
	);
	gLim_RegisterConfigSlider(
		"gLim_CombatLogRangePartyPet",
		COLOR_SKY..GLIMUI_CLRPP_TEXT,
		GLIMUI_CLRPP_DESC,
		GLIMUI_DISTANCE_TEXT,
		GLIMUI_YARD_TEXT,
		1,
		30,
		200,
		VarConfig.CombatLogRangePartyPet,
		function( value )
			SetCVar("CombatLogRangePartyPet", value)
			VarConfig.CombatLogRangePartyPet = value
		end,
		"gLimSysConfig"
	);
	gLim_RegisterConfigSlider(
		"gLim_CombatLogRangeFriendlyPlayers",
		COLOR_SKY..GLIMUI_CLRFP_TEXT,
		GLIMUI_CLRFP_DESC,
		GLIMUI_DISTANCE_TEXT,
		GLIMUI_YARD_TEXT,
		1,
		30,
		200,
		VarConfig.CombatLogRangeFriendlyPlayers,
		function( value )
			SetCVar("CombatLogRangeFriendlyPlayers", value)
			VarConfig.CombatLogRangeFriendlyPlayers = value
		end,
		"gLimSysConfig"
	);
	gLim_RegisterConfigSlider(
		"gLim_CombatLogRangeFriendlyPlayersPets",
		COLOR_SKY..GLIMUI_CLRFPP_TEXT,
		GLIMUI_CLRFPP_DESC,
		GLIMUI_DISTANCE_TEXT,
		GLIMUI_YARD_TEXT,
		1,
		30,
		200,
		VarConfig.CombatLogRangeFriendlyPlayersPets,
		function( value )
			SetCVar("CombatLogRangeFriendlyPlayersPets", value)
			VarConfig.CombatLogRangeFriendlyPlayersPets = value
		end,
		"gLimSysConfig"
	);
	gLim_RegisterConfigSlider(
		"gLim_CombatLogRangeHostilePlayers",
		COLOR_SKY..GLIMUI_CLRHP_TEXT,
		GLIMUI_CLRHP_DESC,
		GLIMUI_DISTANCE_TEXT,
		GLIMUI_YARD_TEXT,
		1,
		30,
		200,
		VarConfig.CombatLogRangeHostilePlayers,
		function( value )
			SetCVar("CombatLogRangeHostilePlayers", value)
			VarConfig.CombatLogRangeHostilePlayers = value
		end,
		"gLimSysConfig"
	);
	gLim_RegisterConfigSlider(
		"gLim_CombatLogRangeHostilePlayersPets",
		COLOR_SKY..GLIMUI_CLRHPP_TEXT,
		GLIMUI_CLRHPP_DESC,
		GLIMUI_DISTANCE_TEXT,
		GLIMUI_YARD_TEXT,
		1,
		30,
		200,
		VarConfig.CombatLogRangeHostilePlayersPets,
		function( value )
			SetCVar("CombatLogRangeHostilePlayersPets", value)
			VarConfig.CombatLogRangeHostilePlayersPets = value
		end,
		"gLimSysConfig"
	);
	gLim_RegisterConfigSlider(
		"gLim_CombatLogRangeCreature",
		COLOR_SKY..GLIMUI_CLRC_TEXT,
		GLIMUI_CLRC_DESC,
		GLIMUI_DISTANCE_TEXT,
		GLIMUI_YARD_TEXT,
		1,
		30,
		200,
		VarConfig.CombatLogRangeCreature,
		function( value )
			SetCVar("CombatLogRangeCreature", value)
			VarConfig.CombatLogRangeCreature = value
		end,
		"gLimSysConfig"
	);
	
	--it works
	gLim_RegisterConfigSlider(
		"gLim_CombatDeathLogRange",
		COLOR_SKY..GLIMUI_CLLR_TEXT,
		GLIMUI_CLLR_DESC,
		GLIMUI_DISTANCE_TEXT,
		GLIMUI_YARD_TEXT,
		1,
		30,
		200,
		VarConfig.CombatDeathLogRange,
		function( value )
			SetCVar("CombatDeathLogRange", value)
			VarConfig.CombatDeathLogRange = value
		end,
		"gLimSysConfig"
	);

	local setCmd = "SET %s \"%d\"";
	local rangeCmds = {
		"CombatLogRangeParty",
		"CombatLogRangePartyPet",
		"CombatLogRangeFriendlyPlayers",
		"CombatLogRangeFriendlyPlayersPets",
		"CombatLogRangeHostilePlayers",
		"CombatLogRangeHostilePlayersPets",
		"CombatLogRangeCreature",
		"CombatDeathLogRange"
	};
	for i, cmd in ipairs(rangeCmds) do
		ConsoleExec(format(setCmd, cmd, VarConfig[cmd]));
	end

--<==================================>

	gLim_RegisterConfigButton(
		"gLimReloadui",
		COLOR_ORANGE..GLIMUI_RELOADUI_TEXT,
		GLIMUI_RELOADUI_DESC,
		GLIMUI_RELOADUI_CAPTION,
		function()
			ReloadUI();
		end,
		"gLimSysConfig"
	);
	
	local GlimmodOptions = CreateFrame("FRAME", "GlimmodOptions")
	GlimmodOptions.name = GLIM_OPTIONS_TITLE;
	InterfaceOptions_AddCategory(GlimmodOptions);
	
	local GlimmodOptionsText1 = GlimmodOptions:CreateFontString(nil, "ARTWORK");
	GlimmodOptionsText1:SetFontObject(GameFontNormalLarge);
	GlimmodOptionsText1:SetJustifyH("LEFT");
	GlimmodOptionsText1:SetJustifyV("TOP");
	GlimmodOptionsText1:ClearAllPoints();
	GlimmodOptionsText1:SetPoint("TOPLEFT", 16, -16);
	GlimmodOptionsText1:SetText(GLIM_OPTIONS_TITLE);
	
	local GlimmodOptionsText2 = GlimmodOptions:CreateFontString(nil, "ARTWORK")
	GlimmodOptionsText2:SetFontObject(GameFontNormalSmall)
	GlimmodOptionsText2:SetJustifyH("LEFT") 
	GlimmodOptionsText2:SetJustifyV("TOP")
	GlimmodOptionsText2:SetTextColor(1, 1, 1)
	GlimmodOptionsText2:ClearAllPoints()
	GlimmodOptionsText2:SetPoint("TOPLEFT", GlimmodOptionsText1, "BOTTOMLEFT", 8, -16)
	GlimmodOptionsText2:SetWidth(340)
	GlimmodOptionsText2:SetText(GLIM_OPTIONS_THANKS)
end

function checkCubeIcon()
	if ( CubeConfig.ShowIcon == 1 ) then
		gLimMinimapFrame:Show();
	else
		gLimMinimapFrame:Hide();
	end
end

