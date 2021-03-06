--[[
    Decursive (v 2.0) add-on for World of Warcraft UI
    Copyright (C) 2006-2007 John Wellesz (Archarodim) ( http://www.2072productions.com/?to=decursive.php )
    This is the continued work of the original Decursive (v1.9.4) by Quu
    Decursive 1.9.4 is in public domain ( www.quutar.com )

    License:
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2
    of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--]]
-------------------------------------------------------------------------------

if not DcrLoadedFiles or not DcrLoadedFiles["Dcr_opt.lua"] then
    if not DcrCorrupted then message("Decursive installation is corrupted! (Dcr_opt.lua not loaded)"); end;
    DcrCorrupted = true;
    return;
end
local D = Dcr;
--D:SetDateAndRevision("$Date: 2008-09-16 00:25:13 +0200 (mar., 16 sept. 2008) $", "$Revision: 81755 $");


local L = D.L;
local BC = D.BC;
local DC = DcrC;
local DS = DC.DS;

D.DebuffUpdateRequest = 0;

local pairs	= _G.pairs;
local next	= _G.next;
local pairs	= _G.pairs;
local ipairs	= _G.ipairs;
local unpack	= _G.unpack;
local select	= _G.select;
local table		= _G.table;
local UnitCreatureFamily	= _G.UnitCreatureFamily;
local InCombatLockdown	= _G.InCombatLockdown;
local PlaySoundFile	= _G.PlaySoundFile;
local UnitExists	= _G.UnitExists;
local UnitCanAttack	= _G.UnitCanAttack;
local UnitName		= _G.UnitName;
local UnitGUID		= _G.UnitGUID;
local GetTime		= _G.GetTime;


function D:GroupChanged () -- {{{
    -- this will trigger an update of the unit array
    D.Groups_datas_are_invalid = true;
    -- Update the MUFs display in a short moment
    D.MicroUnitF:Delayed_MFsDisplay_Update ();


    -- Test if we have to hide Decursive MUF window
    if D.profile.AutoHideDebuffsFrame ~= 0 then
	D:ScheduleEvent("Dcr_CheckIfHideShow", self.AutoHideShowMUFs, 2, self);
    end

    D:Debug("Groups changed");
end -- }}}

local OncePetRetry = false;

function D:UNIT_PET (Unit) -- {{{

    -- when a pet changes somwhere, we update the unit array.

    D:Debug("Pet changed for: ", Unit);
    if (D.profile.Scan_Pets and Unit ~= "focus" and self.Status.Unit_Array_UnitToGUID[Unit]) then
	D.Groups_datas_are_invalid = true;
	self.MicroUnitF:Delayed_MFsDisplay_Update();
    end


    -- If the player's pet changed then we should check it for interesting spells
    if ( Unit == "player" ) then
	self:ScheduleEvent("Dcr_CheckPet", self.UpdatePlayerPet, 2, self);
	OncePetRetry = false;
	D:Debug ("PLAYER pet detected! Poll in 2 seconds...");
    end
end -- }}}

local curr_petType = false;
local last_petType = false;

function D:UpdatePlayerPet () -- {{{
    curr_petType = UnitCreatureFamily("pet");
    D:Debug("|cFF0000FFCurrent Pet type is %s|r", curr_petType);

    -- if we had a pet and lost it, retry once later...
    if (last_petType and not curr_petType and not OncePetRetry) then
	OncePetRetry = true;

	D:Debug("|cFF9900FFPet lost, retry in 10 seconds|r");
	D:ScheduleEvent("Dcr_ReCheckPetOnce", D.UpdatePlayerPet, 10, self);
	return;
    end

    -- if we've changed of pet
    if (last_petType ~= curr_petType) then
	if (curr_petType) then D:Debug ("|cFF0066FFPet name changed: %s|r", curr_petType); else D:Debug ("|cFF0066FFNo more pet!|r"); end; -- debug info only

	last_petType = curr_petType;
	D:Configure();
    else
	D:Debug ("|cFFAA66FFNo change in Pet Type (%s)|r", curr_petType);
    end
end -- }}}



local FocusPrevious_ElligStatus = false;
function D:PLAYER_FOCUS_CHANGED () -- {{{

    -- we need to rescan if the focus is not in our group and it's nice or if we already have a focus unit registered
 
    local FocusCurrent_ElligStatus = (
	not self.Status.Unit_Array_GUIDToUnit[UnitGUID("focus")]    -- it's not already in the unit array
	) and ( UnitExists("focus") and (not UnitCanAttack("focus", "player") or UnitIsFriend("focus", "player"))) -- and it is (or used to) be nice


    if not FocusCurrent_ElligStatus then FocusCurrent_ElligStatus = false; end -- avoid the difference between nil and false...

    if FocusCurrent_ElligStatus~=FocusPrevious_ElligStatus or self.Status.Unit_Array_UnitToGUID["focus"] then
	self.Groups_datas_are_invalid = true;
	self:Debug("Groups set to invalid due to focus update", FocusPrevious_ElligStatus, FocusCurrent_ElligStatus);

	if FocusCurrent_ElligStatus~=FocusPrevious_ElligStatus then -- if the focus is no longer valid, we need to update things
	    self.MicroUnitF:Delayed_MFsDisplay_Update();
	end

	FocusPrevious_ElligStatus = FocusCurrent_ElligStatus;

    end


end -- }}}

function D:OnDebugEnable ()
    self.profile.debugging = true;
end

function D:OnDebugDisable ()
    self.profile.debugging = false;
end

-- This function update Decursive states :
--   - Clear the black list
--   - Execute things we couldn't do when in combat
D.Status.MaxConcurentUpdateDebuff = 0;
function D:SheduledTasks() -- {{{

    -- clean up the blacklist
    for unit in pairs(self.Status.Blacklisted_Array) do
	self.Status.Blacklisted_Array[unit] = self.Status.Blacklisted_Array[unit] - 0.1;
	if (self.Status.Blacklisted_Array[unit] < 0) then
	    self.Status.Blacklisted_Array[unit] = nil; -- remove it from the BL
	end
    end

    if (not self.Status.Combat and self.Status.DelayedFunctionCallsCount > 0) then
	for Id, FuncAndArgs in pairs (self.Status.DelayedFunctionCalls) do
	    D:Debug("Running post combat command %s", Id);
	    local DidSmth = FuncAndArgs.func(unpack(FuncAndArgs.args));
	    self.Status.DelayedFunctionCalls[Id] = nil; -- remove it from the list
	    self.Status.DelayedFunctionCallsCount = self.Status.DelayedFunctionCallsCount - 1;
	    if (DidSmth) then
		break;
	    end
	end
    end

    if (self.Status.Combat and not InCombatLockdown()) then -- just in case...
	D:LeaveCombat();
    end

    if D.DebuffUpdateRequest > D.Status.MaxConcurentUpdateDebuff then
	D.Status.MaxConcurentUpdateDebuff = D.DebuffUpdateRequest;
    end

    D.DebuffUpdateRequest = 0;

end --}}}

-- the combat functions and events. // {{{
-------------------------------------------------------------------------------
function D:EnterCombat() -- called on PLAYER_REGEN_DISABLED {{{
    --D:Debug("Entering combat");
    self.Status.Combat = true;
end --}}}

function D:LeaveCombat() --{{{
    --D:Debug("Leaving combat");
    self.Status.Combat = false;
end --}}}
-- }}}

-- This let us park command we can't execute while in combat to execute them later {{{
    -- the called function must return a non false value when it does something to prevent UI lagging
function D:AddDelayedFunctionCall(CallID,functionLink, ...)

--	D:Println("|cFFFF0000ALERT:|r XXX test %s (%s)",  select("#",...), CallID);
    
    if (not self.Status.DelayedFunctionCalls[CallID]) then 
	self.Status.DelayedFunctionCalls[CallID] =  {["func"] = functionLink, ["args"] =  {...}};
	self.Status.DelayedFunctionCallsCount = self.Status.DelayedFunctionCallsCount + 1;
    elseif select("#",...) > 1 then -- if we had more than the function reference and its object
--	D:Println("|cFFFF0000ALERT:|r XXX used (%s)", CallID);

	local args = self.Status.DelayedFunctionCalls[CallID].args;

	for i=1,select("#",...), 1 do
	    args[i]=select(i, ...);
	end

    end
end -- }}}



function D:UPDATE_MOUSEOVER_UNIT ()
    if not self.profile.Hide_LiveList and not self.Status.MouseOveringMUF and not UnitCanAttack("mouseover", "player") then
	--	D:Debug("will check MouseOver");
	self.LiveList:DelayedGetDebuff("mouseover");
    end
end



function D:PLAYER_TARGET_CHANGED()

    if UnitExists("target") and not UnitCanAttack("player", "target") then

	D.Status.TargetExists = true;

	self.LiveList:DelayedGetDebuff("target");
	

	if self:CheckUnitStealth("target") then
	    self.Stealthed_Units["target"] = true;
	end

    else
	D.Status.TargetExists = false;
	self.Stealthed_Units["target"] = false;
    end
end

function D:LEARNED_SPELL_IN_TAB()
    --D:Debug("|cFFFF0000A new spell was learned, scheduling a reconfiguration|r");
    self:ScheduleEvent("Dcr_NewSpellLearned", self.Configure, 5, self);
end

function D:SPELLS_CHANGED()
    --D:Debug("|cFFFF0000Spells were changed, scheduling a reconfiguration check|r");
    self:ScheduleEvent("Dcr_SpellsChanged", self.ReConfigure, 15, self);
end

do
    local bit = _G.bit;
    local band = bit.band;
    local bor = bit.bor;

    -- AURA bitfields -- now useless {{{
    -- a friendly player character controled directly by the player that is not an outsider
    local PLAYER	= bit.bor (COMBATLOG_OBJECT_CONTROL_PLAYER   , COMBATLOG_OBJECT_TYPE_PLAYER  , COMBATLOG_OBJECT_REACTION_FRIENDLY  ); -- still used
    local PLAYER_MASK	= bit.bnot (COMBATLOG_OBJECT_AFFILIATION_OUTSIDER);

    -- a hostile player character contoled as a pet and that is not an outsider
    local REACTION_HOSTILE		= COMBATLOG_OBJECT_REACTION_HOSTILE;

    -- a pet controled by a friendly player that is not an outsider
    local PET	    = bit.bor (COMBATLOG_OBJECT_CONTROL_PLAYER	, COMBATLOG_OBJECT_TYPE_PET	, COMBATLOG_OBJECT_REACTION_FRIENDLY  );
    local PET_MASK  = bit.bnot (COMBATLOG_OBJECT_AFFILIATION_OUTSIDER);

    -- An outsider friendly focused unit
    local FOCUSED_FRIEND       = bit.bor (COMBATLOG_OBJECT_REACTION_FRIENDLY   , COMBATLOG_OBJECT_FOCUS	    , COMBATLOG_OBJECT_AFFILIATION_OUTSIDER);
    -- }}}

    local OUTSIDER		= COMBATLOG_OBJECT_AFFILIATION_OUTSIDER;
    local HOSTILE_OUTSIDER	= bit.bor (COMBATLOG_OBJECT_AFFILIATION_OUTSIDER, COMBATLOG_OBJECT_REACTION_HOSTILE);
    local FRIENDLY_TARGET	= bit.bor (COMBATLOG_OBJECT_TARGET, COMBATLOG_OBJECT_REACTION_FRIENDLY);
    local ME			= COMBATLOG_OBJECT_AFFILIATION_MINE;


    local AuraEvents = {
	["SPELL_AURA_APPLIED"]	    = 1,
	["SPELL_AURA_APPLIED_DOSE"] = 1,
	["SPELL_AURA_REMOVED"]	    = 0,
	["SPELL_AURA_APPLIED_DOSE"] = 1,
	["SPELL_AURA_REMOVED_DOSE"] = 0,
	["UNIT_DIED"] = 0,
	--["SPELL_AURA_DISPELLED"] = 0,
    };

    local SpellEvents = {
	["SPELL_MISSED"]	= true,
	["SPELL_CAST_START"]	= true,
	["SPELL_CAST_FAILED"]	= true,
	["SPELL_CAST_SUCCESS"]	= true,
	["SPELL_DISPEL_FAILED"]	= true,
    };

    local UnitID;

    function D:DummyDebuff (UnitID, DebuffName)
	D:COMBAT_LOG_EVENT_UNFILTERED(0, "SPELL_AURA_APPLIED", nil, nil, COMBATLOG_OBJECT_NONE, UnitGUID(UnitID), (UnitName(UnitID)), PLAYER, 0, DebuffName, 0x32, "DEBUFF");
    end

    function D:COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, arg9, arg10, arg11, arg12)

	if destName and AuraEvents[event] then

	    if (self.Groups_datas_are_invalid) then
		if not self.DcrFullyInitialized then
		    self:Println("|cFFFF0000Could not process event: init uncomplete!|r");
		    return;
		end
		self:GetUnitArray();
	    end

	    UnitID = self.Status.Unit_Array_GUIDToUnit[destGUID]; -- get the grouped unit associated to the destGUID if there is none then the unit is not in our group or is filtered out

	    --D:Print("? (source=%s) (dest=|cFF00AA00%s|r -- %X): |cffff0000%s|r", sourceName, destName, destFlags, event);


	    -- we don't use the following test because it's unecessary, if a unit is missing, it'll be scanned on addition anyway...
	    --if not UnitID and band (destFlags, OUTSIDER) ~= OUTSIDER then -- we don't have a unit but the flags say it's in our group...
	    --end

	    if UnitID then -- this test is enough, if the unit is groupped we definetely need to scan it, whatever is its status...

		if UnitGUID(UnitID) ~= destGUID then

		    self.Groups_datas_are_invalid = true;
		    self:GetUnitArray();
		    UnitID = self.Status.Unit_Array_GUIDToUnit[destGUID];

		    if UnitID and UnitGUID(UnitID) ~= destGUID then
			D:Println("|cFFFF0000ALERT:|rSanity check(2nd) failed in combat event manager Unit_Array_GUIDToUnit[] is wrong (%s (%s) is not %s (%s) (flag=%s)) (tslgu=%s) %s.\nReport this to ARCHARODIM@TEASER.FR", UnitID, UnitGUID(UnitID), destGUID,destName,destFlags, GetTime() - D.Status.GroupUpdatedOn, event);
			return;
		    elseif not UnitID then
			D:Debug("|cFFFF0000No unit for GUID %s|r, in skip list?", destGUID);
			return;
		    end
		end

		if arg12 == "BUFF" and self.profile.Ingore_Stealthed then
		    if DC.IsStealthBuff[arg10] then
			if AuraEvents[event] == 1 then
			    self.Stealthed_Units[UnitID] = true;
			else
			    D:Debug("STEALTH LOST: ", UnitID, buffName);
			    self.Stealthed_Units[UnitID] = false;
			end
			self.MicroUnitF:UpdateMUFUnit(UnitID);
		    end
		else
		    D:Debug("Debuff, UnitId: ", UnitID, arg10, event);
		    if self.profile.ShowDebuffsFrame then
			self.MicroUnitF:UpdateMUFUnit(UnitID);
		    elseif not self.profile.Hide_LiveList then
			D:Debug("(LiveList) Registering delayed GetDebuff for ", destName);
			self.LiveList:DelayedGetDebuff(UnitID);
		    end

		    if event == "UNIT_DIED" then
			self.Stealthed_Units[UnitID] = false;
		    end

		end
	    end

	    if self.Status.TargetExists and band (destFlags, FRIENDLY_TARGET) == FRIENDLY_TARGET then -- TARGET

		D:Debug("A Target got something (source=%s -- %X) (dest=|cFF00AA00%s|r -- %x): |cffff0000%s|r, |cFF00AAAA%s|r, %s", sourceName, sourceFlags, destName, destFlags, event, arg10, arg12);

		self.LiveList:DelayedGetDebuff("target");

		if arg12 == "BUFF" and self.profile.Ingore_Stealthed then
		    if DC.IsStealthBuff[arg10] then
			if AuraEvents[event] == 1 then
			    self.Stealthed_Units["target"] = true;
			else
			    D:Debug("TARGET STEALTH LOST: ", "target", buffName);
			    self.Stealthed_Units["target"] = false;
			end
		    end
		end
	    end

	    -- SPELL EVENTS {{{
	elseif self.Status.ClickedMF and SpellEvents[event] and self.Status.CuringSpellsPrio[arg10] and band(sourceFlags, ME) ~= 0 then -- SPELL_MISSED  SPELL_CAST_START  SPELL_CAST_FAILED  SPELL_CAST_SUCCESS  DISPEL_FAILED

	    if event == "SPELL_CAST_START" then -- useless

		self:Print("|cFFFF0000Starting SPELL: ", arg10, "|r");
		self:ScheduleEvent("Dcr_UpdatePC"..self.Status.ClickedMF.CurrUnit, self.Status.ClickedMF.Update, 1 + ((select(7, GetSpellInfo(arg9))) / 1000), self.Status.ClickedMF, false, false);
	    end

	    if event == "SPELL_CAST_SUCCESS" then
		--D:Println(L[self.LOC.SUCCESSCAST], arg10, (select(2, GetSpellInfo(arg9))), D:MakePlayerName(destName));
		self:Debug(L[self.LOC.SUCCESSCAST], arg10, (select(2, GetSpellInfo(arg9))), D:MakePlayerName(destName));

		--self:Debug("|cFFFF0000XXXXX|r |cFF11FF11Updating color of clicked frame|r");
		self:ScheduleEvent("Dcr_UpdatePC"..self.Status.ClickedMF.CurrUnit, self.Status.ClickedMF.Update, 1, self.Status.ClickedMF, false, false);
		self:ScheduleEvent("Dcr_clickedMFreset",
		function()
		    if D.Status.ClickedMF then
			D.Status.ClickedMF.SPELL_CAST_SUCCESS = false;
			D.Status.ClickedMF = false;
			D:Debug("ClickedMF to false (sched)");
		    end
		end, 0.1 );

		self.Status.ClickedMF.SPELL_CAST_SUCCESS = true;

	    end

	    if event == "SPELL_CAST_FAILED" and not D.Status.ClickedMF.SPELL_CAST_SUCCESS then
		destName = self:PetUnitName( self.Status.ClickedMF.CurrUnit, true);

		D:Println(L[self.LOC.FAILEDCAST], arg10, (select(2, GetSpellInfo(arg9))), D:MakePlayerName(destName), arg12);

		if (arg12 == SPELL_FAILED_LINE_OF_SIGHT or arg12 == SPELL_FAILED_BAD_TARGETS) then

		    if not self.profile.DoNot_Blacklist_Prio_List or not self:IsInPriorList(self.Status.Unit_Array_UnitToGUID[self.Status.ClickedMF.CurrUnit]) then
			self.Status.Blacklisted_Array[self.Status.ClickedMF.CurrUnit] = self.profile.CureBlacklist;

			self:Debug("|cFFFF0000XXXXX|r |cFF11FF11Updating color of blacklist frame|r");
			self:ScheduleEvent("Dcr_Update"..self.Status.ClickedMF.CurrUnit, self.Status.ClickedMF.Update, self.profile.DebuffsFrameRefreshRate, self.Status.ClickedMF, false, true);
		    end

		    PlaySoundFile(DC.FailedSound);
		end
		self.Status.ClickedMF = false;

	    elseif event == "SPELL_MISSED" or event == "SPELL_DISPEL_FAILED" then -- XXX to test
		destName = self:PetUnitName( self.Status.ClickedMF.CurrUnit, true);

		D:Println(L[self.LOC.FAILEDCAST], arg10, (select(2, GetSpellInfo(arg9))), D:MakePlayerName(destName), arg12);
		PlaySoundFile(DC.FailedSound);
		self.Status.ClickedMF = false;
	    end


	    ----  }}}
	--else
	   --D:Print("UNKNOWN EVENT: (source=%s -- %X) (dest=|cFF00AA00%s|r -- %x): |cFFBB0000%s|r for spell |cFF00FF00%s|r, %s, %s, %s, %s, %s, %s", sourceName, sourceFlags, destName, destFlags, event, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
	    --  }}}
	end


    end



end

function D:SPELL_UPDATE_COOLDOWN()
    --if arg1 then
    D.Status.UpdateCooldown = GetTime();
    --end
    --D:Debug("update cd:", arg1);
end

DcrLoadedFiles["Dcr_Events.lua"] = "2.4_beta_2_STABLE";

