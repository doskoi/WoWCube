function TitanLocalizeEN()
     TITAN_DEBUG = "<Titan>";
     TITAN_INFO = "<Titan>"
     
     TITAN_NA = "N/A";
     TITAN_SECONDS = "seconds";
     TITAN_MINUTES = "minutes";
     TITAN_HOURS = "hours";
     TITAN_DAYS = "days";
     TITAN_SECONDS_ABBR = "s";
     TITAN_MINUTES_ABBR = "m";
     TITAN_HOURS_ABBR = "h";
     TITAN_DAYS_ABBR = "d";
     TITAN_MILLISECOND = "ms";
     TITAN_KILOBYTES_PER_SECOND = "KB/s";
     TITAN_KILOBITS_PER_SECOND = "kbps"
     TITAN_MEGABYTE = "MB";
     TITAN_NONE = "None";
     
     TITAN_MOVABLE_TOOLTIP = "Drag to move around";

     TITAN_PANEL_ERROR_DUP_PLUGIN = " appears to be registered twice. This may cause certain plugins to malfunction, please correct/report this problem.";
     TITAN_PANEL_ERROR_PROF_DELCURRENT = "You may not delete your current profile.";
     TITAN_PANEL_RESET_WARNING = GREEN_FONT_COLOR_CODE.."Warning:"..FONT_COLOR_CODE_CLOSE.."This setting will reset your bar(s) and Panel settings to default values and will recreate your current profile. If you wish to continue with this operation, push 'Accept' (your UI will reload), otherwise push 'Cancel' or the 'Escape' key.";
     
     -- slash command help
     TITAN_PANEL_SLASH_STRING2 = LIGHTYELLOW_FONT_COLOR_CODE.."Usage: |cffffffff/titan {reset | reset tipfont/tipalpha/panelscale/spacing}";
     TITAN_PANEL_SLASH_STRING3 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset: |cffffffffResets Panel to default values/position.";
     TITAN_PANEL_SLASH_STRING4 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset tipfont: |cffffffffResets Panel tooltip font scale to default.";
     TITAN_PANEL_SLASH_STRING5 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset tipalpha: |cffffffffResets Panel tooltip transparency to default.";
     TITAN_PANEL_SLASH_STRING6 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset panelscale: |cffffffffResets Panel scale to default.";
     TITAN_PANEL_SLASH_STRING7 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset spacing: |cffffffffResets Panel button spacing to default.";
     TITAN_PANEL_SLASH_STRING8 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."gui control: |cffffffffOpens the Ace3 Panel control GUI.";
     TITAN_PANEL_SLASH_STRING9 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."gui trans: |cffffffffOpens the Ace3 Transparency control GUI.";
     TITAN_PANEL_SLASH_STRING10 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."gui skin: |cffffffffOpens the Ace3 Skin control GUI.";
     TITAN_PANEL_SLASH_STRING11 = LIGHTYELLOW_FONT_COLOR_CODE.."For help with BonusScanner, type : |cffffffff/bscan";
     
     -- slash command responses
     TITAN_PANEL_SLASH_RESP1 = LIGHTYELLOW_FONT_COLOR_CODE.."Titan Panel tooltip font scale has been reset.";
     TITAN_PANEL_SLASH_RESP2 = LIGHTYELLOW_FONT_COLOR_CODE.."Titan Panel tooltip transparency has been reset.";
     TITAN_PANEL_SLASH_RESP3 = LIGHTYELLOW_FONT_COLOR_CODE.."Titan Panel scale has been reset.";
     TITAN_PANEL_SLASH_RESP4 = LIGHTYELLOW_FONT_COLOR_CODE.."Titan Panel button spacing has been reset.";
     
     -- general panel locale
     TITAN_PANEL = "Titan Panel";
     TITAN_PANEL_VERSION_INFO = "|cffffffff by the |cffff8c00Titan Dev Team".." |cffffffff(HonorGoG, joejanko, Lothayer, Tristanian, oXidFoX, urnati & StingerSoft)";     
     TITAN_PANEL_MENU_TITLE = "Titan Panel";
     TITAN_PANEL_MENU_HIDE = "Hide";
     TITAN_PANEL_MENU_CUSTOMIZE = "Customize";
     TITAN_PANEL_MENU_IN_COMBAT_LOCKDOWN = "(In Combat)";
     TITAN_PANEL_MENU_RELOADUI = "(Reload UI)";
     TITAN_PANEL_MENU_SHOW_COLORED_TEXT = "Show colored text";
     TITAN_PANEL_MENU_SHOW_ICON = "Show icon";
     TITAN_PANEL_MENU_SHOW_LABEL_TEXT = "Show label text";
     TITAN_PANEL_MENU_AUTOHIDE = "Auto-hide";
     TITAN_PANEL_MENU_BGMINIMAP = "Battleground mini-map";
     TITAN_PANEL_MENU_CENTER_TEXT = "Center text";
     TITAN_PANEL_MENU_DISPLAY_ONTOP = "Display on top";
     TITAN_PANEL_MENU_DISPLAY_BOTH = "Display both bars";
     TITAN_PANEL_MENU_DISABLE_PUSH = "Disable screen adjust";
     TITAN_PANEL_MENU_DISABLE_MINIMAP_PUSH = "Disable minimap adjust";
     TITAN_PANEL_MENU_DISABLE_LOGS = "Automatic log adjust";
     TITAN_PANEL_MENU_BUILTINS = "Built-ins";
     TITAN_PANEL_MENU_LEFT_SIDE = "Left Side";
     TITAN_PANEL_MENU_RIGHT_SIDE = "Right Side";
     TITAN_PANEL_MENU_PROFILES = "Profiles";
     TITAN_PANEL_MENU_PROFILE = "Profile ";
     TITAN_PANEL_MENU_PROFILE_CUSTOM = "Custom";
     TITAN_PANEL_MENU_PROFILE_DELETED = " has been deleted.";
     TITAN_PANEL_MENU_PROFILE_SERVERS = "Server";
     TITAN_PANEL_MENU_PROFILE_CHARS = "Character";
     TITAN_PANEL_MENU_PROFILE_RELOADUI = "Your UI will now reload upon pushing 'Okay' to allow saving of your custom profile.";
     TITAN_PANEL_MENU_PROFILE_SAVE_CUSTOM_TITLE = "Enter a name for your custom profile:\n(20 chars max, no spaces allowed, case sensitive)";
     TITAN_PANEL_MENU_PROFILE_SAVE_PENDING = "Current panel settings are to be saved under profile name: ";
     TITAN_PANEL_MENU_PROFILE_ALREADY_EXISTS = "The profile name entered already exists. Are you sure you want to overwrite it ? Push 'Accept' if yes, otherwise push 'Cancel' or the 'Escape' key.";
     TITAN_PANEL_MENU_MANAGE_SETTINGS = "Manage";
     TITAN_PANEL_MENU_LOAD_SETTINGS = "Load";
     TITAN_PANEL_MENU_DELETE_SETTINGS = "Delete";
     TITAN_PANEL_MENU_SAVE_SETTINGS = "Save";
     TITAN_PANEL_MENU_DOUBLE_BAR = "Double Bar";
     TITAN_PANEL_MENU_CONFIGURATION = "Configuration";
     TITAN_PANEL_MENU_OPTIONS = "Options";
     TITAN_PANEL_MENU_OPTIONS_PANEL = "Panel";
     TITAN_PANEL_MENU_OPTIONS_BARS = "Bars";
     TITAN_PANEL_MENU_OPTIONS_TOOLTIPS = "Tooltips";
     TITAN_PANEL_MENU_OPTIONS_FRAMES = "Frames";
     TITAN_PANEL_MENU_OPTIONS_LDB = "Data Broker";
     TITAN_PANEL_MENU_PLUGINS = "Plugins";
     TITAN_PANEL_MENU_LOCK_BUTTONS = "Lock buttons";
     TITAN_PANEL_MENU_VERSION_SHOWN = "Show plugin versions";
     TITAN_PANEL_MENU_LDB_SHOWN = "Append Broker suffix in menu";
     TITAN_PANEL_MENU_LDB_SIDE = "Right-side plugin";
     TITAN_PANEL_MENU_LDB_FORCE_LAUNCHER = "Force launchers to right-side";
     TITAN_PANEL_MENU_DISABLE_FONT = "Disable font scaler";
     TITAN_PANEL_MENU_CATEGORIES = {"General","Combat","Information","Interface","Profession"}
     TITAN_PANEL_MENU_TOOLTIPS_SHOWN = "Show tooltips";
     TITAN_PANEL_MENU_TOOLTIPS_SHOWN_IN_COMBAT = "Hide tooltips in combat";
     TITAN_PANEL_MENU_CASTINGBAR = "Move casting bar";
     TITAN_PANEL_MENU_RESET = "Reset Panel to Default";
     TITAN_PANEL_MENU_TEXTURE_SETTINGS = "Skins";     
     TITAN_PANEL_MENU_FONT = "Font";
     TITAN_PANEL_MENU_LSM_FONTS = "LibSharedMedia Fonts"
     TITAN_PANEL_MENU_ENABLED = "Enabled";
     TITAN_PANEL_MENU_DISABLED = "Disabled";
     
     -- localization strings for AceConfigDialog-3.0     
		 TITAN_PANEL_CONFIG_MAIN_LABEL = "Information display bar addon. Allows users to add data feed or launcher plugins on a control panel placed on the top and/or bottom of the screen.";			 
		 TITAN_TRANS_MENU_TEXT_SHORT = "Transparency";
		 TITAN_TRANS_MENU_DESC = "Adjust transparency for the Titan bars and tooltip.";		
		 TITAN_TRANS_MAIN_CONTROL_TITLE = "Main Bar";
     TITAN_TRANS_AUX_CONTROL_TITLE = "Auxiliary Bar";
     TITAN_TRANS_CONTROL_TITLE_TOOLTIP = "Tooltip";		 
		 TITAN_TRANS_MAIN_BAR_DESC = "Sets transparency for the Main Bar.";
		 TITAN_TRANS_AUX_BAR_DESC = "Sets transparency for the Auxiliary (Bottom) Bar.";
		 TITAN_TRANS_TOOLTIP_DESC = "Sets transparency for the tooltip of the various plugins.";
		 TITAN_UISCALE_MENU_TEXT = "Panel Control";
		 TITAN_UISCALE_CONTROL_TITLE_UI = "UI Scale";
		 TITAN_UISCALE_CONTROL_TITLE_PANEL = "Panel Scale";
		 TITAN_UISCALE_CONTROL_TITLE_BUTTON = "Button Spacing";
		 TITAN_UISCALE_CONTROL_TOOLTIP_TOOLTIPFONT = "Tooltip Font Scale";
		 TITAN_UISCALE_TOOLTIP_DISABLE_TEXT = "Disable Tooltip Font Scale";		 
		 TITAN_UISCALE_MENU_DESC = "Controls various aspects of the UI and Panel.";
		 TITAN_UISCALE_SLIDER_DESC = "Sets the scale of your entire UI.";
		 TITAN_UISCALE_PANEL_SLIDER_DESC = "Sets the scale for the various Panel buttons and icons.";
		 TITAN_UISCALE_BUTTON_SLIDER_DESC = "Adjusts the space between left-side plugins.";
		 TITAN_UISCALE_TOOLTIP_SLIDER_DESC = "Adjusts the scale for the tooltip of the various plugins.";
		 TITAN_UISCALE_DISABLE_TOOLTIP_DESC = "Disables Titan's Tooltip Font Scale Control.";
		 TITAN_SKINS_MAIN_DESC = "Manage various skins for the Titan bars.";
		 TITAN_SKINS_LIST_TITLE = "Skin List";
		 TITAN_SKINS_SET_DESC = "Select a skin to set for the Titan bars.";
		 TITAN_SKINS_SET_HEADER = "Set Panel Skin";
		 TITAN_SKINS_NEW_HEADER = "Add New Skin";
		 TITAN_SKINS_NAME_TITLE = "Skin Name";
		 TITAN_SKINS_NAME_DESC = "Enter a name for your new skin.";
		 TITAN_SKINS_NAME_EXAMPLE = "example: My Titan Skin";
		 TITAN_SKINS_PATH_TITLE = "Skin Path";
		 TITAN_SKINS_PATH_DESC = "Enter the exact path where your skin artwork is located, as shown in the example and explained in the 'Notes'.";
		 TITAN_SKINS_PATH_EXAMPLE = "example: Interface\\AddOns\\Titan\\Artwork\\Custom\\<My Skin folder>\\";
		 TITAN_SKINS_ADD_HEADER = "Add Skin";
		 TITAN_SKINS_ADD_DESC = "Adds a new skin to the list of available skins for the Panel.";
		 TITAN_SKINS_REMOVE_HEADER = "Remove Skin";
		 TITAN_SKINS_REMOVE_DESC = "Select a skin to remove from the available skins for the Panel.";
		 TITAN_SKINS_REMOVE_BUTTON = "Remove";
		 TITAN_SKINS_REMOVE_BUTTON_DESC = "Removes the selected skin from the list of available skins for the Panel.";
		 TITAN_SKINS_NOTES = "|cff19ff19Notes:|r When adding a new skin, please ensure that a folder containing your custom artwork has been created prior to loading 'World of Warcraft' and the path entered here corresponds to it exactly (paths are case sensitive and always end with an '\\' character).";
		 -- /end localization strings for AceConfigDialog-3.0
     
     TITAN_AUTOHIDE_TOOLTIP = "Toggles panel auto-hide on/off";
     TITAN_AUTOHIDE_MENU_TEXT = "Auto-hide";
     
     TITAN_AMMO_FORMAT = "%d";
     TITAN_AMMO_BUTTON_LABEL_AMMO = "Ammo: ";
     TITAN_AMMO_BUTTON_LABEL_THROWN = "Thrown: ";
     TITAN_AMMO_BUTTON_LABEL_AMMO_THROWN = "Ammo/Thrown: ";
     TITAN_AMMO_TOOLTIP = "Equipped Ammo/Thrown Count";
     TITAN_AMMO_MENU_TEXT = "Ammo/Thrown";
     TITAN_AMMO_BUTTON_NOAMMO = "No Ammo";
     TITAN_AMMO_MENU_REFRESH = "Refresh Display";
     TITAN_AMMO_BULLET_NAME = "Show ammo name";
     
     TITAN_BAG_FORMAT = "%d/%d";
     TITAN_BAG_BUTTON_LABEL = "Bags: ";
     TITAN_BAG_TOOLTIP = "Bags Info";
     TITAN_BAG_TOOLTIP_HINTS = "Hint: Left-click to open all bags.";
     TITAN_BAG_MENU_TEXT = "Bag";
     TITAN_BAG_USED_SLOTS = "Used Slots";
     TITAN_BAG_FREE_SLOTS = "Free Slots";
     TITAN_BAG_BACKPACK = "Backpack";
     TITAN_BAG_MENU_SHOW_USED_SLOTS = "Show used slots";
     TITAN_BAG_MENU_SHOW_AVAILABLE_SLOTS = "Show available slots";
     TITAN_BAG_MENU_SHOW_DETAILED = "Show detailed tooltip";
     TITAN_BAG_MENU_IGNORE_AMMO_POUCH_SLOTS = "Ignore ammo pouch slots";
     TITAN_BAG_MENU_IGNORE_SHARD_BAGS_SLOTS = "Ignore shard bags";
     TITAN_BAG_MENU_IGNORE_PROF_BAGS_SLOTS = "Ignore profession bags";
     TITAN_BAG_SHARD_BAG_NAMES = {"Soul Pouch", "Small Soul Pouch", "Box of Souls", "Felcloth Bag", "Core Felcloth Bag", "Ebon Shadowbag", "Abyssal Bag"};
     TITAN_BAG_AMMO_POUCH_NAMES = {"Clefthoof Hide Quiver", "Worg Hide Quiver", "Ancient Sinew Wrapped Lamina", "Nerubian Reinforced Quiver", "Quiver of a Thousand Feathers", "Knothide Quiver", "Harpy Hide Quiver", "Ribbly's Quiver", "Quickdraw Quiver", "Heavy Quiver", "Quiver of the Night Watch", "Hunting Quiver", "Medium Quiver", "Light Leather Quiver", "Small Quiver", "Light Quiver", "Smuggler's Ammo Pouch", "Dragonscale Ammo Pouch", "Knothide Ammo Pouch", "Netherscale Ammo Pouch", "Gnoll Skin Bandolier", "Ribbly's Bandolier", "Thick Leather Ammo Pouch", "Heavy Leather Ammo Pouch", "Bandolier of the Night Watch", "Medium Shot Pouch", "Hunting Ammo Sack", "Small Leather Ammo Pouch", "Small Shot Pouch", "Small Ammo Pouch"};
     TITAN_BAG_PROF_BAG_NAMES = {"Enchanted Mageweave Pouch", "Enchanted Runecloth Bag", "Big Bag of Enchantment", "Enchanter's Satchel", "Mysterious Bag", "Spellfire Bag", "Khorium Toolbox", "Fel Iron Toolbox", "Heavy Toolbox", "Gem Pouch", "Bag of Jewels", "Reinforced Mining Bag", "Mining Sack", "Mammoth Mining Bag", "Leatherworker's Satchel", "Bag of Many Hides", "Trapper's Traveling Pack", "Herb Pouch", "Cenarion Herb Bag", "Satchel of Cenarius", "Mycah's Botanical Bag", "Scribe's Satchel", "Pack of Endless Pockets"};

     TITAN_BGMINIMAP_MENU_TEXT = "Battleground minimap"
     TITAN_BGMINIMAP_TOOLTIP = "Toggles battleground minimap"
     
     TITAN_CLOCK_TOOLTIP = "Clock";     
     TITAN_CLOCK_TOOLTIP_VALUE = "Server offset hour value: ";
     TITAN_CLOCK_TOOLTIP_LOCAL_TIME = "Local Time: ";
     TITAN_CLOCK_TOOLTIP_SERVER_TIME = "Server Time: ";
     TITAN_CLOCK_TOOLTIP_SERVER_ADJUSTED_TIME = "Adjusted Server Time: ";
     TITAN_CLOCK_TOOLTIP_HINT1 = "Hint: Left-click to adjust the offset hour"
     TITAN_CLOCK_TOOLTIP_HINT2 = "(server time only) and the 12/24H time format.";
     TITAN_CLOCK_TOOLTIP_HINT3 = "Shift Left-Click to toggle the Calendar on/off.";
     TITAN_CLOCK_CONTROL_TOOLTIP = "Server Hour Offset: ";
     TITAN_CLOCK_CONTROL_TITLE = "Offset";
     TITAN_CLOCK_CONTROL_HIGH = "+12";
     TITAN_CLOCK_CONTROL_LOW = "-12";
     TITAN_CLOCK_CHECKBUTTON = "24H Fmt";
     TITAN_CLOCK_CHECKBUTTON_TOOLTIP = "Toggles the time display between 12-hour and 24-hour format";
     TITAN_CLOCK_MENU_TEXT = "Clock";
     TITAN_CLOCK_MENU_LOCAL_TIME = "Show Local Time (L)";
     TITAN_CLOCK_MENU_SERVER_TIME = "Show Server Time (S)";
     TITAN_CLOCK_MENU_SERVER_ADJUSTED_TIME = "Show Server Adjusted Time (A)";
     TITAN_CLOCK_MENU_DISPLAY_ON_RIGHT_SIDE = "Display on far right side";
     TITAN_CLOCK_MENU_HIDE_GAMETIME = "Hide Time/Calendar button";
     
     
     TITAN_COORDS_FORMAT = "(%.d, %.d)";
     TITAN_COORDS_FORMAT2 = "(%.1f, %.1f)";
     TITAN_COORDS_FORMAT3 = "(%.2f, %.2f)";
     TITAN_COORDS_FORMAT_LABEL = "(xx , yy)";
     TITAN_COORDS_FORMAT2_LABEL = "(xx.x , yy.y)";
     TITAN_COORDS_FORMAT3_LABEL = "(xx.xx , yy.yy)";
     TITAN_COORDS_FORMAT_COORD_LABEL = "Coordinate Format";
     TITAN_COORDS_BUTTON_LABEL = "Loc: ";
     TITAN_COORDS_TOOLTIP = "Location Info";
     TITAN_COORDS_TOOLTIP_HINTS_1 = "Hint: Shift + left-click to add location";
     TITAN_COORDS_TOOLTIP_HINTS_2 = "info to the chat message.";
     TITAN_COORDS_TOOLTIP_ZONE = "Zone: ";
     TITAN_COORDS_TOOLTIP_SUBZONE = "SubZone: ";
     TITAN_COORDS_TOOLTIP_PVPINFO = "PVP Info: ";
     TITAN_COORDS_TOOLTIP_HOMELOCATION = "Home Location";
     TITAN_COORDS_TOOLTIP_INN = "Inn: ";
     TITAN_COORDS_MENU_TEXT = "Coords";
     TITAN_COORDS_MENU_SHOW_ZONE_ON_PANEL_TEXT = "Show zone text";
     TITAN_COORDS_MENU_SHOW_COORDS_ON_MAP_TEXT = "Show coordinates on world map";
     TITAN_COORDS_MAP_CURSOR_COORDS_TEXT = "Cursor(X,Y): %s";
     TITAN_COORDS_MAP_PLAYER_COORDS_TEXT = "Player(X,Y): %s";
     TITAN_COORDS_NO_COORDS = "No Coords";
     
     TITAN_FPS_FORMAT = "%.1f";
     TITAN_FPS_BUTTON_LABEL = "FPS: ";
     TITAN_FPS_MENU_TEXT = "FPS";
     TITAN_FPS_TOOLTIP_CURRENT_FPS = "Current FPS: ";
     TITAN_FPS_TOOLTIP_AVG_FPS = "Average FPS: ";
     TITAN_FPS_TOOLTIP_MIN_FPS = "Minimum FPS: ";
     TITAN_FPS_TOOLTIP_MAX_FPS = "Maximum FPS: ";
     TITAN_FPS_TOOLTIP = "Frames Per Second";
     
     TITAN_LATENCY_FORMAT = "%d"..TITAN_MILLISECOND;
     TITAN_LATENCY_BANDWIDTH_FORMAT = "%.3f "..TITAN_KILOBYTES_PER_SECOND;
     TITAN_LATENCY_BUTTON_LABEL = "Latency: ";
     TITAN_LATENCY_TOOLTIP = "Network Status";
     TITAN_LATENCY_TOOLTIP_LATENCY = "Latency: ";
     TITAN_LATENCY_TOOLTIP_BANDWIDTH_IN = "Bandwidth in: ";
     TITAN_LATENCY_TOOLTIP_BANDWIDTH_OUT = "Bandwidth out: ";
     TITAN_LATENCY_MENU_TEXT = "Latency";
     
     TITAN_LOOTTYPE_BUTTON_LABEL = "Loot: ";
     TITAN_LOOTTYPE_FREE_FOR_ALL = "Free For All";
     TITAN_LOOTTYPE_ROUND_ROBIN = "Round Robin";
     TITAN_LOOTTYPE_MASTER_LOOTER = "Master Looter";
     TITAN_LOOTTYPE_GROUP_LOOT = "Group Loot";
     TITAN_LOOTTYPE_NEED_BEFORE_GREED = "Need Before Greed";
     TITAN_LOOTTYPE_TOOLTIP = "Loot Type Info";
     TITAN_LOOTTYPE_MENU_TEXT = "Loot Type";
     TITAN_LOOTTYPE_RANDOM_ROLL_LABEL = "Random Roll";
     TITAN_LOOTTYPE_TOOLTIP_HINT1 = "Hint: Left-click for random roll.";
     TITAN_LOOTTYPE_TOOLTIP_HINT2 = "Select roll type from right-click menu.";
     
     TITAN_MEMORY_FORMAT = "%.3f"..TITAN_MEGABYTE;
     TITAN_MEMORY_FORMAT_KB = "%d".."KB";
     TITAN_MEMORY_RATE_FORMAT = "%.3f"..TITAN_KILOBYTES_PER_SECOND;
     TITAN_MEMORY_BUTTON_LABEL = "Memory: ";
     TITAN_MEMORY_TOOLTIP = "Memory Usage";
     TITAN_MEMORY_TOOLTIP_CURRENT_MEMORY = "Current: ";
     TITAN_MEMORY_TOOLTIP_INITIAL_MEMORY = "Initial: ";
     TITAN_MEMORY_TOOLTIP_INCREASING_RATE = "Increasing rate: ";
     TITAN_MEMORY_KBMB_LABEL = "KB/MB";     
     --TITAN_MEMORY_MENU_TEXT = "Memory";
     --TITAN_MEMORY_MENU_RESET_SESSION = "Reset memory data";
     
     TITAN_MONEY_GOLD = "g";
     TITAN_MONEY_SILVER = "s";
     TITAN_MONEY_COPPER = "c";
     TITAN_MONEY_FORMAT = "%d"..TITAN_MONEY_GOLD..", %d"..TITAN_MONEY_SILVER..", %d"..TITAN_MONEY_COPPER;
     
     TITAN_PERFORMANCE_TOOLTIP = "Performance Info";
     TITAN_PERFORMANCE_MENU_TEXT = "Performance";
     TITAN_PERFORMANCE_ADDONS = "Addon Usage";
     TITAN_PERFORMANCE_ADDON_MEM_USAGE_LABEL = "Addon Memory Usage";
     TITAN_PERFORMANCE_ADDON_MEM_FORMAT_LABEL = "Addon Memory Format";
     TITAN_PERFORMANCE_ADDON_CPU_USAGE_LABEL = "Addon CPU Usage";
     TITAN_PERFORMANCE_ADDON_NAME_LABEL = "Name:";
     TITAN_PERFORMANCE_ADDON_USAGE_LABEL = "Usage";
     TITAN_PERFORMANCE_ADDON_RATE_LABEL = "Rate";
     TITAN_PERFORMANCE_ADDON_TOTAL_MEM_USAGE_LABEL = "Total Addon Memory:";
     TITAN_PERFORMANCE_ADDON_TOTAL_CPU_USAGE_LABEL = "Total CPU Time:";
     TITAN_PERFORMANCE_MENU_SHOW_FPS = "Show FPS";
     TITAN_PERFORMANCE_MENU_SHOW_LATENCY = "Show Latency";
     TITAN_PERFORMANCE_MENU_SHOW_MEMORY = "Show Memory";
     TITAN_PERFORMANCE_MENU_SHOW_ADDONS = "Show Addon Memory Usage";
     TITAN_PERFORMANCE_MENU_SHOW_ADDON_RATE = "Show Addon Usage Rate";
     TITAN_PERFORMANCE_MENU_CPUPROF_LABEL = "CPU Profiling Mode";
     TITAN_PERFORMANCE_MENU_CPUPROF_LABEL_ON = "Enable CPU Profiling Mode ";
     TITAN_PERFORMANCE_MENU_CPUPROF_LABEL_OFF = "Disable CPU Profiling Mode ";
     TITAN_PERFORMANCE_CONTROL_TOOLTIP = "Monitored Addons: ";
     TITAN_PERFORMANCE_CONTROL_TITLE = "Monitored Addons";
     TITAN_PERFORMANCE_CONTROL_HIGH = "40";
     TITAN_PERFORMANCE_CONTROL_LOW = "1";
     TITAN_PERFORMANCE_TOOLTIP_HINT = "Hint: Left-click to force a garbage collection.";
		     
     TITAN_XP_FORMAT = "%d";
     TITAN_XP_PERCENT_FORMAT = TITAN_XP_FORMAT.." (%.1f%%)";
     TITAN_XP_BUTTON_LABEL_XPHR_LEVEL = "XP/hr this level: ";
     TITAN_XP_BUTTON_LABEL_XPHR_SESSION = "XP/hr this session: ";
     TITAN_XP_BUTTON_LABEL_TOLEVEL_TIME_LEVEL = "Time to level: ";
		 TITAN_XP_LEVEL_COMPLETE = "Level Complete: ";
		 TITAN_XP_TOTAL_RESTED = "Rested: ";
		 TITAN_XP_XPTOLEVELUP = "XP to level Up: ";
     TITAN_XP_TOOLTIP = "XP Info";
     TITAN_XP_TOOLTIP_TOTAL_TIME = "Total time played: ";
     TITAN_XP_TOOLTIP_LEVEL_TIME = "Time played this level: ";
     TITAN_XP_TOOLTIP_SESSION_TIME = "Time played this session: ";
     TITAN_XP_TOOLTIP_TOTAL_XP = "Total XP required this level: ";
     TITAN_XP_TOOLTIP_LEVEL_XP = "XP gained this level: ";
     TITAN_XP_TOOLTIP_TOLEVEL_XP = "XP needed to level: ";
     TITAN_XP_TOOLTIP_SESSION_XP = "XP gained this session: ";
     TITAN_XP_TOOLTIP_XPHR_LEVEL = "XP/hr this level: ";
     TITAN_XP_TOOLTIP_XPHR_SESSION = "XP/hr this session: ";     
     TITAN_XP_TOOLTIP_TOLEVEL_LEVEL = "Time to level (level rate): ";
     TITAN_XP_TOOLTIP_TOLEVEL_SESSION = "Time to level (session rate): ";
     TITAN_XP_MENU_TEXT = "XP";
     TITAN_XP_MENU_SHOW_XPHR_THIS_LEVEL = "Show XP/hr this level";
     TITAN_XP_MENU_SHOW_XPHR_THIS_SESSION = "Show XP/hr this session";
     TITAN_XP_MENU_SHOW_RESTED_TOLEVELUP = "Show Multi-info view";
     TITAN_XP_MENU_SIMPLE_BUTTON_TITLE = "Button";
     TITAN_XP_MENU_SIMPLE_BUTTON_RESTED = "Show Rested XP";
     TITAN_XP_MENU_SIMPLE_BUTTON_TOLEVELUP = "Show XP to level";
     TITAN_XP_MENU_SIMPLE_BUTTON_KILLS = "Show est. kills to level";
     TITAN_XP_MENU_RESET_SESSION = "Reset session";
     TITAN_XP_MENU_REFRESH_PLAYED = "Refresh Timers";
     TITAN_XP_UPDATE_PENDING = "Updating...";
     TITAN_XP_UNKNOWN = "Unknown";
     TITAN_XP_KILLS_LABEL = "Kills to level (at %d XP gained last): ";
     TITAN_XP_KILLS_LABEL_SHORT = "Est. Kills: ";
     
     TITAN_REGEN_MENU_TEXT = "Regen"
     TITAN_REGEN_MENU_TOOLTIP_TITLE = "Regen Info"
     TITAN_REGEN_MENU_SHOW1 = "Show"
     TITAN_REGEN_MENU_SHOW2 = "HP"
     TITAN_REGEN_MENU_SHOW3 = "MP"
     TITAN_REGEN_MENU_SHOW4 = "As Percentage"
     TITAN_REGEN_BUTTON_TEXT_HP = "HP: "..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
     TITAN_REGEN_BUTTON_TEXT_HP_PERCENT = "HP: "..HIGHLIGHT_FONT_COLOR_CODE.."%.2f"..FONT_COLOR_CODE_CLOSE;
     TITAN_REGEN_BUTTON_TEXT_MP = " MP: "..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
     TITAN_REGEN_BUTTON_TEXT_MP_PERCENT = " MP: "..HIGHLIGHT_FONT_COLOR_CODE.."%.2f"..FONT_COLOR_CODE_CLOSE;
     TITAN_REGEN_TOOLTIP1 = "Health: \t"..GREEN_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE.." / " ..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE.." ("..RED_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE..")";
     TITAN_REGEN_TOOLTIP2 = "Mana: \t"..GREEN_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE.." / " ..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE.." ("..RED_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE..")";
     TITAN_REGEN_TOOLTIP3 = "Best HP Regen: \t"..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
     TITAN_REGEN_TOOLTIP4 = "Worst HP Regen: \t"..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
     TITAN_REGEN_TOOLTIP5 = "Best MP Regen: \t"..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
     TITAN_REGEN_TOOLTIP6 = "Worst MP Regen: \t"..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
     TITAN_REGEN_TOOLTIP7 = "MP Regen in Last Fight: \t"..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE.." ("..GREEN_FONT_COLOR_CODE.."%.2f"..FONT_COLOR_CODE_CLOSE.."%%)";

     TITAN_ITEMBONUSES_TEXT = "Item Bonuses";
     TITAN_ITEMBONUSES_DISPLAY_NONE = "Display none";
     TITAN_ITEMBONUSES_SHORTDISPLAY = "Brief label text";
     TITAN_ITEMBONUSES_BONUSSCANNER_MISSING = "BonusScanner AddOn required";
     TITAN_ITEMBONUSES_AVERAGE_ILVL = "Display average item level";
     TITAN_ITEMBONUSES_RATING_CONVERSION = "Display ratings as points/percentage";
		 TITAN_ITEMBONUSES_SHOWGEMS = "Display number of gem colors";

     TITAN_ITEMBONUSES_CAT_ATT = "Attributes";
     TITAN_ITEMBONUSES_CAT_RES = "Resistance";
     TITAN_ITEMBONUSES_CAT_SKILL = "Skills";
     TITAN_ITEMBONUSES_CAT_BON = "Melee and Ranged Combat";
     TITAN_ITEMBONUSES_CAT_SBON = "Spells";
     TITAN_ITEMBONUSES_CAT_OBON = "Life and Mana";
     TITAN_ITEMBONUSES_CAT_EBON = "Special Bonuses";

     --Titan Repair
     REPAIR_LOCALE = {
          pattern = "^Durability (%d+) / (%d+)$",
          menu = "Repair",
          tooltip = "Durability Info",
          button = "Durability: ",
          normal = "Repair cost (Normal): ",
          friendly = "Repair cost (Friendly): ",
          honored = "Repair cost (Honored): ",
          revered = "Repair cost (Revered): ",
          exalted = "Repair cost (Exalted): ",
          buttonNormal = "Show Normal",
          buttonFriendly = "Show Friendly (5%)",
          buttonHonored = "Show Honored (10%)",
          buttonRevered = "Show Revered (15%)",
          buttonExalted = "Show Exalted (20%)",
          percentage = "Show as Percentage",
--          itemname = "Show Most Damaged",
          itemnames = "Show Item Names",
          mostdamaged = "Show Most Damaged",
          showdurabilityframe = "Show Durability Frame",
          undamaged = "Show Undamaged Items",
          discount = "Discount",
          nothing = "Nothing damaged",
          confirmation = "Do you want to repair all items ?",
          badmerchant = "This merchant cannot repair. Displaying normal repair costs instead.",
          popup = "Show Repair popup",
          showinventory = "Calculate Inventory damage",
          WholeScanInProgress = "Updating...",
          AutoReplabel = "Auto-Repair",
          AutoRepitemlabel = "Auto Repair all items",
          ShowRepairCost = "Show Repair Cost",
     };

     TITAN_PLUGINS_MENU_TITLE = "Plug-ins";
     
end

function Localize()
     TitanLocalizeEN();
     
     local locale = GetLocale();
     if ( locale == "deDE" ) then
          TitanLocalizeDE();
     elseif ( locale == "frFR" ) then
          TitanLocalizeFR();
     elseif ( locale == "esES" ) then
          TitanLocalizeES();
     elseif ( locale == "ruRU" ) then
          TitanLocalizeRU();
     elseif ( locale == "zhCN" ) then
          TitanLocalizeCN();
     elseif ( locale == "zhTW" ) then
          TitanLocalizeTW();
     end
end