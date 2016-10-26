--------------------------------------------------
-- BonusScanner Continued v4.5
-- Originally developed by Crowley <crowley@headshot.de>
-- performance improvements by Archarodim
-- Updated for WoW 2.0 by jmlsteele
-- Updated for WoW 3.0 by Tristanian <bandit@planetcnc.com>
-- get the latest version here:
-- http://wowui.incgamers.com/ui.php?id=4613 (WoWUI)
-- http://www.wowinterface.com/downloads/info7919 (WoWI)
-------------------------------------------------- 

-- Library references
local TipHooker = LibStub("LibTipHooker-1.1")
local AceTimer = LibStub("AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("BonusScanner", true)
local _G = getfenv(0);

-- Initialize globals/tables
local BONUSSCANNER_VERSION = "4.5";

-- Patterns
local BONUSSCANNER_PATTERN_SETNAME = "^(.*) %(%d/%d%)$";
local BONUSSCANNER_PATTERN_GENERIC_PREFIX = "^%+?(%d+)%%?(.*)$";
local BONUSSCANNER_PATTERN_GENERIC_SUFFIX = "^(.*)%+ ?(%d+)%%?$";
local BONUSSCANNER_PATTERN_GENERIC_SUFFIX2 = "^(.*)%s(%d+)%%";
local bsDPSTemplate1 = string.gsub(_G["DPS_TEMPLATE"], "%%.1f", "(%%d+%%.%%d+)")
local bsDPSTemplate2 = string.gsub(_G["DPS_TEMPLATE"], "%%.1f", "(%%d+%%,%%d+)")
  
local ItemCache = {}; -- Cache table for items
  
BonusScanner = {
	bonuses = {};
	bonuses_details = {};
		    
    ShowDebug = false; -- tells when the equipment is scanned
    Verbose	= false; -- Shows a LOT of debug information
    
		-- variable counters for number of gems of the appropriate color		
		GemsRed = 0; 
		GemsYellow = 0;
		GemsBlue = 0;
		
		-- average item level
		AverageiLvl = 0;
		
	active = nil;
	temp = { 
		sets = {},
		set = "",
		slot = "",
		bonuses = {},
		details = {},
		GemsRed = 0,
		GemsYellow = 0,
		GemsBlue = 0,
		AverageiLvl = 0
	};

	slots = {
		"Head",
		"Neck",
		"Shoulder",
		"Shirt",
		"Chest",
		"Waist",
		"Legs",
		"Feet",
		"Wrist",
		"Hands",
		"Finger0",
		"Finger1",
		"Trinket0",
		"Trinket1",
		"Back",
		"MainHand",
		"SecondaryHand",
		"Ranged",
		"Tabard",
	};
}


-- Gem color table and potential logic data (for future releases)
local BonusScanner_Gems = {
-- Crafted Uncommon Quality Gems
{ itemID = "23095", red = 1, yellow = 0, blue = 0, meta = 0 }, --Bold Blood Garnet
{ itemID = "28595", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Bright Blood Garnet
{ itemID = "23113", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Brilliant Golden Draenite
{ itemID = "23106", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Dazzling Deep Peridot
{ itemID = "23097", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Delicate Blood Garnet
{ itemID = "23105", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Enduring Deep Peridot
{ itemID = "23114", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Gleaming Golden Draenite
{ itemID = "23100", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Glinting Flame Spessarite
{ itemID = "23108", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Glowing Shadow Draenite
{ itemID = "23098", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Inscribed Flame Spessarite	
{ itemID = "23104", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Jagged Deep Peridot	
{ itemID = "23099", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Luminous Flame Spessarite
{ itemID = "23121", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Lustrous Azure Moonstone
{ itemID = "23101", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Potent Flame Spessarite	
{ itemID = "23103", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Radiant Deep Peridot
{ itemID = "23116", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Rigid Golden Draenite
{ itemID = "23109", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Royal Shadow Draenite
{ itemID = "23096", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Runed Blood Garnet
{ itemID = "23110", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Shifting Shadow Draenite
{ itemID = "28290", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Smooth Golden Draenite
{ itemID = "23118", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Solid Azure Moonstone
{ itemID = "23111", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Sovereign Shadow Draenite
{ itemID = "23119", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Sparkling Azure Moonstone
{ itemID = "23120", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Stormy Azure Moonstone
{ itemID = "23094", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Teardrop Blood Garnet
{ itemID = "23115", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Thick Golden Draenite
-- Crafted Rare Quality Gems
{ itemID = "24027", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Bold Living Ruby
{ itemID = "24031", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Bright Living Ruby
{ itemID = "24047", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Brilliant Dawnstone
{ itemID = "24065", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Dazzling Talasite
{ itemID = "24028", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Delicate Living Ruby
{ itemID = "24062", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Enduring Talasite
{ itemID = "24036", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Flashing Living Ruby
{ itemID = "24050", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Gleaming Dawnstone
{ itemID = "24061", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Glinting Noble Topaz
{ itemID = "24056", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Glowing Nightseye
{ itemID = "24058", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Inscribed Noble Topaz
{ itemID = "24067", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Jagged Talasite
{ itemID = "24060", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Luminous Noble Topaz
{ itemID = "24037", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Lustrous Star of Elune
{ itemID = "24059", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Potent Noble Topaz
{ itemID = "24066", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Radiant Talasite
{ itemID = "24051", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Rigid Dawnstone
{ itemID = "24057", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Royal Nightseye
{ itemID = "24030", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Runed Living Ruby
{ itemID = "24055", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Shifting Nightseye
{ itemID = "24048", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Smooth Dawnstone
{ itemID = "24033", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Solid Star of Elune
{ itemID = "24054", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Sovereign Nightseye
{ itemID = "24035", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Sparkling Star of Elune
{ itemID = "24039", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Stormy Star of Elune
{ itemID = "24032", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Subtle Living Ruby
{ itemID = "24029", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Teardrop Living Ruby
{ itemID = "24052", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Thick Dawnstone
	-- Crafted Rare Meta Gems
{ itemID = "25897", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Bracing Earthstorm Diamond
{ itemID = "25899", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Brutal Earthstorm Diamond
{ itemID = "25890", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Destructive Skyfire Diamond
{ itemID = "25895", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Enigmatic Skyfire Diamond
{ itemID = "25901", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Insightful Earthstorm Diamond
{ itemID = "25893", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Mystical Skyfire Diamond
{ itemID = "25896", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Powerful Earthstorm Diamond
{ itemID = "25894", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Swift Skyfire Diamond
{ itemID = "25898", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Tenacious Earthstorm Diamond
	-- Enchanter Created
{ itemID = "22460", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Prismatic Sphere
{ itemID = "22459", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Void Sphere
	-- PvP Purchased Rare Meta Gems (Terrokar Spirit Towers)
{ itemID = "28557", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Swift Starfire Diamond
{ itemID = "28556", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Swift Windfire Diamond
	-- PvP Purchased Gems (Nagrand, Halaa)
{ itemID = "27679", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Sublime Mystic Dawnstone
{ itemID = "30598", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Don Amancio's Heart
-- PvP Purchased Epic Gems (Honor Points)
{ itemID = "28362", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Bold Ornate Ruby
{ itemID = "28120", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Gleaming Ornate Dawnstone
{ itemID = "28363", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Inscribed Ornate Topaz
{ itemID = "28123", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Potent Ornate Topaz
{ itemID = "28118", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Runed Ornate Ruby
{ itemID = "28119", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Smooth Ornate Dawnstone
	-- PvP Puchased Rare Gems (Honor Hold/Thrallmar)
{ itemID = "27809", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Barbed Deep Peridot
{ itemID = "27786", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Barbed Deep Peridot
{ itemID = "28361", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Mighty Blood Garnet
{ itemID = "28360", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Mighty Blood Garnet
{ itemID = "27820", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Notched Deep Peridot
{ itemID = "27785", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Notched Deep Peridot
{ itemID = "27812", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Stark Blood Garnet
{ itemID = "27777", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Stark Blood Garnet
-- Vendor Purchased (Common Gems)
{ itemID = "28458", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Bold Tourmaline
{ itemID = "28462", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Bright Tourmaline
{ itemID = "28466", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Brilliant Amber
{ itemID = "28459", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Delicate Tourmaline
{ itemID = "28469", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Gleaming Amber
{ itemID = "28465", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Lustrous Zircon
{ itemID = "28468", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Rigid Amber
{ itemID = "28461", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Runed Tourmaline
{ itemID = "28467", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Smooth Amber	
{ itemID = "28463", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Solid Zircon	
{ itemID = "28464", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Sparkling Zircon
{ itemID = "28460", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Teardrop Tourmaline	
{ itemID = "28470", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Thick Amber	
-- Instance Epic Gem Drops
{ itemID = "30565", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Assassin's Fire Opal
{ itemID = "30601", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Beaming Fire Opal
{ itemID = "30574", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Brutal Tanzanite
{ itemID = "30587", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Champion's Fire Opal
{ itemID = "30566", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Defender's Tanzanite
{ itemID = "30594", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Effulgent Chrysoprase
{ itemID = "30584", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Enscribed Fire Opal
{ itemID = "30559", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Etched Fire Opal
{ itemID = "30600", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Fluorescent Tanzanite		
{ itemID = "30558", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Glimmering Fire Opal
{ itemID = "30556", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Glinting Fire Opal
{ itemID = "30585", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Glistening Fire Opal
{ itemID = "30555", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Glowing Tanzanite
{ itemID = "31116", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Infused Amethyst
{ itemID = "30551", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Infused Fire Opal
{ itemID = "30593", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Iridescent Fire Opal
{ itemID = "30602", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Jagged Chrysoprase
{ itemID = "30606", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Lambent Chrysophrase
{ itemID = "30547", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Luminous Fire Opal
{ itemID = "30548", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Polished Chrysoprase
{ itemID = "30553", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Pristine Fire Opal
{ itemID = "31118", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Pulsing Amethyst
{ itemID = "30608", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Radiant Chrysoprase
{ itemID = "30563", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Regal Tanzanite
{ itemID = "30604", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Resplendent Fire Opal
{ itemID = "30603", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Royal Tanzanite
{ itemID = "30586", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Seer's Chrysoprase
{ itemID = "30549", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Shifting Tanzanite
{ itemID = "30564", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Shining Fire Opal
{ itemID = "31117", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Soothing Amethyst
{ itemID = "30546", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Sovereign Tanzanite
{ itemID = "30607", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Splendid Fire Opal
{ itemID = "30554", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Stalwart Fire Opal
{ itemID = "30592", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Steady Chrysoprase
{ itemID = "30550", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Sundered Chrysoprase
{ itemID = "30583", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Timeless Chrysoprase
{ itemID = "30605", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Vivid Chrysoprase
	
{ itemID = "30552", red = 1, yellow = 0, blue = 1, meta = 0 },  -- Blessed Tanzanite
{ itemID = "30589", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Dazzling Chrysoprase
{ itemID = "30582", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Deadly Fire Opal
{ itemID = "30581", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Durable Fire Opal
{ itemID = "30591", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Empowered Fire Opal
{ itemID = "30590", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Enduring Chrysoprase
{ itemID = "30572", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Imperial Tanzanite
{ itemID = "30573", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Mysterious Fire Opal
{ itemID = "30575", red = 1, yellow = 1, blue = 0, meta = 0 },  -- Nimble Fire Opal
{ itemID = "30588", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Potent Fire Opal
{ itemID = "30560", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Rune Covered Chrysoprase
-- (patch 2.1.1)
{ itemID = "31863", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Balanced Nightseye
{ itemID = "31861", red = 0, yellow = 1, blue = 0, meta = 0 },	-- Great Dawnstone
{ itemID = "31865", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Infused Nightseye
{ itemID = "31867", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Veiled Noble Topaz
{ itemID = "31868", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Wicked Noble Topaz
{ itemID = "32836", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Purified Shadow Pearl
{ itemID = "32833", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Purified Jaggal Pearl
{ itemID = "32409", red = 0, yellow = 0, blue = 0, meta = 1 },	-- Relentless Earthstorm Diamond
{ itemID = "32410", red = 0, yellow = 0, blue = 0, meta = 1 },	-- Relentless Earthstorm Diamond	
-- (patch 2.1.3)
{ itemID = "24053", red = 0, yellow = 1, blue = 0, meta = 0 },	-- Mystic Dawnstone
{ itemID = "32634", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Unstable Amethyst
{ itemID = "32635", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Unstable Peridot
{ itemID = "32636", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Unstable Sapphire
{ itemID = "32637", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Unstable Citrine	
{ itemID = "32638", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Unstable Topaz
{ itemID = "32639", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Unstable Talasite
{ itemID = "32640", red = 0, yellow = 0, blue = 0, meta = 1 },	-- Potent Unstable Diamond	
{ itemID = "32641", red = 0, yellow = 0, blue = 0, meta = 1 },	-- Imbued Unstable Diamond
-- Epic gem drops in Black Temple/Hyjal
{ itemID = "32193", red = 1, yellow = 0, blue = 0, meta = 0 },	-- Bold Crimson Spinel
{ itemID = "32194", red = 1, yellow = 0, blue = 0, meta = 0 },	-- Delicate Crimson Spinel
{ itemID = "32195", red = 1, yellow = 0, blue = 0, meta = 0 },	-- Teardrop Crimson Spinel
{ itemID = "35489", red = 1, yellow = 0, blue = 0, meta = 0 },	-- Teardrop Crimson Spinel
{ itemID = "32196", red = 1, yellow = 0, blue = 0, meta = 0 },	-- Runed Crimson Spinel
{ itemID = "35488", red = 1, yellow = 0, blue = 0, meta = 0 },	-- Runed Crimson Spinel
{ itemID = "32197", red = 1, yellow = 0, blue = 0, meta = 0 },	-- Bright Crimson Spinel
{ itemID = "35487", red = 1, yellow = 0, blue = 0, meta = 0 },	-- Bright Crimson Spinel
{ itemID = "32198", red = 1, yellow = 0, blue = 0, meta = 0 },	-- Subtle Crimson Spinel
{ itemID = "32199", red = 1, yellow = 0, blue = 0, meta = 0 },	-- Flashing Crimson Spinel
{ itemID = "32200", red = 0, yellow = 0, blue = 1, meta = 0 },	-- Solid Empyrean Sapphire
{ itemID = "32201", red = 0, yellow = 0, blue = 1, meta = 0 },	-- Sparkling Empyrean Sapphire
{ itemID = "32202", red = 0, yellow = 0, blue = 1, meta = 0 },	-- Lustrous Empyrean Sapphire
{ itemID = "32203", red = 0, yellow = 0, blue = 1, meta = 0 },	-- Stormy Empyrean Sapphire
{ itemID = "32204", red = 0, yellow = 1, blue = 0, meta = 0 },	-- Brilliant Lionseye
{ itemID = "32205", red = 0, yellow = 1, blue = 0, meta = 0 },	-- Smooth Lionseye
{ itemID = "32206", red = 0, yellow = 1, blue = 0, meta = 0 },	-- Rigid Lionseye
{ itemID = "32207", red = 0, yellow = 1, blue = 0, meta = 0 },	-- Gleaming Lionseye
{ itemID = "32208", red = 0, yellow = 1, blue = 0, meta = 0 },	-- Thick Lionseye
{ itemID = "32209", red = 0, yellow = 1, blue = 0, meta = 0 },	-- Mystic Lionseye
{ itemID = "32210", red = 0, yellow = 1, blue = 0, meta = 0 },	-- Great Lionseye
{ itemID = "32211", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Sovereign Shadowsong Amethyst
{ itemID = "32212", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Shifting Shadowsong Amethyst
{ itemID = "32213", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Balanced Shadowsong Amethyst
{ itemID = "32214", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Infused Shadowsong Amethyst
{ itemID = "32215", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Glowing Shadowsong Amethyst
{ itemID = "32216", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Royal Shadowsong Amethyst
{ itemID = "32217", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Inscribed Pyrestone
{ itemID = "32218", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Potent Pyrestone
{ itemID = "32219", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Luminous Pyrestone
{ itemID = "32220", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Glinting Pyrestone
{ itemID = "32221", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Veiled Pyrestone
{ itemID = "32222", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Wicked Pyrestone
{ itemID = "32223", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Enduring Seaspray Emerald
{ itemID = "32224", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Radiant Seaspray Emerald
{ itemID = "32225", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Dazzling Seaspray Emerald
{ itemID = "32226", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Jagged Seaspray Emerald
	-- (patch 2.2.0)
{ itemID = "33131", red = 1, yellow = 0, blue = 0, meta = 0 },	-- Crimson Sun
{ itemID = "33133", red = 1, yellow = 0, blue = 0, meta = 0 },	-- Don Julio's Heart
{ itemID = "33134", red = 1, yellow = 0, blue = 0, meta = 0 },	-- Kailee's Rose
{ itemID = "33135", red = 0, yellow = 0, blue = 1, meta = 0 },	-- Falling Star
{ itemID = "33140", red = 0, yellow = 1, blue = 0, meta = 0 },	-- Blood of Ember
{ itemID = "33143", red = 0, yellow = 1, blue = 0, meta = 0 },	-- Stone of Blades
{ itemID = "33144", red = 0, yellow = 1, blue = 0, meta = 0 },	-- Facet of Eternity
{ itemID = "33782", red = 0, yellow = 1, blue = 1, meta = 0 },	-- Steady Talasite
	-- (patch 2.2.2)
{ itemID = "31862", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Balanced Shadow Draenite
{ itemID = "31860", red = 0, yellow = 1, blue = 0, meta = 0 },	-- Great Golden Draenite
{ itemID = "31864", red = 1, yellow = 0, blue = 1, meta = 0 },	-- Infused Shadow Draenite
{ itemID = "31866", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Veiled Flame Spessarite
{ itemID = "31869", red = 1, yellow = 1, blue = 0, meta = 0 },	-- Wicked Flame Spessarite
-- (patch 2.3.0)
{ itemID = "34220", red = 0, yellow = 0, blue = 0, meta = 1 }, 	-- Chaotic Skyfire Diamond
{ itemID = "34256", red = 0, yellow = 0, blue = 1, meta = 0 },	-- Charmed Amani Jewel
-- (patch 2.4.0)
{ itemID = "35503", red = 0, yellow = 0, blue = 0, meta = 1 }, 	-- Ember Skyfire Diamond
{ itemID = "35501", red = 0, yellow = 0, blue = 0, meta = 1 }, 	-- Eternal Earthstorm Diamond
{ itemID = "35707", red = 1, yellow = 0, blue = 1, meta = 0 }, 	-- Regal Nightseye
{ itemID = "34831", red = 0, yellow = 0, blue = 1, meta = 0 }, 	-- Eye of the Sea
{ itemID = "35758", red = 0, yellow = 1, blue = 1, meta = 0 }, 	-- Steady Seaspray Emerald
{ itemID = "35759", red = 0, yellow = 1, blue = 1, meta = 0 }, 	-- Forceful Seaspray Emerald
{ itemID = "35760", red = 1, yellow = 1, blue = 0, meta = 0 }, 	-- Reckless Pyrestone
{ itemID = "35761", red = 0, yellow = 1, blue = 0, meta = 0 }, 	-- Quick Lionseye
-- (patch 2.4.2)
{ itemID = "37503", red = 1, yellow = 0, blue = 1, meta = 0 }, 	-- Purified Shadowsong Amethyst
{ itemID = "35315", red = 0, yellow = 1, blue = 0, meta = 0 }, 	-- Quick Dawnstone
{ itemID = "35316", red = 1, yellow = 1, blue = 0, meta = 0 }, 	-- Reckless Noble Topaz
{ itemID = "35318", red = 0, yellow = 1, blue = 1, meta = 0 }, 	-- Forceful Talasite
-- WOTLK !
-- Red
{ itemID = "40111", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Bold Cardinal Ruby
{ itemID = "40114", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Bright Cardinal Ruby
{ itemID = "40112", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Delicate Cardinal Ruby
{ itemID = "40116", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Flashing Cardinal Ruby
{ itemID = "40117", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Fractured Cardinal Ruby
{ itemID = "34835", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Omar's Gem of POWAH
{ itemID = "40118", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Precise Cardinal Ruby
{ itemID = "40113", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Runed Cardinal Ruby
{ itemID = "40115", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Subtle Cardinal Ruby
{ itemID = "39996", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Bold Scarlet Ruby
{ itemID = "39999", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Bright Scarlet Ruby
{ itemID = "39997", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Delicate Scarlet Ruby
{ itemID = "40001", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Flashing Scarlet Ruby
{ itemID = "40002", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Fractured Scarlet Ruby
{ itemID = "40003", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Precise Scarlet Ruby
{ itemID = "40003", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Precise Scarlet Ruby
{ itemID = "39998", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Runed Scarlet Ruby
{ itemID = "40000", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Subtle Scarlet Ruby
{ itemID = "38292", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Test Living Ruby
{ itemID = "39900", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Bold Bloodstone
{ itemID = "39906", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Bright Bloodstone
{ itemID = "39905", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Delicate Bloodstone
{ itemID = "39908", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Flashing Bloodstone
{ itemID = "39909", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Fractured Bloodstone
{ itemID = "41432", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Perfect Bold Bloodstone
{ itemID = "41433", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Perfect Bright Bloodstone
{ itemID = "41434", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Perfect Delicate Bloodstone
{ itemID = "41435", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Perfect Flashing Bloodstone
{ itemID = "41436", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Perfect Fractured Bloodstone
{ itemID = "41437", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Perfect Precise Bloodstone
{ itemID = "41438", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Perfect Runed Bloodstone
{ itemID = "41439", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Perfect Subtle Bloodstone
{ itemID = "39910", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Precise Bloodstone
{ itemID = "39911", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Runed Bloodstone
{ itemID = "39907", red = 1, yellow = 0, blue = 0, meta = 0 }, -- Subtle Bloodstone
-- Yellow
{ itemID = "40123", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Brilliant King's Amber
{ itemID = "40127", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Mystic King's Amber
{ itemID = "40128", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Quick King's Amber
{ itemID = "40125", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Rigid King's Amber
{ itemID = "40124", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Smooth King's Amber
{ itemID = "40126", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Thick King's Amber
{ itemID = "40012", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Brilliant Autumn's Glow
{ itemID = "40016", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Mystic Autumn's Glow
{ itemID = "40017", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Quick Autumn's Glow
{ itemID = "40014", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Rigid Autumn's Glow
{ itemID = "40013", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Smooth Autumn's Glow
{ itemID = "40015", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Thick Autumn's Glow
{ itemID = "39912", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Brilliant Sun Crystal
{ itemID = "39917", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Mystic Sun Crystal
{ itemID = "41444", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Perfect Brilliant Sun Crystal
{ itemID = "41445", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Perfect Mystic Sun Crystal
{ itemID = "41446", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Perfect Quick Sun Crystal
{ itemID = "41447", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Perfect Rigid Sun Crystal
{ itemID = "41448", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Perfect Smooth Sun Crystal
{ itemID = "41449", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Perfect Thick Sun Crystal
{ itemID = "39918", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Quick Sun Crystal
{ itemID = "39915", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Rigid Sun Crystal 
{ itemID = "39914", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Smooth Sun Crystal
{ itemID = "39916", red = 0, yellow = 1, blue = 0, meta = 0 }, -- Thick Sun Crystal
-- Blue
{ itemID = "40121", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Lustrous Majestic Zircon
{ itemID = "40119", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Solid Majestic Zircon
{ itemID = "40120", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Sparkling Majestic Zircon
{ itemID = "40122", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Stormy Majestic Zircon
{ itemID = "40010", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Lustrous Sky Sapphire
{ itemID = "37430", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Solid Sky Sapphire
{ itemID = "40008", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Solid Sky Sapphire
{ itemID = "40009", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Sparkling Sky Sapphire
{ itemID = "40011", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Stormy Sky Sapphire
{ itemID = "39927", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Lustrous Chalcedony
{ itemID = "41440", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Perfect Lustrous Chalcedony
{ itemID = "41441", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Perfect Solid Chalcedony
{ itemID = "41442", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Perfect Sparkling Chalcedony
{ itemID = "41443", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Perfect Stormy Chalcedony
{ itemID = "39919", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Solid Chalcedony
{ itemID = "39920", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Sparkling Chalcedony
{ itemID = "39932", red = 0, yellow = 0, blue = 1, meta = 0 }, -- Stormy Chalcedony
-- Purple
{ itemID = "40136", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Balanced Dreadstone
{ itemID = "40139", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Defender's Dreadstone
{ itemID = "40132", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Glowing Dreadstone
{ itemID = "40141", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Guardian's Dreadstone
{ itemID = "40137", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Infused Dreadstone
{ itemID = "40135", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Mysterious Dreadstone
{ itemID = "40140", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Puissant Dreadstone
{ itemID = "40133", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Purified Dreadstone
{ itemID = "40138", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Regal Dreadstone
{ itemID = "40134", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Royal Dreadstone
{ itemID = "40130", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Shifting Dreadstone
{ itemID = "40129", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Sovereign Dreadstone
{ itemID = "40131", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Tenuous Dreadstone
{ itemID = "40029", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Balanced Twilight Opal
{ itemID = "40032", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Defender's Twilight Opal
{ itemID = "40025", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Glowing Twilight Opal
{ itemID = "40034", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Guardian's Twilight Opal
{ itemID = "40030", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Infused Twilight Opal
{ itemID = "40028", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Mysterious Twilight Opal
{ itemID = "40033", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Puissant Twilight Opal
{ itemID = "40026", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Purified Twilight Opal
{ itemID = "40031", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Regal Twilight Opal
{ itemID = "40027", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Royal Twilight Opal
{ itemID = "40023", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Shifting Twilight Opal
{ itemID = "40022", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Sovereign Twilight Opal
{ itemID = "40024", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Tenuous Twilight Opal
{ itemID = "39937", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Balanced Shadow Crystal
{ itemID = "39939", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Defender's Shadow Crystal
{ itemID = "39936", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Glowing Shadow Crystal
{ itemID = "39940", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Guardian's Shadow Crystal
{ itemID = "39944", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Infused Shadow Crystal
{ itemID = "39945", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Mysterious Shadow Crystal
{ itemID = "41450", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Perfect Balanced Shadow Crystal
{ itemID = "41451", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Perfect Defender's Shadow Crystal
{ itemID = "41452", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Perfect Glowing Shadow Crystal
{ itemID = "41453", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Perfect Guardian's Shadow Crystal
{ itemID = "41454", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Perfect Infused Shadow Crystal
{ itemID = "41455", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Perfect Mysterious Shadow Crystal
{ itemID = "41456", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Perfect Puissant Shadow Crystal
{ itemID = "41457", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Perfect Purified Shadow Crystal
{ itemID = "41458", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Perfect Regal Shadow Crystal
{ itemID = "41459", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Perfect Royal Shadow Crystal
{ itemID = "41460", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Perfect Shifting Shadow Crystal
{ itemID = "41461", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Perfect Sovereign Shadow Crystal
{ itemID = "41462", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Perfect Tenuous Shadow Crystal
{ itemID = "39933", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Puissant Shadow Crystal
{ itemID = "39941", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Purified Shadow Crystal
{ itemID = "39938", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Regal Shadow Crystal
{ itemID = "39943", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Royal Shadow Crystal
{ itemID = "39935", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Shifting Shadow Crystal
{ itemID = "39934", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Sovereign Shadow Crystal
{ itemID = "39942", red = 1, yellow = 0, blue = 1, meta = 0 }, -- Tenuous Shadow Crystal
-- Green
{ itemID = "40175", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Dazzling Eye of Zul
{ itemID = "40167", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Enduring Eye of Zul
{ itemID = "40179", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Energized Eye of Zul
{ itemID = "40169", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Forceful Eye of Zul
{ itemID = "40174", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Intricate Eye of Zul
{ itemID = "40165", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Jagged Eye of Zul
{ itemID = "40177", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Lambent Eye of Zul
{ itemID = "40171", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Misty Eye of Zul
{ itemID = "40178", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Opaque Eye of Zul
{ itemID = "40180", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Radiant Eye of Zul
{ itemID = "40170", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Seer's Eye of Zul
{ itemID = "40182", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Shattered Eye of Zul
{ itemID = "40172", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Shining Eye of Zul
{ itemID = "40168", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Steady Eye of Zul
{ itemID = "40176", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Sundered Eye of Zul
{ itemID = "40181", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Tense Eye of Zul
{ itemID = "40164", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Timeless Eye of Zul
{ itemID = "40173", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Turbid Eye of Zul
{ itemID = "40166", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Vivid Eye of Zul
{ itemID = "40094", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Dazzling Forest Emerald
{ itemID = "40089", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Enduring Forest Emerald
{ itemID = "40105", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Energized Forest Emerald
{ itemID = "40091", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Forceful Forest Emerald
{ itemID = "40104", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Intricate Forest Emerald
{ itemID = "40086", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Jagged Forest Emerald
{ itemID = "40100", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Lambent Forest Emerald
{ itemID = "40095", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Misty Forest Emerald
{ itemID = "40103", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Opaque Forest Emerald
{ itemID = "40098", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Radiant Forest Emerald
{ itemID = "40092", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Seer's Forest Emerald
{ itemID = "40106", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Shattered Forest Emerald
{ itemID = "40099", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Shining Forest Emerald
{ itemID = "40090", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Steady Forest Emerald
{ itemID = "40096", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Sundered Forest Emerald
{ itemID = "40101", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Tense Forest Emerald
{ itemID = "40232", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Test Dazzling Talasite
{ itemID = "40085", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Timeless Forest Emerald
{ itemID = "40102", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Turbid Forest Emerald
{ itemID = "40088", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Vivid Forest Emerald
{ itemID = "39984", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Dazzling Dark Jade
{ itemID = "39976", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Enduring Dark Jade
{ itemID = "39989", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Energized Dark Jade
{ itemID = "39978", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Forceful Dark Jade
{ itemID = "39983", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Intricate Dark Jade
{ itemID = "39974", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Jagged Dark Jade
{ itemID = "39986", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Lambent Dark Jade
{ itemID = "39980", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Misty Dark Jade
{ itemID = "39988", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Opaque Dark Jade
{ itemID = "41463", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Perfect Dazzling Dark Jade
{ itemID = "41464", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Perfect Enduring Dark Jade
{ itemID = "41465", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Perfect Energized Dark Jade
{ itemID = "41466", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Perfect Forceful Dark Jade
{ itemID = "41467", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Perfect Intricate Dark Jade
{ itemID = "41468", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Perfect Jagged Dark Jade
{ itemID = "41469", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Perfect Lambent Dark Jade
{ itemID = "41470", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Perfect Misty Dark Jade
{ itemID = "41471", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Perfect Opaque Dark Jade
{ itemID = "41472", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Perfect Radiant Dark Jade
{ itemID = "41473", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Perfect Seer's Dark Jade
{ itemID = "41474", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Perfect Shattered Dark Jade
{ itemID = "41475", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Perfect Shining Dark Jade
{ itemID = "41476", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Perfect Steady Dark Jade
{ itemID = "41477", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Perfect Sundered Dark Jade
{ itemID = "41478", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Perfect Tense Dark Jade
{ itemID = "41479", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Perfect Timeless Dark Jade
{ itemID = "41480", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Perfect Turbid Dark Jade
{ itemID = "41481", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Perfect Vivid Dark Jade
{ itemID = "39990", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Radiant Dark Jade
{ itemID = "39979", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Seer's Dark Jade
{ itemID = "39992", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Shattered Dark Jade
{ itemID = "39981", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Shining Dark Jade
{ itemID = "39977", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Steady Dark Jade
{ itemID = "39985", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Sundered Dark Jade
{ itemID = "39991", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Tense Dark Jade
{ itemID = "39968", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Timeless Dark Jade
{ itemID = "39982", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Turbid Dark Jade
{ itemID = "39975", red = 0, yellow = 1, blue = 1, meta = 0 }, -- Vivid Dark Jade
-- Orange
{ itemID = "40162", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Accurate Flawless Ametrine
{ itemID = "40144", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Champion's Flawless Ametrine
{ itemID = "40147", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Deadly Flawless Ametrine
{ itemID = "40150", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Deft Flawless Ametrine
{ itemID = "40154", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Durable Flawless Ametrine
{ itemID = "40158", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Empowered Flawless Ametrine
{ itemID = "40143", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Etched Flawless Ametrine
{ itemID = "40146", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Fierce Flawless Ametrine
{ itemID = "40161", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Glimmering Flawless Ametrine
{ itemID = "40148", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Glinting Flawless Ametrine
{ itemID = "40142", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Inscribed Flawless Ametrine
{ itemID = "40149", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Lucent Flawless Ametrine
{ itemID = "40151", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Luminous Flawless Ametrine
{ itemID = "40152", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Potent Flawless Ametrine
{ itemID = "40157", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Pristine Flawless Ametrine
{ itemID = "40155", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Reckless Flawless Ametrine
{ itemID = "40163", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Resolute Flawless Ametrine
{ itemID = "40145", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Resplendent Flawless Ametrine
{ itemID = "40160", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Stalwart Flawless Ametrine
{ itemID = "40159", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Stark Flawless Ametrine
{ itemID = "40153", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Veiled Flawless Ametrine
{ itemID = "40156", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Wicked Flawless Ametrine
{ itemID = "40058", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Accurate Monarch Topaz
{ itemID = "40039", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Champion's Monarch Topaz
{ itemID = "40043", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Deadly Monarch Topaz
{ itemID = "40046", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Deft Monarch Topaz
{ itemID = "40050", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Durable Monarch Topaz
{ itemID = "40054", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Empowered Monarch Topaz
{ itemID = "40038", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Etched Monarch Topaz
{ itemID = "40041", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Fierce Monarch Topaz
{ itemID = "40057", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Glimmering Monarch Topaz
{ itemID = "40044", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Glinting Monarch Topaz
{ itemID = "40037", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Inscribed Monarch Topaz
{ itemID = "40045", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Lucent Monarch Topaz
{ itemID = "40047", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Luminous Monarch Topaz
{ itemID = "40048", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Potent Monarch Topaz
{ itemID = "40053", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Pristine Monarch Topaz
{ itemID = "40051", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Reckless Monarch Topaz
{ itemID = "40059", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Resolute Monarch Topaz
{ itemID = "40040", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Resplendent Monarch Topaz
{ itemID = "40056", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Stalwart Monarch Topaz
{ itemID = "40055", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Stark Monarch Topaz
{ itemID = "40049", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Veiled Monarch Topaz
{ itemID = "40052", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Wicked Monarch Topaz
{ itemID = "39966", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Accurate Huge Citrine
{ itemID = "39949", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Champion's Huge Citrine
{ itemID = "39952", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Deadly Huge Citrine
{ itemID = "39955", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Deft Huge Citrine
{ itemID = "39958", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Durable Huge Citrine
{ itemID = "39962", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Empowered Huge Citrine
{ itemID = "39948", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Etched Huge Citrine
{ itemID = "39951", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Fierce Huge Citrine
{ itemID = "39965", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Glimmering Huge Citrine
{ itemID = "39953", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Glinting Huge Citrine
{ itemID = "39947", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Inscribed Huge Citrine
{ itemID = "39954", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Lucent Huge Citrine
{ itemID = "39946", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Luminous Huge Citrine
{ itemID = "41482", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Accurate Huge Citrine
{ itemID = "41483", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Champion's Huge Citrine
{ itemID = "41484", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Deadly Huge Citrine
{ itemID = "41485", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Deft Huge Citrine
{ itemID = "41486", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Durable Huge Citrine
{ itemID = "41487", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Empowered Huge Citrine
{ itemID = "41488", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Etched Huge Citrine
{ itemID = "41489", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Fierce Huge Citrine
{ itemID = "41490", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Glimmering Huge Citrine
{ itemID = "41491", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Glinting Huge Citrine
{ itemID = "41492", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Inscribed Huge Citrine
{ itemID = "41493", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Lucent Huge Citrine
{ itemID = "41494", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Luminous Huge Citrine
{ itemID = "41495", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Potent Huge Citrine
{ itemID = "41496", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Pristine Huge Citrine
{ itemID = "41497", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Reckless Huge Citrine
{ itemID = "41498", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Resolute Huge Citrine
{ itemID = "41499", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Resplendent Huge Citrine
{ itemID = "41500", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Stalwart Huge Citrine
{ itemID = "41501", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Stark Huge Citrine
{ itemID = "41502", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Veiled Huge Citrine
{ itemID = "41429", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Perfect Wicked Huge Citrine
{ itemID = "39956", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Potent Huge Citrine
{ itemID = "39961", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Pristine Huge Citrine
{ itemID = "39959", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Reckless Huge Citrine
{ itemID = "39967", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Resolute Huge Citrine
{ itemID = "39950", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Resplendent Huge Citrine
{ itemID = "39964", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Stalwart Huge Citrine
{ itemID = "39963", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Stark Huge Citrine
{ itemID = "39957", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Veiled Huge Citrine
{ itemID = "39960", red = 1, yellow = 1, blue = 0, meta = 0 }, -- Wicked Huge Citrine
-- Meta
{ itemID = "41380", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Austere Earthsiege Diamond
{ itemID = "41389", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Beaming Earthsiege Diamond
{ itemID = "41395", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Bracing Earthsiege Diamond
{ itemID = "41285", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Chaotic Skyflare Diamond
{ itemID = "41307", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Destructive Skyflare Diamond
{ itemID = "41377", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Effulgent Skyflare Diamond
{ itemID = "41333", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Ember Skyflare Diamond
{ itemID = "41335", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Enigmatic Skyflare Diamond
{ itemID = "44081", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Enigmatic Starflare Diamond
{ itemID = "41396", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Eternal Earthsiege Diamond
{ itemID = "41378", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Forlorn Skyflare Diamond
{ itemID = "44084", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Forlorn Starflare Diamond
{ itemID = "41379", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Impassive Skyflare Diamond
{ itemID = "44082", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Impassive Starflare Diamond
{ itemID = "41401", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Insightful Earthsiege Diamond
{ itemID = "41385", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Invigorating Earthsiege Diamond
{ itemID = "44087", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Persistent Earthshatter Diamond
{ itemID = "41381", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Persistent Earthsiege Diamond
{ itemID = "44088", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Powerful Earthshatter Diamond
{ itemID = "41397", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Powerful Earthsiege Diamond
{ itemID = "41398", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Relentless Earthsiege Diamond
{ itemID = "41376", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Revitalizing Skyflare Diamond
{ itemID = "41339", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Swift Skyflare Diamond
{ itemID = "44076", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Swift Starflare Diamond
{ itemID = "41400", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Thundering Skyflare Diamond
{ itemID = "41375", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Tireless Skyflare Diamond
{ itemID = "44078", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Tireless Starflare Diamond
{ itemID = "44089", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Trenchant Earthshatter Diamond
{ itemID = "41382", red = 0, yellow = 0, blue = 0, meta = 1 }, -- Trenchant Earthsiege Diamond
-- Prismatic
{ itemID = "42142", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Bold Dragon's Eye
{ itemID = "36766", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Bright Dragon's Eye
{ itemID = "42148", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Brilliant Dragon's Eye
{ itemID = "42143", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Delicate Dragon's Eye
{ itemID = "42152", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Flashing Dragon's Eye
{ itemID = "42153", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Fractured Dragon's Eye
{ itemID = "42146", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Lustrous Dragon's Eye
{ itemID = "42158", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Mystic Dragon's Eye
{ itemID = "42154", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Precise Dragon's Eye
{ itemID = "42150", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Quick Dragon's Eye
{ itemID = "42156", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Rigid Dragon's Eye
{ itemID = "42144", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Runed Dragon's Eye
{ itemID = "42149", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Smooth Dragon's Eye
{ itemID = "36767", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Solid Dragon's Eye
{ itemID = "42145", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Sparkling Dragon's Eye
{ itemID = "42155", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Stormy Dragon's Eye
{ itemID = "42151", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Subtle Dragon's Eye
{ itemID = "42157", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Thick Dragon's Eye
{ itemID = "34143", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Chromatic Sphere
{ itemID = "42702", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Enchanted Tear
{ itemID = "34142", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Infinite Sphere
{ itemID = "42701", red = 1, yellow = 1, blue = 1, meta = 0 }, -- Enchanted Pearl
};

-- bonus effects, basically a refined version of bonus names indexed by category
 local BONUSSCANNER_EFFECTS = {
	{ effect = "STR", cat = "ATT" },
	{ effect = "AGI", cat = "ATT" },
	{ effect = "STA",	cat = "ATT" },
	{ effect = "INT",	cat = "ATT" },
	{ effect = "SPI",	cat = "ATT" },
	{ effect = "ARMOR", cat = "ATT" },

	{ effect = "ARCANERES", cat = "RES" },
	{ effect = "FIRERES", cat = "RES" },
	{ effect = "NATURERES", cat = "RES" },
	{ effect = "FROSTRES", cat = "RES" },
	{ effect = "SHADOWRES", cat = "RES" },

	{ effect = "DEFENSE", pformat="%d pt", cat = "SKILL" },
	{ effect = "EXPERTISE", pformat="%d pt", cat = "SKILL" },
	{ effect = "FISHING",	cat = "SKILL" },
	{ effect = "HERBALISM", cat = "SKILL" },
	{ effect = "MINING", cat = "SKILL" },
	{ effect = "SKINNING", cat = "SKILL" },
  
	{ effect = "ATTACKPOWER", cat = "BON" },
	{ effect = "ATTACKPOWERUNDEAD", cat = "BON" },
	{ effect = "ATTACKPOWERFERAL", cat = "BON" },
	{ effect = "ARMORPEN", pformat="%.2f%%", cat = "BON" },
	{ effect = "BLOCK", pformat="%.2f%%",	cat = "BON" },
  { effect = "BLOCKVALUE", cat = "BON" },
  { effect = "CRIT", pformat="%.2f%%", cat = "BON" },
  { effect = "DODGE", pformat="%.2f%%", cat = "BON" },
	{ effect = "HASTE",	pformat="%.2f%%",	cat = "BON" },
	{ effect = "TOHIT", pformat="%.2f%%",	cat = "BON" },
	{ effect = "RANGEDHIT", pformat="%.2f%%",	cat = "BON" },
	{ effect = "PARRY", pformat="%.2f%%", cat = "BON" },
	{ effect = "RANGEDATTACKPOWER", cat = "BON" },
  { effect = "RANGEDCRIT", pformat="%.2f%%", cat = "BON" },
  { effect = "RANGEDDMG", cat = "BON" },
	{ effect = "RESILIENCE", pformat="%.2f%%", cat = "BON" },
	{ effect = "DMGWPN", cat = "BON" },
	{ effect = "DPSMAIN", cat = "BON" },
	{ effect = "DPSRANGED", cat = "BON" },
	{ effect = "DPSTHROWN", cat = "BON" },
	
	{ effect = "DMGUNDEAD",	cat = "SBON" },	
	{ effect = "SPELLPOW", cat = "SBON" },
  --{ effect = "HOLYCRIT", pformat="%.2f%%", cat = "SBON" },
	{ effect = "SPELLPEN", cat = "SBON" },
	{ effect = "ARCANEDMG", cat = "SBON" },
	{ effect = "FIREDMG", cat = "SBON" },
	{ effect = "FROSTDMG", cat = "SBON" },
	{ effect = "HOLYDMG", cat = "SBON" },
	{ effect = "NATUREDMG", cat = "SBON" },
	{ effect = "SHADOWDMG", cat = "SBON" },

	{ effect = "HEALTH", cat = "OBON" },
	{ effect = "HEALTHREG",	cat = "OBON" },
	{ effect = "MANA", cat = "OBON" },
	{ effect = "MANAREG",	cat = "OBON" },
	
	{ effect = "THREATREDUCTION",	cat = "EBON" },
	{ effect = "THREATINCREASE",	cat = "EBON" },
	{ effect = "INCRCRITDMG",	cat = "EBON" },
	{ effect = "SPELLREFLECT",	cat = "EBON" },
	{ effect = "SNARERESIST",	cat = "EBON" },
	{ effect = "STUNRESIST",	cat = "EBON" },
	{ effect = "PERCINT",	cat = "EBON" },
	{ effect = "PERCBLOCKVALUE",	cat = "EBON" },
	
	{ effect = "PERCARMOR",	cat = "EBON" },
	{ effect = "PERCMANA",	cat = "EBON" },
	{ effect = "PERCREDSPELLDMG",	cat = "EBON" },
	{ effect = "PERCSNARE",	cat = "EBON" },
	{ effect = "PERCSILENCE",	cat = "EBON" },
	{ effect = "PERCFEAR",	cat = "EBON" },
	{ effect = "PERCSTUN",	cat = "EBON" },
	{ effect = "PERCCRITHEALING",	cat = "EBON" },
};

local BaseRatings = {
{ effect = "EXPERTISE", baseval = 2.5},
{ effect = "DEFENSE", baseval = 1.5},
{ effect = "DODGE", baseval = 12},
{ effect = "PARRY", baseval = 15},
{ effect = "BLOCK", baseval = 5},
{ effect = "TOHIT", baseval = 10},
{ effect = "CRIT", baseval = 14},
{ effect = "RANGEDHIT", baseval = 10},		
{ effect = "RANGEDCRIT", baseval = 14},	 
{ effect = "HASTE", baseval = 10},
{ effect = "SPELLTOHIT", baseval = 8},
{ effect = "SPELLCRIT", baseval = 14},
{ effect = "HOLYCRIT", baseval = 14}, 
{ effect = "SPELLH", baseval = 10},
{ effect = "RESILIENCE", baseval = 25},
{ effect = "ARMORPEN", baseval = 4.69512176513672}																 
}

local function ClassColorise(class, localizedclass)
if not class then return localizedclass or "" end
	local classUpper = strupper(class)
	local pclass = string.gsub(classUpper, " ", "")
	local r = string.format("%x", math.floor(_G["RAID_CLASS_COLORS"][pclass].r * 255))
	if strlen(r) == 1 then
		r = "0"..r
	end
	local g = string.format("%x", math.floor(_G["RAID_CLASS_COLORS"][pclass].g * 255))
	if strlen(g) == 1 then
		g = "0"..g
	end
	local b = string.format("%x", math.floor(_G["RAID_CLASS_COLORS"][pclass].b * 255))
	if strlen(b) == 1 then
		b = "0"..b
	end
	return "|cff"..r..g..b..localizedclass..FONT_COLOR_CODE_CLOSE
end

function BonusScanner:clearCache()
 local k;
	for k in pairs(ItemCache) do
		ItemCache[k] = nil;
	end
end

function BonusScanner:GetRatingMultiplier(level)
		if level < 10 then
			return 52 / (10 - 8)
		elseif level <= 60 then
			return 52 / (level - 8)
		elseif level <= 70 then
			return (-3/82)*level+(131/41)
		else
		  return 1/((82/52)*(131/63)^((level - 70)/10))
		end
end
	
function BonusScanner:GetRatingBonus(type, value,level)
	 local ref, F;
	 for _,ref in pairs (BaseRatings) do
	  if ref.effect==type then
	    F = ref.baseval;
	  end
	 end
		if not F then
			return nil
		end
		return value / F * BonusScanner:GetRatingMultiplier(level)
end

-- Update function to hook into. 
-- Gets called, when Equipment changes (after UNIT_INVENTORY_CHANGED)
function BonusScanner_Update()
end

function BonusScanner:GetBonus(bonus)
	if(BonusScanner.bonuses[bonus]) then
		return BonusScanner.bonuses[bonus];
	end;
	return 0;
end

function BonusScanner:GetSlotBonuses(slotname)
	local i, bonus, details;
	local bonuses = {};
	for bonus, details in pairs(BonusScanner.bonuses_details) do
		if(details[slotname]) then
			bonuses[bonus] = details[slotname];
		end
	end
	return bonuses;
end

function BonusScanner:GetBonusDetails(bonus)
	if(BonusScanner.bonuses_details[bonus]) then
		return BonusScanner.bonuses_details[bonus];
	end;
	return {};
end

function BonusScanner:GetSlotBonus(bonus, slotname)
	if(BonusScanner.bonuses_details[bonus]) then
		if(BonusScanner.bonuses_details[bonus][slotname]) then
			return BonusScanner.bonuses_details[bonus][slotname];
		end;
	end;
	return 0;
end

function BonusScanner:ProcessSpecialBonus (bonus, value, level)
	local specialval = "";
	local points = BonusScanner:GetRatingBonus(bonus, value,level);
		if bonus == "RESILIENCE" then
				specialval = " (-"..format("%.2f%%", points)..L["BONUSSCANNER_SPECIAL1_LABEL"]..")";
		elseif bonus == "EXPERTISE" then			
		  local tempval = points * 0.25;
				specialval = " ("..format("%d pt", points)..", -"..format("%.2f%%", tempval)..L["BONUSSCANNER_SPECIAL2_LABEL"]..")";
		elseif bonus == "DEFENSE" then			
			local tempval = points / 25;			
			  specialval = " ("..format("%d pt", points)..", -"..format("%.2f%%", tempval)..L["BONUSSCANNER_SPECIAL1_LABEL"]..")";
		elseif bonus == "TOHIT" then
			local tempval = BonusScanner:GetRatingBonus("SPELLTOHIT", value,level);
			 specialval = " ("..format("%.2f%%", points)..L["BONUSSCANNER_SPECIAL3_LABEL"]..", "..format("%.2f%%", tempval)..L["BONUSSCANNER_SPECIAL4_LABEL"]..")";
		end		
		return specialval, points;
end

function BonusScanner:GetGemSum(link)
local i;
local tempGemRed = 0;
local tempGemYellow = 0;
local tempGemBlue = 0;
local gem1itemID;
local gem2itemID;
local gem3itemID;
local gem1name, gem1Link = GetItemGem(link, 1);
local gem2name, gem2Link = GetItemGem(link, 2);
local gem3name, gem3Link = GetItemGem(link, 3);
  if gem1name then
      gem1itemID = gem1Link:match("item:(%-?%d+)") or nil;
  end
  if gem2name then
      gem2itemID = gem2Link:match("item:(%-?%d+)") or nil;      
  end
  if gem3name then
      gem3itemID = gem3Link:match("item:(%-?%d+)") or nil;      
  end

	for _,i in pairs (BonusScanner_Gems) do
		if gem1itemID then
				if i.itemID == gem1itemID then
					tempGemRed = tempGemRed + i.red;
					tempGemYellow = tempGemYellow + i.yellow;
					tempGemBlue = tempGemBlue + i.blue;
				end
		end
		if gem2itemID then
				if i.itemID == gem2itemID then
					tempGemRed = tempGemRed + i.red;
					tempGemYellow = tempGemYellow + i.yellow;
					tempGemBlue = tempGemBlue + i.blue;
				end
		end
		if gem3itemID then
				if i.itemID == gem3itemID then
					tempGemRed = tempGemRed + i.red;
					tempGemYellow = tempGemYellow + i.yellow;
					tempGemBlue = tempGemBlue + i.blue;
				end
		end
		
	end
	return tempGemRed, tempGemYellow, tempGemBlue;
end 

function BonusScanner.ProcessTooltip(tooltip, name, link)
BonusScannerTooltip:SetOwner(_G["BonusScannerFrame"],"ANCHOR_NONE");

if BonusScannerConfig.tooltip == 1 then

--itemparams
local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture = GetItemInfo(link);
--check to avoid errors if item is not in the player's cache		
		if not itemLink then return end
--get properties of item		
local baseID, enchantID, gem1ID, gem2ID, gem3ID, socketBonusID, suffixID, instanceID = itemLink:match(
	  "item:(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+)"
	);
--if the item has an older format, use this to get the properties
	if (not baseID) then
		baseID, enchantID, suffixID, instanceID = itemLink:match("item:(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+)");
		gem1ID = "0";
		gem2ID = "0";
		gem3ID = "0";
	end		
	
	if BonusScannerConfig.basiciteminfo == 1 then
	tooltip:AddLine(LIGHTYELLOW_FONT_COLOR_CODE..L["BONUSSCANNER_ITEMID_LABEL"]..baseID..LIGHTYELLOW_FONT_COLOR_CODE..", "..L["BONUSSCANNER_ILVL_LABEL"]..itemLevel);
	tooltip:Show();
	end
	
	if BonusScannerConfig.extendediteminfo == 1 then
	tooltip:AddLine(LIGHTYELLOW_FONT_COLOR_CODE..L["BONUSSCANNER_ENCHANTID_LABEL"]..enchantID..LIGHTYELLOW_FONT_COLOR_CODE..", "..L["BONUSSCANNER_GEM1ID_LABEL"]..gem1ID..LIGHTYELLOW_FONT_COLOR_CODE..", "..L["BONUSSCANNER_GEM2ID_LABEL"]..gem2ID..LIGHTYELLOW_FONT_COLOR_CODE..", "..L["BONUSSCANNER_GEM3ID_LABEL"]..gem3ID);
	tooltip:Show();
	end
	
	
	local e, f, level, ratingval, bonuses, cbonuses;
	local GemnoRed = 0;
	local GemnoYellow = 0;
	local GemnoBlue = 0;
	local cat = ""; 
	local nobonus = true;
	local ifound = false;
	
	-- search the addon cache to locate the itemlink
	-- search for baseID, enchantID, socketed gems and suffixID (for green items). This should cover everything
	for _,f in pairs (ItemCache) do
	if f.baseID==baseID and f.enchantID==enchantID and f.gem1ID==gem1ID and f.gem2ID==gem2ID and f.gem3ID==gem3ID and f.suffixID==suffixID then
	bonuses = f.cbonuses;
	GemnoRed = f.gemsred;
	GemnoYellow = f.gemsyellow;
	GemnoBlue = f.gemsblue;
	ifound = true;
	end
	end
	--ONLY if the item is not in the addon cache do we scan it
	if (ifound) then
	else
	bonuses = BonusScanner:ScanItem(link);
	if gem1ID~="0" or gem2ID~="0" or gem3ID~="0" then
	GemnoRed, GemnoYellow, GemnoBlue = BonusScanner:GetGemSum(link);
	end
	 tinsert(ItemCache, {baseID=baseID, enchantID=enchantID, gem1ID=gem1ID, gem2ID=gem2ID, gem3ID=gem3ID, suffixID=suffixID, setname=BonusScanner.temp.set, gemsred=GemnoRed, gemsyellow=GemnoYellow, gemsblue=GemnoBlue, ilvl=itemLevel, cbonuses=bonuses});
	end
					
	if (bonuses) then
	level = UnitLevel("player");
	
	if next (bonuses) == nil then
	else
	nobonus = false;
	end
	
if not (nobonus) then
tooltip:AddLine(" ");
tooltip:AddLine(L["BONUSSCANNER_BONUSSUM_LABEL"]);

	for _,e in pairs (BONUSSCANNER_EFFECTS) do
	if (bonuses[e.effect]) then
				if(e.cat ~= cat) then
				cat = e.cat;				
				tooltip:AddLine(GREEN_FONT_COLOR_CODE..L["BONUSSCANNER_CAT_"..cat]..":");
				 end
				 --handle rating conversion here
				 if (e.pformat) then
				 	  ratingval, points = BonusScanner:ProcessSpecialBonus (e.effect, bonuses[e.effect], level);
				 	  if ratingval == "" then
				 		ratingval = " ("..format(e.pformat,points)..") ";
				 	  end
				 tooltip:AddLine(LIGHTYELLOW_FONT_COLOR_CODE .. L["BONUSSCANNER_NAMES"][e.effect] .. ": " .. HIGHLIGHT_FONT_COLOR_CODE .. bonuses[e.effect]..ratingval);
				 else
				tooltip:AddLine(LIGHTYELLOW_FONT_COLOR_CODE .. L["BONUSSCANNER_NAMES"][e.effect] .. ": ".. HIGHLIGHT_FONT_COLOR_CODE .. bonuses[e.effect]);
			   end
	end			  
	end
	
	  if IsControlKeyDown() or BonusScannerConfig.showgemcount == 1 then
 	if GemnoRed~=0 or GemnoYellow~=0 or GemnoBlue~=0 then
 	tooltip:AddLine(GREEN_FONT_COLOR_CODE..L["BONUSSCANNER_CAT_GEMS"]..":");
 	end
 	if GemnoRed~=0 then
 	tooltip:AddLine(LIGHTYELLOW_FONT_COLOR_CODE..L["BONUSSCANNER_GEMCOUNT_LABEL"]..RED_FONT_COLOR_CODE..L["BONUSSCANNER_GEMRED_LABEL"]..LIGHTYELLOW_FONT_COLOR_CODE..": "..HIGHLIGHT_FONT_COLOR_CODE..GemnoRed);
 	end
 	if GemnoYellow~=0 then
 	tooltip:AddLine(LIGHTYELLOW_FONT_COLOR_CODE..L["BONUSSCANNER_GEMCOUNT_LABEL"].."|cffffd200"..L["BONUSSCANNER_GEMYELLOW_LABEL"]..LIGHTYELLOW_FONT_COLOR_CODE..": "..HIGHLIGHT_FONT_COLOR_CODE..GemnoYellow);
 	end
 	if GemnoBlue~=0 then
 	tooltip:AddLine(LIGHTYELLOW_FONT_COLOR_CODE..L["BONUSSCANNER_GEMCOUNT_LABEL"].."|cff2459ff"..L["BONUSSCANNER_GEMBLUE_LABEL"]..LIGHTYELLOW_FONT_COLOR_CODE..": "..HIGHLIGHT_FONT_COLOR_CODE..GemnoBlue);
  	end
  	  end --end IsControlKeyDown()
	
tooltip:Show();
		end --end (nobonus)
		end --end if (bonuses)
end --end BonusScannerConfig.tooltip
end --end function ProcessTooltip


function BonusScanner:OnEvent(self, event, a1, ...)
	 
    BonusScanner:Debug(event);

    if (event == "UNIT_INVENTORY_CHANGED") and BonusScanner.active and (a1 == "player") then    		
		  AceTimer.CancelAllTimers("BonusScanner")
			AceTimer.ScheduleTimer("BonusScanner", BonusScanner_OnUpdate, 2)		
			return;
    end
    
	if event == "PLAYER_ENTERING_WORLD" then			
			BonusScanner.active = 1;		
			AceTimer.ScheduleTimer("BonusScanner", BonusScanner_OnUpdate, 1)
			self:RegisterEvent("UNIT_INVENTORY_CHANGED");
			return;
	end
	
	if event == "PLAYER_LEAVING_WORLD" then
		self:UnregisterEvent("UNIT_INVENTORY_CHANGED");
		return;
  end	
    
  if event == "VARIABLES_LOADED" then
        if not BonusScannerConfig then 
        -- initialize default configuration
        BonusScannerConfig = { 
				tooltip = 0; -- 1 for 'Enabled', 0 for 'Disabled'
				basiciteminfo = 0;
				extendediteminfo = 0;
				showgemcount = 0;
        }
        end
        if BonusScannerConfig.tooltip == 1 then
        	TipHooker:Hook(BonusScanner.ProcessTooltip, "item");
        end
   end
    
end


-- A little debug function
function BonusScanner:Debug( Message )
    if (BonusScanner.ShowDebug) then
			DEFAULT_CHAT_FRAME:AddMessage("BonusScanner Debug: " .. Message, 0.5, 0.8, 1);
		end	
end


function BonusScanner_OnUpdate()
	BonusScanner.bonuses, BonusScanner.bonuses_details, BonusScanner.GemsRed, BonusScanner.GemsYellow, BonusScanner.GemsBlue, BonusScanner.AverageiLvl = BonusScanner:ScanEquipment("player"); -- scan the equiped items
	BonusScanner_Update();	  -- call the update function (for the mods using this library)	
end

function BonusScanner:ScanEquipment(target)
	local slotid, slotname, hasItem, i, f, k, itemName, itemLink, ifound;
	local totalLevel = 0;
	local itemLevels = {};
	local tbonuses = {};
	local SetCache = {};
	
	BonusScanner.temp.GemsRed = 0;
	BonusScanner.temp.GemsYellow = 0;
	BonusScanner.temp.GemsBlue = 0;
	BonusScanner.temp.AverageiLvl = 0;
	
	  BonusScannerTooltip:SetOwner(_G["BonusScannerFrame"],"ANCHOR_NONE");

    BonusScanner:Debug("Scanning Equipment has requested");
    
    
-- Phase 1 : Check if the equipped items are cached, if not scan and cache them, if yes get the bonuses from the ItemCache
	for i, slotname in pairs(BonusScanner.slots) do
		slotid, _ = GetInventorySlotInfo(slotname.. "Slot");
		BonusScannerTooltip:ClearLines();
		hasItem = BonusScannerTooltip:SetInventoryItem(target, slotid);
		
	local GemnoRed = 0;
	local GemnoYellow = 0;
	local GemnoBlue = 0;

if hasItem then

		ifound=false;
		itemName, itemLink = BonusScannerTooltip:GetItem();		
		
if itemLink then
		
--get properties of item		
local baseID, enchantID, gem1ID, gem2ID, gem3ID, socketBonusID, suffixID, instanceID = itemLink:match(
	  "item:(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+)"
	);
--if the item has an older format, use this to get the properties
	if (not baseID) then
		baseID, enchantID, suffixID, instanceID = itemLink:match("item:(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+)");
		gem1ID = "0";
		gem2ID = "0";
		gem3ID = "0";
	end	

--search the addon cache to locate the itemlink
	--search for baseID, enchantID, socketed gems and suffixID (for green items). This should cover everything
	for _,f in pairs (ItemCache) do
	if f.baseID==baseID and f.enchantID==enchantID and f.gem1ID==gem1ID and f.gem2ID==gem2ID and f.gem3ID==gem3ID and f.suffixID==suffixID then
	tbonuses = f.cbonuses;
	GemnoRed = f.gemsred;
	GemnoYellow = f.gemsyellow;
	GemnoBlue = f.gemsblue;
	itemLevels[slotname] = f.ilvl or 0;
	ifound = true;
	end
	end
	--ONLY if the item is not in the addon cache do we scan it
	if (ifound) then
	else
	tbonuses = BonusScanner:ScanItem(itemLink);
	itemLevels[slotname] = select(4, GetItemInfo(itemLink)) or 0;
	if gem1ID~="0" or gem2ID~="0" or gem3ID~="0" then
	GemnoRed, GemnoYellow, GemnoBlue = BonusScanner:GetGemSum(itemLink);
	end
	tinsert(ItemCache, {baseID=baseID, enchantID=enchantID, gem1ID=gem1ID, gem2ID=gem2ID, gem3ID=gem3ID, suffixID=suffixID, setname=BonusScanner.temp.set, gemsred=GemnoRed, gemsyellow=GemnoYellow, gemsblue=GemnoBlue, ilvl=itemLevels[slotname], cbonuses=tbonuses});
	end
	
	BonusScanner.temp.GemsRed = BonusScanner.temp.GemsRed + GemnoRed;
	BonusScanner.temp.GemsYellow = BonusScanner.temp.GemsYellow + GemnoYellow;
	BonusScanner.temp.GemsBlue = BonusScanner.temp.GemsBlue + GemnoBlue;
	
end --end if itemLink		
end --end if (hasItem) 
end --end for

-- Handle item Levels
for i,k in pairs (itemLevels) do
 -- ignore Tabard and Shirt item levels
	if i ~= "Tabard" and i ~= "Shirt" then
		if i == "MainHand" and not itemLevels["SecondaryHand"] then
			totalLevel = totalLevel + k * 2;
		else
			totalLevel = totalLevel + k;
		end
	end
end

BonusScanner.temp.AverageiLvl = tonumber(format("%.2f", totalLevel / (#BonusScanner.slots - 2))) -- ignore Tabard and Shirt slots

-- Phase 2: Check if an item is part of a set, if it is, scan the tooltip to ensure set bonuses are picked up
-- if the item is not part of a set, use the cached bonuses if any

 		BonusScanner.temp.bonuses = {};
	  BonusScanner.temp.details = {};
	  BonusScanner.temp.sets = {};
		BonusScanner.temp.set = "";
		
		BonusScannerTooltip:SetOwner(_G["BonusScannerFrame"],"ANCHOR_NONE");
		
for i, slotname in pairs(BonusScanner.slots) do
		slotid, _ = GetInventorySlotInfo(slotname.. "Slot");
		BonusScannerTooltip:ClearLines();
		hasItem = BonusScannerTooltip:SetInventoryItem(target, slotid);

if hasItem then

		itemName, itemLink = BonusScannerTooltip:GetItem();

if itemLink then
		
--get properties of item		
local baseID, enchantID, gem1ID, gem2ID, gem3ID, socketBonusID, suffixID, instanceID = itemLink:match(
	  "item:(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+)"
	);
--if the item has an older format, use this to get the properties
	if (not baseID) then
		baseID, enchantID, suffixID, instanceID = itemLink:match("item:(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+)");
		gem1ID = "0";
		gem2ID = "0";
		gem3ID = "0";
	end

local setnotcached = true;

-- search the addon cache to locate the itemlink
	-- if the item is a set item, we scan it to get the setbonus (if available)
	for _,f in pairs (ItemCache) do
	if f.baseID==baseID and f.enchantID==enchantID and f.gem1ID==gem1ID and f.gem2ID==gem2ID and f.gem3ID==gem3ID and f.suffixID==suffixID and (f.setname~="" or slotname=="Head") then
		  for _,k in pairs (SetCache) do
	   		if k.setname==f.setname then
	   				setnotcached=false;
	   		end
	   end
	if (setnotcached) then
		--DEFAULT_CHAT_FRAME:AddMessage("Checking Set Item:"..itemLink);
	BonusScanner.temp.slot = slotname;
	nosetcheck = false;
  BonusScanner:ScanTooltip();
  	if(BonusScanner.temp.set ~= "") then
			BonusScanner.temp.sets[BonusScanner.temp.set] = 1;
		end
		if f.setname~="" then
	tinsert(SetCache, { setname=f.setname });
		end
	tbonuses = {};
	end --end if (setnotcached)
	
	 end --end if f.baseID==baseID...
	
	if f.baseID==baseID and f.enchantID==enchantID and f.gem1ID==gem1ID and f.gem2ID==gem2ID and f.gem3ID==gem3ID and f.suffixID==suffixID and (f.setname=="" or setnotcached==false) and slotname~="Head" then
	--DEFAULT_CHAT_FRAME:AddMessage("Using Cached data for :"..itemLink);
	tbonuses = f.cbonuses; 
	end
	end --end for

BonusScanner.temp.slot = slotname;
for _,k in pairs (BONUSSCANNER_EFFECTS) do
	if (tbonuses) then
	if tbonuses[k.effect] then
	  	BonusScanner:AddValue(k.effect, tbonuses[k.effect])
	end
	end
end
end --end if itemLink
end --end if (hasItem) 
end --end for

	return BonusScanner.temp.bonuses, BonusScanner.temp.details, BonusScanner.temp.GemsRed, BonusScanner.temp.GemsYellow, BonusScanner.temp.GemsBlue, BonusScanner.temp.AverageiLvl;
end

function BonusScanner:ScanItem(itemlink)
		local k;
		local name = GetItemInfo(itemlink);
		if(name) and name ~="" then		
		BonusScanner.temp.bonuses = {};
		BonusScanner.temp.sets = {};
		BonusScanner.temp.set = "";
		BonusScanner.temp.slot = "";
		nosetcheck = true;
	  BonusScannerTooltip:ClearLines();
	  BonusScannerTooltip:SetHyperlink(itemlink);
		BonusScanner:ScanTooltip();
		return BonusScanner.temp.bonuses;
		end
	return false;
end

function BonusScanner:ScanTooltip()
	local tmpTxt, line, tmpTxt2, line2, rline, r, g, b;
	local lines = BonusScannerTooltip:NumLines();
	local wtype = 0 -- 0 for none, 1 for two-hand, one-hand, main hand or offhand, 2 for ranged, 3 for thrown
		
	for i=2, lines, 1 do
		tmpText = _G["BonusScannerTooltipTextLeft"..i];
		tmpText2 = _G["BonusScannerTooltipTextRight"..i];		
		if (tmpText2:GetText()) then
		line2 = tmpText2:GetText();
		rline = string.find(line2, L["BONUSSCANNER_WEAPON_SPEED"], 1,true);
		end
		if (tmpText:GetText()) then
			line = tmpText:GetText();			 
			 r,g,b = tmpText:GetTextColor();
			r, g, b = ceil(r*255), ceil(g*255), ceil(b*255);
			if rline then
			 line="";
			 rline=nil;
			end
			-- detect weapon type
			if line == _G["INVTYPE_2HWEAPON"] or line == _G["INVTYPE_WEAPON"] or line == _G["INVTYPE_WEAPONMAINHAND"] or line == _G["INVTYPE_WEAPONOFFHAND"] then wtype = 1 end
			if line == _G["INVTYPE_RANGED"] then wtype = 2 end
			if line == _G["INVTYPE_THROWN"] then wtype = 3 end
	BonusScanner:ScanLine(line, r, g, b, wtype);
		end
	end
end
	
		
function BonusScanner:AddValue(effect, value)
	local i,e;
	if(type(effect) == "string") then
		value = tonumber(value);				
	  if (BonusScanner.Verbose) then
			BonusScanner:Debug("Adding Effect: " .. effect .. " Value: " .. value);
		end
		if(BonusScanner.temp.bonuses[effect]) then
			BonusScanner.temp.bonuses[effect] = BonusScanner.temp.bonuses[effect] + value;
		else
			BonusScanner.temp.bonuses[effect] = value;
		end
		
		if(BonusScanner.temp.slot) then
			if(BonusScanner.temp.details[effect]) then
				if(BonusScanner.temp.details[effect][BonusScanner.temp.slot]) then
					BonusScanner.temp.details[effect][BonusScanner.temp.slot] = BonusScanner.temp.details[effect][BonusScanner.temp.slot] + value;
				else
					BonusScanner.temp.details[effect][BonusScanner.temp.slot] = value;
				end
			else
				BonusScanner.temp.details[effect] = {};
				BonusScanner.temp.details[effect][BonusScanner.temp.slot] = value;
			end
		end;
	else 
	-- list of effects
		if(type(value) == "table") then
			for i,e in pairs(effect) do
				BonusScanner:AddValue(e, value[i]);
			end
		else
			for i,e in pairs(effect) do
				BonusScanner:AddValue(e, value);
			end
		end
	end
end;

function BonusScanner:ScanLine(line, r, g, b, wtype)
	local tmpStr, found, newline,f, value;
	BonusScanner:Debug(line .. " (".. string.len(line) .. ")")
	
	-- Experimental : Get rid of gray lines
	if (r==128 and g==128 and b==128) or (string.sub(line,0,10) == "|cff808080") then
	line="";
	return;
	end
		
	-- Check for DPS Template	
	 _, _, _, value = string.find(line, bsDPSTemplate1);
	 
	 if not value then
	 	_, _, _, value = string.find(line, bsDPSTemplate2);
	 end
	 
	 if value and wtype and wtype ~= 0 then
	 	value = string.gsub(value, ",", ".")	 	
	 	if wtype == 1 then BonusScanner:AddValue("DPSMAIN", value) end
	 	if wtype == 2 then BonusScanner:AddValue("DPSRANGED", value) end
	 	if wtype == 3 then BonusScanner:AddValue("DPSTHROWN", value) end
	 end
		
	-- Check for "Equip: "
		if(string.sub(line,0,string.len(ITEM_SPELL_TRIGGER_ONEQUIP)) == ITEM_SPELL_TRIGGER_ONEQUIP) then
		tmpStr = string.sub(line,string.len(ITEM_SPELL_TRIGGER_ONEQUIP)+2);
		BonusScanner:CheckPassive(tmpStr);

	-- Check for "Set: "
	elseif(string.sub(line,0,string.len(L["BONUSSCANNER_PREFIX_SET"])) == L["BONUSSCANNER_PREFIX_SET"]
			and BonusScanner.temp.set ~= "" 
			and not BonusScanner.temp.sets[BonusScanner.temp.set]) and not (nosetcheck) then
		
		tmpStr = string.sub(line,string.len(L["BONUSSCANNER_PREFIX_SET"])+1);
		BonusScanner.temp.slot = "Set";
		BonusScanner:CheckPassive(tmpStr);
		
	--Socket Bonus:
	elseif(string.sub(line,0,string.len(L["BONUSSCANNER_PREFIX_SOCKET"])) == L["BONUSSCANNER_PREFIX_SOCKET"]) then
		--See if the line is green
		--if (color[1] < 0.1 and color[2] > 0.99 and color[3] < 0.1 and color[4] > 0.99) then
		 if (r==0 and g==255 and b==0) then
			tmpStr = string.sub(line,string.len(L["BONUSSCANNER_PREFIX_SOCKET"])+1);
			found = BonusScanner:CheckOther(tmpStr);
		 if(not found) then
		   BonusScanner:CheckGeneric(tmpStr);
		 end
		end

	-- any other line (standard stats, enchantment, set name, etc.)
	else
		
	--enchantment/stat fix for green items
		if (string.sub(line,0,10) == "|cffffffff") then
		newline = string.sub(line,11,-3);
		line = newline
		line = string.gsub(line, "%|$", "" );
		end	
		
		-- Check for set name
		_, _, tmpStr = string.find(line, BONUSSCANNER_PATTERN_SETNAME);
		if(tmpStr) then
			BonusScanner.temp.set = tmpStr;
		  else		  
		 found = BonusScanner:CheckOther(line);
		if(not found) then
		found = BonusScanner:CheckGeneric(line);
		end
		end
	end	
end;

-- Scans passive bonuses like "Set: " and "Equip: "
function BonusScanner:CheckPassive(line)
	local i, p, results, resultCount, found, start, value;

	found = nil;
	for i,p in pairs(L["BONUSSCANNER_PATTERNS_PASSIVE"]) do
		results = {string.find(line, "^" .. p.pattern)};
		resultCount = table.getn(results);
		if(resultCount == 3) then
			BonusScanner:AddValue(p.effect, results[3])
			found = 1;
			break; -- prevent duplicated patterns to cause bonuses to be counted several times
		elseif (resultCount > 3) then
			local values = {};
			for i=3,resultCount do
				table.insert(values,results[i]);
			end
			BonusScanner:AddValue(p.effect,values);
			found = 1;
			break; -- prevent duplicated patterns to cause bonuses to be counted several times
		end
		start, _, value = string.find(line, "^" .. p.pattern);
		if(start) and (p.value) then
				BonusScanner:AddValue(p.effect, p.value);
				found = 1;
				break;
			end
	end
	  if(not found) and (BonusScanner.temp.slot == "Set") then
		  BonusScanner:CheckGeneric(line);
	  end
end

-- Scans generic bonuses like "+3 Intellect" or "Arcane Resistance +4"
-- Changes for TBC (multi value gems)
function BonusScanner:CheckGeneric(line)
	local value, token, pos, pos2, pos3, tmpStr, sep, sepend, found;

-- consolidate multilines	
	line = string.gsub( line, "\n", L["BONUSSCANNER_GLOBAL_SEP"]);
		
	while(string.len(line) > 0) do
	found = false;
	
	-- Nasty hack, the following code has been implemented as the 'final' solution to Blizzard's retarded choice of different 'separators'
	-- meaning symbols to distinguish between multibonus patterns. Essentially what we do is forcibly replace all those different separators
	-- with our own, global one.
	
	for _, sep in ipairs(L["BONUSSCANNER_SEPARATORS"]) do
	line = string.gsub(line, sep,L["BONUSSCANNER_GLOBAL_SEP"]);
	end
	
	-- ensures that set bonuses will not be counted if they arent active
	pos = string.find(line, L["BONUSSCANNER_PREFIX_SET"], 1, true);
	if (pos) then
	line = "";
	end
	
	pos = string.find(line, L["BONUSSCANNER_GLOBAL_SEP"], 1, true);
	if (pos) then
	tmpStr = string.sub(line,1,pos-1);
	line = string.sub(line,pos+string.len(L["BONUSSCANNER_GLOBAL_SEP"]));
	else
	tmpStr = line;
	line = "";
	end
						
		-- trim line
	  tmpStr = string.gsub( tmpStr, "^%s+", "" );
  	tmpStr = string.gsub( tmpStr, "%s+$", "" ); 
    tmpStr = string.gsub( tmpStr, "%.$", "" );
    tmpStr = string.gsub( tmpStr, "\n", "" );    
    
  -- code for debugging purposes
	--DEFAULT_CHAT_FRAME:AddMessage("TmpStr:"..tmpStr);
	--DEFAULT_CHAT_FRAME:AddMessage("Line:"..line);
	--/code for debugging purposes
  
		--Check Prefix (+20 Strength)
		  _, _, value, token = string.find(tmpStr, BONUSSCANNER_PATTERN_GENERIC_PREFIX);
	          	
		--Check Suffix (Strength +20)
		if(not value) then
			_, _, token, value = string.find(tmpStr, BONUSSCANNER_PATTERN_GENERIC_SUFFIX);
		end
		
		--Check Suffix (Strength 20%)
		if(not value) then
			_, _, token, value = string.find(tmpStr, BONUSSCANNER_PATTERN_GENERIC_SUFFIX2);
		end
											
		if(token and value) then		
			-- trim token
		  token = string.gsub( token, "^%s+", "" );
    	token = string.gsub( token, "%s+$", "" );
	    token = string.gsub( token, "%.$", "" );
	    token = string.gsub( token, "|r", "" );
	    	      	      
			if(BonusScanner:CheckToken(token,value)) then
				found = true;
			end
			else
			BonusScanner:CheckOther(tmpStr);
		end
	end
	return found;
end

-- Identifies simple tokens like "Intellect" and composite tokens like "Fire damage" and 
-- add the value to the respective bonus. 
-- returns true if some bonus is found
function BonusScanner:CheckToken(token, value)
	local i, p, s1, s2;
	
	if(L["BONUSSCANNER_PATTERNS_GENERIC_LOOKUP"][token]) then
		BonusScanner:AddValue(L["BONUSSCANNER_PATTERNS_GENERIC_LOOKUP"][token], value);		
		return true;
	else
		s1 = nil;
		s2 = nil;
		for i,p in pairs(L["BONUSSCANNER_PATTERNS_GENERIC_STAGE1"]) do
			if(string.find(token,p.pattern,1,1)) then
				s1 = p.effect;
			end
		end	
		for i,p in pairs(L["BONUSSCANNER_PATTERNS_GENERIC_STAGE2"]) do
			if(string.find(token,p.pattern,1,1)) then
				s2 = p.effect;
			end
		end	
		if(s1 and s2) then
			BonusScanner:AddValue(s1..s2, value);
			return true;
		end 
	end
	return false;
end

-- Last fallback for non generic/special enchants/effects, like "Mana Regen x per 5 sec."
function BonusScanner:CheckOther(line)
	local i, p, value, start, found;

	for i,p in pairs(L["BONUSSCANNER_PATTERNS_OTHER"]) do
		start, _, value = string.find(line, "^" .. p.pattern);
		if(start) then
			BonusScanner:Debug("Special match found: \"" .. p.pattern .. "\"");
			if(p.value) then
				BonusScanner:AddValue(p.effect, p.value)
			elseif(value) then
				BonusScanner:AddValue(p.effect, value)
			end
			return true;
		end
	end
	return false;
end


-- Slash Command functions

function BonusScanner_Cmd(cmd)
local pos, temp, e;
WhisperParam=nil;
IsItem=nil;
--chat = ChatFrameEditBox:GetAttribute("chatType");


		-- Split string for optional params
		-- Itemlink whisper
		pos = string.find(cmd, "]|h|r%s", 1);
		if(pos) then
			WhisperParam = string.sub(cmd,pos+6);
		end
		-- If no space after itemlink treat as regular link regardless of text entered after
		pos = string.find(cmd, "]|h|r", 1);
		if(pos) then
			temp = string.sub(cmd,pos+5);
			cmd = string.sub(cmd,0,(string.len(cmd)-string.len(temp)));
		end
		-- Scan Target whisper
		pos = string.find(cmd, "target%s",1);
		if (pos) then
		 WhisperParam = string.sub(cmd,pos+7);
		 cmd = string.sub(cmd,0,(string.len(cmd)-string.len(WhisperParam))-1);
		end
				
	local _, _, itemlink, itemid = string.find(cmd, "|c%x+|H(item:(%-?%d+):%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+)|h%[.-%]|h|r");
	 
	if(itemid) then
  		local name = GetItemInfo(itemid);
		if(name) and name ~="" then
		
		BonusScannerTooltip:SetOwner(_G["BonusScannerFrame"],"ANCHOR_NONE");
			local bonuses = BonusScanner:ScanItem(itemlink);
			local GemnoRed, GemnoYellow, GemnoBlue = BonusScanner:GetGemSum(itemlink);
			local nobonus= true;
						
			if next (bonuses) == nil then
			else
			nobonus = false;
			end
			
			if not (nobonus) then 
			
			if (WhisperParam)then
			SendChatMessage(L["BONUSSCANNER_IBONUS_LABEL"]..cmd,"WHISPER",nil,WhisperParam)
			else
			DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE .. L["BONUSSCANNER_IBONUS_LABEL"]..cmd);
		  end
		  IsItem=1;
	  	BonusScanner:PrintInfo(bonuses, GemnoRed, GemnoYellow, GemnoBlue);
		  else
		  DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE .. L["BONUSSCANNER_NOBONUS_LABEL"]);
		  end --end if not (nobonus) 
		  else
		  DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE .. L["BONUSSCANNER_FAILEDPARSE_LABEL"]);
  		end --end if (name)
  		return;
  	end
  	if(string.lower(cmd) == "show") then
	  	DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE .. L["BONUSSCANNER_CUREQ_LABEL"]);
	  	DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE .. L["BONUSSCANNER_AVERAGE_ILVL_LABEL"]..": ".."|cffffd200"..BonusScanner.AverageiLvl.."|r")
			BonusScanner:PrintInfo(BonusScanner.bonuses, BonusScanner.GemsRed, BonusScanner.GemsYellow, BonusScanner.GemsBlue);
  		return;
  	end
  	  	
  	if(string.lower(cmd) == "tooltip") then
  	
	  	if BonusScannerConfig.tooltip == 1 then
	  	 TipHooker:Unhook(BonusScanner.ProcessTooltip, "item");
	  	 BonusScannerConfig.tooltip = 0;
	  	 DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIP_STRING"].."["..RED_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIP_DISABLED"]..LIGHTYELLOW_FONT_COLOR_CODE.."]");
	  	 else
	  	 TipHooker:Hook(BonusScanner.ProcessTooltip, "item");
	  	 BonusScannerConfig.tooltip = 1;	  	 
	  	 DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIP_STRING"].."["..GREEN_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIP_ENABLED"]..LIGHTYELLOW_FONT_COLOR_CODE.."]");
	  	 end	  	 
  		return;
  	end
  	
  	if(string.lower(cmd) == "itembasic") then
  			if BonusScannerConfig.basiciteminfo == 1 then
  			  BonusScannerConfig.basiciteminfo = 0;
  			  DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE..L["BONUSSCANNER_BASICLINKID_STRING"].."["..RED_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIP_DISABLED"]..LIGHTYELLOW_FONT_COLOR_CODE.."]");
  			  else
  			  BonusScannerConfig.basiciteminfo = 1;
  			  DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE..L["BONUSSCANNER_BASICLINKID_STRING"].."["..GREEN_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIP_ENABLED"]..LIGHTYELLOW_FONT_COLOR_CODE.."]");
  			  end
  		return;
  	end
  	
  	if(string.lower(cmd) == "itemextend") then
  			if BonusScannerConfig.extendediteminfo == 1 then
  			  BonusScannerConfig.extendediteminfo = 0;
  			  DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE..L["BONUSSCANNER_EXTENDEDLINKID_STRING"].."["..RED_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIP_DISABLED"]..LIGHTYELLOW_FONT_COLOR_CODE.."]");
  			  else
  			  BonusScannerConfig.extendediteminfo = 1;
  			  DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE..L["BONUSSCANNER_EXTENDEDLINKID_STRING"].."["..GREEN_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIP_ENABLED"]..LIGHTYELLOW_FONT_COLOR_CODE.."]");
  			  end
  		return;
  	end
  	
  	if(string.lower(cmd) == "tooltip gems") then
  	if BonusScannerConfig.showgemcount == 1 then
	  	 BonusScannerConfig.showgemcount = 0;
	  	 DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIPGEMS_STRING"].."["..RED_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIP_DISABLED"]..LIGHTYELLOW_FONT_COLOR_CODE.."]");
	  	 else
	  	 BonusScannerConfig.showgemcount = 1;
	  	 DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIPGEMS_STRING"].."["..GREEN_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIP_ENABLED"]..LIGHTYELLOW_FONT_COLOR_CODE.."]");
	  	 end	  	 
  		return;
  	end
  	
  	if(string.lower(cmd) == "clearcache") then
			BonusScanner:clearCache();
			collectgarbage('collect');
			DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE..L["BONUSSCANNER_CACHECLEAR_LABEL"]);
  	 return;
  	end
  	
  	if(string.lower(cmd) == "details") then
	  	DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE .. L["BONUSSCANNER_CUREQDET_LABEL"]);
		BonusScanner:PrintInfoDetailed();
  		return;
  	end
  	if (string.lower(cmd) == "target") then
		local name  = GetUnitName("target");
		if (name) then		
			NotifyInspect("target");  
			local bonuses, details, GemnoRed, GemnoYellow, GemnoBlue, AverageiLvl = BonusScanner:ScanEquipment("target"); -- scan the equiped items
			
			-- if bonuses exists (Todo:  Figure out whether bonuses is empty) then continue
			-- also check if the target is within inspection range
		if (CheckInteractDistance("target", 1)) then
			if UnitIsPlayer("target") and CanInspect("target") then
					
				if (WhisperParam) then
				SendChatMessage(L["BONUSSCANNER_IBONUS_LABEL"]..name..", ".._G["LEVEL"].." "..UnitLevel("target").." "..UnitClass("target"),"WHISPER",nil,WhisperParam)
				SendChatMessage(L["BONUSSCANNER_AVERAGE_ILVL_LABEL"]..": "..AverageiLvl, "WHISPER", nil, WhisperParam)				
				else
				DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE .. L["BONUSSCANNER_IBONUS_LABEL"].."|cffffd200"..name.."|r"..LIGHTYELLOW_FONT_COLOR_CODE..", ".._G["LEVEL"].." "..UnitLevel("target").." "..ClassColorise(select(2,UnitClass("target")), UnitClass("target") ));
				DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE .. L["BONUSSCANNER_AVERAGE_ILVL_LABEL"]..": ".."|cffffd200"..AverageiLvl.."|r")
				end
				BonusScanner:PrintInfo(bonuses, GemnoRed, GemnoYellow, GemnoBlue);
			
			else
			DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE .. L["BONUSSCANNER_INVALIDTAR_LABEL"]);
			end
		else
		DEFAULT_CHAT_FRAME:AddMessage("|cffffd200" .. GetUnitName("target") .. LIGHTYELLOW_FONT_COLOR_CODE..L["BONUSSCANNER_OOR_LABEL"]);
		end --end CheckInteractDistance
				
		else
			DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE .. L["BONUSSCANNER_SELTAR_LABEL"]);
		end --end if (name)
		return;
	end
	for i, slotname in pairs(BonusScanner.slots) do
		if(string.lower(cmd) == string.lower(slotname)) then
		  	DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE .. L["BONUSSCANNER_IBONUS_LABEL"].."'".."|cffffd200" ..slotname .. LIGHTYELLOW_FONT_COLOR_CODE .. "' "..L["BONUSSCANNER_SLOT_LABEL"]);
		  	local bonuses = BonusScanner:GetSlotBonuses(slotname);
		  	IsItem=1;
		  	
		  	local slotid, _ = GetInventorySlotInfo(slotname.. "Slot");
		  	BonusScannerTooltip:ClearLines();
				local hasItem = BonusScannerTooltip:SetInventoryItem("player", slotid);
				if hasItem then
				_, itemLink = BonusScannerTooltip:GetItem();
				GemnoRed, GemnoYellow, GemnoBlue = BonusScanner:GetGemSum(itemLink);		  	
		    BonusScanner:PrintInfo(bonuses, GemnoRed, GemnoYellow, GemnoBlue);
		    end
		  	return
		end;
	end
	--display help text on slash commands
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING1"]..LIGHTYELLOW_FONT_COLOR_CODE..BONUSSCANNER_VERSION..L["BONUSSCANNER_SLASH_STRING1a"]);
  	local k,numitems;
  			numitems = 0;
				for k in pairs(ItemCache) do
				if ItemCache[k] then
				 numitems = numitems + 1;
				end
				end
		DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE..L["BONUSSCANNER_CACHESUMMARY_LABEL"].."|cffffd200"..numitems);
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING2"]);
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING3"]);
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING4"]);
  	if BonusScannerConfig.tooltip == 1 then
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING5"]..GREEN_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIP_ENABLED"]..L["BONUSSCANNER_SLASH_STRING5a"]);
  	else
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING5"]..RED_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIP_DISABLED"]..L["BONUSSCANNER_SLASH_STRING5a"]);
  	end
  	if BonusScannerConfig.showgemcount == 1 then
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING14"]..GREEN_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIP_ENABLED"]..L["BONUSSCANNER_SLASH_STRING14a"]);
  	else
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING14"]..RED_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIP_DISABLED"]..L["BONUSSCANNER_SLASH_STRING14a"]);
  	end
  	if BonusScannerConfig.basiciteminfo == 1 then
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING12"]..GREEN_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIP_ENABLED"]..L["BONUSSCANNER_SLASH_STRING12a"]);
  	else
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING12"]..RED_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIP_DISABLED"]..L["BONUSSCANNER_SLASH_STRING12a"]);
  	end
  	if BonusScannerConfig.extendediteminfo == 1 then
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING13"]..GREEN_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIP_ENABLED"]..L["BONUSSCANNER_SLASH_STRING13a"]);
  	else
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING13"]..RED_FONT_COLOR_CODE..L["BONUSSCANNER_TOOLTIP_DISABLED"]..L["BONUSSCANNER_SLASH_STRING13a"]);
  	end
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING11"]);
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING6"]);
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING7"]);
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING8"]);
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING9"]);
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING10"]);
end

SLASH_BONUSSCANNER1 = "/bonusscanner";
SLASH_BONUSSCANNER2 = "/bscan";
SlashCmdList["BONUSSCANNER"] = BonusScanner_Cmd;

function BonusScanner:PrintInfoDetailed()
	local bonus, name, i, j, slot, first, s, e, ratingval;
	
for _, bonus in pairs(BONUSSCANNER_EFFECTS) do
		if(BonusScanner.bonuses[bonus.effect]) then
			first = true;
			s = "(";
			for j, slot in pairs(BonusScanner.slots) do 
				if(BonusScanner.bonuses_details[bonus.effect][slot]) then
					if(not first) then
						s = s .. ", ";
					else
						first = false;
					end
				  s = s .. 	LIGHTYELLOW_FONT_COLOR_CODE .. slot .. 
								HIGHLIGHT_FONT_COLOR_CODE .. ": " .. BonusScanner.bonuses_details[bonus.effect][slot];
				end
			end;
			if(BonusScanner.bonuses_details[bonus.effect]["Set"]) then
				if(not first) then
					s = s .. ", ";
				end
				s = s .. 	LIGHTYELLOW_FONT_COLOR_CODE .. "Set" .. 
							HIGHLIGHT_FONT_COLOR_CODE .. ": " .. BonusScanner.bonuses_details[bonus.effect]["Set"];
				end
			s = s .. ")";
			--rating conversion handled here
			if (bonus.pformat) then
					ratingval, points = BonusScanner:ProcessSpecialBonus (bonus.effect, BonusScanner.bonuses[bonus.effect], UnitLevel("player"));
					if ratingval == "" then
				 ratingval = " ("..format(bonus.pformat,points)..") ";
				  end
				 else
				 ratingval = "";
			end	 				 
			DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE .. L["BONUSSCANNER_NAMES"][bonus.effect] .. ": " .. HIGHLIGHT_FONT_COLOR_CODE .. BonusScanner.bonuses[bonus.effect] .. ratingval.." " .. s);
		end
	end --end for

end --end function

function BonusScanner:PrintInfo(bonuses,GemnoRed,GemnoYellow,GemnoBlue)
	local bonus, name, e, level, ratingval;
	local cat = "";
		
		if not bonuses then
		return;
		end	
		
	for _,e in pairs (BONUSSCANNER_EFFECTS) do
	  if (bonuses[e.effect]) then
	  --set the level of the target for rating conversions. If we are scanning an item then use the player's level
			local tar = GetUnitName("target");
			if (tar) and IsItem==nil then
	  	level = UnitLevel("target");
	  	else
	  	level = UnitLevel("player");
	  	end
	  	--handle whispers with or without conversion here 
			if (WhisperParam) then
			  if (e.pformat) then
			   if IsItem then
			   ratingval = "";
			   else
			   	ratingval, points = BonusScanner:ProcessSpecialBonus (e.effect, bonuses[e.effect], level);
			   	if ratingval == "" then
				 ratingval = " ("..format(e.pformat,points)..") ";
				  end
				 end				   				 
		       SendChatMessage(L["BONUSSCANNER_NAMES"][e.effect] .. ": " .. bonuses[e.effect]..ratingval,"WHISPER",nil,WhisperParam);
        else
           SendChatMessage(L["BONUSSCANNER_NAMES"][e.effect] .. ": " .. bonuses[e.effect],"WHISPER",nil,WhisperParam);
         end
			else
				 if(e.cat ~= cat) then
				cat = e.cat;				
				DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE..L["BONUSSCANNER_CAT_"..cat]..":");				
				 end
				 --handle rating conversion here
				 if (e.pformat) then
				 	ratingval, points = BonusScanner:ProcessSpecialBonus (e.effect, bonuses[e.effect], level);
				 	if ratingval =="" then
				 ratingval = " ("..format(e.pformat,points)..") ";
				  end
				 DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE .. L["BONUSSCANNER_NAMES"][e.effect] .. ": " .. HIGHLIGHT_FONT_COLOR_CODE .. bonuses[e.effect]..ratingval);
				 else
			     DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE .. L["BONUSSCANNER_NAMES"][e.effect] .. ": " .. HIGHLIGHT_FONT_COLOR_CODE .. bonuses[e.effect]);
			   end			   
			end			
	  end
	end --end for
	
if not (WhisperParam) then	
	if GemnoRed~=0 or GemnoYellow~=0 or GemnoBlue~=0 then
					DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE..L["BONUSSCANNER_CAT_GEMS"]..":");
				 end
				 if GemnoRed~=0 then
					DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE..L["BONUSSCANNER_GEMCOUNT_LABEL"]..RED_FONT_COLOR_CODE..L["BONUSSCANNER_GEMRED_LABEL"]..LIGHTYELLOW_FONT_COLOR_CODE..": "..HIGHLIGHT_FONT_COLOR_CODE..GemnoRed);
				 end
				 if GemnoYellow~=0 then
					DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE..L["BONUSSCANNER_GEMCOUNT_LABEL"].."|cffffd200"..L["BONUSSCANNER_GEMYELLOW_LABEL"]..LIGHTYELLOW_FONT_COLOR_CODE..": "..HIGHLIGHT_FONT_COLOR_CODE..GemnoYellow);
				 end
				if GemnoBlue~=0 then
					DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE..L["BONUSSCANNER_GEMCOUNT_LABEL"].."|cff2459ff"..L["BONUSSCANNER_GEMBLUE_LABEL"]..LIGHTYELLOW_FONT_COLOR_CODE..": "..HIGHLIGHT_FONT_COLOR_CODE..GemnoBlue);
				 end
	else
	  if GemnoRed~=0 or GemnoYellow~=0 or GemnoBlue~=0 then
					SendChatMessage(L["BONUSSCANNER_CAT_GEMS"]..":","WHISPER",nil,WhisperParam);
				 end
				 if GemnoRed~=0 then
					SendChatMessage(L["BONUSSCANNER_GEMCOUNT_LABEL"]..L["BONUSSCANNER_GEMRED_LABEL"]..": "..GemnoRed,"WHISPER",nil,WhisperParam);
				 end
				 if GemnoYellow~=0 then
					SendChatMessage(L["BONUSSCANNER_GEMCOUNT_LABEL"]..L["BONUSSCANNER_GEMYELLOW_LABEL"]..": "..GemnoYellow,"WHISPER",nil,WhisperParam);
				 end
				if GemnoBlue~=0 then
					SendChatMessage(L["BONUSSCANNER_GEMCOUNT_LABEL"]..L["BONUSSCANNER_GEMBLUE_LABEL"]..": "..GemnoBlue,"WHISPER",nil,WhisperParam);
				 end
 end
end --end function

-- Create frame and register events
local BSFrame = CreateFrame("Frame", "BonusScannerFrame")
BSFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
BSFrame:RegisterEvent("PLAYER_LEAVING_WORLD");
BSFrame:RegisterEvent("VARIABLES_LOADED");	

BSFrame:SetScript("OnEvent", function(_, event, ...)
	BonusScanner:OnEvent(BSFrame, event, ...)	
end)