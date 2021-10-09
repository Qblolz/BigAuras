local addon, ns = ...;
local version = GetAddOnMetadata(addon, "Version");
local TOTAL_IMMUNITIES_slider = 10;
local IMMINITIES_slider = 9;
local CROWD_CONTROL_slider = 8;
local BUFF_DEFENSIVE_slider = 7;
local BUFF_OFFENSIVE_slider = 6;
local ROOTS_slider = 5;
local OTHER_slider = 4

_CATEGORIES = {
		{
			name = "crowdcontrol",
			slider = CROWD_CONTROL_slider,
			spells = {
				[49012] = 1,	-- Wyvern Sting
					[19386] = { parent = 49012 },
					[24132] = { parent = 49012 },
					[24133] = { parent = 49012 },
					[27068] = { parent = 49012 },
					[49011] = { parent = 49012 },
					[49011] = { parent = 49012 },
				[47481] = 1,	-- Gnaw (Ghoul)
				[51209] = 1,	-- Hungering Cold
				[8983] = 1,	    -- Druid feral bash
					[5211] = { parent =  8983 },
					[6798] = { parent =  8983 },
				[58861] = 1,    -- Bash (also Shaman Spirit Wolf ability)
				[33786] = 1,	-- Cyclone
				[18658] = 1,	-- Hibernate (works against Druids in most forms and Shamans using Ghost Wolf)
					[2637] = { parent = 18658 },
					[18657] = { parent = 18658 },
				[49802] = 1,	-- Maim
					[22570] = { parent = 49802 },
				[49803] = 1,	-- Pounce
					[9005] = { parent = 49803 },
					[9823] = { parent = 49803 },
					[9827] = { parent = 49803 },
					[27006] = { parent = 49803 },
				[14309] = 1,	-- Freezing Trap Effect
					[3355] = { parent =  14309},
					[14308] = { parent =  14309},
					[60210] = { parent =  14309},
				[24394] = 1,	-- Intimidation
				[14327] = 1,	-- Scare Beast (works against Druids in most forms and Shamans using Ghost Wolf)
					[1513] = { parent = 14327 },
					[14326] = { parent = 14327 },
				[19503] = 1,	-- Scatter Shot
				[53568] = 1,	-- Sonic Blast (Bat)
					[50519] = { parent = 53568 },
					[53564] = { parent = 53568 },
					[53565] = { parent = 53568 },
					[53566] = { parent = 53568 },
					[53567] = { parent = 53568 },
				[53562] = 1,	-- Ravage (Ravager)
				[44572] = 1,	-- Deep Freeze
				[42950] = 1,	-- Dragon's Breath
					[31661] = { parent = 42950 }, -- Dragon's Breath
					[33041] = { parent = 42950 }, -- Dragon's Breath
					[33042] = { parent = 42950 }, -- Dragon's Breath
					[33043] = { parent = 42950 }, -- Dragon's Breath
					[42949] = { parent = 42950 }, -- Dragon's Breath
				[12355] = 1,	-- Impact
				[118] = 1,	    -- Polymorph
					[12824] = { parent = 118 },	-- Polymorph (sheep)
					[12825] = { parent = 118 },	-- Polymorph (sheep)
					[12826] = { parent = 118 },	-- Polymorph (sheep)
					[28271] = { parent = 118 },	-- Polymorph (turtle)
					[61721] = { parent = 118 },	-- Polymorph (rabbit)
					[61305] = { parent = 118 },	-- Polymorph (cat)
					[61025] = { parent = 118 },	-- Polymorph (snake)
					[61780] = { parent = 118 },	-- Polymorph (turkey)
					[71319] = { parent = 118 },	-- Polymorph (turkey)
					[28272] = { parent = 118 },	-- Polymorph (pig)
				[10308] = 1,	-- Hammer of Justice
					[853] = { parent = 10308 },
					[5588] = { parent = 10308 },
					[5589] = { parent = 10308 },
				[48817] = 1,	-- Holy Wrath (works against Warlocks using Metamorphasis and Death Knights using Lichborne)
					[2812] = { parent = 48817 },
					[10318] = { parent = 48817 },
					[27139] = { parent = 48817 },
					[48816] = { parent = 48817 },
				[20066] = 1,	-- Repentance
				[20170] = 1,	-- Stun (Seal of Justice proc)
				[10326] = 1,	-- Turn Evil (works against Warlocks using Metamorphasis and Death Knights using Lichborne)
				[605] = 1,	-- Mind Control
				[64044] = 1,	-- Psychic Horror
				[10890] = 1,	-- Psychic Scream
					[8122] = { parent = 10890 },
					[8124] = { parent = 10890 },
					[10888] = { parent = 10890 },
				[10955] = 1,	-- Shackle Undead (works against Death Knights using Lichborne)
					[9484] = { parent = 10955 },
					[9485] = { parent = 10955 },
				[2094] = 1,	-- Blind
				[1833] = 1,	-- Cheap Shot
				[1776] = 1,	-- Gouge
				[8643] = 1,	-- Kidney Shot
					[408] = { parent = 8643 },
				[51724] = 1,	-- Sap
					[6770] = { parent = 51724 },
					[2070] = { parent = 51724 },
					[11297] = { parent = 51724 },
				[39796] = 1,	-- Stoneclaw Stun
				[51514] = 1,	-- Hex
				[18647] = 1,	-- Banish (works against Warlocks using Metamorphasis and Druids using Tree Form)
					[710] = { parent = 18647},
				[47860] = 1,	-- Death Coil
					[6789] = { parent = 47860 },
					[17925] = { parent = 47860 },
					[17926] = { parent = 47860 },
					[27223] = { parent = 47860 },
					[47859] = { parent = 47860 },
				[6215] = 1,	-- Fear
					[5782] = { parent = 6215 },
					[6213] = { parent = 6215 },
				[17928] = 1,	-- Howl of Terror
					[5484] = { parent = 17928 },
				[6358] = 1,	-- Seduction (Succubus)
				[47847] = 1,	-- Shadowfury
					[30283] = { parent = 47847 },
					[30413] = { parent = 47847 },
					[30414] = { parent = 47847 },
					[47846] = { parent = 47847 },
				[7922] = 1,	-- Charge Stun
				[20253] = 1,	-- Intercept Stun (Warrior)
				[12809] = 1,	-- Concussion Blow
				[25274] = 1,	-- Intercept (also Warlock Felguard ability)
					[30153] = { parent = 25274 },
					[30195] = { parent = 25274 },
					[30197] = { parent = 25274 },
					[47995] = { parent = 25274 },
				[5246] = 1,		-- Intimidating Shout
					[20511] = { parent = 5246 },
				[12798] = 1,	-- Revenge Stun
				[46968] = 1,	-- Shockwave
				[308726] = 1, -- Vulpera stun
				[90101] = 1,	-- Pandarien stun
				[316161] = 1,	-- DarkIronDwarf stun
				[30217] = 1,	-- Adamantite Grenade
					[67769] = { parent = 30217},
					[67890] = { parent = 30217},
				[67769] = 1,	-- Cobalt Frag Bomb
				[30216] = 1,	-- Fel Iron Bomb
				[20549] = 1,	-- War Stomp
				-- Silences
				[47476] = 1,	-- Strangulate
				[34490] = 1,	-- Silencing Shot
				[55021] = 1,	-- Silenced - Improved Counterspell
					[18469] = { parent = 55021 },
				[63529] = 1,	-- Shield of the Templar
				[15487] = 1,	-- Silence
				[1330]  = 1,	-- Garrote - Silence
				[18425] = 1,	-- Silenced - Improved Kick
				[24259] = 1,	-- Spell Lock (Felhunter)
				[18498] = 1,	-- Silenced - Gag Order
				[25046] = 1,	-- Arcane Torrent (15 energy)
					[50613] = { parent = 25046 },
					[28730] = { parent = 25046 },
				[54785] = 1,  -- Demon Charge
			}
		},
		{
			name = "defensive",
			slider = BUFF_DEFENSIVE_slider,
			spells = {
				[66] = 1,    -- Invisibility(mage)
					[32612] = { parent = 66 },
				[18708] = 1, -- Fel Domination
				[12975] = 1, -- Last Stand
				[48792] = 1, -- Ice bound
				[2565] = 1, -- Shield Block
				[20230] = 1, -- Retaliation
				[47585] = 1, -- Dispersion
				[55198] = 1, -- Tidal Force
				[48066] = 1, -- Power Word: Shield
					[17] = { parent =  48066},
					[592] = { parent =  48066},
					[600] = { parent =  48066},
					[3747] = { parent =  48066},
					[6065] = { parent =  48066},
					[6066] = { parent =  48066},
					[10898] = { parent =  48066},
					[10899] = { parent =  48066},
					[10900] = { parent =  48066},
					[10901] = { parent =  48066},
					[25217] = { parent =  48066},
					[25218] = { parent =  48066},
					[48065] = { parent =  48066},
				[20216] = 1, -- Divine Favor
				[53659] = 1, -- Sacred Cleansing
				[50461] = 1, -- Anti-Magic Zone
				[49039] = 1, -- Lichborne
				[3411] = 1, -- Intervene
				[54748] = 1, -- Burning Determination
				[55694] = 1, -- Enraged Regeneration
				[16188] = 1, -- Nature's Swiftness
				[26669] = 1, -- Evasion
					[5277] = { parent = 26669 },
				[8178] = 1,  -- Grounding Totem Effect
				[33206] = 1, -- Pain Suppression
				[10060] = 1, -- Power Infusion
				[47788] = 1, -- Guardian Spirit
				[43039] = 1, -- Ice Barrier
					[11426] = { parent = 43039 },
					[13031] = { parent = 43039 },
					[13032] = { parent = 43039 },
					[13033] = { parent = 43039 },
					[27134] = { parent = 43039 },
					[33405] = { parent = 43039 },
					[43038] = { parent = 43039 },
				[43020] = 1, -- Mana Shield
					[1463] = { parent = 43020 },
					[8494] = { parent = 43020 },
					[8495] = { parent = 43020 },
					[10191] = { parent = 43020 },
					[10192] = { parent = 43020 },
					[10193] = { parent = 43020 },
					[27131] = { parent = 43020 },
					[43019] = { parent = 43020 },
				[43012] = 1, -- Frost Ward
					[6143] = { parent = 43012 },
					[8461] = { parent = 43012 },
					[8462] = { parent = 43012 },
					[10177] = { parent = 43012 },
					[28609] = { parent = 43012 },
					[32796] = { parent = 43012 },
				[43010] = 1, -- Fire Ward
					[543] = { parent = 43010 },
					[8457] = { parent = 43010 },
					[8458] = { parent = 43010 },
					[10223] = { parent = 43010 },
					[10225] = { parent = 43010 },
					[27128] = { parent = 43010 },
				[58597] = 1, -- Sacred Shield
				[53563] = 1, -- Beacon of Light
				[54428] = 1, -- Divine Plea
				[498] = 1, -- Divine Protection
				[871] = 1, -- ShieldWall
				[64205] = 1, -- Divine Sacrifice
				[1044] = 1, -- Hand of Freedom
				[6940] = 1, -- Hand of Sacrifice
				[10278] = 1, -- Hand of Protection
					[1022] = { parent = 10278 },
					[5599] = { parent = 10278 },
				[51052] = 1, -- Anti-Magic Zone
				[49222] = 1, -- Bone Shield
				[55233] = 1, -- Vampiric Blood
				[29166] = 1, -- Innervate
				[22842] = 1, -- Frenzied Regeneration
				[22812] = 1, -- Barkskin
			}
		},
		{
			name = "offensive",
			slider = BUFF_OFFENSIVE_slider,
			spells = {
				[47241] = 1,  -- Metamorphosis
				[51690] = 1,  -- Killing Spree
				[31884] = 1,  -- Avenging Wrath
				[2825] = 1,  -- Bloodlust
				[32182] = 1,  -- Heroism
				[1719] = 1, -- Recklessness
				[69369] = 1,  -- Predator's Swiftness
				[51713] = 1, -- Shadow Dance
				[16166] = 1,  -- Elemental Mastery
				[11719] = 1,  -- Curse of Tongues
					[1714] = { parent = 11719 },
				[14751] = 1,  -- Inner Focus
				[12043] = 1,  -- Presence of Mind
				[12472] = 1,  -- Icy Veins
				[12042] = 1,  -- Arcane Power
				[3045] = 1,  -- Rapid Fire
				[53201] = 1, -- Starfall
					[48505] = { parent = 53201 },
					[53199] = { parent = 53201 },
					[53200] = { parent = 53201 },
				[34692] = 1, -- The Beast Within
				[50334] = 1, -- Berserk
				[49016] = 1, -- Hysteria
				[51271] = 1, -- Unbreakable Armor
				-- Disarms
				[53359] = 1, -- Chimera Shot - Scorpid
				[53543] = 1, -- Snatch (Bird of Prey)
					[50541] = { parent = 53543 },
					[53537] = { parent = 53543 },
					[53538] = { parent = 53543 },
					[53540] = { parent = 53543 },
					[53542] = { parent = 53543 },
				[64346] = 1, -- Fiery Payback
				[64058] = 1, -- Psychic Horror disarm
				[51722] = 1, -- Dismantle
				[676]   = 1, -- Disarm
			}
		},
		{
			name = "other",
			slider = OTHER_slider,
			spells = {
				[308876] = 1, -- Necrotic trinket(sirus.su)
					[308877] = { parent = 308876 },
					[308878] = { parent = 308876 },
					[308879] = { parent = 308876 },
			}
		},
		{
			name = "totalimmunity",
			slider = TOTAL_IMMUNITIES_slider,
			spells = {
				[642]   = 1,	-- Divine Shield (Paladin)
				[45438] = 1,	-- Ice Block (Mage)
			}
		},
		{
			name = "immunity",
			slider = IMMINITIES_slider,
			spells = {
				[19263] = 1,	-- Deterrenct (Hunter)
				[46924] = 1,	-- Bladestorm (Warrior)
				[90113] = 1,	-- Barrier of reflect
				[48707] = 1,	-- DK Anti-Magic Shell
				[34692] = 1,	-- The Beast Within (Hunter)
					[34471] = { parent = 34692 },
				[31224] = 1,	-- Cloak of Shadows
				[23920] = 1,	-- Warrior reflect
			}
		},
		{
			name = "roots",
			slider = ROOTS_slider,
			spells = {
				[53148] = 1,  -- Charge(pets)
				[53308] = 1,  -- Entangling Roots
					[339] = { parent = 53308 },
					[1062] = { parent = 53308 },
					[5195] = { parent = 53308 },
					[5196] = { parent = 53308 },
					[9852] = { parent = 53308 },
					[9853] = { parent = 53308 },
					[26989] = { parent = 53308 },
				[19675] = 1,	-- Feral Charge Effect (immobilize with interrupt [spell lockout, not silence])
				[48999] = 1,	-- Counterattack
					[19306] = { parent = 48999 },
					[20909] = { parent = 48999 },
					[20910] = { parent = 48999 },
					[27067] = { parent = 48999 },
					[48998] = { parent = 48999 },
				[19388] = 1,	-- Entrapment
					[19184] = { parent = 19388 },
					[19387] = { parent = 19388 },
				[53548] = 1,	-- Pin (Crab)
					[50245] = { parent = 53548 },
					[53544] = { parent = 53548 },
					[53545] = { parent = 53548 },
					[53546] = { parent = 53548 },
					[53547] = { parent = 53548 },
				[55509] = 1,	-- Venom Web Spray (Silithid)
					[54706] = { parent = 55509 },
					[55505] = { parent = 55509 },
					[55506] = { parent = 55509 },
					[55507] = { parent = 55509 },
					[55508] = { parent = 55509 },
				[4167]  = 1,	-- Web (Spider)
				[90112] = 1,	-- Naga (Sirus.su)
				[33395] = 1,	-- Freeze (Water Elemental)
				[42917] = 1,	-- Frost Nova
					[122] = { parent = 42917 },
					[865] = { parent = 42917 },
					[6131] = { parent = 42917 },
					[10230] = { parent = 42917 },
					[27088] = { parent = 42917 },
				[12494] = 1,	-- Frostbite
				[55080] = 1,	-- Shattered Barrier
				[64695] = 1,	-- Earthgrab (Storm, Earth and Fire)
				[63685] = 1,	-- Freeze (Frozen Power)
				[58373] = 1,	-- Glyph of Hamstring
				[23694] = 1,	-- Improved Hamstring
				[39965] = 1,	-- Frost Grenade
				[55536] = 1,	-- Frostweave Net
				[13099] = 1,	-- Net-o-Matic
				[308725] = 1,   -- Vulpera root (after 308726 (stun)) - Sirus.su
			}
		},
	}

function ns:GetCategoryByName(category)
    for key, tab in pairs(_CATEGORIES) do
        if ( tab.name == category ) then
            return tab;
        end
    end
end


function ns:GetCategoryBySpellID(spellID)
    for i, category in pairs(_CATEGORIES) do
		for spellId in pairs(category.spells) do
			if ( spellID == spellId ) then
				return category.name
			end
		end
    end
end

function ns:GetPriorityBySpellID(unit, spellID)
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
