MinutiaeQuit = Minutiae:NewModule("MinutiaeQuit", "AceConsole-3.0", "AceEvent-3.0")

function MinutiaeQuit:OnEnable()
    self:RegisterEvent("PLAYER_QUITING")
    if not Minutiae.db.global.quit then
        self:Disable()
    end
end

function MinutiaeQuit:OnDisable()
    self:UnregisterEvent("PLAYER_QUITING")
end

function MinutiaeQuit:PLAYER_QUITING()
    ForceQuit()
end
