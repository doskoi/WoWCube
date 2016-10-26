gLimModMasterFrame_IsLoading = false 
local gLimModNow_Seting = {} 
local gLimModOLD_Seting = {} 
 gLimModNow_ConfigIndex = -1 
 gLimMod_ConfigList_MAXEVERYPAGECOUNT = 10 
 gLimMod_ConfigList_MAXCOUNT = 32 
 gLimModSubTopPosition = 100 

StaticPopupDialogs["SAVE_QUESTION"] = {
	text = GLIM_SAVE_QUESTION,
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		gLimModMaster_SetNewConfig() 
		gLim_Configurations[gLimModNow_ConfigIndex][GLIM_VARIABLES] = gLimModNow_Seting;
		ShowUIPanel(gLimConfigSubFrame)
	end,
	timeout = 0,
	showAlert = 1,
};

 function secBook_OnLoad() 
	this:RegisterForDrag("LeftButton")
	tinsert(UISpecialFrames, "gLimConfigSubFrame");
 end
function secBook_OnDragStart() 
	gLimConfigSubFrame:StartMoving() 
	lBeingDragged = 1 
 end
function secBook_OnDragStop() 
	gLimConfigSubFrame:StopMovingOrSizing() 
	lBeingDragged = nil 
 end
function gLimModSecBookShowConfig(GLIMValuesHead)
	local oldConfigIndex = gLimModNow_ConfigIndex 
	 gLimModMasterFrame_IsLoading = true 
	 gLimModNew_Seting = {} 
	 gLimModMaster_GetConfigData(GLIMValuesHead) 
	 gLimModMaster_DrawData() 
	 if (gLimConfigSubFrame:IsVisible()) then
		 if oldConfigIndex == gLimModNow_ConfigIndex then
			HideUIPanel(gLimConfigSubFrame)
		 end 
	 else
		 ShowUIPanel(gLimConfigSubFrame)
		 gLimConfigSubFrame:SetPoint("TopLeft", "UIParent", "BottomLeft",320,GetScreenHeight()/2+300) 
	 end 
	 gLimModMasterFrame_IsLoading = false 
 end 
 local function CloneTable(t)		-- return a copy of the table t
	local new = {};				-- create a new table
	local i, v = next(t, nil);		-- i is an index of t, v = t[i]
	while i do
		if type(v)=="table" then 
			v=CloneTable(v);
		end 
		new[i] = v;
		i, v = next(t, i);			-- get next index
	end
	return new;
end
 function gLimModMaster_GetConfigData(GLIMValuesHead) 
	 if gLim_Configurations ~= nil then
		 local TotalConfigCount = #(gLim_Configurations) 
		 for k=1,TotalConfigCount,1 do 
			 if (gLim_Configurations[k][GLIM_VARIABLE] == GLIMValuesHead ) then
				 gLimModNow_ConfigIndex = k 
				 gLimModNow_Seting = CloneTable(gLim_Configurations[k][GLIM_VARIABLES]) 
				 gLimModOLD_Seting = CloneTable(gLimModNow_Seting)
				 --[[
					 local gLimModNow_SetingCount = #(gLimModNew_Seting) 
					 for nIndex = 1 ,gLimModNow_SetingCount,1 do 
						gLimModNew_Seting[nIndex]["newvalues"] =gLimModNew_Seting[nIndex][GLIM_DEFAULTVALUE] 
					 end
				 ]]
				 return 
			end 
		end 
		ChatFrame1:AddMessage(GLIM_CONFIG_DOWNLOADERROR) 
	 else
		ChatFrame1:AddMessage(GLIM_CONFIG_HAVENTCONFIGERROR) 
	 end 
 end 

 function gLimModMaster_DrawData() 

	 local sectCount = #(gLimModNow_Seting) 
	 FauxScrollFrame_Update(secBookScrollFrame, sectCount, gLimMod_ConfigList_MAXEVERYPAGECOUNT, gLimMod_ConfigList_MAXCOUNT) 

	 local sectOffset = FauxScrollFrame_GetOffset(secBookScrollFrame) 
	 if ( gLimModMaster_DrawDataStarted == 1 ) then
		return 
	 else
		gLimModMaster_DrawDataStarted = 1 
	 end 
	 gLimModMaster_HideAll()

	 for index=1,gLimMod_ConfigList_MAXEVERYPAGECOUNT, 1 do 
		if ( index <= 10 and sectOffset >= 0 and index <=sectCount) then
			local value = gLimModMaster_GetOffsetValue(index+sectOffset) 
			if ( value == nil ) then
				break 
			end 
			 local checkbox = getglobal("gLimMod"..index.."Checkbox") 
			 local checkboxtext = getglobal("gLimMod"..index.."FrameText") 
			 local chatbox = getglobal("DEFAULT_CHAT_FRAMEEditBox") 
			 if(value[GLIM_STRING] ~= nil) then
				 checkboxtext:SetText(value[GLIM_STRING]) 
				 checkboxtext:Show() 
			 end 
			 if (value[GLIM_CONFIGTYPE] == "CheckBox" ) then
				 checkbox:Show() 
				-- ChatFrame1:AddMessage(value[GLIM_VARIABLE]..value[GLIM_VARIABLE]) 
				 if (value[GLIM_DEFAULTVALUE] == 1) or (value[GLIM_DEFAULTVALUE] == true)then 
					checkbox:SetChecked(1) 
				 else
					checkbox:SetChecked(0) 
				 end 
			 end 
			 if ( value[GLIM_CONFIGTYPE] == "SLIDER") then
				 local slider = getglobal ("gLimMod"..index.."Slider") 
				 local slidertext = getglobal("gLimMod"..index.."Slider".."Text") 
				 local slidervaluetext = getglobal("gLimMod"..index.."Slider".."ValueText")
				 local valuetext
				
				valuetext = value[GLIM_DEFAULTVALUE] 
				 valuetext = valuetext..value[GLIM_STEPTEXT] 
				 slidervaluetext:SetText( valuetext ) 
				 slidervaluetext:Show() 
				 slidertext:SetText (value[GLIM_SUBSTRING] ) 
				 slidertext:Show() 
				 local slidervalue = value[GLIM_DEFAULTVALUE] 
				 slider:SetMinMaxValues(value[GLIM_MINVALUE], value[GLIM_MAXVALUE] ) 
				 slider:SetValueStep(value[GLIM_STEPVALUE] ) 
				 slider:SetValue(slidervalue) 
				 slider:Show() 
			 end
			if ( value[GLIM_CONFIGTYPE] == "Section" ) then
				 local separator = getglobal("gLimMod"..index.."Section") 
				 local separatortext = getglobal("gLimMod"..index.."Section".."Text") 
				 if ( value[GLIM_SUBSTRING] == nil ) then
					 separatortext:Hide() 
					 separator:Show() 
				 else
					 separatortext:SetText ( value[GLIM_SUBSTRING] ) 
					 separatortext:Show() 
					 separator:Show() 
				 end 
			 end
			if ( value[GLIM_CONFIGTYPE] == "Button" ) then
				 local button = getglobal("gLimMod"..index.."Button") 
				if ( value[GLIM_SUBSTRING] == nil ) then
					button:SetText(GLIM_CONFIG_ERROR_NOVALUE) 
				else
					button:SetText(value[GLIM_SUBSTRING]) 
				end 
				button:Show() 
			 end 
		end 
	 end 
	 gLimModMaster_DrawDataStarted = 0 
 end 
 function gLimModMaster_GetOffsetValue(offset) 
	 local curList = {} 
	 curList = gLimModNow_Seting
	 --return curList[offset] 
	 return curList[offset]
 end
function gLimModMaster_HideAll() for index = 1, gLimMod_ConfigList_MAXEVERYPAGECOUNT, 1 do local checkbox = getglobal("gLimMod"..index.."Checkbox") 
 local checkboxtext = getglobal("gLimMod"..index.."FrameText") 
 local slider = getglobal ("gLimMod"..index.."Slider") 
 local slidertext = getglobal("gLimMod"..index.."Slider".."Text") 
 local slidervaluetext = getglobal("gLimMod"..index.."Slider".."ValueText") 
 local button = getglobal("gLimMod"..index.."Button") 
 local separator = getglobal("gLimMod"..index.."Section") 
 checkbox:SetChecked(0) 
 checkbox:Hide() 
 checkboxtext:Hide() 
 checkboxtext:SetText("Reset") 
 slider:Hide() 
 slidertext:Hide() 
 slidervaluetext:Hide() 
 button:SetText("") 
 button:Hide() 
 separator:Hide() 
 end end
function gLimModMaster_CheckBox(relativeindex,checkedvalue ) if (gLimModMasterFrame_IsLoading == false) then
	 local index = relativeindex 
	 local funcOffset = FauxScrollFrame_GetOffset(secBookScrollFrame) 
	 index = index + funcOffset 
	 local value = gLimModMaster_GetOffsetValue(index) 
	 local checkbox = getglobal("gLimMod"..index.."Checkbox") 
	 local checkboxtext = getglobal("gLimMod"..index.."FrameText") 
	 if ( value[GLIM_CONFIGTYPE] == "CheckBox")then 
		AppendNewValue(value[GLIM_VARIABLE],checkedvalue) 
	 end 
	 local callback = value[GLIM_CALLBACK] 
		 callback(checkedvalue) 
	 end 
 end
function AppendNewValue(NewValueName,NewValues) 
	
	local NewConfigCount = #(gLimModNow_Seting) 
	 founds = false 
	 for nIndex = 1 ,NewConfigCount ,1 do 
		 if gLimModNow_Seting[nIndex][GLIM_VARIABLE] == NewValueName then
			 founds = true 
			 gLimModNow_Seting[nIndex][GLIM_DEFAULTVALUE] = NewValues 
		 end 
	 end 
	 if founds == false then
		 local NewTable ={ [GLIM_VARIABLE] = NewValueName, [GLIM_DEFAULTVALUE] = NewValues } 
		 tinsert(gLimModNow_Seting,NewTable) 
 		-- ChatFrame1:AddMessage(ChatFrame1:AddMessage(gLimModNew_Seting[offset][GLIM_DEFAULTVALUE]) ) 
	 end 	 
	--[[
	 local gLimModNow_SetingCount = #(gLimModNow_Seting) 
	 for nIndex = 1 ,NewConfigCount,1 do 
		for i = 1,gLimModNow_SetingCount,1 do 
			if (gLimModNow_Seting[i][GLIM_VARIABLE] == gLimModNew_Seting[nIndex]["ValuesName"]) then 
				gLimModNow_Seting[i][GLIM_DEFAULTVALUE] = gLimModNew_Seting[nIndex]["newvalues"] 
			end 
		end 
	 end 
	 ]]
 end 

 function gLimModMaster_Reset()
	ExecAllCallBack() 
	--gLimModNew_Seting = {} 
	--gLimModNow_ConfigIndex = -1 
	HideUIPanel(gLimConfigSubFrame)
 end 

 function gLimModMaster_SetNewConfig()
	 local NewConfigCount = #(gLimModNew_Seting) 
	 local gLimModNow_SetingCount = #(gLimModNow_Seting) 
	 for nIndex = 1 ,NewConfigCount,1 do 
		for i = 1,gLimModNow_SetingCount,1 do 
			if (gLimModNow_Seting[i][GLIM_VARIABLE] == gLimModNew_Seting[nIndex]["ValuesName"]) then 
				gLimModNow_Seting[i][GLIM_DEFAULTVALUE] = gLimModNew_Seting[nIndex]["newvalues"] 
			end 
		end 
	 end 
 end 
 function gLimModMaster_Button (relativeindex) if ( not (gLimModMasterFrame_IsLoading==1) ) then
 local index = relativeindex 
 local funcOffset = FauxScrollFrame_GetOffset(secBookScrollFrame) 
 local value = gLimModMaster_GetOffsetValue(index+funcOffset) 
 local callback = value[GLIM_CALLBACK] 
 callback() 
 end end
function gLimModMaster_Slider (relativeindex, slidervalue ) 
	 local append = "" 
	 local index = relativeindex 
	 local funcOffset = FauxScrollFrame_GetOffset(secBookScrollFrame) 
	 local value = gLimModMaster_GetOffsetValue(index+funcOffset) 
	 local slider = getglobal ("gLimMod"..index.."Slider") 
	 local slidervaluetext = getglobal("gLimMod"..index.."Slider".."ValueText") 
	 local newvalue = slidervalue 
	 newvalue = floor(newvalue * 100+.5)/100 
	 AppendNewValue(value[GLIM_VARIABLE],slidervalue) 
	 local valuetext = newvalue 
	 valuetext = valuetext..value[GLIM_STEPTEXT] 
	 slidervaluetext:SetText ( valuetext ) 
	 slidervaluetext:Show() 
	 local callback = value[GLIM_CALLBACK] 
	 callback(slidervalue) 
 end
function gLimModMaster_SetInfo( index ) local realindex = index + FauxScrollFrame_GetOffset(secBookScrollFrame) 
 if ( realindex > #( gLimModNow_Seting ) ) then
 return 
 end local config = gLimModMaster_GetOffsetValue(realindex) 
 if (not config) then
 return 
 end local descriptiontext = config[GLIM_DESCRIPTION] 
 if ( realindex == 0 ) then
 ChatFrame1:AddMessage("Invalid gLimMod Index: 0 ") 
 else
 local config = gLimModMaster_GetOffsetValue(realindex) 
 local descriptiontext = config[GLIM_DESCRIPTION] 
 if ( not (descriptiontext == "") ) then
 gLimModMaster_ClearInfo() 
 secBookTextbox:AddMessage("\n"..descriptiontext.."\n ", 156/256, 212/256, 1.0 ) 
 end end end
function gLimModMaster_ClearInfo() secBookTextbox:AddMessage("\n\n\n\n") 
 end

function gLimModMaster_OnOkayClick()
 if (gLimModNow_ConfigIndex ~= -1) then
	gLimModMaster_SetNewConfig() 
	gLim_Configurations[gLimModNow_ConfigIndex][GLIM_VARIABLES] = gLimModNow_Seting 	
 end
end

function ExecAllCallBack()
	 gLimModNow_Seting = gLimModOLD_Seting 
	 local totalConfigCount = #(gLimModNow_Seting) 
	 for nIndex = 1 ,totalConfigCount,1 do 
		 if gLimModNow_Seting[nIndex][GLIM_CALLBACK] ~= nil then
			 if (gLimModNow_Seting[nIndex][GLIM_DEFAULTVALUE] ~= nil) then
				 local callback = gLimModNow_Seting[nIndex][GLIM_CALLBACK] 
				 callback(gLimModNow_Seting[nIndex][GLIM_DEFAULTVALUE]) 
			 end 
		 end 
	 end 
end 
