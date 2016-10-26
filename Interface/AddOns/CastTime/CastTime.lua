--[[
	Cast Time 1.7.5
		Adds a timer (in seconds) to the casting bar.
		Provides a moveable timer, too.

	By: Moof <Awakened> Blackhand US (Jim Drey, moof@moofit.com)
		now maintanined exi (exi@stc2.ath.cx)

	Thanks to: <zespri@mail.ru> for the Khaos framework
		Veve (dominique@prevot.nom.fr) for the french translation

	Description:
		Supplies 3 different styles for displaying the remaining
		cast time on the CastingBar or somewhere else.
		It also displays the remaining time from mirror timers.
	
	V1.7.5 -AnduinLothar
	 - Fix more bugs with channeled spells
	 
	V1.7.4 -Gryphon
	 - Fix bug with channeled spells

	V1.7.3 -Moof
	 - Fixed a bug where quickly causing a Mirror Timer to appear, then disappear
		(example: submerging, then immediately surfacing) would result in some
		nonsensical numbers being shown as time remaining

	V1.7.2
	 - added again some security checks

	V1.7.1
	 - various bugfixes and security checks

	V1.7.0
	 - switched to more intuitive versioning (game ver + addon revision)
	 - toc updated to 1700
	 - added inline for mirror timers

	V1.4r3
	 - Added Inline option
	 - fixed some minor bugs
	 - Changed some internals so it should work together with ArcaneBar now
	 - Now supplies a changed CastingBarFrame.xml, if you want you can put it to <wow>\Interface\FrameXML\CastingBarFrame.xml
	   This is a workaround for the progressbar displacement.
	 - Fixed channeled castings and added conversion for upgraders (untested)

	$LastChangedBy exi 02-10-2005 05:30 GMT+1$
]]--

-- initialise all variables
CastTime = { };
CastTime.delaySum = 0;
CastTime.endTime = 0;
CastTime.startTime = 0;
CastTime.sign = "+";
CastTime.print = 0;
CastTime.display = 1;
CastTime.delay = 1;
CastTime.hun = 1;
CastTime.flock = 0;
CastTime.outline = 1;
CastTime.mf = 0;
CastTime.spellname = "";
CastTime.inline = 0;
CastTime.mirror = 1;
CastTime.mirrors = {};

function CastTime_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	--Register events and all that good stuff.
end

function CastTime_AfterLoad()
	CastTimeFrame:Hide();
	if (CastTime_Register) then
		CastTime_Register();
	end
	if (CastTime.outline == nil) then
		CastTime.outline = 1;
	end

	if (CastTime.mirror == nil) then
		CastTime.mirror = 1;
	end

	CastTime.mirrors = {};

	this:RegisterEvent("MIRROR_TIMER_STOP");
	this:RegisterEvent("UNIT_SPELLCAST_START");
	this:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START");
	this:RegisterEvent("UNIT_SPELLCAST_DELAYED");
	this:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE");
	this:RegisterEvent("UNIT_SPELLCAST_STOP");
	this:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")

	this:RegisterEvent("UNIT_SPELLCAST_FAILED");
	this:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");

	MirrorTimerFrame_OnUpdate = CastTime_MirrorTimerFrame_OnUpdate;
end

function CastTime_MirrorTimerFrame_OnUpdate(frame, elapsed)
	if (type(frame) ~= "table") then
		return;
	end
	if ( frame.paused ) then
		return;
	end
	local statusbar = getglobal(frame:GetName().."StatusBar");
	frame.value = (frame.value + frame.scale * elapsed);
	statusbar:SetValue(frame.value);
	if (CastTime.mirror == 1) then
		local name = frame.timer;
		local text = getglobal(frame:GetName().."Text");
		if (not CastTime.mirrors) then
			CastTime.mirrors = {};
		end
		if (not CastTime.mirrors[name]) then
			CastTime.mirrors[name] = text:GetText();
		end
		local test, cap = statusbar:GetMinMaxValues();
		local current_time = frame.value - test;
		local subto = 4;
		if (current_time < 10 and CastTime.hun == 0) then
			subto = 3;
		end
		if (current_time >= 100) then
			subto = 3;
		end
		local time = string.sub(math.min(math.max(current_time,0),cap)+0.001, 1, subto);
		text:SetText(CastTime.mirrors[name].." ("..time..")");
	end
end

function CastTime_OnEnter()
	if ( CastTime.flock == 0 ) then
		if ( this:GetCenter() < UIParent:GetCenter() ) then
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		else
			GameTooltip:SetOwner(this, "ANCHOR_LEFT");
		end
		GameTooltip:SetText(CASTTIME_MF_TOOLTIP);
	end
end

function CastTime_OnEvent(event, arg1, arg2, arg3)
	if (event == "VARIABLES_LOADED" ) then
		CastTime_AfterLoad();
	elseif (event == "MIRROR_TIMER_STOP") then
		if (CastTime.mirrors and CastTime.mirrors[arg1]) then
			CastTime.mirrors[arg1] = nil;
		end
	end
	if (arg1 ~= "player") then
		return;
	end
	--If beginning a spell, show the frame and reset the delaycount.
	if (event == "UNIT_SPELLCAST_START") then
		local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitCastingInfo(arg1);
		CastTime.delaySum = 0;
		CastTime.spellname = text;
		CastTime.startTime = startTime / 1000;
		CastTime.maxValue = endTime / 1000;
		CastTimeFrame:Show();
	elseif (event == "UNIT_SPELLCAST_CHANNEL_START") then
		local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitChannelInfo(arg1);
		CastTime.delaySum = 0;
		CastTime.spellname = text;
		CastTime.startTime = startTime / 1000;
		CastTime.endTime = endTime / 1000;
		CastTime.maxValue = CastTime.startTime;
		CastTime.channeling = 1;
		CastTimeFrame:Show();
	elseif (event == "UNIT_SPELLCAST_DELAYED") then
		local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitCastingInfo(arg1);
		CastTime.delaySum = CastTime.delaySum + (endTime / 1000 - CastTime.maxValue);
		CastTime.startTime = startTime / 1000;
		CastTime.maxValue = endTime / 1000;
	elseif (event == "UNIT_SPELLCAST_CHANNEL_UPDATE") then
		local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitChannelInfo(arg1);
		if (CastTime.endTime == nil) then
			CastTime.endTime = 0;
		end
		CastTime.delaySum = CastTime.delaySum + (endTime / 1000 - CastTime.maxValue);
		CastTime.startTime = startTime / 1000;
		CastTime.endTime = endTime / 1000;
		CastTime.maxValue = CastTime.startTime;
	elseif ( event == "UNIT_SPELLCAST_CHANNEL_STOP" ) then
		CastTime.delaySum = 0;
		CastTimeFrame:Hide();
		CastTimeText:SetText("");
		CastTimeMFText:SetText("");
		CastTime.channeling = nil;
	elseif (event == "UNIT_SPELLCAST_STOP") then
		CastTime.delaySum = 0;
		CastTime.sign = "+";
		if ( not CastingBarFrame:IsVisible() ) then
			CastTimeFrame:Hide();
			CastTimeText:SetText("");
			CastTimeMFText:SetText("");
		end
	-- failed/interrupted/loaded
	else
		CastTime.delaySum = 0;
		CastTime.sign = "+";
		CastTimeFrame:Hide();
		CastTimeText:SetText("");
		CastTimeMFText:SetText("");
	end
end

function CastTime_OnUpdate()
	-- Abort if we are disabled or CastingBarFrame
	if (CastTime.display == 0 or ((not CastingBarFrame:IsVisible()) and CastTime.mfnocb == 0)) then
		CastTimeText:SetText("");
		CastTimeMFText:SetText("");
		CastTimeFrame:Hide();
		CastTime.channeling = nil;
		return;
	end

	local current_time;
	if (CastTime.channeling) then
		local time = GetTime();
		if ( time > (CastTime.endTime+1) ) then
			time = CastTime.endTime+1;
		elseif ( time > CastTime.endTime ) then
			time = CastTime.endTime;
		end
		if ( time == CastTime.endTime ) then
			CastTime.channeling = nil;
		end
		current_time = CastTime.endTime - time;
	else
		current_time = CastTime.maxValue - GetTime();
	end

	local subto = 4;
	if (current_time < 10 and CastTime.hun == 0) then
		subto = 3;
	end

	if (current_time < 0) then
		CastTimeText:SetText("");
		CastTimeMFText:SetText("");
		CastingBarFrameText:SetText(CastTime.spellname);
		return;
	end
	local text = string.sub(math.max(current_time,0)+0.001, 1, subto);
	if (CastTime.delaySum ~= 0) then
		local delay = string.sub(math.max(CastTime.delaySum/1000, 0)+0.001, 1, subto);

		if (CastingBarFrame.channeling == 1) then
			CastTime.sign = "-";
		end
		if (delay ~= "0.00" and delay ~= "0.0") then
			text = "|cffcc0000"..CastTime.sign..delay.."|r "..text;
		end
	end

	if (CastTime.mf == 1) then
		CastTimeMFText:SetText(text);
	end
	if (CastTime.outline == 1) then
		CastTimeText:SetText(text);
	end
	if (CastTime.inline == 1) then
		CastingBarFrameText:SetText(CastTime.spellname.." ("..text..")");
	end
end
