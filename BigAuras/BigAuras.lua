local _G = _G
local ipairs, pairs, select = ipairs, pairs, select
local floor = math.floor
local format = string.format
local tinsert, tremove = table.insert, table.remove

local GetTime = GetTime
local UnitAura = UnitAura
local UIParent = UIParent

BigAuras = CreateFrame("Frame")

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
	["EasuFrames"] = {
		noPortraits = false,
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
	["partypet1"] = {
		["Blizzard"] = "PartyMemberFrame1PetFramePortrait",
		["Perl"] = nil,
		["XPerl"] = nil,
		["ElvUI"] = nil,
		["ShadowedUnitFrames"] = nil
	},
	["partypet2"] = {
		["Blizzard"] = "PartyMemberFrame2PetFramePortrait",
		["Perl"] = nil,
		["XPerl"] = nil,
		["ElvUI"] = nil,
		["ShadowedUnitFrames"] = nil
	},
	["partypet3"] = {
		["Blizzard"] = "PartyMemberFrame3PetFramePortrait",
		["Perl"] = nil,
		["XPerl"] = nil,
		["ElvUI"] = nil,
		["ShadowedUnitFrames"] = nil
	},
	["partypet4"] = {
		["Blizzard"] = "PartyMemberFrame4PetFramePortrait",
		["Perl"] = nil,
		["XPerl"] = nil,
		["ElvUI"] = nil,
		["ShadowedUnitFrames"] = nil
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
	},
	["arenapet1"] = {
		["Blizzard"] = "ArenaEnemyFrame1PetFramePortrait",
		["Perl"] = nil,
		["XPerl"] = nil,
		["ElvUI"] = nil,
		["ShadowedUnitFrames"] = nil
	},
	["arenapet2"] = {
		["Blizzard"] = "ArenaEnemyFrame2PetFramePortrait",
		["Perl"] = nil,
		["XPerl"] = nil,
		["ElvUI"] = nil,
		["ShadowedUnitFrames"] = nil
	},
	["arenapet3"] = {
		["Blizzard"] = "ArenaEnemyFrame3PetFramePortrait",
		["Perl"] = nil,
		["XPerl"] = nil,
		["ElvUI"] = nil,
		["ShadowedUnitFrames"] = nil
	},
	["arenapet4"] = {
		["Blizzard"] = "ArenaEnemyFrame4PetFramePortrait",
		["Perl"] = nil,
		["XPerl"] = nil,
		["ElvUI"] = nil,
		["ShadowedUnitFrames"] = nil
	},
	["arenapet5"] = {
		["Blizzard"] = "ArenaEnemyFrame5PetFramePortrait",
		["Perl"] = nil,
		["XPerl"] = nil,
		["ElvUI"] = nil,
		["ShadowedUnitFrames"] = nil
	}
}

BigAuras.frames = {}

BigAuras:RegisterEvent("UNIT_AURA")
BigAuras:RegisterEvent("PLAYER_TARGET_CHANGED")
BigAuras:RegisterEvent("PLAYER_FOCUS_CHANGED")

BigAuras:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

function BigAuras:UNIT_AURA(unit)
	if not unit then return end
	
	self:GetOrCreate(unit)
	self:UpateUnit(unit)
end

function BigAuras:PLAYER_TARGET_CHANGED()
	self:GetOrCreate("target")
	self:UpateUnit("target")
end
function BigAuras:PLAYER_FOCUS_CHANGED()
	self:GetOrCreate("focus")
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
		self.Text:SetText("");
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

	if expiration > 0 and duration > 0 then
		self.Cooldown:SetFrameLevel(self:GetFrameLevel())
		self.Cooldown:SetCooldown(expiration - duration, duration)
	else
		self.Cooldown:SetCooldownDuration(0)
		self.Cooldown:Hide()
		self.Cooldown:SetFrameLevel(self:GetFrameLevel() - 1)
	end
end

function BigAuras:GetParent(unit)
	if not self.anchors[unit] or not self.anchors[unit][self.db.anchor] then
		return
	end

	local parent, portrait = self.anchors[unit][self.db.anchor]
	if self.uiAnchors[self.db.anchor].noPortraits and parent then
		local getAnchor = GetAnchor[self.db.anchor]
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

function BigAuras:GetOrCreate(unit)
	self.db = GetCurrentProfileData()
	
	local db = self.db and self.db[unit] or nil
	if db ~= nil and db.enable then
		local parent, portrait = self:GetParent(unit)
		
		if string.find(unit, "arenapet") and GetCVar("showArenaEnemyPets") == "0" then
			parent = UIParent
		end
		
		parent = parent or UIParent
		
		if not self.frames[unit] then
			self.frames[unit] = self:CreateFrame(unit, parent)
			self.frames[unit]:SetScript("OnUpdate", nil)
		else
			local oldParent = self.frames[unit]:GetParent()
			if oldParent ~= parent then
				self.frames[unit]:SetParent(parent)
				self.frames[unit]:SetFrameLevel(self:GetFrameLevel() + 1)
			end
		end
		
		local frame = self.frames[unit]
		
		frame.Text:Hide()
		frame.Cooldown:Show()
		frame.SetTime = SetCooldownTime
		
		if not self.db[unit].timertext then
			frame.Text:Show()
			frame.Cooldown:Hide()
			frame.SetTime = SetTime
		end
		
		if db.unlock or parent == UIParent then
			frame:ClearAllPoints()
			frame:SetScale(1)
			frame:SetPoint("CENTER", db.offsetX, db.offsetY)
			frame:SetSize(db.size, db.size)
			frame:SetAlpha(db.alpha)
			frame.Cooldown:SetAllPoints()
		else
			frame:SetAlpha(1)

			if portrait and self.db.anchor == "Blizzard" then
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
		
	elseif unit and self.frames[unit] then
		self.frames[unit]:Hide()
	end
end

local frameFunctions = {
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
	frame.unit = unit

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
	if (self.db ~= nil and self.db[unit] and self.frames[unit]) then
		local frame = self.db[unit].enable and self.frames[unit]
		if not frame then return end
		for _, auraFilter in ipairs(auraFilters) do
			for i = 1, 40 do
				local _, _, icon, _, _, duration, expirationTime, _, _, _, spellID = UnitAura(unit, i, auraFilter)
				if spellID ~= nil then
					local categoryPriority, spellPriority
					local spellData = GetSpellDataBySpellID(unit, spellID)
					if spellData ~= nil then
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
							
							if self.db[unit].unlock or self.db.anchor ~= "Blizzard" then
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
end

function BigAuras:EnableTestMode(unit)
	if unit == "all" then
		for _unit in pairs(self.anchors) do
			self:GetOrCreate(_unit)
			local frame = self.frames[_unit]
			if frame ~= nil then
				frame:SetTime(GetTime() + 120, 120)

				if self.db[_unit].unlock or self.db.anchor ~= "Blizzard" then
					frame.Icon:SetTexture("Interface\\Icons\\inv_jewelry_trinketpvp_01")
				else
					SetPortraitToTexture(frame.Icon, "Interface\\Icons\\inv_jewelry_trinketpvp_01")
				end

				frame.UnitText:Show()
				frame:Show()
				frame.UnitText:SetText(_unit)
			end
		end
	else
		self:GetOrCreate(unit)		
		local frame = self.frames[unit]
		if frame ~= nil then
			frame:SetTime(GetTime() + 120, 120)

			if self.db[unit].unlock or self.db.anchor ~= "Blizzard" then
				frame.Icon:SetTexture("Interface\\Icons\\inv_jewelry_trinketpvp_01")
			else
				SetPortraitToTexture(frame.Icon, "Interface\\Icons\\inv_jewelry_trinketpvp_01")
			end

			frame.UnitText:Show()
			frame:Show()
			frame.UnitText:SetText(unit)
		end
	end
end

function BigAuras:DisableTestMode(unit)
	if unit == "all" then
		for _unit in pairs(self.anchors) do
			self:GetOrCreate(_unit)
			local frame = self.frames[_unit]
			if frame ~= nil then
				frame:Hide()
				frame.UnitText:Hide()
			end
		end
	else
		self:GetOrCreate(unit)
		local frame = self.frames[unit]
		if frame ~= nil then
			frame:Hide()
			frame.UnitText:Hide()
		end
	end
end
