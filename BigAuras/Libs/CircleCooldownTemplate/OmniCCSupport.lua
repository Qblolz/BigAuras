if OmniCC == nil or OmniCC.Cooldown == nil then return end

local function AddOmniCC(self, start, duration)
    OmniCC.Cooldown.Start(self, start, duration)
end

hooksecurefunc('CircleCooldownFrame_SetCooldown', AddOmniCC)
