
---------------------------------------------------
-- Local vars
---------------------------------------------------
local CurRealm = "";
local CurFaction = "";

---------------------------------------------------
-- EasyMail_SetupOptions
-- Set up slash commands and register in Khaos
---------------------------------------------------
function EasyMail_SetupOptions()
	CurRealm = GetRealmName();
	CurFaction = UnitFactionGroup("player");

	-- Define slash commands
	SlashCmdList["EASYMAIL"] = EasyMail_SlashCmdHandler;
	SLASH_EASYMAIL1 = "/"..EASYMAIL_SLASHCMD;
	
	if (Khaos and EasyMail_KhaosRegister) then
		EasyMail_KhaosRegister();
	end
end


---------------------------------------------------
-- EasyMail_SlashCmdHandler
-- Process slash commands
---------------------------------------------------
function EasyMail_SlashCmdHandler(msg)
	local command, parm = strsplit(" ", msg);
	command = command and strupper(command);
	parm = parm and strupper(parm);
	
	if (command == "CLEARLIST") then
		-- Clear all entries from the list
		StaticPopup_Show("EASYMAIL_CLEARLIST");
		return;
	end
	
	if (command == "SETLEN") then
		if (EasyMail_SetListLen(parm)) then
			EasyMail_Print(format(EASYMAIL_MAXLENMSG, parm));
		end
		
		return;
	end
	
	if (command == "AUTOADD") then
		if (parm and (parm == "ON" or parm == "OFF")) then
			EasyMail_ToggleAutoAdd(parm == "ON");
			EasyMail_Print(format(EASYMAIL_AUTOADDMSG, parm));
		else
			EasyMail_PrintError(EASYMAIL_ERRTOGGLE);
		end
		
		return;
	end
	
	if (command == "GUILD") then
		if (parm and (parm == "ON" or parm == "OFF")) then
			EasyMail_ToggleGuild(parm == "ON");
			EasyMail_Print(format(EASYMAIL_GUILDMSG, parm));
		else
			EasyMail_PrintError(EASYMAIL_ERRTOGGLE);
		end
		
		return;
	end
	
	if (command == "FRIENDS") then
		if (parm and (parm == "ON" or parm == "OFF")) then
			EasyMail_ToggleFriends(parm == "ON");
			EasyMail_Print(format(EASYMAIL_FRIENDSMSG, parm));
		else
			EasyMail_PrintError(EASYMAIL_ERRTOGGLE);
		end
		
		return;
	end
	
	if (command == "CLICKGET") then
		if (parm and (parm == "ON" or parm == "OFF")) then
			EasyMail_ToggleClickGet(parm == "ON");
			EasyMail_Print(format(EASYMAIL_CLICKGETMSG, parm));
		else
			EasyMail_PrintError(EASYMAIL_ERRTOGGLE);
		end
		
		return;
	end
	
	if (command == "CLICKDEL") then
		if (parm and (parm == "ON" or parm == "OFF")) then
			EasyMail_ToggleClickDel(parm == "ON");
			EasyMail_Print(format(EASYMAIL_CLICKDELMSG, parm));
		else
			EasyMail_PrintError(EASYMAIL_ERRTOGGLE);
		end
		
		return;
	end
	
	if (command == "DELPROMPT") then
		if (parm and (parm == "ON" or parm == "OFF")) then
			EasyMail_ToggleDelPrompt(parm == "ON");
			EasyMail_Print(format(EASYMAIL_DELPROMPTMSG, parm));
		else
			EasyMail_PrintError(EASYMAIL_ERRTOGGLE);
		end
		
		return;
	end
	
	if (command == "TOOLTIP") then
		if (parm and (parm == "ON" or parm == "OFF")) then
			EasyMail_ToggleTextTooltip(parm == "ON");
			EasyMail_Print(format(EASYMAIL_TOOLTIPMSG, parm));
		else
			EasyMail_PrintError(EASYMAIL_ERRTOGGLE);
		end
		
		return;
	end
	
	if (command == "DELPENDING") then
		if (parm and (parm == "ON" or parm == "OFF")) then
			EasyMail_ToggleDelPending(parm == "ON");
			EasyMail_Print(format(EASYMAIL_DELPENDINGMSG, parm));
		else
			EasyMail_PrintError(EASYMAIL_ERRTOGGLE);
		end
		
		return;
	end
	
	if (command == "MONEY") then
		if (parm and (parm == "ON" or parm == "OFF")) then
			EasyMail_ToggleMoney(parm == "ON");
			EasyMail_Print(format(EASYMAIL_MONEYMSG, parm));
		else
			EasyMail_PrintError(EASYMAIL_ERRTOGGLE);
		end
		
		return;
	end
	
	if (command == "TOTAL") then
		if (parm and (parm == "ON" or parm == "OFF")) then
			EasyMail_ToggleTotal(parm == "ON");
			EasyMail_Print(format(EASYMAIL_TOTALMSG, parm));
		else
			EasyMail_PrintError(EASYMAIL_ERRTOGGLE);
		end
		
		return;
	end
	
	-- Print slash command list
	EasyMail_Print("/"..EASYMAIL_SLASHCMD.." clearlist - "..EASYMAIL_CLEARHELPMSG);
	EasyMail_Print(format("/"..EASYMAIL_SLASHCMD.." setlen <%i - %i> - "..EASYMAIL_MAXLENHELPMSG, EASYMAIL_MINLISTLEN, 
		EASYMAIL_MAXLISTLEN));
	EasyMail_Print("/"..EASYMAIL_SLASHCMD.." autoadd <ON/OFF> - "..EASYMAIL_AUTOADDHELPMSG);
	EasyMail_Print("/"..EASYMAIL_SLASHCMD.." friends <ON/OFF> - "..EASYMAIL_FRIENDSHELPMSG);
	EasyMail_Print("/"..EASYMAIL_SLASHCMD.." guild <ON/OFF> - "..EASYMAIL_GUILDHELPMSG);
	EasyMail_Print("/"..EASYMAIL_SLASHCMD.." clickget <ON/OFF> - "..EASYMAIL_CLICKGETHELPMSG);
	EasyMail_Print("/"..EASYMAIL_SLASHCMD.." clickdel <ON/OFF> - "..EASYMAIL_CLICKDELHELPMSG);
	EasyMail_Print("/"..EASYMAIL_SLASHCMD.." delprompt <ON/OFF> - "..EASYMAIL_DELPROMPTHELPMSG);
	EasyMail_Print("/"..EASYMAIL_SLASHCMD.." tooltip <ON/OFF> - "..EASYMAIL_TOOLTIPHELPMSG);
	EasyMail_Print("/"..EASYMAIL_SLASHCMD.." delpending <ON/OFF> - "..EASYMAIL_DELPENDINGHELPMSG);
	EasyMail_Print("/"..EASYMAIL_SLASHCMD.." money <ON/OFF> - "..EASYMAIL_MONEYHELPMSG);
	EasyMail_Print("/"..EASYMAIL_SLASHCMD.." total <ON/OFF> - "..EASYMAIL_TOTALHELPMSG);
end


---------------------------------------------------
-- EasyMail_SetListLen
-- Set the maximum length of the addressee list
---------------------------------------------------
function EasyMail_SetListLen(newLen)
	local errMsg;
	local i;
	local newLen = tonumber(newLen);

	if (newLen) then
		newLen = floor(newLen);
		
		if (newLen >= EASYMAIL_MINLISTLEN and newLen <= EASYMAIL_MAXLISTLEN) then
			if (newLen < #EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList) then
				-- Remove oldest entries on list when the list is longer than the new length
				for i = 1, #EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList - newLen do
					table.remove(EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList, 1)
				end
			end
			
			EasyMail_SortList();
			
			-- Set to the new length
			EasyMail_SavedVars[CurRealm][CurFaction].MailListLen = newLen;
		else
			-- User entered a parameter outside of the acceptable range
			errMsg = format(EASYMAIL_ERROUTOFRANGE, EASYMAIL_MINLISTLEN, EASYMAIL_MAXLISTLEN);
		end
	else
		-- User did not enter a numeric parameter
		errMsg = EASYMAIL_ERRINVALIDPARM;
	end

	if (errMsg) then
		-- Some error occured
		EasyMail_PrintError(errMsg);
		return false;
	end

	return true;
end


---------------------------------------------------
-- EasyMail_ClearList
-- Clear the addressee list
---------------------------------------------------
function EasyMail_ClearList()
	EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList = {};
	EasyMail_SortList();
	EasyMail_Print(EASYMAIL_CLEARMSG);
end


---------------------------------------------------
-- EasyMail_ToggleEnabled
-- Turn addon on or off
---------------------------------------------------
function EasyMail_ToggleEnabled(enabled)
	if (enabled) then
		EasyMail_Enabled = true;
 		SlashCmdList["EASYMAIL"] = EasyMail_SlashCmdHandler;
 		EasyMail_MailButton:Show();
 		EasyMail_AttButton:Show();
 		EasyMail_CheckAllButton:Show();
 		EasyMail_GetAllButton:Show();
		--EasyMail_Print("EasyMail enabled.");
	else
		EasyMail_Enabled = false;
		SlashCmdList["EASYMAIL"] = nil;
 		EasyMail_MailButton:Hide();
 		EasyMail_AttButton:Hide();
 		EasyMail_CheckAllButton:Hide();
 		EasyMail_GetAllButton:Hide();
		--EasyMail_Print("EasyMail disabled.");
	end
	
	EasyMail_ShowCheckBoxes();
end


---------------------------------------------------
-- EasyMail_ToggleAutoAdd
-- Turn on or off the automatic adding of logged in characters to the addressee list
---------------------------------------------------
function EasyMail_ToggleAutoAdd(enabled)
	EasyMail_SavedVars.AutoAdd = (enabled and "Y") or "N";
	
	if (EasyMail_Enabled and EasyMail_SavedVars.AutoAdd == "Y") then
		EasyMail_SaveAddressee(UnitName("player"), true);
	end;
end


---------------------------------------------------
-- EasyMail_ToggleGuild
-- Turn on or off the display of guild member names in the addressee drop-down list
---------------------------------------------------
function EasyMail_ToggleGuild(enabled)
	EasyMail_SavedVars.Guild = (enabled and "Y") or "N";
	
	if (IsInGuild() and EasyMail_SavedVars.Guild == "Y") then
		TimeSinceLastGuildQuery = 3;
		GuildQueryInterval = .5;
	end
end


---------------------------------------------------
-- EasyMail_ToggleFriends
-- Turn on or off the display of friend names in the addressee drop-down list
---------------------------------------------------
function EasyMail_ToggleFriends(enabled)
	EasyMail_SavedVars.Friends = (enabled and "Y") or "N";
	
	if (EasyMail_SavedVars.Friend == "Y") then
		TimeSinceLastFriendQuery = 3;
		FriendQueryInterval = .5;
	end
end


---------------------------------------------------
-- EasyMail_ToggleClickGet
-- Turn on or off the display of friend names in the addressee drop-down list
---------------------------------------------------
function EasyMail_ToggleClickGet(enabled)
	EasyMail_SavedVars.ClickGet = (enabled and "Y") or "N";
end


---------------------------------------------------
-- EasyMail_ToggleClickDel
-- Turn on or off the display of friend names in the addressee drop-down list
---------------------------------------------------
function EasyMail_ToggleClickDel(enabled)
	EasyMail_SavedVars.ClickDel = (enabled and "Y") or "N";
end


---------------------------------------------------
-- EasyMail_ToggleDelPrompt
-- Turn on or off the display of friend names in the addressee drop-down list
---------------------------------------------------
function EasyMail_ToggleDelPrompt(enabled)
	EasyMail_SavedVars.DelPrompt = (enabled and "Y") or "N";
end


---------------------------------------------------
-- EasyMail_ToggleDelPending
-- Turn on or off the display of friend names in the addressee drop-down list
---------------------------------------------------
function EasyMail_ToggleDelPending(enabled)
	EasyMail_SavedVars.DelPending = (enabled and "Y") or "N";
end


---------------------------------------------------
-- EasyMail_ToggleMoney
-- Turn on or off the display of friend names in the addressee drop-down list
---------------------------------------------------
function EasyMail_ToggleMoney(enabled)
	EasyMail_SavedVars.Money = (enabled and "Y") or "N";
end


---------------------------------------------------
-- EasyMail_ToggleTotal
-- Turn on or off the display of friend names in the addressee drop-down list
---------------------------------------------------
function EasyMail_ToggleTotal(enabled)
	EasyMail_SavedVars.Total = (enabled and "Y") or "N";
end


---------------------------------------------------
-- EasyMail_ToggleTextTooltip
-- Turn on or off the display of friend names in the addressee drop-down list
---------------------------------------------------
function EasyMail_ToggleTextTooltip(enabled)
	EasyMail_SavedVars.TextTooltip = (enabled and "Y") or "N";
end


---------------------------------------------------
-- EasyMail_KhaosRegister
-- Register options into Khaos
---------------------------------------------------
function EasyMail_KhaosRegister()
	local optionSet = {
		id = "EasyMail";
		text = EASYMAIL_ADDONNAME;
		helptext = EASYMAIL_CONFIG_HEADERINFO;
		difficulty = 1;
		callback = EasyMail_ToggleEnabled;
		default = true;
		options={
			{
				id = "header";
				text = EASYMAIL_ADDONNAME;
				helptext = EASYMAIL_CONFIG_HEADERINFO;
				type = K_HEADER;
				difficulty = 1;
			};
			{
				id = "autoadd";
				type = K_TEXT;
				text = EASYMAIL_CONFIG_AUTOADD;
				helptext = EASYMAIL_AUTOADDHELPMSG;
				check = true;
				default = {checked = false;};
				callback = function(state) EasyMail_ToggleAutoAdd(state.checked); end;
				feedback = function(state) return format(EASYMAIL_AUTOADDMSG, ((state.checked and "ON") or "OFF")); end;
			};
			{
				id = "setlen";
				type = K_EDITBOX;
				text = format(EASYMAIL_CONFIG_MAXLEN, EASYMAIL_MINLISTLEN, EASYMAIL_MAXLISTLEN);
				helptext = EASYMAIL_MAXLENHELPMSG;
				callback = function(state) EasyMail_SetListLen(state.value); end;
				setup = {
					callOn = { 
						"unfocus" 
					}; 
				};
				default = {
					value = EasyMail_SavedVars[CurRealm][CurFaction].MailListLen;
				};
			};
			{
				id = "clearlist";
				type = K_BUTTON;
				text = EASYMAIL_CONFIG_CLEARLIST;
				helptext = EASYMAIL_CLEARHELPMSG;
				callback = function(state) EasyMail_SlashCmdHandler("clearlist"); end;
				setup = {
					buttonText = EASYMAIL_CONFIG_CLEARLISTBTNTEXT; 
				};
			};
			{
				id = "friends";
				type = K_TEXT;
				text = EASYMAIL_CONFIG_FRIENDS;
				helptext = EASYMAIL_FRIENDSHELPMSG;
				check = true;
				default = {checked = false;};
				callback = function(state) EasyMail_ToggleFriends(state.checked); end;
				feedback = function(state) return format(EASYMAIL_FRIENDSMSG, ((state.checked and "ON") or "OFF")); end;
			};
			{
				id = "guild";
				type = K_TEXT;
				text = EASYMAIL_CONFIG_GUILD;
				helptext = EASYMAIL_GUILDHELPMSG;
				check = true;
				default = {checked = false;};
				callback = function(state) EasyMail_ToggleGuild(state.checked); end;
				feedback = function(state) return format(EASYMAIL_GUILDMSG, ((state.checked and "ON") or "OFF")); end;
			};
			{
				id = "clickget";
				type = K_TEXT;
				text = EASYMAIL_CONFIG_CLICKGET;
				helptext = EASYMAIL_CLICKGETHELPMSG;
				check = true;
				default = {checked = false;};
				callback = function(state) EasyMail_ToggleClickGet(state.checked); end;
				feedback = function(state) return format(EASYMAIL_CLICKGETMSG, ((state.checked and "ON") or "OFF")); end;
			};
			{
				id = "clickdel";
				type = K_TEXT;
				text = EASYMAIL_CONFIG_CLICKDEL;
				helptext = EASYMAIL_CLICKDELHELPMSG;
				check = true;
				default = {checked = false;};
				callback = function(state) EasyMail_ToggleClickDel(state.checked); end;
				feedback = function(state) return format(EASYMAIL_CLICKDELMSG, ((state.checked and "ON") or "OFF")); end;
			};
			{
				id = "delprompt";
				type = K_TEXT;
				text = EASYMAIL_CONFIG_DELPROMPT;
				helptext = EASYMAIL_DELPROMPTHELPMSG;
				check = true;
				default = {checked = true;};
				callback = function(state) EasyMail_ToggleDelPrompt(state.checked); end;
				feedback = function(state) return format(EASYMAIL_DELPROMPTMSG, ((state.checked and "ON") or "OFF")); end;
			};
			{
				id = "texttooltip";
				type = K_TEXT;
				text = EASYMAIL_CONFIG_TOOLTIP;
				helptext = EASYMAIL_TOOLTIPHELPMSG;
				check = true;
				default = {checked = false;};
				callback = function(state) EasyMail_ToggleTextTooltip(state.checked); end;
				feedback = function(state) return format(EASYMAIL_TOOLTIPMSG, ((state.checked and "ON") or "OFF")); end;
			};
			{
				id = "delpending";
				type = K_TEXT;
				text = EASYMAIL_CONFIG_DELPENDING;
				helptext = EASYMAIL_DELPENDINGHELPMSG;
				check = true;
				default = {checked = false;};
				callback = function(state) EasyMail_ToggleDelPending(state.checked); end;
				feedback = function(state) return format(EASYMAIL_DELPENDINGMSG, ((state.checked and "ON") or "OFF")); end;
			};
			{
				id = "money";
				type = K_TEXT;
				text = EASYMAIL_CONFIG_MONEY;
				helptext = EASYMAIL_MONEYHELPMSG;
				check = true;
				default = {checked = true;};
				callback = function(state) EasyMail_ToggleMoney(state.checked); end;
				feedback = function(state) return format(EASYMAIL_MONEYMSG, ((state.checked and "ON") or "OFF")); end;
			};
			{
				id = "total";
				type = K_TEXT;
				text = EASYMAIL_CONFIG_TOTAL;
				helptext = EASYMAIL_TOTALHELPMSG;
				check = true;
				default = {checked = false;};
				callback = function(state) EasyMail_ToggleTotal(state.checked); end;
				feedback = function(state) return format(EASYMAIL_TOTALMSG, ((state.checked and "ON") or "OFF")); end;
			};
		};
	};
	
	Khaos.registerOptionSet("other", optionSet);
end
