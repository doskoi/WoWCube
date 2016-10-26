--
--	Create by iWOW (http://wow.365wave.com)
--      Modify by Alfred (http://wowbox.tw/)
--

----------------------------------------------------------------------------------------------------
-- Local QuestLibrary Variables
----------------------------------------------------------------------------------------------------
local HC_QuestLibrary_Initing = false;
local QuestLibrary_QuestData = nil;
local SortedTable = nil;
local sizeSortedTable = nil;
local QuestLibrary_Inited = false;
local MapNotesFound = nil;

----------------------------------------------------------------------------------------------------
-- Global QuestLibrary Variables
----------------------------------------------------------------------------------------------------

QUESTLIBRARY_VERSION = "1.9.26";


----------------------------------------------------------------------------------------------------
-- SetHook Functions
----------------------------------------------------------------------------------------------------

local function SetHook(myFunction, HookFunc, hookType)
	if ( not hookType or ( hookType ~= "after" and hookType ~= "replace" ) ) then
		hookType = "replace";
	end
	
	local oldFunction = getglobal(HookFunc);
	local newFunction = nil;
	if ( hookType == "replace" ) then
		newFunction = 
				function(e)
					local ret = myFunction(e);
					if ( ret == true ) then
						oldFunction(e);
					end
				end
	elseif (hookType == "after" ) then
		newFunction = 
				function(e)
					oldFunction(e);
					myFunction(e);
				end
	end
	setglobal(HookFunc, newFunction);
end

----------------------------------------------------------------------------------------------------
-- On_Foo Functions
----------------------------------------------------------------------------------------------------

function QuestLibrary_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
--	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	SetHook(QuestLibrary_QL_Detail_Update,"QuestLog_UpdateQuestDetails","after");
	SetHook(QuestLibrary_QL_Update,"QuestLog_Update","after");

	-- Set up slash commands
	SLASH_QuestLibrary1 = "/qlib";
	SLASH_QuestLibrary2 = "/questlibrary";
	SlashCmdList["QuestLibrary"] = QuestLibrary_SlashCmd; 
end


----------------------------------------------------------------------------------------------------
-- Internal Functions
----------------------------------------------------------------------------------------------------

function getn(db)
	local counts = 0;
	if ( not db ) then
		return 0;
	end
	for i in pairs(db) do
		counts = counts + 1;
	end
	return counts;
end

function HC_PrintLogString( msg )
	if( DEFAULT_CHAT_FRAME and msg) then
		DEFAULT_CHAT_FRAME:AddMessage( msg, 1.0, 1.0, 1.0 );
	end
end

function QuestLibrary_OnEvent()
	if( event == "VARIABLES_LOADED" ) then
		if (MapNotes_Options) then -- Set to either MapNotes or MetaMapNotes
			MapNotesFound = "MapNotes";
			--HC_PrintLogString("QuestLibrary - Using "..MapNotesFound);
			QuestLibraryMN_Data_Notes = MapNotes_Data_Notes;
			QuestLibraryMN_MinDiff = MapNotes_MinDiff;
			QuestLibraryMN_DeleteNote = MapNotes_DeleteNote;
		elseif (0) then -- MetaMapNotes_Options
			MapNotesFound = "MetaMap";
			--HC_PrintLogString("QuestLibrary - Using "..MapNotesFound);
			QuestLibraryMN_Data_Notes = MetaMapNotes_Data;
			QuestLibraryMN_MinDiff = MetaMapNotes_MinDiff;
			QuestLibraryMN_DeleteNote = MetaMapNotes_DeleteNote;
		end
		
		if ( QuestLibraryMN_Data_Notes ) then
			QuestLibraryWorldMapDeleteButton:Show();
		end

		if (not QuestLibraryOptions) then 
			QuestLibraryOptions = {}; 
		end
		if (not QuestLibraryOptions.RemoveQuestAcceptLevelHigher) then 
			QuestLibraryOptions.RemoveQuestAcceptLevelHigher = -1;
		end
		QuestLibraryOptions.RemoveQuestAcceptLevelHigher = -1;
		if (not QuestLibraryOptions.RemoveQuestLevelBelow) then 
			QuestLibraryOptions.RemoveQuestLevelBelow = -1;
		end
		QuestLibraryOptions.RemoveQuestLevelBelow = -1;
		if (not QuestLibraryOptions.RemoveUnusedNPC) then 
			QuestLibraryOptions.RemoveUnusedNPC = true;
		end
		if (not QuestLibraryOptions.RemoveOpponentFaction) then 
			QuestLibraryOptions.RemoveOpponentFaction = false;
		end
	
	elseif (event == "UNIT_NAME_UPDATE" and arg1 == "player") or (event == "PLAYER_ENTERING_WORLD") then
		local playerName = UnitName("player");

		if ( not HC_QuestLibrary_Initing and not QuestLibrary_Inited and playerName ~= UKNOWNBEING and playerName ~= UNKNOWNOBJECT) then
			HC_QuestLibrary_Initing = true;

			QuestLibrary_RemoveOpponentFaction(false);
			QuestLibrary_RemoveUnusedNPC(false);

			if(UberQuest) then
				HC_PrintLogString("UberQuest found! Hook it");
				SetHook(QuestLibrary_UberQuest_Detail_Update,"UberQuest_TitleButton_OnClick","after");
				--SetHook(QuestLibrary_QL_Update,"UberQuest_List_Update","after");
			end

			if(EQL3_QuestLogFrame) then
				HC_PrintLogString("EQL3 found! Hook it");
				SetHook(QuestLibrary_EQL3_Detail_Update,"QuestLogTitleButton_OnClick","after");
			end

			QuestLibrary_Inited = true;
		end
		if QuestLibrary_Inited then
			this:UnregisterEvent("PLAYER_ENTERING_WORLD");
		end
	end
end


function QuestLibrary_SlashCmd(msg)
	if (msg) then
		local cmd = gsub(msg, "%s*([^%s]+).*", "%1");
		local info ="|cff00ffffQuestLibrary "..QUESTLIBRARY_VERSION..": |r|cffffffff";
		if( cmd == "Information" or cmd == "info" ) then
			HC_PrintLogString(info);
			if ( MapNotesFound ) then
				HC_PrintLogString("  MapNotes: "..MapNotesFound);
			else
				HC_PrintLogString("  MapNotes: Not Found");
			end
			HC_PrintLogString("  BaseQuestDB size: "..getn(BaseQuestDB));
			HC_PrintLogString("  BaseNpcDB size: "..getn(BaseNpcDB));
			return;
		end
		HC_PrintLogString(info.."Usage: /questlibrary [command] OR /qlib [command]");
		HC_PrintLogString("|cffffffff/qlib info  - Information");
	end
end

----------------------------------------------------------------------------------------------------
-- Reduce Database Functions
----------------------------------------------------------------------------------------------------

function QuestLibrary_ToggleBoolean ( bool, msg)
	if( bool == false ) then
		HC_PrintLogString("QuestLibrary: "..msg.." On");
		bool = true;
	else
		HC_PrintLogString("QuestLibrary: "..msg.." Off");
		bool = false;
	end
	return bool;
end

function QuestLibrary_RemoveOpponentFaction( toggle )
	if ( toggle == true ) then
		QuestLibraryOptions.RemoveOpponentFaction=QuestLibrary_ToggleBoolean(QuestLibraryOptions.RemoveOpponentFaction, "RemoveOpponentFaction");
	end
	if ( QuestLibraryOptions.RemoveOpponentFaction or QuestLibraryOptions.RemoveQuestAcceptLevelHigher > 0 or QuestLibraryOptions.RemoveQuestLevelBelow > 0 ) then
		--HC_PrintLogString("QuestLibrary - Removing Opponent Faction Quests");
		local pf=1,qf;
		if (UnitFactionGroup("player")=="Horde") then
			pf=2;
		end
		for index,q in pairs(BaseQuestDB) do
			_,_,qf = string.find(BaseQuestDB[index].q,"%d*`%d*`(%d*)");
			qf = tonumber(qf);
			if (qf==pf and QuestLibraryOptions.RemoveOpponentFaction == true ) then
				BaseQuestDB[index] = nil;
			else
				local _,_,qla,ql,qf = string.find(BaseQuestDB[index].q,"(%d*)`(%d*)`(%d*)");
				local level=UnitLevel("player");
				qla = tonumber(qla);
				ql = tonumber(ql);
				if ( QuestLibraryOptions.RemoveQuestAcceptLevelHigher > 0 and qla > QuestLibraryOptions.RemoveQuestAcceptLevelHigher+level ) then
					BaseQuestDB[index] = nil;
				else
					if ( QuestLibraryOptions.RemoveQuestLevelBelow > 0 and ql < level-QuestLibraryOptions.RemoveQuestLevelBelow ) then
						BaseQuestDB[index] = nil;
					end
				end
			end
		end
		HC_PrintLogString("QuestLibrary - BaseQuestDB size "..getn(BaseQuestDB));
	end
end

function QuestLibrary_RemoveUnusedNPC( toggle )
	if ( toggle == true ) then
		QuestLibraryOptions.RemoveUnusedNPC=QuestLibrary_ToggleBoolean(QuestLibraryOptions.RemoveUnusedNPC, "RemoveUnusedNPC");
	end
	if ( QuestLibraryOptions.RemoveUnusedNPC == true ) then
		--HC_PrintLogString("QuestLibrary - Cleaning NPC database");
		for i,q in pairs(BaseQuestDB) do
			if ( q.os ~= nil ) then
				for j,o in pairs(q.os) do
					if ( o ~= nil ) then
						for npccode in string.gmatch(o,"(%d+)") do
							npccode = tonumber(npccode);
							if ( BaseNpcDB[npccode] ~= nil ) then
								BaseNpcDB[npccode]["f"] = true;
							end
						end
					end
				end
			end
			if ( q.pc ~= nil ) then
				npccode = tonumber(q.pc);
				if ( BaseNpcDB[npccode] ~= nil ) then
					BaseNpcDB[npccode]["f"] = true;
				end
			end
		end
		for j,o in pairs(BaseNpcDB) do
			if ( o.f == nil or o.f ~= true ) then
				BaseNpcDB[j] = nil;
			else
				o["f"] = nil;
			end
		end
--		HC_PrintLogString("QuestLibrary - BaseNpcDB size "..getn(BaseNpcDB));
	end
end


local function QuestLibrary_DoNothing()
end

local function QuestLibrary_GetQuestByIndex(index, title)
	local questData = nil;

	if ( not index ) then
		index = 1;
	end

	index = tonumber(index);
	if ( not BaseQuestDB[index] ) then
		return questData;
	end

	local _,_,qla,ql,qf = string.find(BaseQuestDB[index].q,"(%d*)`(%d*)`(%d*)");
	qla = tonumber(qla);
	ql = tonumber(ql);
	qf = tonumber(qf);
	questData = {};
	questData.la = qla;
	questData.l = ql;

	questData.t = title;
	if (BaseQuestDB[index].pc) then
		questData.pc = {};
		npccode = tonumber(BaseQuestDB[index].pc);
		questData.w = BaseNpcNameDB[npccode];
		if (BaseNpcDB[npccode]) then
			local _,_,cz,x,y = string.find(BaseNpcDB[npccode].x[1],"(%d+)`(%d+),(%d+)");
			cz,x,y = tonumber(cz),tonumber(x),tonumber(y);
			questData.cz = BaseAreaDB[cz];
			local haspos=false;
			local insertpos=table.getn(questData.pc)+1;
			for k,v in pairs(questData.pc) do
				if (v.x==x and v.y==y) then
					haspos = true;
					break;
				elseif (v.x>x or (v.x==x and v.y>y)) then
					insertpos = k;
					break;
				end
			end
			if (not haspos) then
				table.insert(questData.pc,insertpos,{x=x,y=y});
			end
		end
	end
	
	if (BaseQuestDB[index].os) then
		questData.os = {};
		for j,o in pairs(BaseQuestDB[index].os) do
			local osd = {};
			local qlstring = getglobal("QuestLogObjective"..j);
			if (qlstring:IsVisible()) then
				osd.t = qlstring:GetText();
			end
			if (o) then
				osd.npc = {};
				for npccode in string.gmatch(o,"(%d+)") do
					npccode = tonumber(npccode);
					if (BaseNpcDB[npccode]) then
						local _,_,c,ll,lm = string.find(BaseNpcDB[npccode].n,"(%d*)`(%d*)`(%d*)");
						ll,lm = tonumber(ll),tonumber(lm);
						n = BaseNpcNameDB[npccode];
						for xi in pairs(BaseNpcDB[npccode].x) do
							local _,_,a,pos = string.find(BaseNpcDB[npccode].x[xi],"([^`]*)`(.*)");
							a = BaseAreaDB[tonumber(a)];
							if (not osd.npc[a]) then
								osd.npc[a] = {};
							end
							local npcindex=nil;
							for k,v in pairs(osd.npc[a]) do
								if (v.n==n and v.c==c) then
									npcindex=k;
									break;
								end
							end
							if (not npcindex) then
								table.insert(osd.npc[a],{n=n,c=c});
								npcindex = table.getn(osd.npc[a]);
							else
								npcindex = nil;
							end
							if (npcindex) then
								osd.npc[a][npcindex].ll = ll;
								osd.npc[a][npcindex].lm = lm;
								if (not osd.npc[a][npcindex].pos) then
									osd.npc[a][npcindex].pos = {};
								end
								for x,y in string.gmatch(pos,"(%d+),(%d+)") do
									x,y = tonumber(x),tonumber(y);
									table.insert(osd.npc[a][npcindex].pos,{x=x,y=y});
								end
							end
						end
					end
				end
				for area,npclist in pairs(osd.npc) do
					table.sort(osd.npc[area],function(n1,n2) return (n1.ll or -1)<(n2.ll or -1) or (n1.ll==n2.ll and (n1.lm or -1)<(n2.lm or -1)); end);
				end
			end
			table.insert(questData.os,osd);
		end
	end
	return questData;
end

local function QuestLibrary_GetQuest(questID, questTitle)
	return QuestLibrary_GetQuestByIndex(questID, questTitle);
end

----------------------------------------------------------------------------------------------------
-- MapNotes Hooked Functions
----------------------------------------------------------------------------------------------------

local function QuestLibrary_GetMapKey()
	local map = GetMapInfo();

	if ( not map ) then
		if ( GetCurrentMapContinent() == WORLDMAP_COSMIC_ID ) then
			map = "Cosmic";
		else
			map = "WorldMap";
		end
	end

	map = "WM "..map;
	return map;
end

local function QuestLibrary_MapNotes_GetZoneID(zone)
    local continentNames, i, val = { GetMapContinents() };

    for i,val in pairs(continentNames) do
        local zoneNames = { GetMapZones(i) };

        for j in pairs(zoneNames) do
            if (zoneNames[j] == zone) then
                return i, j;
            end
        end
    end
end

-- Converts the zone into the continent/zone numbers used by MapNotes
local function QuestLibrary_MapNotes_GetZone(zone)
	if (QUESTLIBRARY_GETZONE[zone]) then
		return "WM "..QUESTLIBRARY_GETZONE[zone];
	else
		return;
	end
end

local function QuestLibrary_Make_MapNote(zonename,title,tcolor,info1,i1color,info2,i2color,icon,x,y)
	local rl =  0;
	if ( QuestLibraryMN_Data_Notes ) then
		local old_WorldMapButton_OnUpdate;
		if (MapNotes_Options) then -- Set to either MapNotes or MetaMapNotes
			old_WorldMapButton_OnUpdate = MapNotes_WorldMapButton_OnUpdate;
			MapNotes_WorldMapButton_OnUpdate = QuestLibrary_DoNothing;
		elseif (MetaMapNotes_Options) then
			old_WorldMapButton_OnUpdate = MetaMapNotes_WorldMapButton_OnUpdate;
			MetaMapNotes_WorldMapButton_OnUpdate = QuestLibrary_DoNothing;
		end

		local key = QuestLibrary_MapNotes_GetZone(zonename);
		local xpos,ypos=(x+0)/100,(y+0)/100;
		local c, hasnear = 1, false;
		if (not QuestLibraryMN_Data_Notes[key]) then
			QuestLibraryMN_Data_Notes[key] = {};
		end
		for l, value in pairs(QuestLibraryMN_Data_Notes[key]) do
			if (abs(value.xPos - xpos) <= 0.0009765625 * QuestLibraryMN_MinDiff and abs(value.yPos - ypos) <= 0.0013020833 * QuestLibraryMN_MinDiff) then
				hasnear=true;
				break;
			end
			c = l+1;
		end
		if ( not hasnear and c < 100) then
			QuestLibraryMN_Data_Notes[key][c] = {};
			QuestLibraryMN_Data_Notes[key][c].name = title;
			QuestLibraryMN_Data_Notes[key][c].ncol = tcolor;
			QuestLibraryMN_Data_Notes[key][c].inf1 = info1;
			QuestLibraryMN_Data_Notes[key][c].in1c = i1color;
			QuestLibraryMN_Data_Notes[key][c].inf2 = info2;
			QuestLibraryMN_Data_Notes[key][c].in2c = i2color;
			QuestLibraryMN_Data_Notes[key][c].creator = "QuestLibrary";
			QuestLibraryMN_Data_Notes[key][c].icon = icon;
			QuestLibraryMN_Data_Notes[key][c].xPos = xpos;
			QuestLibraryMN_Data_Notes[key][c].yPos = ypos;
		elseif (hasnear) then
			rl = 1;
		else
			rl = 2;
		end

		if (MapNotes_Options) then -- Set to either MapNotes or MetaMapNotes
			MapNotes_WorldMapButton_OnUpdate = old_WorldMapButton_OnUpdate;
		elseif (MetaMapNotes_Options) then
			MetaMapNotes_WorldMapButton_OnUpdate = old_WorldMapButton_OnUpdate;
		end
		old_WorldMapButton_OnUpdate = nil;
	end
	return rl;
end

local function QuestLibrary_DeleteMapNotes(key)
	if ( QuestLibraryMN_Data_Notes and QuestLibraryMN_Data_Notes[key]) then
		local i = 1;

		local old_WorldMapButton_OnUpdate;
		if (MapNotes_Options) then -- Set to either MapNotes or MetaMapNotes
			old_WorldMapButton_OnUpdate = MapNotes_WorldMapButton_OnUpdate;
			MapNotes_WorldMapButton_OnUpdate = QuestLibrary_DoNothing;
		elseif (MetaMapNotes_Options) then
			old_WorldMapButton_OnUpdate = MetaMapNotes_WorldMapButton_OnUpdate;
			MetaMapNotes_WorldMapButton_OnUpdate = QuestLibrary_DoNothing;
		end
		local old_SetMapZoom = SetMapZoom;
		SetMapZoom = QuestLibrary_DoNothing;
		
		local orgCont,orgZone = GetCurrentMapContinent(),GetCurrentMapZone();
		--old_SetMapZoom(continent, zone);

		while (QuestLibraryMN_Data_Notes[key][i]) do
			if (QuestLibraryMN_Data_Notes[key][i].creator=="QuestLibrary") then
				QuestLibraryMN_DeleteNote(i, key);
			else
				i = i + 1;
			end
		end
		old_SetMapZoom(orgCont, orgZone);
		SetMapZoom = old_SetMapZoom;
		if (MapNotes_Options) then -- Set to either MapNotes or MetaMapNotes
			MapNotes_WorldMapButton_OnUpdate = old_WorldMapButton_OnUpdate;
			MapNotes_MapUpdate();
		elseif (MetaMapNotes_Options) then
			MetaMapNotes_WorldMapButton_OnUpdate = old_WorldMapButton_OnUpdate;
			MetaMapNotes_MapUpdate();
		end
		old_WorldMapButton_OnUpdate = nil;
	end
end

local function QuestLibrary_QuestNPCTree_OnClick(postable)
	if (not postable or not QuestLibrary_QuestData) then
		return;
	end

	local MapNoteError = 0;
	local text = "["..QuestLibrary_QuestData.t..QUESTLIBRARY_TEXT_TOOLTIP1..postable.t..QUESTLIBRARY_TEXT_TOOLTIP2..postable.n..QUESTLIBRARY_TEXT_TOOLTIP3..postable.a;
	if ( QuestLibraryMN_Data_Notes and postable.pos and postable.pos[1] and not IsShiftKeyDown()) then
		local key = QuestLibrary_MapNotes_GetZone(postable.a);
		QuestLibrary_DeleteMapNotes(key);
	end
	for k,pos in pairs(postable.pos) do
		text = text.." <"..pos.x..","..pos.y..">";
		if (not (IsShiftKeyDown() and ChatFrameEditBox:IsVisible()) and MapNoteError<2) then
			MapNoteError = QuestLibrary_Make_MapNote(postable.a,postable.n,0,QUESTLIBRARY_TEXT_TOOLTIP4..QuestLibrary_QuestData.t,4,postable.t,8,1,pos.x,pos.y);
			if (MapNoteError==2) then
				HC_PrintLogString(QUESTLIBRARY_TEXT_TOOLTIP5..postable.a..QUESTLIBRARY_TEXT_TOOLTIP6);
			end
		end
	end
	if ( IsShiftKeyDown() ) then
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:Insert(text);
		end
	elseif ( QuestLibraryMN_Data_Notes and postable.pos and postable.pos[1]) then
		local continent, zone = QuestLibrary_MapNotes_GetZoneID(postable.a);
		ToggleFrame(WorldMapFrame);
		SetMapZoom(continent, zone);
	end
end

local function QuestLibrary_GenEarthTreeTable(id)
	if (QuestLibrary_QuestData and QuestLibrary_QuestData.os and QuestLibrary_QuestData.os[id] and QuestLibrary_QuestData.os[id].npc) then
		local eTree={};
		local objtext;
		if (QuestLibrary_QuestData.os[id].t) then
			objtext = QuestLibrary_QuestData.os[id].t;
			objtext = string.gsub(objtext,QUESTLIBRARY_QUESTOBJECT_FILTER1,"");
			objtext = string.gsub(objtext,QUESTLIBRARY_QUESTOBJECT_FILTER2,"");
		else
			objtext = "Unknown";
		end
		for z,zn in pairs(QuestLibrary_QuestData.os[id].npc) do
			local areaentry={};
			areaentry.title = z;
			areaentry.children = {};
			for i,nd in pairs(zn) do
				local npcentry = {};
				npcentry.title = nd.n;
				npcentry.titleColor={r=1,g=1,b=0};
				npcentry.right = "";
				if (nd.c) then
					npcentry.right = npcentry.right..nd.c;
				end
				if (nd.ll and nd.lm) then
					if (nd.ll==nd.lm) then
						npcentry.right = npcentry.right.." lv "..nd.ll;
					else
						npcentry.right = npcentry.right.." lv "..nd.ll.."-"..nd.lm;
					end
					npcentry.rightColor=GetDifficultyColor(nd.ll);
				else
					npcentry.right = npcentry.right.." "..UNIT_LETHAL_LEVEL_TEMPLATE;
				end
				npcentry.onClick = QuestLibrary_QuestNPCTree_OnClick;
				local tltip=QUESTLIBRARY_TEXT_TOOLTIP7..objtext.."|r\n|cFFFF0000"..nd.n.."|r\n"..z.."\n";
				local poscount = 0;
				for k,v in pairs(nd.pos) do
					if (poscount==5) then
						poscount = 0;
						tltip = tltip.."\n";
					end
					tltip = tltip.." <"..v.x..","..v.y..">";
					poscount = poscount+1;
				end
				npcentry.tooltip = tltip;
				npcentry.value = {t=objtext,a=z,n=nd.n,pos=nd.pos};
				table.insert(areaentry.children,npcentry);
			end
			table.insert(eTree,areaentry);
		end
		return eTree;
	end
	return nil;
end

-- Remove all notes on World Map
function QuestLibrary_WorldMapDeleteButton_OnClick()
	local key = QuestLibrary_GetMapKey();
	QuestLibrary_DeleteMapNotes(key);
end

----------------------------------------------------------------------------------------------------
-- QuestLog Hooked Functions
----------------------------------------------------------------------------------------------------

-- QuestLog
function QuestLibrary_QL_Update()
	QuestLibraryQLNPCFrame:Hide();
	QuestLogFrameAbandonButton:Show();
	QuestFramePushQuestButton:Show();
end


-- QuestLog
function QuestLibrary_QL_Detail_Update()
	QuestLibraryQLNPCFrame:Hide();
	QuestLogDetailScrollFrame:Show();
	QuestLogFrameAbandonButton:Show();
	QuestFramePushQuestButton:Show();

	local questID = string.match(GetQuestLink(GetQuestLogSelection()),'quest:(%d+):%d+');
	local questTitle = GetQuestLogTitle(GetQuestLogSelection());

	QuestLibrary_QuestData = QuestLibrary_GetQuest(questID, questTitle);
	if (QuestLibrary_QuestData and (QuestLibrary_QuestData.az or QuestLibrary_QuestData.cz)) 
	then
		QuestLibraryQLACQueryButton:Show();
	else
		QuestLibraryQLACQueryButton:Hide();
	end
	
	local i;
	for i = 1, 10 do
		local button = getglobal("QuestLibraryQLObjectButton"..i);
		local qlstring = getglobal("QuestLogObjective"..i);
		button:Hide();
		if (qlstring:IsVisible() and QuestLibrary_QuestData and QuestLibrary_QuestData.os and QuestLibrary_QuestData.os[i]) then
 			button:ClearAllPoints();
			button:SetPoint("TOPLEFT","QuestLogObjective"..i,"TOPLEFT", 0, 0);
			button:SetPoint("BOTTOMRIGHT","QuestLogObjective"..i,"BOTTOMRIGHT", 0, 0);
			button:SetID(i);
			button:Show();
		end
	end
end

-- QuestLog
function QuestLibrary_QLObjectButton_OnClick(button,id)
	if (QuestLibrary_QuestData and QuestLibrary_QuestData.os and QuestLibrary_QuestData.os[id] and QuestLibrary_QuestData.os[id].npc) then
		local ETree = QuestLibrary_GenEarthTreeTable(id);
		if (ETree) then
			QuestLogDetailScrollFrame:Hide();
			QuestLogFrameAbandonButton:Hide();
			QuestFramePushQuestButton:Hide();
			FauxScrollFrame_SetOffset(QuestLibraryQLNPCTreeListScrollFrame, 0); -- reset offset
			EarthTree_LoadEnhanced(QuestLibraryQLNPCTree,ETree);
			EarthTree_UpdateFrame(QuestLibraryQLNPCTree); 
			if(UberQuest_Details ~= nil)then
				QuestLibrary_HideUberQuest_Details();
				QuestLibraryQLNPCFrame:SetParent("UberQuest_Details");
				QuestLibraryQLNPCFrame:SetPoint("TOPLEFT","UberQuest_Details","TOPLEFT", 20, -80);
				QuestLibraryQLNPCBackButton:SetPoint("BOTTOMLEFT","UberQuest_Details","BOTTOMLEFT", 20, 80);
				QuestLibraryQLNPCBackButton:Show();
			end
			if(EQL3_QuestLogFrame_Description ~= nil)then
				QuestLibrary_HideEQL3_Details();
				QuestLibraryQLNPCFrame:SetParent("EQL3_QuestLogFrame_Description");
				QuestLibraryQLNPCFrame:SetPoint("TOPLEFT","EQL3_QuestLogFrame_Description","TOPLEFT", -40, -80);
				QuestLibraryQLNPCBackButton:SetPoint("BOTTOMLEFT","EQL3_QuestLogFrame_Description","BOTTOMLEFT", -40, 5);
				QuestLibraryQLNPCBackButton:Show();
			end
			if(QuestLogFrameCloseButton and beql)then
				QuestLibraryQLNPCFrame:SetParent("QuestLogFrameCloseButton");
				QuestLibraryQLNPCFrame:SetPoint("TOPLEFT","QuestLogFrameCloseButton","TOPLEFT", -310, -75);
				QuestLibraryQLNPCBackButton:SetPoint("BOTTOMLEFT","QuestLogFrameCloseButton","BOTTOMLEFT", -310, -467);
				QuestLibraryQLNPCBackButton:Show();
			end
			QuestLibraryQLNPCFrame:Show();
		end
	end
end

-- QuestLog
local function QuestLibrary_QuestACTree_OnClick(value)
	if (not value or not QuestLibrary_QuestData) then
		return;
	end
	QuestLibrary_QH_SendToMapNotes("LeftButton",value.l);
end

-- QuestLog
function QuestLibrary_QLACQueryButton_OnClick()
	if (QuestLibrary_QuestData and (QuestLibrary_QuestData.az or QuestLibrary_QuestData.cz)) then
		local ETree = {};
		if (QuestLibrary_QuestData.az) then
			local tltip=QUESTLIBRARY_TEXT_TOOLTIP8;
			if (QuestLibrary_QuestData.g) then
				tltip=tltip.."|cFF00FF00"..QuestLibrary_QuestData.g.."|r\n";
			end
			tltip=tltip..QuestLibrary_QuestData.az.."\n";
			local poscount = 0;
			for k,v in pairs(QuestLibrary_QuestData.pa) do
				if (poscount==5) then
					poscount = 0;
					tltip = tltip.."\n";
				end
				tltip = tltip.." <"..v.x..","..v.y..">";
				poscount = poscount+1;
			end	
			local ctitle = QuestLibrary_QuestData.az;
			if (QuestLibrary_QuestData.pa and QuestLibrary_QuestData.pa[1]) then
				ctitle = ctitle.." ("..QuestLibrary_QuestData.pa[1].x..", "..QuestLibrary_QuestData.pa[1].y..")";
			end
			local entry = {
				title = QUESTLIBRARY_TEXT_ACCEPTQUESTLOCATION,
				children = {
					{
						title = ctitle,
						titleColor={r=1,g=1,b=0},
						tooltip = tltip,
						right = QuestLibrary_QuestData.g,
						rightColor={r=0,g=1,b=0},
						onClick = QuestLibrary_QuestACTree_OnClick,
						value = {l="a"},
					}
				},
			};
			table.insert(ETree,entry);
		end
		if (QuestLibrary_QuestData.cz) then
			local tltip=QUESTLIBRARY_TEXT_TOOLTIP9;
			if (QuestLibrary_QuestData.w) then
				tltip=tltip.."|cFF00FF00"..QuestLibrary_QuestData.w.."|r\n";
			end
			tltip=tltip..QuestLibrary_QuestData.cz.."\n";
			local poscount = 0;
			for k,v in pairs(QuestLibrary_QuestData.pc) do
				if (poscount==5) then
					poscount = 0;
					tltip = tltip.."\n";
				end
				tltip = tltip.." <"..v.x..","..v.y..">";
				poscount = poscount+1;
			end
			local ctitle = QuestLibrary_QuestData.cz;
			if (QuestLibrary_QuestData.pc and QuestLibrary_QuestData.pc[1]) then
				ctitle = ctitle.." ("..QuestLibrary_QuestData.pc[1].x..", "..QuestLibrary_QuestData.pc[1].y..")";
			end
			local entry = {
				title = QUESTLIBRARY_TEXT_COMPLETEQUESTLOCATION,
				children = {
					{
						title = ctitle,
						titleColor={r=1,g=1,b=0},
						tooltip = tltip,
						right = QuestLibrary_QuestData.w,
						rightColor={r=0,g=1,b=0},
						onClick = QuestLibrary_QuestACTree_OnClick,
						value = {l="c"},
					}
				},
			};
			table.insert(ETree,entry);
		end
		if(UberQuest_Details)then
				QuestLibrary_HideUberQuest_Details();
				QuestLibraryQLNPCFrame:SetParent("UberQuest_Details");
				QuestLibraryQLNPCFrame:SetPoint("TOPLEFT","UberQuest_Details","TOPLEFT", 20, -80);
				QuestLibraryQLNPCBackButton:SetPoint("BOTTOMLEFT","UberQuest_Details","BOTTOMLEFT", 20, 80);
				QuestLibraryQLNPCBackButton:Show();
		end
		if(EQL3_QuestLogFrame_Description)then
				QuestLibrary_HideEQL3_Details();
				QuestLibraryQLNPCFrame:SetParent("EQL3_QuestLogFrame_Description");
				QuestLibraryQLNPCFrame:SetPoint("TOPLEFT","EQL3_QuestLogFrame_Description","TOPLEFT", -40, -80);
				QuestLibraryQLNPCBackButton:SetPoint("BOTTOMLEFT","EQL3_QuestLogFrame_Description","BOTTOMLEFT", -40, 5);
				QuestLibraryQLNPCBackButton:Show();
		end
		if(QuestLogFrameCloseButton and beql)then
				QuestLibraryQLNPCFrame:SetParent("QuestLogFrameCloseButton");
				QuestLibraryQLNPCFrame:SetPoint("TOPLEFT","QuestLogFrameCloseButton","TOPLEFT", -310, -75);
				QuestLibraryQLNPCBackButton:SetPoint("BOTTOMLEFT","QuestLogFrameCloseButton","BOTTOMLEFT", -310, -467);
				QuestLibraryQLNPCBackButton:Show();
		end
		QuestLogDetailScrollFrame:Hide();
		QuestLogFrameAbandonButton:Hide();
		QuestFramePushQuestButton:Hide();
		FauxScrollFrame_SetOffset(QuestLibraryQLNPCTreeListScrollFrame, 0); -- reset offset
		EarthTree_LoadEnhanced(QuestLibraryQLNPCTree,ETree);
		EarthTree_UpdateFrame(QuestLibraryQLNPCTree);
		QuestLibraryQLNPCFrame:Show();
	end
end

----------------------------------------------------------------------------------------------------
-- UberQuest Hooked Functions
----------------------------------------------------------------------------------------------------

function QuestLibrary_HideUberQuest_Details()
	if(UberQuest_Details)then
		local kids = { UberQuest_Details:GetChildren() };
		for _,child in ipairs(kids) do
			child:Hide();
		end
		UberQuest_Details_CloseButton:Show();
	end
end

function QuestLibrary_ShowUberQuest_Details()
	if(UberQuest_Details)then
		UberQuest_DetailsShowHide();
		if(not UberQuest_Details:IsVisible())then
			UberQuest_DetailsShowHide();
		end
	end
end

function QuestLibrary_UberQuest_Detail_Update()
	QuestLibraryQLNPCFrame:Hide();
	if(UberQuest_Details:IsVisible()) then
		local questID = string.match(GetQuestLink(GetQuestLogSelection()),'quest:(%d+):%d+');
		local questTitle = GetQuestLogTitle(GetQuestLogSelection());
		QuestLibrary_QuestData = QuestLibrary_GetQuest(questID, questTitle);
		if (QuestLibrary_QuestData and (QuestLibrary_QuestData.az or QuestLibrary_QuestData.cz)) 
		then
			QuestLibraryQLACQueryButton:SetParent("UberQuest_Details");
			QuestLibraryQLACQueryButton:SetPoint("TOPRIGHT", "UberQuest_Details", "TOPRIGHT", -65, -80);
			QuestLibraryQLACQueryButton:Show();
		else
			QuestLibraryQLACQueryButton:Hide();
		end
		local i;
		for i = 1, 10 do
			local button = getglobal("QuestLibraryQLObjectButton"..i);
			local qlstring = getglobal("UberQuest_Details_ScrollChild_Objective"..i);
			button:Hide();
			if (qlstring:IsVisible() and QuestLibrary_QuestData and QuestLibrary_QuestData.os) then
				--local text = qlstring:GetText();
				--text = string.gsub(text,QUESTLIBRARY_QUESTOBJECT_FILTER1,"");
				--text = string.gsub(text,QUESTLIBRARY_QUESTOBJECT_FILTER2,"");
				--for k,v in pairs(QuestLibrary_QuestData.os) do
					--local objtext = v.t;
					--objtext = string.gsub(objtext,QUESTLIBRARY_QUESTOBJECT_FILTER1,"");
					--objtext = string.gsub(objtext,QUESTLIBRARY_QUESTOBJECT_FILTER2,"");
					--if (v.npc) then
						--button:ClearAllPoints();
						--button:SetParent("UberQuest_Details");
						--button:SetPoint("TOPLEFT","UberQuest_Details_ScrollChild_Objective"..i,"TOPLEFT", 0, 0);
						--button:SetPoint("BOTTOMRIGHT","UberQuest_Details_ScrollChild_Objective"..i,"BOTTOMRIGHT", 0, 0);
						--button:SetID(k);
						--button:Show();
						--break;
					--end
				--end
				if (QuestLibrary_QuestData.os[i]) then
					button:ClearAllPoints();
					button:SetParent("UberQuest_Details");
					button:SetPoint("TOPLEFT","UberQuest_Details_ScrollChild_Objective"..i,"TOPLEFT", 0, 0);
					button:SetPoint("BOTTOMRIGHT","UberQuest_Details_ScrollChild_Objective"..i,"BOTTOMRIGHT", 0, 0);
					button:SetID(i);
					button:Show();
				end
			end
		end
	end
end


----------------------------------------------------------------------------------------------------
-- EQL3 Hooked Functions
----------------------------------------------------------------------------------------------------

function QuestLibrary_HideEQL3_Details()
	if(EQL3_QuestLogFrame_Description)then
		local kids = { EQL3_QuestLogFrame_Description:GetChildren() };
		for _,child in ipairs(kids) do
			child:Hide();
		end
		EQL3_QuestLogFrameCloseButton2:Show();
		EQL3_QuestLogFrameMinimizeButton:Show();
	end
end

function QuestLibrary_ShowEQL3_Details()
	if(EQL3_QuestLogFrame_Description)then
		ToggleQuestLog();
		if(not EQL3_QuestLogFrame_Description:IsVisible())then
			ToggleQuestLog();
		end
	end
end

function QuestLibrary_EQL3_Detail_Update()
	QuestLibraryQLNPCFrame:Hide();
	if(EQL3_QuestLogFrame_Description:IsVisible()) then
		local questID = string.match(GetQuestLink(GetQuestLogSelection()),'quest:(%d+):%d+');
		local questTitle = GetQuestLogTitle(GetQuestLogSelection());
		QuestLibrary_QuestData = QuestLibrary_GetQuest(questID, questTitle);
		if (QuestLibrary_QuestData and (QuestLibrary_QuestData.az or QuestLibrary_QuestData.cz)) 
		then
			QuestLibraryQLACQueryButton:SetParent("EQL3_QuestLogFrame_Description");
			QuestLibraryQLACQueryButton:SetPoint("TOPRIGHT", "EQL3_QuestLogFrame_Description", "TOPRIGHT", -65, -80);
			QuestLibraryQLACQueryButton:Show();
		else
			QuestLibraryQLACQueryButton:Hide();
		end
		local i;
		for i = 1, 10 do
			local button = getglobal("QuestLibraryQLObjectButton"..i);
			local qlstring = getglobal("EQL3_QuestLogObjective"..i);
			button:Hide();
			if (qlstring:IsVisible() and QuestLibrary_QuestData and QuestLibrary_QuestData.os) then
				--local text = qlstring:GetText();
				--text = string.gsub(text,QUESTLIBRARY_QUESTOBJECT_FILTER1,"");
				--text = string.gsub(text,QUESTLIBRARY_QUESTOBJECT_FILTER2,"");
				--for k,v in pairs(QuestLibrary_QuestData.os) do
					--local objtext = v.t;
					--objtext = string.gsub(objtext,QUESTLIBRARY_QUESTOBJECT_FILTER1,"");
					--objtext = string.gsub(objtext,QUESTLIBRARY_QUESTOBJECT_FILTER2,"");
					--if (v.npc) then
						--button:ClearAllPoints();
						--button:SetParent("EQL3_QuestLogFrame_Description");
						--button:SetPoint("TOPLEFT","EQL3_QuestLogObjective"..i,"TOPLEFT", 0, 0);
						--button:SetPoint("BOTTOMRIGHT","EQL3_QuestLogObjective"..i,"BOTTOMRIGHT", 0, 0);
						--button:SetID(k);
						--button:Show();
						--break;
					--end
				--end
				if (QuestLibrary_QuestData.os[i]) then
					button:ClearAllPoints();
					button:SetParent("UberQuest_Details");
					button:SetPoint("TOPLEFT","UberQuest_Details_ScrollChild_Objective"..i,"TOPLEFT", 0, 0);
					button:SetPoint("BOTTOMRIGHT","UberQuest_Details_ScrollChild_Objective"..i,"BOTTOMRIGHT", 0, 0);
					button:SetID(i);
					button:Show();
				end
			end
		end
	end
end


----------------------------------------------------------------------------------------------------
-- QuestHistory Hooked Functions
----------------------------------------------------------------------------------------------------

function QuestLibrary_QH_SendToMapNotes(button, locationType)
	if (QuestLibrary_QuestData) then
		local title;
		local info1,info2 = "","";
		local icon;
		local p;
		local zone;
		if ( locationType == "a" ) then
			title = QuestLibrary_QuestData.t;
			info1 = QUESTLIBRARY_TEXT_ACCEPTQUEST;
			info2 = QuestLibrary_QuestData.g;
			p = QuestLibrary_QuestData.pa;
			zone = QuestLibrary_QuestData.az;
			icon = 2;
		else
			title = QuestLibrary_QuestData.t;
			info1 = QUESTLIBRARY_TEXT_COMPLETEQUEST;
			info2 = QuestLibrary_QuestData.w;
			p = QuestLibrary_QuestData.pc;
			zone = QuestLibrary_QuestData.cz;
			icon = 3;
		end
		if ( QuestLibraryMN_Data_Notes and p and p[1] and not IsShiftKeyDown()) then
			local key = QuestLibrary_MapNotes_GetZone(zone);
			QuestLibrary_DeleteMapNotes(key);
		end
		local text = "["..title.."]"..info1..": "..info2..QUESTLIBRARY_TEXT_TOOLTIP3..zone;
		local MapNoteError = 0;
		for k,v in pairs(p) do
			text = text.." <"..v.x..","..v.y..">";
			if (not (IsShiftKeyDown() and ChatFrameEditBox:IsVisible()) and MapNoteError<2) then
				MapNoteError = QuestLibrary_Make_MapNote(zone,title,0,info1,4,info2,8,icon,v.x,v.y);
				if (MapNoteError==2) then
					QL_Print(QUESTLIBRARY_TEXT_TOOLTIP5..zone..QUESTLIBRARY_TEXT_TOOLTIP6);
				end
			end
		end
		if ( IsShiftKeyDown() ) then
			if ( ChatFrameEditBox:IsVisible() ) then
				ChatFrameEditBox:Insert(text);
			end
		elseif ( QuestLibraryMN_Data_Notes and p and p[1]) then
			local continent, zone1 = QuestLibrary_MapNotes_GetZoneID(zone);
			ToggleFrame(WorldMapFrame);
			SetMapZoom(continent, zone1);
		end
	end
end


----------------------------------------------------------------------------------------------------
-- WatchButton Hooked Functions
-- Create by ZeroC
----------------------------------------------------------------------------------------------------


local _G = getfenv(0)

local function GetButton(i)
	local button = _G["QuestWatchLine"..i.."SearchButton"]
	
	if button then return button end
	
	button = CreateFrame("Button","QuestWatchLine"..i.."SearchButton",QuestWatchFrame)
	
	button:SetID(i)
	button:SetAlpha(0.6)
	button:RegisterForClicks("AnyUp")
	button:SetWidth(20) button:SetHeight(20)
	button:SetPoint("RIGHT","QuestWatchLine"..i,"LEFT")
	
	button:SetNormalTexture("Interface\\TutorialFrame\\TutorialFrame-QuestionMark")
	button:SetPushedTexture("Interface\\TutorialFrame\\TutorialFrame-QuestionMark")
	button:GetPushedTexture():SetWidth(20)
	button:GetPushedTexture():SetHeight(20)
	button:GetPushedTexture():ClearAllPoints()
	button:GetPushedTexture():SetPoint("CENTER",2,-2)
	
	button:SetScript("OnClick", function()
		ShowUIPanel(QuestLogFrame)
		QuestLog_SetSelection(this.questIndex)
		QuestLog_Update()
		if this.questObjID then
			QuestLibrary_QLObjectButton_OnClick(arg1, this.questObjID)
		else
			QuestLibrary_QLACQueryButton_OnClick()
		end
	end)
	button:SetScript("OnEnter", function() this:SetAlpha(1) end)
	button:SetScript("OnLeave", function() this:SetAlpha(0.6) end)
	
	return button
end
local function SetQuestTitle(index, questIndex)
	GetButton(index).questIndex = questIndex
	GetButton(index).questObjID = nil
	GetButton(index):Show()
end
local function SetQuestText(index, questIndex, questObjID)
	GetButton(index).questIndex = questIndex
	GetButton(index).questObjID = questObjID
	GetButton(index):Show()
end

hooksecurefunc("QuestWatch_Update", function()
	if not QuestWatchFrame:IsShown() then return end
	
	local numObjectives
	local watchTextIndex = 1
	local questIndex
	
	for i=1, GetNumQuestWatches() do
		questIndex = GetQuestIndexForWatch(i)
		if ( questIndex ) then
			numObjectives = GetNumQuestLeaderBoards(questIndex)
			if numObjectives > 0 then
				-- Set title
				SetQuestTitle(watchTextIndex, questIndex)
				watchTextIndex = watchTextIndex + 1
				for j=1, numObjectives do
					-- Set Objective text
					SetQuestText(watchTextIndex, questIndex, j)
					watchTextIndex = watchTextIndex + 1
				end
			end
		end
	end
	-- Hide unused watch lines
	for i=watchTextIndex, MAX_QUESTWATCH_LINES do
		local button = _G["QuestWatchLine"..i.."SearchButton"]
		if button then button:Hide() end
	end
end)
