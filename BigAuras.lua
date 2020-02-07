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


function OnEvent (self, event)
	if event == "VARIABLES_LOADED" then
		self:initializeSettings()
		self:CollectAuras()
		self:CreateFrames()
	end
end

function BigAuras:OnLoad( self )
	BigAuras = self
	
	self:RegisterEvent("VARIABLES_LOADED")
	self:SetScript("OnEvent", OnEvent)

	self.default = {
        version = 1.7,
		playerInCenter = false,
		size = 52,
		alpha = 1,
		offsetX = 0,
		offsetY = 0,
		showSwipe = true,
		categories = {
			cc = {
				name = "CrowdControl",
				priority = 175,
				anchors = {
					["player"] = true,
					["focus"] = true,
					["target"] = true,
					["arena1"] = true,
					["arena2"] = true,
					["arena3"] = true,
					["arena4"] = true,
					["arena5"] = true,
					["party1"] = true,
					["party2"] = true,
					["party3"] = true,
					["party4"] = true,
				},
				spells = {
					[49012] = 175,	-- Wyvern Sting
					[47481] = 175,	-- Gnaw (Ghoul)
					[51209] = 175,	-- Hungering Cold
					[5211] = 175,	-- Bash (also Shaman Spirit Wolf ability)
					[8983] = 175,	-- Bash (also Shaman Spirit Wolf ability)
					[33786] = 175,	-- Cyclone
					[18658] = 175,	-- Hibernate (works against Druids in most forms and Shamans using Ghost Wolf)
					[49802] = 175,	-- Maim
					[49803] = 175,	-- Pounce
					[14309] = 175,	-- Freezing Trap Effect
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
					[25046] = 175,	-- Arcane Torrent
				}
			},
			buffs_defensive = {
				name = "Buffs defensive",
				priority = 50,
				anchors = {
					["player"] = true,
					["focus"] = true,
					["target"] = true,
					["arena1"] = true,
					["arena2"] = true,
					["arena3"] = true,
					["arena4"] = true,
					["arena5"] = true,
					["party1"] = true,
					["party2"] = true,
					["party3"] = true,
					["party4"] = true,
				},
				spells = {
					[66] = 50,    -- Invisibility(mage)
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
					[53651] = 50, -- Beacon of Light
					[498] = 50, -- Divine Protection
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
			buffs_offensive = {
				name = "Buffs offensive",
				priority = 40,
				anchors = {
					["player"] = true,
					["focus"] = true,
					["target"] = true,
					["arena1"] = true,
					["arena2"] = true,
					["arena3"] = true,
					["arena4"] = true,
					["arena5"] = true,
					["party1"] = true,
					["party2"] = true,
					["party3"] = true,
					["party4"] = true,
				},
				spells = {
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
			buffs_other = {
				name = "Buffs other",
				priority = 10,
				anchors = {
					["player"] = true,
					["focus"] = true,
					["target"] = true,
					["arena1"] = true,
					["arena2"] = true,
					["arena3"] = true,
					["arena4"] = true,
					["arena5"] = true,
					["party1"] = true,
					["party2"] = true,
					["party3"] = true,
					["party4"] = true,
				},
				spells = {
					[308876]   = 40, -- Necrotic trinket (sirus.su)
				}
			},
			immunities = {
				name = "Immunities",
				priority = 200,
				anchors = {
					["player"] = true,
					["focus"] = true,
					["target"] = true,
					["arena1"] = true,
					["arena2"] = true,
					["arena3"] = true,
					["arena4"] = true,
					["arena5"] = true,
					["party1"] = true,
					["party2"] = true,
					["party3"] = true,
					["party4"] = true,
				},
				spells = {
					[642]   = 200,	-- Divine Shield (Paladin)
					[45438] = 200,	-- Ice Block (Mage)
				}
			},
			immunities_spells = {
				name = "Immunities spells",
				priority = 150,
				anchors = {
					["player"] = true,
					["focus"] = true,
					["target"] = true,
					["arena1"] = true,
					["arena2"] = true,
					["arena3"] = true,
					["arena4"] = true,
					["arena5"] = true,
					["party1"] = true,
					["party2"] = true,
					["party3"] = true,
					["party4"] = true,
				},
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
			roots = {
				name = "Roots",
				priority = 100,
				anchors = {
					["player"] = true,
					["focus"] = true,
					["target"] = true,
					["arena1"] = true,
					["arena2"] = true,
					["arena3"] = true,
					["arena4"] = true,
					["arena5"] = true,
					["party1"] = true,
					["party2"] = true,
					["party3"] = true,
					["party4"] = true,
				},
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
				}
			},
		},
    }
	self.auraData = {}
	self.anchors = {
        player = {
            portrait = "PlayerPortrait",
            enabled = true,
        },
        target = {
            portrait = "TargetFramePortrait",
            enabled = true,
        },
        focus = {
            portrait = "FocusFramePortrait",
            enabled = true,
        },
        arena1 = {
            portrait = "ArenaEnemyFrame1ClassPortrait",
            enabled = true,
        },
        arena2 = {
            portrait = "ArenaEnemyFrame2ClassPortrait",
            enabled = true,
        },
        arena3 = {
            portrait = "ArenaEnemyFrame3ClassPortrait",
            enabled = true,
        },
        arena4 = {
            portrait = "ArenaEnemyFrame4ClassPortrait",
            enabled = true,
        },
        arena5 = {
            portrait = "ArenaEnemyFrame5ClassPortrait",
            enabled = true,
        },
		party1 = {
			portrait = "PartyMemberFrame1Portrait",
			enabled = true,
		},
		party2 = {
			portrait = "PartyMemberFrame2Portrait",
			enabled = true,
		},
		party3 = {
			portrait = "PartyMemberFrame3Portrait",
			enabled = true,
		},
		party4 = {
			portrait = "PartyMemberFrame4Portrait",
			enabled = true,
		}
    }
	self.frames = {}
end

function BigAuras:CollectAuras()
	for categoryName, categoryData  in pairs(self.db.categories) do
		for spell_id, spellPriority in pairs(categoryData.spells) do
			self.auraData[spell_id] = {
				categoryPriority = categoryData.priority,
				spellPriority = spellPriority,
				categoryName = categoryName,
			}
		end
	end

	table.sort(self.auraData, sortCategories)
end

function sortCategories(categoryA,categoryB)
	return categoryA.categoryPriority > categoryB.categoryPriority and categoryA.spellPriority > categoryB.spellPriority
end

function BigAuras:CreateFrames()
	for point, anchor in pairs(self.anchors) do
        local _parentPortraitFrame = _G[anchor.portrait]
        if _parentPortraitFrame and anchor.enabled then
			
			if self.frames[point] then
				local oldFrame = self.frames[point]
				oldFrame:Hide()
			end
			
            self.frames[point] = CreateFrame("Frame", "aura-" .. anchor.portrait, _parentPortraitFrame:GetParent(), "AuraFrameTemplate")
			
			local _frame = self.frames[point]
			
			if self.db.playerInCenter and point == 'player' then
				_frame:ClearAllPoints()
				_frame:SetPoint("CENTER",UIParent, "CENTER", self.db.offsetX, self.db.offsetY)
				_frame:SetWidth(self.db.size)
				_frame:SetHeight(self.db.size)
				_frame:SetAlpha(self.db.alpha)
			else
				_frame:SetFrameLevel(_parentPortraitFrame:GetParent():GetFrameLevel())
				_frame:SetWidth(_parentPortraitFrame:GetWidth())
				_frame:SetHeight(_parentPortraitFrame:GetHeight())
				_frame:SetScale(_parentPortraitFrame:GetParent():GetScale())
				_frame:SetAllPoints(_parentPortraitFrame)
				
				if self.db.showSwipe then
					_frame.Cooldown:SetFrameLevel(_parentPortraitFrame:GetParent():GetFrameLevel())
				else
					-- remove swipe animation
					_frame.Cooldown:SetFrameLevel(_parentPortraitFrame:GetParent():GetFrameLevel() - 1)
				end
				
				_frame.Cooldown:SetWidth(_parentPortraitFrame:GetWidth())
				_frame.Cooldown:SetHeight(_parentPortraitFrame:GetHeight())
				
				_parentPortraitFrame:SetDrawLayer("BACKGROUND")
				_parentPortraitFrame:GetParent():SetFrameLevel(_parentPortraitFrame:GetParent():GetFrameLevel())
			end
			_frame.auraTrackerStorage = {}
            _frame.point = point
			_frame.showingSpellID = nil
			_frame.showingSpellPriority = nil
			_frame.showingCategoryPriority = nil
			_frame.showingSpellDuration = nil
			_frame.showingSpellExpirationTime = nil

			
			function _frame:LoadCategories(categories)
				self.categories = {}
				for categoryName, categoryData  in pairs(categories) do
					if categoryData.anchors[self.point] == true then
						tinsert(self.categories,categoryName)
					end
				end
			end
			
			_frame:LoadCategories(self.db.categories)

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
                end
            end

            function _frame:AddAura ( spellID, icon, duration, expirationTime )
                if not self.Icon:IsShown() then
                    self.Icon:Show()
                end
				
				if BigAuras.db.playerInCenter and self.point == 'player' then
					self.Icon:SetTexture(icon)
				else
					SetPortraitToTexture(self.Icon, icon)
				end
                CooldownFrame_SetTimer(self.Cooldown, expirationTime - duration, duration, 1 )
				self.Cooldown:SetAllPoints(self.Icon)
            end
        end
    end
end

function OnUpdate( self, elapsed )
    for _, auraFilter in pairs({"HELPFUL", "HARMFUL"}) do
        for auraIndex = 1, 40 do
            local _, _, icon, _, _, duration, expirationTime, _, _, _, spellID, _, _, _, _, _ = UnitAura(self.point, auraIndex, auraFilter)
            if spellID then
				local categoryPriority
				local spellPriority
				local categoryName

				if BigAuras.auraData[spellID] then
					categoryPriority = BigAuras.auraData[spellID].categoryPriority
					spellPriority = BigAuras.auraData[spellID].spellPriority
					categoryName = BigAuras.auraData[spellID].categoryName
				end
				
                if spellPriority and spellPriority ~= 0 and categoryPriority and categoryName and tContains(self.categories,categoryName) then

					local hasAura = self.auraTrackerStorage[spellID] and self.auraTrackerStorage[spellID].status

					self.auraTrackerStorage[spellID] = {
						categoryPriority = categoryPriority,
						spellPriority = spellPriority,
						status = false,
						auraFilter = auraFilter,
						expirationTime = expirationTime,
					}

                    if
						(not hasAura and not self.showingSpellID) or
						(hasAura and not self.showingSpellID) or
						(
							(
								not hasAura and
								self.showingSpellID and
								self.showingSpellPriority < spellPriority and
								self.showingCategoryPriority <= categoryPriority
							) or
							(
								not hasAura and
								self.showingSpellID and
								self.showingSpellPriority == spellPriority and
								self.showingCategoryPriority == categoryPriority and
								self.showingSpellExpirationTime < expirationTime
							) or
							(
								self.showingSpellID and
								self.showingSpellID == spellID and
								self.showingSpellPriority == spellPriority and
								self.showingCategoryPriority == categoryPriority and
								self.showingSpellExpirationTime <= expirationTime
							)
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
end