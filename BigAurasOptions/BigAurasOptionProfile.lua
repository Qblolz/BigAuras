local addon, ns = ...;
local version = GetAddOnMetadata(addon, "Version");
local BigAurasOptionProfile = LibStub("AceAddon-3.0"):NewAddon("BigAurasOptionProfile");
local PROFILES;
local DEFAULT_PROFILE = ns:GetDefaultProfile();
local _BIG_AURAS_DEFAULT_SPELLS

function BigAurasOptionProfile:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("BigAurasOptionDB");
	PROFILES = self.db.char;
	BigAurasSubOptionProfile_ValidateProfilesLoaded()
end

function GetBigAurasProfileName(index)
	if ( not PROFILES ) then
		return 1
	end

	return PROFILES[index].name
end

function BigAurasSubOptionProfile_ValidateProfilesLoaded()
	if ( #PROFILES == 0 ) then
		BigAurasSubOptionProfile_ResetToDefaults();
	end
	BigAurasSubOptionProfile_ActivateProfile(PROFILES[1]);
end

function DeleteBigAurasProfile(profile)
	if ( not PROFILES or not profile ) then
		return;
	end
	if ( type(profile) == "number" ) then
		table.remove(PROFILES, profile);
	else
		for index, profileData in ipairs(PROFILES) do
			if ( profileData.name == profile ) then
				table.remove(PROFILES, index);
				break;
			end
		end
	end
end

function CopyBigAurasPofile(profile)
	if ( not PROFILES or not profile ) then
		return;
	end

	for _, profileData in ipairs(PROFILES) do
		if ( profileData.name == profile ) then
			-- COPY
			break;
		end
	end
end

function CreateNewBigAurasProfile(name)
	if ( not PROFILES or not name ) then
		return;
	end

	local profile = CopyTable(DEFAULT_PROFILE);
	profile.name = name;
	table.insert(PROFILES, profile);
end

function GetBigAurasProfile()
	if PROFILES and PROFILES[1] then
		return PROFILES[1]
	end

	return nil
end

function BigAurasSubOptionProfile_ResetToDefaults()
	local profiles = {};
	for i=1, #PROFILES do
		tinsert(profiles, GetBigAurasProfileName(i));
	end
	for i=1, #profiles do
		DeleteBigAurasProfile(profiles[i]);
	end
	CreateNewBigAurasProfile("DEFAULT_PROFILE_NAME");
end

function BigAurasSubOptionProfile_ActivateProfile(profile)
	BigAurasOption.activeProfile = profile.name;
	BigAurasOption.activeProfileData = profile;
	BigAurasOptionProfile_UpdateCurrentPanel();
end

function SetBigAurasUnitProfileSetting(profile, unit, value, optionName, valueName)
	if not ( profile and unit ) then
		return;
	end

	for key, profiles in pairs(PROFILES) do
		if ( profiles.name == profile ) then
			if ( valueName ) then
				profiles[unit][optionName] = profiles[unit][optionName] or {}
				profiles[unit][optionName][valueName] = value;
			else
				profiles[unit][optionName] = value;
			end
		end
	end
end

function GetBigAurasUnitProfileSetting(profile, unit, optionName, valueName)
	if not ( PROFILES and profile and unit ) then
		return;
	end

	for key, profiles in pairs(PROFILES) do
		if ( profiles.name == profile ) then
			if ( type(profiles[unit][optionName])=="table"  ) then
				return profiles[unit][optionName][valueName];
			else
				return profiles[unit][optionName];
			end
		end
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

	local profile = BigAurasOption.activeProfileData

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
				if profile[unit][spellID]["enabled"] == nil or profile[unit][spellID]["enabled"] == true then
					result.spellPriority = profile[unit][spellID]["value"] or spellData.spellPriority
				else
					result.spellPriority = 0
				end
			end

			return result
		end
	end

	return nil
end

function GetBigAurasUnitProfileMainSetting(profile, optionName)
	if not ( PROFILES and profile ) then
		return;
	end

	for key, profiles in pairs(PROFILES) do
		if ( profiles.name == profile ) then
			return profiles[optionName];
		end
	end
end

function SetBigAurasUnitProfileMainSetting(profile, optionName, value)
	if not ( PROFILES and profile ) then
		return;
	end

	for key, profiles in pairs(PROFILES) do
		if ( profiles.name == profile ) then
			profiles[optionName] = value;
		end
	end
end

function CopyBigAurasConfigureFrom(profile, from, to)
	if not ( PROFILES and profile ) then
		return;
	end

	for key, profiles in pairs(PROFILES) do
		if ( profiles.name == profile ) then
			if profiles[to] ~= nil and profiles[from] ~= nil then
				profiles[to] = CopyTable(profiles[from])
			end
		end
	end

	BigAurasOptionProfile_UpdateCurrentPanel()
end