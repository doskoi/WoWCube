﻿--[[
	Auctioneer Advanced
	Version: 5.2.4013 (DingoII)
	Revision: $Id: CoreMain.lua 3938 2008-12-27 09:35:32Z norganna $
	URL: http://auctioneeraddon.com/

	This is an addon for World of Warcraft that adds statistical history to the auction data that is collected
	when the auction is scanned, so that you can easily determine what price
	you will be able to sell an item for at auction or at a vendor whenever you
	mouse-over an item in the game

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
]]


--[[
	See CoreAPI.lua for a description of the modules API
]]
if not AucAdvanced then return end

if (not AucAdvancedData) then AucAdvancedData = {} end
if (not AucAdvancedLocal) then AucAdvancedLocal = {} end
if (not AucAdvancedConfig) then AucAdvancedConfig = {} end

local private = {}

-- For our modular stats system, each stats engine should add their
-- subclass to AucAdvanced.Modules.<type>.<name> and store their data into their own
-- data table in AucAdvancedData.Stats.<type><name>
if (not AucAdvanced.Modules) then AucAdvanced.Modules = {Filter={}, Match={}, Stat={}, Util={}} end
if (not AucAdvancedData.Stats) then AucAdvancedData.Stats = {} end
if (not AucAdvancedLocal.Stats) then AucAdvancedLocal.Stats = {} end

-- Load DebugLib
local DebugLib = LibStub("DebugLib")

local tooltip

function private.OnTooltip(tip, item, quantity, name, hyperlink, quality, ilvl, rlvl, itype, isubtype, stack, equiploc, texture)
	if not tip then return end

	tooltip:SetFrame(tip)

	local extra = tooltip:GetExtra()
	AucAdvanced.DecodeLink(item, extra)
	
	if extra.itemType ~= "item" then
		tooltip:ClearFrame(tip)
		return -- Auctioneer hooks into item tooltips only
	end

	local cost
	if extra.event == "SetLootItem" then
		cost = extra.price
	elseif extra.event == "SetAuctionItem" then
		cost = extra.bidAmount
		if cost then cost = cost + extra.minIncrement
		else cost = extra.minBid
		end
	end
	quantity = tonumber(quantity) or 1

	-- Check to see if we need to load scandata
	if AucAdvanced.Settings.GetSetting("scandata.tooltip.display") then
		AucAdvanced.Scan.GetImage()
	end

	local saneLink = AucAdvanced.SanitizeLink(hyperlink)

	tooltip:SetColor(0.3, 0.9, 0.8)
	tooltip:SetMoneyAsText(false)
	tooltip:SetEmbed(false)

	local modules = AucAdvanced.GetAllModules()

	if AucAdvanced.Settings.GetSetting("tooltip.marketprice.show") then
		local market, seen = AucAdvanced.API.GetMarketValue(saneLink)
		--we could just return here, but we want an indication that we don't have any data
        -- NB: So we return a value of 0? That sounds stupid to me... -- Shirik
		-- if not seen then seen = 0 end
		-- if not market then market = 0 end
        if not (seen and market) then
            tooltip:AddLine("市场价: 不可用");
		elseif quantity == 1 then
			tooltip:AddLine("市场价: (看见 "..tostring(seen).."次)", market)
		else
			tooltip:AddLine("市场价 x"..tostring(quantity)..": (看见 "..tostring(seen).."次)", market*quantity)
		end

		if IsShiftKeyDown() then
			for pos, engineLib in ipairs(modules) do
				if engineLib.GetItemPDF then
					local pricearray = engineLib.GetPriceArray(saneLink)
					if pricearray and pricearray.price and pricearray.price > 0 then
						if quantity == 1 then
							tooltip:AddLine("  "..engineLib.libName.." price:", pricearray.price)
						else
							tooltip:AddLine("  "..engineLib.libName.." price x"..tostring(quantity)..":", pricearray.price*quantity)
						end
					end
				end
			end
		end
	end

	for pos, engineLib in ipairs(modules) do
		if (engineLib.Processor) then
			-- TODO: Make these defaults configurable
			tooltip:SetColor(0.3, 0.9, 0.8)
			tooltip:SetMoneyAsText(false)
			tooltip:SetEmbed(false)

			engineLib.Processor("tooltip", tooltip, name, hyperlink, quality, quantity, cost, extra)
		end
	end
	tooltip:ClearFrame(tip)
end

function private.ClickBagHook(hookParams, returnValue, button, ignoreShift)
	--if click-hooks are disabled, do nothing
	if (not AucAdvanced.Settings.GetSetting("clickhook.enable")) then return end

	local bag = this:GetParent():GetID()
	local slot = this:GetID()

	local link = GetContainerItemLink(bag, slot)

	if (AuctionFrame and AuctionFrameBrowse and AuctionFrameBrowse:IsVisible()) then
		if link then
			if (button == "RightButton") and (IsAltKeyDown()) then
				local itemType, itemID = AucAdvanced.DecodeLink(link)
				if (itemType and itemType == "item" and itemID) then
					local itemName = GetItemInfo(tostring(itemID))
					if (itemName) then
						QueryAuctionItems(itemName, "", "", nil, nil, nil, nil, nil)
						BrowseName:SetText(itemName)
					end
				end
			end
		end
	end
end

function private.ClickLinkHook(item, link, button)
	--if click-hooks are disabled, do nothing
	if (not AucAdvanced.Settings.GetSetting("clickhook.enable")) then return end

	if (AuctionFrame and AuctionFrameBrowse and AuctionFrameBrowse:IsVisible()) then
		if link then
			if (button == "LeftButton") and (IsAltKeyDown()) then
				local itemType, itemID = AucAdvanced.DecodeLink(link)
				if (itemType and itemType == "item" and itemID) then
					local itemName = GetItemInfo(tostring(itemID))
					if itemName then
						QueryAuctionItems(itemName, "", "", nil, nil, nil, nil, nil)
						BrowseName:SetText(itemName)
					end
				end
			end
		end
	end
end

function private.HookAH()
	hooksecurefunc("AuctionFrameBrowse_Update", AucAdvanced.API.ListUpdate)
	AucAdvanced.SendProcessorMessage("auctionui")
end

function private.HookTT()
	tooltip = AucAdvanced.GetTooltip()
	tooltip:Activate()
	tooltip:AddCallback(private.OnTooltip, 600)
end

function private.OnLoad(addon)
	addon = addon:lower()

	-- Check if the actual addon itself is loading
	if (addon == "auc-advanced") then
		Stubby.RegisterAddOnHook("Blizzard_AuctionUi", "Auc-Advanced", private.HookAH)
		Stubby.RegisterFunctionHook("ContainerFrameItemButton_OnModifiedClick", -200, private.ClickBagHook)
		hooksecurefunc("ChatFrame_OnHyperlinkShow", private.ClickLinkHook)

		private.HookTT()
		
		for pos, module in ipairs(AucAdvanced.EmbeddedModules) do
			-- These embedded modules have also just been loaded
			private.OnLoad(module)
		end

		-- Check to see if we need to load scandata
		if AucAdvanced.Settings.GetSetting("scandata.force") then
			AucAdvanced.Scan.GetImage()
		end

	end

	-- Notify the actual module if it exists
	local auc, sys, eng = strsplit("-", addon)
	if (auc == "auc" and sys and eng) then
		local engineLib = AucAdvanced.GetAllModules("OnLoad", sys, eng)
		if engineLib then
			engineLib.OnLoad(addon)
		end
	end

	-- Check all modules' load triggers and pass event to processors
	local modules = AucAdvanced.GetAllModules("LoadTriggers")
	for pos, engineLib in ipairs(modules) do
		if engineLib.LoadTriggers[addon] then
			if (engineLib.OnLoad) then
				engineLib.OnLoad(addon)
			end
		end
	end

	-- Notify all processors that an auctioneer addon has loaded
	if auc == "auc" and sys and eng then
		AucAdvanced.SendProcessorMessage("load", addon)
	end
end

function private.OnUnload()
	local modules = AucAdvanced.GetAllModules("OnUnload")
	for pos, engineLib in ipairs(modules) do
		engineLib.OnUnload()
	end
end

private.Schedule = {}
function private.OnEvent(...)
	local event, arg = select(2, ...)
	if (event == "ADDON_LOADED") then
		local addon = string.lower(arg)
		if (addon:sub(1,4) == "auc-") then
			private.OnLoad(addon)
		end
	elseif (event == "AUCTION_HOUSE_SHOW") then
		AucAdvanced.SendProcessorMessage("auctionopen")
	elseif (event == "AUCTION_HOUSE_CLOSED") then
		AucAdvanced.SendProcessorMessage("auctionclose")
		AucAdvanced.Scan.Interrupt()
	elseif (event == "PLAYER_LOGOUT") then
		AucAdvanced.Scan.Commit(true)
		AucAdvanced.Scan.LogoutCommit()
		private.OnUnload()
	elseif event == "UNIT_INVENTORY_CHANGED"
	or event == "ITEM_LOCK_CHANGED"
	or event == "CURSOR_UPDATE"
	or event == "BAG_UPDATE"
	then
		private.Schedule["inventory"] = GetTime() + 0.15
	end
end

function private.OnUpdate(...)
	if event == "inventory" then
		AucAdvanced.Post.AlertBagsChanged()
	end

	local now = GetTime()
	for event, time in pairs(private.Schedule) do
		if time > now then
			AucAdvanced.SendProcessorMessage(event, time)
		end
		private.Schedule[event] = nil
	end
end

private.Frame = CreateFrame("Frame")
private.Frame:RegisterEvent("ADDON_LOADED")
private.Frame:RegisterEvent("AUCTION_HOUSE_SHOW")
private.Frame:RegisterEvent("AUCTION_HOUSE_CLOSED")
private.Frame:RegisterEvent("UNIT_INVENTORY_CHANGED")
private.Frame:RegisterEvent("ITEM_LOCK_CHANGED")
private.Frame:RegisterEvent("CURSOR_UPDATE")
private.Frame:RegisterEvent("BAG_UPDATE")
private.Frame:RegisterEvent("PLAYER_LOGOUT")
private.Frame:SetScript("OnEvent", private.OnEvent)
private.Frame:SetScript("OnUpdate", private.OnUpdate)

-- Auctioneer's debug functions
AucAdvanced.Debug = {}
local addonName = "Auctioneer" -- the addon's name as it will be displayed in
                               -- the debug messages
-------------------------------------------------------------------------------
-- Prints the specified message to nLog.
--
-- syntax:
--    errorCode, message = debugPrint([message][, category][, title][, errorCode][, level])
--
-- parameters:
--    message   - (string) the error message
--                nil, no error message specified
--    category  - (string) the category of the debug message
--                nil, no category specified
--    title     - (string) the title for the debug message
--                nil, no title specified
--    errorCode - (number) the error code
--                nil, no error code specified
--    level     - (string) nLog message level
--                         Any nLog.levels string is valid.
--                nil, no level specified
--
-- returns:
--    errorCode - (number) errorCode, if one is specified
--                nil, otherwise
--    message   - (string) message, if one is specified
--                nil, otherwise
-------------------------------------------------------------------------------
function AucAdvanced.Debug.DebugPrint(message, category, title, errorCode, level)
	return DebugLib.DebugPrint(addonName, message, category, title, errorCode, level)
end

-------------------------------------------------------------------------------
-- Used to make sure that conditions are met within functions.
-- If test is false, the error message will be written to nLog and the user's
-- default chat channel.
--
-- syntax:
--    assertion = assert(test, message)
--
-- parameters:
--    test    - (any)     false/nil, if the assertion failed
--                        anything else, otherwise
--    message - (string)  the message which will be output to the user
--
-- returns:
--    assertion - (boolean) true, if the test passed
--                          false, otherwise
-------------------------------------------------------------------------------
function AucAdvanced.Debug.Assert(test, message)
	return DebugLib.Assert(addonName, test, message)
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.2/Auc-Advanced/CoreMain.lua $", "$Rev: 3938 $")
