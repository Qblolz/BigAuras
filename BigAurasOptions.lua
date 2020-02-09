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

	if self.db.testMode then
		self.db.testMode = false
	end
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
			listBaseUI = {
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
			},
			Test = {
				name = 'Test mode',
				type = 'toggle',
				get = function()
					if not self.db.testMode then
						self.db.testMode = false
					end

					return self.db.testMode
				end,
				set = function(option, value)
					self.db.testMode = value
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

	local anchors = {
		"none"
	}
	for key, anchor in ipairs(self.anchors) do
		local point = anchor.name
		tinsert(anchors,point)
	end
	
	local copyFromSelected = 1

	self.frameSettings[point] = {
		name = point,
		type = 'group',
		inline = true,
		args = {
			freePosition = {
				name = 'free position',
				type = 'toggle',
				get = function()

					return self.db.anchorsConfiguration[point].unlock
				end,
				set = function(option, value)
					self.db.anchorsConfiguration[point].unlock = value

					option.options.args.Alpha.hidden = not value
					option.options.args.configuration.hidden = not value
					option.options.args.Size.hidden = not value
					option.options.args.dragable.hidden = not value
					-- force reload frames
					self:CreateFrames()
				end,
				order = 1,
			},
			dragable = {
				name = 'dragable',
				hidden = not self.db.anchorsConfiguration[point].unlock,
				type = 'toggle',
				get = function()
					if not self.db.anchorsConfiguration[point].dragable then
						self.db.anchorsConfiguration[point].dragable = false
					end

					return self.db.anchorsConfiguration[point].dragable
				end,
				set = function(option, value)
					local frame = self.frames[point]
					if value == true then
						local icon = "Interface\\Icons\\inv_jewelry_trinketpvp_01"
						if not frame.Icon:IsShown() then
							frame.Icon:Show()
						end
						frame.Icon:SetTexture(icon)

						frame:SetMovable(true)
						frame:RegisterForDrag("LeftButton")
						frame:EnableMouse(true)

						frame:SetScript("OnDragStart", frame.StartMoving)

						if frame.configuration.offsetX == 0 and frame.configuration.offsetY == 0 then
							frame:ClearAllPoints()
							frame:SetPoint(
								"CENTER",
								UIParent,
								"CENTER",
								0,
								0
							)
						else
							frame:SetAllFromConfiguration()
						end

						frame:SetScript("OnDragStop", function()
							local _, _, _, x, y = frame:GetPoint()
							frame.configuration.offsetX = x
							frame.configuration.offsetY = y
							frame:StopMovingOrSizing()
						end)

					else
						frame:SetMovable(false)
						frame:RegisterForDrag()
						frame:EnableMouse(false)
						if not self.db.testMode then
							frame:RemoveAura()
						end
					end

					self.db.anchorsConfiguration[point].dragable = value
				end,
				order = 2,
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
				order = 3,
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
				order = 4,
			},
			Size = {
				name = "Size",
				type = 'input',
				hidden = not self.db.anchorsConfiguration[point].unlock,
				get = function() return tostring(self.db.anchorsConfiguration[point].size) end,
				set = function(_, value)
					self.db.anchorsConfiguration[point].size = tonumber(value)
					self.frames[point]:SetAllFromConfiguration()
				end,
				order = 5,
			},
			configuration = {
				name = 'Position Configuration',
				type = 'group',
				inline = true,
				hidden = not self.db.anchorsConfiguration[point].unlock,
				order = 6,
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
							self.frames[point]:SetAllFromConfiguration()
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
							self.frames[point]:SetAllFromConfiguration()
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
			},
			copyFrom = {
				name = 'copy ALL from...',
				type = 'select',
				desc = 'Copy configuration for anchor from another anchor... be careful !!!11',
				values = anchors,
				get = function(option)
					return copyFromSelected
				end,
				set = function(option, value)
					local copyFromPoint = anchors[value]
					copyFromSelected = value
					if value > 1 and copyFromSelected ~= point then
						self.db.anchorsConfiguration[point].spells = CopyTable(self.db.anchorsConfiguration[copyFromPoint].spells)
						self.db.anchorsConfiguration[point].categories = CopyTable(self.db.anchorsConfiguration[copyFromPoint].categories)
					end
				end,
				order = 11,
			},
			ShowCategory = {
				name = 'enabled',
				type = 'toggle',
				hidden = function ()
					if selectedCategory == 0 then return true end
					return false
				end,
				get = function()
					return self.db.anchorsConfiguration[point].categories[selectedCategory].enabled
				end,
				set = function(_, value)
					self.db.anchorsConfiguration[point].categories[selectedCategory].enabled = value

					local categoryPrior = self.db.anchorsConfiguration[point].categories[selectedCategory].priority
					if value == true then
						self:applyCategoryPriorityForSpells(point, selectedCategory, categoryPrior)
					else
						self:applyCategoryPriorityForSpells(point, selectedCategory, -categoryPrior)
					end
				end,
				order = 12,
			},
			range = {
				name = "Category Priority",
				type = 'range',
				min = 0,
				max = 200,
				step = 1,
				hidden = function (option)
					if 
						selectedCategory == 0 or
						self.db.anchorsConfiguration[point].categories[selectedCategory].enabled == false
					then
						return true
					end
					return false
				end,
				bigStep = 1,
				get = function() return self.db.anchorsConfiguration[point].categories[selectedCategory].priority end,
				set = function(_, value)
					self:applyCategoryPriorityForSpells(point, selectedCategory, value)
					self.db.anchorsConfiguration[point].categories[selectedCategory].priority = value
				end,
				order = 13,
			},
		}
	}

	return self.frameSettings[point]
end

function BigAuras:applyCategoryPriorityForSpells(point, categoryIndex, priority)
	for spellID, spellData in pairs(self.db.anchorsConfiguration[point].spells) do
		local categoryPriorOld = self.db.anchorsConfiguration[point].categories[categoryIndex].priority
		if math.abs(spellData["categoryPriority"]) == categoryPriorOld then
			spellData["categoryPriority"] = priority
		end
	end
end

function BigAuras:InitializeCategorySpells(point, option, value)
	local categoryData = self.categories[value]

	local spellsConfigurationArray = {}

	local index = 1;
	local selectedCategory = value

	if categoryData.showSpells == false then
		option.options.args.spells = {}
		return 
	end

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