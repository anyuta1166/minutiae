MinutiaeBank = Minutiae:NewModule("MinutiaeBank", "AceConsole-3.0", "AceEvent-3.0")
local abacus = LibStub("LibAbacus-3.0")

function MinutiaeBank:OnEnable()
    self:RegisterEvent("BANKFRAME_OPENED")
    if not Minutiae.db.global.bank then
        self:Disable()
    end
end

function MinutiaeBank:OnDisable()
    self:UnregisterEvent("BANKFRAME_OPENED")
end

function MinutiaeBank:BANKFRAME_OPENED()
    ToggleAllBags()
end