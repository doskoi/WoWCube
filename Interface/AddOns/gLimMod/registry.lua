gLimButton = { }; 
gLim_Configurations = { }; 
function gLim_RegisterButton(var_name,var_longdescription,var_icon,var_callback,var_Type,var_priority) 
	if ( var_name == nil ) then 
		DEFAULT_CHAT_FRAME:AddMessage( "Missing a name for the Button."); 
	end 
	if ( var_icon == nil ) then 
		DEFAULT_CHAT_FRAME:AddMessage( "Missing an icon path for the Button."); 
	end 
	if ( var_callback == nil ) then 
		DEFAULT_CHAT_FRAME:AddMessage( "Missing a callback for the Button."); 
	end 
	if (var_Type == nil) then 
		var_Type = 4; 
	end 
	if (var_priority == nil) then 
		var_priority = 10; 
	end; 
	temp = {};
	 temp[GLIM_NAME] = var_name;
	 temp[GLIM_LONGDESCRIPTION] = var_longdescription;
	 temp[GLIM_ICON] = var_icon;
	 temp[GLIM_CALLBACK] = var_callback;
	 temp[GLIM_TYPE] = var_Type;
	 temp[GLIM_PRIORITY] = var_priority;
	 tinsert(gLimButton,temp);
 end 
 function gLim_RegisterConfigClass( gLim_variable, gLim_description, gLim_Author ) 
	if (gLim_variable == nil)then 
		DEFAULT_CHAT_FRAME:AddMessage(GLIM_CONFIG_ERROR_NILVALUE);
		return;
	end;
	 if (gLim_description == nil)then 
		gLim_description = "";
	 end;
	 if (gLim_Author == nil) then 
		gLim_Author ="gLim Studio";
	 end;
	 local newRegistrant = { [GLIM_VARIABLE] = gLim_variable, [GLIM_DESCRIPTION] = gLim_description, [GLIM_AUTHOR] = gLim_Author } 
	 local found = false;
	 local index = 1;
	while gLim_Configurations[index] do
		--DEFAULT_CHAT_FRAME:AddMessage(gLim_Configurations[index][GLIM_VARIABLE]);
		if (gLim_Configurations[index][GLIM_VARIABLE] == gLim_variable ) then 
			DEFAULT_CHAT_FRAME:AddMessage ( GLIM_CONFIG_ERROR_HASBEENREGSITY..gLim_Configurations[index][GLIM_AUTHOR]);
			found = true;
			return true;
		end 
		index = index + 1;
	end;
	local MaxConfigCount = #(gLim_Configurations);
	tinsert(gLim_Configurations,newRegistrant);
 end;
 function gLim_RegisterConfigSection( gLim_variable, glim_substring, gLim_description, gLim_Author, gLim_Class ) if (gLim_variable == nil)then 
DEFAULT_CHAT_FRAME:AddMessage(GLIM_CONFIG_ERROR_NILVALUE);
 return;
 end;
 if (gLim_description == nil)then 
gLim_description = "";
 end;
 if (gLim_Author == nil) then 
gLim_Author ="gLim Studio";
 end;
 if (gLim_Class == nil)then 
DEFAULT_CHAT_FRAME:AddMessage(GLIM_CONFIG_ERROR_NILVALUE);
 return;
 end;
 local found = false;
 local MaxConfigCount = #(gLim_Configurations);
 local nIndex = -1;
 for k=1,MaxConfigCount,1 do
 if (gLim_Configurations[k][GLIM_VARIABLE] == gLim_Class ) then 
found = true;
 nIndex = k;
 end;
 end;
 local newRegistrant = { [GLIM_VARIABLE] = gLim_variable, [GLIM_DESCRIPTION] = gLim_description, [GLIM_AUTHOR] = gLim_Author, [GLIM_CONFIGTYPE] = "Section", [GLIM_SUBSTRING] = glim_substring } if found == false then 
DEFAULT_CHAT_FRAME:AddMessage(GLIM_CONFIG_ERROR_NAMEERROR);
 return;
 else if gLim_Configurations[nIndex][GLIM_VARIABLES] == nil then 
gLim_Configurations[nIndex][GLIM_VARIABLES]= {};
 end;
 MaxConfigCount = #(gLim_Configurations[nIndex][GLIM_VARIABLES]);
 found = false;
 for k = 1, MaxConfigCount,1 do if (gLim_Configurations[nIndex][GLIM_VARIABLES][k][GLIM_VARIABLE] == gLim_variable ) then 
DEFAULT_CHAT_FRAME:AddMessage ( GLIM_CONFIG_ERROR_HASBEENREGSITY..gLim_Configurations[k][GLIM_AUTHOR]);
 return;
 end;
 end;
 tinsert(gLim_Configurations[nIndex][GLIM_VARIABLES],newRegistrant);
 end;
 end;
 function gLim_RegisterConfigCheckBox( gLim_variable, gLim_String, gLim_description, gLim_DefaultValue, gLim_Defaultfunction, gLim_Class ) if (gLim_String == nil)then 
DEFAULT_CHAT_FRAME:AddMessage(GLIM_CONFIG_ERROR_STRINGRROR);
 return;
 end;
 if (gLim_variable == nil)then 
DEFAULT_CHAT_FRAME:AddMessage(GLIM_CONFIG_ERROR_NILVALUE);
 return;
 end;
 if (gLim_description == nil)then 
gLim_description = "";
 end;
 if (gLim_Class == nil)then 
DEFAULT_CHAT_FRAME:AddMessage(GLIM_CONFIG_ERROR_NILVALUE);
 return;
 end;
 if (gLim_Defaultfunction == nil) then 
DEFAULT_CHAT_FRAME:AddMessage(GLIM_CONFIG_ERROR_CALLBACKRROR);
 return;
 end;
 if (gLim_DefaultValue == nil) then 
gLim_DefaultValue = 1;
 end;
 local found = false;
 local MaxConfigCount = #(gLim_Configurations);
 local nIndex = -1;
 for k=1,MaxConfigCount,1 do if (gLim_Configurations[k][GLIM_VARIABLE] == gLim_Class ) then 
found = true;
 nIndex = k;
 end;
 end;
 local newRegistrant = { [GLIM_VARIABLE] = gLim_variable, [GLIM_DESCRIPTION] = gLim_description, [GLIM_CONFIGTYPE] = "CheckBox", [GLIM_CALLBACK] = gLim_Defaultfunction, [GLIM_DEFAULTVALUE] = gLim_DefaultValue, [GLIM_STRING] = gLim_String } if found == false then 
DEFAULT_CHAT_FRAME:AddMessage(GLIM_CONFIG_ERROR_NAMEERROR);
 return;
 else if gLim_Configurations[nIndex][GLIM_VARIABLES] == nil then 
gLim_Configurations[nIndex][GLIM_VARIABLES]= {};
 end;
 MaxConfigCount = #(gLim_Configurations[nIndex][GLIM_VARIABLES]);
 found = false;
 for k = 1, MaxConfigCount,1 do if (gLim_Configurations[nIndex][GLIM_VARIABLES][k][GLIM_VARIABLE] == gLim_variable ) then 
DEFAULT_CHAT_FRAME:AddMessage ( GLIM_CONFIG_ERROR_HASBEENREGSITY);
 return;
 end;
 end;
 tinsert(gLim_Configurations[nIndex][GLIM_VARIABLES],newRegistrant);
 end;
 end;
 function gLim_RegisterConfigSlider( gLim_variable, gLim_String, gLim_description, glim_substring, gLim_StepText, gLim_StepValue, gLim_MinValue, gLim_MaxValue, gLim_DefaultValue, gLim_Defaultfunction, gLim_Class ) if (gLim_String == nil)then 
DEFAULT_CHAT_FRAME:AddMessage(GLIM_CONFIG_ERROR_STRINGRROR);
 return;
 end;
 if (gLim_variable == nil)then 
DEFAULT_CHAT_FRAME:AddMessage(GLIM_CONFIG_ERROR_NILVALUE);
 return;
 end;
 if (glim_substring == nil) then 
glim_substring = "";
 end;
 if (gLim_description == nil)then 
gLim_description = "";
 end;
 if (gLim_Class == nil)then 
DEFAULT_CHAT_FRAME:AddMessage(GLIM_CONFIG_ERROR_NILVALUE);
 return;
 end;
 if (gLim_Defaultfunction == nil) then 
DEFAULT_CHAT_FRAME:AddMessage(GLIM_CONFIG_ERROR_CALLBACKRROR);
 return;
 end;
 if (gLim_DefaultValue == nil) then 
gLim_DefaultValue = 1;
 end;
 if (gLim_StepValue == nil) then 
gLim_StepValue = 1;
 end;
 if (gLim_MinValue == nil) then 
gLim_MinValue = 1;
 end;
 if (gLim_MaxValue == nil) then 
gLim_MaxValue = 300;
 end;
 if (gLim_StepText == nil)then 
gLim_StepText = "";
 end;
 local found = false;
 local MaxConfigCount = #(gLim_Configurations);
 local nIndex = -1;
 for k=1,MaxConfigCount,1 do if (gLim_Configurations[k][GLIM_VARIABLE] == gLim_Class ) then 
found = true;
 nIndex = k;
 end;
 end;
 local newRegistrant = { [GLIM_VARIABLE] = gLim_variable, [GLIM_DESCRIPTION] = gLim_description, [GLIM_CONFIGTYPE] = "SLIDER", [GLIM_CALLBACK] = gLim_Defaultfunction, [GLIM_DEFAULTVALUE]=gLim_DefaultValue, [GLIM_STRING] =gLim_String, [GLIM_STEPVALUE] = gLim_StepValue;
 [GLIM_MINVALUE] = gLim_MinValue;
 [GLIM_MAXVALUE] = gLim_MaxValue;
 [GLIM_STEPTEXT] = gLim_StepText;
 [GLIM_SUBSTRING] = glim_substring;
 } if found == false then 
DEFAULT_CHAT_FRAME:AddMessage(GLIM_CONFIG_ERROR_NAMEERROR);
 return;
 else if gLim_Configurations[nIndex][GLIM_VARIABLES] == nil then 
gLim_Configurations[nIndex][GLIM_VARIABLES]= {};
 end;
 MaxConfigCount = #(gLim_Configurations[nIndex][GLIM_VARIABLES]);
 found = false;
 for k = 1, MaxConfigCount,1 do if (gLim_Configurations[nIndex][GLIM_VARIABLES][k][GLIM_VARIABLE] == gLim_variable ) then 
DEFAULT_CHAT_FRAME:AddMessage ( GLIM_CONFIG_ERROR_HASBEENREGSITY);
 return;
 end;
 end;
 tinsert(gLim_Configurations[nIndex][GLIM_VARIABLES],newRegistrant);
 end;
 end;
 function gLim_RegisterConfigButton( gLim_variable, gLim_String, gLim_description, glim_substring, gLim_Defaultfunction, gLim_Class ) if (gLim_String == nil)then 
DEFAULT_CHAT_FRAME:AddMessage(GLIM_CONFIG_ERROR_STRINGRROR);
 return;
 end;
 if (gLim_variable == nil)then 
DEFAULT_CHAT_FRAME:AddMessage(GLIM_CONFIG_ERROR_NILVALUE);
 return;
 end;
 if (gLim_description == nil)then 
gLim_description = "";
 end;
 if (gLim_Class == nil)then 
DEFAULT_CHAT_FRAME:AddMessage(GLIM_CONFIG_ERROR_NILVALUE);
 return;
 end;
 if (gLim_Defaultfunction == nil) then 
DEFAULT_CHAT_FRAME:AddMessage(GLIM_CONFIG_ERROR_CALLBACKRROR);
 return;
 end;
 local found = false;
 local MaxConfigCount = #(gLim_Configurations);
 local nIndex = -1;
 for k=1,MaxConfigCount,1 do if (gLim_Configurations[k][GLIM_VARIABLE] == gLim_Class ) then 
found = true;
 nIndex = k;
 end;
 end;
 local newRegistrant = { [GLIM_VARIABLE] = gLim_variable, [GLIM_DESCRIPTION] = gLim_description, [GLIM_CONFIGTYPE] = "Button", [GLIM_CALLBACK] = gLim_Defaultfunction, [GLIM_STRING] = gLim_String;
 [GLIM_SUBSTRING] =glim_substring } if found == false then 
DEFAULT_CHAT_FRAME:AddMessage(GLIM_CONFIG_ERROR_NAMEERROR);
 return;
 else if gLim_Configurations[nIndex][GLIM_VARIABLES] == nil then 
gLim_Configurations[nIndex][GLIM_VARIABLES]= {};
 end;
 MaxConfigCount = #(gLim_Configurations[nIndex][GLIM_VARIABLES]);
 found = false;
 for k = 1, MaxConfigCount,1 do if (gLim_Configurations[nIndex][GLIM_VARIABLES][k][GLIM_VARIABLE] == gLim_variable ) then 
DEFAULT_CHAT_FRAME:AddMessage (GLIM_CONFIG_ERROR_HASBEENREGSITY);
 return;
 end;
 end;
 tinsert(gLim_Configurations[nIndex][GLIM_VARIABLES],newRegistrant);
 end;
 end;
 function gLimKeyBinding(arg) UIParentLoadAddOn("Blizzard_BindingUI");
 ShowUIPanel(KeyBindingFrame);
 local numBindings = GetNumBindings();
 for i = 1, numBindings, 1 do local commandName, binding1, binding2 = GetBinding(i);
 if ( commandName == arg ) then 
ShowUIPanel(KeyBindingFrame);
 KeyBindingFrameScrollFrameScrollBar:SetValue((i-1)*KEY_BINDING_HEIGHT);
 end end end function Registry_OnLoad()
 this:RegisterEvent("VARIABLES_LOADED");
 end function Registry_OnEvent(event) if( event == "VARIABLES_LOADED" ) then
 if( not gLim_Configurations ) then 
gLim_Configurations = {};
 end end end 