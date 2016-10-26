GLIMBUTTONLIST = {};
GLIMCONFIGFRAME_PAGESIZE = 14;
GLIMCONFIGFRAME_MAXPRIORITYSIZE = 10;
GLIMCONFIGFRAME_MAXRIGHTCOUNT = 4;
gLimConfigCurPage = 1;
local DefaultConfig = { ["First"] = 0,
				  ["ShowIcon"] = 1,
				  ["ChatTime"] = 0,
				  ["FixBug"] = 1,
				  ["ColorWhoISList"] = 0,
				  ["ColorGuildList"] = 0,
				  ["ColorFriendsList"] = 0,
				  ["ButtonRadius"] = 78,
				  ["ButtonPosition"] = 325,
				  ["Version"] = GetAddOnMetadata("gLimMod", "Version")
}
function gLim_OnLoad()
 this:RegisterEvent("VARIABLES_LOADED");
 tinsert(UISpecialFrames, "gLimConfigFrame");
 DEFAULT_CHAT_FRAME:AddMessage(GetAddOnMetadata("gLimMod", "Title").." |cFFFF9900"..GetAddOnMetadata("gLimMod", "Version").."|r : "..GetAddOnMetadata("gLimMod", "X-Website"))
end
function gLimModMaster_OnEvent()
if( event == "VARIABLES_LOADED" ) then
 gLimModMaster_LoadConfig();
 if ( not CubeConfig.First or CubeConfig.First == 0 ) then
 StaticPopup_Show("FIRST_TIME");
 end 
 if ( CubeConfig.Version < GetAddOnMetadata("gLimMod", "Version") ) then
	CubeConfig.Version = GetAddOnMetadata("gLimMod", "Version")
 end
 end
 CubeButton_UpdatePosition();
 end
function gLimModMaster_LoadConfig()
if ( not CubeConfig ) then
 CubeConfig = DefaultConfig;
 end;
 gLim_Register();
 end;
 function fillGliModButton(id) 
 if id == 99 then
 GLIMBUTTONLIST = {};
GLIMTEMPBUTTONLIST = {};
GLIMTEMPBUTTONLIST = gLimButton;
TotalButtonNum = #(GLIMTEMPBUTTONLIST);
for lvl = 1, GLIMCONFIGFRAME_MAXPRIORITYSIZE, 1 do 
for i = 1,TotalButtonNum,1 do 
local localtempbuttonvalue = {};
localtempbuttonvalue = GLIMTEMPBUTTONLIST[i];
if localtempbuttonvalue[GLIM_PRIORITY] == lvl then
 tinsert(GLIMBUTTONLIST,localtempbuttonvalue);
end;
end;
end;
gLimConfigTitleText:SetText(TEXT(GLIM_CONFIG_TOTALTITLE));
else getCurTypeButtonList(id);
end
if id == 1 then
 gLimConfigTitleText:SetText(GLIM_CONFIG_TITLE1);
elseif id == 2 then
 gLimConfigTitleText:SetText(GLIM_CONFIG_TITLE2);
elseif id == 3 then
 gLimConfigTitleText:SetText(GLIM_CONFIG_TITLE3);
elseif id == 4 then
 gLimConfigTitleText:SetText(GLIM_CONFIG_TITLE4);
end;
gLimConfigCurPage = 1;
 end;
function getCurTypeButtonList(id)
local TotalButtonNum = #(gLimButton);
GLIMTEMPBUTTONLIST = {};
GLIMBUTTONLIST = {};
for i = 1, TotalButtonNum, 1 do local localbuttonvalue = {};
localbuttonvalue = gLimButton[i];
if localbuttonvalue[GLIM_TYPE] == id then
 tinsert(GLIMTEMPBUTTONLIST,localbuttonvalue);
 end;
 end;
TotalButtonNum = #(GLIMTEMPBUTTONLIST);
for lvl = 1, GLIMCONFIGFRAME_MAXPRIORITYSIZE, 1 do
for i = 1,TotalButtonNum,1 do
local localtempbuttonvalue = {};
localtempbuttonvalue = GLIMTEMPBUTTONLIST[i];
if localtempbuttonvalue[GLIM_PRIORITY] == lvl then
 tinsert(GLIMBUTTONLIST,localtempbuttonvalue);
 end;
 end;
 end;
 end;
function gLimButton_UpdateButton() 
local gLimConfigFramePageNum = getglobal("gLimConfigFramePageNum");
 if (gLimConfigFramePageNum ~= nil) then
 gLimConfigFramePageNum:SetText("");
 gLimConfigFramePageNum:Hide();
 end;
 for i = 1, GLIMCONFIGFRAME_PAGESIZE, 1 do 
 local icon = getglobal("gLimConfigButton"..i);
 local iconTexture = getglobal("gLimConfigButton"..i.."IconTexture");
 icon:Hide();
 iconTexture:Hide();
 end local Cur_ButtonNum = #(GLIMBUTTONLIST);
 gLimConfigPageTotal = math.ceil( Cur_ButtonNum / GLIMCONFIGFRAME_PAGESIZE );
 if (gLimConfigPageTotal == 0) then
 gLimConfigPageTotal = 1;
 end gLimConfigCurPageCount = math.ceil( Cur_ButtonNum/GLIMCONFIGFRAME_PAGESIZE );
 if( gLimConfigCurPageCount == 0 and Cur_ButtonNum ~= 0)then 
 gLimConfigCurPageCount = GLIMCONFIGFRAME_PAGESIZE;
 else
 gLimConfigCurPageCount = Cur_ButtonNum - ((gLimConfigCurPage-1) * GLIMCONFIGFRAME_PAGESIZE);
 if (gLimConfigCurPageCount > GLIMCONFIGFRAME_PAGESIZE) then
 gLimConfigCurPageCount = GLIMCONFIGFRAME_PAGESIZE;
 end end for i = 1, gLimConfigCurPageCount, 1 do
 local icon = getglobal("gLimConfigButton"..i);
 local iconTexture = getglobal("gLimConfigButton"..i.."IconTexture");
 local name = getglobal("gLimConfigName"..i);
 local id = (gLimConfigCurPage-1)*GLIMCONFIGFRAME_PAGESIZE+i;
 local value = {};
 value = GLIMBUTTONLIST[id];
 icon:Show();
 icon:Enable();
 iconTexture:Show();
 iconTexture:SetTexture(value[GLIM_ICON]);
 name:SetText(value[GLIM_NAME]);
 end
if (gLimConfigFramePageNum ~= nil) then
 gLimConfigFramePageNum:SetText(GLIM_CONFIGPAGE_THE.." "..gLimConfigCurPage.." "..GLIM_CONFIGPAGE_PAGE);
 gLimConfigFramePageNum:Show();
 end;
 gLimConfigFrame_UpdatePageArrows();
end;
function gLimConfigFrame_UpdatePageArrows() if ((gLimConfigCurPage < gLimConfigPageTotal) and (gLimConfigCurPage>1) ) then
 gLimConfigFramePrevPageButton:Enable();
gLimConfigFrameNextPageButton:Enable();
end
if ((gLimConfigCurPage < gLimConfigPageTotal) and (gLimConfigCurPage==1) ) then
 gLimConfigFramePrevPageButton:Disable();
gLimConfigFrameNextPageButton:Enable();
end
if ((gLimConfigCurPage == gLimConfigPageTotal) and (gLimConfigCurPage>1) ) then
 gLimConfigFramePrevPageButton:Enable();
gLimConfigFrameNextPageButton:Disable();
end
if ((gLimConfigCurPage == gLimConfigPageTotal) and (gLimConfigCurPage==1) ) then
 gLimConfigFramePrevPageButton:Disable();
gLimConfigFrameNextPageButton:Disable();
end end
function gLimConfigFrame_PrevPageButton_OnClick()
gLimConfigCurPage = gLimConfigCurPage - 1;
gLimButton_UpdateButton();
end
function gLimConfigFrame_NextPageButton_OnClick()
gLimConfigCurPage = gLimConfigCurPage + 1;
gLimButton_UpdateButton();
end
function gLimButton_OnClick()
gLimModMaster_OnOkayClick()
local value = GLIMBUTTONLIST[this:GetID()+(gLimConfigCurPage-1)*GLIMCONFIGFRAME_PAGESIZE];
if (value) then
 local f = value[GLIM_CALLBACK];
this:SetChecked(0);
f();
return;
end end
function gLimButton_OnEnter()
local value = GLIMBUTTONLIST[this:GetID()+(gLimConfigCurPage-1)*GLIMCONFIGFRAME_PAGESIZE];
if (value) then
 GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
GameTooltip:SetText(value[GLIM_LONGDESCRIPTION], 1.0, 1.0, 1.0);
return;
end
end
function Toggle_gLimConfigFrame() 
	if (gLimConfigFrame and gLimConfigFrame:IsVisible()) then
		HideUIPanel(gLimConfigFrame);
	else
		ShowUIPanel(gLimConfigFrame);
		gLimConfigFrame:SetPoint("TopLeft", "UIParent", "BottomLeft", 0, GetScreenHeight()/2+300);
	end
end
function gLimButton_OnHide()
UpdateMicroButtons();
end
function gLimButton_OnShow()
fillGliModButton(99);
gLimButton_UpdateButton();
UpdateMicroButtons();
PlaySound("igSpellBookOpen");
gLimConfigTitleText:SetText(GLIM_CONFIG_TOTALTITLE);
gLimRightButtonSetCheck(99);
end
function gLimBookButtonLineTab_OnClick(id)
local id = this:GetID();
fillGliModButton(id);
gLimButton_UpdateButton();
UpdateMicroButtons();
gLimRightButtonSetCheck(id);
end;
 function gLimRightButtonSetCheck(id)
 local gLimRightButtonID = getglobal("gLimConfigLineTab"..99);
gLimRightButtonID:SetChecked(nil);
if id == 99 then
 gLimRightButtonID:SetChecked(1);
end for i = 1,GLIMCONFIGFRAME_MAXRIGHTCOUNT,1 do
gLimRightButtonID = getglobal("gLimConfigLineTab"..i);
gLimRightButtonID:SetChecked(nil);
if (i == id)then gLimRightButtonID:SetChecked(1);
end end end;
 function gLimBookRightButtonToolTip(id) 
 GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
local id = this:GetID();
local TabTooltip;
if id == 99 then
 TabTooltip = GLIM_CONFIG_TOOLTIP_TOTALTITLE;
elseif id == 1 then
 TabTooltip = GLIM_CONFIG_TOOLTIP_TITLE1;
elseif id == 2 then
 TabTooltip = GLIM_CONFIG_TOOLTIP_TITLE2;
elseif id == 3 then
 TabTooltip = GLIM_CONFIG_TOOLTIP_TITLE3;
elseif id == 4 then
 TabTooltip = GLIM_CONFIG_TOOLTIP_TITLE4;
end;
GameTooltip:SetText(TabTooltip);
end;

 function CubeButton_UpdatePosition()
 if (CubeConfig.ButtonRadius == nil) then
 CubeConfig.ButtonRadius = 78;
 end
if (CubeConfig.ButtonPosition == nil) then
 CubeConfig.ButtonPosition = 325;
 end gLimMinimapFrame:SetPoint( "TOPLEFT", "Minimap", "TOPLEFT", 54 - CubeConfig.ButtonRadius * cos(CubeConfig.ButtonPosition), CubeConfig.ButtonRadius * sin(CubeConfig.ButtonPosition) - 55);
 end
function CubeButton_BeingDragged() local xpos,ypos = GetCursorPosition() local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom() xpos = xmin-xpos/UIParent:GetScale()+70 ypos = ypos/UIParent:GetScale()-ymin-70 CubeButton_SetPosition(math.deg(math.atan2(ypos,xpos)));
end
local function tempgLimModMaster_SetCubeIconNewConfig(value)	 
	 local gLimModNow_SetingCount = #(gLim_Configurations) 
	 for i = 1 ,gLimModNow_SetingCount,1 do 
		if (gLim_Configurations[i][GLIM_VARIABLE] == "gLimSysConfig") then 
			local TempLocalPositionTable = gLim_Configurations[i][GLIM_VARIABLES]
			local NewConfigCount = #(TempLocalPositionTable) 
			for nIndex = 1 ,NewConfigCount ,1 do
				if (TempLocalPositionTable[nIndex][GLIM_VARIABLE] == "gLimIconPosition") then
					TempLocalPositionTable[nIndex][GLIM_DEFAULTVALUE] = value
					return
				end
			end
		end 
	 end 
 end 
function CubeButton_SetPosition(v)
	if(v < 0) then v = v + 360; end
	 v = tonumber(format("%.f",v))
	 CubeConfig.ButtonPosition = v;
	 tempgLimModMaster_SetCubeIconNewConfig(v)
	 CubeButton_UpdatePosition();
 end