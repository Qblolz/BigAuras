if OmniCC == nil then return end
local Timer = OmniCC.Timer;

--show the timer if the cooldown is shown
local function cooldown_OnShow(self)
--	print('onshow', self:GetName())

	local timer = Timer:Get(self)
	if timer then
		timer.visible = true
		timer:UpdateShown()
	end
end

--hide the timer if the cooldown is hidden
local function cooldown_OnHide(self)
--	print('onhide', self:GetName())

	local timer = Timer:Get(self)
	if timer then
		timer.visible = nil
		timer:UpdateShown()
	end
end

--adjust the size of the timer when the cooldown's size changes
local function cooldown_OnSizeChanged(self, ...)
--	print('onsizechanged', self:GetName(), ...)

	local timer = Timer:Get(self)
	if timer then
		timer:Size(...)
	end
end

local function cooldown_Init(self)
--	print('init', self:GetName())

	self:HookScript('OnShow', cooldown_OnShow)
	self:HookScript('OnHide', cooldown_OnHide)
	self:HookScript('OnSizeChanged', cooldown_OnSizeChanged)
	self.omnicc = true

	return self
end

local function AddOmniCC(self, start, duration)
	if OmniCC:IsBlacklisted(self) then
		return
	end

	--create timer if it does not exist yet
	if(not self.omnicc) then
		cooldown_Init(self)
	end

	--hide cooldown model as necessary
	self:SetAlpha(OmniCC:ShowingCooldownModels() and 1 or 0)


	if start > 0 and duration >= OmniCC:GetMinDuration() then
		(Timer:Get(self) or Timer:New(self)):Start(start, duration)
	--stop timer
	else
		local timer = Timer:Get(self)
		if timer then
			timer:Stop()
		end
	end
end

hooksecurefunc('CircleCooldownFrame_SetCooldown', AddOmniCC)