local BabbleClass = LibStub("LibBabble-Class-3.0"):GetLookupTable();
local BabbleZone = LibStub("LibBabble-Zone-3.0"):GetLookupTable();
local BabbleInventory = LibStub("LibBabble-Inventory-3.0"):GetLookupTable();
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

AtlasLoot_Data["PVPMENU"] = {
        { 1, "AVMisc", "INV_Jewelry_Necklace_21", "=ds="..BabbleZone["Alterac Valley"], ""};
        { 2, "ABMENU", "INV_Jewelry_Amulet_07", "=ds="..BabbleZone["Arathi Basin"], ""};
        { 4, "Hellfire", "INV_Misc_Token_HonorHold", "=ds="..BabbleZone["Hellfire Peninsula"], "=q5="..AL["Hellfire Fortifications"]};
        { 5, "Zangarmarsh", "Spell_Nature_ElementalPrecision_1", "=ds="..BabbleZone["Zangarmarsh"], "=q5="..AL["Twin Spire Ruins"]};
        { 7, "LakeWintergrasp1", "INV_Misc_Platnumdisks", "=ds="..BabbleZone["Wintergrasp"], ""};
        { 9, "LEVEL60PVPREWARDS", "INV_Axe_02", "=ds="..AL["PvP Rewards (Level 60)"], ""};
        { 10, "LEVEL80PVPREWARDS", "INV_Axe_02", "=ds="..AL["PvP Rewards (Level 80)"], ""};
        { 16, "WSGMENU", "INV_Misc_Rune_07", "=ds="..BabbleZone["Warsong Gulch"], ""};
        { 17, "ABSets1", "INV_Jewelry_Amulet_07", "=ds="..AL["Arathi Basin Sets"], ""};
        { 19, "Terokkar", "INV_Jewelry_FrostwolfTrinket_04", "=ds="..BabbleZone["Terokkar Forest"], "=q5="..AL["Spirit Towers"]};
        { 20, "Nagrand1", "INV_Misc_Rune_09", "=ds="..BabbleZone["Nagrand"], "=q5="..AL["Halaa"]};
        { 24, "LEVEL70PVPREWARDS", "INV_Axe_02", "=ds="..AL["PvP Rewards (Level 70)"], ""};
    };

AtlasLoot_Data["ABMENU"] = {
        { 2, "AB60", "INV_Jewelry_Amulet_07", "=ds="..AL["Level 60 Rewards"], ""};
        { 3, "AB40491", "INV_Jewelry_Amulet_07", "=ds="..AL["Level 40-49 Rewards"], ""};
        { 4, "AB20291", "INV_Jewelry_Amulet_07", "=ds="..AL["Level 20-29 Rewards"], ""};
        { 17, "AB5059", "INV_Jewelry_Amulet_07", "=ds="..AL["Level 50-59 Rewards"], ""};
        { 18, "AB3039", "INV_Jewelry_Amulet_07", "=ds="..AL["Level 30-39 Rewards"], ""};
        { 19, "ABMisc", "INV_Jewelry_Amulet_07", "=ds="..AL["Misc. Rewards"], ""};
        Back = "PVPMENU";
    };

AtlasLoot_Data["WSGMENU"] = {
        { 2, "WSG60", "INV_Misc_Rune_07", "=ds="..AL["Level 60 Rewards"], ""};
        { 3, "WSG4049", "INV_Misc_Rune_07", "=ds="..AL["Level 40-49 Rewards"], ""};
        { 4, "WSG2029", "INV_Misc_Rune_07", "=ds="..AL["Level 20-29 Rewards"], ""};
        { 5, "WSGMisc", "INV_Misc_Rune_07", "=ds="..AL["Misc. Rewards"], ""};
        { 17, "WSG5059", "INV_Misc_Rune_07", "=ds="..AL["Level 50-59 Rewards"], ""};
        { 18, "WSG3039", "INV_Misc_Rune_07", "=ds="..AL["Level 30-39 Rewards"], ""};
        { 19, "WSG1019", "INV_Misc_Rune_07", "=ds="..AL["Level 10-19 Rewards"], ""};
        Back = "PVPMENU";
    };

AtlasLoot_Data["LEVEL60PVPREWARDS"] = {
        { 2, "PvP60Accessories1", "INV_Jewelry_Talisman_09", "=ds="..AL["PvP Accessories"], "=q5="..AL["Level 60"]};
        { 3, "PVPSET", "INV_Axe_02", "=ds="..AL["PvP Armor Sets"], "=q5="..AL["Level 60"]};
        { 17, "PVPWeapons1", "INV_Weapon_Bow_08", "=ds="..AL["PvP Weapons"], "=q5="..AL["Level 60"]};
        Back = "PVPMENU";
    };

AtlasLoot_Data["LEVEL70PVPREWARDS"] = {
        { 2, "PvP70Accessories1", "INV_Jewelry_Talisman_09", "=ds="..AL["PvP Accessories"], "=q5="..AL["Level 70"]};
        { 3, "PVP70RepSET", "INV_Axe_02", "=ds="..AL["PvP Reputation Sets"], "=q5="..AL["Level 70"]};
        { 5, "ARENASET", "INV_Mace_36", "=ds="..AL["Arena PvP Sets"], ""};
        { 17, "PVP70NONSETEPICS", "INV_Boots_05", "=ds="..AL["PvP Non-Set Epics"], "=q5="..AL["Level 70"]};
        { 20, "Arena2Weapons1", "INV_Weapon_Crossbow_10", "=ds="..AL["Arena PvP Weapons"], "=q5="..AL["Season 2"]};
        { 21, "Arena3Weapons1", "INV_Weapon_Crossbow_10", "=ds="..AL["Arena PvP Weapons"], "=q5="..AL["Season 3"]};
        { 22, "Arena4Weapons1", "INV_Weapon_Crossbow_10", "=ds="..AL["Arena PvP Weapons"], "=q5="..AL["Season 4"]};
        Back = "PVPMENU";
    };

AtlasLoot_Data["PVP70NONSETEPICS"] = {
        { 2, "PvP70NonSet2", "INV_Boots_Cloth_12", "=ds="..BabbleInventory["Cloth"], ""};
        { 3, "PvP70NonSet4", "INV_Boots_Plate_06", "=ds="..BabbleInventory["Mail"], ""};
        { 4, "PvP70NonSet1", "INV_Jewelry_Necklace_36", "=ds="..AL["PvP Accessories"], ""};
        { 17, "PvP70NonSet3", "INV_Boots_08", "=ds="..BabbleInventory["Leather"], ""};
        { 18, "PvP70NonSet5", "INV_Boots_Plate_04", "=ds="..BabbleInventory["Plate"], ""};
        Back = "LEVEL70PVPREWARDS";
    };

AtlasLoot_Data["LEVEL80PVPREWARDS"] = {
        { 2, "LEVEL80PVPSETS", "INV_Boots_01", "=ds="..AL["Level 80 PvP Sets"], "" };
        --{ 4, "PvP80Weapons1", "INV_Sword_86", "=ds="..AL["Savage Gladiator\'s Weapons"], "" };
        { 17, "PvP80NonSet1", "INV_Jewelry_Necklace_36", "=ds="..AL["PvP Non-Set Epics"], ""};
        { 19, "DeadlyGladiatorWeapons1", "INV_Sword_86", "=ds="..AL["Deadly Gladiator\'s Weapons"], "" };
        Back = "PVPMENU";
    };

AtlasLoot_Data["LEVEL80PVPSETS"] = {
        { 2, "PvP80DeathKnight", "Spell_Deathknight_DeathStrike", "=ds="..BabbleClass["Deathknight"], ""};
        { 4, "PvP80DruidBalance", "Spell_Nature_InsectSwarm", "=ds="..BabbleClass["Druid"], "=q5="..AL["Balance"]};
        { 5, "PvP80DruidFeral", "Ability_Druid_Maul", "=ds="..BabbleClass["Druid"], "=q5="..AL["Feral"]};
        { 6, "PvP80DruidRestoration", "Spell_Nature_Regeneration", "=ds="..BabbleClass["Druid"], "=q5="..AL["Restoration"]};
        { 8, "PvP80Hunter", "Ability_Hunter_RunningShot", "=ds="..BabbleClass["Hunter"], ""};
        { 10, "PvP80Mage", "Spell_Frost_IceStorm", "=ds="..BabbleClass["Mage"], ""};
        { 12, "PvP80PaladinHoly", "Spell_Holy_HolyBolt", "=ds="..BabbleClass["Paladin"], "=q5="..AL["Holy"]};
        { 13, "PvP80PaladinRetribution", "Spell_Holy_AuraOfLight", "=ds="..BabbleClass["Paladin"], "=q5="..AL["Retribution"]};
        { 17, "PvP80PriestHoly", "Spell_Holy_PowerWordShield", "=ds="..BabbleClass["Priest"], "=q5="..AL["Holy"]};
        { 18, "PvP80PriestShadow", "Spell_Shadow_AntiShadow", "=ds="..BabbleClass["Priest"], "=q5="..AL["Shadow"]};
        { 20, "PvP80Rogue", "Ability_BackStab", "=ds="..BabbleClass["Rogue"], ""};
        { 22, "PvP80ShamanElemental", "Spell_Nature_Lightning", "=ds="..BabbleClass["Shaman"], "=q5="..AL["Elemental"]};
        { 23, "PvP80ShamanEnhancement", "Spell_FireResistanceTotem_01", "=ds="..BabbleClass["Shaman"], "=q5="..AL["Enhancement"]};
        { 24, "PvP80ShamanRestoration", "Spell_Nature_HealingWaveGreater", "=ds="..BabbleClass["Shaman"], "=q5="..AL["Restoration"]};
        { 26, "PvP80Warlock", "Spell_Shadow_CurseOfTounges", "=ds="..BabbleClass["Warlock"], ""};
        { 28, "PvP80Warrior", "Ability_Warrior_BattleShout", "=ds="..BabbleClass["Warrior"], ""};
        Back = "LEVEL80PVPREWARDS";
    };
   
    