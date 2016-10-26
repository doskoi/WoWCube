-- **************************************************************************
-- * TitanItemBonuses.lua
-- *
-- * By: Titan Development Team 
-- *     (HonorGoG, jaketodd422, joejanko, Lothayer, Tristanian)
-- *
-- * Note: Requires BonusScanner 3.2 or better.
-- **************************************************************************

-- ******************************** Constants *******************************
local TitanItemBonuses = LibStub("AceAddon-3.0"):NewAddon("TitanItemBonuses", "AceHook-3.0")
local TITAN_ITEMBONUSES_ID = "ItemBonuses";
local LB = LibStub("AceLocale-3.0"):GetLocale("BonusScanner", true)
-- ******************************** Variables and table *********************
local TitanItemBonuses_active = nil;
local TITAN_ITEMBONUSES_CATEGORIES = {'ATT', 'BON', 'SBON', 'RES', 'SKILL', 'OBON', 'EBON'};
local _G = getfenv(0);
local TitanItemBonuses_colors = {
	X = 'FFD200',  -- attributes
	Y = '20FF20',  -- skills
	M = '999999',  -- melee
	R = '00C0C0',  -- ranged
	C = 'FFFF00',  -- spells
	A = 'FF60FF',  -- arcane
	I = 'FF3600',  -- fire
	F = '00C0FF',  -- frost
	H = 'FFA400',  -- holy
	N = '00FF60',  -- nature
	S = 'AA12AC',  -- shadow
	L = '20FF20',  -- life
	P = '6060FF',  -- mana
};

local TITAN_ITEMBONUSES_EFFECTS = {
	{ effect = "STR",				name = TITAN_ITEMBONUSES_STR,	 			format = "%d",		short = "XSTR",	cat = "ATT" },
	{ effect = "AGI",				name = TITAN_ITEMBONUSES_AGI, 				format = "%d",		short = "XAGI",	cat = "ATT" },
	{ effect = "STA",				name = TITAN_ITEMBONUSES_STA, 				format = "%d",		short = "XSTA",	cat = "ATT" },
	{ effect = "INT",				name = TITAN_ITEMBONUSES_INT, 				format = "%d",		short = "XINT",	cat = "ATT" },
	{ effect = "SPI",				name = TITAN_ITEMBONUSES_SPI,	 			format = "%d",		short = "XSPI",	cat = "ATT" },
	{ effect = "ARMOR",				name = TITAN_ITEMBONUSES_ARMOR,	 			format = "%d",		short = "XARM",	cat = "ATT" },

	{ effect = "ARCANERES",			name = TITAN_ITEMBONUSES_ARCANERES,			format = "%d",		short = "AR",	cat = "RES" },
	{ effect = "FIRERES",			name = TITAN_ITEMBONUSES_FIRERES, 			format = "%d",		short = "IR",	cat = "RES" },
	{ effect = "NATURERES", 		name = TITAN_ITEMBONUSES_NATURERES, 		format = "%d",		short = "NR",	cat = "RES" },
	{ effect = "FROSTRES",			name = TITAN_ITEMBONUSES_FROSTRES, 			format = "%d",		short = "FR",	cat = "RES" },
	{ effect = "SHADOWRES",			name = TITAN_ITEMBONUSES_SHADOWRES,			format = "%d",		short = "SR",	cat = "RES" },

	{ effect = "DEFENSE",			name = TITAN_ITEMBONUSES_DEFENSE, 			format = "%d",	pformat="%d pt",	short = "YDEF",	cat = "SKILL" },
	{ effect = "EXPERTISE",			name = TITAN_ITEMBONUSES_EXPERTISE, 			format = "%d",	pformat="%d pt",	short = "YEXPR",	cat = "SKILL" },
	{ effect = "FISHING",			name = TITAN_ITEMBONUSES_FISHING,			format = "%d",		short = "YFIS",	cat = "SKILL" },
	{ effect = "HERBALISM",			name = TITAN_ITEMBONUSES_HERBALISM, 		format = "%d",		short = "YHER",	cat = "SKILL" },
	{ effect = "MINING",			name = TITAN_ITEMBONUSES_MINING,			format = "%d",		short = "YMIN",	cat = "SKILL" },
	{ effect = "SKINNING", 			name = TITAN_ITEMBONUSES_SKINNING, 			format = "%d",		short = "YSKI",	cat = "SKILL" },
  
	{ effect = "ATTACKPOWER", 		name = TITAN_ITEMBONUSES_ATTACKPOWER, 		format = "%d",		short = "MAP",	cat = "BON" },
	{ effect = "ATTACKPOWERUNDEAD", 		name = TITAN_ITEMBONUSES_ATTACKPOWERUNDEAD, 		format = "%d",		short = "MAPUD",	cat = "BON" },
	{ effect = "ATTACKPOWERFERAL", 		name = TITAN_ITEMBONUSES_ATTACKPOWERFERAL, 		format = "%d",		short = "MAPFER",	cat = "BON" },
	{ effect = "ARMORPEN",		name = TITAN_ITEMBONUSES_APEN,		format = "%d", pformat="%.2f%%", short = "MAPEN",	cat = "BON" },
	{ effect = "BLOCK",				name = TITAN_ITEMBONUSES_BLOCK, 			format = "%d",	pformat="%.2f%%",	short = "MBLOCK",	cat = "BON" },
  { effect = "BLOCKVALUE",	name = TITAN_ITEMBONUSES_BLOCKVALUE, 			format = "%d",		short = "MBLOCKV",	cat = "BON" },
  { effect = "CRIT",				name = TITAN_ITEMBONUSES_CRIT, 				format = "%d",	pformat="%.2f%%",	short = "MCRIT",	cat = "BON" },
  { effect = "DODGE",				name = TITAN_ITEMBONUSES_DODGE, 			format = "%d", pformat="%.2f%%",		short = "MDODGE",	cat = "BON" },
	{ effect = "HASTE",		name = TITAN_ITEMBONUSES_HASTE,		format = "%d", pformat="%.2f%%",	short = "MHASTE",	cat = "BON" },
	{ effect = "TOHIT", 			name = TITAN_ITEMBONUSES_TOHIT, 			format = "%d",	pformat="%.2f%%",	short = "MHIT",	cat = "BON" },
	{ effect = "PARRY", 			name = TITAN_ITEMBONUSES_PARRY, 			format = "%d", pformat="%.2f%%", short = "MPARRY",	cat = "BON" },
	{ effect = "RANGEDATTACKPOWER", name = TITAN_ITEMBONUSES_RANGEDATTACKPOWER, format = "%d",	short = "RRAP",	cat = "BON" },
	{ effect = "RANGEDHIT",		name = TITAN_ITEMBONUSES_RANGEDHIT,		format = "%d",	pformat="%.2f%%",	short = "RRHIT",	cat = "BON" },
  { effect = "RANGEDCRIT",		name = TITAN_ITEMBONUSES_RANGEDCRIT,		format = "%d",	pformat="%.2f%%",	short = "RRCRIT",	cat = "BON" },
  { effect = "RANGEDDMG",		name = TITAN_ITEMBONUSES_RANGEDDMG,		format = "%d",		short = "RRDMG",	cat = "BON" },
	{ effect = "RESILIENCE",		name = TITAN_ITEMBONUSES_RESILIENCE,		format = "%d",	pformat="%.2f%%",	short = "MRLS",	cat = "BON" },
	{ effect = "DMGWPN",		name = TITAN_ITEMBONUSES_DMGWPN,		format = "%d",		short = "MWPN",	cat = "BON" },
	{ effect = "DPSMAIN",		name = TITAN_ITEMBONUSES_DPSMAIN,		format = "%.1f",		short = "XmDPS",	cat = "BON" },
	{ effect = "DPSRANGED",		name = TITAN_ITEMBONUSES_DPSRANGED,		format = "%.1f",		short = "XrDPS",	cat = "BON" },
	{ effect = "DPSTHROWN",		name = TITAN_ITEMBONUSES_DPSTHROWN,		format = "%.1f",		short = "XtDPS",	cat = "BON" },
	
	
	{ effect = "SPELLPOW",				name = TITAN_ITEMBONUSES_SPELLPOW, 				format = "%d",		short = "CSPOW",	cat = "SBON" },
	{ effect = "DMGUNDEAD",				name = TITAN_ITEMBONUSES_DMGUNDEAD, 				format = "%d",		short = "CDUD",	cat = "SBON" },
  --{ effect = "HOLYCRIT", 			name = TITAN_ITEMBONUSES_HOLYCRIT,			format = "%d", pformat="%.2f%%",	short = "CHC",	cat = "SBON" },	
	{ effect = "SPELLPEN", 		name = TITAN_ITEMBONUSES_SPELLPEN,		format = "%d",		short = "CSPEN",	cat = "SBON" },	
	{ effect = "ARCANEDMG", 		name = TITAN_ITEMBONUSES_ARCANEDMG, 		format = "%d",		short = "AD",	cat = "SBON" },
	{ effect = "FIREDMG", 			name = TITAN_ITEMBONUSES_FIREDMG, 			format = "%d",		short = "ID",	cat = "SBON" },
	{ effect = "FROSTDMG",			name = TITAN_ITEMBONUSES_FROSTDMG, 			format = "%d",		short = "FD",	cat = "SBON" },
	{ effect = "HOLYDMG",			name = TITAN_ITEMBONUSES_HOLYDMG, 			format = "%d",		short = "HD",	cat = "SBON" },
	{ effect = "NATUREDMG",			name = TITAN_ITEMBONUSES_NATUREDMG, 		format = "%d",		short = "ND",	cat = "SBON" },
	{ effect = "SHADOWDMG",			name = TITAN_ITEMBONUSES_SHADOWDMG, 		format = "%d",		short = "SD",	cat = "SBON" },

	{ effect = "HEALTH",			name = TITAN_ITEMBONUSES_HEALTH,			format = "%d",		short = "LP",	cat = "OBON" },
	{ effect = "HEALTHREG",			name = TITAN_ITEMBONUSES_HEALTHREG,			format = "%d HP/5s",short = "LR",	cat = "OBON" },
	{ effect = "MANA",				name = TITAN_ITEMBONUSES_MANA, 				format = "%d",		short = "PP",	cat = "OBON" },
	{ effect = "MANAREG",			name = TITAN_ITEMBONUSES_MANAREG, 			format = "%d MP/5s",short = "PR",	cat = "OBON" },
	
	{ effect = "THREATREDUCTION",	name = TITAN_ITEMBONUSES_THREATR, format = "%d", short = "Y%THREATR", cat = "EBON" },
	{ effect = "THREATINCREASE",	name = TITAN_ITEMBONUSES_THREATI, format = "%d", short = "Y%THREATI", cat = "EBON" },
	{ effect = "INCRCRITDMG",	 name = TITAN_ITEMBONUSES_INCCRIT, format = "%d", short = "C%INCCRIT", cat = "EBON" },
	{ effect = "SPELLREFLECT", name = TITAN_ITEMBONUSES_SPELLREFL, format = "%d", short = "C%SPELLREFL", cat = "EBON" },
	{ effect = "SNARERESIST",	name = TITAN_ITEMBONUSES_SNARERES, format = "%d", short = "Y%SNARERES", cat = "EBON" },
	{ effect = "STUNRESIST",	name = TITAN_ITEMBONUSES_STUNRES, format = "%d", short = "Y%STUNRES", cat = "EBON" },
	{ effect = "PERCINT",	name = TITAN_ITEMBONUSES_PERCINT, format = "%d", short = "X%INT", cat = "EBON" },
	{ effect = "PERCBLOCKVALUE",	name = TITAN_ITEMBONUSES_PERCBLOCK, format = "%d", short = "X%BLOCK", cat = "EBON" },	
	{ effect = "PERCARMOR",	name = TITAN_ITEMBONUSES_PERCARMOR, format = "%d", short = "X%INCARMOR", cat = "EBON" },
	{ effect = "PERCMANA",	name = TITAN_ITEMBONUSES_PERCMANA, format = "%d", short = "P%MANA", cat = "EBON" },
	{ effect = "PERCREDSPELLDMG",	name = TITAN_ITEMBONUSES_PERCREDSPELLDMG, format = "%d", short = "C%SDMGTAKEN", cat = "EBON" },
	{ effect = "PERCSNARE",	name = TITAN_ITEMBONUSES_PERCSNARE, format = "%d", short = "Y%SNAREDUR", cat = "EBON" },
	{ effect = "PERCSILENCE",	name = TITAN_ITEMBONUSES_PERCSILENCE, format = "%d", short = "C%SILENCEDUR", cat = "EBON" },
	{ effect = "PERCFEAR",	name = TITAN_ITEMBONUSES_PERCFEAR, format = "%d", short = "C%FEARDUR", cat = "EBON" },
	{ effect = "PERCSTUN",	name = TITAN_ITEMBONUSES_PERCSTUN, format = "%d", short = "Y%STUNDUR", cat = "EBON" },
	{ effect = "PERCCRITHEALING",	name = TITAN_ITEMBONUSES_PERCCRITHEALING, format = "%d", short = "C%INCCRITHEAL", cat = "EBON" },
};

-- ******************************** Functions *******************************

-- **************************************************************************
-- NAME : TitanPanelItemBonusesButton_OnLoad()
-- DESC : Registers the plugin upon it loading
-- **************************************************************************
function TitanPanelItemBonusesButton_OnLoad(self)
     self.registry = {
          id = TITAN_ITEMBONUSES_ID,
          builtIn = 1,
          version = TITAN_VERSION,
          menuText = TITAN_ITEMBONUSES_TEXT,
          buttonTextFunction = "TitanPanelItemBonusesButton_GetButtonText",
          tooltipTitle = TITAN_ITEMBONUSES_TEXT,
          tooltipTextFunction = "TitanPanelItemBonusesButton_GetTooltipText",
          icon = "Interface\\Icons\\Spell_Nature_EnchantArmor.blp";
          iconWidth = 16,
          savedVariables = {
               ShowLabelText = 1,
               ShowColoredText = false,
               ShowIcon = 1,
               ShowPoints = false,
               ShowGems = false,
               ShowAverageiLvl = false,
               shortdisplay = false,
               displaybonuses = {},
          }
     };

     self:RegisterEvent("PLAYER_ENTERING_WORLD");
end

-- **************************************************************************
-- NAME : TitanPanelItemBonusesButton_OnEvent() 
-- DESC : Parse events registered to plugin and act on them
-- **************************************************************************
function TitanPanelItemBonusesButton_OnEvent(self, event, ...) 
     if (event == "PLAYER_ENTERING_WORLD") then
          TitanItemBonuses_active = 1;          
     end
end

-- **************************************************************************
-- NAME : TitanPanelItemBonusesButton_FormatShortText(short,val)
-- DESC : Condense text into shortened format
-- VARS : short = <research>, val = <research>
-- **************************************************************************
function TitanPanelItemBonusesButton_FormatShortText(short,val)
     local color = 'FFFFFF';
     local text = string.sub(short,2);
     local colorcode = string.sub(short,1,1);
     if(TitanItemBonuses_colors[colorcode]) then
          color = TitanItemBonuses_colors[colorcode];
     end;
     if(val) then
          return '|cff'.. color .. val .. FONT_COLOR_CODE_CLOSE
     else 
          return '|cff'.. color .. text .. FONT_COLOR_CODE_CLOSE
     end;
end


-- **************************************************************************
-- NAME : TitanPanelItemBonusesButton_GetButtonText(id)
-- DESC : Calculate bonuses logic then display data on button
-- VARS : id = button ID
-- **************************************************************************
function TitanPanelItemBonusesButton_GetButtonText(id)
			
		 local level, val;
     local title = TITAN_ITEMBONUSES_TEXT;
     local text = "";
     local disp = TitanGetVar(TITAN_ITEMBONUSES_ID, "displaybonuses");
     -- preventing getting inaccessible due to no display at all
     if   (not disp or (table.getn(disp) == 0 ) 
          and not TitanGetVar(TITAN_ITEMBONUSES_ID, "ShowLabelText")
          and not TitanGetVar(TITAN_ITEMBONUSES_ID, "ShowIcon")) then
          TitanSetVar(TITAN_ITEMBONUSES_ID, "ShowLabelText", 1);
          TitanPanelButton_UpdateButton(TITAN_ITEMBONUSES_ID);
     end;
          
     local i,d,e;
     local liste = {};
     for i,d in pairs(disp) do
          e = TITAN_ITEMBONUSES_EFFECTS[d];
          if(TitanGetVar(TITAN_ITEMBONUSES_ID, "shortdisplay")) then
               title = TitanPanelItemBonusesButton_FormatShortText(e.short).." ";
          else
               title = LB["BONUSSCANNER_NAMES"][e.effect]..": ";
          end
          if(BonusScanner.bonuses[e.effect]) then
               if (TitanGetVar(TITAN_ITEMBONUSES_ID, "ShowPoints")) then
               			level = UnitLevel("player");
                    local temp = BonusScanner:GetRatingBonus(e.effect, BonusScanner.bonuses[e.effect],level)
                     if temp~= nil then
                     		val = temp
                     else
                    		val = BonusScanner.bonuses[e.effect];
                     end
               else
               	val = BonusScanner.bonuses[e.effect];
               end     
          else
               val = 0;
          end
               if(TitanGetVar(TITAN_ITEMBONUSES_ID, "ShowPoints")) and (e.pformat) then
               text = format(e.pformat,val);
               			-- account for spell hit
                    	if e.effect == "TOHIT" and BonusScanner.bonuses[e.effect] then
                    	local level = UnitLevel("player");
                    	local temp, _ = BonusScanner:ProcessSpecialBonus (e.effect, BonusScanner.bonuses[e.effect], level);
                    	text = temp;
                    	end
               else
             text = format(e.format,val);
             end
          if(TitanGetVar(TITAN_ITEMBONUSES_ID, "ShowColoredText")) then
               text = TitanPanelItemBonusesButton_FormatShortText(e.short,text);
          end;
          table.insert(liste,title);
          table.insert(liste,TitanUtils_GetHighlightText(text));
     end;
     if(table.getn(liste) == 0) then
          return TITAN_ITEMBONUSES_TEXT,"";
     end
     return unpack(liste);
end

-- **************************************************************************
-- NAME : TitanPanelItemBonusesButton_isdisp(val)
-- DESC : <research>
-- VARS : val = <research>
-- **************************************************************************
function TitanPanelItemBonusesButton_isdisp(val)
     local disp = TitanGetVar(TITAN_ITEMBONUSES_ID, "displaybonuses");
     local i,d;
     for i,d in pairs(disp) do
          if(d==val) then
               return 1;
          end
     end
     return nil;
end

-- **************************************************************************
-- NAME : TitanPanelItemBonusesButton_hasdisp()
-- DESC : <research>
-- **************************************************************************
function TitanPanelItemBonusesButton_hasdisp()
     local disp = TitanGetVar(TITAN_ITEMBONUSES_ID, "displaybonuses");
     if(not disp) then
          return nil;
     end
     return table.getn(disp) > 0;
end


-- **************************************************************************
-- NAME : TitanPanelItemBonusesButton_GetTooltipText()
-- DESC : Display tooltip text
-- **************************************************************************
function TitanPanelItemBonusesButton_GetTooltipText()
     
     local retstr,cat,val = "","","","";
     local i,e, level, points;

     for i,e in pairs(TITAN_ITEMBONUSES_EFFECTS) do

          if(BonusScanner.bonuses[e.effect]) then
               if(e.format) then
                    if (TitanGetVar(TITAN_ITEMBONUSES_ID, "ShowPoints")) and (e.pformat) then
                          level = UnitLevel("player");
                                val, points = BonusScanner:ProcessSpecialBonus (e.effect, BonusScanner.bonuses[e.effect], level);
                                if val=="" then
                       						val = format(e.pformat,points);
                         				end
                    else
                       val = format(e.format,BonusScanner.bonuses[e.effect]);
                  	end     
               else
                    val = BonusScanner.bonuses[e.effect];
               end;
               if(e.cat ~= cat) then
                    cat = e.cat;
                    if(retstr ~= "") then
                      retstr = retstr .. "\n"
                    end
                    retstr = retstr .. "\n" .. TitanUtils_GetGreenText(_G['TITAN_ITEMBONUSES_CAT_'..cat]..":");
               end
               retstr = retstr.. "\n".. LB["BONUSSCANNER_NAMES"][e.effect]..":\t".. TitanUtils_GetHighlightText(val);
          end
     end
     
     if TitanGetVar(TITAN_ITEMBONUSES_ID, "ShowGems") and GetAddOnMetadata("BonusScanner", "Version") >= "3.2" then                          
           if BonusScanner.GemsRed~=0 or BonusScanner.GemsYellow~=0 or BonusScanner.GemsBlue~=0 then
           							 retstr = retstr .. "\n";
                         retstr = retstr .. "\n"..GREEN_FONT_COLOR_CODE..LB["BONUSSCANNER_TOOLTIPGEMS_STRING"]..":";
                     end
                     if BonusScanner.GemsRed~=0 then
                         retstr = retstr .. "\n"..LB["BONUSSCANNER_GEMCOUNT_LABEL"]..RED_FONT_COLOR_CODE..LB["BONUSSCANNER_GEMRED_LABEL"].."|cffffd200"..":\t"..HIGHLIGHT_FONT_COLOR_CODE..BonusScanner.GemsRed;
                     end
                     if BonusScanner.GemsYellow~=0 then
                         retstr = retstr .. "\n"..LB["BONUSSCANNER_GEMCOUNT_LABEL"]..LIGHTYELLOW_FONT_COLOR_CODE..LB["BONUSSCANNER_GEMYELLOW_LABEL"].."|cffffd200"..":\t"..HIGHLIGHT_FONT_COLOR_CODE..BonusScanner.GemsYellow;
                     end
                    if BonusScanner.GemsBlue~=0 then
                         retstr = retstr .. "\n"..LB["BONUSSCANNER_GEMCOUNT_LABEL"].."|cff2459ff"..LB["BONUSSCANNER_GEMBLUE_LABEL"].."|cffffd200"..":\t"..HIGHLIGHT_FONT_COLOR_CODE..BonusScanner.GemsBlue;
                     end
     
     end
     
     if TitanGetVar(TITAN_ITEMBONUSES_ID, "ShowAverageiLvl") and GetAddOnMetadata("BonusScanner", "Version") >= "4.5" then
			retstr = retstr.."\n\n"..HIGHLIGHT_FONT_COLOR_CODE..LB["BONUSSCANNER_AVERAGE_ILVL_LABEL"]..":\t|r"..LIGHTYELLOW_FONT_COLOR_CODE..BonusScanner.AverageiLvl.."|r"
		 end
		
     return retstr;
end

-- **************************************************************************
-- NAME : TitanPanelItemBonuses_Update()
-- DESC : Update button data
-- **************************************************************************
function TitanPanelItemBonuses_Update()
     if(TitanItemBonuses_active) then     			     			
          TitanPanelPluginHandle_OnUpdate({TITAN_ITEMBONUSES_ID, TITAN_PANEL_UPDATE_ALL})
     end
     --return TitanItemBonuses.hooks.BonusScanner_Update();
end

--TitanItemBonuses:RawHook("BonusScanner_Update", TitanPanelItemBonuses_Update)
TitanItemBonuses:SecureHook("BonusScanner_Update", TitanPanelItemBonuses_Update)
-- **************************************************************************
-- NAME : TitanPanelRightClickMenu_PrepareItemBonusesMenu()
-- DESC : Display rightclick menu options
-- **************************************************************************
function TitanPanelRightClickMenu_PrepareItemBonusesMenu()
     local id = "ItemBonuses";
     local info = {};
     local i,cat,disp,val,level;

     if UIDROPDOWNMENU_MENU_LEVEL == 2 then
          for i,e in pairs(TITAN_ITEMBONUSES_EFFECTS) do
               if(e.cat == UIDROPDOWNMENU_MENU_VALUE) then
                    info = {};
                    info.text = '[' .. TitanPanelItemBonusesButton_FormatShortText(e.short) .. '] ' .. LB["BONUSSCANNER_NAMES"][e.effect];
                    if(BonusScanner.bonuses[e.effect]) then
                              
                              if(e.format) then
                    if (TitanGetVar(TITAN_ITEMBONUSES_ID, "ShowPoints")) and (e.pformat) then
                          			level = UnitLevel("player");
                                val = BonusScanner:GetRatingBonus (e.effect, BonusScanner.bonuses[e.effect], level);
                                if e.effect ~= "TOHIT" then
                                info.text = info.text .. " (".. format(e.pformat,val).. ")"; 
                                end
                                -- account for spell hit
                    						if e.effect == "TOHIT" then                    						
                    						local temp, _ = BonusScanner:ProcessSpecialBonus (e.effect, BonusScanner.bonuses[e.effect], level);
                    						info.text = info.text ..temp;
                    						end
                                                               
                       else
                       val = BonusScanner.bonuses[e.effect];
                       info.text = info.text .. " (".. format(e.format,val).. ")";
                  end     
               else
                    val = BonusScanner.bonuses[e.effect];
                    info.text = info.text .. " (".. format(e.format,val).. ")";
               end;                                                      
                       end
                    info.value = i;
                    info.func = function() TitanPanelItemBonuses_SetDisplay(i) end
                    info.checked = TitanPanelItemBonusesButton_isdisp(i);
                    info.keepShownOnClick = 1;
                    UIDropDownMenu_AddButton(info,UIDROPDOWNMENU_MENU_LEVEL);
               end
          end
     else
               
               TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_ITEMBONUSES_ID].menuText);
               TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL);
     
               info = {};
               info.text = TITAN_ITEMBONUSES_DISPLAY_NONE;
               info.value = 0;
               info.func = function() TitanPanelItemBonuses_SetDisplay(0) end
               disp = TitanGetVar(TITAN_ITEMBONUSES_ID, "displaybonuses");
               info.checked = not TitanPanelItemBonusesButton_hasdisp();
               UIDropDownMenu_AddButton(info);
               
               TitanPanelRightClickMenu_AddToggleVar(TITAN_ITEMBONUSES_AVERAGE_ILVL, TITAN_ITEMBONUSES_ID,'ShowAverageiLvl');
               TitanPanelRightClickMenu_AddToggleVar(TITAN_ITEMBONUSES_RATING_CONVERSION, TITAN_ITEMBONUSES_ID,'ShowPoints');
               TitanPanelRightClickMenu_AddToggleVar(TITAN_ITEMBONUSES_SHOWGEMS, TITAN_ITEMBONUSES_ID,'ShowGems');               
               
               for i,cat in pairs(TITAN_ITEMBONUSES_CATEGORIES) do
                    info = {};
                    info.text = _G['TITAN_ITEMBONUSES_CAT_'..cat];
                    info.hasArrow = 1;
                    info.value = cat;
                    UIDropDownMenu_AddButton(info);
               end;
     
               TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL);
     
               TitanPanelRightClickMenu_AddToggleIcon(TITAN_ITEMBONUSES_ID);
               TitanPanelRightClickMenu_AddToggleVar(TITAN_ITEMBONUSES_SHORTDISPLAY, TITAN_ITEMBONUSES_ID,'shortdisplay');
               TitanPanelRightClickMenu_AddToggleLabelText(TITAN_ITEMBONUSES_ID);
               TitanPanelRightClickMenu_AddToggleColoredText(TITAN_ITEMBONUSES_ID);
               TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, id, TITAN_PANEL_MENU_FUNC_HIDE);                         
     end
end

-- **************************************************************************
-- NAME : TitanPanelItemBonuses_SetDisplay()
-- DESC : <research>
-- **************************************************************************
function TitanPanelItemBonuses_SetDisplay(value)
     local db = TitanGetVar(TITAN_ITEMBONUSES_ID, "displaybonuses");
     local i,d,found;
     if(value == 0) then
          TitanSetVar(TITAN_ITEMBONUSES_ID, "displaybonuses", {});
     else
          found = 0;
          for i,d in pairs(db) do
               if(d == value)then
                    found = i;
               end
          end
          if(found > 0) then
               table.remove(db,found)
          else
               while(table.getn(db)>3) do
                    table.remove(db);
               end;
               table.insert(db, value);
          end
          TitanSetVar(TITAN_ITEMBONUSES_ID, "displaybonuses", db);
     end;
     TitanPanelButton_UpdateButton(TITAN_ITEMBONUSES_ID);
end
