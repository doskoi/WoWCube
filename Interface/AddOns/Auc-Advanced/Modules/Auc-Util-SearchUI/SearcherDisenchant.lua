--[[
	Auctioneer Advanced - Search UI - Searcher Disenchant
	Version: 5.2.4013 (DingoII)
	Revision: $Id: SearcherDisenchant.lua 3953 2009-01-05 11:20:56Z brykrys $
	URL: http://auctioneeraddon.com/

	This is a plugin module for the SearchUI that assists in searching by refined paramaters

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit license to use this AddOn with these facilities
		since that is its designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
--]]
-- Create a new instance of our lib with our parent
local lib, parent, private = AucSearchUI.NewSearcher("Disenchant")
if not lib then return end
local print,decode,_,_,replicate,empty,_,_,_,debugPrint,fill = AucAdvanced.GetModuleLocals()
local get,set,default,Const = AucSearchUI.GetSearchLocals()
lib.tabname = "Disenchant"
-- Set our defaults
default("disenchant.profit.min", 1)
default("disenchant.profit.pct", 50)
default("disenchant.level.custom", false)
default("disenchant.level.min", 0)
default("disenchant.level.max", 450)
default("disenchant.adjust.brokerage", true)
default("disenchant.allow.bid", true)
default("disenchant.allow.buy", true)
default("disenchant.maxprice", 10000000)
default("disenchant.maxprice.enable", false)

-- This function is automatically called when we need to create our search parameters
function lib:MakeGuiConfig(gui)
	-- Get our tab and populate it with our controls
	local id = gui:AddTab(lib.tabname, "Searchers")

	-- Add the help
	gui:AddSearcher("Disenchant", "Search for items which can be disenchanted for profit", 100)
	gui:AddHelp(id, "disenchant searcher",
		"What does this searcher do?",
		"This searcher provides the ability to search for items that are able to be disenchanted into reagents that on average will have a greater value than the purchase price of the given item.")

	if not (Enchantrix and Enchantrix.Storage) then
		gui:AddControl(id, "Header",     0,   "Enchantrix not detected")
		gui:AddControl(id, "Note",    0.3, 1, 290, 30,    "Enchantrix must be enabled to search with Disenchant")
		return
	end

	gui:AddControl(id, "Header",     0,      "Disenchant search criteria")

	local last = gui:GetLast(id)

	gui:AddControl(id, "MoneyFramePinned",  0, 1, "disenchant.profit.min", 1, 99999999, "Minimum Profit")
	gui:AddControl(id, "Slider",            0, 1, "disenchant.profit.pct", 1, 100, .5, "Min Discount: %0.01f%%")
	gui:AddControl(id, "Checkbox",          0, 1, "disenchant.level.custom", "Use custom levels")
	gui:AddControl(id, "Slider",            0, 2, "disenchant.level.min", 0, 450, 25, "Minimum skill: %s")
	gui:AddControl(id, "Slider",            0, 2, "disenchant.level.max", 25, 450, 25, "Maximum skill: %s")
	gui:AddControl(id, "Subhead",           0, "Note:")
	gui:AddControl(id, "Note",              0, 1, 290, 30, "The \"Pct\" Column is \% of DE Value")

	gui:SetLast(id, last)
	gui:AddControl(id, "Checkbox",          0.42, 1, "disenchant.allow.bid", "Allow Bids")
	gui:SetLast(id, last)
	gui:AddControl(id, "Checkbox",          0.56, 1, "disenchant.allow.buy", "Allow Buyouts")
	gui:AddControl(id, "Checkbox",          0.42, 1, "disenchant.maxprice.enable", "Enable individual maximum price:")
	gui:AddTip(id, "Limit the maximum amount you want to spend with the Disenchant searcher")
	gui:AddControl(id, "MoneyFramePinned",  0.42, 2, "disenchant.maxprice", 1, 99999999, "Maximum Price for Disenchant")

	gui:AddControl(id, "Subhead",           0.42,    "Fees Adjustment")
	gui:AddControl(id, "Checkbox",          0.42, 1, "disenchant.adjust.brokerage", "Subtract auction fees")
end

function lib.Search(item)
	if not (Enchantrix and Enchantrix.Storage) then
		return false, "Enchantrix not detected"
	end

	if item[Const.QUALITY] <= 1 then
		return false, "Item not disenchantable"
	end

	local bidprice, buyprice = item[Const.PRICE], item[Const.BUYOUT]
	local maxprice = get("disenchant.maxprice.enable") and get("disenchant.maxprice")
	if buyprice <= 0 or not get("disenchant.allow.buy") or (maxprice and buyprice > maxprice) then
		buyprice = nil
	end
	if not get("disenchant.allow.bid") or (maxprice and bidprice > maxprice) then
		bidprice = nil
	end
	if not (bidprice or buyprice) then
		return false, "Does not meet bid/buy requirements"
	end

	local minskill, maxskill
	if get("disenchant.level.custom") then
		minskill = get("disenchant.level.min")
		maxskill = get("disenchant.level.max")
	else
		minskill = 0
		maxskill = Enchantrix.Util.GetUserEnchantingSkill()
	end
	local skillneeded = Enchantrix.Util.DisenchantSkillRequiredForItemLevel(item[Const.ILEVEL], item[Const.QUALITY])
	if (skillneeded < minskill) or (skillneeded > maxskill) then
		return false, "Skill not high enough to disenchant"
	end
	local _, _, _, market = Enchantrix.Storage.GetItemDisenchantTotals(item[Const.LINK])
	if (not market) or (market == 0) then
		return false, "Item not disenchantable"
	end

	--adjust for brokerage costs
	local brokerage = get("disenchant.adjust.brokerage")

	if brokerage then
		market = market * 0.95
	end
	local pct = get("disenchant.profit.pct")
	local minprofit = get("disenchant.profit.min")
	local value = market * (100-pct) / 100
	if value > (market - minprofit) then
		value = market - minprofit
	end
	if buyprice and buyprice <= value then
		return "buy", market
	elseif bidprice and bidprice <= value then
		return "bid", market
	end
	return false, "Not enough profit"
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.2/Auc-Util-SearchUI/SearcherDisenchant.lua $", "$Rev: 3953 $")
