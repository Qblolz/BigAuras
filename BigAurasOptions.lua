local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local screenWidth, screenHeight = math.ceil(GetScreenWidth() / 20) * 20, math.ceil(GetScreenHeight() / 20) * 20

local addonOptionName = "BigAuras"

local supportUnits = {"Player", "Pet", "Target", "Focus", "Party1", "Party2", "Party3", "Party4", "Arena1", "Arena2", "Arena3", "Arena4", "Arena5"}
local supportAddons = {
	["Blizzard"] = "Blizzard",
	["Perl"] = "Perl",
	["XPerl"] = "XPerl",
	["ElvUI"] = "ElvUI",
	["ShadowedUnitFrames"] = "ShadowedUnitFrames"
}

local categories = {}
for _, categoryData in pairs(BigAuras.categories) do
	tinsert(categories, categoryData.name)
end

local anchors = {"none"}
for unit in pairs(BigAuras.anchors) do
	tinsert(anchors, unit)
end

function BigAuras:GetUnitOptions(unit, name)
	local selectedCategory = 0

	local copyFromSelected = 1

	local option = {
		name = name,
		type = "group",
		childGroups = "tab",
		get = function(info) return self.db.anchorsConfiguration[unit][info[#info]] end,
		set = function(info, value)
			self.db.anchorsConfiguration[unit][info[#info]] = value
			BigAuras:CreateAndUpdateFrame(unit)
		end,
		args = {
			enable = {
				order = 1,
				type = "toggle",
				name = "Enable"
			},
			showSwipe = {
				order = 2,
				type = "toggle",
				name = "Show Cooldown Frame"
			},
			unlock = {
				order = 3,
				type = "toggle",
				name = "Detach Frame"
			},
			spacer = {
				order = 4,
				type = "description",
				name = ""
			},
			alpha = {
				order = 5,
				type = "range",
				name = "Frame Alpha",
				min = 0, max = 1, step = 0.1,
				hidden = function() return not self.db.anchorsConfiguration[unit].unlock end
			},
			size = {
				order = 6,
				type = "range",
				name = "Frame Size",
				min = 10, max = 128, step = 1,
				hidden = function() return not self.db.anchorsConfiguration[unit].unlock end
			},
			offsetX = {
				order = 7,
				type = "range",
				name = "X Offset",
				softMin = (-1 * screenWidth), softMax = screenWidth, bigStep = 1,
				hidden = function() return not self.db.anchorsConfiguration[unit].unlock end
			},
			offsetY = {
				order = 8,
				type = "range",
				name = "Y Offset",
				softMin = (-1 * screenHeight), softMax = screenHeight, bigStep = 1,
				hidden = function() return not self.db.anchorsConfiguration[unit].unlock end
			},
			selectCategory = {
				order = 9,
				name = "Select Category",
				type = "select",
				values = categories,
				get = function(info) return selectedCategory end,
				set = function(info, value)
					self:InitializeCategorySpells(unit, info, value)

					selectedCategory = value
				end,
			},
			copyFrom = {
				order = 10,
				type = "select",
				name = "Copy All From...",
				desc = "Copy configuration for anchor from another anchor... be careful !!!11",
				values = anchors,
				get = function(info) return copyFromSelected end,
				set = function(info, value)
					local copyFromPoint = anchors[value]
					copyFromSelected = value
					if value > 1 and copyFromSelected ~= unit then
						self.db.anchorsConfiguration[unit].spells = CopyTable(self.db.anchorsConfiguration[copyFromPoint].spells)
						self.db.anchorsConfiguration[unit].categories = CopyTable(self.db.anchorsConfiguration[copyFromPoint].categories)
					end
				end
			},
			enablePriority = {
				order = 11,
				type = "toggle",
				name = "Enable Priority",
				hidden = function() return selectedCategory == 0 end,
				get = function() return self.db.anchorsConfiguration[unit].categories[selectedCategory].enabled end,
				set = function(_, value)
					self.db.anchorsConfiguration[unit].categories[selectedCategory].enabled = value

					local categoryPrior = self.db.anchorsConfiguration[unit].categories[selectedCategory].priority
					if value == true then
						self:applyCategoryPriorityForSpells(unit, selectedCategory, categoryPrior)
					else
						self:applyCategoryPriorityForSpells(unit, selectedCategory, -categoryPrior)
					end
				end,
			},
			priority = {
				order = 12,
				type = "range",
				name = "Category Priority",
				min = 0, max = 200, step = 1,
				hidden = function (info) return selectedCategory == 0 or self.db.anchorsConfiguration[unit].categories[selectedCategory].enabled == false end,
				get = function() return self.db.anchorsConfiguration[unit].categories[selectedCategory].priority end,
				set = function(_, value)
					self:applyCategoryPriorityForSpells(unit, selectedCategory, value)
					self.db.anchorsConfiguration[unit].categories[selectedCategory].priority = value
				end
			},
		}
	}

	return option
end

function BigAuras:applyCategoryPriorityForSpells(unit, categoryIndex, priority)
	for spellID, spellData in pairs(self.db.anchorsConfiguration[unit].spells) do
		local categoryPriorOld = self.db.anchorsConfiguration[unit].categories[categoryIndex].priority
		if math.abs(spellData["categoryPriority"]) == categoryPriorOld then
			spellData["categoryPriority"] = priority
		end
	end
end

function BigAuras:InitializeCategorySpells(unit, option, value)
	local categoryData = self.categories[value]

	local spellsConfigurationArray = {}

	local index = 1
	local selectedCategory = value

	if categoryData.showSpells == false then
		option.options.args.spells = {}
		return
	end

	for spellID, spellPriority in pairs(categoryData.spells) do
		local spellName, _, icon = GetSpellInfo(spellID)
		if spellName and icon then
			spellsConfigurationArray[spellID] = {
				order = index,
				type = "group",
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = string.format("|T%s:24|t %s (%s)", icon, spellName, spellID),
						get = function()
							if not self.db.anchorsConfiguration[unit].spells[spellID] then
								self.db.anchorsConfiguration[unit].spells[spellID] = {
									categoryPriority = categoryData.priority,
									spellPriority = categoryData.spells[spellID]
								}
							end

							if self.db.anchorsConfiguration[unit].spells[spellID]["spellPriority"] ~= 0 then
								return true
							else
								return false
							end
						end,
						set = function(option,value)
							if value then
								local categoryData = self.categories[selectedCategory]
								self.db.anchorsConfiguration[unit].spells[spellID] = {
									categoryPriority = categoryData.priority,
									spellPriority = categoryData.spells[spellID]
								}
							else
								self.db.anchorsConfiguration[unit].spells[spellID]["spellPriority"] = 0
							end
						end,
					},
					priority = {
						order = 2,
						type = "input",
						name = "Priority",
						get = function()
							return tostring(self.db.anchorsConfiguration[unit].spells[spellID]["spellPriority"])
						end,
						set = function(_, value)
							value = tonumber(value)
							if value < 0 then
								value = 0
							end

							self.db.anchorsConfiguration[unit].spells[spellID]["spellPriority"] = value
						end
					}
				}
			}
		end

		index = index + 1
	end

	option.options.args.spells = {
		order = 100,
		type = "group",
		name = "Configuration spells",
		inline = true,
		args = spellsConfigurationArray
	}
end

function BigAuras:InitMainOptions()
	local option = {
		name = addonOptionName,
		type = "group",
		args = {
			uiAnchor = {
				order = 1,
				type = "select",
				name = "Base UI",
				values = supportAddons,
				get = function(info) return self.db[info[#info]] end,
				set = function(info, value)
					self.db[info[#info]] = value

					for unit in pairs(self.anchors) do
						self:CreateAndUpdateFrame(unit)
					end
				end
			},
			testMode = {
				order = 2,
				name = "Test mode",
				type = "toggle",
				get = function(info) return self.db[info[#info]] end,
				set = function(info, value)
					self.db[info[#info]] = value

					self:TestMode()
				end
			}
		}
	}

	AceConfig:RegisterOptionsTable("BigAuras", option)
	AceConfigDialog:AddToBlizOptions("BigAuras", addonOptionName)
end

function BigAuras:InitUnitsOptions()
	for _, unit in ipairs(supportUnits) do
		AceConfig:RegisterOptionsTable("BigAuras_"..unit, BigAuras:GetUnitOptions(string.lower(unit), unit))
		AceConfigDialog:AddToBlizOptions("BigAuras_"..unit, unit, addonOptionName)
	end
end

function BigAuras:IninOptions()
    self:InitMainOptions()
    self:InitUnitsOptions()
end