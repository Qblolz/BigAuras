local SimpleOptions = LibStub("LibSimpleOptions-1.0")
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local AddonOptionName = 'BigAuras'
local options

function BigAuras:initializeSettings()
	
	self.selectedCategory = nil
	self.selectedCategoryName = nil
	
	if not BigAurasDB or BigAurasDB.version < self.default.version then
		BigAurasDB = CopyTable(self.default)
	end
	
	self.db = BigAurasDB

    self:initializePanel()
end

function BigAuras:initializePanel()

	local categories = {}
	for key, anchorData in pairs(self.db.categories) do
		tinsert(categories, key)
	end

	options = {
		name = AddonOptionName,
		type = 'group',
		args = {
			listCategories = {
				name = "Category",
				type = 'select',
				values = categories,
				get = function() return self.selectedCategory end,
				set = function(option, value)
					self.selectedCategory = value
					self.selectedCategoryName = option.options.args.listCategories.values[value]
					self:getAnchors()
					self:getSpells()
				end,
				order = 1,
			},
			configuration = {
				name = 'Configuration frames',
				type = 'group',
				inline = true,
				args = {
					showSwipe = {
						name = 'Show swipe on frames ?',
						type = 'toggle',
						get = function()
							return self.db.showSwipe
						end,
						set = function(_, value)
							self.db.showSwipe = value
							BigAuras:CreateFrames()
						end,
						order = 1,
					},
					showSelfInCenter = {
						name = 'Show self in center',
						type = 'toggle',
						get = function()
							return self.db.playerInCenter
						end,
						set = function(_, value)
							self.db.playerInCenter = value
							BigAuras:showSelfConfiguration()
							BigAuras:CreateFrames()
						end,
						order = 2,
					}
				},
				order = 2,
			}
		}
	}
	
	if self.db.playerInCenter then BigAuras:showSelfConfiguration() end
	
end

function BigAuras:showSelfConfiguration()
	if self.db.playerInCenter then
		options.args.showSelfConfigurationSize = {
			name = 'size',
			type = 'input',
			get = function()
				return tostring(self.db.size)
			end,
			set = function(_, value)
				value = tonumber(value)
				if value < 0 then
					value = 0
				end
				self.db.size = value
				BigAuras:CreateFrames()
			end,
			order = 4,
		}
		options.args.showSelfConfigurationRange = {
			name = "Alpha",
			type = 'range',
			min = 0,
			max = 1,
			step = 0.1,
			bigStep = 0.1,
			get = function() return self.db.alpha end,
			set = function(_, value)
				self.db.alpha = value
				BigAuras:CreateFrames()
			end,
			order = 5,
		}
		options.args.showSelfConfigurationOffsetX = {
			name = 'offsetX',
			type = 'input',
			get = function()
				return tostring(self.db.offsetX)
			end,
			set = function(_, value)
				value = tonumber(value)
				self.db.offsetX = value
				BigAuras:CreateFrames()
			end,
			order = 6,
		}
		options.args.showSelfConfigurationOffsetY = {
			name = 'offsetY',
			type = 'input',
			get = function()
				return tostring(self.db.offsetY)
			end,
			set = function(_, value)
				value = tonumber(value)
				self.db.offsetY = value
				BigAuras:CreateFrames()
			end,
			order = 7,
		}
	else
		options.args.showSelfConfigurationSize = nil
		options.args.showSelfConfigurationRange = nil
		options.args.showSelfConfigurationOffsetX = nil
		options.args.showSelfConfigurationOffsetY = nil
	end
end

function BigAuras:getAnchors()
	local anchorsGroup = {}
	local categoryData = self.default.categories[self.selectedCategoryName]
	
	for anchor, isEnabled in pairs(categoryData.anchors) do
		anchorsGroup[anchor] = {
			name = anchor,
			type = 'toggle',
			get = function()
				return self.db.categories[self.selectedCategoryName].anchors[anchor]
			end,
			set = function(_, value)
				self.db.categories[self.selectedCategoryName].anchors[anchor] = value
				local _frame = self.frames[anchor]
				_frame:LoadCategories(self.db.categories)
			end
		}
	end
	
	options.args.anchors =
	{
		name = 'Shown anchors',
		type = 'group',
		inline = true,
		args = anchorsGroup,
		order = 20,
	}
end

function BigAuras:getSpells()
	local lineGroup = {}
	local categoryData = self.default.categories[self.selectedCategoryName]
	
	local order = 40
	
	for spellID, spellPriority in pairs(categoryData.spells) do
		local spellName, _, icon = GetSpellInfo(spellID)
		if spellName and icon then
			label = string.format("|T%s:24|t %s (%s)", icon, spellName, spellID)
			
			lineGroup[spellID .. '-toogle'] = {
				name = label,
				type = 'toggle',
				get = function()
					local value = self.db.categories[self.selectedCategoryName].spells[spellID]
					
					if value == nil then value = 0 end
					
					if value > 0 then
						return true
					else
						return false
					end
				end,
				order = order,
				set = function(_, value)
					if value then
						categoryData = self.db.categories[self.selectedCategoryName]
						self.db.categories[self.selectedCategoryName].spells[spellID] = categoryData.priority
					else
						self.db.categories[self.selectedCategoryName].spells[spellID] = 0
					end
					
					BigAuras:CollectAuras()
				end
			}
			
			lineGroup[spellID .. '-input'] = {
				name = 'Spell priority',
				type = 'input',
				order = order + 1,
				get = function()
					return tostring(self.db.categories[self.selectedCategoryName].spells[spellID])
				end,
				set = function(_, value)
					value = tonumber(value)
					if value < 0 then
						value = 0
					end
					self.db.categories[self.selectedCategoryName].spells[spellID] = value
					
					BigAuras:CollectAuras()
				end
			}
			
			order = order + 10
			
		end
	end
	
	options.args.spells =
	{
		name = 'Configuration spells',
		type = 'group',
		inline = true,
		args = lineGroup,
		order = 35,
	}
end

-- Main options
AceConfig:RegisterOptionsTable('BigAuras-main', function() return options end)
AceConfigDialog:AddToBlizOptions('BigAuras-main', AddonOptionName)