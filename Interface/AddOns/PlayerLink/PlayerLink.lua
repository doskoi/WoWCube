FRIENDSMENU_MAXBUTTONS = 20;
FRIENDSMENU_NOW_LINK_PLAYER = nil;
tinsert(UIMenus, "PlayerLink");
tinsert(UIMenus, "PlayerLinkSecure");

local function GetNameFromLink(link)
	local namelink = strsub(link, 8);
	local name, lineid = strsplit(":", namelink);
	if ( name and (strlen(name) > 0) ) then
		name = gsub(name, "([^%s]*)%s+([^%s]*)%s+([^%s]*)", "%3");
		name = gsub(name, "([^%s]*)%s+([^%s]*)", "%2");
	end
	return name;
end

local function SetOrHookScript(frame, scriptName, func)
	if( frame:GetScript(scriptName) ) then
		frame:HookScript(scriptName, func);
	else
		frame:SetScript(scriptName, func);
	end
end

--function hooked to "FriendsFrame_ShowDropdown"
function PlayerLink_ShowDropdown(name, connected, lineID)
	HideDropDownMenu(1);
	if(InCombatLockdown()) then
		PlayerLink_Show(PlayerLink, name, connected, lineID);
	else
		PlayerLink_Show(PlayerLinkSecure, name, connected, lineID);
	end
end

--function hooked to "RaidGroupButton_ShowMenu"
--[[
function PlayerLink_ShowRaidDropdown()
	local name, server = UnitName(this.unit);
	if(server and server~="") then name = name.."-"..server; end
	local connected = UnitIsConnected(this.unit);
	if(InCombatLockdown()) then
		PlayerLink_Show(PlayerLink, name, connected, nil, nil, "RAID");
		PlayerLink:ClearAllPoints();
		if(DropDownList1:IsVisible()) then
			PlayerLink:SetPoint("TOPLEFT", "DropDownList1", "TOPRIGHT");
		else
			PlayerLink:SetPoint("TOPLEFT", "DropDownList1", "TOPLEFT");
		end
	else
		PlayerLink_Show(PlayerLinkSecure, name, connected, nil, nil, "RAID");
		PlayerLinkSecure:ClearAllPoints();
		if(DropDownList1:IsVisible()) then
			PlayerLinkSecure:SetPoint("TOPLEFT", "DropDownList1", "TOPRIGHT");
		else
			PlayerLinkSecure:SetPoint("TOPLEFT", "DropDownList1", "TOPLEFT");
		end
	end
end
]]

--function hooked to ChatFrames' OnHyperlinkEnter
function PlayerLink_OnHyperlinkEnter(arg1,link,arg3,arg4)
	if ( link and strsub(link, 1, 6) == "player" ) then
		FRIENDSMENU_NOW_LINK_PLAYER = GetNameFromLink(link);
	end;
end

--function hooked to ChatFrames' OnHyperlinkLeave
function PlayerLink_OnHyperlinkLeave(arg1,arg2,arg3,arg4)
	FRIENDSMENU_NOW_LINK_PLAYER=nil;
end

--ClickHandler for ListMenu buttons
function PlayerLinkButton_OnClick()
	local func = this.func;
	if ( func ) then
		func(this:GetParent().NAME, this:GetParent().connected, this:GetParent().lineID, this.arg1, this.arg2, this.arg3);
	end;
	
	this:GetParent():Hide();
	if(getglobal("DropDownList1")) then DropDownList1:Hide(); end;
	PlaySound("UChatScrollButton");
end

function PlayerLink_ChatFrame_OnHyperlinkShow(link, text, button)
--	if(link and strsub(link, 1, 6) == "player") then
		if ( IsAltKeyDown() ) then
			--we must do reverse action against ItemRef#SetItemRef()
			if(not IsShiftKeyDown()) then
				if (button=="RightButton") then
					HideDropDownMenu(1);
				else
					DEFAULT_CHAT_FRAME.editBox:Hide();
				end
			end
			
			--do our defined action
			InviteUnit(GetNameFromLink(link));
			return;
		end
--	end
end
--deal with the hot-key click function.
function PlayerLink_InitiateMaskButton()
	--Create a "mask button", to block the click to ChatHyperlink.
	local button = CreateFrame("Button", "ChatLinkMaskButton", UIParent, "SecureActionButtonTemplate");
	button:RegisterForClicks("AnyUp");
	button:SetWidth(30); button:SetHeight(10);

	--right click this button will also bring the menu
	SetOrHookScript(button, "OnClick", function(self, button)
		if(button=="RightButton") then
			PlayerLink_ShowDropdown(self.NAME);
		end
	end);

	--define the SECURE actions 
	button:SetAttribute("ctrl-type1", "macro"); --ctrl+leftclick with do "/target linkname" macro.

	--define the insecure actions.
	hooksecurefunc("ChatFrame_OnHyperlinkShow", PlayerLink_ChatFrame_OnHyperlinkShow);
end


function PlayerLink_OnLoad()

	PlayerLink_InitiateMaskButton();

	for i=1,7 do
		SetOrHookScript(getglobal("ChatFrame"..i), "OnHyperlinkEnter", PlayerLink_OnHyperlinkEnter);
		SetOrHookScript(getglobal("ChatFrame"..i), "OnHyperlinkLeave", PlayerLink_OnHyperlinkLeave);
	end

	hooksecurefunc("FriendsFrame_ShowDropdown", PlayerLink_ShowDropdown);
	SetOrHookScript(getglobal("DropDownList1"), "OnHide", function()
		PlayerLink:Hide();
		if(not InCombatLockdown()) then PlayerLinkSecure:Hide(); end
	end)

	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("ADDON_LOADED"); -- for RaidUI

end

function PlayerLink_OnEvent(event, arg1)
	if(event=="PLAYER_REGEN_DISABLED") then
		if(ChatLinkMaskButton and ChatLinkMaskButton:IsVisible()) then ChatLinkMaskButton:Hide(); end;
		if(PlayerLinkSecure:IsVisible()) then
			PlayerLink_Show(PlayerLink, PlayerLinkSecure.NAME, PlayerLinkSecure.connected, PlayerLinkSecure.lineID, PlayerLinkSecure);
			PlayerLinkSecure:Hide();
		end
		--PlayerLinkUpdateFrame:SetScript("OnUpdate", nil);
	elseif(event=="PLAYER_REGEN_ENABLED") then
		if(PlayerLink:IsVisible()) then
			PlayerLink_Show(PlayerLinkSecure, PlayerLink.NAME, PlayerLink.connected, PlayerLink.lineID, PlayerLink);
			PlayerLink:Hide();
		end
		--PlayerLinkUpdateFrame:SetScript("OnUpdate", PlayerLink_OnUpdate);
		--[[
		if(RaidGroupButton1 and RaidGroupButton1:GetAttribute("type")~="target") then
			PlayerLink_FixRaidGroupButton();
		end;
		]]
	elseif(event=="ADDON_LOADED") then -- hook the raid button click.
		if(arg1=="Blizzard_RaidUI") then
			--hooksecurefunc("RaidGroupButton_ShowMenu", PlayerLink_ShowRaidDropdown);	
			hooksecurefunc("RaidPullout_Update", function(pullOutFrame) 
				if ( not pullOutFrame ) then
					pullOutFrame = this;
				end
				--pullOutFrame:SetScale(0.85);
				--pullOutFrame:ClearAllPoints();
				--pullOutFrame:SetPoint("TOPLEFT",ER_ContainerFrame,"TOPLEFT", 10,-10);
			end)

			--PlayerLink_FixRaidGroupButton();
		end
	end
end

local TimeSinceLastUpdate = 0;
--[[
function PlayerLink_FixRaidGroupButton()
	if(not InCombatLockdown()) then
		for i=1,40 do 
			local raidbutton = getglobal("RaidGroupButton"..i);
			if(raidbutton and raidbutton.unit) then
				raidbutton:SetAttribute("type", "target");
				raidbutton:SetAttribute("unit", raidbutton.unit);
			end
		end
	end
end
]]
function PlayerLink_OnUpdate(elapsed)
	TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed; 
	if(TimeSinceLastUpdate < 0.1) then return end; 
	TimeSinceLastUpdate = 0;
	if(InCombatLockdown()) then return end;

	if( IsControlKeyDown() and FRIENDSMENU_NOW_LINK_PLAYER) then
		if(ChatLinkMaskButton and ChatLinkMaskButton.NAME ~= FRIENDSMENU_NOW_LINK_PLAYER) then
			ChatLinkMaskButton.NAME = FRIENDSMENU_NOW_LINK_PLAYER;
			ChatLinkMaskButton:SetAttribute("macrotext", "/target "..ChatLinkMaskButton.NAME);
		end

		local x,y = GetCursorPosition()
		scale = UIParent:GetScale()
		if(scale and scale ~= 0) then
			x = x / scale
			y = y / scale
		end
		ChatLinkMaskButton:ClearAllPoints()
		ChatLinkMaskButton:SetPoint("TOPLEFT",UIParent,"TOPLEFT", x-15, y - UIParent:GetTop() + 5)

		ChatLinkMaskButton:Show();
	else
		if(not IsControlKeyDown() and ChatLinkMaskButton and ChatLinkMaskButton:IsVisible()) then 
			ChatLinkMaskButton:Hide(); 
		end
	end
end

--===============================================================================================
--The following codes are based on Blizzard's FrameXMLs, includes UnitPopup and UIDropDownMenu.
--===============================================================================================
function PlayerLink_Show(listFrame, name, connected, lineID, relativeFrame, buttonSet)
	listFrame.NAME = name;
	listFrame.connected = connected;
	listFrame.lineID = lineID;
	if(relativeFrame) then buttonSet = relativeFrame.buttonSet; end
	if(not buttonSet) then buttonSet = "NORMAL"; end;
	listFrame.buttonSet = buttonSet;
	FriendsMenu_Initialize(listFrame, buttonSet);
	if(not relativeFrame) then PlaySound("igMainMenuOpen"); end --open at last place should not play sound.

	-- Set the dropdownframe scale
	local uiScale = 1.0;
	if ( GetCVar("useUiScale") == "1" ) then
		uiScale = tonumber(GetCVar("uiscale"));
	end
	listFrame:SetScale(uiScale);
	
	-- Hide the listframe anyways since it is redrawn OnShow() 
	listFrame:Hide();
	listFrame:ClearAllPoints();

	if(relativeFrame) then
		listFrame:SetPoint(relativeFrame:GetPoint(1));
		listFrame:Show();
		return;
	end

	local cursorX, cursorY = GetCursorPosition();
	cursorX = cursorX/uiScale;
	cursorY = cursorY/uiScale
	listFrame:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", cursorX, cursorY);
	
	-- If no items in the drop down don't show it
	if ( listFrame.numButtons == 0 ) then
		return;
	end

	-- Check to see if the dropdownlist is off the screen, if it is anchor it to the top of the dropdown button
	listFrame:Show();
	-- Hack since GetCenter() is returning coords relative to 1024x768
	local x, y = listFrame:GetCenter();
	-- Hack will fix this in next revision of dropdowns
	if ( not x or not y ) then
		listFrame:Hide();
		return;
	end
	-- Determine whether the menu is off the screen or not
	local offscreenY, offscreenX;
	if ( (y - listFrame:GetHeight()/2) < 0 ) then
		offscreenY = 1;
	end
	if ( listFrame:GetRight() > GetScreenWidth() ) then
		offscreenX = 1;	
	end
	
	if ( offscreenY and offscreenX ) then
		anchorPoint = "BOTTOMRIGHT";
	elseif ( offscreenY ) then
		anchorPoint = "BOTTOMLEFT";
	elseif ( offscreenX ) then
		anchorPoint = "TOPRIGHT";
	else
		anchorPoint = "TOPLEFT";
	end
	
	listFrame:ClearAllPoints();
	listFrame:SetPoint(anchorPoint, nil, "BOTTOMLEFT", cursorX, cursorY);
end

function FriendsMenu_Initialize(dropDownList, buttonSet)
	-- Hide all the buttons
	local button;
	dropDownList.numButtons = 0;
	dropDownList.maxWidth = 0;
	for j=1, FRIENDSMENU_MAXBUTTONS, 1 do
		button = getglobal(dropDownList:GetName().."Button"..j);
		button:Hide();
	end
	dropDownList:Hide();

	-- Add dropdown title
	local info = PlayerLink_CreateInfo();
	info.text = dropDownList.NAME;
	info.isTitle = 1;
	PlayerLink_AddButton(dropDownList, info);

	for _, v in pairs(PlayerLink_ButtonSet[buttonSet]) do
		info = PlayerLink_Buttons[v];
		if(not info.show or info.show(dropDownList.NAME, dropDownList.connected, dropDownList.lineID)) then
			if(not info.isSecure or strfind(dropDownList:GetName(), "Secure")) then
				PlayerLink_AddButton(dropDownList, info);
			end
		end
	end
end

function PlayerLink_AddButton(listFrame, info)
	
	local listFrameName = listFrame:GetName();
	local index = listFrame.numButtons + 1;
	local width;

	-- Set the number of buttons in the listframe
	listFrame.numButtons = index;
	
	local button = getglobal(listFrameName.."Button"..index);
	if(not button) then return end;
	local normalText = getglobal(button:GetName().."NormalText");
	local icon = getglobal(button:GetName().."Icon");
	-- This button is used to capture the mouse OnEnter/OnLeave events if the dropdown button is disabled, since a disabled button doesn't receive any events
	-- This is used specifically for drop down menu time outs
	local invisibleButton = getglobal(button:GetName().."InvisibleButton");
	
	-- Default settings
	button:SetDisabledFontObject(GameFontDisableSmall);
	invisibleButton:Hide();
	button:Enable();
	
	-- Configure button
	if ( info.text ) then
		button:SetText(info.text);

		if ( info.textHeight ) then
			button:SetNormalFontObject(GameFontNormalSmall, info.textHeight);
		else
			button:SetNormalFontObject(GameFontNormalSmall, UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT);
		end

		-- Determine the width of the button
		width = normalText:GetWidth() + 30; --no arrow, colorSwatch, check
		-- Set icon
		if ( info.icon ) then
			icon:SetTexture(info.icon);
			if ( info.tCoordLeft ) then
				icon:SetTexCoord(info.tCoordLeft, info.tCoordRight, info.tCoordTop, info.tCoordBottom);
			end
			icon:Show();
			-- Add padding for the icon
			width = width + 10;
		else
			icon:Hide();
		end
		-- Set maximum button width
		if ( width > listFrame.maxWidth ) then
			listFrame.maxWidth = width;
		end
		-- If a textR is set then set the vertex color of the button text
		
		if ( info.textR ) then
			button:SetNormalFontObject(GameFontNormalSmall);
			button:SetHighlightFontObject(GameFontNormalSmall);
		else
			button:SetNormalFontObject(GameFontHighlightSmall);
			button:SetHighlightFontObject(GameFontHighlightSmall);
		end
		
	else
		button:SetText("");
	end

	-- Pass through attributes
	button.func = info.func;
	button.tooltipText = info.tooltipText;

	-- If not checkable move everything over to the left to fill in the gap where the check would be
	local xPos = 5;
	local yPos = -((button:GetID() - 1) * UIDROPDOWNMENU_BUTTON_HEIGHT) - UIDROPDOWNMENU_BORDER_HEIGHT;
	normalText:ClearAllPoints();
	if ( info.justifyH and info.justifyH == "CENTER" ) then
		normalText:SetPoint("CENTER", button, "CENTER", -7, 0);
	else
		normalText:SetPoint("LEFT", button, "LEFT", 0, 0);
	end
	xPos = xPos + 10;

	button:SetPoint("TOPLEFT", button:GetParent(), "TOPLEFT", xPos, yPos);

	button:UnlockHighlight();

	-- If not clickable then disable the button and set it white
	if ( info.notClickable ) then
		info.disabled = 1;
		button:SetDisabledFontObject(GameFontDisableSmall);
	end

	-- Set the text color and disable it if its a title
	if ( info.isTitle ) then
		info.disabled = 1;
		button:SetDisabledFontObject(GameFontDisableSmall);
	end
	
	-- Disable the button if disabled
	if ( info.disabled ) then
		button:Disable();
		invisibleButton:Show();
	end

	-- Set the height of the listframe
	listFrame:SetHeight((index * UIDROPDOWNMENU_BUTTON_HEIGHT) + (UIDROPDOWNMENU_BORDER_HEIGHT * 2));

	if(button.attributes and button.attributes~="") then
		local attribs = {strsplit(";",button.attributes)};
		for _,v in pairs(attribs) do
			if(v and v~="") then
				button:SetAttribute(v, nil);
			end
		end
	end
	button.attributes = "";
	if(info.isSecure and info.attributes) then
		local attribs = gsub(info.attributes,"%$name%$", listFrame.NAME);
		local aaa = {strsplit(";", attribs)};
		for k,v in pairs(aaa) do
			if(v and v~="") then
				local att,val = strsplit(":",v); 
				if(att and att~="" and val and val~="") then
					button:SetAttribute(strtrim(att), strtrim(val));
					button.attributes = button.attributes..strtrim(att)..";";
				end
			end
		end
	end

	button:Show();
end

local PlayerLink_ButtonInfo = {};

function PlayerLink_CreateInfo()
	-- Reuse the same table to prevent memory churn
	local info = PlayerLink_ButtonInfo;
	for k,v in pairs(info) do
		info[k] = nil;
	end
	return PlayerLink_ButtonInfo;
end






--  <========================================>
-- ButtonSet
--[[
	text,			--按钮名称
	textHeight,		--按钮字体大小
	icon,			--按钮图片路径
	tCoordLeft, tCoordRight, tCoordTop, tCoordBottom,	--按钮图片的相对部分
	textR, textG, textB,	--按钮文字顔色
	tooltipText,		--提示信息
	show,			--判断是否显示该按钮的函数
	func,			--点击按钮所进行的操作
	notClickable,		--不可点击(灰色按钮)
	justifyH,		--文字对其方式, LEFT或CENTER
	isSecure,		--是否是安全按钮
	attributes,		--安全按钮的属性, 格式为"属性1:值1; 属性2:值2"
]]

--{ "WHISPER", "INVITE", "TARGET", "IGNORE", "REPORT_SPAM", "GUILD_PROMOTE", "GUILD_LEAVE", "CANCEL" };
function NoSelfShow(name) return UnitName("player")~=name; end

PlayerLink_Buttons = {};

PlayerLink_Buttons["WHISPER"] = {
	text = WHISPER,
	func = function(name) ChatFrame_SendTell(name); end,
	--show = NoSelfShow,
};

PlayerLink_Buttons["INVITE"] = {
	text = PARTY_INVITE,
	func = function(name) InviteUnit(name); end,
	show = NoSelfShow,
};

PlayerLink_Buttons["TARGET"] = {
	text = TARGET,
	isSecure = 1,
	attributes = "type: macro;    macrotext: /targetexact $name$",
	func = function(name)
		if(UnitName("target")~=name) then 
			DEFAULT_CHAT_FRAME:AddMessage("无法选定<"..name..">为目标。",1,1,0); 
		end
	end,
};

PlayerLink_Buttons["IGNORE"] = {
	text = IGNORE,
	func = function(name) AddOrDelIgnore(name); end,
	--show = NoSelfShow,
};

PlayerLink_Buttons["REPORT_SPAM"] = {
	text = REPORT_SPAM,
	func = function(name,connected,lineID) 
		local dialog = StaticPopup_Show("CONFIRM_REPORT_SPAM_CHAT", name);
		if ( dialog ) then
			dialog.data = lineID;
		end
	end,
	show = function(name, connected, lineID) return lineID and CanComplainChat(lineID) end,
};

PlayerLink_Buttons["CANCEL"] = {
	text = CANCEL,
};

PlayerLink_Buttons["ADD_FRIEND"] = {
	text = ADD_FRIEND,
	func = function (name) AddFriend(name); end,
	show = function(name)
		if(name == UnitName("player")) then return end;
		for i = 1, GetNumFriends() do
			if(name == GetFriendInfo(i)) then
				return nil;
			end
		end
		return 1;
	end,
}

PlayerLink_Buttons["SEND_WHO"] = {
	text = WHO,
	func = function (name) SendWho("n-"..name); end,
}

PlayerLink_Buttons["ADD_GUILD"] = {
	text = GUILDCONTROL_OPTION7,
	func = function (name) GuildInvite(name); end,
	show = function (name) return name~=UnitName("player") and CanGuildInvite() end,
}

PlayerLink_Buttons["GET_NAME"] = {
	text = COPY_NAME,
	func = function (name) 
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:Insert(name);
		elseif( SendMailNameEditBox and SendMailNameEditBox:IsVisible() ) then
			SendMailNameEditBox:Insert(name);
		elseif( CT_MailNameEditBox and CT_MailNameEditBox:IsVisible() ) then
			CT_MailNameEditBox:Insert(name);
		else
			DEFAULT_CHAT_FRAME.editBox:Hide();
			DEFAULT_CHAT_FRAME.editBox.chatType = "SAY";
			ChatEdit_UpdateHeader(DEFAULT_CHAT_FRAME.editBox);
			if (not DEFAULT_CHAT_FRAME.editBox:IsVisible()) then
				ChatFrame_OpenChat(DEFAULT_CHAT_FRAME.editBox:GetText()..name, DEFAULT_CHAT_FRAME);
			end
		end
	end,
}

PlayerLink_Buttons["TRADE"] = {
	text = TRADE,
	isSecure = 1,
	attributes = "type:macro;macrotext:/target $name$",
	func = function (name) InitiateTrade("target"); end,
}

PlayerLink_Buttons["MAGE1_BUFF"] = {
	text = SPELL_ARCANEINTELLECT,
	textHeight = 12,
	justifyH = "CENTER",
	isSecure = 1,
	icon = "Interface\\Icons\\Spell_Holy_MagicalSentry" ,
	attributes = "type: macro; macrotext: /target $name$\n/cast "..SPELL_ARCANEINTELLECT.."\n/targetlasttarget" ,
	show = function() local _, class = UnitClass("player"); if(class == CLASS_MAGE and IsUsableSpell(SPELL_ARCANEINTELLECT)) then return 1 end end ,
};
PlayerLink_Buttons["MAGE2_BUFF"] = {
	text = SPELL_DAMPENMAGIC,
	textHeight = 12,
	justifyH = "CENTER",
	isSecure = 1,
	icon = "Interface\\Icons\\Spell_Nature_AbolishMagic" ,
	attributes = "type: macro; macrotext: /target $name$\n/cast "..SPELL_DAMPENMAGIC.."\n/targetlasttarget" ,
	show = function() local _, class = UnitClass("player"); if(class == CLASS_MAGE and IsUsableSpell(SPELL_DAMPENMAGIC)) then return 1 end end ,
};
PlayerLink_Buttons["MAGE3_BUFF"] = {
	text = SPELL_AMPLIFYMAGIC,
	textHeight = 12,
	justifyH = "CENTER",
	isSecure = 1,
	icon = "Interface\\Icons\\Spell_Holy_FlashHeal" ,
	attributes = "type: macro; macrotext: /target $name$\n/cast "..SPELL_AMPLIFYMAGIC.."\n/targetlasttarget" ,
	show = function() local _, class = UnitClass("player"); if(class == CLASS_MAGE and IsUsableSpell(SPELL_AMPLIFYMAGIC)) then return 1 end end ,
};
PlayerLink_Buttons["PRIE1_BUFF"] = {
	text = SPELL_FORTITUDE,
	textHeight = 12,
	justifyH = "CENTER",
	isSecure = 1,
	icon = "Interface\\Icons\\Spell_Holy_WordFortitude" ,
	attributes = "type: macro; macrotext: /target $name$\n/cast "..SPELL_FORTITUDE.."\n/targetlasttarget" ,
	show = function() local _, class = UnitClass("player"); if(class == CLASS_PRIEST and IsUsableSpell(SPELL_FORTITUDE)) then return 1 end end ,
};
PlayerLink_Buttons["PRIE2_BUFF"] = {
	text = SPELL_HOLYPROTECTION,
	textHeight = 12,
	justifyH = "CENTER",
	isSecure = 1,
	icon = "Interface\\Icons\\Spell_Holy_HolyProtection" ,
	attributes = "type: macro; macrotext: /target $name$\n/cast "..SPELL_HOLYPROTECTION.."\n/targetlasttarget" ,
	show = function() local _, class = UnitClass("player"); if(class == CLASS_PRIEST and IsUsableSpell(SPELL_HOLYPROTECTION)) then return 1 end end ,
};
PlayerLink_Buttons["PRIE3_BUFF"] = {
	text = SPELL_SHADOWPROTECTION,
	textHeight = 12,
	justifyH = "CENTER",
	isSecure = 1,
	icon = "Interface\\Icons\\Spell_Shadow_AntiShadow" ,
	attributes = "type: macro; macrotext: /target $name$\n/cast "..SPELL_SHADOWPROTECTION.."\n/targetlasttarget" ,
	show = function() local _, class = UnitClass("player"); if(class == CLASS_PRIEST and IsUsableSpell(SPELL_SHADOWPROTECTION)) then return 1 end end ,
};
PlayerLink_Buttons["DRUI1_BUFF"] = {
	text = SPELL_MARKOFTHEWILD,
	textHeight = 12,
	justifyH = "CENTER",
	isSecure = 1,
	icon = "Interface\\Icons\\Spell_Nature_Regeneration" ,
	attributes = "type: macro; macrotext: /target $name$\n/cast "..SPELL_MARKOFTHEWILD.."\n/targetlasttarget" ,
	show = function() local _, class = UnitClass("player"); if(class == CLASS_DRUID and IsUsableSpell(SPELL_MARKOFTHEWILD)) then return 1 end end ,
};
PlayerLink_Buttons["DRUI2_BUFF"] = {
	text = SPELL_THORNS,
	textHeight = 12,
	justifyH = "CENTER",
	isSecure = 1,
	icon = "Interface\\Icons\\Spell_Nature_Thorns" ,
	attributes = "type: macro; macrotext: /target $name$\n/cast "..SPELL_THORNS.."\n/targetlasttarget" ,
	show = function() local _, class = UnitClass("player"); if(class == CLASS_DRUID and IsUsableSpell(SPELL_THORNS)) then return 1 end end ,
};
PlayerLink_Buttons["PALA1_BUFF"] = {
	text = SPELL_BLESSINGOFWISDOM,
	textHeight = 12,
	justifyH = "CENTER",
	isSecure = 1,
	icon = "Interface\\Icons\\Spell_Holy_SealOfWisdom" ,
	attributes = "type: macro; macrotext: /target $name$\n/cast "..SPELL_BLESSINGOFWISDOM.."\n/targetlasttarget" ,
	show = function() local _, class = UnitClass("player"); if(class == CLASS_PALADIN and IsUsableSpell(SPELL_BLESSINGOFWISDOM)) then return 1 end end ,
};
PlayerLink_Buttons["PALA2_BUFF"] = {
	text = SPELL_BLESSINGOFMIGHT,
	textHeight = 12,
	justifyH = "CENTER",
	isSecure = 1,
	icon = "Interface\\Icons\\Spell_Holy_FistOfJustice" ,
	attributes = "type: macro; macrotext: /target $name$\n/cast "..SPELL_BLESSINGOFMIGHT.."\n/targetlasttarget" ,
	show = function() local _, class = UnitClass("player"); if(class == CLASS_PALADIN and IsUsableSpell(SPELL_BLESSINGOFMIGHT)) then return 1 end end ,
};
PlayerLink_Buttons["PALA3_BUFF"] = {
	text = SPELL_BLESSINGOFKINGS,
	textHeight = 12,
	justifyH = "CENTER",
	isSecure = 1,
	icon = "Interface\\Icons\\Spell_Magic_MageArmor" ,
	attributes = "type: macro; macrotext: /target $name$\n/cast "..SPELL_BLESSINGOFKINGS.."\n/targetlasttarget" ,
	show = function() local _, class = UnitClass("player"); if(class == CLASS_PALADIN and IsUsableSpell(SPELL_BLESSINGOFKINGS)) then return 1 end end ,
};
PlayerLink_Buttons["PALA4_BUFF"] = {
	text = SPELL_BLESSINGOFLIGHT,
	textHeight = 12,
	justifyH = "CENTER",
	isSecure = 1,
	icon = "Interface\\Icons\\Spell_Holy_GreaterBlessingofLight" ,
	attributes = "type: macro; macrotext: /target $name$\n/cast "..SPELL_BLESSINGOFLIGHT.."\n/targetlasttarget" ,
	show = function() local _, class = UnitClass("player"); if(class == CLASS_PALADIN and IsUsableSpell(SPELL_BLESSINGOFLIGHT)) then return 1 end end ,
};
PlayerLink_Buttons["PALA5_BUFF"] = {
	text = SPELL_BLESSINGOFSALVATION,
	textHeight = 12,
	justifyH = "CENTER",
	isSecure = 1,
	icon = "Interface\\Icons\\Spell_Holy_SealOfSalvation" ,
	attributes = "type: macro; macrotext: /target $name$\n/cast "..SPELL_BLESSINGOFSALVATION.."\n/targetlasttarget" ,
	show = function() local _, class = UnitClass("player"); if(class == CLASS_PALADIN and IsUsableSpell(SPELL_BLESSINGOFSALVATION)) then return 1 end end ,
};
PlayerLink_Buttons["WARL1_BUFF"] = {
	text = SPELL_DETECTINVISIBILITY,
	textHeight = 12,
	justifyH = "CENTER",
	isSecure = 1,
	icon = "Interface\\Icons\\Spell_Shadow_DetectLesserInvisibility" ,
	attributes = "type: macro; macrotext: /target $name$\n/cast "..SPELL_DETECTINVISIBILITY.."\n/targetlasttarget" ,
	show = function() local _, class = UnitClass("player"); if(class == CLASS_WARLOCK and IsUsableSpell(SPELL_DETECTINVISIBILITY)) then return 1 end end ,
};
PlayerLink_Buttons["WARL2_BUFF"] = {
	text = SPELL_RITUALOFSUMMONING,
	textHeight = 12,
	justifyH = "CENTER",
	isSecure = 1,
	icon = "Interface\\Icons\\Spell_Shadow_Twilight" ,
	attributes = "type: macro; macrotext: /target $name$\n/cast "..SPELL_RITUALOFSUMMONING.."\n/targetlasttarget" ,
	show = function() local _, class = UnitClass("player"); if(class == CLASS_WARLOCK and IsUsableSpell(SPELL_RITUALOFSUMMONING)) then return 1 end end ,
};

PlayerLink_Buttons["DKPTABLE"] = {
	text = "DKP",
	func = function(name) DKPT_AddFilter(name); end,
	show = function() if(DKPT_Main_Frame) then return 1 end end,
};

PlayerLink_ButtonSet = {};
PlayerLink_ButtonSet["NORMAL"] = {
	"WHISPER", 
	"INVITE",
	"TARGET",
	"IGNORE",
	"REPORT_SPAM",
	"ADD_FRIEND",
	"SEND_WHO",
	"ADD_GUILD",
	"GET_NAME",
	"TRADE",
	"MAGE1_BUFF",
	"MAGE2_BUFF",
	"MAGE3_BUFF",
	"PRIE1_BUFF",
	"PRIE2_BUFF",
	"PRIE3_BUFF",
	"DRUI1_BUFF",
	"DRUI2_BUFF",
	"PALA1_BUFF",
	"PALA2_BUFF",
	"PALA3_BUFF",
	"PALA4_BUFF",
	"PALA5_BUFF",
	"WARL1_BUFF",
	"WARL2_BUFF",
	"CANCEL", 
}
--[[
PlayerLink_ButtonSet["RAID"] = { 
	"WHISPER", 
	"TARGET", 
	"SEND_WHO", 
	"GET_NAME", 
	"TRADE", 
	"MAGE1_BUFF",
	"MAGE2_BUFF",
	"MAGE3_BUFF",
	"PRIE1_BUFF",
	"PRIE2_BUFF",
	"PRIE3_BUFF",
	"DRUI1_BUFF",
	"DRUI2_BUFF",
	"PALA1_BUFF",
	"PALA2_BUFF",
	"PALA3_BUFF",
	"PALA4_BUFF",
	"PALA5_BUFF",
	"WARL1_BUFF",
	"WARL2_BUFF",
	"DKPTABLE", 
	"CANCEL", 
}
]]