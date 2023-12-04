BigAuras = LibStub("AceAddon-3.0"):NewAddon("BigAuras", "AceEvent-3.0")

BigAuras.defaults = {
    profile = {
        anchor = "Blizzard",
		minimap = {hide = false}
    },
}

BigAuras.frames = {}
BigAuras.spellDataCache = {}

BigAuras.ui = {
    ["Blizzard"] = "Blizzard",
    ["Perl"] = "Perl",
    ["XPerl"] = "XPerl",
    ["ElvUI"] = "ElvUI",
    ["ShadowedUnitFrames"] = "ShadowedUnitFrames",
}

BigAuras.portraitSupport = {
    ["Blizzard"] = true,
    ["Perl"] = true,
    ["XPerl"] = true,
    ["ElvUI"] = false,
    ["ShadowedUnitFrames"] =false,
}

BigAuras.anchors2frames = {
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

function BigAuras:GetLayouts()
    local _table = {}

    for index, value in pairs(self.ui) do
        _table[value] = index
    end

    return _table
end

local units = {"player","pet","target","focus","party1","party2","party3","party4","partypet1","partypet2","partypet3","partypet4","arena1","arena2","arena3","arena4","arena5","arenapet1","arenapet2","arenapet3","arenapet4","arenapet5"}
function BigAuras:GetUnits()
    return units
end

function BigAuras:Print(msg)
    DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99BigAuras|r: " .. msg)
end

function BigAuras:roundFloat(value)
    return floor(value * 10 + 0.5 ) / 10
end

local auraFilters = {"HARMFUL", "HELPFUL"}
local function DETECT_UNIT_AURA(self, unit)
    if self.db and not self.db.enable then return end
    if unit ~= self.unit then return end

    local frame = self
    for _, auraFilter in ipairs(auraFilters) do
        for i = 1, 40 do
            local _, _, icon, _, _, duration, expirationTime, _, _, _, spellID = UnitAura(unit, i, auraFilter)
            if spellID ~= nil then
                local categoryPriority, spellPriority
                local spellData = BigAuras:GetSpellDataBySpellID(unit, spellID)
                if spellData ~= nil then
                    categoryPriority = spellData.categoryPriority
                    spellPriority = spellData.spellPriority
                end

                if spellPriority and spellPriority > 0 and categoryPriority and categoryPriority > 0 then
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

                        if frame.db.unlock or BigAuras.db.profile.anchor ~= "Blizzard" then
                            frame.Icon:SetTexture(icon)
                        else
                            if BigAuras:support_s_Arena() and BigAuras:isArenaUnit(unit) then
                                frame.Icon:SetTexture(icon)
                            else
                                SetPortraitToTexture(frame.Icon, icon)
                            end
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
                frame.showingSpellID = nil
                frame.showingSpellPriority = nil
                frame.showingCategoryPriority = nil
                frame.showingSpellDuration = nil
                frame.showingSpellExpirationTime = nil
                frame:UNIT_AURA(unit)
                break
            end
        end
    end

    if not frame.showingCategoryPriority and not frame.testMode then
        frame:Hide()
    end
end

local function PLAYER_TARGET_CHANGED()
    local frame = BigAuras:getOrCreate("target")
    if frame then
        frame:UNIT_AURA("target")
    end
end

local function PLAYER_FOCUS_CHANGED()
    local frame = BigAuras:getOrCreate("focus")
    if frame then
        frame:UNIT_AURA("focus")
    end
end

local function PLAYER_ENTERING_WORLD(self)
    self.Icon:SetTexture(nil)
    self.auraTrackerStorage = {}
    self.showingSpellID = nil
    self.showingSpellPriority = nil
    self.showingCategoryPriority = nil
    self.showingSpellDuration = nil
    self.showingSpellExpirationTime = nil
end

local function SetCooldownTime(self, expiration, duration)
    self:Show()

    if expiration > 0 and duration > 0 then
        self.Cooldown:Show()
        self.Cooldown:SetFrameLevel(self:GetFrameLevel())
        self.Cooldown:SetCooldown(expiration - duration, duration)
    else
        self.Cooldown:SetCooldown(0, 0)
        self.Cooldown:Hide()
        self.Cooldown:SetFrameLevel(self:GetFrameLevel() - 1)
    end
end

local function SetCircuitCooldownTime(self, expiration, duration)
    self:Show()

    if expiration > 0 and duration > 0 then
        self.CircuitCooldown:Show()
        self.CircuitCooldown:SetFrameLevel(self:GetFrameLevel())
        self.CircuitCooldown:SetCooldown(expiration - duration, duration)
    else
        self.CircuitCooldown:SetCooldown(0, 0)
        self.CircuitCooldown:Hide()
        self.CircuitCooldown:SetFrameLevel(self:GetFrameLevel() - 1)
    end
end

function BigAuras:OnInitialize()
    local _def = {
        enable = true,
        alpha = 1,
        showSwipe = true,
        unlock = false,
        offsetX = 0,
        offsetY = 0,
        size = 40,
        categories = BigAurasCategories,
        spells = BigAurasSpells.spells
    }

    for _, unit in pairs(self:GetUnits()) do self.defaults.profile[unit] = CopyTable(_def) end

    self.db = LibStub:GetLibrary("AceDB-3.0"):New("BigAurasDB", self.defaults, true)
	
	if self.db.profile["minimap"] == nil then
		self.db.profile = CopyTable(self.defaults.profile)
	end

    for _, unit in pairs(self:GetUnits()) do
        local frame = self:getOrCreate(unit)
        if frame then
            frame.PLAYER_ENTERING_WORLD = PLAYER_ENTERING_WORLD
            if unit == "target" then
                frame:RegisterEvent("PLAYER_TARGET_CHANGED")
                frame.PLAYER_TARGET_CHANGED = PLAYER_TARGET_CHANGED
            elseif unit == "focus" then
                frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
                frame.PLAYER_FOCUS_CHANGED = PLAYER_FOCUS_CHANGED
            end
        end
    end
end

function BigAuras:getOrCreate(unit)
    if not self.db.profile[unit].enable then
        return
    end

    -- init
    local parent, portrait = self:GetParent(unit)

    if self.db.profile[unit].unlock then
        parent = UIParent
    end

    if parent == nil then
        return
    end

    local frame = self.frames[unit] or CreateFrame("Frame", "BigAura_"..unit, parent, "BigAurasIconTemplate")

    if not self.frames[unit] then
        self.frames[unit] = frame
        frame.auraTrackerStorage = {}
        frame.showingSpellID = nil
        frame.showingSpellPriority = nil
        frame.showingCategoryPriority = nil
        frame.showingSpellDuration = nil
        frame.showingSpellExpirationTime = nil

        frame.db = self.db.profile[unit]
        frame.unit = unit
        frame.testMode = false

        frame:RegisterEvent("UNIT_AURA")
        frame.UNIT_AURA = DETECT_UNIT_AURA
        frame:SetScript("OnEvent", function(_self, _event, ...)
            _self[_event](_self, ...)
        end)

        frame:SetParent(parent)

        frame.UnitText:SetPoint("BOTTOM", frame, "TOP")
        frame.UnitText:SetText(unit)
        frame.UnitText:Hide()

        frame.CircuitCooldown:SetFrameLevel(frame:GetFrameLevel())
        frame.CircuitCooldown:SetAllPoints()
        frame.CircuitCooldown:SetReverse(true)

        frame.Cooldown:SetFrameLevel(frame:GetFrameLevel())
        frame.Cooldown:SetAllPoints()
        frame.Cooldown:SetReverse(true)
    else
        frame = self.frames[unit]
    end

    if frame.db.unlock or parent == UIParent then
        frame:ClearAllPoints()
        frame:SetParent(parent)
        frame:SetScale(1)
        frame:SetPoint("CENTER", frame.db.offsetX, frame.db.offsetY)
        frame:SetSize(frame.db.size, frame.db.size)
        frame:SetAlpha(frame.db.alpha)

        frame.CircuitCooldown:SetAllPoints()
        frame.Cooldown:SetAllPoints()
    else
        frame:SetAlpha(frame.db.alpha)
        if portrait and self.db.profile.anchor == "Blizzard" then
            portrait:SetDrawLayer("BACKGROUND")

            frame:SetFrameLevel(parent:GetFrameLevel())
            frame:SetScale(parent:GetScale())
            frame:SetAllPoints(portrait)

            frame.CircuitCooldown:ClearAllPoints()
            frame.CircuitCooldown:SetPoint("TOPLEFT", portrait, 3, -3)
            frame.CircuitCooldown:SetPoint("BOTTOMRIGHT", portrait, -3, 3)

            frame.Cooldown:ClearAllPoints()
            frame.Cooldown:SetPoint("TOPLEFT", portrait, 3, -3)
            frame.Cooldown:SetPoint("BOTTOMRIGHT", portrait, -3, 3)
        else
            frame:SetFrameLevel(parent:GetFrameLevel() + 10)
            frame:SetScale(parent:GetScale())
            frame:SetAllPoints(parent)

            frame.Cooldown:SetAllPoints(parent)
            frame.CircuitCooldown.SetAllPoints(parent)
        end
    end

    frame.Cooldown:Show()
    frame.CircuitCooldown:Hide()
    frame.SetTime = SetCooldownTime

    if (self.db.profile.anchor == "Blizzard" and not frame.db.unlock) or (frame.db.unlock and not frame.db.showSwipe) then
        frame.Cooldown:Hide()
        frame.CircuitCooldown:Show()
        frame.CircuitCooldown:SetDrawSwipe(frame.db.showSwipe)
        frame.SetTime = SetCircuitCooldownTime
    end

    if not frame.testMode then
        frame.Cooldown:Hide()
        frame.CircuitCooldown:Hide()
        frame:Hide()
    end

    return frame
end

function BigAuras:SetupDrag(frame, frameToClick, frameToMove)
    if not frameToMove then
        frameToMove = frameToClick
    end

    if not frame or (frame and not frame.testMode) then
        return
    end

    frameToClick:HookScript("OnMouseDown", function()
        if IsShiftKeyDown() and IsControlKeyDown() and not frameToMove.isMoving then
            if InCombatLockdown() then
                print(addonName .. ": Must leave combat to do that.")
                return
            end
            frameToMove:StartMoving()
            frameToMove:SetUserPlaced(false)
            frameToMove.isMoving = true
        end
    end)

    frameToClick:HookScript("OnMouseUp", function()
        if InCombatLockdown() then return end

        if frameToMove.isMoving then
            frameToMove:StopMovingOrSizing()
            frameToMove.isMoving = false

            local settings = frame.db

            local parentX, parentY = frameToMove:GetParent():GetCenter()
            local frameX, frameY = frameToMove:GetCenter()
            local scale = frameToMove:GetScale()

            frameX = ((frameX * scale) - parentX) / scale
            frameY = ((frameY * scale) - parentY) / scale

            -- round to 1 decimal place
            frameX = floor(frameX * 10 + 0.5 ) / 10
            frameY = floor(frameY * 10 + 0.5 ) / 10

            settings.offsetX, settings.offsetY = frameX, frameY
        end
    end)
end

function BigAuras:GetParent(unit)
    if not self.anchors2frames[unit] or not self.anchors2frames[unit][self.db.profile.anchor] then
        return
    end

    local parent, portrait = self.anchors2frames[unit][self.db.profile.anchor]
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

    if not self.portraitSupport[self.db.profile.anchor] and parent then
        local getAnchor = GetAnchor[self.db.profile.anchor]
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
            return nil, nil
        end
    end

    return parent, portrait
end

function BigAuras:support_s_Arena()
    if IsAddOnLoaded("sArena") and sArenaIconStyle then
        return sArenaIconStyle()
    end

    return nil
end

function BigAuras:GetSpellDataBySpellID(unit, targetSpellID)
    if not ( unit and targetSpellID ) then
        return;
    end

    local profile = self.db.profile[unit]

    local _spellData
    if profile.spells[targetSpellID] then
        local  _spell = profile.spells[targetSpellID]

        if _spell.parent then
            _spell = profile.spells[_spell.parent]
        end

        _spellData = {
            spellPriority = _spell.priority,
            categoryPriority = profile.categories[_spell.category].priority,
        }

        return _spellData
    end

    return nil
end

function BigAuras:isArenaUnit(unit)
    return unit:find("arena")
end
