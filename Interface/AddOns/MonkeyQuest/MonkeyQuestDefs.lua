--[[

	MonkeyQuest:
	Displays your quests for quick viewing.
	
	Website:	http://toctastic.net/
	Author:		Trentin (monkeymods@gmail.com)
	
	
	Contributors:
	Celdor
		- Help with the Quest Log Freeze bug
		
	Diungo
		- Toggle grow direction
		
	Pkp
		- Color Quest Titles the same as the quest level
	
	wowpendium.de
		- German translation
		
	MarsMod
		- Valid player name before the VARIABLES_LOADED event bug
		- Settings resetting bug

	Juki
		- French translation
	
	Global
		- PvP Quests

--]]


-- default "constants" like #define in C :)
MONKEYQUEST_DELAY							= 0.3;
MONKEYQUEST_PADDING							= 25;
MONKEYQUEST_MAX_BUTTONS						= 40;

-- default settings
MONKEYQUEST_DEFAULT_CRASHCOLOUR				= { r = 1.0, g = 0.6901960784313725, b = 0.0 };
MONKEYQUEST_DEFAULT_ALPHA					= 0.5;
MONKEYQUEST_DEFAULT_FRAME_ALPHA				= 1.0;
MONKEYQUEST_DEFAULT_WIDTH					= 255;
MONKEYQUEST_DEFAULT_LEFT					= 800;
MONKEYQUEST_DEFAULT_TOP						= 640;
MONKEYQUEST_DEFAULT_BOTTOM					= 640;
MONKEYQUEST_DEFAULT_SHOWNOOBTIPS			= true;
MONKEYQUEST_DEFAULT_QUESTPADDING			= 0;
MONKEYQUEST_DEFAULT_SHOWZONEHIGHLIGHT		= true;
MONKEYQUEST_DEFAULT_SHOWQUESTLEVEL			= true;

MONKEYQUEST_DEFAULT_DISPLAY					= true;
MONKEYQUEST_DEFAULT_DEFAULTANCHOR			= false;
MONKEYQUEST_DEFAULT_ANCHOR					= "ANCHOR_TOPLEFT";
MONKEYQUEST_DEFAULT_OBJECTIVES				= true;
MONKEYQUEST_DEFAULT_MINIMIZED				= false;
MONKEYQUEST_DEFAULT_SHOWHIDDEN				= false;
MONKEYQUEST_DEFAULT_NOHEADERS				= false;
MONKEYQUEST_DEFAULT_ALWAYSHEADERS			= false;
MONKEYQUEST_DEFAULT_NOBORDER				= false;
MONKEYQUEST_DEFAULT_GROWUP					= false;
MONKEYQUEST_DEFAULT_SHOWNUMQUESTS			= false;
MONKEYQUEST_DEFAULT_SHOWDAILYNUMQUESTS		= false;
MONKEYQUEST_DEFAULT_LOCKED					= false;
MONKEYQUEST_DEFAULT_HIDECOMPLETEDQUESTS		= false;
MONKEYQUEST_DEFAULT_HIDECOMPLETEDOBJECTIVES	= false;
MONKEYQUEST_DEFAULT_ALLOWRIGHTCLICK			= true;
MONKEYQUEST_DEFAULT_SHOWTOOLTIPOBJECTIVES		= true;
MONKEYQUEST_DEFAULT_HIDETITLEBUTTONS			= false;
MONKEYQUEST_DEFAULT_HIDETITLE				= false;
MONKEYQUEST_DEFAULT_WORKCOMPLETE			= true;
MONKEYQUEST_DEFAULT_COLOURTITLE				= false;

MONKEYQUEST_DEFAULT_FONTHEIGHT				= 13;
MONKEYQUEST_DEFAULT_CRASHFONT				= false;
MONKEYQUEST_DEFAULT_CRASHBORDER				= false;

MONKEYQUEST_DEFAULT_LOCKBIB					= false;

MONKEYQUEST_DEFAULT_QUESTTITLECOLOUR		= "|cFFFFFFFF";
MONKEYQUEST_DEFAULT_HEADEROPENCOLOUR		= "|cFFBFBFFF";
MONKEYQUEST_DEFAULT_HEADERCLOSEDCOLOUR		= "|cFF9F9FFF";
MONKEYQUEST_DEFAULT_OVERVIEWCOLOUR			= "|cFF7F7F7F";
MONKEYQUEST_DEFAULT_SPECIALOBJECTIVECOLOUR	= "|cFFFFFF00";
MONKEYQUEST_DEFAULT_INITIALOBJECTIVECOLOUR	= "|cFFD82619";
MONKEYQUEST_DEFAULT_MIDOBJECTIVECOLOUR		= "|cFFFFFF00";
MONKEYQUEST_DEFAULT_COMPLETEOBJECTIVECOLOUR	= "|cFF00FF19";
MONKEYQUEST_DEFAULT_FINISHOBJECTIVECOLOUR		= "|cFF33DDFF";
MONKEYQUEST_DEFAULT_ZONEHILIGHTCOLOUR		= "|cff494961";