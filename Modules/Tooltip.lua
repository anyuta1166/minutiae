MinutiaeTooltip = Minutiae:NewModule("MinutiaeTooltip", "AceConsole-3.0", "AceEvent-3.0")

function MinutiaeTooltip:OnEnable()
    self:RegisterEvent("PLAYER_REGEN_DISABLED")
    self:RegisterEvent("PLAYER_REGEN_ENABLED")
    if not Minutiae.db.global.tooltip then
        self:Disable()
    end
end

function MinutiaeTooltip:OnDisable()
    self:UnregisterEvent("PLAYER_REGEN_DISABLED")
    self:UnregisterEvent("PLAYER_REGEN_ENABLED")
    self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
end

function MinutiaeTooltip:PLAYER_REGEN_DISABLED()
    self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
end

function MinutiaeTooltip:PLAYER_REGEN_ENABLED()
    self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
end

function MinutiaeTooltip:UPDATE_MOUSEOVER_UNIT()
    GameTooltip:Hide()
end
