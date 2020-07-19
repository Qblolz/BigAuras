BigAuras = {}

function Mixin(object, ...)
    local mixins = {...}
	
    for _, mixin in pairs(mixins) do
        for k,v in pairs(mixin) do
            object[k] = v
        end
    end

    return object
end

local GetAnchor = {
    ShadowedUnitFrames = function(anchor)
        local frame = _G[anchor]
        if not frame then return end
        if frame.portrait and frame.portrait:IsShown() then
            return frame.portrait, frame
        else
            return frame, frame
        end
    end,
    XPerl = function(anchor)
        local frame = _G[anchor]
        if not frame then return end
        if frame:IsShown() then
            return frame, frame
        else
            frame = frame:GetParent()
            return frame, frame
        end
    end,
	ElvUI = function(anchor)
		local frame = _G[anchor]
		return frame, frame
	end
}

function BigAuras_OnEvent (self, event)
	if event == "VARIABLES_LOADED" then
		self:initializeDB()
		self:CreateFrames()
		self:initializeSettings()
	end
end

function BigAuras:formatTime(s)
	return format("%.1f", s)
end

function BigAuras:OnLoad( self )
	BigAuras = self
	
	self:RegisterEvent("VARIABLES_LOADED")
	self:SetScript("OnEvent", BigAuras_OnEvent)

	self.default = {
        version = 2.0,
		uiAnchor = "Blizzard",
		anchorsConfiguration = {
			player = {
				size = 48,
				offsetX = 0,
				offsetY = 0,
				alpha = 1,
				unlock = false,
				showSwipe = true,
				categories = nil,
				spells = nil,
			},
			pet = {
				size = 48,
				offsetX = 0,
				offsetY = 0,
				alpha = 1,
				unlock = false,
				showSwipe = true,
				categories = nil,
				spells = nil,
			},
			target = {
				size = 48,
				offsetX = 0,
				offsetY = 0,
				alpha = 1,
				unlock = false,
				showSwipe = true,
				categories = nil,
				spells = nil,
			},
			focus = {
				size = 48,
				offsetX = 0,
				offsetY = 0,
				alpha = 1,
				unlock = false,
				showSwipe = true,
				categories = nil,
				spells = nil,
			},
			party1 = {
				size = 48,
				offsetX = 0,
				offsetY = 0,
				alpha = 1,
				unlock = false,
				showSwipe = true,
				categories = nil,
				spells = nil,
			},
			party2 = {
				size = 48,
				offsetX = 0,
				offsetY = 0,
				alpha = 1,
				unlock = false,
				showSwipe = true,
				categories = nil,
				spells = nil,
			},
			party3 = {
				size = 48,
				offsetX = 0,
				offsetY = 0,
				alpha = 1,
				unlock = false,
				showSwipe = true,
				categories = nil,
				spells = nil,
			},
			party4 = {
				size = 48,
				offsetX = 0,
				offsetY = 0,
				alpha = 1,
				unlock = false,
				showSwipe = true,
				categories = nil,
				spells = nil,
			},
			arena1 = {
				size = 48,
				offsetX = 0,
				offsetY = 0,
				alpha = 1,
				unlock = false,
				showSwipe = true,
				categories = nil,
				spells = nil,
			},
			arena2 = {
				size = 48,
				offsetX = 0,
				offsetY = 0,
				alpha = 1,
				unlock = false,
				showSwipe = true,
				categories = nil,
				spells = nil,
			},
			arena3 = {
				size = 48,
				offsetX = 0,
				offsetY = 0,
				alpha = 1,
				unlock = false,
				showSwipe = true,
				categories = nil,
				spells = nil,
			},
			arena4 = {
				size = 48,
				offsetX = 0,
				offsetY = 0,
				alpha = 1,
				unlock = false,
				showSwipe = true,
				categories = nil,
				spells = nil,
			},
			arena5 = {
				size = 48,
				offsetX = 0,
				offsetY = 0,
				alpha = 1,
				unlock = false,
				showSwipe = true,
				categories = nil,
				spells = nil,
			}
		},
    }

	self.categories = {
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

	self.uiAnchors = {
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
		["bUnitFrames"] = {
			noPortraits = true,
			alignLeft = true,
		},
		["ShadowedUnitFrames"] = {
			noPortraits = true,
		},
	}

	self.anchors = {
        {
			name = 'player',
            portraits = {
				["Blizzard"] = "PlayerPortrait",
				["Perl"] = "Perl_Player_Portrait",
				["XPerl"] = "XPerl_PlayerportraitFrameportrait",
				["ElvUI"] = "ElvUF_Player",
				["bUnitFrames"] = "bplayerUnitFrame",
				["ShadowedUnitFrames"] = "SUFUnitplayer"
			},
            enabled = true,
        },
		{
			name = 'pet',
            portraits = {
				["Blizzard"] = "PetPortrait",
				["Perl"] = nil,
				["XPerl"] = "XPerl_Player_PetportraitFrame",
				["ElvUI"] = "ElvUF_Pet",
				["bUnitFrames"] = "bpetUnitFrame",
				["ShadowedUnitFrames"] = "SUFUnitpet"
			},
            enabled = true,
        },
        {
			name = 'target',
            portraits = {
				["Blizzard"] = "TargetFramePortrait",
				["Perl"] = "Perl_Target_Portrait",
				["XPerl"] = "XPerl_TargetportraitFrameportrait",
				["ElvUI"] = "ElvUF_Target",
				["bUnitFrames"] = "btargetUnitFrame",
				["ShadowedUnitFrames"] = "SUFUnittarget"
			},
            enabled = true,
        },
        {
			name = 'focus',
            portraits = {
				["Blizzard"] = "FocusFramePortrait",
				["Perl"] = "Perl_Focus_Portrait",
				["XPerl"] = "XPerl_FocusportraitFrameportrait",
				["ElvUI"] = "ElvUF_Focus",
				["bUnitFrames"] = "bfocusUnitFrame",
				["ShadowedUnitFrames"] = "SUFUnitfocus"
			},
            enabled = true,
        },
		{
			name = 'party1',
            portraits = {
				["Blizzard"] = "PartyMemberFrame1Portrait",
				["Perl"] = "Perl_Party_MemberFrame1_Portrait",
				["XPerl"] = "XPerl_party1portraitFrameportrait",
				["ElvUI"] = "ElvUF_PartyGroup1UnitButton1",
				["bUnitFrames"] = nil,
				["ShadowedUnitFrames"] = "SUFHeaderpartyUnitButton2"
			},
            enabled = true,
        },
		{
			name = 'party2',
            portraits = {
				["Blizzard"] = "PartyMemberFrame2Portrait",
				["Perl"] = "Perl_Party_MemberFrame2_Portrait",
				["XPerl"] = "XPerl_party2portraitFrameportrait",
				["ElvUI"] = "ElvUF_PartyGroup1UnitButton2",
				["bUnitFrames"] = nil,
				["ShadowedUnitFrames"] = "SUFHeaderpartyUnitButton2"
			},
            enabled = true,
        },
		{
			name = 'party3',
            portraits = {
				["Blizzard"] = "PartyMemberFrame3Portrait",
				["Perl"] = "Perl_Party_MemberFrame3_Portrait",
				["XPerl"] = "XPerl_party3portraitFrameportrait",
				["ElvUI"] = "ElvUF_PartyGroup1UnitButton3",
				["bUnitFrames"] = nil,
				["ShadowedUnitFrames"] = "SUFHeaderpartyUnitButton3"
			},
            enabled = true,
        },
		{
			name = 'party4',
            portraits = {
				["Blizzard"] = "PartyMemberFrame4Portrait",
				["Perl"] = "Perl_Party_MemberFrame4_Portrait",
				["XPerl"] = "XPerl_party4portraitFrameportrait",
				["ElvUI"] = "ElvUF_PartyGroup1UnitButton4",
				["bUnitFrames"] = nil,
				["ShadowedUnitFrames"] = "SUFHeaderpartyUnitButton4"
			},
            enabled = true,
        },
        {
			name = 'arena1',
            portraits = {
				["Blizzard"] = "ArenaEnemyFrame1ClassPortrait",
				["bUnitFrames"] = "barena1UnitFrame",
				["Perl"] = nil,
				["XPerl"] = nil,
				["ElvUI"] = nil,
				["ShadowedUnitFrames"] = nil,
			},
            enabled = true,
        },
        {
			name = 'arena2',
			portraits = {
				["Blizzard"] = "ArenaEnemyFrame2ClassPortrait",
				["bUnitFrames"] = "barena2UnitFrame",
				["Perl"] = nil,
				["XPerl"] = nil,
				["ElvUI"] = nil,
				["ShadowedUnitFrames"] = nil,
			},
            enabled = true,
        },
        {
			name = 'arena3',
			portraits = {
				["Blizzard"] = "ArenaEnemyFrame3ClassPortrait",
				["bUnitFrames"] = "barena3UnitFrame",
				["Perl"] = nil,
				["XPerl"] = nil,
				["ElvUI"] = nil,
				["ShadowedUnitFrames"] = nil,
			},
            enabled = true,
        },
        {
			name = 'arena4',
			portraits = {
				["Blizzard"] = "ArenaEnemyFrame4ClassPortrait",
				["bUnitFrames"] = "barena4UnitFrame",
				["Perl"] = nil,
				["XPerl"] = nil,
				["ElvUI"] = nil,
				["ShadowedUnitFrames"] = nil,
			},
            enabled = true,
        },
        {
			name = 'arena5',
			portraits = {
				["Blizzard"] = "ArenaEnemyFrame5ClassPortrait",
				["bUnitFrames"] = "barena5UnitFrame",
				["Perl"] = nil,
				["XPerl"] = nil,
				["ElvUI"] = nil,
				["ShadowedUnitFrames"] = nil,
			},
            enabled = true,
        }
    }
	self.frames = {}
end

function BigAuras:CreateFrames()
	for _, anchor in pairs(self.anchors) do
		local point = anchor.name
		local parent = nil
		local portraitFrame = anchor.portraits[self.db.uiAnchor]
		local uiData = self.uiAnchors[self.db.uiAnchor]

		-- try find protrait in childs
		if uiData and uiData.noPortraits and portraitFrame then
			local func = GetAnchor[self.db.uiAnchor]
			if func then
				portraitFrame, parent = func(portraitFrame)
			else
				portraitFrame = _G[portraitFrame]
			end
		else
			portraitFrame = _G[portraitFrame]
		end

		if anchor.enabled then
			if self.frames[point] then
				local oldFrame = self.frames[point]
				oldFrame:Hide()
				oldFrame = nil
			end

			if self.db.anchorsConfiguration[point].unlock or not portraitFrame then
				self.frames[point] = CreateFrame("Frame", "aura-" .. point, UIParent, "AuraFrameTemplate")
			elseif portraitFrame then
				self.frames[point] = CreateFrame("Frame", "aura-" .. point, portraitFrame:GetParent(), "AuraFrameTemplate")
			end

			if self.frames[point] then

				local _frame = self.frames[point]
				
				local font, size = _frame.Text:GetFont()
				_frame.Text:SetFont(font, size, "OUTLINE")
				
				_frame.showingSpellID = nil
				_frame.showingSpellPriority = nil
				_frame.showingCategoryPriority = nil
				_frame.showingSpellDuration = nil
				_frame.showingSpellExpirationTime = nil

				_frame.configuration = self.db.anchorsConfiguration[point]
				_frame.auraTrackerStorage = {}
				_frame.anchor = anchor
				_frame.point = point

				function _frame:SetAllFromConfiguration()
					self:ClearAllPoints()
					self:SetPoint(
						"TOPLEFT",
						UIParent,
						"TOPLEFT",
						self.configuration.offsetX,
						self.configuration.offsetY
					)
					self:SetWidth(self.configuration.size)
					self:SetHeight(self.configuration.size)
					self:SetAlpha(self.configuration.alpha)
				end

				if _frame.configuration.unlock then
					_frame:ClearAllPoints()
					_frame:SetAllFromConfiguration()
					
				elseif portraitFrame then

					if parent then
						_frame:SetParent(parent)
					end

					if self.db.uiAnchor == "Blizzard" then
						portraitFrame:SetDrawLayer("BACKGROUND")
						_frame:SetFrameLevel(portraitFrame:GetParent():GetFrameLevel())

						_frame.Cooldown:SetWidth(portraitFrame:GetWidth())
						_frame.Cooldown:SetHeight(portraitFrame:GetHeight())

						_frame.drawlayer = portraitFrame:GetDrawLayer()
					else
						_frame:SetFrameLevel(90)
						_frame.Cooldown:SetWidth(portraitFrame:GetWidth())
						_frame.Cooldown:SetHeight(portraitFrame:GetHeight())
					end

					_frame:SetWidth(portraitFrame:GetWidth())
					_frame:SetHeight(portraitFrame:GetHeight())
					_frame:SetScale(portraitFrame:GetParent():GetScale())
					if noPortait and uiData.alignLeft then
						_frame:SetPoint("TOPRIGHT", portraitFrame, "TOPLEFT")
					else
						_frame:SetAllPoints(portraitFrame)
					end
				end

				function _frame:ShownSwipe(anchor)

					if anchor then
						if self.configuration.showSwipe then
							if BigAuras.db.uiAnchor == "Blizzard" then
								self.Cooldown:SetFrameLevel(anchor:GetParent():GetFrameLevel())
							else
								self.Cooldown:SetFrameLevel(90)
							end
						else
							self.Cooldown:SetFrameLevel(anchor:GetParent():GetFrameLevel() - 1)
						end
					else
						if self.configuration.showSwipe then
							if BigAuras.db.uiAnchor == "Blizzard" then
								self.Cooldown:SetFrameLevel(self:GetFrameLevel())
							else
								self.Cooldown:SetFrameLevel(90)
							end
						else
							self.Cooldown:SetFrameLevel(self:GetFrameLevel() - 1)
						end
					end
				end

				_frame:ShownSwipe(portraitFrame)

				function _frame:CollectSpells()
					for key, categoryData  in pairs(BigAuras.categories) do
						--if categoryData.showSpells then
							for spellId, spellPriority in pairs(categoryData.spells) do
								self:AddSpell(categoryData,spellId)
							end
						--end
					end
				end

				function _frame:CollectCategories()
					for key, categoryData  in pairs(BigAuras.categories) do
						self:AddCategory(categoryData.name, categoryData.priority, true, nil)
					end
				end

				function _frame:AddCategory( name, priority, enabled, key )

					local _category = {
						name = name,
						priority = priority,
						enabled = enabled,
					}

					if key then
						self.configuration[key] = _category
					else
						tinsert(self.configuration.categories, _category)
					end
				end

				function _frame:AddSpell( categoryData, spellId )
					if categoryData then
						local spellPriority = categoryData.spells[spellId]

						self.configuration.spells[spellId] = {
							categoryPriority = categoryData.priority,
							spellPriority = spellPriority
						}
					end
				end

				function _frame:RemoveSpell( spellId )
					table.remove(self.configuration.spells, spellId)
				end

				if _frame.configuration.spells == nil then
					_frame.configuration.spells = {}
					_frame:CollectSpells()
				end

				if _frame.configuration.categories == nil then
					_frame.configuration.categories = {}
					_frame:CollectCategories()
				end

				function _frame:clearShowingIndicators()
					self.showingSpellID = nil
					self.showingSpellPriority = nil
					self.showingCategoryPriority = nil
					self.showingSpellDuration = nil
					self.showingSpellExpirationTime = nil
				end

				function _frame:RemoveAura()
					if self.Icon:IsShown() then
						self.Cooldown:Hide()
						self.Icon:Hide()
						self.Text:Hide()
					end
				end

				function _frame:AddAura ( spellID, icon, duration, expirationTime )
					if not self.Icon:IsShown() then
						self.Icon:Show()
					end

					if self.configuration.unlock or BigAuras.db.uiAnchor ~= "Blizzard" then
						self.Icon:SetTexture(icon)
					else
						SetPortraitToTexture(self.Icon, icon)
					end
					
					if self.configuration.showSwipe then
						self.Text:Hide()
						self.Cooldown:Show()
						CooldownFrame_SetTimer(self.Cooldown, expirationTime - duration, duration, 1 )
						self.Cooldown:SetAllPoints(self.Icon)
						self:SetScript("OnUpdate", nil)
					else
						self.Text:Show()
						self.Cooldown:Hide()
						self.total = 0.01
					end
				end
				
				function _frame:UpdateTimer(self, elapsed)
					self.total = self.total + elapsed
					if self.total >= 0.01 then
						if self.showingSpellExpirationTime - GetTime() > 0 and self:IsVisible() then
							self.Text:SetText(BigAuras:formatTime(self.showingSpellExpirationTime-GetTime()))
							self.total = 0
						else
							self.Text.Hide()
						end
					end
				end

				if self.db.testMode == true then
					local icon = "Interface\\Icons\\inv_jewelry_trinketpvp_01"
					if not _frame.Icon:IsShown() then
						_frame.Icon:Show()
					end
					if _frame.configuration.unlock or self.db.uiAnchor ~= 'Blizzard' then
						_frame.Icon:SetTexture(icon)
					else
						SetPortraitToTexture(_frame.Icon, icon)
					end

					_frame.Cooldown:SetCooldown(GetTime(),120,1)

					_frame:SetMovable(false)
					_frame:RegisterForDrag()
					_frame:EnableMouse(false)
					self.db.anchorsConfiguration[point].dragable = false
				else
					self.db.anchorsConfiguration[point].dragable = false
					_frame:RemoveAura()
				end
			end
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

		if 
			frameUnitName == destName and
			(
				notInterruptibleCasting == false
				or
				notInterruptibleChanneling == false
			)
		then
			


		end
	end
end

local filters = {"HARMFUL", "HELPFUL"}

function BigAuras_OnUpdate( self, elapsed )
    for _, auraFilter in pairs(filters) do
        for auraIndex = 1, 40 do
            local name, _, icon, _, _, duration, expirationTime, _, _, _, spellID, _, _, _, _, _ = UnitAura(self.point, auraIndex, auraFilter)
            if spellID or name then
				local categoryPriority
				local spellPriority

				local spellData =  self.configuration.spells[spellID]
				if spellData then
					categoryPriority = spellData.categoryPriority
					spellPriority = spellData.spellPriority
				end
				
                if spellPriority and spellPriority ~= 0 and categoryPriority and categoryPriority > 0 then
					local hasAura = self.auraTrackerStorage[spellID] and self.auraTrackerStorage[spellID].status

					self.auraTrackerStorage[spellID] = {
						categoryPriority = categoryPriority,
						spellPriority = spellPriority,
						status = false,
						auraFilter = auraFilter,
						expirationTime = expirationTime,
					}

                    if
						(
							not hasAura and not self.showingSpellID
						) or
						(
							hasAura and not self.showingSpellID
						) or
						(
							self.showingSpellID and
							(
								self.showingCategoryPriority < categoryPriority
								or
								(
									self.showingCategoryPriority == categoryPriority and
									self.showingSpellPriority < spellPriority
								)
							)
						) or
						(
							self.showingSpellID and
							self.showingSpellID == spellID and
							self.showingSpellExpirationTime > expirationTime
						) or
						(
							self.showingSpellID and
							self.showingCategoryPriority == categoryPriority and
							self.showingSpellPriority == spellPriority and
							self.showingSpellExpirationTime < expirationTime
						)
					then
						self.showingSpellID = spellID
						self.showingSpellPriority = spellPriority
						self.showingCategoryPriority = categoryPriority
						self.showingSpellDuration = duration
						self.showingSpellExpirationTime = expirationTime
                        self:AddAura( spellID, icon, duration, expirationTime )
                    end
                end
            end
        end
    end

	for spellID, spellData in pairs(self.auraTrackerStorage) do
		if not spellData.status then
			self.auraTrackerStorage[spellID].status = true
		else
			self.auraTrackerStorage[spellID] = nil
			if self.showingSpellID == spellID then
				self:RemoveAura()
				self:clearShowingIndicators()
			end
		end
    end
	
	if not self.configuration.showSwipe and self.showingSpellID then
		self:UpdateTimer(self,elapsed)
	end
end