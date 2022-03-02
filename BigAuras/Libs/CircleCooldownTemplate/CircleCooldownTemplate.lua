--######################################################################
--######                CircleCooldownTemplate                   #######
------------------------------------------------------------------------
--######################################################################
--######       https://wow.gamepedia.com/UIOBJECT_Cooldown       #######
------------------------------------------------------------------------
--######################################################################
------------------------------------------------------------------------
--######       My Discord: https://discord.gg/Fm9kgfk            #######
------------------------------------------------------------------------
--######################################################################
--[[------------------------ ADD API -----------------------------------

self:UseColorText([true/false]) -- use formatted color or white
self:SetText(text) -- everything is clear here
self:SetShownText(true/false)

########################################################################]]
local GetTime = GetTime;

local pixels = 1024;
local magic = 1/pixels/2;
local step = pixels/20;

local AtlasInfo = {};
for i = 0, 399 do
    local row = i%20 + 1;
    local column = math.floor(i / 20 ) + 1;

    local top = (step*column - step)/pixels + magic;
    local left = (step*row - step)/pixels + magic;
    local bottom = step*column/pixels - magic;
    local right = step*row/pixels - magic;

    AtlasInfo[i] = {left, right, top, bottom};
end

local function SetFrameVisible(frame, visible)
	if visible then
		frame:Show()
	else
		frame:Hide()
	end
end

function CircleCooldownControlFrame_OnLoad(controlFrame)
	local self = controlFrame:GetParent();
	Mixin(self, CircleCooldownMixin);
	self:SetDrawEdge(self:GetAttribute("drawEdge"));
	self:SetDrawBling(self:GetAttribute("drawBling"));
	self:SetDrawSwipe(self:GetAttribute("drawSwipe"));
	self.IsReverse = self:GetAttribute("reverse");
end

function CircleCooldownControlFrame_OnUpdate(controlFrame, ...)
	CircleCooldownFrame_OnUpdate(controlFrame:GetParent(), ...);
end

function CircleCooldownFrame_SetCooldown(self, start, duration, modRate)
	self.start = start;
    self.duration = duration;
    self.timeRemaining = (start + duration) - GetTime();
    self.fadeTime = 1.2;
    self.Pause = false;
    self:Show();

    if self.Bling.texture.Anim:IsPlaying() then
        self.Bling.texture.Anim:Stop();

        self.Cooldown:SetAlpha(1);
        self.TimerText:SetAlpha(1);
        self.Edge:SetAlpha(1);
    end
end

function Mixin(object, ...)
	for i = 1, select("#", ...) do
		local mixin = select(i, ...);
		for k, v in pairs(mixin) do
			object[k] = v;
		end
	end
	return object;
end

function CreateFromMixins(...)
	return Mixin({}, ...);
end

local function WrapTextInColorCode(text, colorHexString)
	return ("|cff%s%s|r"):format(colorHexString, text);
end

CircleCooldownMixin = {};
CircleCooldownMixin.IsReverse = false;
CircleCooldownMixin.textFormatted = true;
CircleCooldownMixin.IsShownText = false;

function CircleCooldownMixin:SetAtlas(atlasName)
    local atlas = AtlasInfo[atlasName];
    local left, right, top, bottom;

    if atlas then
        if self:GetReverse() then
            left, right, top, bottom = unpack(atlas)
            self.Cooldown.texture:SetTexCoord(right, left, bottom, top);
        else
            left, right, top, bottom = unpack(AtlasInfo[399 - atlasName])
            self.Cooldown.texture:SetTexCoord(left, right, bottom, top);
        end
    end
end

function CircleCooldownMixin:GetReverse()
    return self.IsReverse;
end 

function CircleCooldownMixin:SetReverse(boolean)
    self.IsReverse = boolean;
end

function CircleCooldownMixin:Clear()
    self.start = nil;
    self.duration = nil;
    self.endTime = nil;
    self.timeRemaining = nil;
    self.Pause = false;
    self.rotation = nil;

    self:Hide();
end

function CircleCooldownMixin:IsPaused()
    return self.Pause;
end

function CircleCooldownMixin:Pause()
    self.Pause = true;
end

function CircleCooldownMixin:Resume()
    self.Pause = false;
end

function CircleCooldownMixin:SetCooldown(start, duration, modRate) -- modRate? LoL
	CircleCooldownFrame_SetCooldown(self, start, duration, modRate);
end

function CircleCooldownMixin:GetCooldown()
    return self.start, self.duration, not self:IsPaused();
end

function CircleCooldownMixin:GetRotation()
    return self.rotation;
end

function CircleCooldownMixin:GetCooldownDuration()
    return self.timeRemaining;
end

function CircleCooldownMixin:GetCooldownTimes()
    return self.start, self.duration;
end

function CircleCooldownMixin:UseColorText(value)
    self.textFormatted = value;
end

function CircleCooldownMixin:SetShownText(value)
    self.IsShownText = value;

    if value then
        self.TimerText:Show();
    else
        self.TimerText:Hide();
    end
end

function CircleCooldownMixin:SetText(seconds)
    local hours = math.floor(seconds / 3600);
    local minutes = math.floor(seconds / 60 - (hours * 60));
    local sec = seconds - hours * 3600 - minutes * 60;
    local colorHexString = "ffffff";
    local text;

    if ( seconds  > 3600 ) then
        text = WrapTextInColorCode(string.format("%.fh", hours),  self.textFormatted and "b2b2b2" or colorHexString);
        self:SetFormattedText("%s", text);
    elseif ( seconds > 60 ) then
        text = WrapTextInColorCode(string.format("%.fm", minutes), self.textFormatted and "ffffff" or colorHexString);
        self:SetFormattedText("%s", text);
    elseif ( seconds > 5 ) then
        text = WrapTextInColorCode(string.format("%.f", sec), self.textFormatted and "ffff00" or colorHexString);
        self:SetFormattedText("%s", text);
    elseif (seconds > 2 ) then
        text = WrapTextInColorCode(string.format("%.f", sec), self.textFormatted and "ff0000" or colorHexString);
        self:SetFormattedText("%s", text);
    else
        text = WrapTextInColorCode(string.format("%.1f", sec), self.textFormatted and"ff0000" or colorHexString);
        self:SetFormattedText("%s", text);
    end
end

function CircleCooldownMixin:SetFormattedText(format, text)
    self.TimerText.text:SetFormattedText(format, text);
end

function CircleCooldownMixin:SetDrawEdge(enable)
    SetFrameVisible(self.Edge, enable)
end

function CircleCooldownMixin:SetDrawBling(enable)
    SetFrameVisible(self.Bling, enable)
end

function CircleCooldownMixin:SetBlingTexture(file, r, g, b, a)
    self.Bling.texture:SetTexture(file);
    self.Bling.texture:SetVertexColor(r or 1, g or 1, b or 1, a or 1);
end

function CircleCooldownMixin:SetDrawSwipe(enable)
    SetFrameVisible(self.Cooldown, enable);
end

function CircleCooldownMixin:SetSwipeTexture(file, r, g, b, a)
    self.Cooldown.texture:SetTexture(file);
    self.Cooldown.texture:SetVertexColor(r or 1, g or 1, b or 1, a or 1);
end

function CircleCooldownMixin:SetSwipeColor(r, g, b, a)
    self.Cooldown.texture:SetVertexColor(r or 1, g or 1, b or 1, a or 1);
end

function CircleCooldownMixin:GetDrawEdge()
    return self.Edge:IsVisible();
end

function CircleCooldownMixin:GetDrawBling()
    return self.Bling:IsVisible();
end

function CircleCooldownMixin:GetDrawSwipe()
    return self.Cooldown:IsVisible();
end

function CircleCooldownMixin:GetEdgeScale()
    return self.Edge:GetScale();
end

function CircleCooldownFrame_Set(self, start, duration, enable, forceShowDrawEdge, modRate)
	if enable and enable ~= 0 and start > 0 and duration > 0 then
		self:SetDrawEdge(forceShowDrawEdge);
		self:SetCooldown(start, duration, modRate);
	else
		CircleCooldownFrame_Clear(self);
	end
end

function CircleCooldownFrame_Clear(self)
	self:Hide();
end

function CircleCooldownFrame_SetDisplayAsPercentage(self, percentage)
	local seconds = 100;	-- any number, really
	self:Pause();
	self:SetCooldown(GetTime() - seconds * percentage, seconds);
end

function CircleCooldownFrame_OnUpdate(self, elapsed)
    local start, duration, enable = self:GetCooldown();

    if not enable then -- it is on pause, we do nothing
        return;
    end

    self.timeRemaining = self.timeRemaining - elapsed;
    local percent = math.floor(( self.timeRemaining / duration) * 400);

    if ( percent > 0 ) then

        self.rotation = math.rad(3.6 * percent/4);

        if self:GetDrawSwipe() then
            self:SetAtlas(400 - percent);
        end

        if self.TimerText:IsShown() then
            self:SetText(self.timeRemaining);
        end

        if self:GetDrawEdge() then
            self.Edge.texture:SetRotation(self.rotation);
        end

    elseif ( self:GetDrawBling() and self.fadeTime ) then -- after completion, we turn on the display of the bling animation

        self.fadeTime = self.fadeTime - elapsed;

        if ( self.fadeTime < 0 ) then
            self.fadeTime = nil;
            self:Hide();
        else
            self.Cooldown:SetAlpha(0);
            self.TimerText:SetAlpha(0);
            self.Edge:SetAlpha(0);

            self.Bling.texture.Anim:Play();
        end
    else
        self:Hide();
    end
end
