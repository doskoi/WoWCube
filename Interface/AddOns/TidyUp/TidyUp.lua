-- <= == == == == == == == == == == == == =>
-- =>   TidyUp.lua
-- =>	v 0.2
-- =>   Tidy Up for Inventory
-- =>   Bryan
-- =>	doskoi.panda@gmail.com
-- <= == == == == == == == == == == == == =>

local debug = false
local compress = nil
local compressing = nil
local process = nil
local itemComp = {}
local inbank = nil
local lastTime = 0
local delayTime = 0.3

local function cout(msg, arg1, arg2, arg3)
	if ( debug == true ) then
		if ( not arg1) then arg1 = 0.82 end
		if ( not arg2) then arg3 = 0.82 end
		if ( not arg2) then arg3 = 0.82 end
		DEFAULT_CHAT_FRAME:AddMessage(msg, arg1, arg2, arg3)
	end
end

Tidyup = CreateFrame("Frame", "Tidyup")

function Tidyup:OnEvent()
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		self:OnLoad()
	elseif ( event == "BANKFRAME_OPENED" ) then
		inbank = true
	elseif ( event == "BANKFRAME_CLOSED" ) then
		inbank = nil
	end
end

function Tidyup:OnUpdate(elapsed)
	lastTime = lastTime + elapsed
	if ( lastTime > delayTime and compress and not compressing ) then
		lastTime = 0
		cout("check")
		Tidyup:CheckComp()
	end
end

function Tidyup:OnLoad()
	Tidyup:RegisterEvent("BANKFRAME_OPENED")
	Tidyup:RegisterEvent("BANKFRAME_CLOSED")
	SlashCmdList["TIDYUP"] = Tidyup.Slash
	SLASH_TIDYUP1 = "/tidyup"
	SLASH_TIDYUP2 = "/tu"

	SetTidyUpButton()
end

function Tidyup:Slash()
	if ( not compress ) then
		Tidyup:Work()
	end
end

--unused
function Tidyup:IdToBoth(id)
	local slot = id
	for i = 0,4 do
		local num = GetContainerNumSlots(i) 
		if ( slot <= num )then
			cout(i..","..slot)
			return i, slot
		end
		slot = slot - num
	end
	return -1,-1
end


function Tidyup:Compress(itemID)
	compressing = true
	local itemSwap = {}
	local bagId, slotId
	local t = 1
	local i, j, b
	if ( inbank ) then
		i = -1 j = 11 b = 1
	else
		i = 0 j = 4 b = 0
	end
	for bagId = i, j do
		for slotId = 1, GetContainerNumSlots(bagId) do
			if (GetContainerItemLink(bagId,slotId)) then
				local ItemLink = GetContainerItemLink(bagId, slotId)
				local stack = select(8,GetItemInfo(ItemLink))
				local total = GetItemCount(ItemLink, b)
				local has = select(2, GetContainerItemInfo(bagId,slotId))

				if (strfind(ItemLink, itemID)) then
					if ( stack > has and has ~= total ) then
						tinsert(itemSwap, t, bagId..","..slotId)
						t = t + 1
					end
				end
			end
		end
	end

	if ( t > 2 ) then
		local k = #itemSwap
		cout("to compress:"..GetItemInfo(itemID)..itemSwap[k].." to "..itemSwap[k-(k-1)])
		local bag1, slot1 = strsplit(",", itemSwap[k])
		local bag2, slot2 = strsplit(",", itemSwap[k-(k-1)])
		Tidyup:SwapItem(bag1, slot1, bag2, slot2)

		cout(GetItemInfo(itemID).." comp done")
	else
		for k, v in pairs(itemComp) do
			if ( v == itemID ) then
				tremove(itemComp, k)
			end
		end
		cout(GetItemInfo(itemID).." not need")
	end

	compressing = nil
end


function Tidyup:SwapItem(bag1, slot1, bag2, slot2)
	ClearCursor()

	local _, _, locked1 = GetContainerItemInfo(bag1, slot1)
	local _, _, locked2 = GetContainerItemInfo(bag2, slot2)

	if not locked1 and not locked2 then
		PickupContainerItem(bag1, slot1)
		PickupContainerItem(bag2, slot2)
	end
end


function Tidyup:CheckComp()
	local i = #itemComp
	cout("compress size: "..i)
	if ( i > 0 ) then
		for k, v in pairs(itemComp) do
			Tidyup:Compress(v)
		end
	else
		compress = nil
		TidyupButton:Enable()
		ChatFrame1:AddMessage(COMP_DONE, 1 , 1, 0)
	end
end


function Tidyup:Work()
	TidyupButton:Disable()

	local bagId, slotId
	local i, j, b
	if ( inbank ) then
		i = -1 j = 11 b = 1
	else
		i = 0 j = 4 b = 0
	end
	for bagId = i, j do
		for slotId = 1, GetContainerNumSlots(bagId) do
			if (GetContainerItemLink(bagId,slotId)) then
				local ItemLink = GetContainerItemLink(bagId, slotId)
				local itemID = Tidyup:GetItemLinkNum(ItemLink)
				local itemName = GetItemInfo(itemID);
				local stack = select(8,GetItemInfo(ItemLink))
				local total = GetItemCount(ItemLink, b)
				local has = select(2, GetContainerItemInfo(bagId,slotId))
				--cout(itemName..","..stack..","..total..","..has)
				if ( stack > 1 and total > 1 and stack > has and has ~= total ) then
					cout("try compress:"..itemName..bagId..","..slotId)
					tinsert(itemComp, itemID)
					Tidyup:Compress(itemID)
					
					compress = true
				end
			end
		end
	end

--[[
	local itemClasses = { GetAuctionItemClasses() };
	if #itemClasses > 0 then
	  local itemClass
	  for _, itemClass in pairs(itemClasses) do
	    cout(itemClass)
	  end
	end
]]
end

function Tidyup:GetItemLinkNum(itemLink)
	if (itemLink) then
		local _, _, itemID = strfind(itemLink,"|c%x+|Hitem:(%d+):.+|h%[.-%]|h|r")
		if (itemID) then
			--cout("itemID:"..itemID)
			return itemID
		else
			return ""
		end
	else
		return ""
	end
end

Tidyup:SetScript("OnEvent", Tidyup.OnEvent)
Tidyup:SetScript("OnUpdate", Tidyup.OnUpdate)
Tidyup:RegisterEvent("PLAYER_ENTERING_WORLD")

--------------------------------
-- Hook Button to Frame
--------------------------------

function SetTidyUpButton()
	if ( IsAddOnLoaded("MyInventory") ) then
		local f = CreateFrame("Button", "TidyupButton", MyInventoryFrame, "UIPanelButtonTemplate");
		f:SetWidth(64)
		f:SetHeight(16)
		f:SetPoint("TOPRIGHT", -56, -8)
		f:SetText(ZIP_TEXT)
		f:SetScript("OnClick", Tidyup.Work)
	else
		local f = CreateFrame("Button", "TidyupButton", ContainerFrame1, "UIPanelButtonTemplate");
		f:SetWidth(64)
		f:SetHeight(16)
		f:SetPoint("TOPRIGHT", -10, -30)
		f:SetText(ZIP_TEXT)
		f:SetScript("OnClick", Tidyup.Work)
	end
end
