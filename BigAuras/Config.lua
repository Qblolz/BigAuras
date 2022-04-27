local Config = BigAuras:NewModule("Config")

local SML, config, dialog, registry
local options
local registered = false
local addSpellData = {
    spellID = "",
    category = "",
    parent = "",
}
local SpellIcons = {}

-- General option
local function loadOptions()
    options = {}
    options.type = "group"
    options.name = "BigAuras"
    options.args = {}

    options.args.general = {
        type = "group",
        order = 2,
        name = "General",
        args = {
            anchor = {
                order = 15,
                type = "select",
                name = "Anchor",
                values = BigAuras.ui,
                get = function() return BigAuras.db.profile.anchor end,
                set = function(_, value)
                    BigAuras.db.profile.anchor = value
                    for i, unit in pairs(BigAuras:GetUnits()) do
                        BigAuras:getOrCreate(unit) --force update unit
                    end

                    BigAuras:Print("Need reload UI - type /reload in chat and press enter!")
                end
            }
        },
    }

    local _order = 1
    for _, unit in ipairs(BigAuras:GetUnits()) do
        local UpdateSettings = function(info, val)
            if InCombatLockdown() then
                print(addonName .. ": Must leave combat to do that.")
                return
            end

            BigAuras.db.profile[unit][info[#info]] = val
            BigAuras:getOrCreate(unit) --force update or create frame
        end

        local GetSettings = function(info)
            return BigAuras.db.profile[unit][info[#info]]
        end

        options.args.general.args[unit] = {
            type = "group",
            order = _order,
            name = unit,
            childGroups = "tab",
            args = {
				dragNotice = {
					order = 3,
					type = "description",
					fontSize = "medium",
					name = "Ctrl+Shift+Click to move various elements",
				},
                test = {
                    order = 5,
                    type = "execute",
                    name = "Test",
                    func = function()
                        local _, instanceType = IsInInstance()
                        if InCombatLockdown() or instanceType == "arena" then
                            print(addonName .. ": Must leave combat and arena to do that.")
                        else
                            local frame = BigAuras:getOrCreate(unit)

                            if not frame then return end
                            if not frame:GetParent():IsShown() then return end

                            local texturePath = UnitFactionGroup('player') == "Horde" and "Interface\\Icons\\inv_jewelry_trinketpvp_02" or "Interface\\Icons\\inv_jewelry_trinketpvp_01"

                            if not frame.testMode then
                                if frame.db.unlock then
                                    frame.Icon:SetTexture(texturePath)
                                else
                                    SetPortraitToTexture(frame.Icon, texturePath)
                                end

                                local time = GetTime()
                                local duration = random(45,120)

                                frame:SetTime(time + duration, duration)
                                frame.UnitText:Show()
                                frame.testMode = true
                            else
                                frame.testMode = false
                                frame:Hide()
                                frame.UnitText:Hide()
                            end

                            if frame.db.unlock and frame.testMode then
                                frame:SetMovable(true)
                                BigAuras:SetupDrag(frame, frame)
                            else
                                frame:SetMovable(false)
                            end

                        end
                    end,
                    width = "0.5",
                },
                copyFrom = {
                    order = 8,
                    type = "select",
                    name = "Copy data From",
                    values = BigAuras:GetUnits(),
                    set = function(_, val)
                        local _unit = BigAuras:GetUnits()[val]
                        local fromDB = BigAuras.db.profile[_unit]
                        BigAuras.db.profile[unit] = CopyTable(fromDB)
                    end
                },
                enable = {
                    order = 11,
                    type = "toggle",
                    name = "Enable unit",
                    width = "full",
                    get = GetSettings,
                    set = UpdateSettings,
                },
                unlock = {
                    order = 12,
                    type = "toggle",
                    name = "Unlock frame",
                    get = GetSettings,
                    set = UpdateSettings,
                },
                showSwipe = {
                    order = 13,
                    type = "toggle",
                    name = "Enable swipe",
                    get = GetSettings,
                    set = UpdateSettings,
                },
                break1 = {
                    order = 15,
                    type = "header",
                    name = "",
                },
                alpha = {
                    order = 16,
                    type = "range",
                    name = "Alpha",
                    min = 0.1,
                    max = 1.0,
                    step = 0.1,
                    get = GetSettings,
                    set = UpdateSettings,
                },
                size = {
                    order = 17,
                    type = "range",
                    name = "Size",
                    min = 10,
                    max = 80.0,
                    step = 1,
                    get = GetSettings,
                    set = UpdateSettings,
                },
                break2 = {
                    order = 18,
                    type = "header",
                    name = "",
                },
            },
        }

        for _, categoryName in pairs(BigAurasSpells:GetListCategories()) do
            options.args.general.args[unit].args[categoryName] = {
                name = categoryName,
                type = "group",
                order = 20,
                args = {
                    priority = {
                        order = 1,
                        type = "range",
                        name = "Category Priority",
                        desc = "Set to 0 if you want disable category",
                        min = 0,
                        max = 20.0,
                        step = 1,
                        get = function(_)
                            return tonumber(BigAuras.db.profile[unit].categories[categoryName].priority)
                        end,
                        set = function(_, val)
                            BigAuras.db.profile[unit].categories[categoryName].priority = tonumber(val)
                        end
                    },
                    break1 = {
                        order = 2,
                        type = "header",
                        name = "",
                    },
                }
            }

            for spellID, spellData in pairs(BigAuras.db.profile[unit].spells) do
                if GetSpellInfo(spellID) and not spellData["parent"] and spellData.category == categoryName then
                    local spellName = GetSpellInfo(spellID)
                    options.args.general.args[unit].args[categoryName].args[tostring(spellID)] = {
                        name = spellName,
                        type = "group",
                        icon = function()
                            local icon = SpellIcons[spellID] or select(3,GetSpellInfo(spellID))
                            SpellIcons[spellID] = icon

                            return icon
                        end,
                        args = {
                            priority = {
                                order = 1,
                                type = "range",
                                name = "Spell Priority",
                                min = 0,
                                max = 20.0,
                                step = 1,
                                get = function(_)
                                    return tonumber(BigAuras.db.profile[unit].spells[spellID].priority)
                                end,
                                set = function(_, val)
                                    BigAuras.db.profile[unit].spells[spellID].priority = val
                                end
                            },
                        }
                    }
                end
            end

        end

        _order = _order + 1
    end

    options.args.addSpell = {
        type = "group",
        order = 3,
        name = "Add Spell",
        args = {
            spellID = {
                name = "spellID",
                order = 4,
                type = "input",
                get = function() return addSpellData.spellID end,
                set = function(_, value) addSpellData.spellID = value end
            },
            parent = {
                name = "parent spellID (optional)",
                order = 5,
                type = "input",
                get = function() return addSpellData.parent end,
                set = function(_, value) if tonumber(value) then addSpellData.parent = value end end
            },
            category = {
                order = 15,
                type = "select",
                name = "Category",
                values = BigAurasSpells:GetListCategories(),
                get = function() return addSpellData.category end,
                set = function(_, value) addSpellData.category = value end
            },
            break1 = {
                order = 16,
                type = "header",
                name = "",
            },
            addButton = {
                order = 17,
                type = "execute",
                name = "Add",
                func = function()
                    if      addSpellData.spellID == nil or
                            addSpellData.spellID == "" or
                            addSpellData.category == nil or
                            addSpellData.category == ""
                    then
                        BigAuras:Print("You forgot fill some required field (SpellID / Category)")

                        return
                    end

                    local _, instanceType = IsInInstance()
                    if InCombatLockdown() or instanceType == "arena" then
                        BigAuras:Print("Must leave combat and arena to do that.")

                        return
                    else
                        local categoryName = addSpellData.category
                        local spellID = tonumber(addSpellData.spellID)
                        local parentID

                        if addSpellData.parent ~= "" then
                            parentID = tonumber(addSpellData.parent)
                        end

                        for _, unit in pairs(BigAuras:GetUnits()) do

                            if BigAuras.db.profile[unit].spells[spellID] then
                                BigAuras:Print("Current spell already exist in current category")

                                return
                            end

                            if parentID and not BigAuras.db.profile[unit][categoryName][parentID] then
                                BigAuras.db.profile[unit].spells[parentID] = {category = categoryName,priority = 1}
                            end

                            if parentID and not BigAuras.db.profile[unit][categoryName][spellID] then
                                BigAuras.db.profile[unit].spells[spellID] = {parent = parentID}
                            else
                                BigAuras.db.profile[unit].spells[spellID] = {category = categoryName, priority = 1}
                            end

                            if parentID then spellID = parentID end

                            options.args.general.args[unit].args[categoryName].args[tostring(spellID)] = {
                                name = select(1,GetSpellInfo(spellID)),
                                type = "group",
                                icon = function()
                                    local icon = SpellIcons[spellID] or select(3,GetSpellInfo(spellID))
                                    SpellIcons[spellID] = icon

                                    return icon
                                end,
                                args = {
                                    priority = {
                                        order = 1,
                                        type = "range",
                                        name = "Spell Priority",
                                        min = 0,
                                        max = 20.0,
                                        step = 1,
                                        get = function(_)
                                            return tonumber(BigAuras.db.profile[unit].spells[spellID].priority)
                                        end,
                                        set = function(_, val)
                                            BigAuras.db.profile[unit].spells[spellID].priority = val
                                        end
                                    },
                                }
                            }
                        end

                        BigAuras:Print("Spell was added")
                        registry:NotifyChange("BigAuras")
                    end
                end,
            }
        },
    }
    options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(BigAuras.db)
    options.args.profile.order = 4
end

local function buildConfig()
    if not registered then
        if( not options ) then
            loadOptions()
        end
        config:RegisterOptionsTable("BigAuras", options)
        dialog:SetDefaultSize("BigAuras", 850, 650)
        registered = true
    end
end

function Config:OnInitialize()
    config = LibStub("AceConfig-3.0")
    dialog = LibStub("AceConfigDialog-3.0")
    registry = LibStub("AceConfigRegistry-3.0")

    SML = LibStub:GetLibrary("LibSharedMedia-3.0")

    local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("BigAuras", {
        type = "launcher",
        icon = "Interface\\AddOns\\BigAuras\\logo",
        OnTooltipShow = function(tooltip) tooltip:AddLine("BigAuras") end,
        OnClick = function()
            buildConfig()

            if dialog.OpenFrames["BigAuras"] then
                dialog:Close("BigAuras")
            else
                dialog:Open("BigAuras")
            end
        end,
    })

    BigAuras.icon = LibStub("LibDBIcon-1.0")
    BigAuras.icon:Register("BigAuras", LDB, BigAuras.db.profile.minimap)
end
-- Slash commands
SLASH_BIGAURAS1 = "/bigauras"
SLASH_BIGAURAS2 = "/biga"

SlashCmdList["BIGAURAS"] = function(msg)
    msg = string.lower(msg or "")

    if msg == "ui" then
        buildConfig()
        dialog:Open("BigAuras")
    end
end
