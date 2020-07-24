local _G = _G
local ipairs, pairs, select = ipairs, pairs, select
local floor = math.floor
local format = string.format
local tinsert, tremove = table.insert, table.remove

local GetTime = GetTime
local UnitAura = UnitAura
local UIParent = UIParent

BigAuras = CreateFrame("Frame")
local BigAuras = BigAuras

BigAuras.default = {
	version = 3.1,
	uiAnchor = "Blizzard",
	anchorsConfiguration = {
		player = {
			enable = true,
			size = 48,
			offsetX = 0,
			offsetY = 0,
			alpha = 1,
			unlock = false,
			showSwipe = true,
		},
		pet = {
			enable = true,
			size = 48,
			offsetX = 0,
			offsetY = 0,
			alpha = 1,
			unlock = false,
			showSwipe = true,
		},
		target = {
			enable = true,
			size = 48,
			offsetX = 0,
			offsetY = 0,
			alpha = 1,
			unlock = false,
			showSwipe = true,
		},
		focus = {
			enable = true,
			size = 48,
			offsetX = 0,
			offsetY = 0,
			alpha = 1,
			unlock = false,
			showSwipe = true,
		},
		party1 = {
			enable = true,
			size = 48,
			offsetX = 0,
			offsetY = 0,
			alpha = 1,
			unlock = false,
			showSwipe = true,
		},
		party2 = {
			enable = true,
			size = 48,
			offsetX = 0,
			offsetY = 0,
			alpha = 1,
			unlock = false,
			showSwipe = true,
		},
		party3 = {
			enable = true,
			size = 48,
			offsetX = 0,
			offsetY = 0,
			alpha = 1,
			unlock = false,
			showSwipe = true,
		},
		party4 = {
			enable = true,
			size = 48,
			offsetX = 0,
			offsetY = 0,
			alpha = 1,
			unlock = false,
			showSwipe = true,
		},
		arena1 = {
			enable = true,
			size = 48,
			offsetX = 0,
			offsetY = 0,
			alpha = 1,
			unlock = false,
			showSwipe = true,
		},
		arena2 = {
			enable = true,
			size = 48,
			offsetX = 0,
			offsetY = 0,
			alpha = 1,
			unlock = false,
			showSwipe = true,
		},
		arena3 = {
			enable = true,
			size = 48,
			offsetX = 0,
			offsetY = 0,
			alpha = 1,
			unlock = false,
			showSwipe = true,
		},
		arena4 = {
			enable = true,
			size = 48,
			offsetX = 0,
			offsetY = 0,
			alpha = 1,
			unlock = false,
			showSwipe = true,
		},
		arena5 = {
			enable = true,
			size = 48,
			offsetX = 0,
			offsetY = 0,
			alpha = 1,
			unlock = false,
			showSwipe = true,
		}
	},
}

BigAuras.categories = {
	{
		name = "CrowdControl",
		priority = 175,
		spells = {
			[49012] = 175,	-- Wyvern Sting
			[47481] = 175,	-- Gnaw (Ghoul)
			[51209] = 175,	-- Hungering Cold
			[8983] = 175,	-- Druid feral bash
			[58861] = 175,  -- Bash (also Shaman Spirit Wolf ability)
			[33786] = 175,	-- Cyclone
			[18658] = 175,	-- Hibernate (works against Druids in most forms and Shamans using Ghost Wolf)
			[49802] = 175,	-- Maim
			[49803] = 175,	-- Pounce
			[14309] = 175,	-- Freezing Trap Effect
			[60210] = 175,  -- Freezing Trap Effect v2
			[24394] = 175,	-- Intimidation
			[14327] = 175,	-- Scare Beast (works against Druids in most forms and Shamans using Ghost Wolf)
			[19503] = 175,	-- Scatter Shot
			[53568] = 175,	-- Sonic Blast (Bat)
			[53562] = 175,	-- Ravage (Ravager)
			[44572] = 175,	-- Deep Freeze
			[42950] = 175,	-- Dragon's Breath
			[12355] = 175,	-- Impact
			[118] = 175,	-- Polymorph
			[12826] = 175,	-- Polymorph (sheep)
			[28271] = 175,	-- Polymorph (turtle)
			[61721] = 175,	-- Polymorph (rabbit)
			[61305] = 175,	-- Polymorph (cat)
			[61025] = 175,	-- Polymorph (snake)
			[61780] = 175,	-- Polymorph (turkey)
			[71319] = 175,	-- Polymorph (turkey)
			[28272] = 175,	-- Polymorph (pig)
			[10308] = 175,	-- Hammer of Justice
			[48817] = 175,	-- Holy Wrath (works against Warlocks using Metamorphasis and Death Knights using Lichborne)
			[20066] = 175,	-- Repentance
			[20170] = 175,	-- Stun (Seal of Justice proc)
			[10326] = 175,	-- Turn Evil (works against Warlocks using Metamorphasis and Death Knights using Lichborne)
			[605] = 175,	-- Mind Control
			[64044] = 175,	-- Psychic Horror
			[10890] = 175,	-- Psychic Scream
			[10955] = 175,	-- Shackle Undead (works against Death Knights using Lichborne)
			[2094] = 175,	-- Blind
			[1833] = 175,	-- Cheap Shot
			[1776] = 175,	-- Gouge
			[8643] = 175,	-- Kidney Shot
			[51724] = 175,	-- Sap
			[39796] = 175,	-- Stoneclaw Stun
			[51514] = 175,	-- Hex
			[18647] = 175,	-- Banish (works against Warlocks using Metamorphasis and Druids using Tree Form)
			[47860] = 175,	-- Death Coil
			[6215] = 175,	-- Fear
			[17928] = 175,	-- Howl of Terror
			[6358] = 175,	-- Seduction (Succubus)
			[47847] = 175,	-- Shadowfury
			[7922] = 175,	-- Charge Stun
			[20253] = 175,	-- Intercept Stun (Warrior)
			[12809] = 175,	-- Concussion Blow
			[25274] = 175,	-- Intercept (also Warlock Felguard ability)
			[5246] = 175,	-- Intimidating Shout
			[20511] = 175,	-- Intimidating Shout
			[12798] = 175,	-- Revenge Stun
			[46968] = 175,	-- Shockwave
			[308726] = 175, -- Vulpera stun
			[90101] = 175,	-- Pandarien stun
			[30217] = 175,	-- Adamantite Grenade
			[67769] = 175,	-- Cobalt Frag Bomb
			[30216] = 175,	-- Fel Iron Bomb
			[20549] = 175,	-- War Stomp
			-- Silences
			[47476] = 175,	-- Strangulate
			[34490] = 175,	-- Silencing Shot
			[55021] = 175,	-- Silenced - Improved Counterspell
			[63529] = 175,	-- Shield of the Templar
			[15487] = 175,	-- Silence
			[1330]  = 175,	-- Garrote - Silence
			[18425] = 175,	-- Silenced - Improved Kick
			[24259] = 175,	-- Spell Lock (Felhunter)
			[18498] = 175,	-- Silenced - Gag Order
			[25046] = 175,	-- Arcane Torrent (15 energy)
			[50613] = 175,  -- Arcane Torrent (15 runes)
			[28730] = 175,  -- Arcane Torrent (6% mana)
		}
	},
	{
		name = "Buffs defensive",
		priority = 50,
		spells = {
			[66] = 50,    -- Invisibility(mage)
			[32612] = 50, -- Invisibility (buff) (mage)
			[18708] = 50, -- Fel Domination
			[12975] = 50, -- Last Stand
			[48792] = 50, -- Ice bound
			[2565] = 50, -- Shield Block
			[20230] = 50, -- Retaliation
			[47585] = 50, -- Dispersion
			[55198] = 50, -- Tidal Force
			[48066] = 50, -- Power Word: Shield
			[20216] = 50, -- Divine Favor
			[53659] = 50, -- Sacred Cleansing
			[50461] = 50, -- Anti-Magic Zone
			[49039] = 50, -- Lichborne
			[3411] = 50, -- Intervene
			[54748] = 60, -- Burning Determination
			[55694] = 50, -- Enraged Regeneration
			[16188] = 50, -- Nature's Swiftness
			[26669] = 50, -- Evasion
			[8178] = 50,  -- Grounding Totem Effect
			[33206] = 50, -- Pain Suppression
			[10060] = 50, -- Power Infusion
			[47788] = 50, -- Guardian Spirit
			[43039] = 50, -- Ice Barrier
			[43020] = 50, -- Mana Shield
			[43012] = 50, -- Frost Ward
			[43010] = 50, -- Fire Ward
			[58597] = 50, -- Sacred Shield
			[53563] = 10, -- Beacon of Light
			[54428] = 50, -- Divine Plea
			[498] = 50, -- Divine Protection
			[871] = 50, -- ShieldWall
			[64205] = 50, -- Divine Sacrifice
			[1044] = 50, -- Hand of Freedom
			[6940] = 50, -- Hand of Sacrifice
			[10278] = 50, -- Hand of Protection
			[51052] = 50, -- Anti-Magic Zone
			[49222] = 50, -- Bone Shield
			[55233] = 50, -- Vampiric Blood
			[29166] = 50, -- Innervate
			[22842] = 50, -- Frenzied Regeneration
			[22812] = 50, -- Barkskin
		}
	},
	{
		name = "Buffs offensive",
		priority = 40,
		spells = {
			[47241] = 40,  -- Metamorphosis
			[51690] = 40,  -- Killing Spree
			[31884] = 40,  -- Avenging Wrath
			[2825] = 40,  -- Bloodlust
			[32182] = 40,  -- Heroism
			[1719] = 40, -- Recklessness
			[69369] = 40,  -- Predator's Swiftness
			[51713] = 40, -- Shadow Dance
			[16166] = 40,  -- Elemental Mastery
			[11719] = 40,  -- Curse of Tongues
			[14751] = 40,  -- Inner Focus
			[12043] = 40,  -- Presence of Mind
			[12472] = 40,  -- Icy Veins
			[12042] = 40,  -- Arcane Power
			[3045] = 40,  -- Rapid Fire
			[53201] = 40, -- Starfall
			[34692] = 40, -- The Beast Within
			[50334] = 40, -- Berserk
			[49016] = 40, -- Hysteria
			[51271] = 40, -- Unbreakable Armor
			-- Disarms
			[53359] = 40, -- Chimera Shot - Scorpid
			[53543] = 40, -- Snatch (Bird of Prey)
			[64346] = 40, -- Fiery Payback
			[64058] = 40, -- Psychic Horror disarm
			[51722] = 40, -- Dismantle
			[676]   = 40, -- Disarm
		}
	},
	{
		name = "Buffs other",
		priority = 10,
		spells = {
			[308876]   = 40, -- Necrotic trinket (245 ilvl) (sirus.su)
			[308877]   = 40, -- Necrotic trinket (264 ilvl) (sirus.su)
			[308878]   = 40, -- Necrotic trinket (274 ilvl) (sirus.su)
			[308879]   = 40, -- Necrotic trinket (284 ilvl) (sirus.su)
		}
	},
	{
		name = "Immunities",
		priority = 200,
		spells = {
			[642]   = 200,	-- Divine Shield (Paladin)
			[45438] = 200,	-- Ice Block (Mage)
		}
	},
	{
		name = "Immunities spells",
		priority = 150,
		spells = {
			[19263] = 150,	-- Deterrenct (Hunter)
			[46924] = 150,	-- Bladestorm (Warrior)
			[90113] = 150,	-- Barrier of reflect
			[48707] = 150,	-- DK Anti-Magic Shell
			[34692] = 150,	-- The Beast Within (Hunter)
			[31224] = 150,	-- Cloak of Shadows
			[34471] = 150,	-- The Beast Within
			[23920] = 150,	-- Warrior reflect
		}
	},
	{
		name = "Roots",
		priority = 100,
		spells = {
			[53308]   = 100,  -- Entangling Roots
			[19675] = 100,	-- Feral Charge Effect (immobilize with interrupt [spell lockout, not silence])
			[48999] = 100,	-- Counterattack
			[19388] = 100,	-- Entrapment
			[53548] = 100,	-- Pin (Crab)
			[55509] = 100,	-- Venom Web Spray (Silithid)
			[4167]  = 100,	-- Web (Spider)
			[90112]  = 100,	-- Naga (Sirus.su)
			[33395] = 100,	-- Freeze (Water Elemental)
			[42917] = 100,  -- Frost Nova
			[12494] = 100,	-- Frostbite
			[55080] = 100,	-- Shattered Barrier
			[64695] = 100,	-- Earthgrab (Storm, Earth and Fire)
			[63685] = 100,	-- Freeze (Frozen Power)
			[58373] = 100,	-- Glyph of Hamstring
			[23694] = 100,	-- Improved Hamstring
			[39965] = 100,	-- Frost Grenade
			[55536] = 100,	-- Frostweave Net
			[13099] = 100,	-- Net-o-Matic
			[308725] = 100, -- Vulpera root (after 308726 (stun)) - Sirus.su
		}
	},
	--[[{
		name = "Interrupts",
		priority = 170,
		showSpells = false,
		spells = {
			[6552] = 4,   -- [Warrior] Pummel
			[1766] = 5,   -- [Rogue] Kick
			[47528] = 4,  -- [DK] Mind Freeze
			[57994] = 2,  -- [Shaman] Wind Shear
			[19647] = 6,  -- [Warlock] Spell Lock
			[72] = 6,	  -- [Warrior] Shield Bash
			[132409] = 6, -- [Warlock] Spell Lock
			[2139] = 6,   -- [Mage] Counterspell
			[16979] = 4,  -- [Feral] Feral Charge (Bear)
		}
	},]]
}

BigAuras.uiAnchors = {
	["Blizzard"] = {
		noPortraits = false,
	},
	["Perl"] = {
		noPortraits = false,
	},
	["XPerl"] = {
		noPortraits = true,
	},
	["ElvUI"] = {
		noPortraits = true,
	},
	["ShadowedUnitFrames"] = {
		noPortraits = true,
	},
}

BigAuras.anchors = {
	["player"] = {
		["Blizzard"] = "PlayerPortrait",
		["Perl"] = "Perl_Player_Portrait",
		["XPerl"] = "XPerl_PlayerportraitFrameportrait",
		["ElvUI"] = "ElvUF_Player",
		["ShadowedUnitFrames"] = "SUFUnitplayer"
	},
	["pet"] = {
		["Blizzard"] = "PetPortrait",
		["Perl"] = nil,
		["XPerl"] = "XPerl_Player_PetportraitFrame",
		["ElvUI"] = "ElvUF_Pet",
		["ShadowedUnitFrames"] = "SUFUnitpet"
	},
	["target"] = {
		["Blizzard"] = "TargetFramePortrait",
		["Perl"] = "Perl_Target_Portrait",
		["XPerl"] = "XPerl_TargetportraitFrameportrait",
		["ElvUI"] = "ElvUF_Target",
		["ShadowedUnitFrames"] = "SUFUnittarget"
	},
	["focus"] = {
		["Blizzard"] = "FocusFramePortrait",
		["Perl"] = "Perl_Focus_Portrait",
		["XPerl"] = "XPerl_FocusportraitFrameportrait",
		["ElvUI"] = "ElvUF_Focus",
		["ShadowedUnitFrames"] = "SUFUnitfocus"
	},
	["party1"] = {
		["Blizzard"] = "PartyMemberFrame1Portrait",
		["Perl"] = "Perl_Party_MemberFrame1_Portrait",
		["XPerl"] = "XPerl_party1portraitFrameportrait",
		["ElvUI"] = "ElvUF_PartyGroup1UnitButton1",
		["ShadowedUnitFrames"] = "SUFHeaderpartyUnitButton2"
	},
	["party2"] = {
		["Blizzard"] = "PartyMemberFrame2Portrait",
		["Perl"] = "Perl_Party_MemberFrame2_Portrait",
		["XPerl"] = "XPerl_party2portraitFrameportrait",
		["ElvUI"] = "ElvUF_PartyGroup1UnitButton2",
		["ShadowedUnitFrames"] = "SUFHeaderpartyUnitButton2"
	},
	["party3"] = {
		["Blizzard"] = "PartyMemberFrame3Portrait",
		["Perl"] = "Perl_Party_MemberFrame3_Portrait",
		["XPerl"] = "XPerl_party3portraitFrameportrait",
		["ElvUI"] = "ElvUF_PartyGroup1UnitButton3",
		["ShadowedUnitFrames"] = "SUFHeaderpartyUnitButton3"
	},
	["party4"] = {
		["Blizzard"] = "PartyMemberFrame4Portrait",
		["Perl"] = "Perl_Party_MemberFrame4_Portrait",
		["XPerl"] = "XPerl_party4portraitFrameportrait",
		["ElvUI"] = "ElvUF_PartyGroup1UnitButton4",
		["ShadowedUnitFrames"] = "SUFHeaderpartyUnitButton4"
	},
	["arena1"] = {
		["Blizzard"] = "ArenaEnemyFrame1ClassPortrait",
		["Perl"] = nil,
		["XPerl"] = nil,
		["ElvUI"] = "ElvUF_Arena1",
		["ShadowedUnitFrames"] = nil
	},
	["arena2"] = {
		["Blizzard"] = "ArenaEnemyFrame2ClassPortrait",
		["Perl"] = nil,
		["XPerl"] = nil,
		["ElvUI"] = "ElvUF_Arena2",
		["ShadowedUnitFrames"] = nil
	},
	["arena3"] = {
		["Blizzard"] = "ArenaEnemyFrame3ClassPortrait",
		["Perl"] = nil,
		["XPerl"] = nil,
		["ElvUI"] = "ElvUF_Arena3",
		["ShadowedUnitFrames"] = nil
	},
	["arena4"] = {
		["Blizzard"] = "ArenaEnemyFrame4ClassPortrait",
		["Perl"] = nil,
		["XPerl"] = nil,
		["ElvUI"] = "ElvUF_Arena4",
		["ShadowedUnitFrames"] = nil
	},
	["arena5"] = {
		["Blizzard"] = "ArenaEnemyFrame5ClassPortrait",
		["Perl"] = nil,
		["XPerl"] = nil,
		["ElvUI"] = "ElvUF_Arena5",
		["ShadowedUnitFrames"] = nil
	}
}
BigAuras.frames = {}

BigAuras:RegisterEvent("PLAYER_LOGIN")
BigAuras:RegisterEvent("ADDON_LOADED")
BigAuras:RegisterEvent("UNIT_AURA")
BigAuras:RegisterEvent("PLAYER_TARGET_CHANGED")
BigAuras:RegisterEvent("PLAYER_FOCUS_CHANGED")
BigAuras:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

function BigAuras:PLAYER_LOGIN()
	for unit in pairs(self.anchors) do
		self:CreateAndUpdateFrame(unit)
	end

	self:IninOptions()
end

function BigAuras:ADDON_LOADED(addon)
	if addon == "BigAuras" then
		if not BigAurasDB or BigAurasDB.version < self.default.version then
			BigAurasDB = CopyTable(self.default)
		end

		self.db = BigAurasDB
	elseif addon == "Blizzard_ArenaUI" or addon == "Perl" or addon == "XPerl" or addon == "ElvUI" or addon == "ShadowedUnitFrames" then
		for unit in pairs(self.anchors) do
			self:CreateAndUpdateFrame(unit)
		end
	end
end

function BigAuras:UNIT_AURA(unit)
	if not unit then return end

	self:UpateUnit(unit)
end

function BigAuras:PLAYER_TARGET_CHANGED()
	self:UpateUnit("target")
end
function BigAuras:PLAYER_FOCUS_CHANGED()
	self:UpateUnit("focus")
end

local GetAnchor = {
    ShadowedUnitFrames = function(anchor)
        local frame = _G[anchor]
        if not frame then return end

        if frame.portrait and frame.portrait:IsShown() then
            return frame.portrait
        else
            return frame
        end
    end,
    XPerl = function(anchor)
        local frame = _G[anchor]
        if not frame then return end

        if frame:IsShown() then
            return frame
        else
            return frame:GetParent()
        end
    end,
	ElvUI = function(anchor)
		local frame = _G[anchor]
		if not frame then return end

		return frame
	end
}

local function formatTime(s)
	return format("%.1f", s)
end

local function UptateTime(self, elapsed)
	self.timeLeft = self.timeLeft - elapsed

	if self.timeLeft < 0 then
		self.Text:SetText("")
		self:SetScript("OnUpdate", nil)
		return
	end
	self.Text:SetText(formatTime(self.timeLeft))
end

local function SetTime(self, expiration, duration)
	self:Show()

	if expiration == 0 or duration == 0 then
		self:SetScript("OnUpdate", nil)
		self.Text:Hide()
	else
		self.timeLeft = expiration - GetTime()
		self:SetScript("OnUpdate", UptateTime)
		self.Text:SetText(formatTime(self.timeLeft))
		self.Text:Show()
	end
end

local function SetCooldownTime(self, expiration, duration)
	self:Show()

	self.Cooldown:SetCooldown(expiration - duration, duration)
end

function BigAuras:GetParent(unit)
	if not self.anchors[unit] or not self.anchors[unit][self.db.uiAnchor] then
		return
	end

	local parent, portrait = self.anchors[unit][self.db.uiAnchor]
	if self.uiAnchors[self.db.uiAnchor].noPortraits and parent then
		local getAnchor = GetAnchor[self.db.uiAnchor]
		if getAnchor then
			return getAnchor(parent)
		else
			return _G[parent]
		end
	else
		portrait = _G[parent]

		if portrait then
			parent = portrait:GetParent()
		else
			return
		end
	end

	return parent, portrait
end

function BigAuras:CreateAndUpdateFrame(unit)
	local db = self.db.anchorsConfiguration[unit]
	if db.enable then
		local parent, portrait = self:GetParent(unit)
		parent = parent or UIParent

		if not self.frames[unit] then
			self.frames[unit] = self:CreateFrame(unit, parent)
		else
			local oldParent = self.frames[unit]:GetParent()
			if oldParent ~= parent then
				self.frames[unit]:SetParent(parent)
				self.frames[unit]:SetFrameLevel(self:GetFrameLevel() + 1)
			end
		end

		local frame = self.frames[unit]

		if db.unlock or parent == UIParent then
			frame:ClearAllPoints()
			frame:SetScale(1)
			frame:SetPoint("CENTER", db.offsetX, db.offsetY)
			frame:SetSize(db.size, db.size)
			frame:SetAlpha(db.alpha)
			frame.Cooldown:SetAllPoints()
		else
			frame:SetAlpha(1)

			if portrait and self.db.uiAnchor == "Blizzard" then
				portrait:SetDrawLayer("BACKGROUND")

				frame:SetFrameLevel(parent:GetFrameLevel())
				frame:SetScale(parent:GetScale())
				frame:SetAllPoints(portrait)
				frame.Cooldown:ClearAllPoints()
				frame.Cooldown:SetPoint("TOPLEFT", portrait, 3, -3)
				frame.Cooldown:SetPoint("BOTTOMRIGHT", portrait, -3, 3)
			else
				frame:SetFrameLevel(parent:GetFrameLevel() + 10)
				frame:SetScale(parent:GetScale())
				frame:SetAllPoints(parent)
				frame.Cooldown:SetAllPoints(parent)
			end
		end

		if not db.showSwipe then
			frame:SetScript("OnUpdate", nil)
			frame.Text:Hide()
			frame.Cooldown:Show()
			frame.SetTime = SetTime
		else
			frame.Text:Show()
			frame.Cooldown:Hide()
			frame.SetTime = SetCooldownTime
		end

		frame.db = db

		if not db.spells then
			db.spells = {}
			frame:CollectSpells()
		end

		if not db.categories then
			db.categories = {}
			frame:CollectCategories()
		end

		frame:ClearSpellData()
	else
		self.frames[unit]:Hide()
	end
end

local frameFunctions = {
	CollectSpells = function(self)
		for key, categoryData in pairs(BigAuras.categories) do
--			if categoryData.showSpells then
				for spellID, spellPriority in pairs(categoryData.spells) do
					self:AddSpell(categoryData, spellID)
				end
--			end
		end
	end,
	CollectCategories = function(self)
		for key, categoryData in pairs(BigAuras.categories) do
			self:AddCategory(categoryData.name, categoryData.priority, true, nil)
		end
	end,
	AddCategory = function(self, name, priority, enabled, key)
		local _category = {
			name = name,
			priority = priority,
			enabled = enabled,
		}

		if key then
			self.db[key] = _category
		else
			tinsert(self.db.categories, _category)
		end
	end,
	AddSpell = function(self, categoryData, spellID)
		if categoryData then
			local spellPriority = categoryData.spells[spellID]
			self.db.spells[spellID] = {
				categoryPriority = categoryData.priority,
				spellPriority = spellPriority
			}
		end
	end,
	RemoveSpell = function(self, spellID)
		tremove(self.db.spells, spellID)
	end,

	RemoveAura = function(self)
		self:Hide()
	end,
	ClearSpellData = function(self)
		self.showingSpellID = nil
		self.showingSpellPriority = nil
		self.showingCategoryPriority = nil
		self.showingSpellDuration = nil
		self.showingSpellExpirationTime = nil
	end,
}

function BigAuras:CreateFrame(unit, parent)
	local frame = CreateFrame("Frame", "BigAuras_"..unit, parent)

	frame.auraTrackerStorage = {}

	frame.Icon = frame:CreateTexture(nil, "BORDER")
	frame.Icon:SetAllPoints()

	frame.Text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	frame.Text:SetPoint("CENTER")
	frame.Text:SetTextColor(1,1,1,1)
	
	local font, size = frame.Text:GetFont()
	if unit:find("party") or unit:find("arena") then
		frame.Text:SetFont(font, size/1.4, "OUTLINE")
	else
		frame.Text:SetFont(font, size, "OUTLINE")
	end
	
	frame.Text:Hide()

	frame.UnitText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	frame.UnitText:SetPoint("BOTTOM", frame, "TOP")
	frame.UnitText:Hide()

	frame.Cooldown = CreateFrame("Cooldown", "$parentCooldown", frame)
	frame.Cooldown:SetFrameLevel(frame:GetFrameLevel())
	frame.Cooldown:SetAllPoints()
	frame.Cooldown:SetReverse(true)
	frame.Cooldown:Hide()

	for k, v in pairs(frameFunctions) do
		frame[k] = v
	end

	return frame
end

local auraFilters = {"HARMFUL", "HELPFUL"}
function BigAuras:UpateUnit(unit)
	local frame = self.db.anchorsConfiguration[unit] and self.db.anchorsConfiguration[unit].enable and self.frames[unit]
	if not frame then return end
    for _, auraFilter in ipairs(auraFilters) do
        for i = 1, 40 do
            local _, _, icon, _, _, duration, expirationTime, _, _, _, spellID = UnitAura(unit, i, auraFilter)
            if spellID then
				local categoryPriority, spellPriority
				local spellData =  frame.db.spells[spellID]
				if spellData then
					categoryPriority = spellData.categoryPriority
					spellPriority = spellData.spellPriority
				end

                if spellPriority and spellPriority ~= 0 and categoryPriority and categoryPriority > 0 then
					local hasAura = frame.auraTrackerStorage[spellID] and frame.auraTrackerStorage[spellID].status

					frame.auraTrackerStorage[spellID] = {
						categoryPriority = categoryPriority,
						spellPriority = spellPriority,
						status = false,
						auraFilter = auraFilter,
						expirationTime = expirationTime,
					}

                    if (not hasAura and not frame.showingSpellID)
						or (hasAura and not frame.showingSpellID)
						or (frame.showingSpellID and (frame.showingCategoryPriority < categoryPriority or (frame.showingCategoryPriority == categoryPriority and frame.showingSpellPriority < spellPriority)))
						or (frame.showingSpellID and frame.showingSpellID == spellID and frame.showingSpellExpirationTime > expirationTime)
						or (frame.showingSpellID and frame.showingCategoryPriority == categoryPriority and frame.showingSpellPriority == spellPriority and frame.showingSpellExpirationTime < expirationTime)
					then
						frame.showingSpellID = spellID
						frame.showingSpellPriority = spellPriority
						frame.showingCategoryPriority = categoryPriority
						frame.showingSpellDuration = duration
						frame.showingSpellExpirationTime = expirationTime

						if frame.db.unlock or BigAuras.db.uiAnchor ~= "Blizzard" then
							frame.Icon:SetTexture(icon)
						else
							SetPortraitToTexture(frame.Icon, icon)
						end

						frame:SetTime(expirationTime, duration)
                    end
                end
            end
        end
    end

	for spellID, spellData in pairs(frame.auraTrackerStorage) do
		if not spellData.status then
			frame.auraTrackerStorage[spellID].status = true
		else
			frame.auraTrackerStorage[spellID] = nil

			if frame.showingSpellID == spellID then
				frame:ClearSpellData()
				BigAuras:UpateUnit(unit)
				break
			end
		end
    end

	if not frame.showingCategoryPriority then
		frame:Hide()
	end
end

function BigAuras:TestMode()
	if self.db.testMode then
		for unit in pairs(self.anchors) do
			local frame = self.frames[unit]
			frame:SetTime(GetTime() + 120, 120)

			if frame.db.unlock or BigAuras.db.uiAnchor ~= "Blizzard" then
				frame.Icon:SetTexture("Interface\\Icons\\inv_jewelry_trinketpvp_01")
			else
				SetPortraitToTexture(frame.Icon, "Interface\\Icons\\inv_jewelry_trinketpvp_01")
			end

			frame.UnitText:Show()
			frame.UnitText:SetText(unit)
		end
	else
		for unit in pairs(self.anchors) do
			self.frames[unit]:Hide()
			self.frames[unit].UnitText:Hide()
		end
	end
end

function BigAuras:OnInterrupt( ... )
	local subEvent = select(2, ...)

	if subEvent ~= "SPELL_CAST_SUCCESS" and subEvent ~= "SPELL_INTERRUPT" then
		return
	end

	local destName = select(7, ...)
	local spellId = select(9, ...)

	for _, frame in pairs(self.frames) do
		local frameUnitName = UnitName(frame.point)

		local _, _, _, _, _, _, _, notInterruptibleCasting, _ = UnitCastingInfo(frame.point)
		local _, _, _, _, _, _, notInterruptibleChanneling, _ = UnitChannelInfo(frame.point)

		if frameUnitName == destName and not (notInterruptibleCasting or notInterruptibleChanneling) then

		end
	end
end