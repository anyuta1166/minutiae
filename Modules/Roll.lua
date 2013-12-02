MinutiaeRoll = Minutiae:NewModule("MinutiaeRoll", "AceConsole-3.0", "AceEvent-3.0")

function MinutiaeRoll:OnEnable()
    self:RegisterEvent("START_LOOT_ROLL")
    if not Minutiae.db.global.roll then
        self:Disable()
    end
end

function MinutiaeRoll:OnDisable()
    self:UnregisterEvent("START_LOOT_ROLL")
end

function MinutiaeRoll:START_LOOT_ROLL(_, id, _)
    if not id then
        return
    end
    local _, _, _, quality, bindOnPickUp, _, canGreed, canDisenchant = GetLootRollItemInfo(id)
    if quality == 2 and canGreed and not bindOnPickUp then
        RollOnLoot(id, (canDisenchant and not Minutiae.db.global.rollNoDE) and 3 or 2)
    end
end
