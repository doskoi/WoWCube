local BabbleClass = LibStub("LibBabble-Class-3.0"):GetLookupTable();
local BabbleZone = LibStub("LibBabble-Zone-3.0"):GetLookupTable();
local BabbleInventory = LibStub("LibBabble-Inventory-3.0"):GetLookupTable();
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

AtlasLoot_Data["WORLDEVENTMENU"] = {
        { 2, "Brewfest1", "INV_Cask_04", "=ds="..AL["Brewfest"], "=q5="..AL["Various Locations"]};
        { 3, "Winterviel1", "INV_Holiday_Christmas_Present_01", "=ds="..AL["Feast of Winter Veil"], "=q5="..AL["Various Locations"]};
        { 4, "HarvestFestival", "INV_Misc_Food_33", "=ds="..AL["Harvest Festival"], "=q5="..AL["Various Locations"]};
        { 5, "LunarFestival1", "INV_Misc_ElvenCoins", "=ds="..AL["Lunar Festival"], "=q5="..AL["Various Locations"]};
        { 6, "Noblegarden", "INV_Egg_03", "=ds="..AL["Noblegarden"], "=q5="..AL["Various Locations"]};
        { 8, "BashirLanding", "INV_Trinket_Naxxramas02", "=ds="..AL["Bash'ir Landing Skyguard Raid"], "=q5="..BabbleZone["Blade's Edge Mountains"]};
        { 9, "GurubashiArena", "INV_Box_02", "=ds="..AL["Gurubashi Arena Booty Run"], "=q5="..BabbleZone["Stranglethorn Vale"]};
        { 10, "Shartuul", "INV_Misc_Rune_04", "=ds="..AL["Shartuul"], "=q5="..BabbleZone["Blade's Edge Mountains"]};
        { 12, "ABYSSALMENU", "INV_Staff_13", "=ds="..AL["Abyssal Council"], "=q5="..BabbleZone["Silithus"]};
        { 13, "SKETTISMENU", "Spell_Nature_NaturesWrath", "=ds="..AL["Skettis"], "=q5="..BabbleZone["Terokkar Forest"]};
        { 17, "ChildrensWeek", "Ability_Hunter_BeastCall", "=ds="..AL["Children's Week"], "=q5="..AL["Various Locations"]};
        { 18, "Halloween1", "INV_Misc_Bag_28_Halloween", "=ds="..AL["Hallow's End"], "=q5="..AL["Various Locations"]};
        { 19, "Valentineday", "INV_ValentinesBoxOfChocolates02", "=ds="..AL["Love is in the Air"], "=q5="..AL["Various Locations"]};
        { 20, "MidsummerFestival", "INV_SummerFest_FireFlower", "=ds="..AL["Midsummer Fire Festival"], "=q5="..AL["Various Locations"]};
        { 23, "ElementalInvasion", "INV_DataCrystal03", "=ds="..AL["Elemental Invasion"], "=q5="..AL["Various Locations"]};
        { 24, "ScourgeInvasionEvent1", "INV_Jewelry_Talisman_13", "=ds="..AL["Scourge Invasion"], "=q5="..AL["Various Locations"]};
        { 25, "FishingExtravaganza", "INV_Fishingpole_02", "=ds="..AL["Stranglethorn Fishing Extravaganza"], "=q5="..BabbleZone["Stranglethorn Vale"]};
        { 27, "ETHEREUMMENU", "INV_Misc_PunchCards_Prismatic", "=ds="..AL["Ethereum Prison"], ""};
	};

AtlasLoot_Data["SKETTISMENU"] = {
        { 2, "DarkscreecherAkkarai", "INV_Misc_Rune_07", "=ds="..AL["Darkscreecher Akkarai"], ""};
        { 3, "GezzaraktheHuntress", "INV_Misc_Rune_07", "=ds="..AL["Gezzarak the Huntress"], ""};
        { 4, "Terokk", "INV_Misc_Rune_07", "=ds="..AL["Terokk"], ""};
        { 17, "Karrog", "INV_Misc_Rune_07", "=ds="..AL["Karrog"], ""};
        { 18, "VakkiztheWindrager", "INV_Misc_Rune_07", "=ds="..AL["Vakkiz the Windrager"], ""};
        Back = "WORLDEVENTMENU";
    };

AtlasLoot_Data["ETHEREUMMENU"] = {
        { 2, "ArmbreakerHuffaz", "INV_Jewelry_Ring_59", "=ds="..AL["Armbreaker Huffaz"], ""};
        { 3, "Forgosh", "INV_Boots_05", "=ds="..AL["Forgosh"], ""};
        { 4, "MalevustheMad", "INV_Boots_Chain_04", "=ds="..AL["Malevus the Mad"], ""};
        { 5, "WrathbringerLaztarash", "INV_Misc_Orb_01", "=ds="..AL["Wrathbringer Laz-tarash"], ""};
        { 17, "FelTinkererZortan", "INV_Boots_Chain_08", "=ds="..AL["Fel Tinkerer Zortan"], ""};
        { 18, "Gulbor", "INV_Jewelry_Necklace_29Naxxramas", "=ds="..AL["Gul'bor"], ""};
        { 19, "PorfustheGemGorger", "INV_Boots_Cloth_01", "=ds="..AL["Porfus the Gem Gorger"], ""};
        { 20, "BashirStasisChambers", "INV_Trinket_Naxxramas02", "=ds="..AL["Bash'ir Landing Stasis Chambers"], ""};
        Back = "WORLDEVENTMENU";
    };

AtlasLoot_Data["ABYSSALMENU"] = {
        { 2, "Templars", "INV_Jewelry_Talisman_05", "=ds="..AL["Abyssal Council"].." - "..AL["Templars"], ""};
        { 3, "HighCouncil", "INV_Staff_13", "=ds="..AL["Abyssal Council"].." - "..AL["High Council"], ""};
        { 17, "Dukes", "INV_Jewelry_Ring_36", "=ds="..AL["Abyssal Council"].." - "..AL["Dukes"], ""};
        Back = "WORLDEVENTMENU";
    };    