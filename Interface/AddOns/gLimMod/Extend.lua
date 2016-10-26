-- <= == == == == == == == == == == == == =>
-- => 
-- =>   extend.lua
-- => 
-- =>   Bryan
-- =>   doskoi.panda@gmail.com
-- => 
-- <= == == == == == == == == == == == == =>

function extand_OnEvent()
	getglobal("ChatFrame1").lOriginalAddMessage = getglobal("ChatFrame1").AddMessage;
	getglobal("ChatFrame1").AddMessage = ShowTime;
end

function ShowTime(this, text, r, g, b, id)
	if (not text ) then
		return;
	end
	if ( CubeConfig.ChatTime == 1 ) then
		local msg = format(date("[%H:%M]").."%s", text);
		this:lOriginalAddMessage(msg, r, g, b, id);
	else
		this:lOriginalAddMessage(text, r, g, b, id);
	end
end

local extand = CreateFrame("Frame", nil, UIParent)
extand:SetScript("OnEvent", extand_OnEvent)
extand:RegisterEvent("VARIABLES_LOADED")

StaticPopupDialogs["ACCOUNT_NAME"] = {
  text = TEXT(GLIMUI_ACCOUNT_DESC),
  button1 = TEXT(OKAY),
  button2 = TEXT(CANCEL),
  OnShow = function()
    getglobal(this:GetName().."EditBox"):SetText(GetCVar("accountName"))
  end,
  OnAccept = function()
    SetCVar("accountName", getglobal(this:GetParent():GetName().."EditBox"):GetText())
	if ( gLimConfigSubFrame ) then
		gLimConfigSubFrame:Show();
	end
  end,
  OnCancel = function()
	if ( gLimConfigSubFrame ) then
		gLimConfigSubFrame:Show();
	end
  end,
  hasEditBox = 1,
  timeout = 0,
  hideOnEscape = 1
};

--[[
Better Item Count 

author: AnduinLothar    <karlkfi@cosmosui.org>
version: 1.1

Replaces some old Cosmos FrameXML Hacks.
-Better Item Count displays #.#k instead of * for counts > 999

]]--

function BetterItemCount_SetItemButtonCount(button, count)
	-- orig by Miyke
	if ( not button ) then return end
	if ( not count ) then
		count = 0
	end

	button.count = count
	local countText = getglobal(button:GetName().."Count")
	if count > 1 or (button.isBag and count > 0) then
		if count > 999 then 
			local fixedCount = count+50
			count = floor((fixedCount)/1000).."."..floor(((mod(fixedCount, 1000))/100)).."k"
		end 
		countText:SetText(count)
		countText:Show()
	else
		countText:Hide()
	end
end

hooksecurefunc("SetItemButtonCount", BetterItemCount_SetItemButtonCount)

--[[
ReURL

author: AnduinLothar KarlKFI@cosmosui.org

-Click chat URL's to insert into the editbox for easy copy.

Change Log:
v2.0
-ChatFrame_OnEvent hook removed in favor of ChatFrame#.AddMessage hooks
v1.0
- Initial Release

]]--

--		For CHAT_MSG types: 
--			arg1 - message 
--			arg2 - player
--			arg3 - language (or nil)
--			arg4 - fancy channel name (5. General - Stormwind City)
--				   *Zone is always current zone even if not the same as the channel name
--			arg5 - Second player name when two users are passed for a CHANNEL_NOTICE_USER (E.G. x kicked y)
--			arg6 - AFK/DND "CHAT_FLAG_"..arg6 flags
--			arg7 - zone ID
--				1 (2^0) - General
--				2 (2^1) - Trade
--				2097152 (2^21) - LocalDefense
--				8388608 (2^23) - LookingForGroup
--				(these numbers are added bitwise)
--			arg8 - channel number (5)
--			arg9 - Full channel name (General - Stormwind City)
--				   *Not from GetChannelList

local SetItemRef_orig = SetItemRef;
function ReURL_SetItemRef(link, text, button)
	if (strsub(link, 1, 3) == "url") then
		local url = strsub(link, 5);
		if (not ChatFrameEditBox:IsShown()) then
			ChatFrame_OpenChat(url, DEFAULT_CHAT_FRAME);
		else
			ChatFrameEditBox:Insert(url);
		end
	else
		SetItemRef_orig(link, text, button);
	end
end
SetItemRef = ReURL_SetItemRef;

function ReURL_AddLinkSyntax(chatstring)
	if (type(chatstring) == "string") then
		local extraspace;
		if (not strfind(chatstring, "^ ")) then
			extraspace = true;
			chatstring = " "..chatstring;
		end
		chatstring = gsub (chatstring, " www%.([_A-Za-z0-9-]+)%.(%S+)%s?", ReURL_Link("www.%1.%2"))
		chatstring = gsub (chatstring, " (%a+)://(%S+)%s?", ReURL_Link("%1://%2"))
		chatstring = gsub (chatstring, " ([_A-Za-z0-9-%.]+)@([_A-Za-z0-9-]+)(%.+)([_A-Za-z0-9-%.]+)%s?", ReURL_Link("%1@%2%3%4"))
		chatstring = gsub (chatstring, " (%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?):(%d%d?%d?%d?%d?)%s?", ReURL_Link("%1.%2.%3.%4:%5"))
		chatstring = gsub (chatstring, " (%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%s?", ReURL_Link("%1.%2.%3.%4"))
		if (extraspace) then
			chatstring = strsub(chatstring, 2);
		end
	end
	return chatstring
end

REURL_COLOR = "6600FF";
ReURL_Brackets = nil;
ReUR_CustomColor = true;

function ReURL_Link(url)
	if (ReUR_CustomColor) then
		if (ReURL_Brackets) then
			url = " |cff"..REURL_COLOR.."|Hurl:"..url.."|h["..url.."]|h|r "
		else
			url = " |cff"..REURL_COLOR.."|Hurl:"..url.."|h"..url.."|h|r "
		end
	else
		if (ReURL_Brackets) then
			url = " |Hurl:"..url.."|h["..url.."]|h "
		else
			url = " |Hurl:"..url.."|h"..url.."|h "
		end
	end
	return url
end

--Hook all the AddMessage funcs
for i=1, NUM_CHAT_WINDOWS do
	local frame = getglobal("ChatFrame"..i)
	local addmessage = frame.AddMessage
	frame.AddMessage = function(self, text, ...) addmessage(self, ReURL_AddLinkSyntax(text), ...) end
end

