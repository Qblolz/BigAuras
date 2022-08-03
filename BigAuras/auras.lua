BigAurasSpells = {}
BigAurasCategories = {
    totalImmunity = {
        name = "totalImmunity",
        priority = 10
   },
    immunity = {
        name = "immunity",
        priority = 9
   },
    crowdControl = {
        name = "crowdControl",
        priority = 8
   },
    defensive = {
        name = "defensive",
        priority = 7
   },
    offensive = {
        name = "offensive",
        priority = 6
   },
    roots = {
        name = "roots",
        priority = 5
   },
    other = {
        name = "other",
        priority = 4
   },
}
BigAurasSpells.spells = {
    --totalImmunity
        [642] = {category = "totalImmunity",priority = 1},
        [45438] = {category = "totalImmunity",priority = 1},


    --immunity
        [19263] = {category = "immunity",priority = 1},
        [46924] = {category = "immunity",priority = 1},
        [48707] = {category = "immunity",priority = 1},
        [34692] = {category = "immunity",priority = 1},
            [34471] = {parent = 34692},
        [31224] = {category = "immunity",priority = 1},
        [316243] = {category = "immunity",priority = 1},
        [316271] = {category = "immunity",priority = 1},
        [316294] = {category = "immunity",priority = 1},
        [316372] = {category = "immunity",priority = 1},
        [316405] = {category = "immunity",priority = 1},
        [316413] = {category = "immunity",priority = 1},
        [23920] = {category = "immunity",priority = 1},
            [43443] = {parent = 23920},
            [59725] = {parent = 23920},


    --crowdControl
        [49012] = {category = "crowdControl",priority = 1},
            [19386] = {parent = 49012},
            [24132] = {parent = 49012},
            [24133] = {parent = 49012},
            [27068] = {parent = 49012},
            [49011] = {parent = 49012},
            [49011] = {parent = 49012},
        [47481]= {category = "crowdControl",priority = 1},	-- Gnaw (Ghoul)
        [51209]= {category = "crowdControl",priority = 1},	-- Hungering Cold
        [8983]= {category = "crowdControl",priority = 1},	    -- Druid feral bash
            [5211] = {parent = 8983},
            [6798] = {parent = 8983},
        [58861]= {category = "crowdControl",priority = 1},    -- Bash (also Shaman Spirit Wolf ability)
        [33786]= {category = "crowdControl",priority = 1},	-- Cyclone
        [18658]= {category = "crowdControl",priority = 1},	-- Hibernate (works against Druids in most forms and Shamans using Ghost Wolf)
            [2637] = {parent = 18658},
            [18657] = {parent = 18658},
        [49802]= {category = "crowdControl",priority = 1},	-- Maim
            [22570] = {parent = 49802},
        [49803]= {category = "crowdControl",priority = 1},	-- Pounce
            [9005] = {parent = 49803},
            [9823] = {parent = 49803},
            [9827] = {parent = 49803},
            [27006] = {parent = 49803},
        [14309]= {category = "crowdControl",priority = 1},	-- Freezing Trap Effect
            [3355] = {parent = 14309},
            [14308] = {parent = 14309},
            [60210] = {parent = 14309},
        [24394]= {category = "crowdControl",priority = 1},	-- Intimidation
        [14327]= {category = "crowdControl",priority = 1},	-- Scare Beast (works against Druids in most forms and Shamans using Ghost Wolf)
            [1513] = {parent = 4327},
            [14326] = {parent = 14327},
        [19503]= {category = "crowdControl",priority = 1},	-- Scatter Shot
        [53568]= {category = "crowdControl",priority = 1},	-- Sonic Blast (Bat)
            [50519] = {parent = 53568},
            [53564] = {parent = 53568},
            [53565] = {parent = 53568},
            [53566] = {parent = 53568},
            [53567] = {parent = 53568},
        [53562]= {category = "crowdControl",priority = 1},	-- Ravage (Ravager)
        [44572]= {category = "crowdControl",priority = 1},	-- Deep Freeze
        [42950]= {category = "crowdControl",priority = 1},	-- Dragon's Breath
            [31661] = {parent = 42950}, -- Dragon's Breath
            [33041] = {parent = 42950}, -- Dragon's Breath
            [33042] = {parent = 42950}, -- Dragon's Breath
            [33043] = {parent = 42950}, -- Dragon's Breath
            [42949] = {parent = 42950}, -- Dragon's Breath
        [12355]= {category = "crowdControl",priority = 1},	-- Impact
        [118]= {category = "crowdControl",priority = 1},	    -- Polymorph
            [12824] = {parent = 118},	-- Polymorph (sheep)
            [12825] = {parent = 118},	-- Polymorph (sheep)
            [12826] = {parent = 118},	-- Polymorph (sheep)
            [28271] = {parent = 118},	-- Polymorph (turtle)
            [61721] = {parent = 118},	-- Polymorph (rabbit)
            [61305] = {parent = 118},	-- Polymorph (cat)
            [61025] = {parent = 118},	-- Polymorph (snake)
            [61780] = {parent = 118},	-- Polymorph (turkey)
            [71319] = {parent = 118},	-- Polymorph (turkey)
            [28272] = {parent = 118},	-- Polymorph (pig)
        [10308]= {category = "crowdControl",priority = 1},	-- Hammer of Justice
            [853] = {parent = 10308},
            [5588] = {parent = 10308},
            [5589] = {parent = 10308},
        [48817]= {category = "crowdControl",priority = 1},	-- Holy Wrath (works against Warlocks using Metamorphasis and Death Knights using Lichborne)
            [2812] = {parent = 48817},
            [10318] = {parent = 48817},
            [27139] = {parent = 48817},
            [48816] = {parent = 48817},
        [20066]= {category = "crowdControl",priority = 1},	-- Repentance
        [20170]= {category = "crowdControl",priority = 1},	-- Stun (Seal of Justice proc)
        [10326]= {category = "crowdControl",priority = 1},	-- Turn Evil (works against Warlocks using Metamorphasis and Death Knights using Lichborne)
        [605]= {category = "crowdControl",priority = 1},	-- Mind Control
        [64044]= {category = "crowdControl",priority = 1},	-- Psychic Horror
        [10890]= {category = "crowdControl",priority = 1},	-- Psychic Scream
            [8122] = {parent = 10890},
            [8124] = {parent = 10890},
            [10888] = {parent = 10890},
        [10955]= {category = "crowdControl",priority = 1},	-- Shackle Undead (works against Death Knights using Lichborne)
            [9484] = {parent = 10955},
            [9485] = {parent = 10955},
        [2094]= {category = "crowdControl",priority = 1},	-- Blind
        [1833]= {category = "crowdControl",priority = 1},	-- Cheap Shot
        [1776]= {category = "crowdControl",priority = 1},	-- Gouge
        [8643]= {category = "crowdControl",priority = 1},	-- Kidney Shot
            [408] = {parent = 8643},
        [51724]= {category = "crowdControl",priority = 1},	-- Sap
            [6770] = {parent = 51724},
            [2070] = {parent = 51724},
            [11297] = {parent = 51724},
        [39796]= {category = "crowdControl",priority = 1},	-- Stoneclaw Stun
        [51514]= {category = "crowdControl",priority = 1},	-- Hex
        [18647]= {category = "crowdControl",priority = 1},	-- Banish (works against Warlocks using Metamorphasis and Druids using Tree Form)
            [710] = {parent = 18647},
        [47860]= {category = "crowdControl",priority = 1},	-- Death Coil
            [6789] = {parent = 47860},
            [17925] = {parent = 47860},
            [17926] = {parent = 47860},
            [27223] = {parent = 47860},
            [47859] = {parent = 47860},
        [6215]= {category = "crowdControl",priority = 1},	-- Fear
            [5782] = {parent = 6215},
            [6213] = {parent = 6215},
        [17928]= {category = "crowdControl",priority = 1},	-- Howl of Terror
            [5484] = {parent = 17928},
        [6358]= {category = "crowdControl",priority = 1},	-- Seduction (Succubus)
        [47847]= {category = "crowdControl",priority = 1},	-- Shadowfury
            [30283] = {parent = 47847},
            [30413] = {parent = 47847},
            [30414] = {parent = 47847},
            [47846] = {parent = 47847},
        [7922]= {category = "crowdControl",priority = 1},	-- Charge Stun
        [20253]= {category = "crowdControl",priority = 1},	-- Intercept Stun (Warrior)
        [12809]= {category = "crowdControl",priority = 1},	-- Concussion Blow
        [25274]= {category = "crowdControl",priority = 1},	-- Intercept (also Warlock Felguard ability)
            [30153] = {parent = 25274},
            [30195] = {parent = 25274},
            [30197] = {parent = 25274},
            [47995] = {parent = 25274},
        [5246]= {category = "crowdControl",priority = 1},		-- Intimidating Shout
            [20511] = {parent = 5246},
        [12798]= {category = "crowdControl",priority = 1},	-- Revenge Stun
        [46968]= {category = "crowdControl",priority = 1},	-- Shockwave
        [316456]= {category = "crowdControl",priority = 1}, -- Vulpera stun
        [316443]= {category = "crowdControl",priority = 1},	-- Pandarien stun
        [316161]= {category = "crowdControl",priority = 1},	-- DarkIronDwarf stun
        [30217]= {category = "crowdControl",priority = 1},	-- Adamantite Grenade
            [67769] = {parent = 30217},
            [67890] = {parent = 30217},
        [67769]= {category = "crowdControl",priority = 1},	-- Cobalt Frag Bomb
        [30216]= {category = "crowdControl",priority = 1},	-- Fel Iron Bomb
        [316386]= {category = "crowdControl",priority = 1},	-- War Stomp
            -- Silences
        [47476]= {category = "crowdControl",priority = 1},	-- Strangulate
        [34490]= {category = "crowdControl",priority = 1},	-- Silencing Shot
        [55021]= {category = "crowdControl",priority = 1},	-- Silenced - Improved Counterspell
            [18469] = {parent = 55021},
        [63529]= {category = "crowdControl",priority = 1},	-- Shield of the Templar
        [15487]= {category = "crowdControl",priority = 1},	-- Silence
        [1330] = {category = "crowdControl",priority = 1},	-- Garrote - Silence
        [18425]= {category = "crowdControl",priority = 1},	-- Silenced - Improved Kick
        [24259]= {category = "crowdControl",priority = 1},	-- Spell Lock (Felhunter)
        [18498]= {category = "crowdControl",priority = 1},	-- Silenced - Gag Order
        [316421]= {category = "crowdControl",priority = 1},	-- Arcane Torrent (15 energy)
            [302387] = {parent = 316421},
            [316418] = {parent = 316421},
            [316419] = {parent = 316421},
            [316420] = {parent = 316421},
        [54785]= {category = "crowdControl",priority = 1},  -- Demon Charge


    --defensive
        [66] = {category = "defensive",priority = 1},    -- Invisibility(mage)
            [32612] = {parent = 66},
        [18708] = {category = "defensive",priority = 1}, -- Fel Domination
        [12975] = {category = "defensive",priority = 1}, -- Last Stand
        [48792] = {category = "defensive",priority = 1}, -- Ice bound
        [2565] = {category = "defensive",priority = 1}, -- Shield Block
        [20230] = {category = "defensive",priority = 1}, -- Retaliation
        [47585] = {category = "defensive",priority = 1}, -- Dispersion
        [55198] = {category = "defensive",priority = 1}, -- Tidal Force
        [48066] = {category = "defensive",priority = 1}, -- Power Word: Shield
            [17] = {parent = 48066},
            [592] = {parent = 48066},
            [600] = {parent = 48066},
            [3747] = {parent = 48066},
            [6065] = {parent = 48066},
            [6066] = {parent = 48066},
            [10898] = {parent = 48066},
            [10899] = {parent = 48066},
            [10900] = {parent = 48066},
            [10901] = {parent = 48066},
            [25217] = {parent = 48066},
            [25218] = {parent = 48066},
            [48065] = {parent = 48066},
        [20216] = {category = "defensive",priority = 1}, -- Divine Favor
        [53659] = {category = "defensive",priority = 1}, -- Sacred Cleansing
        [49039] = {category = "defensive",priority = 1}, -- Lichborne
        [3411] = {category = "defensive",priority = 1}, -- Intervene
        [54748] = {category = "defensive",priority = 1}, -- Burning Determination
        [55694] = {category = "defensive",priority = 1}, -- Enraged Regeneration
        [16188] = {category = "defensive",priority = 1}, -- Nature's Swiftness
        [26669] = {category = "defensive",priority = 1}, -- Evasion
            [5277] = {parent =26669},
        [8178] = {category = "defensive",priority = 1},  -- Grounding Totem Effect
        [33206] = {category = "defensive",priority = 1}, -- Pain Suppression
        [10060] = {category = "defensive",priority = 1}, -- Power Infusion
        [47788] = {category = "defensive",priority = 1}, -- Guardian Spirit
        [43039] = {category = "defensive",priority = 1}, -- Ice Barrier
            [11426] = {parent =43039},
            [13031] = {parent =43039},
            [13032] = {parent =43039},
            [13033] = {parent =43039},
            [27134] = {parent =43039},
            [33405] = {parent =43039},
            [43038] = {parent =43039},
        [43020] = {category = "defensive",priority = 1}, -- Mana Shield
            [1463] = {parent =43020},
            [8494] = {parent =43020},
            [8495] = {parent =43020},
            [10191] = {parent =43020},
            [10192] = {parent =43020},
            [10193] = {parent =43020},
            [27131] = {parent =43020},
            [43019] = {parent =43020},
        [43012] = {category = "defensive",priority = 1}, -- Frost Ward
            [6143] = {parent =43012},
            [8461] = {parent =43012},
            [8462] = {parent =43012},
            [10177] = {parent =43012},
            [28609] = {parent =43012},
            [32796] = {parent =43012},
        [43010] = {category = "defensive",priority = 1}, -- Fire Ward
            [543] = {parent =43010},
            [8457] = {parent =43010},
            [8458] = {parent =43010},
            [10223] = {parent =43010},
            [10225] = {parent =43010},
            [27128] = {parent =43010},
        [58597] = {category = "defensive",priority = 1}, -- Sacred Shield
        [53563] = {category = "defensive",priority = 1}, -- Beacon of Light
        [54428] = {category = "defensive",priority = 1}, -- Divine Plea
        [498] = {category = "defensive",priority = 1}, -- Divine Protection
        [871] = {category = "defensive",priority = 1}, -- ShieldWall
        [64205] = {category = "defensive",priority = 1}, -- Divine Sacrifice
        [1044] = {category = "defensive",priority = 1}, -- Hand of Freedom
        [6940] = {category = "defensive",priority = 1}, -- Hand of Sacrifice
        [10278] = {category = "defensive",priority = 1}, -- Hand of Protection
            [1022] = {parent =10278},
            [5599] = {parent =10278},
        [51052] = {category = "defensive",priority = 1}, -- Anti-Magic Zone
            [50461] = {parent = 51052},
        [49222] = {category = "defensive",priority = 1}, -- Bone Shield
        [55233] = {category = "defensive",priority = 1}, -- Vampiric Blood
        [29166] = {category = "defensive",priority = 1}, -- Innervate
        [22842] = {category = "defensive",priority = 1}, -- Frenzied Regeneration
        [22812] = {category = "defensive",priority = 1}, -- Barkskin
        [316255] = {category = "defensive",priority = 1}, -- after Meld


    --offensive
        [47241] = {category = "offensive",priority = 1},  -- Metamorphosis
        [51690] = {category = "offensive",priority = 1},  -- Killing Spree
        [31884] = {category = "offensive",priority = 1},  -- Avenging Wrath
        [2825] = {category = "offensive",priority = 1},  -- Bloodlust
        [32182] = {category = "offensive",priority = 1},  -- Heroism
        [1719] = {category = "offensive",priority = 1}, -- Recklessness
        [69369] = {category = "offensive",priority = 1},  -- Predator's Swiftness
        [51713] = {category = "offensive",priority = 1}, -- Shadow Dance
        [16166] = {category = "offensive",priority = 1},  -- Elemental Mastery
        [11719] = {category = "offensive",priority = 1},  -- Curse of Tongues
            [1714] = {parent = 11719},
        [14751] = {category = "offensive",priority = 1},  -- Inner Focus
        [12043] = {category = "offensive",priority = 1},  -- Presence of Mind
        [12472] = {category = "offensive",priority = 1},  -- Icy Veins
        [12042] = {category = "offensive",priority = 1},  -- Arcane Power
        [3045] = {category = "offensive",priority = 1},  -- Rapid Fire
        [53201] = {category = "offensive",priority = 1}, -- Starfall
            [48505] = {parent = 53201},
            [53199] = {parent = 53201},
            [53200] = {parent = 53201},
        [34692] = {category = "offensive",priority = 1}, -- The Beast Within
        [50334] = {category = "offensive",priority = 1}, -- Berserk
        [49016] = {category = "offensive",priority = 1}, -- Hysteria
        [51271] = {category = "offensive",priority = 1}, -- Unbreakable Armor
        -- Disarms
        [53359] = {category = "offensive",priority = 1}, -- Chimera Shot - Scorpid
        [53543] = {category = "offensive",priority = 1}, -- Snatch (Bird of Prey)
            [50541] = {parent = 53543},
            [53537] = {parent = 53543},
            [53538] = {parent = 53543},
            [53540] = {parent = 53543},
            [53542] = {parent = 53543},
        [64346] = {category = "offensive",priority = 1}, -- Fiery Payback
        [64058] = {category = "offensive",priority = 1}, -- Psychic Horror disarm
        [51722] = {category = "offensive",priority = 1}, -- Dismantle
        [676]   = {category = "offensive",priority = 1}, -- Disarm


    --other
        [308876] = {category = "other", priority = 1}, -- Necrotic trinket(sirus.su)
            [308874] = {parent = 308876},
            [308875] = {parent = 308876},
            [308877] = {parent = 308876},
            [308878] = {parent = 308876},
            [308879] = {parent = 308876},
            [316612] = {parent = 308876},
        
        
    --roots
        [319322] = {category = "roots",priority = 1}, -- Lightforged
        [53148] = {category = "roots",priority = 1},  -- Charge(pets)
        [53308] = {category = "roots",priority = 1},  -- Entangling Roots
            [339] = {parent = 53308},
            [1062] = {parent = 53308},
            [5195] = {parent = 53308},
            [5196] = {parent = 53308},
            [9852] = {parent = 53308},
            [9853] = {parent = 53308},
            [26989] = {parent = 53308},
            [26989] = {parent = 53308},
        [19675] = {category = "roots",priority = 1},	-- Feral Charge Effect (immobilize with interrupt [spell lockout, not silence])
        [48999] = {category = "roots",priority = 1},	-- Counterattack
            [19306] = {parent = 48999},
            [20909] = {parent = 48999},
            [20910] = {parent = 48999},
            [27067] = {parent = 48999},
            [48998] = {parent = 48999},
        [19388] = {category = "roots",priority = 1},	-- Entrapment
            [19184] = {parent = 19388},
            [19387] = {parent = 19388},
            [64804] = {parent = 19388},
            [19387] = {parent = 19388},
            [19184] = {parent = 19388},
            [19975] = {parent = 19388},
            [19974] = {parent = 19388},
            [19973] = {parent = 19388},
            [19972] = {parent = 19388},
            [19971] = {parent = 19388},
            [19970] = {parent = 19388},
            [27010] = {parent = 19388},
            [53313] = {parent = 19388},
        [53548] = {category = "roots",priority = 1},	-- Pin (Crab)
            [50245] = {parent = 53548},
            [53544] = {parent = 53548},
            [53545] = {parent = 53548},
            [53546] = {parent = 53548},
            [53547] = {parent = 53548},
        [55509] = {category = "roots",priority = 1},	-- Venom Web Spray (Silithid)
            [54706] = {parent = 55509},
            [55505] = {parent = 55509},
            [55506] = {parent = 55509},
            [55507] = {parent = 55509},
            [55508] = {parent = 55509},
        [4167]  = {category = "roots",priority = 1},	-- Web (Spider)
        [90112] = {category = "roots",priority = 1},	-- Naga (Sirus.su)
        [33395] = {category = "roots",priority = 1},	-- Freeze (Water Elemental)
        [42917] = {category = "roots",priority = 1},	-- Frost Nova
            [122] = {parent = 42917},
            [865] = {parent = 42917},
            [6131] = {parent = 42917},
            [10230] = {parent = 42917},
            [27088] = {parent = 42917},
        [12494] = {category = "roots",priority = 1},	-- Frostbite
        [55080] = {category = "roots",priority = 1},	-- Shattered Barrier
        [64695] = {category = "roots",priority = 1},	-- Earthgrab (Storm, Earth and Fire)
        [63685] = {category = "roots",priority = 1},	-- Freeze (Frozen Power)
        [58373] = {category = "roots",priority = 1},	-- Glyph of Hamstring
        [23694] = {category = "roots",priority = 1},	-- Improved Hamstring
        [39965] = {category = "roots",priority = 1},	-- Frost Grenade
        [55536] = {category = "roots",priority = 1},	-- Frostweave Net
        [13099] = {category = "roots",priority = 1},	-- Net-o-Matic
        [316455] = {category = "roots",priority = 1},   -- Vulpera root (after (stun)) - Sirus.su
}

function BigAurasSpells:GetListCategories()
    local _table = {}
    for index, tab in pairs(BigAurasCategories) do
        _table[index] = tab.name
    end

    return _table
end
