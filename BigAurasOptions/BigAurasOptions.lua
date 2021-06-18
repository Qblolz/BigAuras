local addon, ns = ...;
local version = GetAddOnMetadata(addon, "Version");

function BigAurasOption_OnLoad(self)
    self.name = "BIG AURAS";
    self.title:SetText("BIG AURAS");
    self.version:SetText("Версия аддона: "..version)
    self.unit = "allUnits";
    InterfaceOptions_AddCategory(self);
end

function BigAurasSubOption_SetUnit(unit, ...)
    for i=1, select("#", ...) do
        local frame = select(i, ...);
        frame.unit = unit;
        BigAurasSubOption_SetUnit(unit, frame:GetChildren());
    end
end

function BigAurasSubOption_OnLoad(self, unit)
    local tag = format("BIG_AURAS_OPTION_%s", strupper(unit));
    self.titleFrame.text:SetText(_G[tag] or ("Need string: "..tag));

    self.unit = unit;
	self.name = _G[tag] or ("Need string: "..tag);

    self.parent = BigAurasOption.name;

    BigAurasSubOption_SetUnit(unit, self);
    InterfaceOptions_AddCategory(self);
end

function BigAurasSubOption_OnShow(self)
    local option = self.titleFrame.Enabled
    local currentValue = GetBigAurasUnitProfileSetting(BigAurasOption.activeProfile, option.unit, option.optionName, option.valueName);

    BigAurasOptionProfileFrame_SetEnabled(currentValue, self:GetChildren())
end

--------------------------------------------------------------
-----------------UI Option Templates---------------------
--------------------------------------------------------------
function BigAurasOptionProfil_OnLoad(self)
    local parent = BigAurasOption;
    if ( not parent.optionControls ) then
		parent.optionControls = {};
	end

	tinsert(parent.optionControls, self);
end

function BigAurasOptionProfile_UpdateCurrentPanel()
	local panel = BigAurasOption;
	for i=1, #panel.optionControls do
		panel.optionControls[i]:updateFunc();
	end
end
-------------------------------
-------- DropDownMenu ---------
-------------------------------
function BigAurasOptionProfileDropdown_InitializeWidget(self, optionName, options)
	self.optionName = optionName;
	self.options = options;
	local tag = format("BIG_AURAS_OPTION_%s", strupper(optionName));
	self.label:SetText(_G[tag] or "Need string: "..tag);
	self.updateFunc = BigAurasOptionProfileDropdown_Update;
	BigAurasOptionProfil_OnLoad(self);
end

function BigAurasOptionProfileDropdown_Update(self)
	UIDropDownMenu_Initialize(self, BigAurasOptionProfileDropdown_Initialize);
	UIDropDownMenu_SetSelectedValue(self, GetBigAurasUnitProfileMainSetting(BigAurasOption.activeProfile, self.optionName))
end

function BigAurasOptionPrfileDropdown_OnShow(self)
	UIDropDownMenu_SetWidth(self, self.width or 160);
	UIDropDownMenu_Initialize(self, BigAurasOptionProfileDropdown_Initialize);
	BigAurasOptionProfileDropdown_Update(self);
end

function BigAurasOptionProfileDropdown_Initialize(dropDown)
	local info = UIDropDownMenu_CreateInfo();

	local currentValue = GetBigAurasUnitProfileMainSetting(BigAurasOption.activeProfile, dropDown.optionName);
	for i=1, #dropDown.options do
		local id = dropDown.options[i];
		info.text = id;
		info.func = BigAurasOptionProfileDropdownButton_OnClick;
		info.arg1 = dropDown;
		info.value = id;
		info.checked = currentValue == id;
		info.isRadio = true;
		UIDropDownMenu_AddButton(info);
	end
end

function BigAurasOptionProfileDropdownButton_OnClick(button, dropDown)
	UIDropDownMenu_SetSelectedValue(dropDown, button.value);
	if (dropDown.optionName == "copyFrom") then
		CopyBigAurasConfigureFrom(BigAurasOption.activeProfile, button.value, dropDown.unit)
	else
		SetBigAurasUnitProfileMainSetting(BigAurasOption.activeProfile, dropDown.optionName,  button.value);
	end
end
-------------------------------
--------    EditBox   ---------
-------------------------------
function BigAurasOptionProfileEditBox_OnEnterPressed(self, ...)
    self:ClearFocus();
    self.tab = false;
end

function BigAurasOptionSlidereEditBox_OnEnterPressed(self)
    local value = self:GetText()
    local slider = self:GetParent();

    value = value:gsub('%%','');
    value = tonumber(value);

    if ( value ) then
        slider:SetValue(value);
        self:ClearFocus();
    end

end

function BigAurasOptionProfileEditBox_Enabled(self, value)
    if ( value ) then
        self:SetFontObject(GameFontHighlightSmall)
        self:EnableMouse(true)
        self:ClearFocus();
    else
        self:EnableMouse(false)
        self:SetFontObject(GameFontDisableSmall)
        self:ClearFocus();
    end
end

function BigAurasOptionProfileEditBox_OnTabPressed(self, ...)
    self.tab = not self.tab
    if ( self.tab ) then
        self:HighlightText();
    else
        self:HighlightText(0,0)
    end
end

function BigAurasOptionProfileEditBox_OnTextChanged(self, changed)
    if ( changed ) then
        local boxText = self:GetText()
        local buttons = self.buttons;
        local pool = {};

        for _, button in pairs(buttons) do
            button:ClearAllPoints();
            button:Hide();
            local text = button.text:GetText()
            if (strlower(text)):match(strlower(boxText)) then
                tinsert(pool, button)
            end
        end

        table.sort(pool, function(a, b)
            return a:GetID() < b:GetID()
        end)

        for i, frame in pairs(pool) do
            if ( i == 1 ) then
                frame:SetPoint("TOPRIGHT", frame.container, "TOPRIGHT", 0, 0);
                frame:SetPoint("TOPLEFT", frame.container, "TOPLEFT", 0, 0);
                frame:Show();
            else
                frame:SetPoint("TOPRIGHT", pool[i-1], "BOTTOMRIGHT", 0, 0);
                frame:SetPoint("TOPLEFT", pool[i-1], "BOTTOMLEFT", 0, -5 );
                frame:Show();
            end
        end
    end
end
-------------------------------
--------    Slider    ---------
-------------------------------
function BigAurasOptionProfileSlider_InitializeWidget(self, name, optionName, valueName, updateFunc)
    if ( name ) then
        local tag = format("BIG_AURAS_OPTION_%s", strupper(name));
        self.lable:SetText(_G[tag] or ("Need string: "..tag));
    end
    if ( optionName ) then
        self.optionName = optionName;
    end
    if ( valueName ) then
		self.valueName = valueName;
	end
    if ( updateFunc ) then
        self.updateFunc = BigAurasOptionProfileSlider_Update;
        BigAurasOptionProfil_OnLoad(self);
    end
end

function BigAurasOptionProfileSlider_OnValueChanged(self, value, userInput)
    if ( userInput ) then
        local currentValue = self.isRound and math.floor(value+0.5) or value;
        local text = string.format(self.isRound and "%.f" or "%.1f", currentValue);
		
		if self:GetValue() == currentValue then return end
		
        self:SetValue(currentValue);
        if ( self.editBox ) then
            self.editBox:SetText(string.format("%.f", currentValue));
        end
        if ( self.value ) then
            self.value:SetText(text);
        end
        SetBigAurasUnitProfileSetting(BigAurasOption.activeProfile, self.unit, currentValue, self.optionName, self.valueName)
        BigAuras:GetOrCreate(self.unit)
    end
end

function BigAurasOptionProfileSlider_Update(self, optionName)
    local currentValue = GetBigAurasUnitProfileSetting(BigAurasOption.activeProfile, self.unit, optionName or self.optionName, self.valueName) or 1;
    local text = string.format("%.1f", currentValue);
    if ( self.isRound ) then
        text = string.format("%.f", math.floor(currentValue+0.5))
    end
	self:SetValue(currentValue);
    self.value:SetText(text);
end

function BigAurasOptionProfileSlider_SetParent(self)
    local slider = self.slider;
    local spellPRFrame = slider:GetParent();
    slider.button = self;
    slider.optionName = self.spellName;
    if ( not spellPRFrame:IsShown() ) then
        spellPRFrame:Show();
    end
    BigAurasOptionProfileSlider_Update(self.slider, self.spellName);
end
-------------------------------
-------  Check Button ---------
-------------------------------
function BigAurasOptionProfileCheckButton_InitializeWidget(self, name, optionName, valueName, updateFunc)
    if ( name ) then
        local tag = format("BIG_AURAS_OPTION_%s", strupper(name));
	    self.label:SetText(_G[tag] or ("Need string: "..tag));
    end
    if ( optionName ) then
        self.optionName = optionName;
    end
    if ( valueName ) then
        self.valueName = valueName;
    end
    if ( updateFunc ) then
        self.updateFunc = updateFunc or BigAurasOptionProfileCheckButton_Update;
        BigAurasOptionProfil_OnLoad(self);
    end
end

function BigAurasOptionProfileCheckButton_Update(self, optionName)
    local currentValue = GetBigAurasUnitProfileSetting(BigAurasOption.activeProfile, self.unit, optionName or self.optionName, self.valueName);
    local setting = self:GetParent():GetParent();
	self:SetChecked(currentValue == nil or currentValue); -- // ( currentValue == nil ) default is true for spellName, because they are written to the database later
    if ( setting.disableGroup ) then
        BigAurasOptionProfileCheckButton_SetParentDisable(self:GetParent())
    else
        BigAurasOptionProfileCheckButton_SetStatus(self);
    end
end

function BigAurasOptionProfileFrame_SetEnabled(value, ...)
    for i=1, select("#", ...) do
        local frame = select(i, ...);
        if ( frame.Enable and value ) then
            frame:Enable();
        elseif ( frame.Disable and not frame.NotDisable ) then
            frame:Disable();
        end
        BigAurasOptionProfileFrame_SetEnabled(value, frame:GetChildren())
    end
end

function BigAurasOptionProfileFrame_Shown(value, ...)
    for i=1, select("#", ...) do
        local frame = select(i, ...);
        if ( frame and value ) then
            frame:Show();
        elseif ( frame ) then
            frame:Hide();
        end
    end
end

function BigAurasOptionProfileCheckButtonUnlock_OnClick(self, button)
    local parent = self:GetParent();
    local sizeSlider = parent.size;
    local xOffSlider = parent.xOff;
    local yOffSlider = parent.yOff;
    local container = parent.container
    local checked = self:GetChecked() or false;

    if ( checked ) then
        container:ClearAllPoints();
        container:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -20, -260);
        container:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 20, 60);
    else
        container:ClearAllPoints();
        container:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -20, -200);
        container:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 20, 60);
    end
    BigAurasOptionProfileFrame_Shown(checked, sizeSlider, xOffSlider, yOffSlider);
    BigAurasOptionProfileCheckButton_SetStatus(self);
    SetBigAurasUnitProfileSetting(BigAurasOption.activeProfile, self.unit, checked, self.optionName, self.valueName);
end

function BigAurasOptionProfileCheckButton_OnClick(self, button)
    if ( self.isGroup ) then
        local setting = self:GetParent():GetParent();
        setting.disableGroup = not self:GetChecked();
    end
    SetBigAurasUnitProfileSetting(BigAurasOption.activeProfile, self.unit, self:GetChecked() or false, self.optionName, self.valueName)
    BigAurasOptionProfileCheckButton_SetStatus(self);
    BigAuras:GetOrCreate(self.unit)
end

function BigAurasOptionProfileCheckButton_SetParent(self)
    local check = self.check;
    local spellPRFrame = check:GetParent();
    check.button = self;
    check.optionName = self.spellName;
    if ( not spellPRFrame:IsShown() ) then
        spellPRFrame:Show();
    end
    BigAurasOptionProfileCheckButton_Update(self.check, self.spellName);
end

function BigAurasOptionProfileCheckButton_SetStatus(self)
    if ( self:GetChecked() ) then
        BigAurasOptionProfileCheckButton_SetEnable(self);
    else
        BigAurasOptionProfileCheckButton_SetDisable(self);
    end
end

function BigAurasOptionProileCheckButton_SetEnabled(self, currentValue)
    local parent = self:GetParent():GetParent();
    BigAurasOptionProfileFrame_SetEnabled(currentValue, parent:GetChildren());
end

function BigAurasOptionProfileCheckButton_SetEnable(self)
    self.label:SetFontObject(GameFontHighlightLeft);
    local slider = self:GetParent().slider
    if ( not slider ) then
        return;
    end

    slider:Enable()
    if (  slider.isGroup ) then
        local setting = self:GetParent():GetParent()
        local spellPriority = setting.spellPriority
        setting.disableGroup = false;
        BigAurasOptionProfileCheckButton_SetEnableForParent(spellPriority)
    end
end

function BigAurasOptionProfileCheckButton_SetEnableForParent(self)
    self.check:Enable();
    self.slider:Enable();
end

function BigAurasOptionProfileCheckButton_SetDisable(self)
    self.label:SetFontObject(GameFontHighlightLeft);
    local slider = self:GetParent().slider
    if ( not slider ) then
        return;
    end

    slider:Disable();
    if ( slider.isGroup ) then
        local setting = self:GetParent():GetParent()
        local spellPriority = setting.spellPriority
        setting.disableGroup = true;
        BigAurasOptionProfileCheckButton_SetParentDisable(spellPriority)
    end
end

function BigAurasOptionProfileCheckButton_SetParentDisable(self)
    self.check:Disable();
    self.slider:Disable();
end
-------------------------------
--------    Buttons   ---------
-------------------------------
function BigAurasOptionTestButton_OnClick(self)
    self.testMode = not self.testMode;
    if ( self.testMode ) then
        print("|cff00ff00TEST_MODE_ON")
		BigAuras:EnableTestMode(self.unit or "all")
    else
        print("|cffff0000TEST_MODE_OFF")
		BigAuras:DisableTestMode(self.unit or "all")
    end
end

function BigAurasOptionProfileButton_OnClick(self, mouseButton)
    if ( mouseButton == "RightButton" ) then
        if ( self.element.hasChildren ) then
            OptionsListButtonToggle_OnClick(self.toggle);
        end
        return;
    end
    local listFrame = self:GetParent();
 
    BigAurasOptionProfileList_ClearSelection(listFrame, listFrame.buttons);
    BigAurasOptionProfileList_SelectButton(listFrame, self);

    BigAurasOptionProfileSpellButton_Update(self);
end

function BigAurasOptionProfileSpellButton_Update(self)
    BigAurasOptionProfileSlider_SetParent(self);
    BigAurasOptionProfileCheckButton_SetParent(self);
end

function BigAurasOptionProfileList_ClearSelection(listFrame, buttons)
    for _, button in pairs(buttons) do
        button:UnlockHighlight();
    end

    listFrame.selection = nil;
end

function BigAurasOptionProfileList_SelectButton(listFrame, button)
    button:LockHighlight()

    listFrame.selection = button.element;
end

function BigAurasOptionProfile_CreateButtonsPool(self, button)
    self.buttons = self.buttons or {};
    tinsert(self.buttons, button);
end

function BigAurasOptionProfileOptionFrame_OnLoad(self)
    local setting = self.setting;
    local optionFrame = setting.spellPriority;
    local spellsFrame = self.spellsFrame;
    local scrollFrame = spellsFrame.scrollFrame;
    local container = scrollFrame.container;

    local text;
    local name = container:GetName().."Button";
    local tabCategory = ns:GetCategoryByName(self.category);
    local searchBar = spellsFrame.searchBar
    local index = 1;
	
    for spellID, spellData in pairs(tabCategory.spells) do
		if (type(spellData) ~= "table") then
			local spellName, _, icon = GetSpellInfo(spellID)
			if ( spellName and icon ) then
				self.maxButton = index;
				text = string.format("|T%s:24|t %s", icon, spellName);

				local button = CreateFrame("Button", name..index, container, "OptionsListButtonTemplate");
				button.text = _G[button:GetName().."Text"];
				button.text:SetText(text);
				button:SetID(index);
				button.container = container;
				button.slider = optionFrame.slider;
				button.check = optionFrame.check;
				button.spellName = spellID;
				button:SetScript("OnClick", BigAurasOptionProfileButton_OnClick);
				button:SetScript("OnDisable", function(this, ...)
					this.text:SetFontObject("GameFontDisable")
				end);

				if ( index == 1 ) then
					button:SetPoint("TOPRIGHT", container, "TOPRIGHT", 0, 0);
					button:SetPoint("TOPLEFT", container, "TOPLEFT", 0, 0);
				else
					button:SetPoint("TOPRIGHT", _G[name..(index-1)], "BOTTOMRIGHT", 0, 0);
					button:SetPoint("TOPLEFT", _G[name..(index-1)], "BOTTOMLEFT", 0, -5 );
				end

				index = index + 1;
				BigAurasOptionProfile_CreateButtonsPool(container, button);
				BigAurasOptionProfile_CreateButtonsPool(searchBar, button);
			end
		end
    end
    container:SetHeight(20 * ( self.maxButton or 0 ));
end
-------------------------------
--------    PAGE   ---------
-------------------------------
function BigAurasOptionProfileTabFrame_OnClick(self, index)
    for i=1,7 do
        self["page"..i]:Hide();
        if ( i == index ) then
          self["page"..i]:Show();
        end
    end
end

function BigAurasOptionProfileTabPage_InitializeWidget(self, optionName, updateFunc)
    self.optionName = optionName;
    self.updateFunc = updateFunc;
    BigAurasOptionProfil_OnLoad(self);
end

function BigAurasOptionProfileTabPage_OnLoad(self)
    local optionFrame = self.optionFrame;
    local setting = optionFrame.setting;
    local categoryPriority = setting.categoryPriority;
    local slider = categoryPriority.slider;
    local check = categoryPriority.check;
    self.slider = slider;

    BigAurasOptionProfileTabPage_InitializeWidget(slider, optionFrame.category, BigAurasOptionProfileSlider_Update);
    BigAurasOptionProfileTabPage_InitializeWidget(check, optionFrame.category, BigAurasOptionProfileCheckButton_Update);
end
