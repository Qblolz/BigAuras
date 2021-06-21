local addon, ns = ...;
local version = GetAddOnMetadata(addon, "Version");
local BigAurasOptionProfile = LibStub("AceAddon-3.0"):NewAddon("BigAurasOptionProfile");
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local PROFILES;
local DEFAULT_PROFILE = ns:GetDefaultProfile();
local _BIG_AURAS_DEFAULT_SPELLS

function BigAurasOptionProfile:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("BigAurasOptionDB", { profile = DEFAULT_PROFILE });
	self.db.RegisterCallback(self, "OnProfileChanged", "dbUpdated")
	self.db.RegisterCallback(self, "OnProfileCopied", "dbUpdated")
	self.db.RegisterCallback(self, "OnProfileReset", "dbUpdated")
	PROFILES = self.db.profiles

	-- Profile options
	local dbOptions = LibStub('AceDBOptions-3.0'):GetOptionsTable(self.db)
	AceConfig:RegisterOptionsTable('BigAuras-profile', dbOptions)
	AceConfigDialog:AddToBlizOptions('BigAuras-profile', dbOptions.name, "BIG AURAS")

	BigAurasOptionProfile_UpdateCurrentPanel();
end

function BigAurasOptionProfile:dbUpdated()
	BigAurasOptionProfile_UpdateCurrentPanel();
end

function GetProfileName()
	return BigAurasOptionProfile.db:GetCurrentProfile()
end

function GetCurrentProfileData()
	return BigAurasOptionProfile.db.profile
end

function SetBigAurasUnitProfileSetting(unit, value, optionName, valueName)
    if not ( unit ) then
        return;
    end

	local _db = GetCurrentProfileData()

	if not _db then return end

	if ( valueName ) then
		_db[unit][optionName] = _db[unit][optionName] or {}
		_db[unit][optionName][valueName] = value;
	else
		_db[unit][optionName] = value;
	end
end

function GetBigAurasUnitProfileSetting(unit, optionName, valueName)
	if not ( unit ) then
		return;
	end



	local _db = GetCurrentProfileData()
	if not _db then return end


	if ( type(_db[unit][optionName])=="table"  ) then
		return _db[unit][optionName][valueName];
	else
		return _db[unit][optionName];
	end
end

function GetOrCollectSpellIndexData()
	if _BIG_AURAS_DEFAULT_SPELLS ~= nil then
		return _BIG_AURAS_DEFAULT_SPELLS
	end
	
	_BIG_AURAS_DEFAULT_SPELLS = {}
	
	for i, category in pairs(_CATEGORIES) do
		for spellId, spellData in pairs(category.spells) do
			_BIG_AURAS_DEFAULT_SPELLS[spellId] = {}
			if type(spellData) ~= "table" then
				_BIG_AURAS_DEFAULT_SPELLS[spellId].spellPriority = spellData
				_BIG_AURAS_DEFAULT_SPELLS[spellId].categoryPriority = category.slider
				_BIG_AURAS_DEFAULT_SPELLS[spellId].categoryName = category.name
			else
				_BIG_AURAS_DEFAULT_SPELLS[spellId] = CopyTable(spellData)
			end
		end
	end
	
	return _BIG_AURAS_DEFAULT_SPELLS
end

function GetSpellDataBySpellID(unit, targetSpellID)
	if not ( PROFILES and unit and targetSpellID ) then
		return;
	end

	local profile = GetCurrentProfileData()
	
	local _spellData = GetOrCollectSpellIndexData()[targetSpellID]
	
	if _spellData then
		local spellID = targetSpellID
		local spellData = _spellData
	
		if spellData["parent"] then
			spellID = spellData["parent"]
			spellData = GetOrCollectSpellIndexData()[spellData["parent"]] or {}
		end

		if spellData.categoryName ~= nil and spellData.categoryPriority ~= nil and spellData.spellPriority ~= nil then
			local result = {}

			result.spellPriority = spellData.spellPriority
			result.categoryPriority = profile[unit][spellData.categoryName]["value"] or spellData.categoryPriority

			if profile[unit][spellID] ~= nil then
				if profile[unit][spellID]["value"] then
					result.spellPriority = profile[unit][spellID]["value"] or spellData.spellPriority
				end

				if profile[unit][spellID]["enabled"] == false then
					result.spellPriority = 0
				end
			end

			return result
		end
	end
	
	return nil
end

function GetBigAurasUnitProfileMainSetting(optionName)
	if not ( optionName ) then
		return;
	end

	local _db = GetCurrentProfileData()
	if not _db then return end

	return _db[optionName];
end

function SetBigAurasUnitProfileMainSetting(optionName, value)
	local _db = GetCurrentProfileData()
	if not _db then return end

	_db[optionName] = value;
end

function CopyBigAurasConfigureFrom(from, to)
	local _db = GetCurrentProfileData()
	if not _db then return end

	if _db[to] ~= nil and _db[from] ~= nil then
		_db[to] = CopyTable(_db[from])
	end
	
	BigAurasOptionProfile_UpdateCurrentPanel()
end