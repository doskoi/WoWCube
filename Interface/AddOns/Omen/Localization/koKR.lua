-- Korean localization by Sayclub.
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Omen", "koKR")
if not L then return end

-- Main Omen window
L["<Unknown>"] = "<무엇인가>"
L["Omen Quick Menu"] = "Omen 빠른 메뉴"
L["Use Focus Target"] = "주시 대상 사용"
L["Test Mode"] = "테스트 모드"
L["Open Config"] = "설정 열기"
L["Open Omen's configuration panel"] = "Omen 설정 패널 열기"
L["Hide Omen"] = "Omen 숨김"
L["Name"] = "이름"
L["Threat [%]"] = "위협 수준 [%]"
L["Threat"] = "위협 수준"
L["TPS"] = "TPS"
L["Toggle Focus"] = "주시 대상 켜기/끄기"
L["> Pull Aggro <"] = "> 어그로 획득 <"

-- Warnings
L["|cffff0000Error:|r Omen cannot use shake warning if you have turned on nameplates at least once since logging in."] = "|cffff0000오류:|r 만약 로그인 후 이름표 표시를 한번이라도 했다면 Omen의 진동 경고를 사용 할 수 없습니다."
L["Passed %s%% of %s's threat!"] = "%2$s 위협 수준의 %1$s%% 초과함!"

-- Config module titles
L["General Settings"] = "일반 설정"
L["Profiles"] = "프로필"
L["Slash Command"] = "슬래시 명령어"

-- Config strings, general settings section
L["OMEN_DESC"] = "Omen은 당신이 전투중인 몹들에 대한 당신의 위협 수준을 보여주는 가벼운 위협 미터기 입니다."
L["Alpha"] = "투명도"
L["Controls the transparency of the main Omen window."] = "Omen 창의 투명도를 조절합니다."
L["Scale"] = "크기"
L["Controls the scaling of the main Omen window."] = "Omen 창의 크기를 조절합니다."
L["Frame Strata"] = "프레임 우선순위"
L["Controls the frame strata of the main Omen window. Default: MEDIUM"] = "Omen 창의 프레임 우선순위를 조절합니다. 기본값: MEDIUM"
L["Clamp To Screen"] = "화면에 고정"
L["Controls whether the main Omen window can be dragged offscreen"] = "Omen 창 이동시 화면 밖으로  나가지 않도록 조절합니다."
L["Tells Omen to additionally check your 'focus' and 'focustarget' before your 'target' and 'targettarget' in that order for threat display."] = "Omen에 당신의 '대상'과 '대상의 대상'에 대한 위협을 표시하기 위해 추가로 당신의 '주시'와 '주시 대상'을 검사합니다."
L["Tells Omen to enter Test Mode so that you can configure Omen's display much more easily."] = "Omen을 쉽게 설정할 수 있도록 테스트 모드에 들어갑니다."
L["Collapse to show a minimum number of bars"] = "최소한의 바를 표시하기 위해 접기를 합니다."
L["Lock Omen"] = "Omen 잠금"
L["Locks Omen in place and prevents it from being dragged or resized."] = "Omen의 위치나 크기를 조절하지 못하도록 잠급니다."
L["Show minimap button"] = "미니맵 버튼 표시"
L["Show the Omen minimap button"] = "Omen 미니맵 버튼을 표시합니다."
L["Ignore Player Pets"] = "플레이어 소환수들 무시"
L["IGNORE_PLAYER_PETS_DESC"] = [[
Tells Omen to skip enemy player pets when determining which unit to display threat data on.

Player pets maintain a threat table when in |cffffff78Aggressive|r or |cffffff78Defensive|r mode and behave just like normal mobs, attacking the target with the highest threat. If the pet is instructed to attack a specific target, the pet still maintains the threat table, but sticks on the assigned target which by definition has 100% threat. Player pets can be taunted to force them to attack you.

However, player pets on |cffffff78Passive|r mode do not have a threat table, and taunt does not work on them. They only attack their assigned target when instructed and do so without any threat table.

When a player pet is instructed to |cffffff78Follow|r, the pet's threat table is wiped immediately and stops attacking, although it may immediately reacquire a target based on its Aggressive/Defensive mode.
]]
L["Autocollapse"] = "자동 접기"
L["Autocollapse Options"] = "자동 접기 옵션"
L["Grow bars upwards"] = "바 위로 확장"
L["Hide Omen on 0 bars"] = "바가 0일때 Omen 숨김"
L["Hide Omen entirely if it collapses to show 0 bars"] = "바의 갯수가 0개일때 Omen을 숨깁니다."
L["Max bars to show"] = "표시할 최대 바"
L["Max number of bars to show"] = "표시할 바의 최대 갯수"
L["Background Options"] = "배경 옵션"
L["Background Texture"] = "배경 무늬"
L["Texture to use for the frame's background"] = "창의 배경에 사용할 무늬를 설정합니다."
L["Border Texture"] = "테두리 무늬"
L["Texture to use for the frame's border"] = "창의 테두리에 사용할 무늬를 설정합니다."
L["Background Color"] = "배경 색상"
L["Frame's background color"] = "창의 배경 색상을 설정합니다."
L["Border Color"] = "테두리 색상"
L["Frame's border color"] = "창의 테두리 색상을 설정합니다."
L["Tile Background"] = "타일 배경"
L["Tile the background texture"] = "배경의 무늬에 사용할 타일을 설정합니다."
L["Background Tile Size"] = "배경 타일 크기"
L["The size used to tile the background texture"] = "배경 무늬의 타일 크기를 설정합니다."
L["Border Thickness"] = "테두리 두께"
L["The thickness of the border"] = "테두리의 두께를 설정합니다."
L["Bar Inset"] = "바 추가"
L["Sets how far inside the frame the threat bars will display from the 4 borders of the frame"] = "창 안에 보여질 위협 바의 4 테두리를 설정합니다."

-- Config strings, title bar section
L["Title Bar Settings"] = "제목 바 설정"
L["Configure title bar settings."] = "제목 바를 설정합니다."
L["Show Title Bar"] = "제목 바 표시"
L["Show the Omen Title Bar"] = "Omen 제목 바를 표시합니다."
L["Title Bar Height"] = "제목 바 높이"
L["Height of the title bar. The minimum height allowed is twice the background border thickness."] = "제목 바의 높이를 설정합니다. 최소 허락된 높이는 배경 테두리 두께입니다."
L["Title Text Options"] = "제목 문자 옵션"
L["The font that the title text will use"] = "제목 문자 사용 글꼴"
L["The outline that the title text will use"] = "제목 문자 사용 외곽선"
L["The color of the title text"] = "제목 문자 색상"
L["Control the font size of the title text"] = "제목 문자 글꼴 크기"
L["Use Same Background"] = "같은 배경 사용"
L["Use the same background settings for the title bar as the main window's background"] = "메인 창의 배경으로 제목 바와 같은 배경 설정을 사용합니다."
L["Title Bar Background Options"] = "제목 바 배경 옵션"

-- Config strings, show when... section
L["Show When..."] = "표시 방법..."
L["Show Omen when..."] = "Omen을 언제 표시할지..."
L["This section controls when Omen is automatically shown or hidden."] = "자동적으로 Omen을 표시하거나 숨기기 위해 이 섹션을 설정합니다."
L["Use Auto Show/Hide"] = "자동 표시/숨김 사용"
L["Show Omen when any of the following are true"] = "선택한 항목에 따라 Omen을 표시합니다."
L["You have a pet"] = "소환수를 가졌을때"
L["Show Omen when you have a pet out"] = "소환수를 가진 경우에 Omen을 표시합니다"
L["You are alone"] = "솔로잉시"
L["Show Omen when you are alone"] = "솔로잉일 경우에 Omen을 표시합니다."
L["You are in a party"] = "파티 참여"
L["Show Omen when you are in a 5-man party"] = "5인 파티일 경우에 Omen을 표시합니다."
L["You are in a raid"] = "공격대 참여"
L["Show Omen when you are in a raid"] = "공격대일 경우에 Omen을 표시합니다."
L["However, hide Omen if any of the following are true (higher priority than the above)."] = "만약 선택한 항목이 사실일때 Omen을 숨깁니다. (최 우선 순위)"
L["You are resting"] = "휴식 상태시"
L["Turning this on will cause Omen to hide whenever you are in a city or inn."] = "당신이 대도시나 여관에 있을때 Omen을 숨깁니다."
L["You are in a battleground"] = "전장 참여"
L["Turning this on will cause Omen to hide whenever you are in a battleground or arena."] = "당신이 전장이나 투기장에 있을때 Omen을 숨깁니다."
L["You are not in combat"] = "비 전투시"
L["Turning this on will cause Omen to hide whenever you are not in combat."] = "당신이 전투 중이 아닐때 Omen을 숨깁니다."
L["AUTO_SHOW/HIDE_NOTE"] = "노트: 만약 수동으로 당신이 Omen 표시나 숨기기를 토글 한다면, 다음에 당신이 설정할 때까지 자동 표시/숨김 설정과 관계없이 표시되거나 숨겨집니다. 파티나 공격대에 참여하거나 떠날때 또는 자동 표시/숨김 설정을 변경하셔야 합니다."

-- Config strings, show classes... section
L["Show Classes..."] = "직업 표시..."
L["SHOW_CLASSES_DESC"] = "다음 직업들을 위해 Omen 위협 바를 표시합니다. 여기 직업은 '파티에 속하지 않음' 옵션을 제외하고 당신이 파티/공격대일때 표시합니다."
L["Show bars for these classes"] = "이 직업들을 위한 바를 표시합니다."
L["DEATHKNIGHT"] = "죽음의 기사"
L["DRUID"] = "드루이드"
L["HUNTER"] = "사냥꾼"
L["MAGE"] = "마법사"
L["PALADIN"] = "성기사"
L["PET"] = "소환수"
L["PRIEST"] = "사제"
L["ROGUE"] = "도적"
L["SHAMAN"] = "주술사"
L["WARLOCK"] = "흑마법사"
L["WARRIOR"] = "전사"
L["*Not in Party*"] = "*파티에 속하지 않음*"

-- Config strings, bar settings section
L["Bar Settings"] = "바 설정"
L["Configure bar settings."] = "바 세팅을 설정합니다."
L["Animate Bars"] = "움직이는 바"
L["Smoothly animate bar changes"] = "바가 부드럽게 움직이도록 변경합니다."
L["Short Numbers"] = "간결한 숫자"
L["Display large numbers in Ks"] = "큰 숫자는 Ks로 표시합니다."
L["Bar Texture"] = "바 무늬"
L["The texture that the bar will use"] = "바에 사용할 무늬을 설정합니다."
L["Bar Height"] = "바 높이"
L["Height of each bar"] = "각 바의 높이를 설정합니다."
L["Bar Spacing"] = "바 간격"
L["Spacing between each bar"] = "각 바 사이의 간격을 설정합니다."
L["Show TPS"] = "TPS 표시"
L["Show threat per second values"] = "초당 위협 수준을 표시합니다."
L["TPS Window"] = "TPS 창"
L["TPS_WINDOW_DESC"] = "초당 위협 수준 계산을 X 초 마다 실시간으로 창에 표시합니다."
L["Show Threat Values"] = "위협 수치 표시"
L["Show Threat %"] = "% 수치 표시"
L["Show Headings"] = "제목 표시"
L["Show column headings"] = "컬럼 제목 표시"
L["Heading BG Color"] = "제목 배경 색상"
L["Heading background color"] = "제목 배경 색상을 설정합니다."
L["Use 'My Bar' color"] = "'플레이어 바'에 색상 사용"
L["Use a different colored background for your threat bar in Omen"] = "Omen에서 플레이어(당신)의 위협 바에 다른 색상을 사용합니다. "
L["'My Bar' BG Color"] = "'플레이어 바'의 배경 색상"
L["The background color for your threat bar"] = "플레이어(당신)의 바에 대한 배경 색상을 지정합니다."
L["Use Tank Bar color"] = "방어전담 바 색상 사용"
L["Use a different colored background for the tank's threat bar in Omen"] = "Omen에서 방어전담(탱커)의 위협 바에 다른 색상을 사용합니다."
L["Tank Bar Color"] = "방어전담 바 색상"
L["The background color for your tank's threat bar"] = "당신의 방어전담(탱커) 위협 바에 대한 배경 색상을 지정합니다."
L["Show Pull Aggro Bar"] = "어그로 획득 바 표시"
L["Show a bar for the amount of threat you will need to reach in order to pull aggro."] = "어그로를 획득하기 위해 당신이 넘어야 할 위협 바를 표시합니다."
L["Pull Aggro Bar Color"] = "어그로 획득 바 색상"
L["The background color for your Pull Aggro bar"] = "당신의 어그로 획득 바에 대한 배경 색상을 지정합니다."
L["Use Class Colors"] = "직업 색상 사용"
L["Use standard class colors for the background color of threat bars"] = "위협 바의 배경 색상을 기본 직업 색상으로 사용합니다."
L["Pet Bar Color"] = "소환수 바 색상"
L["The background color for pets"] = "소환수에 대한 배경 색상을 지정합니다."
L["Bar BG Color"] = "배경 색상 바"
L["The background color for all threat bars"] = "모든 위협 바들에 대한 배경 색상을 지정합니다."
L["Always Show Self"] = "항상 자신 표시"
L["Always show your threat bar on Omen (ignores class filter settings), showing your bar on the last row if necessary"] = "만약 필요하다면 마지막 줄 위에 당신의 바를 보여 주고, 항상 Omen에 당신의 위협 바를 표시합니다. (직업 필터 설정 무시)"
L["Bar Label Options"] = "바 라벨 옵션"
L["Font"] = "글꼴"
L["The font that the labels will use"] = "라벨에 사용할 글꼴을 설정합니다."
L["Font Size"] = "글꼴 크기"
L["Control the font size of the labels"] = "라벨의 글꼴 크기를 조절합니다."
L["Font Color"] = "글꼴 색상"
L["The color of the labels"] = "라벨의 색상을 설정합니다."
L["Font Outline"] = "글꼴 외곽선"
L["The outline that the labels will use"] = "라벨에 사용할 외곽선을 설정합니다."
L["None"] = "없음"
L["Outline"] = "얇은 외곽선"
L["Thick Outline"] = "두꺼운 외곽선"

-- Config strings, slash command section
L["OMEN_SLASH_DESC"] = "슬래시 명령어인 /omen을 입력하면 이 버튼과 같은 기능을 수행하는 명령어를 표시합니다."
L["Toggle Omen"] = "Omen 열기/닫기"
L["Center Omen"] = "Omen 중앙"
L["Configure"] = "설정"
L["Open the configuration dialog"] = "설정 창을 엽니다."

-- Config strings, warning settings section
L["Warning Settings"] = "경고 설정"
L["OMEN_WARNINGS_DESC"] = "이 섹션은 당신이 어그로를 얻을때 언제, 어떻게 Omen이 당신에게 경고할지를 설정합니다."
L["Enable Sound"] = "소리 사용"
L["Causes Omen to play a chosen sound effect"] = "선택된 소리를 듣습니다."
L["Enable Screen Flash"] = "화면 깜박임 사용"
L["Causes the entire screen to flash red momentarily"] = "화면 가장자리에 깜박이는 효과를 냅니다."
L["Enable Screen Shake"] = "화면 진동 사용"
L["Causes the entire game world to shake momentarily. This option only works if nameplates are turned off."] = "전체 게임 화면이 잠시 흔들립니다. 만약 이름표 표시가 켜져 있다면 이 옵션은 작동하지 않습니다."
L["Enable Warning Message"] = "경고 메시지 사용"
L["Print a message to screen when you accumulate too much threat"] = "너무 많은 위협 수준이 쌓일때 화면에 메시지를 보여줍니다."
L["Warning Threshold %"] = "%값에 경고"
L["Sound to play"] = "재생할 소리"
L["Disable while tanking"] = "방어전담시 사용 안함"
L["DISABLE_WHILE_TANKING_DESC"] = "방어 태세, 곰 변신, 정의의 격노나 냉기의 형상일때 모든 경고를 보이지 않습니다."
L["Test warnings"] = "테스트 경고"

-- Config strings, for Fubar
L["Click|r to toggle the Omen window"] = "클릭|r Omen 창 토글"
L["Right-click|r to open the options menu"] = "우-클릭|r 설정 메뉴 열기"
L["FuBar Options"] = "FuBar 옵션"
L["Attach to minimap"] = "미니맵에 표시"
L["Hide minimap/FuBar icon"] = "미니맵/FuBar 아이콘 숨김"
L["Show icon"] = "아이콘 표시"
L["Show text"] = "텍스트 표시"
L["Position"] = "위치"
L["Left"] = "왼쪽"
L["Center"] = "가운데"
L["Right"] = "오른쪽"

-- FAQ
L["Help File"] = "도움말"
L["A collection of help pages"] = "도움말 페이지 목록"
L["FAQ Part 1"] = "FAQ Part 1"
L["FAQ Part 2"] = "FAQ Part 2"
L["Frequently Asked Questions"] = "질문과 답변"
L["Warrior"] = "전사"

L["GENERAL_FAQ"] = [[
|cffffd200How is Omen3 different from Omen2?|r

Omen3 relies completely on the Blizzard threat API and threat events. It does not attempt to calculate or extrapolate threat unlike Omen2.

Omen2 used what we called the Threat-2.0 library. This library was responsible for monitoring the combat log, spellcasting, buffs, debuffs, stances, talents and gear modifiers for calculating each individuals threat. Threat was calculated based on what was known or approximated from observed behaviors. Many abilities such as knockbacks were just assumed (to be a 50% threat reduction) as they were mostly impossible to confirm.

The Threat-2.0 library also included addon communication to broadcast your threat to the rest of the raid as long as they were also using Threat-2.0. This data was then used to provide a raid wide display of threat information.

Since patch 3.0.2, Omen no longer does any of these things and the need for a threat library is no longer necessary. Omen3 uses Blizzard's new in-built threat monitor to obtain exact values of every members threat. This means Omen3 has no need for synchronisation of data, combat log parsing or guessing, resulting in a significant increase in performance with regards to network traffic, CPU time and memory used. The implementation of boss modules for specific threat events (such as Nightbane wiping threat on landing) are also no longer necessary.

Further benefits of this new implementation include the addition of NPC threat on a mob (eg, Human Kalecgos). However, there are some drawbacks; frequency of updates are much slower, threat details cannot be obtained unless somebody in your party/raid are targetting the mob and it is also not possible to obtain threat from a mob you are not in direct combat with.

|cffffd200How do I get rid of the 2 vertical gray lines down the middle?|r

Lock your Omen. Locking Omen will prevent it from being moved or resized, as well as prevent the columns from being resized. If you haven't realized it, the 2 vertical gray lines are column resizing handles.

|cffffd200How do I make Omen3 look like Omen2?|r

Change the both the Background Texture and Border Texture to Blizzard Tooltip, change the Background Color to black (by dragging the luminance bar to the bottom), and the Border Color to blue.

|cffffd200Why does no threat data show on a mob when I target it even though it is in combat?|r

The Blizzard threat API does not return threat data on any mob you are not in direct combat with. We suspect this is an effort on Blizzard's part to save network traffic.

|cffffd200Is there ANY way around this Blizzard limitation? Not being able to see my pet's threat before I attack has set me back to guessing.|r

There is no way around this limitation short of us doing the guessing for you (which is exactly how Omen2 did it).

The goal of Omen3 is to provide accurate threat data, we no longer intend to guess for you and in the process lower your FPS. Have some confidence in your pet/tank, or just wait 2 seconds before attacking and use a low damage spell such as Ice Lance so that you can get initial threat readings.
]]
L["GENERAL_FAQ2"] = [[
|cffffd200Can we get AoE mode back?|r

Again, this is not really possible without guessing threat values. Blizzard's threat API only allows us to query for threat data on units that somebody in the raid is targetting. This means that if there are 20 mobs and only 6 of them are targetted by the raid, there is no way to obtain accurate threat data on the other 14.

This is also extremely complicated to guess particularly for healing and buffing (threat gets divided by the number of mobs you are in combat with) because mobs that are under crowd control effects (sheep, banish, sap, etc) do not have their threat table modified and addons cannot reliably tell how many mobs you are in combat with. Omen2's guess was almost always wrong.

|cffffd200The tooltips on unit mouseover shows a threat % that does not match the threat % reported by Omen3. Why?|r

Blizzard's threat percentage is scaled to between 0% and 100%, so that you will always pull aggro at 100%. Omen reports the raw unscaled values which has pulling aggro percentages at 110% while in melee range and 130% otherwise.

By universal agreement, the primary target of a mob is called the tank and is defined to be at 100% threat.

|cffffd200Does Omen3 sync or parse the combat log?|r

No. Omen3 does not attempt to sync or parse the combat log. Currently there are no intentions to do so.

|cffffd200The threat updates are slow...|r

Omen3 updates the threat values you see as often as Blizzard updates the threat values to us.

In fact, Blizzard updates them about once per second, which is much faster than what Omen2 used to sync updates. In Omen2, you only transmitted your threat to the rest of the raid once every 3 seconds (or 1.5s if you were a tank).

|cffffd200Where can I report bugs or give suggestions?|r

http://forums.wowace.com/showthread.php?t=14249

|cffffd200Who wrote Omen3?|r

Xinhuan (Blackrock US Alliance) did.

|cffffd200Do you accept Paypal donations?|r

Yes, send to xinhuan AT gmail DOT com.
]]
L["WARRIOR_FAQ"] = [[The following data is obtained from |cffffd200http://www.tankspot.com/forums/f200/39775-wow-3-0-threat-values.html|r on 2nd Oct 2008 (credits to Satrina). The numbers are for a level 80.

|cffffd200Modifiers|r
Battle Stance ________ x 80
Berserker Stance _____ x 80
Tactical Mastery _____ x 121/142/163
Defensive Stance _____ x 207.35

Note that in our original threat estimations (that we use now in WoW 2.0), we equated 1 damage to 1 threat, and used 1.495 to represent the stance+defiance multiplier. We see that Blizzard's method is to use the multiplier without decimals, so in 2.x it would've been x149 (maybe x149.5); it is x207 (maybe 207.3) in 3.0. I expect that this is to allow the transport of integer values instead of decimal values across the Internet for efficiency. It appears that threat values are multiplied by 207.35 at the server, then rounded.

If you still want to use the 1 damage = 1 threat method, the stance modifiers are 0.8 and 2.0735, etc.

|cffffd200Threat Values  (stance modifiers apply unless otherwise noted):|r
Battle Shout _________ 78 (split)
Cleave _______________ damage + 225 (split)
Commanding Shout _____ 80 (split)
Concussion Blow ______ damage only
Damage Shield ________ damage only
Demoralising Shout ___ 63 (split)
Devastate ____________ damage + 5% of AP *** Needs re-checking for 8982 **
Dodge/Parry/Block_____ 1 (in defensive stance with Improved Defensive Stance only)
Heroic Strike ________ damage + 259
Heroic Throw _________ 1.50 x damage
Rage Gain ____________ 5 (stance modifier is not applied)
Rend _________________ damage only
Revenge ______________ damage + 121
Shield Bash __________ 36
Shield Slam __________ damage + 770
Shockwave ____________ damage only
Slam _________________ damage + 140
Spell Reflect ________ damage only (only for spells aimed at you)
Social Aggro _________ 0
Sunder Armour ________ 345 + 5%AP
Thunder Clap _________ 1.85 x damage
Vigilance ____________ 10% of target's generated threat (stance modifier is not applied)

You do not gain threat for reflecting spells targetted at allies with Improved Spell Reflect. When you reflect a spell for an ally, your ally gains the threat for the damage dealt by the reflected spell.
]]

