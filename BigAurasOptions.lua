local SimpleOptions = LibStub("LibSimpleOptions-1.0")
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local AddonOptionName = 'BigAuras'
local mainMenu

local categories = {}

function BigAuras:initializeDB()
	
	if not BigAurasDB or BigAurasDB.version < self.default.version then
		BigAurasDB = CopyTable(self.default)
	end
	
	self.db = BigAurasDB
end

function BigAuras:initializeSettings()
	self.selectedUI_index = nil

    self:initializePanel()
end

function BigAuras:initializePanel()

	self.frameSettings = {}

	for _, categoryData in pairs(self.categories) do
		tinsert(categories, categoryData.name)
	end

	local baseUI_anchors = {}

	for ui,_ in pairs(self.uiAnchors) do
		tinsert(baseUI_anchors, ui)
	end

	mainMenu = {
		name = AddonOptionName,
		type = 'group',
		args = {
			listBaseUI= {
				name = "Base UI",
				type = 'select',
				values = baseUI_anchors,
				get = function(option)
					if not self.selectedUI_index then
						for key, value in pairs(option.options.args.listBaseUI.values) do
							if value == self.db.uiAnchor then
								self.selectedUI_index = key
								break
							end
						end
					end

					return self.selectedUI_index
				end,
				set = function(option, value)
					self.selectedUI_index = value
					self.db.uiAnchor = option.options.args.listBaseUI.values[value]

					self:CreateFrames()
				end,
				order = 1,
			}
		}
	}

	for key, anchor in ipairs(self.anchors) do
		local point = anchor.name
		AceConfig:RegisterOptionsTable('BigAuras-' .. point, function()
			return BigAuras:AddframeSettings(point)
		end)
		AceConfigDialog:AddToBlizOptions('BigAuras-' .. point, point, AddonOptionName)
	end
end

function BigAuras:AddframeSettings( point )
	if self.frameSettings[point] then return self.frameSettings[point] end

	local selectedCategory = 0;

	self.frameSettings[point] = {
		name = point,
		type = 'group',
		args = {
			Unlock = {
				name = 'Unlock',
				type = 'toggle',
				get = function()

					return self.db.anchorsConfiguration[point].unlock
				end,
				set = function(option, value)
					self.db.anchorsConfiguration[point].unlock = value

					option.options.args.Alpha.hidden = not value
					option.options.args.configuration.hidden = not value
					option.options.args.Size.hidden = not value
					-- force reload frames
					self:CreateFrames()
				end,
				order = 1,
			},
			showSwipe = {
				name = 'Show swipe ?',
				type = 'toggle',
				get = function()
					return self.db.anchorsConfiguration[point].showSwipe
				end,
				set = function(_, value)
					self.db.anchorsConfiguration[point].showSwipe = value

					self:CreateFrames()
				end,
				order = 2,
			},
			Alpha = {
				name = "Alpha",
				type = 'range',
				min = 0,
				max = 1,
				step = 0.1,
				hidden = not self.db.anchorsConfiguration[point].unlock,
				bigStep = 0.1,
				get = function() return self.db.anchorsConfiguration[point].alpha end,
				set = function(_, value)
					self.db.anchorsConfiguration[point].alpha = value
					self:CreateFrames()
				end,
				order = 3,
			},
			Size = {
				name = "Size",
				type = 'input',
				hidden = not self.db.anchorsConfiguration[point].unlock,
				get = function() return tostring(self.db.anchorsConfiguration[point].size) end,
				set = function(_, value)
					self.db.anchorsConfiguration[point].size = tonumber(value)
					self:CreateFrames()
				end,
				order = 3,
			},
			configuration = {
				name = 'Position Configuration',
				type = 'group',
				inline = true,
				hidden = not self.db.anchorsConfiguration[point].unlock,
				order = 4,
				args = {
					OffsetX = {
						name = 'offsetX',
						type = 'input',
						get = function()
							return tostring(self.db.anchorsConfiguration[point].offsetX)
						end,
						set = function(_, value)
							value = tonumber(value)
							self.db.anchorsConfiguration[point].offsetX = value
							self:CreateFrames()
						end,
						order = 1,
					},
					OffsetY = {
						name = 'offsetY',
						type = 'input',
						get = function()
							return tostring(self.db.anchorsConfiguration[point].offsetY)
						end,
						set = function(_, value)
							value = tonumber(value)
							self.db.anchorsConfiguration[point].offsetY = value
							self:CreateFrames()
						end,
						order = 1,
					}
				}
			},
			Categories = {
				name = 'Categories',
				type = 'select',
				values = categories,
				get = function(option)

					return selectedCategory
				end,
				set = function(option, value)
					self:InitializeCategorySpells(point, option, value)

					selectedCategory = value
				end,
				order = 10,
			}
		}
	}

	return self.frameSettings[point]
end

function BigAuras:InitializeCategorySpells(point, option, value)
	local categoryData = self.categories[value]
	local index = 1;
	local selectedCategory = value
	local spellsConfigurationArray = {}

	for spellID, spellPriority in pairs(categoryData.spells) do
		local spellName, _, icon = GetSpellInfo(spellID)
		if spellName and icon then
			label = string.format("|T%s:24|t %s (%s)", icon, spellName, spellID)

			spellsConfigurationArray[spellID] = {
				type = 'group',
				args = {
					toggle = {
						name = label,
						type = 'toggle',
						get = function()
							if not self.db.anchorsConfiguration[point].spells[spellID] then
								self.db.anchorsConfiguration[point].spells[spellID] = {
									categoryPriority = categoryData.priority,
									spellPriority = categoryData.spells[spellID]
								}
							end

							if self.db.anchorsConfiguration[point].spells[spellID]["spellPriority"] ~= 0 then
								return true
							else
								return false
							end
						end,
						order = 1,
						set = function(option,value)
							if value then
								local categoryData = self.categories[selectedCategory]
								self.db.anchorsConfiguration[point].spells[spellID] = {
									categoryPriority = categoryData.priority,
									spellPriority = categoryData.spells[spellID]
								}
							else
								self.db.anchorsConfiguration[point].spells[spellID]["spellPriority"] = 0
							end
						end,
					},
					priority = {
						name = 'Priority',
						type = 'input',
						get = function()
							return tostring(self.db.anchorsConfiguration[point].spells[spellID]["spellPriority"])
						end,
						order = 2,
						set = function(_, value)
							value = tonumber(value)
							if value < 0 then
								value = 0
							end

							self.db.anchorsConfiguration[point].spells[spellID]["spellPriority"] = value
						end
					}
				},
				order = index,
			}
		end
		index = index + 1
	end
					

	option.options.args.spells = {
		name = 'Configuration spells',
		type = 'group',
		inline = true,
		args = spellsConfigurationArray,
		order = 100,
	}
end

-- Main options
AceConfig:RegisterOptionsTable('BigAuras-main', function() return mainMenu end)
AceConfigDialog:AddToBlizOptions('BigAuras-main', AddonOptionName)