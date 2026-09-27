local addon, ns = ...;
local version = GetAddOnMetadata(addon, "Version");
local TOTAL_IMMUNITIES_slider = 10;
local IMMINITIES_slider = 9;
local CROWD_CONTROL_slider = 8;
local BUFF_DEFENSIVE_slider = 7;
local BUFF_OFFENSIVE_slider = 6;
local ROOTS_slider = 5;
local OTHER_slider = 4;

_CATEGORIES = {
		{
			name = "crowdcontrol",
			slider = CROWD_CONTROL_slider,
			spells = {
				[33786] = 1, -- Cyclone
				[20549] = 1, -- War Stomp
				[1090] = 1, -- Magic Dust
				[13327] = 1, -- Reckless Charge
				[835] = 1, -- Tidal Charm
				[19769] = 1, -- Thorium Grenade
				[4068] = 1, -- Iron Grenade
				[15753] = 1, -- Linken's Boomerang Stun
				[13237] = 1, -- Goblin Mortar trinket
				[18798] = 1, -- Freezing Band
				[605] = 1, -- Mind Control
					[10911] = { parent = 605 },
					[10912] = { parent = 605 },
				[8122] = 1, -- Psychic Scream
					[8124] = { parent = 8122 },
					[10888] = { parent = 8122 },
					[10890] = { parent = 8122 },
				[15269] = 1, -- Blackout
				[15487] = 1, -- Silence
				[9484] = 1, -- Shackle Undead
					[9485] = { parent = 9484 },
					[10955] = { parent = 9484 },
				[24259] = 1, -- Spell Lock Silence
				[6358] = 1, -- Seduction
				[5782] = 1, -- Fear
					[6213] = { parent = 5782 },
					[6215] = { parent = 5782 },
				[5484] = 1, -- Howl of Terror
					[17928] = { parent = 5484 },
				[710] = 1, -- Banish
					[18647] = { parent = 710 },
				[6789] = 1, -- Death Coil
					[17925] = { parent = 6789 },
					[17926] = { parent = 6789 },
					[27223] = { parent = 6789 },
				[18093] = 1, -- Pyroclasm
				[32752] = 1, -- Summoning Disorientation
				[19482] = 1, -- Doom Guard Stun
				[30153] = 1, -- Felguard Stun
					[30195] = { parent = 30153 },
					[30197] = { parent = 30153 },
				[39796] = 1, -- Stoneclaw Totem
				[853] = 1, -- Hammer of Justice
					[5588] = { parent = 853 },
					[5589] = { parent = 853 },
					[10308] = { parent = 853 },
				[20066] = 1, -- Repentance
				[20170] = 1, -- Seal of Justice stun
				[10326] = 1, -- Turn Evil
					[2878] = { parent = 10326 },
					[5627] = { parent = 10326 },
				[1513] = 1, -- Scare Beast
					[14326] = { parent = 1513 },
					[14327] = { parent = 1513 },
				[19410] = 1, -- Concussive Shot Stun
					[28445] = { parent = 19410 },
				[3355] = 1, -- Freezing Trap
					[14308] = { parent = 3355 },
					[14309] = { parent = 3355 },
				[19386] = 1, --Wyvern Sting
					[24132] = { parent = 19386 },
					[24133] = { parent = 19386 },
					[27068] = { parent = 19386 },
				[19503] = 1, -- Scatter Shot
				[34490] = 1, -- Silencing Shot
				[24394] = 1, -- Intimidation
				[2637] = 1, -- Hibernate
					[18657] = { parent = 2637 },
					[18658] = { parent = 2637 },
				[9005] = 1, -- Pounce Stun
					[9823] = { parent = 9005 },
					[9827] = { parent = 9005 },
					[27006] = { parent = 9005 },
				[16922] = 1, -- Starfire Stun
				[5211] = 1, -- Bash
					[6798] = { parent = 5211 },
					[8983] = { parent = 5211 },
				[18469] = 1, -- Improved Counterspell
				[118] = 1, -- Polymorph
					[12824] = { parent = 118 },
					[12825] = { parent = 118 },
					[12826] = { parent = 118 },
					[28270] = { parent = 118 },
					[28271] = { parent = 118 },
					[28272] = { parent = 118 },
				[12355] = 1, -- Impact Stun
				[31661] = 1, -- Dragon's Breath
					[33041] = { parent = 31661 },
					[33042] = { parent = 31661 },
					[33043] = { parent = 31661 },
				[18425] = 1, -- Improved Kick
				[1833] = 1, -- Cheap Shot
				[408] = 1, -- Kidney Shot
					[8643] = { parent = 408 },
				[2070] = 1, -- Sap
					[6770] = { parent = 2070 },
					[11297] = { parent = 2070 },
				[2094] = 1, -- Blind
				[1776] = 1, -- Gouge
					[1777] = { parent = 1776 },
					[8629] = { parent = 1776 },
					[11285] = { parent = 1776 },
					[11286] = { parent = 1776 },
					[38764] = { parent = 1776 },
				[1330] = 1, -- Garrote Silence
				[18498] = 1, -- Improved Shield Bash
				[20253] = 1, -- Intercept Stun
					[20614] = { parent = 20253 },
					[20615] = { parent = 20253 },
					[25273] = { parent = 20253 },
					[25274] = { parent = 20253 },
				[12798] = 1, -- Revenge Stun
				[12809] = 1, -- Concussion Blow
				[7922] = 1, -- Charge Stun
				[5530] = 1, -- Mace Spec Stun (Warrior & Rogue)
				[5246] = 1, -- Intimidating Shout
					[20511] = { parent = 5246 },
				[22703] = 1, -- Inferno Effect
				[30283] = 1, -- Shadowfury
					[30413] = { parent = 30283 },
					[30414] = { parent = 30283 },
				[43523] = 1, -- Unstable Affliction
				[25046] = 1, -- Arcane Torrent
					[28730] = { parent = 25046 }, 
			}
		},
		{
			name = "defensive",
			slider = BUFF_DEFENSIVE_slider,
			spells = {
				[11426] = 1, -- Ice Barrier
					[13031] = {parent = 11426},
					[13032] = {parent = 11426},
					[13033] = {parent = 11426},
					[27134] = {parent = 11426},
					[33405] = {parent = 11426},
				[543] = 1, -- Fire Ward
					[8457] = { parent = 543 },
					[8458] = { parent = 543 },
					[10223] = { parent = 543 },
					[10225] = { parent = 543 },
				[6143] = 1, -- Frost Ward
					[8461] = { parent = 6143 },
					[8462] = { parent = 6143 },
					[10177] = { parent = 6143 },
					[28609] = { parent = 6143 },
				[1463] = 1, -- Mana Shield
					[8494] = { parent = 1463 },
					[8495] = { parent = 1463 },
					[10191] = { parent = 1463 },
					[10192] = { parent = 1463 },
					[10193] = { parent = 1463 },
					[27131] = { parent = 1463 },
				[7744] = 1, -- Will of the Forsaken
				[20594] = 1, -- Stoneform
				[6615] = 1, -- Free Action Potion
				[24364] = 1, -- Living Action Potion
				[11359] = 1, -- Restorative Potion
				[23097] = 1, -- Fire Reflector
				[23131] = 1, -- Frost Reflector
				[23132] = 1, -- Shadow Reflector
				[23506] = 1, -- Arena Grand Master trinket
				[29506] = 1, -- Burrower's Shell trinket
				[12733] = 1, -- Blacksmith trinket, Fear immunity
				[9774] = 1, -- Spider Belt & Ornate Mithril Boots
				[17] = 1, -- Power Word: Shield
					[592] = { parent = 17 },
					[600] = { parent = 17 },
					[3747] = { parent = 17 },
					[6065] = { parent = 17 },
					[6066] = { parent = 17 },
					[10898] = { parent = 17 },
					[10899] = { parent = 17 },
					[10900] = { parent = 17 },
					[10901] = { parent = 17 },
				[6346] = 1, -- Fear Ward
				[33206] = 1, -- Pain Suppression
				[14751] = 1, -- Inner Focus
				[7812] = 1, -- Sacrifice
					[19438] = { parent = 7812 },
					[19440] = { parent = 7812 },
					[19441] = { parent = 7812 },
					[19442] = { parent = 7812 },
					[19443] = { parent = 7812 },
				[6229] = 1, -- Shadow Ward
					[11739] = { parent = 6229 },
					[11740] = { parent = 6229 },
					[28610] = { parent = 6229 },
				[18708] = 1, -- Fel Domination
				[16188] = 1, -- Nature's Swiftness
				[30823] = 1, -- Shamanistic Rage
				[1044] = 1, -- Blessing of Freedom
				[6940] = 1, -- Blessing of Sacrifice
					[20729] = { parent = 6940 },
				[20216] = 1, -- Divine Favor
				[5384] = 1, -- Feign Death
				[22812] = 1, -- Barkskin
				[29166] = 1, -- Innervate
				[16689] = 1, -- Nature's Grasp Buff
					[16810] = { parent = 16689 },
					[16811] = { parent = 16689 },
					[16812] = { parent = 16689 },
					[16813] = { parent = 16689 },
					[17329] = { parent = 16689 },
				[17116] = 1, -- Nature's Swiftness
				[12043] = 1, -- Presence of Mind
				[5277] = 1, -- Evasion
					[26669] = { parent = 5277 },
				[14278] = 1, -- Ghostly Strike
				[45182] = 1, -- Cheating Death
				[20230] = 1, -- Retaliation
				[871] = 1, -- Shield Wall
				[12976] = 1, -- Last Stand
			}
		},
		{
			name = "offensive",
			slider = BUFF_OFFENSIVE_slider,
			spells = {
				[20600] = 1, -- Perception
				[7744] = 1, -- Will of the Forsaken
				[10060] = 1, -- Power Infusion
				[16166] = 1, -- Elemental Mastery
				[31884] = 1, -- Avenging Wrath
				[3045] = 1, -- Rapid Fire
				[1850] = 1, -- Dash
					[9821] = { parent = 1850 },
				[12042] = 1, -- Arcane Power
				[12472] = 1, -- Icy Veins
				[13750] = 1, -- Adrenaline Rush
				[13877] = 1, -- Blade Flurry
				[2983] = 1, -- Sprint
					[8696] = { parent = 2983 },
					[11305] = { parent = 2983 },
				[14177] = 1, -- Cold Blood
				[14251] = 1, -- Riposte (Rogue)
				[1719] = 1, -- Recklessness
				[12328] = 1, -- Death Wish
				[676] = 1, -- Disarm
				[18499] = 1, -- Berserker Rage
			}
		},
		{
			name = "other",
			slider = OTHER_slider,
			spells = {
				[1714] = 1, -- Curse of Tongues
					[11719] = { parent =  1714 },
			}
		},
		{
			name = "totalimmunity",
			slider = TOTAL_IMMUNITIES_slider,
			spells = {
				[642] = 1, -- Divine Shield
					[498] = { parent = 642 },
					[1020] = { parent = 642 },
					[5573] = { parent = 642 },
				[19753] = 1, -- Divine Intervention
				[45438] = 1, -- Ice Block
			}
		},
		{
			name = "immunity",
			slider = IMMINITIES_slider,
			spells = {
				[16621] = 1, -- Invulnerable Mail
				[30300] = 1, -- Nether Protection
				[8178] = 1, -- Grounding Totem Effect
				[1022] = 1,-- Blessing of Protection
					[5599] = { parent = 1022 },
					[10278] = { parent = 1022 },
				[19263] = 1, -- Deterrence
				[19574] = 1, -- Bestial Wrath
				[34471] = 1, -- The Beast Within
				[31224] = 1, -- Cloak of Shadows
				[23920] = 1, -- Spell Reflection
			}
		},
		{
			name = "roots",
			slider = ROOTS_slider,
			spells = {
				[12494] = 1, -- Frostbite
				[33395] = 1, -- Freeze
				[122] = 1, -- Frost Nova
					[865] = { parent = 122 },
					[6131] = { parent = 122 },
					[10230] = { parent = 122 },
					[27088] = { parent = 122 },
				[44041] = 1, -- Chastise
					[44043] = { parent = 44041 },
					[44044] = { parent = 44041 },
					[44045] = { parent = 44041 },
					[44046] = { parent = 44041 },
					[44047] = { parent = 44041 },
				[19229] = 1, -- Wing Clip Root
				[19306] = 1, -- Counterattack Root
					[20909] = { parent = 19306 },
					[20910] = { parent = 19306 },
					[27067] = { parent = 19306 },
				[19185] = 1, -- Entrapment
				[25999] = 1, -- Boar Charge
				[339] = 1, -- Entangling Roots
					[1062] = { parent = 339 },
					[5195] = { parent = 339 },
					[5196] = { parent = 339 },
					[9852] = { parent = 339 },
					[9853] = { parent = 339 },
					[26989] = { parent = 339 },
					[19970] = { parent = 339 }, -- Nature's Grasp Rank 6
					[19971] = { parent = 339 }, -- Nature's Grasp Rank 5
					[19972] = { parent = 339 }, -- Nature's Grasp Rank 4
					[19973] = { parent = 339 }, -- Nature's Grasp Rank 3
					[19974] = { parent = 339 }, -- Nature's Grasp Rank 2
					[19975] = { parent = 339 }, -- Nature's Grasp Rank 1
					[27010] = { parent = 339 },
				--[16979] = 1
				--[19675] = 1, -- Feral Charge Effect
				--	[45334] = { parent = 19675 },
				[23694] = 1, -- Improved Hamstring
			}
		},
	};

function ns:GetCategoryByName(category)
    for key, tab in pairs(_CATEGORIES) do
        if ( tab.name == category ) then
            return tab;
        end
    end
end


function ns:GetCategoryBySpellID(spellID) -- А ВОТ КАТЕГОРИИ ПО СПЕЛЛ АЙДИ
    for i, category in pairs(_CATEGORIES) do
		for spellId in pairs(category.spells) do
			if ( spellID == spellId ) then
				return category.name
			end
		end
    end
end

function ns:GetPriorityBySpellID(unit, spellID) -- // ВОТ ПО ЮНИТЫ МОЖНО ПОЛУЧИТЬ ПРИОРИТЕТ СПЕЛЛ АЙДИ ЕСЛИ ОН ЕСТЬ В БД ВЕРНЕТ ЕГО ЗНАЧЕНИЕ ИЛИ 1 ПО ДЕФОЛТУ
    return GetBigAurasUnitProfileSetting(unit, spellID, "value") or 1
end

function ns:CreateDefaultProfile()
	return  {
		-- main
		["enable"] = true,
		["alpha"] = 1,
		["showSwipe"] = true,
		["timertext"] = true,
		["unlock"] = false,
		["offsetX"] = 0,
		["offsetY"] = 0,
		["size"] = 48,
		-- category
		["crowdcontrol"] = { enabled = true, value = ns:GetCategoryByName("crowdcontrol").slider},
		["defensive"] = { enabled = true, value = ns:GetCategoryByName("defensive").slider},
		["offensive"] = { enabled = true, value = ns:GetCategoryByName("offensive").slider},
		["other"] = { enabled = true, value = ns:GetCategoryByName("other").slider},
		["totalimmunity"] = { enabled = true, value = ns:GetCategoryByName("totalimmunity").slider},
		["immunity"] = { enabled = true, value = ns:GetCategoryByName("immunity").slider},
		["roots"] = { enabled = true, value = ns:GetCategoryByName("roots").slider},
	}
end

function ns:GetDefaultProfile()
	return {
		["name"] = "DEFAULT",
		["anchor"] = "Blizzard",
		["OptionVersion"] = version,
		["player"] = ns:CreateDefaultProfile(),
		["pet"] = ns:CreateDefaultProfile(),
		["target"] = ns:CreateDefaultProfile(),
		["focus"] = ns:CreateDefaultProfile(),
		["party1"] = ns:CreateDefaultProfile(),
		["party2"] = ns:CreateDefaultProfile(),
		["party3"] = ns:CreateDefaultProfile(),
		["party4"] = ns:CreateDefaultProfile(),
		["partypet1"] = ns:CreateDefaultProfile(),
		["partypet2"] = ns:CreateDefaultProfile(),
		["partypet3"] = ns:CreateDefaultProfile(),
		["partypet4"] = ns:CreateDefaultProfile(),
		["arena1"] = ns:CreateDefaultProfile(),
		["arena2"] = ns:CreateDefaultProfile(),
		["arena3"] = ns:CreateDefaultProfile(),
		["arena4"] = ns:CreateDefaultProfile(),
		["arena5"] = ns:CreateDefaultProfile(),
		["arenapet1"] = ns:CreateDefaultProfile(),
		["arenapet2"] = ns:CreateDefaultProfile(),
		["arenapet3"] = ns:CreateDefaultProfile(),
		["arenapet4"] = ns:CreateDefaultProfile(),
		["arenapet5"] = ns:CreateDefaultProfile(),
	}
end
