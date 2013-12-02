MinutiaeLootbop = Minutiae:NewModule("MinutiaeLootbop", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")

function MinutiaeLootbop:OnEnable()
    self:RegisterEvent("LOOT_BIND_CONFIRM")
    if not Minutiae.db.global.lootbop then
        self:Disable()
    end
end

function MinutiaeLootbop:OnDisable()
    self:UnregisterEvent("LOOT_BIND_CONFIRM")
end

function MinutiaeLootbop:LOOT_BIND_CONFIRM(_, id)
--	if GetNumRaidMembers() == 0 and GetNumPartyMembers() == 0 then
		self:ScheduleTimer("mConfirmLootSlot", 0.2, id)
		StaticPopup_Hide("LOOT_BIND")
--	end
end

function MinutiaeLootbop:mConfirmLootSlot(id)
	ConfirmLootSlot(id)
end