--[[
	Auctioneer Advanced - Price Level Utility module
	Version: 5.2.4013 (DingoII)
	Revision: $Id: ScanProgress.lua 4004 2009-01-19 21:10:41Z anaral $
	URL: http://auctioneeraddon.com/

	This is an Auctioneer Advanced module that adds a textual scan progress
	indicator to the Auction House UI.

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
if not AucAdvanced then return end

local libType, libName = "Util", "ScanProgress"
local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end
local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill,_TRANS = AucAdvanced.GetModuleLocals()

function lib.Processor(callbackType, ...)
	if (callbackType == "scanprogress") then
		private.UpdateScanProgress(...)
	elseif (callbackType == "config") then
		private.SetupConfigGui(...)
	elseif (callbackType == "configchanged") then
		private.ConfigChanged(...)
	end
end

function lib.OnLoad()
	--print("AucAdvanced: {{"..libType..":"..libName.."}} loaded!")
	AucAdvanced.Settings.SetDefault("util.scanprogress.activated", true)
	AucAdvanced.Settings.SetDefault("util.scanprogress.leaveshown", true)
end

----  Functions to manage the progress indicator ----
private.scanStartTime = time()
private.scanProgressFormat = "拍卖助手: %s\n扫描页面 %d / %d\n\n平均每秒: %.2f页\n扫描项目: %d\n\n估计剩余时间: %s\n扫描已用时间: %s"

function private.UpdateScanProgress(state, totalAuctions, scannedAuctions, elapsedTime)
	--Check that we're enabled before passing on the callback
	if not AucAdvanced.Settings.GetSetting("util.scanprogress.activated")

	--Check to see if browseoverride has been set, if so gracefully allow it to continue as is
	or AucAdvanced.Settings.GetSetting("util.browseoverride.activated") then
		state = false
	end

	--Change the state if we have not scanned any auctions yet.
	--This is done so that we don't start the timer too soon and thus get skewed numbers
	if (state == nil and (
		not scannedAuctions or
		scannedAuctions == 0 or
		not AucAdvanced.API.IsBlocked() or
		BrowseButton1:IsVisible()
	)) then
		state = true
	end

	--Distribute the callback according to the value of the state variable
	if (state == false) then
		if AucAdvanced.API.IsBlocked() then
			private.HideScanProgressUI()
		end
		return
	elseif (state == true) then
		private.ShowScanProgressUI(totalAuctions)
	end
	if scannedAuctions and scannedAuctions > 0 then
		private.UpdateScanProgressUI(totalAuctions, scannedAuctions, elapsedTime)
	end
end

function private.ShowScanProgressUI(totalAuctions)
	for i=1, NUM_BROWSE_TO_DISPLAY do
		_G["BrowseButton"..i]:Hide()
	end
	BrowseNoResultsText:Show()
	private.scanStartTime = time()
	if totalAuctions and totalAuctions > 0 then
		BrowseNoResultsText:SetText(("扫描 %d 物品中..."):format(totalAuctions))
	else
		BrowseNoResultsText:SetText("扫描中...")
	end
	AucAdvanced.API.BlockUpdate(true, true)
end

function private.HideScanProgressUI()
	if (AucAdvanced.Settings.GetSetting("util.scanprogress.leaveshown")) then
		AucAdvanced.API.BlockUpdate(false, false)
	else
		BrowseNoResultsText:Hide()
		BrowseNoResultsText:SetText(SEARCHING_FOR_ITEMS)

		local numBatchAuctions, totalAuctions = GetNumAuctionItems("list")
		local offset = FauxScrollFrame_GetOffset(BrowseScrollFrame)
		for i=1, NUM_BROWSE_TO_DISPLAY do
			index = offset + i + (NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameBrowse.page)
			if ( index > (numBatchAuctions + (NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameBrowse.page)) ) then
				_G["BrowseButton"..i]:Hide()
			else
				_G["BrowseButton"..i]:Show()
			end
		end
		AucAdvanced.API.BlockUpdate(false, true)
	end
end

function private.UpdateScanProgressUI(totalAuctions, scannedAuctions, elapsedTime)
	local numAuctionsPerPage = NUM_AUCTION_ITEMS_PER_PAGE

	-- Prefer the elapsed time which is provided by core and excludes paused time.
	local secondsElapsed = elapsedTime or (time() - private.scanStartTime)

	local auctionsToScan = totalAuctions - scannedAuctions

	local currentPage = math.floor(scannedAuctions / numAuctionsPerPage)

	local totalPages = totalAuctions / numAuctionsPerPage
	if (totalPages - math.floor(totalPages) > 0) then
		totalPages = math.ceil(totalPages)
	else
		totalPages = math.floor(totalPages)
	end

	local auctionsScannedPerSecond = scannedAuctions / secondsElapsed
	local secondsToScanCompletion = auctionsToScan / auctionsScannedPerSecond

	BrowseNoResultsText:SetText(
		private.scanProgressFormat:format(
			"扫描拍卖中",
			currentPage + 1,
			totalPages,
			auctionsScannedPerSecond,
			scannedAuctions,
			SecondsToTime(secondsToScanCompletion),
			SecondsToTime(secondsElapsed)
		)
	)
end

--Config UI functions
function private.SetupConfigGui(gui)
	-- The defaults for the following settings are set in the lib.OnLoad function
	local id = gui:AddTab(libName, libType.." Modules")
	gui:AddControl(id, "Header",     0,    libName.." Options")

	gui:AddHelp(id, "what scanprogress",
		_TRANS('SPRG_Help_WhatScanProgress'), --"What is the Scan Progress indicator?"
		_TRANS('SPRG_Help_WhatScanProgressAnswer')) --"The Scan Progress indicator is the text that appears while scanning the Auction House. It displays:  the speed of the scan, current auctions and total number of auctions scanned, aswell as the current number of pages and total pages scanned."

--	Old answer, incase the new one is too short and/or vague.
--		"The Scan Progress indicator is the text that appears while scanning the Auction House, indicating "..
--		"how fast you are scanning, how many auctions you have scanned so far, how many total auctions there are, "..
--		"how many pages you have scanned so far, and how many total pages there are.")

	gui:AddControl(id, "Checkbox",   0, 1, "util.scanprogress.activated", _TRANS('SPRG_Interface_Activated')) --"Show a textual progress indicator when scanning"
	gui:AddTip(id, _TRANS('SPRG_HelpTooltip_Activated')) --"Toggles the display of the scan progress indicator\n\nNOTE: This setting is also affected by the CompactUI option to prevent other modules from changing the display of the browse tab while scanning."
	gui:AddControl(id, "Checkbox",   0, 1, "util.scanprogress.leaveshown", _TRANS('SPRG_Interface_LeaveShown')) --"Leave the scan progress text shown after scan completion"
	gui:AddTip(id, _TRANS('SPRG_HelpTooltip_LeaveShown')) --"If toggled, it will leave the scan progress indicator on the screen after scan has completed.\n\nIf disabled it will show the last scanned page."
end

function private.ConfigChanged()
	if (not AucAdvanced.Settings.GetSetting("util.scanprogress.activated")) then
		private.UpdateScanProgress(false)
	elseif (AucAdvanced.Scan.IsScanning()) then
		private.UpdateScanProgress(true)
	end
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.2/Auc-Util-ScanProgress/ScanProgress.lua $", "$Rev: 4004 $")
