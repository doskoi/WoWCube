-- -----------------------------------------------------------------
-- File: MyBank_Config.lua
--
-- Purpose: Functions for MyBank Config window and options.
-- 
-- Author: Ramble 
-- 
-- Credits: 
--   Starven, for MyInventory
--   Kaitlin, for BankItems
--   Sarf, for the original concept of AllInOneInventory
-- -----------------------------------------------------------------

-- == Slash Handlers == 
-- ChatCommandHandler: Slash commands are in here

function MyBank_ChatCommandHandler(msg)

	if ( ( not msg ) or ( strlen(msg) <= 0 ) ) then
		MyBank_Print(MYBANK_CHAT_COMMAND_USAGE);
		return;
	end
	
	local commandName, params = MyBank_Extract_NextParameter(msg);
	
	if ( ( commandName ) and ( strlen(commandName) > 0 ) ) then
		commandName = string.lower(commandName);
	else
		commandName = "";
	end
	
	if ( (strfind(commandName, "show")) or (strfind(commandName, "toggle")) ) then
		ToggleMyBankFrame();
	elseif ( (strfind(commandName, "freeze")) or (strfind(commandName, "unfreeze")) ) then
		MyBank_Toggle_Option("Freeze");
	elseif ( (strfind(commandName, "replacebank")) or (strfind(commandName, "replace"))) then
		MyBank_Toggle_Option("ReplaceBank");
	elseif strfind(commandName, "highlightbags") then
		MyBank_Toggle_Option("HighlightBags");
	elseif strfind(commandName, "highlightitems") then
		MyBank_Toggle_Option("HighlightItems");
	elseif strfind(commandName, "graphic") then
		MyBank_Toggle_Option("Graphics");
	elseif strfind(commandName, "back") then
		MyBank_Toggle_Option("Background");
	elseif strfind(commandName, "player") then
		MyBank_Toggle_Option("ShowPlayers");
	elseif ( (strfind(commandName, "cols")) or (strfind(commandName, "column")) ) then
		cols, params = MyBank_Extract_NextParameter(params);
		cols = tonumber(cols);
		MyBankFrame_SetColumns(cols);
	elseif ( (strfind(commandName, "reset")) or (strfind(commandName, "init")) ) then
		MyBankProfile[UnitName("player")] = nil;
		MyBank_InitializeProfile();
	elseif (strfind(commandName, "config")) then
		MyBankConfigFrame:Show();
	else
		MyBank_Print(MYBANK_CHAT_COMMAND_USAGE);
		return;
	end
end
-- Extract_NextParameter: Used for Slash command handler
function MyBank_Extract_NextParameter(msg)
	local params = msg;
	local command = params;
	local index = strfind(command, " ");
	if ( index ) then
		command = strsub(command, 1, index-1);
		params = strsub(params, index+1);
	else
		params = "";
	end
	return command, params;
end
-- == End Slash Handlers == 


--All Functions that deal directly with MyBankConfig Frame items should go here
function MyBankConfig_OnShow()
	MyBankConfigReplaceCheck:SetChecked(MyBankReplaceBank);
	MyBankConfigFreezeCheck:SetChecked(MyBankFreeze);
	MyBankConfigColumns:SetText(MyBankColumns);
	MyBankConfigHighlightItemsCheck:SetChecked(MyBankHighlightItems);
	MyBankConfigHighlightBagsCheck:SetChecked(MyBankHighlightBags);
	MyBankConfigHighlightItemsCheck:SetChecked(MyBankHighlightItems);
	MyBankConfigGraphicsCheck:SetChecked(MyBankGraphics);
	MyBankConfigBackgroundCheck:SetChecked(MyBankBackground);
end
function MyBankConfig_OnHide()
	if MyBankConfigReplaceCheck:GetChecked() then
		MyBank_Toggle_Option("ReplaceBank", 1,1);
	else
		MyBank_Toggle_Option("ReplaceBank", 0,1);
	end
	if MyBankConfigFreezeCheck:GetChecked() then
		MyBank_Toggle_Option("Freeze", 1,1);
	else
		MyBank_Toggle_Option("Freeze", 0,1);
	end
	local cols =  tonumber(MyBankConfigColumns:GetText());
	if cols and cols > 5 and cols < 19 then
		MyBankFrame_SetColumns(cols);
	end
	if MyBankConfigHighlightItemsCheck:GetChecked() then
		MyBank_Toggle_Option("HighlightItems",1,1);
	else
		MyBank_Toggle_Option("HighlightItems",0,1);
	end
	if MyBankConfigHighlightBagsCheck:GetChecked() then
		MyBank_Toggle_Option("HighlightBags",1,1);
	else
		MyBank_Toggle_Option("HighlightBags",0,1);
	end
	if MyBankConfigGraphicsCheck:GetChecked() then
		MyBank_Toggle_Option("Graphics",1,1);
	else
		MyBank_Toggle_Option("Graphics",0,1);
	end
	if MyBankConfigBackgroundCheck:GetChecked() then
		MyBank_Toggle_Option("Background",1,1);
	else
		MyBank_Toggle_Option("Background",0,1);
	end
end


-- END MyBankConfig Frame stuff


