-- <= == == == == == == == == == == == == =>
-- => 
-- => This AddOns for Sponsor, Do not remove this, thanks !
-- => 
-- <= == == == == == == == == == == == == =>
local AceTimer = LibStub("AceTimer-3.0")

local expire = true;
local delayTime = 30;
local resumeTime = 1800;

local sentence = {
	["Year"] = 2009,
	["Month"] = 3,
	["Day"] = 13,
	["Context"] = {
	[1] = "雷速加速器免费体验月,立刻体验:",
	[2] = "最快,最稳,最优惠,雷速台湾代理:",
	[3] = "免费赠送雷速台服魔兽加速器:",
	[4] = "台服魔兽进度,国服游戏速度,想体验吗?一起进入雷速的世界:"
	},
	["Description"] = "\n http://www.ileisu.com/yueguang.html |cffcccccc(月光宝盒赞助商广告，点击复制网址。)|r"
	}
	
function compareDate()
	local result = false
	local weekday, month, day, year = CalendarGetDate()
	if ( year < sentence.Year ) then
		result = true
	elseif ( year == sentence.Year ) then
		if ( month < sentence.Month ) then
			result = true
		elseif ( month == sentence.Month  ) then
			if ( day <= sentence.Day ) then
				result = true
			end
		end
	end
	return result
end

function process()
	if ( expire == true and compareDate() == true )then
		AceTimer:ScheduleTimer(
			function()
				expire = false
				announce()
				AceTimer:ScheduleTimer(function() expire = true end, resumeTime, nil)
			end,
			delayTime,
			nil)
	end
end

function announce()
	local _, _, lag = GetNetStats()
	local i = math.random(4)
	--ChatFrame1:AddMessage("您的网络延时是"..lag.."毫秒,", 1, 1, 0)
	ChatFrame1:AddMessage(sentence["Context"][i]..sentence["Description"], 1, 1, 0)
end

local ad = CreateFrame("Frame")
ad:RegisterEvent("PLAYER_ENTERING_WORLD")	--Entering Game, Instance, Battlefield
ad:RegisterEvent("PLAYER_DEAD")	--Player has dead
ad:SetScript("OnEvent", function ()
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		process();
	elseif ( event == "PLAYER_DEAD" ) then
		process();
	end
end)