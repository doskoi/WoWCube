--[[
    -- Screenshot
    -- Create it by pigbaby belong to gLim group
    -- Version: 1.1
]]

ScreenShot = { };
ScreenShot_Enable = 1;
ScreenShot_Sign = 1;

local lOriginalTakeScreenshot;
local lOrigianlScreenshotStatus_OnEvent;

local oldUnitNameRenderMode;
local oldUIstatus = 0;


function Screenshot_OnLoad()
  this:RegisterEvent("VARIABLES_LOADED");

  -- Hook the new function instead of the original.
  lOriginalTakeScreenshot = TakeScreenshot;
  TakeScreenshot = Screenshot_TakeScreenshot;

  lOrigianlScreenshotStatus_OnEvent = ScreenshotStatus_OnEvent;
  ScreenshotStatus_OnEvent = ScreensShot_OnEvent;
end

function Screenshot_TakeScreenshot()
	if ( ScreenShot_Sign == 1 ) then		
		if ( not ScreenshotSignFrame:IsVisible() ) then
			ScreenshotSignFrame:Show();
		end
	end
	if ( ScreenShot_Enable == 1 and IsShiftKeyDown() ) then
		RegisterCVar("UnitNameRenderMode");
		oldUnitNameRenderMode = GetCVar("UnitNameRenderMode");
		SetCVar("UnitNameRenderMode", "0");
		if ( UIParent:IsVisible() ) then
			oldUIstatus = 1;
		else
			oldUIstatus = 0;
		end
		CloseAllWindows();
		UIParent:Hide();
	end
	lOriginalTakeScreenshot();
end

function ScreensShot_OnEvent(event)
	lOrigianlScreenshotStatus_OnEvent(event);
	ScreenshotSignFrame:Hide();

	if ( ScreenShot_Enable and IsShiftKeyDown() ) then
		RegisterCVar("UnitNameRenderMode");
		SetCVar("UnitNameRenderMode", oldUnitNameRenderMode);
	end

	if ( oldUIstatus == 1 ) then
		UIParent:Show();
		oldUIstatus = 0;
	end
end

function Screenshot_OnEvent(event)
	if( event == "VARIABLES_LOADED" ) then
		ScreensShot_LoadConfig();
	end
end
--  note: add for save variables and register to gLimMod
function ScreensShot_LoadConfig()
	if( not ScreenShot ) then
		ScreenShot = { };
	end

	if ( ScreenShot.Enable == nil ) then
		ScreenShot.Enable = 1;
	end
	if ( ScreenShot.Sign == nil ) then
		ScreenShot.Sign = 1;
	end

	ScreenShot_Enable = ScreenShot.Enable;
	ScreenShot_Sign = ScreenShot.Sign;
	ScreensShot_Register();
end

function ScreensShot_Register()
  if ( gLim_RegisterButton ) then
  gLim_RegisterButton (
	SCREENSHOT_TITLE,	
	SCREENSHOT_OPTION,
	"Interface\\Icons\\Ability_Hunter_GoForTheThroat",
	function()
		gLimModSecBookShowConfig("gLimScreensShot");
	end,
	1,
	7
	);

  gLim_RegisterConfigClass(
	"gLimScreensShot",
	"Screens Shot",
	"Bryan"
	);
  gLim_RegisterConfigSection(
	"gLimScreensSection",
	SCREENSHOT_CONFIG_HEADER,
	SCREENSHOT_CONFIG_HEADER,
	"Bryan",
	"gLimScreensShot"
	);
  gLim_RegisterConfigCheckBox(
	"gLim_ScreenShot_Enable",
	SCREENSHOT_CONFIG_ENABLE,
	SCREENSHOT_CONFIG_ENABLE_INFO,
	ScreenShot_Enable,
	Enable_OnOff,
	"gLimScreensShot"
	);
  gLim_RegisterConfigCheckBox(
	"gLim_ScreenShot_Sign",
	SCREENSHOT_CONFIG_SIGN,
	SCREENSHOT_CONFIG_SIGN_INFO,
	ScreenShot_Sign,
	Sign_OnOff,
	"gLimScreensShot"
	);
end
end

function Enable_OnOff(toggle)
	if ( toggle == 1) then
		ScreenShot_Enable = 1;
		ScreenShot.Enable = 1;
		--to do
	else
		ScreenShot_Enable = 0;
		ScreenShot.Enable = 0;
		--to do
	end
end

function Sign_OnOff(toggle)
	if ( toggle == 1) then
		ScreenShot_Sign = 1;
		ScreenShot.Sign = 1;
	else
		ScreenShot_Sign = 0;
		ScreenShot.Sign = 0;
	end
end