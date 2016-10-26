-- ============================================= --
--                  www.17cube.com               --
-- ============================================= --
local DefaultRepair = {
	["Cost"] = 0,
	["Repair"] = 1,
	["Sell"] = 0,
}

function AutoRepair_OnLoad()
	this:RegisterEvent("MERCHANT_SHOW");
	this:RegisterEvent("VARIABLES_LOADED");
	SlashCmdList["RepairCost"] = function()
		Cost_SlashCommand();
	end
	SLASH_RepairCost1 = "/autorepair";
	SLASH_RepairCost2 = "/ar";

	SetSellButton();
end

function Repair_Register()
	if ( gLim_RegisterButton ) then
	  gLim_RegisterButton (
		AUTOREPAIR_TITLE,
		AUTOREPAIR_OPTION,
		"Interface\\Icons\\Spell_Holy_AvengineWrath",
		function()
			gLimModSecBookShowConfig("gLimAutoRepair");
		end,
		4,
		7
		);
		gLim_RegisterConfigClass("gLimAutoRepair","Auto Repair","CraZy aPpLe");
		gLim_RegisterConfigSection("gLimAutoRepairSection",AUTOREPAIR_TITLE, AUTOREPAIR_TITLE, AUTOREPAIR_TITLE,"gLimAutoRepair");
		gLim_RegisterConfigCheckBox(
			"gLim_Repair_Enable",
			AUTOREPAIR_WINDOW_DISPLAY,
			AUTOREPAIR_WINDOW_DISPLAY_INFO,
			RepairConfig.Repair,
			function(toggle) RepairConfig.Repair = toggle end,
			"gLimAutoRepair"
		);
		gLim_RegisterConfigCheckBox(
			"gLim_Sell_Enable",
			AUTOSELL_TEXT,
			AUTOSELL_DESC,
			RepairConfig.Sell,
			function(toggle) RepairConfig.Sell = toggle end,
			"gLimAutoRepair"
		);
	end
end

function AutoRepair_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		if ( not RepairConfig ) then
			RepairConfig = DefaultRepair;
		end
		Repair_Register();
	end
	if (event == "MERCHANT_SHOW" ) then
		if ( CanMerchantRepair() and RepairConfig.Repair == 1 ) then			
			if (GetRepairAllCost() == 0) then
				local name, description, textureIndex, x, y = GetMapLandmarkInfo( 2 );
			else
				if ( GetRepairAllCost() < GetMoney() ) then				
					RepairAllItems();
					RepairConfig.Cost = RepairConfig.Cost+GetRepairAllCost();
					local gold = nil;
					local silver = nil;
					local copper = nil;
					gold,silver,copper = Cost_Change(GetRepairAllCost());
					if (gold == 0) then
						gold = "";
					else
						gold = format(gold..AUTOREPAIR_TEXT_GOLD);
					end
					if (silver == 0) then
						silver = "";
					else
						silver = format(silver..AUTOREPAIR_TEXT_SILVER);
					end
					if (copper == 0) then
						copper = "";
					else
						copper = format(copper..AUTOREPAIR_TEXT_COPPER);
					end
					ChatFrame1:AddMessage(AUTOREPAIR_TEXT_REPAIRINFO..COLOR_YELLOW..gold..COLOR_SUBWHITE..silver..COLOR_GOLD..copper);
					gold,silver,copper = Cost_Change(RepairConfig.Cost);
					if (gold == 0) then
						gold = "";
					else
						gold = format(gold..AUTOREPAIR_TEXT_GOLD);
					end
					if (silver == 0) then
						silver = "";
					else
						silver = format(silver..AUTOREPAIR_TEXT_SILVER);
					end
					if (copper == 0) then
						copper = "";
					else
						copper = format(copper..AUTOREPAIR_TEXT_COPPER);
					end
				else
					ChatFrame1:AddMessage(AUTOREPAIR_TEXT_REPAIRSORRY);
				end
			end
		end
		if ( RepairConfig.Sell == 1 ) then
			Sell_Junk();
		end
	end
end

function Cost_Change(Cost)
	local Cost_Gold = floor(Cost/10000);
	Cost = Cost - Cost_Gold*10000;
	local Cost_Silver = floor(Cost/100);
	Cost = Cost - Cost_Silver*100;
	local Cost_Copper = Cost;
	return Cost_Gold,Cost_Silver,Cost_Copper;	
end

function Cost_SlashCommand()
	gold,silver,copper = Cost_Change(RepairConfig.Cost);
		if (gold == 0) then
			gold = "";
		else
			gold = format(gold..AUTOREPAIR_TEXT_GOLD);
		end
		if (silver == 0) then
			silver = "";
		else
			silver = format(silver..AUTOREPAIR_TEXT_SILVER);
		end
		if (copper == 0) then
			copper = "";
		else
			copper = format(copper..AUTOREPAIR_TEXT_COPPER);
		end
		if (gold == "" and silver == "" and copper == "") then
			ChatFrame1:AddMessage(AUTOREPAIR_TEXT_NOREPAIR);
		else
			ChatFrame1:AddMessage(AUTOREPAIR_TEXT_TOTALREPAIR..gold..silver..copper..".");	
		end
end

function Sell_Junk()
	if not MerchantFrame:IsVisible() then
		return 0;
	end

	local bagId, slotId
	for bagId = 0, 4 do
		for slotId = 1, GetContainerNumSlots(bagId) do
			local itemLink = GetContainerItemLink(bagId, slotId);
			if ( itemLink ) then
				local itemRarity = select(3, GetItemInfo(itemLink));
				if ( itemRarity and itemRarity == 0 ) then
					UseContainerItem(bagId, slotId)
					ChatFrame1:AddMessage(SELL_TEXT..": "..itemLink, 1, 1, 0)
				end	
			end
		end
	end	
end

function SetSellButton()
	local f = CreateFrame("Button", "SellButton", MerchantFrame, "UIPanelButtonTemplate");
	f:SetWidth(80)
	f:SetHeight(18)
	f:SetPoint("BOTTOMLEFT", 96, 66)
	f:SetText(SELL_JUNK)
	f:SetScript("OnClick", Sell_Junk)
end
