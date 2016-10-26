BagSet={ };
gLim_KeepBagOpen = 1;
gLim_openallbag = 1;
--包裹栏的注册头和尾

function BagOpen_OnLoad()
	--DEFAULT_CHAT_FRAME:AddMessage("BagOpen Loaded");
	BagOpenFrame:RegisterEvent("VARIABLES_LOADED");
	BagOpenFrame:RegisterEvent("MERCHANT_SHOW");
	BagOpenFrame:RegisterEvent("MERCHANT_CLOSED");
	BagOpenFrame:RegisterEvent("BANKFRAME_CLOSED");
	BagOpenFrame:RegisterEvent("BANKFRAME_OPENED");
	BagOpenFrame:RegisterEvent("AUCTION_HOUSE_CLOSED");
	BagOpenFrame:RegisterEvent("AUCTION_HOUSE_SHOW");
	BagOpenFrame:RegisterEvent("MAIL_SHOW");
	BagOpenFrame:RegisterEvent("MAIL_CLOSE");
	BagOpenFrame:RegisterEvent("TRADEFRAME_OPENED");
	BagOpenFrame:RegisterEvent("TRADEFRAME_SHOW");
end
-- ON/OFF bag auto open
function BagOpen_ONOff(toggle) 	
	if ( toggle == 1 ) then 
		gLim_openallbag = 1;
		BagSet.openallbag = 1;
	else
		gLim_openallbag = 0;
		BagSet.openallbag = 0;
	end
end;

-- ON/OFF bag Keeping open
function BagkeepOpen_ONOff(toggle) 	
	if ( toggle == 1 ) then 
		gLim_KeepBagOpen = 1;
		BagSet.KeepBagOpen = 1;
	else
		gLim_KeepBagOpen = 0;
		BagSet.KeepBagOpen = 0;
	end
end;

--[[
	自动打开所有包裹栏的功能
	create it by 11-X
	edit it by pigbaby
	增加自动打开所有包裹栏的控制状态
]]

function BagOpen_OnEvent(event) 
  if( event == "VARIABLES_LOADED" ) then
	BagOpen_LoadConfig();
  end

  if (event == "MERCHANT_SHOW" or event == "AUCTION_HOUSE_SHOW" or event == "MAIL_SHOW") 
  then
	   --MFC.IO.print("MERCHANT_SHOW Event");
	   --用来记住当前打开的所有的包裹的.个人认为没有用所以去除 by PigBaby
           --SaveBagStatus();
           --增加包裹的功能判断
	   --MFC.IO.print(gLim_openallbag);
           if(gLim_openallbag == 1) then 
           		OpenAllBags(0);
           end;
  end     

  if (event == "MERCHANT_CLOSED" or event == "AUCTION_HOUSE_CLOSE" or event == event == "MAIL_CLOSE" ) 
  then
	    --DEFAULT_CHAT_FRAME:AddMessage("MERCHANT_CLOSED Event");
           CloseAllBags();
           KeepBagOpen();
  end     

  if (event == "BANKFRAME_CLOSED") 
  then
	    --DEFAULT_CHAT_FRAME:AddMessage("BANKFRAME_CLOSED Event");
           CloseAllBags();
           KeepBagOpen();
  end 

  if (event == "BANKFRAME_OPENED" or event == "TRADEFRAME_OPENED" or event == "TRADEFRAME_SHOW" ) 
  then
	    --DEFAULT_CHAT_FRAME:AddMessage("BANKFRAME_OPENED Event");
           --SaveBagStatus();
           if( gLim_openallbag == 1) then 
           		OpenAllBags(0);
           end
  end 
end
--  note: add for save variables and register to gLimMod
function BagOpen_LoadConfig()
	if( not BagSet ) then
		BagSet = { };
	end

	if ( BagSet.KeepBagOpen == nil ) then
		BagSet.KeepBagOpen = 0;
	end
	if ( BagSet.openallbag == nil ) then
		BagSet.openallbag  = 1;
	end
	
	gLim_openallbag = BagSet.openallbag;
	gLim_KeepBagOpen = BagSet.KeepBagOpen;

	BagOpen_Register();
end

function BagOpen_Register()
	if ( gLim_RegisterButton ) then
	gLim_RegisterButton (
		BAGOPEN_TITLE,
		BAGOPEN_OPTION,
		"Interface\\Icons\\INV_Misc_Bag_22",
		function()
			gLimModSecBookShowConfig("gLimopenbag")
		end,
		4,
		8
		);
	gLim_RegisterConfigClass(
		"gLimopenbag",
		BAGOPEN_TITLE,
		"gLim"
		);
	gLim_RegisterConfigSection(
		"gLimopenbagsection",
		BAGOPEN_OPTION,
		BAGOPEN_OPTION_INFO,
		"gLim",
		"gLimopenbag"
		);
	gLim_RegisterConfigCheckBox(
		"gLim_openallbag",
		BAGOPEN_CONFIG_ONOFF,
		BAGOPEN_CONFIG_ONOFF,
		gLim_openallbag,
		BagOpen_ONOff,
		"gLimopenbag"
		);
	gLim_RegisterConfigCheckBox(
		"gLim_KeepBagOpen",
		BAGOPEN_CONFIG_KEEPONOFF,
		BAGOPEN_CONFIG_KEEPONOFF_INFO,
		gLim_KeepBagOpen,
		BagkeepOpen_ONOff,
		"gLimopenbag"
		);
	end

end
--[[
	在关闭了离开了.商人.银行的交易窗口后所有的包裹是否还要保持
	edit it by PigBaby
	edit time 2005.02.09
]]
function KeepBagOpen() 	
	--MFC.IO.print(gLim_openallbag);
    if( gLim_KeepBagOpen == 1) then 
	--因为目前这个游戏一个用户最多只有四个包裹栏所以这里FOR的最大值改为4 BY PigBaby
    	for i=0,4 do 
           OpenBag(i);
      end
    end  
end 
--[[
function SaveBagStatus()	
  --MFC.IO.print(gLim_KeepBagOpen);
  if( gLim_KeepBagOpen == 1) then
    BagSet = {};

    for i=0 , 4 ,1 do 
        if(IsBagOpen(i)) then 
          BagSet[i]="1" 
        else 
          BagSet[i]=nil 
        end 
    end 
  end
end 
]]